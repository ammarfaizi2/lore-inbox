Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293546AbSCCJ6V>; Sun, 3 Mar 2002 04:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293547AbSCCJ5F>; Sun, 3 Mar 2002 04:57:05 -0500
Received: from relay02.valueweb.net ([216.219.253.236]:63759 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S293541AbSCCJ4m>; Sun, 3 Mar 2002 04:56:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 5
Date: Sun, 3 Mar 2002 04:57:02 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095625Z293039-31621+4@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the fifth of 13 patches.

	This cleans up the block tracking/allocation of the quota code and adds 
supporting functions and a qsize_t type.





diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sat Mar  2 19:28:17 2002
+++ linux-2.5/fs/dquot.c	Sat Mar  2 19:27:39 2002
@@ -703,9 +703,9 @@
 	mark_dquot_dirty(dquot);
 }
 
-static inline void dquot_incr_blocks(struct dquot *dquot, unsigned long 
number)
+static inline void dquot_incr_space(struct dquot *dquot, qsize_t number)
 {
-	dquot->dq_curblocks += number;
+	dquot->dq_curspace += number;
 	mark_dquot_dirty(dquot);
 }
 
@@ -721,13 +721,13 @@
 	mark_dquot_dirty(dquot);
 }
 
-static inline void dquot_decr_blocks(struct dquot *dquot, unsigned long 
number)
+static inline void dquot_decr_space(struct dquot *dquot, qsize_t number)
 {
-	if (dquot->dq_curblocks > number)
-		dquot->dq_curblocks -= number;
+	if (dquot->dq_curspace > number)
+		dquot->dq_curspace -= number;
 	else
-		dquot->dq_curblocks = 0;
-	if (dquot->dq_curblocks < dquot->dq_bsoftlimit)
+		dquot->dq_curspace = 0;
+	if (toqb(dquot->dq_curspace) < dquot->dq_bsoftlimit)
 		dquot->dq_btime = (time_t) 0;
 	dquot->dq_flags &= ~DQ_BLKS;
 	mark_dquot_dirty(dquot);
@@ -837,14 +837,14 @@
 	return QUOTA_OK;
 }
 
