Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWG3Jlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWG3Jlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWG3Jlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:41:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17926 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932162AbWG3Jlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:41:46 -0400
Date: Sun, 30 Jul 2006 11:41:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: coreteam@netfilter.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/*/nf_conntrack_*.c:possible cleanups
Message-ID: <20060730094146.GJ26963@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global functions static:
  - net/netfilter/nf_conntrack_core.c: nf_conntrack_register_cache()
  - net/netfilter/nf_conntrack_core.c: nf_conntrack_unregister_cache()
  - net/netfilter/nf_conntrack_core.c: __nf_conntrack_attach()
  - net/netfilter/nf_conntrack_core.c: set_hashsize()
  - net/netfilter/nf_conntrack_proto_sctp.c: nf_conntrack_proto_sctp_init()
  - net/netfilter/nf_conntrack_proto_sctp.c: nf_conntrack_proto_sctp_fini()
- make the following needlessly global variables/locks/structs static:
  - net/ipv6/netfilter/nf_conntrack_reasm.c: nf_ct_frag6_secret_interval
  - net/ipv6/netfilter/nf_conntrack_reasm.c: nf_ct_frag6_mem
  - net/netfilter/nf_conntrack_core.c: nf_ct_cache_lock
  - net/netfilter/nf_conntrack_proto_sctp.c: nf_conntrack_protocol_sctp4
  - net/netfilter/nf_conntrack_proto_sctp.c: nf_conntrack_protocol_sctp6
- #if 0 the following unused global functions:
  - net/ipv6/netfilter/nf_conntrack_reasm.c: nf_ct_frag6_kfree_frags()
  - net/netfilter/nf_conntrack_core.c: nf_conntrack_tuple_taken()
  - net/netfilter/nf_conntrack_core.c: nf_ct_helper_find_get()
  - net/netfilter/nf_conntrack_core.c: nf_ct_helper_put()
  - net/netfilter/nf_conntrack_core.c: nf_ct_invert_tuplepr()
- remove the following unused or write-only variables:
  - net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c: nat_module_is_loaded
  - net/ipv6/netfilter/nf_conntrack_reasm.c: nf_ct_frag6_nqueues
- remove the following unused hooks:
  - net/netfilter/nf_conntrack_core.c: nf_conntrack_destroyed()
  - net/netfilter/nf_conntrack_ftp.c: nf_nat_ftp_hook()
- remove the following unused EXPORT_SYMBOL's:
  - nf_ct_iterate_cleanup
  - nf_ct_protos
  - nf_ct_l3protos

Please review which of these changes make sense and which might conflict 
with pending patches.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 11 Jul 2006

 include/net/netfilter/nf_conntrack.h           |   21 -------------
 include/net/netfilter/nf_conntrack_core.h      |    2 -
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c |    4 --
 net/ipv6/netfilter/nf_conntrack_reasm.c        |    9 ++---
 net/netfilter/nf_conntrack_core.c              |   25 +++++++++-------
 net/netfilter/nf_conntrack_ftp.c               |   26 +++--------------
 net/netfilter/nf_conntrack_proto_sctp.c        |    8 ++---
 net/netfilter/nf_conntrack_standalone.c        |    9 -----
 8 files changed, 27 insertions(+), 77 deletions(-)

--- linux-2.6.18-rc1-mm1-full/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c.old	2006-07-09 19:20:35.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c	2006-07-09 19:20:46.000000000 +0200
@@ -113,12 +113,8 @@
 	return NF_ACCEPT;
 }
 
-int nat_module_is_loaded = 0;
 static u_int32_t ipv4_get_features(const struct nf_conntrack_tuple *tuple)
 {
-	if (nat_module_is_loaded)
-		return NF_CT_F_NAT;
-
 	return NF_CT_F_BASIC;
 }
 
--- linux-2.6.18-rc1-mm1-full/net/ipv6/netfilter/nf_conntrack_reasm.c.old	2006-07-09 19:21:08.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/net/ipv6/netfilter/nf_conntrack_reasm.c	2006-07-09 19:22:45.000000000 +0200
@@ -99,13 +99,11 @@
 static DEFINE_RWLOCK(nf_ct_frag6_lock);
 static u32 nf_ct_frag6_hash_rnd;
 static LIST_HEAD(nf_ct_frag6_lru_list);
-int nf_ct_frag6_nqueues = 0;
 
 static __inline__ void __fq_unlink(struct nf_ct_frag6_queue *fq)
 {
 	hlist_del(&fq->list);
 	list_del(&fq->lru_list);
-	nf_ct_frag6_nqueues--;
 }
 
 static __inline__ void fq_unlink(struct nf_ct_frag6_queue *fq)
@@ -143,7 +141,7 @@
 }
 
 static struct timer_list nf_ct_frag6_secret_timer;
-int nf_ct_frag6_secret_interval = 10 * 60 * HZ;
+static int nf_ct_frag6_secret_interval = 10 * 60 * HZ;
 
 static void nf_ct_frag6_secret_rebuild(unsigned long dummy)
 {
@@ -173,7 +171,7 @@
 	mod_timer(&nf_ct_frag6_secret_timer, now + nf_ct_frag6_secret_interval);
 }
 
-atomic_t nf_ct_frag6_mem = ATOMIC_INIT(0);
+static atomic_t nf_ct_frag6_mem = ATOMIC_INIT(0);
 
 /* Memory Tracking Functions. */
 static inline void frag_kfree_skb(struct sk_buff *skb, unsigned int *work)
