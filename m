Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269498AbUHZUJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269498AbUHZUJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUHZUFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:05:52 -0400
Received: from waste.org ([209.173.204.2]:18844 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269529AbUHZT6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:58:37 -0400
Date: Thu, 26 Aug 2004 14:58:31 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/5] netpoll: fix unaligned accesses
Message-ID: <20040826195831.GY31237@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid some alignment traps.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: linux/net/core/netpoll.c
===================================================================
--- linux.orig/net/core/netpoll.c	2004-08-24 21:36:22.000000000 -0500
+++ linux/net/core/netpoll.c	2004-08-26 10:47:48.693423643 -0500
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <net/tcp.h>
 #include <net/udp.h>
+#include <asm/unaligned.h>
 
 /*
  * We maintain a small pool of fully-sized skbs, to make sure the
@@ -206,17 +207,17 @@
 
 	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
 
-	iph->version  = 4;
-	iph->ihl      = 5;
+	/* iph->version = 4; iph->ihl = 5; */
+	put_unaligned(0x54, (unsigned char *)iph);
 	iph->tos      = 0;
-	iph->tot_len  = htons(ip_len);
+	put_unaligned(htonl(ip_len), &(iph->tot_len));
 	iph->id       = 0;
 	iph->frag_off = 0;
 	iph->ttl      = 64;
 	iph->protocol = IPPROTO_UDP;
 	iph->check    = 0;
-	iph->saddr    = htonl(np->local_ip);
-	iph->daddr    = htonl(np->remote_ip);
+	put_unaligned(htonl(np->local_ip), &(iph->saddr));
+	put_unaligned(htonl(np->remote_ip), &(iph->daddr));
 	iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
 
 	eth = (struct ethhdr *) skb_push(skb, ETH_HLEN);

-- 
Mathematics is the supreme nostalgia of our time.
