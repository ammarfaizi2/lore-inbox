Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268499AbTBWP0m>; Sun, 23 Feb 2003 10:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268502AbTBWP0l>; Sun, 23 Feb 2003 10:26:41 -0500
Received: from usen-43x235x12x234.ap-USEN.usen.ad.jp ([43.235.12.234]:56979
	"EHLO miyazawa.org") by vger.kernel.org with ESMTP
	id <S268499AbTBWPZL>; Sun, 23 Feb 2003 10:25:11 -0500
Date: Mon, 24 Feb 2003 00:35:40 +0900
From: Kazunori Miyazawa <kazunori@miyazawa.org>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi-core@linux-ipv6.org
Subject: Re: [PATCH] IPv6 IPSEC support
Message-Id: <20030224003540.53e4cda5.kazunori@miyazawa.org>
In-Reply-To: <20030222.031326.103246837.davem@redhat.com>
References: <20030222202623.38d41d8a.kazunori@miyazawa.org>
	<20030222.031326.103246837.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 22 Feb 2003 03:13:26 -0800 (PST)
"David S. Miller" <davem@redhat.com> wrote:

>    From: Kazunori Miyazawa <kazunori@miyazawa.org>
>    Date: Sat, 22 Feb 2003 20:26:23 +0900
> 
>    I also moved the functions for ah, and esp.
> 
> I don't think this is so good idea...
>    
>    As a result of moving IPv6 IPsec functions to net/ipv4, it currently prevents to
>    make IPv6 as a module.
>    
> This is one of the reasons why ah/esp ipv6 should stay under ipv6.
> 
> Nothing in xfrm routines really need to reference ipv6 module
> functions, please eliminate this dependency.  Breaking ipv6 as module
> is ok for temporary development, but eventually it must be solved.

I just moved ipv6 ah/esp functions to under net/ipv6.

Thank you,

--Kazunori Miyazawa (Yokogawa Electric Corporation)

diff -ruN -x CVS linux-2.5.62+cs1.1002/include/linux/ipv6.h linux25/include/linux/ipv6.h
--- linux-2.5.62+cs1.1002/include/linux/ipv6.h	2003-02-23 17:56:54.000000000 +0900
+++ linux25/include/linux/ipv6.h	2003-02-23 13:24:59.000000000 +0900
@@ -74,6 +74,21 @@
 #define rt0_type		rt_hdr.type;
 };
 
+struct ipv6_auth_hdr {
+	__u8  nexthdr;
+	__u8  hdrlen;           /* This one is measured in 32 bit units! */
+	__u16 reserved;
+	__u32 spi;
+	__u32 seq_no;           /* Sequence number */
+	__u8  auth_data[4];     /* Length variable but >=4. Mind the 64 bit alignment! */
+};
+
+struct ipv6_esp_hdr {
+	__u32 spi;
+	__u32 seq_no;           /* Sequence number */
+	__u8  enc_data[8];      /* Length variable but >=8. Mind the 64 bit alignment! */
+};
+
 /*
  *	IPv6 fixed header
  *
diff -ruN -x CVS linux-2.5.62+cs1.1002/include/net/dst.h linux25/include/net/dst.h
--- linux-2.5.62+cs1.1002/include/net/dst.h	2003-02-23 17:56:43.000000000 +0900
+++ linux25/include/net/dst.h	2003-02-23 13:24:59.000000000 +0900
@@ -248,6 +248,9 @@
 extern int xfrm_lookup(struct dst_entry **dst_p, struct flowi *fl,
 		       struct sock *sk, int flags);
 extern void xfrm_init(void);
+extern int xfrm6_lookup(struct dst_entry **dst_p, struct flowi *fl,
+		       struct sock *sk, int flags);
+extern void xfrm6_init(void);
 
 #endif
 
diff -ruN -x CVS linux-2.5.62+cs1.1002/include/net/ip6_route.h linux25/include/net/ip6_route.h
--- linux-2.5.62+cs1.1002/include/net/ip6_route.h	2003-02-23 17:56:43.000000000 +0900
+++ linux25/include/net/ip6_route.h	2003-02-23 13:24:59.000000000 +0900
@@ -55,6 +55,8 @@
 					    struct in6_addr *saddr,
 					    int oif, int flags);
 
+extern struct rt6_info		*ndisc_get_dummy_rt(void);
+
 /*
  *	support functions for ND
  *
diff -ruN -x CVS linux-2.5.62+cs1.1002/include/net/xfrm.h linux25/include/net/xfrm.h
--- linux-2.5.62+cs1.1002/include/net/xfrm.h	2003-02-23 17:56:44.000000000 +0900
+++ linux25/include/net/xfrm.h	2003-02-23 19:57:44.000000000 +0900
@@ -12,6 +12,7 @@
 
 #include <net/dst.h>
 #include <net/route.h>
+#include <net/ip6_fib.h>
 
 #define XFRM_ALIGN8(len)	(((len) + 7) & ~7)
 
@@ -282,6 +283,7 @@
 		struct xfrm_dst		*next;
 		struct dst_entry	dst;
 		struct rtable		rt;
+		struct rt6_info		rt6;
 	} u;
 };
 
@@ -308,26 +310,42 @@
 	if (sp && atomic_dec_and_test(&sp->refcnt))
 		__secpath_destroy(sp);
 }
-
-extern int __xfrm_policy_check(struct sock *, int dir, struct sk_buff *skb);
+extern int __xfrm_policy_check(struct sock *, int dir, struct sk_buff *skb, unsigned short family);
 
 static inline int xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
 {
 	if (sk && sk->policy[XFRM_POLICY_IN])
-		return __xfrm_policy_check(sk, dir, skb);
+		return __xfrm_policy_check(sk, dir, skb, AF_INET);
+		
+	return	!xfrm_policy_list[dir] ||
+		(skb->dst->flags & DST_NOPOLICY) ||
+		__xfrm_policy_check(sk, dir, skb, AF_INET);
+}
+
+static inline int xfrm6_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
+{
+	if (sk && sk->policy[XFRM_POLICY_IN])
+		return __xfrm_policy_check(sk, dir, skb, AF_INET6);
 		
 	return	!xfrm_policy_list[dir] ||
 		(skb->dst->flags & DST_NOPOLICY) ||
-		__xfrm_policy_check(sk, dir, skb);
+		__xfrm_policy_check(sk, dir, skb, AF_INET6);
 }
 
-extern int __xfrm_route_forward(struct sk_buff *skb);
+extern int __xfrm_route_forward(struct sk_buff *skb, unsigned short family);
 
 static inline int xfrm_route_forward(struct sk_buff *skb)
 {
 	return	!xfrm_policy_list[XFRM_POLICY_OUT] ||
 		(skb->dst->flags & DST_NOXFRM) ||
-		__xfrm_route_forward(skb);
+		__xfrm_route_forward(skb, AF_INET);
+}
+
+static inline int xfrm6_route_forward(struct sk_buff *skb)
+{
+	return	!xfrm_policy_list[XFRM_POLICY_OUT] ||
+		(skb->dst->flags & DST_NOXFRM) ||
+		__xfrm_route_forward(skb, AF_INET6);
 }
 
 extern int __xfrm_sk_clone_policy(struct sock *sk);
@@ -382,10 +400,14 @@
 extern struct xfrm_state *xfrm_state_alloc(void);
 extern struct xfrm_state *xfrm_state_find(u32 daddr, u32 saddr, struct flowi *fl, struct xfrm_tmpl *tmpl,
 					  struct xfrm_policy *pol, int *err);
+extern struct xfrm_state *xfrm6_state_find(struct in6_addr *daddr, struct in6_addr *saddr,
+					  struct flowi *fl, struct xfrm_tmpl *tmpl,
+					  struct xfrm_policy *pol, int *err);
 extern int xfrm_state_check_expire(struct xfrm_state *x);
 extern void xfrm_state_insert(struct xfrm_state *x);
 extern int xfrm_state_check_space(struct xfrm_state *x, struct sk_buff *skb);
 extern struct xfrm_state *xfrm_state_lookup(u32 daddr, u32 spi, u8 proto);
+extern struct xfrm_state *xfrm6_state_lookup(struct in6_addr *daddr, u32 spi, u8 proto);
 extern struct xfrm_state *xfrm_find_acq_byseq(u32 seq);
 extern void xfrm_state_delete(struct xfrm_state *x);
 extern void xfrm_state_flush(u8 proto);
@@ -393,22 +415,27 @@
 extern void xfrm_replay_advance(struct xfrm_state *x, u32 seq);
 extern int xfrm_check_selectors(struct xfrm_state **x, int n, struct flowi *fl);
 extern int xfrm4_rcv(struct sk_buff *skb);
+extern int xfrm6_rcv(struct sk_buff *skb);
+extern int xfrm6_clear_mutable_options(struct sk_buff *skb, u16 *nh_offset, int dir);
 extern int xfrm_user_policy(struct sock *sk, int optname, u8 *optval, int optlen);
 
 struct xfrm_policy *xfrm_policy_alloc(int gfp);
 extern int xfrm_policy_walk(int (*func)(struct xfrm_policy *, int, int, void*), void *);
-struct xfrm_policy *xfrm_policy_lookup(int dir, struct flowi *fl);
+struct xfrm_policy *xfrm_policy_lookup(int dir, struct flowi *fl, unsigned short family);
 int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl);
 struct xfrm_policy *xfrm_policy_delete(int dir, struct xfrm_selector *sel);
 struct xfrm_policy *xfrm_policy_byid(int dir, u32 id, int delete);
 void xfrm_policy_flush(void);
 void xfrm_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi);
 struct xfrm_state * xfrm_find_acq(u8 mode, u16 reqid, u8 proto, u32 daddr, u32 saddr, int create);
+struct xfrm_state * xfrm6_find_acq(u8 mode, u16 reqid, u8 proto, struct in6_addr *daddr,
+				   struct in6_addr *saddr, int create);
 extern void xfrm_policy_flush(void);
 extern void xfrm_policy_kill(struct xfrm_policy *);
 extern int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 extern struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir, struct flowi *fl);
 extern int xfrm_flush_bundles(struct xfrm_state *x);
+extern int xfrm6_flush_bundles(struct xfrm_state *x);
 
 extern wait_queue_head_t km_waitq;
 extern void km_warn_expired(struct xfrm_state *x);
@@ -425,15 +452,41 @@
 extern struct xfrm_algo_desc *xfrm_aalg_get_byname(char *name);
 extern struct xfrm_algo_desc *xfrm_ealg_get_byname(char *name);
 
+static __inline__ int addr_match(void *token1, void *token2, int prefixlen)
+{
+	__u32 *a1 = token1;
+	__u32 *a2 = token2;
+	int pdw;
+	int pbi;
+
+	pdw = prefixlen >> 5;	  /* num of whole __u32 in prefix */
+	pbi = prefixlen &  0x1f;  /* num of bits in incomplete u32 in prefix */
+
+	if (pdw)
+		if (memcmp(a1, a2, pdw << 2))
+			return 0;
+
+	if (pbi) {
+		__u32 mask;
+
+		mask = htonl((0xffffffff) << (32 - pbi));
+
+		if ((a1[pdw] ^ a2[pdw]) & mask)
+			return 0;
+	}
+
+	return 1;
+}
+
 static inline int
 xfrm6_selector_match(struct xfrm_selector *sel, struct flowi *fl)
 {
-      return  !memcmp(fl->fl6_dst, sel->daddr.a6, sizeof(struct in6_addr)) &&
-              !((fl->uli_u.ports.dport^sel->dport)&sel->dport_mask) &&
-              !((fl->uli_u.ports.sport^sel->sport)&sel->sport_mask) &&
-              (fl->proto == sel->proto || !sel->proto) &&
-              (fl->oif == sel->ifindex || !sel->ifindex) &&
-              !memcmp(fl->fl6_src, sel->saddr.a6, sizeof(struct in6_addr));
+	return  addr_match(fl->fl6_dst, &sel->daddr, sel->prefixlen_d) &&
+		addr_match(fl->fl6_src, &sel->saddr, sel->prefixlen_s) &&
+		!((fl->uli_u.ports.dport^sel->dport)&sel->dport_mask) &&
+		!((fl->uli_u.ports.sport^sel->sport)&sel->sport_mask) &&
+		(fl->proto == sel->proto || !sel->proto) &&
+		(fl->oif == sel->ifindex || !sel->ifindex);
 }
 
 extern int xfrm6_register_type(struct xfrm_type *type);
@@ -444,4 +497,83 @@
 struct xfrm_state * xfrm6_find_acq(u8 mode, u16 reqid, u8 proto, struct in6_addr *daddr, struct in6_addr *saddr, int create);
 void xfrm6_alloc_spi(struct xfrm_state *x, u32 minspi, u32 maxspi);
 
+struct ah_data
+{
+	u8			*key;
+	int			key_len;
+	u8			*work_icv;
+	int			icv_full_len;
+	int			icv_trunc_len;
+
+	void			(*icv)(struct ah_data*,
+	                               struct sk_buff *skb, u8 *icv);
+
+	struct crypto_tfm	*tfm;
+};
+
+struct esp_data
+{
+	/* Confidentiality */
+	struct {
+		u8			*key;		/* Key */
+		int			key_len;	/* Key length */
+		u8			*ivec;		/* ivec buffer */
+		/* ivlen is offset from enc_data, where encrypted data start.
+		 * It is logically different of crypto_tfm_alg_ivsize(tfm).
+		 * We assume that it is either zero (no ivec), or
+		 * >= crypto_tfm_alg_ivsize(tfm). */
+		int			ivlen;
+		int			padlen;		/* 0..255 */
+		struct crypto_tfm	*tfm;		/* crypto handle */
+	} conf;
+
+	/* Integrity. It is active when icv_full_len != 0 */
+	struct {
+		u8			*key;		/* Key */
+		int			key_len;	/* Length of the key */
+		u8			*work_icv;
+		int			icv_full_len;
+		int			icv_trunc_len;
+		void			(*icv)(struct esp_data*,
+		                               struct sk_buff *skb,
+		                               int offset, int len, u8 *icv);
+		struct crypto_tfm	*tfm;
+	} auth;
+};
+
+typedef void (icv_update_fn_t)(struct crypto_tfm *, struct scatterlist *, unsigned int);
+void skb_ah_walk(const struct sk_buff *skb,
+                        struct crypto_tfm *tfm, icv_update_fn_t icv_update);
+void skb_icv_walk(const struct sk_buff *skb, struct crypto_tfm *tfm,
+			int offset, int len, icv_update_fn_t icv_update);
+int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len);
+int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer);
+void *pskb_put(struct sk_buff *skb, struct sk_buff *tail, int len);
+
+static inline void
+ah_hmac_digest(struct ah_data *ahp, struct sk_buff *skb, u8 *auth_data)
+{
+	struct crypto_tfm *tfm = ahp->tfm;
+
+	memset(auth_data, 0, ahp->icv_trunc_len);
+	crypto_hmac_init(tfm, ahp->key, &ahp->key_len);
+	skb_ah_walk(skb, tfm, crypto_hmac_update);
+	crypto_hmac_final(tfm, ahp->key, &ahp->key_len, ahp->work_icv);
+	memcpy(auth_data, ahp->work_icv, ahp->icv_trunc_len);
+}
+
+static inline void
+esp_hmac_digest(struct esp_data *esp, struct sk_buff *skb, int offset,
+                int len, u8 *auth_data)
+{
+	struct crypto_tfm *tfm = esp->auth.tfm;
+	char *icv = esp->auth.work_icv;
+
+	memset(auth_data, 0, esp->auth.icv_trunc_len);
+	crypto_hmac_init(tfm, esp->auth.key, &esp->auth.key_len);
+	skb_icv_walk(skb, tfm, offset, len, crypto_hmac_update);
+	crypto_hmac_final(tfm, esp->auth.key, &esp->auth.key_len, icv);
+	memcpy(auth_data, icv, esp->auth.icv_trunc_len);
+}
+
 #endif	/* _NET_XFRM_H */
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv4/ah.c linux25/net/ipv4/ah.c
--- linux-2.5.62+cs1.1002/net/ipv4/ah.c	2003-02-23 17:53:46.000000000 +0900
+++ linux25/net/ipv4/ah.c	2003-02-23 18:17:13.000000000 +0900
@@ -1,3 +1,11 @@
+/* Changes
+ *
+ *	Mitsuru KANDA @USAGI       : IPv6 Support 
+ * 	Kazunori MIYAZAWA @USAGI   :
+ * 	Kunihiro Ishiguro          :
+ * 	
+ */
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <net/ip.h>
@@ -7,25 +15,10 @@
 #include <net/icmp.h>
 #include <asm/scatterlist.h>
 
