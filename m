Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUDJUeo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUDJUeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:34:44 -0400
Received: from waste.org ([209.173.204.2]:25829 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261920AbUDJUeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:34:04 -0400
Date: Sat, 10 Apr 2004 15:33:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Stelian Pop <stelian@popies.net>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] netpoll early ARP handling
Message-ID: <20040410203302.GR6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle ARP requests while device is trapped before in_dev is
initialized using netpoll config. Allows early kgdboe usage.

>From Stelian Pop <stelian@popies.net>

%patch
Index: mm/net/core/netpoll.c
===================================================================
--- mm.orig/net/core/netpoll.c	2004-04-10 15:06:57.000000000 -0500
+++ mm/net/core/netpoll.c	2004-04-10 15:15:25.000000000 -0500
@@ -231,9 +231,8 @@
 
 static void arp_reply(struct sk_buff *skb)
 {
-	struct in_device *in_dev = (struct in_device *) skb->dev->ip_ptr;
 	struct arphdr *arp;
-	unsigned char *arp_ptr, *sha, *tha;
+	unsigned char *arp_ptr;
 	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
 	u32 sip, tip;
 	struct sk_buff *send_skb;
@@ -253,7 +252,7 @@
 	if (!np) return;
 
 	/* No arp on this interface */
-	if (!in_dev || skb->dev->flags & IFF_NOARP)
+	if (skb->dev->flags & IFF_NOARP)
 		return;
 
 	if (!pskb_may_pull(skb, (sizeof(struct arphdr) +
@@ -270,21 +269,15 @@
 	    arp->ar_op != htons(ARPOP_REQUEST))
 		return;
 
-	arp_ptr= (unsigned char *)(arp+1);
-	sha = arp_ptr;
-	arp_ptr += skb->dev->addr_len;
+	arp_ptr = (unsigned char *)(arp+1) + skb->dev->addr_len;
 	memcpy(&sip, arp_ptr, 4);
-	arp_ptr += 4;
-	tha = arp_ptr;
-	arp_ptr += skb->dev->addr_len;
+	arp_ptr += 4 + skb->dev->addr_len;
 	memcpy(&tip, arp_ptr, 4);
 
 	/* Should we ignore arp? */
-	if (tip != in_dev->ifa_list->ifa_address ||
-	    LOOPBACK(tip) || MULTICAST(tip))
+	if (tip != htonl(np->local_ip) || LOOPBACK(tip) || MULTICAST(tip))
 		return;
 
-
 	size = sizeof(struct arphdr) + 2 * (skb->dev->addr_len + 4);
 	send_skb = find_skb(np, size + LL_RESERVED_SPACE(np->dev),
 			    LL_RESERVED_SPACE(np->dev));
@@ -325,7 +318,7 @@
 	arp_ptr += np->dev->addr_len;
 	memcpy(arp_ptr, &tip, 4);
 	arp_ptr += 4;
-	memcpy(arp_ptr, np->local_mac, np->dev->addr_len);
+	memcpy(arp_ptr, np->remote_mac, np->dev->addr_len);
 	arp_ptr += np->dev->addr_len;
 	memcpy(arp_ptr, &sip, 4);
 

%diffstat
 netpoll.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)



-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
