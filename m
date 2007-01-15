Return-Path: <linux-kernel-owner+w=401wt.eu-S1750747AbXAOOmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXAOOmB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 09:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXAOOmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 09:42:01 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37900 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbXAOOl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 09:41:59 -0500
Date: Mon, 15 Jan 2007 15:40:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Patrick McHardy <kaber@trash.net>
cc: David Madore <david.madore@ens.fr>,
       Netfilter Developer Mailing List 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: ipt->xt (was: implement TCPMSS target for IPv6)
In-Reply-To: <45AB54E5.6060103@trash.net>
Message-ID: <Pine.LNX.4.61.0701151526300.13639@yvahk01.tjqt.qr>
References: <20070114192011.GA6270@clipper.ens.fr>
 <Pine.LNX.4.61.0701142110250.11926@yvahk01.tjqt.qr> <45AB3DCA.9020204@trash.net>
 <Pine.LNX.4.61.0701151109540.32479@yvahk01.tjqt.qr> <45AB54E5.6060103@trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 15 2007 11:18, Patrick McHardy wrote:
>> 
>>>I'm not sure how well that will work (the IPv4/IPv6-specific stuff
>>>is spread over the entire target function), but its worth a try.
>> 
>> 
>> "Nothing is impossible." Since you happened to take that one for
>> yourself... well here's a q: would a patch be accepted that changes
>> all ipt and ip6t modules to the new xt? Even if a module is only for
>> ipv4 or ipv6, I think it makes sense to reduce the number of
>> different *t structures floating around.
>
>If you're talking about using the xt-structures in net/ipv[46]/netfilter
>and removing the ipt/ip6t-wrappers, that would make sense IMO.
>

How about this for a start?

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_CLUSTERIP.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -26,6 +26,7 @@
 
 #include <linux/netfilter_arp.h>
 
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_CLUSTERIP.h>
 #include <net/netfilter/nf_conntrack_compat.h>
