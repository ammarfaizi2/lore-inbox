Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132451AbRAXGSW>; Wed, 24 Jan 2001 01:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRAXGSM>; Wed, 24 Jan 2001 01:18:12 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:7408 "EHLO halfway")
	by vger.kernel.org with ESMTP id <S132451AbRAXGSJ>;
	Wed, 24 Jan 2001 01:18:09 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: torvalds@transmeta.com, davem@redhat.com
cc: linux-kernel@vger.kernel.org, netfilter-devel@us5.samba.org
Subject: [PATCH] fixes for 2.4.1
Date: Wed, 24 Jan 2001 17:17:56 +1100
Message-Id: <E14LJFl-0004B5-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the only netfilter bug-fixes pending for 2.4.1:
	o Rename enum to avoid IPv4/IPv6 clash
	o Fix NAT overlap case.
	o Fix obscure masquerade-breaks fwmark routing problem.
	o Fix mangle align problem (for non-x86).

There are also some feature enhancements pending, but they can wait
for 2.4.2 (dropped table, adjustable hash sizes, multi-port FTP).

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK

--- working-2.4.0-test13-3/include/linux/netfilter_ipv6.h.~1~	Tue May 23 02:50:55 2000
+++ working-2.4.0-test13-3/include/linux/netfilter_ipv6.h	Tue Jan  2 10:27:51 2001
@@ -54,7 +54,7 @@
 #define NF_IP6_NUMHOOKS		5
 
 
-enum nf_ip_hook_priorities {
+enum nf_ip6_hook_priorities {
 	NF_IP6_PRI_FIRST = INT_MIN,
 	NF_IP6_PRI_CONNTRACK = -200,
 	NF_IP6_PRI_MANGLE = -150,
diff -urN -I \$.*\$ -X /tmp/kerndiff.QgcCTD --minimal linux-2.4.1-pre10/net/ipv4/netfilter/ip_nat_core.c working-2.4.1-pre10/net/ipv4/netfilter/ip_nat_core.c
--- linux-2.4.1-pre10/net/ipv4/netfilter/ip_nat_core.c	Fri Aug 11 05:35:15 2000
+++ working-2.4.1-pre10/net/ipv4/netfilter/ip_nat_core.c	Wed Jan 24 17:16:07 2001
@@ -438,8 +438,27 @@
 								conntrack));
 				ret = 1;
 				goto clear_fulls;
+			} else if (HOOK2MANIP(hooknum) == IP_NAT_MANIP_DST) {
+				/* Try implicit source NAT; protocol
+                                   may be able to play with ports to
+                                   make it unique. */
+				struct ip_nat_range r
+					= { IP_NAT_RANGE_MAP_IPS, 
+					    tuple->src.ip, tuple->src.ip,
+					    { 0 }, { 0 } };
+				DEBUGP("Trying implicit mapping\n");
+				if (proto->unique_tuple(tuple, &r,
+							IP_NAT_MANIP_SRC,
+							conntrack)) {
+					/* Must be unique. */
+					IP_NF_ASSERT(!ip_nat_used_tuple
+						     (tuple, conntrack));
+					ret = 1;
+					goto clear_fulls;
+				}
 			}
-			DEBUGP("Protocol can't get unique tuple.\n");
+			DEBUGP("Protocol can't get unique tuple %u.\n",
+			       hooknum);
 		}
 
 		/* Eliminate that from range, and try again. */
diff -urN -I \$.*\$ -X /tmp/kerndiff.QgcCTD --minimal linux-2.4.1-pre10/net/ipv4/netfilter/ipt_MASQUERADE.c working-2.4.1-pre10/net/ipv4/netfilter/ipt_MASQUERADE.c
--- linux-2.4.1-pre10/net/ipv4/netfilter/ipt_MASQUERADE.c	Fri Aug 11 05:35:15 2000
+++ working-2.4.1-pre10/net/ipv4/netfilter/ipt_MASQUERADE.c	Wed Jan 24 17:15:58 2001
@@ -68,6 +68,7 @@
 	struct ip_nat_multi_range newrange;
 	u_int32_t newsrc;
 	struct rtable *rt;
+	struct rt_key key;
 
 	IP_NF_ASSERT(hooknum == NF_IP_POST_ROUTING);
 
@@ -82,10 +83,14 @@
 
 	mr = targinfo;
 
-	if (ip_route_output(&rt, (*pskb)->nh.iph->daddr,
-			    0,
-			    RT_TOS((*pskb)->nh.iph->tos)|RTO_CONN,
-			    out->ifindex) != 0) {
+	key.dst = (*pskb)->nh.iph->daddr;
+	key.src = 0; /* Unknown: that's what we're trying to establish */
+	key.tos = RT_TOS((*pskb)->nh.iph->tos)|RTO_CONN;
+	key.oif = out->ifindex;
+#ifdef CONFIG_IP_ROUTE_FWMARK
+	key.fwmark = (*pskb)->nfmark;
+#endif
+	if (ip_route_output_key(&rt, &key) != 0) {
 		/* Shouldn't happen */
 		printk("MASQUERADE: No route: Rusty's brain broke!\n");
 		return NF_DROP;
diff -urN -I \$.*\$ -X /tmp/kerndiff.QgcCTD --minimal linux-2.4.1-pre10/net/ipv4/netfilter/iptable_mangle.c working-2.4.1-pre10/net/ipv4/netfilter/iptable_mangle.c
--- linux-2.4.1-pre10/net/ipv4/netfilter/iptable_mangle.c	Sat Sep 16 15:37:23 2000
+++ working-2.4.1-pre10/net/ipv4/netfilter/iptable_mangle.c	Wed Jan 24 17:16:15 2001
@@ -53,7 +53,7 @@
 		sizeof(struct ipt_entry),
 		sizeof(struct ipt_standard),
 		0, { 0, 0 }, { } },
-	      { { { { sizeof(struct ipt_standard_target), "" } }, { } },
+	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } }, { } },
 		-NF_ACCEPT - 1 } },
 	    /* LOCAL_OUT */
 	    { { { { 0 }, { 0 }, { 0 }, { 0 }, "", "", { 0 }, { 0 }, 0, 0, 0 },
@@ -61,7 +61,7 @@
 		sizeof(struct ipt_entry),
 		sizeof(struct ipt_standard),
 		0, { 0, 0 }, { } },
-	      { { { { sizeof(struct ipt_standard_target), "" } }, { } },
+	      { { { { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" } }, { } },
 		-NF_ACCEPT - 1 } }
     },
     /* ERROR */
@@ -70,7 +70,7 @@
 	sizeof(struct ipt_entry),
 	sizeof(struct ipt_error),
 	0, { 0, 0 }, { } },
-      { { { { sizeof(struct ipt_error_target), IPT_ERROR_TARGET } },
+      { { { { IPT_ALIGN(sizeof(struct ipt_error_target)), IPT_ERROR_TARGET } },
 	  { } },
 	"ERROR"
       }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
