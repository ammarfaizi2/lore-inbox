Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933079AbWFZWDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933079AbWFZWDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933077AbWFZWDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:03:39 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:14146 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933078AbWFZWDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:03:36 -0400
Date: Mon, 26 Jun 2006 15:03:17 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [resend] [git patches] ocfs2 fixes
Message-ID: <20060626220317.GA4036@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
 	This is my 3rd attempt at getting you to pull this update. If
there's nothing wrong with the patches, I'd really appreciate them getting
upstream before -rc1... Thanks,
	--Mark

Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git

to receive the following updates:

 fs/ocfs2/dlm/dlmdebug.h    |   30 --
 fs/ocfs2/dlm/dlmast.c      |   12 
 fs/ocfs2/dlm/dlmcommon.h   |   63 ++++
 fs/ocfs2/dlm/dlmconvert.c  |   24 +
 fs/ocfs2/dlm/dlmdebug.c    |    6 
 fs/ocfs2/dlm/dlmdomain.c   |  101 +++++--
 fs/ocfs2/dlm/dlmfs.c       |    6 
 fs/ocfs2/dlm/dlmlock.c     |   68 ++++-
 fs/ocfs2/dlm/dlmmaster.c   |  448 +++++++++++++++++++++++-----------
 fs/ocfs2/dlm/dlmrecovery.c |  580 ++++++++++++++++++++++++++++++++++-----------
 fs/ocfs2/dlm/dlmthread.c   |   68 ++++-
 fs/ocfs2/dlm/dlmunlock.c   |   10 
 fs/ocfs2/dlm/userdlm.c     |    2 
 13 files changed, 1045 insertions(+), 373 deletions(-)

Adrian Bunk:
      fs/ocfs2/dlm/: cleanups

Daniel Phillips:
      Clean up ocfs2 hash probe and make it faster
      ocfs2: allocate lockres hash pages in an array

Joel Becker:
      ocfs2: Alloc at least a page for the DLM hash

Kurt Hackel:
      ocfs2: add a small delay after a failed migration
      ocfs2: recheck lockres master before sending an unlock request.
      ocfs2: fix inverted logic in dlm_is_node_dead
      ocfs2: Fix empty lvb check
      ocfs2: Better tracking for recovery state changes
      ocfs2: only recover one dead node at a time
      ocfs2: handle network errors during recovery
      ocfs2: clean up recovery related messages
      ocfs2: better mle debugging
      ocfs2: mle ref counting fixes
      ocfs2: detach mle from heartbeat events
      ocfs2: properly initialize the mle structure
      ocfs2: take mle reference during migration
      ocfs2: allow for an assert message during lock mastery
      ocfs2: mle ref count debugging
      ocfs2: dump lockres info before we BUG() on a bad reference
      ocfs2: better error handling during assert master message
      ocfs2: dlm recovery / lockres reference count fix
      ocfs2: make dlm recovery finalization 2 stage
      ocfs2: dump mismatching migrated lvbs before BUG()
      ocfs2: purge lockres' sooner
      ocfs2: do not send master requests to localhost
      ocfs2: update lvb immediately during recovery
      ocfs2: gracefully handle stale create_lock messages.
      ocfs2: teach dlm_restart_lock_mastery() to wait on recovery
      ocfs2: give the dlm dirty list a reference on the lockres
      ocfs2: have dlm_pre_master_reco_lockres() ignore dead nodes
      ocfs2: increase backoff before waiting for recovery
      ocfs2: do not unconditionally purge the lockres in dlmlock_remote()
      ocfs2: temporarily disable automatic lock migration
      ocfs2: pending mastery asserts and migrations should block each other
      ocfs2: special case recovery lock in dlmlock_remote()
      ocfs2: dlm_remaster_locks() should never exit without completing
      ocfs2: remove unneccesary spin_unlock() in dlm_remaster_locks()
      ocfs2: continue recovery when a dead node is encountered
      ocfs2: wait for recovery when starting lock mastery
      ocfs2: use GFP_NOFS in some dlm operations
      ocfs2: use cond_resched() in dlm_thread()
      ocfs2: retry operations when a lock is marked in recovery
      ocfs2: mlog in dlm_convert_lock_handler() should be ML_ERROR
      ocfs2: display message before waiting for recovery to complete
      ocfs2: tune down some noisy messages during dlm recovery
      ocfs2: fix incorrect error returns
      ocfs2: move dlm work to a private work queue
      ocfs2: remove whitespace in dlmunlock.c

Mark Fasheh:
      ocfs2: move lockres qstr next to hlist_node structure
      ocfs2: calculate lockid hash values outside of the spinlock
      ocfs2: inline dlm_lockres_get()
      ocfs2: silence a compile warning in dlm_alloc_pagevec()
      ocfs2: do LVB puts in place
      ocfs2: dlm_print_one_mle() needs to be defined
      ocfs2: fix compiler warnings in dlm_convert_lock_handler()

diff --git a/fs/ocfs2/dlm/dlmast.c b/fs/ocfs2/dlm/dlmast.c
index 87ee29c..42775e2 100644
--- a/fs/ocfs2/dlm/dlmast.c
+++ b/fs/ocfs2/dlm/dlmast.c
@@ -197,12 +197,14 @@ static void dlm_update_lvb(struct dlm_ct
 				  lock->ml.node == dlm->node_num ? "master" :
 				  "remote");
 			memcpy(lksb->lvb, res->lvb, DLM_LVB_LEN);
-		} else if (lksb->flags & DLM_LKSB_PUT_LVB) {
-			mlog(0, "setting lvb from lockres for %s node\n",
-				  lock->ml.node == dlm->node_num ? "master" :
-				  "remote");
-			memcpy(res->lvb, lksb->lvb, DLM_LVB_LEN);
 		}
+		/* Do nothing for lvb put requests - they should be done in
+ 		 * place when the lock is downconverted - otherwise we risk
+ 		 * racing gets and puts which could result in old lvb data
+ 		 * being propagated. We leave the put flag set and clear it
+ 		 * here. In the future we might want to clear it at the time
+ 		 * the put is actually done.
+		 */
 		spin_unlock(&res->spinlock);
 	}
 
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 88cc43d..9bdc9cf 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -37,7 +37,17 @@ #define DLM_LOCK_RES_OWNER_UNKNOWN     O
 #define DLM_THREAD_SHUFFLE_INTERVAL    5     // flush everything every 5 passes
 #define DLM_THREAD_MS                  200   // flush at least every 200 ms
 