@@ -42,7 +43,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_DESCRIPTION("iptables target for CLUSTERIP");
+MODULE_DESCRIPTION("xtables target for CLUSTERIP");
 
 struct clusterip_config {
 	struct list_head list;			/* list of all configs */
@@ -329,7 +330,7 @@ target(struct sk_buff **pskb,
 	if ((*pskb)->nh.iph->protocol == IPPROTO_ICMP
 	    && (ctinfo == IP_CT_RELATED 
 		|| ctinfo == IP_CT_RELATED+IP_CT_IS_REPLY))
-		return IPT_CONTINUE;
+		return XT_CONTINUE;
 
 	/* ip_conntrack_icmp guarantees us that we only have ICMP_ECHO, 
 	 * TIMESTAMP, INFO_REQUEST or ADDRESS type icmp packets from here
@@ -367,7 +368,7 @@ target(struct sk_buff **pskb,
 	 * actually a unicast IP packet. TCP doesn't like PACKET_MULTICAST */
 	(*pskb)->pkt_type = PACKET_HOST;
 
-	return IPT_CONTINUE;
+	return XT_CONTINUE;
 }
 
 static int
@@ -470,8 +471,9 @@ static void destroy(const struct xt_targ
 	nf_ct_l3proto_module_put(target->family);
 }
 
-static struct ipt_target clusterip_tgt = {
+static struct xt_target clusterip_tgt = {
 	.name		= "CLUSTERIP",
+	.family		= AF_INET,
 	.target		= target,
 	.targetsize	= sizeof(struct ipt_clusterip_tgt_info),
 	.checkentry	= checkentry,
@@ -727,7 +729,7 @@ static int __init ipt_clusterip_init(voi
 {
 	int ret;
 
-	ret = ipt_register_target(&clusterip_tgt);
+	ret = xt_register_target(&clusterip_tgt);
 	if (ret < 0)
 		return ret;
 
@@ -753,7 +755,7 @@ cleanup_hook:
 	nf_unregister_hook(&cip_arp_ops);
 #endif /* CONFIG_PROC_FS */
 cleanup_target:
-	ipt_unregister_target(&clusterip_tgt);
+	xt_unregister_target(&clusterip_tgt);
 	return ret;
 }
 
@@ -765,7 +767,7 @@ static void __exit ipt_clusterip_fini(vo
 	remove_proc_entry(clusterip_procdir->name, clusterip_procdir->parent);
 #endif
 	nf_unregister_hook(&cip_arp_ops);
-	ipt_unregister_target(&clusterip_tgt);
+	xt_unregister_target(&clusterip_tgt);
 }
 
 module_init(ipt_clusterip_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ECN.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_ECN.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ECN.c
@@ -9,18 +9,20 @@
  * ipt_ECN.c,v 1.5 2002/08/18 19:36:51 laforge Exp
 */
 
+#include <linux/in.h>
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <net/checksum.h>
 
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_ECN.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_DESCRIPTION("iptables ECN modification module");
+MODULE_DESCRIPTION("xtables ECN modification module");
 
 /* set ECT codepoint from IP header.
  * 	return 0 if there was an error. */
@@ -95,7 +97,7 @@ target(struct sk_buff **pskb,
 		if (!set_ect_tcp(pskb, einfo))
 			return NF_DROP;
 
-	return IPT_CONTINUE;
+	return XT_CONTINUE;
 }
 
 static int
@@ -119,7 +121,7 @@ checkentry(const char *tablename,
 		return 0;
 	}
 	if ((einfo->operation & (IPT_ECN_OP_SET_ECE|IPT_ECN_OP_SET_CWR))
-	    && (e->ip.proto != IPPROTO_TCP || (e->ip.invflags & IPT_INV_PROTO))) {
+	    && (e->ip.proto != IPPROTO_TCP || (e->ip.invflags & XT_INV_PROTO))) {
 		printk(KERN_WARNING "ECN: cannot use TCP operations on a "
 		       "non-tcp rule\n");
 		return 0;
@@ -127,8 +129,9 @@ checkentry(const char *tablename,
 	return 1;
 }
 
-static struct ipt_target ipt_ecn_reg = {
+static struct xt_target ipt_ecn_reg = {
 	.name		= "ECN",
+	.family		= AF_INET,
 	.target		= target,
 	.targetsize	= sizeof(struct ipt_ECN_info),
 	.table		= "mangle",
@@ -138,12 +141,12 @@ static struct ipt_target ipt_ecn_reg = {
 
 static int __init ipt_ecn_init(void)
 {
-	return ipt_register_target(&ipt_ecn_reg);
+	return xt_register_target(&ipt_ecn_reg);
 }
 
 static void __exit ipt_ecn_fini(void)
 {
-	ipt_unregister_target(&ipt_ecn_reg);
+	xt_unregister_target(&ipt_ecn_reg);
 }
 
 module_init(ipt_ecn_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_LOG.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_LOG.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_LOG.c
@@ -20,12 +20,12 @@
 #include <net/route.h>
 
 #include <linux/netfilter.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ipt_LOG.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
-MODULE_DESCRIPTION("iptables syslog logging module");
+MODULE_DESCRIPTION("xtables syslog logging module");
 
 #if 0
 #define DEBUGP printk
@@ -432,7 +432,7 @@ ipt_log_target(struct sk_buff **pskb,
 
 	ipt_log_packet(PF_INET, hooknum, *pskb, in, out, &li,
 	               loginfo->prefix);
-	return IPT_CONTINUE;
+	return XT_CONTINUE;
 }
 
 static int ipt_log_checkentry(const char *tablename,
@@ -455,8 +455,9 @@ static int ipt_log_checkentry(const char
 	return 1;
 }
 
-static struct ipt_target ipt_log_reg = {
+static struct xt_target ipt_log_reg = {
 	.name		= "LOG",
+	.family		= AF_INET,
 	.target		= ipt_log_target,
 	.targetsize	= sizeof(struct ipt_log_info),
 	.checkentry	= ipt_log_checkentry,
@@ -471,7 +472,7 @@ static struct nf_logger ipt_log_logger =
 
 static int __init ipt_log_init(void)
 {
-	if (ipt_register_target(&ipt_log_reg))
+	if (xt_register_target(&ipt_log_reg))
 		return -EINVAL;
 	if (nf_log_register(PF_INET, &ipt_log_logger) < 0) {
 		printk(KERN_WARNING "ipt_LOG: not logging via system console "
@@ -486,7 +487,7 @@ static int __init ipt_log_init(void)
 static void __exit ipt_log_fini(void)
 {
 	nf_log_unregister_logger(&ipt_log_logger);
-	ipt_unregister_target(&ipt_log_reg);
+	xt_unregister_target(&ipt_log_reg);
 }
 
 module_init(ipt_log_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_MASQUERADE.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_MASQUERADE.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_MASQUERADE.c
@@ -25,11 +25,11 @@
 #else
 #include <linux/netfilter_ipv4/ip_nat_rule.h>
 #endif
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
-MODULE_DESCRIPTION("iptables MASQUERADE target module");
+MODULE_DESCRIPTION("xtables MASQUERADE target module");
 
 #if 0
 #define DEBUGP printk
@@ -192,6 +192,7 @@ static struct notifier_block masq_inet_n
 
 static struct ipt_target masquerade = {
 	.name		= "MASQUERADE",
+	.family		= AF_INET,
 	.target		= masquerade_target,
 	.targetsize	= sizeof(struct ip_nat_multi_range_compat),
 	.table		= "nat",
@@ -204,7 +205,7 @@ static int __init ipt_masquerade_init(vo
 {
 	int ret;
 
-	ret = ipt_register_target(&masquerade);
+	ret = xt_register_target(&masquerade);
 
 	if (ret == 0) {
 		/* Register for device down reports */
@@ -218,7 +219,7 @@ static int __init ipt_masquerade_init(vo
 
 static void __exit ipt_masquerade_fini(void)
 {
-	ipt_unregister_target(&masquerade);
+	xt_unregister_target(&masquerade);
 	unregister_netdevice_notifier(&masq_dev_notifier);
 	unregister_inetaddr_notifier(&masq_inet_notifier);	
 }
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_NETMAP.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_NETMAP.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_NETMAP.c
@@ -15,6 +15,7 @@
 #include <linux/netdevice.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
+#include <linux/netfilter/x_tables.h>
 #ifdef CONFIG_NF_NAT_NEEDED
 #include <net/netfilter/nf_nat_rule.h>
 #else
@@ -24,7 +25,7 @@
 #define MODULENAME "NETMAP"
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Svenning Soerensen <svenning@post5.tele.dk>");
-MODULE_DESCRIPTION("iptables 1:1 NAT mapping of IP networks target");
+MODULE_DESCRIPTION("xtables 1:1 NAT mapping of IP networks target");
 
 #if 0
 #define DEBUGP printk
@@ -90,6 +91,7 @@ target(struct sk_buff **pskb,
 
 static struct ipt_target target_module = { 
 	.name 		= MODULENAME,
+	.family		= AF_INET,
 	.target 	= target, 
 	.targetsize	= sizeof(struct ip_nat_multi_range_compat),
 	.table		= "nat",
@@ -101,12 +103,12 @@ static struct ipt_target target_module =
 
 static int __init ipt_netmap_init(void)
 {
-	return ipt_register_target(&target_module);
+	return xt_register_target(&target_module);
 }
 
 static void __exit ipt_netmap_fini(void)
 {
-	ipt_unregister_target(&target_module);
+	xt_unregister_target(&target_module);
 }
 
 module_init(ipt_netmap_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_REDIRECT.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_REDIRECT.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_REDIRECT.c
@@ -18,6 +18,7 @@
 #include <net/protocol.h>
 #include <net/checksum.h>
 #include <linux/netfilter_ipv4.h>
+#include <linux/netfilter/x_tables.h>
 #ifdef CONFIG_NF_NAT_NEEDED
 #include <net/netfilter/nf_nat_rule.h>
 #else
@@ -26,7 +27,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
-MODULE_DESCRIPTION("iptables REDIRECT target module");
+MODULE_DESCRIPTION("xtables REDIRECT target module");
 
 #if 0
 #define DEBUGP printk
@@ -106,6 +107,7 @@ redirect_target(struct sk_buff **pskb,
 
 static struct ipt_target redirect_reg = {
 	.name		= "REDIRECT",
+	.family		= AF_INET,
 	.target		= redirect_target,
 	.targetsize	= sizeof(struct ip_nat_multi_range_compat),
 	.table		= "nat",
@@ -116,12 +118,12 @@ static struct ipt_target redirect_reg = 
 
 static int __init ipt_redirect_init(void)
 {
-	return ipt_register_target(&redirect_reg);
+	return xt_register_target(&redirect_reg);
 }
 
 static void __exit ipt_redirect_fini(void)
 {
-	ipt_unregister_target(&redirect_reg);
+	xt_unregister_target(&redirect_reg);
 }
 
 module_init(ipt_redirect_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_REJECT.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_REJECT.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_REJECT.c
@@ -22,6 +22,7 @@
 #include <net/tcp.h>
 #include <net/route.h>
 #include <net/dst.h>
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_REJECT.h>
 #ifdef CONFIG_BRIDGE_NETFILTER
@@ -30,7 +31,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
-MODULE_DESCRIPTION("iptables REJECT target module");
+MODULE_DESCRIPTION("xtables REJECT target module");
 
 #if 0
 #define DEBUGP printk
@@ -230,7 +231,7 @@ static int check(const char *tablename,
 	} else if (rejinfo->with == IPT_TCP_RESET) {
 		/* Must specify that it's a TCP packet */
 		if (e->ip.proto != IPPROTO_TCP
-		    || (e->ip.invflags & IPT_INV_PROTO)) {
+		    || (e->ip.invflags & XT_INV_PROTO)) {
 			DEBUGP("REJECT: TCP_RESET invalid for non-tcp\n");
 			return 0;
 		}
@@ -238,8 +239,9 @@ static int check(const char *tablename,
 	return 1;
 }
 
-static struct ipt_target ipt_reject_reg = {
+static struct xt_target ipt_reject_reg = {
 	.name		= "REJECT",
+	.family		= AF_INET,
 	.target		= reject,
 	.targetsize	= sizeof(struct ipt_reject_info),
 	.table		= "filter",
@@ -251,12 +253,12 @@ static struct ipt_target ipt_reject_reg 
 
 static int __init ipt_reject_init(void)
 {
-	return ipt_register_target(&ipt_reject_reg);
+	return xt_register_target(&ipt_reject_reg);
 }
 
 static void __exit ipt_reject_fini(void)
 {
-	ipt_unregister_target(&ipt_reject_reg);
+	xt_unregister_target(&ipt_reject_reg);
 }
 
 module_init(ipt_reject_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_SAME.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_SAME.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_SAME.c
@@ -34,6 +34,7 @@
 #include <net/protocol.h>
 #include <net/checksum.h>
 #include <linux/netfilter_ipv4.h>
+#include <linux/netfilter/x_tables.h>
 #ifdef CONFIG_NF_NAT_NEEDED
 #include <net/netfilter/nf_nat_rule.h>
 #else
@@ -43,7 +44,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Martin Josefsson <gandalf@wlug.westbo.se>");
-MODULE_DESCRIPTION("iptables special SNAT module for consistent sourceip");
+MODULE_DESCRIPTION("xtables special SNAT module for consistent sourceip");
 
 #if 0
 #define DEBUGP printk
@@ -186,8 +187,9 @@ same_target(struct sk_buff **pskb,
 	return ip_nat_setup_info(ct, &newrange, hooknum);
 }
 
-static struct ipt_target same_reg = { 
+static struct xt_target same_reg = {
 	.name		= "SAME",
+	.family		= AF_INET,
 	.target		= same_target,
 	.targetsize	= sizeof(struct ipt_same_info),
 	.table		= "nat",
@@ -199,12 +201,12 @@ static struct ipt_target same_reg = { 
 
 static int __init ipt_same_init(void)
 {
-	return ipt_register_target(&same_reg);
+	return xt_register_target(&same_reg);
 }
 
 static void __exit ipt_same_fini(void)
 {
-	ipt_unregister_target(&same_reg);
+	xt_unregister_target(&same_reg);
 }
 
 module_init(ipt_same_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_TOS.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_TOS.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_TOS.c
@@ -13,12 +13,12 @@
 #include <linux/ip.h>
 #include <net/checksum.h>
 
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ipt_TOS.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Netfilter Core Team <coreteam@netfilter.org>");
-MODULE_DESCRIPTION("iptables TOS mangling module");
+MODULE_DESCRIPTION("xtables TOS mangling module");
 
 static unsigned int
 target(struct sk_buff **pskb,
@@ -40,7 +40,7 @@ target(struct sk_buff **pskb,
 		iph->tos = (iph->tos & IPTOS_PREC_MASK) | tosinfo->tos;
 		nf_csum_replace2(&iph->check, htons(oldtos), htons(iph->tos));
 	}
-	return IPT_CONTINUE;
+	return XT_CONTINUE;
 }
 
 static int
@@ -63,8 +63,9 @@ checkentry(const char *tablename,
 	return 1;
 }
 
-static struct ipt_target ipt_tos_reg = {
+static struct xt_target ipt_tos_reg = {
 	.name		= "TOS",
+	.family		= AF_INET,
 	.target		= target,
 	.targetsize	= sizeof(struct ipt_tos_target_info),
 	.table		= "mangle",
@@ -74,12 +75,12 @@ static struct ipt_target ipt_tos_reg = {
 
 static int __init ipt_tos_init(void)
 {
-	return ipt_register_target(&ipt_tos_reg);
+	return xt_register_target(&ipt_tos_reg);
 }
 
 static void __exit ipt_tos_fini(void)
 {
-	ipt_unregister_target(&ipt_tos_reg);
+	xt_unregister_target(&ipt_tos_reg);
 }
 
 module_init(ipt_tos_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_TTL.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_TTL.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_TTL.c
@@ -12,11 +12,11 @@
 #include <linux/ip.h>
 #include <net/checksum.h>
 
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ipt_TTL.h>
 
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_DESCRIPTION("IP tables TTL modification module");
+MODULE_DESCRIPTION("xtables TTL modification module");
 MODULE_LICENSE("GPL");
 
 static unsigned int 
@@ -59,7 +59,7 @@ ipt_ttl_target(struct sk_buff **pskb,
 		iph->ttl = new_ttl;
 	}
 
-	return IPT_CONTINUE;
+	return XT_CONTINUE;
 }
 
 static int ipt_ttl_checkentry(const char *tablename,
@@ -80,8 +80,9 @@ static int ipt_ttl_checkentry(const char
 	return 1;
 }
 
-static struct ipt_target ipt_TTL = { 
+static struct xt_target ipt_TTL = {
 	.name 		= "TTL",
+	.family		= AF_INET,
 	.target 	= ipt_ttl_target, 
 	.targetsize	= sizeof(struct ipt_TTL_info),
 	.table		= "mangle",
@@ -91,12 +92,12 @@ static struct ipt_target ipt_TTL = { 
 
 static int __init ipt_ttl_init(void)
 {
-	return ipt_register_target(&ipt_TTL);
+	return xt_register_target(&ipt_TTL);
 }
 
 static void __exit ipt_ttl_fini(void)
 {
-	ipt_unregister_target(&ipt_TTL);
+	xt_unregister_target(&ipt_TTL);
 }
 
 module_init(ipt_ttl_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ULOG.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_ULOG.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ULOG.c
@@ -57,14 +57,14 @@
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
 #include <linux/netfilter.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ipt_ULOG.h>
 #include <net/sock.h>
 #include <linux/bitops.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Harald Welte <laforge@gnumonks.org>");
-MODULE_DESCRIPTION("iptables userspace logging module");
+MODULE_DESCRIPTION("xtables userspace logging module");
 MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_NFLOG);
 
 #define ULOG_NL_EVENT		111		/* Harald's favorite number */
@@ -132,7 +132,6 @@ static void ulog_send(unsigned int nlgro
 	ub->qlen = 0;
 	ub->skb = NULL;
 	ub->lastnlh = NULL;
-
 }
 
 
@@ -314,7 +313,7 @@ static unsigned int ipt_ulog_target(stru
 
 	ipt_ulog_packet(hooknum, *pskb, in, out, loginfo, NULL);
  
- 	return IPT_CONTINUE;
+ 	return XT_CONTINUE;
 }
  
 static void ipt_logfn(unsigned int pf,
@@ -363,8 +362,9 @@ static int ipt_ulog_checkentry(const cha
 	return 1;
 }
 
-static struct ipt_target ipt_ulog_reg = {
+static struct xt_target ipt_ulog_reg = {
 	.name		= "ULOG",
+	.family		= AF_INET,
 	.target		= ipt_ulog_target,
 	.targetsize	= sizeof(struct ipt_ulog_info),
 	.checkentry	= ipt_ulog_checkentry,
@@ -400,7 +400,7 @@ static int __init ipt_ulog_init(void)
 	if (!nflognl)
 		return -ENOMEM;
 
-	if (ipt_register_target(&ipt_ulog_reg) != 0) {
+	if (xt_register_target(&ipt_ulog_reg) != 0) {
 		sock_release(nflognl->sk_socket);
 		return -EINVAL;
 	}
@@ -419,7 +419,7 @@ static void __exit ipt_ulog_fini(void)
 
 	if (nflog)
 		nf_log_unregister_logger(&ipt_ulog_logger);
-	ipt_unregister_target(&ipt_ulog_reg);
+	xt_unregister_target(&ipt_ulog_reg);
 	sock_release(nflognl->sk_socket);
 
 	/* remove pending timers and free allocated skb's */
@@ -435,7 +435,6 @@ static void __exit ipt_ulog_fini(void)
 			ub->skb = NULL;
 		}
 	}
-
 }
 
 module_init(ipt_ulog_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_addrtype.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_addrtype.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_addrtype.c
@@ -16,11 +16,11 @@
 #include <net/route.h>
 
 #include <linux/netfilter_ipv4/ipt_addrtype.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Patrick McHardy <kaber@trash.net>");
-MODULE_DESCRIPTION("iptables addrtype match");
+MODULE_DESCRIPTION("xtables addrtype match");
 
 static inline int match_type(__be32 addr, u_int16_t mask)
 {
@@ -44,8 +44,9 @@ static int match(const struct sk_buff *s
 	return ret;
 }
 
-static struct ipt_match addrtype_match = {
+static struct xt_match addrtype_match = {
 	.name		= "addrtype",
+	.family		= AF_INET,
 	.match		= match,
 	.matchsize	= sizeof(struct ipt_addrtype_info),
 	.me		= THIS_MODULE
@@ -53,12 +54,12 @@ static struct ipt_match addrtype_match =
 
 static int __init ipt_addrtype_init(void)
 {
-	return ipt_register_match(&addrtype_match);
+	return xt_register_match(&addrtype_match);
 }
 
 static void __exit ipt_addrtype_fini(void)
 {
-	ipt_unregister_match(&addrtype_match);
+	xt_unregister_match(&addrtype_match);
 }
 
 module_init(ipt_addrtype_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ah.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_ah.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ah.c
@@ -6,16 +6,17 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/in.h>
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/ip.h>
 
 #include <linux/netfilter_ipv4/ipt_ah.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Yon Uriarte <yon@astaro.de>");
-MODULE_DESCRIPTION("iptables AH SPI match module");
+MODULE_DESCRIPTION("xtables AH SPI match module");
 
 #ifdef DEBUG_CONNTRACK
 #define duprintf(format, args...) printk(format , ## args)
@@ -86,8 +87,9 @@ checkentry(const char *tablename,
 	return 1;
 }
 
-static struct ipt_match ah_match = {
+static struct xt_match ah_match = {
 	.name		= "ah",
+	.family		= AF_INET,
 	.match		= match,
 	.matchsize	= sizeof(struct ipt_ah),
 	.proto		= IPPROTO_AH,
@@ -97,12 +99,12 @@ static struct ipt_match ah_match = {
 
 static int __init ipt_ah_init(void)
 {
-	return ipt_register_match(&ah_match);
+	return xt_register_match(&ah_match);
 }
 
 static void __exit ipt_ah_fini(void)
 {
-	ipt_unregister_match(&ah_match);
+	xt_unregister_match(&ah_match);
 }
 
 module_init(ipt_ah_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ecn.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_ecn.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ecn.c
@@ -9,15 +9,18 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/in.h>
+#include <linux/ip.h>
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/tcp.h>
 
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/netfilter_ipv4/ipt_ecn.h>
 
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_DESCRIPTION("iptables ECN matching module");
+MODULE_DESCRIPTION("xtables ECN matching module");
 MODULE_LICENSE("GPL");
 
 static inline int match_ip(const struct sk_buff *skb,
@@ -109,8 +112,10 @@ static int checkentry(const char *tablen
 	return 1;
 }
 
-static struct ipt_match ecn_match = {
+static struct xt_match ecn_match = {
 	.name		= "ecn",
+	.family		= AF_INET,
+	.proto		= IPPROTO_TCP,
 	.match		= match,
 	.matchsize	= sizeof(struct ipt_ecn_info),
 	.checkentry	= checkentry,
@@ -119,12 +124,12 @@ static struct ipt_match ecn_match = {
 
 static int __init ipt_ecn_init(void)
 {
-	return ipt_register_match(&ecn_match);
+	return xt_register_match(&ecn_match);
 }
 
 static void __exit ipt_ecn_fini(void)
 {
-	ipt_unregister_match(&ecn_match);
+	xt_unregister_match(&ecn_match);
 }
 
 module_init(ipt_ecn_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_iprange.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_iprange.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_iprange.c
@@ -10,12 +10,12 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/ip.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ipt_iprange.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>");
-MODULE_DESCRIPTION("iptables arbitrary IP range match module");
+MODULE_DESCRIPTION("xtables arbitrary IP range match module");
 
 #if 0
 #define DEBUGP printk
@@ -63,22 +63,22 @@ match(const struct sk_buff *skb,
 	return 1;
 }
 
-static struct ipt_match iprange_match = {
+static struct xt_match iprange_match = {
 	.name		= "iprange",
+	.family		= AF_INET,
 	.match		= match,
 	.matchsize	= sizeof(struct ipt_iprange_info),
-	.destroy	= NULL,
 	.me		= THIS_MODULE
 };
 
 static int __init ipt_iprange_init(void)
 {
-	return ipt_register_match(&iprange_match);
+	return xt_register_match(&iprange_match);
 }
 
 static void __exit ipt_iprange_fini(void)
 {
-	ipt_unregister_match(&iprange_match);
+	xt_unregister_match(&iprange_match);
 }
 
 module_init(ipt_iprange_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_owner.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_owner.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_owner.c
@@ -15,11 +15,11 @@
 #include <net/sock.h>
 
 #include <linux/netfilter_ipv4/ipt_owner.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Marc Boucher <marc@mbsi.ca>");
-MODULE_DESCRIPTION("iptables owner match");
+MODULE_DESCRIPTION("xtables owner match");
 
 static int
 match(const struct sk_buff *skb,
@@ -68,8 +68,9 @@ checkentry(const char *tablename,
 	return 1;
 }
 
-static struct ipt_match owner_match = {
+static struct xt_match owner_match = {
 	.name		= "owner",
+	.family		= AF_INET,
 	.match		= match,
 	.matchsize	= sizeof(struct ipt_owner_info),
 	.hooks		= (1 << NF_IP_LOCAL_OUT) | (1 << NF_IP_POST_ROUTING),
@@ -79,12 +80,12 @@ static struct ipt_match owner_match = {
 
 static int __init ipt_owner_init(void)
 {
-	return ipt_register_match(&owner_match);
+	return xt_register_match(&owner_match);
 }
 
 static void __exit ipt_owner_fini(void)
 {
-	ipt_unregister_match(&owner_match);
+	xt_unregister_match(&owner_match);
 }
 
 module_init(ipt_owner_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_recent.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_recent.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_recent.c
@@ -12,6 +12,7 @@
  * Copyright 2002-2003, Stephen Frost, 2.5.x port by laforge@netfilter.org
  */
 #include <linux/init.h>
+#include <linux/ip.h>
 #include <linux/moduleparam.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -24,11 +25,11 @@
 #include <linux/skbuff.h>
 #include <linux/inet.h>
 
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 #include <linux/netfilter_ipv4/ipt_recent.h>
 
 MODULE_AUTHOR("Patrick McHardy <kaber@trash.net>");
-MODULE_DESCRIPTION("IP tables recently seen matching module");
+MODULE_DESCRIPTION("xtables recently seen matching module");
 MODULE_LICENSE("GPL");
 
 static unsigned int ip_list_tot = 100;
@@ -462,8 +463,9 @@ static struct file_operations recent_fop
 };
 #endif /* CONFIG_PROC_FS */
 
-static struct ipt_match recent_match = {
+static struct xt_match recent_match = {
 	.name		= "recent",
+	.family		= AF_INET,
 	.match		= ipt_recent_match,
 	.matchsize	= sizeof(struct ipt_recent_info),
 	.checkentry	= ipt_recent_checkentry,
@@ -479,13 +481,13 @@ static int __init ipt_recent_init(void)
 		return -EINVAL;
 	ip_list_hash_size = 1 << fls(ip_list_tot);
 
-	err = ipt_register_match(&recent_match);
+	err = xt_register_match(&recent_match);
 #ifdef CONFIG_PROC_FS
 	if (err)
 		return err;
 	proc_dir = proc_mkdir("ipt_recent", proc_net);
 	if (proc_dir == NULL) {
-		ipt_unregister_match(&recent_match);
+		xt_unregister_match(&recent_match);
 		err = -ENOMEM;
 	}
 #endif
@@ -495,7 +497,7 @@ static int __init ipt_recent_init(void)
 static void __exit ipt_recent_exit(void)
 {
 	BUG_ON(!list_empty(&tables));
-	ipt_unregister_match(&recent_match);
+	xt_unregister_match(&recent_match);
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("ipt_recent", proc_net);
 #endif
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_tos.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_tos.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_tos.c
@@ -8,14 +8,15 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/ip.h>
 #include <linux/module.h>
 #include <linux/skbuff.h>
 
 #include <linux/netfilter_ipv4/ipt_tos.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("iptables TOS match module");
+MODULE_DESCRIPTION("xtables TOS match module");
 
 static int
 match(const struct sk_buff *skb,
@@ -32,8 +33,9 @@ match(const struct sk_buff *skb,
 	return (skb->nh.iph->tos == info->tos) ^ info->invert;
 }
 
-static struct ipt_match tos_match = {
+static struct xt_match tos_match = {
 	.name		= "tos",
+	.family		= AF_INET,
 	.match		= match,
 	.matchsize	= sizeof(struct ipt_tos_info),
 	.me		= THIS_MODULE,
@@ -41,12 +43,12 @@ static struct ipt_match tos_match = {
 
 static int __init ipt_multiport_init(void)
 {
-	return ipt_register_match(&tos_match);
+	return xt_register_match(&tos_match);
 }
 
 static void __exit ipt_multiport_fini(void)
 {
-	ipt_unregister_match(&tos_match);
+	xt_unregister_match(&tos_match);
 }
 
 module_init(ipt_multiport_init);
Index: linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ttl.c
===================================================================
--- linux-2.6.20-rc5.orig/net/ipv4/netfilter/ipt_ttl.c
+++ linux-2.6.20-rc5/net/ipv4/netfilter/ipt_ttl.c
@@ -9,14 +9,15 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/ip.h>
 #include <linux/module.h>
 #include <linux/skbuff.h>
 
 #include <linux/netfilter_ipv4/ipt_ttl.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter/x_tables.h>
 
 MODULE_AUTHOR("Harald Welte <laforge@netfilter.org>");
-MODULE_DESCRIPTION("IP tables TTL matching module");
+MODULE_DESCRIPTION("xtables TTL matching module");
 MODULE_LICENSE("GPL");
 
 static int match(const struct sk_buff *skb,
@@ -48,8 +49,9 @@ static int match(const struct sk_buff *s
 	return 0;
 }
 
-static struct ipt_match ttl_match = {
+static struct xt_match ttl_match = {
 	.name		= "ttl",
+	.family		= AF_INET,
 	.match		= match,
 	.matchsize	= sizeof(struct ipt_ttl_info),
 	.me		= THIS_MODULE,
@@ -57,13 +59,12 @@ static struct ipt_match ttl_match = {
 
 static int __init ipt_ttl_init(void)
 {
-	return ipt_register_match(&ttl_match);
+	return xt_register_match(&ttl_match);
 }
 
 static void __exit ipt_ttl_fini(void)
 {
-	ipt_unregister_match(&ttl_match);
-
+	xt_unregister_match(&ttl_match);
 }
 
 module_init(ipt_ttl_init);
#<EOF>

	-`J'
-- 
