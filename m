Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUDIRCB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUDIRCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:02:00 -0400
Received: from A17-250-248-89.apple.com ([17.250.248.89]:14796 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S261396AbUDIRBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:01:51 -0400
Subject: [PATCH] ensure core dump is owned by root, dump core as root on
	seteuid
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Content-Type: multipart/mixed; boundary="=-FMGHZ7A8TdXBcrkIqkPJ"
Message-Id: <1081530068.3153.60.camel@picklock.adams.family>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 09 Apr 2004 19:01:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FMGHZ7A8TdXBcrkIqkPJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While it's more secure to not dump core at all if the program has
switched euid, it's also very unpractical. Since only programs 
started from root, being setuid root or have CAP_SETUID it's far 
more practical to dump as root.root mode 600. This is the bahavior 
of Solaris.

The current implementation does not ensure that an existing core
file is only readable as root, i.e. after dumping the ownership 
and mode is unchanged.

Besides mm->dumpable to avoid recursive core dumps, on setuid files 
the dumpable flag still prevents a core dump while seteuid & co will
result in a core only readable as root.



--=-FMGHZ7A8TdXBcrkIqkPJ
Content-Description: 
Content-Disposition: inline; filename=core-patch
Content-Type: text/x-patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -X dontdiff -Nur linux-2.6.5/fs/exec.c linux-2.6/fs/exec.c
--- linux-2.6.5/fs/exec.c	2004-04-08 22:06:32.000000000 +0200
+++ linux-2.6/fs/exec.c	2004-04-08 23:13:49.000000000 +0200
@@ -1378,6 +1378,10 @@
 		goto fail;
 	}
 	mm->dumpable = 0;
+	if (mm->dump_as_root){
+		current->fsuid = 0;
+		current->fsgid = 0;
+	}
 	init_completion(&mm->core_done);
 	current->signal->group_exit = 1;
 	current->signal->group_exit_code = exit_code;
@@ -1387,9 +1391,14 @@
 		goto fail_unlock;
 
  	format_corename(corename, core_pattern, signr);
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
-	if (IS_ERR(file))
-		goto fail_unlock;
+	file = filp_open(corename, O_CREAT | O_EXCL | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+	if (IS_ERR(file)){
+		if (do_unlink(corename))
+			goto fail_unlock;
+		file = filp_open(corename, O_CREAT | O_EXCL | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+		if (IS_ERR(file))
+			goto fail_unlock;
+	}
 	inode = file->f_dentry->d_inode;
 	if (inode->i_nlink > 1)
 		goto close_fail;	/* multiple links - don't dump */
diff -X dontdiff -Nur linux-2.6.5/fs/namei.c linux-2.6/fs/namei.c
--- linux-2.6.5/fs/namei.c	2004-04-08 22:07:21.000000000 +0200
+++ linux-2.6/fs/namei.c	2004-04-08 23:21:25.000000000 +0200
@@ -1700,18 +1700,13 @@
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
  */
-asmlinkage long sys_unlink(const char __user * pathname)
+int do_unlink(const char *name)
 {
 	int error = 0;
-	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
 	struct inode *inode = NULL;
 
-	name = getname(pathname);
-	if(IS_ERR(name))
-		return PTR_ERR(name);
-
 	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
@@ -1736,8 +1731,6 @@
 exit1:
 	path_release(&nd);
 exit:
-	putname(name);
-
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	return error;
@@ -1746,6 +1739,22 @@
 	error = !dentry->d_inode ? -ENOENT :
 		S_ISDIR(dentry->d_inode->i_mode) ? -EISDIR : -ENOTDIR;
 	goto exit2;
+
+}
+
+asmlinkage long sys_unlink(const char __user * pathname)
+{
+	int error = 0;
+	char * name;
+
+	name = getname(pathname);
+	if(IS_ERR(name))
+		return PTR_ERR(name);
+
+	error = do_unlink(name);
+	putname(name);
+
+	return error;
 }
 
 int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
diff -X dontdiff -Nur linux-2.6.5/include/linux/fs.h linux-2.6/include/linux/fs.h
--- linux-2.6.5/include/linux/fs.h	2004-04-08 22:07:23.000000000 +0200
+++ linux-2.6/include/linux/fs.h	2004-04-08 21:57:16.000000000 +0200
@@ -1253,6 +1253,7 @@
 
 extern int open_namei(const char *, int, int, struct nameidata *);
 extern int may_open(struct nameidata *, int, int);
+extern int do_unlink(const char *);
 
 extern int kernel_read(struct file *, unsigned long, char *, unsigned long);
 extern struct file * open_exec(const char *);
diff -X dontdiff -Nur linux-2.6.5/include/linux/sched.h linux-2.6/include/linux/sched.h
--- linux-2.6.5/include/linux/sched.h	2004-04-08 22:07:23.000000000 +0200
+++ linux-2.6/include/linux/sched.h	2004-04-08 19:14:17.000000000 +0200
@@ -211,6 +211,7 @@
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:1;
+	unsigned dump_as_root:1;
 #ifdef CONFIG_HUGETLB_PAGE
 	int used_hugetlb;
 #endif
diff -X dontdiff -Nur linux-2.6.5/kernel/sys.c linux-2.6/kernel/sys.c
--- linux-2.6.5/kernel/sys.c	2004-04-08 22:06:37.000000000 +0200
+++ linux-2.6/kernel/sys.c	2004-04-08 19:22:10.000000000 +0200
@@ -573,7 +573,7 @@
 	}
 	if (new_egid != old_egid)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dump_as_root = 1;
 		wmb();
 	}
 	if (rgid != (gid_t) -1 ||
@@ -603,7 +603,7 @@
 	{
 		if(old_egid != gid)
 		{
-			current->mm->dumpable=0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->gid = current->egid = current->sgid = current->fsgid = gid;
@@ -612,7 +612,7 @@
 	{
 		if(old_egid != gid)
 		{
-			current->mm->dumpable=0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->egid = current->fsgid = gid;
@@ -641,7 +641,7 @@
 
 	if(dumpclear)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dump_as_root = 1;
 		wmb();
 	}
 	current->uid = new_ruid;
@@ -698,7 +698,7 @@
 
 	if (new_euid != old_euid)
 	{
-		current->mm->dumpable=0;
+		current->mm->dump_as_root = 1;
 		wmb();
 	}
 	current->fsuid = current->euid = new_euid;
@@ -746,7 +746,7 @@
 
 	if (old_euid != uid)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dump_as_root = 1;
 		wmb();
 	}
 	current->fsuid = current->euid = uid;
@@ -789,7 +789,7 @@
 	if (euid != (uid_t) -1) {
 		if (euid != current->euid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->euid = euid;
@@ -837,7 +837,7 @@
 	if (egid != (gid_t) -1) {
 		if (egid != current->egid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->egid = egid;
@@ -882,7 +882,7 @@
 	{
 		if (uid != old_fsuid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->fsuid = uid;
@@ -910,7 +910,7 @@
 	{
 		if (gid != old_fsgid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->fsgid = gid;

--=-FMGHZ7A8TdXBcrkIqkPJ--

