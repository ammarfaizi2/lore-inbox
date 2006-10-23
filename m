Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWJWTGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWJWTGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWJWTEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:04:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965067AbWJWTEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:04:47 -0400
Date: Mon, 23 Oct 2006 12:02:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] netpoll: use sk_buff_head for txq
Message-ID: <20061023120253.5dd146d2@dxpl.pdx.osdl.net>
In-Reply-To: <20061022.204220.78710782.davem@davemloft.net>
References: <20061020134826.75dd1cba@freekitty>
 <20061020.140149.125893169.davem@davemloft.net>
 <20061020153027.3bed8c86@dxpl.pdx.osdl.net>
 <20061022.204220.78710782.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 3rd version of the netpoll patches. The first patch
switches from open-coded skb list to using a skb_buff_head.
It also flushes packets from queue when device is removed from
netpoll.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- netpoll.orig/net/core/netpoll.c
+++ netpoll/net/core/netpoll.c
@@ -37,10 +37,7 @@
 #define MAX_RETRIES 20000
 
 static struct sk_buff_head netpoll_pool;
-	
-static DEFINE_SPINLOCK(queue_lock);
-static int queue_depth;
-static struct sk_buff *queue_head, *queue_tail;
+static struct sk_buff_head netpoll_txq;
 
 static atomic_t trapped;
 
@@ -56,44 +53,35 @@ static void arp_reply(struct sk_buff *sk
 
 static void queue_process(void *p)
 {
-	unsigned long flags;
 	struct sk_buff *skb;
 
-	while (queue_head) {
-		spin_lock_irqsave(&queue_lock, flags);
-
-		skb = queue_head;
-		queue_head = skb->next;
-		if (skb == queue_tail)
-			queue_head = NULL;
+	while ((skb = skb_dequeue(&netpoll_txq)))
+		dev_queue_xmit(skb);
 
-		queue_depth--;
+}
 
-		spin_unlock_irqrestore(&queue_lock, flags);
+static void queue_purge(struct net_device *dev)
+{
+	struct sk_buff *skb, *next;
+	unsigned long flags;
 
-		dev_queue_xmit(skb);
+	spin_lock_irqsave(&netpoll_txq.lock, flags);
+	for (skb = (struct sk_buff *)netpoll_txq.next;
+	     skb != (struct sk_buff *)&netpoll_txq; skb = next) {
+		next = skb->next;
+		if (skb->dev == dev) {
+			skb_unlink(skb, &netpoll_txq);
+			kfree_skb(skb);
+		}
 	}
+	spin_unlock_irqrestore(&netpoll_txq.lock, flags);
 }
 
 static DECLARE_WORK(send_queue, queue_process, NULL);
 
 void netpoll_queue(struct sk_buff *skb)
 {
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
+	skb_queue_tail(&netpoll_txq, skb);
 
 	schedule_work(&send_queue);
 }
@@ -745,6 +733,7 @@ int netpoll_setup(struct netpoll *np)
 }
 
 static int __init netpoll_init(void) {
+	skb_queue_head_init(&netpoll_txq);
 	skb_queue_head_init(&netpoll_pool);
 	return 0;
 }
@@ -752,20 +741,22 @@ core_initcall(netpoll_init);
 
 void netpoll_cleanup(struct netpoll *np)
 {
-	struct netpoll_info *npinfo;
+	struct net_device *dev = np->dev;
 	unsigned long flags;
 
-	if (np->dev) {
-		npinfo = np->dev->npinfo;
+	if (dev) {
+		struct netpoll_info *npinfo = dev->npinfo;
+
 		if (npinfo && npinfo->rx_np == np) {
 			spin_lock_irqsave(&npinfo->rx_lock, flags);
 			npinfo->rx_np = NULL;
 			npinfo->rx_flags &= ~NETPOLL_RX_ENABLED;
 			spin_unlock_irqrestore(&npinfo->rx_lock, flags);
 		}
-		dev_put(np->dev);
-	}
+		dev_put(dev);
 
+		queue_purge(dev);
+	}
 	np->dev = NULL;
 }
 
