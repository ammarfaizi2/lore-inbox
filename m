Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWIFOpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWIFOpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWIFOpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:45:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57067 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751168AbWIFOpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:45:10 -0400
Message-Id: <20060906151644.601351848@winden.suse.de>
References: <20060906151438.228071937@winden.suse.de>
User-Agent: quilt/0.44-16.4
Date: Wed, 06 Sep 2006 17:14:39 +0200
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [patch 1/3] Pass MAY_APPEND through to permission inode operations that understand it
Content-Disposition: inline; filename=may-append.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a mount flag with which filesystems can idicate that they
support permissions beyond MAY_READ, MAY_WRITE, and MAY_EXEC. If
that flag is set, pass MAY_APPEND through to the filesystems'
permission inode operation.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.18-rc6/fs/namei.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/namei.c
+++ linux-2.6.18-rc6/fs/namei.c
@@ -228,7 +228,7 @@ int generic_permission(struct inode *ino
 int permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	umode_t mode = inode->i_mode;
-	int retval, submask;
+	int retval, submask = mask;
 
 	if (mask & MAY_WRITE) {
 
@@ -254,8 +254,8 @@ int permission(struct inode *inode, int 
 	if ((mask & MAY_EXEC) && S_ISREG(mode) && !(mode & S_IXUGO))
 		return -EACCES;
 
-	/* Ordinary permission routines do not understand MAY_APPEND. */
-	submask = mask & ~MAY_APPEND;
+	if (!IS_XPERM(inode))
+		submask &= (MAY_READ | MAY_WRITE | MAY_EXEC);
 	if (inode->i_op && inode->i_op->permission)
 		retval = inode->i_op->permission(inode, submask, nd);
 	else
Index: linux-2.6.18-rc6/include/linux/fs.h
===================================================================
--- linux-2.6.18-rc6.orig/include/linux/fs.h
+++ linux-2.6.18-rc6/include/linux/fs.h
@@ -119,6 +119,8 @@ extern int dir_notify_enable;
 #define MS_PRIVATE	(1<<18)	/* change to private */
 #define MS_SLAVE	(1<<19)	/* change to slave */
 #define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_XPERM	(1<<21) /* permission function understands more than
+				   MAY_{READ,WRITE,EXEC} */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
@@ -172,6 +174,7 @@ extern int dir_notify_enable;
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
+#define IS_XPERM(inode)		__IS_FLG(inode, MS_XPERM)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX Products GmbH / Novell Inc.

