Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbTDASm3>; Tue, 1 Apr 2003 13:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbTDASm3>; Tue, 1 Apr 2003 13:42:29 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:24324 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262728AbTDASmN>; Tue, 1 Apr 2003 13:42:13 -0500
Date: Tue, 1 Apr 2003 20:52:58 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Brad Campbell <brad@seme.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: via-rhine problem on EPIAV-1Ghz 2.4.21-pre6
Message-ID: <20030401185258.GC3736@arthur.home>
References: <3E88FA24.7040406@seme.com.au> <20030401042734.GA21273@gtf.org> <3E89171A.8010506@seme.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <3E89171A.8010506@seme.com.au>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2003 at 12:35:38PM +0800, Brad Campbell wrote:
> Jeff Garzik wrote:
> >On Tue, Apr 01, 2003 at 10:32:04AM +0800, Brad Campbell wrote:
> >
> >>G'day all,
> >>I have a problem with the via-rhine on this board timing out.
> >
> >
> >Try booting with "noapic"
> >
> >I have sent via-rhine fixes to Marcelo, hopefully they will appear in -p=
re7
> >
> >	Jeff
> Thanks for the prompt reply Jeff.
>=20
> Tried that, and I don't have apic configured in anyway.
>=20
> Is there somewhere I can grab the patches so I can apply them locally=20
> and test them?

Here's the 2.5 driver backported to 2.4.20, it solved my timeout
problems (with thanks to Roger Luethi). Don't know if the "noapic"
option is still necessary, but it won't hurt anyway.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org


--- net/core/skbuff.c-old	Sat Aug  3 02:39:46 2002
+++ net/core/skbuff.c	Thu Feb 27 14:03:17 2003
@@ -731,6 +731,36 @@
 	return n;
 }
=20
+/**
+ *     skb_pad                 -       zero pad the tail of an skb
+ *     @skb: buffer to pad
+ *     @pad: space to pad
+ *
+ *     Ensure that a buffer is followed by a padding area that is zero
+ *     filled. Used by network drivers which may DMA or transfer data
+ *     beyond the buffer end onto the wire.
+ *
+ *     May return NULL in out of memory cases.
+ */
+=20
+struct sk_buff *skb_pad(struct sk_buff *skb, int pad)
+{
+       struct sk_buff *nskb;
+      =20
+       /* If the skbuff is non linear tailroom is always zero.. */
+       if(skb_tailroom(skb) >=3D pad)
+       {
+               memset(skb->data+skb->len, 0, pad);
+               return skb;
+       }
+      =20
+       nskb =3D skb_copy_expand(skb, skb_headroom(skb), skb_tailroom(skb) =
+ pad, GFP_ATOMIC);
+	kfree_skb(skb);
+       if(nskb)
+               memset(nskb->data+nskb->len, 0, pad);
+       return nskb;
+}     =20
+=20
 /* Trims skb to length len. It can change skb pointers, if "realloc" is 1.
  * If realloc=3D=3D0 and trimming is impossible without change of data,
  * it is BUG().
--- net/netsyms.c-old	Wed Dec 18 12:09:34 2002
+++ net/netsyms.c	Thu Feb 27 14:00:08 2003
@@ -93,6 +93,7 @@
 /* Skbuff symbols. */
 EXPORT_SYMBOL(skb_over_panic);
 EXPORT_SYMBOL(skb_under_panic);
+EXPORT_SYMBOL(skb_pad);
=20
 /* Socket layer registration */
 EXPORT_SYMBOL(sock_register);
--- drivers/net/via-rhine.c-old	Wed Dec 18 12:09:17 2002
+++ drivers/net/via-rhine.c	Fri Feb 28 13:48:41 2003
@@ -98,11 +98,21 @@
  	- location of collision counter is chip specific
  	- allow selecting backoff algorithm (module parameter)
=20
+	LK1.1.15 (jgarzik):
+	- Use new MII lib helper generic_mii_ioctl
+
+	LK1.1.16 (Roger Luethi)
+	- Etherleak fix
+	- Handle Tx buffer underrun
+	- Fix bugs in full duplex handling
+	- New reset code uses "force reset" cmd on Rhine-II
+	- Various clean ups
+
 */
