Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSF3PXP>; Sun, 30 Jun 2002 11:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSF3PSr>; Sun, 30 Jun 2002 11:18:47 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:1985 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315259AbSF3PQm>;
	Sun, 30 Jun 2002 11:16:42 -0400
Date: Sun, 30 Jun 2002 17:19:02 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.24 - drivers/net/tlan.c dma mapping 2/10
Message-ID: <20020630171902.D19347@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr> <3D17743E.8060905@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D17743E.8060905@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Jun 24, 2002 at 03:34:22PM -0400
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- TLAN pad buffer virt_to_bus -> pci_map_single conversion.

--- linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 22:06:32 2002
+++ linux-2.5.24/drivers/net/tlan.c	Sat Jun 29 22:12:10 2002
@@ -215,6 +215,7 @@ MODULE_PARM_DESC(bbuf, "ThunderLAN use b
 static  int		debug;
 
 static	int		bbuf;
+static	dma_addr_t	TLanPadBuffer_dma;
 static	u8		*TLanPadBuffer;
 static	char		TLanSignature[] = "TLAN";
 static const char tlan_banner[] = "ThunderLAN driver v1.15\n";
@@ -441,6 +442,9 @@ static int __init tlan_probe(void)
 		printk(KERN_ERR "TLAN: Could not allocate memory for pad buffer.\n");
 		return -ENOMEM;
 	}
+	TLanPadBuffer_dma = pci_map_single(NULL, TLanPadBuffer,
+		TLAN_MIN_FRAME_SIZE, PCI_DMA_TODEVICE);
+
 
 	memset(TLanPadBuffer, 0, TLAN_MIN_FRAME_SIZE);
 	pad_allocated = 1;
@@ -647,6 +651,8 @@ static void __exit tlan_exit(void)
 
 	if (tlan_have_eisa)
 		TLan_Eisa_Cleanup();
+	pci_unmap_single(NULL, TLanPadBuffer_dma, TLAN_MIN_FRAME_SIZE,
+		PCI_DMA_TODEVICE);
 
 	kfree( TLanPadBuffer );
 
@@ -1026,7 +1032,7 @@ static int TLan_StartTx( struct sk_buff 
 		tail_list->frameSize = (u16) skb->len + pad;
 		tail_list->buffer[0].count = (u32) skb->len;
 		tail_list->buffer[1].count = TLAN_LAST_BUFFER | (u32) pad;
-		tail_list->buffer[1].address = virt_to_bus( TLanPadBuffer );
+		tail_list->buffer[1].address = TLanPadBuffer_dma;
 	} else {
 		tail_list->frameSize = (u16) skb->len;
 		tail_list->buffer[0].count = TLAN_LAST_BUFFER | (u32) skb->len;
