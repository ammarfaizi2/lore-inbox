Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRIMWFm>; Thu, 13 Sep 2001 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272592AbRIMWFe>; Thu, 13 Sep 2001 18:05:34 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:9295 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S272622AbRIMWFW>; Thu, 13 Sep 2001 18:05:22 -0400
Date: Thu, 13 Sep 2001 18:05:40 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, saw@saw.sw.com.sg
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup eepro100 indentation
Message-ID: <20010913180540.D4539@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to fix a braindead indentation mess in speedo_start_xmit 
that someone added when adding the flags variable.  *sigh*.

		-ben


diff -urN v2.4.9-ac10/drivers/net/eepro100.c foo-v2.4.9-ac10/drivers/net/eepro100.c
--- v2.4.9-ac10/drivers/net/eepro100.c	Mon Sep 10 15:10:59 2001
+++ foo-v2.4.9-ac10/drivers/net/eepro100.c	Thu Sep 13 18:02:08 2001
@@ -1313,56 +1313,55 @@
 	long ioaddr = dev->base_addr;
 	int entry;
 
-	{	/* Prevent interrupts from changing the Tx ring from underneath us. */
-		unsigned long flags;
+	/* Prevent interrupts from changing the Tx ring from underneath us. */
+	unsigned long flags;
 
-		spin_lock_irqsave(&sp->lock, flags);
-
-		/* Check if there are enough space. */
-		if ((int)(sp->cur_tx - sp->dirty_tx) >= TX_QUEUE_LIMIT) {
-			printk(KERN_ERR "%s: incorrect tbusy state, fixed.\n", dev->name);
-			netif_stop_queue(dev);
-			sp->tx_full = 1;
-			spin_unlock_irqrestore(&sp->lock, flags);
-			return 1;
-		}
-
-		/* Calculate the Tx descriptor entry. */
-		entry = sp->cur_tx++ % TX_RING_SIZE;
-
-		sp->tx_skbuff[entry] = skb;
-		sp->tx_ring[entry].status =
-			cpu_to_le32(CmdSuspend | CmdTx | CmdTxFlex);
-		if (!(entry & ((TX_RING_SIZE>>2)-1)))
-			sp->tx_ring[entry].status |= cpu_to_le32(CmdIntr);
-		sp->tx_ring[entry].link =
-			cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->cur_tx % TX_RING_SIZE));
-		sp->tx_ring[entry].tx_desc_addr =
-			cpu_to_le32(TX_RING_ELEM_DMA(sp, entry) + TX_DESCR_BUF_OFFSET);
-		/* The data region is always in one buffer descriptor. */
-		sp->tx_ring[entry].count = cpu_to_le32(sp->tx_threshold);
-		sp->tx_ring[entry].tx_buf_addr0 =
-			cpu_to_le32(pci_map_single(sp->pdev, skb->data,
-						   skb->len, PCI_DMA_TODEVICE));
-		sp->tx_ring[entry].tx_buf_size0 = cpu_to_le32(skb->len);
-		/* Trigger the command unit resume. */
-		wait_for_cmd_done(ioaddr + SCBCmd);
-		clear_suspend(sp->last_cmd);
-		/* We want the time window between clearing suspend flag on the previous
-		   command and resuming CU to be as small as possible.
-		   Interrupts in between are very undesired.  --SAW */
-		outb(CUResume, ioaddr + SCBCmd);
-		sp->last_cmd = (struct descriptor *)&sp->tx_ring[entry];
-
-		/* Leave room for set_rx_mode(). If there is no more space than reserved
-		   for multicast filter mark the ring as full. */
-		if ((int)(sp->cur_tx - sp->dirty_tx) >= TX_QUEUE_LIMIT) {
-			netif_stop_queue(dev);
-			sp->tx_full = 1;
-		}
+	spin_lock_irqsave(&sp->lock, flags);
 
+	/* Check if there are enough space. */
+	if ((int)(sp->cur_tx - sp->dirty_tx) >= TX_QUEUE_LIMIT) {
+		printk(KERN_ERR "%s: incorrect tbusy state, fixed.\n", dev->name);
+		netif_stop_queue(dev);
+		sp->tx_full = 1;
 		spin_unlock_irqrestore(&sp->lock, flags);
+		return 1;
 	}
+
+	/* Calculate the Tx descriptor entry. */
+	entry = sp->cur_tx++ % TX_RING_SIZE;
+
+	sp->tx_skbuff[entry] = skb;
+	sp->tx_ring[entry].status =
+		cpu_to_le32(CmdSuspend | CmdTx | CmdTxFlex);
+	if (!(entry & ((TX_RING_SIZE>>2)-1)))
+		sp->tx_ring[entry].status |= cpu_to_le32(CmdIntr);
+	sp->tx_ring[entry].link =
+		cpu_to_le32(TX_RING_ELEM_DMA(sp, sp->cur_tx % TX_RING_SIZE));
+	sp->tx_ring[entry].tx_desc_addr =
+		cpu_to_le32(TX_RING_ELEM_DMA(sp, entry) + TX_DESCR_BUF_OFFSET);
+	/* The data region is always in one buffer descriptor. */
+	sp->tx_ring[entry].count = cpu_to_le32(sp->tx_threshold);
+	sp->tx_ring[entry].tx_buf_addr0 =
+		cpu_to_le32(pci_map_single(sp->pdev, skb->data,
+					   skb->len, PCI_DMA_TODEVICE));
+	sp->tx_ring[entry].tx_buf_size0 = cpu_to_le32(skb->len);
+	/* Trigger the command unit resume. */
+	wait_for_cmd_done(ioaddr + SCBCmd);
+	clear_suspend(sp->last_cmd);
+	/* We want the time window between clearing suspend flag on the previous
+	   command and resuming CU to be as small as possible.
+	   Interrupts in between are very undesired.  --SAW */
+	outb(CUResume, ioaddr + SCBCmd);
+	sp->last_cmd = (struct descriptor *)&sp->tx_ring[entry];
+
+	/* Leave room for set_rx_mode(). If there is no more space than reserved
+	   for multicast filter mark the ring as full. */
+	if ((int)(sp->cur_tx - sp->dirty_tx) >= TX_QUEUE_LIMIT) {
+		netif_stop_queue(dev);
+		sp->tx_full = 1;
+	}
+
+	spin_unlock_irqrestore(&sp->lock, flags);
 
 	dev->trans_start = jiffies;
 