=20
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.1.14"
-#define DRV_RELDATE	"May-3-2002"
+#define DRV_VERSION	"1.1.16"
+#define DRV_RELDATE	"February-15-2003"
=20
=20
 /* A few user-configurable values.
@@ -358,6 +368,8 @@
 #else
 #define RHINE_IOTYPE (PCI_USES_IO  | PCI_USES_MASTER | PCI_ADDR0)
 #endif
+/* Beware of PCI posted writes */
+#define IOSYNC	do { readb(dev->base_addr + StationAddr); } while (0)
=20
 /* directly indexed by enum via_rhine_chips, above */
 static struct via_rhine_chip_info via_rhine_chip_info[] __devinitdata =3D
@@ -392,8 +404,9 @@
 	MIIPhyAddr=3D0x6C, MIIStatus=3D0x6D, PCIBusConfig=3D0x6E,
 	MIICmd=3D0x70, MIIRegAddr=3D0x71, MIIData=3D0x72, MACRegEEcsr=3D0x74,
 	ConfigA=3D0x78, ConfigB=3D0x79, ConfigC=3D0x7A, ConfigD=3D0x7B,
-	RxMissed=3D0x7C, RxCRCErrs=3D0x7E,
-	StickyHW=3D0x83, WOLcrClr=3D0xA4, WOLcgClr=3D0xA7, PwrcsrClr=3D0xAC,
+	RxMissed=3D0x7C, RxCRCErrs=3D0x7E, MiscCmd=3D0x81,
+	StickyHW=3D0x83, IntrStatus2=3D0x84, WOLcrClr=3D0xA4, WOLcgClr=3D0xA7,
+	PwrcsrClr=3D0xAC,
 };
=20
 /* Bits in ConfigD */
@@ -413,27 +426,15 @@
 /* Bits in the interrupt status/mask registers. */
 enum intr_status_bits {
 	IntrRxDone=3D0x0001, IntrRxErr=3D0x0004, IntrRxEmpty=3D0x0020,
-	IntrTxDone=3D0x0002, IntrTxError=3D0x0008, IntrTxUnderrun=3D0x0010,
+	IntrTxDone=3D0x0002, IntrTxError=3D0x0008, IntrTxUnderrun=3D0x0210,
 	IntrPCIErr=3D0x0040,
-	IntrStatsMax=3D0x0080, IntrRxEarly=3D0x0100, IntrMIIChange=3D0x0200,
+	IntrStatsMax=3D0x0080, IntrRxEarly=3D0x0100,
 	IntrRxOverflow=3D0x0400, IntrRxDropped=3D0x0800, IntrRxNoBuf=3D0x1000,
 	IntrTxAborted=3D0x2000, IntrLinkChange=3D0x4000,
 	IntrRxWakeUp=3D0x8000,
 	IntrNormalSummary=3D0x0003, IntrAbnormalSummary=3D0xC260,
-};
-
-/* MII interface, status flags.
-   Not to be confused with the MIIStatus register ... */
-enum mii_status_bits {
-	MIICap100T4			=3D 0x8000,
-	MIICap10100HdFd		=3D 0x7800,
-	MIIPreambleSupr		=3D 0x0040,
-	MIIAutoNegCompleted	=3D 0x0020,
-	MIIRemoteFault		=3D 0x0010,
-	MIICapAutoNeg		=3D 0x0008,
-	MIILink				=3D 0x0004,
-	MIIJabber			=3D 0x0002,
-	MIIExtended			=3D 0x0001
+	IntrTxDescRace=3D0x080000,	/* mapped from IntrStatus2 */
+	IntrTxErrSummary=3D0x082210,
 };
=20
 /* The Rx and Tx buffer descriptors. */
