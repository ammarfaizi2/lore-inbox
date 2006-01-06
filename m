Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752232AbWAFQ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbWAFQ3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbWAFQ3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:29:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19647 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752232AbWAFQ3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:47 -0500
Date: Fri, 6 Jan 2006 16:29:38 GMT
Message-Id: <200601061629.k06GTcpH011394@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 17/17] FRV: Stop XFS from accessing sem count directly
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch stops the XFS from accessing the internals of a semaphore
directly. On the FRV arch, which XFS does does not work. This alternative
implementation was supplied by Al Viro.

If Ingo Molnar's mutexes are going to be accepted into the kernel, then this
patch should be dropped.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 xfs-sema-2615.diff
 fs/xfs/linux-2.6/sema.h       |    5 ++++-
 fs/xfs/quota/xfs_dquot.h      |    4 ++--
 fs/xfs/quota/xfs_dquot_item.c |    4 ++--
 fs/xfs/xfs_iget.c             |    2 +-
 fs/xfs/xfs_inode.c            |    4 ++--
 fs/xfs/xfs_inode_item.c       |    6 +++---
 6 files changed, 14 insertions(+), 11 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15/fs/xfs/linux-2.6/sema.h linux-2.6.15-frv/fs/xfs/linux-2.6/sema.h
--- /warthog/kernels/linux-2.6.15/fs/xfs/linux-2.6/sema.h	2006-01-04 12:39:36.000000000 +0000
+++ linux-2.6.15-frv/fs/xfs/linux-2.6/sema.h	2006-01-06 14:43:43.000000000 +0000
@@ -34,8 +34,11 @@ typedef struct semaphore sema_t;
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
diff -uNrp /warthog/kernels/linux-2.6.15/fs/xfs/quota/xfs_dquot.h linux-2.6.15-frv/fs/xfs/quota/xfs_dquot.h
--- /warthog/kernels/linux-2.6.15/fs/xfs/quota/xfs_dquot.h	2006-01-04 12:39:36.000000000 +0000
+++ linux-2.6.15-frv/fs/xfs/quota/xfs_dquot.h	2006-01-06 14:43:43.000000000 +0000
@@ -119,7 +119,7 @@ XFS_DQ_IS_LOCKED(xfs_dquot_t *dqp)
  */
 #define xfs_dqflock(dqp)	 { psema(&((dqp)->q_flock), PINOD | PRECALC);\
 				   (dqp)->dq_flags |= XFS_DQ_FLOCKED; }
-#define xfs_dqfunlock(dqp)	 { ASSERT(valusema(&((dqp)->q_flock)) <= 0); \
+#define xfs_dqfunlock(dqp)	 { ASSERT(sem_is_locked(&((dqp)->q_flock))); \
 				   vsema(&((dqp)->q_flock)); \
 				   (dqp)->dq_flags &= ~(XFS_DQ_FLOCKED); }
 
@@ -128,7 +128,7 @@ XFS_DQ_IS_LOCKED(xfs_dquot_t *dqp)
 #define XFS_DQ_PINUNLOCK(dqp, s)   mutex_spinunlock( \
 				     &(XFS_DQ_TO_QINF(dqp)->qi_pinlock), s)
 
-#define XFS_DQ_IS_FLUSH_LOCKED(dqp) (valusema(&((dqp)->q_flock)) <= 0)
+#define XFS_DQ_IS_FLUSH_LOCKED(dqp) (sem_is_locked(&((dqp)->q_flock)))
 #define XFS_DQ_IS_ON_FREELIST(dqp)  ((dqp)->dq_flnext != (dqp))
 #define XFS_DQ_IS_DIRTY(dqp)	((dqp)->dq_flags & XFS_DQ_DIRTY)
 #define XFS_QM_ISUDQ(dqp)	((dqp)->dq_flags & XFS_DQ_USER)
