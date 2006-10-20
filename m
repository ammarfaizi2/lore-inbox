Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423248AbWJTWfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423248AbWJTWfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWJTWfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:35:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030369AbWJTWf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:35:28 -0400
Date: Fri, 20 Oct 2006 15:35:09 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] netpoll: retry logic cleanup
Message-ID: <20061020153509.228c7103@dxpl.pdx.osdl.net>
In-Reply-To: <20061020.140149.125893169.davem@davemloft.net>
References: <20061020084015.5c559326@localhost.localdomain>
	<20061020.134209.85688168.davem@davemloft.net>
	<20061020134826.75dd1cba@freekitty>
	<20061020.140149.125893169.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change retry logic of netpoll.  Always requeue if unable to send
instead of dropping. Make retry counter per send rather than causing
mass migration when tries gets less than zero. Since callers are
either netpoll_send_arp or netpoll_send_udp, we knwo that np and np->dev
can't be null.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


--- netpoll.orig/include/linux/netpoll.h
+++ netpoll/include/linux/netpoll.h
@@ -27,7 +27,6 @@ struct netpoll {
 struct netpoll_info {
 	spinlock_t poll_lock;
 	int poll_owner;
-	int tries;
 	int rx_flags;
 	spinlock_t rx_lock;
 	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
--- netpoll.orig/net/core/netpoll.c
+++ netpoll/net/core/netpoll.c
@@ -232,50 +232,43 @@ static struct sk_buff * find_skb(struct 
 
 static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
-	int status;
-	struct netpoll_info *npinfo;
-
-	if (!np || !np->dev || !netif_running(np->dev))
-		goto free_skb;
+	struct net_device *dev = np->dev;
+	struct netpoll_info *npinfo = dev->npinfo;
+	int status, tries;
 
-	npinfo = np->dev->npinfo;
+	if (!netif_running(dev) || !netif_device_present(dev))
+		__kfree_skb(skb);
 
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
+	    dev->xmit_lock_owner == smp_processor_id())
+		goto busy;
 
+	for (tries = MAX_RETRIES; tries; --tries) {
 		/*
 		 * network drivers do not expect to be called if the queue is
 		 * stopped.
 		 */
-		status = NETDEV_TX_BUSY;
-		if (!netif_queue_stopped(np->dev))
-			status = np->dev->hard_start_xmit(skb, np->dev);
-
-		netif_tx_unlock(np->dev);
+		if (netif_queue_stopped(dev))
+			status = NETDEV_TX_BUSY;
+		else
+			status = dev->hard_start_xmit(skb, dev);
+		netif_tx_unlock(dev);
 
 		/* success */
-		if(!status) {
-			npinfo->tries = MAX_RETRIES; /* reset */
+		if(status == NETDEV_TX_OK)
 			return;
-		}
 
 		/* transmit busy */
 		netpoll_poll(np);
 		udelay(50);
-	} while (npinfo->tries > 0);
-free_skb:
-	__kfree_skb(skb);
+	}
+
+busy:
+	if (np->drop)
+		np->drop(skb);
+	else
+		__kfree_skb(skb);
 }
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
@@ -628,7 +621,7 @@ int netpoll_setup(struct netpoll *np)
 		npinfo->rx_np = NULL;
 		spin_lock_init(&npinfo->poll_lock);
 		npinfo->poll_owner = -1;
-		npinfo->tries = MAX_RETRIES;
+
 		spin_lock_init(&npinfo->rx_lock);
 		skb_queue_head_init(&npinfo->arp_tx);
 	} else
