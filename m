Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267975AbUHPWOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267975AbUHPWOj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUHPWOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:14:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4741 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267975AbUHPWOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:14:21 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.12618.781947.445999@segfault.boston.redhat.com>
Date: Mon, 16 Aug 2004 18:12:26 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [patch] remove the netpoll_rx config option
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

This patch removes CONFIG_NETPOLL_RX, as discussed.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.7/include/linux/netdevice.h.kill_rx	2004-08-16 12:21:23.260001336 -0400
+++ linux-2.6.7/include/linux/netdevice.h	2004-08-16 12:21:33.428455496 -0400
@@ -459,7 +459,7 @@ struct net_device
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	int			netpoll_rx;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
--- linux-2.6.7/net/core/netpoll.c.kill_rx	2004-08-16 12:20:47.479440808 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-16 12:25:27.372890536 -0400
@@ -603,9 +603,7 @@ int netpoll_setup(struct netpoll *np)
 	if(np->rx_hook) {
 		unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
 		np->dev->netpoll_rx = 1;
-#endif
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_add(&np->rx_list, &rx_list);
@@ -625,12 +623,10 @@ void netpoll_cleanup(struct netpoll *np)
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_del(&np->rx_list);
-#ifdef CONFIG_NETPOLL_RX
-		np->dev->netpoll_rx = 0;
-#endif
 		spin_unlock_irqrestore(&rx_list_lock, flags);
 	}
 
+	np->dev->netpoll_rx = 0;
 	dev_put(np->dev);
 	np->dev = 0;
 }
--- linux-2.6.7/net/core/dev.c.kill_rx	2004-08-16 12:25:54.149819824 -0400
+++ linux-2.6.7/net/core/dev.c	2004-08-16 12:26:05.750056320 -0400
@@ -1575,7 +1575,7 @@ int netif_rx(struct sk_buff *skb)
 	struct softnet_data *queue;
 	unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
@@ -1737,7 +1737,7 @@ int netif_receive_skb(struct sk_buff *sk
 	int ret = NET_RX_DROP;
 	unsigned short type;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && skb->dev->poll && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
--- linux-2.6.7/net/Kconfig.kill_rx	2004-08-16 12:26:20.192860680 -0400
+++ linux-2.6.7/net/Kconfig	2004-08-16 12:26:53.855743144 -0400
@@ -653,11 +653,6 @@ endmenu
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
