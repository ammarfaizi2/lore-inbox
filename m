Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946257AbWJSRTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946257AbWJSRTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946259AbWJSRTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:19:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946257AbWJSRTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:19:17 -0400
Message-Id: <20061019171814.281988608@osdl.org>
References: <20061019171541.062261760@osdl.org>
User-Agent: quilt/0.45-1
Date: Thu, 19 Oct 2006 10:15:43 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] netpoll: rework skb transmit queue
Content-Disposition: inline; filename=netpoll-txq.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The original skb management for netpoll was a mess, it had two queue paths
and a callback. This changes it to have a per-instance transmit queue
and use a tasklet rather than a work queue for the congested case.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

---
 drivers/net/netconsole.c |    1 
 include/linux/netpoll.h  |    3 -
 net/core/netpoll.c       |  123 +++++++++++++++--------------------------------
 3 files changed, 42 insertions(+), 85 deletions(-)

--- linux-2.6.orig/drivers/net/netconsole.c	2006-10-16 14:15:01.000000000 -0700
+++ linux-2.6/drivers/net/netconsole.c	2006-10-19 08:28:25.000000000 -0700
@@ -60,7 +60,6 @@
 	.local_port = 6665,
 	.remote_port = 6666,
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-	.drop = netpoll_queue,
 };
 static int configured = 0;
 
--- linux-2.6.orig/include/linux/netpoll.h	2006-10-16 14:15:04.000000000 -0700
+++ linux-2.6/include/linux/netpoll.h	2006-10-19 08:28:25.000000000 -0700
@@ -27,11 +27,12 @@
 struct netpoll_info {
 	spinlock_t poll_lock;
 	int poll_owner;
-	int tries;
 	int rx_flags;
 	spinlock_t rx_lock;
 	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
 	struct sk_buff_head arp_tx; /* list of arp requests to reply to */
+	struct sk_buff_head tx_q;
+	struct tasklet_struct tx_task;
 };
 
 void netpoll_poll(struct netpoll *np);
--- linux-2.6.orig/net/core/netpoll.c	2006-10-19 08:28:04.000000000 -0700
+++ linux-2.6/net/core/netpoll.c	2006-10-19 09:47:38.000000000 -0700
@@ -40,10 +40,6 @@
 static int nr_skbs;
 static struct sk_buff *skbs;
 
-static DEFINE_SPINLOCK(queue_lock);
-static int queue_depth;
-static struct sk_buff *queue_head, *queue_tail;
-
 static atomic_t trapped;
 
 #define NETPOLL_RX_ENABLED  1
@@ -56,49 +52,33 @@
 static void zap_completion_queue(void);
 static void arp_reply(struct sk_buff *skb);
 
