Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSF3PSo>; Sun, 30 Jun 2002 11:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSF3PSj>; Sun, 30 Jun 2002 11:18:39 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:6337 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315267AbSF3PR0>;
	Sun, 30 Jun 2002 11:17:26 -0400
Date: Sun, 30 Jun 2002 17:19:38 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 6/10
Message-ID: <20020630171938.H19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- TLAN Rx/Tx buffers virt_to_bus -> pci_map_single conversion.

--- linux-2.5.24/drivers/net/tlan.h	Sat Jun 29 23:09:21 2002
+++ linux-2.5.24/drivers/net/tlan.h	Sat Jun 29 23:42:28 2002
@@ -41,6 +41,7 @@
 
 #define TLAN_NUM_RX_LISTS	32
 #define TLAN_NUM_TX_LISTS	64
+#define TLAN_NUM_ALL_LISTS	(TLAN_NUM_RX_LISTS+TLAN_NUM_TX_LISTS)
 
 #define TLAN_IGNORE		0
 #define TLAN_RECORD		1
@@ -169,6 +170,8 @@ typedef u8 TLanBuffer[TLAN_MAX_FRAME_SIZ
 
 typedef struct tlan_private_tag {
 	struct pci_dev  	*pci_dev;
+	dma_addr_t		rxBuffer_dma;
+	dma_addr_t		txBuffer_dma;
 	struct net_device       *nextDevice;
 	void			*dmaStorage;
 	u8			*padBuffer;
--- linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 23:19:12 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 23:49:46 2002
@@ -298,6 +298,7 @@ static void	TLan_tx_timeout( struct net_
 static int 	tlan_init_one( struct pci_dev *pdev, const struct pci_device_id *ent);
 static void	TLan_ResetTxBuffer(struct pci_dev *, TLanList *);
 static void	TLan_ResetRxBuffer(struct pci_dev *, TLanList *);
+static void	TLan_ReleaseBuffers(struct pci_dev *, TLanPrivateInfo *);
 static void	TLan_Release_Dev(struct net_device *);
 
 static u32	TLan_HandleInvalid( struct net_device *, u16 );
@@ -624,12 +625,24 @@ err_out:
 	return ret;
 }
 
+static void TLan_ReleaseBuffers(struct pci_dev *pdev, TLanPrivateInfo *priv)
+{
+	pci_unmap_single(pdev, priv->rxBuffer_dma,
+		TLAN_NUM_RX_LISTS*TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
+	pci_unmap_single(pdev, priv->txBuffer_dma,
+		TLAN_NUM_TX_LISTS*TLAN_MAX_FRAME_SIZE, PCI_DMA_TODEVICE);
+	kfree(priv->rxBuffer);
+}
+
 static void TLan_Release_Dev(struct net_device *dev)
 {
 	TLanPrivateInfo *priv = dev->priv;
+	struct pci_dev	*pdev = priv->pci_dev;
 
 	if (priv->dmaStorage)
 		kfree(priv->dmaStorage);
+	if ( bbuf )
+		TLan_ReleaseBuffers(pdev, priv);
 	release_region(dev->base_addr, 0x10);
 	unregister_netdev(dev);
 }
@@ -784,12 +797,12 @@ static void  __init TLan_EisaProbe (void
 
 static int TLan_Init( struct net_device *dev )
 {
+	TLanPrivateInfo	*priv = dev->priv;
+	struct pci_dev	*pdev = priv->pci_dev;
+	void		*addr;
 	int		dma_size;
 	int 		err;
 	int		i;
-	TLanPrivateInfo	*priv;
-
-	priv = dev->priv;
 	
 	if (!priv->is_eisa)	/* EISA devices have already requested IO */
 		if (!request_region( dev->base_addr, 0x10, TLanSignature )) {
@@ -819,9 +832,24 @@ static int TLan_Init( struct net_device 
 		       ( ( ( (u32) priv->dmaStorage ) + 7 ) & 0xFFFFFFF8 );
 	priv->txList = priv->rxList + TLAN_NUM_RX_LISTS;
 	if ( bbuf ) {
-		priv->rxBuffer = (u8 *) ( priv->txList + TLAN_NUM_TX_LISTS );
-		priv->txBuffer = priv->rxBuffer
-				 + ( TLAN_NUM_RX_LISTS * TLAN_MAX_FRAME_SIZE );
+		dma_size = TLAN_NUM_ALL_LISTS * TLAN_MAX_FRAME_SIZE;
+		addr = kmalloc(dma_size, GFP_KERNEL | GFP_DMA);
+		if ( addr == NULL ) {
+			printk(KERN_ERR "%s: buffers allocation failed\n",
+				dev->name );
+			release_region( dev->base_addr, 0x10 );
+			return -ENOMEM;
+		}
+		memset(addr, 0, dma_size );
+		priv->rxBuffer = (u8 *)addr;
+		priv->rxBuffer_dma = pci_map_single(pdev, addr,
+			TLAN_NUM_RX_LISTS*TLAN_MAX_FRAME_SIZE,
+			PCI_DMA_FROMDEVICE);
+		priv->txBuffer = priv->rxBuffer +
+			TLAN_NUM_RX_LISTS*TLAN_MAX_FRAME_SIZE;
+		priv->txBuffer_dma = pci_map_single(pdev, priv->txBuffer,
+			TLAN_NUM_TX_LISTS*TLAN_MAX_FRAME_SIZE,
+			PCI_DMA_TODEVICE);
 	}
 
 	err = 0;
@@ -1024,6 +1052,9 @@ static int TLan_StartTx( struct sk_buff 
 	if ( bbuf ) {
 		tail_buffer = priv->txBuffer + ( priv->txTail * TLAN_MAX_FRAME_SIZE );
 		memcpy( tail_buffer, skb->data, skb->len );
+		pci_dma_sync_single(pdev, priv->txBuffer_dma +
+			priv->txTail*TLAN_MAX_FRAME_SIZE,
+			skb->len, PCI_DMA_TODEVICE);
 	} else {
 		tail_list->buffer[0].address =  pci_map_single(pdev, skb->data,
 			skb->len, PCI_DMA_TODEVICE);
@@ -1488,6 +1519,9 @@ u32 TLan_HandleRxEOF( struct net_device 
 		
 				priv->stats.rx_bytes += head_list->frameSize;
 
+				pci_dma_sync_single(pdev, priv->rxBuffer_dma +
+					priv->rxHead*TLAN_MAX_FRAME_SIZE,
+					frameSize, PCI_DMA_FROMDEVICE);
 				memcpy( t, head_buffer, frameSize );
 				skb->protocol = eth_type_trans( skb, dev );
 				netif_rx( skb );
@@ -1901,7 +1935,7 @@ void TLan_ResetLists( struct net_device 
 		list = priv->txList + i;
 		list->cStat = TLAN_CSTAT_UNUSED;
 		if ( bbuf ) {
-			list->buffer[0].address = virt_to_bus( priv->txBuffer + ( i * TLAN_MAX_FRAME_SIZE ) );
+			list->buffer[0].address = priv->rxBuffer_dma + (i * TLAN_MAX_FRAME_SIZE);
 		} else {
 			list->buffer[0].address = 0;
 		}
@@ -1918,7 +1952,7 @@ void TLan_ResetLists( struct net_device 
 		list->frameSize = TLAN_MAX_FRAME_SIZE;
 		list->buffer[0].count = TLAN_MAX_FRAME_SIZE | TLAN_LAST_BUFFER;
 		if ( bbuf ) {
-			list->buffer[0].address = virt_to_bus( priv->rxBuffer + ( i * TLAN_MAX_FRAME_SIZE ) );
+			list->buffer[0].address = priv->rxBuffer_dma + (i * TLAN_MAX_FRAME_SIZE);
 		} else {
 			skb = dev_alloc_skb( TLAN_MAX_FRAME_SIZE + 7 );
 			if ( skb == NULL ) {
