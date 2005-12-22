Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVLVXHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVLVXHY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVLVXGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:06:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:20128 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030360AbVLVXGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:06:21 -0500
Date: Fri, 23 Dec 2005 00:05:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 8/8] mutex subsystem, XFS namespace collision fixes
Message-ID: <20051222230532.GI13302@elte.hu>
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

Fixup the XFS code to avoid name clashing with the mutex code by 
introducing xfs_mutex_ functions. [this causes no change in the
resulting code.]

Signed-off-by: Jes Sorensen <jes@trained-monkey.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----

 fs/xfs/linux-2.6/mutex.h       |   10 +++++-----
 fs/xfs/quota/xfs_dquot.c       |   12 ++++++------
 fs/xfs/quota/xfs_dquot.h       |    4 ++--
 fs/xfs/quota/xfs_qm.c          |   20 ++++++++++----------
 fs/xfs/quota/xfs_qm.h          |    4 ++--
 fs/xfs/quota/xfs_qm_bhv.c      |    2 +-
 fs/xfs/quota/xfs_qm_syscalls.c |   24 ++++++++++++------------
 fs/xfs/quota/xfs_quota_priv.h  |    8 ++++----
 fs/xfs/support/uuid.c          |   12 ++++++------
 fs/xfs/xfs_mount.c             |    4 ++--
 fs/xfs/xfs_mount.h             |    4 ++--
 11 files changed, 52 insertions(+), 52 deletions(-)

Index: linux/fs/xfs/linux-2.6/mutex.h
===================================================================
--- linux.orig/fs/xfs/linux-2.6/mutex.h
+++ linux/fs/xfs/linux-2.6/mutex.h
@@ -30,10 +30,10 @@
 #define MUTEX_DEFAULT		0x0
 typedef struct semaphore	mutex_t;
 
-#define mutex_init(lock, type, name)		sema_init(lock, 1)
-#define mutex_destroy(lock)			sema_init(lock, -99)
-#define mutex_lock(lock, num)			down(lock)
-#define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
-#define mutex_unlock(lock)			up(lock)
+#define xfs_mutex_init(lock, type, name)	sema_init(lock, 1)
+#define xfs_mutex_destroy(lock)			sema_init(lock, -99)
+#define xfs_mutex_lock(lock, num)		down(lock)
+#define xfs_mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
+#define xfs_mutex_unlock(lock)			up(lock)
 
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
+		xfs_mutex_init(&dqp->q_qlock,  MUTEX_DEFAULT, "xdq");
 		initnsema(&dqp->q_flock, 1, "fdq");
 		sv_init(&dqp->q_pinwait, SV_DEFAULT, "pdq");
 
