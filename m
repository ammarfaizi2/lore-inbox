Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUAHCfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbUAHCfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:35:05 -0500
Received: from palrel10.hp.com ([156.153.255.245]:41668 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263526AbUAHCd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:33:58 -0500
Date: Wed, 7 Jan 2004 18:33:57 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] sir-dev raw mode fix
Message-ID: <20040108023357.GD13620@bougret.hpl.hp.com>
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

irXXX_sirdev_rawmode.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~
		<Apply *after* irXXX_sirdev_txlock.diff patch>
		<Patch from Martin Diehl>
	o [CORRECT] Fix sir-dev 'raw' mode for sir dongles that need it


diff -urp linux-2.6.0-test9-bk22/drivers/net/irda/sir-dev.h v2.6.0-md/drivers/net/irda/sir-dev.h
--- linux-2.6.0-test9-bk22/drivers/net/irda/sir-dev.h	Wed Oct  8 21:24:07 2003
+++ v2.6.0-md/drivers/net/irda/sir-dev.h	Mon Nov 17 18:51:41 2003
@@ -179,6 +179,7 @@ struct sir_dev {
 
 	struct sir_fsm fsm;
 	atomic_t enable_rx;
+	int raw_tx;
 	spinlock_t tx_lock;
 
 	u32 new_speed;
diff -urp linux-2.6.0-test9-bk22/drivers/net/irda/sir_dev.c v2.6.0-md/drivers/net/irda/sir_dev.c
--- linux-2.6.0-test9-bk22/drivers/net/irda/sir_dev.c	Mon Nov 17 17:39:54 2003
+++ v2.6.0-md/drivers/net/irda/sir_dev.c	Mon Nov 17 18:51:41 2003
@@ -31,7 +31,9 @@ void sirdev_enable_rx(struct sir_dev *de
 
 	/* flush rx-buffer - should also help in case of problems with echo cancelation */
 	dev->rx_buff.data = dev->rx_buff.head;
-	dev->tx_buff.len = 0;
+	dev->rx_buff.len = 0;
+	dev->rx_buff.in_frame = FALSE;
+	dev->rx_buff.state = OUTSIDE_FRAME;
 	atomic_set(&dev->enable_rx, 1);
 }
 
@@ -78,8 +80,17 @@ int sirdev_raw_write(struct sir_dev *dev
 
 	dev->tx_buff.data = dev->tx_buff.head;
 	memcpy(dev->tx_buff.data, buf, len);	
+	dev->tx_buff.len = len;
 
 	ret = dev->drv->do_write(dev, dev->tx_buff.data, dev->tx_buff.len);
+	if (ret > 0) {
+		IRDA_DEBUG(3, "%s(), raw-tx started\n", __FUNCTION__);
+
+		dev->tx_buff.data += ret;
+		dev->tx_buff.len -= ret;
+		dev->raw_tx = 1;
+		ret = len;		/* all data is going to be sent */
+	}
 	spin_unlock_irqrestore(&dev->tx_lock, flags);
 	return ret;
 }
@@ -95,13 +106,13 @@ int sirdev_raw_read(struct sir_dev *dev,
 
 	count = (len < dev->rx_buff.len) ? len : dev->rx_buff.len;
 
-	if (count > 0)
-		memcpy(buf, dev->rx_buff.head, count);
+	if (count > 0) {
+		memcpy(buf, dev->rx_buff.data, count);
+		dev->rx_buff.data += count;
+		dev->rx_buff.len -= count;
+	}
 
-	/* forget trailing stuff */
-	dev->rx_buff.data = dev->rx_buff.head;
-	dev->rx_buff.len = 0;
-	dev->rx_buff.state = OUTSIDE_FRAME;
+	/* remaining stuff gets flushed when re-enabling normal rx */
 
 	return count;
 }
@@ -150,6 +161,19 @@ void sirdev_write_complete(struct sir_de
 		}
 	}
 
+	if (unlikely(dev->raw_tx != 0)) {
+		/* in raw mode we are just done now after the buffer was sent
+		 * completely. Since this was requested by some dongle driver
+		 * running under the control of the irda-thread we must take
+		 * care here not to re-enable the queue. The queue will be
+		 * restarted when the irda-thread has completed the request.
+		 */
+
+		IRDA_DEBUG(3, "%s(), raw-tx done\n", __FUNCTION__);
+		dev->raw_tx = 0;
+		return;
+	}
+
 	/* we have finished now sending this skb.
 	 * update statistics and free the skb.
 	 * finally we check and trigger a pending speed change, if any.
@@ -482,6 +506,7 @@ static int sirdev_open(struct net_device
 		goto errout_free;
 
 	sirdev_enable_rx(dev);
+	dev->raw_tx = 0;
 
 	netif_start_queue(ndev);
 	dev->irlap = irlap_open(ndev, &dev->qos, dev->hwname);

