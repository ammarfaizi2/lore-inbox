Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSGYNfZ>; Thu, 25 Jul 2002 09:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSGYNeb>; Thu, 25 Jul 2002 09:34:31 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6141 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314138AbSGYNdl>; Thu, 25 Jul 2002 09:33:41 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251450.g6PEoqE5010507@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) Update tlan driver to new pci api
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:50:51 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/tlan.c linux-2.5.28-ac1/drivers/net/tlan.c
--- linux-2.5.28/drivers/net/tlan.c	Thu Jul 25 10:48:30 2002
+++ linux-2.5.28-ac1/drivers/net/tlan.c	Sun Jul 21 21:03:33 2002
@@ -166,20 +166,18 @@
  *	                       Thanks to Gunnar Eikman
  *******************************************************************************/
 
-#error Please convert me to Documentation/DMA-mapping.txt
-                                                                                
 #include <linux/module.h>
-
-#include "tlan.h"
-
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
+#include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#include <linux/tqueue.h>
 #include <linux/mii.h>
 
+#include "tlan.h"
 
 typedef u32 (TLanIntVectorFunc)( struct net_device *, u16 );
 
@@ -218,10 +216,11 @@
 
 static	int		bbuf;
 static	u8		*TLanPadBuffer;
+static  dma_addr_t	TLanPadBufferDMA;
 static	char		TLanSignature[] = "TLAN";
