Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261536AbSIYE1W>; Wed, 25 Sep 2002 00:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSIYE1W>; Wed, 25 Sep 2002 00:27:22 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:18442 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261536AbSIYE1P>; Wed, 25 Sep 2002 00:27:15 -0400
Date: Wed, 25 Sep 2002 13:30:31 +0900 (JST)
Message-Id: <20020925.133031.538200492.yoshfuji@linux-ipv6.org>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Don't Process ND Messages with Invalid Options
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

My name is YOSHIFUJI Hideaki.  I'm from USAGI Project.
Our project is trying to improve IPv6 implementation in Linux, 
and we'd like to continue contributing our efforts.
Please see <http://www.linux-ipv6.org> for further information.

Well...

Linux happened to process invalid ND messages with invalid options
such as
 - length of ND options is 0
 - length of ND options is not enough
Specification says that such messages must be silently discarded.
This patch parses/checks ND options before it changes state of
neighbour / address etc. and ignores such messages.

Following patch is against linux-2.4.19.

Thank you in advance.

---
Patch-Name: Don't Process ND Messages with Invalid Options
Patch-Id: FIX_2_4_19_NDP_OPTIONS-20020830
Patch-Revision: s20020925
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Reference: RFC2461
---
Index: include/net/ndisc.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/include/net/ndisc.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.1
diff -u -r1.1.1.1 -r1.1.1.1.2.1
--- include/net/ndisc.h	2002/08/20 09:46:45	1.1.1.1
+++ include/net/ndisc.h	2002/09/03 09:31:13	1.1.1.1.2.1
@@ -51,6 +51,25 @@
 	__u32			retrans_timer;
 };
 
+struct nd_opt_hdr {
+	__u8		nd_opt_type;
+	__u8		nd_opt_len;
+} __attribute__((__packed__));
+
+struct ndisc_options {
+	struct nd_opt_hdr *nd_opt_array[7];
+	struct nd_opt_hdr *nd_opt_piend;
+};
+
+#define nd_opts_src_lladdr	nd_opt_array[ND_OPT_SOURCE_LL_ADDR]
+#define nd_opts_tgt_lladdr	nd_opt_array[ND_OPT_TARGET_LL_ADDR]
+#define nd_opts_pi		nd_opt_array[ND_OPT_PREFIX_INFO]
+#define nd_opts_pi_end		nd_opt_piend
+#define nd_opts_rh		nd_opt_array[ND_OPT_REDIRECT_HDR]
+#define nd_opts_mtu		nd_opt_array[ND_OPT_MTU]
+
+extern struct nd_opt_hdr *ndisc_next_option(struct nd_opt_hdr *cur, struct nd_opt_hdr *end);
+extern struct ndisc_options *ndisc_parse_options(u8 *opt, int opt_len, struct ndisc_options *ndopts);
 
 extern int			ndisc_init(struct net_proto_family *ops);
 
Index: net/ipv6/ndisc.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/ndisc.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1 -r1.1.1.1.2.3
--- net/ipv6/ndisc.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/ndisc.c	2002/09/14 17:29:42	1.1.1.1.2.3
@@ -154,6 +154,67 @@
 	return opt + space;
 }
 
