Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTDNSQu (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTDNSQd (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:16:33 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:32779 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S263655AbTDNSJG (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:09:06 -0400
Date: Tue, 15 Apr 2003 03:21:09 +0900 (JST)
Message-Id: <20030415.032109.127483264.yoshfuji@linux-ipv6.org>
To: davem@redhat.com, kuznet@ms2.inr.ac.ru
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, usagi@linux-ipv6.org
Subject: [PATCH] [IPV6] Fixed multiple mistake extension header handling
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

ChangeSet 1.977.5.12: "[IPV6] Process all extension headers via 
ipproto->handler" broke IPv6 extension header handling.

 - double free if sending Parameter Problem message in reassembly code.
 - (sometimes) broken checksum
 - HbH not producing unknown header; it is only allowed at the beginning of
   the exthdrs chain.
 - wrong pointer value in Parameter Problem message.

I've fixed the problem.

Patch is against 2.5.67 + CS 1.1202.

Thank you.

Index: include/net/protocol.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/net/protocol.h,v
retrieving revision 1.1.1.5
retrieving revision 1.1.1.5.10.1
diff -u -r1.1.1.5 -r1.1.1.5.10.1
--- include/net/protocol.h	2 Apr 2003 04:14:22 -0000	1.1.1.5
+++ include/net/protocol.h	14 Apr 2003 17:24:49 -0000	1.1.1.5.10.1
@@ -44,15 +44,17 @@
 #if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
 struct inet6_protocol 
 {
-	int	(*handler)(struct sk_buff **skbp);
+	int	(*handler)(struct sk_buff **skb, unsigned int *nhoffp);
 
 	void	(*err_handler)(struct sk_buff *skb,
 			       struct inet6_skb_parm *opt,
 			       int type, int code, int offset,
 			       __u32 info);
-	int	no_policy;
+	unsigned int	flags;	/* INET6_PROTO_xxx */
 };
 
+#define INET6_PROTO_NOPOLICY	0x1
+#define INET6_PROTO_FINAL	0x2
 #endif
 
 /* This is used to register socket interfaces for IP protocols.  */
Index: include/net/xfrm.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/net/xfrm.h,v
retrieving revision 1.1.1.14
retrieving revision 1.1.1.14.4.1
diff -u -r1.1.1.14 -r1.1.1.14.4.1
--- include/net/xfrm.h	14 Apr 2003 04:33:59 -0000	1.1.1.14
+++ include/net/xfrm.h	14 Apr 2003 17:24:49 -0000	1.1.1.14.4.1
@@ -760,7 +760,7 @@
 extern int xfrm4_rcv_encap(struct sk_buff *skb, __u16 encap_type);
 extern int xfrm4_tunnel_register(struct xfrm_tunnel *handler);
 extern int xfrm4_tunnel_deregister(struct xfrm_tunnel *handler);
-extern int xfrm6_rcv(struct sk_buff **pskb);
+extern int xfrm6_rcv(struct sk_buff **pskb, unsigned int *nhoffp);
 extern int xfrm6_clear_mutable_options(struct sk_buff *skb, u16 *nh_offset, int dir);
 extern int xfrm_user_policy(struct sock *sk, int optname, u8 *optval, int optlen);
 
Index: net/ipv6/af_inet6.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/af_inet6.c,v
retrieving revision 1.1.1.12
retrieving revision 1.1.1.12.4.1
diff -u -r1.1.1.12 -r1.1.1.12.4.1
--- net/ipv6/af_inet6.c	14 Apr 2003 04:34:17 -0000	1.1.1.12
+++ net/ipv6/af_inet6.c	14 Apr 2003 17:24:49 -0000	1.1.1.12.4.1
@@ -805,7 +805,6 @@
 	sit_init();
 
 	/* Init v6 extension headers. */
-	ipv6_hopopts_init();
 	ipv6_rthdr_init();
 	ipv6_frag_init();
 	ipv6_nodata_init();
Index: net/ipv6/ah6.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/ah6.c,v
retrieving revision 1.1.1.7
retrieving revision 1.1.1.7.4.1
diff -u -r1.1.1.7 -r1.1.1.7.4.1
--- net/ipv6/ah6.c	14 Apr 2003 04:34:17 -0000	1.1.1.7
+++ net/ipv6/ah6.c	14 Apr 2003 17:24:49 -0000	1.1.1.7.4.1
@@ -330,7 +330,7 @@
 static struct inet6_protocol ah6_protocol = {
 	.handler	=	xfrm6_rcv,
 	.err_handler	=	ah6_err,
-	.no_policy	=	1,
+	.flags		=	INET6_PROTO_NOPOLICY,
 };
 
 int __init ah6_init(void)
Index: net/ipv6/esp6.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/esp6.c,v
retrieving revision 1.1.1.7
retrieving revision 1.1.1.7.4.1
diff -u -r1.1.1.7 -r1.1.1.7.4.1
--- net/ipv6/esp6.c	14 Apr 2003 04:34:17 -0000	1.1.1.7
+++ net/ipv6/esp6.c	14 Apr 2003 17:24:49 -0000	1.1.1.7.4.1
@@ -501,7 +501,7 @@
 static struct inet6_protocol esp6_protocol = {
 	.handler 	=	xfrm6_rcv,
 	.err_handler	=	esp6_err,
-	.no_policy	=	1,
+	.flags		=	INET6_PROTO_NOPOLICY,
 };
 
 int __init esp6_init(void)
Index: net/ipv6/exthdrs.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/exthdrs.c,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.12.2
diff -u -r1.1.1.4 -r1.1.1.4.12.2
--- net/ipv6/exthdrs.c	25 Mar 2003 04:33:45 -0000	1.1.1.4
+++ net/ipv6/exthdrs.c	14 Apr 2003 17:26:57 -0000	1.1.1.4.12.2
@@ -18,9 +18,9 @@
 /* Changes:
  *	yoshfuji		: ensure not to overrun while parsing 
  *				  tlv options.
- *	Mitsuru KANDA @USAGI	: Remove ipv6_parse_exthdrs().
- *				: Register inbound extention header
- *				: handlers as inet6_protocol{}.
+ *	Mitsuru KANDA @USAGI and: Remove ipv6_parse_exthdrs().
+ *	YOSHIFUJI Hideaki @USAGI  Register inbound extention header
+ *				  handlers as inet6_protocol{}.
  */
 
 #include <linux/errno.h>
@@ -153,38 +153,37 @@
 	{-1,			NULL}
 };
 
-static int ipv6_destopt_rcv(struct sk_buff **skbp) 
+static int ipv6_destopt_rcv(struct sk_buff **skbp, unsigned int *nhoffp)
 {
 	struct sk_buff *skb = *skbp;
 	struct inet6_skb_parm *opt = (struct inet6_skb_parm *)skb->cb;
-	u8 nexthdr = 0;
 
 	if (!pskb_may_pull(skb, (skb->h.raw-skb->data)+8) ||
 	    !pskb_may_pull(skb, (skb->h.raw-skb->data)+((skb->h.raw[1]+1)<<3))) {
 		kfree_skb(skb);
-		return 0;
+		return -1;
 	}
 
-	nexthdr = ((struct ipv6_destopt_hdr *)skb->h.raw)->nexthdr;
-	
 	opt->dst1 = skb->h.raw - skb->nh.raw;
 
 	if (ip6_parse_tlv(tlvprocdestopt_lst, skb)) {
 		skb->h.raw += ((skb->h.raw[1]+1)<<3);
-		return -nexthdr;
+		*nhoffp = opt->dst1;
+		return 1;
 	}
-						
-	return 0;
+
+	return -1;
 }
 
 static struct inet6_protocol destopt_protocol =
 {
-	.handler 	= 	ipv6_destopt_rcv,
+	.handler	=	ipv6_destopt_rcv,
+	.flags		=	INET6_PROTO_NOPOLICY,
 };
 
 void __init ipv6_destopt_init(void)
 {
-	if (inet6_add_protocol(&destopt_protocol, IPPROTO_DSTOPTS) < 0) 
+	if (inet6_add_protocol(&destopt_protocol, IPPROTO_DSTOPTS) < 0)
 		printk(KERN_ERR "ipv6_destopt_init: Could not register protocol\n");
 }
 
@@ -192,7 +191,7 @@
   NONE header. No data in packet.
  ********************************/
 
-static int ipv6_nodata_rcv(struct sk_buff **skbp)
+static int ipv6_nodata_rcv(struct sk_buff **skbp, unsigned int *nhoffp)
 {
 	struct sk_buff *skb = *skbp;
 
@@ -203,6 +202,7 @@
 static struct inet6_protocol nodata_protocol =
 {
 	.handler	=	ipv6_nodata_rcv,
+	.flags		=	INET6_PROTO_NOPOLICY,
 };
 
 void __init ipv6_nodata_init(void)
@@ -215,7 +215,7 @@
   Routing header.
  ********************************/
 
-static int ipv6_rthdr_rcv(struct sk_buff **skbp)
+static int ipv6_rthdr_rcv(struct sk_buff **skbp, unsigned int *nhoffp)
 {
 	struct sk_buff *skb = *skbp;
 	struct inet6_skb_parm *opt = (struct inet6_skb_parm *)skb->cb;
@@ -223,7 +223,6 @@
 	struct in6_addr daddr;
 	int addr_type;
 	int n, i;
-	u8 nexthdr = 0;
 
 	struct ipv6_rt_hdr *hdr;
 	struct rt0_hdr *rthdr;
@@ -232,16 +231,15 @@
 	    !pskb_may_pull(skb, (skb->h.raw-skb->data)+((skb->h.raw[1]+1)<<3))) {
 		IP6_INC_STATS_BH(Ip6InHdrErrors);
 		kfree_skb(skb);
-		return 0;
+		return -1;
 	}
 
 	hdr = (struct ipv6_rt_hdr *) skb->h.raw;
-	nexthdr = hdr->nexthdr;
 
 	if ((ipv6_addr_type(&skb->nh.ipv6h->daddr)&IPV6_ADDR_MULTICAST) ||
 	    skb->pkt_type != PACKET_HOST) {
 		kfree_skb(skb);
-		return 0;
+		return -1;
 	}
 
 looped_back:
@@ -250,12 +248,13 @@
 		skb->h.raw += (hdr->hdrlen + 1) << 3;
 		opt->dst0 = opt->dst1;
 		opt->dst1 = 0;
-		return -nexthdr;
+		*nhoffp = (&hdr->nexthdr) - skb->nh.raw;
+		return 1;
 	}
 
 	if (hdr->type != IPV6_SRCRT_TYPE_0 || (hdr->hdrlen & 0x01)) {
 		icmpv6_param_prob(skb, ICMPV6_HDR_FIELD, hdr->type != IPV6_SRCRT_TYPE_0 ? 2 : 1);
-		return 0;
+		return -1;
 	}
 
 	/*
@@ -267,7 +266,7 @@
 
 	if (hdr->segments_left > n) {
 		icmpv6_param_prob(skb, ICMPV6_HDR_FIELD, (&hdr->segments_left) - skb->nh.raw);
-		return 0;
+		return -1;
 	}
 
 	/* We are about to mangle packet header. Be careful!
@@ -277,7 +276,7 @@
 		struct sk_buff *skb2 = skb_copy(skb, GFP_ATOMIC);
 		kfree_skb(skb);
 		if (skb2 == NULL)
-			return 0;
+			return -1;
 		*skbp = skb = skb2;
 		opt = (struct inet6_skb_parm *)skb2->cb;
 		hdr = (struct ipv6_rt_hdr *) skb2->h.raw;
@@ -296,7 +295,7 @@
 
 	if (addr_type&IPV6_ADDR_MULTICAST) {
 		kfree_skb(skb);
-		return 0;
+		return -1;
 	}
 
 	ipv6_addr_copy(&daddr, addr);
@@ -307,26 +306,27 @@
 	ip6_route_input(skb);
 	if (skb->dst->error) {
 		dst_input(skb);
-		return 0;
+		return -1;
 	}
 	if (skb->dst->dev->flags&IFF_LOOPBACK) {
 		if (skb->nh.ipv6h->hop_limit <= 1) {
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED, ICMPV6_EXC_HOPLIMIT,
 				    0, skb->dev);
 			kfree_skb(skb);
-			return 0;
+			return -1;
 		}
 		skb->nh.ipv6h->hop_limit--;
 		goto looped_back;
 	}
 
 	dst_input(skb);
-	return 0;
+	return -1;
 }
 
 static struct inet6_protocol rthdr_protocol =
 {
 	.handler	=	ipv6_rthdr_rcv,
+	.flags		=	INET6_PROTO_NOPOLICY,
 };
 
 void __init ipv6_rthdr_init(void)
@@ -468,34 +468,6 @@
 	if (ip6_parse_tlv(tlvprochopopt_lst, skb))
 		return sizeof(struct ipv6hdr);
 	return -1;
-}
-
-/* This is fake. We have already parsed hopopts in ipv6_rcv(). -mk */
-static int ipv6_hopopts_rcv(struct sk_buff **skbp)
-{
-	struct sk_buff *skb = *skbp;
-	u8 nexthdr = 0;
-
-	if (!pskb_may_pull(skb, (skb->h.raw-skb->data)+8) ||
-	    !pskb_may_pull(skb, (skb->h.raw-skb->data)+((skb->h.raw[1]+1)<<3))) {
-		kfree_skb(skb);
-		return 0;
-	}
-	nexthdr = ((struct ipv6_hopopt_hdr *)skb->h.raw)->nexthdr;
-	skb->h.raw += (skb->h.raw[1]+1)<<3;
-
-       return -nexthdr;
-}
-
-static struct inet6_protocol hopopts_protocol =
-{
-	.handler	=	ipv6_hopopts_rcv,
-};
-
-void __init ipv6_hopopts_init(void)
-{
-	if (inet6_add_protocol(&hopopts_protocol, IPPROTO_HOPOPTS) < 0)
-		printk(KERN_ERR "ipv6_hopopts_init: Could not register protocol\n");
 }
 
 /*
Index: net/ipv6/icmp.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/icmp.c,v
retrieving revision 1.1.1.9
retrieving revision 1.1.1.9.12.1
diff -u -r1.1.1.9 -r1.1.1.9.12.1
--- net/ipv6/icmp.c	25 Mar 2003 04:33:45 -0000	1.1.1.9
+++ net/ipv6/icmp.c	14 Apr 2003 17:24:49 -0000	1.1.1.9.12.1
@@ -74,10 +74,11 @@
 static struct socket *__icmpv6_socket[NR_CPUS];
 #define icmpv6_socket	__icmpv6_socket[smp_processor_id()]
 
-static int icmpv6_rcv(struct sk_buff **pskb);
+static int icmpv6_rcv(struct sk_buff **pskb, unsigned int *nhoffp);
 
 static struct inet6_protocol icmpv6_protocol = {
 	.handler	=	icmpv6_rcv,
+	.flags		=	INET6_PROTO_FINAL,
 };
 
 struct icmpv6_msg {
@@ -459,7 +460,7 @@
  *	Handle icmp messages
  */
 
-static int icmpv6_rcv(struct sk_buff **pskb)
+static int icmpv6_rcv(struct sk_buff **pskb, unsigned int *nhoffp)
 {
 	struct sk_buff *skb = *pskb;
 	struct net_device *dev = skb->dev;
Index: net/ipv6/ip6_input.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/ip6_input.c,v
retrieving revision 1.1.1.8
retrieving revision 1.1.1.8.10.2
diff -u -r1.1.1.8 -r1.1.1.8.10.2
--- net/ipv6/ip6_input.c	2 Apr 2003 04:16:14 -0000	1.1.1.8
+++ net/ipv6/ip6_input.c	14 Apr 2003 17:26:57 -0000	1.1.1.8.10.2
@@ -17,7 +17,8 @@
  */
 /* Changes
  *
- * 	Mitsuru KANDA @USAGI	: Remove ipv6_parse_exthdrs().
+ * 	Mitsuru KANDA @USAGI and
+ * 	YOSHIFUJI Hideaki @USAGI: Remove ipv6_parse_exthdrs().
  */
 
 #include <linux/errno.h>
@@ -128,22 +129,34 @@
 
 static inline int ip6_input_finish(struct sk_buff *skb)
 {
-	struct ipv6hdr *hdr = skb->nh.ipv6h;
 	struct inet6_protocol *ipprot;
 	struct sock *raw_sk;
-	int nexthdr = hdr->nexthdr;
+	unsigned int nhoff;
+	int nexthdr;
 	u8 hash;
+	int cksum_sub = 0;
 
 	skb->h.raw = skb->nh.raw + sizeof(struct ipv6hdr);
 
-	if (!pskb_pull(skb, skb->h.raw - skb->data))
-		goto discard;
+	/*
+	 *	Parse extension headers
+	 */
 
-	if (skb->ip_summed == CHECKSUM_HW)
-		skb->csum = csum_sub(skb->csum,
-				     csum_partial(skb->nh.raw, skb->h.raw-skb->nh.raw, 0));
+	nexthdr = skb->nh.ipv6h->nexthdr;
+	nhoff = offsetof(struct ipv6hdr, nexthdr);
+
+	/* Skip  hop-by-hop options, they are already parsed. */
+	if (nexthdr == NEXTHDR_HOP) {
+		nhoff = sizeof(struct ipv6hdr);
+		nexthdr = skb->h.raw[0];
+		skb->h.raw += (skb->h.raw[1]+1)<<3;
+	}
 
 resubmit:
+	if (!pskb_pull(skb, skb->h.raw - skb->data))
+		goto discard;
+	nexthdr = skb->nh.raw[nhoff];
+
 	raw_sk = raw_v6_htable[nexthdr & (MAX_INET_PROTOS - 1)];
 	if (raw_sk)
 		ipv6_raw_deliver(skb, nexthdr);
@@ -152,23 +165,29 @@
 	if ((ipprot = inet6_protos[hash]) != NULL) {
 		int ret;
 		
-		if (!ipprot->no_policy &&
+		if (ipprot->flags & INET6_PROTO_FINAL) {
+			if (!cksum_sub && skb->ip_summed == CHECKSUM_HW) {
+				skb->csum = csum_sub(skb->csum,
+						     csum_partial(skb->nh.raw, skb->h.raw-skb->nh.raw, 0));
+				cksum_sub++;
+			}
+		}
+		if (!(ipprot->flags & INET6_PROTO_NOPOLICY) &&
 		    !xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
 			kfree_skb(skb);
 			return 0;
 		}
-		ret = ipprot->handler(&skb);
-		if (ret < 0) {
-			nexthdr = -ret;
+		
+		ret = ipprot->handler(&skb, &nhoff);
+		if (ret > 0)
 			goto resubmit;
-		}
-		IP6_INC_STATS_BH(Ip6InDelivers);
+		else if (ret == 0)
+			IP6_INC_STATS_BH(Ip6InDelivers);
 	} else {
 		if (!raw_sk) {
 			if (xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
 				IP6_INC_STATS_BH(Ip6InUnknownProtos);
-				icmpv6_param_prob(skb, ICMPV6_UNK_NEXTHDR,
-						  offsetof(struct ipv6hdr, nexthdr));
+				icmpv6_param_prob(skb, ICMPV6_UNK_NEXTHDR, nhoff);
 			}
 		} else {
 			IP6_INC_STATS_BH(Ip6InDelivers);
Index: net/ipv6/reassembly.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/reassembly.c,v
retrieving revision 1.1.1.5
retrieving revision 1.1.1.5.12.1
diff -u -r1.1.1.5 -r1.1.1.5.12.1
--- net/ipv6/reassembly.c	25 Mar 2003 04:33:45 -0000	1.1.1.5
+++ net/ipv6/reassembly.c	14 Apr 2003 17:24:49 -0000	1.1.1.5.12.1
@@ -520,13 +520,13 @@
  *	the last and the first frames arrived and all the bits are here.
  */
 static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff **skb_in,
+			  unsigned int *nhoffp,
 			  struct net_device *dev)
 {
 	struct sk_buff *fp, *head = fq->fragments;
 	int    remove_fraghdr = 0;
 	int    payload_len;
-	int    nhoff;
-	u8     nexthdr = 0;
+	unsigned int nhoff;
 
 	fq_kill(fq);
 
@@ -537,8 +537,6 @@
 	payload_len = (head->data - head->nh.raw) - sizeof(struct ipv6hdr) + fq->len;
 	nhoff = head->h.raw - head->nh.raw;
 
-	nexthdr = ((struct frag_hdr*)head->h.raw)->nexthdr;
-
 	if (payload_len > 65535) {
 		payload_len -= 8;
 		if (payload_len > 65535)
@@ -613,12 +611,10 @@
 	if (head->ip_summed == CHECKSUM_HW)
 		head->csum = csum_partial(head->nh.raw, head->h.raw-head->nh.raw, head->csum);
 
-	if (!pskb_pull(head, head->h.raw - head->data))
-		goto out_fail;
-
 	IP6_INC_STATS_BH(Ip6ReasmOKs);
 	fq->fragments = NULL;
-	return nexthdr;
+	*nhoffp = nhoff;
+	return 1;
 
 out_oversize:
 	if (net_ratelimit())
@@ -629,18 +625,16 @@
 		printk(KERN_DEBUG "ip6_frag_reasm: no memory for reassembly\n");
 out_fail:
 	IP6_INC_STATS_BH(Ip6ReasmFails);
-	return 0;
+	return -1;
 }
 
-static int ipv6_frag_rcv(struct sk_buff **skbp)
+static int ipv6_frag_rcv(struct sk_buff **skbp, unsigned int *nhoffp)
 {
 	struct sk_buff *skb = *skbp; 
 	struct net_device *dev = skb->dev;
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
 	struct ipv6hdr *hdr;
-	int nhoff = skb->h.raw - skb->nh.raw;
-	u8 nexthdr = 0;
 
 	hdr = skb->nh.ipv6h;
 
@@ -649,23 +643,23 @@
 	/* Jumbo payload inhibits frag. header */
 	if (hdr->payload_len==0) {
 		icmpv6_param_prob(skb, ICMPV6_HDR_FIELD, skb->h.raw-skb->nh.raw);
-		goto discard;
+		return -1;
 	}
 	if (!pskb_may_pull(skb, (skb->h.raw-skb->data)+sizeof(struct frag_hdr))) {
 		icmpv6_param_prob(skb, ICMPV6_HDR_FIELD, skb->h.raw-skb->nh.raw);
-		goto discard;
+		return -1;
 	}
 
 	hdr = skb->nh.ipv6h;
 	fhdr = (struct frag_hdr *)skb->h.raw;
-	nexthdr = fhdr->nexthdr;
 
 	if (!(fhdr->frag_off & htons(0xFFF9))) {
 		/* It is not a fragmented frame */
 		skb->h.raw += sizeof(struct frag_hdr);
 		IP6_INC_STATS_BH(Ip6ReasmOKs);
 
-		return (u8*)fhdr - skb->nh.raw;
+		*nhoffp = (u8*)fhdr - skb->nh.raw;
+		return 1;
 	}
 
 	if (atomic_read(&ip6_frag_mem) > sysctl_ip6frag_high_thresh)
@@ -676,26 +670,26 @@
 
 		spin_lock(&fq->lock);
 
-		ip6_frag_queue(fq, skb, fhdr, nhoff);
+		ip6_frag_queue(fq, skb, fhdr, *nhoffp);
 
 		if (fq->last_in == (FIRST_IN|LAST_IN) &&
 		    fq->meat == fq->len)
-			ret = ip6_frag_reasm(fq, skbp, dev);
+			ret = ip6_frag_reasm(fq, skbp, nhoffp, dev);
 
 		spin_unlock(&fq->lock);
 		fq_put(fq);
-		return -ret;
+		return ret;
 	}
 
-discard:
 	IP6_INC_STATS_BH(Ip6ReasmFails);
 	kfree_skb(skb);
-	return 0;
+	return -1;
 }
 
 static struct inet6_protocol frag_protocol =
 {
 	.handler	=	ipv6_frag_rcv,
+	.flags		=	INET6_PROTO_NOPOLICY,
 };
 
 void __init ipv6_frag_init(void)
Index: net/ipv6/tcp_ipv6.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/tcp_ipv6.c,v
retrieving revision 1.1.1.12
retrieving revision 1.1.1.12.8.1
diff -u -r1.1.1.12 -r1.1.1.12.8.1
--- net/ipv6/tcp_ipv6.c	8 Apr 2003 08:57:58 -0000	1.1.1.12
+++ net/ipv6/tcp_ipv6.c	14 Apr 2003 17:24:49 -0000	1.1.1.12.8.1
@@ -1591,7 +1591,7 @@
 	return 0;
 }
 
-static int tcp_v6_rcv(struct sk_buff **pskb)
+static int tcp_v6_rcv(struct sk_buff **pskb, unsigned int *nhoffp)
 {
 	struct sk_buff *skb = *pskb;
 	struct tcphdr *th;	
@@ -1657,7 +1657,7 @@
 	bh_unlock_sock(sk);
 
 	sock_put(sk);
-	return ret;
+	return ret ? -1 : 0;
 
 no_tcp_socket:
 	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
@@ -2193,7 +2193,7 @@
 static struct inet6_protocol tcpv6_protocol = {
 	.handler	=	tcp_v6_rcv,
 	.err_handler	=	tcp_v6_err,
-	.no_policy	=	1,
+	.flags		=	INET6_PROTO_NOPOLICY|INET6_PROTO_FINAL,
 };
 
 extern struct proto_ops inet6_stream_ops;
Index: net/ipv6/udp.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/udp.c,v
retrieving revision 1.1.1.9
retrieving revision 1.1.1.9.10.1
diff -u -r1.1.1.9 -r1.1.1.9.10.1
--- net/ipv6/udp.c	2 Apr 2003 04:16:14 -0000	1.1.1.9
+++ net/ipv6/udp.c	14 Apr 2003 17:24:49 -0000	1.1.1.9.10.1
@@ -640,7 +640,7 @@
 	read_unlock(&udp_hash_lock);
 }
 
-static int udpv6_rcv(struct sk_buff **pskb)
+static int udpv6_rcv(struct sk_buff **pskb, unsigned int *nhoffp)
 {
 	struct sk_buff *skb = *pskb;
 	struct sock *sk;
@@ -954,7 +954,7 @@
 static struct inet6_protocol udpv6_protocol = {
 	.handler	=	udpv6_rcv,
 	.err_handler	=	udpv6_err,
-	.no_policy	=	1,
+	.flags		=	INET6_PROTO_NOPOLICY|INET6_PROTO_FINAL,
 };
 
 #define LINE_LEN 190
Index: net/ipv6/xfrm6_input.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/xfrm6_input.c,v
retrieving revision 1.1.1.5
retrieving revision 1.1.1.5.4.1
diff -u -r1.1.1.5 -r1.1.1.5.4.1
--- net/ipv6/xfrm6_input.c	14 Apr 2003 04:34:17 -0000	1.1.1.5
+++ net/ipv6/xfrm6_input.c	14 Apr 2003 17:24:49 -0000	1.1.1.5.4.1
@@ -123,7 +123,7 @@
 	return nexthdr;
 }
 
-int xfrm6_rcv(struct sk_buff **pskb)
+int xfrm6_rcv(struct sk_buff **pskb, unsigned int *nhoffp)
 {
 	struct sk_buff *skb = *pskb;
 	int err;
@@ -233,6 +233,7 @@
 
 	memcpy(skb->sp->x+skb->sp->len, xfrm_vec, xfrm_nr*sizeof(struct sec_decap_state));
 	skb->sp->len += xfrm_nr;
+	skb->ip_summed = CHECKSUM_NONE;
 
 	if (decaps) {
 		if (!(skb->dev->flags&IFF_LOOPBACK)) {
@@ -240,9 +241,10 @@
 			skb->dst = NULL;
 		}
 		netif_rx(skb);
-		return 0;
+		return -1;
 	} else {
-		return -nexthdr;
+		*nhoffp = nh_offset;
+		return 1;
 	}
 
 drop_unlock:
@@ -253,7 +255,7 @@
 	while (--xfrm_nr >= 0)
 		xfrm_state_put(xfrm_vec[xfrm_nr].xvec);
 	kfree_skb(skb);
-	return 0;
+	return -1;
 }
 
 void __init xfrm6_input_init(void)

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