-#define DLM_HASH_BUCKETS     (PAGE_SIZE / sizeof(struct hlist_head))
+#define DLM_HASH_SIZE_DEFAULT	(1 << 14)
+#if DLM_HASH_SIZE_DEFAULT < PAGE_SIZE
+# define DLM_HASH_PAGES		1
+#else
+# define DLM_HASH_PAGES		(DLM_HASH_SIZE_DEFAULT / PAGE_SIZE)
+#endif
+#define DLM_BUCKETS_PER_PAGE	(PAGE_SIZE / sizeof(struct hlist_head))
+#define DLM_HASH_BUCKETS	(DLM_HASH_PAGES * DLM_BUCKETS_PER_PAGE)
+
+/* Intended to make it easier for us to switch out hash functions */
+#define dlm_lockid_hash(_n, _l) full_name_hash(_n, _l)
 
 enum dlm_ast_type {
 	DLM_AST = 0,
@@ -61,7 +71,8 @@ static inline int dlm_is_recovery_lock(c
 	return 0;
 }
 
-#define DLM_RECO_STATE_ACTIVE  0x0001
+#define DLM_RECO_STATE_ACTIVE    0x0001
+#define DLM_RECO_STATE_FINALIZE  0x0002
 
 struct dlm_recovery_ctxt
 {
@@ -85,7 +96,7 @@ enum dlm_ctxt_state {
 struct dlm_ctxt
 {
 	struct list_head list;
-	struct hlist_head *lockres_hash;
+	struct hlist_head **lockres_hash;
 	struct list_head dirty_list;
 	struct list_head purge_list;
 	struct list_head pending_asts;
@@ -120,6 +131,7 @@ struct dlm_ctxt
 	struct o2hb_callback_func dlm_hb_down;
 	struct task_struct *dlm_thread_task;
 	struct task_struct *dlm_reco_thread_task;
+	struct workqueue_struct *dlm_worker;
 	wait_queue_head_t dlm_thread_wq;
 	wait_queue_head_t dlm_reco_thread_wq;
 	wait_queue_head_t ast_wq;
@@ -132,6 +144,11 @@ struct dlm_ctxt
 	struct list_head	dlm_eviction_callbacks;
 };
 
+static inline struct hlist_head *dlm_lockres_hash(struct dlm_ctxt *dlm, unsigned i)
+{
+	return dlm->lockres_hash[(i / DLM_BUCKETS_PER_PAGE) % DLM_HASH_PAGES] + (i % DLM_BUCKETS_PER_PAGE);
+}
+
 /* these keventd work queue items are for less-frequently
  * called functions that cannot be directly called from the
  * net message handlers for some reason, usually because
@@ -216,20 +233,29 @@ struct dlm_lock_resource
 	/* WARNING: Please see the comment in dlm_init_lockres before
 	 * adding fields here. */
 	struct hlist_node hash_node;
+	struct qstr lockname;
 	struct kref      refs;
 
-	/* please keep these next 3 in this order
-	 * some funcs want to iterate over all lists */
+	/*
+	 * Please keep granted, converting, and blocked in this order,
+	 * as some funcs want to iterate over all lists.
+	 *
+	 * All four lists are protected by the hash's reference.
+	 */
 	struct list_head granted;
 	struct list_head converting;
 	struct list_head blocked;
+	struct list_head purge;
 
+	/*
+	 * These two lists require you to hold an additional reference
+	 * while they are on the list.
+	 */
 	struct list_head dirty;
 	struct list_head recovering; // dlm_recovery_ctxt.resources list
 
 	/* unused lock resources have their last_used stamped and are
 	 * put on a list for the dlm thread to run. */
-	struct list_head purge;
 	unsigned long    last_used;
 
 	unsigned migration_pending:1;
@@ -238,7 +264,6 @@ struct dlm_lock_resource
 	wait_queue_head_t wq;
 	u8  owner;              //node which owns the lock resource, or unknown
 	u16 state;
-	struct qstr lockname;
 	char lvb[DLM_LVB_LEN];
 };
 
@@ -300,6 +325,15 @@ enum dlm_lockres_list {
 	DLM_BLOCKED_LIST
 };
 
+static inline int dlm_lvb_is_empty(char *lvb)
+{
+	int i;
+	for (i=0; i<DLM_LVB_LEN; i++)
+		if (lvb[i])
+			return 0;
+	return 1;
+}
+
 static inline struct list_head *
 dlm_list_idx_to_ptr(struct dlm_lock_resource *res, enum dlm_lockres_list idx)
 {
@@ -609,7 +643,8 @@ struct dlm_finalize_reco
 {
 	u8 node_idx;
 	u8 dead_node;
-	__be16 pad1;
+	u8 flags;
+	u8 pad1;
 	__be32 pad2;
 };
 
@@ -676,6 +711,7 @@ void dlm_wait_for_recovery(struct dlm_ct
 void dlm_kick_recovery_thread(struct dlm_ctxt *dlm);
 int dlm_is_node_dead(struct dlm_ctxt *dlm, u8 node);
 int dlm_wait_for_node_death(struct dlm_ctxt *dlm, u8 node, int timeout);
+int dlm_wait_for_node_recovery(struct dlm_ctxt *dlm, u8 node, int timeout);
 
 void dlm_put(struct dlm_ctxt *dlm);
 struct dlm_ctxt *dlm_grab(struct dlm_ctxt *dlm);
@@ -687,14 +723,20 @@ void dlm_lockres_calc_usage(struct dlm_c
 			    struct dlm_lock_resource *res);
 void dlm_purge_lockres(struct dlm_ctxt *dlm,
 		       struct dlm_lock_resource *lockres);
-void dlm_lockres_get(struct dlm_lock_resource *res);
+static inline void dlm_lockres_get(struct dlm_lock_resource *res)
+{
+	/* This is called on every lookup, so it might be worth
+	 * inlining. */
+	kref_get(&res->refs);
+}
 void dlm_lockres_put(struct dlm_lock_resource *res);
 void __dlm_unhash_lockres(struct dlm_lock_resource *res);
 void __dlm_insert_lockres(struct dlm_ctxt *dlm,
 			  struct dlm_lock_resource *res);
 struct dlm_lock_resource * __dlm_lookup_lockres(struct dlm_ctxt *dlm,
 						const char *name,
-						unsigned int len);
+						unsigned int len,
+						unsigned int hash);
 struct dlm_lock_resource * dlm_lookup_lockres(struct dlm_ctxt *dlm,
 					      const char *name,
 					      unsigned int len);
@@ -819,6 +861,7 @@ void dlm_clean_master_list(struct dlm_ct
 			   u8 dead_node);
 int dlm_lock_basts_flushed(struct dlm_ctxt *dlm, struct dlm_lock *lock);
 
+int __dlm_lockres_unused(struct dlm_lock_resource *res);
 
 static inline const char * dlm_lock_mode_name(int mode)
 {
diff --git a/fs/ocfs2/dlm/dlmconvert.c b/fs/ocfs2/dlm/dlmconvert.c
index 70888b3..c764dc8 100644
--- a/fs/ocfs2/dlm/dlmconvert.c
+++ b/fs/ocfs2/dlm/dlmconvert.c
@@ -214,6 +214,9 @@ grant:
 	if (lock->ml.node == dlm->node_num)
 		mlog(0, "doing in-place convert for nonlocal lock\n");
 	lock->ml.type = type;
+	if (lock->lksb->flags & DLM_LKSB_PUT_LVB)
+		memcpy(res->lvb, lock->lksb->lvb, DLM_LVB_LEN);
+
 	status = DLM_NORMAL;
 	*call_ast = 1;
 	goto unlock_exit;
@@ -461,6 +464,12 @@ int dlm_convert_lock_handler(struct o2ne
 	}
 
 	spin_lock(&res->spinlock);
+	status = __dlm_lockres_state_to_status(res);
+	if (status != DLM_NORMAL) {
+		spin_unlock(&res->spinlock);
+		dlm_error(status);
+		goto leave;
+	}
 	list_for_each(iter, &res->granted) {
 		lock = list_entry(iter, struct dlm_lock, list);
 		if (lock->ml.cookie == cnv->cookie &&
@@ -470,6 +479,21 @@ int dlm_convert_lock_handler(struct o2ne
 		}
 		lock = NULL;
 	}
+	if (!lock) {
+		__dlm_print_one_lock_resource(res);
+		list_for_each(iter, &res->granted) {
+			lock = list_entry(iter, struct dlm_lock, list);
+			if (lock->ml.node == cnv->node_idx) {
+				mlog(ML_ERROR, "There is something here "
+				     "for node %u, lock->ml.cookie=%llu, "
+				     "cnv->cookie=%llu\n", cnv->node_idx,
+				     (unsigned long long)lock->ml.cookie,
+				     (unsigned long long)cnv->cookie);
+				break;
+			}
+		}
+		lock = NULL;
+	}
 	spin_unlock(&res->spinlock);
 	if (!lock) {
 		status = DLM_IVLOCKID;
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index c7eae5d..3f6c8d8 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -37,10 +37,8 @@ #include "cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
-#include "dlmdebug.h"
 
 #include "dlmdomain.h"
-#include "dlmdebug.h"
 
 #define MLOG_MASK_PREFIX ML_DLM
 #include "cluster/masklog.h"
@@ -120,6 +118,7 @@ void dlm_print_one_lock(struct dlm_lock 
 }
 EXPORT_SYMBOL_GPL(dlm_print_one_lock);
 
+#if 0
 void dlm_dump_lock_resources(struct dlm_ctxt *dlm)
 {
 	struct dlm_lock_resource *res;
@@ -136,12 +135,13 @@ void dlm_dump_lock_resources(struct dlm_
 
 	spin_lock(&dlm->spinlock);
 	for (i=0; i<DLM_HASH_BUCKETS; i++) {
-		bucket = &(dlm->lockres_hash[i]);
+		bucket = dlm_lockres_hash(dlm, i);
 		hlist_for_each_entry(res, iter, bucket, hash_node)
 			dlm_print_one_lock_resource(res);
 	}
 	spin_unlock(&dlm->spinlock);
 }
+#endif  /*  0  */
 
 static const char *dlm_errnames[] = {
 	[DLM_NORMAL] =			"DLM_NORMAL",
diff --git a/fs/ocfs2/dlm/dlmdebug.h b/fs/ocfs2/dlm/dlmdebug.h
deleted file mode 100644
index 6858510..0000000
--- a/fs/ocfs2/dlm/dlmdebug.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* -*- mode: c; c-basic-offset: 8; -*-
- * vim: noexpandtab sw=8 ts=8 sts=0:
- *
- * dlmdebug.h
- *
- * Copyright (C) 2004 Oracle.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 021110-1307, USA.
- *
- */
-
-#ifndef DLMDEBUG_H
-#define DLMDEBUG_H
-
-void dlm_dump_lock_resources(struct dlm_ctxt *dlm);
-
-#endif
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 8f3a9e3..ba27c5c 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -41,7 +41,6 @@ #include "cluster/tcp.h"
 #include "dlmapi.h"
 #include "dlmcommon.h"
 
-#include "dlmdebug.h"
 #include "dlmdomain.h"
 
 #include "dlmver.h"
@@ -49,6 +48,33 @@ #include "dlmver.h"
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_DOMAIN)
 #include "cluster/masklog.h"
 
+static void dlm_free_pagevec(void **vec, int pages)
+{
+	while (pages--)
+		free_page((unsigned long)vec[pages]);
+	kfree(vec);
+}
+
+static void **dlm_alloc_pagevec(int pages)
+{
+	void **vec = kmalloc(pages * sizeof(void *), GFP_KERNEL);
+	int i;
+
+	if (!vec)
+		return NULL;
+
+	for (i = 0; i < pages; i++)
+		if (!(vec[i] = (void *)__get_free_page(GFP_KERNEL)))
+			goto out_free;
+
+	mlog(0, "Allocated DLM hash pagevec; %d pages (%lu expected), %lu buckets per page\n",
+	     pages, DLM_HASH_PAGES, (unsigned long)DLM_BUCKETS_PER_PAGE);
+	return vec;
+out_free:
+	dlm_free_pagevec(vec, i);
+	return NULL;
+}
+
 /*
  *
  * spinlock lock ordering: if multiple locks are needed, obey this ordering:
@@ -90,8 +116,7 @@ void __dlm_insert_lockres(struct dlm_ctx
 	assert_spin_locked(&dlm->spinlock);
 
 	q = &res->lockname;
-	q->hash = full_name_hash(q->name, q->len);
-	bucket = &(dlm->lockres_hash[q->hash % DLM_HASH_BUCKETS]);
+	bucket = dlm_lockres_hash(dlm, q->hash);
 
 	/* get a reference for our hashtable */
 	dlm_lockres_get(res);
@@ -100,34 +125,32 @@ void __dlm_insert_lockres(struct dlm_ctx
 }
 
 struct dlm_lock_resource * __dlm_lookup_lockres(struct dlm_ctxt *dlm,
-					 const char *name,
-					 unsigned int len)
+						const char *name,
+						unsigned int len,
+						unsigned int hash)
 {
-	unsigned int hash;
-	struct hlist_node *iter;
-	struct dlm_lock_resource *tmpres=NULL;
 	struct hlist_head *bucket;
+	struct hlist_node *list;
 
 	mlog_entry("%.*s\n", len, name);
 
 	assert_spin_locked(&dlm->spinlock);
 
-	hash = full_name_hash(name, len);
-
-	bucket = &(dlm->lockres_hash[hash % DLM_HASH_BUCKETS]);
-
-	/* check for pre-existing lock */
-	hlist_for_each(iter, bucket) {
-		tmpres = hlist_entry(iter, struct dlm_lock_resource, hash_node);
-		if (tmpres->lockname.len == len &&
-		    memcmp(tmpres->lockname.name, name, len) == 0) {
-			dlm_lockres_get(tmpres);
-			break;
-		}
+	bucket = dlm_lockres_hash(dlm, hash);
 
-		tmpres = NULL;
+	hlist_for_each(list, bucket) {
+		struct dlm_lock_resource *res = hlist_entry(list,
+			struct dlm_lock_resource, hash_node);
+		if (res->lockname.name[0] != name[0])
+			continue;
+		if (unlikely(res->lockname.len != len))
+			continue;
+		if (memcmp(res->lockname.name + 1, name + 1, len - 1))
+			continue;
+		dlm_lockres_get(res);
+		return res;
 	}
-	return tmpres;
+	return NULL;
 }
 
 struct dlm_lock_resource * dlm_lookup_lockres(struct dlm_ctxt *dlm,
@@ -135,9 +158,10 @@ struct dlm_lock_resource * dlm_lookup_lo
 				    unsigned int len)
 {
 	struct dlm_lock_resource *res;
+	unsigned int hash = dlm_lockid_hash(name, len);
 
 	spin_lock(&dlm->spinlock);
-	res = __dlm_lookup_lockres(dlm, name, len);
+	res = __dlm_lookup_lockres(dlm, name, len, hash);
 	spin_unlock(&dlm->spinlock);
 	return res;
 }
@@ -194,7 +218,7 @@ static int dlm_wait_on_domain_helper(con
 static void dlm_free_ctxt_mem(struct dlm_ctxt *dlm)
 {
 	if (dlm->lockres_hash)
-		free_page((unsigned long) dlm->lockres_hash);
+		dlm_free_pagevec((void **)dlm->lockres_hash, DLM_HASH_PAGES);
 
 	if (dlm->name)
 		kfree(dlm->name);
@@ -278,11 +302,21 @@ int dlm_domain_fully_joined(struct dlm_c
 	return ret;
 }
 
+static void dlm_destroy_dlm_worker(struct dlm_ctxt *dlm)
+{
+	if (dlm->dlm_worker) {
+		flush_workqueue(dlm->dlm_worker);
+		destroy_workqueue(dlm->dlm_worker);
+		dlm->dlm_worker = NULL;
+	}
+}
+
 static void dlm_complete_dlm_shutdown(struct dlm_ctxt *dlm)
 {
 	dlm_unregister_domain_handlers(dlm);
 	dlm_complete_thread(dlm);
 	dlm_complete_recovery_thread(dlm);
+	dlm_destroy_dlm_worker(dlm);
 
 	/* We've left the domain. Now we can take ourselves out of the
 	 * list and allow the kref stuff to help us free the
@@ -304,8 +338,8 @@ static void dlm_migrate_all_locks(struct
 restart:
 	spin_lock(&dlm->spinlock);
 	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
-		while (!hlist_empty(&dlm->lockres_hash[i])) {
-			res = hlist_entry(dlm->lockres_hash[i].first,
+		while (!hlist_empty(dlm_lockres_hash(dlm, i))) {
+			res = hlist_entry(dlm_lockres_hash(dlm, i)->first,
 					  struct dlm_lock_resource, hash_node);
 			/* need reference when manually grabbing lockres */
 			dlm_lockres_get(res);
@@ -1126,6 +1160,13 @@ static int dlm_join_domain(struct dlm_ct
 		goto bail;
 	}
 
+	dlm->dlm_worker = create_singlethread_workqueue("dlm_wq");
+	if (!dlm->dlm_worker) {
+		status = -ENOMEM;
+		mlog_errno(status);
+		goto bail;
+	}
+
 	do {
 		unsigned int backoff;
 		status = dlm_try_to_join_domain(dlm);
@@ -1166,6 +1207,7 @@ bail:
 		dlm_unregister_domain_handlers(dlm);
 		dlm_complete_thread(dlm);
 		dlm_complete_recovery_thread(dlm);
+		dlm_destroy_dlm_worker(dlm);
 	}
 
 	return status;
@@ -1191,7 +1233,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
 		goto leave;
 	}
 
-	dlm->lockres_hash = (struct hlist_head *) __get_free_page(GFP_KERNEL);
+	dlm->lockres_hash = (struct hlist_head **)dlm_alloc_pagevec(DLM_HASH_PAGES);
 	if (!dlm->lockres_hash) {
 		mlog_errno(-ENOMEM);
 		kfree(dlm->name);
@@ -1200,8 +1242,8 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
 		goto leave;
 	}
 
-	for (i=0; i<DLM_HASH_BUCKETS; i++)
-		INIT_HLIST_HEAD(&dlm->lockres_hash[i]);
+	for (i = 0; i < DLM_HASH_BUCKETS; i++)
+		INIT_HLIST_HEAD(dlm_lockres_hash(dlm, i));
 
 	strcpy(dlm->name, domain);
 	dlm->key = key;
@@ -1231,6 +1273,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
 
 	dlm->dlm_thread_task = NULL;
 	dlm->dlm_reco_thread_task = NULL;
+	dlm->dlm_worker = NULL;
 	init_waitqueue_head(&dlm->dlm_thread_wq);
 	init_waitqueue_head(&dlm->dlm_reco_thread_wq);
 	init_waitqueue_head(&dlm->reco.event);
diff --git a/fs/ocfs2/dlm/dlmfs.c b/fs/ocfs2/dlm/dlmfs.c
index 7273d9f..033ad17 100644
--- a/fs/ocfs2/dlm/dlmfs.c
+++ b/fs/ocfs2/dlm/dlmfs.c
@@ -116,7 +116,7 @@ static int dlmfs_file_open(struct inode 
 	 * doesn't make sense for LVB writes. */
 	file->f_flags &= ~O_APPEND;
 
-	fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+	fp = kmalloc(sizeof(*fp), GFP_NOFS);
 	if (!fp) {
 		status = -ENOMEM;
 		goto bail;
@@ -196,7 +196,7 @@ static ssize_t dlmfs_file_read(struct fi
 	else
 		readlen = count - *ppos;
 
-	lvb_buf = kmalloc(readlen, GFP_KERNEL);
+	lvb_buf = kmalloc(readlen, GFP_NOFS);
 	if (!lvb_buf)
 		return -ENOMEM;
 
@@ -240,7 +240,7 @@ static ssize_t dlmfs_file_write(struct f
 	else
 		writelen = count - *ppos;
 
-	lvb_buf = kmalloc(writelen, GFP_KERNEL);
+	lvb_buf = kmalloc(writelen, GFP_NOFS);
 	if (!lvb_buf)
 		return -ENOMEM;
 
diff --git a/fs/ocfs2/dlm/dlmlock.c b/fs/ocfs2/dlm/dlmlock.c
index 55cda25..d6f8957 100644
--- a/fs/ocfs2/dlm/dlmlock.c
+++ b/fs/ocfs2/dlm/dlmlock.c
@@ -201,6 +201,7 @@ static enum dlm_status dlmlock_remote(st
 				      struct dlm_lock *lock, int flags)
 {
 	enum dlm_status status = DLM_DENIED;
+	int lockres_changed = 1;
 
 	mlog_entry("type=%d\n", lock->ml.type);
 	mlog(0, "lockres %.*s, flags = 0x%x\n", res->lockname.len,
@@ -226,8 +227,25 @@ static enum dlm_status dlmlock_remote(st
 	res->state &= ~DLM_LOCK_RES_IN_PROGRESS;
 	lock->lock_pending = 0;
 	if (status != DLM_NORMAL) {
-		if (status != DLM_NOTQUEUED)
+		if (status == DLM_RECOVERING &&
+		    dlm_is_recovery_lock(res->lockname.name,
+					 res->lockname.len)) {
+			/* recovery lock was mastered by dead node.
+			 * we need to have calc_usage shoot down this
+			 * lockres and completely remaster it. */
+			mlog(0, "%s: recovery lock was owned by "
+			     "dead node %u, remaster it now.\n",
+			     dlm->name, res->owner);
+		} else if (status != DLM_NOTQUEUED) {
+			/*
+			 * DO NOT call calc_usage, as this would unhash
+			 * the remote lockres before we ever get to use
+			 * it.  treat as if we never made any change to
+			 * the lockres.
+			 */
+			lockres_changed = 0;
 			dlm_error(status);
+		}
 		dlm_revert_pending_lock(res, lock);
 		dlm_lock_put(lock);
 	} else if (dlm_is_recovery_lock(res->lockname.name, 
@@ -243,7 +261,8 @@ static enum dlm_status dlmlock_remote(st
 	}
 	spin_unlock(&res->spinlock);
 
-	dlm_lockres_calc_usage(dlm, res);
+	if (lockres_changed)
+		dlm_lockres_calc_usage(dlm, res);
 
 	wake_up(&res->wq);
 	return status;
@@ -280,6 +299,14 @@ static enum dlm_status dlm_send_remote_l
 	if (tmpret >= 0) {
 		// successfully sent and received
 		ret = status;  // this is already a dlm_status
+		if (ret == DLM_REJECTED) {
+			mlog(ML_ERROR, "%s:%.*s: BUG.  this is a stale lockres "
+			     "no longer owned by %u.  that node is coming back "
+			     "up currently.\n", dlm->name, create.namelen,
+			     create.name, res->owner);
+			dlm_print_one_lock_resource(res);
+			BUG();
+		}
 	} else {
 		mlog_errno(tmpret);
 		if (dlm_is_host_down(tmpret)) {
@@ -381,13 +408,13 @@ struct dlm_lock * dlm_new_lock(int type,
 	struct dlm_lock *lock;
 	int kernel_allocated = 0;
 
-	lock = kcalloc(1, sizeof(*lock), GFP_KERNEL);
+	lock = kcalloc(1, sizeof(*lock), GFP_NOFS);
 	if (!lock)
 		return NULL;
 
 	if (!lksb) {
 		/* zero memory only if kernel-allocated */
-		lksb = kcalloc(1, sizeof(*lksb), GFP_KERNEL);
+		lksb = kcalloc(1, sizeof(*lksb), GFP_NOFS);
 		if (!lksb) {
 			kfree(lock);
 			return NULL;
@@ -428,11 +455,16 @@ int dlm_create_lock_handler(struct o2net
 	if (!dlm_grab(dlm))
 		return DLM_REJECTED;
 
-	mlog_bug_on_msg(!dlm_domain_fully_joined(dlm),
-			"Domain %s not fully joined!\n", dlm->name);
-
 	name = create->name;
 	namelen = create->namelen;
+	status = DLM_REJECTED;
+	if (!dlm_domain_fully_joined(dlm)) {
+		mlog(ML_ERROR, "Domain %s not fully joined, but node %u is "
+		     "sending a create_lock message for lock %.*s!\n",
+		     dlm->name, create->node_idx, namelen, name);
+		dlm_error(status);
+		goto leave;
+	}
 
 	status = DLM_IVBUFLEN;
 	if (namelen > DLM_LOCKID_NAME_MAX) {
@@ -668,18 +700,22 @@ retry_lock:
 			msleep(100);
 			/* no waiting for dlm_reco_thread */
 			if (recovery) {
-				if (status == DLM_RECOVERING) {
-					mlog(0, "%s: got RECOVERING "
-					     "for $REOCVERY lock, master "
-					     "was %u\n", dlm->name, 
-					     res->owner);
-					dlm_wait_for_node_death(dlm, res->owner, 
-							DLM_NODE_DEATH_WAIT_MAX);
-				}
+				if (status != DLM_RECOVERING)
+					goto retry_lock;
+
+				mlog(0, "%s: got RECOVERING "
+				     "for $RECOVERY lock, master "
+				     "was %u\n", dlm->name,
+				     res->owner);
+				/* wait to see the node go down, then
+				 * drop down and allow the lockres to
+				 * get cleaned up.  need to remaster. */
+				dlm_wait_for_node_death(dlm, res->owner,
+						DLM_NODE_DEATH_WAIT_MAX);
 			} else {
 				dlm_wait_for_recovery(dlm);
+				goto retry_lock;
 			}
-			goto retry_lock;
 		}
 
 		if (status != DLM_NORMAL) {
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 940be4c..1b8346d 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -47,7 +47,6 @@ #include "cluster/tcp.h"
 
 #include "dlmapi.h"
 #include "dlmcommon.h"
-#include "dlmdebug.h"
 #include "dlmdomain.h"
 
 #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_MASTER)
@@ -74,6 +73,7 @@ struct dlm_master_list_entry
 	wait_queue_head_t wq;
 	atomic_t woken;
 	struct kref mle_refs;
+	int inuse;
 	unsigned long maybe_map[BITS_TO_LONGS(O2NM_MAX_NODES)];
 	unsigned long vote_map[BITS_TO_LONGS(O2NM_MAX_NODES)];
 	unsigned long response_map[BITS_TO_LONGS(O2NM_MAX_NODES)];
@@ -127,18 +127,30 @@ static inline int dlm_mle_equal(struct d
 	return 1;
 }
 
-#if 0
-/* Code here is included but defined out as it aids debugging */
+#define dlm_print_nodemap(m)  _dlm_print_nodemap(m,#m)
+static void _dlm_print_nodemap(unsigned long *map, const char *mapname)
+{
+	int i;
+	printk("%s=[ ", mapname);
+	for (i=0; i<O2NM_MAX_NODES; i++)
+		if (test_bit(i, map))
+			printk("%d ", i);
+	printk("]");
+}
 
-void dlm_print_one_mle(struct dlm_master_list_entry *mle)
+static void dlm_print_one_mle(struct dlm_master_list_entry *mle)
 {
-	int i = 0, refs;
+	int refs;
 	char *type;
 	char attached;
 	u8 master;
 	unsigned int namelen;
 	const char *name;
 	struct kref *k;
+	unsigned long *maybe = mle->maybe_map,
+		      *vote = mle->vote_map,
+		      *resp = mle->response_map,
+		      *node = mle->node_map;
 
 	k = &mle->mle_refs;
 	if (mle->type == DLM_MLE_BLOCK)
@@ -159,18 +171,29 @@ void dlm_print_one_mle(struct dlm_master
 		name = mle->u.res->lockname.name;
 	}
 
-	mlog(ML_NOTICE, "  #%3d: %3s  %3d  %3u   %3u %c    (%d)%.*s\n",
-		  i, type, refs, master, mle->new_master, attached,
-		  namelen, namelen, name);
+	mlog(ML_NOTICE, "%.*s: %3s refs=%3d mas=%3u new=%3u evt=%c inuse=%d ",
+		  namelen, name, type, refs, master, mle->new_master, attached,
+		  mle->inuse);
+	dlm_print_nodemap(maybe);
+	printk(", ");
+	dlm_print_nodemap(vote);
+	printk(", ");
+	dlm_print_nodemap(resp);
+	printk(", ");
+	dlm_print_nodemap(node);
+	printk(", ");
+	printk("\n");
 }
 
+#if 0
+/* Code here is included but defined out as it aids debugging */
+
 static void dlm_dump_mles(struct dlm_ctxt *dlm)
 {
 	struct dlm_master_list_entry *mle;
 	struct list_head *iter;
 	
 	mlog(ML_NOTICE, "dumping all mles for domain %s:\n", dlm->name);
-	mlog(ML_NOTICE, "  ####: type refs owner new events? lockname nodemap votemap respmap maybemap\n");
 	spin_lock(&dlm->master_lock);
 	list_for_each(iter, &dlm->master_list) {
 		mle = list_entry(iter, struct dlm_master_list_entry, list);
@@ -314,6 +337,31 @@ static inline void dlm_mle_detach_hb_eve
 	spin_unlock(&dlm->spinlock);
 }
 
+static void dlm_get_mle_inuse(struct dlm_master_list_entry *mle)
+{
+	struct dlm_ctxt *dlm;
+	dlm = mle->dlm;
+
+	assert_spin_locked(&dlm->spinlock);
+	assert_spin_locked(&dlm->master_lock);
+	mle->inuse++;
+	kref_get(&mle->mle_refs);
+}
+
+static void dlm_put_mle_inuse(struct dlm_master_list_entry *mle)
+{
+	struct dlm_ctxt *dlm;
+	dlm = mle->dlm;
+
+	spin_lock(&dlm->spinlock);
+	spin_lock(&dlm->master_lock);
+	mle->inuse--;
+	__dlm_put_mle(mle);
+	spin_unlock(&dlm->master_lock);
+	spin_unlock(&dlm->spinlock);
+
+}
+
 /* remove from list and free */
 static void __dlm_put_mle(struct dlm_master_list_entry *mle)
 {
@@ -322,9 +370,14 @@ static void __dlm_put_mle(struct dlm_mas
 
 	assert_spin_locked(&dlm->spinlock);
 	assert_spin_locked(&dlm->master_lock);
-	BUG_ON(!atomic_read(&mle->mle_refs.refcount));
-
-	kref_put(&mle->mle_refs, dlm_mle_release);
+	if (!atomic_read(&mle->mle_refs.refcount)) {
+		/* this may or may not crash, but who cares.
+		 * it's a BUG. */
+		mlog(ML_ERROR, "bad mle: %p\n", mle);
+		dlm_print_one_mle(mle);
+		BUG();
+	} else
+		kref_put(&mle->mle_refs, dlm_mle_release);
 }
 
 
@@ -367,6 +420,7 @@ static void dlm_init_mle(struct dlm_mast
 	memset(mle->response_map, 0, sizeof(mle->response_map));
 	mle->master = O2NM_MAX_NODES;
 	mle->new_master = O2NM_MAX_NODES;
+	mle->inuse = 0;
 
 	if (mle->type == DLM_MLE_MASTER) {
 		BUG_ON(!res);
@@ -564,6 +618,28 @@ static void dlm_lockres_release(struct k
 	mlog(0, "destroying lockres %.*s\n", res->lockname.len,
 	     res->lockname.name);
 
+	if (!hlist_unhashed(&res->hash_node) ||
+	    !list_empty(&res->granted) ||
+	    !list_empty(&res->converting) ||
+	    !list_empty(&res->blocked) ||
+	    !list_empty(&res->dirty) ||
+	    !list_empty(&res->recovering) ||
+	    !list_empty(&res->purge)) {
+		mlog(ML_ERROR,
+		     "Going to BUG for resource %.*s."
+		     "  We're on a list! [%c%c%c%c%c%c%c]\n",
+		     res->lockname.len, res->lockname.name,
+		     !hlist_unhashed(&res->hash_node) ? 'H' : ' ',
+		     !list_empty(&res->granted) ? 'G' : ' ',
+		     !list_empty(&res->converting) ? 'C' : ' ',
+		     !list_empty(&res->blocked) ? 'B' : ' ',
+		     !list_empty(&res->dirty) ? 'D' : ' ',
+		     !list_empty(&res->recovering) ? 'R' : ' ',
+		     !list_empty(&res->purge) ? 'P' : ' ');
+
+		dlm_print_one_lock_resource(res);
+	}
+
 	/* By the time we're ready to blow this guy away, we shouldn't
 	 * be on any lists. */
 	BUG_ON(!hlist_unhashed(&res->hash_node));
@@ -579,11 +655,6 @@ static void dlm_lockres_release(struct k
 	kfree(res);
 }
 
-void dlm_lockres_get(struct dlm_lock_resource *res)
-{
-	kref_get(&res->refs);
-}
-
 void dlm_lockres_put(struct dlm_lock_resource *res)
 {
 	kref_put(&res->refs, dlm_lockres_release);
@@ -603,7 +674,7 @@ static void dlm_init_lockres(struct dlm_
 	memcpy(qname, name, namelen);
 
 	res->lockname.len = namelen;
-	res->lockname.hash = full_name_hash(name, namelen);
+	res->lockname.hash = dlm_lockid_hash(name, namelen);
 
 	init_waitqueue_head(&res->wq);
 	spin_lock_init(&res->spinlock);
@@ -637,11 +708,11 @@ struct dlm_lock_resource *dlm_new_lockre
 {
 	struct dlm_lock_resource *res;
 
-	res = kmalloc(sizeof(struct dlm_lock_resource), GFP_KERNEL);
+	res = kmalloc(sizeof(struct dlm_lock_resource), GFP_NOFS);
 	if (!res)
 		return NULL;
 
-	res->lockname.name = kmalloc(namelen, GFP_KERNEL);
+	res->lockname.name = kmalloc(namelen, GFP_NOFS);
 	if (!res->lockname.name) {
 		kfree(res);
 		return NULL;
@@ -677,19 +748,20 @@ struct dlm_lock_resource * dlm_get_lock_
 	int blocked = 0;
 	int ret, nodenum;
 	struct dlm_node_iter iter;
-	unsigned int namelen;
+	unsigned int namelen, hash;
 	int tries = 0;
 	int bit, wait_on_recovery = 0;
 
 	BUG_ON(!lockid);
 
 	namelen = strlen(lockid);
+	hash = dlm_lockid_hash(lockid, namelen);
 
 	mlog(0, "get lockres %s (len %d)\n", lockid, namelen);
 
 lookup:
 	spin_lock(&dlm->spinlock);
-	tmpres = __dlm_lookup_lockres(dlm, lockid, namelen);
+	tmpres = __dlm_lookup_lockres(dlm, lockid, namelen, hash);
 	if (tmpres) {
 		spin_unlock(&dlm->spinlock);
 		mlog(0, "found in hash!\n");
@@ -704,7 +776,7 @@ lookup:
 		mlog(0, "allocating a new resource\n");
 		/* nothing found and we need to allocate one. */
 		alloc_mle = (struct dlm_master_list_entry *)
-			kmem_cache_alloc(dlm_mle_cache, GFP_KERNEL);
+			kmem_cache_alloc(dlm_mle_cache, GFP_NOFS);
 		if (!alloc_mle)
 			goto leave;
 		res = dlm_new_lockres(dlm, lockid, namelen);
@@ -790,10 +862,11 @@ lookup:
 	 * if so, the creator of the BLOCK may try to put the last
 	 * ref at this time in the assert master handler, so we
 	 * need an extra one to keep from a bad ptr deref. */
-	dlm_get_mle(mle);
+	dlm_get_mle_inuse(mle);
 	spin_unlock(&dlm->master_lock);
 	spin_unlock(&dlm->spinlock);
 
+redo_request:
 	while (wait_on_recovery) {
 		/* any cluster changes that occurred after dropping the
 		 * dlm spinlock would be detectable be a change on the mle,
@@ -812,7 +885,7 @@ lookup:
 		} 
 
 		dlm_kick_recovery_thread(dlm);
-		msleep(100);
+		msleep(1000);
 		dlm_wait_for_recovery(dlm);
 
 		spin_lock(&dlm->spinlock);
@@ -825,13 +898,15 @@ lookup:
 		} else
 			wait_on_recovery = 0;
 		spin_unlock(&dlm->spinlock);
+
+		if (wait_on_recovery)
+			dlm_wait_for_node_recovery(dlm, bit, 10000);
 	}
 
 	/* must wait for lock to be mastered elsewhere */
 	if (blocked)
 		goto wait;
 
-redo_request:
 	ret = -EINVAL;
 	dlm_node_iter_init(mle->vote_map, &iter);
 	while ((nodenum = dlm_node_iter_next(&iter)) >= 0) {
@@ -856,6 +931,7 @@ wait:
 	/* keep going until the response map includes all nodes */
 	ret = dlm_wait_for_lock_mastery(dlm, res, mle, &blocked);
 	if (ret < 0) {
+		wait_on_recovery = 1;
 		mlog(0, "%s:%.*s: node map changed, redo the "
 		     "master request now, blocked=%d\n",
 		     dlm->name, res->lockname.len,
@@ -866,7 +942,7 @@ wait:
 			     dlm->name, res->lockname.len, 
 			     res->lockname.name, blocked);
 			dlm_print_one_lock_resource(res);
-			/* dlm_print_one_mle(mle); */
+			dlm_print_one_mle(mle);
 			tries = 0;
 		}
 		goto redo_request;
@@ -880,7 +956,7 @@ wait:
 	dlm_mle_detach_hb_events(dlm, mle);
 	dlm_put_mle(mle);
 	/* put the extra ref */
-	dlm_put_mle(mle);
+	dlm_put_mle_inuse(mle);
 
 wake_waiters:
 	spin_lock(&res->spinlock);
@@ -921,12 +997,14 @@ recheck:
 		spin_unlock(&res->spinlock);
 		/* this will cause the master to re-assert across
 		 * the whole cluster, freeing up mles */
-		ret = dlm_do_master_request(mle, res->owner);
-		if (ret < 0) {
-			/* give recovery a chance to run */
-			mlog(ML_ERROR, "link to %u went down?: %d\n", res->owner, ret);
-			msleep(500);
-			goto recheck;
+		if (res->owner != dlm->node_num) {
+			ret = dlm_do_master_request(mle, res->owner);
+			if (ret < 0) {
+				/* give recovery a chance to run */
+				mlog(ML_ERROR, "link to %u went down?: %d\n", res->owner, ret);
+				msleep(500);
+				goto recheck;
+			}
 		}
 		ret = 0;
 		goto leave;
@@ -962,6 +1040,12 @@ recheck:
 		     "rechecking now\n", dlm->name, res->lockname.len,
 		     res->lockname.name);
 		goto recheck;
+	} else {
+		if (!voting_done) {
+			mlog(0, "map not changed and voting not done "
+			     "for %s:%.*s\n", dlm->name, res->lockname.len,
+			     res->lockname.name);
+		}
 	}
 
 	if (m != O2NM_MAX_NODES) {
@@ -1129,18 +1213,6 @@ static int dlm_restart_lock_mastery(stru
 			set_bit(node, mle->vote_map);
 		} else {
 			mlog(ML_ERROR, "node down! %d\n", node);
-
-			/* if the node wasn't involved in mastery skip it,
-			 * but clear it out from the maps so that it will
-			 * not affect mastery of this lockres */
-			clear_bit(node, mle->response_map);
-			clear_bit(node, mle->vote_map);
-			if (!test_bit(node, mle->maybe_map))
-				goto next;
-
-			/* if we're already blocked on lock mastery, and the
-			 * dead node wasn't the expected master, or there is
-			 * another node in the maybe_map, keep waiting */
 			if (blocked) {
 				int lowest = find_next_bit(mle->maybe_map,
 						       O2NM_MAX_NODES, 0);
@@ -1148,54 +1220,53 @@ static int dlm_restart_lock_mastery(stru
 				/* act like it was never there */
 				clear_bit(node, mle->maybe_map);
 
-			       	if (node != lowest)
-					goto next;
-
-				mlog(ML_ERROR, "expected master %u died while "
-				     "this node was blocked waiting on it!\n",
-				     node);
-				lowest = find_next_bit(mle->maybe_map,
-						       O2NM_MAX_NODES,
-						       lowest+1);
-				if (lowest < O2NM_MAX_NODES) {
-					mlog(0, "still blocked. waiting "
-					     "on %u now\n", lowest);
-					goto next;
+			       	if (node == lowest) {
+					mlog(0, "expected master %u died"
+					    " while this node was blocked "
+					    "waiting on it!\n", node);
+					lowest = find_next_bit(mle->maybe_map,
+						       	O2NM_MAX_NODES,
+						       	lowest+1);
+					if (lowest < O2NM_MAX_NODES) {
+						mlog(0, "%s:%.*s:still "
+						     "blocked. waiting on %u "
+						     "now\n", dlm->name,
+						     res->lockname.len,
+						     res->lockname.name,
+						     lowest);
+					} else {
+						/* mle is an MLE_BLOCK, but
+						 * there is now nothing left to
+						 * block on.  we need to return
+						 * all the way back out and try
+						 * again with an MLE_MASTER.
+						 * dlm_do_local_recovery_cleanup
+						 * has already run, so the mle
+						 * refcount is ok */
+						mlog(0, "%s:%.*s: no "
+						     "longer blocking. try to "
+						     "master this here\n",
+						     dlm->name,
+						     res->lockname.len,
+						     res->lockname.name);
+						mle->type = DLM_MLE_MASTER;
+						mle->u.res = res;
+					}
 				}
-
-				/* mle is an MLE_BLOCK, but there is now
-				 * nothing left to block on.  we need to return
-				 * all the way back out and try again with
-				 * an MLE_MASTER. dlm_do_local_recovery_cleanup
-				 * has already run, so the mle refcount is ok */
-				mlog(0, "no longer blocking. we can "
-				     "try to master this here\n");
-				mle->type = DLM_MLE_MASTER;
-				memset(mle->maybe_map, 0,
-				       sizeof(mle->maybe_map));
-				memset(mle->response_map, 0,
-				       sizeof(mle->maybe_map));
-				memcpy(mle->vote_map, mle->node_map,
-				       sizeof(mle->node_map));
-				mle->u.res = res;
-				set_bit(dlm->node_num, mle->maybe_map);
-
-				ret = -EAGAIN;
-				goto next;
 			}
 
-			clear_bit(node, mle->maybe_map);
-			if (node > dlm->node_num)
-				goto next;
-
-			mlog(0, "dead node in map!\n");
-			/* yuck. go back and re-contact all nodes
-			 * in the vote_map, removing this node. */
-			memset(mle->response_map, 0,
-			       sizeof(mle->response_map));
+			/* now blank out everything, as if we had never
+			 * contacted anyone */
+			memset(mle->maybe_map, 0, sizeof(mle->maybe_map));
+			memset(mle->response_map, 0, sizeof(mle->response_map));
+			/* reset the vote_map to the current node_map */
+			memcpy(mle->vote_map, mle->node_map,
+			       sizeof(mle->node_map));
+			/* put myself into the maybe map */
+			if (mle->type != DLM_MLE_BLOCK)
+				set_bit(dlm->node_num, mle->maybe_map);
 		}
 		ret = -EAGAIN;
-next:
 		node = dlm_bitmap_diff_iter_next(&bdi, &sc);
 	}
 	return ret;
@@ -1316,7 +1387,7 @@ int dlm_master_request_handler(struct o2
 	struct dlm_master_request *request = (struct dlm_master_request *) msg->buf;
 	struct dlm_master_list_entry *mle = NULL, *tmpmle = NULL;
 	char *name;
-	unsigned int namelen;
+	unsigned int namelen, hash;
 	int found, ret;
 	int set_maybe;
 	int dispatch_assert = 0;
@@ -1331,6 +1402,7 @@ int dlm_master_request_handler(struct o2
 
 	name = request->name;
 	namelen = request->namelen;
+	hash = dlm_lockid_hash(name, namelen);
 
 	if (namelen > DLM_LOCKID_NAME_MAX) {
 		response = DLM_IVBUFLEN;
@@ -1339,7 +1411,7 @@ int dlm_master_request_handler(struct o2
 
 way_up_top:
 	spin_lock(&dlm->spinlock);
-	res = __dlm_lookup_lockres(dlm, name, namelen);
+	res = __dlm_lookup_lockres(dlm, name, namelen, hash);
 	if (res) {
 		spin_unlock(&dlm->spinlock);
 
@@ -1459,21 +1531,18 @@ way_up_top:
 			spin_unlock(&dlm->spinlock);
 
 			mle = (struct dlm_master_list_entry *)
-				kmem_cache_alloc(dlm_mle_cache, GFP_KERNEL);
+				kmem_cache_alloc(dlm_mle_cache, GFP_NOFS);
 			if (!mle) {
 				response = DLM_MASTER_RESP_ERROR;
 				mlog_errno(-ENOMEM);
 				goto send_response;
 			}
-			spin_lock(&dlm->spinlock);
-			dlm_init_mle(mle, DLM_MLE_BLOCK, dlm, NULL,
-					 name, namelen);
-			spin_unlock(&dlm->spinlock);
 			goto way_up_top;
 		}
 
 		// mlog(0, "this is second time thru, already allocated, "
 		// "add the block.\n");
+		dlm_init_mle(mle, DLM_MLE_BLOCK, dlm, NULL, name, namelen);
 		set_bit(request->node_idx, mle->maybe_map);
 		list_add(&mle->list, &dlm->master_list);
 		response = DLM_MASTER_RESP_NO;
@@ -1556,6 +1625,8 @@ again:
 	dlm_node_iter_init(nodemap, &iter);
 	while ((to = dlm_node_iter_next(&iter)) >= 0) {
 		int r = 0;
+		struct dlm_master_list_entry *mle = NULL;
+
 		mlog(0, "sending assert master to %d (%.*s)\n", to,
 		     namelen, lockname);
 		memset(&assert, 0, sizeof(assert));
@@ -1567,20 +1638,28 @@ again:
 		tmpret = o2net_send_message(DLM_ASSERT_MASTER_MSG, dlm->key,
 					    &assert, sizeof(assert), to, &r);
 		if (tmpret < 0) {
-			mlog(ML_ERROR, "assert_master returned %d!\n", tmpret);
+			mlog(0, "assert_master returned %d!\n", tmpret);
 			if (!dlm_is_host_down(tmpret)) {
-				mlog(ML_ERROR, "unhandled error!\n");
+				mlog(ML_ERROR, "unhandled error=%d!\n", tmpret);
 				BUG();
 			}
 			/* a node died.  finish out the rest of the nodes. */
-			mlog(ML_ERROR, "link to %d went down!\n", to);
+			mlog(0, "link to %d went down!\n", to);
 			/* any nonzero status return will do */
 			ret = tmpret;
 		} else if (r < 0) {
 			/* ok, something horribly messed.  kill thyself. */
 			mlog(ML_ERROR,"during assert master of %.*s to %u, "
 			     "got %d.\n", namelen, lockname, to, r);
-			dlm_dump_lock_resources(dlm);
+			spin_lock(&dlm->spinlock);
+			spin_lock(&dlm->master_lock);
+			if (dlm_find_mle(dlm, &mle, (char *)lockname,
+					 namelen)) {
+				dlm_print_one_mle(mle);
+				__dlm_put_mle(mle);
+			}
+			spin_unlock(&dlm->master_lock);
+			spin_unlock(&dlm->spinlock);
 			BUG();
 		} else if (r == EAGAIN) {
 			mlog(0, "%.*s: node %u create mles on other "
@@ -1612,7 +1691,7 @@ int dlm_assert_master_handler(struct o2n
 	struct dlm_assert_master *assert = (struct dlm_assert_master *)msg->buf;
 	struct dlm_lock_resource *res = NULL;
 	char *name;
-	unsigned int namelen;
+	unsigned int namelen, hash;
 	u32 flags;
 	int master_request = 0;
 	int ret = 0;
@@ -1622,6 +1701,7 @@ int dlm_assert_master_handler(struct o2n
 
 	name = assert->name;
 	namelen = assert->namelen;
+	hash = dlm_lockid_hash(name, namelen);
 	flags = be32_to_cpu(assert->flags);
 
 	if (namelen > DLM_LOCKID_NAME_MAX) {
@@ -1646,7 +1726,7 @@ int dlm_assert_master_handler(struct o2n
 		if (bit >= O2NM_MAX_NODES) {
 			/* not necessarily an error, though less likely.
 			 * could be master just re-asserting. */
-			mlog(ML_ERROR, "no bits set in the maybe_map, but %u "
+			mlog(0, "no bits set in the maybe_map, but %u "
 			     "is asserting! (%.*s)\n", assert->node_idx,
 			     namelen, name);
 		} else if (bit != assert->node_idx) {
@@ -1658,19 +1738,36 @@ int dlm_assert_master_handler(struct o2n
 				 * number winning the mastery will respond
 				 * YES to mastery requests, but this node
 				 * had no way of knowing.  let it pass. */
-				mlog(ML_ERROR, "%u is the lowest node, "
+				mlog(0, "%u is the lowest node, "
 				     "%u is asserting. (%.*s)  %u must "
 				     "have begun after %u won.\n", bit,
 				     assert->node_idx, namelen, name, bit,
 				     assert->node_idx);
 			}
 		}
+		if (mle->type == DLM_MLE_MIGRATION) {
+			if (flags & DLM_ASSERT_MASTER_MLE_CLEANUP) {
+				mlog(0, "%s:%.*s: got cleanup assert"
+				     " from %u for migration\n",
+				     dlm->name, namelen, name,
+				     assert->node_idx);
+			} else if (!(flags & DLM_ASSERT_MASTER_FINISH_MIGRATION)) {
+				mlog(0, "%s:%.*s: got unrelated assert"
+				     " from %u for migration, ignoring\n",
+				     dlm->name, namelen, name,
+				     assert->node_idx);
+				__dlm_put_mle(mle);
+				spin_unlock(&dlm->master_lock);
+				spin_unlock(&dlm->spinlock);
+				goto done;
+			}	
+		}
 	}
 	spin_unlock(&dlm->master_lock);
 
 	/* ok everything checks out with the MLE
 	 * now check to see if there is a lockres */
-	res = __dlm_lookup_lockres(dlm, name, namelen);
+	res = __dlm_lookup_lockres(dlm, name, namelen, hash);
 	if (res) {
 		spin_lock(&res->spinlock);
 		if (res->state & DLM_LOCK_RES_RECOVERING)  {
@@ -1679,7 +1776,8 @@ int dlm_assert_master_handler(struct o2n
 			goto kill;
 		}
 		if (!mle) {
-			if (res->owner != assert->node_idx) {
+			if (res->owner != DLM_LOCK_RES_OWNER_UNKNOWN &&
+			    res->owner != assert->node_idx) {
 				mlog(ML_ERROR, "assert_master from "
 					  "%u, but current owner is "
 					  "%u! (%.*s)\n",
@@ -1732,6 +1830,7 @@ ok:
 	if (mle) {
 		int extra_ref = 0;
 		int nn = -1;
+		int rr, err = 0;
 		
 		spin_lock(&mle->spinlock);
 		if (mle->type == DLM_MLE_BLOCK || mle->type == DLM_MLE_MIGRATION)
@@ -1751,27 +1850,64 @@ ok:
 		wake_up(&mle->wq);
 		spin_unlock(&mle->spinlock);
 
-		if (mle->type == DLM_MLE_MIGRATION && res) {
-			mlog(0, "finishing off migration of lockres %.*s, "
-			     "from %u to %u\n",
-			       res->lockname.len, res->lockname.name,
-			       dlm->node_num, mle->new_master);
+		if (res) {
 			spin_lock(&res->spinlock);
-			res->state &= ~DLM_LOCK_RES_MIGRATING;
-			dlm_change_lockres_owner(dlm, res, mle->new_master);
-			BUG_ON(res->state & DLM_LOCK_RES_DIRTY);
+			if (mle->type == DLM_MLE_MIGRATION) {
+				mlog(0, "finishing off migration of lockres %.*s, "
+			     		"from %u to %u\n",
+			       		res->lockname.len, res->lockname.name,
+			       		dlm->node_num, mle->new_master);
+				res->state &= ~DLM_LOCK_RES_MIGRATING;
+				dlm_change_lockres_owner(dlm, res, mle->new_master);
+				BUG_ON(res->state & DLM_LOCK_RES_DIRTY);
+			} else {
+				dlm_change_lockres_owner(dlm, res, mle->master);
+			}
 			spin_unlock(&res->spinlock);
 		}
-		/* master is known, detach if not already detached */
-		dlm_mle_detach_hb_events(dlm, mle);
-		dlm_put_mle(mle);
-		
+
+		/* master is known, detach if not already detached.
+		 * ensures that only one assert_master call will happen
+		 * on this mle. */
+		spin_lock(&dlm->spinlock);
+		spin_lock(&dlm->master_lock);
+
+		rr = atomic_read(&mle->mle_refs.refcount);
+		if (mle->inuse > 0) {
+			if (extra_ref && rr < 3)
+				err = 1;
+			else if (!extra_ref && rr < 2)
+				err = 1;
+		} else {
+			if (extra_ref && rr < 2)
+				err = 1;
+			else if (!extra_ref && rr < 1)
+				err = 1;
+		}
+		if (err) {
+			mlog(ML_ERROR, "%s:%.*s: got assert master from %u "
+			     "that will mess up this node, refs=%d, extra=%d, "
+			     "inuse=%d\n", dlm->name, namelen, name,
+			     assert->node_idx, rr, extra_ref, mle->inuse);
+			dlm_print_one_mle(mle);
+		}
+		list_del_init(&mle->list);
+		__dlm_mle_detach_hb_events(dlm, mle);
+		__dlm_put_mle(mle);
 		if (extra_ref) {
 			/* the assert master message now balances the extra
 		 	 * ref given by the master / migration request message.
 		 	 * if this is the last put, it will be removed
 		 	 * from the list. */
-			dlm_put_mle(mle);
+			__dlm_put_mle(mle);
+		}
+		spin_unlock(&dlm->master_lock);
+		spin_unlock(&dlm->spinlock);
+	} else if (res) {
+		if (res->owner != assert->node_idx) {
+			mlog(0, "assert_master from %u, but current "
+			     "owner is %u (%.*s), no mle\n", assert->node_idx,
+			     res->owner, namelen, name);
 		}
 	}
 
@@ -1788,12 +1924,12 @@ done:
 
 kill:
 	/* kill the caller! */
+	mlog(ML_ERROR, "Bad message received from another node.  Dumping state "
+	     "and killing the other node now!  This node is OK and can continue.\n");
+	__dlm_print_one_lock_resource(res);
 	spin_unlock(&res->spinlock);
 	spin_unlock(&dlm->spinlock);
 	dlm_lockres_put(res);
-	mlog(ML_ERROR, "Bad message received from another node.  Dumping state "
-	     "and killing the other node now!  This node is OK and can continue.\n");
-	dlm_dump_lock_resources(dlm);
 	dlm_put(dlm);
 	return -EINVAL;
 }
@@ -1803,7 +1939,7 @@ int dlm_dispatch_assert_master(struct dl
 			       int ignore_higher, u8 request_from, u32 flags)
 {
 	struct dlm_work_item *item;
-	item = kcalloc(1, sizeof(*item), GFP_KERNEL);
+	item = kcalloc(1, sizeof(*item), GFP_NOFS);
 	if (!item)
 		return -ENOMEM;
 
@@ -1825,7 +1961,7 @@ int dlm_dispatch_assert_master(struct dl
 	list_add_tail(&item->list, &dlm->work_list);
 	spin_unlock(&dlm->work_lock);
 
-	schedule_work(&dlm->dispatched_work);
+	queue_work(dlm->dlm_worker, &dlm->dispatched_work);
 	return 0;
 }
 
@@ -1866,6 +2002,23 @@ static void dlm_assert_master_worker(str
 		}
 	}
 
+	/*
+	 * If we're migrating this lock to someone else, we are no
+	 * longer allowed to assert out own mastery.  OTOH, we need to
+	 * prevent migration from starting while we're still asserting
+	 * our dominance.  The reserved ast delays migration.
+	 */
+	spin_lock(&res->spinlock);
+	if (res->state & DLM_LOCK_RES_MIGRATING) {
+		mlog(0, "Someone asked us to assert mastery, but we're "
+		     "in the middle of migration.  Skipping assert, "
+		     "the new master will handle that.\n");
+		spin_unlock(&res->spinlock);
+		goto put;
+	} else
+		__dlm_lockres_reserve_ast(res);
+	spin_unlock(&res->spinlock);
+
 	/* this call now finishes out the nodemap
 	 * even if one or more nodes die */
 	mlog(0, "worker about to master %.*s here, this=%u\n",
@@ -1875,9 +2028,14 @@ static void dlm_assert_master_worker(str
 				   nodemap, flags);
 	if (ret < 0) {
 		/* no need to restart, we are done */
-		mlog_errno(ret);
+		if (!dlm_is_host_down(ret))
+			mlog_errno(ret);
 	}
 
+	/* Ok, we've asserted ourselves.  Let's let migration start. */
+	dlm_lockres_release_ast(dlm, res);
+
+put:
 	dlm_lockres_put(res);
 
 	mlog(0, "finished with dlm_assert_master_worker\n");
@@ -1916,6 +2074,7 @@ static int dlm_pre_master_reco_lockres(s
 				BUG();
 			/* host is down, so answer for that node would be
 			 * DLM_LOCK_RES_OWNER_UNKNOWN.  continue. */
+			ret = 0;
 		}
 
 		if (master != DLM_LOCK_RES_OWNER_UNKNOWN) {
@@ -2016,14 +2175,14 @@ int dlm_migrate_lockres(struct dlm_ctxt 
 	 */
 
 	ret = -ENOMEM;
-	mres = (struct dlm_migratable_lockres *) __get_free_page(GFP_KERNEL);
+	mres = (struct dlm_migratable_lockres *) __get_free_page(GFP_NOFS);
 	if (!mres) {
 		mlog_errno(ret);
 		goto leave;
 	}
 
 	mle = (struct dlm_master_list_entry *) kmem_cache_alloc(dlm_mle_cache,
-								GFP_KERNEL);
+								GFP_NOFS);
 	if (!mle) {
 		mlog_errno(ret);
 		goto leave;
@@ -2117,7 +2276,7 @@ fail:
 	 * take both dlm->spinlock and dlm->master_lock */
 	spin_lock(&dlm->spinlock);
 	spin_lock(&dlm->master_lock);
-	dlm_get_mle(mle);
+	dlm_get_mle_inuse(mle);
 	spin_unlock(&dlm->master_lock);
 	spin_unlock(&dlm->spinlock);
 
@@ -2134,7 +2293,10 @@ fail:
 		/* migration failed, detach and clean up mle */
 		dlm_mle_detach_hb_events(dlm, mle);
 		dlm_put_mle(mle);
-		dlm_put_mle(mle);
+		dlm_put_mle_inuse(mle);
+		spin_lock(&res->spinlock);
+		res->state &= ~DLM_LOCK_RES_MIGRATING;
+		spin_unlock(&res->spinlock);
 		goto leave;
 	}
 
@@ -2164,8 +2326,8 @@ fail:
 			/* avoid hang during shutdown when migrating lockres 
 			 * to a node which also goes down */
 			if (dlm_is_node_dead(dlm, target)) {
-				mlog(0, "%s:%.*s: expected migration target %u "
-				     "is no longer up.  restarting.\n",
+				mlog(0, "%s:%.*s: expected migration "
+				     "target %u is no longer up, restarting\n",
 				     dlm->name, res->lockname.len,
 				     res->lockname.name, target);
 				ret = -ERESTARTSYS;
@@ -2175,7 +2337,10 @@ fail:
 			/* migration failed, detach and clean up mle */
 			dlm_mle_detach_hb_events(dlm, mle);
 			dlm_put_mle(mle);
-			dlm_put_mle(mle);
+			dlm_put_mle_inuse(mle);
+			spin_lock(&res->spinlock);
+			res->state &= ~DLM_LOCK_RES_MIGRATING;
+			spin_unlock(&res->spinlock);
 			goto leave;
 		}
 		/* TODO: if node died: stop, clean up, return error */
@@ -2191,7 +2356,7 @@ fail:
 
 	/* master is known, detach if not already detached */
 	dlm_mle_detach_hb_events(dlm, mle);
-	dlm_put_mle(mle);
+	dlm_put_mle_inuse(mle);
 	ret = 0;
 
 	dlm_lockres_calc_usage(dlm, res);
@@ -2462,7 +2627,7 @@ int dlm_migrate_request_handler(struct o
 	struct dlm_migrate_request *migrate = (struct dlm_migrate_request *) msg->buf;
 	struct dlm_master_list_entry *mle = NULL, *oldmle = NULL;
 	const char *name;
-	unsigned int namelen;
+	unsigned int namelen, hash;
 	int ret = 0;
 
 	if (!dlm_grab(dlm))
@@ -2470,10 +2635,11 @@ int dlm_migrate_request_handler(struct o
 
 	name = migrate->name;
 	namelen = migrate->namelen;
+	hash = dlm_lockid_hash(name, namelen);
 
 	/* preallocate.. if this fails, abort */
 	mle = (struct dlm_master_list_entry *) kmem_cache_alloc(dlm_mle_cache,
-							 GFP_KERNEL);
+							 GFP_NOFS);
 
 	if (!mle) {
 		ret = -ENOMEM;
@@ -2482,7 +2648,7 @@ int dlm_migrate_request_handler(struct o
 
 	/* check for pre-existing lock */
 	spin_lock(&dlm->spinlock);
-	res = __dlm_lookup_lockres(dlm, name, namelen);
+	res = __dlm_lookup_lockres(dlm, name, namelen, hash);
 	spin_lock(&dlm->master_lock);
 
 	if (res) {
@@ -2580,6 +2746,7 @@ static int dlm_add_migration_mle(struct 
 			/* remove it from the list so that only one
 			 * mle will be found */
 			list_del_init(&tmp->list);
+			__dlm_mle_detach_hb_events(dlm, mle);
 		}
 		spin_unlock(&tmp->spinlock);
 	}
@@ -2601,6 +2768,7 @@ void dlm_clean_master_list(struct dlm_ct
 	struct list_head *iter, *iter2;
 	struct dlm_master_list_entry *mle;
 	struct dlm_lock_resource *res;
+	unsigned int hash;
 
 	mlog_entry("dlm=%s, dead node=%u\n", dlm->name, dead_node);
 top:
@@ -2640,7 +2808,7 @@ top:
 				 * may result in the mle being unlinked and
 				 * freed, but there may still be a process
 				 * waiting in the dlmlock path which is fine. */
-				mlog(ML_ERROR, "node %u was expected master\n",
+				mlog(0, "node %u was expected master\n",
 				     dead_node);
 				atomic_set(&mle->woken, 1);
 				spin_unlock(&mle->spinlock);
@@ -2673,19 +2841,21 @@ top:
 
 		/* remove from the list early.  NOTE: unlinking
 		 * list_head while in list_for_each_safe */
+		__dlm_mle_detach_hb_events(dlm, mle);
 		spin_lock(&mle->spinlock);
 		list_del_init(&mle->list);
 		atomic_set(&mle->woken, 1);
 		spin_unlock(&mle->spinlock);
 		wake_up(&mle->wq);
 
-		mlog(0, "node %u died during migration from "
-		     "%u to %u!\n", dead_node,
+		mlog(0, "%s: node %u died during migration from "
+		     "%u to %u!\n", dlm->name, dead_node,
 		     mle->master, mle->new_master);
 		/* if there is a lockres associated with this
 	 	 * mle, find it and set its owner to UNKNOWN */
+		hash = dlm_lockid_hash(mle->u.name.name, mle->u.name.len);
 		res = __dlm_lookup_lockres(dlm, mle->u.name.name,
-					mle->u.name.len);
+					   mle->u.name.len, hash);
 		if (res) {
 			/* unfortunately if we hit this rare case, our
 		 	 * lock ordering is messed.  we need to drop
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 9962190..da39901 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -115,12 +115,37 @@ static u64 dlm_get_next_mig_cookie(void)
 	return c;
 }
 
+static inline void dlm_set_reco_dead_node(struct dlm_ctxt *dlm,
+					  u8 dead_node)
+{
+	assert_spin_locked(&dlm->spinlock);
+	if (dlm->reco.dead_node != dead_node)
+		mlog(0, "%s: changing dead_node from %u to %u\n",
+		     dlm->name, dlm->reco.dead_node, dead_node);
+	dlm->reco.dead_node = dead_node;
+}
+
+static inline void dlm_set_reco_master(struct dlm_ctxt *dlm,
+				       u8 master)
+{
+	assert_spin_locked(&dlm->spinlock);
+	mlog(0, "%s: changing new_master from %u to %u\n",
+	     dlm->name, dlm->reco.new_master, master);
+	dlm->reco.new_master = master;
+}
+
+static inline void __dlm_reset_recovery(struct dlm_ctxt *dlm)
+{
+	assert_spin_locked(&dlm->spinlock);
+	clear_bit(dlm->reco.dead_node, dlm->recovery_map);
+	dlm_set_reco_dead_node(dlm, O2NM_INVALID_NODE_NUM);
+	dlm_set_reco_master(dlm, O2NM_INVALID_NODE_NUM);
+}
+
 static inline void dlm_reset_recovery(struct dlm_ctxt *dlm)
 {
 	spin_lock(&dlm->spinlock);
-	clear_bit(dlm->reco.dead_node, dlm->recovery_map);
-	dlm->reco.dead_node = O2NM_INVALID_NODE_NUM;
-	dlm->reco.new_master = O2NM_INVALID_NODE_NUM;
+	__dlm_reset_recovery(dlm);
 	spin_unlock(&dlm->spinlock);
 }
 
@@ -132,12 +157,21 @@ void dlm_dispatch_work(void *data)
 	struct list_head *iter, *iter2;
 	struct dlm_work_item *item;
 	dlm_workfunc_t *workfunc;
+	int tot=0;
+
+	if (!dlm_joined(dlm))
+		return;
 
 	spin_lock(&dlm->work_lock);
 	list_splice_init(&dlm->work_list, &tmp_list);
 	spin_unlock(&dlm->work_lock);
 
 	list_for_each_safe(iter, iter2, &tmp_list) {
+		tot++;
+	}
+	mlog(0, "%s: work thread has %d work items\n", dlm->name, tot);
+
+	list_for_each_safe(iter, iter2, &tmp_list) {
 		item = list_entry(iter, struct dlm_work_item, list);
 		workfunc = item->func;
 		list_del_init(&item->list);
@@ -220,6 +254,52 @@ void dlm_complete_recovery_thread(struct
  *
  */
 
+static void dlm_print_reco_node_status(struct dlm_ctxt *dlm)
+{
+	struct dlm_reco_node_data *ndata;
+	struct dlm_lock_resource *res;
+
+	mlog(ML_NOTICE, "%s(%d): recovery info, state=%s, dead=%u, master=%u\n",
+	     dlm->name, dlm->dlm_reco_thread_task->pid,
+	     dlm->reco.state & DLM_RECO_STATE_ACTIVE ? "ACTIVE" : "inactive",
+	     dlm->reco.dead_node, dlm->reco.new_master);
+
+	list_for_each_entry(ndata, &dlm->reco.node_data, list) {
+		char *st = "unknown";
+		switch (ndata->state) {
+			case DLM_RECO_NODE_DATA_INIT:
+				st = "init";
+				break;
+			case DLM_RECO_NODE_DATA_REQUESTING:
+				st = "requesting";
+				break;
+			case DLM_RECO_NODE_DATA_DEAD:
+				st = "dead";
+				break;
+			case DLM_RECO_NODE_DATA_RECEIVING:
+				st = "receiving";
+				break;
+			case DLM_RECO_NODE_DATA_REQUESTED:
+				st = "requested";
+				break;
+			case DLM_RECO_NODE_DATA_DONE:
+				st = "done";
+				break;
+			case DLM_RECO_NODE_DATA_FINALIZE_SENT:
+				st = "finalize-sent";
+				break;
+			default:
+				st = "bad";
+				break;
+		}
+		mlog(ML_NOTICE, "%s: reco state, node %u, state=%s\n",
+		     dlm->name, ndata->node_num, st);
+	}
+	list_for_each_entry(res, &dlm->reco.resources, recovering) {
+		mlog(ML_NOTICE, "%s: lockres %.*s on recovering list\n",
+		     dlm->name, res->lockname.len, res->lockname.name);
+	}
+}
 
 #define DLM_RECO_THREAD_TIMEOUT_MS (5 * 1000)
 
@@ -267,11 +347,23 @@ int dlm_is_node_dead(struct dlm_ctxt *dl
 {
 	int dead;
 	spin_lock(&dlm->spinlock);
-	dead = test_bit(node, dlm->domain_map);
+	dead = !test_bit(node, dlm->domain_map);
 	spin_unlock(&dlm->spinlock);
 	return dead;
 }
 
+/* returns true if node is no longer in the domain
+ * could be dead or just not joined */
+static int dlm_is_node_recovered(struct dlm_ctxt *dlm, u8 node)
+{
+	int recovered;
+	spin_lock(&dlm->spinlock);
+	recovered = !test_bit(node, dlm->recovery_map);
+	spin_unlock(&dlm->spinlock);
+	return recovered;
+}
+
+
 int dlm_wait_for_node_death(struct dlm_ctxt *dlm, u8 node, int timeout)
 {
 	if (timeout) {
@@ -290,6 +382,24 @@ int dlm_wait_for_node_death(struct dlm_c
 	return 0;
 }
 
+int dlm_wait_for_node_recovery(struct dlm_ctxt *dlm, u8 node, int timeout)
+{
+	if (timeout) {
+		mlog(0, "%s: waiting %dms for notification of "
+		     "recovery of node %u\n", dlm->name, timeout, node);
+		wait_event_timeout(dlm->dlm_reco_thread_wq,
+			   dlm_is_node_recovered(dlm, node),
+			   msecs_to_jiffies(timeout));
+	} else {
+		mlog(0, "%s: waiting indefinitely for notification "
+		     "of recovery of node %u\n", dlm->name, node);
+		wait_event(dlm->dlm_reco_thread_wq,
+			   dlm_is_node_recovered(dlm, node));
+	}
+	/* for now, return 0 */
+	return 0;
+}
+
 /* callers of the top-level api calls (dlmlock/dlmunlock) should
  * block on the dlm->reco.event when recovery is in progress.
  * the dlm recovery thread will set this state when it begins
@@ -308,6 +418,13 @@ static int dlm_in_recovery(struct dlm_ct
 
 void dlm_wait_for_recovery(struct dlm_ctxt *dlm)
 {
+	if (dlm_in_recovery(dlm)) {
+		mlog(0, "%s: reco thread %d in recovery: "
+		     "state=%d, master=%u, dead=%u\n",
+		     dlm->name, dlm->dlm_reco_thread_task->pid,
+		     dlm->reco.state, dlm->reco.new_master,
+		     dlm->reco.dead_node);
+	}
 	wait_event(dlm->reco.event, !dlm_in_recovery(dlm));
 }
 
@@ -341,7 +458,7 @@ static int dlm_do_recovery(struct dlm_ct
 		mlog(0, "new master %u died while recovering %u!\n",
 		     dlm->reco.new_master, dlm->reco.dead_node);
 		/* unset the new_master, leave dead_node */
-		dlm->reco.new_master = O2NM_INVALID_NODE_NUM;
+		dlm_set_reco_master(dlm, O2NM_INVALID_NODE_NUM);
 	}
 
 	/* select a target to recover */
@@ -350,14 +467,14 @@ static int dlm_do_recovery(struct dlm_ct
 
 		bit = find_next_bit (dlm->recovery_map, O2NM_MAX_NODES+1, 0);
 		if (bit >= O2NM_MAX_NODES || bit < 0)
-			dlm->reco.dead_node = O2NM_INVALID_NODE_NUM;
+			dlm_set_reco_dead_node(dlm, O2NM_INVALID_NODE_NUM);
 		else
-			dlm->reco.dead_node = bit;
+			dlm_set_reco_dead_node(dlm, bit);
 	} else if (!test_bit(dlm->reco.dead_node, dlm->recovery_map)) {
 		/* BUG? */
 		mlog(ML_ERROR, "dead_node %u no longer in recovery map!\n",
 		     dlm->reco.dead_node);
-		dlm->reco.dead_node = O2NM_INVALID_NODE_NUM;
+		dlm_set_reco_dead_node(dlm, O2NM_INVALID_NODE_NUM);
 	}
 
 	if (dlm->reco.dead_node == O2NM_INVALID_NODE_NUM) {
@@ -366,7 +483,8 @@ static int dlm_do_recovery(struct dlm_ct
 		/* return to main thread loop and sleep. */
 		return 0;
 	}
-	mlog(0, "recovery thread found node %u in the recovery map!\n",
+	mlog(0, "%s(%d):recovery thread found node %u in the recovery map!\n",
+	     dlm->name, dlm->dlm_reco_thread_task->pid,
 	     dlm->reco.dead_node);
 	spin_unlock(&dlm->spinlock);
 
@@ -389,8 +507,8 @@ static int dlm_do_recovery(struct dlm_ct
 		}
 		mlog(0, "another node will master this recovery session.\n");
 	}
-	mlog(0, "dlm=%s, new_master=%u, this node=%u, dead_node=%u\n",
-	     dlm->name, dlm->reco.new_master,
+	mlog(0, "dlm=%s (%d), new_master=%u, this node=%u, dead_node=%u\n",
+	     dlm->name, dlm->dlm_reco_thread_task->pid, dlm->reco.new_master,
 	     dlm->node_num, dlm->reco.dead_node);
 
 	/* it is safe to start everything back up here
@@ -402,11 +520,13 @@ static int dlm_do_recovery(struct dlm_ct
 	return 0;
 
 master_here:
-	mlog(0, "mastering recovery of %s:%u here(this=%u)!\n",
+	mlog(0, "(%d) mastering recovery of %s:%u here(this=%u)!\n",
+	     dlm->dlm_reco_thread_task->pid,
 	     dlm->name, dlm->reco.dead_node, dlm->node_num);
 
 	status = dlm_remaster_locks(dlm, dlm->reco.dead_node);
 	if (status < 0) {
+		/* we should never hit this anymore */
 		mlog(ML_ERROR, "error %d remastering locks for node %u, "
 		     "retrying.\n", status, dlm->reco.dead_node);
 		/* yield a bit to allow any final network messages
@@ -433,9 +553,16 @@ static int dlm_remaster_locks(struct dlm
 	int destroy = 0;
 	int pass = 0;
 
-	status = dlm_init_recovery_area(dlm, dead_node);
-	if (status < 0)
-		goto leave;
+	do {
+		/* we have become recovery master.  there is no escaping
+		 * this, so just keep trying until we get it. */
+		status = dlm_init_recovery_area(dlm, dead_node);
+		if (status < 0) {
+			mlog(ML_ERROR, "%s: failed to alloc recovery area, "
+			     "retrying\n", dlm->name);
+			msleep(1000);
+		}
+	} while (status != 0);
 
 	/* safe to access the node data list without a lock, since this
 	 * process is the only one to change the list */
@@ -452,16 +579,36 @@ static int dlm_remaster_locks(struct dlm
 			continue;
 		}
 
-		status = dlm_request_all_locks(dlm, ndata->node_num, dead_node);
-		if (status < 0) {
-			mlog_errno(status);
-			if (dlm_is_host_down(status))
-				ndata->state = DLM_RECO_NODE_DATA_DEAD;
-			else {
-				destroy = 1;
-				goto leave;
+		do {
+			status = dlm_request_all_locks(dlm, ndata->node_num,
+						       dead_node);
+			if (status < 0) {
+				mlog_errno(status);
+				if (dlm_is_host_down(status)) {
+					/* node died, ignore it for recovery */
+					status = 0;
+					ndata->state = DLM_RECO_NODE_DATA_DEAD;
+					/* wait for the domain map to catch up
+					 * with the network state. */
+					wait_event_timeout(dlm->dlm_reco_thread_wq,
+							   dlm_is_node_dead(dlm,
+								ndata->node_num),
+							   msecs_to_jiffies(1000));
+					mlog(0, "waited 1 sec for %u, "
+					     "dead? %s\n", ndata->node_num,
+					     dlm_is_node_dead(dlm, ndata->node_num) ?
+					     "yes" : "no");
+				} else {
+					/* -ENOMEM on the other node */
+					mlog(0, "%s: node %u returned "
+					     "%d during recovery, retrying "
+					     "after a short wait\n",
+					     dlm->name, ndata->node_num,
+					     status);
+					msleep(100);
+				}
 			}
-		}
+		} while (status != 0);
 
 		switch (ndata->state) {
 			case DLM_RECO_NODE_DATA_INIT:
@@ -473,10 +620,9 @@ static int dlm_remaster_locks(struct dlm
 				mlog(0, "node %u died after requesting "
 				     "recovery info for node %u\n",
 				     ndata->node_num, dead_node);
-				// start all over
-				destroy = 1;
-				status = -EAGAIN;
-				goto leave;
+				/* fine.  don't need this node's info.
+				 * continue without it. */
+				break;
 			case DLM_RECO_NODE_DATA_REQUESTING:
 				ndata->state = DLM_RECO_NODE_DATA_REQUESTED;
 				mlog(0, "now receiving recovery data from "
@@ -520,35 +666,26 @@ static int dlm_remaster_locks(struct dlm
 					BUG();
 					break;
 				case DLM_RECO_NODE_DATA_DEAD:
-					mlog(ML_NOTICE, "node %u died after "
+					mlog(0, "node %u died after "
 					     "requesting recovery info for "
 					     "node %u\n", ndata->node_num,
 					     dead_node);
-					spin_unlock(&dlm_reco_state_lock);
-					// start all over
-					destroy = 1;
-					status = -EAGAIN;
-					/* instead of spinning like crazy here,
-					 * wait for the domain map to catch up
-					 * with the network state.  otherwise this
-					 * can be hit hundreds of times before
-					 * the node is really seen as dead. */
-					wait_event_timeout(dlm->dlm_reco_thread_wq,
-							   dlm_is_node_dead(dlm,
-								ndata->node_num),
-							   msecs_to_jiffies(1000));
-					mlog(0, "waited 1 sec for %u, "
-					     "dead? %s\n", ndata->node_num,
-					     dlm_is_node_dead(dlm, ndata->node_num) ?
-					     "yes" : "no");
-					goto leave;
+					break;
 				case DLM_RECO_NODE_DATA_RECEIVING:
 				case DLM_RECO_NODE_DATA_REQUESTED:
+					mlog(0, "%s: node %u still in state %s\n",
+					     dlm->name, ndata->node_num,
+					     ndata->state==DLM_RECO_NODE_DATA_RECEIVING ?
+					     "receiving" : "requested");
 					all_nodes_done = 0;
 					break;
 				case DLM_RECO_NODE_DATA_DONE:
+					mlog(0, "%s: node %u state is done\n",
+					     dlm->name, ndata->node_num);
 					break;
 				case DLM_RECO_NODE_DATA_FINALIZE_SENT:
+					mlog(0, "%s: node %u state is finalize\n",
+					     dlm->name, ndata->node_num);
 					break;
 			}
 		}
@@ -578,7 +715,7 @@ static int dlm_remaster_locks(struct dlm
 			     jiffies, dlm->reco.dead_node,
 			     dlm->node_num, dlm->reco.new_master);
 			destroy = 1;
-			status = ret;
+			status = 0;
 			/* rescan everything marked dirty along the way */
 			dlm_kick_thread(dlm, NULL);
 			break;
@@ -591,7 +728,6 @@ static int dlm_remaster_locks(struct dlm
 
 	}
 
-leave:
 	if (destroy)
 		dlm_destroy_recovery_area(dlm, dead_node);
 
@@ -617,7 +753,7 @@ static int dlm_init_recovery_area(struct
 		}
 		BUG_ON(num == dead_node);
 
-		ndata = kcalloc(1, sizeof(*ndata), GFP_KERNEL);
+		ndata = kcalloc(1, sizeof(*ndata), GFP_NOFS);
 		if (!ndata) {
 			dlm_destroy_recovery_area(dlm, dead_node);
 			return -ENOMEM;
@@ -691,16 +827,25 @@ int dlm_request_all_locks_handler(struct
 	if (!dlm_grab(dlm))
 		return -EINVAL;
 
+	if (lr->dead_node != dlm->reco.dead_node) {
+		mlog(ML_ERROR, "%s: node %u sent dead_node=%u, but local "
+		     "dead_node is %u\n", dlm->name, lr->node_idx,
+		     lr->dead_node, dlm->reco.dead_node);
+		dlm_print_reco_node_status(dlm);
+		/* this is a hack */
+		dlm_put(dlm);
+		return -ENOMEM;
+	}
 	BUG_ON(lr->dead_node != dlm->reco.dead_node);
 
-	item = kcalloc(1, sizeof(*item), GFP_KERNEL);
+	item = kcalloc(1, sizeof(*item), GFP_NOFS);
 	if (!item) {
 		dlm_put(dlm);
 		return -ENOMEM;
 	}
 
 	/* this will get freed by dlm_request_all_locks_worker */
-	buf = (char *) __get_free_page(GFP_KERNEL);
+	buf = (char *) __get_free_page(GFP_NOFS);
 	if (!buf) {
 		kfree(item);
 		dlm_put(dlm);
@@ -715,7 +860,7 @@ int dlm_request_all_locks_handler(struct
 	spin_lock(&dlm->work_lock);
 	list_add_tail(&item->list, &dlm->work_list);
 	spin_unlock(&dlm->work_lock);
-	schedule_work(&dlm->dispatched_work);
+	queue_work(dlm->dlm_worker, &dlm->dispatched_work);
 
 	dlm_put(dlm);
 	return 0;
@@ -730,32 +875,34 @@ static void dlm_request_all_locks_worker
 	struct list_head *iter;
 	int ret;
 	u8 dead_node, reco_master;
+	int skip_all_done = 0;
 
 	dlm = item->dlm;
 	dead_node = item->u.ral.dead_node;
 	reco_master = item->u.ral.reco_master;
 	mres = (struct dlm_migratable_lockres *)data;
 
+	mlog(0, "%s: recovery worker started, dead=%u, master=%u\n",
+	     dlm->name, dead_node, reco_master);
+
 	if (dead_node != dlm->reco.dead_node ||
 	    reco_master != dlm->reco.new_master) {
-		/* show extra debug info if the recovery state is messed */
-		mlog(ML_ERROR, "%s: bad reco state: reco(dead=%u, master=%u), "
-		     "request(dead=%u, master=%u)\n",
-		     dlm->name, dlm->reco.dead_node, dlm->reco.new_master,
-		     dead_node, reco_master);
-		mlog(ML_ERROR, "%s: name=%.*s master=%u locks=%u/%u flags=%u "
-		     "entry[0]={c=%u:%llu,l=%u,f=%u,t=%d,ct=%d,hb=%d,n=%u}\n",
-		     dlm->name, mres->lockname_len, mres->lockname, mres->master,
-		     mres->num_locks, mres->total_locks, mres->flags,
-		     dlm_get_lock_cookie_node(mres->ml[0].cookie),
-		     dlm_get_lock_cookie_seq(mres->ml[0].cookie),
-		     mres->ml[0].list, mres->ml[0].flags,
-		     mres->ml[0].type, mres->ml[0].convert_type,
-		     mres->ml[0].highest_blocked, mres->ml[0].node);
-		BUG();
+		/* worker could have been created before the recovery master
+		 * died.  if so, do not continue, but do not error. */
+		if (dlm->reco.new_master == O2NM_INVALID_NODE_NUM) {
+			mlog(ML_NOTICE, "%s: will not send recovery state, "
+			     "recovery master %u died, thread=(dead=%u,mas=%u)"
+			     " current=(dead=%u,mas=%u)\n", dlm->name,
+			     reco_master, dead_node, reco_master,
+			     dlm->reco.dead_node, dlm->reco.new_master);
+		} else {
+			mlog(ML_NOTICE, "%s: reco state invalid: reco(dead=%u, "
+			     "master=%u), request(dead=%u, master=%u)\n",
+			     dlm->name, dlm->reco.dead_node,
+			     dlm->reco.new_master, dead_node, reco_master);
+		}
+		goto leave;
 	}
-	BUG_ON(dead_node != dlm->reco.dead_node);
-	BUG_ON(reco_master != dlm->reco.new_master);
 
 	/* lock resources should have already been moved to the
  	 * dlm->reco.resources list.  now move items from that list
@@ -766,12 +913,20 @@ static void dlm_request_all_locks_worker
 	dlm_move_reco_locks_to_list(dlm, &resources, dead_node);
 
 	/* now we can begin blasting lockreses without the dlm lock */
+
+	/* any errors returned will be due to the new_master dying,
+	 * the dlm_reco_thread should detect this */
 	list_for_each(iter, &resources) {
 		res = list_entry (iter, struct dlm_lock_resource, recovering);
 		ret = dlm_send_one_lockres(dlm, res, mres, reco_master,
 				   	DLM_MRES_RECOVERY);
-		if (ret < 0)
-			mlog_errno(ret);
+		if (ret < 0) {
+			mlog(ML_ERROR, "%s: node %u went down while sending "
+			     "recovery state for dead node %u, ret=%d\n", dlm->name,
+			     reco_master, dead_node, ret);
+			skip_all_done = 1;
+			break;
+		}
 	}
 
 	/* move the resources back to the list */
@@ -779,10 +934,15 @@ static void dlm_request_all_locks_worker
 	list_splice_init(&resources, &dlm->reco.resources);
 	spin_unlock(&dlm->spinlock);
 
-	ret = dlm_send_all_done_msg(dlm, dead_node, reco_master);
-	if (ret < 0)
-		mlog_errno(ret);
-
+	if (!skip_all_done) {
+		ret = dlm_send_all_done_msg(dlm, dead_node, reco_master);
+		if (ret < 0) {
+			mlog(ML_ERROR, "%s: node %u went down while sending "
+			     "recovery all-done for dead node %u, ret=%d\n",
+			     dlm->name, reco_master, dead_node, ret);
+		}
+	}
+leave:
 	free_page((unsigned long)data);
 }
 
@@ -801,8 +961,14 @@ static int dlm_send_all_done_msg(struct 
 
 	ret = o2net_send_message(DLM_RECO_DATA_DONE_MSG, dlm->key, &done_msg,
 				 sizeof(done_msg), send_to, &tmpret);
-	/* negative status is ignored by the caller */
-	if (ret >= 0)
+	if (ret < 0) {
+		if (!dlm_is_host_down(ret)) {
+			mlog_errno(ret);
+			mlog(ML_ERROR, "%s: unknown error sending data-done "
+			     "to %u\n", dlm->name, send_to);
+			BUG();
+		}
+	} else
 		ret = tmpret;
 	return ret;
 }
@@ -822,7 +988,11 @@ int dlm_reco_data_done_handler(struct o2
 	mlog(0, "got DATA DONE: dead_node=%u, reco.dead_node=%u, "
 	     "node_idx=%u, this node=%u\n", done->dead_node,
 	     dlm->reco.dead_node, done->node_idx, dlm->node_num);
-	BUG_ON(done->dead_node != dlm->reco.dead_node);
+
+	mlog_bug_on_msg((done->dead_node != dlm->reco.dead_node),
+			"Got DATA DONE: dead_node=%u, reco.dead_node=%u, "
+			"node_idx=%u, this node=%u\n", done->dead_node,
+			dlm->reco.dead_node, done->node_idx, dlm->node_num);
 
 	spin_lock(&dlm_reco_state_lock);
 	list_for_each(iter, &dlm->reco.node_data) {
@@ -1021,8 +1191,9 @@ static int dlm_add_lock_to_array(struct 
 		    ml->type == LKM_PRMODE) {
 			/* if it is already set, this had better be a PR
 			 * and it has to match */
-			if (mres->lvb[0] && (ml->type == LKM_EXMODE ||
-			    memcmp(mres->lvb, lock->lksb->lvb, DLM_LVB_LEN))) {
+			if (!dlm_lvb_is_empty(mres->lvb) &&
+			    (ml->type == LKM_EXMODE ||
+			     memcmp(mres->lvb, lock->lksb->lvb, DLM_LVB_LEN))) {
 				mlog(ML_ERROR, "mismatched lvbs!\n");
 				__dlm_print_one_lock_resource(lock->lockres);
 				BUG();
@@ -1081,22 +1252,25 @@ int dlm_send_one_lockres(struct dlm_ctxt
 			 * we must send it immediately. */
 			ret = dlm_send_mig_lockres_msg(dlm, mres, send_to,
 						       res, total_locks);
-			if (ret < 0) {
-				// TODO
-				mlog(ML_ERROR, "dlm_send_mig_lockres_msg "
-				     "returned %d, TODO\n", ret);
-				BUG();
-			}
+			if (ret < 0)
+				goto error;
 		}
 	}
 	/* flush any remaining locks */
 	ret = dlm_send_mig_lockres_msg(dlm, mres, send_to, res, total_locks);
-	if (ret < 0) {
-		// TODO
-		mlog(ML_ERROR, "dlm_send_mig_lockres_msg returned %d, "
-		     "TODO\n", ret);
+	if (ret < 0)
+		goto error;
+	return ret;
+
+error:
+	mlog(ML_ERROR, "%s: dlm_send_mig_lockres_msg returned %d\n",
+	     dlm->name, ret);
+	if (!dlm_is_host_down(ret))
 		BUG();
-	}
+	mlog(0, "%s: node %u went down while sending %s "
+	     "lockres %.*s\n", dlm->name, send_to,
+	     flags & DLM_MRES_RECOVERY ?  "recovery" : "migration",
+	     res->lockname.len, res->lockname.name);
 	return ret;
 }
 
@@ -1144,8 +1318,8 @@ int dlm_mig_lockres_handler(struct o2net
 		mlog(0, "all done flag.  all lockres data received!\n");
 
 	ret = -ENOMEM;
-	buf = kmalloc(be16_to_cpu(msg->data_len), GFP_KERNEL);
-	item = kcalloc(1, sizeof(*item), GFP_KERNEL);
+	buf = kmalloc(be16_to_cpu(msg->data_len), GFP_NOFS);
+	item = kcalloc(1, sizeof(*item), GFP_NOFS);
 	if (!buf || !item)
 		goto leave;
 
@@ -1236,7 +1410,7 @@ int dlm_mig_lockres_handler(struct o2net
 	spin_lock(&dlm->work_lock);
 	list_add_tail(&item->list, &dlm->work_list);
 	spin_unlock(&dlm->work_lock);
-	schedule_work(&dlm->dispatched_work);
+	queue_work(dlm->dlm_worker, &dlm->dispatched_work);
 
 leave:
 	dlm_put(dlm);
@@ -1404,6 +1578,7 @@ int dlm_master_requery_handler(struct o2
 	struct dlm_ctxt *dlm = data;
 	struct dlm_master_requery *req = (struct dlm_master_requery *)msg->buf;
 	struct dlm_lock_resource *res = NULL;
+	unsigned int hash;
 	int master = DLM_LOCK_RES_OWNER_UNKNOWN;
 	u32 flags = DLM_ASSERT_MASTER_REQUERY;
 
@@ -1413,8 +1588,10 @@ int dlm_master_requery_handler(struct o2
 		return master;
 	}
 
+	hash = dlm_lockid_hash(req->name, req->namelen);
+
 	spin_lock(&dlm->spinlock);
-	res = __dlm_lookup_lockres(dlm, req->name, req->namelen);
+	res = __dlm_lookup_lockres(dlm, req->name, req->namelen, hash);
 	if (res) {
 		spin_lock(&res->spinlock);
 		master = res->owner;
@@ -1481,7 +1658,7 @@ static int dlm_process_recovery_data(str
 	struct dlm_lock *newlock = NULL;
 	struct dlm_lockstatus *lksb = NULL;
 	int ret = 0;
-	int i;
+	int i, bad;
 	struct list_head *iter;
 	struct dlm_lock *lock = NULL;
 
@@ -1550,28 +1727,48 @@ static int dlm_process_recovery_data(str
 		}
 		lksb->flags |= (ml->flags &
 				(DLM_LKSB_PUT_LVB|DLM_LKSB_GET_LVB));
-			
-		if (mres->lvb[0]) {
+
+		if (ml->type == LKM_NLMODE)
+			goto skip_lvb;
+
+		if (!dlm_lvb_is_empty(mres->lvb)) {
 			if (lksb->flags & DLM_LKSB_PUT_LVB) {
 				/* other node was trying to update
 				 * lvb when node died.  recreate the
 				 * lksb with the updated lvb. */
 				memcpy(lksb->lvb, mres->lvb, DLM_LVB_LEN);
+				/* the lock resource lvb update must happen
+				 * NOW, before the spinlock is dropped.
+				 * we no longer wait for the AST to update
+				 * the lvb. */
+				memcpy(res->lvb, mres->lvb, DLM_LVB_LEN);
 			} else {
 				/* otherwise, the node is sending its 
 				 * most recent valid lvb info */
 				BUG_ON(ml->type != LKM_EXMODE &&
 				       ml->type != LKM_PRMODE);
-				if (res->lvb[0] && (ml->type == LKM_EXMODE ||
-				    memcmp(res->lvb, mres->lvb, DLM_LVB_LEN))) {
-					mlog(ML_ERROR, "received bad lvb!\n");
-					__dlm_print_one_lock_resource(res);
-					BUG();
+				if (!dlm_lvb_is_empty(res->lvb) &&
+ 				    (ml->type == LKM_EXMODE ||
+ 				     memcmp(res->lvb, mres->lvb, DLM_LVB_LEN))) {
+ 					int i;
+ 					mlog(ML_ERROR, "%s:%.*s: received bad "
+ 					     "lvb! type=%d\n", dlm->name,
+ 					     res->lockname.len,
+ 					     res->lockname.name, ml->type);
+ 					printk("lockres lvb=[");
+ 					for (i=0; i<DLM_LVB_LEN; i++)
+ 						printk("%02x", res->lvb[i]);
+ 					printk("]\nmigrated lvb=[");
+ 					for (i=0; i<DLM_LVB_LEN; i++)
+ 						printk("%02x", mres->lvb[i]);
+ 					printk("]\n");
+ 					dlm_print_one_lock_resource(res);
+ 					BUG();
 				}
 				memcpy(res->lvb, mres->lvb, DLM_LVB_LEN);
 			}
 		}
-
+skip_lvb:
 
 		/* NOTE:
 		 * wrt lock queue ordering and recovery:
@@ -1589,9 +1786,33 @@ static int dlm_process_recovery_data(str
 		 * relative to each other, but clearly *not*
 		 * preserved relative to locks from other nodes.
 		 */
+		bad = 0;
 		spin_lock(&res->spinlock);
-		dlm_lock_get(newlock);
-		list_add_tail(&newlock->list, queue);
+		list_for_each_entry(lock, queue, list) {
+			if (lock->ml.cookie == ml->cookie) {
+				u64 c = lock->ml.cookie;
+				mlog(ML_ERROR, "%s:%.*s: %u:%llu: lock already "
+				     "exists on this lockres!\n", dlm->name,
+				     res->lockname.len, res->lockname.name,
+				     dlm_get_lock_cookie_node(c),
+				     dlm_get_lock_cookie_seq(c));
+
+				mlog(ML_NOTICE, "sent lock: type=%d, conv=%d, "
+				     "node=%u, cookie=%u:%llu, queue=%d\n",
+	      			     ml->type, ml->convert_type, ml->node,
+				     dlm_get_lock_cookie_node(ml->cookie),
+				     dlm_get_lock_cookie_seq(ml->cookie),
+				     ml->list);
+
+				__dlm_print_one_lock_resource(res);
+				bad = 1;
+				break;
+			}
+		}
+		if (!bad) {
+			dlm_lock_get(newlock);
+			list_add_tail(&newlock->list, queue);
+		}
 		spin_unlock(&res->spinlock);
 	}
 	mlog(0, "done running all the locks\n");
@@ -1615,8 +1836,14 @@ void dlm_move_lockres_to_recovery_list(s
 	struct dlm_lock *lock;
 
 	res->state |= DLM_LOCK_RES_RECOVERING;
-	if (!list_empty(&res->recovering))
+	if (!list_empty(&res->recovering)) {
+		mlog(0,
+		     "Recovering res %s:%.*s, is already on recovery list!\n",
+		     dlm->name, res->lockname.len, res->lockname.name);
 		list_del_init(&res->recovering);
+	}
+	/* We need to hold a reference while on the recovery list */
+	dlm_lockres_get(res);
 	list_add_tail(&res->recovering, &dlm->reco.resources);
 
 	/* find any pending locks and put them back on proper list */
@@ -1705,9 +1932,11 @@ static void dlm_finish_local_lockres_rec
 			spin_lock(&res->spinlock);
 			dlm_change_lockres_owner(dlm, res, new_master);
 			res->state &= ~DLM_LOCK_RES_RECOVERING;
-			__dlm_dirty_lockres(dlm, res);
+			if (!__dlm_lockres_unused(res))
+				__dlm_dirty_lockres(dlm, res);
 			spin_unlock(&res->spinlock);
 			wake_up(&res->wq);
+			dlm_lockres_put(res);
 		}
 	}
 
@@ -1716,7 +1945,7 @@ static void dlm_finish_local_lockres_rec
 	 * the RECOVERING state and set the owner
 	 * if necessary */
 	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
-		bucket = &(dlm->lockres_hash[i]);
+		bucket = dlm_lockres_hash(dlm, i);
 		hlist_for_each_entry(res, hash_iter, bucket, hash_node) {
 			if (res->state & DLM_LOCK_RES_RECOVERING) {
 				if (res->owner == dead_node) {
@@ -1740,11 +1969,13 @@ static void dlm_finish_local_lockres_rec
 					     dlm->name, res->lockname.len,
 					     res->lockname.name, res->owner);
 					list_del_init(&res->recovering);
+					dlm_lockres_put(res);
 				}
 				spin_lock(&res->spinlock);
 				dlm_change_lockres_owner(dlm, res, new_master);
 				res->state &= ~DLM_LOCK_RES_RECOVERING;
-				__dlm_dirty_lockres(dlm, res);
+				if (!__dlm_lockres_unused(res))
+					__dlm_dirty_lockres(dlm, res);
 				spin_unlock(&res->spinlock);
 				wake_up(&res->wq);
 			}
@@ -1881,7 +2112,7 @@ static void dlm_do_local_recovery_cleanu
 	 *    need to be fired as a result.
 	 */
 	for (i = 0; i < DLM_HASH_BUCKETS; i++) {
-		bucket = &(dlm->lockres_hash[i]);
+		bucket = dlm_lockres_hash(dlm, i);
 		hlist_for_each_entry(res, iter, bucket, hash_node) {
  			/* always prune any $RECOVERY entries for dead nodes,
  			 * otherwise hangs can occur during later recovery */
@@ -1921,6 +2152,20 @@ static void __dlm_hb_node_down(struct dl
 {
 	assert_spin_locked(&dlm->spinlock);
 
+	if (dlm->reco.new_master == idx) {
+		mlog(0, "%s: recovery master %d just died\n",
+		     dlm->name, idx);
+		if (dlm->reco.state & DLM_RECO_STATE_FINALIZE) {
+			/* finalize1 was reached, so it is safe to clear
+			 * the new_master and dead_node.  that recovery
+			 * is complete. */
+			mlog(0, "%s: dead master %d had reached "
+			     "finalize1 state, clearing\n", dlm->name, idx);
+			dlm->reco.state &= ~DLM_RECO_STATE_FINALIZE;
+			__dlm_reset_recovery(dlm);
+		}
+	}
+
 	/* check to see if the node is already considered dead */
 	if (!test_bit(idx, dlm->live_nodes_map)) {
 		mlog(0, "for domain %s, node %d is already dead. "
@@ -2084,7 +2329,7 @@ again:	
 
 			/* set the new_master to this node */
 			spin_lock(&dlm->spinlock);
-			dlm->reco.new_master = dlm->node_num;
+			dlm_set_reco_master(dlm, dlm->node_num);
 			spin_unlock(&dlm->spinlock);
 		}
 
@@ -2122,6 +2367,10 @@ again:	
 		mlog(0, "%s: reco master %u is ready to recover %u\n",
 		     dlm->name, dlm->reco.new_master, dlm->reco.dead_node);
 		status = -EEXIST;
+	} else if (ret == DLM_RECOVERING) {
+		mlog(0, "dlm=%s dlmlock says master node died (this=%u)\n",
+		     dlm->name, dlm->node_num);
+		goto again;
 	} else {
 		struct dlm_lock_resource *res;
 
@@ -2153,7 +2402,7 @@ static int dlm_send_begin_reco_message(s
 
 	mlog_entry("%u\n", dead_node);
 
-	mlog(0, "dead node is %u\n", dead_node);
+	mlog(0, "%s: dead node is %u\n", dlm->name, dead_node);
 
 	spin_lock(&dlm->spinlock);
 	dlm_node_iter_init(dlm->domain_map, &iter);
@@ -2211,6 +2460,14 @@ retry:
 			 * another ENOMEM */
 			msleep(100);
 			goto retry;
+		} else if (ret == EAGAIN) {
+			mlog(0, "%s: trying to start recovery of node "
+			     "%u, but node %u is waiting for last recovery "
+			     "to complete, backoff for a bit\n", dlm->name,
+			     dead_node, nodenum);
+			/* TODO Look into replacing msleep with cond_resched() */
+			msleep(100);
+			goto retry;
 		}
 	}
 
@@ -2226,8 +2483,20 @@ int dlm_begin_reco_handler(struct o2net_
 	if (!dlm_grab(dlm))
 		return 0;
 
-	mlog(0, "node %u wants to recover node %u\n",
-		  br->node_idx, br->dead_node);
+	spin_lock(&dlm->spinlock);
+	if (dlm->reco.state & DLM_RECO_STATE_FINALIZE) {
+		mlog(0, "%s: node %u wants to recover node %u (%u:%u) "
+		     "but this node is in finalize state, waiting on finalize2\n",
+		     dlm->name, br->node_idx, br->dead_node,
+		     dlm->reco.dead_node, dlm->reco.new_master);
+		spin_unlock(&dlm->spinlock);
+		return EAGAIN;
+	}
+	spin_unlock(&dlm->spinlock);
+
+	mlog(0, "%s: node %u wants to recover node %u (%u:%u)\n",
+	     dlm->name, br->node_idx, br->dead_node,
+	     dlm->reco.dead_node, dlm->reco.new_master);
 
 	dlm_fire_domain_eviction_callbacks(dlm, br->dead_node);
 
@@ -2249,8 +2518,8 @@ int dlm_begin_reco_handler(struct o2net_
 		     "node %u changing it to %u\n", dlm->name, 
 		     dlm->reco.dead_node, br->node_idx, br->dead_node);
 	}
-	dlm->reco.new_master = br->node_idx;
-	dlm->reco.dead_node = br->dead_node;
+	dlm_set_reco_master(dlm, br->node_idx);
+	dlm_set_reco_dead_node(dlm, br->dead_node);
 	if (!test_bit(br->dead_node, dlm->recovery_map)) {
 		mlog(0, "recovery master %u sees %u as dead, but this "
 		     "node has not yet.  marking %u as dead\n",
@@ -2269,10 +2538,16 @@ int dlm_begin_reco_handler(struct o2net_
 	spin_unlock(&dlm->spinlock);
 
 	dlm_kick_recovery_thread(dlm);
+
+	mlog(0, "%s: recovery started by node %u, for %u (%u:%u)\n",
+	     dlm->name, br->node_idx, br->dead_node,
+	     dlm->reco.dead_node, dlm->reco.new_master);
+
 	dlm_put(dlm);
 	return 0;
 }
 
+#define DLM_FINALIZE_STAGE2  0x01
 static int dlm_send_finalize_reco_message(struct dlm_ctxt *dlm)
 {
 	int ret = 0;
@@ -2280,25 +2555,31 @@ static int dlm_send_finalize_reco_messag
 	struct dlm_node_iter iter;
 	int nodenum;
 	int status;
+	int stage = 1;
 
-	mlog(0, "finishing recovery for node %s:%u\n",
-	     dlm->name, dlm->reco.dead_node);
+	mlog(0, "finishing recovery for node %s:%u, "
+	     "stage %d\n", dlm->name, dlm->reco.dead_node, stage);
 
 	spin_lock(&dlm->spinlock);
 	dlm_node_iter_init(dlm->domain_map, &iter);
 	spin_unlock(&dlm->spinlock);
 
+stage2:
 	memset(&fr, 0, sizeof(fr));
 	fr.node_idx = dlm->node_num;
 	fr.dead_node = dlm->reco.dead_node;
+	if (stage == 2)
+		fr.flags |= DLM_FINALIZE_STAGE2;
 
 	while ((nodenum = dlm_node_iter_next(&iter)) >= 0) {
 		if (nodenum == dlm->node_num)
 			continue;
 		ret = o2net_send_message(DLM_FINALIZE_RECO_MSG, dlm->key,
 					 &fr, sizeof(fr), nodenum, &status);
-		if (ret >= 0) {
+		if (ret >= 0)
 			ret = status;
+		if (ret < 0) {
+			mlog_errno(ret);
 			if (dlm_is_host_down(ret)) {
 				/* this has no effect on this recovery 
 				 * session, so set the status to zero to 
@@ -2306,13 +2587,17 @@ static int dlm_send_finalize_reco_messag
 				mlog(ML_ERROR, "node %u went down after this "
 				     "node finished recovery.\n", nodenum);
 				ret = 0;
+				continue;
 			}
-		}
-		if (ret < 0) {
-			mlog_errno(ret);
 			break;
 		}
 	}
+	if (stage == 1) {
+		/* reset the node_iter back to the top and send finalize2 */
+		iter.curnode = -1;
+		stage = 2;
+		goto stage2;
+	}
 
 	return ret;
 }
@@ -2321,14 +2606,19 @@ int dlm_finalize_reco_handler(struct o2n
 {
 	struct dlm_ctxt *dlm = data;
 	struct dlm_finalize_reco *fr = (struct dlm_finalize_reco *)msg->buf;
+	int stage = 1;
 
 	/* ok to return 0, domain has gone away */
 	if (!dlm_grab(dlm))
 		return 0;
 
-	mlog(0, "node %u finalizing recovery of node %u\n",
-	     fr->node_idx, fr->dead_node);
+	if (fr->flags & DLM_FINALIZE_STAGE2)
+		stage = 2;
 
+	mlog(0, "%s: node %u finalizing recovery stage%d of "
+	     "node %u (%u:%u)\n", dlm->name, fr->node_idx, stage,
+	     fr->dead_node, dlm->reco.dead_node, dlm->reco.new_master);
+ 
 	spin_lock(&dlm->spinlock);
 
 	if (dlm->reco.new_master != fr->node_idx) {
@@ -2344,13 +2634,41 @@ int dlm_finalize_reco_handler(struct o2n
 		BUG();
 	}
 
-	dlm_finish_local_lockres_recovery(dlm, fr->dead_node, fr->node_idx);
-
-	spin_unlock(&dlm->spinlock);
+	switch (stage) {
+		case 1:
+			dlm_finish_local_lockres_recovery(dlm, fr->dead_node, fr->node_idx);
+			if (dlm->reco.state & DLM_RECO_STATE_FINALIZE) {
+				mlog(ML_ERROR, "%s: received finalize1 from "
+				     "new master %u for dead node %u, but "
+				     "this node has already received it!\n",
+				     dlm->name, fr->node_idx, fr->dead_node);
+				dlm_print_reco_node_status(dlm);
+				BUG();
+			}
+			dlm->reco.state |= DLM_RECO_STATE_FINALIZE;
+			spin_unlock(&dlm->spinlock);
+			break;
+		case 2:
+			if (!(dlm->reco.state & DLM_RECO_STATE_FINALIZE)) {
+				mlog(ML_ERROR, "%s: received finalize2 from "
+				     "new master %u for dead node %u, but "
+				     "this node did not have finalize1!\n",
+				     dlm->name, fr->node_idx, fr->dead_node);
+				dlm_print_reco_node_status(dlm);
+				BUG();
+			}
+			dlm->reco.state &= ~DLM_RECO_STATE_FINALIZE;
+			spin_unlock(&dlm->spinlock);
+			dlm_reset_recovery(dlm);
+			dlm_kick_recovery_thread(dlm);
+			break;
+		default:
+			BUG();
+	}
 
-	dlm_reset_recovery(dlm);
+	mlog(0, "%s: recovery done, reco master was %u, dead now %u, master now %u\n",
+	     dlm->name, fr->node_idx, dlm->reco.dead_node, dlm->reco.new_master);
 
-	dlm_kick_recovery_thread(dlm);
 	dlm_put(dlm);
 	return 0;
 }
diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
index 44d3b57..0c822f3 100644
--- a/fs/ocfs2/dlm/dlmthread.c
+++ b/fs/ocfs2/dlm/dlmthread.c
@@ -39,6 +39,7 @@ #include <linux/socket.h>
 #include <linux/inet.h>
 #include <linux/timer.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 
 
 #include "cluster/heartbeat.h"
@@ -53,6 +54,8 @@ #define MLOG_MASK_PREFIX (ML_DLM|ML_DLM_
 #include "cluster/masklog.h"
 
 static int dlm_thread(void *data);
+static void dlm_purge_lockres_now(struct dlm_ctxt *dlm,
+				  struct dlm_lock_resource *lockres);
 
 static void dlm_flush_asts(struct dlm_ctxt *dlm);
 
@@ -80,7 +83,7 @@ repeat:
 }
 
 
-static int __dlm_lockres_unused(struct dlm_lock_resource *res)
+int __dlm_lockres_unused(struct dlm_lock_resource *res)
 {
 	if (list_empty(&res->granted) &&
 	    list_empty(&res->converting) &&
@@ -103,6 +106,20 @@ void __dlm_lockres_calc_usage(struct dlm
 	assert_spin_locked(&res->spinlock);
 
 	if (__dlm_lockres_unused(res)){
+		/* For now, just keep any resource we master */
+		if (res->owner == dlm->node_num)
+		{
+			if (!list_empty(&res->purge)) {
+				mlog(0, "we master %s:%.*s, but it is on "
+				     "the purge list.  Removing\n",
+				     dlm->name, res->lockname.len,
+				     res->lockname.name);
+				list_del_init(&res->purge);
+				dlm->purge_count--;
+			}
+			return;
+		}
+
 		if (list_empty(&res->purge)) {
 			mlog(0, "putting lockres %.*s from purge list\n",
 			     res->lockname.len, res->lockname.name);
@@ -110,10 +127,23 @@ void __dlm_lockres_calc_usage(struct dlm
 			res->last_used = jiffies;
 			list_add_tail(&res->purge, &dlm->purge_list);
 			dlm->purge_count++;
+
+			/* if this node is not the owner, there is
+			 * no way to keep track of who the owner could be.
+			 * unhash it to avoid serious problems. */
+			if (res->owner != dlm->node_num) {
+				mlog(0, "%s:%.*s: doing immediate "
+				     "purge of lockres owned by %u\n",
+				     dlm->name, res->lockname.len,
+				     res->lockname.name, res->owner);
+
+				dlm_purge_lockres_now(dlm, res);
+			}
 		}
 	} else if (!list_empty(&res->purge)) {
-		mlog(0, "removing lockres %.*s from purge list\n",
-		     res->lockname.len, res->lockname.name);
+		mlog(0, "removing lockres %.*s from purge list, "
+		     "owner=%u\n", res->lockname.len, res->lockname.name,
+		     res->owner);
 
 		list_del_init(&res->purge);
 		dlm->purge_count--;
@@ -165,6 +195,7 @@ again:
 	} else if (ret < 0) {
 		mlog(ML_NOTICE, "lockres %.*s: migrate failed, retrying\n",
 		     lockres->lockname.len, lockres->lockname.name);
+		msleep(100);
 		goto again;
 	}
 
@@ -178,6 +209,24 @@ finish:
 	__dlm_unhash_lockres(lockres);
 }
 
+/* make an unused lockres go away immediately.
+ * as soon as the dlm spinlock is dropped, this lockres
+ * will not be found. kfree still happens on last put. */
+static void dlm_purge_lockres_now(struct dlm_ctxt *dlm,
+				  struct dlm_lock_resource *lockres)
+{
+	assert_spin_locked(&dlm->spinlock);
+	assert_spin_locked(&lockres->spinlock);
+
+	BUG_ON(!__dlm_lockres_unused(lockres));
+
+	if (!list_empty(&lockres->purge)) {
+		list_del_init(&lockres->purge);
+		dlm->purge_count--;
+	}
+	__dlm_unhash_lockres(lockres);
+}
+
 static void dlm_run_purge_list(struct dlm_ctxt *dlm,
 			       int purge_now)
 {
@@ -420,6 +469,8 @@ void __dlm_dirty_lockres(struct dlm_ctxt
 	/* don't shuffle secondary queues */
 	if ((res->owner == dlm->node_num) &&
 	    !(res->state & DLM_LOCK_RES_DIRTY)) {
+		/* ref for dirty_list */
+		dlm_lockres_get(res);
 		list_add_tail(&res->dirty, &dlm->dirty_list);
 		res->state |= DLM_LOCK_RES_DIRTY;
 	}
@@ -604,6 +655,8 @@ static int dlm_thread(void *data)
 			list_del_init(&res->dirty);
 			spin_unlock(&res->spinlock);
 			spin_unlock(&dlm->spinlock);
+			/* Drop dirty_list ref */
+			dlm_lockres_put(res);
 
 		 	/* lockres can be re-dirtied/re-added to the
 			 * dirty_list in this gap, but that is ok */
@@ -640,8 +693,9 @@ static int dlm_thread(void *data)
 			 * spinlock and do NOT have the dlm lock.
 			 * safe to reserve/queue asts and run the lists. */
 
-			mlog(0, "calling dlm_shuffle_lists with dlm=%p, "
-			     "res=%p\n", dlm, res);
+			mlog(0, "calling dlm_shuffle_lists with dlm=%s, "
+			     "res=%.*s\n", dlm->name,
+			     res->lockname.len, res->lockname.name);
 
 			/* called while holding lockres lock */
 			dlm_shuffle_lists(dlm, res);
@@ -655,6 +709,8 @@ in_progress:
 			/* if the lock was in-progress, stick
 			 * it on the back of the list */
 			if (delay) {
+				/* ref for dirty_list */
+				dlm_lockres_get(res);
 				spin_lock(&res->spinlock);
 				list_add_tail(&res->dirty, &dlm->dirty_list);
 				res->state |= DLM_LOCK_RES_DIRTY;
@@ -675,7 +731,7 @@ in_progress:
 
 		/* yield and continue right away if there is more work to do */
 		if (!n) {
-			yield();
+			cond_resched();
 			continue;
 		}
 
diff --git a/fs/ocfs2/dlm/dlmunlock.c b/fs/ocfs2/dlm/dlmunlock.c
index ac89c50..b0c3134 100644
--- a/fs/ocfs2/dlm/dlmunlock.c
+++ b/fs/ocfs2/dlm/dlmunlock.c
@@ -318,6 +318,16 @@ static enum dlm_status dlm_send_remote_u
 
 	mlog_entry("%.*s\n", res->lockname.len, res->lockname.name);
 
+	if (owner == dlm->node_num) {
+		/* ended up trying to contact ourself.  this means
+		 * that the lockres had been remote but became local
+		 * via a migration.  just retry it, now as local */
+		mlog(0, "%s:%.*s: this node became the master due to a "
+		     "migration, re-evaluate now\n", dlm->name,
+		     res->lockname.len, res->lockname.name);
+		return DLM_FORWARD;
+	}
+
 	memset(&unlock, 0, sizeof(unlock));
 	unlock.node_idx = dlm->node_num;
 	unlock.flags = cpu_to_be32(flags);
diff --git a/fs/ocfs2/dlm/userdlm.c b/fs/ocfs2/dlm/userdlm.c
index 74ca4e5..e641b08 100644
--- a/fs/ocfs2/dlm/userdlm.c
+++ b/fs/ocfs2/dlm/userdlm.c
@@ -672,7 +672,7 @@ struct dlm_ctxt *user_dlm_register_conte
 	u32 dlm_key;
 	char *domain;
 
-	domain = kmalloc(name->len + 1, GFP_KERNEL);
+	domain = kmalloc(name->len + 1, GFP_NOFS);
 	if (!domain) {
 		mlog_errno(-ENOMEM);
 		return ERR_PTR(-ENOMEM);