-static int check_bdq(struct dquot *dquot, ulong blocks, char prealloc, char 
*warntype)
+static int check_bdq(struct dquot *dquot, qsize_t space, int prealloc, char 
*warntype)
 {
 	*warntype = 0;
-	if (blocks <= 0 || dquot->dq_flags & DQ_FAKE)
+	if (space <= 0 || dquot->dq_flags & DQ_FAKE)
 		return QUOTA_OK;
 
 	if (dquot->dq_bhardlimit &&
-	   (dquot->dq_curblocks + blocks) > dquot->dq_bhardlimit &&
+	   toqb(dquot->dq_curspace + space) > dquot->dq_bhardlimit &&
             !ignore_hardlimit(dquot)) {
 		if (!prealloc)
 			*warntype = BHARDWARN;
@@ -852,7 +852,7 @@
 	}
 
 	if (dquot->dq_bsoftlimit &&
-	   (dquot->dq_curblocks + blocks) > dquot->dq_bsoftlimit &&
+	   toqb(dquot->dq_curspace + space) > dquot->dq_bsoftlimit &&
 	    dquot->dq_btime && CURRENT_TIME >= dquot->dq_btime &&
             !ignore_hardlimit(dquot)) {
 		if (!prealloc)
@@ -861,7 +861,7 @@
 	}
 
 	if (dquot->dq_bsoftlimit &&
-	   (dquot->dq_curblocks + blocks) > dquot->dq_bsoftlimit &&
+	   toqb(dquot->dq_curspace + space) > dquot->dq_bsoftlimit &&
 	    dquot->dq_btime == 0) {
 		if (!prealloc) {
 			*warntype = BSOFTWARN;
@@ -948,7 +948,7 @@
 /*
  * This operation can block, but only after everything is updated
  */
-int dquot_alloc_block(struct inode *inode, unsigned long number, char warn)
+int dquot_alloc_space(struct inode *inode, qsize_t number, int warn)
 {
 	int cnt, ret = NO_QUOTA;
 	struct dquot *dquot[MAXQUOTAS];
@@ -970,9 +970,9 @@
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		if (dquot[cnt] == NODQUOT)
 			continue;
-		dquot_incr_blocks(dquot[cnt], number);
+		dquot_incr_space(dquot[cnt], number);
 	}
-	inode->i_blocks += number << (BLOCK_SIZE_BITS - 9);
+	inode->i_blocks += number >> 9;
 	/* NOBLOCK End */
 	ret = QUOTA_OK;
 warn_put_all:
@@ -1026,7 +1026,7 @@
 /*
  * This is a non-blocking operation.
  */
-void dquot_free_block(struct inode *inode, unsigned long number)
+void dquot_free_space(struct inode *inode, qsize_t number)
 {
 	unsigned short cnt;
 	struct dquot *dquot;
@@ -1037,10 +1037,10 @@
 		dquot = dqduplicate(inode->i_dquot[cnt]);
 		if (dquot == NODQUOT)
 			continue;
-		dquot_decr_blocks(dquot, number);
+		dquot_decr_space(dquot, number);
 		dqputduplicate(dquot);
 	}
-	inode->i_blocks -= number << (BLOCK_SIZE_BITS - 9);
+	inode->i_blocks -= number >> 9;
 	unlock_kernel();
 	/* NOBLOCK End */
 }
@@ -1073,7 +1073,7 @@
  */
 int dquot_transfer(struct inode *inode, struct iattr *iattr)
 {
-	unsigned long blocks;
+	qsize_t space;
 	struct dquot *transfer_from[MAXQUOTAS];
 	struct dquot *transfer_to[MAXQUOTAS];
 	int cnt, ret = NO_QUOTA, chuid = (iattr->ia_valid & ATTR_UID) && 
inode->i_uid != iattr->ia_uid,
@@ -1103,7 +1103,7 @@
 		}
 	}
 	/* NOBLOCK START: From now on we shouldn't block */
-	blocks = (inode->i_blocks >> 1);
+	space = ((qsize_t)inode->i_blocks) << 9;
 	/* Build the transfer_from list and check the limits */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
 		/* The second test can fail when quotaoff is in progress... */
@@ -1113,7 +1113,7 @@
 		if (transfer_from[cnt] == NODQUOT)	/* Can happen on quotafiles (quota 
isn't initialized on them)... */
 			continue;
 		if (check_idq(transfer_to[cnt], 1, warntype+cnt) == NO_QUOTA ||
-		    check_bdq(transfer_to[cnt], blocks, 0, warntype+cnt) == NO_QUOTA)
+		    check_bdq(transfer_to[cnt], space, 0, warntype+cnt) == NO_QUOTA)
 			goto warn_put_all;
 	}
 
@@ -1128,10 +1128,10 @@
 			continue;
 
 		dquot_decr_inodes(transfer_from[cnt], 1);
-		dquot_decr_blocks(transfer_from[cnt], blocks);
+		dquot_decr_space(transfer_from[cnt], space);
 
 		dquot_incr_inodes(transfer_to[cnt], 1);
-		dquot_incr_blocks(transfer_to[cnt], blocks);
+		dquot_incr_space(transfer_to[cnt], space);
 
 		if (inode->i_dquot[cnt] == NODQUOT)
 			BUG();
