Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbTLZXNR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTLZXNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:13:17 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:57096 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S265246AbTLZXM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:12:59 -0500
Date: Sat, 27 Dec 2003 00:16:13 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       <irda-users@lists.sourceforge.net>
Subject: Re: [irda-users] (irda) Badness in local_bh_enable at kernel/softirq.c:121
In-Reply-To: <20031226130031.A14007@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0312270006190.30804-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Dec 2003, Russell King wrote:

Hi Russell,

> I've just been testing w83977af_ir with ircomm on a NetWinder (ARM) and
> a Nokia mobile phone, and, while closing down the connection by exiting
> minicom, I saw this which looks particularly evil.  I'm not sure exactly
> when this occurred because I was running minicom over ssh.
> 
> Badness in local_bh_enable at kernel/softirq.c:121
> [<c00429c4>] (local_bh_enable+0x0/0x84) from [<c014d1b4>] (dev_queue_xmit+0x108/0x20c)
> [<c014d0ac>] (dev_queue_xmit+0x0/0x20c) from [<bf00ee68>] (irlap_send_data_primary_poll+0xdc/0x1c4 [irda])
> [<bf00ed8c>] (irlap_send_data_primary_poll+0x0/0x1c4 [irda]) from [<bf00babc>] (irlap_state_xmit_p+0x1a4/0x308 [irda])

Yes, Thanks. It's a known problem with 2.6.0: sirdev_txlock-patch is 
waiting on Jean's page to get forwarded - for 2.6.[12] I assume. 

Beware, there's another local_bh_enable issue with ircomm even with this 
patch applied. It's triggered when the ircomm-dev wasn't closed by the 
application before exiting (say kill -9 f.e.). So if you get another such 
badness warning with slightly different backtrace, chances are you also 
want to apply the "IrCOMM detach Oops" fixes from Jean's page.

Martin

-------------------

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