-static void queue_process(void *p)
+static void netpoll_run(unsigned long arg)
 {
-	unsigned long flags;
+	struct net_device *dev = (struct net_device *) arg;
+	struct netpoll_info *npinfo = dev->npinfo;
 	struct sk_buff *skb;
 
-	while (queue_head) {
-		spin_lock_irqsave(&queue_lock, flags);
-
-		skb = queue_head;
-		queue_head = skb->next;
-		if (skb == queue_tail)
-			queue_head = NULL;
-
-		queue_depth--;
-
-		spin_unlock_irqrestore(&queue_lock, flags);
+	while ((skb = skb_dequeue(&npinfo->tx_q))) {
+		int rc;
 
-		dev_queue_xmit(skb);
-	}
-}
-
-static DECLARE_WORK(send_queue, queue_process, NULL);
+		if (!netif_running(dev) || !netif_device_present(dev)) {
+			__kfree_skb(skb);
+			continue;
+		}
 
-void netpoll_queue(struct sk_buff *skb)
-{
-	unsigned long flags;
+		netif_tx_lock(dev);
+		if (netif_queue_stopped(dev))
+			rc = NETDEV_TX_BUSY;
+		else
+		    	rc = dev->hard_start_xmit(skb, dev);
+		netif_tx_unlock(dev);
 
-	if (queue_depth == MAX_QUEUE_DEPTH) {
-		__kfree_skb(skb);
-		return;
+		if (rc != NETDEV_TX_OK) {
+			skb_queue_head(&npinfo->tx_q, skb);
+			tasklet_schedule(&npinfo->tx_task);
+			break;
+		}
 	}
-	WARN_ON(skb->protocol == 0);
-
-	spin_lock_irqsave(&queue_lock, flags);
-	if (!queue_head)
-		queue_head = skb;
-	else
-		queue_tail->next = skb;
-	queue_tail = skb;
-	queue_depth++;
-	spin_unlock_irqrestore(&queue_lock, flags);
-
-	schedule_work(&send_queue);
 }
 
 static int checksum_udp(struct sk_buff *skb, struct udphdr *uh,
@@ -232,6 +212,7 @@
 
 static struct sk_buff * find_skb(struct netpoll *np, int len, int reserve)
 {
+	int once = 1, count = 0;
 	unsigned long flags;
 	struct sk_buff *skb = NULL;
 
@@ -254,6 +235,11 @@
 	}
 
 	if(!skb) {
+		count++;
+		if (once && (count == 1000000)) {
+			printk("out of netpoll skbs!\n");
+			once = 0;
+		}
 		netpoll_poll(np);
 		goto repeat;
 	}
@@ -265,51 +251,17 @@
 
 static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
-	int status;
-	struct netpoll_info *npinfo;
+	struct net_device *dev = np->dev;
+	struct netpoll_info *npinfo = dev->npinfo;
 
-	if (!np || !np->dev || !netif_device_present(np->dev) || !netif_running(np->dev)) {
-		__kfree_skb(skb);
-		return;
-	}
-
-	npinfo = np->dev->npinfo;
+	skb_queue_tail(&npinfo->tx_q, skb);
 
 	/* avoid recursion */
 	if (npinfo->poll_owner == smp_processor_id() ||
-	    np->dev->xmit_lock_owner == smp_processor_id()) {
-		if (np->drop)
-			np->drop(skb);
-		else
-			__kfree_skb(skb);
-		return;
-	}
-
-	do {
-		npinfo->tries--;
-		netif_tx_lock(np->dev);
-
-		/*
-		 * network drivers do not expect to be called if the queue is
-		 * stopped.
-		 */
-		status = NETDEV_TX_BUSY;
-		if (!netif_queue_stopped(np->dev))
-			status = np->dev->hard_start_xmit(skb, np->dev);
-
-		netif_tx_unlock(np->dev);
-
-		/* success */
-		if(!status) {
-			npinfo->tries = MAX_RETRIES; /* reset */
-			return;
-		}
-
-		/* transmit busy */
-		netpoll_poll(np);
-		udelay(50);
-	} while (npinfo->tries > 0);
-	__kfree_skb(skb);
+	    dev->xmit_lock_owner == smp_processor_id())
+		tasklet_schedule(&npinfo->tx_task);
+	else
+		netpoll_run((unsigned long) dev);
 }
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
@@ -662,9 +614,10 @@
 		npinfo->rx_np = NULL;
 		spin_lock_init(&npinfo->poll_lock);
 		npinfo->poll_owner = -1;
-		npinfo->tries = MAX_RETRIES;
 		spin_lock_init(&npinfo->rx_lock);
 		skb_queue_head_init(&npinfo->arp_tx);
+		skb_queue_head_init(&npinfo->tx_q);
+		tasklet_init(&npinfo->tx_task, netpoll_run, (unsigned long) ndev);
 	} else
 		npinfo = ndev->npinfo;
 
@@ -772,6 +725,11 @@
 			npinfo->rx_np = NULL;
 			npinfo->rx_flags &= ~NETPOLL_RX_ENABLED;
 			spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+
+			skb_queue_purge(&npinfo->arp_tx);
+			skb_queue_purge(&npinfo->tx_q);
+
+			tasklet_kill(&npinfo->tx_task);
 		}
 		dev_put(np->dev);
 	}
@@ -799,4 +757,3 @@
 EXPORT_SYMBOL(netpoll_cleanup);
 EXPORT_SYMBOL(netpoll_send_udp);
 EXPORT_SYMBOL(netpoll_poll);
-EXPORT_SYMBOL(netpoll_queue);

--

