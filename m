Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316568AbSEPDSz>; Wed, 15 May 2002 23:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSEPDSy>; Wed, 15 May 2002 23:18:54 -0400
Received: from mta3n.bluewin.ch ([195.186.1.212]:16685 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S316568AbSEPDSs>;
	Wed, 15 May 2002 23:18:48 -0400
Date: Thu, 16 May 2002 05:13:42 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Message-ID: <20020516031342.GC13388@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is against 2.4.19-pre8.

Patch description (changes over previous patch marked *):
* Recover gracefully from TxAbort (the actual fix, new version)
* Be more quiet about aborts, no need to fill log files or scare people
- Explicitly pick a backoff algorithm (alternative "fix")
* Rename backoff bits
- Remove full_duplex, duplex_lock, and advertising from netdev_private
- Make use of MII register names somewhat more consistent
- Update comment regarding config information at 0x78
- Move comment on *_desc_status where it belongs
* Remove DescEndPacket, DescIntr; unused and hardly correct
- More comment details
* Add TXDESC plus comments for desc_length
* Reverted comment change "Tune configuration???". I am genuinely puzzled
  by that line. It sets "store & forward" in a way that according to the
  documentation is bound to be overriden by the threshold values set
  elsewhere.

Note that the abort recovery piece is down to one additional line of code
compared to vanilla 2.4.19-pre8.

The summary of what happens: when an abort occurs at frame n, the TxRingPtr
has already been upped to n+2. Frame n will have a status indicating an
abort, whereas frame n+1 and following are still owned by the NIC. The
problem is that the NIC forgets about that. When the driver issues a
TxDemand after an abort, the NIC won't go back to update the status for
frame n+1. It will happily continue and send all the remaining frames
starting with n+2. The driver will receive a bunch of interrupts for sent
frames, but it will never again scavenge another slot because the chip
skipped one. Until a time out resets the chip, that is.

With the new patch, we don't break out to retransmit an aborted frame.
Instead we scavenge all finished slots after the aborted one (not that I
think there will be any, but it doesn't hurt to be safe). So once we enter
the error handler, the aborted frame is reaped, and we _know_ what the next
frame we need to have sent is -- we just failed to scavenge it because it's
still owned by the NIC. And that's what we hammer into TxRingPtr. Now
either the NIC was right (hypothetically speaking, it seems to be wrong
always), then the writel() is a nop. Or the NIC was confused, then it's
back on track again.

While TxAbort is the only error I have encountered frequently, it is still
tempting to think that the same problem hits us with other errors as well,
TxUnderrun being the most obvious candidate.

If this patch brings no improvement for the VT86C100A, you may want to
watch the state of the rx/tx descriptors and the associated pointers.

The numbers haven't changed, by the way: I am still seeing about 20% higher
troughput with what is now called BackModify, despite the aborts it
produces. Abort handling and resends are cheap compared to the benefits of
flooding the network with traffic, it seems. YMMV, as always.

Roger

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine.c.2.patch"

--- via-rhine.c.org	Sun May 12 21:53:41 2002
+++ via-rhine.c	Thu May 16 05:04:49 2002
@@ -224,7 +224,8 @@ II. Board-specific settings
 Boards with this chip are functional only in a bus-master PCI slot.
 
 Many operational settings are loaded from the EEPROM to the Config word at
-offset 0x78.  This driver assumes that they are correct.
+offset 0x78. For most of these settings, this driver assumes that they are
+correct.
 If this driver is compiled to use PCI memory space operations the EEPROM
 must be configured to enable memory ops.
 
@@ -376,6 +377,14 @@ enum register_offsets {
 	StickyHW=0x83, WOLcrClr=0xA4, WOLcgClr=0xA7, PwrcsrClr=0xAC,
 };
 
+/* Bits in ConfigD (select backoff algorithm (Ethernet capture effect)) */
+enum backoff_bits {
+	BackOptional=0x01,
+	BackModify=0x02,
+	BackCaptureEffect=0x04,
+	BackRandom=0x08
+};
+
 #ifdef USE_MEM
 /* Registers we check that mmio and reg are the same. */
 int mmio_verify_registers[] = {
@@ -413,24 +422,27 @@ enum mii_status_bits {
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
 
-/* Bits in *_desc.status */
+/* Initial value for tx_desc.desc_length, Buffer size goes to bits 0-10 */
+#define TXDESC 0x00e08000
+
 enum rx_status_bits {
 	RxOK=0x8000, RxWholePkt=0x0300, RxErr=0x008F
 };
 
+/* Bits in *_desc.*_status */
 enum desc_status_bits {
-	DescOwn=0x80000000, DescEndPacket=0x4000, DescIntr=0x1000,
+	DescOwn=0x80000000
 };
 
 /* Bits in ChipCmd. */
@@ -476,13 +488,10 @@ struct netdev_private {
 	u16 chip_cmd;						/* Current setting for ChipCmd */
 
 	/* These values are keep track of the transceiver/media in use. */
-	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
-	unsigned int duplex_lock:1;
 	unsigned int default_port:4;		/* Last dev->if_port value. */
 	u8 tx_thresh, rx_thresh;
 
 	/* MII transceiver section. */
-	u16 advertising;					/* NWay media advertisement */
 	unsigned char phys[MAX_MII_CNT];			/* MII device addresses. */
 	unsigned int mii_cnt;			/* number of MIIs found, but only the first one is used */
 	u16 mii_status;						/* last read MII status */
@@ -693,6 +702,9 @@ static int __devinit via_rhine_init_one 
 		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
 	}
 
+	/* Select backoff algorithm */
+	writeb(readb(ioaddr + ConfigD) & (0xF0 | BackModify), ioaddr + ConfigD);
+
 	dev->irq = pdev->irq;
 
 	np = dev->priv;
@@ -784,7 +796,7 @@ static int __devinit via_rhine_init_one 
 				   (option & 0x300 ? 100 : 10),
 				   (option & 0x220 ? "full" : "half"));
 			if (np->mii_cnt)
-				mdio_write(dev, np->phys[0], 0,
+				mdio_write(dev, np->phys[0], MII_BMCR,
 						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
 						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
 		}
@@ -927,7 +939,7 @@ static void alloc_tbufs(struct net_devic
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_skbuff[i] = 0;
 		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		np->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		next += sizeof(struct tx_desc);
 		np->tx_ring[i].next_desc = cpu_to_le32(next);
 		np->tx_buf[i] = &np->tx_bufs[i * PKT_BUF_SZ];
@@ -943,7 +955,7 @@ static void free_tbufs(struct net_device
 
 	for (i = 0; i < TX_RING_SIZE; i++) {
 		np->tx_ring[i].tx_status = 0;
-		np->tx_ring[i].desc_length = cpu_to_le32(0x00e08000);
+		np->tx_ring[i].desc_length = cpu_to_le32(TXDESC);
 		np->tx_ring[i].addr = cpu_to_le32(0xBADF00D0); /* An invalid address. */
 		if (np->tx_skbuff[i]) {
 			if (np->tx_skbuff_dma[i]) {
@@ -969,8 +981,8 @@ static void init_registers(struct net_de
 
 	/* Initialize other registers. */
 	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
-	/* Configure the FIFO thresholds. */
-	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
+	/* Configure initial FIFO thresholds. */
+	writeb(0x20, ioaddr + TxConfig);
 	np->tx_thresh = 0x20;
 	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */
 
@@ -1029,13 +1041,13 @@ static void mdio_write(struct net_device
 
 	if (phy_id == np->phys[0]) {
 		switch (regnum) {
-		case 0:							/* Is user forcing speed/duplex? */
+		case MII_BMCR:					/* Is user forcing speed/duplex? */
 			if (value & 0x9000)			/* Autonegotiation. */
 				np->mii_if.duplex_lock = 0;
 			else
 				np->mii_if.full_duplex = (value & 0x0100) ? 1 : 0;
 			break;
-		case 4:
+		case MII_ADVERTISE:
 			np->mii_if.advertising = value;
 			break;
 		}
@@ -1227,7 +1239,7 @@ static int via_rhine_start_tx(struct sk_
 	}
 
 	np->tx_ring[entry].desc_length = 
-		cpu_to_le32(0x00E08000 | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
+		cpu_to_le32(TXDESC | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
 
 	/* lock eth irq */
 	spin_lock_irq (&np->lock);
@@ -1492,8 +1504,14 @@ static void via_rhine_error(struct net_d
 		clear_tally_counters(ioaddr);
 	}
 	if (intr_status & IntrTxAbort) {
-		/* Stats counted in Tx-done handler, just restart Tx. */
+		/* No skipping frames we have no results for! Bad chip! */
+		writel(virt_to_bus(&np->tx_ring[np->dirty_tx % TX_RING_SIZE]),
+			   ioaddr + TxRingPtr);
+		/* Prevent hanging on a full queue */
 		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+		if (debug > 1)
+			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
+				   dev->name, intr_status);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)

--HcAYCG3uE/tztfnV--