@@ -331,7 +329,6 @@
 	hlist_add_head(&fq->list, &nf_ct_frag6_hash[hash]);
 	INIT_LIST_HEAD(&fq->lru_list);
 	list_add_tail(&fq->lru_list, &nf_ct_frag6_lru_list);
-	nf_ct_frag6_nqueues++;
 	write_unlock(&nf_ct_frag6_lock);
 	return fq;
 }
@@ -842,6 +839,7 @@
 	nf_conntrack_put_reasm(skb);
 }
 
+#if 0
 int nf_ct_frag6_kfree_frags(struct sk_buff *skb)
 {
 	struct sk_buff *s, *s2;
@@ -856,6 +854,7 @@
 
 	return 0;
 }
+#endif  /*  0  */
 
 int nf_ct_frag6_init(void)
 {
--- linux-2.6.18-rc1-mm1-full/include/net/netfilter/nf_conntrack_core.h.old	2006-07-09 19:23:09.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/include/net/netfilter/nf_conntrack_core.h	2006-07-09 19:23:16.000000000 +0200
@@ -68,8 +68,6 @@
 	return ret;
 }
 
-extern void __nf_conntrack_attach(struct sk_buff *nskb, struct sk_buff *skb);
-
 extern struct list_head *nf_conntrack_hash;
 extern struct list_head nf_conntrack_expect_list;
 extern rwlock_t nf_conntrack_lock ;
--- linux-2.6.18-rc1-mm1-full/include/net/netfilter/nf_conntrack.h.old	2006-07-09 19:24:29.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/include/net/netfilter/nf_conntrack.h	2006-07-09 19:28:48.000000000 +0200
@@ -177,12 +177,6 @@
 nf_conntrack_alter_reply(struct nf_conn *conntrack,
 			 const struct nf_conntrack_tuple *newreply);
 
-/* Is this tuple taken? (ignoring any belonging to the given
-   conntrack). */
-extern int
-nf_conntrack_tuple_taken(const struct nf_conntrack_tuple *tuple,
-			 const struct nf_conn *ignored_conntrack);
-
 /* Return conntrack_info and tuple hash for given skb. */
 static inline struct nf_conn *
 nf_ct_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
@@ -221,15 +215,8 @@
 extern void nf_conntrack_flush(void);
 
 extern struct nf_conntrack_helper *
-nf_ct_helper_find_get( const struct nf_conntrack_tuple *tuple);
-extern void nf_ct_helper_put(struct nf_conntrack_helper *helper);
-
-extern struct nf_conntrack_helper *
 __nf_conntrack_helper_find_byname(const char *name);
 
