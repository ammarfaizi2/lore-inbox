Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSKCCsy>; Sat, 2 Nov 2002 21:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSKCCsy>; Sat, 2 Nov 2002 21:48:54 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:47880 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id <S261567AbSKCCsv>; Sat, 2 Nov 2002 21:48:51 -0500
Date: Sun, 03 Nov 2002 11:54:27 +0900 (JST)
Message-Id: <20021103.115427.104445233.yoshfuji@linux-ipv6.org>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru, usagi@linux-ipv6.org
Subject: [PATCH] IPv6: Functions Clean-up
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

Hello!

This patch cleans up functions in ipv6 stack:

 - export route6_me_harder() as ip6_route_harder() and
   use it from net/ipv6/netfilter/ip6_queue.c.
 - make ip6_addr_prefix() to generate prefix of given address and
   prefix length, instead of doing "ipv6_copy_addr() then
   ipv6_wash_prefix()."

Patch is against 2.5.45.

Thanks in advance.

-------------------------------------------------------------------
Patch-Name: Functions Clean-up
Patch-Id: FIX_2_5_45_FUNC_CLEANUP-20021102
Patch-Author: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
Credit: YOSHIFUJI Hideaki / USAGI Project <yoshfuji@linux-ipv6.org>
-------------------------------------------------------------------
Index: include/net/ip6_route.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/include/net/ip6_route.h,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.16.1
diff -u -r1.1.1.1 -r1.1.1.1.16.1
--- include/net/ip6_route.h	7 Oct 2002 10:22:46 -0000	1.1.1.1
+++ include/net/ip6_route.h	2 Nov 2002 14:50:30 -0000	1.1.1.1.16.1
@@ -30,6 +30,8 @@
 extern struct dst_entry *	ip6_route_output(struct sock *sk,
 						 struct flowi *fl);
 
+extern int			ip6_route_harder(struct sk_buff *skb);
+
 extern void			ip6_route_init(void);
 extern void			ip6_route_cleanup(void);
 
Index: net/ipv6/ip6_output.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/ip6_output.c,v
retrieving revision 1.1.1.3
retrieving revision 1.1.1.3.6.1
diff -u -r1.1.1.3 -r1.1.1.3.6.1
--- net/ipv6/ip6_output.c	30 Oct 2002 09:43:18 -0000	1.1.1.3
+++ net/ipv6/ip6_output.c	2 Nov 2002 14:50:30 -0000	1.1.1.3.6.1
@@ -134,7 +134,7 @@
 
 
 #ifdef CONFIG_NETFILTER
