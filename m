Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSF3PQd>; Sun, 30 Jun 2002 11:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSF3PQd>; Sun, 30 Jun 2002 11:16:33 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:449 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315257AbSF3PQa>;
	Sun, 30 Jun 2002 11:16:30 -0400
Date: Sun, 30 Jun 2002 17:18:52 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 1/10
Message-ID: <20020630171852.C19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- removal of code duplication.

--- linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 21:59:16 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 22:01:37 2002
@@ -295,6 +295,7 @@ static int	TLan_ioctl( struct net_device
 static int      TLan_probe1( struct pci_dev *pdev, long ioaddr, int irq, int rev, const struct pci_device_id *ent);
 static void	TLan_tx_timeout( struct net_device *dev);
 static int 	tlan_init_one( struct pci_dev *pdev, const struct pci_device_id *ent);
+static void	TLan_Release_Dev(struct net_device *);
 
 static u32	TLan_HandleInvalid( struct net_device *, u16 );
 static u32	TLan_HandleTxEOF( struct net_device *, u16 );
@@ -415,18 +416,8 @@ TLan_SetTimer( struct net_device *dev, u
 static void __devexit tlan_remove_one( struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata( pdev );
-	TLanPrivateInfo	*priv = dev->priv;
-	
-	unregister_netdev( dev );
-
-	if ( priv->dmaStorage ) {
-		kfree( priv->dmaStorage );
-	}
-
-	release_region( dev->base_addr, 0x10 );
-	
-	kfree( dev );
 		
+	TLan_Release_Dev(dev);	
 	pci_set_drvdata( pdev, NULL );
 } 
 
@@ -627,23 +618,25 @@ static int __devinit TLan_probe1(struct 
 
 }
 
+static void TLan_Release_Dev(struct net_device *dev)
+{
+	TLanPrivateInfo *priv = dev->priv;
+
+	if (priv->dmaStorage)
+		kfree(priv->dmaStorage);
+	release_region(dev->base_addr, 0x10);
+	unregister_netdev(dev);
+}
 
 static void TLan_Eisa_Cleanup(void)
 {
-	struct net_device *dev;
-	TLanPrivateInfo *priv;
+	for (; tlan_have_eisa; tlan_have_eisa--) {
+		struct net_device *dev = TLan_Eisa_Devices;
+		TLanPrivateInfo *priv = dev->priv;
 	
-	while( tlan_have_eisa ) {
-		dev = TLan_Eisa_Devices;
-		priv = dev->priv;
-		if (priv->dmaStorage) {
-			kfree(priv->dmaStorage);
-		}
-		release_region( dev->base_addr, 0x10);
-		unregister_netdev( dev );
+		TLan_Release_Dev(dev);
 		TLan_Eisa_Devices = priv->nextDevice;
 		kfree( dev );
-		tlan_have_eisa--;
 	}
 }
 	
