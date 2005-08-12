Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVHLCUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVHLCUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVHLCUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:20:12 -0400
Received: from waste.org ([216.27.176.166]:64935 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964785AbVHLCTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:19:49 -0400
Date: Thu, 11 Aug 2005 21:19:11 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>, "David S. Miller" <davem@davemloft.net>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: ak@suse.de, Jeff Moyer <jmoyer@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu, john.ronciak@intel.com,
       rostedt@goodmis.org
In-Reply-To: <5.502409567@selenic.com>
Message-Id: <6.502409567@selenic.com>
Subject: [PATCH 5/8] netpoll: add retry timeout
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add limited retry logic to netpoll_send_skb

Each time we attempt to send, decrement our per-device retry counter.
On every successful send, we reset the counter. 

We delay 50us between attempts with up to 20000 retries for a total of
1 second. After we've exhausted our retries, subsequent failed
attempts will try only once until reset by success.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: lhg/net/core/netpoll.c
===================================================================
--- lhg.orig/net/core/netpoll.c	2005-08-11 16:17:45.000000000 -0700
+++ lhg/net/core/netpoll.c	2005-08-11 16:45:20.000000000 -0700
@@ -33,6 +33,7 @@
 #define MAX_UDP_CHUNK 1460
 #define MAX_SKBS 32
 #define MAX_QUEUE_DEPTH (MAX_SKBS / 2)
+#define MAX_RETRIES 20000
 
 static DEFINE_SPINLOCK(skb_list_lock);
 static int nr_skbs;
@@ -265,7 +266,8 @@ static void netpoll_send_skb(struct netp
 		return;
 	}
 
-	while (1) {
+	do {
+		npinfo->tries--;
 		spin_lock(&np->dev->xmit_lock);
 		np->dev->xmit_lock_owner = smp_processor_id();
 
@@ -277,6 +279,7 @@ static void netpoll_send_skb(struct netp
 			np->dev->xmit_lock_owner = -1;
 			spin_unlock(&np->dev->xmit_lock);
 			netpoll_poll(np);
+			udelay(50);
 			continue;
 		}
 
@@ -285,12 +288,15 @@ static void netpoll_send_skb(struct netp
 		spin_unlock(&np->dev->xmit_lock);
 
 		/* success */
-		if(!status)
+		if(!status) {
+			npinfo->tries = MAX_RETRIES; /* reset */
 			return;
+		}
 
 		/* transmit busy */
 		netpoll_poll(np);
-	}
+		udelay(50);
+	} while (npinfo->tries > 0);
 }
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
@@ -642,6 +648,7 @@ int netpoll_setup(struct netpoll *np)
 		npinfo->rx_np = NULL;
 		npinfo->poll_lock = SPIN_LOCK_UNLOCKED;
 		npinfo->poll_owner = -1;
+		npinfo->tries = MAX_RETRIES;
 		npinfo->rx_lock = SPIN_LOCK_UNLOCKED;
 	} else
 		npinfo = ndev->npinfo;
Index: lhg/include/linux/netpoll.h
===================================================================
--- lhg.orig/include/linux/netpoll.h	2005-08-11 15:40:27.000000000 -0700
+++ lhg/include/linux/netpoll.h	2005-08-11 16:17:56.000000000 -0700
@@ -26,6 +26,7 @@ struct netpoll {
 struct netpoll_info {
 	spinlock_t poll_lock;
 	int poll_owner;
+	int tries;
 	int rx_flags;
 	spinlock_t rx_lock;
 	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