@@ -153,7 +153,7 @@ xfs_qm_dqdestroy(
 {
 	ASSERT(! XFS_DQ_IS_ON_FREELIST(dqp));
 
-	mutex_destroy(&dqp->q_qlock);
+	xfs_mutex_destroy(&dqp->q_qlock);
 	freesema(&dqp->q_flock);
 	sv_destroy(&dqp->q_pinwait);
 
@@ -1375,21 +1375,21 @@ int
 xfs_qm_dqlock_nowait(
 	xfs_dquot_t *dqp)
 {
-	return (mutex_trylock(&((dqp)->q_qlock)));
+	return (xfs_mutex_trylock(&((dqp)->q_qlock)));
 }
 
 void
 xfs_dqlock(
 	xfs_dquot_t *dqp)
 {
-	mutex_lock(&(dqp->q_qlock), PINOD);
+	xfs_mutex_lock(&(dqp->q_qlock), PINOD);
 }
 
 void
 xfs_dqunlock(
 	xfs_dquot_t *dqp)
 {
-	mutex_unlock(&(dqp->q_qlock));
+	xfs_mutex_unlock(&(dqp->q_qlock));
 	if (dqp->q_logitem.qli_dquot == dqp) {
 		/* Once was dqp->q_mount, but might just have been cleared */
 		xfs_trans_unlocked_item(dqp->q_logitem.qli_item.li_mountp,
@@ -1402,7 +1402,7 @@ void
 xfs_dqunlock_nonotify(
 	xfs_dquot_t *dqp)
 {
-	mutex_unlock(&(dqp->q_qlock));
+	xfs_mutex_unlock(&(dqp->q_qlock));
 }
 
 void
Index: linux/fs/xfs/quota/xfs_dquot.h
===================================================================
--- linux.orig/fs/xfs/quota/xfs_dquot.h
+++ linux/fs/xfs/quota/xfs_dquot.h
@@ -103,8 +103,8 @@ typedef struct xfs_dquot {
 static inline int
 XFS_DQ_IS_LOCKED(xfs_dquot_t *dqp)
 {
-	if (mutex_trylock(&dqp->q_qlock)) {
-		mutex_unlock(&dqp->q_qlock);
+	if (xfs_mutex_trylock(&dqp->q_qlock)) {
+		xfs_mutex_unlock(&dqp->q_qlock);
 		return 0;
 	}
 	return 1;
Index: linux/fs/xfs/quota/xfs_qm.c
===================================================================
--- linux.orig/fs/xfs/quota/xfs_qm.c
+++ linux/fs/xfs/quota/xfs_qm.c
@@ -1166,7 +1166,7 @@ xfs_qm_init_quotainfo(
 	qinf->qi_dqreclaims = 0;
 
 	/* mutex used to serialize quotaoffs */
-	mutex_init(&qinf->qi_quotaofflock, MUTEX_DEFAULT, "qoff");
+	xfs_mutex_init(&qinf->qi_quotaofflock, MUTEX_DEFAULT, "qoff");
 
 	/* Precalc some constants */
 	qinf->qi_dqchunklen = XFS_FSB_TO_BB(mp, XFS_DQUOT_CLUSTER_SIZE_FSB);
@@ -1269,7 +1269,7 @@ xfs_qm_destroy_quotainfo(
 		XFS_PURGE_INODE(qi->qi_gquotaip);
 		qi->qi_gquotaip = NULL;
 	}
-	mutex_destroy(&qi->qi_quotaofflock);
+	xfs_mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi, sizeof(xfs_quotainfo_t));
 	mp->m_quotainfo = NULL;
 }
@@ -1285,7 +1285,7 @@ xfs_qm_list_init(
 	char		*str,
 	int		n)
 {
-	mutex_init(&list->qh_lock, MUTEX_DEFAULT, str);
+	xfs_mutex_init(&list->qh_lock, MUTEX_DEFAULT, str);
 	list->qh_next = NULL;
 	list->qh_version = 0;
 	list->qh_nelems = 0;
@@ -1295,7 +1295,7 @@ STATIC void
 xfs_qm_list_destroy(
 	xfs_dqlist_t	*list)
 {
-	mutex_destroy(&(list->qh_lock));
+	xfs_mutex_destroy(&(list->qh_lock));
 }
 
 
@@ -2762,7 +2762,7 @@ STATIC void
 xfs_qm_freelist_init(xfs_frlist_t *ql)
 {
 	ql->qh_next = ql->qh_prev = (xfs_dquot_t *) ql;
-	mutex_init(&ql->qh_lock, MUTEX_DEFAULT, "dqf");
+	xfs_mutex_init(&ql->qh_lock, MUTEX_DEFAULT, "dqf");
 	ql->qh_version = 0;
 	ql->qh_nelems = 0;
 }
@@ -2772,7 +2772,7 @@ xfs_qm_freelist_destroy(xfs_frlist_t *ql
 {
 	xfs_dquot_t	*dqp, *nextdqp;
 
-	mutex_lock(&ql->qh_lock, PINOD);
+	xfs_mutex_lock(&ql->qh_lock, PINOD);
 	for (dqp = ql->qh_next;
 	     dqp != (xfs_dquot_t *)ql; ) {
 		xfs_dqlock(dqp);
@@ -2788,7 +2788,7 @@ xfs_qm_freelist_destroy(xfs_frlist_t *ql
 	/*
 	 * Don't bother about unlocking.
 	 */
-	mutex_destroy(&ql->qh_lock);
+	xfs_mutex_destroy(&ql->qh_lock);
 
 	ASSERT(ql->qh_nelems == 0);
 }
@@ -2829,7 +2829,7 @@ xfs_qm_dqhashlock_nowait(
 {
 	int locked;
 
-	locked = mutex_trylock(&((dqp)->q_hash->qh_lock));
+	locked = xfs_mutex_trylock(&((dqp)->q_hash->qh_lock));
 	return (locked);
 }
 
@@ -2839,7 +2839,7 @@ xfs_qm_freelist_lock_nowait(
 {
 	int locked;
 
-	locked = mutex_trylock(&(xqm->qm_dqfreelist.qh_lock));
+	locked = xfs_mutex_trylock(&(xqm->qm_dqfreelist.qh_lock));
 	return (locked);
 }
 
@@ -2850,6 +2850,6 @@ xfs_qm_mplist_nowait(
 	int locked;
 
 	ASSERT(mp->m_quotainfo);
-	locked = mutex_trylock(&(XFS_QI_MPLLOCK(mp)));
+	locked = xfs_mutex_trylock(&(XFS_QI_MPLLOCK(mp)));
 	return (locked);
 }
Index: linux/fs/xfs/quota/xfs_qm.h
===================================================================
--- linux.orig/fs/xfs/quota/xfs_qm.h
+++ linux/fs/xfs/quota/xfs_qm.h
@@ -165,8 +165,8 @@ typedef struct xfs_dquot_acct {
 #define XFS_QM_IWARNLIMIT	5
 #define XFS_QM_RTBWARNLIMIT	5
 
-#define XFS_QM_LOCK(xqm)	(mutex_lock(&xqm##_lock, PINOD))
-#define XFS_QM_UNLOCK(xqm)	(mutex_unlock(&xqm##_lock))
+#define XFS_QM_LOCK(xqm)	(xfs_mutex_lock(&xqm##_lock, PINOD))
+#define XFS_QM_UNLOCK(xqm)	(xfs_mutex_unlock(&xqm##_lock))
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
+	xfs_mutex_init(&xfs_Gqm_lock, MUTEX_DEFAULT, "xfs_qmlock");
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
+		xfs_mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
 
 	ASSERT(mp->m_quotainfo);
 
@@ -246,7 +246,7 @@ xfs_qm_scall_quotaoff(
 		s = XFS_SB_LOCK(mp);
 		mp->m_sb.sb_qflags = mp->m_qflags;
 		XFS_SB_UNLOCK(mp, s);
-		mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
+		xfs_mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 
 		/* XXX what to do if error ? Revert back to old vals incore ? */
 		error = xfs_qm_write_sb_changes(mp, XFS_SB_QFLAGS);
@@ -280,7 +280,7 @@ xfs_qm_scall_quotaoff(
 	 * turning off quota enforcement.
 	 */
 	if ((mp->m_qflags & flags) == 0) {
-		mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
+		xfs_mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 		return (0);
 	}
 
@@ -351,7 +351,7 @@ xfs_qm_scall_quotaoff(
 	 */
 	if (((flags & XFS_MOUNT_QUOTA_ALL) == XFS_MOUNT_QUOTA_SET1) ||
 	    ((flags & XFS_MOUNT_QUOTA_ALL) == XFS_MOUNT_QUOTA_SET2)) {
-		mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
+		xfs_mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 		xfs_qm_destroy_quotainfo(mp);
 		return (0);
 	}
@@ -368,7 +368,7 @@ xfs_qm_scall_quotaoff(
 		XFS_PURGE_INODE(XFS_QI_GQIP(mp));
 		XFS_QI_GQIP(mp) = NULL;
 	}
-	mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
+	xfs_mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 
 	return (error);
 }
@@ -508,9 +508,9 @@ xfs_qm_scall_quotaon(
 	/*
 	 * Switch on quota enforcement in core.
 	 */
-	mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
+	xfs_mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
 	mp->m_qflags |= (flags & XFS_ALL_QUOTA_ENFD);
-	mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
+	xfs_mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 
 	return (0);
 }
@@ -617,7 +617,7 @@ xfs_qm_scall_setqlim(
 	 * a quotaoff from happening). (XXXThis doesn't currently happen
 	 * because we take the vfslock before calling xfs_qm_sysent).
 	 */
-	mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
+	xfs_mutex_lock(&(XFS_QI_QOFFLOCK(mp)), PINOD);
 
 	/*
 	 * Get the dquot (locked), and join it to the transaction.
@@ -625,7 +625,7 @@ xfs_qm_scall_setqlim(
 	 */
 	if ((error = xfs_qm_dqget(mp, NULL, id, type, XFS_QMOPT_DQALLOC, &dqp))) {
 		xfs_trans_cancel(tp, XFS_TRANS_ABORT);
-		mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
+		xfs_mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 		ASSERT(error != ENOENT);
 		return (error);
 	}
@@ -739,7 +739,7 @@ xfs_qm_scall_setqlim(
 	xfs_trans_commit(tp, 0, NULL);
 	xfs_qm_dqprint(dqp);
 	xfs_qm_dqrele(dqp);
-	mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
+	xfs_mutex_unlock(&(XFS_QI_QOFFLOCK(mp)));
 
 	return (0);
 }
@@ -1426,7 +1426,7 @@ xfs_qm_internalqcheck(
 	xfs_log_force(mp, (xfs_lsn_t)0, XFS_LOG_FORCE | XFS_LOG_SYNC);
 	XFS_bflush(mp->m_ddev_targp);
 
-	mutex_lock(&qcheck_lock, PINOD);
+	xfs_mutex_lock(&qcheck_lock, PINOD);
 	/* There should be absolutely no quota activity while this
 	   is going on. */
 	qmtest_udqtab = kmem_zalloc(qmtest_hashmask *
@@ -1473,7 +1473,7 @@ xfs_qm_internalqcheck(
 	}
 	kmem_free(qmtest_udqtab, qmtest_hashmask * sizeof(xfs_dqhash_t));
 	kmem_free(qmtest_gdqtab, qmtest_hashmask * sizeof(xfs_dqhash_t));
-	mutex_unlock(&qcheck_lock);
+	xfs_mutex_unlock(&qcheck_lock);
 	return (qmtest_nfails);
 }
 
Index: linux/fs/xfs/quota/xfs_quota_priv.h
===================================================================
--- linux.orig/fs/xfs/quota/xfs_quota_priv.h
+++ linux/fs/xfs/quota/xfs_quota_priv.h
@@ -51,14 +51,14 @@
 #define XFS_QI_MPLNEXT(mp)	((mp)->m_quotainfo->qi_dqlist.qh_next)
 #define XFS_QI_MPLNDQUOTS(mp)	((mp)->m_quotainfo->qi_dqlist.qh_nelems)
 
-#define XQMLCK(h)			(mutex_lock(&((h)->qh_lock), PINOD))
-#define XQMUNLCK(h)			(mutex_unlock(&((h)->qh_lock)))
+#define XQMLCK(h)			(xfs_mutex_lock(&((h)->qh_lock), PINOD))
+#define XQMUNLCK(h)			(xfs_mutex_unlock(&((h)->qh_lock)))
 #ifdef DEBUG
 struct xfs_dqhash;
 static inline int XQMISLCKD(struct xfs_dqhash *h)
 {
-	if (mutex_trylock(&h->qh_lock)) {
-		mutex_unlock(&h->qh_lock);
+	if (xfs_mutex_trylock(&h->qh_lock)) {
+		xfs_mutex_unlock(&h->qh_lock);
 		return 0;
 	}
 	return 1;
Index: linux/fs/xfs/support/uuid.c
===================================================================
--- linux.orig/fs/xfs/support/uuid.c
+++ linux/fs/xfs/support/uuid.c
@@ -24,7 +24,7 @@ static uuid_t	*uuid_table;
 void
 uuid_init(void)
 {
-	mutex_init(&uuid_monitor, MUTEX_DEFAULT, "uuid_monitor");
+	xfs_mutex_init(&uuid_monitor, MUTEX_DEFAULT, "uuid_monitor");
 }
 
 /*
@@ -94,14 +94,14 @@ uuid_table_insert(uuid_t *uuid)
 {
 	int	i, hole;
 
-	mutex_lock(&uuid_monitor, PVFS);
+	xfs_mutex_lock(&uuid_monitor, PVFS);
 	for (i = 0, hole = -1; i < uuid_table_size; i++) {
 		if (uuid_is_nil(&uuid_table[i])) {
 			hole = i;
 			continue;
 		}
 		if (uuid_equal(uuid, &uuid_table[i])) {
-			mutex_unlock(&uuid_monitor);
+			xfs_mutex_unlock(&uuid_monitor);
 			return 0;
 		}
 	}
@@ -113,7 +113,7 @@ uuid_table_insert(uuid_t *uuid)
 		hole = uuid_table_size++;
 	}
 	uuid_table[hole] = *uuid;
-	mutex_unlock(&uuid_monitor);
+	xfs_mutex_unlock(&uuid_monitor);
 	return 1;
 }
 
@@ -122,7 +122,7 @@ uuid_table_remove(uuid_t *uuid)
 {
 	int	i;
 
-	mutex_lock(&uuid_monitor, PVFS);
+	xfs_mutex_lock(&uuid_monitor, PVFS);
 	for (i = 0; i < uuid_table_size; i++) {
 		if (uuid_is_nil(&uuid_table[i]))
 			continue;
@@ -132,5 +132,5 @@ uuid_table_remove(uuid_t *uuid)
 		break;
 	}
 	ASSERT(i < uuid_table_size);
-	mutex_unlock(&uuid_monitor);
+	xfs_mutex_unlock(&uuid_monitor);
 }
Index: linux/fs/xfs/xfs_mount.c
===================================================================
--- linux.orig/fs/xfs/xfs_mount.c
+++ linux/fs/xfs/xfs_mount.c
@@ -117,7 +117,7 @@ xfs_mount_init(void)
 
 	AIL_LOCKINIT(&mp->m_ail_lock, "xfs_ail");
 	spinlock_init(&mp->m_sb_lock, "xfs_sb");
-	mutex_init(&mp->m_ilock, MUTEX_DEFAULT, "xfs_ilock");
+	xfs_mutex_init(&mp->m_ilock, MUTEX_DEFAULT, "xfs_ilock");
 	initnsema(&mp->m_growlock, 1, "xfs_grow");
 	/*
 	 * Initialize the AIL.
@@ -158,7 +158,7 @@ xfs_mount_free(
 
 	AIL_LOCK_DESTROY(&mp->m_ail_lock);
 	spinlock_destroy(&mp->m_sb_lock);
-	mutex_destroy(&mp->m_ilock);
+	xfs_mutex_destroy(&mp->m_ilock);
 	freesema(&mp->m_growlock);
 	if (mp->m_quotainfo)
 		XFS_QM_DONE(mp);
Index: linux/fs/xfs/xfs_mount.h
===================================================================
--- linux.orig/fs/xfs/xfs_mount.h
+++ linux/fs/xfs/xfs_mount.h
@@ -533,8 +533,8 @@ typedef struct xfs_mod_sb {
 	int		msb_delta;	/* Change to make to specified field */
 } xfs_mod_sb_t;
 
-#define	XFS_MOUNT_ILOCK(mp)	mutex_lock(&((mp)->m_ilock), PINOD)
-#define	XFS_MOUNT_IUNLOCK(mp)	mutex_unlock(&((mp)->m_ilock))
+#define	XFS_MOUNT_ILOCK(mp)	xfs_mutex_lock(&((mp)->m_ilock), PINOD)
+#define	XFS_MOUNT_IUNLOCK(mp)	xfs_mutex_unlock(&((mp)->m_ilock))
 #define	XFS_SB_LOCK(mp)		mutex_spinlock(&(mp)->m_sb_lock)
 #define	XFS_SB_UNLOCK(mp,s)	mutex_spinunlock(&(mp)->m_sb_lock,(s))
 
