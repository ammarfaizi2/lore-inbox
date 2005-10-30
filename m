Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVJ3AnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVJ3AnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVJ3AnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:43:17 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932471AbVJ3AnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:43:15 -0400
Date: Sun, 30 Oct 2005 02:43:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Joel Becker <joel.becker@oracle.com>, Zach Brown <zach.brown@oracle.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Kurt Hackel <kurt.hackel@oracle.com>,
       Sunil Mushran <sunil.mushran@oracle.com>,
       Manish Singh <manish.singh@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/ocfs2/: possible cleanups
Message-ID: <20051030004308.GR4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- every function should #include the headers with the prototypes of it's
  global functions
- #if 0 unused code


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/ocfs2/alloc.c             |    4 +-
 fs/ocfs2/alloc.h             |    2 -
 fs/ocfs2/cluster/heartbeat.c |    5 ++
 fs/ocfs2/cluster/heartbeat.h |    2 -
 fs/ocfs2/cluster/sys.c       |    3 +
 fs/ocfs2/dlm/dlmast.c        |    4 +-
 fs/ocfs2/dlm/dlmcommon.h     |   31 ------------------
 fs/ocfs2/dlm/dlmdomain.c     |    4 +-
 fs/ocfs2/dlm/dlmdomain.h     |    1 
 fs/ocfs2/dlm/dlmlock.c       |    3 +
 fs/ocfs2/dlm/dlmmaster.c     |   59 ++++++++++++++++++++---------------
 fs/ocfs2/dlm/dlmrecovery.c   |   33 +++++++++++--------
 fs/ocfs2/dlm/dlmthread.c     |   11 +++++-
 fs/ocfs2/extent_map.c        |   10 ++++-
 fs/ocfs2/extent_map.h        |    8 ----
 fs/ocfs2/file.c              |    2 -
 fs/ocfs2/file.h              |    1 
 fs/ocfs2/ver.c               |    2 +
 fs/ocfs2/ver.h               |    1 
 19 files changed, 89 insertions(+), 97 deletions(-)

--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/cluster/sys.c.old	2005-10-30 00:51:49.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/cluster/sys.c	2005-10-30 00:54:54.000000000 +0200
@@ -31,6 +31,7 @@
 
 #include "ocfs2_nodemanager.h"
 #include "masklog.h"
+#include "sys.h"
 
 struct o2cb_attribute {
 	struct attribute	attr;
@@ -66,7 +67,7 @@
 	.store	= o2cb_store,
 };
 
-struct kobj_type o2cb_subsys_type = {
+static struct kobj_type o2cb_subsys_type = {
 	.default_attrs	= o2cb_attrs,
 	.sysfs_ops	= &o2cb_sysfs_ops,
 };
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/alloc.h.old	2005-10-30 00:52:28.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/alloc.h	2005-10-30 00:52:34.000000000 +0200
@@ -70,8 +70,6 @@
 	struct buffer_head *tc_last_eb_bh;
 };
 
-void ocfs2_free_truncate_context(struct ocfs2_truncate_context *tc);
-
 int ocfs2_prepare_truncate(ocfs2_super *osb,
 			   struct inode *inode,
 			   struct buffer_head *fe_bh,
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/alloc.c.old	2005-10-30 00:52:43.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/alloc.c	2005-10-30 00:53:01.000000000 +0200
@@ -92,6 +92,8 @@
 				       struct buffer_head *old_last_eb,
 				       struct buffer_head **new_last_eb);
 
+static void ocfs2_free_truncate_context(struct ocfs2_truncate_context *tc);
+
 static int ocfs2_extent_contig(struct inode *inode,
 			       ocfs2_extent_rec *ext,
 			       u64 blkno)
@@ -2018,7 +2020,7 @@
 	return status;
 }
 