-#define AH_HLEN_NOICV	12
-
-typedef void (icv_update_fn_t)(struct crypto_tfm *,
-                               struct scatterlist *, unsigned int);
-
-struct ah_data
-{
-	u8			*key;
-	int			key_len;
-	u8			*work_icv;
-	int			icv_full_len;
-	int			icv_trunc_len;
-
-	void			(*icv)(struct ah_data*,
-	                               struct sk_buff *skb, u8 *icv);
-
-	struct crypto_tfm	*tfm;
-};
+#include <net/xfrm.h>
+#include <asm/scatterlist.h>
 
+#define AH_HLEN_NOICV	12
 
 /* Clear mutable options and find final destination to substitute
  * into IP header for icv calculation. Options are already checked
@@ -71,7 +64,7 @@
 	return 0;
 }
 
-static void skb_ah_walk(const struct sk_buff *skb,
+void skb_ah_walk(const struct sk_buff *skb,
                         struct crypto_tfm *tfm, icv_update_fn_t icv_update)
 {
 	int offset = 0;
@@ -145,18 +138,6 @@
 		BUG();
 }
 
-static void
-ah_hmac_digest(struct ah_data *ahp, struct sk_buff *skb, u8 *auth_data)
-{
-	struct crypto_tfm *tfm = ahp->tfm;
-
-	memset(auth_data, 0, ahp->icv_trunc_len);
- 	crypto_hmac_init(tfm, ahp->key, &ahp->key_len);
-  	skb_ah_walk(skb, tfm, crypto_hmac_update);
-	crypto_hmac_final(tfm, ahp->key, &ahp->key_len, ahp->work_icv);
-	memcpy(auth_data, ahp->work_icv, ahp->icv_trunc_len);
-}
-
 static int ah_output(struct sk_buff *skb)
 {
 	int err;
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv4/esp.c linux25/net/ipv4/esp.c
--- linux-2.5.62+cs1.1002/net/ipv4/esp.c	2003-02-23 17:53:46.000000000 +0900
+++ linux25/net/ipv4/esp.c	2003-02-23 18:17:39.000000000 +0900
@@ -1,3 +1,11 @@
+/* Changes
+ *
+ *	Mitsuru KANDA @USAGI       : IPv6 Support 
+ * 	Kazunori MIYAZAWA @USAGI   :
+ * 	Kunihiro Ishiguro          :
+ * 	
+ */
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <net/ip.h>
@@ -8,45 +16,13 @@
 #include <linux/random.h>
 #include <net/icmp.h>
 
-#define MAX_SG_ONSTACK 4
 
-typedef void (icv_update_fn_t)(struct crypto_tfm *,
-                               struct scatterlist *, unsigned int);
+#define MAX_SG_ONSTACK 4
 
 /* BUGS:
  * - we assume replay seqno is always present.
  */
 
-struct esp_data
-{
-	/* Confidentiality */
-	struct {
-		u8			*key;		/* Key */
-		int			key_len;	/* Key length */
-		u8			*ivec;		/* ivec buffer */
-		/* ivlen is offset from enc_data, where encrypted data start.
-		 * It is logically different of crypto_tfm_alg_ivsize(tfm).
-		 * We assume that it is either zero (no ivec), or
-		 * >= crypto_tfm_alg_ivsize(tfm). */
-		int			ivlen;
-		int			padlen;		/* 0..255 */
-		struct crypto_tfm	*tfm;		/* crypto handle */
-	} conf;
-
-	/* Integrity. It is active when icv_full_len != 0 */
-	struct {
-		u8			*key;		/* Key */
-		int			key_len;	/* Length of the key */
-		u8			*work_icv;
-		int			icv_full_len;
-		int			icv_trunc_len;
-		void			(*icv)(struct esp_data*,
-		                               struct sk_buff *skb,
-		                               int offset, int len, u8 *icv);
-		struct crypto_tfm	*tfm;
-	} auth;
-};
-
 /* Move to common area: it is shared with AH. */
 
 void skb_icv_walk(const struct sk_buff *skb, struct crypto_tfm *tfm,
@@ -190,22 +166,6 @@
 	return elt;
 }
 
-/* Common with AH after some work on arguments. */
-
-static void
-esp_hmac_digest(struct esp_data *esp, struct sk_buff *skb, int offset,
-		int len, u8 *auth_data)
-{
-	struct crypto_tfm *tfm = esp->auth.tfm;
-	char *icv = esp->auth.work_icv;
-
-	memset(auth_data, 0, esp->auth.icv_trunc_len);
- 	crypto_hmac_init(tfm, esp->auth.key, &esp->auth.key_len);
-	skb_icv_walk(skb, tfm, offset, len, crypto_hmac_update);
-	crypto_hmac_final(tfm, esp->auth.key, &esp->auth.key_len, icv);
-	memcpy(auth_data, icv, esp->auth.icv_trunc_len);
-}
-
 /* Check that skb data bits are writable. If they are not, copy data
  * to newly created private area. If "tailbits" is given, make sure that
  * tailbits bytes beyond current end of skb are writable.
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv4/xfrm_input.c linux25/net/ipv4/xfrm_input.c
--- linux-2.5.62+cs1.1002/net/ipv4/xfrm_input.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv4/xfrm_input.c	2003-02-23 13:25:00.000000000 +0900
@@ -1,4 +1,13 @@
+/* Changes
+ *
+ *	Mitsuru KANDA @USAGI       : IPv6 Support 
+ * 	Kazunori MIYAZAWA @USAGI   :
+ * 	Kunihiro Ishiguro          :
+ * 	
+ */
+
 #include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/xfrm.h>
 
 static kmem_cache_t *secpath_cachep;
@@ -157,3 +166,288 @@
 	if (!secpath_cachep)
 		panic("IP: failed to allocate secpath_cache\n");
 }
+
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+
+/* Fetch spi and seq frpm ipsec header */
+
+static int xfrm6_parse_spi(struct sk_buff *skb, u8 nexthdr, u32 *spi, u32 *seq)
+{
+	int offset, offset_seq;
+
+	switch (nexthdr) {
+	case IPPROTO_AH:
+		offset = offsetof(struct ip_auth_hdr, spi);
+		offset_seq = offsetof(struct ip_auth_hdr, seq_no);
+		break;
+	case IPPROTO_ESP:
+		offset = offsetof(struct ip_esp_hdr, spi);
+		offset_seq = offsetof(struct ip_esp_hdr, seq_no);
+		break;
+	case IPPROTO_COMP:
+		if (!pskb_may_pull(skb, 4))
+			return -EINVAL;
+		*spi = *(u16*)(skb->h.raw + 2);
+		*seq = 0;
+		return 0;
+	default:
+		return 1;
+	}
+
+	if (!pskb_may_pull(skb, 16))
+		return -EINVAL;
+
+	*spi = *(u32*)(skb->h.raw + offset);
+	*seq = *(u32*)(skb->h.raw + offset_seq);
+	return 0;
+}
+
+static int zero_out_mutable_opts(struct ipv6_opt_hdr *opthdr)
+{
+	u8 *opt = (u8 *)opthdr;
+	int len = ipv6_optlen(opthdr);
+	int off = 0;
+	int optlen = 0;
+
+	off += 2;
+	len -= 2;
+
+	while (len > 0) {
+
+		switch (opt[off]) {
+
+		case IPV6_TLV_PAD0:
+			optlen = 1;
+			break;
+		default:
+			if (len < 2) 
+				goto bad;
+			optlen = opt[off+1]+2;
+			if (len < optlen)
+				goto bad;
+			if (opt[off] & 0x20)
+				memset(&opt[off+2], 0, opt[off+1]);
+			break;
+		}
+
+		off += optlen;
+		len -= optlen;
+	}
+	if (len == 0)
+		return 1;
+
+bad:
+	return 0;
+}
+
+int xfrm6_clear_mutable_options(struct sk_buff *skb, u16 *nh_offset, int dir)
+{
+	u16 offset = sizeof(struct ipv6hdr);
+	struct ipv6_opt_hdr *exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+	unsigned int packet_len = skb->tail - skb->nh.raw;
+	u8 nexthdr = skb->nh.ipv6h->nexthdr;
+	u8 nextnexthdr = 0;
+
+	*nh_offset = ((unsigned char *)&skb->nh.ipv6h->nexthdr) - skb->nh.raw;
+
+	while (offset + 1 <= packet_len) {
+
+		switch (nexthdr) {
+
+		case NEXTHDR_HOP:
+			*nh_offset = offset;
+			offset += ipv6_optlen(exthdr);
+			if (!zero_out_mutable_opts(exthdr)) {
+				if (net_ratelimit())
+					printk(KERN_WARNING "overrun hopopts\n"); 
+				return 0;
+			}
+			nexthdr = exthdr->nexthdr;
+			exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+			break;
+
+		case NEXTHDR_ROUTING:
+			*nh_offset = offset;
+			offset += ipv6_optlen(exthdr);
+			((struct ipv6_rt_hdr*)exthdr)->segments_left = 0; 
+			nexthdr = exthdr->nexthdr;
+			exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+			break;
+
+		case NEXTHDR_DEST:
+			*nh_offset = offset;
+			offset += ipv6_optlen(exthdr);
+			if (!zero_out_mutable_opts(exthdr))  {
+				if (net_ratelimit())
+					printk(KERN_WARNING "overrun destopt\n"); 
+				return 0;
+			}
+			nexthdr = exthdr->nexthdr;
+			exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+			break;
+
+		case NEXTHDR_AUTH:
+			if (dir == XFRM_POLICY_OUT) {
+				memset(((struct ipv6_auth_hdr*)exthdr)->auth_data, 0, 
+				       (((struct ipv6_auth_hdr*)exthdr)->hdrlen - 1) << 2);
+			}
+			if (exthdr->nexthdr == NEXTHDR_DEST) {
+				offset += (((struct ipv6_auth_hdr*)exthdr)->hdrlen + 2) << 2;
+				exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+				nextnexthdr = exthdr->nexthdr;
+				if (!zero_out_mutable_opts(exthdr)) {
+					if (net_ratelimit())
+						printk(KERN_WARNING "overrun destopt\n");
+					return 0;
+				}
+			}
+			return nexthdr;
+		default :
+			return nexthdr;
+		}
+	}
+
+	return nexthdr;
+}
+
+int xfrm6_rcv(struct sk_buff *skb)
+{
+	int err;
+	u32 spi, seq;
+	struct xfrm_state *xfrm_vec[XFRM_MAX_DEPTH];
+	struct xfrm_state *x;
+	int xfrm_nr = 0;
+	int decaps = 0;
+	struct ipv6hdr *hdr = skb->nh.ipv6h;
+	unsigned char *tmp_hdr = NULL;
+	int hdr_len = 0;
+	u16 nh_offset = 0;
+	u8 nexthdr = 0;
+
+	if (hdr->nexthdr == IPPROTO_AH || hdr->nexthdr == IPPROTO_ESP) {
+		nh_offset = ((unsigned char*)&skb->nh.ipv6h->nexthdr) - skb->nh.raw;
+		hdr_len = sizeof(struct ipv6hdr);
+	} else {
+		hdr_len = skb->h.raw - skb->nh.raw;
+	}
+
+	tmp_hdr = kmalloc(hdr_len, GFP_ATOMIC);
+	if (!tmp_hdr)
+		goto drop;
+	memcpy(tmp_hdr, skb->nh.raw, hdr_len);
+
+	nexthdr = xfrm6_clear_mutable_options(skb, &nh_offset, XFRM_POLICY_IN);
+	hdr->priority    = 0;
+	hdr->flow_lbl[0] = 0;
+	hdr->flow_lbl[1] = 0;
+	hdr->flow_lbl[2] = 0;
+	hdr->hop_limit   = 0;
+
+	if ((err = xfrm6_parse_spi(skb, nexthdr, &spi, &seq)) != 0)
+		goto drop;
+	
+	do {
+		struct ipv6hdr *iph = skb->nh.ipv6h;
+
+		if (xfrm_nr == XFRM_MAX_DEPTH)
+			goto drop;
+
+		x = xfrm6_state_lookup(&iph->daddr, spi, nexthdr);
+		if (x == NULL)
+			goto drop;
+		spin_lock(&x->lock);
+		if (unlikely(x->km.state != XFRM_STATE_VALID))
+			goto drop_unlock;
+
+		if (x->props.replay_window && xfrm_replay_check(x, seq))
+			goto drop_unlock;
+
+		nexthdr = x->type->input(x, skb);
+		if (nexthdr <= 0)
+			goto drop_unlock;
+
+		if (x->props.replay_window)
+			xfrm_replay_advance(x, seq);
+
+		x->curlft.bytes += skb->len;
+		x->curlft.packets++;
+
+		spin_unlock(&x->lock);
+
+		xfrm_vec[xfrm_nr++] = x;
+
+		iph = skb->nh.ipv6h; /* ??? */ 
+
+		if (nexthdr == NEXTHDR_DEST) {
+			if (!pskb_may_pull(skb, (skb->h.raw-skb->data)+8) ||
+		    	!pskb_may_pull(skb, (skb->h.raw-skb->data)+((skb->h.raw[1]+1)<<3))) {
+				err = -EINVAL;
+				goto drop;
+			}
+			nexthdr = skb->h.raw[0];
+			nh_offset = skb->h.raw - skb->nh.raw;
+			skb_pull(skb, (skb->h.raw[1]+1)<<3);
+			skb->h.raw = skb->data;
+		}
+
+		if (x->props.mode) { /* XXX */
+			if (iph->nexthdr != IPPROTO_IPV6)
+				goto drop;
+			skb->nh.raw = skb->data;
+			iph = skb->nh.ipv6h;
+			decaps = 1;
+			break;
+		}
+
+		if ((err = xfrm6_parse_spi(skb, nexthdr, &spi, &seq)) < 0)
+			goto drop;
+	} while (!err);
+
+	memcpy(skb->nh.raw, tmp_hdr, hdr_len);
+	skb->nh.raw[nh_offset] = nexthdr;
+	skb->nh.ipv6h->payload_len = htons(hdr_len + skb->len - sizeof(struct ipv6hdr));
+
+	/* Allocate new secpath or COW existing one. */
+	if (!skb->sp || atomic_read(&skb->sp->refcnt) != 1) {
+		struct sec_path *sp;
+		sp = kmem_cache_alloc(secpath_cachep, SLAB_ATOMIC);
+		if (!sp)
+			goto drop;
+		if (skb->sp) {
+			memcpy(sp, skb->sp, sizeof(struct sec_path));
+			secpath_put(skb->sp);
+		} else
+			sp->len = 0;
+		atomic_set(&sp->refcnt, 1);
+		skb->sp = sp;
+	}
+
+	if (xfrm_nr + skb->sp->len > XFRM_MAX_DEPTH)
+		goto drop;
+
+	memcpy(skb->sp->xvec+skb->sp->len, xfrm_vec, xfrm_nr*sizeof(void*));
+	skb->sp->len += xfrm_nr;
+
+	if (decaps) {
+		if (!(skb->dev->flags&IFF_LOOPBACK)) {
+			dst_release(skb->dst);
+			skb->dst = NULL;
+		}
+		netif_rx(skb);
+		return 0;
+	} else {
+		return -nexthdr;
+	}
+
+drop_unlock:
+	spin_unlock(&x->lock);
+	xfrm_state_put(x);
+drop:
+	if (tmp_hdr) kfree(tmp_hdr);
+	while (--xfrm_nr >= 0)
+		xfrm_state_put(xfrm_vec[xfrm_nr]);
+	kfree_skb(skb);
+	return 0;
+}
+
+#endif /* CONFIG_IPV6 || CONFIG_IPV6_MODULE */
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv4/xfrm_policy.c linux25/net/ipv4/xfrm_policy.c
--- linux-2.5.62+cs1.1002/net/ipv4/xfrm_policy.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv4/xfrm_policy.c	2003-02-23 13:25:00.000000000 +0900
@@ -1,6 +1,16 @@
+/* Changes
+ *
+ *	Mitsuru KANDA @USAGI       : IPv6 Support 
+ * 	Kazunori MIYAZAWA @USAGI   :
+ * 	Kunihiro Ishiguro          :
+ * 	
+ */
+
 #include <linux/config.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/ip6_route.h>
 
 DECLARE_MUTEX(xfrm_cfg_sem);
 
