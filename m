Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265313AbSKACOL>; Thu, 31 Oct 2002 21:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265324AbSKACOL>; Thu, 31 Oct 2002 21:14:11 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:35972 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265313AbSKACOH>;
	Thu, 31 Oct 2002 21:14:07 -0500
From: Krishna Kumar <krkumar@us.ibm.com>
Message-Id: <200211010219.gA12JMn11699@eng2.beaverton.ibm.com>
Subject: [PATCHSET] Mobile IPv6 for 2.5.45
To: kuznet@ms2.inr.ac.ru, davem@redhat.com
Date: Thu, 31 Oct 2002 18:19:21 -0800 (PST)
Cc: ajtuomin@tml.hut.fi (Antti Tuominen),
       lpetande@tml.hut.fi (Petander Henrik), jagana@us.ibm.com,
       krkumar@us.ibm.com (Krishna Kumar), netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

We have been working with MIPL to further split the patch as you had suggested. The patch I am sending breaks this into Correspondent Node, Mobile Node and Home Agent functionalities. This patch is against 2.5.45. As part of integrating with 2.5.45 as well as due to the splitting done, there is one outstanding issue with the patch : at module unload time, some memory allocated during module_init is not freed up. However this is a small issue and we are confident of submitting a patch in a couple of days to fix this. The code base is the same that was submitted a few days ago, so the only new thing is the further splitting work and integrating with 2.5.45.

The patch is in two parts, you need to first install the following patch :
http://traci.mipl.mediapoli.com/patches/mipl-2.5.45.patch

After that, please apply the patch at the end of this mail (created as part of 2.5.45 cleanup) to create the final tree. Once the two patches are applied, you will see separate files for the client and the agent parts.

Please let us know if you need any clarification on this patch.

Thanks,

- KK

---------------------------- Patch 2 ------------------------------------------
diff -ruN linux-2.5.45.org/net/ipv6/ipv6_syms.c linux-2.5.45/net/ipv6/ipv6_syms.c
--- linux-2.5.45.org/net/ipv6/ipv6_syms.c	Thu Oct 31 18:00:41 2002
+++ linux-2.5.45/net/ipv6/ipv6_syms.c	Thu Oct 31 15:07:47 2002
@@ -54,6 +54,7 @@
 EXPORT_SYMBOL(ip6_rt_addr_del);
 EXPORT_SYMBOL(ip6_routing_table);
 EXPORT_SYMBOL(ip6_route_add);
+EXPORT_SYMBOL(ip6_route_del);
 EXPORT_SYMBOL(ip6_del_rt);
 EXPORT_SYMBOL(fib6_clean_tree);
 EXPORT_SYMBOL(rt6_lock);
diff -ruN linux-2.5.45.org/net/ipv6/route.c linux-2.5.45/net/ipv6/route.c
--- linux-2.5.45.org/net/ipv6/route.c	Thu Oct 31 17:52:04 2002
+++ linux-2.5.45/net/ipv6/route.c	Thu Oct 31 13:07:03 2002
@@ -788,7 +788,7 @@
 	return err;
 }
 
-static int ip6_route_del(struct in6_rtmsg *rtmsg)
+int ip6_route_del(struct in6_rtmsg *rtmsg)
 {
 	struct fib6_node *fn;
 	struct rt6_info *rt;
diff -ruN linux-2.5.45.org/net/ipv6/ipv6_tunnel.c linux-2.5.45/net/ipv6/ipv6_tunnel.c
--- linux-2.5.45.org/net/ipv6/ipv6_tunnel.c	Thu Oct 31 18:00:41 2002
+++ linux-2.5.45/net/ipv6/ipv6_tunnel.c	Thu Oct 31 12:53:23 2002
@@ -1202,16 +1202,16 @@
 		       t->parms.name);
 		goto tx_err_dst_release;
 	}
-	mtu = dst->pmtu - sizeof (*ipv6h);
+	mtu = dst->metrics[RTAX_MTU-1] - sizeof (*ipv6h);
 	if (opt) {
 		mtu -= (opt->opt_nflen + opt->opt_flen);
 	}
 	if (mtu < IPV6_MIN_MTU)
 		mtu = IPV6_MIN_MTU;
