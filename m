Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUHPWYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUHPWYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUHPWYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:24:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46984 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267984AbUHPWX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:23:59 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.13184.377319.776597@segfault.boston.redhat.com>
Date: Mon, 16 Aug 2004 18:21:52 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [patch] fix netconsole hang w/Alt-Sysrq-t
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

This patch contains the updates necessary to fix the hangs in netconsole.
This includes the changing of trapped to an atomic_t, and the addition of a
netpoll_poll_lock.  It also turns dev->netpoll_rx into a bitfield which is
used to keep from running the networking code from the netpoll_poll call
path.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

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
