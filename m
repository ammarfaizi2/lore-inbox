Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBHBwi>; Wed, 7 Feb 2001 20:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRBHBw3>; Wed, 7 Feb 2001 20:52:29 -0500
Received: from vp175097.reshsg.uci.edu ([128.195.175.97]:39690 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S129161AbRBHBwP>; Wed, 7 Feb 2001 20:52:15 -0500
Date: Wed, 7 Feb 2001 17:52:06 -0800
Message-Id: <200102080152.f181q6G17259@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <3A81A89C.DFD09434@mandrakesoft.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Wed, 07 Feb 2001 14:57:16 -0500, Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> Here's the patch I have, against vanilla 2.4.2-pre1, with the
> pci_enable_device preferred changes included...

Well, I decided to bite the bullet and port my zerocopy starfire
changes to the official tree, properly ifdef'ed. So here it goes,
the patch was made against 2.4.1 vanilla and includes all the
fixes from Jeff and myself that were sent to the list so far.

I've also added myself as the starfire maintainer -- I hope
nobody objects.

Alan, if you want, I can rediff this against 2.4.1-ac. I'll
also try and send a 2.2.19 patch shortly.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
--------------------------
--- linux-2.4.vanilla/MAINTAINERS	Wed Feb  7 15:45:15 2001
+++ linux-2.4-boxter/MAINTAINERS	Wed Feb  7 17:38:50 2001
@@ -1166,6 +1166,11 @@
 W:	http://www.stallion.com
 S:	Supported
 
+STARFIRE/DURALAN NETWORK DRIVER
+P:	Ion Badulescu
+M:	ionut@cs.columbia.edu
+S:	Maintained
+
 STARMODE RADIO IP (STRIP) PROTOCOL DRIVER
 W:	http://mosquitonet.Stanford.EDU/strip.html
 S:	Unsupported ?
--- linux-2.4.vanilla/drivers/net/starfire.c	Fri Aug 11 15:57:58 2000
+++ linux-2.4-boxter/drivers/net/starfire.c	Wed Feb  7 17:38:19 2001
@@ -34,6 +34,10 @@
 	
 	LK1.1.4 (jgarzik):
 	- Merge Becker version 1.03
+
+	LK1.2.1 (Ion Badulescu <ionut@cs.columbia.edu>)
+	- Support hardware Rx/Tx checksumming
+	- Use the GFP firmware taken from Adaptec's Netware driver
 */
 
 /* These identify the driver base version and may not be removed. */
@@ -43,11 +47,36 @@
 " Updates and info at http://www.scyld.com/network/starfire.html\n";
 
 static const char version3[] =
-" (unofficial 2.4.x kernel port, version 1.1.4, August 10, 2000)\n";
+" (unofficial 2.4.x kernel port, version 1.2.1, February 07, 2001)\n";
 
 /* The user-configurable values.
    These may be modified when a driver module is loaded.*/
 
+/*
+ * Adaptec's license for their Novell drivers (which is where I got the
+ * firmware files) does not allow to redistribute them. Thus, we can't
+ * include them with this driver.
+ *
+ * However, an end-user is allowed to download and use them, after
+ * converting them to C header files using starfire_firmware.pl.
+ * Once that's done, the #undef must be changed into a #define
+ * for this driver to really use the firmware. Note that Rx/Tx
+ * hardware TCP checksumming is not possible without the firmware.
+ *
+ * I'm currently talking to Adaptec about this redistribution issue.
+ * Stay tuned...
+ */
+#undef HAS_FIRMWARE
+/*
+ * The current frame processor firmware fails to checksum a fragment
+ * of length 1. If and when this is fixed, the #define below can be removed.
+ */
+#define HAS_BROKEN_FIRMWARE
+/*
+ * Define this if using the driver with the zero-copy patch
+ */
+#undef ZEROCOPY
+
 /* Used for tuning interrupt latency vs. overhead. */
 static int interrupt_mitigation = 0x0;
 
@@ -88,25 +117,39 @@
 
 #define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
 
+/*
+ * The ia64 doesn't allow for unaligned loads even of integers being
+ * misaligned on a 2 byte boundary. Thus always force copying of
+ * packets as the starfire doesn't allow for misaligned DMAs ;-(
+ * 23/10/2000 - Jes
+ *
+ * Neither does the Alpha. -Ion
+ */
+#if defined(__ia64__) || defined(__alpha__)
+#define PKT_SHOULD_COPY(pkt_len)       1
+#else
+#define PKT_SHOULD_COPY(pkt_len)       (pkt_len < rx_copybreak)
+#endif
+
+#ifdef ZEROCOPY
+#define skb_first_frag_len(skb)	skb_headlen(skb)
+#else  /* not ZEROCOPY */
+#define skb_first_frag_len(skb)	(skb->len)
+#endif /* not ZEROCOPY */
+
 #if !defined(__OPTIMIZE__)
 #warning  You must compile this file with the correct options!
 #warning  See the last lines of the source file.
 #error You must compile this driver with "-O".
 #endif
 
-/* Include files, designed to support most kernel versions 2.0.0 and later. */
-#include <linux/version.h>
 #include <linux/module.h>
-#if LINUX_VERSION_CODE < 0x20300  &&  defined(MODVERSIONS)
-#include <linux/modversions.h>
-#endif
-
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/netdevice.h>
@@ -117,12 +160,17 @@
 #include <asm/bitops.h>
 #include <asm/io.h>
 
+#ifdef HAS_FIRMWARE
+#include "starfire_firmware.h"
+#endif /* HAS_FIRMWARE */
+
 MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Adaptec Starfire Ethernet driver");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(mtu, "i");
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
+MODULE_PARM(interrupt_mitigation, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
 
@@ -155,8 +203,9 @@
 See the Adaptec manual for the many possible structures, and options for
 each structure.  There are far too many to document here.
 
-For transmit this driver uses type 1 transmit descriptors, and relies on
-automatic minimum-length padding.  It does not use the completion queue
+For transmit this driver uses type 0/1 transmit descriptors (depending
+on the presence of the zerocopy patches), and relies on automatic
+minimum-length padding.  It does not use the completion queue
 consumer index, but instead checks for non-zero status entries.
 
 For receive this driver uses type 0 receive descriptors.  The driver
@@ -167,14 +216,15 @@
 When an incoming frame is less than RX_COPYBREAK bytes long, a fresh skbuff
 is allocated and the frame is copied to the new skbuff.  When the incoming
 frame is larger, the skbuff is passed directly up the protocol stack.
-Buffers consumed this way are replaced by newly allocated skbuffs in a later
-phase of receive.
+Buffers consumed this way are replaced by newly allocated skbuffs in a
+later phase of receive.
 
 A notable aspect of operation is that unaligned buffers are not permitted by
 the Starfire hardware.  The IP header at offset 14 in an ethernet frame thus
 isn't longword aligned, which may cause problems on some machine
-e.g. Alphas.  Copied frames are put into the skbuff at an offset of "+2",
-16-byte aligning the IP header.
+e.g. Alphas and IA64. For these architectures, the driver is forced to copy
+the frame into a new skbuff unconditionally. Copied frames are put into the
+skbuff at an offset of "+2", thus 16-byte aligning the IP header.
 
 IIId. Synchronization
 
@@ -256,19 +306,31 @@
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
 enum intr_status_bits {
-	IntrNormalSummary=0x8000,	IntrAbnormalSummary=0x02000000,
-	IntrRxDone=0x0300, IntrRxEmpty=0x10040, IntrRxPCIErr=0x80000,
-	IntrTxDone=0x4000, IntrTxEmpty=0x1000, IntrTxPCIErr=0x80000,
-	StatsMax=0x08000000, LinkChange=0xf0000000,
-	IntrTxDataLow=0x00040000,
+	IntrLinkChange=0xf0000000, IntrStatsMax=0x08000000,
+	IntrAbnormalSummary=0x02000000, IntrGeneralTimer=0x01000000,
+	IntrSoftware=0x800000, IntrRxComplQ1Low=0x400000,
+	IntrTxComplQLow=0x200000, IntrPCI=0x100000,
+	IntrDMAErr=0x080000, IntrTxDataLow=0x040000,
+	IntrRxComplQ2Low=0x020000, IntrRxDescQ1Low=0x010000,
+	IntrNormalSummary=0x8000, IntrTxDone=0x4000,
+	IntrTxDMADone=0x2000, IntrTxEmpty=0x1000,
+	IntrEarlyRxQ2=0x0800, IntrEarlyRxQ1=0x0400,
+	IntrRxQ2Done=0x0200, IntrRxQ1Done=0x0100,
+	IntrRxGFPDead=0x80, IntrRxDescQ2Low=0x40,
+	IntrNoTxCsum=0x20, IntrTxBadID=0x10,
+	IntrHiPriTxBadID=0x08, IntrRxGfp=0x04,
+	IntrTxGfp=0x02, IntrPCIPad=0x01,
+	/* not quite bits */
+	IntrRxDone=IntrRxQ2Done | IntrRxQ1Done,
+	IntrRxEmpty=IntrRxDescQ1Low | IntrRxDescQ2Low,
 };
 
 /* Bits in the RxFilterMode register. */
@@ -277,6 +339,37 @@
 	AcceptMulticast=0x10, AcceptMyPhys=0xE040,
 };
 
+/* Bits in the TxDescCtrl register. */
+enum tx_ctrl_bits {
+	TxDescSpaceUnlim=0x00, TxDescSpace32=0x10, TxDescSpace64=0x20,
+	TxDescSpace128=0x30, TxDescSpace256=0x40,
+	TxDescType0=0x00, TxDescType1=0x01, TxDescType2=0x02,
+	TxDescType3=0x03, TxDescType4=0x04,
+	TxNoDMACompletion=0x08, TxDescQ64bit=0x80,
+	TxHiPriFIFOThreshShift=24, TxPadLenShift=16,
+	TxDMABurstSizeShift=8,
+};
+
+/* Bits in the RxDescQCtrl register. */
+enum rx_ctrl_bits {
+	RxBufferLenShift=16, RxMinDescrThreshShift=0,
+	RxPrefetchMode=0x8000, Rx2048QEntries=0x4000,
+	RxVariableQ=0x2000, RxDesc64bit=0x1000,
+	RxDescQAddr64bit=0x0100,
+	RxDescSpace4=0x000, RxDescSpace8=0x100,
+	RxDescSpace16=0x200, RxDescSpace32=0x300,
+	RxDescSpace64=0x400, RxDescSpace128=0x500,
+	RxConsumerWrEn=0x80,
+};
+
+/* Bits in the RxCompletionAddr register */
+enum rx_compl_bits {
+	RxComplQAddr64bit=0x80, TxComplProducerWrEn=0x40,
+	RxComplType0=0x00, RxComplType1=0x10,
+	RxComplType2=0x20, RxComplType3=0x30,
+	RxComplThreshShift=0,
+};
+
 /* The Rx and Tx buffer descriptors. */
 struct starfire_rx_desc {
 	u32 rxaddr;					/* Optionally 64 bits. */
@@ -288,27 +381,51 @@
 /* Completion queue entry.
    You must update the page allocation, init_ring and the shift count in rx()
    if using a larger format. */
+#ifdef HAS_FIRMWARE
+#define csum_rx_status
+#endif /* HAS_FIRMWARE */
 struct rx_done_desc {
 	u32 status;					/* Low 16 bits is length. */
+#ifdef csum_rx_status
+	u32 status2;				/* Low 16 bits is csum */
+#endif /* csum_rx_status */
 #ifdef full_rx_status
 	u32 status2;
 	u16 vlanid;
 	u16 csum; 			/* partial checksum */
 	u32 timestamp;
-#endif
+#endif /* full_rx_status */
 };
 enum rx_done_bits {
 	RxOK=0x20000000, RxFIFOErr=0x10000000, RxBufQ2=0x08000000,
 };
 
+#ifdef ZEROCOPY
+/* Type 0 Tx descriptor. */
+/* If more fragments are needed, don't forget to change the
+   descriptor spacing as well! */
+struct starfire_tx_desc {
+	u32 status;
+	u32 nbufs;
+	u32 first_addr;
+	u16 first_len;
+	u16 total_len;
+	struct {
+		u32 addr;
+		u32 len;
+	} frag[6];
+};
+#else  /* not ZEROCOPY */
 /* Type 1 Tx descriptor. */
 struct starfire_tx_desc {
 	u32 status;					/* Upper bits are status, lower 16 length. */
-	u32 addr;
+	u32 first_addr;
 };
+#endif /* not ZEROCOPY */
 enum tx_desc_bits {
-	TxDescID=0xB1010000,		/* Also marks single fragment, add CRC.  */
-	TxDescIntr=0x08000000, TxRingWrap=0x04000000,
+	TxDescID=0xB0000000,
+	TxCRCEn=0x01000000, TxDescIntr=0x08000000,
+	TxRingWrap=0x04000000, TxCalTCP=0x02000000,
 };
 struct tx_done_report {
 	u32 status;					/* timestamp, index. */
@@ -318,10 +435,17 @@
 };
 
 #define PRIV_ALIGN	15 	/* Required alignment mask */
-struct ring_info {
+struct rx_ring_info {
 	struct sk_buff *skb;
 	dma_addr_t mapping;
 };
+struct tx_ring_info {
+	struct sk_buff *skb;
+	dma_addr_t first_mapping;
+#ifdef ZEROCOPY
+	dma_addr_t frag_mapping[6];
+#endif /* ZEROCOPY */
+};
 
 struct netdev_private {
 	/* Descriptor rings first for alignment. */
@@ -330,8 +454,8 @@
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
@@ -390,16 +514,20 @@
 	static int card_idx = -1;
 	static int printed_version = 0;
 	long ioaddr;
-	int drv_flags, io_size = netdrv_tbl[chip_idx].io_size;
+	int drv_flags, io_size;
 
 	card_idx++;
 	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
-	
+
 	if (!printed_version++)
 		printk(KERN_INFO "%s" KERN_INFO "%s" KERN_INFO "%s",
 		       version1, version2, version3);
 
+	if (pci_enable_device (pdev))
+		return -EIO;
+
 	ioaddr = pci_resource_start (pdev, 0);
+	io_size = pci_resource_len (pdev, 0);
 	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_MEM) == 0)) {
 		printk (KERN_ERR "starfire %d: no PCI MEM resources, aborting\n", card_idx);
 		return -ENODEV;
@@ -410,6 +538,7 @@
 		printk (KERN_ERR "starfire %d: cannot alloc etherdev, aborting\n", card_idx);
 		return -ENOMEM;
 	}
+	SET_MODULE_OWNER(dev);
 	
 	irq = pdev->irq; 
 
@@ -419,9 +548,6 @@
 		goto err_out_free_netdev;
 	}
 	
