Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270295AbRHNEWw>; Tue, 14 Aug 2001 00:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270422AbRHNEWk>; Tue, 14 Aug 2001 00:22:40 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:41442 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S270295AbRHNEWY>;
	Tue, 14 Aug 2001 00:22:24 -0400
Message-ID: <3B78A85C.A95AD0DD@sun.com>
Date: Mon, 13 Aug 2001 21:26:04 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, Manfred Spraul <manfred@colorfullife.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com, alan@redhat.com
Subject: Re: [PATCH} NatSemi ethernet - largish
In-Reply-To: <3B70A9DB.826B3054@sun.com>
Content-Type: multipart/mixed;
 boundary="------------441AFA254E9AE63163F4DF9D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------441AFA254E9AE63163F4DF9D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hey gang, not be a pest but...

Another release kernel has come and gone with a severely broken NatSemi
driver.  Attached here is the same patch I sent you guys before (change
listing below).  The first two listings combined are this patch, the third
is the ethtool patch (also attached).

It would be super if we could push these changes into the mainline kernel
ASAP - I know the magic registers thing is causing problems...

> 1) As discussed with Andrew and Jeff: a generic wake-on-lan API for
> ethtool.  A simple struct, 2 ETHTOOL sub-ioctls, and some bitmasks.
> 
> 2) A largish patch against natsemi.c implementing several things.
> * increase the HW timeout to be long enough for an EEPROM reload
> * add several register names
> * add several bit-names for registers
> * remove the wake-on-lan interrupt from the default "on" list
> * call netif_carrier_off if we are not currently opened
> * force an EEPROM reload on a chip reset - some systems have trouble
> loading the EEPROM initially due to the dp83815 starting at voltage < 3.0v
> * ALWAYS set the magic registers
> * decrease maxdma to 256 - makes "Something Wicked" stop happening on
> ServerWorks.
> * Add support for ETHTOOL_GSET and ETHTOOL_SSET
> * Add support for new wake-on-lan ethtools (ETHTOOL_GWOL, ETHTOOL_SWOL)
> * only halt the chip if wake-on-lan is not enabled
> 
> 3) A patch against ethtool-1.2 implementing wake-on-lan support
> * bump version to 1.3
> * compile with -Wall
> * updated man page
> * added cmdline opts for wol and sopass
> * minor restructuring to make it easier

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------441AFA254E9AE63163F4DF9D
Content-Type: text/plain; charset=us-ascii;
 name="natsemi+ethtool+wol.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="natsemi+ethtool+wol.diff"

diff -ruN dist+patches-2.4.8/drivers/net/natsemi.c cobalt-2.4.8/drivers/net/natsemi.c
--- dist+patches-2.4.8/drivers/net/natsemi.c	Tue Jul 17 18:53:55 2001
+++ cobalt-2.4.8/drivers/net/natsemi.c	Mon Aug 13 16:42:04 2001
@@ -60,16 +60,20 @@
 			 from Myrio Corporation, Greg Smith]
 		* suspend/resume
 
+	version 1.0.8 (Tim Hockin <thockin@sun.com>)
+		* ETHTOOL_* support
+		* Wake on lan support (Erik Gilling)
+		* MXDMA fixes for serverworks
+		* EEPROM reload
 	TODO:
 	* big endian support with CFG:BEM instead of cpu_to_le32
 	* support for an external PHY
 	* flow control
-	* Wake-On-LAN
 */
 
 #define DRV_NAME	"natsemi"
-#define DRV_VERSION	"1.07+LK1.0.7"
-#define DRV_RELDATE	"May 18, 2001"
+#define DRV_VERSION	"1.07+LK1.0.8"
+#define DRV_RELDATE	"Aug 07, 2001"
 
 
 /* Updated to recommendations in pci-skeleton v2.03. */
@@ -125,7 +129,7 @@
 /* Time in jiffies before concluding the transmitter is hung. */
 #define TX_TIMEOUT  (2*HZ)
 
-#define NATSEMI_HW_TIMEOUT	200
+#define NATSEMI_HW_TIMEOUT	400
 
 #define PKT_BUF_SZ		1536			/* Size of each temporary Rx buffer.*/
 
@@ -302,18 +306,30 @@
 	WOLCmd=0x40, PauseCmd=0x44, RxFilterAddr=0x48, RxFilterData=0x4C,
 	BootRomAddr=0x50, BootRomData=0x54, SiliconRev=0x58, StatsCtrl=0x5C,
 	StatsData=0x60, RxPktErrs=0x60, RxMissed=0x68, RxCRCErrs=0x64,
-	PCIPM=0x44, PhyStatus=0xC0, MIntrCtrl=0xC4, MIntrStatus=0xC8,
+	BasicControl=0x80, BasicStatus=0x84,
+	AnegAdv=0x90, AnegPeer = 0x94, PhyStatus=0xC0, MIntrCtrl=0xC4, 
+	MIntrStatus=0xC8, PhyCtrl=0xE4,
 
-	/* These are from the spec, around page 78... on a separate table. */
+	/* These are from the spec, around page 78... on a separate table.
+	 * The meaning of these registers depend on the value of PGSEL. */
 	PGSEL=0xCC, PMDCSR=0xE4, TSTDAT=0xFC, DSPCFG=0xF4, SDCFG=0x8C
 };
 
+/* misc PCI space registers */
+enum PCISpaceRegs {
+	PCIPM=0x44,
+};
+
 /* Bit in ChipCmd. */
 enum ChipCmdBits {
 	ChipReset=0x100, RxReset=0x20, TxReset=0x10, RxOff=0x08, RxOn=0x04,
 	TxOff=0x02, TxOn=0x01,
 };
 
+enum PCIBusCfgBits {
+	EepromReload=0x4,
+};
+
 /* Bits in the interrupt status/mask registers. */
 enum intr_status_bits {
 	IntrRxDone=0x0001, IntrRxIntr=0x0002, IntrRxErr=0x0004, IntrRxEarly=0x0008,
@@ -324,7 +340,7 @@
 	WOLPkt=0x2000,
 	RxResetDone=0x1000000, TxResetDone=0x2000000,
 	IntrPCIErr=0x00f00000,
-	IntrNormalSummary=0x0251, IntrAbnormalSummary=0xED20,
+	IntrNormalSummary=0x025f, IntrAbnormalSummary=0xCD20,
 };
 
 /* Bits in the RxMode register. */
@@ -335,6 +351,34 @@
 	AcceptAllPhys=0x10000000, AcceptMyPhys=0x08000000,
 };
 
