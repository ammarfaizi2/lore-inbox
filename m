Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVBAXtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVBAXtq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVBAXtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:49:45 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:59575 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262147AbVBAXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:46:15 -0500
Date: Wed, 2 Feb 2005 00:46:14 +0100
From: rene.scharfe@lsrfire.ath.cx
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc filesystem (1/3): fix mount options
Message-ID: <20050201234614.GA29125@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while trying to add a umask option to the proc filesystem I stumbled
over a somewhat related problem: the existing mount options uid and
gid were non-functional.  The patch below is an attempt to fix them
and prepares the ground for my evil umask plans. :)

The first half of the reason why the uid and gid options are not
working is that proc has only a single superblock, no matter how many
times it is mounted.  This is achieved with the help of get_single_sb().
Only the first mount calls fill_super(), all following mounts are
like remounts.

The second half is that proc is mounted during boot with kern_mount().
This function passes NULL as mount parameter string to
proc_fill_super().

So the single mount call where we could provide some options provides --
nothing.  I don't know why parse_options() is not called from
proc_remount(), but it looks like this has been done on purpose, to
avoid changing ownership of the root inode while proc is mounted.
Is that observation correct or was it just an accident?

Anyway, the following patch changes proc to not appear like accepting
regular mount options and instead makes it parse kernel parameters.  I
hope this is not too evil.  They provide the semantics which I hope is
correct: changable at boot time and only at boot time.

Patch is against 2.6.11-rc2-bk10 (2.6.10 should be OK, too), compiles,
boots and works for me.

Comments welcome.

Thanks,
Rene


diff -pur linux-2.6.11-rc2-bk10/fs/proc/inode.c ll/fs/proc/inode.c
--- linux-2.6.11-rc2-bk10/fs/proc/inode.c	2005-02-01 04:17:25.000000000 +0100
+++ ll/fs/proc/inode.c	2005-02-01 03:23:51.000000000 +0100
@@ -148,22 +148,24 @@ enum {
 };
 
 static match_table_t tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
+	{Opt_uid, "proc.uid=%u"},
+	{Opt_gid, "proc.gid=%u"},
 	{Opt_err, NULL}
 };
 
+/*
+ * This parse_options function is different.  It parses kernel parameters
+ * instead of filesystem mount options.
+ */ 
 static int parse_options(char *options,uid_t *uid,gid_t *gid)
 {
 	char *p;
 	int option;
 
-	*uid = current->uid;
-	*gid = current->gid;
 	if (!options)
 		return 1;
 
-	while ((p = strsep(&options, ",")) != NULL) {
+	while ((p = strsep(&options, " \t")) != NULL) {
 		substring_t args[MAX_OPT_ARGS];
 		int token;
 		if (!*p)
@@ -173,16 +175,14 @@ static int parse_options(char *options,u
 		switch (token) {
 		case Opt_uid:
 			if (match_int(args, &option))
-				return 0;
+				continue;
 			*uid = option;
 			break;
 		case Opt_gid:
 			if (match_int(args, &option))
-				return 0;
+				continue;
 			*gid = option;
 			break;
-		default:
-			return 0;
 		}
 	}
 	return 1;
@@ -231,6 +231,11 @@ out_fail:
 	goto out;
 }			
 
+/*
+ * Because proc is a single-superblock filesystem, proc_fill_super() is
+ * only called at boot time and never during sys_mount().  That means
+ * filesystem options can only be specified as kernel parameters.
+ */
 int proc_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode * root_inode;
@@ -249,6 +254,8 @@ int proc_fill_super(struct super_block *
 	 * Fixup the root inode's nlink value
 	 */
 	root_inode->i_nlink += nr_processes();
+	root_inode->i_uid = 0;
+	root_inode->i_gid = 0;
 	s->s_root = d_alloc_root(root_inode);
 	if (!s->s_root)
 		goto out_no_root;
diff -pur linux-2.6.11-rc2-bk10/fs/proc/root.c ll/fs/proc/root.c
--- linux-2.6.11-rc2-bk10/fs/proc/root.c	2004-12-24 22:35:24.000000000 +0100
+++ ll/fs/proc/root.c	2005-02-01 02:25:04.000000000 +0100
@@ -7,6 +7,7 @@
  */
 
 #include <asm/uaccess.h>
+#include <asm/setup.h>
 
 #include <linux/errno.h>
 #include <linux/time.h>
@@ -17,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
+#include <linux/string.h>
+#include <linux/mount.h>
 
 struct proc_dir_entry *proc_net, *proc_net_stat, *proc_bus, *proc_root_fs, *proc_root_driver;
 
@@ -39,13 +42,15 @@ static struct file_system_type proc_fs_t
 extern int __init proc_init_inodecache(void);
 void __init proc_root_init(void)
 {
+	char tmp_cmdline[COMMAND_LINE_SIZE];
 	int err = proc_init_inodecache();
 	if (err)
 		return;
 	err = register_filesystem(&proc_fs_type);
 	if (err)
 		return;
-	proc_mnt = kern_mount(&proc_fs_type);
+	strlcpy(tmp_cmdline, saved_command_line, COMMAND_LINE_SIZE);
+	proc_mnt = do_kern_mount("proc", 0, "proc", tmp_cmdline);
 	err = PTR_ERR(proc_mnt);
 	if (IS_ERR(proc_mnt)) {
 		unregister_filesystem(&proc_fs_type);
