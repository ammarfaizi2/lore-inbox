Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUAHCdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUAHCdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:33:32 -0500
Received: from palrel10.hp.com ([156.153.255.245]:15812 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263523AbUAHCdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:33:18 -0500
Date: Wed, 7 Jan 2004 18:33:17 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Sir-dev Tx lock fix
Message-ID: <20040108023317.GC13620@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_sirdev_txlock.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Martin Diehl>
	o [CRITICA] Fix a potential dealock in sir-dev state machine
	o [FEATURE] Make sir-dev locking compatible with irport


--- linux-2.6.0-test9-bk22/drivers/net/irda/sir_dev.c	Wed Oct  8 21:24:16 2003
+++ v2.6.0-test9-bk22/drivers/net/irda/sir_dev.c	Tue Nov 18 00:01:38 2003
@@ -62,24 +62,25 @@ int sirdev_set_dongle(struct sir_dev *de
 
 int sirdev_raw_write(struct sir_dev *dev, const char *buf, int len)
 {
+	unsigned long flags;
 	int ret;
 
 	if (unlikely(len > dev->tx_buff.truesize))
 		return -ENOSPC;
 
-	spin_lock_bh(&dev->tx_lock);		/* serialize with other tx operations */
-	while (dev->tx_buff.len > 0) {		/* wait until tx idle */
-		spin_unlock_bh(&dev->tx_lock);
+	spin_lock_irqsave(&dev->tx_lock, flags);	/* serialize with other tx operations */
+	while (dev->tx_buff.len > 0) {			/* wait until tx idle */
+		spin_unlock_irqrestore(&dev->tx_lock, flags);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(MSECS_TO_JIFFIES(10));
-		spin_lock_bh(&dev->tx_lock);
+		spin_lock_irqsave(&dev->tx_lock, flags);
 	}
 
 	dev->tx_buff.data = dev->tx_buff.head;
 	memcpy(dev->tx_buff.data, buf, len);	
 
 	ret = dev->drv->do_write(dev, dev->tx_buff.data, dev->tx_buff.len);
-	spin_unlock_bh(&dev->tx_lock);
+	spin_unlock_irqrestore(&dev->tx_lock, flags);
 	return ret;
 }
 
@@ -114,11 +115,12 @@ int sirdev_raw_read(struct sir_dev *dev,
 
 void sirdev_write_complete(struct sir_dev *dev)
 {
+	unsigned long flags;
 	struct sk_buff *skb;
 	int actual = 0;
 	int err;
 	
-	spin_lock_bh(&dev->tx_lock);
+	spin_lock_irqsave(&dev->tx_lock, flags);
 
 	IRDA_DEBUG(3, "%s() - dev->tx_buff.len = %d\n",
 		   __FUNCTION__, dev->tx_buff.len);
@@ -143,7 +145,7 @@ void sirdev_write_complete(struct sir_de
 			dev->tx_buff.len = 0;
 		}
 		if (dev->tx_buff.len > 0) {
-			spin_unlock_bh(&dev->tx_lock);
+			spin_unlock_irqrestore(&dev->tx_lock, flags);
 			return;
 		}
 	}
@@ -190,7 +192,7 @@ void sirdev_write_complete(struct sir_de
 		netif_wake_queue(dev->netdev);
 	}
 
-	spin_unlock_bh(&dev->tx_lock);
+	spin_unlock_irqrestore(&dev->tx_lock, flags);
 }
 
 /* called from client driver - likely with bh-context - to give us
@@ -258,6 +260,7 @@ static struct net_device_stats *sirdev_g
 static int sirdev_hard_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct sir_dev *dev = ndev->priv;
+	unsigned long flags;
 	int actual = 0;
 	int err;
 	s32 speed;
@@ -307,7 +310,7 @@ static int sirdev_hard_xmit(struct sk_bu
 	}
 
 	/* serialize with write completion */
-	spin_lock_bh(&dev->tx_lock);
+	spin_lock_irqsave(&dev->tx_lock, flags);
 
         /* Copy skb to tx_buff while wrapping, stuffing and making CRC */
 	dev->tx_buff.len = async_wrap_skb(skb, dev->tx_buff.data, dev->tx_buff.truesize); 
@@ -337,7 +340,7 @@ static int sirdev_hard_xmit(struct sk_bu
 		dev->stats.tx_dropped++;		      
 		netif_wake_queue(ndev);
 	}
-	spin_unlock_bh(&dev->tx_lock);
+	spin_unlock_irqrestore(&dev->tx_lock, flags);
 
 	return 0;
 }
--- linux-2.6.0-test9-bk22/drivers/net/irda/sir_kthread.c	Wed Oct  8 21:24:27 2003
+++ v2.6.0-test9-bk22/drivers/net/irda/sir_kthread.c	Mon Nov 17 17:39:54 2003
@@ -436,14 +436,13 @@ int sirdev_schedule_request(struct sir_d
 
 	IRDA_DEBUG(2, "%s - state=0x%04x / param=%u\n", __FUNCTION__, initial_state, param);
 
-	if (in_interrupt()) {
-		if (down_trylock(&fsm->sem)) {
+	if (down_trylock(&fsm->sem)) {
+		if (in_interrupt()  ||  in_atomic()  ||  irqs_disabled()) {
 			IRDA_DEBUG(1, "%s(), state machine busy!\n", __FUNCTION__);
 			return -EWOULDBLOCK;
-		}
+		} else
+			down(&fsm->sem);
 	}
-	else
-		down(&fsm->sem);
 
 	if (fsm->state == SIRDEV_STATE_DEAD) {
 		/* race with sirdev_close should never happen */