-	if (pci_enable_device (pdev))
-		goto err_out_free_res;
-	
 	ioaddr = (long) ioremap (ioaddr, io_size);
 	if (!ioaddr) {
 		printk (KERN_ERR "starfire %d: cannot remap 0x%x @ 0x%lx, aborting\n",
@@ -434,6 +560,14 @@
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 		   dev->name, netdrv_tbl[chip_idx].name, ioaddr);
 
+#ifdef ZEROCOPY
+	/* Starfire can do SG and TCP/UDP checksumming */
+	dev->features |= NETIF_F_SG;
+#ifdef HAS_FIRMWARE
+	dev->features |= NETIF_F_IP_CSUM;
+#endif /* HAS_FIRMWARE */
+#endif /* ZEROCOPY */
+
 	/* Serial EEPROM reads are hidden by the hardware. */
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = readb(ioaddr + EEPROMCtrl + 20-i);
@@ -540,19 +674,15 @@
 
 static int netdev_open(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int i, retval;
 
 	/* Do we ever need to reset the chip??? */
 
-	MOD_INC_USE_COUNT;
-
 	retval = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
-	if (retval) {
-		MOD_DEC_USE_COUNT;
+	if (retval)
 		return retval;
-	}
 
 	/* Disable the Rx and Tx, and reset the chip. */
 	writel(0, ioaddr + GenCtrl);
@@ -564,7 +694,7 @@
 	if (np->tx_done_q == 0)
 		np->tx_done_q = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_done_q_dma);
 	if (np->rx_done_q == 0)
-		np->rx_done_q = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->rx_done_q_dma);
+		np->rx_done_q = pci_alloc_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE, &np->rx_done_q_dma);
 	if (np->tx_ring == 0)
 		np->tx_ring = pci_alloc_consistent(np->pci_dev, PAGE_SIZE, &np->tx_ring_dma);
 	if (np->rx_ring == 0)
