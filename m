Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUDHKja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 06:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUDHKja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 06:39:30 -0400
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:19926 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S261602AbUDHKj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 06:39:27 -0400
Date: Thu, 8 Apr 2004 12:39:25 +0200
From: Stelian Pop <stelian@popies.net>
To: Matt Mackall <mpm@selenic.com>
Cc: kgdb-bugreport@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] netpoll: prevent transmission stall
Message-ID: <20040408103924.GU2718@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Matt Mackall <mpm@selenic.com>, kgdb-bugreport@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While working on kgdb over netpoll I found out another bug in
netpoll.

This one is in netpoll_send_skb(), and it is triggered by
sending repeatedly more packets than the transmit buffers the
ethernet card has, while being in the netpoll_trap. (this is 
rapidly triggered by kgdb when using a card with limited
transmit buffers, like my pcmcia NE2000).

One should poll() the ethernet card interrupt function in order
to get the transmit acks from the card and free the transmit 
buffers in order to be able to transmit more packets.

This is why in the original code, netpoll_send_skb() calls 
netpoll_poll() if dev->hard_start_xmit() fails. However, this
does not work because netpoll_poll() is called only if 
netif_queue_stopped(). But the net queue functions are overridden 
if netpoll_trap() is on, causing netif_queue_stopped() to never
return true.

The attached patch 'fixes' this, by forcing a netpoll_poll()
every time dev->hard_start_xmit() fails. Maybe there is a cleaner
way to do this by making the queue functions work even under
netpoll_trap, but it shouldn't really be necessary, I cannot
see how forcing the netpoll_poll() call could break anything.

Stelian.

--- net/core/netpoll.c.ORIG	2004-04-06 10:50:05.000000000 +0200
+++ net/core/netpoll.c	2004-04-08 10:41:56.484026496 +0200
@@ -163,21 +163,15 @@
 	spin_lock(&np->dev->xmit_lock);
 	np->dev->xmit_lock_owner = smp_processor_id();
 
-	if (netif_queue_stopped(np->dev)) {
-		np->dev->xmit_lock_owner = -1;
-		spin_unlock(&np->dev->xmit_lock);
-
-		netpoll_poll(np);
-		goto repeat;
-	}
-
 	status = np->dev->hard_start_xmit(skb, np->dev);
 	np->dev->xmit_lock_owner = -1;
 	spin_unlock(&np->dev->xmit_lock);
 
 	/* transmit busy */
-	if(status)
+	if(status) {
+		netpoll_poll(np);
 		goto repeat;
+	}
 }
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)


-- 
Stelian Pop <stelian@popies.net>
