Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUC1Lys (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUC1Lyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:54:47 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:60169 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261203AbUC1Lyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:54:46 -0500
Date: Sun, 28 Mar 2004 13:54:39 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: [PATCH-2.4.26] ip6tables cleanup
Message-ID: <20040328115439.GA24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, all

2.4.26-rc1 returned this warning compiling ip6_tables :

ip6_tables.c: In function `tcp_match':
ip6_tables.c:1596: warning: implicit declaration of function `ipv6_skip_exthdr'

I had to add a cast because ipv6_skip_exthdr() expects a 'struct sk_buff*' while
its caller uses a 'const struct sk_buff*'. Here is a cleanup patch.

Please apply,
Willy

--- ./net/ipv6/netfilter/ip6_tables.c.orig	Sun Mar 28 10:57:08 2004
+++ ./net/ipv6/netfilter/ip6_tables.c	Sun Mar 28 11:15:55 2004
@@ -23,7 +23,7 @@
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 #include <linux/proc_fs.h>
-
+#include <net/ipv6.h>
 #include <linux/netfilter_ipv6/ip6_tables.h>
 
 #define IPV6_HDR_LEN	(sizeof(struct ipv6hdr))
@@ -1593,7 +1593,8 @@
 	}
 
 	tcpoff = (u8*)(skb->nh.ipv6h + 1) - skb->data;
-	tcpoff = ipv6_skip_exthdr(skb, tcpoff, &nexthdr, skb->len - tcpoff);
+	tcpoff = ipv6_skip_exthdr((struct sk_buff *)skb,
+					tcpoff, &nexthdr, skb->len - tcpoff);
 	if (tcpoff < 0 || tcpoff > skb->len) {
 		duprintf("tcp_match: cannot skip exthdr. Dropping.\n");
 		*hotdrop = 1;
@@ -1674,7 +1675,8 @@
 	}
 
 	udpoff = (u8*)(skb->nh.ipv6h + 1) - skb->data;
-	udpoff = ipv6_skip_exthdr(skb, udpoff, &nexthdr, skb->len - udpoff);
+	udpoff = ipv6_skip_exthdr((struct sk_buff *)skb,
+					udpoff, &nexthdr, skb->len - udpoff);
 	if (udpoff < 0 || udpoff > skb->len) {
 		duprintf("udp_match: cannot skip exthdr. Dropping.\n");
 		*hotdrop = 1;
