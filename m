Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVASJW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVASJW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVASJVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:21:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47629 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261649AbVASJRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:17:23 -0500
Date: Wed, 19 Jan 2005 10:17:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill xfrm_export.c
Message-ID: <20050119091715.GQ1841@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes xfrm_export.c and moves the EXPORT_SYMBOL{,_GPL}'s to 
the files where the actual functions are.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

diffstat output:
 net/xfrm/Makefile      |    3 -
 net/xfrm/xfrm_algo.c   |   12 +++++++
 net/xfrm/xfrm_export.c |   62 -----------------------------------------
 net/xfrm/xfrm_input.c  |    4 ++
 net/xfrm/xfrm_policy.c |   20 ++++++++++++-
 net/xfrm/xfrm_state.c  |   29 +++++++++++++++++--
 6 files changed, 63 insertions(+), 67 deletions(-)


--- linux-2.6.11-rc1-mm1-full/net/xfrm/Makefile.old	2005-01-19 09:43:09.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/net/xfrm/Makefile	2005-01-19 09:43:23.000000000 +0100
@@ -2,7 +2,6 @@
 # Makefile for the XFRM subsystem.
 #
 
-obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_input.o xfrm_algo.o \
-	xfrm_export.o
+obj-$(CONFIG_XFRM) := xfrm_policy.o xfrm_state.o xfrm_input.o xfrm_algo.o
 obj-$(CONFIG_XFRM_USER) += xfrm_user.o
 
--- linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_state.c.old	2005-01-19 09:44:46.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_state.c	2005-01-19 09:58:22.000000000 +0100
@@ -17,6 +17,7 @@
 #include <net/xfrm.h>
 #include <linux/pfkeyv2.h>
 #include <linux/ipsec.h>
+#include <linux/module.h>
 #include <asm/uaccess.h>
 
 /* Each xfrm_state may be linked to two tables:
@@ -38,6 +39,7 @@
 static struct list_head xfrm_state_byspi[XFRM_DST_HSIZE];
 
 DECLARE_WAIT_QUEUE_HEAD(km_waitq);
+EXPORT_SYMBOL(km_waitq);
 
 static DEFINE_RWLOCK(xfrm_state_afinfo_lock);
 static struct xfrm_state_afinfo *xfrm_state_afinfo[NPROTO];
@@ -193,6 +195,7 @@
 	}
 	return x;
 }
+EXPORT_SYMBOL(xfrm_state_alloc);
 
 void __xfrm_state_destroy(struct xfrm_state *x)
 {
@@ -203,6 +206,7 @@
 	spin_unlock_bh(&xfrm_state_gc_lock);
 	schedule_work(&xfrm_state_gc_work);
 }
+EXPORT_SYMBOL(__xfrm_state_destroy);
 
 static void __xfrm_state_delete(struct xfrm_state *x)
 {
@@ -241,6 +245,7 @@
 	__xfrm_state_delete(x);
 	spin_unlock_bh(&x->lock);
 }
+EXPORT_SYMBOL(xfrm_state_delete);
 
 void xfrm_state_flush(u8 proto)
 {
@@ -267,6 +272,7 @@
 	spin_unlock_bh(&xfrm_state_lock);
 	wake_up(&km_waitq);
 }
+EXPORT_SYMBOL(xfrm_state_flush);
 
 static int
 xfrm_init_tempsel(struct xfrm_state *x, struct flowi *fl,
@@ -392,6 +398,7 @@
 	__xfrm_state_insert(x);
 	spin_unlock_bh(&xfrm_state_lock);
 }
+EXPORT_SYMBOL(xfrm_state_insert);
 
 static struct xfrm_state *__xfrm_find_acq_byseq(u32 seq);
 
@@ -444,6 +451,7 @@
 
 	return err;
 }
+EXPORT_SYMBOL(xfrm_state_add);
 
 int xfrm_state_update(struct xfrm_state *x)
 {
@@ -508,6 +516,7 @@
 
 	return err;
 }
+EXPORT_SYMBOL(xfrm_state_update);
 
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
@@ -531,6 +540,7 @@
 		km_state_expired(x, 0);
 	return 0;
 }
+EXPORT_SYMBOL(xfrm_state_check_expire);
 
 static int xfrm_state_check_space(struct xfrm_state *x, struct sk_buff *skb)
 {
@@ -553,6 +563,7 @@
 err:
 	return err;
 }
+EXPORT_SYMBOL(xfrm_state_check);
 
 struct xfrm_state *
 xfrm_state_lookup(xfrm_address_t *daddr, u32 spi, u8 proto,
@@ -569,6 +580,7 @@
 	xfrm_state_put_afinfo(afinfo);
 	return x;
 }
+EXPORT_SYMBOL(xfrm_state_lookup);
 
 struct xfrm_state *
 xfrm_find_acq(u8 mode, u32 reqid, u8 proto, 
@@ -586,6 +598,7 @@
 	xfrm_state_put_afinfo(afinfo);
 	return x;
 }
+EXPORT_SYMBOL(xfrm_find_acq);
 
 /* Silly enough, but I'm lazy to build resolution list */
 
