Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268244AbUHFTi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268244AbUHFTi0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUHFTiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:38:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268244AbUHFTbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:31:44 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16659.56343.686372.724218@segfault.boston.redhat.com>
Date: Fri, 6 Aug 2004 15:29:27 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [patch] fix netconsole hang with alt-sysrq-t
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

Here's the patch.  Sorry it took me so long, been busy with other work.
Two things which need perhaps more thinking, can netpoll_poll be called
recursively (it didn't look like it to me), and do we care about the racy
nature of the netpoll_set_trap interface?

You'll notice that I reverted part of an earlier changeset which caused us
to call the hard_start_xmit function even if netif_queue_stopped returned
true.  This is a bug.  I preserved the second part of that patch, which was
correct.

I've also bumped the budget from 1 to 16.  As I mentioned, this was a
required change for netdump.

This patch was tested on my dual hammer test system.

Comments welcome.

-Jeff

--- linux-2.6.7/include/linux/netpoll.h.orig	2004-08-06 11:14:11.735851056 -0400
+++ linux-2.6.7/include/linux/netpoll.h	2004-08-06 11:14:33.500542320 -0400
@@ -21,6 +21,7 @@
 	u16 local_port, remote_port;
 	unsigned char local_mac[6], remote_mac[6];
 	struct list_head rx_list;
+	spinlock_t poll_lock;
 };
 
 void netpoll_poll(struct netpoll *np);
--- linux-2.6.7/include/linux/netdevice.h.orig	2004-08-06 13:01:39.438651240 -0400
+++ linux-2.6.7/include/linux/netdevice.h	2004-08-06 13:01:41.414350888 -0400
@@ -462,7 +462,7 @@
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	int			netpoll_rx;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
--- linux-2.6.7/net/core/netpoll.c.orig	2004-08-06 11:13:45.230880424 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-06 15:15:14.154229272 -0400
@@ -61,7 +61,8 @@
 
 void netpoll_poll(struct netpoll *np)
 {
-	int budget = 1;
+	int budget = 16;
+	unsigned long flags;
 
 	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
 		return;
@@ -70,9 +71,21 @@
 	np->dev->poll_controller(np->dev);
 
 	/* If scheduling is stopped, tickle NAPI bits */
-	if(trapped && np->dev->poll &&
-	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
-		np->dev->poll(np->dev, &budget);
+	spin_lock_irqsave(&np->poll_lock, flags);
+	if (np->dev->poll &&
+	    test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
+		np->dev->netpoll_rx |= NETPOLL_RX_DROP;
+		if (trapped)
+			np->dev->poll(np->dev, &budget);
+		else {
+			trapped = 1;
+			np->dev->poll(np->dev, &budget);
+			trapped = 0;
+		}
+		np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
+	}
+	spin_unlock_irqrestore(&np->poll_lock, flags);
+
 	zap_completion_queue();
 }
 
@@ -168,6 +181,14 @@
 	spin_lock(&np->dev->xmit_lock);
 	np->dev->xmit_lock_owner = smp_processor_id();
 
+	if (netif_queue_stopped(np->dev)) {
+		np->dev->xmit_lock_owner = -1;
+		spin_unlock(&np->dev->xmit_lock);
+
+		netpoll_poll(np);
+		goto repeat;
+	}
+
 	status = np->dev->hard_start_xmit(skb, np->dev);
 	np->dev->xmit_lock_owner = -1;
 	spin_unlock(&np->dev->xmit_lock);
@@ -587,13 +608,12 @@
 	}
 
 	np->dev = ndev;
+	spin_lock_init(&np->poll_lock);
 
 	if(np->rx_hook) {
 		unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
-		np->dev->netpoll_rx = 1;
-#endif
+		np->dev->netpoll_rx = NETPOLL_RX_ENABLED;
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_add(&np->rx_list, &rx_list);
@@ -613,12 +633,10 @@
 
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
@@ -628,6 +646,7 @@
 	return trapped;
 }
 
+/* this interface is inherently racy.  do we care?  -phro */
 void netpoll_set_trap(int trap)
 {
 	trapped = trap;
--- linux-2.6.7/net/core/dev.c.orig	2004-08-06 11:13:51.237967208 -0400
+++ linux-2.6.7/net/core/dev.c	2004-08-06 13:26:28.246318072 -0400
@@ -1601,7 +1601,7 @@
 	struct softnet_data *queue;
 	unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
@@ -1805,7 +1805,7 @@
 	int ret = NET_RX_DROP;
 	unsigned short type;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && skb->dev->poll && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
--- linux-2.6.7/net/Kconfig.orig	2004-08-06 13:09:21.543400640 -0400
+++ linux-2.6.7/net/Kconfig	2004-08-06 13:09:24.042020792 -0400
@@ -656,9 +656,6 @@
 config NETPOLL
 	def_bool NETCONSOLE || KGDBOE
 
-config NETPOLL_RX
-	def_bool KGDBOE
-
 config NETPOLL_TRAP
 	def_bool KGDBOE
 
