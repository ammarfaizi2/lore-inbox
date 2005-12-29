Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVL2Qiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVL2Qiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVL2Qiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:38:54 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:14010 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750802AbVL2Qix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:38:53 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [patch] updates XFS mutex patch
References: <yq0zmmktbhk.fsf@jaguar.mkp.net>
	<20051229144824.GC18833@infradead.org>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 29 Dec 2005 11:38:49 -0500
In-Reply-To: <20051229144824.GC18833@infradead.org>
Message-ID: <yq0r77vuacm.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Thu, Dec 29, 2005 at 05:59:35AM -0500, Jes Sorensen
Christoph> wrote:
>> This patch switches XFS over to use the new mutex code directly as
>> opposed to the previous workaround patch I posted earlier that
>> avoided the namespace clash by forcing it back to semaphores. This
>> falls in the 'works for me<tm>' category.

Christoph> It's say just switch XFS to the one-arg mutex_init variant.

Ok,

One for the blame Christoph files then ;-)

How about this one?

Cheers,
Jes

This patch switches XFS over to use the new mutex code directly as
opposed to the previous workaround patch I posted earlier that avoided
the namespace clash by forcing it back to semaphores. This falls in the
'works for me<tm>' category.

Signed-off-by: Jes Sorensen <jes@trained-monkey.org>

----

 fs/xfs/linux-2.6/mutex.h       |   10 +++-------
 fs/xfs/quota/xfs_dquot.c       |    4 ++--
 fs/xfs/quota/xfs_qm.c          |   10 +++++-----
 fs/xfs/quota/xfs_qm.h          |    2 +-
 fs/xfs/quota/xfs_qm_bhv.c      |    2 +-
 fs/xfs/quota/xfs_qm_syscalls.c |    8 ++++----
 fs/xfs/quota/xfs_quota_priv.h  |    2 +-
 fs/xfs/support/uuid.c          |    6 +++---
 fs/xfs/xfs_mount.c             |    2 +-
 fs/xfs/xfs_mount.h             |    2 +-
 10 files changed, 22 insertions(+), 26 deletions(-)

Index: linux-2.6.15-rc7-quilt/fs/xfs/linux-2.6/mutex.h
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/linux-2.6/mutex.h
+++ linux-2.6.15-rc7-quilt/fs/xfs/linux-2.6/mutex.h
@@ -19,7 +19,7 @@
 #define __XFS_SUPPORT_MUTEX_H__
 
 #include <linux/spinlock.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 /*
  * Map the mutex'es from IRIX to Linux semaphores.
@@ -28,12 +28,8 @@
  * callers.
  */
 #define MUTEX_DEFAULT		0x0
-typedef struct semaphore	mutex_t;
 
-#define mutex_init(lock, type, name)		sema_init(lock, 1)
-#define mutex_destroy(lock)			sema_init(lock, -99)
-#define mutex_lock(lock, num)			down(lock)
-#define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
-#define mutex_unlock(lock)			up(lock)
+typedef struct mutex		mutex_t;
+#define mutex_destroy(lock)			do{}while(0)
 
 #endif /* __XFS_SUPPORT_MUTEX_H__ */
Index: linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_dquot.c
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/quota/xfs_dquot.c
+++ linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_dquot.c
@@ -104,7 +104,7 @@
 	 */
 	if (brandnewdquot) {
 		dqp->dq_flnext = dqp->dq_flprev = dqp;
-		mutex_init(&dqp->q_qlock,  MUTEX_DEFAULT, "xdq");
+		mutex_init(&dqp->q_qlock);
 		initnsema(&dqp->q_flock, 1, "fdq");
 		sv_init(&dqp->q_pinwait, SV_DEFAULT, "pdq");
 
@@ -1382,7 +1382,7 @@
 xfs_dqlock(
 	xfs_dquot_t *dqp)
 {
-	mutex_lock(&(dqp->q_qlock), PINOD);
+	mutex_lock(&(dqp->q_qlock));
 }
 
 void
Index: linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_qm.c
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/quota/xfs_qm.c
+++ linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_qm.c
@@ -167,7 +167,7 @@
 	xqm->qm_dqfree_ratio = XFS_QM_DQFREE_RATIO;
 	xqm->qm_nrefs = 0;
 #ifdef DEBUG
-	mutex_init(&qcheck_lock, MUTEX_DEFAULT, "qchk");
+	xfs_mutex_init(&qcheck_lock, MUTEX_DEFAULT, "qchk");
 #endif
 	return xqm;
 }
