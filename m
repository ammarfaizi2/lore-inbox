Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319157AbSHMW6r>; Tue, 13 Aug 2002 18:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319128AbSHMW5c>; Tue, 13 Aug 2002 18:57:32 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:9979 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319106AbSHMW5M>; Tue, 13 Aug 2002 18:57:12 -0400
Date: Tue, 13 Aug 2002 19:01:00 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: patch 12/38: CLIENT: add change_attr to nfs_fattr
Message-ID: <Pine.SOL.4.44.0208131900360.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a nontrivial change to the NFS client.

NFSv4 defines a new file attribute, change_attr.  This is a per-file
opaque quantity returned by the server, whose value is required to
change whenever the file is modified.  If it exists, we want to use
it for all cache consistency checks in nfs_refresh_inode().  Some
operations also return a "pre-operation" value of the change_attr;
we want to take this into account too.

First, define flags
  NFS_ATTR_FATTR_V4 - indicates that the 'struct nfs_fattr' is an
                      NFSv4 fattr, so the change_attr field is valid
  NFS_ATTR_PRE_CHANGE - indicates that the server returned a pre-operation
                      change_attr, so the pre_change_attr field is valid

Second, change nfs_refresh_inode() so that the caches are invalidated
if there is a change_attr mismatch.  Exception: If the pre_change_attr
tells us that the mismatch was caused by our operation, then do not
invalidate the caches.

This patch should leave the logic in nfs_refresh_inode() unchanged
if neither of the new flags are set.

--- old/include/linux/nfs_xdr.h	Mon Jul 29 23:13:28 2002
+++ new/include/linux/nfs_xdr.h	Mon Jul 29 13:50:30 2002
@@ -33,12 +33,16 @@ struct nfs_fattr {
 	__u64			atime;
 	__u64			mtime;
 	__u64			ctime;
+	__u64			change_attr;	/* NFSv4 change attribute */
+	__u64			pre_change_attr;/* pre-operation NFSv4 change attribute */
 };
 #define fsid			fsid_u.nfs3

 #define NFS_ATTR_WCC		0x0001		/* pre-op WCC data    */
 #define NFS_ATTR_FATTR		0x0002		/* post-op attributes */
 #define NFS_ATTR_FATTR_V3	0x0004		/* NFSv3 attributes */
+#define NFS_ATTR_FATTR_V4	0x0008
+#define NFS_ATTR_PRE_CHANGE	0x0010

 /*
  * Info on the file system
--- old/include/linux/nfs_fs.h	Mon Jul 29 22:38:55 2002
+++ new/include/linux/nfs_fs.h	Mon Jul 29 13:56:17 2002
@@ -133,6 +133,7 @@ struct nfs_inode {
 	__u64			read_cache_isize;
 	unsigned long		attrtimeo;
 	unsigned long		attrtimeo_timestamp;
+	__u64			change_attr;		/* v4 only */

 	/*
 	 * Timestamp that dates the change made to read_cache_mtime.
@@ -195,6 +196,7 @@ static inline struct nfs_inode *NFS_I(st
 #define NFS_CACHE_CTIME(inode)		(NFS_I(inode)->read_cache_ctime)
 #define NFS_CACHE_MTIME(inode)		(NFS_I(inode)->read_cache_mtime)
 #define NFS_CACHE_ISIZE(inode)		(NFS_I(inode)->read_cache_isize)
+#define NFS_CHANGE_ATTR(inode)		(NFS_I(inode)->change_attr)
 #define NFS_NEXTSCAN(inode)		(NFS_I(inode)->nextscan)
 #define NFS_CACHEINV(inode) \
 do { \
--- old/fs/nfs/inode.c	Tue Jul 30 00:44:15 2002
+++ new/fs/nfs/inode.c	Tue Jul 30 10:23:27 2002
@@ -707,6 +707,8 @@ __nfs_fhget(struct super_block *sb, stru
 		inode->i_mtime = nfs_time_to_secs(new_mtime);
 		NFS_MTIME_UPDATE(inode) = jiffies;
 		NFS_CACHE_ISIZE(inode) = new_size;
+		if (fattr->valid & NFS_ATTR_FATTR_V4)
+			NFS_CHANGE_ATTR(inode) = fattr->change_attr;
 		inode->i_size = new_isize;
 		inode->i_mode = fattr->mode;
 		inode->i_nlink = fattr->nlink;
@@ -1047,12 +1049,25 @@ __nfs_refresh_inode(struct inode *inode,
 		invalid = 1;
 	}

+	if ((fattr->valid & NFS_ATTR_FATTR_V4)
+	    && NFS_CHANGE_ATTR(inode) != fattr->change_attr) {
+#ifdef NFS_DEBUG_VERBOSE
+		printk(KERN_DEBUG "NFS: change_attr change on %s/%ld\n",
+		       inode->i_sb->s_id, inode->i_ino);
+#endif
+		invalid = 1;
+	}
+
 	/* Check Weak Cache Consistency data.
 	 * If size and mtime match the pre-operation values, we can
 	 * assume that any attribute changes were caused by our NFS
          * operation, so there's no need to invalidate the caches.
          */
-        if ((fattr->valid & NFS_ATTR_WCC)
+	if ((fattr->valid & NFS_ATTR_PRE_CHANGE)
+	    && NFS_CHANGE_ATTR(inode) == fattr->pre_change_attr) {
+		invalid = 0;
+	}
+	else if ((fattr->valid & NFS_ATTR_WCC)
 	    && NFS_CACHE_ISIZE(inode) == fattr->pre_size
 	    && NFS_CACHE_MTIME(inode) == fattr->pre_mtime) {
 		invalid = 0;
@@ -1080,6 +1095,9 @@ __nfs_refresh_inode(struct inode *inode,
 	NFS_CACHE_ISIZE(inode) = new_size;
 	inode->i_size = new_isize;

+	if (fattr->valid & NFS_ATTR_FATTR_V4)
+		NFS_CHANGE_ATTR(inode) = fattr->change_attr;
+
 	inode->i_mode = fattr->mode;
 	inode->i_nlink = fattr->nlink;
 	inode->i_uid = fattr->uid;

