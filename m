Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSF3PSs>; Sun, 30 Jun 2002 11:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSF3PSH>; Sun, 30 Jun 2002 11:18:07 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:7361 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315275AbSF3PR3>;
	Sun, 30 Jun 2002 11:17:29 -0400
Date: Sun, 30 Jun 2002 17:19:48 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 7/10
Message-ID: <20020630171948.I19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- private dma storage doesn't need room for Rx/Tx buffers anymore.

--- linux-2.5.24/drivers/net/tlan.h	Sat Jun 29 23:51:42 2002
+++ linux-2.5.24/drivers/net/tlan.h	Sat Jun 29 23:56:02 2002
@@ -42,6 +42,7 @@
 #define TLAN_NUM_RX_LISTS	32
 #define TLAN_NUM_TX_LISTS	64
 #define TLAN_NUM_ALL_LISTS	(TLAN_NUM_RX_LISTS+TLAN_NUM_TX_LISTS)
+#define TLAN_TOTAL_SIZE		TLAN_NUM_ALL_LISTS*sizeof(TLanList)
 
 #define TLAN_IGNORE		0
 #define TLAN_RECORD		1
--- linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 23:51:38 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sun Jun 30 00:00:07 2002
@@ -813,13 +813,7 @@ static int TLan_Init( struct net_device 
 			return -EIO;
 		}
 	
-	if ( bbuf ) {
-		dma_size = ( TLAN_NUM_RX_LISTS + TLAN_NUM_TX_LISTS )
-	           * ( sizeof(TLanList) + TLAN_MAX_FRAME_SIZE );
-	} else {
-		dma_size = ( TLAN_NUM_RX_LISTS + TLAN_NUM_TX_LISTS )
-	           * ( sizeof(TLanList) );
-	}
+	dma_size = TLAN_TOTAL_SIZE;	
 	priv->dmaStorage = kmalloc(dma_size, GFP_KERNEL | GFP_DMA);
 	if ( priv->dmaStorage == NULL ) {
 		printk(KERN_ERR "TLAN:  Could not allocate lists and buffers for %s.\n",
