Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWFOLiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWFOLiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWFOLiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:38:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48307 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030249AbWFOLiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:38:22 -0400
Date: Thu, 15 Jun 2006 12:38:21 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Subject: [PATCH] xfs semaphore count abuse fixes
Message-ID: <20060615113821.GO27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kill direct access to ->count in valusema(); all we ever use it for is check
if semaphore is actually locked, which can be trivially done in portable way.
Code gets more reabable, while we are at it...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/xfs/linux-2.6/sema.h       |    5 ++++-
 fs/xfs/quota/xfs_dquot.h      |    4 ++--
 fs/xfs/quota/xfs_dquot_item.c |    4 ++--
 fs/xfs/xfs_iget.c             |    2 +-
 fs/xfs/xfs_inode.c            |    4 ++--
 fs/xfs/xfs_inode_item.c       |    6 +++---
 6 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/linux-2.6/sema.h b/fs/xfs/linux-2.6/sema.h
index 194a844..d9380a4 100644
--- a/fs/xfs/linux-2.6/sema.h
+++ b/fs/xfs/linux-2.6/sema.h
@@ -34,8 +34,11 @@ #define initsema(sp, val)		sema_init(sp,
 #define initnsema(sp, val, name)	sema_init(sp, val)
 #define psema(sp, b)			down(sp)
 #define vsema(sp)			up(sp)
-#define valusema(sp)			(atomic_read(&(sp)->count))
 #define freesema(sema)
+static inline int sem_is_locked(sema_t *sp)
+{
+	return down_trylock(sp) || (up(sp), 0);
+}
 
 /*
  * Map cpsema (try to get the sema) to down_trylock. We need to switch
diff --git a/fs/xfs/quota/xfs_dquot.h b/fs/xfs/quota/xfs_dquot.h
index c0c6296..0ffa034 100644
--- a/fs/xfs/quota/xfs_dquot.h
+++ b/fs/xfs/quota/xfs_dquot.h
@@ -119,7 +119,7 @@ #endif
  */
 #define xfs_dqflock(dqp)	 { psema(&((dqp)->q_flock), PINOD | PRECALC);\
 				   (dqp)->dq_flags |= XFS_DQ_FLOCKED; }
-#define xfs_dqfunlock(dqp)	 { ASSERT(valusema(&((dqp)->q_flock)) <= 0); \
+#define xfs_dqfunlock(dqp)	 { ASSERT(sem_is_locked(&((dqp)->q_flock))); \
 				   vsema(&((dqp)->q_flock)); \
 				   (dqp)->dq_flags &= ~(XFS_DQ_FLOCKED); }
 
@@ -128,7 +128,7 @@ #define XFS_DQ_PINLOCK(dqp)	   mutex_spi
 #define XFS_DQ_PINUNLOCK(dqp, s)   mutex_spinunlock( \
 				     &(XFS_DQ_TO_QINF(dqp)->qi_pinlock), s)
 
-#define XFS_DQ_IS_FLUSH_LOCKED(dqp) (valusema(&((dqp)->q_flock)) <= 0)
+#define XFS_DQ_IS_FLUSH_LOCKED(dqp) (sem_is_locked(&((dqp)->q_flock)))
 #define XFS_DQ_IS_ON_FREELIST(dqp)  ((dqp)->dq_flnext != (dqp))
 #define XFS_DQ_IS_DIRTY(dqp)	((dqp)->dq_flags & XFS_DQ_DIRTY)
 #define XFS_QM_ISUDQ(dqp)	((dqp)->dq_flags & XFS_DQ_USER)