@@ -614,7 +627,8 @@
 	spin_unlock_bh(&xfrm_state_lock);
 	return x;
 }
- 
+EXPORT_SYMBOL(xfrm_find_acq_byseq);
+
 u32 xfrm_get_acqseq(void)
 {
 	u32 res;
@@ -626,6 +640,7 @@
 	spin_unlock_bh(&acqseq_lock);
 	return res;
 }
+EXPORT_SYMBOL(xfrm_get_acqseq);
 
 void
 xfrm_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi)
@@ -666,6 +681,7 @@
 		wake_up(&km_waitq);
 	}
 }
+EXPORT_SYMBOL(xfrm_alloc_spi);
 
 int xfrm_state_walk(u8 proto, int (*func)(struct xfrm_state *, int, void*),
 		    void *data)
@@ -700,7 +716,7 @@
 	spin_unlock_bh(&xfrm_state_lock);
 	return err;
 }
-
+EXPORT_SYMBOL(xfrm_state_walk);
 
 int xfrm_replay_check(struct xfrm_state *x, u32 seq)
 {
@@ -726,6 +742,7 @@
 	}
 	return 0;
 }
+EXPORT_SYMBOL(xfrm_replay_check);
 
 void xfrm_replay_advance(struct xfrm_state *x, u32 seq)
 {
@@ -745,6 +762,7 @@
 		x->replay.bitmap |= (1U << diff);
 	}
 }
+EXPORT_SYMBOL(xfrm_replay_advance);
 
 static struct list_head xfrm_km_list = LIST_HEAD_INIT(xfrm_km_list);
 static DEFINE_RWLOCK(xfrm_km_lock);
@@ -797,6 +815,7 @@
 	read_unlock(&xfrm_km_lock);
 	return err;
 }
+EXPORT_SYMBOL(km_new_mapping);
 
 void km_policy_expired(struct xfrm_policy *pol, int dir, int hard)
 {
@@ -850,6 +869,7 @@
 	kfree(data);
 	return err;
 }
+EXPORT_SYMBOL(xfrm_user_policy);
 
 int xfrm_register_km(struct xfrm_mgr *km)
 {
@@ -858,6 +878,7 @@
 	write_unlock_bh(&xfrm_km_lock);
 	return 0;
 }
+EXPORT_SYMBOL(xfrm_register_km);
 
 int xfrm_unregister_km(struct xfrm_mgr *km)
 {
@@ -866,6 +887,7 @@
 	write_unlock_bh(&xfrm_km_lock);
 	return 0;
 }
+EXPORT_SYMBOL(xfrm_unregister_km);
 
 int xfrm_state_register_afinfo(struct xfrm_state_afinfo *afinfo)
 {
@@ -885,6 +907,7 @@
 	write_unlock(&xfrm_state_afinfo_lock);
 	return err;
 }
+EXPORT_SYMBOL(xfrm_state_register_afinfo);
 
 int xfrm_state_unregister_afinfo(struct xfrm_state_afinfo *afinfo)
 {
@@ -906,6 +929,7 @@
 	write_unlock(&xfrm_state_afinfo_lock);
 	return err;
 }
+EXPORT_SYMBOL(xfrm_state_unregister_afinfo);
 
 static struct xfrm_state_afinfo *xfrm_state_get_afinfo(unsigned short family)
 {
@@ -940,6 +964,7 @@
 		x->tunnel = NULL;
 	}
 }
