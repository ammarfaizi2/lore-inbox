Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbRAJXjD>; Wed, 10 Jan 2001 18:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135908AbRAJXio>; Wed, 10 Jan 2001 18:38:44 -0500
Received: from linuxcare.com.au ([203.29.91.49]:32785 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S132301AbRAJXiY>; Wed, 10 Jan 2001 18:38:24 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: torvalds@transmeta.com, Frank Dekervel <kervel@bakvis.kotnet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netfilter ipv6 as module unresolved symbols 
In-Reply-To: Your message of "Tue, 09 Jan 2001 04:23:29 BST."
             <Pine.LNX.4.21.0101090421410.17358-100000@bakvis.kotnet.org> 
Date: Wed, 10 Jan 2001 21:16:36 +1100
Message-Id: <E14GIJ3-0003Bq-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.21.0101090421410.17358-100000@bakvis.kotnet.org> you wri
te:
> Hello,
> 
> test13-acXX and final-acXX have unresolved symbols, namely
> ipt_register_target and ipt_unregister_target in the module
> ip6t_MARK.o

Yes, IPv6 netfilter is broken.  MARK and mangle should be removed, or
the following patch (by Harald Welte) applied, which:

1) Adds documentation for the config options.
2) Adds the mangle table the configuration option promises
3) Substitutes the IPv4 references which were missed.

Rusty.
--
http://linux.conf.au The Linux conference Australia needed.

