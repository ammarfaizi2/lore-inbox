Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbULLV13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbULLV13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbULLV12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:27:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37127 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262140AbULLVZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:25:36 -0500
Date: Sun, 12 Dec 2004 22:25:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Morris <jmorris@intercode.com.au>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/xfrm/: some cleanups
Message-ID: <20041212212523.GC22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following changes:
- make some needlessly global code static
- remove the EXPORT_SYMBOL_GPL'ed but unused function 
  xfrm_calg_get_byidx


diffstat output:
 include/net/xfrm.h     |    5 -----
 net/xfrm/xfrm_algo.c   |    8 --------
 net/xfrm/xfrm_export.c |    1 -
 net/xfrm/xfrm_policy.c |    8 ++++----
 net/xfrm/xfrm_state.c  |    7 +++++--
 net/xfrm/xfrm_user.c   |    4 ++--
 6 files changed, 11 insertions(+), 22 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/net/xfrm.h.old	2004-12-12 19:42:57.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/net/xfrm.h	2004-12-12 19:45:37.000000000 +0100
@@ -843,7 +843,6 @@
 } 
 #endif
 
-void xfrm_policy_init(void);
 struct xfrm_policy *xfrm_policy_alloc(int gfp);
 extern int xfrm_policy_walk(int (*func)(struct xfrm_policy *, int, int, void*), void *);
 int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl);
@@ -858,12 +857,9 @@
 				  int create, unsigned short family);
 extern void xfrm_policy_flush(void);
 extern int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
-extern struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir, struct flowi *fl);
 extern int xfrm_flush_bundles(void);
 
 extern wait_queue_head_t km_waitq;
-extern void km_state_expired(struct xfrm_state *x, int hard);
-extern int km_query(struct xfrm_state *x, struct xfrm_tmpl *, struct xfrm_policy *pol);
 extern int km_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr, u16 sport);
 extern void km_policy_expired(struct xfrm_policy *pol, int dir, int hard);
 
@@ -875,7 +871,6 @@
 extern int xfrm_count_enc_supported(void);
 extern struct xfrm_algo_desc *xfrm_aalg_get_byidx(unsigned int idx);
 extern struct xfrm_algo_desc *xfrm_ealg_get_byidx(unsigned int idx);
-extern struct xfrm_algo_desc *xfrm_calg_get_byidx(unsigned int idx);
 extern struct xfrm_algo_desc *xfrm_aalg_get_byid(int alg_id);
 extern struct xfrm_algo_desc *xfrm_ealg_get_byid(int alg_id);
 extern struct xfrm_algo_desc *xfrm_calg_get_byid(int alg_id);
--- linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_algo.c.old	2004-12-12 19:43:09.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_algo.c	2004-12-12 19:43:16.000000000 +0100
@@ -416,14 +416,6 @@
 	return &ealg_list[idx];
 }
 
-struct xfrm_algo_desc *xfrm_calg_get_byidx(unsigned int idx)
-{
-	if (idx >= calg_entries())
-		return NULL;
-
-	return &calg_list[idx];
-}
-
 /*
  * Probe for the availability of crypto algorithms, and set the available
  * flag for any algorithms found on the system.  This is typically called by
--- linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_export.c.old	2004-12-12 19:43:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_export.c	2004-12-12 19:43:26.000000000 +0100
@@ -53,7 +53,6 @@
 EXPORT_SYMBOL_GPL(xfrm_count_enc_supported);
 EXPORT_SYMBOL_GPL(xfrm_aalg_get_byidx);
 EXPORT_SYMBOL_GPL(xfrm_ealg_get_byidx);
-EXPORT_SYMBOL_GPL(xfrm_calg_get_byidx);
 EXPORT_SYMBOL_GPL(xfrm_aalg_get_byid);
 EXPORT_SYMBOL_GPL(xfrm_ealg_get_byid);
 EXPORT_SYMBOL_GPL(xfrm_calg_get_byid);
--- linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_policy.c.old	2004-12-12 19:43:41.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_policy.c	2004-12-12 19:44:43.000000000 +0100
@@ -33,7 +33,7 @@
 static rwlock_t xfrm_policy_afinfo_lock = RW_LOCK_UNLOCKED;
 static struct xfrm_policy_afinfo *xfrm_policy_afinfo[NPROTO];
 
-kmem_cache_t *xfrm_dst_cache;
+static kmem_cache_t *xfrm_dst_cache;
 
 static struct work_struct xfrm_policy_gc_work;
 static struct list_head xfrm_policy_gc_list =
@@ -498,7 +498,7 @@
 		*obj_refp = &pol->refcnt;
 }
 
-struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir, struct flowi *fl)
+static struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir, struct flowi *fl)
 {
 	struct xfrm_policy *pol;
 
@@ -1220,13 +1220,13 @@
 	return NOTIFY_DONE;
 }
 
-struct notifier_block xfrm_dev_notifier = {
+static struct notifier_block xfrm_dev_notifier = {
 	xfrm_dev_event,
 	NULL,
 	0
 };
 
-void __init xfrm_policy_init(void)
+static void __init xfrm_policy_init(void)
 {
 	xfrm_dst_cache = kmem_cache_create("xfrm_dst_cache",
 					   sizeof(struct xfrm_dst),
--- linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_state.c.old	2004-12-12 19:45:01.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_state.c	2004-12-12 19:46:03.000000000 +0100
@@ -51,6 +51,9 @@
 static struct xfrm_state_afinfo *xfrm_state_get_afinfo(unsigned short family);
 static void xfrm_state_put_afinfo(struct xfrm_state_afinfo *afinfo);
 
+static int km_query(struct xfrm_state *x, struct xfrm_tmpl *t, struct xfrm_policy *pol);
+static void km_state_expired(struct xfrm_state *x, int hard);
+
 static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
 	if (del_timer(&x->timer))
@@ -746,7 +749,7 @@
 static struct list_head xfrm_km_list = LIST_HEAD_INIT(xfrm_km_list);
 static rwlock_t		xfrm_km_lock = RW_LOCK_UNLOCKED;
 
-void km_state_expired(struct xfrm_state *x, int hard)
+static void km_state_expired(struct xfrm_state *x, int hard)
 {
 	struct xfrm_mgr *km;
 
@@ -764,7 +767,7 @@
 		wake_up(&km_waitq);
 }
 
-int km_query(struct xfrm_state *x, struct xfrm_tmpl *t, struct xfrm_policy *pol)
+static int km_query(struct xfrm_state *x, struct xfrm_tmpl *t, struct xfrm_policy *pol)
 {
 	int err = -EINVAL;
 	struct xfrm_mgr *km;
--- linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_user.c.old	2004-12-12 19:46:18.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/xfrm/xfrm_user.c	2004-12-12 19:46:35.000000000 +0100
@@ -1128,8 +1128,8 @@
 /* User gives us xfrm_user_policy_info followed by an array of 0
  * or more templates.
  */
-struct xfrm_policy *xfrm_compile_policy(u16 family, int opt,
-                                        u8 *data, int len, int *dir)
+static struct xfrm_policy *xfrm_compile_policy(u16 family, int opt,
+					       u8 *data, int len, int *dir)
 {
 	struct xfrm_userpolicy_info *p = (struct xfrm_userpolicy_info *)data;
 	struct xfrm_user_tmpl *ut = (struct xfrm_user_tmpl *) (p + 1);

