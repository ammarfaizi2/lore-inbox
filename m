Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317440AbSGTQk7>; Sat, 20 Jul 2002 12:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317443AbSGTQk7>; Sat, 20 Jul 2002 12:40:59 -0400
Received: from mta11n.bluewin.ch ([195.186.1.211]:28622 "EHLO
	mta11n.bluewin.ch") by vger.kernel.org with ESMTP
	id <S317440AbSGTQk4>; Sat, 20 Jul 2002 12:40:56 -0400
Date: Sat, 20 Jul 2002 18:43:21 +0200
From: Roger Luethi <rl@hellgate.ch>
To: damsnet@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with via-rhine driver and VT6103 chipset
Message-ID: <20020720164321.GA22754@k3.hellgate.ch>
References: <20020720182044.550f2cf0.damsnet@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020720182044.550f2cf0.damsnet@free.fr>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-rc1 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002 18:20:44 +0200, damsnet@free.fr wrote:
> I would like to report a bug, appearing in kernels 2.4.18 
> to 2.4.19-rc3 (I have not tested with previous ones). 
> 
> It concerns the VIA-Rhine (ethernet) driver. I use it with
> a VT6103 ethernet adaptator, which seems not to be supported
> by the driver, but almost works.
> 
> When I use this driver in 10Mbps mode (not 100Mbps), it resets the
> ethernet card every few seconds and at the ends I have to reboot, 
> because the card does not work anymore. These are the messages
> I see with repetition:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timed out, status 0000, PHY status 786d, resetting...
> [etc, etc, ...]

Try a recent ac kernel (2.4.19rc1-ac6 or later) or the patch below.

Roger

--- drivers/net/bk_11Jul.c	Mon Jul 15 14:53:27 2002
+++ drivers/net/via-rhine.c	Mon Jul 15 14:53:53 2002
@@ -93,7 +93,10 @@
 	- transmit frame queue message is off by one - fixed
 	- adds IntrNormalSummary to "Something Wicked" exclusion list
 	  so normal interrupts will not trigger the message (src: Donald Becker)
-	(Roger Lahti)
+	(Roger Luethi)
+	- show confused chip where to continue after Tx error
+	- location of collision counter is chip specific
+	- allow selecting backoff algorithm (module parameter)
 	- cosmetic cleanups, remove 3 unused members of struct netdev_private
 
 */
@@ -113,6 +116,9 @@ static int max_interrupt_work = 20;
    Setting to > 1518 effectively disables this feature. */
 static int rx_copybreak;
 
+/* Select a backoff algorithm (Ethernet capture effect) */
+static int backoff;
+
 /* Used to pass the media type, etc.
    Both 'options[]' and 'full_duplex[]' should exist for driver
    interoperability.
@@ -215,11 +221,13 @@ MODULE_LICENSE("GPL");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
+MODULE_PARM(backoff, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM_DESC(max_interrupt_work, "VIA Rhine maximum events handled per interrupt");
 MODULE_PARM_DESC(debug, "VIA Rhine debug level (0-7)");
 MODULE_PARM_DESC(rx_copybreak, "VIA Rhine copy breakpoint for copy-only-tiny-frames");
+MODULE_PARM_DESC(backoff, "VIA Rhine: Bits 0-3: backoff algorithm");
 MODULE_PARM_DESC(options, "VIA Rhine: Bits 0-3: media type, bit 17: full duplex");
 MODULE_PARM_DESC(full_duplex, "VIA Rhine full duplex setting(s) (1)");
 
@@ -236,7 +244,8 @@ II. Board-specific settings
 Boards with this chip are functional only in a bus-master PCI slot.
 
 Many operational settings are loaded from the EEPROM to the Config word at
-offset 0x78.  This driver assumes that they are correct.
+offset 0x78. For most of these settings, this driver assumes that they are
+correct.
 If this driver is compiled to use PCI memory space operations the EEPROM
 must be configured to enable memory ops.
 
@@ -388,9 +397,10 @@ enum register_offsets {
 	StickyHW=0x83, WOLcrClr=0xA4, WOLcgClr=0xA7, PwrcsrClr=0xAC,
 };
 
-/* Bits in ConfigD (select backoff algorithm (Ethernet capture effect)) */
+/* Bits in ConfigD */
 enum backoff_bits {
-	BackOpt=0x01, BackAMD=0x02, BackDEC=0x04, BackRandom=0x08
+	BackOptional=0x01, BackModify=0x02,
+	BackCaptureEffect=0x04, BackRandom=0x08
 };
 
 #ifdef USE_MEM
@@ -404,7 +414,7 @@ int mmio_verify_registers[] = {
 /* Bits in the interrupt status/mask registers. */
 enum intr_status_bits {
 	IntrRxDone=0x0001, IntrRxErr=0x0004, IntrRxEmpty=0x0020,
-	IntrTxDone=0x0002, IntrTxAbort=0x0008, IntrTxUnderrun=0x0010,
+	IntrTxDone=0x0002, IntrTxError=0x0008, IntrTxUnderrun=0x0010,
 	IntrPCIErr=0x0040,
 	IntrStatsMax=0x0080, IntrRxEarly=0x0100, IntrMIIChange=0x0200,
 	IntrRxOverflow=0x0400, IntrRxDropped=0x0800, IntrRxNoBuf=0x1000,
@@ -430,24 +440,27 @@ enum mii_status_bits {
 /* The Rx and Tx buffer descriptors. */
 struct rx_desc {
 	s32 rx_status;
-	u32 desc_length;
+	u32 desc_length; /* Chain flag, Buffer/frame length */
 	u32 addr;
 	u32 next_desc;
 };
 struct tx_desc {
 	s32 tx_status;
-	u32 desc_length;
+	u32 desc_length; /* Chain flag, Tx Config, Frame length */
 	u32 addr;
 	u32 next_desc;
 };
 
+/* Initial value for tx_desc.desc_length, Buffer size goes to bits 0-10 */
+#define TXDESC 0x00e08000
+
 enum rx_status_bits {
 	RxOK=0x8000, RxWholePkt=0x0300, RxErr=0x008F
 };
 
-/* Bits in *_desc.status */
+/* Bits in *_desc.*_status */
 enum desc_status_bits {
-	DescOwn=0x80000000, DescEndPacket=0x4000, DescIntr=0x1000,
+	DescOwn=0x80000000
 };
 
 /* Bits in ChipCmd. */
@@ -519,6 +532,7 @@ static struct net_device_stats *via_rhin
 static int via_rhine_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int  via_rhine_close(struct net_device *dev);
 static inline void clear_tally_counters(long ioaddr);
+static inline void via_restart_tx(struct net_device *dev);
 
 static void wait_for_reset(struct net_device *dev, int chip_id, char *name)
 {
@@ -705,6 +719,11 @@ static int __devinit via_rhine_init_one 
 		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
 	}
 
+	/* Select backoff algorithm */
+	if (backoff)
+		writeb(readb(ioaddr + ConfigD) & (0xF0 | backoff),
+			ioaddr + ConfigD);
+
 	dev->irq = pdev->irq;
 
 	np = dev->priv;
@@ -939,7 +958,7 @@ static void alloc_tbufs(struct net_devic
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_skbuff[i] = 0;
 		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		np->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		next += sizeof(struct tx_desc);
 		np->tx_ring[i].next_desc = cpu_to_le32(next);
 		np->tx_buf[i] = &np->tx_bufs[i * PKT_BUF_SZ];
@@ -955,7 +974,7 @@ static void free_tbufs(struct net_device
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		np->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		np->tx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
 		if (np->tx_skbuff[i]) {
 			if (np->tx_skbuff_dma[i]) {
@@ -980,7 +999,7 @@ static void init_registers(struct net_de
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
-	writew(0x0006, ioaddr + PCIBusConfig);	/* Store & forward */
+	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
 	/* Configure initial FIFO thresholds. */
 	writeb(0x20, ioaddr + TxConfig);
 	np->tx_thresh = 0x20;
@@ -995,8 +1014,9 @@ static void init_registers(struct net_de
 	via_rhine_set_rx_mode(dev);
 
 	/* Enable interrupts by setting the interrupt mask. */
-	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow| IntrRxDropped|
-		   IntrTxDone | IntrTxAbort | IntrTxUnderrun |
+	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow |
+		   IntrRxDropped | IntrRxNoBuf | IntrTxAborted |
+		   IntrTxDone | IntrTxError | IntrTxUnderrun |
 		   IntrPCIErr | IntrStatsMax | IntrLinkChange | IntrMIIChange,
 		   ioaddr + IntrEnable);
 
@@ -1239,7 +1259,7 @@ static int via_rhine_start_tx(struct sk_
 	}
 
 	np->tx_ring[entry].desc_length = 
-		cpu_to_le32(0x00E08000 | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
+		cpu_to_le32(TXDESC | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
 
 	/* lock eth irq */
 	spin_lock_irq (&np->lock);
@@ -1291,13 +1311,14 @@ static void via_rhine_interrupt(int irq,
 						   IntrRxWakeUp | IntrRxEmpty | IntrRxNoBuf))
 			via_rhine_rx(dev);
 
-		if (intr_status & (IntrTxDone | IntrTxAbort | IntrTxUnderrun |
+		if (intr_status & (IntrTxDone | IntrTxError | IntrTxUnderrun |
 						   IntrTxAborted))
 			via_rhine_tx(dev);
 
 		/* Abnormal error summary/uncommon events handlers. */
 		if (intr_status & (IntrPCIErr | IntrLinkChange | IntrMIIChange |
-						   IntrStatsMax | IntrTxAbort | IntrTxUnderrun))
+				   IntrStatsMax | IntrTxError | IntrTxAborted |
+				   IntrTxUnderrun))
 			via_rhine_error(dev, intr_status);
 
 		if (--boguscnt < 0) {
@@ -1309,7 +1330,7 @@ static void via_rhine_interrupt(int irq,
 	}
 
 	if (debug > 3)
-		printk(KERN_DEBUG "%s: exiting interrupt, status=%#4.4x.\n",
+		printk(KERN_DEBUG "%s: exiting interrupt, status=%4.4x.\n",
 			   dev->name, readw(ioaddr + IntrStatus));
 }
 
@@ -1325,11 +1346,11 @@ static void via_rhine_tx(struct net_devi
 	/* find and cleanup dirty tx descriptors */
 	while (np->dirty_tx != np->cur_tx) {
 		txstatus = le32_to_cpu(np->tx_ring[entry].tx_status);
-		if (txstatus & DescOwn)
-			break;
 		if (debug > 6)
 			printk(KERN_DEBUG " Tx scavenge %d status %8.8x.\n",
 				   entry, txstatus);
+		if (txstatus & DescOwn)
+			break;
 		if (txstatus & 0x8000) {
 			if (debug > 1)
 				printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
@@ -1339,10 +1360,22 @@ static void via_rhine_tx(struct net_devi
 			if (txstatus & 0x0200) np->stats.tx_window_errors++;
 			if (txstatus & 0x0100) np->stats.tx_aborted_errors++;
 			if (txstatus & 0x0080) np->stats.tx_heartbeat_errors++;
-			if (txstatus & 0x0002) np->stats.tx_fifo_errors++;
+			if (((np->chip_id == VT86C100A) && txstatus & 0x0002) ||
+				(txstatus & 0x0800) || (txstatus & 0x1000)) {
+				np->stats.tx_fifo_errors++;
+				np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
+				break; /* Keep the skb - we try again */
+			}
 			/* Transmitter restarted in 'abnormal' handler. */
 		} else {
-			np->stats.collisions += (txstatus >> 3) & 15;
+			if (np->chip_id == VT86C100A)
+				np->stats.collisions += (txstatus >> 3) & 0x0F;
+			else
+				np->stats.collisions += txstatus & 0x0F;
+			if (debug > 6)
+				printk(KERN_DEBUG "collisions: %1.1x:%1.1x\n",
+					(txstatus >> 3) & 0xF,
+					txstatus & 0xF);
 			np->stats.tx_bytes += np->tx_skbuff[entry]->len;
 			np->stats.tx_packets++;
 		}
@@ -1478,6 +1511,17 @@ static void via_rhine_rx(struct net_devi
 	writew(CmdRxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
 }
 
+static inline void via_restart_tx(struct net_device *dev) {
+	struct netdev_private *np = dev->priv;
+	int entry = np->dirty_tx % TX_RING_SIZE;
+
+	/* We know better than the chip where it should continue */
+	writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
+		   dev->base_addr + TxRingPtr);
+
+	writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+}
+
 static void via_rhine_error(struct net_device *dev, int intr_status)
 {
 	struct netdev_private *np = dev->priv;
@@ -1503,19 +1547,23 @@ static void via_rhine_error(struct net_d
 		np->stats.rx_missed_errors	+= readw(ioaddr + RxMissed);
 		clear_tally_counters(ioaddr);
 	}
-	if (intr_status & IntrTxAbort) {
-		/* Stats counted in Tx-done handler, just restart Tx. */
-		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+	if (intr_status & IntrTxError) {
+		if (debug > 1)
+			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
+				   dev->name, intr_status);
+		via_restart_tx(dev);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)
 			writeb(np->tx_thresh += 0x20, ioaddr + TxConfig);
 		if (debug > 1)
-			printk(KERN_INFO "%s: Transmitter underrun, increasing Tx "
-				   "threshold setting to %2.2x.\n", dev->name, np->tx_thresh);
+			printk(KERN_INFO "%s: Transmitter underrun, Tx "
+				   "threshold now %2.2x.\n",
+				   dev->name, np->tx_thresh);
+		via_restart_tx(dev);
 	}
 	if (intr_status & ~( IntrLinkChange | IntrStatsMax |
- 						 IntrTxAbort | IntrTxAborted | IntrNormalSummary)) {
+ 						 IntrTxError | IntrTxAborted | IntrNormalSummary)) {
 		if (debug > 1)
 			printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
 			   dev->name, intr_status);
