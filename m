Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSJCQH7>; Thu, 3 Oct 2002 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261772AbSJCQH7>; Thu, 3 Oct 2002 12:07:59 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:44809 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261698AbSJCQHw>; Thu, 3 Oct 2002 12:07:52 -0400
Date: Fri, 04 Oct 2002 01:13:15 +0900 (JST)
Message-Id: <20021004.011315.05129566.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org
CC: usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Miscellaneous clean-ups
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

1. use s6_addrXX instead of in6_u.s6_addrXX.
2. avoid using magic number.
3. use 32bit constants.

Following patch in against linux-2.4.19.

Thanks in advance.

-------------------------------------------------------------------
Patch-Name: Miscellaneous clean-ups
Patch-Id: FIX_2_4_19_ADDRCONF_TIMER-20020905
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Reference: RFC2553
-------------------------------------------------------------------
Index: net/ipv6/addrconf.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/addrconf.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv6/addrconf.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/addrconf.c	2002/09/12 09:41:58	1.1.1.1.12.1
@@ -172,7 +172,7 @@
 
 	if ((addr->s6_addr32[0] | addr->s6_addr32[1]) == 0) {
 		if (addr->s6_addr32[2] == 0) {
-			if (addr->in6_u.u6_addr32[3] == 0)
+			if (addr->s6_addr32[3] == 0)
 				return IPV6_ADDR_ANY;
 
 			if (addr->s6_addr32[3] == __constant_htonl(0x00000001))
@@ -1187,7 +1187,7 @@
 	ASSERT_RTNL();
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-	addr.s6_addr[15] = 1;
+	addr.s6_addr32[3] = __constant_htonl(0x00000001);
 
 	if ((idev = ipv6_find_idev(dev)) == NULL) {
 		printk(KERN_DEBUG "init loopback: add_dev failed\n");
@@ -1234,9 +1234,7 @@
 		return;
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-
-	addr.s6_addr[0] = 0xFE;
-	addr.s6_addr[1] = 0x80;
+	addr.s6_addr32[0] = __contant_htonl(0xFE800000);
 
 	if (ipv6_generate_eui64(addr.s6_addr + 8, dev) == 0)
 		addrconf_add_linklocal(idev, &addr);
Index: net/ipv6/icmp.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/icmp.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.1
diff -u -r1.1.1.1 -r1.1.1.1.12.1
--- net/ipv6/icmp.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/icmp.c	2002/09/12 09:41:58	1.1.1.1.12.1
@@ -198,7 +198,7 @@
 		u8 type;
 		if (skb_copy_bits(skb, ptr+offsetof(struct icmp6hdr, icmp6_type),
 				  &type, 1)
-		    || !(type & 0x80))
+		    || !(type & ICMPV6_INFOMSG_MASK))
 			return 1;
 	}
 	return 0;
@@ -216,7 +216,7 @@
 	int res = 0;
 
 	/* Informational messages are not limited. */
-	if (type & 0x80)
+	if (type & ICMPV6_INFOMSG_MASK)
 		return 1;
 
 	/* Do not limit pmtu discovery, it would break it. */
@@ -519,22 +519,22 @@
 				    skb_checksum(skb, 0, skb->len, 0))) {
 			if (net_ratelimit())
 				printk(KERN_DEBUG "ICMPv6 checksum failed [%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x > %04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x]\n",
-				       ntohs(saddr->in6_u.u6_addr16[0]),
-				       ntohs(saddr->in6_u.u6_addr16[1]),
-				       ntohs(saddr->in6_u.u6_addr16[2]),
-				       ntohs(saddr->in6_u.u6_addr16[3]),
-				       ntohs(saddr->in6_u.u6_addr16[4]),
-				       ntohs(saddr->in6_u.u6_addr16[5]),
-				       ntohs(saddr->in6_u.u6_addr16[6]),
-				       ntohs(saddr->in6_u.u6_addr16[7]),
-				       ntohs(daddr->in6_u.u6_addr16[0]),
-				       ntohs(daddr->in6_u.u6_addr16[1]),
-				       ntohs(daddr->in6_u.u6_addr16[2]),
-				       ntohs(daddr->in6_u.u6_addr16[3]),
-				       ntohs(daddr->in6_u.u6_addr16[4]),
-				       ntohs(daddr->in6_u.u6_addr16[5]),
-				       ntohs(daddr->in6_u.u6_addr16[6]),
-				       ntohs(daddr->in6_u.u6_addr16[7]));
+				       ntohs(saddr->s6_addr16[0]),
+				       ntohs(saddr->s6_addr16[1]),
+				       ntohs(saddr->s6_addr16[2]),
+				       ntohs(saddr->s6_addr16[3]),
+				       ntohs(saddr->s6_addr16[4]),
+				       ntohs(saddr->s6_addr16[5]),
+				       ntohs(saddr->s6_addr16[6]),
+				       ntohs(saddr->s6_addr16[7]),
+				       ntohs(daddr->s6_addr16[0]),
+				       ntohs(daddr->s6_addr16[1]),
+				       ntohs(daddr->s6_addr16[2]),
+				       ntohs(daddr->s6_addr16[3]),
+				       ntohs(daddr->s6_addr16[4]),
+				       ntohs(daddr->s6_addr16[5]),
+				       ntohs(daddr->s6_addr16[6]),
+				       ntohs(daddr->s6_addr16[7]));
 			goto discard_it;
 		}
 	}
@@ -613,7 +613,7 @@
 			printk(KERN_DEBUG "icmpv6: msg of unkown type\n");
 
 		/* informational */
-		if (type & 0x80)
+		if (type & ICMPV6_INFOMSG_MASK)
 			break;
 
 		/* 
Index: net/ipv6/netfilter/ip6_queue.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux24/net/ipv6/netfilter/ip6_queue.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.12.2
diff -u -r1.1.1.1 -r1.1.1.1.12.2
--- net/ipv6/netfilter/ip6_queue.c	2002/08/20 09:47:02	1.1.1.1
+++ net/ipv6/netfilter/ip6_queue.c	2002/09/19 03:57:51	1.1.1.1.12.2
@@ -306,14 +306,8 @@
 	 */
 	if (e->info->hook == NF_IP_LOCAL_OUT) {
 		struct ipv6hdr *iph = e->skb->nh.ipv6h;
-		if (!(   iph->daddr.in6_u.u6_addr32[0] == e->rt_info.daddr.in6_u.u6_addr32[0]
-                      && iph->daddr.in6_u.u6_addr32[1] == e->rt_info.daddr.in6_u.u6_addr32[1]
-                      && iph->daddr.in6_u.u6_addr32[2] == e->rt_info.daddr.in6_u.u6_addr32[2]
-                      && iph->daddr.in6_u.u6_addr32[3] == e->rt_info.daddr.in6_u.u6_addr32[3]
-		      && iph->saddr.in6_u.u6_addr32[0] == e->rt_info.saddr.in6_u.u6_addr32[0]
-		      && iph->saddr.in6_u.u6_addr32[1] == e->rt_info.saddr.in6_u.u6_addr32[1]
-		      && iph->saddr.in6_u.u6_addr32[2] == e->rt_info.saddr.in6_u.u6_addr32[2]
-		      && iph->saddr.in6_u.u6_addr32[3] == e->rt_info.saddr.in6_u.u6_addr32[3]))
+		if (ipv6_addr_cmp(&iph->daddr, &e->rt_info.daddr) ||
+		    ipv6_addr_cmp(&iph->saddr, &e->rt_info.saddr))
 			return route6_me_harder(e->skb);
 	}
 	return 0;
