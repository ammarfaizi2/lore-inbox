Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSF3PSq>; Sun, 30 Jun 2002 11:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSF3PS0>; Sun, 30 Jun 2002 11:18:26 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:5057 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315266AbSF3PRI>;
	Sun, 30 Jun 2002 11:17:08 -0400
Date: Sun, 30 Jun 2002 17:19:31 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 5/10
Message-ID: <20020630171931.G19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- more code duplication removal.

--- linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 23:09:16 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 23:18:19 2002
@@ -296,6 +296,8 @@ static int	TLan_ioctl( struct net_device
 static int      TLan_probe1( struct pci_dev *pdev, long ioaddr, int irq, int rev, const struct pci_device_id *ent);
 static void	TLan_tx_timeout( struct net_device *dev);
 static int 	tlan_init_one( struct pci_dev *pdev, const struct pci_device_id *ent);
+static void	TLan_ResetTxBuffer(struct pci_dev *, TLanList *);
+static void	TLan_ResetRxBuffer(struct pci_dev *, TLanList *);
 static void	TLan_Release_Dev(struct net_device *);
 
 static u32	TLan_HandleInvalid( struct net_device *, u16 );
@@ -1349,14 +1351,8 @@ u32 TLan_HandleTxEOF( struct net_device 
 
 	while (((tmpCStat = head_list->cStat ) & TLAN_CSTAT_FRM_CMP) && (ack < 255)) {
 		ack++;
-		if ( ! bbuf ) {
-			struct sk_buff *skb = (struct sk_buff *)head_list->buffer[9].address;
-
-			pci_unmap_single(pdev, head_list->buffer[0].address,
-				skb->len, PCI_DMA_TODEVICE);
-			dev_kfree_skb_any(skb);
-			head_list->buffer[9].address = 0;
-		}
+		if ( ! bbuf )
+			TLan_ResetTxBuffer(pdev, head_list);
 	
 		if ( tmpCStat & TLAN_CSTAT_EOC )
 			eoc = 1;
@@ -1948,37 +1944,42 @@ void TLan_ResetLists( struct net_device 
 
 } /* TLan_ResetLists */
 
-
-void TLan_FreeLists( struct net_device *dev )
+static void TLan_ResetTxBuffer(struct pci_dev *pdev, TLanList *list)
 {
-	TLanPrivateInfo *priv = dev->priv;
-	struct pci_dev	*pdev = priv->pci_dev;
-	int		i;
-	TLanList	*list;
-	struct sk_buff	*skb;
+	struct sk_buff	*skb = (struct sk_buff *) list->buffer[9].address;
 
-	if ( ! bbuf ) {
-		for ( i = 0; i < TLAN_NUM_TX_LISTS; i++ ) {
-			list = priv->txList + i;
-			skb = (struct sk_buff *) list->buffer[9].address;
-			if ( skb ) {
-				pci_unmap_single(pdev, list->buffer[0].address,
-					skb->len, PCI_DMA_TODEVICE);
-				dev_kfree_skb_any( skb );
+	if (skb) {
+		pci_unmap_single(pdev, list->buffer[0].address, skb->len,
+			PCI_DMA_TODEVICE);
+		dev_kfree_skb_any(skb);
 				list->buffer[9].address = 0;
 			}
-		}
+}
+
+static void TLan_ResetRxBuffer(struct pci_dev *pdev, TLanList *list)
+{
+	struct sk_buff *skb = (struct sk_buff *) list->buffer[9].address;
 
-		for ( i = 0; i < TLAN_NUM_RX_LISTS; i++ ) {
-			list = priv->rxList + i;
 			skb = (struct sk_buff *) list->buffer[9].address;
-			if ( skb ) {
+	if (skb) {
 				pci_unmap_single(pdev, list->buffer[0].address,
 					TLAN_MAX_FRAME_SIZE, PCI_DMA_FROMDEVICE);
-				dev_kfree_skb_any( skb );
+		dev_kfree_skb_any(skb);
 				list->buffer[9].address = 0;
 			}
-		}
+}
+
+void TLan_FreeLists( struct net_device *dev )
+{
+	TLanPrivateInfo *priv = dev->priv;
+	struct pci_dev	*pdev = priv->pci_dev;
+	int		i;
+
+	if ( ! bbuf ) {
+		for (i = 0; i < TLAN_NUM_TX_LISTS; i++)
+			TLan_ResetTxBuffer(pdev, priv->txList + i);
+		for (i = 0; i < TLAN_NUM_RX_LISTS; i++)
+			TLan_ResetRxBuffer(pdev, priv->rxList + i);
 	}
 
 } /* TLan_FreeLists */