diff -uNrp /warthog/kernels/linux-2.6.15/fs/xfs/quota/xfs_dquot_item.c linux-2.6.15-frv/fs/xfs/quota/xfs_dquot_item.c
--- /warthog/kernels/linux-2.6.15/fs/xfs/quota/xfs_dquot_item.c	2006-01-04 12:39:36.000000000 +0000
+++ linux-2.6.15-frv/fs/xfs/quota/xfs_dquot_item.c	2006-01-06 14:43:43.000000000 +0000
@@ -246,7 +246,7 @@ xfs_qm_dquot_logitem_pushbuf(
 	 * inode flush completed and the inode was taken off the AIL.
 	 * So, just get out.
 	 */
-	if ((valusema(&(dqp->q_flock)) > 0)  ||
+	if (!sem_is_locked(&(dqp->q_flock))  ||
 	    ((qip->qli_item.li_flags & XFS_LI_IN_AIL) == 0)) {
 		qip->qli_pushbuf_flag = 0;
 		xfs_dqunlock(dqp);
@@ -259,7 +259,7 @@ xfs_qm_dquot_logitem_pushbuf(
 	if (bp != NULL) {
 		if (XFS_BUF_ISDELAYWRITE(bp)) {
 			dopush = ((qip->qli_item.li_flags & XFS_LI_IN_AIL) &&
-				  (valusema(&(dqp->q_flock)) <= 0));
+				  sem_is_locked(&(dqp->q_flock)));
 			qip->qli_pushbuf_flag = 0;
 			xfs_dqunlock(dqp);
 
diff -uNrp /warthog/kernels/linux-2.6.15/fs/xfs/xfs_iget.c linux-2.6.15-frv/fs/xfs/xfs_iget.c
--- /warthog/kernels/linux-2.6.15/fs/xfs/xfs_iget.c	2006-01-04 12:39:37.000000000 +0000
+++ linux-2.6.15-frv/fs/xfs/xfs_iget.c	2006-01-06 14:43:43.000000000 +0000
@@ -1041,6 +1041,6 @@ xfs_iflock_nowait(xfs_inode_t *ip)
 void
 xfs_ifunlock(xfs_inode_t *ip)
 {
-	ASSERT(valusema(&(ip->i_flock)) <= 0);
+	ASSERT(sem_is_locked(&(ip->i_flock)));
 	vsema(&(ip->i_flock));
 }
diff -uNrp /warthog/kernels/linux-2.6.15/fs/xfs/xfs_inode.c linux-2.6.15-frv/fs/xfs/xfs_inode.c
--- /warthog/kernels/linux-2.6.15/fs/xfs/xfs_inode.c	2006-01-04 12:39:37.000000000 +0000
+++ linux-2.6.15-frv/fs/xfs/xfs_inode.c	2006-01-06 14:43:43.000000000 +0000
@@ -3061,7 +3061,7 @@ xfs_iflush(
 	XFS_STATS_INC(xs_iflush_count);
 
 	ASSERT(ismrlocked(&ip->i_lock, MR_UPDATE|MR_ACCESS));
-	ASSERT(valusema(&ip->i_flock) <= 0);
+	ASSERT(sem_is_locked(&(ip->i_flock)));
 	ASSERT(ip->i_d.di_format != XFS_DINODE_FMT_BTREE ||
 	       ip->i_d.di_nextents > ip->i_df.if_ext_max);
 
@@ -3319,7 +3319,7 @@ xfs_iflush_int(
 	SPLDECL(s);
 
 	ASSERT(ismrlocked(&ip->i_lock, MR_UPDATE|MR_ACCESS));
-	ASSERT(valusema(&ip->i_flock) <= 0);
+	ASSERT(sem_is_locked(&(ip->i_flock)));
 	ASSERT(ip->i_d.di_format != XFS_DINODE_FMT_BTREE ||
 	       ip->i_d.di_nextents > ip->i_df.if_ext_max);
 
diff -uNrp /warthog/kernels/linux-2.6.15/fs/xfs/xfs_inode_item.c linux-2.6.15-frv/fs/xfs/xfs_inode_item.c
--- /warthog/kernels/linux-2.6.15/fs/xfs/xfs_inode_item.c	2006-01-04 12:39:37.000000000 +0000
+++ linux-2.6.15-frv/fs/xfs/xfs_inode_item.c	2006-01-06 14:43:43.000000000 +0000
@@ -789,7 +789,7 @@ xfs_inode_item_pushbuf(
 	 * inode flush completed and the inode was taken off the AIL.
 	 * So, just get out.
 	 */
-	if ((valusema(&(ip->i_flock)) > 0)  ||
+	if (!sem_is_locked(&(ip->i_flock)) ||
 	    ((iip->ili_item.li_flags & XFS_LI_IN_AIL) == 0)) {
 		iip->ili_pushbuf_flag = 0;
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
@@ -811,7 +811,7 @@ xfs_inode_item_pushbuf(
 			 * If not, we can flush it async.
 			 */
 			dopush = ((iip->ili_item.li_flags & XFS_LI_IN_AIL) &&
-				  (valusema(&(ip->i_flock)) <= 0));
+				  sem_is_locked(&(ip->i_flock)));
 			iip->ili_pushbuf_flag = 0;
 			xfs_iunlock(ip, XFS_ILOCK_SHARED);
 			xfs_buftrace("INODE ITEM PUSH", bp);
@@ -859,7 +859,7 @@ xfs_inode_item_push(
 	ip = iip->ili_inode;
 
 	ASSERT(ismrlocked(&(ip->i_lock), MR_ACCESS));
-	ASSERT(valusema(&(ip->i_flock)) <= 0);
+	ASSERT(sem_is_locked(&(ip->i_flock)));
 	/*
 	 * Since we were able to lock the inode's flush lock and
 	 * we found it on the AIL, the inode must be dirty.  This