-	if (skb->dst && mtu < skb->dst->pmtu) {
+	if (skb->dst && mtu < skb->dst->metrics[RTAX_MTU-1]) {
 		struct rt6_info *rt6 = (struct rt6_info *) skb->dst;
 		rt6->rt6i_flags |= RTF_MODIFIED;
-		rt6->u.dst.pmtu = mtu;
+		rt6->u.dst.metrics[RTAX_MTU-1] = mtu;
 	}
 	if (skb->len > mtu) {
 		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu, dev);
diff -ruN linux-2.5.45.org/net/ipv6/exthdrs.c linux-2.5.45/net/ipv6/exthdrs.c
--- linux-2.5.45.org/net/ipv6/exthdrs.c	Thu Oct 31 18:00:41 2002
+++ linux-2.5.45/net/ipv6/exthdrs.c	Thu Oct 31 12:44:06 2002
@@ -80,7 +80,7 @@
 
 /* An unknown option is detected, decide what to do */
 
-static int ip6_tlvopt_unknown(struct sk_buff *skb, int optoff)
+int ip6_tlvopt_unknown(struct sk_buff *skb, int optoff)
 {
 	switch ((skb->nh.raw[optoff] & 0xC0) >> 6) {
 	case 0: /* ignore */
diff -ruN linux-2.5.45.org/net/ipv6/mobile_ip6/ha.h linux-2.5.45/net/ipv6/mobile_ip6/ha.h
--- linux-2.5.45.org/net/ipv6/mobile_ip6/ha.h	Thu Oct 31 18:00:42 2002
+++ linux-2.5.45/net/ipv6/mobile_ip6/ha.h	Thu Oct 31 15:43:25 2002
@@ -258,6 +258,13 @@
 	if (*lifetime > MAX_RR_BINDING_LIFE)
 		*lifetime = MAX_RR_BINDING_LIFE;
 }
+
+static __inline__ int mipv6_del_tnl_to_mn(struct in6_addr *coa, 
+			struct in6_addr *ha_addr, struct in6_addr *home_addr)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_IPV6_MOBILITY_HA */
 
 #endif
diff -ruN linux-2.5.45.org/net/ipv6/mobile_ip6/hashlist.c linux-2.5.45/net/ipv6/mobile_ip6/hashlist.c
--- linux-2.5.45.org/net/ipv6/mobile_ip6/hashlist.c	Thu Oct 31 18:00:42 2002
+++ linux-2.5.45/net/ipv6/mobile_ip6/hashlist.c	Thu Oct 31 16:21:08 2002
@@ -115,7 +115,9 @@
 	}
 
 	if (hashlist->kmem) {
+#if 0
 		kmem_cache_destroy(hashlist->kmem);
+#endif
 		hashlist->kmem = NULL;
 	}
 
diff -ruN linux-2.5.45.org/net/ipv6/mobile_ip6/bcache.c linux-2.5.45/net/ipv6/mobile_ip6/bcache.c
--- linux-2.5.45.org/net/ipv6/mobile_ip6/bcache.c	Thu Oct 31 18:00:42 2002
+++ linux-2.5.45/net/ipv6/mobile_ip6/bcache.c	Thu Oct 31 16:31:47 2002
@@ -905,7 +905,7 @@
 	del_timer(&bcache->callback_timer);
 
 	while ((entry = (struct mipv6_bcache_entry *)
-		hashlist_get_first(bcache->entries)) != NULL) {
+				hashlist_get_first(bcache->entries)) != NULL) {
 		hashkey.a1 = &entry->home_addr;
 		hashkey.a2 = &entry->our_addr;
 
diff -ruN linux-2.5.45.org/net/ipv6/mobile_ip6/halist.c linux-2.5.45/net/ipv6/mobile_ip6/halist.c
--- linux-2.5.45.org/net/ipv6/mobile_ip6/halist.c	Thu Oct 31 18:00:42 2002
+++ linux-2.5.45/net/ipv6/mobile_ip6/halist.c	Thu Oct 31 16:59:17 2002
@@ -472,7 +472,9 @@
 	DEBUG(DBG_INFO, "Stopping the timer");
 	del_timer(&home_agents->expire_timer);
 
+#if 0
 	mipv6_halist_gc(1);
+#endif
 	hashlist_destroy(home_agents->entries);
 
 	proc_net_remove("mip6_home_agents");
diff -ruN linux-2.5.45.org/include/net/ip6_route.h linux-2.5.45/include/net/ip6_route.h
--- linux-2.5.45.org/include/net/ip6_route.h	Thu Oct 31 18:00:41 2002
+++ linux-2.5.45/include/net/ip6_route.h	Thu Oct 31 15:09:50 2002
@@ -37,6 +37,7 @@
 extern int			ipv6_route_ioctl(unsigned int cmd, void *arg);
 
 extern int			ip6_route_add(struct in6_rtmsg *rtmsg);
+extern int			ip6_route_del(struct in6_rtmsg *rtmsg);
 extern int			ip6_del_rt(struct rt6_info *);
 
 extern int			ip6_rt_addr_add(struct in6_addr *addr,
diff -ruN linux-2.5.45.org/include/linux/sysctl.h linux-2.5.45/include/linux/sysctl.h
--- linux-2.5.45.org/include/linux/sysctl.h	Thu Oct 31 18:00:41 2002
+++ linux-2.5.45/include/linux/sysctl.h	Thu Oct 31 12:32:08 2002
@@ -359,7 +359,7 @@
 	NET_IPV6_NEIGH=17,
 	NET_IPV6_ROUTE=18,
 	NET_IPV6_ICMP=19,
-	NET_IPV6_BINDV6ONLY=20
+	NET_IPV6_BINDV6ONLY=20,
 	NET_IPV6_MOBILITY=21
 };
 
---------------------------- End of Patch -------------------------------------
