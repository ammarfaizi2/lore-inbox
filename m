Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRAZGHG>; Fri, 26 Jan 2001 01:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129367AbRAZGG4>; Fri, 26 Jan 2001 01:06:56 -0500
Received: from cs.columbia.edu ([128.59.16.20]:18666 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129311AbRAZGGg>;
	Fri, 26 Jan 2001 01:06:36 -0500
Date: Thu, 25 Jan 2001 22:06:33 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <14960.38705.859136.36297@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101252156170.20615-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, David S. Miller wrote:

> Ion Badulescu writes:
>  > I'm just wondering, if a card supports sg but *not* TX csum, is it worth
>  > it to make use of sg? eepro100 falls into this category..
>
> No, not worth it for now.  In fact I'm going to mark that combination
> (sg without csum) as illegal in the final zerocopy patch I end up
> sending to Linus.

Well, in the meantime I've ported the starfire driver to the zerocopy
framework, it now takes almost full advantage of the card sg+csum
capabilities. The patch is attached; I'd appreciate it if you could
include it into the main zerocopy patch.

I've tested the new driver using a dual-port starfire, and it survived all
my attempts to kill it with fragmented TCP, UDP and ICMP. More testers
would be welcome, though.

BTW, it looks like not many people are using this driver: the original had
a bug which made it spit out one printk per Tx packet, which was *not*
funny. Also, the module could not be unloaded and reloaded, as it failed
to release some of its resources (Alan already has a fix for that)..

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

--------------------------------------------------
diff -urNX diff_kernel_excludes /usr/src/local/linux-2.4/drivers/net/starfire.c linux-2.4/drivers/net/starfire.c
--- /usr/src/local/linux-2.4/drivers/net/starfire.c	Fri Jan 12 12:52:48 2001
+++ linux-2.4/drivers/net/starfire.c	Thu Jan 25 21:23:18 2001
@@ -34,6 +34,10 @@

 	LK1.1.4 (jgarzik):
 	- Merge Becker version 1.03
+
+	LK1.2.0 (Ion Badulescu <ionut@cs.columbia.edu>)
+	- Support hardware Rx/Tx checksumming
+	- Add GFP firmware taken from Adaptec's Netware driver
 */

 /* These identify the driver base version and may not be removed. */
@@ -43,7 +47,7 @@
 " Updates and info at http://www.scyld.com/network/starfire.html\n";

 static const char version3[] =
-" (unofficial 2.4.x kernel port, version 1.1.4, August 10, 2000)\n";
+" (unofficial 2.4.x kernel port, version 1.2.0, January 25, 2001)\n";

 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
@@ -117,6 +121,8 @@
 #include <asm/bitops.h>
 #include <asm/io.h>

+#include "starfire_firmware.h"
+
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Adaptec Starfire Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
@@ -256,10 +262,10 @@
 	TxThreshold=0x500B0,
 	CompletionHiAddr=0x500B4, TxCompletionAddr=0x500B8,
 	RxCompletionAddr=0x500BC, RxCompletionQ2Addr=0x500C0,
-	CompletionQConsumerIdx=0x500C4,
+	CompletionQConsumerIdx=0x500C4, RxDMACtrl=0x500D0,
 	RxDescQCtrl=0x500D4, RxDescQHiAddr=0x500DC, RxDescQAddr=0x500E0,
 	RxDescQIdx=0x500E8, RxDMAStatus=0x500F0, RxFilterMode=0x500F4,
-	TxMode=0x55000,
+	TxMode=0x55000, TxGfpMem=0x58000, RxGfpMem=0x5a000,
 };

 /* Bits in the interrupt status/mask registers. */
@@ -288,8 +294,12 @@
 /* Completion queue entry.
    You must update the page allocation, init_ring and the shift count in rx()
    if using a larger format. */
