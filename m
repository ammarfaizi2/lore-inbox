Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUBHWu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUBHWu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:50:28 -0500
Received: from mail2.scram.de ([195.226.127.112]:41488 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id S264267AbUBHWtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:49:50 -0500
Date: Sun, 8 Feb 2004 23:49:33 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: tms380tr patch 2/3 (queue fix)
Message-ID: <Pine.LNX.4.58.0402082348330.1327@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

this one removes the internal queue of tms380tr. It was racy, anyways.

--jochen

 tms380tr.c |  178 +++++++++++++++++++++++--------------------------------------
 1 files changed, 70 insertions(+), 108 deletions(-)

diff -u -p -r1.17 tms380tr.c
--- drivers/net/tokenring/tms380tr.c	2004-02-08 23:29:18.000000000 +0100
+++ drivers/net/tokenring/tms380tr.c	2004-02-08 11:09:38.000000000 +0100
@@ -143,8 +145,8 @@ static void 	tms380tr_exec_sifcmd(struct
 /* "G" */
 static struct net_device_stats *tms380tr_get_stats(struct net_device *dev);
 /* "H" */
-static void 	tms380tr_hardware_send_packet(struct net_device *dev,
-			struct net_local* tp);
+static int 	tms380tr_hardware_send_packet(struct sk_buff *skb,
+			struct net_device *dev);
 /* "I" */
 static int 	tms380tr_init_adapter(struct net_device *dev);
 static void 	tms380tr_init_ipb(struct net_local *tp);
@@ -388,9 +390,6 @@ static void tms380tr_init_net_local(stru
 	tp->LastOpenStatus	= 0;
 	tp->MaxPacketSize	= DEFAULT_PACKET_SIZE;

-	skb_queue_head_init(&tp->SendSkbQueue);
-	tp->QueueSkb = MAX_TX_QUEUE;
-
 	/* Create circular chain of transmit lists */
 	for (i = 0; i < TPL_NUM; i++)
 	{
@@ -598,111 +600,87 @@ static void tms380tr_timeout(struct net_
 static int tms380tr_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct net_local *tp = (struct net_local *)dev->priv;
+	int err;

-	/*
-	 * Block transmits from overlapping.
-	 */
-
-	netif_stop_queue(dev);
-
-	if(tp->QueueSkb == 0)
-		return (1);	/* Return with tbusy set: queue full */
-
-	tp->QueueSkb--;
-	skb_queue_tail(&tp->SendSkbQueue, skb);
-	tms380tr_hardware_send_packet(dev, tp);
-	if(tp->QueueSkb > 0)
-		netif_wake_queue(dev);
-	return (0);
+	err = tms380tr_hardware_send_packet(skb, dev);
+	if(tp->TplFree->NextTPLPtr->BusyFlag)
+		netif_stop_queue(dev);
+	return (err);
 }

 /*
- * Move frames from internal skb queue into adapter tx queue
+ * Move frames into adapter tx queue
  */
-static void tms380tr_hardware_send_packet(struct net_device *dev, struct net_local* tp)
+static int tms380tr_hardware_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	TPL *tpl;
 	short length;
 	unsigned char *buf;
 	unsigned long flags;
-	struct sk_buff *skb;
 	int i;
 	dma_addr_t dmabuf, newbuf;
+	struct net_local *tp = (struct net_local *)dev->priv;

-	for(;;)
-	{
-		/* Try to get a free TPL from the chain.
-		 *
-		 * NOTE: We *must* always leave one unused TPL in the chain,
-		 * because otherwise the adapter might send frames twice.
-		 */
-		spin_lock_irqsave(&tp->lock, flags);
-		if(tp->TplFree->NextTPLPtr->BusyFlag)	/* No free TPL */
-		{
-			if (tms380tr_debug > 0)
-				printk(KERN_DEBUG "%s: No free TPL\n", dev->name);
-				spin_unlock_irqrestore(&tp->lock, flags);
-			return;
-		}
+	/* Try to get a free TPL from the chain.
+	 *
+	 * NOTE: We *must* always leave one unused TPL in the chain,
+	 * because otherwise the adapter might send frames twice.
+	 */
+	spin_lock_irqsave(&tp->lock, flags);
+	if(tp->TplFree->NextTPLPtr->BusyFlag)  { /* No free TPL */
+		if (tms380tr_debug > 0)
+			printk(KERN_DEBUG "%s: No free TPL\n", dev->name);
+		spin_unlock_irqrestore(&tp->lock, flags);
+		return 1;
+	}

-		/* Send first buffer from queue */
-		skb = skb_dequeue(&tp->SendSkbQueue);
-		if(skb == NULL)
-		{
-			spin_unlock_irqrestore(&tp->lock, flags);
-			return;
-		}
-		tp->QueueSkb++;
-		dmabuf = 0;
+	dmabuf = 0;

-		/* Is buffer reachable for Busmaster-DMA? */
+	/* Is buffer reachable for Busmaster-DMA? */

-		length	= skb->len;
-		dmabuf = pci_map_single(tp->pdev, skb->data, length, PCI_DMA_TODEVICE);
-		if(tp->dmalimit && (dmabuf + length > tp->dmalimit))
-		{
-			/* Copy frame to local buffer */
-			pci_unmap_single(tp->pdev, dmabuf, length, PCI_DMA_TODEVICE);
-			dmabuf  = 0;
-			i 	= tp->TplFree->TPLIndex;
-			buf 	= tp->LocalTxBuffers[i];
-			memcpy(buf, skb->data, length);
-			newbuf 	= ((char *)buf - (char *)tp) + tp->dmabuffer;
-		}
-		else
-		{
-			/* Send direct from skb->data */
-			newbuf	= dmabuf;
-			buf	= skb->data;
-		}
-		/* Source address in packet? */
-		tms380tr_chk_src_addr(buf, dev->dev_addr);
-		tp->LastSendTime	= jiffies;
-		tpl 			= tp->TplFree;	/* Get the "free" TPL */
-		tpl->BusyFlag 		= 1;		/* Mark TPL as busy */
-		tp->TplFree 		= tpl->NextTPLPtr;
+	length	= skb->len;
+	dmabuf = pci_map_single(tp->pdev, skb->data, length, PCI_DMA_TODEVICE);
+	if(tp->dmalimit && (dmabuf + length > tp->dmalimit)) {
+		/* Copy frame to local buffer */
+		pci_unmap_single(tp->pdev, dmabuf, length, PCI_DMA_TODEVICE);
+		dmabuf  = 0;
+		i 	= tp->TplFree->TPLIndex;
+		buf 	= tp->LocalTxBuffers[i];
+		memcpy(buf, skb->data, length);
+		newbuf 	= ((char *)buf - (char *)tp) + tp->dmabuffer;
+	}
+	else {
+		/* Send direct from skb->data */
+		newbuf	= dmabuf;
+		buf	= skb->data;
+	}
+	/* Source address in packet? */
+	tms380tr_chk_src_addr(buf, dev->dev_addr);
+	tp->LastSendTime	= jiffies;
+	tpl 			= tp->TplFree;	/* Get the "free" TPL */
+	tpl->BusyFlag 		= 1;		/* Mark TPL as busy */
+	tp->TplFree 		= tpl->NextTPLPtr;

-		/* Save the skb for delayed return of skb to system */
-		tpl->Skb = skb;
-		tpl->DMABuff = dmabuf;
-		tpl->FragList[0].DataCount = cpu_to_be16((unsigned short)length);
-		tpl->FragList[0].DataAddr  = htonl(newbuf);
-
-		/* Write the data length in the transmit list. */
-		tpl->FrameSize 	= cpu_to_be16((unsigned short)length);
-		tpl->MData 	= buf;
-
-		/* Transmit the frame and set the status values. */
-		tms380tr_write_tpl_status(tpl, TX_VALID | TX_START_FRAME
-					| TX_END_FRAME | TX_PASS_SRC_ADDR
-					| TX_FRAME_IRQ);
-
-		/* Let adapter send the frame. */
-		tms380tr_exec_sifcmd(dev, CMD_TX_VALID);
-		spin_unlock_irqrestore(&tp->lock, flags);
-	}
+	/* Save the skb for delayed return of skb to system */
+	tpl->Skb = skb;
+	tpl->DMABuff = dmabuf;
+	tpl->FragList[0].DataCount = cpu_to_be16((unsigned short)length);
+	tpl->FragList[0].DataAddr  = htonl(newbuf);
+
+	/* Write the data length in the transmit list. */
+	tpl->FrameSize 	= cpu_to_be16((unsigned short)length);
+	tpl->MData 	= buf;
+
+	/* Transmit the frame and set the status values. */
+	tms380tr_write_tpl_status(tpl, TX_VALID | TX_START_FRAME
+				| TX_END_FRAME | TX_PASS_SRC_ADDR
+				| TX_FRAME_IRQ);
+
+	/* Let adapter send the frame. */
+	tms380tr_exec_sifcmd(dev, CMD_TX_VALID);
+	spin_unlock_irqrestore(&tp->lock, flags);

-	return;
+	return 0;
 }

 /*
@@ -747,7 +725,7 @@ static void tms380tr_timer_chk(unsigned

 	tms380tr_chk_outstanding_cmds(dev);
 	if(time_before(tp->LastSendTime + SEND_TIMEOUT, jiffies)
-		&& (tp->QueueSkb < MAX_TX_QUEUE || tp->TplFree != tp->TplBusy))
+		&& (tp->TplFree != tp->TplBusy))
 	{
 		/* Anything to send, but stalled too long */
 		tp->LastSendTime = jiffies;
@@ -1769,8 +1771,8 @@ static void tms380tr_ring_status_irq(str
 	if(tp->ssb.Parm[0] & ADAPTER_CLOSED)
 	{
 		printk(KERN_INFO "%s: Adapter closed (Reopening),"
-			"QueueSkb %d, CurrentRingStat %x\n",
-			dev->name, tp->QueueSkb, tp->CurrentRingStatus);
+			"CurrentRingStat %x\n",
+			dev->name, tp->CurrentRingStatus);
 		tp->AdapterOpenFlag = 0;
 		tms380tr_open_adapter(dev);
 	}
@@ -1998,7 +2000,6 @@ static void tms380tr_read_ram(struct net
 static void tms380tr_cancel_tx_queue(struct net_local* tp)
 {
 	TPL *tpl;
-	struct sk_buff *skb;

 	/*
 	 * NOTE: There must not be an active TRANSMIT command pending, when
@@ -2023,15 +2024,6 @@ static void tms380tr_cancel_tx_queue(str
 		dev_kfree_skb_any(tpl->Skb);
 	}

-	for(;;)
-	{
-		skb = skb_dequeue(&tp->SendSkbQueue);
-		if(skb == NULL)
-			break;
-		tp->QueueSkb++;
-		dev_kfree_skb_any(skb);
-	}
-
 	return;
 }

@@ -2102,9 +2094,8 @@ static void tms380tr_tx_status_irq(struc
 		tpl->BusyFlag = 0;	/* "free" TPL */
 	}

-	netif_wake_queue(dev);
-	if(tp->QueueSkb < MAX_TX_QUEUE)
-		tms380tr_hardware_send_packet(dev, tp);
+	if(!tp->TplFree->NextTPLPtr->BusyFlag)
+		netif_wake_queue(dev);
 	return;
 }