@@ -575,7 +705,7 @@
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
 								np->tx_done_q, np->tx_done_q_dma);
 		if (np->rx_done_q)
-			pci_free_consistent(np->pci_dev, PAGE_SIZE,
+			pci_free_consistent(np->pci_dev, sizeof(struct rx_done_desc) * DONE_Q_SIZE,
 								np->rx_done_q, np->rx_done_q_dma);
 		if (np->tx_ring)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
@@ -583,16 +713,32 @@
 		if (np->rx_ring)
 			pci_free_consistent(np->pci_dev, PAGE_SIZE,
 								np->rx_ring, np->rx_ring_dma);
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
 	init_ring(dev);
 	/* Set the size of the Rx buffers. */
-	writel((np->rx_buf_sz<<16) | 0xA000, ioaddr + RxDescQCtrl);
-
+	writel((np->rx_buf_sz << RxBufferLenShift) |
+		   (0 << RxMinDescrThreshShift) |
+		   RxPrefetchMode | RxVariableQ |
+		   RxDescSpace4,
+		   ioaddr + RxDescQCtrl);
+
+#ifdef ZEROCOPY
+	/* Set Tx descriptor to type 0 and spacing to 64 bytes. */
+	writel((2 << TxHiPriFIFOThreshShift) |
+	       (0 << TxPadLenShift) |
+	       (4 << TxDMABurstSizeShift) |
+	       TxDescSpace64 | TxDescType0,
+	       ioaddr + TxDescCtrl);
+#else  /* not ZEROCOPY */
 	/* Set Tx descriptor to type 1 and padding to 0 bytes. */
-	writel(0x02000401, ioaddr + TxDescCtrl);
+	writel((2 << TxHiPriFIFOThreshShift) |
+	       (0 << TxPadLenShift) |
+	       (4 << TxDMABurstSizeShift) |
+	       TxDescSpaceUnlim | TxDescType1,
+	       ioaddr + TxDescCtrl);
+#endif /* not ZEROCOPY */
 
 #if defined(ADDR_64BITS) && defined(__alpha__)
 	/* XXX We really need a 64-bit PCI dma interfaces too... -DaveM */
@@ -607,7 +753,24 @@
 	writel(np->tx_ring_dma, ioaddr + TxRingPtr);
 
 	writel(np->tx_done_q_dma, ioaddr + TxCompletionAddr);
-	writel(np->rx_done_q_dma, ioaddr + RxCompletionAddr);
+#ifdef full_rx_status
+	writel(np->rx_done_q_dma |
+		   RxComplType3 |
+		   (0 << RxComplThreshShift),
+		   ioaddr + RxCompletionAddr);
+#else  /* not full_rx_status */
+#ifdef csum_rx_status
+	writel(np->rx_done_q_dma |
+		   RxComplType2 |
+		   (0 << RxComplThreshShift),
+		   ioaddr + RxCompletionAddr);
+#else  /* not csum_rx_status */
+	writel(np->rx_done_q_dma |
+		   RxComplType0 |
+		   (0 << RxComplThreshShift),
+		   ioaddr + RxCompletionAddr);
+#endif /* not csum_rx_status */
+#endif /* not full_rx_status */
 
 	if (debug > 1)
 		printk(KERN_DEBUG "%s:  Filling in the station address.\n", dev->name);
@@ -643,15 +806,26 @@
 	check_duplex(dev, 1);
 
 	/* Set the interrupt mask and enable PCI interrupts. */
-	writel(IntrRxDone | IntrRxEmpty | IntrRxPCIErr |
-		   IntrTxDone | IntrTxEmpty | IntrTxPCIErr |
-		   StatsMax | LinkChange | IntrNormalSummary | IntrAbnormalSummary
-		   | 0x0010 , ioaddr + IntrEnable);
+	writel(IntrRxDone | IntrRxEmpty | IntrDMAErr |
+	       IntrTxDone | IntrStatsMax | IntrLinkChange |
+	       IntrNormalSummary | IntrAbnormalSummary |
+	       IntrRxGFPDead | IntrNoTxCsum | IntrTxBadID,
+	       ioaddr + IntrEnable);
 	writel(0x00800000 | readl(ioaddr + PCIDeviceConfig),
 		   ioaddr + PCIDeviceConfig);
 
-	/* Enable the Rx and Tx units. */
+#ifdef HAS_FIRMWARE
+	/* Load Rx/Tx firmware into the frame processors */
+	for (i = 0; i < FIRMWARE_RX_SIZE * 2; i++)
+		writel(cpu_to_le32(firmware_rx[i]), ioaddr + RxGfpMem + i * 4);
+	for (i = 0; i < FIRMWARE_TX_SIZE * 2; i++)
+		writel(cpu_to_le32(firmware_tx[i]), ioaddr + TxGfpMem + i * 4);
+	/* Enable the Rx and Tx units, and the Rx/Tx frame processors. */
+	writel(0x003F, ioaddr + GenCtrl);
+#else  /* not HAS_FIRMWARE */
+	/* Enable the Rx and Tx units only. */
 	writel(0x000F, ioaddr + GenCtrl);
+#endif /* not HAS_FIRMWARE */
 
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done netdev_open().\n",
@@ -669,7 +843,7 @@
 
 static void check_duplex(struct net_device *dev, int startup)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int new_tx_mode ;
 
@@ -702,7 +876,7 @@
 static void netdev_timer(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 	int next_tick = 60*HZ;		/* Check before driver release. */
 
@@ -730,7 +904,7 @@
 
 static void tx_timeout(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
 
 	printk(KERN_WARNING "%s: Transmit timed out, status %8.8x,"
@@ -757,14 +931,14 @@
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
-	return;
+	netif_wake_queue(dev);
 }
 
 
 /* Initialize the Rx and Tx rings, along with various 'dev' bits. */
 static void init_ring(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	int i;
 
 	np->tx_full = 0;
@@ -804,7 +978,14 @@
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_info[i].skb = NULL;
-		np->tx_info[i].mapping = 0;
+		np->tx_info[i].first_mapping = 0;
+#ifdef ZEROCOPY
+		{
+			int j;
+			for (j = 0; j < 6; j++)
+				np->tx_info[i].frag_mapping[j] = 0;
+		}
+#endif /* ZEROCOPY */
 		np->tx_ring[i].status = 0;
 	}
 	return;
@@ -812,8 +993,11 @@
 
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
-	unsigned entry;
+	struct netdev_private *np = dev->priv;
+	unsigned int entry;
+#ifdef ZEROCOPY
+	int i;
+#endif
 
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
@@ -821,42 +1005,102 @@
 	/* Calculate the next Tx descriptor entry. */
 	entry = np->cur_tx % TX_RING_SIZE;
 
+#if defined(ZEROCOPY) && defined(HAS_FIRMWARE) && defined(HAS_BROKEN_FIRMWARE)
+	{
+		int has_bad_length = 0;
+
+		if (skb_first_frag_len(skb) == 1)
+			has_bad_length = 1;
+		else {
+			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
+				if (skb_shinfo(skb)->frags[i].size == 1) {
+					has_bad_length = 1;
+					break;
+				}
+		}
+
+		if (has_bad_length)
+			skb_checksum_help(skb);
+	}
+#endif /* ZEROCOPY && HAS_FIRMWARE && HAS_BROKEN_FIRMWARE */
+
 	np->tx_info[entry].skb = skb;
-	np->tx_info[entry].mapping =
-		pci_map_single(np->pci_dev, skb->data, skb->len, PCI_DMA_TODEVICE);
+	np->tx_info[entry].first_mapping =
+		pci_map_single(np->pci_dev, skb->data, skb_first_frag_len(skb), PCI_DMA_TODEVICE);
 
-	np->tx_ring[entry].addr = cpu_to_le32(np->tx_info[entry].mapping);
+	np->tx_ring[entry].first_addr = cpu_to_le32(np->tx_info[entry].first_mapping);
+#ifdef ZEROCOPY
+	np->tx_ring[entry].first_len = cpu_to_le32(skb_first_frag_len(skb));
+	np->tx_ring[entry].total_len = cpu_to_le32(skb->len);
 	/* Add  "| TxDescIntr" to generate Tx-done interrupts. */
-	np->tx_ring[entry].status = cpu_to_le32(skb->len | TxDescID);
+	np->tx_ring[entry].status = cpu_to_le32(TxDescID | TxCRCEn);
+	np->tx_ring[entry].nbufs = cpu_to_le32(skb_shinfo(skb)->nr_frags + 1);
+#else  /* not ZEROCOPY */
+	/* Add  "| TxDescIntr" to generate Tx-done interrupts. */
+	np->tx_ring[entry].status = cpu_to_le32(skb->len | TxDescID | TxCRCEn | 1 << 16);
+#endif /* not ZEROCOPY */
+
+	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
+		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
+
+	/* not ifdef'ed, but shouldn't happen without ZEROCOPY */
+	if (skb->ip_summed == CHECKSUM_HW)
+		np->tx_ring[entry].status |= cpu_to_le32(TxCalTCP);
+
 	if (debug > 5) {
-		printk(KERN_DEBUG "%s: Tx #%d slot %d  %8.8x %8.8x.\n",
+#ifdef ZEROCOPY
+		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x nbufs %d len %4.4x/%4.4x.\n",
 			   dev->name, np->cur_tx, entry,
 			   le32_to_cpu(np->tx_ring[entry].status),
-			   le32_to_cpu(np->tx_ring[entry].addr));
+			   le32_to_cpu(np->tx_ring[entry].nbufs),
+			   le32_to_cpu(np->tx_ring[entry].first_len),
+			   le32_to_cpu(np->tx_ring[entry].total_len));
+#else  /* not ZEROCOPY */
+		printk(KERN_DEBUG "%s: Tx #%d slot %d status %8.8x.\n",
+			   dev->name, np->cur_tx, entry,
+			   le32_to_cpu(np->tx_ring[entry].status));
+#endif /* not ZEROCOPY */
 	}
+
+#ifdef ZEROCOPY
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *this_frag = &skb_shinfo(skb)->frags[i];
+
+		/* we already have the proper value in entry */
+		np->tx_info[entry].frag_mapping[i] =
+			pci_map_single(np->pci_dev, page_address(this_frag->page) + this_frag->page_offset, this_frag->size, PCI_DMA_TODEVICE);
+
+		np->tx_ring[entry].frag[i].addr = cpu_to_le32(np->tx_info[entry].frag_mapping[i]);
+		np->tx_ring[entry].frag[i].len = cpu_to_le32(this_frag->size);
+		if (debug > 5) {
+			printk(KERN_DEBUG "%s: Tx #%d frag %d len %4.4x.\n",
+				   dev->name, np->cur_tx, i,
+				   le32_to_cpu(np->tx_ring[entry].frag[i].len));
+		}
+	}
+#endif /* ZEROCOPY */
+
 	np->cur_tx++;
-#if 1
-	if (entry >= TX_RING_SIZE-1) {		 /* Wrap ring */
-		np->tx_ring[entry].status |= cpu_to_le32(TxRingWrap | TxDescIntr);
+
+	if (entry >= TX_RING_SIZE-1)		 /* Wrap ring */
 		entry = -1;
-	}
-#endif
+	entry++;
 
 	/* Non-x86: explicitly flush descriptor cache lines here. */
+	/* Ensure everything is written back above before the transmit is
+	   initiated. - Jes */
+	wmb();
 
 	/* Update the producer index. */
-	writel(++entry, dev->base_addr + TxProducerIdx);
+	writel(entry * (sizeof(struct starfire_tx_desc) / 8), dev->base_addr + TxProducerIdx);
 
 	if (np->cur_tx - np->dirty_tx >= TX_RING_SIZE - 1) {
 		np->tx_full = 1;
 		netif_stop_queue(dev);
 	}
+
 	dev->trans_start = jiffies;
 
-	if (debug > 4) {
-		printk(KERN_DEBUG "%s: Transmit frame #%d queued in slot %d.\n",
-			   dev->name, np->cur_tx, entry);
-	}
 	return 0;
 }
 
