Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUHPW3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUHPW3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267982AbUHPW3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:29:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13195 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267979AbUHPW3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:29:39 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16673.13536.765055.152488@segfault.boston.redhat.com>
Date: Mon, 16 Aug 2004 18:27:44 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [patch] allow netpoll_poll to be called recursively
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

This should fix the recursive netpoll_poll deadlock that can happen with
the newly introduced netpoll_poll_lock.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.7/net/core/netpoll.c.getcpu	2004-08-16 15:50:47.275980584 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-16 15:46:53.328546000 -0400
@@ -72,7 +72,9 @@ void netpoll_poll(struct netpoll *np)
 	 * timeouts.  Thus, we set our budget to a more reasonable value.
 	 */
 	int budget = 16;
+	static int poll_owner = -1;
 	unsigned long flags;
+	int netpoll_rx_flag = NETPOLL_RX_DROP;
 
 	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
 		return;
@@ -81,17 +83,27 @@ void netpoll_poll(struct netpoll *np)
 	np->dev->poll_controller(np->dev);
 
 	/* If scheduling is stopped, tickle NAPI bits */
-	spin_lock_irqsave(&netpoll_poll_lock, flags);
+	local_irq_save(flags);
+	if (!spin_trylock(&netpoll_poll_lock)) {
+		/* allow recursive calls on this cpu */
+		if (smp_processor_id() != poll_owner)
+			spin_lock(&netpoll_poll_lock);
+		else
+			netpoll_rx_flag = 0;
+	}
+	poll_owner = smp_processor_id();
+
 	if (np->dev->poll &&
 	    test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
-		np->dev->netpoll_rx |= NETPOLL_RX_DROP;
+		np->dev->netpoll_rx |= netpoll_rx_flag;
 		atomic_inc(&trapped);
 
 		np->dev->poll(np->dev, &budget);
 
 		atomic_dec(&trapped);
-		np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
+		np->dev->netpoll_rx &= ~netpoll_rx_flag;
 	}
+	poll_owner = -1;
 	spin_unlock_irqrestore(&netpoll_poll_lock, flags);
 
 	zap_completion_queue();