-static const char tlan_banner[] = "ThunderLAN driver v1.15\n";
-static int tlan_have_pci;
-static int tlan_have_eisa;
+static  const char tlan_banner[] = "ThunderLAN driver v1.15\n";
+static  int tlan_have_pci;
+static  int tlan_have_eisa;
 
 const char *media[] = {
 	"10BaseT-HD ", "10BaseT-FD ","100baseTx-HD ", 
@@ -422,7 +421,7 @@
 	unregister_netdev( dev );
 
 	if ( priv->dmaStorage ) {
-		kfree( priv->dmaStorage );
+		pci_free_consistent(priv->pciDev, priv->dmaSize, priv->dmaStorage, priv->dmaStorageDMA );
 	}
 
 	release_region( dev->base_addr, 0x10 );
@@ -445,8 +444,7 @@
 	
 	printk(KERN_INFO "%s", tlan_banner);
 	
-	TLanPadBuffer = (u8 *) kmalloc(TLAN_MIN_FRAME_SIZE, 
-					GFP_KERNEL);
+	TLanPadBuffer = (u8 *) pci_alloc_consistent(NULL, TLAN_MIN_FRAME_SIZE, &TLanPadBufferDMA);
 
 	if (TLanPadBuffer == NULL) {
 		printk(KERN_ERR "TLAN: Could not allocate memory for pad buffer.\n");
@@ -471,7 +469,7 @@
 
 	if (TLanDevicesInstalled == 0) {
 		pci_unregister_driver(&tlan_driver);
-		kfree(TLanPadBuffer);
+		pci_free_consistent(NULL, TLAN_MIN_FRAME_SIZE, TLanPadBuffer, TLanPadBufferDMA);
 		return -ENODEV;
 	}
 	return 0;
@@ -526,12 +524,22 @@
 	
 	priv = dev->priv;
 
+	priv->pciDev = pdev;
+	
 	/* Is this a PCI device? */
 	if (pdev) {
 		u32 		   pci_io_base = 0;
 
 		priv->adapter = &board_info[ent->driver_data];
 
+		if(pci_set_dma_mask(pdev, 0xFFFFFFFF))
+		{
+			printk(KERN_ERR "TLAN: No suitable PCI mapping available.\n");
+			unregister_netdev(dev);
+			kfree(dev);
+			return -ENODEV;
+		}
+
 		pci_read_config_byte ( pdev, PCI_REVISION_ID, &pci_rev);
 
 		for ( reg= 0; reg <= 5; reg ++ ) {
@@ -639,7 +647,7 @@
 		dev = TLan_Eisa_Devices;
 		priv = dev->priv;
 		if (priv->dmaStorage) {
-			kfree(priv->dmaStorage);
+			pci_free_consistent(priv->pciDev, priv->dmaSize, priv->dmaStorage, priv->dmaStorageDMA );
 		}
 		release_region( dev->base_addr, 0x10);
 		unregister_netdev( dev );
@@ -657,7 +665,7 @@
 	if (tlan_have_eisa)
 		TLan_Eisa_Cleanup();
 
-	kfree( TLanPadBuffer );
+	pci_free_consistent(NULL, TLAN_MIN_FRAME_SIZE, TLanPadBuffer, TLanPadBufferDMA);
 
 }
 
@@ -808,7 +816,9 @@
 		dma_size = ( TLAN_NUM_RX_LISTS + TLAN_NUM_TX_LISTS )
 	           * ( sizeof(TLanList) );
 	}
-	priv->dmaStorage = kmalloc(dma_size, GFP_KERNEL | GFP_DMA);
+	priv->dmaStorage = pci_alloc_consistent(priv->pciDev, dma_size, &priv->dmaStorageDMA);
+	priv->dmaSize = dma_size;
+	
 	if ( priv->dmaStorage == NULL ) {
 		printk(KERN_ERR "TLAN:  Could not allocate lists and buffers for %s.\n",
 			dev->name );
@@ -818,11 +828,14 @@
 	memset( priv->dmaStorage, 0, dma_size );
 	priv->rxList = (TLanList *) 
 		       ( ( ( (u32) priv->dmaStorage ) + 7 ) & 0xFFFFFFF8 );
+	priv->rxListDMA = ( ( ( (u32) priv->dmaStorageDMA ) + 7 ) & 0xFFFFFFF8 );
 	priv->txList = priv->rxList + TLAN_NUM_RX_LISTS;
+	priv->txListDMA = priv->rxListDMA + sizeof(TLanList) * TLAN_NUM_RX_LISTS;
 	if ( bbuf ) {
 		priv->rxBuffer = (u8 *) ( priv->txList + TLAN_NUM_TX_LISTS );
-		priv->txBuffer = priv->rxBuffer
-				 + ( TLAN_NUM_RX_LISTS * TLAN_MAX_FRAME_SIZE );
+		priv->rxBufferDMA =priv->txListDMA + sizeof(TLanList) * TLAN_NUM_TX_LISTS;
+		priv->txBuffer = priv->rxBuffer + ( TLAN_NUM_RX_LISTS * TLAN_MAX_FRAME_SIZE );
+		priv->txBufferDMA = priv->rxBufferDMA + ( TLAN_NUM_RX_LISTS * TLAN_MAX_FRAME_SIZE );
 	}
 
 	err = 0;
@@ -1000,6 +1013,7 @@
 {
 	TLanPrivateInfo *priv = dev->priv;
 	TLanList	*tail_list;
+	dma_addr_t	tail_list_phys;
 	u8		*tail_buffer;
 	int		pad;
 	unsigned long	flags;
@@ -1011,6 +1025,7 @@
 	}
 
 	tail_list = priv->txList + priv->txTail;
+	tail_list_phys = priv->txListDMA + sizeof(TLanList) * priv->txTail;
 	
 	if ( tail_list->cStat != TLAN_CSTAT_UNUSED ) {
 		TLAN_DBG( TLAN_DEBUG_TX, "TRANSMIT:  %s is busy (Head=%d Tail=%d)\n", dev->name, priv->txHead, priv->txTail );
@@ -1025,7 +1040,7 @@
 		tail_buffer = priv->txBuffer + ( priv->txTail * TLAN_MAX_FRAME_SIZE );
 		memcpy( tail_buffer, skb->data, skb->len );
 	} else {
-		tail_list->buffer[0].address = virt_to_bus( skb->data );
+		tail_list->buffer[0].address = pci_map_single(priv->pciDev, skb->data, skb->len, PCI_DMA_TODEVICE);
 		tail_list->buffer[9].address = (u32) skb;
 	}
 
@@ -1035,7 +1050,7 @@
 		tail_list->frameSize = (u16) skb->len + pad;
 		tail_list->buffer[0].count = (u32) skb->len;
 		tail_list->buffer[1].count = TLAN_LAST_BUFFER | (u32) pad;
-		tail_list->buffer[1].address = virt_to_bus( TLanPadBuffer );
+		tail_list->buffer[1].address = TLanPadBufferDMA;
 	} else {
 		tail_list->frameSize = (u16) skb->len;
 		tail_list->buffer[0].count = TLAN_LAST_BUFFER | (u32) skb->len;
@@ -1048,14 +1063,14 @@
 	if ( ! priv->txInProgress ) {
 		priv->txInProgress = 1;
 		TLAN_DBG( TLAN_DEBUG_TX, "TRANSMIT:  Starting TX on buffer %d\n", priv->txTail );
-		outl( virt_to_bus( tail_list ), dev->base_addr + TLAN_CH_PARM );
+		outl( tail_list_phys, dev->base_addr + TLAN_CH_PARM );
 		outl( TLAN_HC_GO, dev->base_addr + TLAN_HOST_CMD );
 	} else {
 		TLAN_DBG( TLAN_DEBUG_TX, "TRANSMIT:  Adding buffer %d to TX channel\n", priv->txTail );
 		if ( priv->txTail == 0 ) {
-			( priv->txList + ( TLAN_NUM_TX_LISTS - 1 ) )->forward = virt_to_bus( tail_list );
+			( priv->txList + ( TLAN_NUM_TX_LISTS - 1 ) )->forward = tail_list_phys;
 		} else {
-			( priv->txList + ( priv->txTail - 1 ) )->forward = virt_to_bus( tail_list );
+			( priv->txList + ( priv->txTail - 1 ) )->forward = tail_list_phys;
 		}
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -1341,6 +1356,7 @@
 	TLanPrivateInfo	*priv = dev->priv;
 	int		eoc = 0;
 	TLanList	*head_list;
+	dma_addr_t	head_list_phys;
 	u32		ack = 0;
 	u16		tmpCStat;
 	
@@ -1350,7 +1366,9 @@
 	while (((tmpCStat = head_list->cStat ) & TLAN_CSTAT_FRM_CMP) && (ack < 255)) {
 		ack++;
 		if ( ! bbuf ) {
-			dev_kfree_skb_any( (struct sk_buff *) head_list->buffer[9].address );
+			struct sk_buff *skb = (struct sk_buff *) head_list->buffer[9].address;
+			pci_unmap_single(priv->pciDev, head_list->buffer[0].address, skb->len, PCI_DMA_TODEVICE);
+			dev_kfree_skb_any(skb);
 			head_list->buffer[9].address = 0;
 		}
 	
@@ -1371,8 +1389,9 @@
 	if ( eoc ) {
 		TLAN_DBG( TLAN_DEBUG_TX, "TRANSMIT:  Handling TX EOC (Head=%d Tail=%d)\n", priv->txHead, priv->txTail );
 		head_list = priv->txList + priv->txHead;
+		head_list_phys = priv->txListDMA + sizeof(TLanList) * priv->txHead;
 		if ( ( head_list->cStat & TLAN_CSTAT_READY ) == TLAN_CSTAT_READY ) {
-			outl( virt_to_bus( head_list ), dev->base_addr + TLAN_CH_PARM );
+			outl(head_list_phys, dev->base_addr + TLAN_CH_PARM );
 			ack |= TLAN_HC_GO;
 		} else {
 			priv->txInProgress = 0;
@@ -1465,9 +1484,11 @@
 	void		*t;
 	u32		frameSize;
 	u16		tmpCStat;
+	dma_addr_t	head_list_phys;
 
 	TLAN_DBG( TLAN_DEBUG_RX, "RECEIVE:  Handling RX EOF (Head=%d Tail=%d)\n", priv->rxHead, priv->rxTail );
 	head_list = priv->rxList + priv->rxHead;
+	head_list_phys = priv->rxListDMA + sizeof(TLanList) * priv->rxHead;
 	
 	while (((tmpCStat = head_list->cStat) & TLAN_CSTAT_FRM_CMP) && (ack < 255)) {
 		frameSize = head_list->frameSize;
@@ -1495,17 +1516,16 @@
 			struct sk_buff *new_skb;
 		
 			/*
-		 	*	I changed the algorithm here. What we now do
-		 	*	is allocate the new frame. If this fails we
-		 	*	simply recycle the frame.
-		 	*/
+		 	 *	I changed the algorithm here. What we now do
+		 	 *	is allocate the new frame. If this fails we
+		 	 *	simply recycle the frame.
+		 	 */
 		
 			new_skb = dev_alloc_skb( TLAN_MAX_FRAME_SIZE + 7 );
 			
 			if ( new_skb != NULL ) {
-				/* If this ever happened it would be a problem */
-				/* not any more - ac */
 				skb = (struct sk_buff *) head_list->buffer[9].address;
+				pci_unmap_single(priv->pciDev, head_list->buffer[0].address, TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 				skb_trim( skb, frameSize );
 
 				priv->stats.rx_bytes += frameSize;
@@ -1516,8 +1536,11 @@
 				new_skb->dev = dev;
 				skb_reserve( new_skb, 2 );
 				t = (void *) skb_put( new_skb, TLAN_MAX_FRAME_SIZE );
-				head_list->buffer[0].address = virt_to_bus( t );
+				head_list->buffer[0].address = pci_map_single(priv->pciDev, new_skb->data, TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 				head_list->buffer[8].address = (u32) t;
+#ifdef __LP64__
+#error "Not 64bit clean"
+#endif				
 				head_list->buffer[9].address = (u32) new_skb;
 			} else 
 				printk(KERN_WARNING "TLAN:  Couldn't allocate memory for received data.\n" );
@@ -1526,11 +1549,12 @@
 		head_list->forward = 0;
 		head_list->cStat = 0;
 		tail_list = priv->rxList + priv->rxTail;
-		tail_list->forward = virt_to_bus( head_list );
+		tail_list->forward = head_list_phys;
 
 		CIRC_INC( priv->rxHead, TLAN_NUM_RX_LISTS );
 		CIRC_INC( priv->rxTail, TLAN_NUM_RX_LISTS );
 		head_list = priv->rxList + priv->rxHead;
+		head_list_phys = priv->rxListDMA + sizeof(TLanList) * priv->rxHead;
 	}
 
 	if (!ack)
@@ -1542,7 +1566,8 @@
 	if ( eoc ) { 
 		TLAN_DBG( TLAN_DEBUG_RX, "RECEIVE:  Handling RX EOC (Head=%d Tail=%d)\n", priv->rxHead, priv->rxTail );
 		head_list = priv->rxList + priv->rxHead;
-		outl( virt_to_bus( head_list ), dev->base_addr + TLAN_CH_PARM );
+		head_list_phys = priv->rxListDMA + sizeof(TLanList) * priv->rxHead;
+		outl(head_list_phys, dev->base_addr + TLAN_CH_PARM );
 		ack |= TLAN_HC_GO | TLAN_HC_RT;
 		priv->rxEocCount++;
 	}
@@ -1621,15 +1646,17 @@
 {
 	TLanPrivateInfo	*priv = dev->priv;
 	TLanList		*head_list;
+	dma_addr_t		head_list_phys;
 	u32			ack = 1;
 	
 	host_int = 0;
 	if ( priv->tlanRev < 0x30 ) {
 		TLAN_DBG( TLAN_DEBUG_TX, "TRANSMIT:  Handling TX EOC (Head=%d Tail=%d) -- IRQ\n", priv->txHead, priv->txTail );
 		head_list = priv->txList + priv->txHead;
+		head_list_phys = priv->txListDMA + sizeof(TLanList) * priv->txHead;
 		if ( ( head_list->cStat & TLAN_CSTAT_READY ) == TLAN_CSTAT_READY ) {
 			netif_stop_queue(dev);
-			outl( virt_to_bus( head_list ), dev->base_addr + TLAN_CH_PARM );
+			outl( head_list_phys, dev->base_addr + TLAN_CH_PARM );
 			ack |= TLAN_HC_GO;
 		} else {
 			priv->txInProgress = 0;
@@ -1742,13 +1769,13 @@
 u32 TLan_HandleRxEOC( struct net_device *dev, u16 host_int )
 {
 	TLanPrivateInfo	*priv = dev->priv;
-	TLanList	*head_list;
+	dma_addr_t	head_list_phys;
 	u32		ack = 1;
 
 	if (  priv->tlanRev < 0x30 ) {
 		TLAN_DBG( TLAN_DEBUG_RX, "RECEIVE:  Handling RX EOC (Head=%d Tail=%d) -- IRQ\n", priv->rxHead, priv->rxTail );
-		head_list = priv->rxList + priv->rxHead;
-		outl( virt_to_bus( head_list ), dev->base_addr + TLAN_CH_PARM );
+		head_list_phys = priv->rxListDMA + sizeof(TLanList) * priv->rxHead;
+		outl( head_list_phys, dev->base_addr + TLAN_CH_PARM );
 		ack |= TLAN_HC_GO | TLAN_HC_RT;
 		priv->rxEocCount++;
 	}
@@ -1885,6 +1912,7 @@
 	TLanPrivateInfo *priv = dev->priv;
 	int		i;
 	TLanList	*list;
+	dma_addr_t	list_phys;
 	struct sk_buff	*skb;
 	void		*t = NULL;
 
@@ -1894,7 +1922,7 @@
 		list = priv->txList + i;
 		list->cStat = TLAN_CSTAT_UNUSED;
 		if ( bbuf ) {
-			list->buffer[0].address = virt_to_bus( priv->txBuffer + ( i * TLAN_MAX_FRAME_SIZE ) );
+			list->buffer[0].address = priv->txBufferDMA + ( i * TLAN_MAX_FRAME_SIZE );
 		} else {
 			list->buffer[0].address = 0;
 		}
@@ -1907,11 +1935,12 @@
 	priv->rxTail = TLAN_NUM_RX_LISTS - 1;
 	for ( i = 0; i < TLAN_NUM_RX_LISTS; i++ ) {
 		list = priv->rxList + i;
+		list_phys = priv->rxListDMA + sizeof(TLanList) * i;
 		list->cStat = TLAN_CSTAT_READY;
 		list->frameSize = TLAN_MAX_FRAME_SIZE;
 		list->buffer[0].count = TLAN_MAX_FRAME_SIZE | TLAN_LAST_BUFFER;
 		if ( bbuf ) {
-			list->buffer[0].address = virt_to_bus( priv->rxBuffer + ( i * TLAN_MAX_FRAME_SIZE ) );
+			list->buffer[0].address = priv->rxBufferDMA + ( i * TLAN_MAX_FRAME_SIZE );
 		} else {
 			skb = dev_alloc_skb( TLAN_MAX_FRAME_SIZE + 7 );
 			if ( skb == NULL ) {
@@ -1922,14 +1951,14 @@
 				skb_reserve( skb, 2 );
 				t = (void *) skb_put( skb, TLAN_MAX_FRAME_SIZE );
 			}
-			list->buffer[0].address = virt_to_bus( t );
+			list->buffer[0].address = pci_map_single(priv->pciDev, t, TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 			list->buffer[8].address = (u32) t;
 			list->buffer[9].address = (u32) skb;
 		}
 		list->buffer[1].count = 0;
 		list->buffer[1].address = 0;
 		if ( i < TLAN_NUM_RX_LISTS - 1 )
-			list->forward = virt_to_bus( list + 1 );
+			list->forward = list_phys + sizeof(TLanList);
 		else
 			list->forward = 0;
 	}
@@ -1949,6 +1978,7 @@
 			list = priv->txList + i;
 			skb = (struct sk_buff *) list->buffer[9].address;
 			if ( skb ) {
+				pci_unmap_single(priv->pciDev, list->buffer[0].address, skb->len, PCI_DMA_TODEVICE);
 				dev_kfree_skb_any( skb );
 				list->buffer[9].address = 0;
 			}
@@ -1958,12 +1988,12 @@
 			list = priv->rxList + i;
 			skb = (struct sk_buff *) list->buffer[9].address;
 			if ( skb ) {
+				pci_unmap_single(priv->pciDev, list->buffer[0].address, TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 				dev_kfree_skb_any( skb );
 				list->buffer[9].address = 0;
 			}
 		}
 	}
-
 } /* TLan_FreeLists */
 
 
@@ -2301,7 +2331,7 @@
 		if ( debug >= 1 && debug != TLAN_DEBUG_PROBE ) {
 			outb( ( TLAN_HC_REQ_INT >> 8 ), dev->base_addr + TLAN_HOST_CMD + 1 );
 		}
-		outl( virt_to_bus( priv->rxList ), dev->base_addr + TLAN_CH_PARM );
+		outl( priv->rxListDMA, dev->base_addr + TLAN_CH_PARM );
 		outl( TLAN_HC_GO | TLAN_HC_RT, dev->base_addr + TLAN_HOST_CMD );
 	} else {
 		printk( "TLAN: %s: Link inactive, will retry in 10 secs...\n", dev->name );
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/net/tlan.h linux-2.5.28-ac1/drivers/net/tlan.h
--- linux-2.5.28/drivers/net/tlan.h	Thu Jul 25 10:48:31 2002
+++ linux-2.5.28-ac1/drivers/net/tlan.h	Sun Jul 21 16:34:19 2002
@@ -169,15 +169,22 @@
 
 typedef struct tlan_private_tag {
 	struct net_device       *nextDevice;
+	struct pci_dev		*pciDev;
 	void			*dmaStorage;
+	dma_addr_t		dmaStorageDMA;
+	unsigned int		dmaSize;
 	u8			*padBuffer;
 	TLanList                *rxList;
+	dma_addr_t		rxListDMA;
 	u8			*rxBuffer;
+	dma_addr_t		rxBufferDMA;
 	u32                     rxHead;
 	u32                     rxTail;
 	u32			rxEocCount;
 	TLanList                *txList;
+	dma_addr_t		txListDMA;
 	u8			*txBuffer;
+	dma_addr_t		txBufferDMA;
 	u32                     txHead;
 	u32                     txInProgress;
 	u32                     txTail;