-extern int nf_ct_invert_tuplepr(struct nf_conntrack_tuple *inverse,
-				const struct nf_conntrack_tuple *orig);
-
 extern void __nf_ct_refresh_acct(struct nf_conn *ct,
 				 enum ip_conntrack_info ctinfo,
 				 const struct sk_buff *skb,
@@ -260,9 +247,6 @@
 				    struct nf_conn *conntrack,
 				    int dir);
 
-/* Call me when a conntrack is destroyed. */
-extern void (*nf_conntrack_destroyed)(struct nf_conn *conntrack);
-
 /* Fake conntrack entry for untracked connections */
 extern struct nf_conn nf_conntrack_untracked;
 
@@ -380,11 +364,6 @@
 #define	NF_CT_F_NAT	2
 #define NF_CT_F_NUM	4
 
-extern int
-nf_conntrack_register_cache(u_int32_t features, const char *name, size_t size);
-extern void
-nf_conntrack_unregister_cache(u_int32_t features);
-
 /* valid combinations:
  * basic: nf_conn, nf_conn .. nf_conn_help
  * nat: nf_conn .. nf_conn_nat, nf_conn .. nf_conn_nat, nf_conn help
--- linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_core.c.old	2006-07-09 19:23:24.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_core.c	2006-07-09 19:30:55.000000000 +0200
@@ -72,7 +72,6 @@
 /* nf_conntrack_standalone needs this */
 atomic_t nf_conntrack_count = ATOMIC_INIT(0);
 
-void (*nf_conntrack_destroyed)(struct nf_conn *conntrack) = NULL;
 LIST_HEAD(nf_conntrack_expect_list);
 struct nf_conntrack_protocol **nf_ct_protos[PF_MAX];
 struct nf_conntrack_l3proto *nf_ct_l3protos[PF_MAX];
@@ -180,7 +179,7 @@
 } nf_ct_cache[NF_CT_F_NUM];
 
 /* protect members of nf_ct_cache except of "use" */
-DEFINE_RWLOCK(nf_ct_cache_lock);
+static DEFINE_RWLOCK(nf_ct_cache_lock);
 
 /* This avoids calling kmem_cache_create() with same name simultaneously */
 static DEFINE_MUTEX(nf_ct_cache_mutex);
@@ -285,8 +284,8 @@
 				nf_conntrack_hash_rnd);
 }
 
-int nf_conntrack_register_cache(u_int32_t features, const char *name,
-				size_t size)
+static int nf_conntrack_register_cache(u_int32_t features, const char *name,
+				       size_t size)
 {
 	int ret = 0;
 	char *cache_name;
@@ -366,7 +365,7 @@
 }
 
 /* FIXME: In the current, only nf_conntrack_cleanup() can call this function. */
-void nf_conntrack_unregister_cache(u_int32_t features)
+static void nf_conntrack_unregister_cache(u_int32_t features)
 {
 	kmem_cache_t *cachep;
 	char *name;
@@ -578,9 +577,6 @@
 	if (proto && proto->destroy)
 		proto->destroy(ct);
 
-	if (nf_conntrack_destroyed)
-		nf_conntrack_destroyed(ct);
-
 	write_lock_bh(&nf_conntrack_lock);
 	/* Expectations will have been removed in clean_from_lists,
 	 * except TFTP can create an expectation on the first packet,
@@ -762,6 +758,7 @@
 
 /* Returns true if a connection correspondings to the tuple (required
    for NAT). */
+#if 0
 int
 nf_conntrack_tuple_taken(const struct nf_conntrack_tuple *tuple,
 			 const struct nf_conn *ignored_conntrack)
@@ -774,6 +771,7 @@
 
 	return h != NULL;
 }
+#endif  /*  0  */
 
 /* There's a small race here where we may free a just-assured
    connection.  Too bad: we're in trouble anyway. */
@@ -824,6 +822,8 @@
 			 tuple);
 }
 
