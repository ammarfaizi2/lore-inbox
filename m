Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbTCGAKz>; Thu, 6 Mar 2003 19:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbTCGAKy>; Thu, 6 Mar 2003 19:10:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:48581 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261301AbTCGAKo>;
	Thu, 6 Mar 2003 19:10:44 -0500
Date: Thu, 06 Mar 2003 16:03:00 -0800 (PST)
Message-Id: <20030306.160300.126216253.davem@redhat.com>
To: rusty@linux.co.intel.com
Cc: miyazawa@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: Latest bk build error in xfrm.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1046986725.4169.40.camel@vmhack>
References: <1046980043.4170.31.camel@vmhack>
	<1046986725.4169.40.camel@vmhack>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Lynch <rusty@linux.co.intel.com>
   Date: 06 Mar 2003 13:38:44 -0800

   The problem is now the core networking has a dependency on the crypto
   hmac code (CONFIG_CRYOTPO_HMAC) since the ipv4 ipsec code was added to
   include/net/xfrm.h (which is included from all kinds of places.)
   
   The pretty much exhaust my networking/ipsec knowledge so no patch.
   
I just pushed the following patch to Linus, should fix the build for
everyone.  It's also available at:

	bk://kernel.bkbits.net/davem/netfix-2.5

Thanks.

ChangeSet@1.1075.2.1, 2003-03-06 16:17:07-08:00, davem@nuts.ninka.net
  [IPSEC]: Fix build when ipsec is disabled.

diff -Nru a/include/net/ah.h b/include/net/ah.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/net/ah.h	Thu Mar  6 15:39:12 2003
@@ -0,0 +1,35 @@
+#ifndef _NET_AH_H
+#define _NET_AH_H
+
+#include <net/xfrm.h>
+
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
+extern void skb_ah_walk(const struct sk_buff *skb,
+                        struct crypto_tfm *tfm, icv_update_fn_t icv_update);
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
+#endif
diff -Nru a/include/net/esp.h b/include/net/esp.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/net/esp.h	Thu Mar  6 15:39:12 2003
@@ -0,0 +1,56 @@
+#ifndef _NET_ESP_H
+#define _NET_ESP_H
+
+#include <net/xfrm.h>
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
+extern void skb_icv_walk(const struct sk_buff *skb, struct crypto_tfm *tfm,
+			 int offset, int len, icv_update_fn_t icv_update);
+extern int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len);
+extern int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer);
+extern void *pskb_put(struct sk_buff *skb, struct sk_buff *tail, int len);
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
+#endif
diff -Nru a/include/net/xfrm.h b/include/net/xfrm.h
--- a/include/net/xfrm.h	Thu Mar  6 15:39:12 2003
+++ b/include/net/xfrm.h	Thu Mar  6 15:39:12 2003
@@ -492,85 +492,8 @@
 extern int xfrm6_unregister_type(struct xfrm_type *type);
 extern struct xfrm_type *xfrm6_get_type(u8 proto);
 
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
-
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
+struct crypto_tfm;
 typedef void (icv_update_fn_t)(struct crypto_tfm *, struct scatterlist *, unsigned int);
-extern void skb_ah_walk(const struct sk_buff *skb,
-                        struct crypto_tfm *tfm, icv_update_fn_t icv_update);
-extern void skb_icv_walk(const struct sk_buff *skb, struct crypto_tfm *tfm,
-			int offset, int len, icv_update_fn_t icv_update);
-extern int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len);
-extern int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer);
-extern void *pskb_put(struct sk_buff *skb, struct sk_buff *tail, int len);
-
-static inline void
-ah_hmac_digest(struct ah_data *ahp, struct sk_buff *skb, u8 *auth_data)
-{
-	struct crypto_tfm *tfm = ahp->tfm;
-
-	memset(auth_data, 0, ahp->icv_trunc_len);
-	crypto_hmac_init(tfm, ahp->key, &ahp->key_len);
-	skb_ah_walk(skb, tfm, crypto_hmac_update);
-	crypto_hmac_final(tfm, ahp->key, &ahp->key_len, ahp->work_icv);
-	memcpy(auth_data, ahp->work_icv, ahp->icv_trunc_len);
-}
-
-static inline void
-esp_hmac_digest(struct esp_data *esp, struct sk_buff *skb, int offset,
-                int len, u8 *auth_data)
-{
-	struct crypto_tfm *tfm = esp->auth.tfm;
-	char *icv = esp->auth.work_icv;
-
-	memset(auth_data, 0, esp->auth.icv_trunc_len);
-	crypto_hmac_init(tfm, esp->auth.key, &esp->auth.key_len);
-	skb_icv_walk(skb, tfm, offset, len, crypto_hmac_update);
-	crypto_hmac_final(tfm, esp->auth.key, &esp->auth.key_len, icv);
-	memcpy(auth_data, icv, esp->auth.icv_trunc_len);
-}
-
 
 typedef int (xfrm_dst_lookup_t)(struct xfrm_dst **dst, struct flowi *fl);
 int xfrm_dst_lookup_register(xfrm_dst_lookup_t *dst_lookup, unsigned short family);
