Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992594AbWJTPkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992594AbWJTPkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946448AbWJTPkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:40:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946447AbWJTPkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:40:21 -0400
Date: Fri, 20 Oct 2006 08:40:15 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] netpoll: rework skb transmit queue
Message-ID: <20061020084015.5c559326@localhost.localdomain>
In-Reply-To: <20061020.001530.35664340.davem@davemloft.net>
References: <20061019171541.062261760@osdl.org>
	<20061019171814.281988608@osdl.org>
	<20061020.001530.35664340.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change netpoll to use a skb queue for transmit. This solves problems
where there are two tx paths that can cause things to get out of order
and different semantics when netconsole output goes through fast and
slow paths.

The only user of the drop hook was netconsole, and I fixed that path.
This probably breaks netdump, but that is out of tree, so it needs
to fix itself.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
---
 drivers/net/netconsole.c |    1 
 include/linux/netpoll.h  |    3 +
 net/core/netpoll.c       |  109 ++++++++++++----------------------------------
 3 files changed, 31 insertions(+), 82 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bf58db2..fad5bf2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -60,7 +60,6 @@ static struct netpoll np = {
 	.local_port = 6665,
 	.remote_port = 6666,
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-	.drop = netpoll_queue,
 };
 static int configured = 0;
 
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1efe60c..835ca0d 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -27,11 +27,12 @@ struct netpoll {
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
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 9308af0..22332fd 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -40,10 +40,6 @@ static DEFINE_SPINLOCK(skb_list_lock);
 static int nr_skbs;
 static struct sk_buff *skbs;
 
-static DEFINE_SPINLOCK(queue_lock);
-static int queue_depth;
-static struct sk_buff *queue_head, *queue_tail;
-
 static atomic_t trapped;
 
 #define NETPOLL_RX_ENABLED  1
@@ -56,50 +52,31 @@ #define MAX_SKB_SIZE \
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
+	while ((skb = skb_dequeue(&npinfo->tx_q))) {
+		if (!netif_running(dev) || !netif_device_present(dev)) {
+			__kfree_skb(skb);
+			continue;
+		}
 
-		spin_unlock_irqrestore(&queue_lock, flags);
+		netif_tx_lock(dev);
+		if (netif_queue_stopped(dev) ||
+		    dev->hard_start_xmit(skb, dev) != NETDEV_TX_OK) {
+			skb_queue_head(&npinfo->tx_q, skb);
+			netif_tx_unlock(dev);
+			tasklet_schedule(&npinfo->tx_task);
+			return;
+		}
 
-		dev_queue_xmit(skb);
+		netif_tx_unlock(dev);
 	}
 }
 
-static DECLARE_WORK(send_queue, queue_process, NULL);
-
-void netpoll_queue(struct sk_buff *skb)
-{
-	unsigned long flags;
-
-	if (queue_depth == MAX_QUEUE_DEPTH) {
-		__kfree_skb(skb);
-		return;
-	}
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
-}
-
 static int checksum_udp(struct sk_buff *skb, struct udphdr *uh,
 			     unsigned short ulen, u32 saddr, u32 daddr)
 {
@@ -270,50 +247,17 @@ repeat:
 
 static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
-	int status;
-	struct netpoll_info *npinfo;
-
-	if (!np || !np->dev || !netif_running(np->dev)) {
-		__kfree_skb(skb);
-		return;
-	}
+	struct net_device *dev = np->dev;
+	struct netpoll_info *npinfo = dev->npinfo;
 
-	npinfo = np->dev->npinfo;
+	skb_queue_tail(&npinfo->tx_q, skb);
 
 	/* avoid recursion */
 	if (npinfo->poll_owner == smp_processor_id() ||
-	    np->dev->xmit_lock_owner == smp_processor_id()) {
-		if (np->drop)
-			np->drop(skb);
-		else
-			__kfree_skb(skb);
+	    dev->xmit_lock_owner == smp_processor_id())
 		return;
-	}
 
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
+	netpoll_run((unsigned long) dev);
 }
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
@@ -666,9 +610,10 @@ int netpoll_setup(struct netpoll *np)
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
 
@@ -776,6 +721,11 @@ void netpoll_cleanup(struct netpoll *np)
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
@@ -803,4 +753,3 @@ EXPORT_SYMBOL(netpoll_setup);
 EXPORT_SYMBOL(netpoll_cleanup);
 EXPORT_SYMBOL(netpoll_send_udp);
 EXPORT_SYMBOL(netpoll_poll);
-EXPORT_SYMBOL(netpoll_queue);
-- 
1.4.2.4

