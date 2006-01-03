Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWACQr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWACQr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWACQrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:47:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:34441 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932440AbWACQrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:47:12 -0500
Date: Tue, 3 Jan 2006 17:46:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 12/19] mutex subsystem, semaphore to mutex: XFS
Message-ID: <20060103164655.GM25802@elte.hu>
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

From: Jes Sorensen <jes@trained-monkey.org>

This patch switches XFS over to use the new mutex code directly as
opposed to the previous workaround patch I posted earlier that avoided
the namespace clash by forcing it back to semaphores. This falls in the
'works for me<tm>' category.

Signed-off-by: Jes Sorensen <jes@trained-monkey.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

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

Index: linux/fs/xfs/linux-2.6/mutex.h
===================================================================
--- linux.orig/fs/xfs/linux-2.6/mutex.h
+++ linux/fs/xfs/linux-2.6/mutex.h
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
+//#define mutex_destroy(lock)			do{}while(0)
 
 #endif /* __XFS_SUPPORT_MUTEX_H__ */
Index: linux/fs/xfs/quota/xfs_dquot.c
===================================================================
--- linux.orig/fs/xfs/quota/xfs_dquot.c
+++ linux/fs/xfs/quota/xfs_dquot.c
@@ -104,7 +104,7 @@ xfs_qm_dqinit(
 	 */
 	if (brandnewdquot) {
 		dqp->dq_flnext = dqp->dq_flprev = dqp;
-		mutex_init(&dqp->q_qlock,  MUTEX_DEFAULT, "xdq");
+		mutex_init(&dqp->q_qlock);
 		initnsema(&dqp->q_flock, 1, "fdq");
 		sv_init(&dqp->q_pinwait, SV_DEFAULT, "pdq");
 
@@ -1382,7 +1382,7 @@ void
 xfs_dqlock(
 	xfs_dquot_t *dqp)
 {
-	mutex_lock(&(dqp->q_qlock), PINOD);
+	mutex_lock(&(dqp->q_qlock));
 }
 
 void
Index: linux/fs/xfs/quota/xfs_qm.c
===================================================================
--- linux.orig/fs/xfs/quota/xfs_qm.c
+++ linux/fs/xfs/quota/xfs_qm.c
@@ -167,7 +167,7 @@ xfs_Gqm_init(void)
 	xqm->qm_dqfree_ratio = XFS_QM_DQFREE_RATIO;
 	xqm->qm_nrefs = 0;
 #ifdef DEBUG
-	mutex_init(&qcheck_lock, MUTEX_DEFAULT, "qchk");
+	xfs_mutex_init(&qcheck_lock, MUTEX_DEFAULT, "qchk");
 #endif
 	return xqm;
 }
@@ -1166,7 +1166,7 @@ xfs_qm_init_quotainfo(
 	qinf->qi_dqreclaims = 0;
 
 	/* mutex used to serialize quotaoffs */
-	mutex_init(&qinf->qi_quotaofflock, MUTEX_DEFAULT, "qoff");
+	mutex_init(&qinf->qi_quotaofflock);
 
 	/* Precalc some constants */
 	qinf->qi_dqchunklen = XFS_FSB_TO_BB(mp, XFS_DQUOT_CLUSTER_SIZE_FSB);
@@ -1285,7 +1285,7 @@ xfs_qm_list_init(
 	char		*str,
 	int		n)
 {
-	mutex_init(&list->qh_lock, MUTEX_DEFAULT, str);
+	mutex_init(&list->qh_lock);
 	list->qh_next = NULL;
 	list->qh_version = 0;
 	list->qh_nelems = 0;
@@ -2762,7 +2762,7 @@ STATIC void
 xfs_qm_freelist_init(xfs_frlist_t *ql)
 {
 	ql->qh_next = ql->qh_prev = (xfs_dquot_t *) ql;
-	mutex_init(&ql->qh_lock, MUTEX_DEFAULT, "dqf");
+	mutex_init(&ql->qh_lock);
 	ql->qh_version = 0;
 	ql->qh_nelems = 0;
 }
@@ -2772,7 +2772,7 @@ xfs_qm_freelist_destroy(xfs_frlist_t *ql
 {
 	xfs_dquot_t	*dqp, *nextdqp;
 
-	mutex_lock(&ql->qh_lock, PINOD);
+	mutex_lock(&ql->qh_lock);
 	for (dqp = ql->qh_next;
 	     dqp != (xfs_dquot_t *)ql; ) {
 		xfs_dqlock(dqp);
Index: linux/fs/xfs/quota/xfs_qm.h
===================================================================
--- linux.orig/fs/xfs/quota/xfs_qm.h
+++ linux/fs/xfs/quota/xfs_qm.h
@@ -165,7 +165,7 @@ typedef struct xfs_dquot_acct {
 #define XFS_QM_IWARNLIMIT	5
 #define XFS_QM_RTBWARNLIMIT	5
 
-#define XFS_QM_LOCK(xqm)	(mutex_lock(&xqm##_lock, PINOD))
+#define XFS_QM_LOCK(xqm)	(mutex_lock(&xqm##_lock))
 #define XFS_QM_UNLOCK(xqm)	(mutex_unlock(&xqm##_lock))
 #define XFS_QM_HOLD(xqm)	((xqm)->qm_nrefs++)
 #define XFS_QM_RELE(xqm)	((xqm)->qm_nrefs--)
Index: linux/fs/xfs/quota/xfs_qm_bhv.c
===================================================================
--- linux.orig/fs/xfs/quota/xfs_qm_bhv.c
+++ linux/fs/xfs/quota/xfs_qm_bhv.c
@@ -363,7 +363,7 @@ xfs_qm_init(void)
 		KERN_INFO "SGI XFS Quota Management subsystem\n";
 
 	printk(message);
-	mutex_init(&xfs_Gqm_lock, MUTEX_DEFAULT, "xfs_qmlock");
+	mutex_init(&xfs_Gqm_lock);
 	vfs_bhv_set_custom(&xfs_qmops, &xfs_qmcore_xfs);
 	xfs_qm_init_procfs();
 }
Index: linux/fs/xfs/quota/xfs_qm_syscalls.c
===================================================================
--- linux.orig/fs/xfs/quota/xfs_qm_syscalls.c
+++ linux/fs/xfs/quota/xfs_qm_syscalls.c
@@ -233,7 +233,7 @@ xfs_qm_scall_quotaoff(
 	 */
 	ASSERT(mp->m_quotainfo);
 	if (mp->m_quotainfo)
-		mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
+		mutex_lock(&(XFS_QI_QOFFLOCK(mp)));
 
 	ASSERT(mp->m_quotainfo);
 
@@ -508,7 +508,7 @@ xfs_qm_scall_quotaon(
 	/*
 	 * Switch on quota enforcement in core.
 	 */
-	mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
+	mutex_lock(&(XFS_QI_QOFFLOCK(mp)));
 	mp->m_qflags |= (flags & XFS_ALL_QUOTA_ENFD);
 	mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 
@@ -617,7 +617,7 @@ xfs_qm_scall_setqlim(
 	 * a quotaoff from happening). (XXXThis doesn't currently happen
 	 * because we take the vfslock before calling xfs_qm_sysent).
 	 */
-	mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
+	mutex_lock(&(XFS_QI_QOFFLOCK(mp)));
 
 	/*
 	 * Get the dquot (locked), and join it to the transaction.
@@ -1426,7 +1426,7 @@ xfs_qm_internalqcheck(
 	xfs_log_force(mp, (xfs_lsn_t)0, XFS_LOG_FORCE | XFS_LOG_SYNC);
 	XFS_bflush(mp->m_ddev_targp);
 
-	mutex_lock(&qcheck_lock, PINOD);
+	mutex_lock(&qcheck_lock);
 	/* There should be absolutely no quota activity while this
 	   is going on. */
 	qmtest_udqtab = kmem_zalloc(qmtest_hashmask *
Index: linux/fs/xfs/quota/xfs_quota_priv.h
===================================================================
--- linux.orig/fs/xfs/quota/xfs_quota_priv.h
+++ linux/fs/xfs/quota/xfs_quota_priv.h
@@ -51,7 +51,7 @@
 #define XFS_QI_MPLNEXT(mp)	((mp)->m_quotainfo->qi_dqlist.qh_next)
 #define XFS_QI_MPLNDQUOTS(mp)	((mp)->m_quotainfo->qi_dqlist.qh_nelems)
 
-#define XQMLCK(h)			(mutex_lock(&((h)->qh_lock), PINOD))
+#define XQMLCK(h)			(mutex_lock(&((h)->qh_lock)))
 #define XQMUNLCK(h)			(mutex_unlock(&((h)->qh_lock)))
 #ifdef DEBUG
 struct xfs_dqhash;
Index: linux/fs/xfs/support/uuid.c
===================================================================
--- linux.orig/fs/xfs/support/uuid.c
+++ linux/fs/xfs/support/uuid.c
@@ -24,7 +24,7 @@ static uuid_t	*uuid_table;
 void
 uuid_init(void)
 {
-	mutex_init(&uuid_monitor, MUTEX_DEFAULT, "uuid_monitor");
+	mutex_init(&uuid_monitor);
 }
 
 /*
@@ -94,7 +94,7 @@ uuid_table_insert(uuid_t *uuid)
 {
 	int	i, hole;
 
-	mutex_lock(&uuid_monitor, PVFS);
+	mutex_lock(&uuid_monitor);
 	for (i = 0, hole = -1; i < uuid_table_size; i++) {
 		if (uuid_is_nil(&uuid_table[i])) {
 			hole = i;
@@ -122,7 +122,7 @@ uuid_table_remove(uuid_t *uuid)
 {
 	int	i;
 
-	mutex_lock(&uuid_monitor, PVFS);
+	mutex_lock(&uuid_monitor);
 	for (i = 0; i < uuid_table_size; i++) {
 		if (uuid_is_nil(&uuid_table[i]))
 			continue;
Index: linux/fs/xfs/xfs_mount.c
===================================================================
--- linux.orig/fs/xfs/xfs_mount.c
+++ linux/fs/xfs/xfs_mount.c
@@ -117,7 +117,7 @@ xfs_mount_init(void)
 
 	AIL_LOCKINIT(&mp->m_ail_lock, "xfs_ail");
 	spinlock_init(&mp->m_sb_lock, "xfs_sb");
-	mutex_init(&mp->m_ilock, MUTEX_DEFAULT, "xfs_ilock");
+	mutex_init(&mp->m_ilock);
 	initnsema(&mp->m_growlock, 1, "xfs_grow");
 	/*
 	 * Initialize the AIL.
Index: linux/fs/xfs/xfs_mount.h
===================================================================
--- linux.orig/fs/xfs/xfs_mount.h
+++ linux/fs/xfs/xfs_mount.h
@@ -533,7 +533,7 @@ typedef struct xfs_mod_sb {
 	int		msb_delta;	/* Change to make to specified field */
 } xfs_mod_sb_t;
 
-#define	XFS_MOUNT_ILOCK(mp)	mutex_lock(&((mp)->m_ilock), PINOD)
+#define	XFS_MOUNT_ILOCK(mp)	mutex_lock(&((mp)->m_ilock))
 #define	XFS_MOUNT_IUNLOCK(mp)	mutex_unlock(&((mp)->m_ilock))
 #define	XFS_SB_LOCK(mp)		mutex_spinlock(&(mp)->m_sb_lock)
 #define	XFS_SB_UNLOCK(mp,s)	mutex_spinunlock(&(mp)->m_sb_lock,(s))