+EXPORT_SYMBOL(xfrm_state_delete_tunnel);
 
 void __init xfrm_state_init(void)
 {
--- linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_policy.c.old	2005-01-19 09:47:53.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_policy.c	2005-01-19 10:00:08.000000000 +0100
@@ -21,14 +21,17 @@
 #include <linux/workqueue.h>
 #include <linux/notifier.h>
 #include <linux/netdevice.h>
+#include <linux/module.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
 
 DECLARE_MUTEX(xfrm_cfg_sem);
+EXPORT_SYMBOL(xfrm_cfg_sem);
 
 static DEFINE_RWLOCK(xfrm_policy_lock);
 
 struct xfrm_policy *xfrm_policy_list[XFRM_POLICY_MAX*2];
+EXPORT_SYMBOL(xfrm_policy_list);
 
 static DEFINE_RWLOCK(xfrm_policy_afinfo_lock);
 static struct xfrm_policy_afinfo *xfrm_policy_afinfo[NPROTO];
@@ -62,6 +65,7 @@
 	xfrm_policy_put_afinfo(afinfo);
 	return err;
 }
+EXPORT_SYMBOL(xfrm_register_type);
 
 int xfrm_unregister_type(struct xfrm_type *type, unsigned short family)
 {
@@ -82,6 +86,7 @@
 	xfrm_policy_put_afinfo(afinfo);
 	return err;
 }
+EXPORT_SYMBOL(xfrm_unregister_type);
 
 struct xfrm_type *xfrm_get_type(u8 proto, unsigned short family)
 {
@@ -112,6 +117,7 @@
 	xfrm_policy_put_afinfo(afinfo);
 	return type;
 }
+EXPORT_SYMBOL(xfrm_get_type);
 
 int xfrm_dst_lookup(struct xfrm_dst **dst, struct flowi *fl, 
 		    unsigned short family)
@@ -129,6 +135,7 @@
 	xfrm_policy_put_afinfo(afinfo);
 	return err;
 }
+EXPORT_SYMBOL(xfrm_dst_lookup);
 
 void xfrm_put_type(struct xfrm_type *type)
 {
@@ -234,6 +241,7 @@
 	}
 	return policy;
 }
+EXPORT_SYMBOL(xfrm_policy_alloc);
 
 /* Destroy xfrm_policy: descendant resources must be released to this moment. */
 
@@ -250,6 +258,7 @@
 
 	kfree(policy);
 }
+EXPORT_SYMBOL(__xfrm_policy_destroy);
 
 static void xfrm_policy_gc_kill(struct xfrm_policy *policy)
 {
@@ -373,6 +382,7 @@
 	}
 	return 0;
 }
+EXPORT_SYMBOL(xfrm_policy_insert);
 
 struct xfrm_policy *xfrm_policy_bysel(int dir, struct xfrm_selector *sel,
 				      int delete)
@@ -396,6 +406,7 @@
 	}
 	return pol;
 }
+EXPORT_SYMBOL(xfrm_policy_bysel);
 
 struct xfrm_policy *xfrm_policy_byid(int dir, u32 id, int delete)
 {
@@ -418,6 +429,7 @@
 	}
 	return pol;
 }
+EXPORT_SYMBOL(xfrm_policy_byid);
 
 void xfrm_policy_flush(void)
 {
@@ -438,6 +450,7 @@
 	atomic_inc(&flow_cache_genid);
 	write_unlock_bh(&xfrm_policy_lock);
 }
+EXPORT_SYMBOL(xfrm_policy_flush);
 
 int xfrm_policy_walk(int (*func)(struct xfrm_policy *, int, int, void*),
 		     void *data)
@@ -470,7 +483,7 @@
 	read_unlock_bh(&xfrm_policy_lock);
 	return error;
 }
-
+EXPORT_SYMBOL(xfrm_policy_walk);
 
 /* Find policy to apply to this flow. */
 
@@ -845,6 +858,7 @@
 	*dst_p = NULL;
 	return err;
 }
+EXPORT_SYMBOL(xfrm_lookup);
 
 /* When skb is transformed back to its "native" form, we have to
  * check policy restrictions. At the moment we make this in maximally
@@ -981,6 +995,7 @@
 	xfrm_pol_put(pol);
 	return 0;
 }
+EXPORT_SYMBOL(__xfrm_policy_check);
 
 int __xfrm_route_forward(struct sk_buff *skb, unsigned short family)
 {
@@ -991,6 +1006,7 @@
 
 	return xfrm_lookup(&skb->dst, &fl, NULL, 0) == 0;
 }
+EXPORT_SYMBOL(__xfrm_route_forward);
 
 /* Optimize later using cookies and generation ids. */
 
