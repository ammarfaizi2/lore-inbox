Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVCLEfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVCLEfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 23:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVCLEfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 23:35:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35268 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261858AbVCLEeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 23:34:19 -0500
Message-ID: <4232712D.3070705@pobox.com>
Date: Fri, 11 Mar 2005 23:33:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x net driver fixes
Content-Type: multipart/mixed;
 boundary="------------060701010700080001070204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060701010700080001070204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060701010700080001070204
Content-Type: text/plain;
 name="net-drivers.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="net-drivers.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.6

This will update the following files:

 drivers/net/lance.c            |    1 +
 drivers/net/r8169.c            |   17 ++++++++++-------
 drivers/net/sk98lin/skge.c     |    2 +-
 drivers/net/tulip/media.c      |    4 ++--
 drivers/net/tulip/tulip_core.c |   21 ++++++++++++---------
 drivers/net/typhoon-firmware.h |    2 +-
 6 files changed, 27 insertions(+), 20 deletions(-)

through these ChangeSets:

<apatard:mandrakesoft.com>:
  o sk98lin driver: fix driver name string

Adrian Bunk:
  o drivers/net/typhoon: make a firmware image static

Alan Cox:
  o ac bits for ULI ethernet missing from 2.6.11

François Romieu:
  o Fix r8169: panic on 2.6.11

Matthew Wilcox:
  o Lance needs delay.h


--------------060701010700080001070204
Content-Type: text/x-patch;
 name="net-drivers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="net-drivers.patch"

diff -Nru a/drivers/net/lance.c b/drivers/net/lance.c
--- a/drivers/net/lance.c	2005-03-11 23:31:46 -05:00
+++ b/drivers/net/lance.c	2005-03-11 23:31:46 -05:00
@@ -47,6 +47,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/slab.h>
diff -Nru a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	2005-03-11 23:31:46 -05:00
+++ b/drivers/net/r8169.c	2005-03-11 23:31:46 -05:00
@@ -1683,16 +1683,19 @@
 	rtl8169_make_unusable_by_asic(desc);
 }
 
-static inline void rtl8169_return_to_asic(struct RxDesc *desc, int rx_buf_sz)
+static inline void rtl8169_mark_to_asic(struct RxDesc *desc, u32 rx_buf_sz)
 {
-	desc->opts1 |= cpu_to_le32(DescOwn + rx_buf_sz);
+	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
+
+	desc->opts1 = cpu_to_le32(DescOwn | eor | rx_buf_sz);
 }
 
-static inline void rtl8169_give_to_asic(struct RxDesc *desc, dma_addr_t mapping,
-					int rx_buf_sz)
+static inline void rtl8169_map_to_asic(struct RxDesc *desc, dma_addr_t mapping,
+				       u32 rx_buf_sz)
 {
 	desc->addr = cpu_to_le64(mapping);
-	desc->opts1 |= cpu_to_le32(DescOwn + rx_buf_sz);
+	wmb();
+	rtl8169_mark_to_asic(desc, rx_buf_sz);
 }
 
 static int rtl8169_alloc_rx_skb(struct pci_dev *pdev, struct sk_buff **sk_buff,
@@ -1712,7 +1715,7 @@
 	mapping = pci_map_single(pdev, skb->tail, rx_buf_sz,
 				 PCI_DMA_FROMDEVICE);
 
-	rtl8169_give_to_asic(desc, mapping, rx_buf_sz);
+	rtl8169_map_to_asic(desc, mapping, rx_buf_sz);
 
 out:
 	return ret;
@@ -2150,7 +2153,7 @@
 			skb_reserve(skb, NET_IP_ALIGN);
 			eth_copy_and_sum(skb, sk_buff[0]->tail, pkt_size, 0);
 			*sk_buff = skb;
-			rtl8169_return_to_asic(desc, rx_buf_sz);
+			rtl8169_mark_to_asic(desc, rx_buf_sz);
 			ret = 0;
 		}
 	}
