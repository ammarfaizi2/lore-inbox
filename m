Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWANP26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWANP26 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWANP26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:28:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:47517 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964770AbWANP25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:28:57 -0500
Date: Sat, 14 Jan 2006 16:29:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       shaggy@austin.ibm.com
Subject: [patch 2.6.15-mm4] sem2mutex: JFS
Message-ID: <20060114152901.GA27921@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

semaphore to mutex conversion.

the conversion was generated via scripts, and the result was validated
automatically via a script as well.

build and boot tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 fs/jfs/acl.c        |    4 +-
 fs/jfs/inode.c      |   14 +++----
 fs/jfs/jfs_dmap.c   |    6 +--
 fs/jfs/jfs_dmap.h   |    2 -
 fs/jfs/jfs_extent.c |   20 +++++-----
 fs/jfs/jfs_imap.c   |   22 +++++------
 fs/jfs/jfs_imap.h   |    4 +-
 fs/jfs/jfs_incore.h |    5 +-
 fs/jfs/jfs_lock.h   |    1 
 fs/jfs/jfs_logmgr.c |    6 +--
 fs/jfs/jfs_logmgr.h |    2 -
 fs/jfs/jfs_txnmgr.c |   10 ++---
 fs/jfs/namei.c      |   98 ++++++++++++++++++++++++++--------------------------
 fs/jfs/super.c      |    2 -
 fs/jfs/xattr.c      |    8 ++--
 15 files changed, 103 insertions(+), 101 deletions(-)

Index: linux/fs/jfs/acl.c
===================================================================
--- linux.orig/fs/jfs/acl.c
+++ linux/fs/jfs/acl.c
@@ -207,12 +207,12 @@ static int jfs_acl_chmod(struct inode *i
 	rc = posix_acl_chmod_masq(clone, inode->i_mode);
 	if (!rc) {
 		tid_t tid = txBegin(inode->i_sb, 0);
-		down(&JFS_IP(inode)->commit_sem);
+		mutex_lock(&JFS_IP(inode)->commit_mutex);
 		rc = jfs_set_acl(tid, inode, ACL_TYPE_ACCESS, clone);
 		if (!rc)
 			rc = txCommit(tid, 1, &inode, 0);
 		txEnd(tid);
-		up(&JFS_IP(inode)->commit_sem);
+		mutex_unlock(&JFS_IP(inode)->commit_mutex);
 	}
 
 	posix_acl_release(clone);
Index: linux/fs/jfs/inode.c
===================================================================
--- linux.orig/fs/jfs/inode.c
+++ linux/fs/jfs/inode.c
@@ -89,16 +89,16 @@ int jfs_commit_inode(struct inode *inode
 	}
 
 	tid = txBegin(inode->i_sb, COMMIT_INODE);
-	down(&JFS_IP(inode)->commit_sem);
+	mutex_lock(&JFS_IP(inode)->commit_mutex);
 
 	/*
-	 * Retest inode state after taking commit_sem
+	 * Retest inode state after taking commit_mutex
 	 */
 	if (inode->i_nlink && test_cflag(COMMIT_Dirty, inode))
 		rc = txCommit(tid, 1, &inode, wait ? COMMIT_SYNC : 0);
 
 	txEnd(tid);
-	up(&JFS_IP(inode)->commit_sem);
+	mutex_unlock(&JFS_IP(inode)->commit_mutex);
 	return rc;
 }
 
