Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSF3P3R>; Sun, 30 Jun 2002 11:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSF3PSE>; Sun, 30 Jun 2002 11:18:04 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:9153 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315277AbSF3PRh>;
	Sun, 30 Jun 2002 11:17:37 -0400
Date: Sun, 30 Jun 2002 17:20:00 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 9/10
Message-ID: <20020630172000.K19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- (cosmetic) gotoize error paths in TLan_Init.

--- linux-2.5.24/drivers/net/tlan.c	Sun Jun 30 14:54:32 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sun Jun 30 15:10:34 2002
@@ -805,11 +805,10 @@ static int TLan_Init( struct net_device 
 
 	if (!priv->is_eisa)	/* EISA devices have already requested IO */
 		if (!request_region( dev->base_addr, 0x10, TLanSignature )) {
-			printk(KERN_ERR "TLAN: %s: IO port region 0x%lx size 0x%x in use.\n",
-				dev->name,
-				dev->base_addr,
-				0x10 );
-			return -EIO;
+			printk(KERN_ERR "%s: IO port region 0x%lx size 0x%x in use\n",
+				dev->name, dev->base_addr, 0x10);
+			err = -EIO;
+			goto err_out;
 		}
 
 	dma_size = TLAN_TOTAL_SIZE;
@@ -817,8 +816,8 @@ static int TLan_Init( struct net_device 
 	if (!addr) {
 		printk(KERN_ERR "TLAN:  Could not allocate lists and buffers for %s.\n",
 			dev->name );
-		release_region( dev->base_addr, 0x10 );
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_out_release_region;
 	}
 	/*
 	 * pci_alloc_consistent and an adequate power of 2 for TLAN_NUM_RX_LISTS
@@ -833,10 +832,8 @@ static int TLan_Init( struct net_device 
 		if ( addr == NULL ) {
 			printk(KERN_ERR "%s: buffers allocation failed\n",
 				dev->name );
-			pci_free_consistent(pdev, TLAN_TOTAL_SIZE, priv->rxList,
-				priv->lists_dma);
-			release_region( dev->base_addr, 0x10 );
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto err_out_free_consistent;
 		}
 		memset(addr, 0, dma_size );
 		priv->rxBuffer = (u8 *)addr;
@@ -874,6 +871,14 @@ static int TLan_Init( struct net_device 
 
 	return 0;
 
+err_out_free_consistent:
+	pci_free_consistent(pdev, TLAN_TOTAL_SIZE, priv->rxList,
+		priv->lists_dma);
+err_out_release_region:
+	release_region( dev->base_addr, 0x10 );
+err_out:
+	return err;
+
 } /* TLan_Init */
 
 