+/* Bits in WOLCmd register. */
+enum wol_bits {
+	WakePhy=0x1, WakeUnicast=0x2, WakeMulticast=0x4, WakeBroadcast=0x8,
+	WakeArp=0x10, WakePMatch0=0x20, WakePMatch1=0x40, WakePMatch2=0x80,
+	WakePMatch3=0x100, WakeMagic=0x200, WakeMagicSecure=0x400, 
+	SecureHack=0x100000, WokePhy=0x400000, WokeUnicast=0x800000, 
+	WokeMulticast=0x1000000, WokeBroadcast=0x2000000, WokeArp=0x4000000,
+	WokePMatch0=0x8000000, WokePMatch1=0x10000000, WokePMatch2=0x20000000,
+	WokePMatch3=0x40000000, WokeMagic=0x80000000, WakeOptsSummary=0x7ff
+};
+
+enum aneg_bits {
+	Aneg10BaseT=0x20, Aneg10BaseTFull=0x40, 
+	Aneg100BaseT=0x80, Aneg100BaseTFull=0x100,
+};
+
+enum config_bits {
+	CfgPhyDis=0x200, CfgPhyRst=0x400, CfgAnegEnable=0x2000,
+	CfgAneg100=0x4000, CfgAnegFull=0x8000, CfgAnegDone=0x8000000,
+	CfgFullDuplex=0x20000000,
+	CfgSpeed100=0x40000000, CfgLink=0x80000000,
+};
+
+enum bmcr_bits {
+	BMCRDuplex=0x100, BMCRAnegRestart=0x200, BMCRAnegEnable=0x1000,
+	BMCRSpeed=0x2000, BMCRPhyReset=0x8000,
+};
+
 /* The Rx and Tx buffer descriptors. */
 /* Note that using only 32 bit fields simplifies conversion to big-endian
    architectures. */
@@ -408,6 +452,12 @@
 static void __get_stats(struct net_device *dev);
 static struct net_device_stats *get_stats(struct net_device *dev);
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+static int netdev_set_wol(struct net_device *dev, u32 newval);
+static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 *cur);
+static int netdev_set_sopass(struct net_device *dev, u8 *newval);
+static int netdev_get_sopass(struct net_device *dev, u8 *data);
+static int netdev_get_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd);
+static int netdev_set_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd);
 static int  netdev_close(struct net_device *dev);
 
 
@@ -530,6 +580,7 @@
 		pci_set_drvdata(pdev, NULL);
 		return i;
 	}
+	netif_carrier_off(dev);
 
 	printk(KERN_INFO "%s: %s at 0x%lx, ",
 		   dev->name, natsemi_pci_info[chip_idx].name, ioaddr);
@@ -548,7 +599,8 @@
 			   chip_config & 0x8000 ? "full" : "half");
 	}
 	printk(KERN_INFO "%s: Transceiver status 0x%4.4x advertising %4.4x.\n",
-		   dev->name, (int)readl(ioaddr + 0x84), np->advertising);
+		   dev->name, (int)readl(ioaddr + BasicStatus), 
+		   np->advertising);
 
 	return 0;
 }
@@ -617,7 +669,7 @@
 static int mdio_read(struct net_device *dev, int phy_id, int location)
 {
 	if (phy_id == 1 && location < 32)
-		return readl(dev->base_addr + 0x80 + (location<<2)) & 0xffff;
+		return readl(dev->base_addr+BasicControl+(location<<2))&0xffff;
 	else
 		return 0xffff;
 }
@@ -639,6 +691,20 @@
 		printk(KERN_DEBUG "%s: reset completed in %d usec.\n",
 		   dev->name, i*5);
 	}
+
+	writel(EepromReload, dev->base_addr + PCIBusCfg);
+	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
+		if (!(readl(dev->base_addr + PCIBusCfg) & EepromReload))
+			break;
+		udelay(5);
+	}
+	if (i==NATSEMI_HW_TIMEOUT && debug) {
+		printk(KERN_INFO "%s: EEPROM did not reload in %d usec.\n",
+		   dev->name, i*5);
+	} else if (debug > 2) {
+		printk(KERN_DEBUG "%s: EEPROM reloaded in %d usec.\n",
+		   dev->name, i*5);
+	}
 }
 
 
@@ -733,23 +799,20 @@
 	if (debug > 4)
 		printk(KERN_DEBUG "%s: found silicon revision %xh.\n",
 				dev->name, readl(ioaddr + SiliconRev));
+
 	/* On page 78 of the spec, they recommend some settings for "optimum
 	   performance" to be done in sequence.  These settings optimize some
-	   of the 100Mbit autodetection circuitry.  Also, we only want to do
-	   this for rev C of the chip.
-
-	   There seems to be a typo on page 78, but there isn't.  The fixup 
-	   should be performed for "DP83815CVNG (SRR = 203h)", which is a 
-	   pretty old rev.  This is not to be confused with 302h, which is 
-	   current.  Confirmed with engineers at NSC.
+	   of the 100Mbit autodetection circuitry.  They say we only want to 
+	   do this for rev C of the chip, but engineers at NSC (Bradley 
+	   Kennedy) recommends always setting them.  If you don't, you get 
+	   errors on some autonegotiations that make the device unusable.
 	*/
-	if (readl(ioaddr + SiliconRev) == 0x203) {
-		writew(0x0001, ioaddr + PGSEL);
-		writew(0x189C, ioaddr + PMDCSR);
-		writew(0x0000, ioaddr + TSTDAT);
-		writew(0x5040, ioaddr + DSPCFG);
-		writew(0x008C, ioaddr + SDCFG);
-	}
+	writew(0x0001, ioaddr + PGSEL);
+	writew(0x189C, ioaddr + PMDCSR);
+	writew(0x0000, ioaddr + TSTDAT);
+	writew(0x5040, ioaddr + DSPCFG);
+	writew(0x008C, ioaddr + SDCFG);
+	writew(0x0000, ioaddr + PGSEL);
 
 	/* Enable PHY Specific event based interrupts.  Link state change
 	   and Auto-Negotiation Completion are among the affected.
@@ -774,16 +837,16 @@
 
 	/* DRTH: 2: start tx if 64 bytes are in the fifo
 	 * FLTH: 0x10: refill with next packet if 512 bytes are free
-	 * MXDMA: 0: up to 512 byte bursts.
+	 * MXDMA: 0: up to 256 byte bursts.
 	 * 	MXDMA must be <= FLTH
 	 * ECRETRY=1
 	 * ATP=1
 	 */
-	np->tx_config = 0x10801002;
+	np->tx_config = 0x10f01002;
 	/* DRTH 0x10: start copying to memory if 128 bytes are in the fifo
-	 * MXDMA 0: up to 512 byte bursts
+	 * MXDMA 0: up to 256 byte bursts
 	 */
-	np->rx_config = 0x0020;
+	np->rx_config = 0x700020;
 	writel(np->tx_config, ioaddr + TxConfig);
 	writel(np->rx_config, ioaddr + RxConfig);
 
@@ -800,11 +863,11 @@
 	__set_rx_mode(dev);
 
 	/* Enable interrupts by setting the interrupt mask. */
