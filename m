Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTEODYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTEODXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:23:04 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:20460 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263805AbTEODSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:24 -0400
Date: Thu, 15 May 2003 04:31:08 +0100
Message-Id: <200305150331.h4F3V8eJ000641@deviant.impure.org.uk>
To: jgarzik@pobox.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: hamachi PCI DMA fix from 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maintainer fix that went into 2.4 last August with the comments
"Get hamachi net driver RX working again.
 Apparently the PCI DMA conversion still has a bug or two left in it..."

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/hamachi.c linux-2.5/drivers/net/hamachi.c
--- bk-linus/drivers/net/hamachi.c	2003-04-22 00:40:42.000000000 +0100
+++ linux-2.5/drivers/net/hamachi.c	2003-04-22 01:23:14.000000000 +0100
@@ -207,8 +207,10 @@ KERN_INFO "   Further modifications by K
 /* Condensed bus+endian portability operations. */
 #if ADDRLEN == 64
 #define cpu_to_leXX(addr)	cpu_to_le64(addr)
+#define desc_to_virt(addr) bus_to_virt(le64_to_cpu(addr))
 #else 
 #define cpu_to_leXX(addr)	cpu_to_le32(addr)
+#define desc_to_virt(addr) bus_to_virt(le32_to_cpu(addr))
 #endif   
 
 
@@ -1497,7 +1499,7 @@ static int hamachi_rx(struct net_device 
 			break;
 		pci_dma_sync_single(hmp->pci_dev, desc->addr, hmp->rx_buf_sz, 
 			PCI_DMA_FROMDEVICE);
-		buf_addr = (u8 *)hmp->rx_ring + entry*sizeof(*desc);
+		buf_addr = desc_to_virt(desc->addr);
 		frame_status = le32_to_cpu(get_unaligned((s32*)&(buf_addr[data_size - 12])));
 		if (hamachi_debug > 4)
 			printk(KERN_DEBUG "  hamachi_rx() status was %8.8x.\n",