@@ -530,30 +531,45 @@
 static struct net_device_stats *via_rhine_get_stats(struct net_device *dev=
);
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static int  via_rhine_close(struct net_device *dev);
-static inline void clear_tally_counters(long ioaddr);
-static inline void via_restart_tx(struct net_device *dev);
+
+static inline u32 get_intr_status(struct net_device *dev)
+{
+	long ioaddr =3D dev->base_addr;
+	struct netdev_private *np =3D dev->priv;
+	u32 intr_status;
+
+	intr_status =3D readw(ioaddr + IntrStatus);
+	/* On Rhine-II, Bit 3 indicates Tx descriptor write-back race. */
+	if (np->chip_id =3D=3D VT6102)
+		intr_status |=3D readb(ioaddr + IntrStatus2) << 16;
+	return intr_status;
+}
=20
 static void wait_for_reset(struct net_device *dev, int chip_id, char *name)
 {
 	long ioaddr =3D dev->base_addr;
-	int i;
+	int boguscnt =3D 20;
=20
-	/* VT86C100A may need long delay after reset (dlink) */
-	if (chip_id =3D=3D VT86C100A)
-		udelay(100);
+	IOSYNC;
+
+	if (readw(ioaddr + ChipCmd) & CmdReset) {
+		printk(KERN_INFO "%s: Reset not complete yet. "
+			"Trying harder.\n", name);
+
+		/* Rhine-II needs to be forced sometimes */
+		if (chip_id =3D=3D VT6102)
+			writeb(0x40, ioaddr + MiscCmd);
+
+		/* VT86C100A may need long delay after reset (dlink) */
+		/* Seen on Rhine-II as well (rl) */
+		while ((readw(ioaddr + ChipCmd) & CmdReset) && --boguscnt)
+			udelay(5);
+
+	}
=20
-	i =3D 0;
-	do {
-		udelay(5);
-		i++;
-		if(i > 2000) {
-			printk(KERN_ERR "%s: reset did not complete in 10 ms.\n", name);
-			break;
-		}
-	} while(readw(ioaddr + ChipCmd) & CmdReset);
 	if (debug > 1)
-		printk(KERN_INFO "%s: reset finished after %d microseconds.\n",
-			   name, 5*i);
+		printk(KERN_INFO "%s: Reset %s.\n", name,
+			boguscnt ? "succeeded" : "failed");
 }
=20
 #ifdef USE_MEM
@@ -739,21 +755,6 @@
 	if (dev->mem_start)
 		option =3D dev->mem_start;
=20
-	/* The lower four bits are the media type. */
-	if (option > 0) {
-		if (option & 0x200)
-			np->mii_if.full_duplex =3D 1;
-		np->default_port =3D option & 15;
-	}
-	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
-		np->mii_if.full_duplex =3D 1;
-
-	if (np->mii_if.full_duplex) {
-		printk(KERN_INFO "%s: Set to forced full duplex, autonegotiation"
-			   " disabled.\n", dev->name);
-		np->mii_if.force_media =3D 1;
-	}
-
 	/* The chip-specific entries in the device structure. */
 	dev->open =3D via_rhine_open;
 	dev->hard_start_xmit =3D via_rhine_start_tx;
@@ -765,11 +766,27 @@
 	dev->watchdog_timeo =3D TX_TIMEOUT;
 	if (np->drv_flags & ReqTxAlign)
 		dev->features |=3D NETIF_F_SG|NETIF_F_HW_CSUM;
-=09
+
+	/* dev->name not defined before register_netdev()! */
 	i =3D register_netdev(dev);
 	if (i)
 		goto err_out_unmap;
=20
+	/* The lower four bits are the media type. */
+	if (option > 0) {
+		if (option & 0x220)
+			np->mii_if.full_duplex =3D 1;
+		np->default_port =3D option & 15;
+	}
+	if (card_idx < MAX_UNITS  &&  full_duplex[card_idx] > 0)
+		np->mii_if.full_duplex =3D 1;
+
+	if (np->mii_if.full_duplex) {
+		printk(KERN_INFO "%s: Set to forced full duplex, autonegotiation"
+			   " disabled.\n", dev->name);
+		np->mii_if.force_media =3D 1;
+	}
+
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 		   dev->name, via_rhine_chip_info[chip_id].name,
 		   (pci_flags & PCI_USES_IO) ? ioaddr : memaddr);
@@ -794,7 +811,7 @@
 					   mdio_read(dev, phy, 5));
=20
 				/* set IFF_RUNNING */
-				if (mii_status & MIILink)
+				if (mii_status & BMSR_LSTATUS)
 					netif_carrier_on(dev);
 				else
 					netif_carrier_off(dev);
@@ -1005,6 +1022,7 @@
 	writeb(0x20, ioaddr + TxConfig);
 	np->tx_thresh =3D 0x20;
 	np->rx_thresh =3D 0x60;			/* Written in via_rhine_set_rx_mode(). */
+	np->mii_if.full_duplex =3D 0;
=20
 	if (dev->if_port =3D=3D 0)
 		dev->if_port =3D np->default_port;
@@ -1018,7 +1036,7 @@
 	writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow |
 		   IntrRxDropped | IntrRxNoBuf | IntrTxAborted |
 		   IntrTxDone | IntrTxError | IntrTxUnderrun |
