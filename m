Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVAYSEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVAYSEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVAYSEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:04:35 -0500
Received: from twin.jikos.cz ([213.151.79.26]:15542 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S262028AbVAYSEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:04:30 -0500
Date: Tue, 25 Jan 2005 19:04:27 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: coreteam@netfilter.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix linking of ip_nat_tftp.o and ip_conntrack_tftp.o
Message-ID: <Pine.LNX.4.58.0501251901480.32479@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when both nat and connection tracking for TFTP protocol is turned on, the 
linking fails:

net/ipv4/netfilter/ip_nat_tftp.o(.bss+0x0): multiple definition of `ip_nat_tftp_hook'
net/ipv4/netfilter/ip_conntrack_tftp.o(.bss+0x0): first defined here

The following patch fixes it, please apply.

diff -ruN linux-2.6.11-rc2.old/include/linux/netfilter_ipv4/ip_conntrack_tftp.h linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conntrack_tftp.h
--- linux-2.6.11-rc2.old/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2005-01-22 02:47:31.000000000 +0100
+++ linux-2.6.11-rc2/include/linux/netfilter_ipv4/ip_conntrack_tftp.h	2005-01-25 18:50:20.000000000 +0100
@@ -13,7 +13,7 @@
 #define TFTP_OPCODE_ACK		4
 #define TFTP_OPCODE_ERROR	5
 
-unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
+extern unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
 				 enum ip_conntrack_info ctinfo,
 				 struct ip_conntrack_expect *exp);
 
diff -ruN linux-2.6.11-rc2.old/net/ipv4/netfilter/ip_conntrack_tftp.c linux-2.6.11-rc2/net/ipv4/netfilter/ip_conntrack_tftp.c
--- linux-2.6.11-rc2.old/net/ipv4/netfilter/ip_conntrack_tftp.c	2005-01-22 02:47:32.000000000 +0100
+++ linux-2.6.11-rc2/net/ipv4/netfilter/ip_conntrack_tftp.c	2005-01-25 18:47:28.000000000 +0100
@@ -38,9 +38,6 @@
 #define DEBUGP(format, args...)
 #endif
 
-unsigned int (*ip_nat_tftp_hook)(struct sk_buff **pskb,
-				 enum ip_conntrack_info ctinfo,
-				 struct ip_conntrack_expect *exp);
 EXPORT_SYMBOL_GPL(ip_nat_tftp_hook);
 
 static int tftp_help(struct sk_buff **pskb,

-- 
JiKos.