@@ -335,18 +335,18 @@ void jfs_truncate_nolock(struct inode *i
 		tid = txBegin(ip->i_sb, 0);
 
 		/*
-		 * The commit_sem cannot be taken before txBegin.
+		 * The commit_mutex cannot be taken before txBegin.
 		 * txBegin may block and there is a chance the inode
 		 * could be marked dirty and need to be committed
 		 * before txBegin unblocks
 		 */
-		down(&JFS_IP(ip)->commit_sem);
+		mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 		newsize = xtTruncate(tid, ip, length,
 				     COMMIT_TRUNCATE | COMMIT_PWMAP);
 		if (newsize < 0) {
 			txEnd(tid);
-			up(&JFS_IP(ip)->commit_sem);
+			mutex_unlock(&JFS_IP(ip)->commit_mutex);
 			break;
 		}
 
@@ -355,7 +355,7 @@ void jfs_truncate_nolock(struct inode *i
 
 		txCommit(tid, 1, &ip, 0);
 		txEnd(tid);
-		up(&JFS_IP(ip)->commit_sem);
+		mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	} while (newsize > length);	/* Truncate isn't always atomic */
 }
 
Index: linux/fs/jfs/jfs_dmap.c
===================================================================
--- linux.orig/fs/jfs/jfs_dmap.c
+++ linux/fs/jfs/jfs_dmap.c
@@ -64,9 +64,9 @@
  *	to the persistent bitmaps in dmaps) is guarded by (busy) buffers.
  */
 
-#define BMAP_LOCK_INIT(bmp)	init_MUTEX(&bmp->db_bmaplock)
-#define BMAP_LOCK(bmp)		down(&bmp->db_bmaplock)
-#define BMAP_UNLOCK(bmp)	up(&bmp->db_bmaplock)
+#define BMAP_LOCK_INIT(bmp)	mutex_init(&bmp->db_bmaplock)
+#define BMAP_LOCK(bmp)		mutex_lock(&bmp->db_bmaplock)
+#define BMAP_UNLOCK(bmp)	mutex_unlock(&bmp->db_bmaplock)
 
 /*
  * forward references
Index: linux/fs/jfs/jfs_dmap.h
===================================================================
--- linux.orig/fs/jfs/jfs_dmap.h
+++ linux/fs/jfs/jfs_dmap.h
@@ -243,7 +243,7 @@ struct dbmap {
 struct bmap {
 	struct dbmap db_bmap;		/* on-disk aggregate map descriptor */
 	struct inode *db_ipbmap;	/* ptr to aggregate map incore inode */
-	struct semaphore db_bmaplock;	/* aggregate map lock */
+	struct mutex db_bmaplock;	/* aggregate map lock */
 	atomic_t db_active[MAXAG];	/* count of active, open files in AG */
 	u32 *db_DBmap;
 };