+#if 0
+
 struct nf_conntrack_helper *
 nf_ct_helper_find_get( const struct nf_conntrack_tuple *tuple)
 {
@@ -852,6 +852,8 @@
 	module_put(helper->me);
 }
 
+#endif  /*  0  */
+
 static struct nf_conn *
 __nf_conntrack_alloc(const struct nf_conntrack_tuple *orig,
 		     const struct nf_conntrack_tuple *repl,
@@ -1137,6 +1139,7 @@
 	return ret;
 }
 
+#if 0
 int nf_ct_invert_tuplepr(struct nf_conntrack_tuple *inverse,
 			 const struct nf_conntrack_tuple *orig)
 {
@@ -1145,6 +1148,7 @@
 				  __nf_ct_proto_find(orig->src.l3num,
 						     orig->dst.protonum));
 }
+#endif  /*  0  */
 
 /* Would two expected things clash? */
 static inline int expect_clash(const struct nf_conntrack_expect *a,
@@ -1482,8 +1486,7 @@
 }
 #endif
 
-/* Used by ipt_REJECT and ip6t_REJECT. */
-void __nf_conntrack_attach(struct sk_buff *nskb, struct sk_buff *skb)
+static void __nf_conntrack_attach(struct sk_buff *nskb, struct sk_buff *skb)
 {
 	struct nf_conn *ct;
 	enum ip_conntrack_info ctinfo;
@@ -1635,7 +1638,7 @@
 	return hash;
 }
 
