Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269596AbUHZU3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269596AbUHZU3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269469AbUHZUL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:11:28 -0400
Received: from waste.org ([209.173.204.2]:8605 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269562AbUHZUDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:03:06 -0400
Date: Thu, 26 Aug 2004 15:02:52 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH 5/5] netpoll: fix up trapped logic
Message-ID: <20040826200252.GC31237@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>

This patch contains the updates necessary to fix the hangs in netconsole.
This includes the changing of trapped to an atomic_t, and the addition of a
netpoll_poll_lock.  It also turns dev->netpoll_rx into a bitfield which is
used to keep from running the networking code from the netpoll_poll call
path.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Matt Mackall <mpm@selenic.com>

--- linux-2.6.7/net/core/netpoll.c.locking	2004-08-16 14:43:52.565309376 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-16 15:06:29.270058904 -0400
@@ -36,7 +36,11 @@ static struct sk_buff *skbs;
 static spinlock_t rx_list_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(rx_list);
 
-static int trapped;
+static atomic_t trapped;
+spinlock_t netpoll_poll_lock = SPIN_LOCK_UNLOCKED;
+
+#define NETPOLL_RX_ENABLED  1
+#define NETPOLL_RX_DROP     2
 
 #define MAX_SKB_SIZE \
 		(MAX_UDP_CHUNK + sizeof(struct udphdr) + \
@@ -68,6 +72,7 @@ void netpoll_poll(struct netpoll *np)
 	 * timeouts.  Thus, we set our budget to a more reasonable value.
 	 */
 	int budget = 16;
+	unsigned long flags;
 
 	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
 		return;
@@ -76,9 +81,19 @@ void netpoll_poll(struct netpoll *np)
 	np->dev->poll_controller(np->dev);
 
 	/* If scheduling is stopped, tickle NAPI bits */
-	if(trapped && np->dev->poll &&
-	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
+	spin_lock_irqsave(&netpoll_poll_lock, flags);
+	if (np->dev->poll &&
+	    test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
+		np->dev->netpoll_rx |= NETPOLL_RX_DROP;
+		atomic_inc(&trapped);
+
 		np->dev->poll(np->dev, &budget);
+
+		atomic_dec(&trapped);
+		np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
+	}
+	spin_unlock_irqrestore(&netpoll_poll_lock, flags);
+
 	zap_completion_queue();
 }
 
@@ -355,7 +370,8 @@ int netpoll_rx(struct sk_buff *skb)
 		goto out;
 
 	/* check if netpoll clients need ARP */
-	if (skb->protocol == __constant_htons(ETH_P_ARP) && trapped) {
+	if (skb->protocol == __constant_htons(ETH_P_ARP) &&
+	    atomic_read(&trapped)) {
 		arp_reply(skb);
 		return 1;
 	}
@@ -418,7 +434,7 @@ int netpoll_rx(struct sk_buff *skb)
 	spin_unlock_irqrestore(&rx_list_lock, flags);
 
 out:
-	return trapped;
+	return atomic_read(&trapped);
 }
 
 int netpoll_parse_options(struct netpoll *np, char *opt)
@@ -609,7 +625,7 @@ int netpoll_setup(struct netpoll *np)
 	if(np->rx_hook) {
 		unsigned long flags;
 
-		np->dev->netpoll_rx = 1;
+		np->dev->netpoll_rx = NETPOLL_RX_ENABLED;
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_add(&np->rx_list, &rx_list);
@@ -639,12 +655,15 @@ void netpoll_cleanup(struct netpoll *np)
 
 int netpoll_trap(void)
 {
-	return trapped;
+	return atomic_read(&trapped);
 }
 
 void netpoll_set_trap(int trap)
 {
-	trapped = trap;
+	if (trap)
+		atomic_inc(&trapped);
+	else
+		atomic_dec(&trapped);
 }
 
 EXPORT_SYMBOL(netpoll_set_trap);


-- 
Mathematics is the supreme nostalgia of our time.