@@ -878,7 +1122,7 @@
 #endif
 
 	ioaddr = dev->base_addr;
-	np = (struct netdev_private *)dev->priv;
+	np = dev->priv;
 
 	do {
 		u32 intr_status = readl(ioaddr + IntrClear);
@@ -919,18 +1163,33 @@
 					np->stats.tx_packets++;
 				} else if ((tx_status & 0xe0000000) == 0x80000000) {
 					struct sk_buff *skb;
+#ifdef ZEROCOPY
+					int i;
+#endif /* ZEROCOPY */
 					u16 entry = tx_status; 		/* Implicit truncate */
-					entry >>= 3;
+					entry /= sizeof(struct starfire_tx_desc);
 
 					skb = np->tx_info[entry].skb;
+					np->tx_info[entry].skb = NULL;
 					pci_unmap_single(np->pci_dev,
-							 np->tx_info[entry].mapping,
-							 skb->len, PCI_DMA_TODEVICE);
+									 np->tx_info[entry].first_mapping,
+									 skb_first_frag_len(skb),
+									 PCI_DMA_TODEVICE);
+					np->tx_info[entry].first_mapping = 0;
+
+#ifdef ZEROCOPY
+					for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+						pci_unmap_single(np->pci_dev,
+										 np->tx_info[entry].frag_mapping[i],
+										 skb_shinfo(skb)->frags[i].size,
+										 PCI_DMA_TODEVICE);
+						np->tx_info[entry].frag_mapping[i] = 0;
+					}
+#endif /* ZEROCOPY */
 
 					/* Scavenge the descriptor. */
 					dev_kfree_skb_irq(skb);