@@ -1162,9 +1162,9 @@
 struct dquot_operations dquot_operations = {
 	dquot_initialize,		/* mandatory */
 	dquot_drop,			/* mandatory */
-	dquot_alloc_block,
+	dquot_alloc_space,
 	dquot_alloc_inode,
-	dquot_free_block,
+	dquot_free_space,
 	dquot_free_inode,
 	dquot_transfer
 };
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/fs.h 
linux-2.5/include/linux/fs.h
--- linux-2.5-linus/include/linux/fs.h	Sat Mar  2 19:16:55 2002
+++ linux-2.5/include/linux/fs.h	Sat Mar  2 19:26:04 2002
@@ -929,9 +929,9 @@
 struct dquot_operations {
 	void (*initialize) (struct inode *, short);
 	void (*drop) (struct inode *);
-	int (*alloc_block) (struct inode *, unsigned long, char);
+	int (*alloc_space) (struct inode *, qsize_t, int);
 	int (*alloc_inode) (const struct inode *, unsigned long);
-	void (*free_block) (struct inode *, unsigned long);
+	void (*free_space) (struct inode *, qsize_t);
 	void (*free_inode) (const struct inode *, unsigned long);
 	int (*transfer) (struct inode *, struct iattr *);
 };
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sat Mar  2 19:28:17 2002
+++ linux-2.5/include/linux/quota.h	Sat Mar  2 19:26:04 2002
@@ -46,30 +46,16 @@
 #define __DQUOT_NUM_VERSION__	6*10000+5*100+1
 
 typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
+typedef __u64 qsize_t;          /* Type in which we store sizes */
 
-/*
- * Convert diskblocks to blocks and the other way around.
- */
-#define dbtob(num) (num << BLOCK_SIZE_BITS)
-#define btodb(num) (num >> BLOCK_SIZE_BITS)
-
-/*
- * Convert count of filesystem blocks to diskquota blocks, meant
- * for filesystems where i_blksize != BLOCK_SIZE
- */
-#define fs_to_dq_blocks(num, blksize) (((num) * (blksize)) / BLOCK_SIZE)
-
-/*
- * Definitions for disk quotas imposed on the average user
- * (big brother finally hits Linux).
- *
- * The following constants define the amount of time given a user
- * before the soft limits are treated as hard limits (usually resulting
- * in an allocation failure). The timer is started when the user crosses
- * their soft limit, it is reset when they go below their soft limit.
- */
-#define MAX_IQ_TIME  604800	/* (7*24*60*60) 1 week */
-#define MAX_DQ_TIME  604800	/* (7*24*60*60) 1 week */
+/* Size of blocks in which are counted size limits */
+#define QUOTABLOCK_BITS 10
+#define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
+
+/* Conversion routines from and to quota blocks */
+#define qb2kb(x) ((x) << (QUOTABLOCK_BITS-10))
+#define kb2qb(x) ((x) >> (QUOTABLOCK_BITS-10))
+#define toqb(x) (((x) + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS)
 
 #define MAXQUOTAS 2
 #define USRQUOTA  0		/* element used for user quotas */
