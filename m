Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSKDVBp>; Mon, 4 Nov 2002 16:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262788AbSKDVBp>; Mon, 4 Nov 2002 16:01:45 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:60911 "EHLO
	mookie.adilger.int") by vger.kernel.org with ESMTP
	id <S262783AbSKDVBn>; Mon, 4 Nov 2002 16:01:43 -0500
Date: Mon, 4 Nov 2002 14:13:17 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: linux-kernel@vger.kernel.org
Cc: Marco van Wieringen <mvw@planets.elm.net>
Subject: [PATCH] remove extern inline from quotaops.h
Message-ID: <20021104141317.A29058@mookie.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marco van Wieringen <mvw@planets.elm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are having a strange problem with compiling ext3 code out-of-tree,
and it is related to the fact that several functions in quotaops.h
are declared "extern __inline__" instead of "static inline".  Is
there a good reason to have it that way?  I thought "extern __inline__"
was sort of frowned upon.

Below is a patch to change this to "static inline".  A similar patch is
needed for 2.5, but the file has changed significantly...

Cheers, Andreas
=============================================================================
--- linux-2.4/include/linux/quotaops.h.orig	Wed Oct 30 17:10:48 2002
+++ linux-2.4/include/linux/quotaops.h	Mon Nov  4 13:53:05 2002
@@ -38,9 +38,9 @@
  */
 #define sb_any_quota_enabled(sb) ((sb)->s_dquot.flags & (DQUOT_USR_ENABLED | DQUOT_GRP_ENABLED))
 
-static __inline__ void DQUOT_INIT(struct inode *inode)
+static inline void DQUOT_INIT(struct inode *inode)
 {
- 	if (!inode->i_sb)
+	if (!inode->i_sb)
 		out_of_line_bug();
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
@@ -48,18 +48,19 @@
 	unlock_kernel();
 }
 
-static __inline__ void DQUOT_DROP(struct inode *inode)
+static inline void DQUOT_DROP(struct inode *inode)
 {
 	lock_kernel();
 	if (IS_QUOTAINIT(inode)) {
 		if (!inode->i_sb)
 			out_of_line_bug();
-		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
+		/* Ops must be set when there's any quota... */
+		inode->i_sb->dq_op->drop(inode);
 	}
 	unlock_kernel();
 }
 
-static __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb)) {
@@ -75,7 +76,7 @@
 	return 0;
 }
 
-static __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	int ret;
 	if (!(ret = DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr)))
@@ -83,7 +84,7 @@
 	return ret;
 }
 
-static __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb)) {
@@ -99,7 +100,7 @@
 	return 0;
 }
 
-static __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	int ret;
 	if (!(ret = DQUOT_ALLOC_SPACE_NODIRTY(inode, nr)))
@@ -107,7 +108,7 @@
 	return ret;
 }
 
-static __inline__ int DQUOT_ALLOC_INODE(struct inode *inode)
+static inline int DQUOT_ALLOC_INODE(struct inode *inode)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb)) {
@@ -121,7 +122,7 @@
 	return 0;
 }
 
-static __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb))
@@ -131,13 +132,13 @@
 	unlock_kernel();
 }
 
-static __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 }
-	
-static __inline__ void DQUOT_FREE_INODE(struct inode *inode)
+
+static inline void DQUOT_FREE_INODE(struct inode *inode)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb))
@@ -145,7 +146,7 @@
 	unlock_kernel();
 }
 
-static __inline__ int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
+static inline int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode)) {
@@ -174,7 +175,7 @@
 #define DQUOT_SYNC(dev)				do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
-extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	inode_add_bytes(inode, nr);
@@ -182,14 +183,14 @@
 	return 0;
 }
 
-extern __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	inode_add_bytes(inode, nr);
@@ -197,21 +198,21 @@
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+static inline int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
 {
 	lock_kernel();
 	inode_sub_bytes(inode, nr);
 	unlock_kernel();
 }
 
-extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+static inline void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
 	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

