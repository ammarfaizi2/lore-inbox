Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266630AbUGLL42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266630AbUGLL42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 07:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUGLL42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 07:56:28 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:45501 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266630AbUGLLyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 07:54:36 -0400
Date: Mon, 12 Jul 2004 13:54:08 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine breaks with recent Linus kernels : probe of 0000:00:09.0 failed with error -5
Message-ID: <20040712115408.GA31854@k3.hellgate.ch>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	lkml <linux-kernel@vger.kernel.org>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F9E@difpst1a.dif.dk> <20040712080933.GA9221@k3.hellgate.ch> <Pine.LNX.4.56.0407121317130.24721@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0407121317130.24721@jjulnx.backbone.dif.dk>
X-Operating-System: Linux 2.6.7-bk20 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, 12 Jul 2004 13:27:17 +0200, Jesper Juhl wrote:
> Making this change to 2.6.8-rc1 has no effect for me :
> 
[...]
> 
> But, copying the driver from 2.6.7-mm7 to 2.6.8-rc1 works like a charm.

Thanks. <sigh> Not knowing the cause, especially considering that the
bug mysteriously vanished on my box makes me nervous. That there is a
serious problem in a mainline -rc doubly so.

I'll try to reproduce on a different box as soon as I get around to
it, hopefully tonight. If you could help tracking down the culprit
in via-rhine that would be great. Basically, the differences between
those drivers are 9 experimental patches I posted on June 15 on netdev
(attached).

Roger

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=1

Restructure code to make it easier to maintain.

rhine_hw_init: resets chip, reloads eeprom
rhine_chip_reset: chip reset + what used to be wait_for_reset
rhine_reload_eeprom: reload eeprom, re-enable MMIO, disable EEPROM-controlled
	WOL

Note: Chip reset clears a bunch of registers that should be reloaded
from EEPROM (which turns off MMIO). Deal with that later.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- orig/drivers/net/via-rhine.c
+++ mod/drivers/net/via-rhine.c
@@ -579,56 +579,76 @@
 	}
 }
 
-static void wait_for_reset(struct net_device *dev, u32 quirks, char *name)
+static void rhine_chip_reset(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
+	struct rhine_private *rp = netdev_priv(dev);
 	int boguscnt = 20;
 
+	writew(CmdReset, ioaddr + ChipCmd);
 	IOSYNC;
 
 	if (readw(ioaddr + ChipCmd) & CmdReset) {
 		printk(KERN_INFO "%s: Reset not complete yet. "
-			"Trying harder.\n", name);
+			"Trying harder.\n", DRV_NAME);
 
-		/* Rhine-II needs to be forced sometimes */
-		if (quirks & rqForceReset)
+		/* Force reset */
+		if (rp->quirks & rqForceReset)
 			writeb(0x40, ioaddr + MiscCmd);
 
-		/* VT86C100A may need long delay after reset (dlink) */
-		/* Seen on Rhine-II as well (rl) */
+		/* Reset can take somewhat longer (rare) */
 		while ((readw(ioaddr + ChipCmd) & CmdReset) && --boguscnt)
 			udelay(5);
-
 	}
 
 	if (debug > 1)
-		printk(KERN_INFO "%s: Reset %s.\n", name,
+		printk(KERN_INFO "%s: Reset %s.\n", pci_name(rp->pdev),
 			boguscnt ? "succeeded" : "failed");
 }
 
 #ifdef USE_MMIO
-static void __devinit enable_mmio(long ioaddr, u32 quirks)
+static void __devinit enable_mmio(long pioaddr, u32 quirks)
 {
 	int n;
 	if (quirks & rqRhineI) {
 		/* More recent docs say that this bit is reserved ... */
-		n = inb(ioaddr + ConfigA) | 0x20;
-		outb(n, ioaddr + ConfigA);
+		n = inb(pioaddr + ConfigA) | 0x20;
+		outb(n, pioaddr + ConfigA);
 	} else {
-		n = inb(ioaddr + ConfigD) | 0x80;
-		outb(n, ioaddr + ConfigD);
+		n = inb(pioaddr + ConfigD) | 0x80;
+		outb(n, pioaddr + ConfigD);
 	}
 }
 #endif
 
-static void __devinit reload_eeprom(long ioaddr)
+/*
+ * Loads bytes 0x00-0x05, 0x6E-0x6F, 0x78-0x7B from EEPROM
+ */
+static void __devinit rhine_reload_eeprom(long pioaddr, struct net_device *dev)
 {
+	long ioaddr = dev->base_addr;
+	struct rhine_private *rp = netdev_priv(dev);
 	int i;
-	outb(0x20, ioaddr + MACRegEEcsr);
+
+	outb(0x20, pioaddr + MACRegEEcsr);
 	/* Typically 2 cycles to reload. */
 	for (i = 0; i < 150; i++)
-		if (! (inb(ioaddr + MACRegEEcsr) & 0x20))
+		if (! (inb(pioaddr + MACRegEEcsr) & 0x20))
 			break;
+
+#ifdef USE_MMIO
+	/*
+	 * Reloading from EEPROM overwrites ConfigA-D, so we must re-enable
+	 * MMIO. If reloading EEPROM was done first this could be avoided, but
+	 * it is not known if that still works with the "win98-reboot" problem.
+	 */
+	enable_mmio(pioaddr, rp->quirks);
+#endif
+
+	/* Turn off EEPROM-controlled wake-up (magic packet) */
+	if (rp->quirks & rqWOL)
+		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
+
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -640,6 +660,15 @@
 }
 #endif
 
+static void rhine_hw_init(struct net_device *dev, long pioaddr)
+{
+	/* Reset the chip to erase previous misconfiguration. */
+	rhine_chip_reset(dev);
+
+	/* Reload EEPROM controlled bytes cleared by soft reset */
+	rhine_reload_eeprom(pioaddr, dev);
+}
+
 static int __devinit rhine_init_one(struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
@@ -649,13 +678,11 @@
 	u8 pci_rev;
 	u32 quirks;
 	static int card_idx = -1;
-	long ioaddr;
+	long pioaddr;
 	long memaddr;
+	long ioaddr;
 	int io_size;
 	int phy, phy_idx = 0;
-#ifdef USE_MMIO
-	long ioaddr0;
-#endif
 	const char *name;
 
 /* when built into the kernel, we only print version if device is found */
@@ -708,7 +735,7 @@
 		goto err_out;
 	}
 
-	ioaddr = pci_resource_start(pdev, 0);
+	pioaddr = pci_resource_start(pdev, 0);
 	memaddr = pci_resource_start(pdev, 1);
 
 	pci_set_master(pdev);
@@ -728,8 +755,7 @@
 		goto err_out_free_netdev;
 
 #ifdef USE_MMIO
-	ioaddr0 = ioaddr;
-	enable_mmio(ioaddr0, quirks);
+	enable_mmio(pioaddr, quirks);
 
 	ioaddr = (long) ioremap(memaddr, io_size);
 	if (!ioaddr) {
@@ -743,7 +769,7 @@
 	i = 0;
 	while (mmio_verify_registers[i]) {
 		int reg = mmio_verify_registers[i++];
-		unsigned char a = inb(ioaddr0+reg);
+		unsigned char a = inb(pioaddr+reg);
 		unsigned char b = readb(ioaddr+reg);
 		if (a != b) {
 			rc = -EIO;
@@ -752,26 +778,18 @@
 			goto err_out_unmap;
 		}
 	}
+#else
+	ioaddr = pioaddr;
 #endif /* USE_MMIO */
+
 	dev->base_addr = ioaddr;
+	rp = netdev_priv(dev);
+	rp->quirks = quirks;
 
 	rhine_power_init(dev);
 
 	/* Reset the chip to erase previous misconfiguration. */
-	writew(CmdReset, ioaddr + ChipCmd);
-
-	wait_for_reset(dev, quirks, shortname);
-
-	/* Reload the station address from the EEPROM. */
-#ifdef USE_MMIO
-	reload_eeprom(ioaddr0);
-	/* Reloading from eeprom overwrites cfgA-D, so we must re-enable MMIO.
-	   If reload_eeprom() was done first this could be avoided, but it is
-	   not known if that still works with the "win98-reboot" problem. */
-	enable_mmio(ioaddr0, quirks);
-#else
-	reload_eeprom(ioaddr);
-#endif
+	rhine_hw_init(dev, pioaddr);
 
 	for (i = 0; i < 6; i++)
 		dev->dev_addr[i] = readb(ioaddr + StationAddr + i);
@@ -782,15 +800,6 @@
 		goto err_out_unmap;
 	}
 
