Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUDJUfS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUDJUfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:35:17 -0400
Received: from waste.org ([209.173.204.2]:31717 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262113AbUDJUfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:35:06 -0400
Date: Sat, 10 Apr 2004 15:34:13 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Stelian Pop <stelian@popies.net>, Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] netpoll transmit busy bugfix
Message-ID: <20040410203413.GS6248@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for handling of full transmit queue when netpoll trap is enabled.

>From Stelian Pop <stelian@popies.net>

%patch
Index: mm/net/core/netpoll.c
===================================================================
--- mm.orig/net/core/netpoll.c	2004-04-10 15:15:25.000000000 -0500
+++ mm/net/core/netpoll.c	2004-04-10 15:19:31.000000000 -0500
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

%diffstat
 netpoll.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)



-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