-static int route6_me_harder(struct sk_buff *skb)
+int ip6_route_harder(struct sk_buff *skb)
 {
 	struct ipv6hdr *iph = skb->nh.ipv6h;
 	struct dst_entry *dst;
@@ -152,7 +152,7 @@
 
 	if (dst->error) {
 		if (net_ratelimit())
-			printk(KERN_DEBUG "route6_me_harder: No more route.\n");
+			printk(KERN_DEBUG "ip6_route_harder: No more route.\n");
 		return -EINVAL;
 	}
 
@@ -168,7 +168,7 @@
 {
 #ifdef CONFIG_NETFILTER
 	if (skb->nfcache & NFC_ALTERED){
-		if (route6_me_harder(skb) != 0){
+		if (ip6_route_harder(skb) != 0){
 			kfree_skb(skb);
 			return -EINVAL;
 		}
Index: net/ipv6/ipv6_syms.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/ipv6_syms.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.16.1
diff -u -r1.1.1.1 -r1.1.1.1.16.1
--- net/ipv6/ipv6_syms.c	7 Oct 2002 10:20:36 -0000	1.1.1.1
+++ net/ipv6/ipv6_syms.c	2 Nov 2002 14:50:30 -0000	1.1.1.1.16.1
@@ -1,4 +1,5 @@
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <net/protocol.h>
 #include <net/ipv6.h>
@@ -11,6 +12,9 @@
 EXPORT_SYMBOL(register_inet6addr_notifier);
 EXPORT_SYMBOL(unregister_inet6addr_notifier);
 EXPORT_SYMBOL(ip6_route_output);
+#ifdef CONFIG_NETFILTER
+EXPORT_SYMBOL(ip6_route_harder);
+#endif
 EXPORT_SYMBOL(addrconf_lock);
 EXPORT_SYMBOL(ipv6_setsockopt);
 EXPORT_SYMBOL(ipv6_getsockopt);
Index: net/ipv6/route.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/route.c,v
retrieving revision 1.1.1.4
retrieving revision 1.1.1.4.6.1
diff -u -r1.1.1.4 -r1.1.1.4.6.1
--- net/ipv6/route.c	30 Oct 2002 09:43:18 -0000	1.1.1.4
+++ net/ipv6/route.c	2 Nov 2002 14:52:05 -0000	1.1.1.4.6.1
@@ -573,15 +573,17 @@
    Remove it only when all the things will work!
  */
 
-static void ipv6_wash_prefix(struct in6_addr *pfx, int plen)
+static void ipv6_addr_prefix(struct in6_addr *pfx,
+			     const struct in6_addr *addr, int plen)
 {
 	int b = plen&0x7;
-	int o = (plen + 7)>>3;
+	int o = plen>>3;
 
+	memcpy(prefix, addr, o);
 	if (o < 16)
 		memset(pfx->s6_addr + o, 0, 16 - o);
 	if (b != 0)
-		pfx->s6_addr[plen>>3] &= (0xFF<<(8-b));
+		pfx->s6_addr[o] = addr->s6_addr[o]&(0xff00 >> b);
 }
 
 static int ipv6_get_mtu(struct net_device *dev)
@@ -654,16 +656,16 @@
 			goto out;
 	}
 
-	ipv6_addr_copy(&rt->rt6i_dst.addr, &rtmsg->rtmsg_dst);
+	ipv6_addr_prefix(&rt->rt6i_dst.addr, 
+			 &rtmsg->rtmsg_dst, rtmsg->rtmsg_dst_len);
 	rt->rt6i_dst.plen = rtmsg->rtmsg_dst_len;
 	if (rt->rt6i_dst.plen == 128)
 	       rt->u.dst.flags = DST_HOST;
-	ipv6_wash_prefix(&rt->rt6i_dst.addr, rt->rt6i_dst.plen);
 
 #ifdef CONFIG_IPV6_SUBTREES
-	ipv6_addr_copy(&rt->rt6i_src.addr, &rtmsg->rtmsg_src);
+	ipv6_addr_prefix(&rt->rt6i_src.addr, 
+			 &rtmsg->rtmsg_src, rtmsg->rtmsg_src_len);
 	rt->rt6i_src.plen = rtmsg->rtmsg_src_len;
-	ipv6_wash_prefix(&rt->rt6i_src.addr, rt->rt6i_src.plen);
 #endif
 
 	rt->rt6i_metric = rtmsg->rtmsg_metric;
Index: net/ipv6/netfilter/ip6_queue.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/net/ipv6/netfilter/ip6_queue.c,v
retrieving revision 1.1.1.2
retrieving revision 1.1.1.2.14.1
diff -u -r1.1.1.2 -r1.1.1.2.14.1
--- net/ipv6/netfilter/ip6_queue.c	8 Oct 2002 03:15:20 -0000	1.1.1.2
+++ net/ipv6/netfilter/ip6_queue.c	2 Nov 2002 14:50:30 -0000	1.1.1.2.14.1
@@ -326,45 +326,6 @@
 	return status;
 }
 
-/*
- * Taken from net/ipv6/ip6_output.c
- *
- * We should use the one there, but is defined static
- * so we put this just here and let the things as
- * they are now.
- *
- * If that one is modified, this one should be modified too.
- */
-static int
-route6_me_harder(struct sk_buff *skb)
-{
-	struct ipv6hdr *iph = skb->nh.ipv6h;
-	struct dst_entry *dst;
-	struct flowi fl;
-
-	fl.proto = iph->nexthdr;
-	fl.fl6_dst = &iph->daddr;
-	fl.fl6_src = &iph->saddr;
-	fl.oif = skb->sk ? skb->sk->bound_dev_if : 0;
-	fl.fl6_flowlabel = 0;
-	fl.uli_u.ports.dport = 0;
-	fl.uli_u.ports.sport = 0;
-
-	dst = ip6_route_output(skb->sk, &fl);
-
-	if (dst->error) {
-		if (net_ratelimit())
-			printk(KERN_DEBUG "route6_me_harder: No more route.\n");
-		return -EINVAL;
-	}
-
-	/* Drop old route. */
-	dst_release(skb->dst);
-
-	skb->dst = dst;
-	return 0;
-}
-
 static int
 ipq_mangle_ipv6(ipq_verdict_msg_t *v, struct ipq_queue_entry *e)
 {
@@ -410,7 +371,7 @@
 		struct ipv6hdr *iph = e->skb->nh.ipv6h;
 		if (ipv6_addr_cmp(&iph->daddr, &e->rt_info.daddr) ||
 		    ipv6_addr_cmp(&iph->saddr, &e->rt_info.saddr))
-			return route6_me_harder(e->skb);
+			return ip6_route_harder(e->skb);
 	}
 	return 0;
 }