-					np->tx_info[entry].skb = NULL;
-					np->tx_info[entry].mapping = 0;
+
 					np->dirty_tx++;
 				}
 				np->tx_done_q[np->tx_done].status = 0;
@@ -977,7 +1236,7 @@
    for clarity and better register allocation. */
 static int netdev_rx(struct net_device *dev)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	u32 desc_status;
 
@@ -1015,7 +1274,7 @@
 #endif
 			/* Check if the packet is long enough to accept without copying
 			   to a minimally-sized skbuff. */
-			if (pkt_len < rx_copybreak
+			if (PKT_SHOULD_COPY(pkt_len)
 				&& (skb = dev_alloc_skb(pkt_len + 2)) != NULL) {
 				skb->dev = dev;
 				skb_reserve(skb, 2);	/* 16 byte align the IP header */
@@ -1037,14 +1296,6 @@
 				temp = skb_put(skb, pkt_len);
 				np->rx_info[entry].skb = NULL;
 				np->rx_info[entry].mapping = 0;
-#ifndef final_version				/* Remove after testing. */
-				if (le32_to_cpu(np->rx_ring[entry].rxaddr & ~3) != ((unsigned long) temp))
-					printk(KERN_ERR "%s: Internal fault: The skbuff addresses "
-						   "do not match in netdev_rx: %d vs. %p / %p.\n",
-						   dev->name,
-						   le32_to_cpu(np->rx_ring[entry].rxaddr),
-						   skb->head, temp);
-#endif
 			}
 #ifndef final_version				/* Remove after testing. */
 			/* You will want this info for the initial debug. */
@@ -1060,9 +1311,24 @@
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
+			 * Maybe I missed something -- corrections are welcome.
+			 * Until then, the printk stays. :-) -Ion
+			 */
+			else if (le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0x00400000) {
+				skb->ip_summed = CHECKSUM_HW;
+				skb->csum = le32_to_cpu(np->rx_done_q[np->rx_done].status2) & 0xffff;
+				printk(KERN_DEBUG "%s: checksum_hw, status2 = %x\n", dev->name, np->rx_done_q[np->rx_done].status2);
+			}
 #endif
 			netif_rx(skb);
 			dev->last_rx = jiffies;
