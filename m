Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269576AbUHZUJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269576AbUHZUJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269498AbUHZUFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:05:02 -0400
Received: from waste.org ([209.173.204.2]:42652 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269555AbUHZUBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:01:11 -0400
Date: Thu, 26 Aug 2004 15:00:55 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH 3/5] netpoll: kill CONFIG_NETPOLL_RX
Message-ID: <20040826200055.GA31237@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>

This patch removes CONFIG_NETPOLL_RX, as discussed.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: linux/include/linux/netdevice.h
===================================================================
--- linux.orig/include/linux/netdevice.h	2004-08-24 21:36:20.000000000 -0500
+++ linux/include/linux/netdevice.h	2004-08-25 12:22:23.711540045 -0500
@@ -462,7 +462,7 @@
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	int			netpoll_rx;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
Index: linux/net/core/netpoll.c
===================================================================
--- linux.orig/net/core/netpoll.c	2004-08-25 12:22:18.017253979 -0500
+++ linux/net/core/netpoll.c	2004-08-25 12:22:23.711540045 -0500
@@ -603,9 +603,7 @@
 	if(np->rx_hook) {
 		unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
 		np->dev->netpoll_rx = 1;
-#endif
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_add(&np->rx_list, &rx_list);
@@ -625,12 +623,10 @@
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_del(&np->rx_list);
-#ifdef CONFIG_NETPOLL_RX
-		np->dev->netpoll_rx = 0;
-#endif
 		spin_unlock_irqrestore(&rx_list_lock, flags);
 	}
 
+	np->dev->netpoll_rx = 0;
 	dev_put(np->dev);
 	np->dev = NULL;
 }
Index: linux/net/core/dev.c
===================================================================
--- linux.orig/net/core/dev.c	2004-08-24 21:36:22.000000000 -0500
+++ linux/net/core/dev.c	2004-08-25 12:22:24.015501935 -0500
@@ -1558,7 +1558,7 @@
 	struct softnet_data *queue;
 	unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
@@ -1762,7 +1762,7 @@
 	int ret = NET_RX_DROP;
 	unsigned short type;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && skb->dev->poll && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
Index: linux/net/Kconfig
===================================================================
--- linux.orig/net/Kconfig	2004-08-24 21:36:22.000000000 -0500
+++ linux/net/Kconfig	2004-08-25 12:22:24.038499052 -0500
@@ -635,11 +635,6 @@
 config NETPOLL
 	def_bool NETCONSOLE
 
-config NETPOLL_RX
-	bool "Netpoll support for trapping incoming packets"
-	default n
-	depends on NETPOLL
-
 config NETPOLL_TRAP
 	bool "Netpoll traffic trapping"
 	default n

-- 
Mathematics is the supreme nostalgia of our time.
