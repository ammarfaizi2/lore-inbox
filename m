Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270615AbUJUB2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270615AbUJUB2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 21:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270520AbUJUB00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 21:26:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:15795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270687AbUJUBPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 21:15:19 -0400
Date: Wed, 20 Oct 2004 18:15:09 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: sds@epoch.ncsc.mil, jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2][LSM] fix send_sigurg mediation
Message-ID: <20041020181507.S2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley notes that send_sigurg isn't mediated by LSM in the
same manner as send_sigio.  Patch below is a slight modification of
Stephen's original patch.  It moves the security_file_send_sigiotask()
hook into the sigio_perm().  The hook's fd and reason arguments are
replaced with the signum.  sigio_perm() and it's callers are updated to
pass the signum through to the hook.  In send_sigio case, the signum is
simply fown->signum or SIGIO when signum is 0, however in send_sigurg
the kernel doesn't use fown->signum, it always sends SIGURG.

From: Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/fcntl.c 1.43 vs edited =====
--- 1.43/fs/fcntl.c	2004-10-19 02:40:19 -07:00
+++ edited/fs/fcntl.c	2004-10-20 17:41:22 -07:00
@@ -431,11 +431,12 @@
 };
 
 static inline int sigio_perm(struct task_struct *p,
-                             struct fown_struct *fown)
+                             struct fown_struct *fown, int sig)
 {
-	return ((fown->euid == 0) ||
- 	        (fown->euid == p->suid) || (fown->euid == p->uid) ||
- 	        (fown->uid == p->suid) || (fown->uid == p->uid));
+	return (((fown->euid == 0) ||
+		 (fown->euid == p->suid) || (fown->euid == p->uid) ||
+		 (fown->uid == p->suid) || (fown->uid == p->uid)) &&
+		!security_file_send_sigiotask(p, fown, sig));
 }
 
 static void send_sigio_to_task(struct task_struct *p,
@@ -443,10 +444,7 @@
 			       int fd,
 			       int reason)
 {
-	if (!sigio_perm(p, fown))
-		return;
-
-	if (security_file_send_sigiotask(p, fown, fd, reason))
+	if (!sigio_perm(p, fown, fown->signum))
 		return;
 
 	switch (fown->signum) {
@@ -508,7 +506,7 @@
 static void send_sigurg_to_task(struct task_struct *p,
                                 struct fown_struct *fown)
 {
-	if (sigio_perm(p, fown))
+	if (sigio_perm(p, fown, SIGURG))
 		send_group_sig_info(SIGURG, SEND_SIG_PRIV, p);
 }
 
===== include/linux/security.h 1.42 vs edited =====
--- 1.42/include/linux/security.h	2004-10-20 01:37:07 -07:00
+++ edited/include/linux/security.h	2004-10-20 17:41:22 -07:00
@@ -488,16 +488,15 @@
  *	@file contains the file structure to update.
  *	Return 0 on success.
  * @file_send_sigiotask:
- *	Check permission for the file owner @fown to send SIGIO to the process
- *	@tsk.  Note that this hook is always called from interrupt.  Note that
- *	the fown_struct, @fown, is never outside the context of a struct file,
- *	so the file structure (and associated security information) can always
- *	be obtained:
+ *	Check permission for the file owner @fown to send SIGIO or SIGURG to the
+ *	process @tsk.  Note that this hook is sometimes called from interrupt.
+ *	Note that the fown_struct, @fown, is never outside the context of a
+ *	struct file, so the file structure (and associated security information)
+ *	can always be obtained:
  *		(struct file *)((long)fown - offsetof(struct file,f_owner));
  * 	@tsk contains the structure of task receiving signal.
  *	@fown contains the file owner information.
- *	@fd contains the file descriptor.
- *	@reason contains the operational flags.
+ *	@sig is the signal that will be sent.  When 0, kernel sends SIGIO.
  *	Return 0 if permission is granted.
  * @file_receive:
  *	This hook allows security modules to control the ability of a process
@@ -1135,8 +1134,7 @@
 			   unsigned long arg);
 	int (*file_set_fowner) (struct file * file);
 	int (*file_send_sigiotask) (struct task_struct * tsk,
-				    struct fown_struct * fown,
-				    int fd, int reason);
+				    struct fown_struct * fown, int sig);
 	int (*file_receive) (struct file * file);
 
 	int (*task_create) (unsigned long clone_flags);
@@ -1657,9 +1655,9 @@
 
 static inline int security_file_send_sigiotask (struct task_struct *tsk,
 						struct fown_struct *fown,
-						int fd, int reason)
+						int sig)
 {
-	return security_ops->file_send_sigiotask (tsk, fown, fd, reason);
+	return security_ops->file_send_sigiotask (tsk, fown, sig);
 }
 
 static inline int security_file_receive (struct file *file)
@@ -2299,7 +2297,7 @@
 
 static inline int security_file_send_sigiotask (struct task_struct *tsk,
 						struct fown_struct *fown,
-						int fd, int reason)
+						int sig)
 {
 	return 0;
 }
===== security/dummy.c 1.46 vs edited =====
--- 1.46/security/dummy.c	2004-10-20 01:37:08 -07:00
+++ edited/security/dummy.c	2004-10-20 17:41:22 -07:00
@@ -518,8 +518,7 @@
 }
 
 static int dummy_file_send_sigiotask (struct task_struct *tsk,
-				      struct fown_struct *fown, int fd,
-				      int reason)
+				      struct fown_struct *fown, int sig)
 {
 	return 0;
 }
===== security/selinux/hooks.c 1.67 vs edited =====
--- 1.67/security/selinux/hooks.c	2004-10-19 02:40:31 -07:00
+++ edited/security/selinux/hooks.c	2004-10-20 17:41:22 -07:00
@@ -2562,8 +2562,7 @@
 }
 
 static int selinux_file_send_sigiotask(struct task_struct *tsk,
-				       struct fown_struct *fown,
-				       int fd, int reason)
+				       struct fown_struct *fown, int signum)
 {
         struct file *file;
 	u32 perm;
@@ -2576,10 +2575,10 @@
 	tsec = tsk->security;
 	fsec = file->f_security;
 
-	if (!fown->signum)
+	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
 	else
-		perm = signal_to_av(fown->signum);
+		perm = signal_to_av(signum);
 
 	return avc_has_perm(fsec->fown_sid, tsec->sid,
 			    SECCLASS_PROCESS, perm, NULL, NULL);
