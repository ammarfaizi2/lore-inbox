Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUDAMGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 07:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbUDAMGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 07:06:48 -0500
Received: from raven.ecs.soton.ac.uk ([152.78.70.1]:43146 "EHLO
	raven.ecs.soton.ac.uk") by vger.kernel.org with ESMTP
	id S262877AbUDAMGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 07:06:42 -0500
Date: Thu, 1 Apr 2004 13:06:38 +0100
From: Hugo Mills <hugo@soton.ac.uk>
To: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Cc: hugo-lkml@carfax.org.uk
Subject: [PATCH] RFC3514 packet filtering
Message-ID: <20040401120638.GB30129@soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-MailScanner-Information: Please contact helpdesk@ecs.soton.ac.uk for more information
X-ECS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   This patch provides an RFC3514 filter for iptables. This is the
kernel half of the patch, against 2.6.5-rc3.

   Please cc: replies to me -- I'm having some trouble subscribing to
linux-kernel at the moment.

   Hugo.

diff -uNr linux-2.6/include/linux/netfilter_ipv4/ipt_evil.h linux-2.6-ipt-evil/include/linux/netfilter_ipv4/ipt_evil.h
--- linux-2.6/include/linux/netfilter_ipv4/ipt_evil.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ipt-evil/include/linux/netfilter_ipv4/ipt_evil.h	2004-03-15 22:05:34.268945232 +0000
@@ -0,0 +1,7 @@
+#ifndef _IPT_EVIL_H
+#define _IPT_EVIL_H
+
+struct ipt_evil_info {
+	int	invert;
+};
+#endif /*_IPT_EVIL_H*/
diff -uNr linux-2.6/include/net/ip.h linux-2.6-ipt-evil/include/net/ip.h
--- linux-2.6/include/net/ip.h	2003-09-08 19:50:16.000000000 +0000
+++ linux-2.6-ipt-evil/include/net/ip.h	2004-03-15 20:43:33.349763049 +0000
@@ -71,6 +71,7 @@
 
 /* IP flags. */
 #define IP_CE		0x8000		/* Flag: "Congestion"		*/
+#define IP_EVIL	0x8000		/* Flag: "Evil" (RFC 3514)	*/
 #define IP_DF		0x4000		/* Flag: "Don't Fragment"	*/
 #define IP_MF		0x2000		/* Flag: "More Fragments"	*/
 #define IP_OFFSET	0x1FFF		/* "Fragment Offset" part	*/
diff -uNr linux-2.6/net/ipv4/netfilter/Kconfig linux-2.6-ipt-evil/net/ipv4/netfilter/Kconfig
--- linux-2.6/net/ipv4/netfilter/Kconfig	2004-03-15 21:47:01.353917514 +0000
+++ linux-2.6-ipt-evil/net/ipv4/netfilter/Kconfig	2004-03-15 20:56:08.577655525 +0000
@@ -274,6 +274,15 @@
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
+config IP_NF_MATCH_EVIL
+	tristate "Evil bit match support"
+	depends on IP_NF_IPTABLES
+	help
+	  Matches the "Evil" bit in the IP header. See RFC 3514 for 
+	  details.
+
+	  To compile it as a module, choose M here.  If unsure, say N.
+
 # The targets
 config IP_NF_FILTER
 	tristate "Packet filtering"
diff -uNr linux-2.6/net/ipv4/netfilter/Makefile linux-2.6-ipt-evil/net/ipv4/netfilter/Makefile
--- linux-2.6/net/ipv4/netfilter/Makefile	2003-09-08 19:49:57.000000000 +0000
+++ linux-2.6-ipt-evil/net/ipv4/netfilter/Makefile	2004-03-15 20:59:18.934937734 +0000
@@ -66,6 +66,8 @@
 
 obj-$(CONFIG_IP_NF_MATCH_PHYSDEV) += ipt_physdev.o
 
+obj-$(CONFIG_IP_NF_MATCH_EVIL) += ipt_evil.o
+
 # targets
 obj-$(CONFIG_IP_NF_TARGET_REJECT) += ipt_REJECT.o
 obj-$(CONFIG_IP_NF_TARGET_TOS) += ipt_TOS.o
diff -uNr linux-2.6/net/ipv4/netfilter/ipt_evil.c linux-2.6-ipt-evil/net/ipv4/netfilter/ipt_evil.c
--- linux-2.6/net/ipv4/netfilter/ipt_evil.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-ipt-evil/net/ipv4/netfilter/ipt_evil.c	2004-03-15 21:16:21.991019291 +0000
@@ -0,0 +1,67 @@
+/* (C) 2004 Hugo Mills <hugo@carfax.org.uk>
+ * Structure copied/stolen from ipt_pkttype.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/if_ether.h>
+#include <linux/if_packet.h>
+#include <net/ip.h>
+
+#include <linux/netfilter_ipv4/ipt_evil.h>
+#include <linux/netfilter_ipv4/ip_tables.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hugo Mills <hugo@carfax.org.uk>");
+MODULE_DESCRIPTION("IP tables match to match on evil bit (RFC 3514)");
+
+static int match(const struct sk_buff *skb,
+      const struct net_device *in,
+      const struct net_device *out,
+      const void *matchinfo,
+      int offset,
+      int *hotdrop)
+{
+    const struct ipt_evil_info *info = matchinfo;
+
+	if(skb->nh.iph->frag_off & __constant_htons(IP_EVIL))
+		return !info->invert;
+
+	return info->invert;
+}
+
+static int checkentry(const char *tablename,
+		   const struct ipt_ip *ip,
+		   void *matchinfo,
+		   unsigned int matchsize,
+		   unsigned int hook_mask)
+{
+	if (matchsize != IPT_ALIGN(sizeof(struct ipt_evil_info)))
+		return 0;
+
+	return 1;
+}
+
+static struct ipt_match evil_match = {
+	.name		= "evil",
+	.match		= &match,
+	.checkentry	= &checkentry,
+	.me		= THIS_MODULE,
+};
+
+static int __init init(void)
+{
+	return ipt_register_match(&evil_match);
+}
+
+static void __exit fini(void)
+{
+	ipt_unregister_match(&evil_match);
+}
+
+module_init(init);
+module_exit(fini);


-- 
 --- Hugo Mills - <hugo@soton.ac.uk> - ECS at Southampton University --- 
          --- Comb-e-chem project: http://www.combechem.org/ ---         
              Quantum Mechanics: The dreams stuff is made of             
