Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272468AbTG1BRo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272464AbTG1ADR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:17 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272742AbTG0W7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:59:07 -0400
Date: Sun, 27 Jul 2003 21:10:42 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272010.h6RKAgco029659@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: further z85230 fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/net/wan/z85230.c linux-2.6.0-test2-ac1/drivers/net/wan/z85230.c
--- linux-2.6.0-test2/drivers/net/wan/z85230.c	2003-07-10 21:04:09.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/net/wan/z85230.c	2003-07-17 15:49:05.000000000 +0100
@@ -890,12 +890,12 @@
 	if(c->mtu  > PAGE_SIZE/2)
 		return -EMSGSIZE;
 	 
-	c->rx_buf[0]=(void *)get_zeroed_page(GFP_KERNEL|GFP_DMA);
+	c->rx_buf[0]=(void *)get_free_page(GFP_KERNEL|GFP_DMA);
 	if(c->rx_buf[0]==NULL)
 		return -ENOBUFS;
 	c->rx_buf[1]=c->rx_buf[0]+PAGE_SIZE/2;
 	
-	c->tx_dma_buf[0]=(void *)get_zeroed_page(GFP_KERNEL|GFP_DMA);
+	c->tx_dma_buf[0]=(void *)get_free_page(GFP_KERNEL|GFP_DMA);
 	if(c->tx_dma_buf[0]==NULL)
 	{
 		free_page((unsigned long)c->rx_buf[0]);
@@ -1080,7 +1080,7 @@
 	if(c->mtu  > PAGE_SIZE/2)
 		return -EMSGSIZE;
 	 
-	c->tx_dma_buf[0]=(void *)get_zeroed_page(GFP_KERNEL|GFP_DMA);
+	c->tx_dma_buf[0]=(void *)get_free_page(GFP_KERNEL|GFP_DMA);
 	if(c->tx_dma_buf[0]==NULL)
 		return -ENOBUFS;
 
@@ -1261,7 +1261,6 @@
 	dev->chanB.dcdcheck=DCD;
 
 	/* Set up the chip level lock */
-	spin_lock_init(&dev->lock);
 	dev->chanA.lock = &dev->lock;
 	dev->chanB.lock = &dev->lock;
 
@@ -1452,7 +1451,6 @@
 	c->tx_next_skb=NULL;
 	c->tx_ptr=c->tx_next_ptr;
 	
-	netif_wake_queue(c->netdevice);
 	if(c->tx_skb==NULL)
 	{
 		/* Idle on */
@@ -1514,7 +1512,6 @@
 			/* ABUNDER off */
 			write_zsreg(c, R10, c->regs[10]);
 			write_zsctrl(c, RES_Tx_CRC);
-//???			write_zsctrl(c, RES_EOM_L);
 	
 			while(c->txcount && (read_zsreg(c,R0)&Tx_BUF_EMP))
 			{		
@@ -1524,6 +1521,10 @@
 
 		}
 	}
+	/*
+	 *	Since we emptied tx_skb we can ask for more
+	 */
+	netif_wake_queue(c->netdevice);
 }
 
 /**
@@ -1541,7 +1542,6 @@
 {
 	struct sk_buff *skb;
 
-	netif_wake_queue(c->netdevice);
 	/* Actually this can happen.*/
 	if(c->tx_skb==NULL)
 		return;
@@ -1635,7 +1635,7 @@
 			write_zsreg(c, R0, RES_Rx_CRC);
 		}
 		else
-			/* Can't occur as we don't reenable the DMA irq until
+			/* Can't occur as we dont reenable the DMA irq until
 			   after the flip is done */
 			printk(KERN_WARNING "%s: DMA flip overrun!\n", c->netdevice->name);
 			
@@ -1796,7 +1796,6 @@
 	z8530_tx_begin(c);
 	spin_unlock_irqrestore(c->lock, flags);
 	
-	netif_wake_queue(c->netdevice);
 	return 0;
 }
 
Binary files linux-2.6.0-test2/drivers/pci/gen-devlist and linux-2.6.0-test2-ac1/drivers/pci/gen-devlist differ