-	if (quirks & rqWOL) {
-		/*
-		 * for 3065D, EEPROM reloaded will cause bit 0 in MAC_REG_CFGA
-		 * turned on. it makes MAC receive magic packet
-		 * automatically. So, we turn it off. (D-Link)
-		 */
-		writeb(readb(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
-	}
-
 	/* Select backoff algorithm */
 	if (backoff)
 		writeb(readb(ioaddr + ConfigD) & (0xF0 | backoff),
@@ -798,10 +807,8 @@
 
 	dev->irq = pdev->irq;
 
-	rp = netdev_priv(dev);
 	spin_lock_init(&rp->lock);
 	rp->pdev = pdev;
-	rp->quirks = quirks;
 	rp->mii_if.dev = dev;
 	rp->mii_if.mdio_read = mdio_read;
 	rp->mii_if.mdio_write = mdio_write;
@@ -1170,9 +1177,6 @@
 	long ioaddr = dev->base_addr;
 	int i;
 
-	/* Reset the chip. */
-	writew(CmdReset, ioaddr + ChipCmd);
-
 	i = request_irq(rp->pdev->irq, &rhine_interrupt, SA_SHIRQ, dev->name,
 			dev);
 	if (i)
@@ -1187,7 +1191,7 @@
 		return i;
 	alloc_rbufs(dev);
 	alloc_tbufs(dev);
-	wait_for_reset(dev, rp->quirks, dev->name);
+	rhine_chip_reset(dev);
 	init_registers(dev);
 	if (debug > 2)
 		printk(KERN_DEBUG "%s: Done rhine_open(), status %4.4x "
@@ -1283,9 +1287,6 @@
 
 	spin_lock(&rp->lock);
 
-	/* Reset the chip. */
-	writew(CmdReset, ioaddr + ChipCmd);
-
 	/* clear all descriptors */
 	free_tbufs(dev);
 	free_rbufs(dev);
@@ -1293,7 +1294,7 @@
 	alloc_rbufs(dev);
 
 	/* Reinitialize the hardware. */
-	wait_for_reset(dev, rp->quirks, dev->name);
+	rhine_chip_reset(dev);
 	init_registers(dev);
 
 	spin_unlock(&rp->lock);

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=2

A.J. from VIA Networking Technologies noticed that via-rhine is using
cpu_to_le32() when preparing mc_filter hashes. This breaks Rhine hardware
multicast filters on big-endian architectures.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- 2.6-bk/drivers/net/via-rhine.c.orig	2004-06-06 18:03:21.323194221 +0200
+++ 2.6-bk/drivers/net/via-rhine.c	2004-06-06 18:05:22.137319854 +0200
@@ -1782,7 +1782,7 @@
 		     i++, mclist = mclist->next) {
 			int bit_nr = ether_crc(ETH_ALEN, mclist->dmi_addr) >> 26;
 
-			mc_filter[bit_nr >> 5] |= cpu_to_le32(1 << (bit_nr & 31));
+			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
 		}
 		writel(mc_filter[0], ioaddr + MulticastFilter0);
 		writel(mc_filter[1], ioaddr + MulticastFilter1);

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=3

All this code is broken (e.g. unconditionally programs all PHYs as if
they were the same model) and/or unused (IntrLinkChange never occurs
with driver as is).

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- orig/drivers/net/via-rhine.c
+++ mod/drivers/net/via-rhine.c
@@ -373,7 +373,6 @@
 enum rhine_quirks {
 	rqWOL		= 0x0001,	/* Wake-On-LAN support */
 	rqForceReset	= 0x0002,
-	rqDavicomPhy	= 0x0020,
 	rq6patterns	= 0x0040,	/* 6 instead of 4 patterns for WOL */
 	rqStatusWBRace	= 0x0080,	/* Tx Status Writeback Error possible */
 	rqRhineI	= 0x0100,	/* See comment below */
@@ -698,7 +697,7 @@
 
 	io_size = 256;
 	if (pci_rev < VT6102) {
-		quirks = rqRhineI | rqDavicomPhy;
+		quirks = rqRhineI;
 		io_size = 128;
 		name = "VT86C100A Rhine";
 	}
@@ -1113,11 +1112,6 @@
 	writew(rp->chip_cmd, ioaddr + ChipCmd);
 
 	rhine_check_duplex(dev);
-
-	/* The LED outputs of various MII xcvrs should be configured. */
-	/* For NS or Mison phys, turn on bit 1 in register 0x17 */
-	mdio_write(dev, rp->phys[0], 0x17, mdio_read(dev, rp->phys[0], 0x17) |
-		   0x0001);
 }
 
 /* Read and write over the MII Management Data I/O (MDIO) interface. */
@@ -1692,12 +1686,7 @@
 	spin_lock(&rp->lock);
 
 	if (intr_status & (IntrLinkChange)) {
-		if (readb(ioaddr + MIIStatus) & 0x02) {
-			/* Link failed, restart autonegotiation. */
-			if (rp->quirks & rqRhineI)
-				mdio_write(dev, rp->phys[0], MII_BMCR, 0x3300);
-		} else
-			rhine_check_duplex(dev);
+		rhine_check_duplex(dev);
 		if (debug)
 			printk(KERN_ERR "%s: MII status changed: "
 			       "Autonegotiation advertising %4.4x partner "

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=4

Instead of probing, set phy_id to 1 for Rhine III and read phy_id from
EEPROM-controlled register for Rhine I/II.

Remove code for handling anything other than 1 MII PHY. If it wasn't
unnecessary code to begin with, it would need to be fixed because it
wouldn't work.

Use mii_if_info.phy_id as the only container of phy_id. Not particulary
happy about those names (phy_id vs. MII_PHYSIDx), but being consequent
about it mitigates confusion.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- orig/drivers/net/via-rhine.c
+++ mod/drivers/net/via-rhine.c
@@ -475,7 +475,6 @@
 	CmdNoTxPoll=0x0800, CmdReset=0x8000,
 };
 
-#define MAX_MII_CNT	4
 struct rhine_private {
 	/* Descriptor rings */
 	struct rx_desc *rx_ring;
@@ -513,8 +512,6 @@
 	u8 tx_thresh, rx_thresh;
 
 	/* MII transceiver section. */
-	unsigned char phys[MAX_MII_CNT];	/* MII device addresses. */
-	unsigned int mii_cnt;		/* number of MIIs found, but only the first one is used */
 	u16 mii_status;			/* last read MII status */
 	struct mii_if_info mii_if;
 };
@@ -622,6 +619,7 @@
 
 /*
  * Loads bytes 0x00-0x05, 0x6E-0x6F, 0x78-0x7B from EEPROM
+ * (plus 0x6C for Rhine I/II)
  */
 static void __devinit rhine_reload_eeprom(long pioaddr, struct net_device *dev)
 {
@@ -680,8 +678,7 @@
 	long pioaddr;
 	long memaddr;
 	long ioaddr;
-	int io_size;
-	int phy, phy_idx = 0;
+	int io_size, phy_id;
 	const char *name;
 
 /* when built into the kernel, we only print version if device is found */
@@ -696,6 +693,7 @@
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &pci_rev);
 
 	io_size = 256;
+	phy_id = 0;
 	if (pci_rev < VT6102) {
 		quirks = rqRhineI;
 		io_size = 128;
@@ -709,6 +707,7 @@
 		}
 		else {
 			name = "Rhine III";
+			phy_id = 1;	/* Integrated PHY, phy_id fixed to 1 */
 			if (pci_rev >= VT6105_B0)
 				quirks |= rq6patterns;
 		}
@@ -804,6 +803,10 @@
 		writeb(readb(ioaddr + ConfigD) & (0xF0 | backoff),
 		       ioaddr + ConfigD);
 
+	/* For Rhine I/II, phy_id is loaded from EEPROM */
+	if (!phy_id)
+		phy_id = readb(ioaddr + 0x6C);
+
 	dev->irq = pdev->irq;
 
 	spin_lock_init(&rp->lock);
@@ -867,17 +870,15 @@
 
 	pci_set_drvdata(pdev, dev);
 
-	rp->phys[0] = 1;		/* Standard for this chip. */
-	for (phy = 1; phy < 32 && phy_idx < MAX_MII_CNT; phy++) {
-		int mii_status = mdio_read(dev, phy, 1);
+	{
+		int mii_status = mdio_read(dev, phy_id, 1);
 		if (mii_status != 0xffff && mii_status != 0x0000) {
-			rp->phys[phy_idx++] = phy;
-			rp->mii_if.advertising = mdio_read(dev, phy, 4);
+			rp->mii_if.advertising = mdio_read(dev, phy_id, 4);
 			printk(KERN_INFO "%s: MII PHY found at address "
 			       "%d, status 0x%4.4x advertising %4.4x "
-			       "Link %4.4x.\n", dev->name, phy,
+			       "Link %4.4x.\n", dev->name, phy_id,
 			       mii_status, rp->mii_if.advertising,
-			       mdio_read(dev, phy, 5));
+			       mdio_read(dev, phy_id, 5));
 
 			/* set IFF_RUNNING */
 			if (mii_status & BMSR_LSTATUS)
@@ -885,11 +886,9 @@
 			else
 				netif_carrier_off(dev);
 
-			break;
 		}
 	}
-	rp->mii_cnt = phy_idx;
-	rp->mii_if.phy_id = rp->phys[0];
+	rp->mii_if.phy_id = phy_id;
 
 	/* Allow forcing the media type. */
 	if (option > 0) {
@@ -900,10 +899,9 @@
 				"operation.\n",
 			       (option & 0x300 ? 100 : 10),
 			       (option & 0x220 ? "full" : "half"));
-			if (rp->mii_cnt)
-				mdio_write(dev, rp->phys[0], MII_BMCR,
-					   ((option & 0x300) ? 0x2000 : 0) | /* 100mbps? */
-					   ((option & 0x220) ? 0x0100 : 0)); /* Full duplex? */
+			mdio_write(dev, phy_id, MII_BMCR,
+				   ((option & 0x300) ? 0x2000 : 0) | /* 100mbps? */
+				   ((option & 0x220) ? 0x0100 : 0)); /* Full duplex? */
 		}
 	}
 
@@ -1140,7 +1138,7 @@
 	long ioaddr = dev->base_addr;
 	int boguscnt = 1024;
 
-	if (phy_id == rp->phys[0]) {
+	if (phy_id == rp->mii_if.phy_id) {
 		switch (regnum) {
 		case MII_BMCR:		/* Is user forcing speed/duplex? */
 			if (value & 0x9000)	/* Autonegotiation. */
@@ -1191,7 +1189,7 @@
 		printk(KERN_DEBUG "%s: Done rhine_open(), status %4.4x "
 		       "MII status: %4.4x.\n",
 		       dev->name, readw(ioaddr + ChipCmd),
-		       mdio_read(dev, rp->phys[0], MII_BMSR));
+		       mdio_read(dev, rp->mii_if.phy_id, MII_BMSR));
 
 	netif_start_queue(dev);
 
@@ -1209,7 +1207,7 @@
 {
 	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
-	int mii_lpa = mdio_read(dev, rp->phys[0], MII_LPA);
+	int mii_lpa = mdio_read(dev, rp->mii_if.phy_id, MII_LPA);
 	int negotiated = mii_lpa & rp->mii_if.advertising;
 	int duplex;
 
@@ -1222,7 +1220,7 @@
 			printk(KERN_INFO "%s: Setting %s-duplex based on "
 			       "MII #%d link partner capability of %4.4x.\n",
 			       dev->name, duplex ? "full" : "half",
-			       rp->phys[0], mii_lpa);
+			       rp->mii_if.phy_id, mii_lpa);
 		if (duplex)
 			rp->chip_cmd |= CmdFDuplex;
 		else
@@ -1250,7 +1248,7 @@
 	rhine_check_duplex(dev);
 
 	/* make IFF_RUNNING follow the MII status bit "Link established" */
-	mii_status = mdio_read(dev, rp->phys[0], MII_BMSR);
+	mii_status = mdio_read(dev, rp->mii_if.phy_id, MII_BMSR);
 	if ((mii_status & BMSR_LSTATUS) != (rp->mii_status & BMSR_LSTATUS)) {
 		if (mii_status & BMSR_LSTATUS)
 			netif_carrier_on(dev);
@@ -1274,7 +1272,7 @@
 	printk(KERN_WARNING "%s: Transmit timed out, status %4.4x, PHY status "
 	       "%4.4x, resetting...\n",
 	       dev->name, readw(ioaddr + IntrStatus),
-	       mdio_read(dev, rp->phys[0], MII_BMSR));
+	       mdio_read(dev, rp->mii_if.phy_id, MII_BMSR));
 
 	/* protect against concurrent rx interrupts */
 	disable_irq(rp->pdev->irq);
@@ -1691,8 +1689,8 @@
 			printk(KERN_ERR "%s: MII status changed: "
 			       "Autonegotiation advertising %4.4x partner "
 			       "%4.4x.\n", dev->name,
-			       mdio_read(dev, rp->phys[0], MII_ADVERTISE),
-			       mdio_read(dev, rp->phys[0], MII_LPA));
+			       mdio_read(dev, rp->mii_if.phy_id, MII_ADVERTISE),
+			       mdio_read(dev, rp->mii_if.phy_id, MII_LPA));
 	}
 	if (intr_status & IntrStatsMax) {
 		rp->stats.rx_crc_errors += readw(ioaddr + RxCRCErrs);

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=5

Nobody complained although media locking parameters were broken
forever. They were sort of fixed recently, but the code is still in a
bad shape.

More seriously, the options/full_duplex stuff has fundamental design
problems that have been discussed in-depth on the list (e.g. effect of
hotplugging, nameif, suspend/resume).

For those needing media locking with Linux 2.6+ via-rhine, ethtool(8)
is the replacement.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- orig/drivers/net/via-rhine.c
+++ mod/drivers/net/via-rhine.c
@@ -145,19 +145,10 @@
 /* Select a backoff algorithm (Ethernet capture effect) */
 static int backoff;
 
-/* Used to pass the media type, etc.
-   Both 'options[]' and 'full_duplex[]' should exist for driver
-   interoperability.
-   The media type is usually passed in 'options[]'.
-   The default is autonegotiation for speed and duplex.
-     This should rarely be overridden.
-   Use option values 0x10/0x20 for 10Mbps, 0x100,0x200 for 100Mbps.
-   Use option values 0x10 and 0x100 for forcing half duplex fixed speed.
-   Use option values 0x20 and 0x200 for forcing full duplex operation.
-*/
-#define MAX_UNITS	8	/* More are supported, limit only on options */
-static int options[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
-static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
+/*
+ * In case you are looking for 'options[]' or 'full_duplex[]', they
+ * are gone. Use ethtool(8) instead.
+ */
 
 /* Maximum number of multicast addresses to filter (vs. rx-all-multicast).
    The Rhine has a 64 element 8390-like hash table. */
@@ -246,14 +237,10 @@
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(backoff, "i");
-MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM_DESC(max_interrupt_work, "VIA Rhine maximum events handled per interrupt");
 MODULE_PARM_DESC(debug, "VIA Rhine debug level (0-7)");
 MODULE_PARM_DESC(rx_copybreak, "VIA Rhine copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(backoff, "VIA Rhine: Bits 0-3: backoff algorithm");
-MODULE_PARM_DESC(options, "VIA Rhine: Bits 0-3: media type, bit 17: full duplex");
-MODULE_PARM_DESC(full_duplex, "VIA Rhine full duplex setting(s) (1)");
 
 /*
 		Theory of Operation
@@ -671,7 +658,7 @@
 {
 	struct net_device *dev;
 	struct rhine_private *rp;
-	int i, option, rc;
+	int i, rc;
 	u8 pci_rev;
 	u32 quirks;
 	static int card_idx = -1;
@@ -688,8 +675,6 @@
 		printk(version);
 #endif
 
-	card_idx++;
-	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &pci_rev);
 
 	io_size = 256;
@@ -817,9 +802,6 @@
 	rp->mii_if.phy_id_mask = 0x1f;
 	rp->mii_if.reg_num_mask = 0x1f;
 
-	if (dev->mem_start)
-		option = dev->mem_start;
-
 	/* The chip-specific entries in the device structure. */
 	dev->open = rhine_open;
 	dev->hard_start_xmit = rhine_start_tx;
@@ -841,20 +823,6 @@
 	if (rc)
 		goto err_out_unmap;
 
-	/* The lower four bits are the media type. */
-	if (option > 0) {
-		if (option & 0x220)
-			rp->mii_if.full_duplex = 1;
-	}
-	if (card_idx < MAX_UNITS && full_duplex[card_idx] > 0)
-		rp->mii_if.full_duplex = 1;
-
-	if (rp->mii_if.full_duplex) {
-		printk(KERN_INFO "%s: Set to forced full duplex, "
-		       "autonegotiation disabled.\n", dev->name);
-		rp->mii_if.force_media = 1;
-	}
-
 	printk(KERN_INFO "%s: VIA %s at 0x%lx, ",
 	       dev->name, name,
 #ifdef USE_MMIO
@@ -890,21 +858,6 @@
 	}
 	rp->mii_if.phy_id = phy_id;
 
-	/* Allow forcing the media type. */
-	if (option > 0) {
-		if (option & 0x220)
-			rp->mii_if.full_duplex = 1;
-		if (option & 0x330) {
-			printk(KERN_INFO " Forcing %dMbs %s-duplex "
-				"operation.\n",
-			       (option & 0x300 ? 100 : 10),
-			       (option & 0x220 ? "full" : "half"));
-			mdio_write(dev, phy_id, MII_BMCR,
-				   ((option & 0x300) ? 0x2000 : 0) | /* 100mbps? */
-				   ((option & 0x220) ? 0x0100 : 0)); /* Full duplex? */
-		}
-	}
-
 	return 0;
 
 err_out_unmap:

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=6

It finally dawned on me how to eliminate the race I've been narrowing
down with earlier patches: Instead of writing the command registers as
one word, write them one at a time (as bytes). The race was for settings
bits in ChipCmd and ChipCmd1 (0x09) against the chip clearing CmdTxOn
which is in ChipCmd.

In addition to writing single bytes, the fix requires a switch from
using bit 5 in ChipCmd0 to bit 5 in ChipCmd1 (which is equivalent)
to signal Tx demand.

Also, don't restart Rx engine "pre-emptively" in rhine_rx, that's a
sure way to race with the chip.

Introduce RHINE_WAIT_FOR, a macro for small busy loops with primitive
completion checking.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- orig/drivers/net/via-rhine.c
+++ mod/drivers/net/via-rhine.c
@@ -387,6 +387,7 @@
 /* Offsets to the device registers. */
 enum register_offsets {
 	StationAddr=0x00, RxConfig=0x06, TxConfig=0x07, ChipCmd=0x08,
+	ChipCmd1=0x09,
 	IntrStatus=0x0C, IntrEnable=0x0E,
 	MulticastFilter0=0x10, MulticastFilter1=0x14,
 	RxRingPtr=0x18, TxRingPtr=0x1C, GFIFOTest=0x54,
@@ -456,10 +457,10 @@
 
 /* Bits in ChipCmd. */
 enum chip_cmd_bits {
-	CmdInit=0x0001, CmdStart=0x0002, CmdStop=0x0004, CmdRxOn=0x0008,
-	CmdTxOn=0x0010, CmdTxDemand=0x0020, CmdRxDemand=0x0040,
-	CmdEarlyRx=0x0100, CmdEarlyTx=0x0200, CmdFDuplex=0x0400,
-	CmdNoTxPoll=0x0800, CmdReset=0x8000,
+	CmdInit=0x01, CmdStart=0x02, CmdStop=0x04, CmdRxOn=0x08,
+	CmdTxOn=0x10, Cmd1TxDemand=0x20, CmdRxDemand=0x40,
+	Cmd1EarlyRx=0x01, Cmd1EarlyTx=0x02, Cmd1FDuplex=0x04,
+	Cmd1NoTxPoll=0x08, Cmd1Reset=0x80,
 };
 
 struct rhine_private {
@@ -493,7 +494,6 @@
 	unsigned int cur_rx, dirty_rx;	/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
-	u16 chip_cmd;			/* Current setting for ChipCmd */
 
 	/* These values are keep track of the transceiver/media in use. */
 	u8 tx_thresh, rx_thresh;
@@ -520,6 +520,15 @@
 static struct ethtool_ops netdev_ethtool_ops;
 static int  rhine_close(struct net_device *dev);
 
+#define RHINE_WAIT_FOR(condition) do {					\
+	int i=1024;							\
+	while (!(condition) && --i)					\
+		;							\
+	if (debug > 1 && i < 512)					\
+		printk(KERN_INFO "%s: %4d cycles used @ %s:%d\n",	\
+				DRV_NAME, 1024-i, __func__, __LINE__);	\
+} while(0)
+
 static inline u32 get_intr_status(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
@@ -566,12 +575,11 @@
 {
 	long ioaddr = dev->base_addr;
 	struct rhine_private *rp = netdev_priv(dev);
-	int boguscnt = 20;
 
-	writew(CmdReset, ioaddr + ChipCmd);
+	writeb(Cmd1Reset, ioaddr + ChipCmd1);
 	IOSYNC;
 
-	if (readw(ioaddr + ChipCmd) & CmdReset) {
+	if (readb(ioaddr + ChipCmd1) & Cmd1Reset) {
 		printk(KERN_INFO "%s: Reset not complete yet. "
 			"Trying harder.\n", DRV_NAME);
 
@@ -580,13 +588,13 @@
 			writeb(0x40, ioaddr + MiscCmd);
 
 		/* Reset can take somewhat longer (rare) */
-		while ((readw(ioaddr + ChipCmd) & CmdReset) && --boguscnt)
-			udelay(5);
+		RHINE_WAIT_FOR(!(readb(ioaddr + ChipCmd1) & Cmd1Reset));
 	}
 
 	if (debug > 1)
-		printk(KERN_INFO "%s: Reset %s.\n", pci_name(rp->pdev),
-			boguscnt ? "succeeded" : "failed");
+		printk(KERN_INFO "%s: Reset %s.\n", dev->name,
+			(readb(ioaddr + ChipCmd1) & Cmd1Reset) ?
+			"failed" : "succeeded");
 }
 
 #ifdef USE_MMIO
@@ -612,13 +620,9 @@
 {
 	long ioaddr = dev->base_addr;
 	struct rhine_private *rp = netdev_priv(dev);
-	int i;
 
 	outb(0x20, pioaddr + MACRegEEcsr);
-	/* Typically 2 cycles to reload. */
-	for (i = 0; i < 150; i++)
-		if (! (inb(pioaddr + MACRegEEcsr) & 0x20))
-			break;
+	RHINE_WAIT_FOR(!(inb(pioaddr + MACRegEEcsr) & 0x20));
 
 #ifdef USE_MMIO
 	/*
@@ -1057,10 +1061,14 @@
 	       IntrPCIErr | IntrStatsMax | IntrLinkChange,
 	       ioaddr + IntrEnable);
 
-	rp->chip_cmd = CmdStart|CmdTxOn|CmdRxOn|CmdNoTxPoll;
+	writew(CmdStart|CmdTxOn|CmdRxOn|(Cmd1NoTxPoll << 8),
+	       ioaddr + ChipCmd);
 	if (rp->mii_if.force_media)
-		rp->chip_cmd |= CmdFDuplex;
-	writew(rp->chip_cmd, ioaddr + ChipCmd);
+		writeb(readb(ioaddr + ChipCmd1) | Cmd1FDuplex,
+		       ioaddr + ChipCmd1);
+	else
+		writeb(readb(ioaddr + ChipCmd1) & ~Cmd1FDuplex,
+		       ioaddr + ChipCmd1);
 
 	rhine_check_duplex(dev);
 }
@@ -1070,18 +1078,14 @@
 static int mdio_read(struct net_device *dev, int phy_id, int regnum)
 {
 	long ioaddr = dev->base_addr;
-	int boguscnt = 1024;
 
 	/* Wait for a previous command to complete. */
-	while ((readb(ioaddr + MIICmd) & 0x60) && --boguscnt > 0)
-		;
+	RHINE_WAIT_FOR(!(readb(ioaddr + MIICmd) & 0x60));
 	writeb(0x00, ioaddr + MIICmd);
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
 	writeb(0x40, ioaddr + MIICmd);		/* Trigger read */
-	boguscnt = 1024;
-	while ((readb(ioaddr + MIICmd) & 0x40) && --boguscnt > 0)
-		;
+	RHINE_WAIT_FOR(!(readb(ioaddr + MIICmd) & 0x40));
 	return readw(ioaddr + MIIData);
 }
 
@@ -1089,7 +1093,6 @@
 {
 	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
-	int boguscnt = 1024;
 
 	if (phy_id == rp->mii_if.phy_id) {
 		switch (regnum) {
@@ -1106,8 +1109,7 @@
 	}
 
 	/* Wait for a previous command to complete. */
-	while ((readb(ioaddr + MIICmd) & 0x60) && --boguscnt > 0)
-		;
+	RHINE_WAIT_FOR(!(readb(ioaddr + MIICmd) & 0x60));
 	writeb(0x00, ioaddr + MIICmd);
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
@@ -1175,10 +1177,11 @@
 			       dev->name, duplex ? "full" : "half",
 			       rp->mii_if.phy_id, mii_lpa);
 		if (duplex)
-			rp->chip_cmd |= CmdFDuplex;
+			writeb(readb(ioaddr + ChipCmd1) | Cmd1FDuplex,
+			       ioaddr + ChipCmd1);
 		else
-			rp->chip_cmd &= ~CmdFDuplex;
-		writew(rp->chip_cmd, ioaddr + ChipCmd);
+			writeb(readb(ioaddr + ChipCmd1) & ~Cmd1FDuplex,
+			       ioaddr + ChipCmd1);
 	}
 }
 
@@ -1311,7 +1314,8 @@
 	 */
 	intr_status = get_intr_status(dev);
 	if ((intr_status & IntrTxErrSummary) == 0) {
-		writew(CmdTxDemand | rp->chip_cmd, dev->base_addr + ChipCmd);
+		writeb(readb(dev->base_addr + ChipCmd1) | Cmd1TxDemand,
+		       dev->base_addr + ChipCmd1);
 	}
 	IOSYNC;
 
@@ -1360,11 +1364,10 @@
 
 		if (intr_status & (IntrTxErrSummary | IntrTxDone)) {
 			if (intr_status & IntrTxErrSummary) {
-				int cnt = 20;
 				/* Avoid scavenging before Tx engine turned off */
-				while ((readw(ioaddr+ChipCmd) & CmdTxOn) && --cnt)
-					udelay(5);
-				if (debug > 2 && !cnt)
+				RHINE_WAIT_FOR(!(readb(ioaddr+ChipCmd) & CmdTxOn));
+				if (debug > 2 &&
+				    readb(ioaddr+ChipCmd) & CmdTxOn)
 					printk(KERN_WARNING "%s: "
 					       "rhine_interrupt() Tx engine"
 					       "still on.\n", dev->name);
@@ -1579,10 +1582,6 @@
 		}
 		rp->rx_ring[entry].rx_status = cpu_to_le32(DescOwn);
 	}
-
-	/* Pre-emptively restart Rx engine. */
-	writew(readw(dev->base_addr + ChipCmd) | CmdRxOn | CmdRxDemand,
-	       dev->base_addr + ChipCmd);
 }
 
 /*
@@ -1616,7 +1615,11 @@
 		writel(rp->tx_ring_dma + entry * sizeof(struct tx_desc),
 		       ioaddr + TxRingPtr);
 
-		writew(CmdTxDemand | rp->chip_cmd, ioaddr + ChipCmd);
+		writeb(readb(ioaddr + ChipCmd) | CmdTxOn,
+		       ioaddr + ChipCmd);
+		writeb(readb(ioaddr + ChipCmd1) | Cmd1TxDemand,
+		       ioaddr + ChipCmd1);
+
 		IOSYNC;
 	}
 	else {

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=7

Remove rhine_check_duplex, rhine_timer and related data structures

Add rhine_check_media: wrapper for generic mii_check_media, sets duplex
bit in MAC

Add rhine_enable_linkmon, rhine_disable_linkmon to enable hardware link
status monitoring

Update mdio_read, mdio_write accordingly

Remove get_intr_status check in rhine_start_tx because we are not racing
anymore

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- orig/drivers/net/via-rhine.c
+++ mod/drivers/net/via-rhine.c
@@ -485,7 +485,6 @@
 
 	struct pci_dev *pdev;
 	struct net_device_stats stats;
-	struct timer_list timer;	/* Media monitoring timer. */
 	spinlock_t lock;
 
 	/* Frequently used values: keep some adjacent for cache effect. */
@@ -498,16 +497,12 @@
 	/* These values are keep track of the transceiver/media in use. */
 	u8 tx_thresh, rx_thresh;
 
-	/* MII transceiver section. */
-	u16 mii_status;			/* last read MII status */
 	struct mii_if_info mii_if;
 };
 
 static int  mdio_read(struct net_device *dev, int phy_id, int location);
 static void mdio_write(struct net_device *dev, int phy_id, int location, int value);
 static int  rhine_open(struct net_device *dev);
-static void rhine_check_duplex(struct net_device *dev);
-static void rhine_timer(unsigned long data);
 static void rhine_tx_timeout(struct net_device *dev);
 static int  rhine_start_tx(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t rhine_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
@@ -1032,6 +1027,21 @@
 	}
 }
 
+static void rhine_check_media(struct net_device *dev, unsigned int init_media)
+{
+	struct rhine_private *rp = netdev_priv(dev);
+	long ioaddr = dev->base_addr;
+
+	mii_check_media(&rp->mii_if, debug, init_media);
+
+	if (rp->mii_if.full_duplex)
+	    writeb(readb(ioaddr + ChipCmd1) | Cmd1FDuplex,
+		   ioaddr + ChipCmd1);
+	else
+	    writeb(readb(ioaddr + ChipCmd1) & ~Cmd1FDuplex,
+		   ioaddr + ChipCmd1);
+}
+
 static void init_registers(struct net_device *dev)
 {
 	struct rhine_private *rp = netdev_priv(dev);
@@ -1047,7 +1057,6 @@
 	writeb(0x20, ioaddr + TxConfig);
 	rp->tx_thresh = 0x20;
 	rp->rx_thresh = 0x60;		/* Written in rhine_set_rx_mode(). */
-	rp->mii_if.full_duplex = 0;
 
 	writel(rp->rx_ring_dma, ioaddr + RxRingPtr);
 	writel(rp->tx_ring_dma, ioaddr + TxRingPtr);
@@ -1063,14 +1072,42 @@
 
 	writew(CmdStart|CmdTxOn|CmdRxOn|(Cmd1NoTxPoll << 8),
 	       ioaddr + ChipCmd);
-	if (rp->mii_if.force_media)
-		writeb(readb(ioaddr + ChipCmd1) | Cmd1FDuplex,
-		       ioaddr + ChipCmd1);
-	else
-		writeb(readb(ioaddr + ChipCmd1) & ~Cmd1FDuplex,
-		       ioaddr + ChipCmd1);
+	rhine_check_media(dev, 1);
+}
+
+/* Enable MII link status auto-polling (required for IntrLinkChange) */
+static void rhine_enable_linkmon(long ioaddr)
+{
+	writeb(0, ioaddr + MIICmd);
+	writeb(MII_BMSR, ioaddr + MIIRegAddr);
+	writeb(0x80, ioaddr + MIICmd);
 
-	rhine_check_duplex(dev);
+	RHINE_WAIT_FOR((readb(ioaddr + MIIRegAddr) & 0x20));
+
+	writeb(MII_BMSR | 0x40, ioaddr + MIIRegAddr);
+}
+
+/* Disable MII link status auto-polling (required for MDIO access) */
+static void rhine_disable_linkmon(long ioaddr, u32 quirks)
+{
+	writeb(0, ioaddr + MIICmd);
+
+	if (quirks & rqRhineI) {
+		writeb(0x01, ioaddr + MIIRegAddr);	// MII_BMSR
+
+		/* Can be called from ISR. Evil. */
+		mdelay(1);
+
+		/* 0x80 must be set immediately before turning it off */
+		writeb(0x80, ioaddr + MIICmd);
+
+		RHINE_WAIT_FOR(readb(ioaddr + MIIRegAddr) & 0x20);
+
+		/* Heh. Now clear 0x80 again. */
+		writeb(0, ioaddr + MIICmd);
+	}
+	else
+		RHINE_WAIT_FOR(readb(ioaddr + MIIRegAddr) & 0x80);
 }
 
 /* Read and write over the MII Management Data I/O (MDIO) interface. */
@@ -1078,15 +1115,20 @@
 static int mdio_read(struct net_device *dev, int phy_id, int regnum)
 {
 	long ioaddr = dev->base_addr;
+	struct rhine_private *rp = netdev_priv(dev);
+	int result;
 
-	/* Wait for a previous command to complete. */
-	RHINE_WAIT_FOR(!(readb(ioaddr + MIICmd) & 0x60));
-	writeb(0x00, ioaddr + MIICmd);
+	rhine_disable_linkmon(ioaddr, rp->quirks);
+
+	writeb(0, ioaddr + MIICmd);
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
 	writeb(0x40, ioaddr + MIICmd);		/* Trigger read */
 	RHINE_WAIT_FOR(!(readb(ioaddr + MIICmd) & 0x40));
-	return readw(ioaddr + MIIData);
+	result = readw(ioaddr + MIIData);
+
+	rhine_enable_linkmon(ioaddr);
+	return result;
 }
 
 static void mdio_write(struct net_device *dev, int phy_id, int regnum, int value)
@@ -1094,29 +1136,17 @@
 	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
 
-	if (phy_id == rp->mii_if.phy_id) {
-		switch (regnum) {
-		case MII_BMCR:		/* Is user forcing speed/duplex? */
-			if (value & 0x9000)	/* Autonegotiation. */
-				rp->mii_if.force_media = 0;
-			else
-				rp->mii_if.full_duplex = (value & 0x0100) ? 1 : 0;
-			break;
-		case MII_ADVERTISE:
-			rp->mii_if.advertising = value;
-			break;
-		}
-	}
+	rhine_disable_linkmon(ioaddr, rp->quirks);
 
-	/* Wait for a previous command to complete. */
-	RHINE_WAIT_FOR(!(readb(ioaddr + MIICmd) & 0x60));
-	writeb(0x00, ioaddr + MIICmd);
+	writeb(0, ioaddr + MIICmd);
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
 	writew(value, ioaddr + MIIData);
 	writeb(0x20, ioaddr + MIICmd);		/* Trigger write. */
-}
+	RHINE_WAIT_FOR(!(readb(ioaddr + MIICmd) & 0x20));
 
+	rhine_enable_linkmon(ioaddr);
+}
 
 static int rhine_open(struct net_device *dev)
 {
@@ -1148,78 +1178,9 @@
 
 	netif_start_queue(dev);
 
-	/* Set the timer to check for link beat. */
-	init_timer(&rp->timer);
-	rp->timer.expires = jiffies + 2 * HZ/100;
-	rp->timer.data = (unsigned long)dev;
-	rp->timer.function = &rhine_timer;		/* timer handler */
-	add_timer(&rp->timer);
-
 	return 0;
 }
 
-static void rhine_check_duplex(struct net_device *dev)
-{
-	struct rhine_private *rp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-	int mii_lpa = mdio_read(dev, rp->mii_if.phy_id, MII_LPA);
-	int negotiated = mii_lpa & rp->mii_if.advertising;
-	int duplex;
-
-	if (rp->mii_if.force_media || mii_lpa == 0xffff)
-		return;
-	duplex = (negotiated & 0x0100) || (negotiated & 0x01C0) == 0x0040;
-	if (rp->mii_if.full_duplex != duplex) {
-		rp->mii_if.full_duplex = duplex;
-		if (debug)
-			printk(KERN_INFO "%s: Setting %s-duplex based on "
-			       "MII #%d link partner capability of %4.4x.\n",
-			       dev->name, duplex ? "full" : "half",
-			       rp->mii_if.phy_id, mii_lpa);
-		if (duplex)
-			writeb(readb(ioaddr + ChipCmd1) | Cmd1FDuplex,
-			       ioaddr + ChipCmd1);
-		else
-			writeb(readb(ioaddr + ChipCmd1) & ~Cmd1FDuplex,
-			       ioaddr + ChipCmd1);
-	}
-}
-
-
-static void rhine_timer(unsigned long data)
-{
-	struct net_device *dev = (struct net_device *)data;
-	struct rhine_private *rp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-	int next_tick = 10*HZ;
-	int mii_status;
-
-	if (debug > 3) {
-		printk(KERN_DEBUG "%s: VIA Rhine monitor tick, status %4.4x.\n",
-		       dev->name, readw(ioaddr + IntrStatus));
-	}
-
-	spin_lock_irq (&rp->lock);
-
-	rhine_check_duplex(dev);
-
-	/* make IFF_RUNNING follow the MII status bit "Link established" */
-	mii_status = mdio_read(dev, rp->mii_if.phy_id, MII_BMSR);
-	if ((mii_status & BMSR_LSTATUS) != (rp->mii_status & BMSR_LSTATUS)) {
-		if (mii_status & BMSR_LSTATUS)
-			netif_carrier_on(dev);
-		else
-			netif_carrier_off(dev);
-	}
-	rp->mii_status = mii_status;
-
-	spin_unlock_irq(&rp->lock);
-
-	rp->timer.expires = jiffies + next_tick;
-	add_timer(&rp->timer);
-}
-
-
 static void rhine_tx_timeout(struct net_device *dev)
 {
 	struct rhine_private *rp = netdev_priv(dev);
@@ -1256,8 +1217,8 @@
 static int rhine_start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct rhine_private *rp = netdev_priv(dev);
+	long ioaddr = dev->base_addr;
 	unsigned entry;
-	u32 intr_status;
 
 	/* Caution: the write order is important here, set the field
 	   with the "ownership" bits last. */
@@ -1308,15 +1269,9 @@
 
 	/* Non-x86 Todo: explicitly flush cache lines here. */
 
-	/*
-	 * Wake the potentially-idle transmit channel unless errors are
-	 * pending (the ISR must sort them out first).
-	 */
-	intr_status = get_intr_status(dev);
-	if ((intr_status & IntrTxErrSummary) == 0) {
-		writeb(readb(dev->base_addr + ChipCmd1) | Cmd1TxDemand,
-		       dev->base_addr + ChipCmd1);
-	}
+	/* Wake the potentially-idle transmit channel */
+	writeb(readb(ioaddr + ChipCmd1) | Cmd1TxDemand,
+	       ioaddr + ChipCmd1);
 	IOSYNC;
 
 	if (rp->cur_tx == rp->dirty_tx + TX_QUEUE_LEN)
@@ -1639,15 +1594,8 @@
 
 	spin_lock(&rp->lock);
 
-	if (intr_status & (IntrLinkChange)) {
-		rhine_check_duplex(dev);
-		if (debug)
-			printk(KERN_ERR "%s: MII status changed: "
-			       "Autonegotiation advertising %4.4x partner "
-			       "%4.4x.\n", dev->name,
-			       mdio_read(dev, rp->mii_if.phy_id, MII_ADVERTISE),
-			       mdio_read(dev, rp->mii_if.phy_id, MII_LPA));
-	}
+	if (intr_status & IntrLinkChange)
+		rhine_check_media(dev, 0);
 	if (intr_status & IntrStatsMax) {
 		rp->stats.rx_crc_errors += readw(ioaddr + RxCRCErrs);
 		rp->stats.rx_missed_errors += readw(ioaddr + RxMissed);
@@ -1839,8 +1786,6 @@
 	long ioaddr = dev->base_addr;
 	struct rhine_private *rp = netdev_priv(dev);
 
-	del_timer_sync(&rp->timer);
-
 	spin_lock_irq(&rp->lock);
 
 	netif_stop_queue(dev);

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=8

Bump driver version to mark recent major changes in driver code.

Remove backoff parameter. The reason it was once introduced is gone.
Continue to go with EEPROM default for now, will hard-wire IEEE backoff
algorithm instead (later).

Rhine-I needs extra time to recuperate from chip reset before EEPROM
reload.

Add Rhine model identification.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- orig/drivers/net/via-rhine.c
+++ mod/drivers/net/via-rhine.c
@@ -125,11 +125,16 @@
 	LK1.1.19 (Roger Luethi)
 	- Increase Tx threshold for unspecified errors
 
+	LK1.2.0-2.6 (Roger Luethi)
+	- Massive clean-up
+	- Rewrite PHY, media handling (remove options, full_duplex, backoff)
+	- Fix Tx engine race for good
+
 */
 
 #define DRV_NAME	"via-rhine"
-#define DRV_VERSION	"1.1.20-2.6"
-#define DRV_RELDATE	"May-23-2004"
+#define DRV_VERSION	"1.2.0-2.6"
+#define DRV_RELDATE	"June-10-2004"
 
 
 /* A few user-configurable values.
@@ -142,9 +147,6 @@
    Setting to > 1518 effectively disables this feature. */
 static int rx_copybreak;
 
-/* Select a backoff algorithm (Ethernet capture effect) */
-static int backoff;
-
 /*
  * In case you are looking for 'options[]' or 'full_duplex[]', they
  * are gone. Use ethtool(8) instead.
@@ -207,9 +209,6 @@
 static char version[] __devinitdata =
 KERN_INFO DRV_NAME ".c:v1.10-LK" DRV_VERSION " " DRV_RELDATE " Written by Donald Becker\n";
 
-static char shortname[] = DRV_NAME;
-
-
 /* This driver was written to use PCI memory space. Some early versions
    of the Rhine may only work correctly with I/O space accesses. */
 #ifdef CONFIG_VIA_RHINE_MMIO
@@ -236,11 +235,9 @@
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM(debug, "i");
 MODULE_PARM(rx_copybreak, "i");
-MODULE_PARM(backoff, "i");
 MODULE_PARM_DESC(max_interrupt_work, "VIA Rhine maximum events handled per interrupt");
 MODULE_PARM_DESC(debug, "VIA Rhine debug level (0-7)");
 MODULE_PARM_DESC(rx_copybreak, "VIA Rhine copy breakpoint for copy-only-tiny-frames");
-MODULE_PARM_DESC(backoff, "VIA Rhine: Bits 0-3: backoff algorithm");
 
 /*
 		Theory of Operation
@@ -343,17 +340,18 @@
 
 enum rhine_revs {
 	VT86C100A	= 0x00,
+	VTunknown0	= 0x20,
 	VT6102		= 0x40,
 	VT8231		= 0x50,	/* Integrated MAC */
 	VT8233		= 0x60,	/* Integrated MAC */
 	VT8235		= 0x74,	/* Integrated MAC */
 	VT8237		= 0x78,	/* Integrated MAC */
-	VTunknown0	= 0x7C,
+	VTunknown1	= 0x7C,
 	VT6105		= 0x80,
 	VT6105_B0	= 0x83,
 	VT6105L		= 0x8A,
 	VT6107		= 0x8C,
-	VTunknown1	= 0x8E,
+	VTunknown2	= 0x8E,
 	VT6105M		= 0x90,
 };
 
@@ -609,7 +607,7 @@
 
 /*
  * Loads bytes 0x00-0x05, 0x6E-0x6F, 0x78-0x7B from EEPROM
- * (plus 0x6C for Rhine I/II)
+ * (plus 0x6C for Rhine-I/II)
  */
 static void __devinit rhine_reload_eeprom(long pioaddr, struct net_device *dev)
 {
@@ -645,9 +643,15 @@
 
 static void rhine_hw_init(struct net_device *dev, long pioaddr)
 {
+	struct rhine_private *rp = netdev_priv(dev);
+
 	/* Reset the chip to erase previous misconfiguration. */
 	rhine_chip_reset(dev);
 
+	/* Rhine-I needs extra time to recuperate before EEPROM reload */
+	if (rp->quirks & rqRhineI)
+		msleep(5);
+
 	/* Reload EEPROM controlled bytes cleared by soft reset */
 	rhine_reload_eeprom(pioaddr, dev);
 }
@@ -660,12 +664,11 @@
 	int i, rc;
 	u8 pci_rev;
 	u32 quirks;
-	static int card_idx = -1;
 	long pioaddr;
 	long memaddr;
 	long ioaddr;
 	int io_size, phy_id;
-	const char *name;
+	const char *name, *mname;
 
 /* when built into the kernel, we only print version if device is found */
 #ifndef MODULE
@@ -678,22 +681,43 @@
 
 	io_size = 256;
 	phy_id = 0;
-	if (pci_rev < VT6102) {
+	quirks = 0;
+	name = "Rhine";
+	mname = "unknown";
+	if (pci_rev < VTunknown0) {
 		quirks = rqRhineI;
 		io_size = 128;
-		name = "VT86C100A Rhine";
+		mname = "VT86C100A";
 	}
-	else {
+	else if (pci_rev >= VT6102) {
 		quirks = rqWOL | rqForceReset;
 		if (pci_rev < VT6105) {
 			name = "Rhine II";
 			quirks |= rqStatusWBRace;	/* Rhine-II exclusive */
+			if (pci_rev < VT8231)
+				mname = "VT6102";
+			else if (pci_rev < VT8233)
+				mname = "VT8231";
+			else if (pci_rev < VT8235)
+				mname = "VT8233";
+			else if (pci_rev < VT8237)
+				mname = "VT8235";
+			else if (pci_rev < VTunknown1)
+				mname = "VT8237";
 		}
 		else {
 			name = "Rhine III";
 			phy_id = 1;	/* Integrated PHY, phy_id fixed to 1 */
 			if (pci_rev >= VT6105_B0)
 				quirks |= rq6patterns;
+			if (pci_rev < VT6105L)
+				mname = "VT6105";
+			else if (pci_rev < VT6107)
+				mname = "VT6105L";
+			else if (pci_rev < VT6105M)
+				mname = "VT6107";
+			else if (pci_rev >= VT6105M)
+				mname = "Management Adapter VT6105M";
 		}
 	}
 
@@ -722,17 +746,16 @@
 
 	pci_set_master(pdev);
 
-	dev = alloc_etherdev(sizeof(*rp));
-	if (dev == NULL) {
+	dev = alloc_etherdev(sizeof(struct rhine_private));
+	if (!dev) {
 		rc = -ENOMEM;
-		printk(KERN_ERR "init_ethernet failed for card #%d\n",
-		       card_idx);
+		printk(KERN_ERR "alloc_etherdev failed\n");
 		goto err_out;
 	}
 	SET_MODULE_OWNER(dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-	rc = pci_request_regions(pdev, shortname);
+	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
 		goto err_out_free_netdev;
 
@@ -768,9 +791,8 @@
 	rp = netdev_priv(dev);
 	rp->quirks = quirks;
 
+	/* Get chip registers into a sane state */
 	rhine_power_init(dev);
-
-	/* Reset the chip to erase previous misconfiguration. */
 	rhine_hw_init(dev, pioaddr);
 
 	for (i = 0; i < 6; i++)
@@ -778,16 +800,11 @@
 
 	if (!is_valid_ether_addr(dev->dev_addr)) {
 		rc = -EIO;
-		printk(KERN_ERR "Invalid MAC address for card #%d\n", card_idx);
+		printk(KERN_ERR "Invalid MAC address\n");
 		goto err_out_unmap;
 	}
 
-	/* Select backoff algorithm */
-	if (backoff)
-		writeb(readb(ioaddr + ConfigD) & (0xF0 | backoff),
-		       ioaddr + ConfigD);
-
-	/* For Rhine I/II, phy_id is loaded from EEPROM */
+	/* For Rhine-I/II, phy_id is loaded from EEPROM */
 	if (!phy_id)
 		phy_id = readb(ioaddr + 0x6C);
 
@@ -822,8 +839,8 @@
 	if (rc)
 		goto err_out_unmap;
 
-	printk(KERN_INFO "%s: VIA %s at 0x%lx, ",
-	       dev->name, name,
+	printk(KERN_INFO "%s: VIA %s (%s) at 0x%lx, ",
+	       dev->name, name, mname,
 #ifdef USE_MMIO
 		memaddr
 #else
@@ -1070,7 +1087,7 @@
 	       IntrPCIErr | IntrStatsMax | IntrLinkChange,
 	       ioaddr + IntrEnable);
 
-	writew(CmdStart|CmdTxOn|CmdRxOn|(Cmd1NoTxPoll << 8),
+	writew(CmdStart | CmdTxOn | CmdRxOn | (Cmd1NoTxPoll << 8),
 	       ioaddr + ChipCmd);
 	rhine_check_media(dev, 1);
 }
@@ -1142,7 +1159,7 @@
 	writeb(phy_id, ioaddr + MIIPhyAddr);
 	writeb(regnum, ioaddr + MIIRegAddr);
 	writew(value, ioaddr + MIIData);
-	writeb(0x20, ioaddr + MIICmd);		/* Trigger write. */
+	writeb(0x20, ioaddr + MIICmd);		/* Trigger write */
 	RHINE_WAIT_FOR(!(readb(ioaddr + MIICmd) & 0x20));
 
 	rhine_enable_linkmon(ioaddr);
@@ -1152,20 +1169,20 @@
 {
 	struct rhine_private *rp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
-	int i;
+	int rc;
 
-	i = request_irq(rp->pdev->irq, &rhine_interrupt, SA_SHIRQ, dev->name,
+	rc = request_irq(rp->pdev->irq, &rhine_interrupt, SA_SHIRQ, dev->name,
 			dev);
-	if (i)
-		return i;
+	if (rc)
+		return rc;
 
 	if (debug > 1)
 		printk(KERN_DEBUG "%s: rhine_open() irq %d.\n",
 		       dev->name, rp->pdev->irq);
 
-	i = alloc_ring(dev);
-	if (i)
-		return i;
+	rc = alloc_ring(dev);
+	if (rc)
+		return rc;
 	alloc_rbufs(dev);
 	alloc_tbufs(dev);
 	rhine_chip_reset(dev);
@@ -1482,10 +1499,6 @@
 							    rp->rx_buf_sz,
 							    PCI_DMA_FROMDEVICE);
 
-				/* *_IP_COPYSUM isn't defined anywhere and
-				   eth_copy_and_sum is memcpy for all archs so
-				   this is kind of pointless right now
-				   ... or? */
 				eth_copy_and_sum(skb,
 						 rp->rx_skbuff[entry]->tail,
 						 pkt_len, 0);
@@ -1574,7 +1587,6 @@
 		       ioaddr + ChipCmd);
 		writeb(readb(ioaddr + ChipCmd1) | Cmd1TxDemand,
 		       ioaddr + ChipCmd1);
-
 		IOSYNC;
 	}
 	else {
@@ -1834,7 +1846,7 @@
 
 
 static struct pci_driver rhine_driver = {
-	.name		= "via-rhine",
+	.name		= DRV_NAME,
 	.id_table	= rhine_pci_tbl,
 	.probe		= rhine_init_one,
 	.remove		= __devexit_p(rhine_remove_one),

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=9

Add rhine_shutdown callback to prepare Rhine power registers for
shutdown.

Add rhine_get_wol/rhine_set_wol for ethtool ioctl.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- 2.6-mm/drivers/net/via-rhine.c.orig	2004-06-15 18:34:21.000000000 +0200
+++ 2.6-mm/drivers/net/via-rhine.c	2004-06-15 18:36:12.000000000 +0200
@@ -394,8 +394,8 @@
 	ConfigA=0x78, ConfigB=0x79, ConfigC=0x7A, ConfigD=0x7B,
 	RxMissed=0x7C, RxCRCErrs=0x7E, MiscCmd=0x81,
 	StickyHW=0x83, IntrStatus2=0x84,
-	WOLcrSet=0xA0, WOLcrClr=0xA4, WOLcrClr1=0xA6,
-	WOLcgClr=0xA7,
+	WOLcrSet=0xA0, PwcfgSet=0xA1, WOLcgSet=0xA3, WOLcrClr=0xA4,
+	WOLcrClr1=0xA6, WOLcgClr=0xA7,
 	PwrcsrSet=0xA8, PwrcsrSet1=0xA9, PwrcsrClr=0xAC, PwrcsrClr1=0xAD,
 };
 
@@ -427,6 +427,15 @@
 	IntrTxErrSummary=0x082218,
 };
 
+/* Bits in WOLcrSet/WOLcrClr and PwrcsrSet/PwrcsrClr */
+enum wol_bits {
+	WOLucast	= 0x10,
+	WOLmagic	= 0x20,
+	WOLbmcast	= 0x30,
+	WOLlnkon	= 0x40,
+	WOLlnkoff	= 0x80,
+};
+
 /* The Rx and Tx buffer descriptors. */
 struct rx_desc {
 	s32 rx_status;
@@ -491,8 +500,8 @@
 	unsigned int cur_rx, dirty_rx;	/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
 	unsigned int rx_buf_sz;		/* Based on MTU+slack. */
+	u8 wolopts;
 
-	/* These values are keep track of the transceiver/media in use. */
 	u8 tx_thresh, rx_thresh;
 
 	struct mii_if_info mii_if;
@@ -512,6 +521,7 @@
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 static struct ethtool_ops netdev_ethtool_ops;
 static int  rhine_close(struct net_device *dev);
+static void rhine_shutdown (struct device *gdev);
 
 #define RHINE_WAIT_FOR(condition) do {					\
 	int i=1024;							\
@@ -537,12 +547,13 @@
 
 /*
  * Get power related registers into sane state.
- * Returns content of power-event (WOL) registers.
+ * Notify user about past WOL event.
  */
 static void rhine_power_init(struct net_device *dev)
 {
 	long ioaddr = dev->base_addr;
 	struct rhine_private *rp = netdev_priv(dev);
+	u16 wolstat;
 
 	if (rp->quirks & rqWOL) {
 		/* Make sure chip is in power state D0 */
@@ -557,10 +568,40 @@
 		if (rp->quirks & rq6patterns)
 			writeb(0x03, ioaddr + WOLcrClr1);
 
+		/* Save power-event status bits */
+		wolstat = readb(ioaddr + PwrcsrSet);
+		if (rp->quirks & rq6patterns)
+			wolstat |= (readb(ioaddr + PwrcsrSet1) & 0x03) << 8;
+
 		/* Clear power-event status bits */
 		writeb(0xFF, ioaddr + PwrcsrClr);
 		if (rp->quirks & rq6patterns)
 			writeb(0x03, ioaddr + PwrcsrClr1);
+
+		if (wolstat) {
+			char *reason;
+			switch (wolstat) {
+			case WOLmagic:
+				reason = "Magic packet";
+				break;
+			case WOLlnkon:
+				reason = "Link went up";
+				break;
+			case WOLlnkoff:
+				reason = "Link went down";
+				break;
+			case WOLucast:
+				reason = "Unicast packet";
+				break;
+			case WOLbmcast:
+				reason = "Multicast/broadcast packet";
+				break;
+			default:
+				reason = "Unknown";
+			}
+			printk("%s: Woke system up. Reason: %s.\n",
+			       DRV_NAME, reason);
+		}
 	}
 }
 
@@ -1766,6 +1807,39 @@
 	debug = value;
 }
 
+static void rhine_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct rhine_private *rp = netdev_priv(dev);
+
+	if (!(rp->quirks & rqWOL))
+		return;
+
+	spin_lock_irq(&rp->lock);
+	wol->supported = WAKE_PHY | WAKE_MAGIC |
+			 WAKE_UCAST | WAKE_MCAST | WAKE_BCAST;	/* Untested */
+	wol->wolopts = rp->wolopts;
+	spin_unlock_irq(&rp->lock);
+}
+
+static int rhine_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct rhine_private *rp = netdev_priv(dev);
+	u32 support = WAKE_PHY | WAKE_MAGIC |
+		      WAKE_UCAST | WAKE_MCAST | WAKE_BCAST;	/* Untested */
+
+	if (!(rp->quirks & rqWOL))
+		return -EINVAL;
+
+	if (wol->wolopts & ~support)
+		return -EINVAL;
+
+	spin_lock_irq(&rp->lock);
+	rp->wolopts = wol->wolopts;
+	spin_unlock_irq(&rp->lock);
+
+	return 0;
+}
+
 static struct ethtool_ops netdev_ethtool_ops = {
 	.get_drvinfo		= netdev_get_drvinfo,
 	.get_settings		= netdev_get_settings,
@@ -1774,6 +1848,8 @@
 	.get_link		= netdev_get_link,
 	.get_msglevel		= netdev_get_msglevel,
 	.set_msglevel		= netdev_set_msglevel,
+	.get_wol		= rhine_get_wol,
+	.set_wol		= rhine_set_wol,
 	.get_sg			= ethtool_op_get_sg,
 	.get_tx_csum		= ethtool_op_get_tx_csum,
 };
@@ -1844,12 +1920,51 @@
 	pci_set_drvdata(pdev, NULL);
 }
 
+static void rhine_shutdown (struct device *gendev)
+{
+	struct pci_dev *pdev = to_pci_dev(gendev);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rhine_private *rp = netdev_priv(dev);
+
+	long ioaddr = dev->base_addr;
+
+	rhine_power_init(dev);
+
+	/* Make sure we use pattern 0, 1 and not 4, 5 */
+	if (rp->quirks & rq6patterns)
+		writeb(0x04, ioaddr + 0xA7);
+
+	if (rp->wolopts & WAKE_MAGIC)
+		writeb(WOLmagic, ioaddr + WOLcrSet);
+
+	if (rp->wolopts & (WAKE_BCAST|WAKE_MCAST))
+		writeb(WOLbmcast, ioaddr + WOLcgSet);
+
+	if (rp->wolopts & WAKE_PHY)
+		writeb(WOLlnkon | WOLlnkoff, ioaddr + WOLcrSet);
+
+	if (rp->wolopts & WAKE_UCAST)
+		writeb(WOLucast, ioaddr + WOLcrSet);
+
+	/* Enable legacy WOL (for old motherboards) */
+	writeb(0x01, ioaddr + PwcfgSet);
+	writeb(readb(ioaddr + StickyHW) | 0x04, ioaddr + StickyHW);
+
+	/* Hit power state D3 (sleep) */
+	writeb(readb(ioaddr + StickyHW) | 0x03, ioaddr + StickyHW);
+
+	/* TODO: Check use of pci_enable_wake() */
+
+}
 
 static struct pci_driver rhine_driver = {
 	.name		= DRV_NAME,
 	.id_table	= rhine_pci_tbl,
 	.probe		= rhine_init_one,
 	.remove		= __devexit_p(rhine_remove_one),
+	.driver = {
+		.shutdown = rhine_shutdown,
+	}
 };

--WIyZ46R2i8wDzkSu--
