Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVA2CqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVA2CqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 21:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVA2CqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 21:46:13 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:20652 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262842AbVA2Cpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 21:45:47 -0500
Date: Sat, 29 Jan 2005 03:45:42 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Restrict procfs permissions
Message-ID: <20050129024542.GB12270@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patch adds a umask option to the proc filesystem.  It can be used
to restrict the permission of users to view each others process
information.  E.g. on a multi-user shell server one could use a setting
of umask=077 to allow all users to view info about their own processes,
only.  It should prevent "command line snooping" and generally increases
privacy on the server.

Top and ps can cope with such restrictions, they simply are quiet about
files they cannot access.

The umask option affects permissions of the numerical directories in
/proc, only (the process info).  And root can see everything, of course,
even with a umask setting of 0777.  Default umask is 0, i.e. unchanged
permissions.

The patch is inspired by the /proc restriction parts of the GrSecurity
patch.  The main difference is the ability to configure the restrictions
dynamically.  You can change the umask setting by running

   # mount -o remount,umask=007 /proc

Testing has been *very* light so far -- it compiles and boots.  Patch is
against 2.6.11-rc2-bk6.

Comments are very welcome.

Thanks,
Rene


diff -rup linux-2.6.11-rc2-bk6/fs/proc/base.c l/fs/proc/base.c
--- linux-2.6.11-rc2-bk6/fs/proc/base.c	2005-01-28 23:42:44.000000000 +0000
+++ l/fs/proc/base.c	2005-01-28 23:58:38.000000000 +0000
@@ -1222,7 +1222,7 @@ static struct dentry *proc_pident_lookup
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = p->mode;
+	inode->i_mode = p->mode & ~proc_umask;
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
@@ -1537,7 +1537,7 @@ struct dentry *proc_pid_lookup(struct in
 		put_task_struct(task);
 		goto out;
 	}
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = (S_IFDIR|S_IRUGO|S_IXUGO) & ~proc_umask;
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_nlink = 3;
@@ -1592,7 +1592,7 @@ static struct dentry *proc_task_lookup(s
 
 	if (!inode)
 		goto out_drop_task;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
+	inode->i_mode = (S_IFDIR|S_IRUGO|S_IXUGO) & ~proc_umask;
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_nlink = 3;
diff -rup linux-2.6.11-rc2-bk6/fs/proc/inode.c l/fs/proc/inode.c
--- linux-2.6.11-rc2-bk6/fs/proc/inode.c	2005-01-28 23:42:44.000000000 +0000
+++ l/fs/proc/inode.c	2005-01-28 23:56:11.000000000 +0000
@@ -22,6 +22,8 @@
 
 extern void free_proc_entry(struct proc_dir_entry *);
 
+umode_t proc_umask = 0;
+
 static inline struct proc_dir_entry * de_get(struct proc_dir_entry *de)
 {
 	if (de)
@@ -127,9 +129,14 @@ int __init proc_init_inodecache(void)
 	return 0;
 }
 
+static int parse_options(char *, uid_t *, gid_t *);
 static int proc_remount(struct super_block *sb, int *flags, char *data)
 {
+	uid_t dummy_uid;
+	gid_t dummy_gid;
+
 	*flags |= MS_NODIRATIME;
+	parse_options(data, &dummy_uid, &dummy_gid);
 	return 0;
 }
 
@@ -144,12 +151,13 @@ static struct super_operations proc_sops
 };
 
 enum {
-	Opt_uid, Opt_gid, Opt_err
+	Opt_uid, Opt_gid, Opt_umask, Opt_err
 };
 
 static match_table_t tokens = {
 	{Opt_uid, "uid=%u"},
 	{Opt_gid, "gid=%u"},
+	{Opt_umask, "umask=%o"},
 	{Opt_err, NULL}
 };
 
@@ -181,6 +189,11 @@ static int parse_options(char *options,u
 				return 0;
 			*gid = option;
 			break;
+		case Opt_umask:
+			if (match_octal(args, &option))
+				return 0;
+			proc_umask = option;
+			break;
 		default:
 			return 0;
 		}
diff -rup linux-2.6.11-rc2-bk6/fs/proc/internal.h l/fs/proc/internal.h
--- linux-2.6.11-rc2-bk6/fs/proc/internal.h	2005-01-28 23:42:44.000000000 +0000
+++ l/fs/proc/internal.h	2005-01-28 23:58:29.000000000 +0000
@@ -16,6 +16,8 @@ struct vmalloc_info {
 	unsigned long	largest_chunk;
 };
 
+extern umode_t proc_umask;
+
 #ifdef CONFIG_MMU
 #define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
 extern void get_vmalloc_info(struct vmalloc_info *vmi);
