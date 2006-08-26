Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422932AbWHZRay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932AbWHZRay (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422939AbWHZRay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:30:54 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:30882 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1422932AbWHZRax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:30:53 -0400
Message-ID: <44F086E8.7090602@student.ltu.se>
Date: Sat, 26 Aug 2006 19:37:44 +0200
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: shaggy@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc4-mm2] fs/jfs: Conversion to generic boolean
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Conversion of booleans to: generic-boolean.patch (2006-08-23)

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Compile-tested


 inode.c        |    2 +-
 jfs_dmap.c     |   12 ++++++------
 jfs_extent.c   |   14 +++++++-------
 jfs_extent.h   |    4 ++--
 jfs_imap.c     |   26 +++++++++++++-------------
 jfs_imap.h     |    4 ++--
 jfs_metapage.h |    4 ++--
 jfs_txnmgr.c   |   16 ++++++++--------
 jfs_types.h    |    4 ----
 jfs_xtree.c    |    2 +-
 xattr.c        |   10 +++++-----
 11 files changed, 47 insertions(+), 51 deletions(-)


diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index a223cf4..a8cc169 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -227,7 +227,7 @@ #endif				/* _JFS_4K */
 #ifdef _JFS_4K
 	if ((rc = extHint(ip, lblock64 << ip->i_sb->s_blocksize_bits, &xad)))
 		goto unlock;