@@ -1163,6 +1179,7 @@
 	write_unlock(&xfrm_policy_afinfo_lock);
 	return err;
 }
+EXPORT_SYMBOL(xfrm_policy_register_afinfo);
 
 int xfrm_policy_unregister_afinfo(struct xfrm_policy_afinfo *afinfo)
 {
@@ -1190,6 +1207,7 @@
 	write_unlock(&xfrm_policy_afinfo_lock);
 	return err;
 }
+EXPORT_SYMBOL(xfrm_policy_unregister_afinfo);
 
 static struct xfrm_policy_afinfo *xfrm_policy_get_afinfo(unsigned short family)
 {
--- linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_input.c.old	2005-01-19 09:53:59.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_input.c	2005-01-19 09:55:24.000000000 +0100
@@ -8,6 +8,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/module.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
 
@@ -20,6 +21,7 @@
 		xfrm_state_put(sp->x[i].xvec);
 	kmem_cache_free(secpath_cachep, sp);
 }
+EXPORT_SYMBOL(__secpath_destroy);
 
 struct sec_path *secpath_dup(struct sec_path *src)
 {
@@ -40,6 +42,7 @@
 	atomic_set(&sp->refcnt, 1);
 	return sp;
 }
+EXPORT_SYMBOL(secpath_dup);
 
 /* Fetch spi and seq from ipsec header */
 
@@ -73,6 +76,7 @@
 	*seq = *(u32*)(skb->h.raw + offset_seq);
 	return 0;
 }