+#define csum_rx_status
 struct rx_done_desc {
 	u32 status;					/* Low 16 bits is length. */
+#ifdef csum_rx_status
+	u32 status2;				/* Low 16 bits is csum */
+#endif
 #ifdef full_rx_status
 	u32 status2;
 	u16 vlanid;
@@ -307,8 +317,9 @@
 	u32 addr;
 };
 enum tx_desc_bits {
-	TxDescID=0xB1010000,		/* Also marks single fragment, add CRC.  */
-	TxDescIntr=0x08000000, TxRingWrap=0x04000000,
+	TxDescID=0xB0000000,
+	TxCRCEn=0x01000000, TxDescIntr=0x08000000,
+	TxRingWrap=0x04000000, TxCalTCP=0x02000000,
 };
 struct tx_done_report {
 	u32 status;					/* timestamp, index. */
@@ -318,9 +329,14 @@
 };

 #define PRIV_ALIGN	15 	/* Required alignment mask */
-struct ring_info {
+struct rx_ring_info {
+	struct sk_buff *skb;
+	dma_addr_t mapping;
+};
+struct tx_ring_info {
 	struct sk_buff *skb;
 	dma_addr_t mapping;
+	int len;
 };

 struct netdev_private {
@@ -330,8 +346,8 @@
 	dma_addr_t rx_ring_dma;
 	dma_addr_t tx_ring_dma;
 	/* The addresses of rx/tx-in-place skbuffs. */
-	struct ring_info rx_info[RX_RING_SIZE];
-	struct ring_info tx_info[TX_RING_SIZE];
+	struct rx_ring_info rx_info[RX_RING_SIZE];
+	struct tx_ring_info tx_info[TX_RING_SIZE];
 	/* Pointers to completion queues (full pages).  I should cache line pad..*/
 	u8 pad0[100];
 	struct rx_done_desc *rx_done_q;
@@ -435,6 +451,9 @@
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 		   dev->name, netdrv_tbl[chip_idx].name, ioaddr);

+	/* Starfire can do SG and TCP/UDP checksumming */
+	dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
+
 	/* Serial EEPROM reads are hidden by the hardware. */
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = readb(ioaddr + EEPROMCtrl + 20-i);
@@ -565,7 +584,7 @@
 	if (np->tx_done_q == 0)
 		np->tx_done_q = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_done_q_dma);
 	if (np->rx_done_q == 0)
-		np->rx_done_q = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->rx_done_q_dma);
+		np->rx_done_q = pci_alloc_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE, &np->rx_done_q_dma);
 	if (np->tx_ring == 0)
 		np->tx_ring = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_ring_dma);
 	if (np->rx_ring == 0)
@@ -576,7 +595,7 @@
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
 								np->tx_done_q, np->tx_done_q_dma);
 		if (np->rx_done_q)
-			pci_free_consistent(np->pci_dev, PAGE_SIZE,
+			pci_free_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE,
 								np->rx_done_q, np->rx_done_q_dma);
 		if (np->tx_ring)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
@@ -591,6 +610,8 @@
 	init_ring(dev);
 	/* Set the size of the Rx buffers. */
 	writel((np->rx_buf_sz<<16) | 0xA000, ioaddr + RxDescQCtrl);
+	/* Make the card reject bad csum TCP/UDP packets */
+	writel(0x03000604, ioaddr + RxDMACtrl);

 	/* Set Tx descriptor to type 1 and padding to 0 bytes. */
 	writel(0x02000401, ioaddr + TxDescCtrl);
@@ -608,7 +629,15 @@
 	writel(np->tx_ring_dma, ioaddr + TxRingPtr);

 	writel(np->tx_done_q_dma, ioaddr + TxCompletionAddr);
+#ifdef full_rx_status
+	writel(np->rx_done_q_dma | 0x30, ioaddr + RxCompletionAddr);
+#else
+#ifdef csum_rx_status
+	writel(np->rx_done_q_dma | 0x20, ioaddr + RxCompletionAddr);
+#else
 	writel(np->rx_done_q_dma, ioaddr + RxCompletionAddr);