-void ocfs2_free_truncate_context(struct ocfs2_truncate_context *tc)
+static void ocfs2_free_truncate_context(struct ocfs2_truncate_context *tc)
 {
 	if (tc->tc_ext_alloc_inode) {
 		if (tc->tc_ext_alloc_locked)
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/cluster/heartbeat.h.old	2005-10-30 00:53:18.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/cluster/heartbeat.h	2005-10-30 00:53:57.000000000 +0200
@@ -73,12 +73,10 @@
 int o2hb_unregister_callback(struct o2hb_callback_func *hc);
 void o2hb_fill_node_map(unsigned long *map,
 			unsigned bytes);
-void o2hb_fill_node_map_from_callback(unsigned long *map, unsigned bytes);
 void o2hb_init(void);
 int o2hb_check_node_heartbeating(u8 node_num);
 int o2hb_check_node_heartbeating_from_callback(u8 node_num);
 int o2hb_check_local_node_heartbeating(void);
-int o2hb_check_local_node_heartbeating_from_callback(void);
 void o2hb_stop_all_regions(void);
 
 #endif /* O2CLUSTER_HEARTBEAT_H */
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/cluster/heartbeat.c.old	2005-10-30 00:53:32.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/cluster/heartbeat.c	2005-10-30 00:54:19.000000000 +0200
@@ -969,7 +969,8 @@
 }
 
 /* if we're already in a callback then we're already serialized by the sem */
-void o2hb_fill_node_map_from_callback(unsigned long *map, unsigned bytes)
+static void o2hb_fill_node_map_from_callback(unsigned long *map,
+					     unsigned bytes)
 {
 	BUG_ON(bytes < (BITS_TO_LONGS(O2NM_MAX_NODES) * sizeof(unsigned long)));
 
@@ -1776,6 +1777,7 @@
 }
 EXPORT_SYMBOL_GPL(o2hb_check_local_node_heartbeating);
 
+#if 0
 /* Makes sure our local node is configured with a node number, and is
  * heartbeating. */
 int o2hb_check_local_node_heartbeating_from_callback(void)
@@ -1792,6 +1794,7 @@
 	return o2hb_check_node_heartbeating_from_callback(node_num);
 }
 EXPORT_SYMBOL_GPL(o2hb_check_local_node_heartbeating_from_callback);
+#endif  /*  0  */
 
 /*
  * this is just a hack until we get the plumbing which flips file systems
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmcommon.h.old	2005-10-30 00:55:09.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmcommon.h	2005-10-30 01:07:28.000000000 +0200
@@ -634,7 +634,6 @@
 void dlm_lock_get(struct dlm_lock *lock);
 void dlm_lock_put(struct dlm_lock *lock);
 
-void dlm_lock_detach_lockres(struct dlm_lock *lock);
 void dlm_lock_attach_lockres(struct dlm_lock *lock,
 			     struct dlm_lock_resource *res);
 
@@ -653,17 +652,12 @@
 void dlm_commit_pending_unlock(struct dlm_lock_resource *res,
 			       struct dlm_lock *lock);
 
-void dlm_shuffle_lists(struct dlm_ctxt *dlm,
-		       struct dlm_lock_resource *res);
 int dlm_launch_thread(struct dlm_ctxt *dlm);
 void dlm_complete_thread(struct dlm_ctxt *dlm);
-void dlm_flush_asts(struct dlm_ctxt *dlm);
-int dlm_flush_lockres_asts(struct dlm_ctxt *dlm, struct dlm_lock_resource *res);
 int dlm_launch_recovery_thread(struct dlm_ctxt *dlm);
 void dlm_complete_recovery_thread(struct dlm_ctxt *dlm);
 void dlm_wait_for_recovery(struct dlm_ctxt *dlm);
 
-void dlm_get(struct dlm_ctxt *dlm);
 void dlm_put(struct dlm_ctxt *dlm);
 struct dlm_ctxt *dlm_grab(struct dlm_ctxt *dlm);
 int dlm_domain_fully_joined(struct dlm_ctxt *dlm);
@@ -697,9 +691,7 @@
 					  const char *name,
 					  unsigned int namelen);
 
-void __dlm_queue_ast(struct dlm_ctxt *dlm, struct dlm_lock *lock);
 void dlm_queue_ast(struct dlm_ctxt *dlm, struct dlm_lock *lock);
-void __dlm_queue_bast(struct dlm_ctxt *dlm, struct dlm_lock *lock);
 void dlm_queue_bast(struct dlm_ctxt *dlm, struct dlm_lock *lock);
 void dlm_do_local_ast(struct dlm_ctxt *dlm,
 		      struct dlm_lock_resource *res,
@@ -739,17 +731,13 @@
 
 u8 dlm_nm_this_node(struct dlm_ctxt *dlm);
 void dlm_kick_thread(struct dlm_ctxt *dlm, struct dlm_lock_resource *res);
-void __dlm_kick_thread(struct dlm_ctxt *dlm, struct dlm_lock_resource *res);
 void __dlm_dirty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res);
 
 
 int dlm_nm_init(struct dlm_ctxt *dlm);
 int dlm_heartbeat_init(struct dlm_ctxt *dlm);
-void __dlm_hb_node_down(struct dlm_ctxt *dlm, int idx);
 void dlm_hb_node_down_cb(struct o2nm_node *node, int idx, void *data);
 void dlm_hb_node_up_cb(struct o2nm_node *node, int idx, void *data);
-int dlm_hb_node_dead(struct dlm_ctxt *dlm, int node);
-int __dlm_hb_node_dead(struct dlm_ctxt *dlm, int node);
 
 int dlm_lockres_is_dirty(struct dlm_ctxt *dlm, struct dlm_lock_resource *res);
 int dlm_migrate_lockres(struct dlm_ctxt *dlm,
@@ -777,7 +765,6 @@
 			       int ignore_higher,
 			       u8 request_from,
 			       u32 flags);
-void dlm_assert_master_worker(struct dlm_work_item *item, void *data);
 
 
 int dlm_send_one_lockres(struct dlm_ctxt *dlm,
@@ -788,11 +775,6 @@
 void dlm_move_lockres_to_recovery_list(struct dlm_ctxt *dlm,
 				       struct dlm_lock_resource *res);
 
-void dlm_init_lockres(struct dlm_ctxt *dlm,
-		      struct dlm_lock_resource *res,
-		      const char *name,
-		      unsigned int namelen);
-
 /* will exit holding res->spinlock, but may drop in function */
 void __dlm_wait_on_lockres_flags(struct dlm_lock_resource *res, int flags);
 void __dlm_wait_on_lockres_flags_set(struct dlm_lock_resource *res, int flags);
