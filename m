Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265739AbSJYAjK>; Thu, 24 Oct 2002 20:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265744AbSJYAjJ>; Thu, 24 Oct 2002 20:39:09 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:5391 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S265739AbSJYAi6>; Thu, 24 Oct 2002 20:38:58 -0400
Date: Fri, 25 Oct 2002 09:44:59 +0900 (JST)
Message-Id: <20021025.094459.116783443.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: ndisc_rcv() clean-up
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch just adds new ndisc_recv_ns() and ndisc_recv_na() to
make switch / case in ndisc_rcv() (and ndisc_rcv() itself) small.

This patch is against linux-2.4.20-pre11.

Thanks in advance.

-------------------------------------------------------------------
Patch-Name: ndisc_rcv() clean-up
Patch-Id: FIX_2_4_20_pre11_NDISC_CLEANUP
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
-------------------------------------------------------------------
Index: net/ipv6/ndisc.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/ndisc.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.20.1
diff -u -r1.1.1.2 -r1.1.1.2.20.1
--- net/ipv6/ndisc.c	9 Oct 2002 01:35:53 -0000	1.1.1.2
+++ net/ipv6/ndisc.c	24 Oct 2002 09:50:42 -0000	1.1.1.2.20.1
@@ -583,6 +583,253 @@
 	}
 }
 