-	rc = extAlloc(ip, xlen, lblock64, &xad, FALSE);
+	rc = extAlloc(ip, xlen, lblock64, &xad, false);
 	if (rc)
 		goto unlock;
 
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index c161c98..f05ebb6 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -403,8 +403,8 @@ int dbFree(struct inode *ip, s64 blkno, 
  *
  * PARAMETERS:
  *      ipbmap	-  pointer to in-core inode for the block map.
- *      free	- TRUE if block range is to be freed from the persistent
- *		  map; FALSE if it is to   be allocated.
+ *      free	-  'true' if block range is to be freed from the persistent
+ *		   map; 'false' if it is to   be allocated.
  *      blkno	-  starting block number of the range.
  *      nblocks	-  number of contiguous blocks in the range.
  *      tblk	-  transaction block;
@@ -2394,7 +2394,7 @@ static int dbFreeBits(struct bmap * bmp,
  *		   requires the dmap control page to be adjusted.
  *      newval	-  the new value of the lower level dmap or dmap control
  *		   page root.
- *      alloc	-  TRUE if adjustment is due to an allocation.
+ *      alloc	-  'true' if adjustment is due to an allocation.
  *      level	-  current level of dmap control page (i.e. L0, L1, L2) to
  *		   be adjusted.
  *
@@ -3290,7 +3290,7 @@ int dbExtendFS(struct inode *ipbmap, s64
 {
 	struct jfs_sb_info *sbi = JFS_SBI(ipbmap->i_sb);
 	int nbperpage = sbi->nbperpage;
-	int i, i0 = TRUE, j, j0 = TRUE, k, n;
+	int i, i0 = true, j, j0 = true, k, n;
 	s64 newsize;
 	s64 p;
 	struct metapage *mp, *l2mp, *l1mp = NULL, *l0mp = NULL;
@@ -3398,7 +3398,7 @@ int dbExtendFS(struct inode *ipbmap, s64
 			j = (blkno & (MAXL1SIZE - 1)) >> L2MAXL0SIZE;
 			l1leaf = l1dcp->stree + CTLLEAFIND + j;
 			p = BLKTOL0(blkno, sbi->l2nbperpage);
-			j0 = FALSE;
+			j0 = false;
 		} else {
 			/* assign/init L1 page */
 			l1mp = get_metapage(ipbmap, p, PSIZE, 0);
@@ -3432,7 +3432,7 @@ int dbExtendFS(struct inode *ipbmap, s64
 				l0leaf = l0dcp->stree + CTLLEAFIND + i;
 				p = BLKTODMAP(blkno,
 					      sbi->l2nbperpage);
-				i0 = FALSE;
+				i0 = false;
 			} else {
 				/* assign/init L0 page */
 				l0mp = get_metapage(ipbmap, p, PSIZE, 0);
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index 4d52593..30893a4 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -74,7 +74,7 @@ #define DPS1(a)         (printk("  %s  "
  *		  extent that is used as an allocation hint if the
  *		  xaddr of the xad is non-zero.  on successful exit,
  *		  the xad describes the newly allocated extent.
- *	abnr	- boolean_t indicating whether the newly allocated extent
+ *	abnr	- bool indicating whether the newly allocated extent
  *		  should be marked as allocated but not recorded.
  *
  * RETURN VALUES:
@@ -83,7 +83,7 @@ #define DPS1(a)         (printk("  %s  "
  *      -ENOSPC	- insufficient disk resources.
  */
 int
-extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, boolean_t abnr)
+extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, bool abnr)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
 	s64 nxlen, nxaddr, xoff, hint, xaddr = 0;
@@ -117,7 +117,7 @@ extAlloc(struct inode *ip, s64 xlen, s64
 		 * following the hint extent.
 		 */
 		if (offsetXAD(xp) + nxlen == xoff &&
-		    abnr == ((xp->flag & XAD_NOTRECORDED) ? TRUE : FALSE))
+		    abnr == ((xp->flag & XAD_NOTRECORDED) ? true : false))
 			xaddr = hint + nxlen;
 
 		/* adjust the hint to the last block of the extent */
@@ -148,7 +148,7 @@ extAlloc(struct inode *ip, s64 xlen, s64
 	}
 
 	/* determine the value of the extent flag */
-	xflag = (abnr == TRUE) ? XAD_NOTRECORDED : 0;
+	xflag = abnr ? XAD_NOTRECORDED : 0;
 
 	/* if we can extend the hint extent to cover the current request, 
 	 * extend it.  otherwise, insert a new extent to
@@ -203,7 +203,7 @@ #ifdef _NOTYET
  *	xlen	- request size of the resulting extent.
  *	xp	- pointer to an xad. on successful exit, the xad
  *		  describes the newly allocated extent.
- *	abnr	- boolean_t indicating whether the newly allocated extent
+ *	abnr	- bool indicating whether the newly allocated extent
  *		  should be marked as allocated but not recorded.
  *
  * RETURN VALUES:
@@ -211,7 +211,7 @@ #ifdef _NOTYET
  *      -EIO	- i/o error.
  *      -ENOSPC	- insufficient disk resources.
  */
-int extRealloc(struct inode *ip, s64 nxlen, xad_t * xp, boolean_t abnr)
+int extRealloc(struct inode *ip, s64 nxlen, xad_t * xp, bool abnr)
 {
 	struct super_block *sb = ip->i_sb;
 	s64 xaddr, xlen, nxaddr, delta, xoff;
@@ -476,7 +476,7 @@ int extFill(struct inode *ip, xad_t * xp
 	XADaddress(xp, 0);
 
 	/* allocate an extent to fill the hole */
-	if ((rc = extAlloc(ip, nbperpage, blkno, xp, FALSE)))
+	if ((rc = extAlloc(ip, nbperpage, blkno, xp, false)))
 		return (rc);
 
 	assert(lengthPXD(xp) == nbperpage);
diff --git a/fs/jfs/jfs_extent.h b/fs/jfs/jfs_extent.h
index e80fc7c..3a7f3f2 100644
--- a/fs/jfs/jfs_extent.h
+++ b/fs/jfs/jfs_extent.h
@@ -22,10 +22,10 @@ #define _H_JFS_EXTENT
 #define	INOHINT(ip)	\
 	(addressPXD(&(JFS_IP(ip)->ixpxd)) + lengthPXD(&(JFS_IP(ip)->ixpxd)) - 1)
 
-extern int	extAlloc(struct inode *, s64, s64, xad_t *, boolean_t);
+extern int	extAlloc(struct inode *, s64, s64, xad_t *, bool);
 extern int	extFill(struct inode *, xad_t *);
 extern int	extHint(struct inode *, s64, xad_t *);
-extern int	extRealloc(struct inode *, s64, xad_t *, boolean_t);
+extern int	extRealloc(struct inode *, s64, xad_t *, bool);
 extern int	extRecord(struct inode *, xad_t *);
 
 #endif	/* _H_JFS_EXTENT */
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index ccbe60a..47f0123 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -78,8 +78,8 @@ #define AG_UNLOCK(imap,agno)		mutex_unlo
 /*
  * forward references
  */
-static int diAllocAG(struct inomap *, int, boolean_t, struct inode *);
-static int diAllocAny(struct inomap *, int, boolean_t, struct inode *);
+static int diAllocAG(struct inomap *, int, bool, struct inode *);
+static int diAllocAny(struct inomap *, int, bool, struct inode *);
 static int diAllocBit(struct inomap *, struct iag *, int);
 static int diAllocExt(struct inomap *, int, struct inode *);
 static int diAllocIno(struct inomap *, int, struct inode *);
@@ -1345,7 +1345,7 @@ diInitInode(struct inode *ip, int iagno,
  *
  * PARAMETERS:
  *      pip  	- pointer to incore inode for the parent inode.
- *      dir  	- TRUE if the new disk inode is for a directory.
+ *      dir  	- 'true' if the new disk inode is for a directory.
  *      ip  	- pointer to a new inode
  *
  * RETURN VALUES:
@@ -1353,7 +1353,7 @@ diInitInode(struct inode *ip, int iagno,
  *      -ENOSPC	- insufficient disk resources.
  *      -EIO  	- i/o error.
  */
-int diAlloc(struct inode *pip, boolean_t dir, struct inode *ip)
+int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 {
 	int rc, ino, iagno, addext, extno, bitno, sword;
 	int nwords, rem, i, agno;
@@ -1375,7 +1375,7 @@ int diAlloc(struct inode *pip, boolean_t
 	/* for a directory, the allocation policy is to start 
 	 * at the ag level using the preferred ag.
 	 */
-	if (dir == TRUE) {
+	if (dir) {
 		agno = dbNextAG(JFS_SBI(pip->i_sb)->ipbmap);
 		AG_LOCK(imap, agno);
 		goto tryag;
@@ -1651,7 +1651,7 @@ int diAlloc(struct inode *pip, boolean_t
  * PARAMETERS:
  *      imap  	- pointer to inode map control structure.
  *      agno  	- allocation group to allocate from.
- *      dir  	- TRUE if the new disk inode is for a directory.
+ *      dir  	- 'true' if the new disk inode is for a directory.
  *      ip  	- pointer to the new inode to be filled in on successful return
  *		  with the disk inode number allocated, its extent address
  *		  and the start of the ag.
@@ -1662,7 +1662,7 @@ int diAlloc(struct inode *pip, boolean_t
  *      -EIO  	- i/o error.
  */
 static int
-diAllocAG(struct inomap * imap, int agno, boolean_t dir, struct inode *ip)
+diAllocAG(struct inomap * imap, int agno, bool dir, struct inode *ip)
 {
 	int rc, addext, numfree, numinos;
 
@@ -1682,7 +1682,7 @@ diAllocAG(struct inomap * imap, int agno
 	 * if there are a small number of free inodes or number of free
 	 * inodes is a small percentage of the number of backed inodes.
 	 */
-	if (dir == TRUE)
+	if (dir)
 		addext = (numfree < 64 ||
 			  (numfree < 256
 			   && ((numfree * 100) / numinos) <= 20));
@@ -1721,7 +1721,7 @@ diAllocAG(struct inomap * imap, int agno
  * PARAMETERS:
  *      imap  	- pointer to inode map control structure.
  *      agno  	- primary allocation group (to avoid).
- *      dir  	- TRUE if the new disk inode is for a directory.
+ *      dir  	- 'true' if the new disk inode is for a directory.
  *      ip  	- pointer to a new inode to be filled in on successful return
  *		  with the disk inode number allocated, its extent address
  *		  and the start of the ag.
@@ -1732,7 +1732,7 @@ diAllocAG(struct inomap * imap, int agno
  *      -EIO  	- i/o error.
  */
 static int
-diAllocAny(struct inomap * imap, int agno, boolean_t dir, struct inode *ip)
+diAllocAny(struct inomap * imap, int agno, bool dir, struct inode *ip)
 {
 	int ag, rc;
 	int maxag = JFS_SBI(imap->im_ipimap->i_sb)->bmap->db_maxag;
@@ -2749,7 +2749,7 @@ static int diFindFree(u32 word, int star
  * PARAMETERS:
  *	ipimap	- Incore inode map inode
  *	inum	- Number of inode to mark in permanent map
- *	is_free	- If TRUE indicates inode should be marked freed, otherwise
+ *	is_free	- If 'true' indicates inode should be marked freed, otherwise
  *		  indicates inode should be marked allocated.
  *
  * RETURN VALUES: 
@@ -2757,7 +2757,7 @@ static int diFindFree(u32 word, int star
  */
 int
 diUpdatePMap(struct inode *ipimap,
-	     unsigned long inum, boolean_t is_free, struct tblock * tblk)
+	     unsigned long inum, bool is_free, struct tblock * tblk)
 {
 	int rc;
 	struct iag *iagp;
@@ -2796,7 +2796,7 @@ diUpdatePMap(struct inode *ipimap,
 	/* 
 	 * mark the inode free in persistent map:
 	 */
-	if (is_free == TRUE) {
+	if (is_free) {
 		/* The inode should have been allocated both in working
 		 * map and in persistent map;
 		 * the inode will be freed from working map at the release
diff --git a/fs/jfs/jfs_imap.h b/fs/jfs/jfs_imap.h
index 6e24465..e3b7db4 100644
--- a/fs/jfs/jfs_imap.h
+++ b/fs/jfs/jfs_imap.h
@@ -159,11 +159,11 @@ #define	im_diskblock	im_imap.in_diskbloc
 #define	im_maxag	im_imap.in_maxag
 
 extern int diFree(struct inode *);
-extern int diAlloc(struct inode *, boolean_t, struct inode *);
+extern int diAlloc(struct inode *, bool, struct inode *);
 extern int diSync(struct inode *);
 /* external references */
 extern int diUpdatePMap(struct inode *ipimap, unsigned long inum,
-			boolean_t is_free, struct tblock * tblk);
+			bool is_free, struct tblock * tblk);
 extern int diExtendFS(struct inode *ipimap, struct inode *ipbmap);
 extern int diMount(struct inode *);
 extern int diUnmount(struct inode *, int);
diff --git a/fs/jfs/jfs_metapage.h b/fs/jfs/jfs_metapage.h
index d17a329..01a5a45 100644
--- a/fs/jfs/jfs_metapage.h
+++ b/fs/jfs/jfs_metapage.h
@@ -65,10 +65,10 @@ extern struct metapage *__get_metapage(s
 				  int absolute, unsigned long new);
 
 #define read_metapage(inode, lblock, size, absolute)\
-	 __get_metapage(inode, lblock, size, absolute, FALSE)
+	 __get_metapage(inode, lblock, size, absolute, false)
 
 #define get_metapage(inode, lblock, size, absolute)\
-	 __get_metapage(inode, lblock, size, absolute, TRUE)
+	 __get_metapage(inode, lblock, size, absolute, true)
 
 extern void release_metapage(struct metapage *);
 extern void grab_metapage(struct metapage *);
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index efbb586..4c51933 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2393,7 +2393,7 @@ static void txUpdateMap(struct tblock * 
 	 * unlock mapper/write lock
 	 */
 	if (tblk->xflag & COMMIT_CREATE) {
-		diUpdatePMap(ipimap, tblk->ino, FALSE, tblk);
+		diUpdatePMap(ipimap, tblk->ino, false, tblk);
 		/* update persistent block allocation map
 		 * for the allocation of inode extent;
 		 */
@@ -2403,7 +2403,7 @@ static void txUpdateMap(struct tblock * 
 		txAllocPMap(ipimap, (struct maplock *) & pxdlock, tblk);
 	} else if (tblk->xflag & COMMIT_DELETE) {
 		ip = tblk->u.ip;
-		diUpdatePMap(ipimap, ip->i_ino, TRUE, tblk);
+		diUpdatePMap(ipimap, ip->i_ino, true, tblk);
 		iput(ip);
 	}
 }
@@ -2451,7 +2451,7 @@ static void txAllocPMap(struct inode *ip
 			if (xad->flag & (XAD_NEW | XAD_EXTENDED)) {
 				xaddr = addressXAD(xad);
 				xlen = lengthXAD(xad);
-				dbUpdatePMap(ipbmap, FALSE, xaddr,
+				dbUpdatePMap(ipbmap, false, xaddr,
 					     (s64) xlen, tblk);
 				xad->flag &= ~(XAD_NEW | XAD_EXTENDED);
 				jfs_info("allocPMap: xaddr:0x%lx xlen:%d",
@@ -2462,7 +2462,7 @@ static void txAllocPMap(struct inode *ip
 		pxdlock = (struct pxd_lock *) maplock;
 		xaddr = addressPXD(&pxdlock->pxd);
 		xlen = lengthPXD(&pxdlock->pxd);
-		dbUpdatePMap(ipbmap, FALSE, xaddr, (s64) xlen, tblk);
+		dbUpdatePMap(ipbmap, false, xaddr, (s64) xlen, tblk);
 		jfs_info("allocPMap: xaddr:0x%lx xlen:%d", (ulong) xaddr, xlen);
 	} else {		/* (maplock->flag & mlckALLOCPXDLIST) */
 
@@ -2471,7 +2471,7 @@ static void txAllocPMap(struct inode *ip
 		for (n = 0; n < pxdlistlock->count; n++, pxd++) {
 			xaddr = addressPXD(pxd);
 			xlen = lengthPXD(pxd);
-			dbUpdatePMap(ipbmap, FALSE, xaddr, (s64) xlen,
+			dbUpdatePMap(ipbmap, false, xaddr, (s64) xlen,
 				     tblk);
 			jfs_info("allocPMap: xaddr:0x%lx xlen:%d",
 				 (ulong) xaddr, xlen);
@@ -2513,7 +2513,7 @@ void txFreeMap(struct inode *ip,
 				if (!(xad->flag & XAD_NEW)) {
 					xaddr = addressXAD(xad);
 					xlen = lengthXAD(xad);
-					dbUpdatePMap(ipbmap, TRUE, xaddr,
+					dbUpdatePMap(ipbmap, true, xaddr,
 						     (s64) xlen, tblk);
 					jfs_info("freePMap: xaddr:0x%lx "
 						 "xlen:%d",
@@ -2524,7 +2524,7 @@ void txFreeMap(struct inode *ip,
 			pxdlock = (struct pxd_lock *) maplock;
 			xaddr = addressPXD(&pxdlock->pxd);
 			xlen = lengthPXD(&pxdlock->pxd);
-			dbUpdatePMap(ipbmap, TRUE, xaddr, (s64) xlen,
+			dbUpdatePMap(ipbmap, true, xaddr, (s64) xlen,
 				     tblk);
 			jfs_info("freePMap: xaddr:0x%lx xlen:%d",
 				 (ulong) xaddr, xlen);
@@ -2535,7 +2535,7 @@ void txFreeMap(struct inode *ip,
 			for (n = 0; n < pxdlistlock->count; n++, pxd++) {
 				xaddr = addressPXD(pxd);
 				xlen = lengthPXD(pxd);
-				dbUpdatePMap(ipbmap, TRUE, xaddr,
+				dbUpdatePMap(ipbmap, true, xaddr,
 					     (s64) xlen, tblk);
 				jfs_info("freePMap: xaddr:0x%lx xlen:%d",
 					 (ulong) xaddr, xlen);
diff --git a/fs/jfs/jfs_types.h b/fs/jfs/jfs_types.h
index 5bfad39..09b2529 100644
--- a/fs/jfs/jfs_types.h
+++ b/fs/jfs/jfs_types.h
@@ -57,10 +57,6 @@ #define LEFTMOSTONE	0x80000000
 #define	HIGHORDER	0x80000000u	/* high order bit on            */
 #define	ONES		0xffffffffu	/* all bit on                   */
 
-typedef int boolean_t;
-#define TRUE 1
-#define FALSE 0
-
 /*
  *	logical xd (lxd)
  */
diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index e72f4eb..c92307d 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -2964,7 +2964,7 @@ xtRelocate(tid_t tid, struct inode * ip,
 			cmSetXD(ip, cp, pno, dxaddr, nblks);
 
 			/* release the cbuf, mark it as modified */
-			cmPut(cp, TRUE);
+			cmPut(cp, true);
 
 			dxaddr += nblks;
 			sxaddr += nblks;
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 9bc5b7c..7a10e19 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -97,26 +97,26 @@ static inline int is_os2_xattr(struct jf
 	 */
 	if ((ea->namelen >= XATTR_SYSTEM_PREFIX_LEN) &&
 	    !strncmp(ea->name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
-		return FALSE;
+		return false;
 	/*
 	 * Check for "user."
 	 */
 	if ((ea->namelen >= XATTR_USER_PREFIX_LEN) &&
 	    !strncmp(ea->name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
-		return FALSE;
+		return false;
 	/*
 	 * Check for "security."
 	 */
 	if ((ea->namelen >= XATTR_SECURITY_PREFIX_LEN) &&
 	    !strncmp(ea->name, XATTR_SECURITY_PREFIX,
 		     XATTR_SECURITY_PREFIX_LEN))
-		return FALSE;
+		return false;
 	/*
 	 * Check for "trusted."
 	 */
 	if ((ea->namelen >= XATTR_TRUSTED_PREFIX_LEN) &&
 	    !strncmp(ea->name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN))
-		return FALSE;
+		return false;
 	/*
 	 * Add any other valid namespace prefixes here
 	 */
@@ -124,7 +124,7 @@ static inline int is_os2_xattr(struct jf
 	/*
 	 * We assume it's OS/2's flat namespace
 	 */
-	return TRUE;
+	return true;
 }
 
 static inline int name_size(struct jfs_ea *ea)