@@ -105,7 +91,7 @@
 struct mem_dqblk {
 	__u32 dqb_bhardlimit;	/* absolute limit on disk blks alloc */
 	__u32 dqb_bsoftlimit;	/* preferred limit on disk blks */
-	__u32 dqb_curblocks;	/* current block count */
+	qsize_t dqb_curspace;	/* current used space */
 	__u32 dqb_ihardlimit;	/* absolute limit on allocated inodes */
 	__u32 dqb_isoftlimit;	/* preferred inode limit */
 	__u32 dqb_curinodes;	/* current # allocated inodes */
@@ -119,7 +105,7 @@
 struct quota_format_type;
 
 struct mem_dqinfo {
-	struct quota_format_type *dqi_format;
+	struct quota_format_type * dqi_format;
 	int dqi_flags;
 	unsigned int dqi_bgrace;
 	unsigned int dqi_igrace;
@@ -148,7 +134,7 @@
  */
 #define	dq_bhardlimit	dq_dqb.dqb_bhardlimit
 #define	dq_bsoftlimit	dq_dqb.dqb_bsoftlimit
-#define	dq_curblocks	dq_dqb.dqb_curblocks
+#define	dq_curspace	dq_dqb.dqb_curspace
 #define	dq_ihardlimit	dq_dqb.dqb_ihardlimit
 #define	dq_isoftlimit	dq_dqb.dqb_isoftlimit
 #define	dq_curinodes	dq_dqb.dqb_curinodes
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quotaops.h 
linux-2.5/include/linux/quotaops.h
--- linux-2.5-linus/include/linux/quotaops.h	Sat Mar  2 16:40:41 2002
+++ linux-2.5/include/linux/quotaops.h	Sat Mar  2 19:26:07 2002
@@ -25,10 +25,10 @@
 extern int  quota_off(struct super_block *sb, short type);
 extern int  sync_dquots(struct super_block *sb, short type);
 
-extern int  dquot_alloc_block(struct inode *inode, unsigned long number, 
char prealloc);
+extern int  dquot_alloc_space(struct inode *inode, qsize_t number, int 
prealloc);
 extern int  dquot_alloc_inode(const struct inode *inode, unsigned long 
number);
 
-extern void dquot_free_block(struct inode *inode, unsigned long number);
+extern void dquot_free_space(struct inode *inode, qsize_t number);
 extern void dquot_free_inode(const struct inode *inode, unsigned long 
number);
 
 extern int  dquot_transfer(struct inode *inode, struct iattr *iattr);
@@ -59,50 +59,50 @@
 	unlock_kernel();
 }
 
-static __inline__ int DQUOT_PREALLOC_BLOCK_NODIRTY(struct inode *inode, int 
nr)
+static __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, 
qsize_t nr)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb)) {
-		/* Number of used blocks is updated in alloc_block() */
-		if (inode->i_sb->dq_op->alloc_block(inode, fs_to_dq_blocks(nr, 
inode->i_sb->s_blocksize), 1) == NO_QUOTA) {
+		/* Used space is updated in alloc_space() */
+		if (inode->i_sb->dq_op->alloc_space(inode, nr, 1) == NO_QUOTA) {
 			unlock_kernel();
 			return 1;
 		}
 	}
 	else
-		inode->i_blocks += nr << (inode->i_sb->s_blocksize_bits - 9);
+		inode->i_blocks += nr >> 9;
 	unlock_kernel();
 	return 0;
 }
 
-static __inline__ int DQUOT_PREALLOC_BLOCK(struct inode *inode, int nr)
+static __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	int ret;
-        if (!(ret =  DQUOT_PREALLOC_BLOCK_NODIRTY(inode, nr)))
+        if (!(ret =  DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr)))
 		mark_inode_dirty(inode);
 	return ret;
 }
 
-static __inline__ int DQUOT_ALLOC_BLOCK_NODIRTY(struct inode *inode, int nr)
+static __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t 
nr)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb)) {
-		/* Number of used blocks is updated in alloc_block() */
-		if (inode->i_sb->dq_op->alloc_block(inode, fs_to_dq_blocks(nr, 
inode->i_sb->s_blocksize), 0) == NO_QUOTA) {
+		/* Used space is updated in alloc_space() */
+		if (inode->i_sb->dq_op->alloc_space(inode, nr, 0) == NO_QUOTA) {
 			unlock_kernel();
 			return 1;
 		}
 	}
 	else
-		inode->i_blocks += nr << (inode->i_sb->s_blocksize_bits - 9);
+		inode->i_blocks += nr >> 9;
 	unlock_kernel();
 	return 0;
 }
 
-static __inline__ int DQUOT_ALLOC_BLOCK(struct inode *inode, int nr)
+static __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
 	int ret;
-	if (!(ret = DQUOT_ALLOC_BLOCK_NODIRTY(inode, nr)))
+	if (!(ret = DQUOT_ALLOC_SPACE_NODIRTY(inode, nr)))
 		mark_inode_dirty(inode);
 	return ret;
 }
@@ -121,19 +121,19 @@
 	return 0;
 }
 