+EXPORT_SYMBOL(xfrm_parse_spi);
 
 void __init xfrm_input_init(void)
 {
--- linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_algo.c.old	2005-01-19 10:00:47.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_algo.c	2005-01-19 10:03:51.000000000 +0100
@@ -315,6 +315,7 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(xfrm_aalg_get_byid);
 
 struct xfrm_algo_desc *xfrm_ealg_get_byid(int alg_id)
 {
@@ -330,6 +331,7 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(xfrm_ealg_get_byid);
 
 struct xfrm_algo_desc *xfrm_calg_get_byid(int alg_id)
 {
@@ -345,6 +347,7 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(xfrm_calg_get_byid);
 
 struct xfrm_algo_desc *xfrm_aalg_get_byname(char *name)
 {
@@ -363,6 +366,7 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(xfrm_aalg_get_byname);
 
 struct xfrm_algo_desc *xfrm_ealg_get_byname(char *name)
 {
@@ -381,6 +385,7 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(xfrm_ealg_get_byname);
 
 struct xfrm_algo_desc *xfrm_calg_get_byname(char *name)
 {
@@ -399,6 +404,7 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(xfrm_calg_get_byname);
 
 struct xfrm_algo_desc *xfrm_aalg_get_byidx(unsigned int idx)
 {
@@ -407,6 +413,7 @@
 
 	return &aalg_list[idx];
 }
+EXPORT_SYMBOL_GPL(xfrm_aalg_get_byidx);
 
 struct xfrm_algo_desc *xfrm_ealg_get_byidx(unsigned int idx)
 {
@@ -415,6 +422,7 @@
 
 	return &ealg_list[idx];
 }
+EXPORT_SYMBOL_GPL(xfrm_ealg_get_byidx);
 
 /*
  * Probe for the availability of crypto algorithms, and set the available
@@ -447,6 +455,7 @@
 	}
 #endif
 }
+EXPORT_SYMBOL_GPL(xfrm_probe_algs);
 
 int xfrm_count_auth_supported(void)
 {
@@ -457,6 +466,7 @@
 			n++;
 	return n;
 }
+EXPORT_SYMBOL_GPL(xfrm_count_auth_supported);
 
 int xfrm_count_enc_supported(void)
 {
@@ -467,6 +477,7 @@
 			n++;
 	return n;
 }
+EXPORT_SYMBOL_GPL(xfrm_count_enc_supported);
 
 /* Move to common area: it is shared with AH. */
 
@@ -541,6 +552,7 @@
 	if (len)
 		BUG();
 }
+EXPORT_SYMBOL_GPL(skb_icv_walk);
 
 #if defined(CONFIG_INET_ESP) || defined(CONFIG_INET_ESP_MODULE) || defined(CONFIG_INET6_ESP) || defined(CONFIG_INET6_ESP_MODULE)
 
--- linux-2.6.11-rc1-mm1-full/net/xfrm/xfrm_export.c	2005-01-14 12:58:51.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,62 +0,0 @@
-#include <linux/module.h>
-#include <net/xfrm.h>
-
-EXPORT_SYMBOL(xfrm_user_policy);
-EXPORT_SYMBOL(km_waitq);
-EXPORT_SYMBOL(km_new_mapping);
-EXPORT_SYMBOL(xfrm_cfg_sem);
-EXPORT_SYMBOL(xfrm_policy_alloc);
-EXPORT_SYMBOL(__xfrm_policy_destroy);
-EXPORT_SYMBOL(xfrm_lookup);
-EXPORT_SYMBOL(__xfrm_policy_check);
-EXPORT_SYMBOL(__xfrm_route_forward);
-EXPORT_SYMBOL(xfrm_state_alloc);
-EXPORT_SYMBOL(__xfrm_state_destroy);
-EXPORT_SYMBOL(xfrm_state_insert);
-EXPORT_SYMBOL(xfrm_state_add);
-EXPORT_SYMBOL(xfrm_state_update);
-EXPORT_SYMBOL(xfrm_state_check_expire);
-EXPORT_SYMBOL(xfrm_state_check);
-EXPORT_SYMBOL(xfrm_state_lookup);
-EXPORT_SYMBOL(xfrm_state_register_afinfo);
-EXPORT_SYMBOL(xfrm_state_unregister_afinfo);
-EXPORT_SYMBOL(xfrm_state_delete_tunnel);
-EXPORT_SYMBOL(xfrm_replay_check);
-EXPORT_SYMBOL(xfrm_replay_advance);
-EXPORT_SYMBOL(__secpath_destroy);
-EXPORT_SYMBOL(secpath_dup);
-EXPORT_SYMBOL(xfrm_get_acqseq);
-EXPORT_SYMBOL(xfrm_parse_spi);
-EXPORT_SYMBOL(xfrm_register_type);
-EXPORT_SYMBOL(xfrm_unregister_type);
-EXPORT_SYMBOL(xfrm_get_type);
-EXPORT_SYMBOL(xfrm_register_km);
-EXPORT_SYMBOL(xfrm_unregister_km);
-EXPORT_SYMBOL(xfrm_state_delete);
-EXPORT_SYMBOL(xfrm_state_walk);
-EXPORT_SYMBOL(xfrm_find_acq_byseq);
-EXPORT_SYMBOL(xfrm_find_acq);
-EXPORT_SYMBOL(xfrm_alloc_spi);
-EXPORT_SYMBOL(xfrm_state_flush);
-EXPORT_SYMBOL(xfrm_policy_bysel);
-EXPORT_SYMBOL(xfrm_policy_insert);
-EXPORT_SYMBOL(xfrm_policy_walk);
-EXPORT_SYMBOL(xfrm_policy_flush);
-EXPORT_SYMBOL(xfrm_policy_byid);
-EXPORT_SYMBOL(xfrm_policy_list);
-EXPORT_SYMBOL(xfrm_dst_lookup);
-EXPORT_SYMBOL(xfrm_policy_register_afinfo);
-EXPORT_SYMBOL(xfrm_policy_unregister_afinfo);
-
-EXPORT_SYMBOL_GPL(xfrm_probe_algs);
-EXPORT_SYMBOL_GPL(xfrm_count_auth_supported);
-EXPORT_SYMBOL_GPL(xfrm_count_enc_supported);
-EXPORT_SYMBOL_GPL(xfrm_aalg_get_byidx);
-EXPORT_SYMBOL_GPL(xfrm_ealg_get_byidx);
-EXPORT_SYMBOL_GPL(xfrm_aalg_get_byid);
-EXPORT_SYMBOL_GPL(xfrm_ealg_get_byid);
-EXPORT_SYMBOL_GPL(xfrm_calg_get_byid);
-EXPORT_SYMBOL_GPL(xfrm_aalg_get_byname);
-EXPORT_SYMBOL_GPL(xfrm_ealg_get_byname);
-EXPORT_SYMBOL_GPL(xfrm_calg_get_byname);
-EXPORT_SYMBOL_GPL(skb_icv_walk);

