Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTFMHGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbTFMHGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:06:18 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:1012 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265182AbTFMHFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:05:47 -0400
Date: Fri, 13 Jun 2003 00:19:08 -0700
From: Chris Wright <chris@wirex.com>
To: torvalds@transmeta.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Remove inode_permission_lite hook 3/4
Message-ID: <20030613001908.F31636@figure1.int.wirex.com>
Mail-Followup-To: torvalds@transmeta.com, akpm@digeo.com,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030613001021.D31636@figure1.int.wirex.com> <20030613001521.E31636@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030613001521.E31636@figure1.int.wirex.com>; from chris@wirex.com on Fri, Jun 13, 2003 at 12:15:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[LSM] Remove security_inode_permission_lite hook

--- linus-2.5/fs/namei.c.perm_lite	Thu Jun 12 22:51:27 2003
+++ linus-2.5/fs/namei.c	Thu Jun 12 22:51:27 2003
@@ -325,7 +325,7 @@
 
 	return -EACCES;
 ok:
-	return security_inode_permission_lite(inode, MAY_EXEC);
+	return security_inode_permission(inode, MAY_EXEC);
 }
 
 /*
--- linus-2.5/include/linux/security.h.perm_lite	Thu Jun 12 22:48:12 2003
+++ linus-2.5/include/linux/security.h	Thu Jun 12 22:51:27 2003
@@ -327,16 +327,6 @@
  *	@inode contains the inode structure to check.
  *	@mask contains the permission mask.
  *	Return 0 if permission is granted.
- * @inode_permission_lite:
- * 	Check permission before accessing an inode.  This hook is
- * 	currently only called when checking MAY_EXEC access during
- * 	pathname resolution.  The dcache lock is held and thus modules
- * 	that could sleep or contend the lock should return -EAGAIN to
- * 	inform the kernel to drop the lock and try again calling the
- * 	full permission hook.
- * 	@inode contains the inode structure to check.
- * 	@mask contains the permission mask.
- * 	Return 0 if permission is granted.
  * @inode_setattr:
  *	Check permission before setting file attributes.  Note that the kernel
  *	call to notify_change is performed from several locations, whenever
@@ -1052,7 +1042,6 @@
 	int (*inode_readlink) (struct dentry *dentry);
 	int (*inode_follow_link) (struct dentry *dentry, struct nameidata *nd);
 	int (*inode_permission) (struct inode *inode, int mask);
-	int (*inode_permission_lite) (struct inode *inode, int mask);
 	int (*inode_setattr)	(struct dentry *dentry, struct iattr *attr);
 	int (*inode_getattr) (struct vfsmount *mnt, struct dentry *dentry);
         void (*inode_delete) (struct inode *inode);
@@ -1465,12 +1454,6 @@
 	return security_ops->inode_permission (inode, mask);
 }
 
-static inline int security_inode_permission_lite (struct inode *inode,
-						  int mask)
-{
-	return security_ops->inode_permission_lite (inode, mask);
-}
-
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
 {
@@ -2096,12 +2079,6 @@
 {
 	return 0;
 }
-
-static inline int security_inode_permission_lite (struct inode *inode,
-						  int mask)
-{
-	return 0;
-}
 
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
--- linus-2.5/security/dummy.c.perm_lite	Thu Jun 12 22:48:12 2003
+++ linus-2.5/security/dummy.c	Thu Jun 12 22:51:27 2003
@@ -308,11 +308,6 @@
 	return 0;
 }
 
-static int dummy_inode_permission_lite (struct inode *inode, int mask)
-{
-	return 0;
-}
-
 static int dummy_inode_setattr (struct dentry *dentry, struct iattr *iattr)
 {
 	return 0;
@@ -826,7 +821,6 @@
 	set_to_dummy_if_null(ops, inode_readlink);
 	set_to_dummy_if_null(ops, inode_follow_link);
 	set_to_dummy_if_null(ops, inode_permission);
-	set_to_dummy_if_null(ops, inode_permission_lite);
 	set_to_dummy_if_null(ops, inode_setattr);
 	set_to_dummy_if_null(ops, inode_getattr);
 	set_to_dummy_if_null(ops, inode_delete);
