Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUDXFJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUDXFJD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 01:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUDXFJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 01:09:03 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.120]:37786 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261939AbUDXFI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 01:08:57 -0400
Date: Fri, 23 Apr 2004 22:08:25 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: vi and postfix ;)
MIME-Version: 1.0
To: romieu@fr.zoreil.com
Cc: luto@myrealbox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BROKEN PATCH] r8169 tx csum offload
Content-Type: text/plain; charset=us-ascii
Message-Id: <20040424050932.4EE961D52@luto.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This applies after my patch from a couple minutes ago.  The only problem is
that it doesn't seem to do anything.  I added a printk to the
(skb->ip_summed == CHECKSUM_HW) check and it never triggered.  I confirmed
that sk_route_caps had NETIF_F_IP_CSUM set.  What gives?

--Andy Lutomirski

Patch against 2.6.6-rc2-mm1.

--- linux-2.6.6-rc2/drivers/net/r8169.c~r8169_tx_offload	2004-04-23 17:57:45.355820480 -0700
+++ linux-2.6.6-rc2/drivers/net/r8169.c	2004-04-23 20:30:49.634175536 -0700
@@ -55,6 +55,8 @@
 #include <linux/crc32.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
+#include <linux/in.h>
+#include <linux/ip.h>
 
 #include <asm/io.h>
 
@@ -301,6 +303,8 @@
 enum _DescStatusBit {
 	OWNbit = 0x80000000,
 	EORbit = 0x40000000,
+	TCPCSbit = 0x00010000,
+	UDPCSbit = 0x00020000,
 	FSbit = 0x20000000,
 	LSbit = 0x10000000,
 };
@@ -533,6 +537,8 @@
 	.get_link		= ethtool_op_get_link,
 	.get_settings		= rtl8169_get_settings,
 	.set_settings		= rtl8169_set_settings,
+	.get_tx_csum		= ethtool_op_get_tx_csum,
+	.set_tx_csum		= ethtool_op_set_tx_csum,
 };
 
 static void rtl8169_write_gmii_reg_bit(void *ioaddr, int reg, int bitnum,
@@ -952,6 +958,7 @@
 	dev->watchdog_timeo = RTL8169_TX_TIMEOUT;
 	dev->irq = pdev->irq;
 	dev->base_addr = (unsigned long) ioaddr;
+	dev->features = NETIF_F_IP_CSUM;
 //      dev->do_ioctl           = mii_ioctl;
 
 	tp = dev->priv;		// private data //
@@ -1428,6 +1435,7 @@
 
 	if (!(le32_to_cpu(tp->TxDescArray[entry].status) & OWNbit)) {
 		dma_addr_t mapping;
+		u32 flags = 0;
 
 		mapping = pci_map_single(tp->pci_dev, skb->data, len,
 					 PCI_DMA_TODEVICE);
@@ -1435,8 +1443,19 @@
 		tp->Tx_skbuff[entry] = skb;
 		tp->TxDescArray[entry].addr = cpu_to_le64(mapping);
 
+		if (skb->ip_summed == CHECKSUM_HW) {
+			const struct iphdr *ip = skb->nh.iph;
+			if (ip->protocol == IPPROTO_TCP)
+				flags = TCPCSbit;
+			else if (ip->protocol == IPPROTO_UDP)
+				flags = UDPCSbit;
+			else
+				BUG();
+		}
+
 		tp->TxDescArray[entry].status = cpu_to_le32(OWNbit | FSbit |
-			LSbit | len | (EORbit * !((entry + 1) % NUM_TX_DESC)));
+			LSbit | len | (EORbit * !((entry + 1) % NUM_TX_DESC)) |
+			flags);
 			
 		RTL_W8(TxPoll, 0x40);	//set polling bit
 