@@ -1166,7 +1166,7 @@
 	qinf->qi_dqreclaims = 0;
 
 	/* mutex used to serialize quotaoffs */
-	mutex_init(&qinf->qi_quotaofflock, MUTEX_DEFAULT, "qoff");
+	mutex_init(&qinf->qi_quotaofflock);
 
 	/* Precalc some constants */
 	qinf->qi_dqchunklen = XFS_FSB_TO_BB(mp, XFS_DQUOT_CLUSTER_SIZE_FSB);
@@ -1285,7 +1285,7 @@
 	char		*str,
 	int		n)
 {
-	mutex_init(&list->qh_lock, MUTEX_DEFAULT, str);
+	mutex_init(&list->qh_lock);
 	list->qh_next = NULL;
 	list->qh_version = 0;
 	list->qh_nelems = 0;
@@ -2762,7 +2762,7 @@
 xfs_qm_freelist_init(xfs_frlist_t *ql)
 {
 	ql->qh_next = ql->qh_prev = (xfs_dquot_t *) ql;
-	mutex_init(&ql->qh_lock, MUTEX_DEFAULT, "dqf");
+	mutex_init(&ql->qh_lock);
 	ql->qh_version = 0;
 	ql->qh_nelems = 0;
 }
@@ -2772,7 +2772,7 @@
 {
 	xfs_dquot_t	*dqp, *nextdqp;
 
-	mutex_lock(&ql->qh_lock, PINOD);
+	mutex_lock(&ql->qh_lock);
 	for (dqp = ql->qh_next;
 	     dqp != (xfs_dquot_t *)ql; ) {
 		xfs_dqlock(dqp);
Index: linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_qm.h
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/quota/xfs_qm.h
+++ linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_qm.h
@@ -165,7 +165,7 @@
 #define XFS_QM_IWARNLIMIT	5
 #define XFS_QM_RTBWARNLIMIT	5
 
-#define XFS_QM_LOCK(xqm)	(mutex_lock(&xqm##_lock, PINOD))
+#define XFS_QM_LOCK(xqm)	(mutex_lock(&xqm##_lock))
 #define XFS_QM_UNLOCK(xqm)	(mutex_unlock(&xqm##_lock))
 #define XFS_QM_HOLD(xqm)	((xqm)->qm_nrefs++)
 #define XFS_QM_RELE(xqm)	((xqm)->qm_nrefs--)
Index: linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_qm_bhv.c
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/quota/xfs_qm_bhv.c
+++ linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_qm_bhv.c
@@ -363,7 +363,7 @@
 		KERN_INFO "SGI XFS Quota Management subsystem\n";
 
 	printk(message);
-	mutex_init(&xfs_Gqm_lock, MUTEX_DEFAULT, "xfs_qmlock");
+	mutex_init(&xfs_Gqm_lock);
 	vfs_bhv_set_custom(&xfs_qmops, &xfs_qmcore_xfs);
 	xfs_qm_init_procfs();
 }
Index: linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_qm_syscalls.c
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/quota/xfs_qm_syscalls.c
+++ linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_qm_syscalls.c
@@ -233,7 +233,7 @@
 	 */
 	ASSERT(mp->m_quotainfo);
 	if (mp->m_quotainfo)
-		mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
+		mutex_lock(&(XFS_QI_QOFFLOCK(mp)));
 
 	ASSERT(mp->m_quotainfo);
 
@@ -508,7 +508,7 @@
 	/*
 	 * Switch on quota enforcement in core.
 	 */
-	mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
+	mutex_lock(&(XFS_QI_QOFFLOCK(mp)));
 	mp->m_qflags |= (flags & XFS_ALL_QUOTA_ENFD);
 	mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 
@@ -617,7 +617,7 @@
 	 * a quotaoff from happening). (XXXThis doesn't currently happen
 	 * because we take the vfslock before calling xfs_qm_sysent).
 	 */
-	mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
+	mutex_lock(&(XFS_QI_QOFFLOCK(mp)));
 
 	/*
 	 * Get the dquot (locked), and join it to the transaction.
@@ -1426,7 +1426,7 @@
 	xfs_log_force(mp, (xfs_lsn_t)0, XFS_LOG_FORCE | XFS_LOG_SYNC);
 	XFS_bflush(mp->m_ddev_targp);
 
-	mutex_lock(&qcheck_lock, PINOD);
+	mutex_lock(&qcheck_lock);
 	/* There should be absolutely no quota activity while this
 	   is going on. */
 	qmtest_udqtab = kmem_zalloc(qmtest_hashmask *
Index: linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_quota_priv.h
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/quota/xfs_quota_priv.h
+++ linux-2.6.15-rc7-quilt/fs/xfs/quota/xfs_quota_priv.h
@@ -51,7 +51,7 @@
 #define XFS_QI_MPLNEXT(mp)	((mp)->m_quotainfo->qi_dqlist.qh_next)
 #define XFS_QI_MPLNDQUOTS(mp)	((mp)->m_quotainfo->qi_dqlist.qh_nelems)
 
-#define XQMLCK(h)			(mutex_lock(&((h)->qh_lock), PINOD))
+#define XQMLCK(h)			(mutex_lock(&((h)->qh_lock)))
 #define XQMUNLCK(h)			(mutex_unlock(&((h)->qh_lock)))
 #ifdef DEBUG
 struct xfs_dqhash;
Index: linux-2.6.15-rc7-quilt/fs/xfs/support/uuid.c
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/support/uuid.c
+++ linux-2.6.15-rc7-quilt/fs/xfs/support/uuid.c
@@ -24,7 +24,7 @@
 void
 uuid_init(void)
 {
-	mutex_init(&uuid_monitor, MUTEX_DEFAULT, "uuid_monitor");
+	mutex_init(&uuid_monitor);
 }
 
 /*
@@ -94,7 +94,7 @@
 {
 	int	i, hole;
 
-	mutex_lock(&uuid_monitor, PVFS);
+	mutex_lock(&uuid_monitor);
 	for (i = 0, hole = -1; i < uuid_table_size; i++) {
 		if (uuid_is_nil(&uuid_table[i])) {
 			hole = i;
@@ -122,7 +122,7 @@
 {
 	int	i;
 
-	mutex_lock(&uuid_monitor, PVFS);
+	mutex_lock(&uuid_monitor);
 	for (i = 0; i < uuid_table_size; i++) {
 		if (uuid_is_nil(&uuid_table[i]))
 			continue;
Index: linux-2.6.15-rc7-quilt/fs/xfs/xfs_mount.c
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/xfs_mount.c
+++ linux-2.6.15-rc7-quilt/fs/xfs/xfs_mount.c
@@ -117,7 +117,7 @@
 
 	AIL_LOCKINIT(&mp->m_ail_lock, "xfs_ail");
 	spinlock_init(&mp->m_sb_lock, "xfs_sb");
-	mutex_init(&mp->m_ilock, MUTEX_DEFAULT, "xfs_ilock");
+	mutex_init(&mp->m_ilock);
 	initnsema(&mp->m_growlock, 1, "xfs_grow");
 	/*
 	 * Initialize the AIL.
Index: linux-2.6.15-rc7-quilt/fs/xfs/xfs_mount.h
===================================================================
--- linux-2.6.15-rc7-quilt.orig/fs/xfs/xfs_mount.h
+++ linux-2.6.15-rc7-quilt/fs/xfs/xfs_mount.h
@@ -533,7 +533,7 @@
 	int		msb_delta;	/* Change to make to specified field */
 } xfs_mod_sb_t;
 
-#define	XFS_MOUNT_ILOCK(mp)	mutex_lock(&((mp)->m_ilock), PINOD)
+#define	XFS_MOUNT_ILOCK(mp)	mutex_lock(&((mp)->m_ilock))
 #define	XFS_MOUNT_IUNLOCK(mp)	mutex_unlock(&((mp)->m_ilock))
 #define	XFS_SB_LOCK(mp)		mutex_spinlock(&(mp)->m_sb_lock)
 #define	XFS_SB_UNLOCK(mp,s)	mutex_spinunlock(&(mp)->m_sb_lock,(s))