diff -Nru a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
--- a/drivers/net/sk98lin/skge.c	2005-03-11 23:31:46 -05:00
+++ b/drivers/net/sk98lin/skge.c	2005-03-11 23:31:46 -05:00
@@ -5155,7 +5155,7 @@
 MODULE_DEVICE_TABLE(pci, skge_pci_tbl);
 
 static struct pci_driver skge_driver = {
-	.name		= "skge",
+	.name		= "sk98lin",
 	.id_table	= skge_pci_tbl,
 	.probe		= skge_probe_one,
 	.remove		= __devexit_p(skge_remove_one),
diff -Nru a/drivers/net/tulip/media.c b/drivers/net/tulip/media.c
--- a/drivers/net/tulip/media.c	2005-03-11 23:31:46 -05:00
+++ b/drivers/net/tulip/media.c	2005-03-11 23:31:46 -05:00
@@ -88,7 +88,7 @@
 		value = ioread32(ioaddr + CSR9);
 		iowrite32(value & 0xFFEFFFFF, ioaddr + CSR9);
 		
-		value = (phy_id << 21) | (location << 16) | 0x80000000;
+		value = (phy_id << 21) | (location << 16) | 0x08000000;
 		iowrite32(value, ioaddr + CSR10);
 		
 		while(--i > 0) {
@@ -166,7 +166,7 @@
 		value = ioread32(ioaddr + CSR9);
 		iowrite32(value & 0xFFEFFFFF, ioaddr + CSR9);
 		
-		value = (phy_id << 21) | (location << 16) | 0x40000000 | (val & 0xFFFF);
+		value = (phy_id << 21) | (location << 16) | 0x04000000 | (val & 0xFFFF);
 		iowrite32(value, ioaddr + CSR10);
 		
 		while(--i > 0) {
diff -Nru a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c	2005-03-11 23:31:46 -05:00
+++ b/drivers/net/tulip/tulip_core.c	2005-03-11 23:31:46 -05:00
@@ -1102,15 +1102,18 @@
 			entry = tp->cur_tx++ % TX_RING_SIZE;
 
 			if (entry != 0) {
-				/* Avoid a chip errata by prefixing a dummy entry. */
-				tp->tx_buffers[entry].skb = NULL;
-				tp->tx_buffers[entry].mapping = 0;
-				tp->tx_ring[entry].length =
-					(entry == TX_RING_SIZE-1) ? cpu_to_le32(DESC_RING_WRAP) : 0;
-				tp->tx_ring[entry].buffer1 = 0;
-				/* Must set DescOwned later to avoid race with chip */
-				dummy = entry;
-				entry = tp->cur_tx++ % TX_RING_SIZE;
+				/* Avoid a chip errata by prefixing a dummy entry. Don't do
+				   this on the ULI526X as it triggers a different problem */
+				if (!(tp->chip_id == ULI526X && (tp->revision = 0x40 || tp->revision == 0x50))) {
+					tp->tx_buffers[entry].skb = NULL;
+					tp->tx_buffers[entry].mapping = 0;
+					tp->tx_ring[entry].length =
+						(entry == TX_RING_SIZE-1) ? cpu_to_le32(DESC_RING_WRAP) : 0;
+					tp->tx_ring[entry].buffer1 = 0;
+					/* Must set DescOwned later to avoid race with chip */
+					dummy = entry;
+					entry = tp->cur_tx++ % TX_RING_SIZE;
+				}
 			}
 
 			tp->tx_buffers[entry].skb = NULL;
diff -Nru a/drivers/net/typhoon-firmware.h b/drivers/net/typhoon-firmware.h
--- a/drivers/net/typhoon-firmware.h	2005-03-11 23:31:46 -05:00
+++ b/drivers/net/typhoon-firmware.h	2005-03-11 23:31:46 -05:00
@@ -32,7 +32,7 @@
  */ 
 
  /* ver 03.001.008 */
-const u8 typhoon_firmware_image[] = {
+static const u8 typhoon_firmware_image[] = {
 0x54, 0x59, 0x50, 0x48, 0x4f, 0x4f, 0x4e, 0x00, 0x02, 0x00, 0x00, 0x00, 
 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xcb, 0x99, 0xb1, 0xd4, 
 0x4c, 0xb8, 0xd0, 0x4b, 0x32, 0x02, 0xd4, 0xee, 0x73, 0x7e, 0x0b, 0x13, 

--------------060701010700080001070204--
