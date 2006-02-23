Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWBWOKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWBWOKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 09:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWBWOKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 09:10:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63408 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751256AbWBWOKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 09:10:24 -0500
Date: Thu, 23 Feb 2006 09:10:22 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200602231410.k1NEAMk1021578@devserv.devel.redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] flags parameter for linkat
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently at the POSIX meeting and one thing covered was the
incompatibility of Linux's link() with the POSIX definition.  The
difference is the treatment of symbolic links in the destination
name.  Linux does not follow symlinks, POSIX requires it does.

Even somebody thinks this is a good default behavior we cannot
change this because it would break the ABI.  But the fact remains
that some application might want this behavior.

We have one chance to help implementing this without breaking the
behavior.  For this we could use the new linkat interface which
would need a new flags parameter.  If the new parameter is
AT_SYMLINK_FOLLOW the new behavior could be invoked.

I do not want to introduce such a patch now.  But we could add the
parameter now, just don't use it.  The patch below would do this.
Can we get this late patch applied before the release more or less
fixes the syscall API?

Signed-Off-By: Ulrich Drepper <drepper@redhat.com>


--- fs/namei.c	2006-02-23 05:51:45.000000000 -0800
+++ fs/namei.c-new	2006-02-23 05:58:31.000000000 -0800
@@ -2232,13 +2232,17 @@
  * and other special files.  --ADM
  */
 asmlinkage long sys_linkat(int olddfd, const char __user *oldname,
-			   int newdfd, const char __user *newname)
+			   int newdfd, const char __user *newname,
+			   int flags)
 {
 	struct dentry *new_dentry;
 	struct nameidata nd, old_nd;
 	int error;
 	char * to;
 
+	if (flags != 0)
+		return -EINVAL;
+
 	to = getname(newname);
 	if (IS_ERR(to))
 		return PTR_ERR(to);
@@ -2271,7 +2275,7 @@
 
 asmlinkage long sys_link(const char __user *oldname, const char __user *newname)
 {
-	return sys_linkat(AT_FDCWD, oldname, AT_FDCWD, newname);
+	return sys_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
 /*
--- ./arch/s390/kernel/compat_wrapper.S-new	2006-02-23 06:00:12.000000000 -0800
+++ ./arch/s390/kernel/compat_wrapper.S	2006-02-23 05:51:32.000000000 -0800
@@ -1552,7 +1552,6 @@
 	llgtr	%r3,%r3			# const char *
 	lgfr	%r4,%r4			# int
 	llgtr	%r5,%r5			# const char *
-	lgfr	%r6,%r6			# int
 	jg	sys_linkat
 
 	.globl sys_symlinkat_wrapper
