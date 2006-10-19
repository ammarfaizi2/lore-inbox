Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946262AbWJSRTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946262AbWJSRTs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946269AbWJSRTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:19:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946258AbWJSRT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:19:26 -0400
Message-Id: <20061019171814.026676621@osdl.org>
References: <20061019171541.062261760@osdl.org>
User-Agent: quilt/0.45-1
Date: Thu, 19 Oct 2006 10:15:42 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] netpoll: initialize skb for UDP
Content-Disposition: inline; filename=netpoll-protofix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need to fully initialize skb to keep lower layers and queueing happy.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- linux-2.6.orig/net/core/netpoll.c	2006-10-18 15:26:36.000000000 -0700
+++ linux-2.6/net/core/netpoll.c	2006-10-19 08:28:04.000000000 -0700
@@ -331,13 +331,13 @@
 	memcpy(skb->data, msg, len);
 	skb->len += len;
 
-	udph = (struct udphdr *) skb_push(skb, sizeof(*udph));
+	skb->h.uh = udph = (struct udphdr *) skb_push(skb, sizeof(*udph));
 	udph->source = htons(np->local_port);
 	udph->dest = htons(np->remote_port);
 	udph->len = htons(udp_len);
 	udph->check = 0;
 
-	iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
+	skb->nh.iph = iph = (struct iphdr *)skb_push(skb, sizeof(*iph));
 
 	/* iph->version = 4; iph->ihl = 5; */
 	put_unaligned(0x45, (unsigned char *)iph);
@@ -353,8 +353,8 @@
 	iph->check    = ip_fast_csum((unsigned char *)iph, iph->ihl);
 
 	eth = (struct ethhdr *) skb_push(skb, ETH_HLEN);
-
-	eth->h_proto = htons(ETH_P_IP);
+	skb->mac.raw = skb->data;
+	skb->protocol = eth->h_proto = htons(ETH_P_IP);
 	memcpy(eth->h_source, np->local_mac, 6);
 	memcpy(eth->h_dest, np->remote_mac, 6);
 

--