+void ndisc_recv_ns(struct sk_buff *skb)
+{
+	struct nd_msg *msg = (struct nd_msg *)skb->h.raw;
+	struct in6_addr *saddr = &skb->nh.ipv6h->saddr;
+	struct in6_addr *daddr = &skb->nh.ipv6h->daddr;
+	u8 *lladdr = NULL;
+	int lladdrlen = 0;
+	u32 ndoptlen = skb->tail - msg->opt;
+	struct ndisc_options ndopts;
+	struct net_device *dev = skb->dev;
+	struct inet6_ifaddr *ifp;
+	struct neighbour *neigh;
+
+	if (skb->len < sizeof(struct nd_msg)) {
+		if (net_ratelimit())
+			printk(KERN_WARNING "ICMP NS: packet too short\n");
+		return;
+	}
+
+	if (ipv6_addr_type(&msg->target)&IPV6_ADDR_MULTICAST) {
+		if (net_ratelimit())
+			printk(KERN_WARNING "ICMP NS: target address is multicast\n");
+		return;
+	}
+
+	if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts)) {
+		if (net_ratelimit())
+			printk(KERN_WARNING "ICMP NS: invalid ND option, ignored.\n");
+		return;
+	}
+
+	if (ndopts.nd_opts_src_lladdr) {
+		lladdr = (u8*)(ndopts.nd_opts_src_lladdr + 1);
+		lladdrlen = ndopts.nd_opts_src_lladdr->nd_opt_len << 3;
+		if (lladdrlen != NDISC_OPT_SPACE(dev->addr_len)) {
+			if (net_ratelimit())
+				printk(KERN_WARNING "ICMP NS: bad lladdr length.\n");
+			return;
+		}
+	}
+
+	/* XXX: RFC2461 7.1.1:
+	 * 	If the IP source address is the unspecified address, there
+	 *	MUST NOT be source link-layer address option in the message.
+	 *
+	 *	NOTE! Linux kernel < 2.4.4 broke this rule.
+	 */
+		 	
+	/* XXX: RFC2461 7.1.1:
+	 *	If the IP source address is the unspecified address, the IP
+      	 *	destination address MUST be a solicited-node multicast address.
+	 */
+
+	if ((ifp = ipv6_get_ifaddr(&msg->target, dev)) != NULL) {
+		int addr_type = ipv6_addr_type(saddr);
+
+		if (ifp->flags & IFA_F_TENTATIVE) {
+			/* Address is tentative. If the source
+			   is unspecified address, it is someone
+			   does DAD, otherwise we ignore solicitations
+			   until DAD timer expires.
+			 */
+			if (addr_type == IPV6_ADDR_ANY) {
+				if (dev->type == ARPHRD_IEEE802_TR) { 
+					unsigned char *sadr = skb->mac.raw ;
+					if (((sadr[8] &0x7f) != (dev->dev_addr[0] & 0x7f)) ||
+					(sadr[9] != dev->dev_addr[1]) ||
+					(sadr[10] != dev->dev_addr[2]) ||
+					(sadr[11] != dev->dev_addr[3]) ||
+					(sadr[12] != dev->dev_addr[4]) ||
+					(sadr[13] != dev->dev_addr[5])) 
+					{
+						addrconf_dad_failure(ifp) ; 
+					}
+				} else {
+					addrconf_dad_failure(ifp);
+				}
+			} else
+				in6_ifa_put(ifp);
+			return;
+		}
+	
+		if (addr_type == IPV6_ADDR_ANY) {
+			struct in6_addr maddr;
+
+			ipv6_addr_all_nodes(&maddr);
+			ndisc_send_na(dev, NULL, &maddr, &ifp->addr, 
+				      ifp->idev->cnf.forwarding, 0, 
+				      ipv6_addr_type(&ifp->addr)&IPV6_ADDR_ANYCAST ? 0 : 1, 
+				      1);
+			in6_ifa_put(ifp);
+			return;
+		}
+
+		if (addr_type & IPV6_ADDR_UNICAST) {
+			int inc = ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST;
+
+			if (inc)
+				nd_tbl.stats.rcv_probes_mcast++;
+			else
+				nd_tbl.stats.rcv_probes_ucast++;
+
+			/* 
+			 *	update / create cache entry
+			 *	for the source adddress
+			 */
+
+			neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, dev);
+
+			if (neigh || !dev->hard_header) {
+				ndisc_send_na(dev, neigh, saddr, &ifp->addr, 
+					      ifp->idev->cnf.forwarding, 1, 
+					      ipv6_addr_type(&ifp->addr)&IPV6_ADDR_ANYCAST ? 0 : 1, 
+					      1);
+				if (neigh)
+					neigh_release(neigh);
+			}
+		}
+		in6_ifa_put(ifp);
+	} else {
+		struct inet6_dev *in6_dev = in6_dev_get(dev);
+		int addr_type = ipv6_addr_type(saddr);
+
+		if (in6_dev && in6_dev->cnf.forwarding &&
+		    (addr_type & IPV6_ADDR_UNICAST) &&
+		    pneigh_lookup(&nd_tbl, &msg->target, dev, 0)) {
+			int inc = ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST;
+
+			if (skb->stamp.tv_sec == 0 ||
+			    skb->pkt_type == PACKET_HOST ||
+			    inc == 0 ||
+			    in6_dev->nd_parms->proxy_delay == 0) {
+				if (inc)
+					nd_tbl.stats.rcv_probes_mcast++;
+				else
+					nd_tbl.stats.rcv_probes_ucast++;
+					
+				neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, dev);
+
+				if (neigh) {
+					ndisc_send_na(dev, neigh, saddr, &msg->target,
+						      0, 1, 0, 1);
+					neigh_release(neigh);
+				}
+			} else {
+				struct sk_buff *n = skb_clone(skb, GFP_ATOMIC);
+				if (n)
+					pneigh_enqueue(&nd_tbl, in6_dev->nd_parms, n);
+				in6_dev_put(in6_dev);
+				return;
+			}
+		}
+		if (in6_dev)
+			in6_dev_put(in6_dev);
+	}
+	return;
+}
+
+void ndisc_recv_na(struct sk_buff *skb)
+{
+	struct nd_msg *msg = (struct nd_msg *)skb->h.raw;
+	struct in6_addr *saddr = &skb->nh.ipv6h->saddr;
+	struct in6_addr *daddr = &skb->nh.ipv6h->daddr;
+	u8 *lladdr = NULL;
+	int lladdrlen = 0;
+	u32 ndoptlen = skb->tail - msg->opt;
+	struct ndisc_options ndopts;
+	struct net_device *dev = skb->dev;
+	struct inet6_ifaddr *ifp;
+	struct neighbour *neigh;
+
+	if (skb->len < sizeof(struct nd_msg)) {
+		if (net_ratelimit())
+			printk(KERN_WARNING "ICMP NA: packet too short\n");
+		return;
+	}
+
+	if (ipv6_addr_type(&msg->target)&IPV6_ADDR_MULTICAST) {
+		if (net_ratelimit())
+			printk(KERN_WARNING "NDISC NA: target address is multicast\n");
+		return;
+	}
+
+	if ((ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST) &&
+	    msg->icmph.icmp6_solicited) {
+		ND_PRINTK0("NDISC: solicited NA is multicasted\n");
+		return;
+	}
+		
+	if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts)) {
+		if (net_ratelimit())
+			printk(KERN_WARNING "ICMP NS: invalid ND option, ignored.\n");
+		return;
+	}
+	if (ndopts.nd_opts_tgt_lladdr) {
+		lladdr = (u8*)(ndopts.nd_opts_tgt_lladdr + 1);
+		lladdrlen = ndopts.nd_opts_tgt_lladdr->nd_opt_len << 3;
+		if (lladdrlen != NDISC_OPT_SPACE(dev->addr_len)) {
+			if (net_ratelimit())
+				printk(KERN_WARNING "NDISC NA: invalid lladdr length.\n");
+			return;
+		}
+	}
+	if ((ifp = ipv6_get_ifaddr(&msg->target, dev))) {
+		if (ifp->flags & IFA_F_TENTATIVE) {
+			addrconf_dad_failure(ifp);
+			return;
+		}
+		/* What should we make now? The advertisement
+		   is invalid, but ndisc specs say nothing
+		   about it. It could be misconfiguration, or
+		   an smart proxy agent tries to help us :-)
+		 */
+		ND_PRINTK0("%s: someone advertises our address!\n",
+			   ifp->idev->dev->name);
+		in6_ifa_put(ifp);
+		return;
+	}
+	neigh = neigh_lookup(&nd_tbl, &msg->target, dev);
+
+	if (neigh) {
+		if (neigh->flags & NTF_ROUTER) {
+			if (msg->icmph.icmp6_router == 0) {
+				/*
+				 *	Change: router to host
+				 */
+				struct rt6_info *rt;
+				rt = rt6_get_dflt_router(saddr, dev);
+				if (rt) {
+					/* It is safe only because
+					   we aer in BH */
+					dst_release(&rt->u.dst);
+					ip6_del_rt(rt);
+				}
+			}
+		} else {
+			if (msg->icmph.icmp6_router)
+				neigh->flags |= NTF_ROUTER;
+		}
+
+		neigh_update(neigh, lladdr,
+			     msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE,
+			     msg->icmph.icmp6_override, 1);
+		neigh_release(neigh);
+	}
+}
+
 static void ndisc_router_discovery(struct sk_buff *skb)
 {
         struct ra_msg *ra_msg = (struct ra_msg *) skb->h.raw;
@@ -990,12 +1237,7 @@
 
 int ndisc_rcv(struct sk_buff *skb)
 {
-	struct net_device *dev = skb->dev;
-	struct in6_addr *saddr = &skb->nh.ipv6h->saddr;
-	struct in6_addr *daddr = &skb->nh.ipv6h->daddr;
 	struct nd_msg *msg = (struct nd_msg *) skb->h.raw;
-	struct neighbour *neigh;
-	struct inet6_ifaddr *ifp;
 
 	__skb_push(skb, skb->data-skb->h.raw);
 
@@ -1015,244 +1257,12 @@
 
 	switch (msg->icmph.icmp6_type) {
 	case NDISC_NEIGHBOUR_SOLICITATION:
-	    {
-		struct nd_msg *msg = (struct nd_msg *)skb->h.raw;
-		u8 *lladdr = NULL;
-		int lladdrlen = 0;
-		u32 ndoptlen = skb->tail - msg->opt;
-		struct ndisc_options ndopts;
-
-		if (skb->len < sizeof(struct nd_msg)) {
-			if (net_ratelimit())
-				printk(KERN_WARNING "ICMP NS: packet too short\n");
-			return 0;
-		}
-
-		if (ipv6_addr_type(&msg->target)&IPV6_ADDR_MULTICAST) {
-			if (net_ratelimit())
-				printk(KERN_WARNING "ICMP NS: target address is multicast\n");
-			return 0;
-		}
-
-		if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts)) {
-			if (net_ratelimit())
-				printk(KERN_WARNING "ICMP NS: invalid ND option, ignored.\n");
-			return 0;
-		}
-
-		if (ndopts.nd_opts_src_lladdr) {
-			lladdr = (u8*)(ndopts.nd_opts_src_lladdr + 1);
-			lladdrlen = ndopts.nd_opts_src_lladdr->nd_opt_len << 3;
-			if (lladdrlen != NDISC_OPT_SPACE(skb->dev->addr_len)) {
-				if (net_ratelimit())
-					printk(KERN_WARNING "ICMP NS: bad lladdr length.\n");
-				return 0;
-			}
-		}
-
-		/* XXX: RFC2461 7.1.1:
-		 * 	If the IP source address is the unspecified address, there
-		 *	MUST NOT be source link-layer address option in the message.
-		 *
-		 *	NOTE! Linux kernel < 2.4.4 broke this rule.
-		 */
-		 	
-		/* XXX: RFC2461 7.1.1:
-		 *	If the IP source address is the unspecified address, the IP
-      		 *	destination address MUST be a solicited-node multicast address.
-		 */
-
-		if ((ifp = ipv6_get_ifaddr(&msg->target, dev)) != NULL) {
-			int addr_type = ipv6_addr_type(saddr);
-
-			if (ifp->flags & IFA_F_TENTATIVE) {
-				/* Address is tentative. If the source
-				   is unspecified address, it is someone
-				   does DAD, otherwise we ignore solicitations
-				   until DAD timer expires.
-				 */
-				if (addr_type == IPV6_ADDR_ANY) {
-					if (dev->type == ARPHRD_IEEE802_TR) { 
-						unsigned char *sadr = skb->mac.raw ;
-						if (((sadr[8] &0x7f) != (dev->dev_addr[0] & 0x7f)) ||
-						(sadr[9] != dev->dev_addr[1]) ||
-						(sadr[10] != dev->dev_addr[2]) ||
-						(sadr[11] != dev->dev_addr[3]) ||
-						(sadr[12] != dev->dev_addr[4]) ||
-						(sadr[13] != dev->dev_addr[5])) 
-						{
-							addrconf_dad_failure(ifp) ; 
-						}
-					} else {
-						addrconf_dad_failure(ifp);
-					}
-				} else
-					in6_ifa_put(ifp);
-				return 0;
-			}
-
-			if (addr_type == IPV6_ADDR_ANY) {
-				struct in6_addr maddr;
-
-				ipv6_addr_all_nodes(&maddr);
-				ndisc_send_na(dev, NULL, &maddr, &ifp->addr, 
-					      ifp->idev->cnf.forwarding, 0, 
-					      ipv6_addr_type(&ifp->addr)&IPV6_ADDR_ANYCAST ? 0 : 1, 
-					      1);
-				in6_ifa_put(ifp);
-				return 0;
-			}
-
-			if (addr_type & IPV6_ADDR_UNICAST) {
-				int inc = ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST;
-
-				if (inc)
-					nd_tbl.stats.rcv_probes_mcast++;
-				else
-					nd_tbl.stats.rcv_probes_ucast++;
-
-				/* 
-				 *	update / create cache entry
-				 *	for the source adddress
-				 */
-
-				neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, skb->dev);
-
-				if (neigh || !dev->hard_header) {
-					ndisc_send_na(dev, neigh, saddr, &ifp->addr, 
-						      ifp->idev->cnf.forwarding, 1, 
-						      ipv6_addr_type(&ifp->addr)&IPV6_ADDR_ANYCAST ? 0 : 1, 
-						      1);
-					if (neigh)
-						neigh_release(neigh);
-				}
-			}
-			in6_ifa_put(ifp);
-		} else {
-			struct inet6_dev *in6_dev = in6_dev_get(dev);
-			int addr_type = ipv6_addr_type(saddr);
-
-			if (in6_dev && in6_dev->cnf.forwarding &&
-			    (addr_type & IPV6_ADDR_UNICAST) &&
-			    pneigh_lookup(&nd_tbl, &msg->target, dev, 0)) {
-				int inc = ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST;
-
-				if (skb->stamp.tv_sec == 0 ||
-				    skb->pkt_type == PACKET_HOST ||
-				    inc == 0 ||
-				    in6_dev->nd_parms->proxy_delay == 0) {
-					if (inc)
-						nd_tbl.stats.rcv_probes_mcast++;
-					else
-						nd_tbl.stats.rcv_probes_ucast++;
-
-					
-					neigh = neigh_event_ns(&nd_tbl, lladdr, saddr, skb->dev);
-
-					if (neigh) {
-						ndisc_send_na(dev, neigh, saddr, &msg->target,
-							      0, 1, 0, 1);
-						neigh_release(neigh);
-					}
-				} else {
-					struct sk_buff *n = skb_clone(skb, GFP_ATOMIC);
-					if (n)
-						pneigh_enqueue(&nd_tbl, in6_dev->nd_parms, n);
-					in6_dev_put(in6_dev);
-					return 0;
-				}
-			}
-			if (in6_dev)
-				in6_dev_put(in6_dev);
-			
-		}
-		return 0;
-	    }
+		ndisc_recv_ns(skb);
+		break;
 
 	case NDISC_NEIGHBOUR_ADVERTISEMENT:
-	    {
-		struct nd_msg *msg = (struct nd_msg *)skb->h.raw;
-		u8 *lladdr = NULL;
-		int lladdrlen = 0;
-		u32 ndoptlen = skb->tail - msg->opt;
-		struct ndisc_options ndopts;
-
-		if (skb->len < sizeof(struct nd_msg)) {
-			if (net_ratelimit())
-				printk(KERN_WARNING "ICMP NA: packet too short\n");
-			return 0;
-		}
-
-		if (ipv6_addr_type(&msg->target)&IPV6_ADDR_MULTICAST) {
-			if (net_ratelimit())
-				printk(KERN_WARNING "NDISC NA: target address is multicast\n");
-			return 0;
-		}
-
-		if ((ipv6_addr_type(daddr)&IPV6_ADDR_MULTICAST) &&
-		    msg->icmph.icmp6_solicited) {
-			ND_PRINTK0("NDISC: solicited NA is multicasted\n");
-			return 0;
-		}
-		
-		if (!ndisc_parse_options(msg->opt, ndoptlen, &ndopts)) {
-			if (net_ratelimit())
-				printk(KERN_WARNING "ICMP NS: invalid ND option, ignored.\n");
-			return 0;
-		}
-		if (ndopts.nd_opts_tgt_lladdr) {
-			lladdr = (u8*)(ndopts.nd_opts_tgt_lladdr + 1);
-			lladdrlen = ndopts.nd_opts_tgt_lladdr->nd_opt_len << 3;
-			if (lladdrlen != NDISC_OPT_SPACE(skb->dev->addr_len)) {
-				if (net_ratelimit())
-					printk(KERN_WARNING "NDISC NA: invalid lladdr length.\n");
-				return 0;
-			}
-		}
-		if ((ifp = ipv6_get_ifaddr(&msg->target, dev))) {
-			if (ifp->flags & IFA_F_TENTATIVE) {
-				addrconf_dad_failure(ifp);
-				return 0;
-			}
-			/* What should we make now? The advertisement
-			   is invalid, but ndisc specs say nothing
-			   about it. It could be misconfiguration, or
-			   an smart proxy agent tries to help us :-)
-			 */
-			ND_PRINTK0("%s: someone advertises our address!\n",
-				   ifp->idev->dev->name);
-			in6_ifa_put(ifp);
-			return 0;
-		}
-		neigh = neigh_lookup(&nd_tbl, &msg->target, skb->dev);
-
-		if (neigh) {
-			if (neigh->flags & NTF_ROUTER) {
-				if (msg->icmph.icmp6_router == 0) {
-					/*
-					 *	Change: router to host
-					 */
-					struct rt6_info *rt;
-					rt = rt6_get_dflt_router(saddr, skb->dev);
-					if (rt) {
-						/* It is safe only because
-						   we aer in BH */
-						dst_release(&rt->u.dst);
-						ip6_del_rt(rt);
-					}
-				}
-			} else {
-				if (msg->icmph.icmp6_router)
-					neigh->flags |= NTF_ROUTER;
-			}
-
-			neigh_update(neigh, lladdr,
-				     msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE,
-				     msg->icmph.icmp6_override, 1);
-			neigh_release(neigh);
-		}
+		ndisc_recv_na(skb);
 		break;
-	    }
 
 	case NDISC_ROUTER_ADVERTISEMENT:
 		ndisc_router_discovery(skb);