-	writel(IntrNormalSummary | IntrAbnormalSummary | 0x1f, ioaddr + IntrMask);
+	writel(IntrNormalSummary | IntrAbnormalSummary, ioaddr + IntrMask);
 	writel(1, ioaddr + IntrEnable);
 
 	writel(RxOn | TxOn, ioaddr + ChipCmd);
-	writel(4, ioaddr + StatsCtrl); 					/* Clear Stats */
+	writel(4, ioaddr + StatsCtrl); /* Clear Stats */
 }
 
 static void netdev_timer(unsigned long data)
@@ -1190,7 +1253,8 @@
 	if (intr_status & LinkChange) {
 		printk(KERN_NOTICE "%s: Link changed: Autonegotiation advertising"
 			   " %4.4x  partner %4.4x.\n", dev->name,
-			   (int)readl(ioaddr + 0x90), (int)readl(ioaddr + 0x94));
+			   (int)readl(ioaddr + AnegAdv), 
+			   (int)readl(ioaddr + AnegPeer));
 		/* read MII int status to clear the flag */
 		readw(ioaddr + MIntrStatus);
 		check_link(dev);
@@ -1208,7 +1272,7 @@
 	}
 	if (intr_status & WOLPkt) {
 		int wol_status = readl(ioaddr + WOLCmd);
-		printk(KERN_NOTICE "%s: Link wake-up event %8.8x",
+		printk(KERN_NOTICE "%s: Link wake-up event %8.8x\n",
 			   dev->name, wol_status);
 	}
 	if ((intr_status & ~(LinkChange|StatsMax|RxResetDone|TxResetDone|0xA7ff))
@@ -1230,7 +1294,7 @@
 
 	/* The chip only need report frame silently dropped. */
 	np->stats.rx_crc_errors	+= readl(ioaddr + RxCRCErrs);
-	np->stats.rx_missed_errors	+= readl(ioaddr + RxMissed);
+	np->stats.rx_missed_errors += readl(ioaddr + RxMissed);
 }
 
 static struct net_device_stats *get_stats(struct net_device *dev)
@@ -1349,12 +1413,12 @@
 static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
 {
 	struct netdev_private *np = dev->priv;
-	u32 ethcmd;
+	struct ethtool_cmd ecmd;
 		
-	if (copy_from_user(&ethcmd, useraddr, sizeof(ethcmd)))
+	if (copy_from_user(&ecmd, useraddr, sizeof(ecmd)))
 		return -EFAULT;
 
-        switch (ethcmd) {
+        switch (ecmd.cmd) {
         case ETHTOOL_GDRVINFO: {
 		struct ethtool_drvinfo info = {ETHTOOL_GDRVINFO};
 		strcpy(info.driver, DRV_NAME);
@@ -1364,12 +1428,257 @@
 			return -EFAULT;
 		return 0;
 	}
+	case ETHTOOL_GSET: {
+		spin_lock_irq(&np->lock);
+		netdev_get_ecmd(dev, &ecmd);
+		spin_unlock_irq(&np->lock);
+		if (copy_to_user(useraddr, &ecmd, sizeof(ecmd)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_SSET: {
+		int r;
+		if (copy_from_user(&ecmd, useraddr, sizeof(ecmd)))
+			return -EFAULT;
+		spin_lock_irq(&np->lock);
+		r = netdev_set_ecmd(dev, &ecmd);
+		spin_unlock_irq(&np->lock);
+		return r;
+	}
+	case ETHTOOL_GWOL: {
+		struct ethtool_wolinfo wol = {ETHTOOL_GWOL};
+		spin_lock_irq(&np->lock);
+		netdev_get_wol(dev, &wol.supported, &wol.wolopts);
+		netdev_get_sopass(dev, wol.sopass);
+		spin_unlock_irq(&np->lock);
+		if (copy_to_user(useraddr, &wol, sizeof(wol)))
+			return -EFAULT;
+		return 0;
+	}
+	case ETHTOOL_SWOL: {
+		struct ethtool_wolinfo wol;
+		int r;
+		if (copy_from_user(&wol, useraddr, sizeof(wol)))
+			return -EFAULT;
+		spin_lock_irq(&np->lock);
+		netdev_set_wol(dev, wol.wolopts);
+		r = netdev_set_sopass(dev, wol.sopass);
+		spin_unlock_irq(&np->lock);
+		return r;
+	}
 
         }
 	
 	return -EOPNOTSUPP;
 }
 
+static int netdev_set_wol(struct net_device *dev, u32 newval)
+{
+	u32 data = readl(dev->base_addr + WOLCmd) & ~WakeOptsSummary;
+
+	/* translate to bitmasks this chip understands */
+	if (newval & WAKE_PHY)
+		data |= WakePhy;
+	if (newval & WAKE_UCAST)
+		data |= WakeUnicast;
+	if (newval & WAKE_MCAST)
+		data |= WakeMulticast;
+	if (newval & WAKE_BCAST)
+		data |= WakeBroadcast;
+	if (newval & WAKE_ARP)
+		data |= WakeArp;
+	if (newval & WAKE_MAGIC)
+		data |= WakeMagic;
+	if (newval & WAKE_MAGICSECURE)
+		data |= WakeMagicSecure;
+
+	writel(data, dev->base_addr + WOLCmd);
+
+	/* should we burn these into the EEPROM? */
+	
+	return 0;
+}
+
+static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 *cur)
+{
+	u32 regval = readl(dev->base_addr + WOLCmd);
+
+	*supported = (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST 
+			| WAKE_ARP | WAKE_MAGIC | WAKE_MAGICSECURE);
+	*cur = 0;
+	/* translate from chip bitmasks */
+	if (regval & 0x1)
+		*cur |= WAKE_PHY;
+	if (regval & 0x2)
+		*cur |= WAKE_UCAST;
+	if (regval & 0x4)
+		*cur |= WAKE_MCAST;
+	if (regval & 0x8)
+		*cur |= WAKE_BCAST;
+	if (regval & 0x10)
+		*cur |= WAKE_ARP;
+	if (regval & 0x200)
+		*cur |= WAKE_MAGIC;
+	if (regval & 0x400)
+		*cur |= WAKE_MAGICSECURE;
+
+	return 0;
+}
+
+static int netdev_set_sopass(struct net_device *dev, u8 *newval)
+{
+	u16 *sval = (u16 *)newval;
+	u32 addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
+
+	/* enable writing to these registers by disabling the RX filter */
+	addr &= ~0x80000000;
+	writel(addr, dev->base_addr + RxFilterAddr);
+
+	/* write the three words to (undocumented) RFCR vals 0xa, 0xc, 0xe */
+	writel(addr | 0xa, dev->base_addr + RxFilterAddr);
+	writew(sval[0], dev->base_addr + RxFilterData);
+
+	writel(addr | 0xc, dev->base_addr + RxFilterAddr);
+	writew(sval[1], dev->base_addr + RxFilterData);
+	
+	writel(addr | 0xe, dev->base_addr + RxFilterAddr);
+	writew(sval[2], dev->base_addr + RxFilterData);
+	
+	/* re-enable the RX filter */
+	writel(addr | 0x80000000, dev->base_addr + RxFilterAddr);
+
+	/* should we burn this into the EEPROM? */
+
+	return 0;
+}
+
+static int netdev_get_sopass(struct net_device *dev, u8 *data)
+{
+	u16 *sval = (u16 *)data;
+	u32 addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
+
+	/* read the three words from (undocumented) RFCR vals 0xa, 0xc, 0xe */
+	writel(addr | 0xa, dev->base_addr + RxFilterAddr);
+	sval[0] = readw(dev->base_addr + RxFilterData);
+
+	writel(addr | 0xc, dev->base_addr + RxFilterAddr);
+	sval[1] = readw(dev->base_addr + RxFilterData);
+	
+	writel(addr | 0xe, dev->base_addr + RxFilterAddr);
+	sval[2] = readw(dev->base_addr + RxFilterData);
+	
+	return 0;
+}
+
+static int netdev_get_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	u32 tmp;
+
+	ecmd->supported = 
+		(SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
+		SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
+		SUPPORTED_Autoneg | SUPPORTED_TP);
+	
+	/* only supports twisted-pair */
+	ecmd->port = PORT_TP;
+
+	/* only supports internal transceiver */
+	ecmd->transceiver = XCVR_INTERNAL;
+
+	/* this isn't fully supported at higher layers */
+	ecmd->phy_address = readw(dev->base_addr + PhyCtrl) & 0xf;
+
+	tmp = readl(dev->base_addr + AnegAdv);
+	ecmd->advertising = ADVERTISED_TP;
+	if (tmp & Aneg10BaseT)
+		ecmd->advertising |= ADVERTISED_10baseT_Half;
+	if (tmp & Aneg10BaseTFull)
+		ecmd->advertising |= ADVERTISED_10baseT_Full;
+	if (tmp & Aneg100BaseT)
+		ecmd->advertising |= ADVERTISED_100baseT_Half;
+	if (tmp & Aneg100BaseTFull)
+		ecmd->advertising |= ADVERTISED_100baseT_Full;
+
+	tmp = readl(dev->base_addr + ChipConfig);
+	if (tmp & CfgAnegEnable) {
+		ecmd->advertising |= ADVERTISED_Autoneg;
+		ecmd->autoneg = AUTONEG_ENABLE;
+	} else {
+		ecmd->autoneg = AUTONEG_DISABLE;
+	}
+
+	if (tmp & CfgSpeed100) {
+		ecmd->speed = SPEED_100;
+	} else {
+		ecmd->speed = SPEED_10;
+	}
+
+	if (tmp & CfgFullDuplex) {
+		ecmd->duplex = DUPLEX_FULL;
+	} else {
+		ecmd->duplex = DUPLEX_HALF;
+	}
+
+	/* ignore maxtxpkt, maxrxpkt for now */
+
+	return 0;
+}
+
+static int netdev_set_ecmd(struct net_device *dev, struct ethtool_cmd *ecmd)
+{
+	struct netdev_private *np = dev->priv;
+	u32 tmp;
+
+	if (ecmd->speed != SPEED_10 && ecmd->speed != SPEED_100)
+		return -EINVAL;
+	if (ecmd->duplex != DUPLEX_HALF && ecmd->duplex != DUPLEX_FULL)
+		return -EINVAL;
+	if (ecmd->port != PORT_TP)
+		return -EINVAL;
+	if (ecmd->transceiver != XCVR_INTERNAL)
+		return -EINVAL;
+	if (ecmd->autoneg != AUTONEG_DISABLE && ecmd->autoneg != AUTONEG_ENABLE)
+		return -EINVAL;
+	/* ignore phy_address, maxtxpkt, maxrxpkt for now */
+	
+	/* WHEW! now lets bang some bits */
+	
+	if (ecmd->autoneg == AUTONEG_ENABLE) {
+		/* advertise only what has been requested */
+		tmp = readl(dev->base_addr + ChipConfig);
+		tmp &= ~(CfgAneg100 | CfgAnegFull);
+		tmp |= CfgAnegEnable;
+		if (ecmd->advertising & ADVERTISED_100baseT_Half 
+		 || ecmd->advertising & ADVERTISED_100baseT_Full) {
+			tmp |= CfgAneg100;
+		}
+		if (ecmd->advertising & ADVERTISED_10baseT_Full 
+		 || ecmd->advertising & ADVERTISED_100baseT_Full) {
+			tmp |= CfgAnegFull;
+		}
+		writel(tmp, dev->base_addr + ChipConfig);
+		/* turn on autonegotiation, and force a renegotiate */
+		tmp = readl(dev->base_addr + BasicControl);
+		tmp |= BMCRAnegEnable | BMCRAnegRestart;
+		writel(tmp, dev->base_addr + BasicControl);
+		np->advertising = mdio_read(dev, 1, 4);
+	} else {
+		/* turn off auto negotiation, set speed and duplexity */
+		tmp = readl(dev->base_addr + BasicControl);
+		tmp &= ~(BMCRAnegEnable | BMCRSpeed | BMCRDuplex);
+		if (ecmd->speed == SPEED_100) {
+			tmp |= BMCRSpeed;
+		}
+		if (ecmd->duplex == DUPLEX_FULL) {
+			tmp |= BMCRDuplex;
+		} else {
+			np->full_duplex = 0;
+		}
+		writel(tmp, dev->base_addr + BasicControl);
+	}
+	return 0;
+}
+
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct netdev_private *np = dev->priv;
@@ -1395,7 +1704,8 @@
 		if (data->phy_id == 1) {
 			u16 miireg = data->reg_num & 0x1f;
 			u16 value = data->val_in;
-			writew(value, dev->base_addr + 0x80 + (miireg << 2));
+			writew(value, dev->base_addr + BasicControl 
+					+ (miireg << 2));
 			switch (miireg) {
 			case 4: np->advertising = value; break;
 			}
@@ -1410,8 +1720,11 @@
 {
 	long ioaddr = dev->base_addr;
 	struct netdev_private *np = dev->priv;
+	u32 wol = readl(ioaddr + WOLCmd) & WakeOptsSummary;
+	u32 clkrun;
 
 	netif_stop_queue(dev);
+	netif_carrier_off(dev);
 
 	if (debug > 1) {
 		printk(KERN_DEBUG "%s: Shutting down ethercard, status was %4.4x.",
@@ -1420,14 +1733,23 @@
 			   dev->name, np->cur_tx, np->dirty_tx, np->cur_rx, np->dirty_rx);
 	}
 
-	/* Disable interrupts using the mask. */
-	writel(0, ioaddr + IntrMask);
-	writel(0, ioaddr + IntrEnable);
-	writel(2, ioaddr + StatsCtrl); 					/* Freeze Stats */
-
-	/* Stop the chip's Tx and Rx processes. */
-	writel(RxOff | TxOff, ioaddr + ChipCmd);
-
+	/* Only shut down chip if wake on lan is not set */
+	if (!wol) {
+		/* Disable interrupts using the mask. */
+		writel(0, ioaddr + IntrMask);
+		writel(0, ioaddr + IntrEnable);
+		writel(2, ioaddr + StatsCtrl); 	/* Freeze Stats */
+	    
+		/* Stop the chip's Tx and Rx processes. */
+		writel(RxOff | TxOff, ioaddr + ChipCmd);
+	} else if (debug > 1) {
+		printk(KERN_INFO "%s: remaining active for wake-on-lan\n", 
+			dev->name);
+		/* spec says write 0 here */
+		writel(0, ioaddr + RxRingPtr);
+		/* allow wake-event interrupts now */
+		writel(readl(ioaddr + IntrMask) | WOLPkt, ioaddr + IntrMask);
+	}
 	del_timer_sync(&np->timer);
 
 #ifdef __i386__
@@ -1451,8 +1773,15 @@
 	drain_ring(dev);
 	free_ring(dev);
 
+	clkrun = np->SavedClkRun;
+	if (wol) {
+		/* make sure to enable PME */
+		clkrun |= 0x100;
+	}
+
 	/* Restore PME enable bit */
 	writel(np->SavedClkRun, ioaddr + ClkRun);
+	
 #if 0
 	writel(0x0200, ioaddr + ChipConfig); /* Power down Xcvr. */
 #endif
diff -ruN dist+patches-2.4.8/include/linux/ethtool.h cobalt-2.4.8/include/linux/ethtool.h
--- dist+patches-2.4.8/include/linux/ethtool.h	Thu Jul 19 17:47:14 2001
+++ cobalt-2.4.8/include/linux/ethtool.h	Mon Aug 13 16:42:49 2001
@@ -38,11 +38,22 @@
 	u32	regdump_len;	/* Amount of data from ETHTOOL_GREGS */
 };
 
+#define SOPASS_MAX	6
+/* wake-on-lan settings */
+struct ethtool_wolinfo {
+	u32	cmd;
+	u32	supported;
+	u32	wolopts;
+	u8	sopass[SOPASS_MAX]; /* SecureOn(tm) password */
+};
+
 /* CMDs currently supported */
 #define ETHTOOL_GSET		0x00000001 /* Get settings. */
 #define ETHTOOL_SSET		0x00000002 /* Set settings, privileged. */
 #define ETHTOOL_GDRVINFO	0x00000003 /* Get driver info. */
 #define ETHTOOL_GREGS		0x00000004 /* Get NIC registers, privileged. */
+#define ETHTOOL_GWOL		0x00000005 /* Get wake-on-lan options. */
+#define ETHTOOL_SWOL		0x00000006 /* Set wake-on-lan options. */
 
 /* compatibility with older code */
 #define SPARC_ETH_GSET		ETHTOOL_GSET
@@ -108,5 +119,14 @@
  */
 #define AUTONEG_DISABLE		0x00
 #define AUTONEG_ENABLE		0x01
+
+/* Wake-On-Lan options. */
+#define WAKE_PHY		(1 << 0)
+#define WAKE_UCAST		(1 << 1)
+#define WAKE_MCAST		(1 << 2)
+#define WAKE_BCAST		(1 << 3)
+#define WAKE_ARP		(1 << 4)
+#define WAKE_MAGIC		(1 << 5)
+#define WAKE_MAGICSECURE	(1 << 6) /* only meaningful if WAKE_MAGIC */
 
 #endif /* _LINUX_ETHTOOL_H */

--------------441AFA254E9AE63163F4DF9D
Content-Type: text/plain; charset=us-ascii;
 name="ethtool-wol.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ethtool-wol.diff"

diff -ruN ethtool-1.2/AUTHORS ethtool-1.3/AUTHORS
--- ethtool-1.2/AUTHORS	Fri Mar 23 10:47:36 2001
+++ ethtool-1.3/AUTHORS	Thu May 13 15:39:49 1976
@@ -1,3 +1,4 @@
 David Miller <davem@redhat.com>
 Jakub Jelinek <jj@ultra.linux.cz>
 Jeff Garzik <jgarzik@mandrakesoft.com>
+Tim Hockin <thockin@sun.com>
diff -ruN ethtool-1.2/NEWS ethtool-1.3/NEWS
--- ethtool-1.2/NEWS	Thu May 17 18:52:39 2001
+++ ethtool-1.3/NEWS	Thu May 13 15:39:49 1976
@@ -4,3 +4,6 @@
 	  information from the ethernet driver associated
 	  with the specified interface.
 
+Version 1.3 - Aug 02, 2001
+
+	* Support Wake-on-LAN (ETHTOOL GWOL and ETHTOOL SWOL ioctl).
diff -ruN ethtool-1.2/configure ethtool-1.3/configure
--- ethtool-1.2/configure	Thu May 17 18:58:44 2001
+++ ethtool-1.3/configure	Thu May 13 22:53:17 1976
@@ -691,7 +691,7 @@
 
 PACKAGE=ethtool
 
-VERSION=1.2
+VERSION=1.3
 
 if test "`cd $srcdir && pwd`" != "`pwd`" && test -f $srcdir/config.status; then
   { echo "configure: error: source directory already configured; run "make distclean" there first" 1>&2; exit 1; }
@@ -987,7 +987,7 @@
   CFLAGS="$ac_save_CFLAGS"
 elif test $ac_cv_prog_cc_g = yes; then
   if test "$GCC" = yes; then
-    CFLAGS="-g -O2"
+    CFLAGS="-g -O2 -Wall"
   else
     CFLAGS="-g"
   fi
diff -ruN ethtool-1.2/ethtool.8 ethtool-1.3/ethtool.8
--- ethtool-1.2/ethtool.8	Thu May 17 18:52:40 2001
+++ ethtool-1.3/ethtool.8	Fri May 14 14:58:46 1976
@@ -2,9 +2,9 @@
 .\" Copyright 1999 by David S. Miller.  All Rights Reserved.
 .\" This file may be copied under the terms of the GNU Public License.
 .\" 
-.TH ETHTOOL 8 "April 1999" "Ethtool version 1.0"
+.TH ETHTOOL 8 "August 2001" "Ethtool version 1.3"
 .SH NAME
-ethtool \- Display or change ethernet card setting
+ethtool \- Display or change ethernet card settings
 .SH SYNOPSIS
 .B ethtool
 .I ethX
@@ -50,9 +50,19 @@
 .I internal,external
 }
 ]
+[
+.B wol
+[
+.I pumbagsd
+]+
+]
+[
+.B sopass
+.I X:X:X:X:X:X
+]
 .SH DESCRIPTION
 .BI ethtool
-Is used for querying setting of an ethernet device and changing it.
+Is used for querying settings of an ethernet device and changing them.
 
 .I ethX
 is the name of the ethernet device to work on.
@@ -95,11 +105,49 @@
 .I xcvr
 Select transceiver type. Currently only internal and external can be
 specified, in the future further types might be added.
+.TP
+.I wol
+Set Wake-on-LAN options.  Not all devices support this.  The argument to 
+this option is a string of characters specifying which options to enable.
+.PD 0
+.TP
+.B p
+Wake on phy activity
+.TP
+.B u
+Wake on unicast messages
+.TP
+.B m
+Wake on multicast messages
+.TP
+.B b
+Wake on broadcast messages
+.TP
+.B a
+Wake on ARP
+.TP
+.B g
+Wake on MagicPacket(tm)
+.TP
+.B s
+Enable SecureOn(tm) password for MagicPacket(tm)
+.TP
+.B d
+Disable (wake on nothing).  This option clears all previous options.
+.TP
+.TP
+.I sopass
+Set the SecureOn(tm) password.  The argument to this option must be 6
+bytes in ethernet MAC hex format (xx:yy:zz:aa:bb:cc).
 .SH BUGS
-Currently supported by Sun Happy Meal Ethernet only.
+Not supported (in part or whole) on all ethernet drivers.
 .SH AUTHOR
 .B ethtool
-has been written by David Miller <davem@redhat.com>.
+was written by David Miller <davem@redhat.com>.
+
+Modifications by 
+Jeff Garzik <jgarzik@mandrakesoft.com>, 
+Tim Hockin <thockin@sun.com>.
 
 Manual page written by Jakub Jelinek <jj@ultra.linux.cz>.
 .SH AVAILABILITY
diff -ruN ethtool-1.2/ethtool.c ethtool-1.3/ethtool.c
--- ethtool-1.2/ethtool.c	Thu May 17 18:52:40 2001
+++ ethtool-1.3/ethtool.c	Fri May 14 15:20:57 1976
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 1998 David S. Miller (davem@dm.cobaltmicro.com)
  * Kernel 2.4 update Copyright 2001 Jeff Garzik <jgarzik@mandrakesoft.com>
+ * Wake-on-LAN support by Tim Hockin <thockin@sun.com>
  */
 
 #ifdef HAVE_CONFIG_H
@@ -22,40 +23,59 @@
 #include <linux/ethtool.h>
 #include <linux/sockios.h>
 
+static int parse_wolopts(char *optstr, int *data);
+static char *unparse_wolopts(int wolopts);
+static int parse_sopass(char *src, unsigned char *dest);
+static int do_gdrv(int fd, struct ifreq *ifr);
+static int do_gset(int fd, struct ifreq *ifr);
+static int do_sset(int fd, struct ifreq *ifr);
 
 /* Syntax:
  *
  *	ethtool DEVNAME
+ *	ethtool -i DEVNAME
  *	ethtool -s DEVNAME [ speed {10,100,1000} ] \
  *		[ duplex {half,full} ] \
  *		[ port {tp,aui,mii,fibre} ] \
  *		[ autoneg {on,off} ] \
  *		[ phyad %d ] \
- *		[ xcvr {internal,external} ]
+ *		[ xcvr {internal,external} ] \
+ *		[ wol [pumbagsd]+ ] \
+ *		[ sopass %x:%x:%x:%x:%x:%x ]
  */
 
 static char *devname = NULL;
-static int cmd = ETHTOOL_GSET;
+static enum { MODE_GSET=0, MODE_SSET, MODE_GDRV } mode = MODE_GSET;
 static int speed_wanted = -1;
 static int duplex_wanted = -1;
 static int port_wanted = -1;
 static int autoneg_wanted = -1;
 static int phyad_wanted = -1;
 static int xcvr_wanted = -1;
+static int gset_changed = 0; /* did anything in GSET change? */
+static u32  wol_wanted = 0;
+static int wol_change = 0;
+static u8 sopass_wanted[SOPASS_MAX];
+static int sopass_change = 0;
+static int gwol_changed = 0; /* did anything in GWOL change? */
 
 static void show_usage(int badarg)
 {
 	fprintf(stderr, PACKAGE " version " VERSION "\n");
-	fprintf(stderr, "Usage:\n");
-	fprintf(stderr, "	ethtool DEVNAME\n");
-	fprintf(stderr, "	ethtool -i DEVNAME\n");
-	fprintf(stderr, "	ethtool -s DEVNAME \\\n");
-	fprintf(stderr, "		[ speed {10,100,1000} ] \\\n");
-	fprintf(stderr, "		[ duplex {half,full} ]	\\\n");
-	fprintf(stderr, "		[ port {tp,aui,mii,fibre} ] \\\n");
-	fprintf(stderr, "		[ autoneg {on,off} ] \\\n");
-	fprintf(stderr, "		[ phyad %%d ] \\\n");
-	fprintf(stderr, "		[ xcvr {internal,external} ] \\\n");
+	fprintf(stderr, 
+		"Usage:\n"
+		"	ethtool DEVNAME\n"
+		"	ethtool -i DEVNAME\n"
+		"	ethtool -s DEVNAME \\\n"
+		"		[ speed {10,100,1000} ] \\\n"
+		"		[ duplex {half,full} ]	\\\n"
+		"		[ port {tp,aui,mii,fibre} ] \\\n"
+		"		[ autoneg {on,off} ] \\\n"
+		"		[ phyad %%d ] \\\n"
+		"		[ xcvr {internal,external} ] \\\n"
+		"		[ wol [pumbagsd]+ ] \\\n"
+		"		[ sopass %%x:%%x:%%x:%%x:%%x:%%x ] \n"
+	);
 	exit(badarg);
 }
 
@@ -67,25 +87,26 @@
 		switch(i) {
 		case 1:
 			if(!strcmp(argp[i], "-s"))
-				cmd = ETHTOOL_SSET;
+				mode = MODE_SSET;
 			else if(!strcmp(argp[i], "-i"))
-				cmd = ETHTOOL_GDRVINFO;
+				mode = MODE_GDRV;
 			else if(!strcmp(argp[i], "-h"))
 				show_usage(0);
 			else
 				devname = argp[i];
 			break;
 		case 2:
-			if ((cmd == ETHTOOL_SSET) ||
-			    (cmd == ETHTOOL_GDRVINFO)) {
+			if ((mode == MODE_SSET) ||
+			    (mode == MODE_GDRV)) {
 				devname = argp[i];
 				break;
 			}
 			/* fallthrough */
 		default:
-			if(cmd != ETHTOOL_SSET)
+			if (mode != MODE_SSET)
 				show_usage(1);
 			if(!strcmp(argp[i], "speed")) {
+				gset_changed = 1;
 				i += 1;
 				if(i >= argc)
 					show_usage(1);
@@ -99,6 +120,7 @@
 					show_usage(1);
 				break;
 			} else if(!strcmp(argp[i], "duplex")) {
+				gset_changed = 1;
 				i += 1;
 				if(i >= argc)
 					show_usage(1);
@@ -110,6 +132,7 @@
 					show_usage(1);
 				break;
 			} else if(!strcmp(argp[i], "port")) {
+				gset_changed = 1;
 				i += 1;
 				if(i >= argc)
 					show_usage(1);
@@ -125,6 +148,7 @@
 					show_usage(1);
 				break;
 			} else if(!strcmp(argp[i], "autoneg")) {
+				gset_changed = 1;
 				i += 1;
 				if(i >= argc)
 					show_usage(1);
@@ -136,6 +160,7 @@
 					show_usage(1);
 				break;
 			} else if(!strcmp(argp[i], "phyad")) {
+				gset_changed = 1;
 				i += 1;
 				if(i >= argc)
 					show_usage(1);
@@ -144,6 +169,7 @@
 					show_usage(1);
 				break;
 			} else if(!strcmp(argp[i], "xcvr")) {
+				gset_changed = 1;
 				i += 1;
 				if(i >= argc)
 					show_usage(1);
@@ -154,6 +180,24 @@
 				else
 					show_usage(1);
 				break;
+			} else if(!strcmp(argp[i], "wol")) {
+				gwol_changed = 1;
+				i++;
+				if (i >= argc)
+					show_usage(1);
+				if (parse_wolopts(argp[i], &wol_wanted) < 0)
+					show_usage(1);
+				wol_change = 1;
+				break;
+			} else if(!strcmp(argp[i], "sopass")) {
+				gwol_changed = 1;
+				i++;
+				if (i >= argc)
+					show_usage(1);
+				if (parse_sopass(argp[i], sopass_wanted) < 0)
+					show_usage(1);
+				sopass_change = 1;
+				break;
 			}
 			show_usage(1);
 		}
@@ -165,7 +209,7 @@
 static void dump_supported(struct ethtool_cmd *ep)
 {
 	u_int32_t mask = ep->supported;
-	int cnt;
+	int did1;
 
 	fprintf(stdout, "	Supported ports: [ ");
 	if(mask & SUPPORTED_TP)
@@ -179,38 +223,36 @@
 	fprintf(stdout, "]\n");
 
 	fprintf(stdout, "	Supported link modes:   ");
-	cnt = 0;
+	did1 = 0;
 	if(mask & SUPPORTED_10baseT_Half) {
-		cnt++; fprintf(stdout, "10baseT/Half ");
+		did1++; fprintf(stdout, "10baseT/Half ");
 	}
 	if(mask & SUPPORTED_10baseT_Full) {
-		cnt++; fprintf(stdout, "10baseT/Full ");
+		did1++; fprintf(stdout, "10baseT/Full ");
 	}
-	if(cnt != 0) {
+	if(did1 && mask & (SUPPORTED_100baseT_Half|SUPPORTED_100baseT_Full)) {
 		fprintf(stdout, "\n");
 		fprintf(stdout, "	                        ");
-		cnt = 0;
 	}
 	if(mask & SUPPORTED_100baseT_Half) {
-		cnt++; fprintf(stdout, "100baseT/Half ");
+		did1++; fprintf(stdout, "100baseT/Half ");
 	}
 	if(mask & SUPPORTED_100baseT_Full) {
-		cnt++; fprintf(stdout, "100baseT/Full ");
+		did1++; fprintf(stdout, "100baseT/Full ");
 	}
-	if(cnt != 0) {
+	if(did1 && mask & (SUPPORTED_1000baseT_Half|SUPPORTED_1000baseT_Full)) {
 		fprintf(stdout, "\n");
 		fprintf(stdout, "	                        ");
-		cnt = 0;
 	}
 	if(mask & SUPPORTED_1000baseT_Half) {
-		cnt++; fprintf(stdout, "1000baseT/Half ");
+		did1++; fprintf(stdout, "1000baseT/Half ");
 	}
 	if(mask & SUPPORTED_1000baseT_Full) {
-		cnt++; fprintf(stdout, "1000baseT/Full ");
+		did1++; fprintf(stdout, "1000baseT/Full ");
 	}
 	fprintf(stdout, "\n");
 
-	fprintf(stdout, "	Supports auto-negotiation? ");
+	fprintf(stdout, "	Supports auto-negotiation: ");
 	if(mask & SUPPORTED_Autoneg)
 		fprintf(stdout, "Yes\n");
 	else
@@ -293,10 +335,10 @@
 static int dump_drvinfo(struct ethtool_drvinfo *info)
 {
 	fprintf(stdout,
-"driver: %s\n"
-"version: %s\n"
-"firmware-version: %s\n"
-"bus-info: %s\n",
+		"driver: %s\n"
+		"version: %s\n"
+		"firmware-version: %s\n"
+		"bus-info: %s\n",
 		info->driver,
 		info->version,
 		info->fw_version,
@@ -305,23 +347,121 @@
 	return 0;
 }
 
+static int dump_wol(struct ethtool_wolinfo *wol)
+{
+	fprintf(stdout, "	Supports Wake-on: %s\n", 
+		unparse_wolopts(wol->supported));
+	fprintf(stdout, "	Wake-on: %s\n", 
+		unparse_wolopts(wol->wolopts));
+	if (wol->supported & WAKE_MAGICSECURE) {
+		int i;
+		int delim = 0;
+		fprintf(stdout, "        SecureOn Password: ");
+		for (i = 0; i < SOPASS_MAX; i++) {
+			fprintf(stdout, "%s%02x", delim?":":"", wol->sopass[i]);
+			delim=1;
+		}
+		fprintf(stdout, "\n");
+	}
+	
+	return 0;
+}
+
+static int parse_wolopts(char *optstr, int *data)
+{
+	*data = 0;
+	while (*optstr) {
+		switch (*optstr) {
+			case 'p':
+				*data |= WAKE_PHY;
+				break;
+			case 'u':
+				*data |= WAKE_UCAST;
+				break;
+			case 'm':
+				*data |= WAKE_MCAST;
+				break;
+			case 'b':
+				*data |= WAKE_BCAST;
+				break;
+			case 'a':
+				*data |= WAKE_ARP;
+				break;
+			case 'g':
+				*data |= WAKE_MAGIC;
+				break;
+			case 's':
+				*data |= WAKE_MAGICSECURE;
+				break;
+			case 'd':
+				*data = 0;
+				break;
+			default:
+				return -1;
+		}
+		optstr++;
+	}
+	return 0;
+}
+
+static char *unparse_wolopts(int wolopts)
+{
+	static char buf[16];
+	char *p = buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	if (wolopts) {
+		if (wolopts & WAKE_PHY)
+			*p++ = 'p';
+		if (wolopts & WAKE_UCAST)
+			*p++ = 'u';
+		if (wolopts & WAKE_MCAST)
+			*p++ = 'm';
+		if (wolopts & WAKE_BCAST)
+			*p++ = 'b';
+		if (wolopts & WAKE_ARP)
+			*p++ = 'a';
+		if (wolopts & WAKE_MAGIC)
+			*p++ = 'g';
+		if (wolopts & WAKE_MAGICSECURE)
+			*p++ = 's';
+	} else {
+		*p = 'd';
+	}
+	
+	return buf;
+}
+
+static int parse_sopass(char *src, unsigned char *dest)
+{
+	int count;
+	int i;
+	int buf[SOPASS_MAX];
+
+	count = sscanf(src, "%2x:%2x:%2x:%2x:%2x:%2x",
+		&buf[0], &buf[1], &buf[2], &buf[3], &buf[4], &buf[5]);
+	if (count != SOPASS_MAX) {
+		return -1;
+	}
+
+	for (i = 0; i < count; i++) {
+		dest[i] = buf[i];
+	}
+	return 0;
+}
+			
 static int doit(void)
 {
-	struct ethtool_cmd ecmd;
 	struct ifreq ifr;
-	int fd, err;
+	int fd;
 	char buf[1024];
 
 	/* Setup our control structures. */
-	memset(&ecmd, 0, sizeof(ecmd));
+	memset(buf, 0, sizeof(buf));
 	memset(&ifr, 0, sizeof(ifr));
-	strcpy(&ifr.ifr_name[0], devname);
+	strcpy(ifr.ifr_name, devname);
 	ifr.ifr_data = (caddr_t) &buf;
-	if (cmd == ETHTOOL_GDRVINFO)
-		ecmd.cmd = ETHTOOL_GDRVINFO;
-	else
-		ecmd.cmd = ETHTOOL_GSET;
-	memcpy(&buf, &ecmd, sizeof(ecmd.cmd));
 
 	/* Open control socket. */
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
@@ -330,45 +470,123 @@
 		return 70;
 	}
 
-	/* Get current settings. */
-	err = ioctl(fd, SIOCETHTOOL, &ifr);
+	if (mode == MODE_GDRV) {
+		return do_gdrv(fd, &ifr);
+	} else if (mode == MODE_GSET) {
+		return do_gset(fd, &ifr);
+	} else if (mode == MODE_SSET) {
+		return do_sset(fd, &ifr);
+	}
+
+	return 69;
+}
+
+static int do_gdrv(int fd, struct ifreq *ifr)
+{
+	int err;
+	struct ethtool_cmd *ecmd = (struct ethtool_cmd *)ifr->ifr_data;
+
+	ecmd->cmd = ETHTOOL_GDRVINFO;
+	err = ioctl(fd, SIOCETHTOOL, ifr);
 	if(err < 0) {
-		perror("Cannot get current device settings");
+		perror("Cannot get driver information");
 		return 71;
 	}
-	if(cmd == ETHTOOL_GDRVINFO)
-		return dump_drvinfo((struct ethtool_drvinfo *) &buf);
-	else if(cmd == ETHTOOL_GSET)
-		return dump_ecmd((struct ethtool_cmd *) &buf);
-	else if(cmd == ETHTOOL_SSET) {
-		memcpy(&ecmd, &buf, sizeof(ecmd));
-		ifr.ifr_data = (caddr_t) &ecmd;
+	return dump_drvinfo((struct ethtool_drvinfo *)ifr->ifr_data);
+}
+
+static int do_gset(int fd, struct ifreq *ifr)
+{
+	int err;
+	struct ethtool_cmd *ecmd = (struct ethtool_cmd *)ifr->ifr_data;
+
+	ecmd->cmd = ETHTOOL_GSET;
+	err = ioctl(fd, SIOCETHTOOL, ifr);
+	if(err < 0) {
+		perror("Cannot get device settings");
+		return 71;
+	}
+	err = dump_ecmd(ecmd);
+	if (err) {
+		return err;
+	}
+
+	ecmd->cmd = ETHTOOL_GWOL;
+	err = ioctl(fd, SIOCETHTOOL, ifr);
+	if(err < 0) {
+		perror("Cannot get wake-on-lan settings");
+		return 72;
+	}
+	err = dump_wol((struct ethtool_wolinfo *)ifr->ifr_data);
+	return 0;
+}
+
+static int do_sset(int fd, struct ifreq *ifr)
+{
+	int err;
+	struct ethtool_cmd *ecmd = (struct ethtool_cmd *)ifr->ifr_data;
+	struct ethtool_wolinfo *wol = (struct ethtool_wolinfo *)ifr->ifr_data;
+
+	if (gset_changed) {
+		ecmd->cmd = ETHTOOL_GSET;
+		err = ioctl(fd, SIOCETHTOOL, ifr);
+		if(err < 0) {
+			perror("Cannot get current device settings");
+			return 71;
+		}
+
 		/* Change everything the user specified. */
 		if(speed_wanted != -1)
-			ecmd.speed = speed_wanted;
+			ecmd->speed = speed_wanted;
 		if(duplex_wanted != -1)
-			ecmd.duplex = duplex_wanted;
+			ecmd->duplex = duplex_wanted;
 		if(port_wanted != -1)
-			ecmd.port = port_wanted;
+			ecmd->port = port_wanted;
 		if(autoneg_wanted != -1)
-			ecmd.autoneg = autoneg_wanted;
+			ecmd->autoneg = autoneg_wanted;
 		if(phyad_wanted != -1)
-			ecmd.phy_address = phyad_wanted;
+			ecmd->phy_address = phyad_wanted;
 		if(xcvr_wanted != -1)
-			ecmd.transceiver = xcvr_wanted;
-
+			ecmd->transceiver = xcvr_wanted;
+	
 		/* Try to perform the update. */
-		ecmd.cmd = ETHTOOL_SSET;
-		err = ioctl(fd, SIOCETHTOOL, &ifr);
+		ecmd->cmd = ETHTOOL_SSET;
+		err = ioctl(fd, SIOCETHTOOL, ifr);
 		if(err < 0) {
 			perror("Cannot update new settings");
 			return 72;
 		}
-		return 0;
 	}
 
-	/* XXX */
-	return 69;
+	if (gwol_changed) {
+		ecmd->cmd = ETHTOOL_GWOL;
+		err = ioctl(fd, SIOCETHTOOL, ifr);
+		if (err < 0) {
+			perror("Cannot get current wake-on-lan settings");
+			return 73;
+		}
+
+		/* Change everything the user specified. */
+		if (wol_change) {
+			wol->wolopts = wol_wanted;
+		}
+		if (sopass_change) {
+			int i;
+			for (i = 0; i < SOPASS_MAX; i++) {
+				wol->sopass[i] = sopass_wanted[i];
+			}
+		}
+
+		/* Try to perform the update. */
+		ecmd->cmd = ETHTOOL_SWOL;
+		err = ioctl(fd, SIOCETHTOOL, ifr);
+		if(err < 0) {
+			perror("Cannot update new wake-on-lan settings");
+			return 74;
+		}
+	}
+
+	return 0;
 }
 
 int main(int argc, char **argp, char **envp)

--------------441AFA254E9AE63163F4DF9D--