+#endif
+#endif

 	if (debug > 1)
 		printk(KERN_DEBUG "%s:  Filling in the station address.\n", dev->name);
@@ -651,8 +680,13 @@
 	writel(0x00800000 | readl(ioaddr + PCIDeviceConfig),
 		   ioaddr + PCIDeviceConfig);

-	/* Enable the Rx and Tx units. */
-	writel(0x000F, ioaddr + GenCtrl);
+	/* Load Rx/Tx firmware into the frame processors */
+	for (i = 0; i < FIRMWARE_RX_SIZE * 2; i++)
+		writel(cpu_to_le32(firmware_rx[i]), ioaddr + RxGfpMem + i * 4);
+	for (i = 0; i < FIRMWARE_TX_SIZE * 2; i++)
+		writel(cpu_to_le32(firmware_tx[i]), ioaddr + TxGfpMem + i * 4);
+	/* Enable the Rx and Tx units, and the Rx/Tx frame processors. */
+	writel(0x003F, ioaddr + GenCtrl);

 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done netdev_open().\n",
@@ -806,6 +840,7 @@
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_info[i].skb = NULL;
 		np->tx_info[i].mapping = 0;
+		np->tx_info[i].len = 0;
 		np->tx_ring[i].status = 0;
 	}
 	return;
@@ -814,50 +849,79 @@
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdev_private *np = (struct netdev_private *)dev->priv;
-	unsigned entry;
+	unsigned entry, old_entry;
+	int frag;

 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */

+	if (np->cur_tx + skb_shinfo(skb)->nr_frags - np->dirty_tx >= TX_RING_SIZE - 1) {
+		np->tx_full = 1;
+		netif_stop_queue(dev);
+		return 1;
+	}
+
 	/* Calculate the next Tx descriptor entry. */
-	entry = np->cur_tx % TX_RING_SIZE;
+	old_entry = entry = np->cur_tx % TX_RING_SIZE;

-	np->tx_info[entry].skb = skb;
+	if (skb_shinfo(skb)->nr_frags == 0)
+		np->tx_info[entry].skb = skb;
+	np->tx_info[entry].len = skb_headlen(skb);
 	np->tx_info[entry].mapping =
-		pci_map_single(np->pci_dev, skb->data, skb->len, PCI_DMA_TODEVICE);
+		pci_map_single(np->pci_dev, skb->data, np->tx_info[entry].len, PCI_DMA_TODEVICE);

 	np->tx_ring[entry].addr = cpu_to_le32(np->tx_info[entry].mapping);
 	/* Add  "| TxDescIntr" to generate Tx-done interrupts. */
-	np->tx_ring[entry].status = cpu_to_le32(skb->len | TxDescID);
+	np->tx_ring[entry].status = cpu_to_le32(np->tx_info[entry].len | TxDescID | TxCRCEn);
+	np->tx_ring[entry].status |= cpu_to_le32((skb_shinfo(skb)->nr_frags + 1) << 16);
+
+	if (skb->ip_summed == CHECKSUM_HW)
+		np->tx_ring[entry].status |= cpu_to_le32(TxCalTCP);
+
+	if (entry + skb_shinfo(skb)->nr_frags >= TX_RING_SIZE-1) {		 /* Wrap ring */
+		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
+		entry = -1;
+	}
+
 	if (debug > 5) {
 		printk(KERN_DEBUG "%s: Tx #%d slot %d  %8.8x %8.8x.\n",
-			   dev->name, np->cur_tx, entry,
-			   le32_to_cpu(np->tx_ring[entry].status),
-			   le32_to_cpu(np->tx_ring[entry].addr));
+			   dev->name, np->cur_tx, old_entry,
+			   le32_to_cpu(np->tx_ring[old_entry].status),
+			   le32_to_cpu(np->tx_ring[old_entry].addr));
 	}