diff -Nru a/net/ipv4/ah.c b/net/ipv4/ah.c
--- a/net/ipv4/ah.c	Thu Mar  6 15:39:12 2003
+++ b/net/ipv4/ah.c	Thu Mar  6 15:39:12 2003
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
+#include <net/ah.h>
 #include <linux/crypto.h>
 #include <linux/pfkeyv2.h>
 #include <net/icmp.h>
diff -Nru a/net/ipv4/esp.c b/net/ipv4/esp.c
--- a/net/ipv4/esp.c	Thu Mar  6 15:39:12 2003
+++ b/net/ipv4/esp.c	Thu Mar  6 15:39:12 2003
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
+#include <net/esp.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
 #include <linux/pfkeyv2.h>
diff -Nru a/net/ipv4/xfrm_algo.c b/net/ipv4/xfrm_algo.c
--- a/net/ipv4/xfrm_algo.c	Thu Mar  6 15:39:12 2003
+++ b/net/ipv4/xfrm_algo.c	Thu Mar  6 15:39:12 2003
@@ -12,6 +12,12 @@
 #include <linux/kernel.h>
 #include <linux/pfkeyv2.h>
 #include <net/xfrm.h>
+#if defined(CONFIG_INET_AH) || defined(CONFIG_INET_AH_MODULE) || defined(CONFIG_INET6_AH) || defined(CONFIG_INET6_AH_MODULE)
+#include <net/ah.h>
+#endif
+#if defined(CONFIG_INET_ESP) || defined(CONFIG_INET_ESP_MODULE) || defined(CONFIG_INET6_ESP) || defined(CONFIG_INET6_ESP_MODULE)
+#include <net/esp.h>
+#endif
 #include <asm/scatterlist.h>
 
 /*
diff -Nru a/net/ipv6/ah6.c b/net/ipv6/ah6.c
--- a/net/ipv6/ah6.c	Thu Mar  6 15:39:12 2003
+++ b/net/ipv6/ah6.c	Thu Mar  6 15:39:12 2003
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
+#include <net/ah.h>
 #include <linux/crypto.h>
 #include <linux/pfkeyv2.h>
 #include <net/icmp.h>
diff -Nru a/net/ipv6/esp6.c b/net/ipv6/esp6.c
--- a/net/ipv6/esp6.c	Thu Mar  6 15:39:12 2003
+++ b/net/ipv6/esp6.c	Thu Mar  6 15:39:12 2003
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
+#include <net/esp.h>
 #include <asm/scatterlist.h>
 #include <linux/crypto.h>
 #include <linux/pfkeyv2.h>
diff -Nru a/net/netsyms.c b/net/netsyms.c
--- a/net/netsyms.c	Thu Mar  6 15:39:12 2003
+++ b/net/netsyms.c	Thu Mar  6 15:39:12 2003
@@ -54,6 +54,12 @@
 #include <linux/mroute.h>
 #include <linux/igmp.h>
 #include <net/xfrm.h>
+#if defined(CONFIG_INET_AH) || defined(CONFIG_INET_AH_MODULE) || defined(CONFIG_INET6_AH) || defined(CONFIG_INET6_AH_MODULE)
+#include <net/ah.h>
+#endif
+#if defined(CONFIG_INET_ESP) || defined(CONFIG_INET_ESP_MODULE) || defined(CONFIG_INET6_ESP) || defined(CONFIG_INET6_ESP_MODULE)
+#include <net/esp.h>
+#endif
 
 extern struct net_proto_family inet_family_ops;
 