diff -urN -I \$.*\$ -X /tmp/kerndiff.v5jn1f --minimal linux-2.4.0-official/Documentation/Configure.help tmp/Documentation/Configure.help
--- linux-2.4.0-official/Documentation/Configure.help	Fri Jan  5 08:00:55 2001
+++ tmp/Documentation/Configure.help	Wed Jan 10 21:04:59 2001
@@ -2052,6 +2052,73 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
+IP6 tables support (required for filtering/masq/NAT)
+CONFIG_IP6_NF_IPTABLES
+  ip6tables is a general, extensible packet identification framework.
+  Currently only the packet filtering and packet mangling subsystem
+  for IPv6 use this, but connection tracking is going to follow.
+  Say 'Y' or 'M' here if you want to use either of those.
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
+IPv6 limit match support
+CONFIG_IP6_NF_MATCH_LIMIT
+  limit matching allows you to control the rate at which a rule can be
+  matched: mainly useful in combination with the LOG target ("LOG
+  target support", below) and to avoid some Denial of Service attacks.
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
+MAC address match support
+CONFIG_IP6_NF_MATCH_MAC
+  mac matching allows you to match packets based on the source
+  ethernet address of the packet.
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
+netfilter mark match support
+CONFIG_IP6_NF_MATCH_MARK
+  Netfilter mark matching allows you to match packets based on the
+  `nfmark' value in the packet.  This can be set by the MARK target
+  (see below).
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
+Packet filtering
+CONFIG_IP6_NF_FILTER
+  Packet filtering defines a table `filter', which has a series of
+  rules for simple packet filtering at local input, forwarding and
+  local output.  See the man page for iptables(8).
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
+Packet mangling
+CONFIG_IP6_NF_MANGLE
+  This option adds a `mangle' table to iptables: see the man page for
+  iptables(8).  This table is used for various packet alterations
+  which can effect how the packet is routed.
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
+MARK target support
+CONFIG_IP6_NF_TARGET_MARK
+  This option adds a `MARK' target, which allows you to create rules
+  in the `mangle' table which alter the netfilter mark (nfmark) field
+  associated with the packet packet prior to routing. This can change
+  the routing method (see `IP: use netfilter MARK value as routing
+  key') and can also be used by other subsystems to change their
+  behavior.
+
+  If you want to compile it as a module, say M here and read
+  Documentation/modules.txt.  If unsure, say `N'.
+
+
 TCP Explicit Congestion Notification support
 CONFIG_INET_ECN
   Explicit Congestion Notification (ECN) allows routers to notify
diff -urN -I \$.*\$ -X /tmp/kerndiff.v5jn1f --minimal linux-2.4.0-official/net/ipv6/netfilter/Makefile tmp/net/ipv6/netfilter/Makefile
--- linux-2.4.0-official/net/ipv6/netfilter/Makefile	Sat Dec 30 09:07:24 2000
+++ tmp/net/ipv6/netfilter/Makefile	Wed Jan 10 21:12:35 2001
@@ -20,5 +20,6 @@
 obj-$(CONFIG_IP6_NF_MATCH_MULTIPORT) += ip6t_multiport.o
 obj-$(CONFIG_IP6_NF_FILTER) += ip6table_filter.o
 obj-$(CONFIG_IP6_NF_TARGET_MARK) += ip6t_MARK.o
+obj-$(CONFIG_IP6_NF_MANGLE) += ip6table_mangle.o
 
 include $(TOPDIR)/Rules.make
diff -urN -I \$.*\$ -X /tmp/kerndiff.v5jn1f --minimal linux-2.4.0-official/net/ipv6/netfilter/ip6_tables.c tmp/net/ipv6/netfilter/ip6_tables.c
--- linux-2.4.0-official/net/ipv6/netfilter/ip6_tables.c	Sat Aug  5 11:18:49 2000
+++ tmp/net/ipv6/netfilter/ip6_tables.c	Wed Jan 10 21:04:59 2001
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
-#include <linux/icmp.h>
+#include <linux/icmpv6.h>
 #include <net/ip.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -1642,7 +1642,7 @@
 
 /* Returns 1 if the type and code is matched by the range, 0 otherwise */
 static inline int
-icmp_type_code_match(u_int8_t test_type, u_int8_t min_code, u_int8_t max_code,
+icmp6_type_code_match(u_int8_t test_type, u_int8_t min_code, u_int8_t max_code,
 		     u_int8_t type, u_int8_t code,
 		     int invert)
 {
@@ -1651,7 +1651,7 @@
 }
 
 static int
-icmp_match(const struct sk_buff *skb,
+icmp6_match(const struct sk_buff *skb,
 	   const struct net_device *in,
 	   const struct net_device *out,
 	   const void *matchinfo,
@@ -1660,7 +1660,7 @@
 	   u_int16_t datalen,
 	   int *hotdrop)
 {
-	const struct icmphdr *icmp = hdr;
+	const struct icmp6hdr *icmp = hdr;
 	const struct ip6t_icmp *icmpinfo = matchinfo;
 
 	if (offset == 0 && datalen < 2) {
@@ -1673,16 +1673,16 @@
 
 	/* Must not be a fragment. */
 	return !offset
-		&& icmp_type_code_match(icmpinfo->type,
+		&& icmp6_type_code_match(icmpinfo->type,
 					icmpinfo->code[0],
 					icmpinfo->code[1],
-					icmp->type, icmp->code,
+					icmp->icmp6_type, icmp->icmp6_code,
 					!!(icmpinfo->invflags&IP6T_ICMP_INV));
 }
 
 /* Called when user tries to insert an entry of this type. */
 static int
-icmp_checkentry(const char *tablename,
+icmp6_checkentry(const char *tablename,
 	   const struct ip6t_ip6 *ipv6,
 	   void *matchinfo,
 	   unsigned int matchsize,
@@ -1691,7 +1691,7 @@
 	const struct ip6t_icmp *icmpinfo = matchinfo;
 
 	/* Must specify proto == ICMP, and no unknown invflags */
-	return ipv6->proto == IPPROTO_ICMP
+	return ipv6->proto == IPPROTO_ICMPV6
 		&& !(ipv6->invflags & IP6T_INV_PROTO)
 		&& matchsize == IP6T_ALIGN(sizeof(struct ip6t_icmp))
 		&& !(icmpinfo->invflags & ~IP6T_ICMP_INV);
@@ -1711,8 +1711,8 @@
 = { { NULL, NULL }, "tcp", &tcp_match, &tcp_checkentry, NULL };
 static struct ip6t_match udp_matchstruct
 = { { NULL, NULL }, "udp", &udp_match, &udp_checkentry, NULL };
-static struct ip6t_match icmp_matchstruct
-= { { NULL, NULL }, "icmp", &icmp_match, &icmp_checkentry, NULL };
+static struct ip6t_match icmp6_matchstruct
+= { { NULL, NULL }, "icmp6", &icmp6_match, &icmp6_checkentry, NULL };
 
 #ifdef CONFIG_PROC_FS
 static inline int print_name(const struct ip6t_table *t,
@@ -1761,7 +1761,7 @@
 	list_append(&ip6t_target, &ip6t_error_target);
 	list_append(&ip6t_match, &tcp_matchstruct);
 	list_append(&ip6t_match, &udp_matchstruct);
-	list_append(&ip6t_match, &icmp_matchstruct);
+	list_append(&ip6t_match, &icmp6_matchstruct);
 	up(&ip6t_mutex);
 
 	/* Register setsockopt */
diff -urN -I \$.*\$ -X /tmp/kerndiff.v5jn1f --minimal linux-2.4.0-official/net/ipv6/netfilter/ip6t_MARK.c tmp/net/ipv6/netfilter/ip6t_MARK.c
--- linux-2.4.0-official/net/ipv6/netfilter/ip6t_MARK.c	Tue May 23 02:50:55 2000
+++ tmp/net/ipv6/netfilter/ip6t_MARK.c	Wed Jan 10 21:04:59 2001
@@ -4,8 +4,8 @@
 #include <linux/ip.h>
 #include <net/checksum.h>
 
-#include <linux/netfilter_ipv4/ip_tables.h>
-#include <linux/netfilter_ipv4/ipt_MARK.h>
+#include <linux/netfilter_ipv6/ip6_tables.h>
+#include <linux/netfilter_ipv6/ip6t_MARK.h>
 
 static unsigned int
 target(struct sk_buff **pskb,
@@ -15,26 +15,26 @@
        const void *targinfo,
        void *userinfo)
 {
-	const struct ipt_mark_target_info *markinfo = targinfo;
+	const struct ip6t_mark_target_info *markinfo = targinfo;
 
 	if((*pskb)->nfmark != markinfo->mark) {
 		(*pskb)->nfmark = markinfo->mark;
 		(*pskb)->nfcache |= NFC_ALTERED;
 	}
-	return IPT_CONTINUE;
+	return IP6T_CONTINUE;
 }
 
 static int
 checkentry(const char *tablename,
-	   const struct ipt_entry *e,
+	   const struct ip6t_entry *e,
            void *targinfo,
            unsigned int targinfosize,
            unsigned int hook_mask)
 {
-	if (targinfosize != IPT_ALIGN(sizeof(struct ipt_mark_target_info))) {
+	if (targinfosize != IP6T_ALIGN(sizeof(struct ip6t_mark_target_info))) {
 		printk(KERN_WARNING "MARK: targinfosize %u != %Zu\n",
 		       targinfosize,
-		       IPT_ALIGN(sizeof(struct ipt_mark_target_info)));
+		       IP6T_ALIGN(sizeof(struct ip6t_mark_target_info)));
 		return 0;
 	}
 
@@ -46,12 +46,13 @@
 	return 1;
 }
 
-static struct ipt_target ipt_mark_reg
+static struct ip6t_target ip6t_mark_reg
 = { { NULL, NULL }, "MARK", target, checkentry, NULL, THIS_MODULE };
 
 static int __init init(void)
 {
-	if (ipt_register_target(&ipt_mark_reg))
+	printk(KERN_DEBUG "registering ipv6 mark target\n");
+	if (ip6t_register_target(&ip6t_mark_reg))
 		return -EINVAL;
 
 	return 0;
@@ -59,7 +60,7 @@
 
 static void __exit fini(void)
 {
-	ipt_unregister_target(&ipt_mark_reg);
+	ip6t_unregister_target(&ip6t_mark_reg);
 }
 
 module_init(init);
diff -urN -I \$.*\$ -X /tmp/kerndiff.v5jn1f --minimal linux-2.4.0-official/net/ipv6/netfilter/ip6t_mark.c tmp/net/ipv6/netfilter/ip6t_mark.c
--- linux-2.4.0-official/net/ipv6/netfilter/ip6t_mark.c	Tue May 23 02:50:55 2000
+++ tmp/net/ipv6/netfilter/ip6t_mark.c	Wed Jan 10 21:04:59 2001
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 
-#include <linux/netfilter_ipv4/ipt_mark.h>
+#include <linux/netfilter_ipv6/ip6t_mark.h>
 #include <linux/netfilter_ipv6/ip6_tables.h>
 
 static int
@@ -15,7 +15,7 @@
       u_int16_t datalen,
       int *hotdrop)
 {
-	const struct ipt_mark_info *info = matchinfo;
+	const struct ip6t_mark_info *info = matchinfo;
 
 	return ((skb->nfmark & info->mask) == info->mark) ^ info->invert;
 }
@@ -27,7 +27,7 @@
            unsigned int matchsize,
            unsigned int hook_mask)
 {
-	if (matchsize != IP6T_ALIGN(sizeof(struct ipt_mark_info)))
+	if (matchsize != IP6T_ALIGN(sizeof(struct ip6t_mark_info)))
 		return 0;
 
 	return 1;
diff -urN -I \$.*\$ -X /tmp/kerndiff.v5jn1f --minimal linux-2.4.0-official/net/ipv6/netfilter/ip6table_mangle.c tmp/net/ipv6/netfilter/ip6table_mangle.c
--- linux-2.4.0-official/net/ipv6/netfilter/ip6table_mangle.c	Thu Jan  1 10:00:00 1970
+++ tmp/net/ipv6/netfilter/ip6table_mangle.c	Wed Jan 10 21:04:59 2001
@@ -0,0 +1,189 @@
+/*
+ * IPv6 packet mangling table, a port of the IPv4 mangle table to IPv6
+ *
+ * Copyright (C) 2000 by Harald Welte <laforge@gnumonks.org>
+ */
+#include <linux/module.h>
+#include <linux/netfilter_ipv6/ip6_tables.h>
+
+#define MANGLE_VALID_HOOKS ((1 << NF_IP6_PRE_ROUTING) | (1 << NF_IP6_LOCAL_OUT))
+
+#if 1
+#define DEBUGP(x, args...)	printk(KERN_DEBUG x, ## args)
+#else
+#define DEBUGP(x, args...)
+#endif
+
+/* Standard entry. */
+struct ip6t_standard
+{
+	struct ip6t_entry entry;
+	struct ip6t_standard_target target;
+};
+
+struct ip6t_error_target
+{
+	struct ip6t_entry_target target;
+	char errorname[IP6T_FUNCTION_MAXNAMELEN];
+};
+
+struct ip6t_error
+{
+	struct ip6t_entry entry;
+	struct ip6t_error_target target;
+};
+
+static struct
+{
+	struct ip6t_replace repl;
+	struct ip6t_standard entries[2];
+	struct ip6t_error term;
+} initial_table __initdata
+= { { "mangle", MANGLE_VALID_HOOKS, 3,
+      sizeof(struct ip6t_standard) * 2 + sizeof(struct ip6t_error),
+      { [NF_IP6_PRE_ROUTING] 0,
+	[NF_IP6_LOCAL_OUT] sizeof(struct ip6t_standard) },
+      { [NF_IP6_PRE_ROUTING] 0,
+	[NF_IP6_LOCAL_OUT] sizeof(struct ip6t_standard) },
+      0, NULL, { } },
+    {
+	    /* PRE_ROUTING */
+	    { { { { { { 0 } } }, { { { 0 } } }, { { { 0 } } }, { { { 0 } } }, "", "", { 0 }, { 0 }, 0, 0, 0 },
+		0,
+		sizeof(struct ip6t_entry),
+		sizeof(struct ip6t_standard),
+		0, { 0, 0 }, { } },
+	      { { { { IP6T_ALIGN(sizeof(struct ip6t_standard_target)), "" } }, { } },
+		-NF_ACCEPT - 1 } },
+	    /* LOCAL_OUT */
+	    { { { { { { 0 } } }, { { { 0 } } }, { { { 0 } } }, { { { 0 } } }, "", "", { 0 }, { 0 }, 0, 0, 0 },
+		0,
+		sizeof(struct ip6t_entry),
+		sizeof(struct ip6t_standard),
+		0, { 0, 0 }, { } },
+	      { { { { IP6T_ALIGN(sizeof(struct ip6t_standard_target)), "" } }, { } },
+		-NF_ACCEPT - 1 } }
+    },
+    /* ERROR */
+    { { { { { { 0 } } }, { { { 0 } } }, { { { 0 } } }, { { { 0 } } }, "", "", { 0 }, { 0 }, 0, 0, 0 },
+	0,
+	sizeof(struct ip6t_entry),
+	sizeof(struct ip6t_error),
+	0, { 0, 0 }, { } },
+      { { { { IP6T_ALIGN(sizeof(struct ip6t_error_target)), IP6T_ERROR_TARGET } },
+	  { } },
+	"ERROR"
+      }
+    }
+};
+
+static struct ip6t_table packet_mangler
+= { { NULL, NULL }, "mangle", &initial_table.repl,
+    MANGLE_VALID_HOOKS, RW_LOCK_UNLOCKED, NULL };
+
+/* The work comes in here from netfilter.c. */
+static unsigned int
+ip6t_hook(unsigned int hook,
+	 struct sk_buff **pskb,
+	 const struct net_device *in,
+	 const struct net_device *out,
+	 int (*okfn)(struct sk_buff *))
+{
+	return ip6t_do_table(pskb, hook, in, out, &packet_mangler, NULL);
+}
+
+static unsigned int
+ip6t_local_out_hook(unsigned int hook,
+		   struct sk_buff **pskb,
+		   const struct net_device *in,
+		   const struct net_device *out,
+		   int (*okfn)(struct sk_buff *))
+{
+
+	unsigned long nfmark;
+	unsigned int ret;
+	struct in6_addr saddr, daddr;
+	u_int8_t hop_limit;
+	u_int32_t flowlabel;
+
+#if 0
+	/* root is playing with raw sockets. */
+	if ((*pskb)->len < sizeof(struct iphdr)
+	    || (*pskb)->nh.iph->ihl * 4 < sizeof(struct iphdr)) {
+		if (net_ratelimit())
+			printk("ip6t_hook: happy cracking.\n");
+		return NF_ACCEPT;
+	}
+#endif
+
+	/* save source/dest address, nfmark, hoplimit, flowlabel, priority,  */
+	memcpy(&saddr, &(*pskb)->nh.ipv6h->saddr, sizeof(saddr));
+	memcpy(&daddr, &(*pskb)->nh.ipv6h->daddr, sizeof(daddr));
+	nfmark = (*pskb)->nfmark;
+	hop_limit = (*pskb)->nh.ipv6h->hop_limit;
+
+	/* flowlabel and prio (includes version, which shouldn't change either */
+	flowlabel = (u_int32_t) (*pskb)->nh.ipv6h;
+
+	ret = ip6t_do_table(pskb, hook, in, out, &packet_mangler, NULL);
+
+	if (ret != NF_DROP && ret != NF_STOLEN 
+		&& (memcmp(&(*pskb)->nh.ipv6h->saddr, &saddr, sizeof(saddr))
+		    || memcmp(&(*pskb)->nh.ipv6h->daddr, &daddr, sizeof(daddr))
+		    || (*pskb)->nfmark != nfmark
+		    || (*pskb)->nh.ipv6h->hop_limit != hop_limit)) {
+
+		/* something which could affect routing has changed */
+
+		DEBUGP("ip6table_mangle: we'd need to re-route a packet\n");
+	}
+
+	return ret;
+}
+
+static struct nf_hook_ops ip6t_ops[]
+= { { { NULL, NULL }, ip6t_hook, PF_INET6, NF_IP6_PRE_ROUTING, NF_IP6_PRI_MANGLE },
+    { { NULL, NULL }, ip6t_local_out_hook, PF_INET6, NF_IP6_LOCAL_OUT,
+		NF_IP6_PRI_MANGLE }
+};
+
+static int __init init(void)
+{
+	int ret;
+
+	/* Register table */
+	ret = ip6t_register_table(&packet_mangler);
+	if (ret < 0)
+		return ret;
+
+	/* Register hooks */
+	ret = nf_register_hook(&ip6t_ops[0]);
+	if (ret < 0)
+		goto cleanup_table;
+
+	ret = nf_register_hook(&ip6t_ops[1]);
+	if (ret < 0)
+		goto cleanup_hook0;
+
+	return ret;
+
+ cleanup_hook0:
+	nf_unregister_hook(&ip6t_ops[0]);
+ cleanup_table:
+	ip6t_unregister_table(&packet_mangler);
+
+	return ret;
+}
+
+static void __exit fini(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < sizeof(ip6t_ops)/sizeof(struct nf_hook_ops); i++)
+		nf_unregister_hook(&ip6t_ops[i]);
+
+	ip6t_unregister_table(&packet_mangler);
+}
+
+module_init(init);
+module_exit(fini);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