Index: linux/fs/jfs/jfs_extent.c
===================================================================
--- linux.orig/fs/jfs/jfs_extent.c
+++ linux/fs/jfs/jfs_extent.c
@@ -94,7 +94,7 @@ extAlloc(struct inode *ip, s64 xlen, s64
 	txBeginAnon(ip->i_sb);
 
 	/* Avoid race with jfs_commit_inode() */
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	/* validate extent length */
 	if (xlen > MAXXLEN)
@@ -136,14 +136,14 @@ extAlloc(struct inode *ip, s64 xlen, s64
 	 */
 	nxlen = xlen;
 	if ((rc = extBalloc(ip, hint ? hint : INOHINT(ip), &nxlen, &nxaddr))) {
-		up(&JFS_IP(ip)->commit_sem);
+		mutex_unlock(&JFS_IP(ip)->commit_mutex);
 		return (rc);
 	}
 
 	/* Allocate blocks to quota. */
 	if (DQUOT_ALLOC_BLOCK(ip, nxlen)) {
 		dbFree(ip, nxaddr, (s64) nxlen);
-		up(&JFS_IP(ip)->commit_sem);
+		mutex_unlock(&JFS_IP(ip)->commit_mutex);
 		return -EDQUOT;
 	}
 
@@ -165,7 +165,7 @@ extAlloc(struct inode *ip, s64 xlen, s64
 	if (rc) {
 		dbFree(ip, nxaddr, nxlen);
 		DQUOT_FREE_BLOCK(ip, nxlen);
-		up(&JFS_IP(ip)->commit_sem);
+		mutex_unlock(&JFS_IP(ip)->commit_mutex);
 		return (rc);
 	}
 
@@ -177,7 +177,7 @@ extAlloc(struct inode *ip, s64 xlen, s64
 
 	mark_inode_dirty(ip);
 
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	/*
 	 * COMMIT_SyncList flags an anonymous tlock on page that is on
 	 * sync list.
@@ -222,7 +222,7 @@ int extRealloc(struct inode *ip, s64 nxl
 	/* This blocks if we are low on resources */
 	txBeginAnon(ip->i_sb);
 
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 	/* validate extent length */
 	if (nxlen > MAXXLEN)
 		nxlen = MAXXLEN;
@@ -258,7 +258,7 @@ int extRealloc(struct inode *ip, s64 nxl
 	/* Allocat blocks to quota. */
 	if (DQUOT_ALLOC_BLOCK(ip, nxlen)) {
 		dbFree(ip, nxaddr, (s64) nxlen);
-		up(&JFS_IP(ip)->commit_sem);
+		mutex_unlock(&JFS_IP(ip)->commit_mutex);
 		return -EDQUOT;
 	}
 
@@ -338,7 +338,7 @@ int extRealloc(struct inode *ip, s64 nxl
 
 	mark_inode_dirty(ip);
 exit:
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	return (rc);
 }
 #endif			/* _NOTYET */
@@ -439,12 +439,12 @@ int extRecord(struct inode *ip, xad_t * 
 
 	txBeginAnon(ip->i_sb);
 
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	/* update the extent */
 	rc = xtUpdate(0, ip, xp);
 
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	return rc;
 }
 
Index: linux/fs/jfs/jfs_imap.c
===================================================================
--- linux.orig/fs/jfs/jfs_imap.c
+++ linux/fs/jfs/jfs_imap.c
@@ -66,14 +66,14 @@ static HLIST_HEAD(aggregate_hash);
  * imap locks
  */
 /* iag free list lock */
-#define IAGFREE_LOCK_INIT(imap)		init_MUTEX(&imap->im_freelock)
-#define IAGFREE_LOCK(imap)		down(&imap->im_freelock)
-#define IAGFREE_UNLOCK(imap)		up(&imap->im_freelock)
+#define IAGFREE_LOCK_INIT(imap)		mutex_init(&imap->im_freelock)
+#define IAGFREE_LOCK(imap)		mutex_lock(&imap->im_freelock)
+#define IAGFREE_UNLOCK(imap)		mutex_unlock(&imap->im_freelock)
 
 /* per ag iag list locks */
-#define AG_LOCK_INIT(imap,index)	init_MUTEX(&(imap->im_aglock[index]))
-#define AG_LOCK(imap,agno)		down(&imap->im_aglock[agno])
-#define AG_UNLOCK(imap,agno)		up(&imap->im_aglock[agno])
+#define AG_LOCK_INIT(imap,index)	mutex_init(&(imap->im_aglock[index]))
+#define AG_LOCK(imap,agno)		mutex_lock(&imap->im_aglock[agno])
+#define AG_UNLOCK(imap,agno)		mutex_unlock(&imap->im_aglock[agno])
 
 /*
  * forward references
@@ -1261,7 +1261,7 @@ int diFree(struct inode *ip)
 	 * to be freed by the transaction;  
 	 */
 	tid = txBegin(ipimap->i_sb, COMMIT_FORCE);
-	down(&JFS_IP(ipimap)->commit_sem);
+	mutex_lock(&JFS_IP(ipimap)->commit_mutex);
 
 	/* acquire tlock of the iag page of the freed ixad 
 	 * to force the page NOHOMEOK (even though no data is
@@ -1294,7 +1294,7 @@ int diFree(struct inode *ip)
 	rc = txCommit(tid, 1, &iplist[0], COMMIT_FORCE);
 
 	txEnd(tid);
-	up(&JFS_IP(ipimap)->commit_sem);
+	mutex_unlock(&JFS_IP(ipimap)->commit_mutex);
 
 	/* unlock the AG inode map information */
 	AG_UNLOCK(imap, agno);
@@ -2554,13 +2554,13 @@ diNewIAG(struct inomap * imap, int *iagn
 		 * addressing structure pointing to the new iag page;
 		 */
 		tid = txBegin(sb, COMMIT_FORCE);
-		down(&JFS_IP(ipimap)->commit_sem);
+		mutex_lock(&JFS_IP(ipimap)->commit_mutex);
 
 		/* update the inode map addressing structure to point to it */
 		if ((rc =
 		     xtInsert(tid, ipimap, 0, blkno, xlen, &xaddr, 0))) {
 			txEnd(tid);
-			up(&JFS_IP(ipimap)->commit_sem);
+			mutex_unlock(&JFS_IP(ipimap)->commit_mutex);
 			/* Free the blocks allocated for the iag since it was
 			 * not successfully added to the inode map
 			 */
@@ -2626,7 +2626,7 @@ diNewIAG(struct inomap * imap, int *iagn
 		rc = txCommit(tid, 1, &iplist[0], COMMIT_FORCE);
 
 		txEnd(tid);
-		up(&JFS_IP(ipimap)->commit_sem);
+		mutex_unlock(&JFS_IP(ipimap)->commit_mutex);
 
 		duplicateIXtree(sb, blkno, xlen, &xaddr);
 
Index: linux/fs/jfs/jfs_imap.h
===================================================================
--- linux.orig/fs/jfs/jfs_imap.h
+++ linux/fs/jfs/jfs_imap.h
@@ -140,8 +140,8 @@ struct dinomap {
 struct inomap {
 	struct dinomap im_imap;		/* 4096: inode allocation control */
 	struct inode *im_ipimap;	/* 4: ptr to inode for imap   */
-	struct semaphore im_freelock;	/* 4: iag free list lock      */
-	struct semaphore im_aglock[MAXAG];	/* 512: per AG locks          */
+	struct mutex im_freelock;	/* 4: iag free list lock      */
+	struct mutex im_aglock[MAXAG];	/* 512: per AG locks          */
 	u32 *im_DBGdimap;
 	atomic_t im_numinos;	/* num of backed inodes */
 	atomic_t im_numfree;	/* num of free backed inodes */
Index: linux/fs/jfs/jfs_incore.h
===================================================================
--- linux.orig/fs/jfs/jfs_incore.h
+++ linux/fs/jfs/jfs_incore.h
@@ -19,6 +19,7 @@
 #ifndef _H_JFS_INCORE
 #define _H_JFS_INCORE
 
+#include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
@@ -62,12 +63,12 @@ struct jfs_inode_info {
 	 */
 	struct rw_semaphore rdwrlock;
 	/*
-	 * commit_sem serializes transaction processing on an inode.
+	 * commit_mutex serializes transaction processing on an inode.
 	 * It must be taken after beginning a transaction (txBegin), since
 	 * dirty inodes may be committed while a new transaction on the
 	 * inode is blocked in txBegin or TxBeginAnon
 	 */
-	struct semaphore commit_sem;
+	struct mutex commit_mutex;
 	/* xattr_sem allows us to access the xattrs without taking i_mutex */
 	struct rw_semaphore xattr_sem;
 	lid_t	xtlid;		/* lid of xtree lock on directory */
Index: linux/fs/jfs/jfs_lock.h
===================================================================
--- linux.orig/fs/jfs/jfs_lock.h
+++ linux/fs/jfs/jfs_lock.h
@@ -20,6 +20,7 @@
 #define _H_JFS_LOCK
 
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/sched.h>
 
 /*
Index: linux/fs/jfs/jfs_logmgr.c
===================================================================
--- linux.orig/fs/jfs/jfs_logmgr.c
+++ linux/fs/jfs/jfs_logmgr.c
@@ -88,9 +88,9 @@ DECLARE_WAIT_QUEUE_HEAD(jfs_IO_thread_wa
 /*
  *	log read/write serialization (per log)
  */
-#define LOG_LOCK_INIT(log)	init_MUTEX(&(log)->loglock)
-#define LOG_LOCK(log)		down(&((log)->loglock))
-#define LOG_UNLOCK(log)		up(&((log)->loglock))
+#define LOG_LOCK_INIT(log)	mutex_init(&(log)->loglock)
+#define LOG_LOCK(log)		mutex_lock(&((log)->loglock))
+#define LOG_UNLOCK(log)		mutex_unlock(&((log)->loglock))
 
 
 /*
Index: linux/fs/jfs/jfs_logmgr.h
===================================================================
--- linux.orig/fs/jfs/jfs_logmgr.h
+++ linux/fs/jfs/jfs_logmgr.h
@@ -389,7 +389,7 @@ struct jfs_log {
 	int eor;		/* 4: eor of last record in eol page */
 	struct lbuf *bp;	/* 4: current log page buffer */
 
-	struct semaphore loglock;	/* 4: log write serialization lock */
+	struct mutex loglock;	/* 4: log write serialization lock */
 
 	/* syncpt */
 	int nextsync;		/* 4: bytes to write before next syncpt */
Index: linux/fs/jfs/jfs_txnmgr.c
===================================================================
--- linux.orig/fs/jfs/jfs_txnmgr.c
+++ linux/fs/jfs/jfs_txnmgr.c
@@ -2876,10 +2876,10 @@ restart:
 		 */
 		TXN_UNLOCK();
 		tid = txBegin(ip->i_sb, COMMIT_INODE | COMMIT_FORCE);
-		down(&jfs_ip->commit_sem);
+		mutex_lock(&jfs_ip->commit_mutex);
 		txCommit(tid, 1, &ip, 0);
 		txEnd(tid);
-		up(&jfs_ip->commit_sem);
+		mutex_unlock(&jfs_ip->commit_mutex);
 		/*
 		 * Just to be safe.  I don't know how
 		 * long we can run without blocking
@@ -2952,7 +2952,7 @@ int jfs_sync(void *arg)
 				 * Inode is being freed
 				 */
 				list_del_init(&jfs_ip->anon_inode_list);
-			} else if (! down_trylock(&jfs_ip->commit_sem)) {
+			} else if (! !mutex_trylock(&jfs_ip->commit_mutex)) {
 				/*
 				 * inode will be removed from anonymous list
 				 * when it is committed
@@ -2961,7 +2961,7 @@ int jfs_sync(void *arg)
 				tid = txBegin(ip->i_sb, COMMIT_INODE);
 				rc = txCommit(tid, 1, &ip, 0);
 				txEnd(tid);
-				up(&jfs_ip->commit_sem);
+				mutex_unlock(&jfs_ip->commit_mutex);
 
 				iput(ip);
 				/*
@@ -2971,7 +2971,7 @@ int jfs_sync(void *arg)
 				cond_resched();
 				TXN_LOCK();
 			} else {
-				/* We can't get the commit semaphore.  It may
+				/* We can't get the commit mutex.  It may
 				 * be held by a thread waiting for tlock's
 				 * so let's not block here.  Save it to
 				 * put back on the anon_list.
Index: linux/fs/jfs/namei.c
===================================================================
--- linux.orig/fs/jfs/namei.c
+++ linux/fs/jfs/namei.c
@@ -104,8 +104,8 @@ static int jfs_create(struct inode *dip,
 
 	tid = txBegin(dip->i_sb, 0);
 
-	down(&JFS_IP(dip)->commit_sem);
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(dip)->commit_mutex);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	rc = jfs_init_acl(tid, ip, dip);
 	if (rc)
@@ -165,8 +165,8 @@ static int jfs_create(struct inode *dip,
 
       out3:
 	txEnd(tid);
-	up(&JFS_IP(dip)->commit_sem);
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	if (rc) {
 		free_ea_wmap(ip);
 		ip->i_nlink = 0;
@@ -238,8 +238,8 @@ static int jfs_mkdir(struct inode *dip, 
 
 	tid = txBegin(dip->i_sb, 0);
 
-	down(&JFS_IP(dip)->commit_sem);
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(dip)->commit_mutex);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	rc = jfs_init_acl(tid, ip, dip);
 	if (rc)
@@ -300,8 +300,8 @@ static int jfs_mkdir(struct inode *dip, 
 
       out3:
 	txEnd(tid);
-	up(&JFS_IP(dip)->commit_sem);
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	if (rc) {
 		free_ea_wmap(ip);
 		ip->i_nlink = 0;
@@ -365,8 +365,8 @@ static int jfs_rmdir(struct inode *dip, 
 
 	tid = txBegin(dip->i_sb, 0);
 
-	down(&JFS_IP(dip)->commit_sem);
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(dip)->commit_mutex);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	iplist[0] = dip;
 	iplist[1] = ip;
@@ -384,8 +384,8 @@ static int jfs_rmdir(struct inode *dip, 
 		if (rc == -EIO)
 			txAbort(tid, 1);
 		txEnd(tid);
-		up(&JFS_IP(dip)->commit_sem);
-		up(&JFS_IP(ip)->commit_sem);
+		mutex_unlock(&JFS_IP(dip)->commit_mutex);
+		mutex_unlock(&JFS_IP(ip)->commit_mutex);
 
 		goto out2;
 	}
@@ -422,8 +422,8 @@ static int jfs_rmdir(struct inode *dip, 
 
 	txEnd(tid);
 
-	up(&JFS_IP(dip)->commit_sem);
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 
 	/*
 	 * Truncating the directory index table is not guaranteed.  It
@@ -488,8 +488,8 @@ static int jfs_unlink(struct inode *dip,
 
 	tid = txBegin(dip->i_sb, 0);
 
-	down(&JFS_IP(dip)->commit_sem);
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(dip)->commit_mutex);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	iplist[0] = dip;
 	iplist[1] = ip;
@@ -503,8 +503,8 @@ static int jfs_unlink(struct inode *dip,
 		if (rc == -EIO)
 			txAbort(tid, 1);	/* Marks FS Dirty */
 		txEnd(tid);
-		up(&JFS_IP(dip)->commit_sem);
-		up(&JFS_IP(ip)->commit_sem);
+		mutex_unlock(&JFS_IP(dip)->commit_mutex);
+		mutex_unlock(&JFS_IP(ip)->commit_mutex);
 		IWRITE_UNLOCK(ip);
 		goto out1;
 	}
@@ -527,8 +527,8 @@ static int jfs_unlink(struct inode *dip,
 		if ((new_size = commitZeroLink(tid, ip)) < 0) {
 			txAbort(tid, 1);	/* Marks FS Dirty */
 			txEnd(tid);
-			up(&JFS_IP(dip)->commit_sem);
-			up(&JFS_IP(ip)->commit_sem);
+			mutex_unlock(&JFS_IP(dip)->commit_mutex);
+			mutex_unlock(&JFS_IP(ip)->commit_mutex);
 			IWRITE_UNLOCK(ip);
 			rc = new_size;
 			goto out1;
@@ -556,13 +556,13 @@ static int jfs_unlink(struct inode *dip,
 
 	txEnd(tid);
 
-	up(&JFS_IP(dip)->commit_sem);
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 
 
 	while (new_size && (rc == 0)) {
 		tid = txBegin(dip->i_sb, 0);
-		down(&JFS_IP(ip)->commit_sem);
+		mutex_lock(&JFS_IP(ip)->commit_mutex);
 		new_size = xtTruncate_pmap(tid, ip, new_size);
 		if (new_size < 0) {
 			txAbort(tid, 1);	/* Marks FS Dirty */
@@ -570,7 +570,7 @@ static int jfs_unlink(struct inode *dip,
 		} else
 			rc = txCommit(tid, 2, &iplist[0], COMMIT_SYNC);
 		txEnd(tid);
-		up(&JFS_IP(ip)->commit_sem);
+		mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	}
 
 	if (ip->i_nlink == 0)
@@ -805,8 +805,8 @@ static int jfs_link(struct dentry *old_d
 
 	tid = txBegin(ip->i_sb, 0);
 
-	down(&JFS_IP(dir)->commit_sem);
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(dir)->commit_mutex);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	/*
 	 * scan parent directory for entry/freespace
@@ -847,8 +847,8 @@ static int jfs_link(struct dentry *old_d
       out:
 	txEnd(tid);
 
-	up(&JFS_IP(dir)->commit_sem);
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(dir)->commit_mutex);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 
 	jfs_info("jfs_link: rc:%d", rc);
 	return rc;
@@ -916,8 +916,8 @@ static int jfs_symlink(struct inode *dip
 
 	tid = txBegin(dip->i_sb, 0);
 
-	down(&JFS_IP(dip)->commit_sem);
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(dip)->commit_mutex);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	rc = jfs_init_security(tid, ip, dip);
 	if (rc)
@@ -1037,8 +1037,8 @@ static int jfs_symlink(struct inode *dip
 
       out3:
 	txEnd(tid);
-	up(&JFS_IP(dip)->commit_sem);
-	up(&JFS_IP(ip)->commit_sem);
+	mutex_unlock(&JFS_IP(dip)->commit_mutex);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
 	if (rc) {
 		free_ea_wmap(ip);
 		ip->i_nlink = 0;
@@ -1141,13 +1141,13 @@ static int jfs_rename(struct inode *old_
 	 */
 	tid = txBegin(new_dir->i_sb, 0);
 
-	down(&JFS_IP(new_dir)->commit_sem);
-	down(&JFS_IP(old_ip)->commit_sem);
+	mutex_lock(&JFS_IP(new_dir)->commit_mutex);
+	mutex_lock(&JFS_IP(old_ip)->commit_mutex);
 	if (old_dir != new_dir)
-		down(&JFS_IP(old_dir)->commit_sem);
+		mutex_lock(&JFS_IP(old_dir)->commit_mutex);
 
 	if (new_ip) {
-		down(&JFS_IP(new_ip)->commit_sem);
+		mutex_lock(&JFS_IP(new_ip)->commit_mutex);
 		/*
 		 * Change existing directory entry to new inode number
 		 */
@@ -1160,10 +1160,10 @@ static int jfs_rename(struct inode *old_
 		if (S_ISDIR(new_ip->i_mode)) {
 			new_ip->i_nlink--;
 			if (new_ip->i_nlink) {
-				up(&JFS_IP(new_dir)->commit_sem);
-				up(&JFS_IP(old_ip)->commit_sem);
+				mutex_unlock(&JFS_IP(new_dir)->commit_mutex);
+				mutex_unlock(&JFS_IP(old_ip)->commit_mutex);
 				if (old_dir != new_dir)
-					up(&JFS_IP(old_dir)->commit_sem);
+					mutex_unlock(&JFS_IP(old_dir)->commit_mutex);
 				if (!S_ISDIR(old_ip->i_mode) && new_ip)
 					IWRITE_UNLOCK(new_ip);
 				jfs_error(new_ip->i_sb,
@@ -1282,16 +1282,16 @@ static int jfs_rename(struct inode *old_
       out4:
 	txEnd(tid);
 
-	up(&JFS_IP(new_dir)->commit_sem);
-	up(&JFS_IP(old_ip)->commit_sem);
+	mutex_unlock(&JFS_IP(new_dir)->commit_mutex);
+	mutex_unlock(&JFS_IP(old_ip)->commit_mutex);
 	if (old_dir != new_dir)
-		up(&JFS_IP(old_dir)->commit_sem);
+		mutex_unlock(&JFS_IP(old_dir)->commit_mutex);
 	if (new_ip)
-		up(&JFS_IP(new_ip)->commit_sem);
+		mutex_unlock(&JFS_IP(new_ip)->commit_mutex);
 
 	while (new_size && (rc == 0)) {
 		tid = txBegin(new_ip->i_sb, 0);
-		down(&JFS_IP(new_ip)->commit_sem);
+		mutex_lock(&JFS_IP(new_ip)->commit_mutex);
 		new_size = xtTruncate_pmap(tid, new_ip, new_size);
 		if (new_size < 0) {
 			txAbort(tid, 1);
@@ -1299,7 +1299,7 @@ static int jfs_rename(struct inode *old_
 		} else
 			rc = txCommit(tid, 1, &new_ip, COMMIT_SYNC);
 		txEnd(tid);
-		up(&JFS_IP(new_ip)->commit_sem);
+		mutex_unlock(&JFS_IP(new_ip)->commit_mutex);
 	}
 	if (new_ip && (new_ip->i_nlink == 0))
 		set_cflag(COMMIT_Nolink, new_ip);
@@ -1361,8 +1361,8 @@ static int jfs_mknod(struct inode *dir, 
 
 	tid = txBegin(dir->i_sb, 0);
 
-	down(&JFS_IP(dir)->commit_sem);
-	down(&JFS_IP(ip)->commit_sem);
+	mutex_lock(&JFS_IP(dir)->commit_mutex);
+	mutex_lock(&JFS_IP(ip)->commit_mutex);
 
 	rc = jfs_init_acl(tid, ip, dir);
 	if (rc)
@@ -1407,8 +1407,8 @@ static int jfs_mknod(struct inode *dir, 
 
       out3:
 	txEnd(tid);
-	up(&JFS_IP(ip)->commit_sem);
-	up(&JFS_IP(dir)->commit_sem);
+	mutex_unlock(&JFS_IP(ip)->commit_mutex);
+	mutex_unlock(&JFS_IP(dir)->commit_mutex);
 	if (rc) {
 		free_ea_wmap(ip);
 		ip->i_nlink = 0;
Index: linux/fs/jfs/super.c
===================================================================
--- linux.orig/fs/jfs/super.c
+++ linux/fs/jfs/super.c
@@ -617,7 +617,7 @@ static void init_once(void *foo, kmem_ca
 		memset(jfs_ip, 0, sizeof(struct jfs_inode_info));
 		INIT_LIST_HEAD(&jfs_ip->anon_inode_list);
 		init_rwsem(&jfs_ip->rdwrlock);
-		init_MUTEX(&jfs_ip->commit_sem);
+		mutex_init(&jfs_ip->commit_mutex);
 		init_rwsem(&jfs_ip->xattr_sem);
 		spin_lock_init(&jfs_ip->ag_lock);
 		jfs_ip->active_ag = -1;
Index: linux/fs/jfs/xattr.c
===================================================================
--- linux.orig/fs/jfs/xattr.c
+++ linux/fs/jfs/xattr.c
@@ -934,13 +934,13 @@ int jfs_setxattr(struct dentry *dentry, 
 	}
 
 	tid = txBegin(inode->i_sb, 0);
-	down(&ji->commit_sem);
+	mutex_lock(&ji->commit_mutex);
 	rc = __jfs_setxattr(tid, dentry->d_inode, name, value, value_len,
 			    flags);
 	if (!rc)
 		rc = txCommit(tid, 1, &inode, 0);
 	txEnd(tid);
-	up(&ji->commit_sem);
+	mutex_unlock(&ji->commit_mutex);
 
 	return rc;
 }
@@ -1093,12 +1093,12 @@ int jfs_removexattr(struct dentry *dentr
 		return rc;
 
 	tid = txBegin(inode->i_sb, 0);
-	down(&ji->commit_sem);
+	mutex_lock(&ji->commit_mutex);
 	rc = __jfs_setxattr(tid, dentry->d_inode, name, NULL, 0, XATTR_REPLACE);
 	if (!rc)
 		rc = txCommit(tid, 1, &inode, 0);
 	txEnd(tid);
-	up(&ji->commit_sem);
+	mutex_unlock(&ji->commit_mutex);
 
 	return rc;
 }
