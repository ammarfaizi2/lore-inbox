Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVGMVyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVGMVyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVGMSpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:45:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:20451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262315AbVGMSox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:44:53 -0400
Date: Wed, 13 Jul 2005 11:43:23 -0700
From: Greg KH <gregkh@suse.de>
To: davem@davemloft.net, hch@lst.de
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [04/11] [SHAPER] fix Shaper driver lossage in 2.6.12
Message-ID: <20050713184323.GF9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

[SHAPER]: Switch to spinlocks.

Dave, you were right and the sleeping locks in shaper were
broken. Markus Kanet noticed this and also tested the patch below that
switches locking to spinlocks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/net/shaper.c      |   42 ++++++++++++++++--------------------------
 include/linux/if_shaper.h |    2 +-
 2 files changed, 17 insertions(+), 27 deletions(-)

--- linux-2.6.12.2.orig/drivers/net/shaper.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/drivers/net/shaper.c	2005-07-13 10:56:34.000000000 -0700
@@ -135,10 +135,8 @@
 {
 	struct shaper *shaper = dev->priv;
  	struct sk_buff *ptr;
-   
-	if (down_trylock(&shaper->sem))
-		return -1;
-
+
+	spin_lock(&shaper->lock);
  	ptr=shaper->sendq.prev;
  	
  	/*
@@ -232,7 +230,7 @@
                 shaper->stats.collisions++;
  	}
 	shaper_kick(shaper);
-	up(&shaper->sem);
+	spin_unlock(&shaper->lock);
  	return 0;
 }
 
@@ -271,11 +269,9 @@
 {
 	struct shaper *shaper = (struct shaper *)data;
 
-	if (!down_trylock(&shaper->sem)) {
-		shaper_kick(shaper);
-		up(&shaper->sem);
-	} else
-		mod_timer(&shaper->timer, jiffies);
+	spin_lock(&shaper->lock);
+	shaper_kick(shaper);
+	spin_unlock(&shaper->lock);
 }
 
 /*
@@ -332,21 +328,6 @@
 
 
 /*
- *	Flush the shaper queues on a closedown
- */
- 
-static void shaper_flush(struct shaper *shaper)
-{
-	struct sk_buff *skb;
-
-	down(&shaper->sem);
-	while((skb=skb_dequeue(&shaper->sendq))!=NULL)
-		dev_kfree_skb(skb);
-	shaper_kick(shaper);
-	up(&shaper->sem);
-}
-
-/*
  *	Bring the interface up. We just disallow this until a 
  *	bind.
  */
@@ -375,7 +356,15 @@
 static int shaper_close(struct net_device *dev)
 {
 	struct shaper *shaper=dev->priv;
-	shaper_flush(shaper);
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&shaper->sendq)) != NULL)
+		dev_kfree_skb(skb);
+
+	spin_lock_bh(&shaper->lock);
+	shaper_kick(shaper);
+	spin_unlock_bh(&shaper->lock);
+
 	del_timer_sync(&shaper->timer);
 	return 0;
 }
@@ -576,6 +565,7 @@
 	init_timer(&sh->timer);
 	sh->timer.function=shaper_timer;
 	sh->timer.data=(unsigned long)sh;
+	spin_lock_init(&sh->lock);
 }
 
 /*
--- linux-2.6.12.2.orig/include/linux/if_shaper.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/include/linux/if_shaper.h	2005-07-13 10:56:34.000000000 -0700
@@ -23,7 +23,7 @@
 	__u32 shapeclock;
 	unsigned long recovery;	/* Time we can next clock a packet out on
 				   an empty queue */
-	struct semaphore sem;
+	spinlock_t lock;
         struct net_device_stats stats;
 	struct net_device *dev;
 	int  (*hard_start_xmit) (struct sk_buff *skb,