+struct nd_opt_hdr *ndisc_next_option(struct nd_opt_hdr *cur,
+				     struct nd_opt_hdr *end)
+{
+	int type;
+	if (!cur || !end || cur >= end)
+		return NULL;
+	type = cur->nd_opt_type;
+	do {
+		cur = ((void *)cur) + (cur->nd_opt_len << 3);
+	} while(cur < end && cur->nd_opt_type != type);
+	return (cur <= end && cur->nd_opt_type == type ? cur : NULL);
+}
+
+struct ndisc_options *ndisc_parse_options(u8 *opt, int opt_len,
+					  struct ndisc_options *ndopts)
+{
+	struct nd_opt_hdr *nd_opt = (struct nd_opt_hdr *)opt;
+
+	if (!nd_opt || opt_len < 0 || !ndopts)
+		return NULL;
+	memset(ndopts, 0, sizeof(*ndopts));
+	while (opt_len) {
+		int l;
+		if (opt_len < sizeof(struct nd_opt_hdr))
+			return NULL;
+		l = nd_opt->nd_opt_len << 3;
+		if (opt_len < l || l == 0)
+			return NULL;
+		switch (nd_opt->nd_opt_type) {
+		case ND_OPT_SOURCE_LL_ADDR:
+		case ND_OPT_TARGET_LL_ADDR:
+		case ND_OPT_MTU:
+		case ND_OPT_REDIRECT_HDR:
+			if (ndopts->nd_opt_array[nd_opt->nd_opt_type]) {
+				ND_PRINTK2((KERN_WARNING
+					    "ndisc_parse_options(): duplicated ND6 option found: type=%d\n",
+					    nd_opt->nd_opt_type));
+			} else {
+				ndopts->nd_opt_array[nd_opt->nd_opt_type] = nd_opt;
+			}
+			break;
+		case ND_OPT_PREFIX_INFO:
+			ndopts->nd_opts_pi_end = nd_opt;
+			if (ndopts->nd_opt_array[nd_opt->nd_opt_type] == 0)
+				ndopts->nd_opt_array[nd_opt->nd_opt_type] = nd_opt;
+			break;
+		default:
+			/*
+			 * Unknown options must be silently ignored,
+			 * to accomodate future extension to the protocol.
+			 */
+			ND_PRINTK2(KERN_WARNING
+				   "ndisc_parse_options(): ignored unsupported option; type=%d, len=%d\n",
+				   nd_opt->nd_opt_type, nd_opt->nd_opt_len);
+		}
+		opt_len -= l;
+		nd_opt = ((void *)nd_opt) + l;
+	}
+	return ndopts;
+}
+
 int ndisc_mc_map(struct in6_addr *addr, char *buf, struct net_device *dev, int dir)
 {
 	switch (dev->type) {
@@ -484,27 +545,6 @@
 }
 		   
 
-static u8 * ndisc_find_option(u8 *opt, int opt_len, int len, int option)
-{
-	while (opt_len <= len) {
-		int l = opt[1]<<3;
-
-		if (opt[0] == option && l >= opt_len)
-			return opt + 2;
-
-		if (l == 0) {
-			if (net_ratelimit())
-			    printk(KERN_WARNING "ndisc: option has 0 len\n");
-			return NULL;
-		}
-
-		opt += l;
-		len -= l;
-	}
-	return NULL;
-}
-
-
 static void ndisc_error_report(struct neighbour *neigh, struct sk_buff *skb)
 {
 	/*
@@ -542,13 +582,6 @@
 	}
 }
 
-
-static void ndisc_update(struct neighbour *neigh, u8* opt, int len, int type)
-{
-	opt = ndisc_find_option(opt, neigh->dev->addr_len+2, len, type);
-	neigh_update(neigh, opt, NUD_STALE, 1, 1);
-}
-
 static void ndisc_router_discovery(struct sk_buff *skb)
 {
         struct ra_msg *ra_msg = (struct ra_msg *) skb->h.raw;
@@ -556,6 +589,7 @@
 	struct inet6_dev *in6_dev;
 	struct rt6_info *rt;
 	int lifetime;
+	struct ndisc_options ndopts;
 	int optlen;
 
 	__u8 * opt = (__u8 *)(ra_msg + 1);
@@ -587,6 +621,13 @@
 		return;
 	}
 
+	if (!ndisc_parse_options(opt, optlen, &ndopts)) {
+		if (net_ratelimit())
+			ND_PRINTK2(KERN_WARNING
+				   "ICMP6 RA: invalid ND option, ignored.\n");
+		return;
+	}
+
 	if (in6_dev->if_flags & IF_RS_SENT) {
 		/*
 		 *	flag that an RA was received after an RS was sent
@@ -670,63 +711,60 @@
 	 *	Process options.
 	 */
 
-        while (optlen > 0) {
-                int len = (opt[1] << 3);
+	if (rt && (neigh = rt->rt6i_nexthop) != NULL) {
+		u8 *lladdr = NULL;
+		int lladdrlen;
+		if (ndopts.nd_opts_src_lladdr) {
+			lladdr = (u8*)((ndopts.nd_opts_src_lladdr)+1);
+			lladdrlen = ndopts.nd_opts_src_lladdr->nd_opt_len << 3;
+			if (lladdrlen != NDISC_OPT_SPACE(skb->dev->addr_len)) {
+				if (net_ratelimit())
+					ND_PRINTK2(KERN_WARNING
+						   "ICMP6 RA: Invalid lladdr length.\n");
+				goto out;
+			}
+		}
+		neigh_update(neigh, lladdr, NUD_STALE, 1, 1);
+	}
 
-		if (len == 0) {
-			ND_PRINTK0("RA: opt has 0 len\n");
-			break;
+	if (ndopts.nd_opts_pi) {
+		struct nd_opt_hdr *p;
+		for (p = ndopts.nd_opts_pi;
+		     p;
+		     p = ndisc_next_option(p, ndopts.nd_opts_pi_end)) {
+			addrconf_prefix_rcv(skb->dev, (u8*)p, (p->nd_opt_len) << 3);
 		}
+	}
 
-                switch(*opt) {
-                case ND_OPT_SOURCE_LL_ADDR:
+	if (ndopts.nd_opts_mtu) {
+		u32 mtu;
 
-			if (rt == NULL)
-				break;
-			
-			if ((neigh = rt->rt6i_nexthop) != NULL &&
-			    skb->dev->addr_len + 2 >= len)
-				neigh_update(neigh, opt+2, NUD_STALE, 1, 1);
-			break;
+		memcpy(&mtu, ((u8*)(ndopts.nd_opts_mtu+1))+2, sizeof(mtu));
+		mtu = ntohl(mtu);
 
-                case ND_OPT_PREFIX_INFO:
-			addrconf_prefix_rcv(skb->dev, opt, len);
-                        break;
-
-                case ND_OPT_MTU:
-			{
-				int mtu;
-				
-				mtu = htonl(*(__u32 *)(opt+4));
-
-				if (mtu < IPV6_MIN_MTU || mtu > skb->dev->mtu) {
-					ND_PRINTK0("NDISC: router "
-						   "announcement with mtu = %d\n",
-						   mtu);
-					break;
-				}
+		if (mtu < IPV6_MIN_MTU || mtu > skb->dev->mtu) {
+			if (net_ratelimit()) {
+				ND_PRINTK0("NDISC: router announcement with mtu = %d\n",
+					   mtu);
+			}
+		}
 
-				if (in6_dev->cnf.mtu6 != mtu) {
-					in6_dev->cnf.mtu6 = mtu;
+		if (in6_dev->cnf.mtu6 != mtu) {
+			in6_dev->cnf.mtu6 = mtu;
 
-					if (rt)
-						rt->u.dst.pmtu = mtu;
+			if (rt)
+				rt->u.dst.pmtu = mtu;
 
-					rt6_mtu_change(skb->dev, mtu);
-				}
-			}
-                        break;
-
-		case ND_OPT_TARGET_LL_ADDR:
-		case ND_OPT_REDIRECT_HDR:
-			ND_PRINTK0("got illegal option with RA");
-			break;
-		default:
-			ND_PRINTK0("unkown option in RA\n");
-                };
-                optlen -= len;
-                opt += len;
-        }
+			rt6_mtu_change(skb->dev, mtu);
+		}
+	}
+			
+	if (ndopts.nd_opts_tgt_lladdr || ndopts.nd_opts_rh) {
+		if (net_ratelimit())
+			ND_PRINTK0(KERN_WARNING
+				   "ICMP6 RA: got illegal option with RA");
+	}
+out:
 	if (rt)
 		dst_release(&rt->u.dst);
 	in6_dev_put(in6_dev);
@@ -740,7 +778,10 @@
 	struct in6_addr *target;	/* new first hop to destination */
 	struct neighbour *neigh;
 	int on_link = 0;
+	struct ndisc_options ndopts;
 	int optlen;
+	u8 *lladdr = NULL;
+	int lladdrlen;
 
 	if (!(ipv6_addr_type(&skb->nh.ipv6h->saddr) & IPV6_ADDR_LINKLOCAL)) {
 		if (net_ratelimit())
@@ -788,6 +829,24 @@
 	 *	first-hop router for the specified ICMP Destination Address.
 	 */
 		
+	if (!ndisc_parse_options((u8*)(dest + 1), optlen, &ndopts)) {
+		if (net_ratelimit())
+			ND_PRINTK2(KERN_WARNING
+				   "ICMP6 Redirect: invalid ND options, rejected.\n");
+		in6_dev_put(in6_dev);
+		return;
+	}
+	if (ndopts.nd_opts_tgt_lladdr) {
+		lladdr = (u8*)(ndopts.nd_opts_tgt_lladdr + 1);
+		lladdrlen = ndopts.nd_opts_tgt_lladdr->nd_opt_len << 3;
+		if (lladdrlen != NDISC_OPT_SPACE(skb->dev->addr_len)) {
+			if (net_ratelimit())
+				ND_PRINTK2(KERN_WARNING
+					   "ICMP6 Redirect: invalid lladdr length.\n");
+			in6_dev_put(in6_dev);
+			return;
+		}
+	}
 	/* passed validation tests */
 
 	/*
@@ -796,7 +855,7 @@
 
 	neigh = __neigh_lookup(&nd_tbl, target, skb->dev, 1);
 	if (neigh) {
-		ndisc_update(neigh, (u8*)(dest + 1), optlen, ND_OPT_TARGET_LL_ADDR);
+		neigh_update(neigh, lladdr, NUD_STALE, 1, 1);
 		if (neigh->nud_state&NUD_VALID)
 			rt6_redirect(dest, &skb->nh.ipv6h->saddr, neigh, on_link);
 		else
@@ -922,31 +981,6 @@
 	ICMP6_INC_STATS(Icmp6OutMsgs);
 }
 
-static __inline__ struct neighbour *
-ndisc_recv_ns(struct in6_addr *saddr, struct sk_buff *skb)
-{
-	u8 *opt;
-
-	opt = skb->h.raw;
-	opt += sizeof(struct nd_msg);
-	opt = ndisc_find_option(opt, skb->dev->addr_len+2, skb->tail - opt, ND_OPT_SOURCE_LL_ADDR);
-
-	return neigh_event_ns(&nd_tbl, opt, saddr, skb->dev);
-}
-
-static __inline__ int ndisc_recv_na(struct neighbour *neigh, struct sk_buff *skb)
-{
-	u8 *opt;
-	struct nd_msg *msg = (struct nd_msg*) skb->h.raw;
-
-	opt = ndisc_find_option(msg->opt, skb->dev->addr_len+2,
-				skb->tail - msg->opt, ND_OPT_TARGET_LL_ADDR);
-
-	return neigh_update(neigh, opt,
-			    msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE,
-			    msg->icmph.icmp6_override, 1);
-}
-
 static void pndisc_redo(struct sk_buff *skb)
 {
 	ndisc_rcv(skb);
@@ -978,13 +1012,15 @@
 		return 0;
 	}
 
-	/* XXX: RFC2461 Validation of [all ndisc messages]:
-	 *	All included ndisc options MUST be of non-zero length
-	 *	(Some checking in ndisc_find_option)
-	 */
-
 	switch (msg->icmph.icmp6_type) {
 	case NDISC_NEIGHBOUR_SOLICITATION:
+	    {
+		struct nd_msg *msg = (struct nd_msg *)skb->h.raw;
+		u8 *lladdr = NULL;
+		int lladdrlen = 0;
+		u32 ndoptlen = skb->tail - msg->opt;
+		struct ndisc_options ndopts;
+
 		if (skb->len < sizeof(struct nd_msg)) {
 			if (net_ratelimit())
 				printk(KERN_WARNING "ICMP NS: packet too short\n");
@@ -997,6 +1033,22 @@
 			return 0;
 		}
 
+		if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts)) {
+			if (net_ratelimit())
+				printk(KERN_WARNING "ICMP NS: invalid ND option, ignored.\n");
+			return 0;
+		}
+
+		if (ndopts.nd_opts_src_lladdr) {
+			lladdr = (u8*)(ndopts.nd_opts_src_lladdr + 1);
+			lladdrlen = ndopts.nd_opts_src_lladdr->nd_opt_len << 3;
+			if (lladdrlen != NDISC_OPT_SPACE(skb->dev->addr_len)) {
+				if (net_ratelimit())
+					printk(KERN_WARNING "ICMP NS: bad lladdr length.\n");
+				return 0;
+			}
+		}
+
 		/* XXX: RFC2461 7.1.1:
 		 * 	If the IP source address is the unspecified address, there
 		 *	MUST NOT be source link-layer address option in the message.
@@ -1063,7 +1115,7 @@
 				 *	for the source adddress
 				 */
 
-				neigh = ndisc_recv_ns(saddr, skb);
+				neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, skb->dev);
 
 				if (neigh || !dev->hard_header) {
 					ndisc_send_na(dev, neigh, saddr, &ifp->addr, 
@@ -1093,7 +1145,8 @@
 					else
 						nd_tbl.stats.rcv_probes_ucast++;
 
-					neigh = ndisc_recv_ns(saddr, skb);
+					
+					neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, skb->dev);
 
 					if (neigh) {
 						ndisc_send_na(dev, neigh, saddr, &msg->target,
@@ -1113,8 +1166,16 @@
 			
 		}
 		return 0;
+	    }
 
 	case NDISC_NEIGHBOUR_ADVERTISEMENT:
+	    {
+		struct nd_msg *msg = (struct nd_msg *)skb->h.raw;
+		u8 *lladdr = NULL;
+		int lladdrlen = 0;
+		u32 ndoptlen = skb->tail - msg->opt;
+		struct ndisc_options ndopts;
+
 		if (skb->len < sizeof(struct nd_msg)) {
 			if (net_ratelimit())
 				printk(KERN_WARNING "ICMP NA: packet too short\n");
@@ -1133,6 +1194,20 @@
 			return 0;
 		}
 		
+		if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts)) {
+			if (net_ratelimit())
+				printk(KERN_WARNING "ICMP NS: invalid ND option, ignored.\n");
+			return 0;
+		}
+		if (ndopts.nd_opts_tgt_lladdr) {
+			lladdr = (u8*)(ndopts.nd_opts_tgt_lladdr + 1);
+			lladdrlen = ndopts.nd_opts_tgt_lladdr->nd_opt_len << 3;
+			if (lladdrlen != NDISC_OPT_SPACE(skb->dev->addr_len)) {
+				if (net_ratelimit())
+					printk(KERN_WARNING "NDISC NA: invalid lladdr length.\n");
+				return 0;
+			}
+		}
 		if ((ifp = ipv6_get_ifaddr(&msg->target, dev))) {
 			if (ifp->flags & IFA_F_TENTATIVE) {
 				addrconf_dad_failure(ifp);
@@ -1170,10 +1245,13 @@
 					neigh->flags |= NTF_ROUTER;
 			}
 
-			ndisc_recv_na(neigh, skb);
+			neigh_update(neigh, lladdr,
+				     msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE,
+				     msg->icmph.icmp6_override, 1);
 			neigh_release(neigh);
 		}
 		break;
+	    }
 
 	case NDISC_ROUTER_ADVERTISEMENT:
 		ndisc_router_discovery(skb);

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