+
 	np->cur_tx++;
-#if 1
-	if (entry >= TX_RING_SIZE-1) {		 /* Wrap ring */
-		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
-		entry = -1;
-	}
-#endif

 	/* Non-x86: explicitly flush descriptor cache lines here. */

 	/* Update the producer index. */
 	writel(++entry, dev->base_addr + TxProducerIdx);

-	if (np->cur_tx - np->dirty_tx >= TX_RING_SIZE - 1) {
-		np->tx_full = 1;
-		netif_stop_queue(dev);
+	for (frag = 0; frag < skb_shinfo(skb)->nr_frags; frag++) {
+		skb_frag_t *this_frag = &skb_shinfo(skb)->frags[frag];
+
+		/* we already have the proper value in entry */
+		if (skb_shinfo(skb)->nr_frags == frag + 1)
+			np->tx_info[entry].skb = skb;
+		np->tx_info[entry].mapping =
+			pci_map_single(np->pci_dev, page_address(this_frag->page) + this_frag->page_offset, this_frag->size, PCI_DMA_TODEVICE);
+		np->tx_info[entry].len = this_frag->size;
+
+		np->tx_ring[entry].addr = cpu_to_le32(np->tx_info[entry].mapping);
+		np->tx_ring[entry].status = cpu_to_le32(this_frag->size | TxDescID);
+		if (debug > 5) {
+			printk(KERN_DEBUG "%s: Tx #%d slot %d  %8.8x %8.8x.\n",
+				   dev->name, np->cur_tx, entry,
+				   le32_to_cpu(np->tx_ring[entry].status),
+				   le32_to_cpu(np->tx_ring[entry].addr));
+		}
+		np->cur_tx++;
+		/* Update the producer index. */
+		writel(++entry, dev->base_addr + TxProducerIdx);
 	}
+
 	dev->trans_start = jiffies;

-	if (debug > 4) {
-		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
-			   dev->name, np->cur_tx, entry);
-	}
 	return 0;
 }

@@ -923,15 +987,18 @@
 					u16 entry = tx_status; 		/* Implicit truncate */
 					entry >>= 3;

-					skb = np->tx_info[entry].skb;
 					pci_unmap_single(np->pci_dev,
-							 np->tx_info[entry].mapping,
-							 skb->len, PCI_DMA_TODEVICE);
-
-					/* Scavenge the descriptor. */
-					dev_kfree_skb_irq(skb);
-					np->tx_info[entry].skb = NULL;
+									 np->tx_info[entry].mapping,
+									 np->tx_info[entry].len, PCI_DMA_TODEVICE);
 					np->tx_info[entry].mapping = 0;
+					np->tx_info[entry].len = 0;
+
+					skb = np->tx_info[entry].skb;
+					if (skb != NULL) {
+						/* Scavenge the descriptor. */
+						dev_kfree_skb_irq(skb);
+						np->tx_info[entry].skb = NULL;
+					}
 					np->dirty_tx++;
 				}
 				np->tx_done_q[np->tx_done].status = 0;
@@ -1038,14 +1105,16 @@
 				temp = skb_put(skb, pkt_len);
 				np->rx_info[entry].skb = NULL;
 				np->rx_info[entry].mapping = 0;
+#if 0
 #ifndef final_version				/* Remove after testing. */
-				if (le32_to_cpu(np->rx_ring[entry].rxaddr & ~3) != ((unsigned long) temp))
+				if ((le32_to_cpu(np->rx_ring[entry].rxaddr) & ~3) != ((unsigned long) temp))
 					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
-						   "do not match in netdev_rx: %d vs. %p / %p.\n",
+						   "do not match in netdev_rx: %x vs. %p / %p.\n",
 						   dev->name,
 						   le32_to_cpu(np->rx_ring[entry].rxaddr),
 						   skb->head, temp);
 #endif
+#endif
 			}
 #ifndef final_version				/* Remove after testing. */
 			/* You will want this info for the initial debug. */