@@ -1107,36 +1373,34 @@
 
 static void netdev_error(struct net_device *dev, int intr_status)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 
-	if (intr_status & LinkChange) {
+	if (intr_status & IntrLinkChange) {
 		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"
 			   " %4.4x  partner %4.4x.\n", dev->name,
 			   mdio_read(dev, np->phys[0], 4),
 			   mdio_read(dev, np->phys[0], 5));
 		check_duplex(dev, 0);
 	}
-	if (intr_status & StatsMax) {
+	if (intr_status & IntrStatsMax) {
 		get_stats(dev);
 	}
 	/* Came close to underrunning the Tx FIFO, increase threshold. */
 	if (intr_status & IntrTxDataLow)
 		writel(++np->tx_threshold, dev->base_addr + TxThreshold);
 	if ((intr_status &
-		 ~(IntrAbnormalSummary|LinkChange|StatsMax|IntrTxDataLow|1)) && debug)
+		 ~(IntrAbnormalSummary|IntrLinkChange|IntrStatsMax|IntrTxDataLow|1)) && debug)
 		printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
 			   dev->name, intr_status);
-	/* Hmmmmm, it's not clear how to recover from PCI faults. */
-	if (intr_status & IntrTxPCIErr)
+	/* Hmmmmm, it's not clear how to recover from DMA faults. */
+	if (intr_status & IntrDMAErr)
 		np->stats.tx_fifo_errors++;