@@ -809,24 +791,11 @@
 int dlm_init_mle_cache(void);
 void dlm_destroy_mle_cache(void);
 void dlm_hb_event_notify_attached(struct dlm_ctxt *dlm, int idx, int node_up);
-int dlm_do_assert_master(struct dlm_ctxt *dlm,
-			 const char *lockname,
-			 unsigned int namelen,
-			 void *nodemap,
-			 u32 flags);
-int dlm_do_migrate_request(struct dlm_ctxt *dlm,
-			   struct dlm_lock_resource *res,
-			   u8 master,
-			   u8 new_master,
-			   struct dlm_node_iter *iter);
 void dlm_clean_master_list(struct dlm_ctxt *dlm,
 			   u8 dead_node);
 int dlm_lock_basts_flushed(struct dlm_ctxt *dlm, struct dlm_lock *lock);
 
 
-int dlm_dump_all_mles(const char __user *data, unsigned int len);
-
-
 static inline const char * dlm_lock_mode_name(int mode)
 {
 	switch (mode) {
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmast.c.old	2005-10-30 00:55:22.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmast.c	2005-10-30 00:55:44.000000000 +0200
@@ -91,7 +91,7 @@
 	return 0;
 }
 
-void __dlm_queue_ast(struct dlm_ctxt *dlm, struct dlm_lock *lock)
+static void __dlm_queue_ast(struct dlm_ctxt *dlm, struct dlm_lock *lock)
 {
 	mlog_entry_void();
 
@@ -136,7 +136,7 @@
 }
 
 
-void __dlm_queue_bast(struct dlm_ctxt *dlm, struct dlm_lock *lock)
+static void __dlm_queue_bast(struct dlm_ctxt *dlm, struct dlm_lock *lock)
 {
 	mlog_entry_void();
 
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmdomain.h.old	2005-10-30 00:56:03.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmdomain.h	2005-10-30 00:56:09.000000000 +0200
@@ -28,7 +28,6 @@
 extern spinlock_t dlm_domain_lock;
 extern struct list_head dlm_domains;
 
-struct dlm_ctxt * __dlm_lookup_domain(const char *domain);
 int dlm_joined(struct dlm_ctxt *dlm);
 int dlm_shutting_down(struct dlm_ctxt *dlm);
 void dlm_fire_domain_eviction_callbacks(struct dlm_ctxt *dlm,
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmdomain.c.old	2005-10-30 00:56:17.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmdomain.c	2005-10-30 01:15:35.000000000 +0200
@@ -163,7 +163,7 @@
 }
 
 /* For null terminated domain strings ONLY */
-struct dlm_ctxt * __dlm_lookup_domain(const char *domain)
+static struct dlm_ctxt * __dlm_lookup_domain(const char *domain)
 {
 	assert_spin_locked(&dlm_domain_lock);
 
@@ -266,12 +266,14 @@
 	return target;
 }
 
+#if 0
 void dlm_get(struct dlm_ctxt *dlm)
 {
 	spin_lock(&dlm_domain_lock);
 	__dlm_get(dlm);
 	spin_unlock(&dlm_domain_lock);
 }
+#endif  /*  0  */
 
 int dlm_domain_fully_joined(struct dlm_ctxt *dlm)
 {
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmlock.c.old	2005-10-30 00:58:06.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmlock.c	2005-10-30 00:58:23.000000000 +0200
@@ -62,6 +62,7 @@
 static void dlm_init_lock(struct dlm_lock *newlock, int type,
 			  u8 node, u64 cookie);
 static void dlm_lock_release(struct kref *kref);
+static void dlm_lock_detach_lockres(struct dlm_lock *lock);
 
 /* Tell us whether we can grant a new lock request.
  * locking:
@@ -312,7 +313,7 @@
 }
 
 /* drop ref on lockres, if there is still one associated with lock */
-void dlm_lock_detach_lockres(struct dlm_lock *lock)
+static void dlm_lock_detach_lockres(struct dlm_lock *lock)
 {
 	struct dlm_lock_resource *res;
 
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmmaster.c.old	2005-10-30 00:58:51.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmmaster.c	2005-10-30 01:18:23.000000000 +0200
@@ -88,16 +88,19 @@
 	} u;
 };
 
-void dlm_print_one_mle(struct dlm_master_list_entry *mle);
-
-void dlm_mle_node_down(struct dlm_ctxt *dlm,
-		       struct dlm_master_list_entry *mle,
-		       struct o2nm_node *node,
-		       int idx);
-void dlm_mle_node_up(struct dlm_ctxt *dlm,
-		     struct dlm_master_list_entry *mle,
-		     struct o2nm_node *node,
-		     int idx);
+static void dlm_mle_node_down(struct dlm_ctxt *dlm,
+			      struct dlm_master_list_entry *mle,
+			      struct o2nm_node *node,
+			      int idx);
+static void dlm_mle_node_up(struct dlm_ctxt *dlm,
+			    struct dlm_master_list_entry *mle,
+			    struct o2nm_node *node,
+			    int idx);
+
+static void dlm_assert_master_worker(struct dlm_work_item *item, void *data);
+static int dlm_do_assert_master(struct dlm_ctxt *dlm, const char *lockname,
+				unsigned int namelen, void *nodemap,
+				u32 flags);
 
 static inline int dlm_mle_equal(struct dlm_ctxt *dlm,
 				struct dlm_master_list_entry *mle,
@@ -123,6 +126,8 @@
 	return 1;
 }
 
+#if 0
+
 void dlm_print_one_mle(struct dlm_master_list_entry *mle)
 {
 	int i = 0, refs;
@@ -152,9 +157,6 @@
 		  namelen, namelen, name);
 }
 
-			      
-static void dlm_dump_mles(struct dlm_ctxt *dlm);
-
 static void dlm_dump_mles(struct dlm_ctxt *dlm)
 {
 	struct dlm_master_list_entry *mle;
@@ -189,6 +191,8 @@
 }
 EXPORT_SYMBOL_GPL(dlm_dump_all_mles);
 
+#endif  /*  0  */
+
 
 static kmem_cache_t *dlm_mle_cache = NULL;
 
@@ -419,8 +423,9 @@
 	}
 }
 