@@ -55,6 +65,34 @@
 
 #define flow_count(cpu)		(flow_number[cpu])
 
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+
+static int xfrm6_bundle_ok(struct xfrm_dst *xdst, struct flowi *fl);
+static int xfrm6_bundle_create(struct xfrm_policy *policy, 
+			       struct xfrm_state **xfrm, int nx,
+			       struct flowi *fl, struct dst_entry **dst_p);
+static int xfrm6_tmpl_resolve(struct xfrm_policy *policy, struct flowi *fl,
+			      struct xfrm_state **xfrm);
+
+static inline u32 flow_hash6(struct flowi *fl)
+{
+	u32 hash = fl->fl6_src->s6_addr32[2] ^
+		   fl->fl6_src->s6_addr32[3] ^ 
+		   fl->uli_u.ports.sport;
+
+	hash = ((hash & 0xF0F0F0F0) >> 4) | ((hash & 0x0F0F0F0F) << 4);
+
+	hash ^= fl->fl6_dst->s6_addr32[2] ^
+		fl->fl6_dst->s6_addr32[3] ^ 
+		fl->uli_u.ports.dport;
+	hash ^= (hash >> 10);
+	hash ^= (hash >> 20);
+	return hash & (FLOWCACHE_HASH_SIZE-1);
+}
+
+extern struct dst_ops xfrm6_dst_ops;
+#endif
+
 static void flow_cache_shrink(int cpu)
 {
 	int i;
@@ -77,13 +115,27 @@
 	}
 }
 
-struct xfrm_policy *flow_lookup(int dir, struct flowi *fl)
+struct xfrm_policy *flow_lookup(int dir, struct flowi *fl, 
+				unsigned short family)
 {
-	struct xfrm_policy *pol;
+	struct xfrm_policy *pol = NULL;
 	struct flow_entry *fle;
-	u32 hash = flow_hash(fl);
+	u32 hash;
 	int cpu;
 
+	switch (family) {
+	case AF_INET:
+		hash = flow_hash(fl);
+		break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+	case AF_INET6:
+		hash = flow_hash6(fl);
+		break;
+#endif
+	default:
+		return NULL;
+	}
+
 	local_bh_disable();
 	cpu = smp_processor_id();
 
@@ -101,7 +153,7 @@
 		}
 	}
 