-static __inline__ void DQUOT_FREE_BLOCK_NODIRTY(struct inode *inode, int nr)
+static __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t 
nr)
 {
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb))
-		inode->i_sb->dq_op->free_block(inode, fs_to_dq_blocks(nr, 
inode->i_sb->s_blocksize));
+		inode->i_sb->dq_op->free_space(inode, nr);
 	else
-		inode->i_blocks -= nr << (inode->i_sb->s_blocksize_bits - 9);
+		inode->i_blocks -= nr >> 9;
 	unlock_kernel();
 }
 
-static __inline__ void DQUOT_FREE_BLOCK(struct inode *inode, int nr)
+static __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
-	DQUOT_FREE_BLOCK_NODIRTY(inode, nr);
+	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 }
 
@@ -174,48 +174,56 @@
 #define DQUOT_SYNC(sb)				do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
-extern __inline__ int DQUOT_PREALLOC_BLOCK_NODIRTY(struct inode *inode, int 
nr)
+extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, 
qsize_t nr)
 {
 	lock_kernel();
-	inode->i_blocks += nr << (inode->i_sb->s_blocksize_bits - 9);
+	inode->i_blocks += nr >> 9;
 	unlock_kernel();
 	return 0;
 }
 
-extern __inline__ int DQUOT_PREALLOC_BLOCK(struct inode *inode, int nr)
+extern __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
-	DQUOT_PREALLOC_BLOCK_NODIRTY(inode, nr);
+	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_BLOCK_NODIRTY(struct inode *inode, int nr)
+extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t 
nr)
 {
 	lock_kernel();
-	inode->i_blocks += nr << (inode->i_sb->s_blocksize_bits - 9);
+	inode->i_blocks += nr >> 9;
 	unlock_kernel();
 	return 0;
 }
 
-extern __inline__ int DQUOT_ALLOC_BLOCK(struct inode *inode, int nr)
+extern __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
 {
-	DQUOT_ALLOC_BLOCK_NODIRTY(inode, nr);
+	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 	return 0;
 }
 
-extern __inline__ void DQUOT_FREE_BLOCK_NODIRTY(struct inode *inode, int nr)
+extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t 
nr)
 {
 	lock_kernel();
-	inode->i_blocks -= nr << (inode->i_sb->s_blocksize_bits - 9);
+	inode->i_blocks -= nr >> 9;
 	unlock_kernel();
 }
 
-extern __inline__ void DQUOT_FREE_BLOCK(struct inode *inode, int nr)
+extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
 {
-	DQUOT_FREE_BLOCK_NODIRTY(inode, nr);
+	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 }	
 
 #endif /* CONFIG_QUOTA */
+
+#define DQUOT_PREALLOC_BLOCK_NODIRTY(inode, nr)	
DQUOT_PREALLOC_SPACE_NODIRTY(inode, ((qsize_t)(nr)) << 
(inode)->i_sb->s_blocksize_bits)
+#define DQUOT_PREALLOC_BLOCK(inode, nr)	DQUOT_PREALLOC_SPACE(inode, 
((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
+#define DQUOT_ALLOC_BLOCK_NODIRTY(inode, nr) 
DQUOT_ALLOC_SPACE_NODIRTY(inode, ((qsize_t)(nr)) << 
(inode)->i_sb->s_blocksize_bits)
+#define DQUOT_ALLOC_BLOCK(inode, nr) DQUOT_ALLOC_SPACE(inode, 
fs_to_dq_blocks(nr, ((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
+#define DQUOT_FREE_BLOCK_NODIRTY(inode, nr) DQUOT_FREE_SPACE_NODIRTY(inode, 
((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
+#define DQUOT_FREE_BLOCK(inode, nr) DQUOT_FREE_SPACE(inode, 
fs_to_dq_blocks(nr, ((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
+
 #endif /* _LINUX_QUOTAOPS_ */