@@ -1061,9 +1130,23 @@
 					   skb->data[17]);
 #endif
 			skb->protocol = eth_type_trans(skb, dev);
-#ifdef full_rx_status
-			if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x01000000)
+#if defined(full_rx_status) || defined(csum_rx_status)
+			if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x01000000) {
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
+			}
+			/*
+			 * This feature doesn't seem to be working, at least
+			 * with the two firmware versions I have. If the GFP sees
+			 * a fragment, it either ignores it completely, or reports
+			 * "bad checksum" on it.
+			 *
+			 * Maybe I missed something -- corrections are welcome. -Ion
+			 */
+			else if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x00400000) {
+				skb->ip_summed = CHECKSUM_HW;
+				skb->csum = le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0xffff;
+				printk(KERN_DEBUG "sf: checksum_hw, status2 = %x\n", np->rx_done_q[np->rx_done].status2);
+			}
 #endif
 			netif_rx(skb);
 			dev->last_rx = jiffies;
@@ -1340,6 +1423,7 @@
 		}
 		np->tx_info[i].skb = NULL;
 		np->tx_info[i].mapping = 0;
+		np->tx_info[i].len = 0;
 	}

 	MOD_DEC_USE_COUNT;
diff -urNX diff_kernel_excludes /usr/src/local/linux-2.4/drivers/net/starfire_firmware.h linux-2.4/drivers/net/starfire_firmware.h
--- /usr/src/local/linux-2.4/drivers/net/starfire_firmware.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4/drivers/net/starfire_firmware.h	Thu Jan 25 21:43:27 2001
@@ -0,0 +1,215 @@
+static u32 firmware_rx[] = {
+  0x010003dc, 0x00000000,
+  0x04000421, 0x00000086,
+  0x80000015, 0x0000180e,
+  0x81000015, 0x00006664,
+  0x1a0040ab, 0x00000b06,
+  0x14200011, 0x00000000,
+  0x14204022, 0x0000aaaa,
+  0x14204022, 0x00000300,
+  0x14204022, 0x00000000,
+  0x1a0040ab, 0x00000b14,
+  0x14200011, 0x00000000,
+  0x83000015, 0x00000002,
+  0x04000021, 0x00000000,
+  0x00000010, 0x00000000,
+  0x04000421, 0x00000087,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00008015, 0x00000000,
+  0x0000003e, 0x00000000,
+  0x00000010, 0x00000000,
+  0x82000015, 0x00004000,
+  0x009e8050, 0x00000000,
+  0x03008015, 0x00000000,
+  0x86008015, 0x00000000,
+  0x82000015, 0x00008000,
+  0x0100001c, 0x00000000,
+  0x000050a0, 0x0000010c,
+  0x4e20d011, 0x00006008,
+  0x1420d012, 0x00004008,
+  0x0000f090, 0x00007000,
+  0x0000c8b0, 0x00003000,
+  0x00004040, 0x00000000,
+  0x00108015, 0x00000000,
+  0x00a2c150, 0x00004000,
+  0x00a400b0, 0x00000014,
+  0x00000020, 0x00000000,
+  0x2500400d, 0x00002525,
+  0x00047220, 0x00003100,
+  0x00934070, 0x00000000,
+  0x00000020, 0x00000000,
+  0x00924460, 0x00000184,
+  0x2b20c011, 0x00000000,
+  0x0000c420, 0x00000540,
+  0x36014018, 0x0000422d,
+  0x14200011, 0x00000000,
+  0x00924460, 0x00000183,
+  0x3200001f, 0x00000034,
+  0x02ac0015, 0x00000002,
+  0x00a60110, 0x00000008,
+  0x42200011, 0x00000000,
+  0x00924060, 0x00000103,
+  0x0000001e, 0x00000000,
+  0x00000020, 0x00000100,
+  0x0000001e, 0x00000000,
+  0x00924460, 0x00000086,
+  0x00004080, 0x00000000,
+  0x0092c070, 0x00000000,
+  0x00924060, 0x00000100,
+  0x0000c890, 0x00005000,
+  0x00a6c110, 0x00000000,
+  0x00b0c090, 0x00000012,
+  0x021c0015, 0x00000000,
+  0x3200001f, 0x00000034,
+  0x00924460, 0x00000510,
+  0x44210011, 0x00000000,
+  0x42000011, 0x00000000,
+  0x83000015, 0x00000040,
+  0x00924460, 0x00000508,
+  0x45014018, 0x00004545,
+  0x00808050, 0x00000000,
+  0x83000015, 0x00000040,
+  0x62208012, 0x00000000,
+  0x82000015, 0x00000800,
+  0x15200011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x80000015, 0x0000eea4,
+  0x81000015, 0x0000005f,
+  0x00000060, 0x00000000,
+  0x00004120, 0x00000000,
+  0x00004a00, 0x00004000,
+  0x00924460, 0x00000190,
+  0x5601401a, 0x00005956,
+  0x14000011, 0x00000000,
+  0x00934050, 0x00000018,
+  0x00930050, 0x00000018,
+  0x3601403a, 0x0000002d,
+  0x000643a9, 0x00000000,
+  0x0000c420, 0x00000140,
+  0x5601401a, 0x00005956,
+  0x14000011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x000642a9, 0x00000000,
+  0x00024420, 0x00000183,
+  0x5601401a, 0x00005956,
+  0x82000015, 0x00002000,
+  0x15200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x15200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x15200011, 0x00000000,
+};	/* 104 Rx instructions */
+#define FIRMWARE_RX_SIZE 104
+
+static u32 firmware_tx[] = {
+  0x010003dc, 0x00000000,
+  0x04000421, 0x00000086,
+  0x80000015, 0x0000180e,
+  0x81000015, 0x00006664,
+  0x1a0040ab, 0x00000b06,
+  0x14200011, 0x00000000,
+  0x14204022, 0x0000aaaa,
+  0x14204022, 0x00000300,
+  0x14204022, 0x00000000,
+  0x1a0040ab, 0x00000b14,
+  0x14200011, 0x00000000,
+  0x83000015, 0x00000002,
+  0x04000021, 0x00000000,
+  0x00000010, 0x00000000,
+  0x14204022, 0x0000000c,
+  0x04000421, 0x00000087,
+  0x00000010, 0x00000000,
+  0x00008015, 0x00000000,
+  0x0000003e, 0x00000000,
+  0x00000010, 0x00000000,
+  0x82000015, 0x00004000,
+  0x009e8050, 0x00000000,
+  0x03008015, 0x00000000,
+  0x86008015, 0x00000000,
+  0x82000015, 0x00008000,
+  0x0100001c, 0x00000000,
+  0x000050a0, 0x0000010c,
+  0x4e20d011, 0x00006008,
+  0x1420d012, 0x00004008,
+  0x0000f090, 0x00007000,
+  0x0000c8b0, 0x00003000,
+  0x00004040, 0x00000000,
+  0x00108015, 0x00000000,
+  0x00a2c150, 0x00004000,
+  0x00a400b0, 0x00000014,
+  0x00000020, 0x00000000,
+  0x2500400d, 0x00002525,
+  0x00047220, 0x00003100,
+  0x00934070, 0x00000000,
+  0x00000020, 0x00000000,
+  0x00924460, 0x00000184,
+  0x2b20c011, 0x00000000,
+  0x0000c420, 0x00000540,
+  0x36014018, 0x00004b2d,
+  0x14200011, 0x00000000,
+  0x00924460, 0x00000183,
+  0x3200001f, 0x00000034,
+  0x02ac0015, 0x00000002,
+  0x00a60110, 0x00000008,
+  0x42200011, 0x00000000,
+  0x00924060, 0x00000103,
+  0x0000001e, 0x00000000,
+  0x00000020, 0x00000100,
+  0x0000001e, 0x00000000,
+  0x00924460, 0x00000086,
+  0x00004080, 0x00000000,
+  0x0092c070, 0x00000000,
+  0x00924060, 0x00000100,
+  0x0000c890, 0x00005000,
+  0x00a6c110, 0x00000000,
+  0x00b0c090, 0x00000012,
+  0x021c0015, 0x00000000,
+  0x3200001f, 0x00000034,
+  0x00924460, 0x00000510,
+  0x45210011, 0x00000000,
+  0x42000011, 0x00000000,
+  0x43014018, 0x00004343,
+  0x83000015, 0x00000040,
+  0x00924460, 0x00000508,
+  0x00808050, 0x00000000,
+  0x62208012, 0x00000000,
+  0x82000015, 0x00000800,
+  0x15200011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000050, 0x00000000,
+  0x00070050, 0x00000000,
+  0x36014018, 0x0000422d,
+  0x80000015, 0x0000eea4,
+  0x81000015, 0x0000005f,
+  0x00000060, 0x00000000,
+  0x00004120, 0x00000000,
+  0x00004a00, 0x00004000,
+  0x00924460, 0x00000190,
+  0x5601401a, 0x00005956,
+  0x14000011, 0x00000000,
+  0x00934050, 0x00000018,
+  0x00930050, 0x00000018,
+  0x3601403a, 0x0000002d,
+  0x000643a9, 0x00000000,
+  0x0000c420, 0x00000140,
+  0x5601401a, 0x00005956,
+  0x14000011, 0x00000000,
+  0x00000010, 0x00000000,
+  0x00000010, 0x00000000,
+  0x000642a9, 0x00000000,
+  0x00024420, 0x00000183,
+  0x5601401a, 0x00005956,
+  0x82000015, 0x00002000,
+  0x15200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x15200011, 0x00000000,
+  0x82000015, 0x00000010,
+  0x15200011, 0x00000000,
+};	/* 104 Tx instructions */
+#define FIRMWARE_TX_SIZE 104
diff -urNX diff_kernel_excludes /usr/src/local/linux-2.4/drivers/net/starfire_firmware.pl linux-2.4/drivers/net/starfire_firmware.pl
--- /usr/src/local/linux-2.4/drivers/net/starfire_firmware.pl	Wed Dec 31 16:00:00 1969
+++ linux-2.4/drivers/net/starfire_firmware.pl	Thu Jan 25 21:43:27 2001
@@ -0,0 +1,31 @@
+#!/usr/bin/perl
+
+# This script can be used to generate a new starfire_firmware.h
+# from GFP_RX.DAT and GFP_TX.DAT, files included with the DDK
+# and also with the Novell drivers.
+
+open FW, "GFP_RX.DAT" || die;
+open FWH, ">starfire_firmware.h" || die;
+
+printf(FWH "static u32 firmware_rx[] = {\n");
+$counter = 0;
+while ($foo = <FW>) {
+  chomp;
+  printf(FWH "  0x%s, 0x0000%s,\n", substr($foo, 4, 8), substr($foo, 0, 4));
+  $counter++;
+}
+
+close FW;
+open FW, "GFP_TX.DAT" || die;
+
+printf(FWH "};\t/* %d Rx instructions */\n#define FIRMWARE_RX_SIZE %d\n\nstatic u32 firmware_tx[] = {\n", $counter, $counter);
+$counter = 0;
+while ($foo = <FW>) {
+  chomp;
+  printf(FWH "  0x%s, 0x0000%s,\n", substr($foo, 4, 8), substr($foo, 0, 4));
+  $counter++;
+}
+
+close FW;
+printf(FWH "};\t/* %d Tx instructions */\n#define FIRMWARE_TX_SIZE %d\n", $counter, $counter);
+close(FWH);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