-void dlm_mle_node_down(struct dlm_ctxt *dlm, struct dlm_master_list_entry *mle,
-		       struct o2nm_node *node, int idx)
+static void dlm_mle_node_down(struct dlm_ctxt *dlm,
+			      struct dlm_master_list_entry *mle,
+			      struct o2nm_node *node, int idx)
 {
 	spin_lock(&mle->spinlock);
 
@@ -432,8 +437,9 @@
 	spin_unlock(&mle->spinlock);
 }
 
-void dlm_mle_node_up(struct dlm_ctxt *dlm, struct dlm_master_list_entry *mle,
-		     struct o2nm_node *node, int idx)
+static void dlm_mle_node_up(struct dlm_ctxt *dlm,
+			    struct dlm_master_list_entry *mle,
+			    struct o2nm_node *node, int idx)
 {
 	spin_lock(&mle->spinlock);
 
@@ -576,8 +582,9 @@
 	kref_put(&res->refs, dlm_lockres_release);
 }
 
-void dlm_init_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res,
-		      const char *name, unsigned int namelen)
+static void dlm_init_lockres(struct dlm_ctxt *dlm,
+			     struct dlm_lock_resource *res,
+			     const char *name, unsigned int namelen)
 {
 	char *qname;
 
@@ -1427,9 +1434,9 @@
  * can periodically run all locks owned by this node
  * and re-assert across the cluster...
  */
-int dlm_do_assert_master(struct dlm_ctxt *dlm, const char *lockname,
-			 unsigned int namelen, void *nodemap,
-			 u32 flags)
+static int dlm_do_assert_master(struct dlm_ctxt *dlm, const char *lockname,
+				unsigned int namelen, void *nodemap,
+				u32 flags)
 {
 	struct dlm_assert_master assert;
 	int to, tmpret;
@@ -1670,7 +1677,7 @@
 	return 0;
 }
 
-void dlm_assert_master_worker(struct dlm_work_item *item, void *data)
+static void dlm_assert_master_worker(struct dlm_work_item *item, void *data)
 {
 	struct dlm_ctxt *dlm = data;
 	int ret = 0;
@@ -2182,8 +2189,10 @@
 
 /* this is called by the new master once all lockres
  * data has been received */
-int dlm_do_migrate_request(struct dlm_ctxt *dlm, struct dlm_lock_resource *res,
-			   u8 master, u8 new_master, struct dlm_node_iter *iter)
+static int dlm_do_migrate_request(struct dlm_ctxt *dlm,
+				  struct dlm_lock_resource *res,
+				  u8 master, u8 new_master,
+				  struct dlm_node_iter *iter)
 {
 	struct dlm_migrate_request migrate;
 	int ret, status = 0;
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmrecovery.c.old	2005-10-30 01:02:58.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmrecovery.c	2005-10-30 01:16:39.000000000 +0200
@@ -57,15 +57,15 @@
 static int dlm_recovery_thread(void *data);
 void dlm_complete_recovery_thread(struct dlm_ctxt *dlm);
 int dlm_launch_recovery_thread(struct dlm_ctxt *dlm);
-void dlm_kick_recovery_thread(struct dlm_ctxt *dlm);
-int dlm_do_recovery(struct dlm_ctxt *dlm);
+static void dlm_kick_recovery_thread(struct dlm_ctxt *dlm);
+static int dlm_do_recovery(struct dlm_ctxt *dlm);
 
-int dlm_pick_recovery_master(struct dlm_ctxt *dlm);
+static int dlm_pick_recovery_master(struct dlm_ctxt *dlm);
 static int dlm_remaster_locks(struct dlm_ctxt *dlm, u8 dead_node);
-int dlm_init_recovery_area(struct dlm_ctxt *dlm, u8 dead_node);
-int dlm_request_all_locks(struct dlm_ctxt *dlm,
-			  u8 request_from, u8 dead_node);
-void dlm_destroy_recovery_area(struct dlm_ctxt *dlm, u8 dead_node);
+static int dlm_init_recovery_area(struct dlm_ctxt *dlm, u8 dead_node);
+static int dlm_request_all_locks(struct dlm_ctxt *dlm,
+				 u8 request_from, u8 dead_node);
+static void dlm_destroy_recovery_area(struct dlm_ctxt *dlm, u8 dead_node);
 
 static inline int dlm_num_locks_in_lockres(struct dlm_lock_resource *res);
 static void dlm_init_migratable_lockres(struct dlm_migratable_lockres *mres,
@@ -164,7 +164,7 @@
  * RECOVERY THREAD
  */
 
-void dlm_kick_recovery_thread(struct dlm_ctxt *dlm)
+static void dlm_kick_recovery_thread(struct dlm_ctxt *dlm)
 {
 	/* wake the recovery thread
 	 * this will wake the reco thread in one of three places
@@ -294,7 +294,7 @@
 	wake_up(&dlm->reco.event);
 }
 
-int dlm_do_recovery(struct dlm_ctxt *dlm)
+static int dlm_do_recovery(struct dlm_ctxt *dlm)
 {
 	int status = 0;
 
@@ -538,7 +538,7 @@
 	return status;
 }
 
-int dlm_init_recovery_area(struct dlm_ctxt *dlm, u8 dead_node)
+static int dlm_init_recovery_area(struct dlm_ctxt *dlm, u8 dead_node)
 {
 	int num=0;
 	struct dlm_reco_node_data *ndata;
@@ -572,7 +572,7 @@
 	return 0;
 }
 
-void dlm_destroy_recovery_area(struct dlm_ctxt *dlm, u8 dead_node)
+static void dlm_destroy_recovery_area(struct dlm_ctxt *dlm, u8 dead_node)
 {
 	struct list_head *iter, *iter2;
 	struct dlm_reco_node_data *ndata;
@@ -589,7 +589,8 @@
 	}
 }
 
-int dlm_request_all_locks(struct dlm_ctxt *dlm, u8 request_from, u8 dead_node)
+static int dlm_request_all_locks(struct dlm_ctxt *dlm, u8 request_from,
+				 u8 dead_node)
 {
 	struct dlm_lock_request lr;
 	enum dlm_status ret;
@@ -1784,7 +1785,7 @@
 
 }
 
-void __dlm_hb_node_down(struct dlm_ctxt *dlm, int idx)
+static void __dlm_hb_node_down(struct dlm_ctxt *dlm, int idx)
 {
 	assert_spin_locked(&dlm->spinlock);
 
@@ -1865,6 +1866,8 @@
 	dlm_put(dlm);
 }
 
+#if 0
+
 int __dlm_hb_node_dead(struct dlm_ctxt *dlm, int node)
 {
 	if (test_bit(node, dlm->recovery_map))
@@ -1881,6 +1884,8 @@
 	return ret;
 }
 
+#endif  /*  0  */
+
 static void dlm_reco_ast(void *astdata)
 {
 	struct dlm_ctxt *dlm = astdata;
@@ -1899,7 +1904,7 @@
 }
 
 
-int dlm_pick_recovery_master(struct dlm_ctxt *dlm)
+static int dlm_pick_recovery_master(struct dlm_ctxt *dlm)
 {
 	enum dlm_status ret;
 	struct dlm_lockstatus lksb;
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmthread.c.old	2005-10-30 01:06:11.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/dlm/dlmthread.c	2005-10-30 01:07:41.000000000 +0200
@@ -57,6 +57,8 @@
 
 static int dlm_thread(void *data);
 
+static void dlm_flush_asts(struct dlm_ctxt *dlm);
+
 #define dlm_lock_is_remote(dlm, lock)     ((lock)->ml.node != (dlm)->node_num)
 
 /* will exit holding res->spinlock, but may drop in function */
@@ -236,7 +238,8 @@
 	spin_unlock(&dlm->spinlock);
 }
 
-void dlm_shuffle_lists(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
+static void dlm_shuffle_lists(struct dlm_ctxt *dlm,
+			      struct dlm_lock_resource *res)
 {
 	struct dlm_lock *lock, *target;
 	struct list_head *iter;
@@ -412,6 +415,7 @@
 	wake_up(&dlm->dlm_thread_wq);
 }
 
+#if 0
 void __dlm_kick_thread(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
 {
 	mlog_entry("dlm=%p, res=%p\n", dlm, res);
@@ -420,6 +424,7 @@
 
 	wake_up(&dlm->dlm_thread_wq);
 }
+#endif  /*  0  */
 
 void __dlm_dirty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
 {
@@ -472,14 +477,16 @@
 	return empty;
 }
 
+#if 0
 int dlm_flush_lockres_asts(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
 {
 	dlm_flush_asts(dlm);
 	/* still need to implement dlm_flush_lockres_asts */
 	return 0;
 }
+#endif  /*  0  */
 
-void dlm_flush_asts(struct dlm_ctxt *dlm)
+static void dlm_flush_asts(struct dlm_ctxt *dlm)
 {
 	int ret;
 	struct dlm_lock *lock;
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/extent_map.h.old	2005-10-30 01:07:53.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/extent_map.h	2005-10-30 01:09:22.000000000 +0200
@@ -34,16 +34,8 @@
  * in the process of being updated.
  */
 int ocfs2_extent_map_init(struct inode *inode);
-int ocfs2_extent_map_insert(struct inode *inode, ocfs2_extent_rec *rec,
-			    int tree_depth);
 int ocfs2_extent_map_append(struct inode *inode, ocfs2_extent_rec *rec,
 			    u32 new_clusters);
-int ocfs2_extent_map_get_rec(struct inode *inode, u32 cpos,
-			     ocfs2_extent_rec **rec,
-			     int *tree_depth);
-int ocfs2_extent_map_get_clusters(struct inode *inode,
-				  u32 v_cpos, int count,
-			  	  u32 *p_cpos, int *ret_count);
 int ocfs2_extent_map_get_blocks(struct inode *inode,
 				u64 v_blkno, int count,
 				u64 *p_blkno, int *ret_count);
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/extent_map.c.old	2005-10-30 01:08:05.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/extent_map.c	2005-10-30 01:10:02.000000000 +0200
@@ -69,6 +69,8 @@
 			u32 cpos, u32 clusters,
 			struct rb_node ***ret_p,
 			struct rb_node **ret_parent);
+static int ocfs2_extent_map_insert(struct inode *inode, ocfs2_extent_rec *rec,
+				   int tree_depth);
 static int ocfs2_extent_map_insert_entry(struct ocfs2_extent_map *em,
 					 struct ocfs2_extent_map_entry *ent);
 static int ocfs2_extent_map_find_leaf(struct inode *inode,
@@ -482,8 +484,8 @@
 }
 
 
-int ocfs2_extent_map_insert(struct inode *inode, ocfs2_extent_rec *rec,
-			    int tree_depth)
+static int ocfs2_extent_map_insert(struct inode *inode, ocfs2_extent_rec *rec,
+				   int tree_depth)
 {
 	int ret;
 	struct ocfs2_em_insert_context ctxt = {0, };
@@ -633,6 +635,8 @@
 	return ret;
 }
 
+#if 0
+
 /*
  * Look up the record containing this cluster offset.  This record is
  * part of the extent map.  Do not free it.  Any changes you make to
@@ -736,6 +740,8 @@
 	return -ENOENT;
 }
 
+#endif  /*  0  */
+
 int ocfs2_extent_map_get_blocks(struct inode *inode,
 				u64 v_blkno, int count,
 				u64 *p_blkno, int *ret_count)
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/file.h.old	2005-10-30 01:10:17.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/file.h	2005-10-30 01:10:22.000000000 +0200
@@ -47,7 +47,6 @@
 int ocfs2_setattr(struct dentry *dentry, struct iattr *attr);
 int ocfs2_getattr(struct vfsmount *mnt, struct dentry *dentry,
 		  struct kstat *stat);
-int ocfs2_sync_inode(struct inode *inode);
 int ocfs2_extend_file(ocfs2_super *osb,
 		      struct inode *inode,
 		      u64 new_i_size,
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/file.c.old	2005-10-30 01:10:29.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/file.c	2005-10-30 01:10:35.000000000 +0200
@@ -56,7 +56,7 @@
 				     struct buffer_head *fe_bh,
 				     u64 new_i_size);
 
-int ocfs2_sync_inode(struct inode *inode)
+static int ocfs2_sync_inode(struct inode *inode)
 {
 	filemap_fdatawrite(inode->i_mapping);
 	return sync_mapping_buffers(inode->i_mapping);
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/ver.h.old	2005-10-30 01:10:54.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/ver.h	2005-10-30 01:10:59.000000000 +0200
@@ -27,6 +27,5 @@
 #define OCFS2_VER_H
 
 void ocfs2_print_version(void);
-int ocfs2_str_version(char *buf);
 
 #endif /* OCFS2_VER_H */
--- linux-2.6.14-rc5-mm1-full/fs/ocfs2/ver.c.old	2005-10-30 01:11:06.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/fs/ocfs2/ver.c	2005-10-30 01:13:07.000000000 +0200
@@ -38,10 +38,12 @@
 	printk(KERN_INFO "%s\n", VERSION_STR);
 }
 
+#if 0
 int ocfs2_str_version(char *buf)
 {
 	return sprintf(buf, "%s\n", VERSION_STR);
 }
+#endif  /*  0  */
 
 MODULE_DESCRIPTION(VERSION_STR);
 

