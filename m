Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSF3PSp>; Sun, 30 Jun 2002 11:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSF3PSV>; Sun, 30 Jun 2002 11:18:21 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:4033 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315265AbSF3PRE>;
	Sun, 30 Jun 2002 11:17:04 -0400
Date: Sun, 30 Jun 2002 17:19:20 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 4/10
Message-ID: <20020630171920.F19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- skbuff virt_to_bus -> pci_map_single conversion in Rx/Tx paths.

--- linux-2.5.24/drivers/net/tlan.h	Sat Jun 29 22:01:16 2002
+++ linux-2.5.24/drivers/net/tlan.h	Sat Jun 29 22:50:17 2002
@@ -168,6 +168,7 @@ typedef u8 TLanBuffer[TLAN_MAX_FRAME_SIZ
 	 ****************************************************************/
 
 typedef struct tlan_private_tag {
+	struct pci_dev  	*pci_dev;
 	struct net_device       *nextDevice;
 	void			*dmaStorage;
 	u8			*padBuffer;
--- linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 22:28:42 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 23:08:37 2002
@@ -515,6 +515,7 @@ static int __devinit TLan_probe1(struct 
 	SET_MODULE_OWNER(dev);
 	
 	priv = dev->priv;
+	priv->pci_dev = pdev;
 
 	/* Is this a PCI device? */
 	if (pdev) {
@@ -995,6 +996,7 @@ static void TLan_tx_timeout(struct net_d
 static int TLan_StartTx( struct sk_buff *skb, struct net_device *dev )
 {
 	TLanPrivateInfo *priv = dev->priv;
+	struct pci_dev	*pdev = priv->pci_dev;
 	TLanList	*tail_list;
 	u8		*tail_buffer;
 	int		pad;
@@ -1021,7 +1023,8 @@ static int TLan_StartTx( struct sk_buff 
 		tail_buffer = priv->txBuffer + ( priv->txTail * TLAN_MAX_FRAME_SIZE );
 		memcpy( tail_buffer, skb->data, skb->len );
 	} else {
-		tail_list->buffer[0].address = virt_to_bus( skb->data );
+		tail_list->buffer[0].address =  pci_map_single(pdev, skb->data,
+			skb->len, PCI_DMA_TODEVICE);
 		tail_list->buffer[9].address = (u32) skb;
 	}
 
@@ -1335,6 +1338,7 @@ u32 TLan_HandleInvalid( struct net_devic
 u32 TLan_HandleTxEOF( struct net_device *dev, u16 host_int )
 {
 	TLanPrivateInfo	*priv = dev->priv;
+	struct pci_dev	*pdev = priv->pci_dev;
 	int		eoc = 0;
 	TLanList	*head_list;
 	u32		ack = 0;
@@ -1346,7 +1350,11 @@ u32 TLan_HandleTxEOF( struct net_device 
 	while (((tmpCStat = head_list->cStat ) & TLAN_CSTAT_FRM_CMP) && (ack < 255)) {
 		ack++;
 		if ( ! bbuf ) {
-			dev_kfree_skb_any( (struct sk_buff *) head_list->buffer[9].address );
+			struct sk_buff *skb = (struct sk_buff *)head_list->buffer[9].address;
+
+			pci_unmap_single(pdev, head_list->buffer[0].address,
+				skb->len, PCI_DMA_TODEVICE);
+			dev_kfree_skb_any(skb);
 			head_list->buffer[9].address = 0;
 		}
 	
@@ -1452,6 +1460,7 @@ u32 TLan_HandleStatOverflow( struct net_
 u32 TLan_HandleRxEOF( struct net_device *dev, u16 host_int )
 {
 	TLanPrivateInfo	*priv = dev->priv;
+	struct pci_dev	*pdev = priv->pci_dev;
 	u32		ack = 0;
 	int		eoc = 0;
 	u8		*head_buffer;
@@ -1499,9 +1508,13 @@ u32 TLan_HandleRxEOF( struct net_device 
 			new_skb = dev_alloc_skb( TLAN_MAX_FRAME_SIZE + 7 );
 			
 			if ( new_skb != NULL ) {
+				TLanBufferRef *head_buf = head_list->buffer;
+
 				/* If this ever happened it would be a problem */
 				/* not any more - ac */
-				skb = (struct sk_buff *) head_list->buffer[9].address;
+				pci_unmap_single(pdev, head_list->buffer[0].address,
+					TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
+				skb = (struct sk_buff *) head_buf[9].address;
 				skb_trim( skb, frameSize );
 
 				priv->stats.rx_bytes += frameSize;
@@ -1512,9 +1525,10 @@ u32 TLan_HandleRxEOF( struct net_device 
 				new_skb->dev = dev;
 				skb_reserve( new_skb, 2 );
 				t = (void *) skb_put( new_skb, TLAN_MAX_FRAME_SIZE );
-				head_list->buffer[0].address = virt_to_bus( t );
-				head_list->buffer[8].address = (u32) t;
-				head_list->buffer[9].address = (u32) new_skb;
+				head_buf[0].address = pci_map_single(pdev, t,
+					TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
+				head_buf[8].address = (u32) t;
+				head_buf[9].address = (u32) new_skb;
 			} else 
 				printk(KERN_WARNING "TLAN:  Couldn't allocate memory for received data.\n" );
 		}
@@ -1879,6 +1893,7 @@ void TLan_Timer( unsigned long data )
 void TLan_ResetLists( struct net_device *dev )
 {
 	TLanPrivateInfo *priv = dev->priv;
+	struct pci_dev	*pdev = priv->pci_dev;
 	int		i;
 	TLanList	*list;
 	struct sk_buff	*skb;
@@ -1918,7 +1933,8 @@ void TLan_ResetLists( struct net_device 
 				skb_reserve( skb, 2 );
 				t = (void *) skb_put( skb, TLAN_MAX_FRAME_SIZE );
 			}
-			list->buffer[0].address = virt_to_bus( t );
+			list->buffer[0].address = pci_map_single(pdev, t,
+				TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 			list->buffer[8].address = (u32) t;
 			list->buffer[9].address = (u32) skb;
 		}
@@ -1936,6 +1952,7 @@ void TLan_ResetLists( struct net_device 
 void TLan_FreeLists( struct net_device *dev )
 {
 	TLanPrivateInfo *priv = dev->priv;
+	struct pci_dev	*pdev = priv->pci_dev;
 	int		i;
 	TLanList	*list;
 	struct sk_buff	*skb;
@@ -1945,6 +1962,8 @@ void TLan_FreeLists( struct net_device *
 			list = priv->txList + i;
 			skb = (struct sk_buff *) list->buffer[9].address;
 			if ( skb ) {
+				pci_unmap_single(pdev, list->buffer[0].address,
+					skb->len, PCI_DMA_TODEVICE);
 				dev_kfree_skb_any( skb );
 				list->buffer[9].address = 0;
 			}
@@ -1954,6 +1973,8 @@ void TLan_FreeLists( struct net_device *
 			list = priv->rxList + i;
 			skb = (struct sk_buff *) list->buffer[9].address;
 			if ( skb ) {
+				pci_unmap_single(pdev, list->buffer[0].address,
+					TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
 				dev_kfree_skb_any( skb );
 				list->buffer[9].address = 0;
 			}