-	pol = xfrm_policy_lookup(dir, fl);
+	pol = xfrm_policy_lookup(dir, fl, family);
 
 	if (fle) {
 		/* Stale flow entry found. Update it. */
@@ -506,33 +558,63 @@
 
 /* Find policy to apply to this flow. */
 
-struct xfrm_policy *xfrm_policy_lookup(int dir, struct flowi *fl)
+struct xfrm_policy *xfrm_policy_lookup(int dir, struct flowi *fl, unsigned short family)
 {
-	struct xfrm_policy *pol;
+	struct xfrm_policy *pol = NULL;
 
 	read_lock_bh(&xfrm_policy_lock);
 	for (pol = xfrm_policy_list[dir]; pol; pol = pol->next) {
 		struct xfrm_selector *sel = &pol->selector;
-
-		if (xfrm4_selector_match(sel, fl)) {
-			atomic_inc(&pol->refcnt);
+		switch (family) {
+		case AF_INET:
+			if (pol->family != AF_INET) break;
+			if (xfrm4_selector_match(sel, fl)) {
+				atomic_inc(&pol->refcnt);
+				goto unlock_out;
+			}
 			break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+		case AF_INET6:
+			if (pol->family != AF_INET6) break;
+			if (xfrm6_selector_match(sel, fl)) {
+				atomic_inc(&pol->refcnt);
+				goto unlock_out;
+			}
+			break;
+#endif
+		default:
+			goto unlock_out;
 		}
 	}
+unlock_out:
 	read_unlock_bh(&xfrm_policy_lock);
 	return pol;
 }
 
 struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir, struct flowi *fl)
 {
-	struct xfrm_policy *pol;
+	struct xfrm_policy *pol = NULL;
 
 	read_lock_bh(&xfrm_policy_lock);
 	if ((pol = sk->policy[dir]) != NULL) {
-		if (xfrm4_selector_match(&pol->selector, fl))
-			atomic_inc(&pol->refcnt);
-		else
+		switch (sk->family) {
+		case AF_INET:
+			if (xfrm4_selector_match(&pol->selector, fl))
+				atomic_inc(&pol->refcnt);
+			else
+				pol = NULL;
+			break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+		case AF_INET6:
+			if (xfrm6_selector_match(&pol->selector, fl))
+				atomic_inc(&pol->refcnt);
+			else
+				pol = NULL;
+			break;
+#endif
+		default:
 			pol = NULL;
+		}
 	}
 	read_unlock_bh(&xfrm_policy_lock);
 	return pol;
@@ -806,9 +888,7 @@
 	int nx = 0;
 	int err;
 	u32 genid;
-
-	fl->oif = rt->u.dst.dev->ifindex;
-	fl->fl4_src = rt->rt_src;
+	u16 family = (*dst_p)->ops->family;
 
 restart:
 	genid = xfrm_policy_genid;
@@ -821,7 +901,16 @@
 		if ((rt->u.dst.flags & DST_NOXFRM) || !xfrm_policy_list[XFRM_POLICY_OUT])
 			return 0;
 
-		policy = flow_lookup(XFRM_POLICY_OUT, fl);
+		switch (family) {
+		case AF_INET:
+			policy = flow_lookup(XFRM_POLICY_OUT, fl, AF_INET);
+			break;
+		case AF_INET6:
+			policy = flow_lookup(XFRM_POLICY_OUT, fl, AF_INET6);
+			break;
+		default:
+			return 0;
+		}
 		if (!policy)
 			return 0;
 	}
@@ -846,23 +935,48 @@
 		 * LATER: help from flow cache. It is optional, this
 		 * is required only for output policy.
 		 */
-		read_lock_bh(&policy->lock);
-		for (dst = policy->bundles; dst; dst = dst->next) {
-			struct xfrm_dst *xdst = (struct xfrm_dst*)dst;
-			if (xdst->u.rt.fl.fl4_dst == fl->fl4_dst &&
-			    xdst->u.rt.fl.fl4_src == fl->fl4_src &&
-			    xdst->u.rt.fl.oif == fl->oif &&
-			    xfrm_bundle_ok(xdst, fl)) {
-				dst_clone(dst);
+		if (family == AF_INET) {
+			fl->oif = rt->u.dst.dev->ifindex;
+			fl->fl4_src = rt->rt_src;
+			read_lock_bh(&policy->lock);
+			for (dst = policy->bundles; dst; dst = dst->next) {
+				struct xfrm_dst *xdst = (struct xfrm_dst*)dst;
+				if (xdst->u.rt.fl.fl4_dst == fl->fl4_dst &&
+				    xdst->u.rt.fl.fl4_src == fl->fl4_src &&
+				    xdst->u.rt.fl.oif == fl->oif &&
+				    xfrm_bundle_ok(xdst, fl)) {
+					dst_clone(dst);
+					break;
+				}
+			}
+			read_unlock_bh(&policy->lock);
+			if (dst)
 				break;
+			nx = xfrm_tmpl_resolve(policy, fl, xfrm);
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+		} else if (family == AF_INET6) {
+			read_lock_bh(&policy->lock);
+			for (dst = policy->bundles; dst; dst = dst->next) {
+				struct xfrm_dst *xdst = (struct xfrm_dst*)dst;
+				if (!memcmp(&xdst->u.rt6.rt6i_dst, &fl->fl6_dst, sizeof(struct in6_addr)) &&
+				    !memcmp(&xdst->u.rt6.rt6i_src, &fl->fl6_src, sizeof(struct in6_addr)) &&
+				    xfrm6_bundle_ok(xdst, fl)) {
+					dst_clone(dst);
+					break;
+				}
 			}
+			read_unlock_bh(&policy->lock);
+			if (dst)
+				break;
+			nx = xfrm6_tmpl_resolve(policy, fl, xfrm);
+#endif
+		} else {
+			return -EINVAL;
 		}
-		read_unlock_bh(&policy->lock);
 
 		if (dst)
 			break;
 
-		nx = xfrm_tmpl_resolve(policy, fl, xfrm);
 		if (unlikely(nx<0)) {
 			err = nx;
 			if (err == -EAGAIN) {
@@ -873,7 +987,18 @@
 
 				__set_task_state(tsk, TASK_INTERRUPTIBLE);
 				add_wait_queue(&km_waitq, &wait);
-				err = xfrm_tmpl_resolve(policy, fl, xfrm);
+				switch (family) {
+				case AF_INET:
+					err = xfrm_tmpl_resolve(policy, fl, xfrm);
+					break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+				case AF_INET6:
+					err = xfrm6_tmpl_resolve(policy, fl, xfrm);
+					break;
+#endif
+				default:
+					err = -EINVAL;
+				}
 				if (err == -EAGAIN)
 					schedule();
 				__set_task_state(tsk, TASK_RUNNING);
@@ -896,7 +1021,19 @@
 		}
 
 		dst = &rt->u.dst;
-		err = xfrm_bundle_create(policy, xfrm, nx, fl, &dst);
+		switch (family) {
+		case AF_INET:
+			err = xfrm_bundle_create(policy, xfrm, nx, fl, &dst);
+			break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+		case AF_INET6:
+			err = xfrm6_bundle_create(policy, xfrm, nx, fl, &dst);
+			break;
+#endif
+		default:
+			err = -EINVAL;
+		}
+			
 		if (unlikely(err)) {
 			int i;
 			for (i=0; i<nx; i++)
@@ -1008,18 +1145,108 @@
 	fl->fl4_src = iph->saddr;
 }
 
-int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb)
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+static inline int
+xfrm6_state_ok(struct xfrm_tmpl *tmpl, struct xfrm_state *x)
+{
+	return	x->id.proto == tmpl->id.proto &&
+		(x->id.spi == tmpl->id.spi || !tmpl->id.spi) &&
+		x->props.mode == tmpl->mode &&
+		(tmpl->aalgos & (1<<x->props.aalgo)) &&
+		(!x->props.mode || !ipv6_addr_any((struct in6_addr*)&x->props.saddr) ||
+		 !memcmp(&tmpl->saddr, &x->props.saddr, sizeof(struct in6_addr)));
+}
+
+static inline int
+xfrm6_policy_ok(struct xfrm_tmpl *tmpl, struct sec_path *sp, int idx)
+{
+	for (; idx < sp->len; idx++) {
+		if (xfrm6_state_ok(tmpl, sp->xvec[idx]))
+			return ++idx;
+	}
+	return -1;
+}
+
+static inline void
+_decode_session6(struct sk_buff *skb, struct flowi *fl)
+{
+	u16 offset = sizeof(struct ipv6hdr);
+	struct ipv6hdr *hdr = skb->nh.ipv6h;
+	struct ipv6_opt_hdr *exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+	u8 nexthdr = skb->nh.ipv6h->nexthdr;
+
+	fl->fl6_dst = &hdr->daddr;
+	fl->fl6_src = &hdr->saddr;
+
+	while (pskb_may_pull(skb, skb->nh.raw + offset + 1 - skb->data)) {
+		switch (nexthdr) {
+		case NEXTHDR_ROUTING:
+		case NEXTHDR_HOP:
+		case NEXTHDR_DEST:
+			offset += ipv6_optlen(exthdr);
+			nexthdr = exthdr->nexthdr;
+			exthdr = (struct ipv6_opt_hdr*)(skb->nh.raw + offset);
+			break;
+
+		case IPPROTO_UDP:
+		case IPPROTO_TCP:
+		case IPPROTO_SCTP:
+			if (pskb_may_pull(skb, skb->nh.raw + offset + 4 - skb->data)) {
+				u16 *ports = (u16 *)exthdr;
+
+				fl->uli_u.ports.sport = ports[0];
+				fl->uli_u.ports.dport = ports[1];
+			}
+			return;
+
+		/* XXX Why are there these headers? */
+		case IPPROTO_AH:
+		case IPPROTO_ESP:
+		default:
+			fl->uli_u.spi = 0;
+			return;
+		};
+	}
+}
+#endif
+
+int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb, unsigned short family)
 {
 	struct xfrm_policy *pol;
 	struct flowi fl;
 
-	_decode_session(skb, &fl);
+	switch (family) {
+	case AF_INET:
+		_decode_session(skb, &fl);
+		break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+	case AF_INET6:
+		_decode_session6(skb, &fl);
+		break;
+#endif
+	default :
+		return 0;
+	}
 
 	/* First, check used SA against their selectors. */
 	if (skb->sp) {
 		int i;
-		for (i=skb->sp->len-1; i>=0; i--) {
-			if (!xfrm4_selector_match(&skb->sp->xvec[i]->sel, &fl))
+		switch (family) {
+		case AF_INET:
+			for (i=skb->sp->len-1; i>=0; i--) {
+				if (!xfrm4_selector_match(&skb->sp->xvec[i]->sel, &fl))
+					return 0;
+			}
+			break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+		case AF_INET6:
+			for (i=skb->sp->len-1; i>=0; i--) {
+				if (family == AF_INET6 && !xfrm6_selector_match(&skb->sp->xvec[i]->sel, &fl))
+					return 0;
+			}
+			break;
+#endif
+		default :
 				return 0;
 		}
 	}
@@ -1029,7 +1256,7 @@
 		pol = xfrm_sk_policy_lookup(sk, dir, &fl);
 
 	if (!pol)
-		pol = flow_lookup(dir, &fl);
+		pol = flow_lookup(dir, &fl, family);
 
 	if (!pol)
 		return 1;
@@ -1049,10 +1276,25 @@
 			 * some barriers, but at the moment barriers
 			 * are implied between each two transformations.
 			 */
-			for (i = pol->xfrm_nr-1, k = 0; i >= 0; i--) {
-				k = xfrm_policy_ok(pol->xfrm_vec+i, sp, k);
-				if (k < 0)
-					goto reject;
+			switch (family) {
+			case AF_INET:
+				for (i = pol->xfrm_nr-1, k = 0; i >= 0; i--) {
+					k = xfrm_policy_ok(pol->xfrm_vec+i, sp, k);
+					if (k < 0)
+						goto reject;
+				}
+				break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+			case AF_INET6:
+				for (i = pol->xfrm_nr-1, k = 0; i >= 0; i--) {
+					k = xfrm_policy_ok(pol->xfrm_vec+i, sp, k);
+					if (k < 0)
+						goto reject;
+				}
+				break;
+#endif
+			default :
+				return 0;
 			}
 		}
 		xfrm_pol_put(pol);
@@ -1064,18 +1306,29 @@
 	return 0;
 }
 
-int __xfrm_route_forward(struct sk_buff *skb)
+int __xfrm_route_forward(struct sk_buff *skb, unsigned short family)
 {
 	struct flowi fl;
 
-	_decode_session(skb, &fl);
+	switch (family) {
+	case AF_INET:
+		_decode_session(skb, &fl);
+		break;
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+	case AF_INET6:
+		_decode_session6(skb, &fl);
+		break;
+#endif
+	default:
+		return 0;
+	}
 
 	return xfrm_lookup(&skb->dst, &fl, NULL, 0) == 0;
 }
 
 /* Optimize later using cookies and generation ids. */
 
-static struct dst_entry *xfrm4_dst_check(struct dst_entry *dst, u32 cookie)
+static struct dst_entry *xfrm_dst_check(struct dst_entry *dst, u32 cookie)
 {
 	struct dst_entry *child = dst;
 
@@ -1091,19 +1344,19 @@
 	return dst;
 }
 
-static void xfrm4_dst_destroy(struct dst_entry *dst)
+static void xfrm_dst_destroy(struct dst_entry *dst)
 {
 	xfrm_state_put(dst->xfrm);
 	dst->xfrm = NULL;
 }
 
-static void xfrm4_link_failure(struct sk_buff *skb)
+static void xfrm_link_failure(struct sk_buff *skb)
 {
 	/* Impossible. Such dst must be popped before reaches point of failure. */
 	return;
 }
 
-static struct dst_entry *xfrm4_negative_advice(struct dst_entry *dst)
+static struct dst_entry *xfrm_negative_advice(struct dst_entry *dst)
 {
 	if (dst) {
 		if (dst->obsolete) {
@@ -1114,8 +1367,7 @@
 	return dst;
 }
 
-
-static int xfrm4_garbage_collect(void)
+static void __xfrm_garbage_collect(void)
 {
 	int i;
 	struct xfrm_policy *pol;
@@ -1145,7 +1397,11 @@
 		gc_list = dst->next;
 		dst_free(dst);
 	}
+}
 
+static inline int xfrm4_garbage_collect(void)
+{
+	__xfrm_garbage_collect();
 	return (atomic_read(&xfrm4_dst_ops.entries) > xfrm4_dst_ops.gc_thresh*2);
 }
 
@@ -1247,10 +1503,10 @@
 	.family =		AF_INET,
 	.protocol =		__constant_htons(ETH_P_IP),
 	.gc =			xfrm4_garbage_collect,
-	.check =		xfrm4_dst_check,
-	.destroy =		xfrm4_dst_destroy,
-	.negative_advice =	xfrm4_negative_advice,
-	.link_failure =		xfrm4_link_failure,
+	.check =		xfrm_dst_check,
+	.destroy =		xfrm_dst_destroy,
+	.negative_advice =	xfrm_negative_advice,
+	.link_failure =		xfrm_link_failure,
 	.update_pmtu =		xfrm4_update_pmtu,
 	.get_mss =		xfrm4_get_mss,
 	.gc_thresh =		1024,
@@ -1267,8 +1523,301 @@
 	if (!xfrm4_dst_ops.kmem_cachep)
 		panic("IP: failed to allocate xfrm4_dst_cache\n");
 
-	flow_cache_init();
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+	xfrm6_dst_ops.kmem_cachep = xfrm4_dst_ops.kmem_cachep;
+#endif
 
+	flow_cache_init();
 	xfrm_state_init();
 	xfrm_input_init();
 }
+
+#if defined (CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
+
+/* Limited flow cache. Its function now is to accelerate search for
+ * policy rules.
+ *
+ * Flow cache is private to cpus, at the moment this is important
+ * mostly for flows which do not match any rule, so that flow lookups
+ * are absolultely cpu-local. When a rule exists we do some updates
+ * to rule (refcnt, stats), so that locality is broken. Later this
+ * can be repaired.
+ */
+
+/* Resolve list of templates for the flow, given policy. */
+
+static int
+xfrm6_tmpl_resolve(struct xfrm_policy *policy, struct flowi *fl,
+		  struct xfrm_state **xfrm)
+{
+	int nx;
+	int i, error;
+	struct in6_addr *daddr = fl->fl6_dst;
+	struct in6_addr *saddr = fl->fl6_src;
+
+	for (nx=0, i = 0; i < policy->xfrm_nr; i++) {
+		struct xfrm_state *x=NULL;
+		struct in6_addr *remote = daddr;
+		struct in6_addr *local = saddr;
+		struct xfrm_tmpl *tmpl = &policy->xfrm_vec[i];
+
+		if (tmpl->mode) {
+			remote = (struct in6_addr*)&tmpl->id.daddr;
+			local = (struct in6_addr*)&tmpl->saddr;
+		}
+
+		x = xfrm6_state_find(remote, local, fl, tmpl, policy, &error);
+
+		if (x && x->km.state == XFRM_STATE_VALID) {
+			xfrm[nx++] = x;
+			daddr = remote;
+			saddr = local;
+			continue;
+		}
+
+		if (x) {
+			error = (x->km.state == XFRM_STATE_ERROR ?
+				 -EINVAL : -EAGAIN);
+			xfrm_state_put(x);
+		}
+
+		if (!tmpl->optional)
+			goto fail;
+	}
+	return nx;
+
+fail:
+	for (nx--; nx>=0; nx--)
+		xfrm_state_put(xfrm[nx]);
+	return error;
+}
+
+/* Check that the bundle accepts the flow and its components are
+ * still valid.
+ */
+
+static int xfrm6_bundle_ok(struct xfrm_dst *xdst, struct flowi *fl)
+{
+	do {
+		if (xdst->u.dst.ops != &xfrm6_dst_ops)
+			return 1;
+
+		if (!xfrm6_selector_match(&xdst->u.dst.xfrm->sel, fl))
+			return 0;
+		if (xdst->u.dst.xfrm->km.state != XFRM_STATE_VALID ||
+		    xdst->u.dst.path->obsolete > 0)
+			return 0;
+		xdst = (struct xfrm_dst*)xdst->u.dst.child;
+	} while (xdst);
+	return 0;
+}
+
+
+/* Allocate chain of dst_entry's, attach known xfrm's, calculate
+ * all the metrics... Shortly, bundle a bundle.
+ */
+
+static int
+xfrm6_bundle_create(struct xfrm_policy *policy, struct xfrm_state **xfrm, int nx,
+		   struct flowi *fl, struct dst_entry **dst_p)
+{
+	struct dst_entry *dst, *dst_prev;
+	struct rt6_info *rt0 = (struct rt6_info*)(*dst_p);
+	struct rt6_info *rt  = rt0;
+	struct in6_addr *remote = fl->fl6_dst;
+	struct in6_addr *local  = fl->fl6_src;
+	int i;
+	int err = 0;
+	int header_len = 0;
+
+	dst = dst_prev = NULL;
+
+	for (i = 0; i < nx; i++) {
+		struct dst_entry *dst1 = dst_alloc(&xfrm6_dst_ops);
+
+		if (unlikely(dst1 == NULL)) {
+			err = -ENOBUFS;
+			goto error;
+		}
+
+		dst1->xfrm = xfrm[i];
+		if (!dst)
+			dst = dst1;
+		else {
+			dst_prev->child = dst1;
+			dst1->flags |= DST_NOHASH;
+			dst_clone(dst1);
+		}
+		dst_prev = dst1;
+		if (xfrm[i]->props.mode) {
+			remote = (struct in6_addr*)&xfrm[i]->id.daddr;
+			local  = (struct in6_addr*)&xfrm[i]->props.saddr;
+		}
+		header_len += xfrm[i]->props.header_len;
+	}
+
+	if (remote != fl->fl6_dst) {
+		struct flowi fl_tunnel;
+		memset(&fl_tunnel, 0, sizeof(fl_tunnel));
+		fl_tunnel.fl6_dst = remote;
+		fl_tunnel.fl6_src = local;
+
+		rt = (struct rt6_info*)ip6_route_output(NULL, &fl_tunnel);
+		if (err)
+			goto error;
+	} else {
+		dst_clone(&rt->u.dst);
+	}
+
+	dst_prev->child = &rt->u.dst;
+	for (dst_prev = dst; dst_prev != &rt->u.dst; dst_prev = dst_prev->child) {
+		struct xfrm_dst *x = (struct xfrm_dst*)dst_prev;
+		x->u.rt.fl = *fl;
+
+		dst_prev->dev = rt->u.dst.dev;
+		if (rt->u.dst.dev)
+			dev_hold(rt->u.dst.dev);
+		dst_prev->obsolete	= -1;
+		dst_prev->flags	       |= DST_HOST;
+		dst_prev->lastuse	= jiffies;
+		dst_prev->header_len	= header_len;
+		memcpy(&dst_prev->metrics, &rt->u.dst.metrics, sizeof(dst_prev->metrics));
+		dst_prev->path		= &rt->u.dst;
+
+		/* Copy neighbout for reachability confirmation */
+		dst_prev->neighbour	= neigh_clone(rt->u.dst.neighbour);
+		dst_prev->input		= rt->u.dst.input;
+		dst_prev->output	= dst_prev->xfrm->type->output;
+		/* Sheit... I remember I did this right. Apparently,
+		 * it was magically lost, so this code needs audit */
+		x->u.rt6.rt6i_flags    = rt0->rt6i_flags&(RTCF_BROADCAST|RTCF_MULTICAST|RTCF_LOCAL);
+		x->u.rt6.rt6i_metric   = rt0->rt6i_metric;
+		x->u.rt6.rt6i_node     = rt0->rt6i_node;
+		x->u.rt6.rt6i_hoplimit = rt0->rt6i_hoplimit;
+		x->u.rt6.rt6i_gateway  = rt0->rt6i_gateway;
+		memcpy(&x->u.rt6.rt6i_gateway, &rt0->rt6i_gateway, sizeof(x->u.rt6.rt6i_gateway)); 
+		header_len -= x->u.dst.xfrm->props.header_len;
+	}
+	*dst_p = dst;
+	return 0;
+
+error:
+	if (dst)
+		dst_free(dst);
+	return err;
+}
+
+static inline int xfrm6_garbage_collect(void)
+{
+	__xfrm_garbage_collect();
+	return (atomic_read(&xfrm6_dst_ops.entries) > xfrm6_dst_ops.gc_thresh*2);
+}
+
+static int bundle6_depends_on(struct dst_entry *dst, struct xfrm_state *x)
+{
+	do {
+		if (dst->xfrm == x)
+			return 1;
+	} while ((dst = dst->child) != NULL);
+	return 0;
+}
+
+int xfrm6_flush_bundles(struct xfrm_state *x)
+{
+	int i;
+	struct xfrm_policy *pol;
+	struct dst_entry *dst, **dstp, *gc_list = NULL;
+
+	read_lock_bh(&xfrm_policy_lock);
+	for (i=0; i<2*XFRM_POLICY_MAX; i++) {
+		for (pol = xfrm_policy_list[i]; pol; pol = pol->next) {
+			write_lock(&pol->lock);
+			dstp = &pol->bundles;
+			while ((dst=*dstp) != NULL) {
+				if (bundle6_depends_on(dst, x)) {
+					*dstp = dst->next;
+					dst->next = gc_list;
+					gc_list = dst;
+				} else {
+					dstp = &dst->next;
+				}
+			}
+			write_unlock(&pol->lock);
+		}
+	}
+	read_unlock_bh(&xfrm_policy_lock);
+
+	while (gc_list) {
+		dst = gc_list;
+		gc_list = dst->next;
+		dst_free(dst);
+	}
+
+	return 0;
+}
+
+static void xfrm6_update_pmtu(struct dst_entry *dst, u32 mtu)
+{
+	struct dst_entry *path = dst->path;
+
+	if (mtu >= 1280 && mtu < dst_pmtu(dst))
+		return;
+
+	path->ops->update_pmtu(path, mtu);
+}
+
+/* Well... that's _TASK_. We need to scan through transformation
+ * list and figure out what mss tcp should generate in order to
+ * final datagram fit to mtu. Mama mia... :-)
+ *
+ * Apparently, some easy way exists, but we used to choose the most
+ * bizarre ones. :-) So, raising Kalashnikov... tra-ta-ta.
+ *
+ * Consider this function as something like dark humour. :-)
+ */
+static int xfrm6_get_mss(struct dst_entry *dst, u32 mtu)
+{
+	int res = mtu - dst->header_len;
+
+	for (;;) {
+		struct dst_entry *d = dst;
+		int m = res;
+
+		do {
+			struct xfrm_state *x = d->xfrm;
+			if (x) {
+				spin_lock_bh(&x->lock);
+				if (x->km.state == XFRM_STATE_VALID &&
+				    x->type && x->type->get_max_size)
+					m = x->type->get_max_size(d->xfrm, m);
+				else
+					m += x->props.header_len;
+				spin_unlock_bh(&x->lock);
+			}
+		} while ((d = d->child) != NULL);
+
+		if (m <= mtu)
+			break;
+		res -= (m - mtu);
+		if (res < 88)
+			return mtu;
+	}
+
+	return res + dst->header_len;
+}
+
+struct dst_ops xfrm6_dst_ops = {
+	.family =		AF_INET6,
+	.protocol =		__constant_htons(ETH_P_IPV6),
+	.gc =			xfrm6_garbage_collect,
+	.check =		xfrm_dst_check,
+	.destroy =		xfrm_dst_destroy,
+	.negative_advice =	xfrm_negative_advice,
+	.link_failure =		xfrm_link_failure,
+	.update_pmtu =		xfrm6_update_pmtu,
+	.get_mss =		xfrm6_get_mss,
+	.gc_thresh =		1024,
+	.entry_size =		sizeof(struct xfrm_dst),
+};
+
+#endif /* CONFIG_IPV6 || CONFIG_IPV6_MODULE */
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv4/xfrm_state.c linux25/net/ipv4/xfrm_state.c
--- linux-2.5.62+cs1.1002/net/ipv4/xfrm_state.c	2003-02-23 17:53:46.000000000 +0900
+++ linux25/net/ipv4/xfrm_state.c	2003-02-23 13:25:00.000000000 +0900
@@ -1,3 +1,11 @@
+/* Changes
+ *
+ *	Mitsuru KANDA @USAGI       : IPv6 Support 
+ * 	Kazunori MIYAZAWA @USAGI   :
+ * 	Kunihiro Ishiguro          :
+ * 	
+ */
+
 #include <net/xfrm.h>
 #include <linux/pfkeyv2.h>
 #include <linux/ipsec.h>
@@ -165,8 +173,19 @@
 		spin_unlock(&xfrm_state_lock);
 		if (del_timer(&x->timer))
 			atomic_dec(&x->refcnt);
-		if (atomic_read(&x->refcnt) != 1)
-			xfrm_flush_bundles(x);
+		if (atomic_read(&x->refcnt) != 1) {
+			switch (x->props.family) {
+			case AF_INET:
+				xfrm_flush_bundles(x);
+				break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+			case AF_INET6:
+				xfrm6_flush_bundles(x);
+				break;
+#endif
+			default:;
+			}
+		}
 	}
 
 	if (kill && x->type)
@@ -290,6 +309,7 @@
 			x->props.saddr.xfrm4_addr = saddr;
 		x->props.mode = tmpl->mode;
 		x->props.reqid = tmpl->reqid;
+		x->props.family = AF_INET;
 
 		if (km_query(x, tmpl, pol) == 0) {
 			x->km.state = XFRM_STATE_ACQ;
@@ -322,10 +342,18 @@
 {
 	unsigned h = 0;
 
-	if (x->props.family == AF_INET)
+	switch (x->props.family) {
+	case AF_INET:
 		h = ntohl(x->id.daddr.xfrm4_addr);
-	else if (x->props.family == AF_INET6)
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case AF_INET6:
 		h = ntohl(x->id.daddr.a6[2]^x->id.daddr.a6[3]);
+		break;
+#endif
+	default:
+		return;
+	}
 
 	h = (h ^ (h>>16)) % XFRM_DST_HSIZE;
 
@@ -448,6 +476,7 @@
 		x0->props.family = AF_INET;
 		x0->props.mode = mode;
 		x0->props.reqid = reqid;
+		x0->props.family = AF_INET;
 		x0->lft.hard_add_expires_seconds = ACQ_EXPIRES;
 		atomic_inc(&x0->refcnt);
 		mod_timer(&x0->timer, jiffies + ACQ_EXPIRES*HZ);
@@ -836,4 +865,114 @@
 		wake_up(&km_waitq);
 	}
 }
+
+struct xfrm_state *
+xfrm6_state_find(struct in6_addr *daddr, struct in6_addr *saddr, struct flowi *fl, struct xfrm_tmpl *tmpl,
+		struct xfrm_policy *pol, int *err)
+{
+	unsigned h = ntohl(daddr->s6_addr32[2]^daddr->s6_addr32[3]);
+	struct xfrm_state *x = NULL;
+	int acquire_in_progress = 0;
+	int error = 0;
+	struct xfrm_state *best = NULL;
+
+	h = (h ^ (h>>16)) % XFRM_DST_HSIZE;
+
+	spin_lock_bh(&xfrm_state_lock);
+	list_for_each_entry(x, xfrm_state_bydst+h, bydst) {
+		if (x->props.family == AF_INET6&&
+		    !memcmp(daddr, &x->id.daddr, sizeof(*daddr)) &&
+		    x->props.reqid == tmpl->reqid &&
+		    (!memcmp(saddr, &x->props.saddr, sizeof(*saddr))|| ipv6_addr_any(saddr)) &&
+		    tmpl->mode == x->props.mode &&
+		    tmpl->id.proto == x->id.proto) {
+			/* Resolution logic:
+			   1. There is a valid state with matching selector.
+			      Done.
+			   2. Valid state with inappropriate selector. Skip.
+
+			   Entering area of "sysdeps".
+
+			   3. If state is not valid, selector is temporary,
+			      it selects only session which triggered
+			      previous resolution. Key manager will do
+			      something to install a state with proper
+			      selector.
+			 */
+			if (x->km.state == XFRM_STATE_VALID) {
+				if (!xfrm6_selector_match(&x->sel, fl))
+					continue;
+				if (!best ||
+				    best->km.dying > x->km.dying ||
+				    (best->km.dying == x->km.dying &&
+				     best->curlft.add_time < x->curlft.add_time))
+					best = x;
+			} else if (x->km.state == XFRM_STATE_ACQ) {
+				acquire_in_progress = 1;
+			} else if (x->km.state == XFRM_STATE_ERROR ||
+				   x->km.state == XFRM_STATE_EXPIRED) {
+				if (xfrm6_selector_match(&x->sel, fl))
+					error = 1;
+			}
+		}
+	}
+
+	if (best) {
+		atomic_inc(&best->refcnt);
+		spin_unlock_bh(&xfrm_state_lock);
+		return best;
+	}
+	x = NULL;
+	if (!error && !acquire_in_progress &&
+	    ((x = xfrm_state_alloc()) != NULL)) {
+		/* Initialize temporary selector matching only
+		 * to current session. */
+		memcpy(&x->sel.daddr, fl->fl6_dst, sizeof(struct in6_addr));
+		memcpy(&x->sel.saddr, fl->fl6_src, sizeof(struct in6_addr));
+		x->sel.dport = fl->uli_u.ports.dport;
+		x->sel.dport_mask = ~0;
+		x->sel.sport = fl->uli_u.ports.sport;
+		x->sel.sport_mask = ~0;
+		x->sel.prefixlen_d = 128;
+		x->sel.prefixlen_s = 128;
+		x->sel.proto = fl->proto;
+		x->sel.ifindex = fl->oif;
+		x->id = tmpl->id;
+		if (ipv6_addr_any((struct in6_addr*)&x->id.daddr))
+			memcpy(&x->id.daddr, daddr, sizeof(x->sel.daddr));
+		memcpy(&x->props.saddr, &tmpl->saddr, sizeof(x->props.saddr));
+		if (ipv6_addr_any((struct in6_addr*)&x->props.saddr))
+			memcpy(&x->props.saddr, &saddr, sizeof(x->sel.saddr));
+		x->props.mode = tmpl->mode;
+		x->props.reqid = tmpl->reqid;
+		x->props.family = AF_INET6;
+
+		if (km_query(x, tmpl, pol) == 0) {
+			x->km.state = XFRM_STATE_ACQ;
+			list_add_tail(&x->bydst, xfrm_state_bydst+h);
+			atomic_inc(&x->refcnt);
+			if (x->id.spi) {
+				struct in6_addr *addr = (struct in6_addr*)&x->id.daddr;
+				h = ntohl((addr->s6_addr32[2]^addr->s6_addr32[3])^x->id.spi^x->id.proto);
+				h = (h ^ (h>>10) ^ (h>>20)) % XFRM_DST_HSIZE;
+				list_add(&x->byspi, xfrm_state_byspi+h);
+				atomic_inc(&x->refcnt);
+			}
+			x->lft.hard_add_expires_seconds = ACQ_EXPIRES;
+			atomic_inc(&x->refcnt);
+			mod_timer(&x->timer, ACQ_EXPIRES*HZ);
+		} else {
+			x->km.state = XFRM_STATE_DEAD;
+			xfrm_state_put(x);
+			x = NULL;
+			error = 1;
+		}
+	}
+	spin_unlock_bh(&xfrm_state_lock);
+	if (!x)
+		*err = acquire_in_progress ? -EAGAIN :
+			(error ? -ESRCH : -ENOMEM);
+	return x;
+}
+
 #endif /* CONFIG_IPV6 || CONFIG_IPV6_MODULE */
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/Makefile linux25/net/ipv6/Makefile
--- linux-2.5.62+cs1.1002/net/ipv6/Makefile	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/Makefile	2003-02-23 15:26:11.000000000 +0900
@@ -10,4 +10,6 @@
 		exthdrs.o sysctl_net_ipv6.o datagram.o proc.o \
 		ip6_flowlabel.o ipv6_syms.o
 
+obj-$(CONFIG_INET_AH) += ah.o
+obj-$(CONFIG_INET_ESP) += esp.o
 obj-$(CONFIG_NETFILTER)	+= netfilter/
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/ah.c linux25/net/ipv6/ah.c
--- linux-2.5.62+cs1.1002/net/ipv6/ah.c	1970-01-01 09:00:00.000000000 +0900
+++ linux25/net/ipv6/ah.c	2003-02-23 20:52:24.000000000 +0900
@@ -0,0 +1,345 @@
+/* Changes
+ *
+ *	Mitsuru KANDA @USAGI       : IPv6 Support 
+ * 	Kazunori MIYAZAWA @USAGI   :
+ * 	Kunihiro Ishiguro          :
+ * 	
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <net/ip.h>
+#include <net/xfrm.h>
+#include <linux/crypto.h>
+#include <linux/pfkeyv2.h>
+#include <net/icmp.h>
+#include <net/ipv6.h>
+#include <asm/scatterlist.h>
+
+#include <net/xfrm.h>
+#include <asm/scatterlist.h>
+
+#define AH_HLEN_NOICV	12
+
+/* XXX no ipv6 ah specific */
+#define NIP6(addr) \
+	ntohs((addr).s6_addr16[0]),\
+	ntohs((addr).s6_addr16[1]),\
+	ntohs((addr).s6_addr16[2]),\
+	ntohs((addr).s6_addr16[3]),\
+	ntohs((addr).s6_addr16[4]),\
+	ntohs((addr).s6_addr16[5]),\
+	ntohs((addr).s6_addr16[6]),\
+	ntohs((addr).s6_addr16[7])
+
+int ah6_output(struct sk_buff *skb)
+{
+	int err;
+	int hdr_len = sizeof(struct ipv6hdr);
+	struct dst_entry *dst = skb->dst;
+	struct xfrm_state *x  = dst->xfrm;
+	struct ipv6hdr *iph = NULL;
+	struct ip_auth_hdr *ah;
+	struct ah_data *ahp;
+	u16 nh_offset = 0;
+	u8 nexthdr;
+printk(KERN_DEBUG "%s\n", __FUNCTION__);
+	if (skb->ip_summed == CHECKSUM_HW && skb_checksum_help(skb) == NULL)
+		return -EINVAL;
+
+	spin_lock_bh(&x->lock);
+	if ((err = xfrm_state_check_expire(x)) != 0)
+		goto error;
+	if ((err = xfrm_state_check_space(x, skb)) != 0)
+		goto error;
+
+	if (x->props.mode) {
+		iph = skb->nh.ipv6h;
+		skb->nh.ipv6h = (struct ipv6hdr*)skb_push(skb, x->props.header_len);
+		skb->nh.ipv6h->version = 6;
+		skb->nh.ipv6h->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
+		skb->nh.ipv6h->nexthdr = IPPROTO_AH;
+		memcpy(&skb->nh.ipv6h->saddr, &x->props.saddr, sizeof(struct in6_addr));
+		memcpy(&skb->nh.ipv6h->daddr, &x->id.daddr, sizeof(struct in6_addr));
+		ah = (struct ip_auth_hdr*)(skb->nh.ipv6h+1);
+		ah->nexthdr = IPPROTO_IPV6;
+	} else {
+		hdr_len = skb->h.raw - skb->nh.raw;
+		iph = kmalloc(hdr_len, GFP_ATOMIC);
+		if (!iph) {
+			err = -ENOMEM;
+			goto error;
+		}
+		memcpy(iph, skb->data, hdr_len);
+		skb->nh.ipv6h = (struct ipv6hdr*)skb_push(skb, x->props.header_len);
+		memcpy(skb->nh.ipv6h, iph, hdr_len);
+		nexthdr = xfrm6_clear_mutable_options(skb, &nh_offset, XFRM_POLICY_OUT);
+		if (nexthdr == 0)
+			goto error;
+
+		skb->nh.raw[nh_offset] = IPPROTO_AH;
+		skb->nh.ipv6h->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
+		ah = (struct ip_auth_hdr*)(skb->nh.raw+hdr_len);
+		skb->h.raw = (unsigned char*) ah;
+		ah->nexthdr = nexthdr;
+	}
+
+	skb->nh.ipv6h->priority    = 0;
+	skb->nh.ipv6h->flow_lbl[0] = 0;
+	skb->nh.ipv6h->flow_lbl[1] = 0;
+	skb->nh.ipv6h->flow_lbl[2] = 0;
+	skb->nh.ipv6h->hop_limit    = 0;
+
+	ahp = x->data;
+	ah->hdrlen  = (XFRM_ALIGN8(ahp->icv_trunc_len +
+		AH_HLEN_NOICV) >> 2) - 2;
+
+	ah->reserved = 0;
+	ah->spi = x->id.spi;
+	ah->seq_no = htonl(++x->replay.oseq);
+	ahp->icv(ahp, skb, ah->auth_data);
+
+	if (x->props.mode) {
+		skb->nh.ipv6h->hop_limit   = iph->hop_limit;
+		skb->nh.ipv6h->priority    = iph->priority; 	
+		skb->nh.ipv6h->flow_lbl[0] = iph->flow_lbl[0];
+		skb->nh.ipv6h->flow_lbl[1] = iph->flow_lbl[1];
+		skb->nh.ipv6h->flow_lbl[2] = iph->flow_lbl[2];
+	} else {
+		memcpy(skb->nh.ipv6h, iph, hdr_len);
+		skb->nh.raw[nh_offset] = IPPROTO_AH;
+		skb->nh.ipv6h->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
+		kfree (iph);
+	}
+
+	skb->nh.raw = skb->data;
+
+	x->curlft.bytes += skb->len;
+	x->curlft.packets++;
+	spin_unlock_bh(&x->lock);
+	if ((skb->dst = dst_pop(dst)) == NULL)
+		goto error_nolock;
+	return NET_XMIT_BYPASS;
+error:
+	spin_unlock_bh(&x->lock);
+error_nolock:
+	kfree_skb(skb);
+	return err;
+}
+
+int ah6_input(struct xfrm_state *x, struct sk_buff *skb)
+{
+	int ah_hlen;
+	struct ipv6hdr *iph;
+	struct ipv6_auth_hdr *ah;
+	struct ah_data *ahp;
+	unsigned char *tmp_hdr = NULL;
+	int hdr_len = skb->h.raw - skb->nh.raw;
+	u8 nexthdr = 0;
+
+	if (!pskb_may_pull(skb, sizeof(struct ip_auth_hdr)))
+		goto out;
+
+	ah = (struct ipv6_auth_hdr*)skb->data;
+	ahp = x->data;
+        ah_hlen = (ah->hdrlen + 2) << 2;
+
+        if (ah_hlen != XFRM_ALIGN8(ahp->icv_full_len + AH_HLEN_NOICV) &&
+            ah_hlen != XFRM_ALIGN8(ahp->icv_trunc_len + AH_HLEN_NOICV))
+                goto out;
+
+	if (!pskb_may_pull(skb, ah_hlen))
+		goto out;
+
+	/* We are going to _remove_ AH header to keep sockets happy,
+	 * so... Later this can change. */
+	if (skb_cloned(skb) &&
+	    pskb_expand_head(skb, 0, 0, GFP_ATOMIC))
+		goto out;
+
+	tmp_hdr = kmalloc(hdr_len, GFP_ATOMIC);
+	if (!tmp_hdr)
+		goto out;
+	memcpy(tmp_hdr, skb->nh.raw, hdr_len);
+	ah = (struct ipv6_auth_hdr*)skb->data;
+	iph = skb->nh.ipv6h;
+
+        {
+		u8 auth_data[ahp->icv_trunc_len];
+
+		memcpy(auth_data, ah->auth_data, ahp->icv_trunc_len);
+		skb_push(skb, skb->data - skb->nh.raw);
+		ahp->icv(ahp, skb, ah->auth_data);
+		if (memcmp(ah->auth_data, auth_data, ahp->icv_trunc_len)) {
+			if (net_ratelimit())
+				printk(KERN_WARNING "ipsec ah authentication error\n");
+			x->stats.integrity_failed++;
+			goto free_out;
+		}
+	}
+
+	nexthdr = ah->nexthdr;
+	skb->nh.raw = skb_pull(skb, (ah->hdrlen+2)<<2);
+	memcpy(skb->nh.raw, tmp_hdr, hdr_len);
+	skb->nh.ipv6h->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
+	skb_pull(skb, hdr_len);
+	skb->h.raw = skb->data;
+
+
+	kfree(tmp_hdr);
+
+	return nexthdr;
+
+free_out:
+	kfree(tmp_hdr);
+out:
+	return -EINVAL;
+}
+
+void ah6_err(struct sk_buff *skb, struct inet6_skb_parm *opt, 
+	 int type, int code, int offset, __u32 info)
+{
+	struct ipv6hdr *iph = (struct ipv6hdr*)skb->data;
+	struct ip_auth_hdr *ah = (struct ip_auth_hdr*)(skb->data+offset);
+	struct xfrm_state *x;
+
+	if (type != ICMPV6_DEST_UNREACH ||
+	    type != ICMPV6_PKT_TOOBIG)
+		return;
+
+	x = xfrm6_state_lookup(&iph->daddr, ah->spi, IPPROTO_AH);
+	if (!x)
+		return;
+
+	printk(KERN_DEBUG "pmtu discvovery on SA AH/%08x/"
+			"%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+	       ntohl(ah->spi), NIP6(iph->daddr));
+
+	xfrm_state_put(x);
+}
+
+static int ah6_init_state(struct xfrm_state *x, void *args)
+{
+	struct ah_data *ahp = NULL;
+	struct xfrm_algo_desc *aalg_desc;
+
+	/* null auth can use a zero length key */
+	if (x->aalg->alg_key_len > 512)
+		goto error;
+
+	ahp = kmalloc(sizeof(*ahp), GFP_KERNEL);
+	if (ahp == NULL)
+		return -ENOMEM;
+
+	memset(ahp, 0, sizeof(*ahp));
+
+	ahp->key = x->aalg->alg_key;
+	ahp->key_len = (x->aalg->alg_key_len+7)/8;
+	ahp->tfm = crypto_alloc_tfm(x->aalg->alg_name, 0);
+	if (!ahp->tfm)
+		goto error;
+	ahp->icv = ah_hmac_digest;
+	
+	/*
+	 * Lookup the algorithm description maintained by xfrm_algo,
+	 * verify crypto transform properties, and store information
+	 * we need for AH processing.  This lookup cannot fail here
+	 * after a successful crypto_alloc_tfm().
+	 */
+	aalg_desc = xfrm_aalg_get_byname(x->aalg->alg_name);
+	BUG_ON(!aalg_desc);
+
+	if (aalg_desc->uinfo.auth.icv_fullbits/8 !=
+	    crypto_tfm_alg_digestsize(ahp->tfm)) {
+		printk(KERN_INFO "AH: %s digestsize %u != %hu\n",
+		       x->aalg->alg_name, crypto_tfm_alg_digestsize(ahp->tfm),
+		       aalg_desc->uinfo.auth.icv_fullbits/8);
+		goto error;
+	}
+	
+	ahp->icv_full_len = aalg_desc->uinfo.auth.icv_fullbits/8;
+	ahp->icv_trunc_len = aalg_desc->uinfo.auth.icv_truncbits/8;
+	
+	ahp->work_icv = kmalloc(ahp->icv_full_len, GFP_KERNEL);
+	if (!ahp->work_icv)
+		goto error;
+	
+	x->props.header_len = XFRM_ALIGN8(ahp->icv_trunc_len + AH_HLEN_NOICV);
+	if (x->props.mode)
+		x->props.header_len += 20;
+	x->data = ahp;
+
+	return 0;
+
+error:
+	if (ahp) {
+		if (ahp->work_icv)
+			kfree(ahp->work_icv);
+		if (ahp->tfm)
+			crypto_free_tfm(ahp->tfm);
+		kfree(ahp);
+	}
+	return -EINVAL;
+}
+
+static void ah6_destroy(struct xfrm_state *x)
+{
+	struct ah_data *ahp = x->data;
+
+	if (ahp->work_icv) {
+		kfree(ahp->work_icv);
+		ahp->work_icv = NULL;
+	}
+	if (ahp->tfm) {
+		crypto_free_tfm(ahp->tfm);
+		ahp->tfm = NULL;
+	}
+}
+
+static struct xfrm_type ah6_type =
+{
+	.description	= "AH6",
+	.proto	     	= IPPROTO_AH,
+	.init_state	= ah6_init_state,
+	.destructor	= ah6_destroy,
+	.input		= ah6_input,
+	.output		= ah6_output
+};
+
+static struct inet6_protocol ah6_protocol = {
+	.handler	=	xfrm6_rcv,
+	.err_handler	=	ah6_err,
+};
+
+int __init ah6_init(void)
+{
+	SET_MODULE_OWNER(&ah6_type);
+
+	if (xfrm6_register_type(&ah6_type) < 0) {
+		printk(KERN_INFO "ipv6 ah init: can't add xfrm type\n");
+		return -EAGAIN;
+	}
+
+	if (inet6_add_protocol(&ah6_protocol, IPPROTO_AH) < 0) {
+		printk(KERN_INFO "ipv6 ah init: can't add protocol\n");
+		xfrm6_unregister_type(&ah6_type);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static void __exit ah6_fini(void)
+{
+	if (inet6_del_protocol(&ah6_protocol, IPPROTO_AH) < 0)
+		printk(KERN_INFO "ipv6 ah close: can't remove protocol\n");
+
+	if (xfrm6_unregister_type(&ah6_type) < 0)
+		printk(KERN_INFO "ipv6 ah close: can't remove xfrm type\n");
+
+}
+
+module_init(ah6_init);
+module_exit(ah6_fini);
+
+MODULE_LICENSE("GPL");
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/esp.c linux25/net/ipv6/esp.c
--- linux-2.5.62+cs1.1002/net/ipv6/esp.c	1970-01-01 09:00:00.000000000 +0900
+++ linux25/net/ipv6/esp.c	2003-02-23 20:52:24.000000000 +0900
@@ -0,0 +1,508 @@
+/* Changes
+ *
+ *	Mitsuru KANDA @USAGI       : IPv6 Support 
+ * 	Kazunori MIYAZAWA @USAGI   :
+ * 	Kunihiro Ishiguro          :
+ * 	
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <net/ip.h>
+#include <net/xfrm.h>
+#include <asm/scatterlist.h>
+#include <linux/crypto.h>
+#include <linux/pfkeyv2.h>
+#include <linux/random.h>
+#include <net/icmp.h>
+#include <net/ipv6.h>
+#include <linux/icmpv6.h>
+
+#define MAX_SG_ONSTACK 4
+
+/* BUGS:
+ * - we assume replay seqno is always present.
+ */
+
+/* Move to common area: it is shared with AH. */
+/* Common with AH after some work on arguments. */
+
+/* XXX no ipv6 esp specific */
+#define NIP6(addr) \
+	ntohs((addr).s6_addr16[0]),\
+	ntohs((addr).s6_addr16[1]),\
+	ntohs((addr).s6_addr16[2]),\
+	ntohs((addr).s6_addr16[3]),\
+	ntohs((addr).s6_addr16[4]),\
+	ntohs((addr).s6_addr16[5]),\
+	ntohs((addr).s6_addr16[6]),\
+	ntohs((addr).s6_addr16[7])
+
+static int get_offset(u8 *packet, u32 packet_len, u8 *nexthdr, struct ipv6_opt_hdr **prevhdr)
+{
+	u16 offset = sizeof(struct ipv6hdr);
+	struct ipv6_opt_hdr *exthdr = (struct ipv6_opt_hdr*)(packet + offset);
+	u8 nextnexthdr;
+
+	*nexthdr = ((struct ipv6hdr*)packet)->nexthdr;
+
+	while (offset + 1 < packet_len) {
+
+		switch (*nexthdr) {
+
+		case NEXTHDR_HOP:
+		case NEXTHDR_ROUTING:
+			offset += ipv6_optlen(exthdr);
+			*nexthdr = exthdr->nexthdr;
+			*prevhdr = exthdr;
+			exthdr = (struct ipv6_opt_hdr*)(packet + offset);
+			break;
+
+		case NEXTHDR_DEST:
+			nextnexthdr =
+				((struct ipv6_opt_hdr*)(packet + offset + ipv6_optlen(exthdr)))->nexthdr;
+			/* XXX We know the option is inner dest opt
+			   with next next header check. */
+			if (nextnexthdr != NEXTHDR_HOP &&
+		    	    nextnexthdr != NEXTHDR_ROUTING &&
+			    nextnexthdr != NEXTHDR_DEST) {
+					return offset;
+			}
+			offset += ipv6_optlen(exthdr);
+			*nexthdr = exthdr->nexthdr;
+			*prevhdr = exthdr;
+			exthdr = (struct ipv6_opt_hdr*)(packet + offset);
+			break;
+
+		default :
+			return offset;
+		}
+	}
+
+	return offset;
+}
+
+int esp6_output(struct sk_buff *skb)
+{
+	int err;
+	int hdr_len = 0;
+	struct dst_entry *dst = skb->dst;
+	struct xfrm_state *x  = dst->xfrm;
+	struct ipv6hdr *iph = NULL, *top_iph;
+	struct ip_esp_hdr *esph;
+	struct crypto_tfm *tfm;
+	struct esp_data *esp;
+	struct sk_buff *trailer;
+	struct ipv6_opt_hdr *prevhdr = NULL;
+	int blksize;
+	int clen;
+	int alen;
+	int nfrags;
+	u8 nexthdr;
+printk(KERN_DEBUG "%s\n", __FUNCTION__);
+	/* First, if the skb is not checksummed, complete checksum. */
+	if (skb->ip_summed == CHECKSUM_HW && skb_checksum_help(skb) == NULL)
+		return -EINVAL;
+
+	spin_lock_bh(&x->lock);
+	if ((err = xfrm_state_check_expire(x)) != 0)
+		goto error;
+	if ((err = xfrm_state_check_space(x, skb)) != 0)
+		goto error;
+
+	err = -ENOMEM;
+
+	/* Strip IP header in transport mode. Save it. */
+
+	if (!x->props.mode) {
+		hdr_len = get_offset(skb->nh.raw, skb->len, &nexthdr, &prevhdr);
+		iph = kmalloc(hdr_len, GFP_ATOMIC);
+		if (!iph) {
+			err = -ENOMEM;
+			goto error;
+		}
+		memcpy(iph, skb->nh.raw, hdr_len);
+		__skb_pull(skb, hdr_len);
+	}
+
+	/* Now skb is pure payload to encrypt */
+
+	/* Round to block size */
+	clen = skb->len;
+
+	esp = x->data;
+	alen = esp->auth.icv_trunc_len;
+	tfm = esp->conf.tfm;
+	blksize = crypto_tfm_alg_blocksize(tfm);
+	clen = (clen + 2 + blksize-1)&~(blksize-1);
+	if (esp->conf.padlen)
+		clen = (clen + esp->conf.padlen-1)&~(esp->conf.padlen-1);
+
+	if ((nfrags = skb_cow_data(skb, clen-skb->len+alen, &trailer)) < 0) {
+		if (!x->props.mode && iph) kfree(iph);
+		goto error;
+	}
+
+	/* Fill padding... */
+	do {
+		int i;
+		for (i=0; i<clen-skb->len - 2; i++)
+			*(u8*)(trailer->tail + i) = i+1;
+	} while (0);
+	*(u8*)(trailer->tail + clen-skb->len - 2) = (clen - skb->len)-2;
+	pskb_put(skb, trailer, clen - skb->len);
+
+	if (x->props.mode) {
+		iph = skb->nh.ipv6h;
+		top_iph = (struct ipv6hdr*)skb_push(skb, x->props.header_len);
+		esph = (struct ip_esp_hdr*)(top_iph+1);
+		*(u8*)(trailer->tail - 1) = IPPROTO_IPV6;
+		top_iph->version = 6;
+		top_iph->priority = iph->priority;
+		top_iph->flow_lbl[0] = iph->flow_lbl[0];
+		top_iph->flow_lbl[1] = iph->flow_lbl[1];
+		top_iph->flow_lbl[2] = iph->flow_lbl[2];
+		top_iph->nexthdr = IPPROTO_ESP;
+		top_iph->payload_len = htons(skb->len + alen);
+		top_iph->hop_limit = iph->hop_limit;
+		memcpy(&top_iph->saddr, (struct in6_addr *)&x->props.saddr, sizeof(struct ipv6hdr));
+		memcpy(&top_iph->daddr, (struct in6_addr *)&x->id.daddr, sizeof(struct ipv6hdr));
+	} else { 
+		/* XXX exthdr */
+		esph = (struct ip_esp_hdr*)skb_push(skb, x->props.header_len);
+		skb->h.raw = (unsigned char*)esph;
+		top_iph = (struct ipv6hdr*)skb_push(skb, hdr_len);
+		memcpy(top_iph, iph, hdr_len);
+		kfree(iph);
+		top_iph->payload_len = htons(skb->len + alen - sizeof(struct ipv6hdr));
+		if (prevhdr) {
+			prevhdr->nexthdr = IPPROTO_ESP;
+		} else {
+			top_iph->nexthdr = IPPROTO_ESP;
+		}
+		*(u8*)(trailer->tail - 1) = nexthdr;
+	}
+
+	esph->spi = x->id.spi;
+	esph->seq_no = htonl(++x->replay.oseq);
+
+	if (esp->conf.ivlen)
+		crypto_cipher_set_iv(tfm, esp->conf.ivec, crypto_tfm_alg_ivsize(tfm));
+
+	do {
+		struct scatterlist sgbuf[nfrags>MAX_SG_ONSTACK ? 0 : nfrags];
+		struct scatterlist *sg = sgbuf;
+
+		if (unlikely(nfrags > MAX_SG_ONSTACK)) {
+			sg = kmalloc(sizeof(struct scatterlist)*nfrags, GFP_ATOMIC);
+			if (!sg)
+				goto error;
+		}
+		skb_to_sgvec(skb, sg, esph->enc_data+esp->conf.ivlen-skb->data, clen);
+		crypto_cipher_encrypt(tfm, sg, sg, clen);
+		if (unlikely(sg != sgbuf))
+			kfree(sg);
+	} while (0);
+
+	if (esp->conf.ivlen) {
+		memcpy(esph->enc_data, esp->conf.ivec, crypto_tfm_alg_ivsize(tfm));
+		crypto_cipher_get_iv(tfm, esp->conf.ivec, crypto_tfm_alg_ivsize(tfm));
+	}
+
+	if (esp->auth.icv_full_len) {
+		esp->auth.icv(esp, skb, (u8*)esph-skb->data,
+			8+esp->conf.ivlen+clen, trailer->tail);
+		pskb_put(skb, trailer, alen);
+	}
+
+	skb->nh.raw = skb->data;
+
+	x->curlft.bytes += skb->len;
+	x->curlft.packets++;
+	spin_unlock_bh(&x->lock);
+	if ((skb->dst = dst_pop(dst)) == NULL)
+		goto error_nolock;
+	return NET_XMIT_BYPASS;
+
+error:
+	spin_unlock_bh(&x->lock);
+error_nolock:
+	kfree_skb(skb);
+	return err;
+}
+
+int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
+{
+	struct ipv6hdr *iph;
+	struct ip_esp_hdr *esph;
+	struct esp_data *esp = x->data;
+	struct sk_buff *trailer;
+	int blksize = crypto_tfm_alg_blocksize(esp->conf.tfm);
+	int alen = esp->auth.icv_trunc_len;
+	int elen = skb->len - 8 - esp->conf.ivlen - alen;
+
+	int hdr_len = skb->h.raw - skb->nh.raw;
+	int nfrags;
+	u8 ret_nexthdr = 0;
+	unsigned char *tmp_hdr = NULL;
+
+	if (!pskb_may_pull(skb, sizeof(struct ip_esp_hdr)))
+		goto out;
+
+	if (elen <= 0 || (elen & (blksize-1)))
+		goto out;
+
+	tmp_hdr = kmalloc(hdr_len, GFP_ATOMIC);
+	if (!tmp_hdr)
+		goto out;
+	memcpy(tmp_hdr, skb->nh.raw, hdr_len);
+
+	/* If integrity check is required, do this. */
+        if (esp->auth.icv_full_len) {
+		u8 sum[esp->auth.icv_full_len];
+		u8 sum1[alen];
+
+		esp->auth.icv(esp, skb, 0, skb->len-alen, sum);
+
+		if (skb_copy_bits(skb, skb->len-alen, sum1, alen))
+			BUG();
+
+		if (unlikely(memcmp(sum, sum1, alen))) {
+			x->stats.integrity_failed++;
+			goto out;
+		}
+	}
+
+	if ((nfrags = skb_cow_data(skb, 0, &trailer)) < 0)
+		goto out;
+
+	skb->ip_summed = CHECKSUM_NONE;
+
+	esph = (struct ip_esp_hdr*)skb->data;
+	iph = skb->nh.ipv6h;
+
+	/* Get ivec. This can be wrong, check against another impls. */
+	if (esp->conf.ivlen)
+		crypto_cipher_set_iv(esp->conf.tfm, esph->enc_data, crypto_tfm_alg_ivsize(esp->conf.tfm));
+
+        {
+		u8 nexthdr[2];
+		struct scatterlist sgbuf[nfrags>MAX_SG_ONSTACK ? 0 : nfrags];
+		struct scatterlist *sg = sgbuf;
+		u8 padlen;
+
+		if (unlikely(nfrags > MAX_SG_ONSTACK)) {
+			sg = kmalloc(sizeof(struct scatterlist)*nfrags, GFP_ATOMIC);
+			if (!sg)
+				goto out;
+		}
+		skb_to_sgvec(skb, sg, 8+esp->conf.ivlen, elen);
+		crypto_cipher_decrypt(esp->conf.tfm, sg, sg, elen);
+		if (unlikely(sg != sgbuf))
+			kfree(sg);
+
+		if (skb_copy_bits(skb, skb->len-alen-2, nexthdr, 2))
+			BUG();
+
+		padlen = nexthdr[0];
+		if (padlen+2 >= elen) {
+			if (net_ratelimit()) {
+				printk(KERN_WARNING "ipsec esp packet is garbage padlen=%d, elen=%d\n", padlen+2, elen);
+			}
+			goto out;
+		}
+		/* ... check padding bits here. Silly. :-) */ 
+
+		ret_nexthdr = nexthdr[1];
+		pskb_trim(skb, skb->len - alen - padlen - 2);
+		skb->h.raw = skb_pull(skb, 8 + esp->conf.ivlen);
+		skb->nh.raw += 8 + esp->conf.ivlen;
+		memcpy(skb->nh.raw, tmp_hdr, hdr_len);
+	}
+	kfree(tmp_hdr);
+	return ret_nexthdr;
+
+out:
+	return -EINVAL;
+}
+
+static u32 esp6_get_max_size(struct xfrm_state *x, int mtu)
+{
+	struct esp_data *esp = x->data;
+	u32 blksize = crypto_tfm_alg_blocksize(esp->conf.tfm);
+
+	if (x->props.mode) {
+		mtu = (mtu + 2 + blksize-1)&~(blksize-1);
+	} else {
+		/* The worst case. */
+		mtu += 2 + blksize;
+	}
+	if (esp->conf.padlen)
+		mtu = (mtu + esp->conf.padlen-1)&~(esp->conf.padlen-1);
+
+	return mtu + x->props.header_len + esp->auth.icv_full_len;
+}
+
+void esp6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+		int type, int code, int offset, __u32 info)
+{
+	struct ipv6hdr *iph = (struct ipv6hdr*)skb->data;
+	struct ip_esp_hdr *esph = (struct ip_esp_hdr*)(skb->data+offset);
+	struct xfrm_state *x;
+
+	if (type != ICMPV6_DEST_UNREACH ||
+	    type != ICMPV6_PKT_TOOBIG)
+		return;
+
+	x = xfrm6_state_lookup(&iph->daddr, esph->spi, IPPROTO_ESP);
+	if (!x)
+		return;
+	printk(KERN_DEBUG "pmtu discvovery on SA ESP/%08x/"
+			"%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n", 
+			ntohl(esph->spi), NIP6(iph->daddr));
+	xfrm_state_put(x);
+}
+
+void esp6_destroy(struct xfrm_state *x)
+{
+	struct esp_data *esp = x->data;
+
+	if (esp->conf.tfm) {
+		crypto_free_tfm(esp->conf.tfm);
+		esp->conf.tfm = NULL;
+	}
+	if (esp->conf.ivec) {
+		kfree(esp->conf.ivec);
+		esp->conf.ivec = NULL;
+	}
+	if (esp->auth.tfm) {
+		crypto_free_tfm(esp->auth.tfm);
+		esp->auth.tfm = NULL;
+	}
+	if (esp->auth.work_icv) {
+		kfree(esp->auth.work_icv);
+		esp->auth.work_icv = NULL;
+	}
+}
+
+int esp6_init_state(struct xfrm_state *x, void *args)
+{
+	struct esp_data *esp = NULL;
+
+	if (x->aalg) {
+		if (x->aalg->alg_key_len == 0 || x->aalg->alg_key_len > 512)
+			goto error;
+	}
+	if (x->ealg == NULL || x->ealg->alg_key_len == 0)
+		goto error;
+
+	esp = kmalloc(sizeof(*esp), GFP_KERNEL);
+	if (esp == NULL)
+		return -ENOMEM;
+
+	memset(esp, 0, sizeof(*esp));
+
+	if (x->aalg) {
+		struct xfrm_algo_desc *aalg_desc;
+
+		esp->auth.key = x->aalg->alg_key;
+		esp->auth.key_len = (x->aalg->alg_key_len+7)/8;
+		esp->auth.tfm = crypto_alloc_tfm(x->aalg->alg_name, 0);
+		if (esp->auth.tfm == NULL)
+			goto error;
+		esp->auth.icv = esp_hmac_digest;
+ 
+		aalg_desc = xfrm_aalg_get_byname(x->aalg->alg_name);
+		BUG_ON(!aalg_desc);
+ 
+		if (aalg_desc->uinfo.auth.icv_fullbits/8 !=
+			crypto_tfm_alg_digestsize(esp->auth.tfm)) {
+				printk(KERN_INFO "ESP: %s digestsize %u != %hu\n",
+					x->aalg->alg_name,
+					crypto_tfm_alg_digestsize(esp->auth.tfm),
+					aalg_desc->uinfo.auth.icv_fullbits/8);
+				goto error;
+		}
+ 
+		esp->auth.icv_full_len = aalg_desc->uinfo.auth.icv_fullbits/8;
+		esp->auth.icv_trunc_len = aalg_desc->uinfo.auth.icv_truncbits/8;
+ 
+		esp->auth.work_icv = kmalloc(esp->auth.icv_full_len, GFP_KERNEL);
+		if (!esp->auth.work_icv)
+			goto error;
+	}
+	esp->conf.key = x->ealg->alg_key;
+	esp->conf.key_len = (x->ealg->alg_key_len+7)/8;
+	esp->conf.tfm = crypto_alloc_tfm(x->ealg->alg_name, CRYPTO_TFM_MODE_CBC);
+	if (esp->conf.tfm == NULL)
+		goto error;
+	esp->conf.ivlen = crypto_tfm_alg_ivsize(esp->conf.tfm);
+	esp->conf.padlen = 0;
+	if (esp->conf.ivlen) {
+		esp->conf.ivec = kmalloc(esp->conf.ivlen, GFP_KERNEL);
+		get_random_bytes(esp->conf.ivec, esp->conf.ivlen);
+	}
+	crypto_cipher_setkey(esp->conf.tfm, esp->conf.key, esp->conf.key_len);
+	x->props.header_len = 8 + esp->conf.ivlen;
+	if (x->props.mode)
+		x->props.header_len += 40;  /* XXX ext hdr */
+	x->data = esp;
+	return 0;
+
+error:
+	if (esp) {
+		if (esp->auth.tfm)
+			crypto_free_tfm(esp->auth.tfm);
+		if (esp->auth.work_icv)
+			kfree(esp->auth.work_icv);
+		if (esp->conf.tfm)
+			crypto_free_tfm(esp->conf.tfm);
+		kfree(esp);
+	}
+	return -EINVAL;
+}
+
+static struct xfrm_type esp6_type =
+{
+	.description	= "ESP6",
+	.proto	     	= IPPROTO_ESP,
+	.init_state	= esp6_init_state,
+	.destructor	= esp6_destroy,
+	.get_max_size	= esp6_get_max_size,
+	.input		= esp6_input,
+	.output		= esp6_output
+};
+
+static struct inet6_protocol esp6_protocol = {
+	.handler 	=	xfrm6_rcv,
+	.err_handler	=	esp6_err,
+};
+
+int __init esp6_init(void)
+{
+	SET_MODULE_OWNER(&esp6_type);
+	if (xfrm6_register_type(&esp6_type) < 0) {
+		printk(KERN_INFO "ipv6 esp init: can't add xfrm type\n");
+		return -EAGAIN;
+	}
+	if (inet6_add_protocol(&esp6_protocol, IPPROTO_ESP) < 0) {
+		printk(KERN_INFO "ipv6 esp init: can't add protocol\n");
+		xfrm6_unregister_type(&esp6_type);
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static void __exit esp6_fini(void)
+{
+	if (inet6_del_protocol(&esp6_protocol, IPPROTO_ESP) < 0)
+		printk(KERN_INFO "ipv6 esp close: can't remove protocol\n");
+	if (xfrm6_unregister_type(&esp6_type) < 0)
+		printk(KERN_INFO "ipv6 esp close: can't remove xfrm type\n");
+}
+
+module_init(esp6_init);
+module_exit(esp6_fini);
+
+MODULE_LICENSE("GPL");
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/exthdrs.c linux25/net/ipv6/exthdrs.c
--- linux-2.5.62+cs1.1002/net/ipv6/exthdrs.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/exthdrs.c	2003-02-23 13:25:00.000000000 +0900
@@ -392,7 +392,7 @@
    cpu ticks, checking that sender did not something stupid
    and opt->hdrlen is even. Shit!		--ANK (980730)
  */
-
+#if 0
 static int ipv6_auth_hdr(struct sk_buff **skb_ptr, int nhoff)
 {
 	struct sk_buff *skb=*skb_ptr;
@@ -424,6 +424,7 @@
 	kfree_skb(skb);
 	return -1;
 }
+#endif
 
 /* This list MUST NOT contain entry for NEXTHDR_HOP.
    It is parsed immediately after packet received
@@ -436,7 +437,9 @@
 	{NEXTHDR_ROUTING,	ipv6_routing_header},
 	{NEXTHDR_DEST,		ipv6_dest_opt},
 	{NEXTHDR_NONE,		ipv6_nodata},
+   /*
 	{NEXTHDR_AUTH,		ipv6_auth_hdr},
+   */
    /*
 	{NEXTHDR_ESP,		ipv6_esp_hdr},
     */
@@ -627,6 +630,8 @@
 {
 	if (opt->auth)
 		prev_hdr = ipv6_build_authhdr(skb, prev_hdr, opt->auth);
+
+	skb->h.raw = skb->tail;
 	if (opt->dst1opt)
 		prev_hdr = ipv6_build_exthdr(skb, prev_hdr, NEXTHDR_DEST, opt->dst1opt);
 	return prev_hdr;
@@ -689,8 +694,10 @@
 
 void ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt, u8 *proto)
 {
-	if (opt->dst1opt)
+	if (opt->dst1opt) {
 		ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst1opt);
+		skb->h.raw = skb->data;
+	}
 	if (opt->auth)
 		ipv6_push_authhdr(skb, proto, opt->auth);
 }
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/ip6_input.c linux25/net/ipv6/ip6_input.c
--- linux-2.5.62+cs1.1002/net/ipv6/ip6_input.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/ip6_input.c	2003-02-23 13:25:00.000000000 +0900
@@ -150,7 +150,8 @@
 	   It would be stupid to detect for optional headers,
 	   which are missing with probability of 200%
 	 */
-	if (nexthdr != IPPROTO_TCP && nexthdr != IPPROTO_UDP) {
+	if (nexthdr != IPPROTO_TCP && nexthdr != IPPROTO_UDP &&
+	    nexthdr != NEXTHDR_AUTH && nexthdr != NEXTHDR_ESP) {
 		nhoff = ipv6_parse_exthdrs(&skb, nhoff);
 		if (nhoff < 0)
 			return 0;
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/ip6_output.c linux25/net/ipv6/ip6_output.c
--- linux-2.5.62+cs1.1002/net/ipv6/ip6_output.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/ip6_output.c	2003-02-23 13:25:00.000000000 +0900
@@ -192,6 +192,11 @@
 	int seg_len = skb->len;
 	int hlimit;
 	u32 mtu;
+	int err = 0;
+
+	if ((err = xfrm_lookup(&skb->dst, fl, sk, 0)) < 0) {
+		return err;
+	}
 
 	if (opt) {
 		int head_room;
@@ -576,6 +581,13 @@
 	}
 	pktlength = length;
 
+        if (dst) {
+		if ((err = xfrm_lookup(&dst, fl, sk, 0)) < 0) {
+			dst_release(dst);	
+			return -ENETUNREACH;
+		}
+        }
+
 	if (hlimit < 0) {
 		if (ipv6_addr_is_multicast(fl->fl6_dst))
 			hlimit = np->mcast_hops;
@@ -630,10 +642,8 @@
 		err = 0;
 		if (flags&MSG_PROBE)
 			goto out;
-
-		skb = sock_alloc_send_skb(sk, pktlength + 15 +
-					  dev->hard_header_len,
-					  flags & MSG_DONTWAIT, &err);
+		/* alloc skb with mtu as we do in the IPv4 stack for IPsec */
+		skb = sock_alloc_send_skb(sk, mtu, flags & MSG_DONTWAIT, &err);
 
 		if (skb == NULL) {
 			IP6_INC_STATS(Ip6OutDiscards);
@@ -663,6 +673,8 @@
 		err = getfrag(data, &hdr->saddr,
 			      ((char *) hdr) + (pktlength - length),
 			      0, length);
+		if (!opt || !opt->dst1opt)
+			skb->h.raw = ((char *) hdr) + (pktlength - length);
 
 		if (!err) {
 			IP6_INC_STATS(Ip6OutRequests);
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/ndisc.c linux25/net/ipv6/ndisc.c
--- linux-2.5.62+cs1.1002/net/ipv6/ndisc.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/ndisc.c	2003-02-23 13:25:00.000000000 +0900
@@ -72,6 +72,7 @@
 #include <net/addrconf.h>
 #include <net/icmp.h>
 
+#include <net/flow.h>
 #include <net/checksum.h>
 #include <linux/proc_fs.h>
 
@@ -336,8 +337,6 @@
 	unsigned char ha[MAX_ADDR_LEN];
 	unsigned char *h_dest = NULL;
 
-	skb_reserve(skb, (dev->hard_header_len + 15) & ~15);
-
 	if (dev->hard_header) {
 		if (ipv6_addr_type(daddr) & IPV6_ADDR_MULTICAST) {
 			ndisc_mc_map(daddr, ha, dev, 1);
@@ -374,10 +373,50 @@
  *	Send a Neighbour Advertisement
  */
 
+int ndisc_output(struct sk_buff *skb)
+{
+	if (skb) {
+		struct neighbour *neigh = (skb->dst ? skb->dst->neighbour : NULL);
+		if (ndisc_build_ll_hdr(skb, skb->dev, &skb->nh.ipv6h->daddr, neigh, skb->len) == 0) {
+			kfree_skb(skb);
+			return -EINVAL;
+		}
+		dev_queue_xmit(skb);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static inline void ndisc_rt_init(struct rt6_info *rt, struct net_device *dev,
+			    struct neighbour *neigh)
+{
+	rt->rt6i_dev	  = dev;
+	rt->rt6i_nexthop  = neigh;
+	rt->rt6i_expires  = 0;
+	rt->rt6i_flags    = RTF_LOCAL;
+	rt->rt6i_metric   = 0;
+	rt->rt6i_hoplimit = 255;
+	rt->u.dst.output  = ndisc_output;
+}
+
+static inline void ndisc_flow_init(struct flowi *fl, u8 type,
+			    struct in6_addr *saddr, struct in6_addr *daddr)
+{
+	memset(fl, 0, sizeof(*fl));
+	fl->fl6_src		= saddr;
+	fl->fl6_dst	 	= daddr;
+	fl->proto	 	= IPPROTO_ICMPV6;
+	fl->uli_u.icmpt.type	= type;
+	fl->uli_u.icmpt.code	= 0;
+}
+
 static void ndisc_send_na(struct net_device *dev, struct neighbour *neigh,
 		   struct in6_addr *daddr, struct in6_addr *solicited_addr,
 		   int router, int solicited, int override, int inc_opt) 
 {
+	struct flowi fl;
+	struct rt6_info *rt = NULL;
+	struct dst_entry* dst;
         struct sock *sk = ndisc_socket->sk;
         struct nd_msg *msg;
         int len;
@@ -386,6 +425,22 @@
 
 	len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);
 
+	rt = ndisc_get_dummy_rt();
+	if (!rt) 
+		return;
+
+	ndisc_flow_init(&fl, NDISC_NEIGHBOUR_ADVERTISEMENT, solicited_addr, daddr);
+	ndisc_rt_init(rt, dev, neigh);	
+
+	dst = (struct dst_entry*)rt;
+	dst_clone(dst);
+
+	err = xfrm_lookup(&dst, &fl, NULL, 0);
+	if (err < 0) {
+		dst_release(dst);
+		return;
+	}
+
 	if (inc_opt) {
 		if (dev->addr_len)
 			len += NDISC_OPT_SPACE(dev->addr_len);
@@ -401,14 +456,10 @@
 		return;
 	}
 
-	if (ndisc_build_ll_hdr(skb, dev, daddr, neigh, len) == 0) {
-		kfree_skb(skb);
-		return;
-	}
-
+	skb_reserve(skb, (dev->hard_header_len + 15) & ~15);
 	ip6_nd_hdr(sk, skb, dev, solicited_addr, daddr, IPPROTO_ICMPV6, len);
 
-	msg = (struct nd_msg *) skb_put(skb, len);
+	skb->h.raw = (unsigned char*) msg = (struct nd_msg *) skb_put(skb, len);
 
         msg->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
         msg->icmph.icmp6_code = 0;
@@ -431,7 +482,9 @@
 						 csum_partial((__u8 *) msg, 
 							      len, 0));
 
-	dev_queue_xmit(skb);
+	dst_clone(dst);
+	skb->dst = dst;
+	dst_output(skb);
 
 	ICMP6_INC_STATS(Icmp6OutNeighborAdvertisements);
 	ICMP6_INC_STATS(Icmp6OutMsgs);
@@ -441,6 +494,9 @@
 		   struct in6_addr *solicit,
 		   struct in6_addr *daddr, struct in6_addr *saddr) 
 {
+	struct flowi fl;
+	struct rt6_info *rt = NULL;
+	struct dst_entry* dst;
         struct sock *sk = ndisc_socket->sk;
         struct sk_buff *skb;
         struct nd_msg *msg;
@@ -455,6 +511,22 @@
 		saddr = &addr_buf;
 	}
 
+	rt = ndisc_get_dummy_rt();
+	if (!rt) 
+		return;
+
+	ndisc_flow_init(&fl, NDISC_NEIGHBOUR_SOLICITATION, saddr, daddr);
+	ndisc_rt_init(rt, dev, neigh);	
+
+	dst = (struct dst_entry*)rt;
+	dst_clone(dst);
+
+	err = xfrm_lookup(&dst, &fl, NULL, 0);
+	if (err < 0) {
+		dst_release(dst);
+		return;
+	}
+
 	len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);
 	send_llinfo = dev->addr_len && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
 	if (send_llinfo)
@@ -467,14 +539,10 @@
 		return;
 	}
 
-	if (ndisc_build_ll_hdr(skb, dev, daddr, neigh, len) == 0) {
-		kfree_skb(skb);
-		return;
-	}
-
+	skb_reserve(skb, (dev->hard_header_len + 15) & ~15);
 	ip6_nd_hdr(sk, skb, dev, saddr, daddr, IPPROTO_ICMPV6, len);
 
-	msg = (struct nd_msg *)skb_put(skb, len);
+	skb->h.raw = (unsigned char*) msg = (struct nd_msg *)skb_put(skb, len);
 	msg->icmph.icmp6_type = NDISC_NEIGHBOUR_SOLICITATION;
 	msg->icmph.icmp6_code = 0;
 	msg->icmph.icmp6_cksum = 0;
@@ -493,7 +561,9 @@
 						 csum_partial((__u8 *) msg, 
 							      len, 0));
 	/* send it! */
-	dev_queue_xmit(skb);
+	dst_clone(dst);
+	skb->dst = dst;
+	dst_output(skb);
 
 	ICMP6_INC_STATS(Icmp6OutNeighborSolicits);
 	ICMP6_INC_STATS(Icmp6OutMsgs);
@@ -502,6 +572,9 @@
 void ndisc_send_rs(struct net_device *dev, struct in6_addr *saddr,
 		   struct in6_addr *daddr)
 {
+	struct flowi fl;
+	struct rt6_info *rt = NULL;
+	struct dst_entry* dst;
 	struct sock *sk = ndisc_socket->sk;
         struct sk_buff *skb;
         struct icmp6hdr *hdr;
@@ -509,6 +582,22 @@
         int len;
 	int err;
 
+	rt = ndisc_get_dummy_rt();
+	if (!rt) 
+		return;
+
+	ndisc_flow_init(&fl, NDISC_ROUTER_SOLICITATION, saddr, daddr);
+	ndisc_rt_init(rt, dev, NULL);
+
+	dst = (struct dst_entry*)rt;
+	dst_clone(dst);
+
+	err = xfrm_lookup(&dst, &fl, NULL, 0);
+	if (err < 0) {
+		dst_release(dst);
+		return;
+	}
+
 	len = sizeof(struct icmp6hdr);
 	if (dev->addr_len)
 		len += NDISC_OPT_SPACE(dev->addr_len);
@@ -520,14 +609,10 @@
 		return;
 	}
 
-	if (ndisc_build_ll_hdr(skb, dev, daddr, NULL, len) == 0) {
-		kfree_skb(skb);
-		return;
-	}
-
+	skb_reserve(skb, (dev->hard_header_len + 15) & ~15);
 	ip6_nd_hdr(sk, skb, dev, saddr, daddr, IPPROTO_ICMPV6, len);
 
-        hdr = (struct icmp6hdr *) skb_put(skb, len);
+        skb->h.raw = (unsigned char*) hdr = (struct icmp6hdr *) skb_put(skb, len);
         hdr->icmp6_type = NDISC_ROUTER_SOLICITATION;
         hdr->icmp6_code = 0;
         hdr->icmp6_cksum = 0;
@@ -544,7 +629,9 @@
 					   csum_partial((__u8 *) hdr, len, 0));
 
 	/* send it! */
-	dev_queue_xmit(skb);
+	dst_clone(dst);
+	skb->dst = dst;
+	dst_output(skb);
 
 	ICMP6_INC_STATS(Icmp6OutRouterSolicits);
 	ICMP6_INC_STATS(Icmp6OutMsgs);
@@ -1126,6 +1213,8 @@
 	struct in6_addr *addrp;
 	struct net_device *dev;
 	struct rt6_info *rt;
+	struct dst_entry *dst;
+	struct flowi fl;
 	u8 *opt;
 	int rd_len;
 	int err;
@@ -1137,6 +1226,22 @@
 	if (rt == NULL)
 		return;
 
+	dst = (struct dst_entry*)rt;
+
+	if (ipv6_get_lladdr(dev, &saddr_buf)) {
+ 		ND_PRINTK1("redirect: no link_local addr for dev\n");
+ 		return;
+ 	}
+
+	ndisc_flow_init(&fl, NDISC_REDIRECT, &saddr_buf, &skb->nh.ipv6h->saddr);
+
+	dst_clone(dst);
+	err = xfrm_lookup(&dst, &fl, NULL, 0);
+	if (err) {
+		dst_release(dst);
+		return;
+	}
+
 	if (rt->rt6i_flags & RTF_GATEWAY) {
 		ND_PRINTK1("ndisc_send_redirect: not a neighbour\n");
 		dst_release(&rt->u.dst);
@@ -1165,11 +1270,6 @@
 	rd_len &= ~0x7;
 	len += rd_len;
 
-	if (ipv6_get_lladdr(dev, &saddr_buf)) {
- 		ND_PRINTK1("redirect: no link_local addr for dev\n");
- 		return;
- 	}
-
 	buff = sock_alloc_send_skb(sk, MAX_HEADER + len + dev->hard_header_len + 15,
 				   0, &err);
 	if (buff == NULL) {
@@ -1179,15 +1279,11 @@
 
 	hlen = 0;
 
-	if (ndisc_build_ll_hdr(buff, dev, &skb->nh.ipv6h->saddr, NULL, len) == 0) {
-		kfree_skb(buff);
-		return;
-	}
-
+	skb_reserve(skb, (dev->hard_header_len + 15) & ~15);
 	ip6_nd_hdr(sk, buff, dev, &saddr_buf, &skb->nh.ipv6h->saddr,
 		   IPPROTO_ICMPV6, len);
 
-	icmph = (struct icmp6hdr *) skb_put(buff, len);
+	skb->h.raw = (unsigned char*) icmph = (struct icmp6hdr *) skb_put(buff, len);
 
 	memset(icmph, 0, sizeof(struct icmp6hdr));
 	icmph->icmp6_type = NDISC_REDIRECT;
@@ -1225,7 +1321,8 @@
 					     len, IPPROTO_ICMPV6,
 					     csum_partial((u8 *) icmph, len, 0));
 
-	dev_queue_xmit(buff);
+	skb->dst = dst;
+	dst_output(skb);
 
 	ICMP6_INC_STATS(Icmp6OutRedirects);
 	ICMP6_INC_STATS(Icmp6OutMsgs);
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/raw.c linux25/net/ipv6/raw.c
--- linux-2.5.62+cs1.1002/net/ipv6/raw.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/raw.c	2003-02-23 13:25:00.000000000 +0900
@@ -45,6 +45,7 @@
 #include <net/inet_common.h>
 
 #include <net/rawv6.h>
+#include <net/xfrm.h>
 
 struct sock *raw_v6_htable[RAWV6_HTABLE_SIZE];
 rwlock_t raw_v6_lock = RW_LOCK_UNLOCKED;
@@ -304,6 +305,11 @@
 	struct inet_opt *inet = inet_sk(sk);
 	struct raw6_opt *raw_opt = raw6_sk(sk);
 
+        if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
+                kfree_skb(skb);
+                return NET_RX_DROP;
+        }
+
 	if (!raw_opt->checksum)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/route.c linux25/net/ipv6/route.c
--- linux-2.5.62+cs1.1002/net/ipv6/route.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/route.c	2003-02-23 13:25:00.000000000 +0900
@@ -49,6 +49,7 @@
 #include <net/addrconf.h>
 #include <net/tcp.h>
 #include <linux/rtnetlink.h>
+#include <net/dst.h>
 
 #include <asm/uaccess.h>
 
@@ -128,6 +129,12 @@
 rwlock_t rt6_lock = RW_LOCK_UNLOCKED;
 
 
+/*	Dummy rt for ndisc */
+struct rt6_info *ndisc_get_dummy_rt()
+{
+	return dst_alloc(&ip6_dst_ops);
+}
+
 /*
  *	Route lookup. Any rt6_lock is implied.
  */
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/tcp_ipv6.c linux25/net/ipv6/tcp_ipv6.c
--- linux-2.5.62+cs1.1002/net/ipv6/tcp_ipv6.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/tcp_ipv6.c	2003-02-23 13:25:00.000000000 +0900
@@ -51,6 +51,7 @@
 #include <net/ip6_route.h>
 #include <net/inet_ecn.h>
 #include <net/protocol.h>
+#include <net/xfrm.h>
 
 #include <asm/uaccess.h>
 
@@ -678,6 +679,9 @@
 		fl.nl_u.ip6_u.daddr = rt0->addr;
 	}
 
+	if (!fl.fl6_src)
+		fl.fl6_src = &np->saddr;
+
 	dst = ip6_route_output(sk, &fl);
 
 	if ((err = dst->error) != 0) {
@@ -1638,6 +1642,9 @@
 	if (sk_filter(sk, skb, 0))
 		goto discard_and_relse;
 
+	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
+		goto discard_it;
+
 	skb->dev = NULL;
 
 	bh_lock_sock(sk);
@@ -1653,6 +1660,9 @@
 	return ret;
 
 no_tcp_socket:
+	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
+		goto discard_and_relse;
+
 	if (skb->len < (th->doff<<2) || tcp_checksum_complete(skb)) {
 bad_packet:
 		TCP_INC_STATS_BH(TcpInErrs);
@@ -1672,8 +1682,11 @@
 discard_and_relse:
 	sock_put(sk);
 	goto discard_it;
-                
+
 do_time_wait:
+	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
+		goto discard_and_relse;
+
 	if (skb->len < (th->doff<<2) || tcp_checksum_complete(skb)) {
 		TCP_INC_STATS_BH(TcpInErrs);
 		sock_put(sk);
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/ipv6/udp.c linux25/net/ipv6/udp.c
--- linux-2.5.62+cs1.1002/net/ipv6/udp.c	2003-02-23 17:53:47.000000000 +0900
+++ linux25/net/ipv6/udp.c	2003-02-23 13:25:01.000000000 +0900
@@ -50,6 +50,7 @@
 #include <net/inet_common.h>
 
 #include <net/checksum.h>
+#include <net/xfrm.h>
 
 DEFINE_SNMP_STAT(struct udp_mib, udp_stats_in6);
 
@@ -541,6 +542,11 @@
 
 static inline int udpv6_queue_rcv_skb(struct sock * sk, struct sk_buff *skb)
 {
+	if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb)) {
+		kfree_skb(skb);
+		return -1;
+	}
+
 #if defined(CONFIG_FILTER)
 	if (sk->filter && skb->ip_summed != CHECKSUM_UNNECESSARY) {
 		if ((unsigned short)csum_fold(skb_checksum(skb, 0, skb->len, skb->csum))) {
@@ -646,6 +652,9 @@
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto short_packet;
 
+	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
+                goto discard;
+
 	saddr = &skb->nh.ipv6h->saddr;
 	daddr = &skb->nh.ipv6h->daddr;
 	uh = skb->h.uh;
diff -ruN -x CVS linux-2.5.62+cs1.1002/net/netsyms.c linux25/net/netsyms.c
--- linux-2.5.62+cs1.1002/net/netsyms.c	2003-02-23 17:53:50.000000000 +0900
+++ linux25/net/netsyms.c	2003-02-23 13:24:59.000000000 +0900
@@ -325,12 +325,15 @@
 EXPORT_SYMBOL(xfrm_policy_byid);
 EXPORT_SYMBOL(xfrm_policy_list);
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+EXPORT_SYMBOL(xfrm6_state_find);
+EXPORT_SYMBOL(xfrm6_rcv);
 EXPORT_SYMBOL(xfrm6_state_lookup);
 EXPORT_SYMBOL(xfrm6_find_acq);
 EXPORT_SYMBOL(xfrm6_alloc_spi);
 EXPORT_SYMBOL(xfrm6_register_type);
 EXPORT_SYMBOL(xfrm6_unregister_type);
 EXPORT_SYMBOL(xfrm6_get_type);
+EXPORT_SYMBOL(xfrm6_clear_mutable_options);
 #endif
 
 EXPORT_SYMBOL_GPL(xfrm_probe_algs);

