Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315276AbSF3PR7>; Sun, 30 Jun 2002 11:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSF3PR6>; Sun, 30 Jun 2002 11:17:58 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:8129 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315276AbSF3PRd>;
	Sun, 30 Jun 2002 11:17:33 -0400
Date: Sun, 30 Jun 2002 17:19:54 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 8/10
Message-ID: <20020630171954.J19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- descriptors converted to synchronous DMA mapping.

--- linux-2.5.24/drivers/net/tlan.h	Sun Jun 30 00:00:39 2002
+++ linux-2.5.24/drivers/net/tlan.h	Sun Jun 30 14:34:27 2002
@@ -173,8 +173,8 @@ typedef struct tlan_private_tag {
 	struct pci_dev  	*pci_dev;
 	dma_addr_t		rxBuffer_dma;
 	dma_addr_t		txBuffer_dma;
+	dma_addr_t		lists_dma;
 	struct net_device       *nextDevice;
-	void			*dmaStorage;
 	u8			*padBuffer;
 	TLanList                *rxList;
 	u8			*rxBuffer;
--- linux-2.5.24/drivers/net/tlan.c	Sun Jun 30 00:00:42 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sun Jun 30 14:53:29 2002
@@ -639,8 +639,7 @@ static void TLan_Release_Dev(struct net_
 	TLanPrivateInfo *priv = dev->priv;
 	struct pci_dev	*pdev = priv->pci_dev;
 
-	if (priv->dmaStorage)
-		kfree(priv->dmaStorage);
+	pci_free_consistent(pdev, TLAN_TOTAL_SIZE, priv->rxList, priv->lists_dma);
 	if ( bbuf )
 		TLan_ReleaseBuffers(pdev, priv);
 	release_region(dev->base_addr, 0x10);
@@ -814,16 +813,19 @@ static int TLan_Init( struct net_device 
 		}
 
 	dma_size = TLAN_TOTAL_SIZE;	
-	priv->dmaStorage = kmalloc(dma_size, GFP_KERNEL | GFP_DMA);
-	if ( priv->dmaStorage == NULL ) {
+	addr = pci_alloc_consistent(pdev, TLAN_TOTAL_SIZE, &priv->lists_dma);
+	if (!addr) {
 		printk(KERN_ERR "TLAN:  Could not allocate lists and buffers for %s.\n",
 			dev->name );
 		release_region( dev->base_addr, 0x10 );
 		return -ENOMEM;
 	}
-	memset( priv->dmaStorage, 0, dma_size );
-	priv->rxList = (TLanList *) 
-		       ( ( ( (u32) priv->dmaStorage ) + 7 ) & 0xFFFFFFF8 );
+	/*
+	 * pci_alloc_consistent and an adequate power of 2 for TLAN_NUM_RX_LISTS
+	 * guarantees that &xList is aligned on a 8 bytes boundary (required 
+	 * for rx and tx).
+	 */
+	priv->rxList = (TLanList *)addr;
 	priv->txList = priv->rxList + TLAN_NUM_RX_LISTS;
 	if ( bbuf ) {
 		dma_size = TLAN_NUM_ALL_LISTS * TLAN_MAX_FRAME_SIZE;
@@ -831,6 +833,8 @@ static int TLan_Init( struct net_device 
 		if ( addr == NULL ) {
 			printk(KERN_ERR "%s: buffers allocation failed\n",
 				dev->name );
+			pci_free_consistent(pdev, TLAN_TOTAL_SIZE, priv->rxList,
+				priv->lists_dma);
 			release_region( dev->base_addr, 0x10 );
 			return -ENOMEM;
 		}
@@ -1074,15 +1078,15 @@ static int TLan_StartTx( struct sk_buff 
 	if ( ! priv->txInProgress ) {
 		priv->txInProgress = 1;
 		TLAN_DBG( TLAN_DEBUG_TX, "TRANSMIT:  Starting TX on buffer %d\n", priv->txTail );
-		outl( virt_to_bus( tail_list ), dev->base_addr + TLAN_CH_PARM );
+		outl( priv->lists_dma +
+			(TLAN_NUM_RX_LISTS + priv->txTail)*sizeof(TLanList),
+			dev->base_addr + TLAN_CH_PARM );
 		outl( TLAN_HC_GO, dev->base_addr + TLAN_HOST_CMD );
 	} else {
 		TLAN_DBG( TLAN_DEBUG_TX, "TRANSMIT:  Adding buffer %d to TX channel\n", priv->txTail );
-		if ( priv->txTail == 0 ) {
-			( priv->txList + ( TLAN_NUM_TX_LISTS - 1 ) )->forward = virt_to_bus( tail_list );
-		} else {
-			( priv->txList + ( priv->txTail - 1 ) )->forward = virt_to_bus( tail_list );
-		}
+		priv->txList[(priv->txTail-1)%TLAN_NUM_TX_LISTS].forward =
+			priv->lists_dma +
+			(TLAN_NUM_RX_LISTS + priv->txTail)*sizeof(TLanList);
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -1397,7 +1401,9 @@ u32 TLan_HandleTxEOF( struct net_device 
 		TLAN_DBG( TLAN_DEBUG_TX, "TRANSMIT:  Handling TX EOC (Head=%d Tail=%d)\n", priv->txHead, priv->txTail );
 		head_list = priv->txList + priv->txHead;
 		if ( ( head_list->cStat & TLAN_CSTAT_READY ) == TLAN_CSTAT_READY ) {
-			outl( virt_to_bus( head_list ), dev->base_addr + TLAN_CH_PARM );
+			outl( priv->lists_dma +
+				(TLAN_NUM_RX_LISTS + priv->txHead)*sizeof(TLanList),
+				dev->base_addr + TLAN_CH_PARM );
 			ack |= TLAN_HC_GO;
 		} else {
 			priv->txInProgress = 0;
@@ -1560,7 +1566,8 @@ u32 TLan_HandleRxEOF( struct net_device 
 		head_list->forward = 0;
 		head_list->cStat = 0;
 		tail_list = priv->rxList + priv->rxTail;
-		tail_list->forward = virt_to_bus( head_list );
+		tail_list->forward = priv->lists_dma + 
+			priv->rxHead*sizeof(TLanList);
 
 		CIRC_INC( priv->rxHead, TLAN_NUM_RX_LISTS );
 		CIRC_INC( priv->rxTail, TLAN_NUM_RX_LISTS );
@@ -1576,7 +1583,8 @@ u32 TLan_HandleRxEOF( struct net_device 
 	if ( eoc ) { 
 		TLAN_DBG( TLAN_DEBUG_RX, "RECEIVE:  Handling RX EOC (Head=%d Tail=%d)\n", priv->rxHead, priv->rxTail );
 		head_list = priv->rxList + priv->rxHead;
-		outl( virt_to_bus( head_list ), dev->base_addr + TLAN_CH_PARM );
+		outl( priv->lists_dma + priv->rxHead*sizeof(TLanList),
+			dev->base_addr + TLAN_CH_PARM );
 		ack |= TLAN_HC_GO | TLAN_HC_RT;
 		priv->rxEocCount++;
 	}
@@ -1663,7 +1671,9 @@ u32 TLan_HandleTxEOC( struct net_device 
 		head_list = priv->txList + priv->txHead;
 		if ( ( head_list->cStat & TLAN_CSTAT_READY ) == TLAN_CSTAT_READY ) {
 			netif_stop_queue(dev);
-			outl( virt_to_bus( head_list ), dev->base_addr + TLAN_CH_PARM );
+			outl( priv->lists_dma + (TLAN_NUM_RX_LISTS +
+				priv->txHead)*sizeof(TLanList),
+				dev->base_addr + TLAN_CH_PARM );
 			ack |= TLAN_HC_GO;
 		} else {
 			priv->txInProgress = 0;
@@ -1782,7 +1792,8 @@ u32 TLan_HandleRxEOC( struct net_device 
 	if (  priv->tlanRev < 0x30 ) {
 		TLAN_DBG( TLAN_DEBUG_RX, "RECEIVE:  Handling RX EOC (Head=%d Tail=%d) -- IRQ\n", priv->rxHead, priv->rxTail );
 		head_list = priv->rxList + priv->rxHead;
-		outl( virt_to_bus( head_list ), dev->base_addr + TLAN_CH_PARM );
+		outl( priv->lists_dma + priv->rxHead*sizeof(TLanList),
+			dev->base_addr + TLAN_CH_PARM );
 		ack |= TLAN_HC_GO | TLAN_HC_RT;
 		priv->rxEocCount++;
 	}
@@ -1964,12 +1975,9 @@ void TLan_ResetLists( struct net_device 
 		}
 		list->buffer[1].count = 0;
 		list->buffer[1].address = 0;
-		if ( i < TLAN_NUM_RX_LISTS - 1 )
-			list->forward = virt_to_bus( list + 1 );
-		else
-			list->forward = 0;
+		list->forward = priv->lists_dma + (i+1)*sizeof(TLanList);
 	}
-
+	list->forward = 0;
 } /* TLan_ResetLists */
 
 static void TLan_ResetTxBuffer(struct pci_dev *pdev, TLanList *list)
@@ -2347,7 +2355,7 @@ TLan_FinishReset( struct net_device *dev
 		if ( debug >= 1 && debug != TLAN_DEBUG_PROBE ) {
 			outb( ( TLAN_HC_REQ_INT >> 8 ), dev->base_addr + TLAN_HOST_CMD + 1 );
 		}
-		outl( virt_to_bus( priv->rxList ), dev->base_addr + TLAN_CH_PARM );
+		outl( priv->lists_dma, dev->base_addr + TLAN_CH_PARM );
 		outl( TLAN_HC_GO | TLAN_HC_RT, dev->base_addr + TLAN_HOST_CMD );
 	} else {
 		printk( "TLAN: %s: Link inactive, will retry in 10 secs...\n", dev->name );