-	if (intr_status & IntrRxPCIErr)
-		np->stats.rx_fifo_errors++;
 }
 
 static struct net_device_stats *get_stats(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 
 	/* This adapter architecture needs no SMP locks. */
 	np->stats.tx_bytes = readl(ioaddr + 0x57010);
@@ -1241,7 +1505,7 @@
 
 static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	u16 *data = (u16 *)&rq->ifr_data;
 
 	switch(cmd) {
@@ -1279,7 +1543,7 @@
 static int netdev_close(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
-	struct netdev_private *np = (struct netdev_private *)dev->priv;
+	struct netdev_private *np = dev->priv;
 	int i;
 
 	netif_stop_queue(dev);
@@ -1305,7 +1569,7 @@
 		for (i = 0; i < 8 /* TX_RING_SIZE is huge! */; i++)
 			printk(KERN_DEBUG " #%d desc. %8.8x %8.8x -> %8.8x.\n",
 				   i, le32_to_cpu(np->tx_ring[i].status),
-				   le32_to_cpu(np->tx_ring[i].addr),
+				   le32_to_cpu(np->tx_ring[i].first_addr),
 				   le32_to_cpu(np->tx_done_q[i].status));
 		printk(KERN_DEBUG "  Rx ring at %8.8x -> %p:\n",
 			   np->rx_ring_dma, np->rx_done_q);
@@ -1331,18 +1595,30 @@
 	}
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		struct sk_buff *skb = np->tx_info[i].skb;
+#ifdef ZEROCOPY
+		int j;
+#endif /* ZEROCOPY */
 		if (skb != NULL) {
 			pci_unmap_single(np->pci_dev,
-					 np->tx_info[i].mapping,
-					 skb->len, PCI_DMA_TODEVICE);
+					 np->tx_info[i].first_mapping,
+					 skb_first_frag_len(skb), PCI_DMA_TODEVICE);
+			np->tx_info[i].first_mapping = 0;
 			dev_kfree_skb(skb);
+			np->tx_info[i].skb = NULL;
+#ifdef ZEROCOPY
+			for (j = 0; j < 6; j++)
+				if (np->tx_info[i].frag_mapping[j]) {
+					pci_unmap_single(np->pci_dev,
+									 np->tx_info[i].frag_mapping[j],
+									 skb_shinfo(skb)->frags[j].size,
+									 PCI_DMA_TODEVICE);
+					np->tx_info[i].frag_mapping[j] = 0;
+				} else
+					break;
+#endif /* ZEROCOPY */
 		}
-		np->tx_info[i].skb = NULL;
-		np->tx_info[i].mapping = 0;
 	}
 
-	MOD_DEC_USE_COUNT;
-
 	return 0;
 }
 
@@ -1359,6 +1635,9 @@
 
 	unregister_netdev(dev);
 	iounmap((char *)dev->base_addr);
+
+	release_mem_region(pci_resource_start (pdev, 0),
+					   pci_resource_len (pdev, 0));
 
 	if (np->tx_done_q)
 		pci_free_consistent(np->pci_dev, PAGE_SIZE,
--- linux-2.4.vanilla/drivers/net/starfire_firmware.pl	Wed Feb  7 17:40:48 2001
+++ linux-2.4-boxter/drivers/net/starfire_firmware.pl	Wed Feb  7 16:22:14 2001
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