diff --git a/fs/xfs/quota/xfs_dquot_item.c b/fs/xfs/quota/xfs_dquot_item.c
index 546f48a..c4e1819 100644
--- a/fs/xfs/quota/xfs_dquot_item.c
+++ b/fs/xfs/quota/xfs_dquot_item.c
@@ -248,7 +248,7 @@ xfs_qm_dquot_logitem_pushbuf(
 	 * inode flush completed and the inode was taken off the AIL.
 	 * So, just get out.
 	 */
-	if ((valusema(&(dqp->q_flock)) > 0)  ||
+	if (!sem_is_locked(&(dqp->q_flock))  ||
 	    ((qip->qli_item.li_flags & XFS_LI_IN_AIL) == 0)) {
 		qip->qli_pushbuf_flag = 0;
 		xfs_dqunlock(dqp);
@@ -261,7 +261,7 @@ xfs_qm_dquot_logitem_pushbuf(
 	if (bp != NULL) {
 		if (XFS_BUF_ISDELAYWRITE(bp)) {
 			dopush = ((qip->qli_item.li_flags & XFS_LI_IN_AIL) &&
-				  (valusema(&(dqp->q_flock)) <= 0));
+				  sem_is_locked(&(dqp->q_flock)));
 			qip->qli_pushbuf_flag = 0;
 			xfs_dqunlock(dqp);
 
diff --git a/fs/xfs/xfs_iget.c b/fs/xfs/xfs_iget.c
index b538543..6260e02 100644
--- a/fs/xfs/xfs_iget.c
+++ b/fs/xfs/xfs_iget.c
@@ -1033,6 +1033,6 @@ xfs_iflock_nowait(xfs_inode_t *ip)
 void
 xfs_ifunlock(xfs_inode_t *ip)
 {
-	ASSERT(valusema(&(ip->i_flock)) <= 0);
+	ASSERT(sem_is_locked(&(ip->i_flock)));
 	vsema(&(ip->i_flock));
 }
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 94b60dd..19e7eb6 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3006,7 +3006,7 @@ xfs_iflush(
 	XFS_STATS_INC(xs_iflush_count);
 
 	ASSERT(ismrlocked(&ip->i_lock, MR_UPDATE|MR_ACCESS));
-	ASSERT(valusema(&ip->i_flock) <= 0);
+	ASSERT(sem_is_locked(&(ip->i_flock)));
 	ASSERT(ip->i_d.di_format != XFS_DINODE_FMT_BTREE ||
 	       ip->i_d.di_nextents > ip->i_df.if_ext_max);
 
@@ -3264,7 +3264,7 @@ #endif
 	SPLDECL(s);
 
 	ASSERT(ismrlocked(&ip->i_lock, MR_UPDATE|MR_ACCESS));
-	ASSERT(valusema(&ip->i_flock) <= 0);
+	ASSERT(sem_is_locked(&(ip->i_flock)));
 	ASSERT(ip->i_d.di_format != XFS_DINODE_FMT_BTREE ||
 	       ip->i_d.di_nextents > ip->i_df.if_ext_max);
 
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 7497a48..1c9e465 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -794,7 +794,7 @@ xfs_inode_item_pushbuf(
 	 * inode flush completed and the inode was taken off the AIL.
 	 * So, just get out.
 	 */
-	if ((valusema(&(ip->i_flock)) > 0)  ||
+	if (!sem_is_locked(&(ip->i_flock)) ||
 	    ((iip->ili_item.li_flags & XFS_LI_IN_AIL) == 0)) {
 		iip->ili_pushbuf_flag = 0;
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
@@ -816,7 +816,7 @@ xfs_inode_item_pushbuf(
 			 * If not, we can flush it async.
 			 */
 			dopush = ((iip->ili_item.li_flags & XFS_LI_IN_AIL) &&
-				  (valusema(&(ip->i_flock)) <= 0));
+				  sem_is_locked(&(ip->i_flock)));
 			iip->ili_pushbuf_flag = 0;
 			xfs_iunlock(ip, XFS_ILOCK_SHARED);
 			xfs_buftrace("INODE ITEM PUSH", bp);
@@ -864,7 +864,7 @@ xfs_inode_item_push(
 	ip = iip->ili_inode;
 
 	ASSERT(ismrlocked(&(ip->i_lock), MR_ACCESS));
-	ASSERT(valusema(&(ip->i_flock)) <= 0);
+	ASSERT(sem_is_locked(&(ip->i_flock)));
 	/*
 	 * Since we were able to lock the inode's flush lock and
 	 * we found it on the AIL, the inode must be dirty.  This
-- 
1.4.0.rc2