-		   IntrPCIErr | IntrStatsMax | IntrLinkChange | IntrMIIChange,
+		   IntrPCIErr | IntrStatsMax | IntrLinkChange,
 		   ioaddr + IntrEnable);
=20
 	np->chip_cmd =3D CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
@@ -1172,8 +1190,8 @@
=20
 	/* make IFF_RUNNING follow the MII status bit "Link established" */
 	mii_status =3D mdio_read(dev, np->phys[0], MII_BMSR);
-	if ( (mii_status & MIILink) !=3D (np->mii_status & MIILink) ) {
-		if (mii_status & MIILink)
+	if ( (mii_status & BMSR_LSTATUS) !=3D (np->mii_status & BMSR_LSTATUS) ) {
+		if (mii_status & BMSR_LSTATUS)
 			netif_carrier_on(dev);
 		else
 			netif_carrier_off(dev);
@@ -1229,6 +1247,7 @@
 {
 	struct netdev_private *np =3D dev->priv;
 	unsigned entry;
+	u32 intr_status;
=20
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
@@ -1236,6 +1255,12 @@
 	/* Calculate the next Tx descriptor entry. */
 	entry =3D np->cur_tx % TX_RING_SIZE;
=20
+	if (skb->len < ETH_ZLEN) {
+		skb =3D skb_padto(skb, ETH_ZLEN);
+		if(skb =3D=3D NULL)
+			return 0;
+	}
+
 	np->tx_skbuff[entry] =3D skb;
=20
 	if ((np->drv_flags & ReqTxAlign) &&
@@ -1272,8 +1297,15 @@
=20
 	/* Non-x86 Todo: explicitly flush cache lines here. */
=20
-	/* Wake the potentially-idle transmit channel. */
-	writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+	/*
+	 * Wake the potentially-idle transmit channel unless errors are
+	 * pending (the ISR must sort them out first).
+	 */
+	intr_status =3D get_intr_status(dev);
+	if ((intr_status & IntrTxErrSummary) =3D=3D 0) {
+		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+	}
+	IOSYNC;
=20
 	if (np->cur_tx =3D=3D np->dirty_tx + TX_QUEUE_LEN)
 		netif_stop_queue(dev);
@@ -1300,38 +1332,51 @@
=20
 	ioaddr =3D dev->base_addr;
 =09
-	while ((intr_status =3D readw(ioaddr + IntrStatus))) {
+	while ((intr_status =3D get_intr_status(dev))) {
 		/* Acknowledge all of the current interrupt sources ASAP. */
+		if (intr_status & IntrTxDescRace)
+			writeb(0x08, ioaddr + IntrStatus2);
 		writew(intr_status & 0xffff, ioaddr + IntrStatus);
+		IOSYNC;
=20
 		if (debug > 4)
-			printk(KERN_DEBUG "%s: Interrupt, status %4.4x.\n",
+			printk(KERN_DEBUG "%s: Interrupt, status %8.8x.\n",
 				   dev->name, intr_status);
=20
 		if (intr_status & (IntrRxDone | IntrRxErr | IntrRxDropped |
 						   IntrRxWakeUp | IntrRxEmpty | IntrRxNoBuf))
 			via_rhine_rx(dev);
=20
-		if (intr_status & (IntrTxDone | IntrTxError | IntrTxUnderrun |
-						   IntrTxAborted))
+		if (intr_status & (IntrTxErrSummary | IntrTxDone)) {
+			if (intr_status & IntrTxErrSummary) {
+				int cnt =3D 20;
+				/* Avoid scavenging before Tx engine turned off */
+				while ((readw(ioaddr+ChipCmd) & CmdTxOn) && --cnt)
+					udelay(5);
+				if (debug > 2 && !cnt)
+					printk(KERN_WARNING "%s: via_rhine_interrupt() "
+						   "Tx engine still on.\n",
+						   dev->name);
+			}
 			via_rhine_tx(dev);
+		}
=20
 		/* Abnormal error summary/uncommon events handlers. */
-		if (intr_status & (IntrPCIErr | IntrLinkChange | IntrMIIChange |
+		if (intr_status & (IntrPCIErr | IntrLinkChange |
 				   IntrStatsMax | IntrTxError | IntrTxAborted |
-				   IntrTxUnderrun))
+				   IntrTxUnderrun | IntrTxDescRace))
 			via_rhine_error(dev, intr_status);
=20
 		if (--boguscnt < 0) {
 			printk(KERN_WARNING "%s: Too much work at interrupt, "
-				   "status=3D0x%4.4x.\n",
+				   "status=3D%#8.8x.\n",
 				   dev->name, intr_status);
 			break;
 		}
 	}
=20
 	if (debug > 3)
-		printk(KERN_DEBUG "%s: exiting interrupt, status=3D%4.4x.\n",
+		printk(KERN_DEBUG "%s: exiting interrupt, status=3D%8.8x.\n",
 			   dev->name, readw(ioaddr + IntrStatus));
 }
=20
@@ -1405,8 +1450,8 @@
 	int boguscnt =3D np->dirty_rx + RX_RING_SIZE - np->cur_rx;
=20
 	if (debug > 4) {
-		printk(KERN_DEBUG " In via_rhine_rx(), entry %d status %8.8x.\n",
-			   entry, le32_to_cpu(np->rx_head_desc->rx_status));
+		printk(KERN_DEBUG "%s: via_rhine_rx(), entry %d status %8.8x.\n",
+			   dev->name, entry, le32_to_cpu(np->rx_head_desc->rx_status));
 	}
=20
 	/* If EOP is set on the next entry, it's a new packet. Send it up. */
@@ -1509,18 +1554,50 @@
 	}
=20
 	/* Pre-emptively restart Rx engine. */
-	writew(CmdRxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+	writew(readw(dev->base_addr + ChipCmd) | CmdRxOn | CmdRxDemand,
+		   dev->base_addr + ChipCmd);
 }
=20
-static inline void via_restart_tx(struct net_device *dev) {
+/* Clears the "tally counters" for CRC errors and missed frames(?).
+   It has been reported that some chips need a write of 0 to clear
+   these, for others the counters are set to 1 when written to and
+   instead cleared when read. So we clear them both ways ... */
+static inline void clear_tally_counters(const long ioaddr)
+{
+	writel(0, ioaddr + RxMissed);
+	readw(ioaddr + RxCRCErrs);
+	readw(ioaddr + RxMissed);
+}
+
+static void via_rhine_restart_tx(struct net_device *dev) {
 	struct netdev_private *np =3D dev->priv;
+	long ioaddr =3D dev->base_addr;
 	int entry =3D np->dirty_tx % TX_RING_SIZE;
+	u32 intr_status;
=20
-	/* We know better than the chip where it should continue */
-	writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
-		   dev->base_addr + TxRingPtr);
+	/*
+	 * If new errors occured, we need to sort them out before doing Tx.
+	 * In that case the ISR will be back here RSN anyway.
+	 */
+	intr_status =3D get_intr_status(dev);
+
+	if ((intr_status & IntrTxErrSummary) =3D=3D 0) {
+
+		/* We know better than the chip where it should continue. */
+		writel(np->tx_ring_dma + entry * sizeof(struct tx_desc),
+			   ioaddr + TxRingPtr);
+
+		writew(CmdTxDemand | np->chip_cmd, ioaddr + ChipCmd);
+		IOSYNC;
+	}
+	else {
+		/* This should never happen */
+		if (debug > 1)
+			printk(KERN_WARNING "%s: via_rhine_restart_tx() "
+				   "Another error occured %8.8x.\n",
+				   dev->name, intr_status);
+	}
=20
-	writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
 }
=20
 static void via_rhine_error(struct net_device *dev, int intr_status)
@@ -1530,7 +1607,7 @@
=20
 	spin_lock (&np->lock);
=20
-	if (intr_status & (IntrMIIChange | IntrLinkChange)) {
+	if (intr_status & (IntrLinkChange)) {
 		if (readb(ioaddr + MIIStatus) & 0x02) {
 			/* Link failed, restart autonegotiation. */
 			if (np->drv_flags & HasDavicomPhy)
@@ -1548,11 +1625,10 @@
 		np->stats.rx_missed_errors	+=3D readw(ioaddr + RxMissed);
 		clear_tally_counters(ioaddr);
 	}
-	if (intr_status & IntrTxError) {
+	if (intr_status & IntrTxAborted) {
 		if (debug > 1)
-			printk(KERN_INFO "%s: Abort %4.4x, frame dropped.\n",
+			printk(KERN_INFO "%s: Abort %8.8x, frame dropped.\n",
 				   dev->name, intr_status);
-		via_restart_tx(dev);
 	}
 	if (intr_status & IntrTxUnderrun) {
 		if (np->tx_thresh < 0xE0)
@@ -1561,15 +1637,21 @@
 			printk(KERN_INFO "%s: Transmitter underrun, Tx "
 				   "threshold now %2.2x.\n",
 				   dev->name, np->tx_thresh);
-		via_restart_tx(dev);
 	}
-	if (intr_status & ~( IntrLinkChange | IntrStatsMax |
- 						 IntrTxError | IntrTxAborted | IntrNormalSummary)) {
+	if (intr_status & IntrTxDescRace) {
+		if (debug > 2)
+			printk(KERN_INFO "%s: Tx descriptor write-back race.\n",
+				   dev->name);
+	}
+	if (intr_status & ( IntrTxAborted | IntrTxUnderrun | IntrTxDescRace ))
+		via_rhine_restart_tx(dev);
+
+	if (intr_status & ~( IntrLinkChange | IntrStatsMax | IntrTxUnderrun |
+ 						 IntrTxError | IntrTxAborted | IntrNormalSummary |
+						 IntrTxDescRace )) {
 		if (debug > 1)
-			printk(KERN_ERR "%s: Something Wicked happened! %4.4x.\n",
-			   dev->name, intr_status);
-		/* Recovery for other fault sources not known. */
-		writew(CmdTxDemand | np->chip_cmd, dev->base_addr + ChipCmd);
+			printk(KERN_ERR "%s: Something Wicked happened! %8.8x.\n",
+				   dev->name, intr_status);
 	}
=20
 	spin_unlock (&np->lock);
@@ -1590,17 +1672,6 @@
 	return &np->stats;
 }
=20
-/* Clears the "tally counters" for CRC errors and missed frames(?).
-   It has been reported that some chips need a write of 0 to clear
-   these, for others the counters are set to 1 when written to and
-   instead cleared when read. So we clear them both ways ... */
-static inline void clear_tally_counters(const long ioaddr)
-{
-	writel(0, ioaddr + RxMissed);
-	readw(ioaddr + RxCRCErrs);
-	readw(ioaddr + RxMissed);
-}
-
 static void via_rhine_set_rx_mode(struct net_device *dev)
 {
 	struct netdev_private *np =3D dev->priv;
@@ -1794,10 +1865,10 @@
=20
=20
 static struct pci_driver via_rhine_driver =3D {
-	name:		"via-rhine",
-	id_table:	via_rhine_pci_tbl,
-	probe:		via_rhine_init_one,
-	remove:		__devexit_p(via_rhine_remove_one),
+	.name		=3D "via-rhine",
+	.id_table	=3D via_rhine_pci_tbl,
+	.probe		=3D via_rhine_init_one,
+	.remove		=3D __devexit_p(via_rhine_remove_one),
 };
=20
=20
--- include/linux/skbuff.h-old	Tue Mar 25 14:23:22 2003
+++ include/linux/skbuff.h	Fri Feb 28 12:48:15 2003
@@ -240,6 +240,7 @@
 						int newheadroom,
 						int newtailroom,
 						int priority);
+extern struct sk_buff *		skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	kfree_skb(a)
 extern void	skb_over_panic(struct sk_buff *skb, int len, void *here);
 extern void	skb_under_panic(struct sk_buff *skb, int len, void *here);
@@ -1079,6 +1080,26 @@
 	if (delta || skb_cloned(skb))
 		return pskb_expand_head(skb, (delta+15)&~15, 0, GFP_ATOMIC);
 	return 0;
+}
+
+/**
+ *     skb_padto       - pad an skbuff up to a minimal size
+ *     @skb: buffer to pad
+ *     @len: minimal length
+ *
+ *     Pads up a buffer to ensure the trailing bytes exist and are
+ *     blanked. If the buffer already contains sufficient data it
+ *     is untouched. Returns the buffer, which may be a replacement
+ *     for the original, or NULL for out of memory - in which case
+ *     the original buffer is still freed.
+ */
+=20
+static inline struct sk_buff *skb_padto(struct sk_buff *skb, unsigned int =
len)
+{
+       unsigned int size =3D skb->len + skb->data_len;
+       if(likely(size >=3D len))
+               return skb;
+       return skb_pad(skb, len-size);
 }
=20
 /**

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ieAK/PlVHJtIto0RAtTaAJ9LvaT6id1jvB5KakLFetggVF2cUgCfd+S+
rEIKsaJ+ZhYB176ufJlWq+s=
=gIIs
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
