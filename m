Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUCSCwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUCSCwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:52:45 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:13265 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261627AbUCSCwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:52:38 -0500
Date: Fri, 19 Mar 2004 03:52:36 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-ID: <20040319025236.GC31040@MAIL.13thfloor.at>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075814.GE31818@MAIL.13thfloor.at> <20040318122645.GJ31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318122645.GJ31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:26:45PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Mar 15, 2004 at 08:58:14AM +0100, Herbert Poetzl wrote:
> > -extern int vfs_permission(struct inode *, int);
> > +extern int vfs_permission(struct inode *, int, struct nameidata *);
> 
> Vetoed, along with IS_RDONLY() prototype change.

hmm, that is what I expected ...

> Note that you are doing exactly the opposite of the changes we'll need
> to deal with remount races.
> 
> What we need is to push readonly checks _up_ - into callers of fs methods.
> vfs_permission() is default ->permission() - no more, no less.  Neither
> it nor other instances have any business touching "this vfsmount is readonly"
> logics - it's not something where fs can override stuff; it's "admin said
> no r/w access here".
> 
> IOW, the check for r/w access to file/directory/symlink on a r/o mount should
> be moved into the callers (very few of them) of ->permission() and away from
> the methods themselves.

maybe like this ...

patch can be downloaded at:
http://www.13thfloor.at/patches/patch-2.6.5-rc1-bk3-bme0.04.2-permission.diff

best,
Herbert


diff -NurpP --minimal linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/ext2/acl.c linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/ext2/acl.c
--- linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/ext2/acl.c	2004-03-16 10:21:19.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/ext2/acl.c	2004-03-19 03:17:17.000000000 +0100
@@ -290,13 +290,6 @@ ext2_permission(struct inode *inode, int
 {
 	int mode = inode->i_mode;
 
-	/* Nobody gets write access to a read-only fs */
-	if ((mask & MAY_WRITE) && IS_RDONLY(inode) &&
-	    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
-		return -EROFS;
-	/* Nobody gets write access to an immutable file */
-	if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
-	    return -EACCES;
 	if (current->fsuid == inode->i_uid) {
 		mode >>= 6;
 	} else if (test_opt(inode->i_sb, POSIX_ACL)) {
diff -NurpP --minimal linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/ext3/acl.c linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/ext3/acl.c
--- linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/ext3/acl.c	2004-03-16 10:21:19.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/ext3/acl.c	2004-03-19 03:17:28.000000000 +0100
@@ -295,13 +295,6 @@ ext3_permission(struct inode *inode, int
 {
 	int mode = inode->i_mode;
 
-	/* Nobody gets write access to a read-only fs */
-	if ((mask & MAY_WRITE) && IS_RDONLY(inode) &&
-	    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
-		return -EROFS;
-	/* Nobody gets write access to an immutable file */
-	if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
-	    return -EACCES;
 	if (current->fsuid == inode->i_uid) {
 		mode >>= 6;
 	} else if (test_opt(inode->i_sb, POSIX_ACL)) {
diff -NurpP --minimal linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/intermezzo/dir.c linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/intermezzo/dir.c
--- linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/intermezzo/dir.c	2004-03-18 22:49:57.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/intermezzo/dir.c	2004-03-19 03:46:49.000000000 +0100
@@ -846,6 +846,16 @@ int presto_permission(struct inode *inod
 
         cache = presto_get_cache(inode);
 
+        /* Nobody gets write access to a read-only fs */
+        if ((mask & MAY_WRITE) &&
+                (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) &&
+                (IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))))
+                return -EROFS;
+
+        /* Nobody gets write access to an immutable file */
+        if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
+                return -EACCES;
+
         if ( cache ) {
                 /* we only override the file/dir permission operations */
                 struct inode_operations *fiops = filter_c2cfiops(cache->cache_filter);
diff -NurpP --minimal linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/jfs/acl.c linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/jfs/acl.c
--- linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/jfs/acl.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/jfs/acl.c	2004-03-19 03:18:12.000000000 +0100
@@ -132,21 +132,6 @@ int jfs_permission(struct inode * inode,
 	umode_t mode = inode->i_mode;
 	struct jfs_inode_info *ji = JFS_IP(inode);
 
-	if (mask & MAY_WRITE) {
-		/*
-		 * Nobody gets write access to a read-only fs.
-		 */
-		if (IS_RDONLY(inode) &&
-		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
-			return -EROFS;
-
-		/*
-		 * Nobody gets write access to an immutable file.
-		 */
-		if (IS_IMMUTABLE(inode))
-			return -EACCES;
-	}
-
 	if (current->fsuid == inode->i_uid) {
 		mode >>= 6;
 		goto check_mode;
diff -NurpP --minimal linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/namei.c linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/namei.c
--- linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/namei.c	2004-03-19 01:40:53.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/namei.c	2004-03-19 03:43:38.000000000 +0100
@@ -160,21 +160,6 @@ int vfs_permission(struct inode * inode,
 {
 	umode_t			mode = inode->i_mode;
 
-	if (mask & MAY_WRITE) {
-		/*
-		 * Nobody gets write access to a read-only fs.
-		 */
-		if (IS_RDONLY(inode) &&
-		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
-			return -EROFS;
-
-		/*
-		 * Nobody gets write access to an immutable file.
-		 */
-		if (IS_IMMUTABLE(inode))
-			return -EACCES;
-	}
-
 	if (current->fsuid == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
@@ -207,9 +192,20 @@ int vfs_permission(struct inode * inode,
 
 int permission(struct inode * inode,int mask, struct nameidata *nd)
 {
+	int mode = inode->i_mode;
 	int retval;
 	int submask;
 
+	/* Nobody gets write access to a read-only fs */
+	if ((mask & MAY_WRITE) &&
+		(S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) &&
+		(IS_RDONLY(inode) || (nd && MNT_IS_RDONLY(nd->mnt))))
+		return -EROFS;
+
+	/* Nobody gets write access to an immutable file */
+	if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
+		return -EACCES;
+
 	/* Ordinary permission routines do not understand MAY_APPEND. */
 	submask = mask & ~MAY_APPEND;
 
diff -NurpP --minimal linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/nfs/dir.c linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/nfs/dir.c
--- linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/nfs/dir.c	2004-03-16 10:21:20.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-permission/fs/nfs/dir.c	2004-03-19 03:36:11.000000000 +0100
@@ -1503,29 +1503,11 @@ nfs_permission(struct inode *inode, int 
 {
 	struct nfs_access_cache *cache = &NFS_I(inode)->cache_access;
 	struct rpc_cred *cred;
-	int mode = inode->i_mode;
 	int res;
 
 	if (mask == 0)
 		return 0;
-	if (mask & MAY_WRITE) {
-		/*
-		 *
-		 * Nobody gets write access to a read-only fs.
-		 *
-		 */
-		if (IS_RDONLY(inode) &&
-		    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
-			return -EROFS;
 
-		/*
-		 *
-		 * Nobody gets write access to an immutable file.
-		 *
-		 */
-		if (IS_IMMUTABLE(inode))
-			return -EACCES;
-	}
 	/* Are we checking permissions on anything other than lookup/execute? */
 	if ((mask & MAY_EXEC) == 0) {
 		/* We only need to check permissions on file open() and access() */