-int set_hashsize(const char *val, struct kernel_param *kp)
+static int set_hashsize(const char *val, struct kernel_param *kp)
 {
 	int i, bucket, hashsize, vmalloced;
 	int old_vmalloced, old_size;
--- linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_standalone.c.old	2006-07-09 19:23:54.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_standalone.c	2006-07-09 19:30:34.000000000 +0200
@@ -851,26 +851,20 @@
 EXPORT_SYMBOL(nf_conntrack_l3proto_unregister);
 EXPORT_SYMBOL(nf_conntrack_protocol_register);
 EXPORT_SYMBOL(nf_conntrack_protocol_unregister);
-EXPORT_SYMBOL(nf_ct_invert_tuplepr);
-EXPORT_SYMBOL(nf_conntrack_destroyed);
 EXPORT_SYMBOL(need_conntrack);
 EXPORT_SYMBOL(nf_conntrack_helper_register);
 EXPORT_SYMBOL(nf_conntrack_helper_unregister);
-EXPORT_SYMBOL(nf_ct_iterate_cleanup);
 EXPORT_SYMBOL(__nf_ct_refresh_acct);
-EXPORT_SYMBOL(nf_ct_protos);
 EXPORT_SYMBOL(__nf_ct_proto_find);
 EXPORT_SYMBOL(nf_ct_proto_find_get);
 EXPORT_SYMBOL(nf_ct_proto_put);
 EXPORT_SYMBOL(nf_ct_l3proto_find_get);
 EXPORT_SYMBOL(nf_ct_l3proto_put);
-EXPORT_SYMBOL(nf_ct_l3protos);
 EXPORT_SYMBOL_GPL(nf_conntrack_checksum);
 EXPORT_SYMBOL(nf_conntrack_expect_alloc);
 EXPORT_SYMBOL(nf_conntrack_expect_put);
 EXPORT_SYMBOL(nf_conntrack_expect_related);
 EXPORT_SYMBOL(nf_conntrack_unexpect_related);
-EXPORT_SYMBOL(nf_conntrack_tuple_taken);
 EXPORT_SYMBOL(nf_conntrack_htable_size);
 EXPORT_SYMBOL(nf_conntrack_lock);
 EXPORT_SYMBOL(nf_conntrack_hash);
@@ -883,13 +877,10 @@
 EXPORT_SYMBOL(nf_ct_get_tuple);
 EXPORT_SYMBOL(nf_ct_invert_tuple);
 EXPORT_SYMBOL(nf_conntrack_in);
-EXPORT_SYMBOL(__nf_conntrack_attach);
 EXPORT_SYMBOL(nf_conntrack_alloc);
 EXPORT_SYMBOL(nf_conntrack_free);
 EXPORT_SYMBOL(nf_conntrack_flush);
 EXPORT_SYMBOL(nf_ct_remove_expectations);
-EXPORT_SYMBOL(nf_ct_helper_find_get);
-EXPORT_SYMBOL(nf_ct_helper_put);
 EXPORT_SYMBOL(__nf_conntrack_helper_find_byname);
 EXPORT_SYMBOL(__nf_conntrack_find);
 EXPORT_SYMBOL(nf_ct_unlink_expect);
--- linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_ftp.c.old	2006-07-09 19:31:09.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_ftp.c	2006-07-09 19:39:01.000000000 +0200
@@ -45,15 +45,6 @@
 static int loose;
 module_param(loose, bool, 0600);
 
-unsigned int (*nf_nat_ftp_hook)(struct sk_buff **pskb,
-				enum ip_conntrack_info ctinfo,
-				enum ip_ct_ftp_type type,
-				unsigned int matchoff,
-				unsigned int matchlen,
-				struct nf_conntrack_expect *exp,
-				u32 *seq);
-EXPORT_SYMBOL_GPL(nf_nat_ftp_hook);
-
 #if 0
 #define DEBUGP printk
 #else
@@ -602,18 +593,11 @@
 	exp->expectfn = NULL;
 	exp->flags = 0;
 
-	/* Now, NAT might want to mangle the packet, and register the
-	 * (possibly changed) expectation itself. */
-	if (nf_nat_ftp_hook)
-		ret = nf_nat_ftp_hook(pskb, ctinfo, search[dir][i].ftptype,
-				      matchoff, matchlen, exp, &seq);
-	else {
-		/* Can't expect this?  Best to drop packet now. */
-		if (nf_conntrack_expect_related(exp) != 0)
-			ret = NF_DROP;
-		else
-			ret = NF_ACCEPT;
-	}
+	/* Can't expect this?  Best to drop packet now. */
+	if (nf_conntrack_expect_related(exp) != 0)
+		ret = NF_DROP;
+	else
+		ret = NF_ACCEPT;
 
 out_put_expect:
 	nf_conntrack_expect_put(exp);
--- linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_proto_sctp.c.old	2006-07-09 19:32:45.000000000 +0200
+++ linux-2.6.18-rc1-mm1-full/net/netfilter/nf_conntrack_proto_sctp.c	2006-07-09 19:33:27.000000000 +0200
@@ -508,7 +508,7 @@
 	return 1;
 }
 
-struct nf_conntrack_protocol nf_conntrack_protocol_sctp4 = { 
+static struct nf_conntrack_protocol nf_conntrack_protocol_sctp4 = { 
 	.l3proto	 = PF_INET,
 	.proto 		 = IPPROTO_SCTP, 
 	.name 		 = "sctp",
@@ -522,7 +522,7 @@
 	.me 		 = THIS_MODULE 
 };
 
-struct nf_conntrack_protocol nf_conntrack_protocol_sctp6 = { 
+static struct nf_conntrack_protocol nf_conntrack_protocol_sctp6 = { 
 	.l3proto	 = PF_INET6,
 	.proto 		 = IPPROTO_SCTP, 
 	.name 		 = "sctp",
@@ -620,7 +620,7 @@
 static struct ctl_table_header *nf_ct_sysctl_header;
 #endif
 
-int __init nf_conntrack_proto_sctp_init(void)
+static int __init nf_conntrack_proto_sctp_init(void)
 {
 	int ret;
 
@@ -657,7 +657,7 @@
 	return ret;
 }
 
-void __exit nf_conntrack_proto_sctp_fini(void)
+static void __exit nf_conntrack_proto_sctp_fini(void)
 {
 	nf_conntrack_protocol_unregister(&nf_conntrack_protocol_sctp6);
 	nf_conntrack_protocol_unregister(&nf_conntrack_protocol_sctp4);

