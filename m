Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSENDyF>; Mon, 13 May 2002 23:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315169AbSENDyE>; Mon, 13 May 2002 23:54:04 -0400
Received: from [195.186.1.212] ([195.186.1.212]:45169 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S315168AbSENDyC>;
	Mon, 13 May 2002 23:54:02 -0400
Date: Tue, 14 May 2002 05:53:18 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] VIA Rhine stalls: TxAbort handling
Message-ID: <20020514035318.GA20088@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.8-ac9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't know how many time-out problems exist in via-rhine.c, but the patch
below fixes at least one of them. It works for my VT6102 based card. I hope
some of you can confirm the fix (or let me know what other chips I broke).

Here's the error message the patch addresses:
Transmit timed out, status 0000, PHY status 782d, resetting...

The patch is slightly experimental and contains some changes and clean-ups
that are not directly related to the time out problem.

Patch description:
- Recover gracefully from TxAbort (the actual fix)
- Explicitly pick a backoff algorithm (alternative "fix")
- Remove full_duplex, duplex_lock, and advertising from netdev_private
- Make use of MII register names somewhat more consistent
- Update comment regarding config information at 0x78
- Move comment on *_desc_status where it belongs
- More comment details

Some information on stalling:

The time outs happened because the driver's handling of TxAbort was
incomplete: The transfer didn't get restarted. My initial fix was to
prevent TxAbort -- clearing bit 1 of ConfigD did the trick for me. The
stalling effect was gone.

The simple reason: The AMD backoff algorithm always triggered TxAborts,
the others didn't.

However, once I had the driver recover from TxAbort without waiting for the
time out reset, the AMD solution provided over 20% higher throughput than
the DEC algorithm. YMMV, depending on the specific setup. I'd vote for a
module parameter. For now, I hardcoded AMD: it's what the eeprom picks when
reloaded. Also, every other algorithm masked the TxAbort problem (by not
triggering any).

Incidentally, the VIA drivers clear bits 0-3 and set bit 3 of TxConfig for
all chips (the latter supposedly deals with backoff algorithms, too, but
it didn't seem to make a measurable difference on my system).

Patch is against 2.4.19-pre8. Feedback welcome.

Roger

--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine.c.patch"

--- via-rhine.c.org	Sun May 12 21:53:41 2002
+++ via-rhine.c	Tue May 14 05:33:06 2002
@@ -224,7 +224,8 @@
 Boards with this chip are functional only in a bus-master PCI slot.
 
 Many operational settings are loaded from the EEPROM to the Config word at
-offset 0x78.  This driver assumes that they are correct.
+offset 0x78. For most of these settings, this driver assumes that they are
+correct.
 If this driver is compiled to use PCI memory space operations the EEPROM
 must be configured to enable memory ops.
 
@@ -376,6 +377,11 @@
 	StickyHW=0x83, WOLcrClr=0xA4, WOLcgClr=0xA7, PwrcsrClr=0xAC,
 };
 
+/* Bits in ConfigD (select backoff algorithm (Ethernet capture effect)) */
+enum backoff_bits {
+	BackOpt=0x01, BackAMD=0x02, BackDEC=0x04, BackRandom=0x08
+};
+
 #ifdef USE_MEM
 /* Registers we check that mmio and reg are the same. */
 int mmio_verify_registers[] = {
@@ -424,11 +430,11 @@
 	u32 next_desc;
 };
 
-/* Bits in *_desc.status */
 enum rx_status_bits {
 	RxOK=0x8000, RxWholePkt=0x0300, RxErr=0x008F
 };
 
+/* Bits in *_desc.status */
 enum desc_status_bits {
 	DescOwn=0x80000000, DescEndPacket=0x4000, DescIntr=0x1000,
 };
@@ -476,13 +482,10 @@
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
@@ -693,6 +696,9 @@
 		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
 	}
 
+	/* Select backoff algorithm */
+	writeb(readb(ioaddr + ConfigD) & (0xF0 | BackAMD), ioaddr + ConfigD);
+
 	dev->irq = pdev->irq;
 
 	np = dev->priv;
@@ -784,7 +790,7 @@
 				   (option & 0x300 ? 100 : 10),
 				   (option & 0x220 ? "full" : "half"));
 			if (np->mii_cnt)
-				mdio_write(dev, np->phys[0], 0,
+				mdio_write(dev, np->phys[0], MII_BMCR,
 						   ((option & 0x300) ? 0x2000 : 0) |  /* 100mbps? */
 						   ((option & 0x220) ? 0x0100 : 0));  /* Full duplex? */
 		}
@@ -968,9 +974,9 @@
 		writeb(dev->dev_addr[i], ioaddr + StationAddr + i);
 
 	/* Initialize other registers. */
-	writew(0x0006, ioaddr + PCIBusConfig);	/* Tune configuration??? */
-	/* Configure the FIFO thresholds. */
-	writeb(0x20, ioaddr + TxConfig);	/* Initial threshold 32 bytes */
+	writew(0x0006, ioaddr + PCIBusConfig);	/* Store & forward */
+	/* Configure initial FIFO thresholds. */
+	writeb(0x20, ioaddr + TxConfig);
 	np->tx_thresh = 0x20;
 	np->rx_thresh = 0x60;			/* Written in via_rhine_set_rx_mode(). */
 
@@ -1029,13 +1035,13 @@
 
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
@@ -1325,7 +1331,12 @@
 			np->stats.tx_errors++;
 			if (txstatus & 0x0400) np->stats.tx_carrier_errors++;
 			if (txstatus & 0x0200) np->stats.tx_window_errors++;
-			if (txstatus & 0x0100) np->stats.tx_aborted_errors++;
+			if (txstatus & 0x0100) {
+				np->stats.tx_aborted_errors++;
+				np->tx_ring[entry].tx_status = cpu_to_le32(DescOwn);
+				writel(virt_to_bus(&np->tx_ring[entry]), dev->base_addr + TxRingPtr);
+				break; /* Keep the skb for retry */
+			}
 			if (txstatus & 0x0080) np->stats.tx_heartbeat_errors++;
 			if (txstatus & 0x0002) np->stats.tx_fifo_errors++;
 			/* Transmitter restarted in 'abnormal' handler. */
@@ -1492,8 +1503,11 @@
 		clear_tally_counters(ioaddr);
 	}
 	if (intr_status & IntrTxAbort) {
-		/* Stats counted in Tx-done handler, just restart Tx. */
-		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+		/* Prepared in via_rhine_tx(), now kick-start Tx */
+		writew(CmdTxOn | np->chip_cmd, dev->base_addr + ChipCmd);
+		writeb(CmdTxDemand | readb(dev->base_addr + ChipCmd) , dev->base_addr + ChipCmd);
+		printk(KERN_ERR "%s: ABORT %4.4x.\n",
+			   dev->name, intr_status);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)

--neYutvxvOLaeuPCA--
