Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTBTX74>; Thu, 20 Feb 2003 18:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbTBTX74>; Thu, 20 Feb 2003 18:59:56 -0500
Received: from palrel13.hp.com ([156.153.255.238]:51599 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id <S267322AbTBTX7t>;
	Thu, 20 Feb 2003 18:59:49 -0500
Date: Thu, 20 Feb 2003 16:09:54 -0800
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : irtty-sir ZeroCopy Rx
Message-ID: <20030221000954.GE26770@bougret.hpl.hp.com>
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

ir253_sir-dev_wrapper-4.diff :
----------------------------
	o [FEATURE] Enable ZeroCopy Rx in irtty-sir/sir-dev
		(provided by the new SIR wrapper in 2.5.61).


diff -u -p linux/drivers/net/irda/sir_dev.d7.c linux/drivers/net/irda/sir_dev.c
--- linux/drivers/net/irda/sir_dev.d7.c	Thu Feb 20 11:07:06 2003
+++ linux/drivers/net/irda/sir_dev.c	Thu Feb 20 11:11:44 2003
@@ -223,25 +223,24 @@ int sirdev_receive(struct sir_dev *dev, 
 	}
 
 	/* Read the characters into the buffer */
- 	while (count--) {
-		if (likely(atomic_read(&dev->enable_rx))) {
+	if (likely(atomic_read(&dev->enable_rx))) {
+		while (count--)
 			/* Unwrap and destuff one byte */
 			async_unwrap_char(dev->netdev, &dev->stats, 
-				  &dev->rx_buff, *cp++);
-		}
-		else {
+					  &dev->rx_buff, *cp++);
+	} else {
+		while (count--) {
 			/* rx not enabled: save the raw bytes and never
 			 * trigger any netif_rx. The received bytes are flushed
 			 * later when we re-enable rx but might be read meanwhile
 			 * by the dongle driver.
 			 */
 			dev->rx_buff.data[dev->rx_buff.len++] = *cp++;
-		}
 
-		/* What should we do when the buffer is full? */
-		if (unlikely(dev->rx_buff.len == dev->rx_buff.truesize))
-			dev->rx_buff.len = 0;
-			
+			/* What should we do when the buffer is full? */
+			if (unlikely(dev->rx_buff.len == dev->rx_buff.truesize))
+				dev->rx_buff.len = 0;
+		}
 	}
 
 	return 0;
@@ -423,19 +422,24 @@ static int sirdev_ioctl(struct net_devic
 
 static int sirdev_alloc_buffers(struct sir_dev *dev)
 {
-	dev->rx_buff.truesize = SIRBUF_ALLOCSIZE; 
 	dev->tx_buff.truesize = SIRBUF_ALLOCSIZE;
+	dev->rx_buff.truesize = IRDA_SKB_MAX_MTU; 
 
-	dev->rx_buff.head = kmalloc(dev->rx_buff.truesize, GFP_KERNEL);
-	if (dev->rx_buff.head == NULL)
+	/* Bootstrap ZeroCopy Rx */
+	dev->rx_buff.skb = __dev_alloc_skb(dev->rx_buff.truesize, GFP_KERNEL);
+	if (dev->rx_buff.skb == NULL)
 		return -ENOMEM;
-	memset(dev->rx_buff.head, 0, dev->rx_buff.truesize);
+	skb_reserve(dev->rx_buff.skb, 1);
+	dev->rx_buff.head = dev->rx_buff.skb->data;
+	/* No need to memset the buffer, unless you are really pedantic */
 
 	dev->tx_buff.head = kmalloc(dev->tx_buff.truesize, GFP_KERNEL);
 	if (dev->tx_buff.head == NULL) {
-		kfree(dev->rx_buff.head);
+		kfree_skb(dev->rx_buff.skb);
+		dev->rx_buff.skb = NULL;
 		dev->rx_buff.head = NULL;
 		return -ENOMEM;
+		/* Hu ??? This should not be here, Martin ? */
 		memset(dev->tx_buff.head, 0, dev->tx_buff.truesize);
 	}
 
@@ -451,11 +455,12 @@ static int sirdev_alloc_buffers(struct s
 
 static void sirdev_free_buffers(struct sir_dev *dev)
 {
-	if (dev->rx_buff.head)
-		kfree(dev->rx_buff.head);
+	if (dev->rx_buff.skb)
+		kfree_skb(dev->rx_buff.skb);
 	if (dev->tx_buff.head)
 		kfree(dev->tx_buff.head);
 	dev->rx_buff.head = dev->tx_buff.head = NULL;
+	dev->rx_buff.skb = NULL;
 }
 
 static int sirdev_open(struct net_device *ndev)
