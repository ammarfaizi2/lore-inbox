Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTFBJuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTFBJuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:50:08 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:54520 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262108AbTFBJtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:49:41 -0400
Date: Mon, 2 Jun 2003 03:00:09 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Early init for security modules and various cleanups
Message-ID: <20030602030009.E27233@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030602024910.B27233@figure1.int.wirex.com> <20030602025450.C27233@figure1.int.wirex.com> <20030602025736.D27233@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030602025736.D27233@figure1.int.wirex.com>; from chris@wirex.com on Mon, Jun 02, 2003 at 02:57:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1261  -> 1.1262 
#	    security/dummy.c	1.24    -> 1.25   
#	          fs/namei.c	1.73    -> 1.74   
#	include/linux/security.h	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/02	chris@wirex.com	1.1262
# [LSM] Remove security_inode_permission_lite hook
# --------------------------------------------
#
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Mon Jun  2 01:31:29 2003
+++ b/fs/namei.c	Mon Jun  2 01:31:29 2003
@@ -325,7 +325,7 @@
 
 	return -EACCES;
 ok:
-	return security_inode_permission_lite(inode, MAY_EXEC);
+	return security_inode_permission(inode, MAY_EXEC);
 }
 
 /*
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Mon Jun  2 01:31:29 2003
+++ b/include/linux/security.h	Mon Jun  2 01:31:29 2003
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
@@ -1470,12 +1459,6 @@
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
@@ -2103,12 +2086,6 @@
 }
 
 static inline int security_inode_permission (struct inode *inode, int mask)
-{
-	return 0;
-}
-
-static inline int security_inode_permission_lite (struct inode *inode,
-						  int mask)
 {
 	return 0;
 }
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Mon Jun  2 01:31:29 2003
+++ b/security/dummy.c	Mon Jun  2 01:31:29 2003
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
