Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbUCOH7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 02:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUCOH7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 02:59:13 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:65230 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262277AbUCOH6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 02:58:49 -0500
Date: Mon, 15 Mar 2004 08:58:47 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.04.1 4/5
Message-ID: <20040315075847.GF31818@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314203427.27857fd9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/namei.c linux-2.6.4-20040314_2308-bme0.04.1/fs/namei.c
--- linux-2.6.4-20040314_2308/fs/namei.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/namei.c	2004-03-15 07:29:50.000000000 +0100
@@ -156,15 +156,15 @@ char * getname(const char __user * filen
  * for filesystem access without changing the "normal" uids which
  * are used for other things..
  */
-int vfs_permission(struct inode * inode, int mask)
+int vfs_permission(struct inode * inode, int mask, struct nameidata *nd)
 {
-	umode_t			mode = inode->i_mode;
+	umode_t	mode = inode->i_mode;
 
 	if (mask & MAY_WRITE) {
 		/*
 		 * Nobody gets write access to a read-only fs.
 		 */
-		if (IS_RDONLY(inode) &&
+		if (IS_RDONLY(inode, nd ? nd->mnt : NULL) &&
 		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 			return -EROFS;
 
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ext2/acl.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ext2/acl.c
--- linux-2.6.4-20040314_2308/fs/ext2/acl.c	2004-03-15 05:41:49.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext2/acl.c	2004-03-15 07:44:41.000000000 +0100
@@ -291,7 +292,8 @@ ext2_permission(struct inode *inode, int
 	int mode = inode->i_mode;
 
 	/* Nobody gets write access to a read-only fs */
-	if ((mask & MAY_WRITE) && IS_RDONLY(inode) &&
+	if ((mask & MAY_WRITE) &&
+	    (IS_RDONLY(inode, nd ? nd->mnt : NULL)) &&
 	    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 		return -EROFS;
 	/* Nobody gets write access to an immutable file */
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/ext3/acl.c linux-2.6.4-20040314_2308-bme0.04.1/fs/ext3/acl.c
--- linux-2.6.4-20040314_2308/fs/ext3/acl.c	2004-03-15 05:41:49.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/ext3/acl.c	2004-03-15 07:38:42.000000000 +0100
@@ -296,7 +296,8 @@ ext3_permission(struct inode *inode, int
 	int mode = inode->i_mode;
 
 	/* Nobody gets write access to a read-only fs */
-	if ((mask & MAY_WRITE) && IS_RDONLY(inode) &&
+	if ((mask & MAY_WRITE) &&
+	    (IS_RDONLY(inode, nd ? nd->mnt : NULL)) &&
 	    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 		return -EROFS;
 	/* Nobody gets write access to an immutable file */
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/jfs/acl.c linux-2.6.4-20040314_2308-bme0.04.1/fs/jfs/acl.c
--- linux-2.6.4-20040314_2308/fs/jfs/acl.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/jfs/acl.c	2004-03-15 07:37:45.000000000 +0100
@@ -136,7 +136,7 @@ int jfs_permission(struct inode * inode,
 		/*
 		 * Nobody gets write access to a read-only fs.
 		 */
-		if (IS_RDONLY(inode) &&
+		if (IS_RDONLY(inode, nd ? nd->mnt : NULL) &&
 		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
 			return -EROFS;
