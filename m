Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269365AbUI3R0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269365AbUI3R0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269367AbUI3R0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:26:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:4030 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269365AbUI3RY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:24:57 -0400
Date: Thu, 30 Sep 2004 10:24:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Franz Pletz <franz_pletz@t-online.de>
cc: Michal Rokos <michal@rokos.info>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6] Natsemi - remove compilation warnings
In-Reply-To: <415C37D8.20203@t-online.de>
Message-ID: <Pine.LNX.4.58.0409300951150.2403@ppc970.osdl.org>
References: <200409230958.31758.michal@rokos.info> <200409231618.56861.michal@rokos.info>
 <415C37D8.20203@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Sep 2004, Franz Pletz wrote:
>
> It seems like your patch unfortunately went into 2.6.9-rc2-mm[3,4] and 
> 2.6.9-rc3.

It's definitely not in _my_ -rc3. Which kernel are you looking at?

> My Natsemi network card stops working with 2.6.9-rc3. After succesfully 
> revoking your patch from 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm3/broken-out/natsemi-remove-compilation-warnings.patch
> everything works fine.

That patch does indeed look totally bogus. The reason a lot of network
drivers complain about readl/writel is that "struct net_device" is very
confused about what the IO addresses mean, and they mean different things
for different users. Which makes type safety basically disappear, and now
that we check it more carefully, things break.

This patch should clean up natsemi.c a bit, and makes the warnings go 
away. Does it work for you? (It really should, it's just a basic 
search-and-replace fix).

This is bigger than the broken patch, but that's really pretty
unavoidable, unless "struct net_device" is fixed. And the way it's
structured, if "net_device" ever _is_ fixed, this driver will now be
trivially updated.

		Linus

----
===== drivers/net/natsemi.c 1.68 vs edited =====
--- 1.68/drivers/net/natsemi.c	2004-07-27 11:18:53 -07:00
+++ edited/drivers/net/natsemi.c	2004-09-30 10:22:44 -07:00
@@ -719,7 +719,7 @@
 };
 
 static void move_int_phy(struct net_device *dev, int addr);
-static int eeprom_read(long ioaddr, int location);
+static int eeprom_read(void __iomem *ioaddr, int location);
 static int mdio_read(struct net_device *dev, int reg);
 static void mdio_write(struct net_device *dev, int reg, u16 data);
 static void init_phy_fixup(struct net_device *dev);
@@ -769,9 +769,15 @@
 static int netdev_get_regs(struct net_device *dev, u8 *buf);
 static int netdev_get_eeprom(struct net_device *dev, u8 *buf);
 
+static inline void __iomem *ns_ioaddr(struct net_device *dev)
+{
+	return (void __iomem *) dev->base_addr;
+}
+
 static void move_int_phy(struct net_device *dev, int addr)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
 	int target = 31;
 
 	/* 
@@ -788,8 +794,8 @@
 		target--;
 	if (target == np->phy_addr_external)
 		target--;
-	writew(target, dev->base_addr + PhyCtrl);
-	readw(dev->base_addr + PhyCtrl);
+	writew(target, ioaddr + PhyCtrl);
+	readw(ioaddr + PhyCtrl);
 	udelay(1);
 }
 
@@ -800,7 +806,8 @@
 	struct netdev_private *np;
 	int i, option, irq, chip_idx = ent->driver_data;
 	static int find_cnt = -1;
-	unsigned long ioaddr, iosize;
+	unsigned long iostart, iosize;
+	void __iomem *ioaddr;
 	const int pcibar = 1; /* PCI base address register */
 	int prev_eedata;
 	u32 tmp;
@@ -827,7 +834,7 @@
 	}
 
 	find_cnt++;
-	ioaddr = pci_resource_start(pdev, pcibar);
+	iostart = pci_resource_start(pdev, pcibar);
 	iosize = pci_resource_len(pdev, pcibar);
 	irq = pdev->irq;
 
@@ -844,7 +851,7 @@
 	if (i)
 		goto err_pci_request_regions;
 
-	ioaddr = (unsigned long) ioremap (ioaddr, iosize);
+	ioaddr = ioremap(iostart, iosize);
 	if (!ioaddr) {
 		i = -ENOMEM;
 		goto err_ioremap;
@@ -859,7 +866,7 @@
 		prev_eedata = eedata;
 	}
 
-	dev->base_addr = ioaddr;
+	dev->base_addr = (unsigned long __force) ioaddr;
 	dev->irq = irq;
 
 	np = netdev_priv(dev);
@@ -879,7 +886,7 @@
 	 * The address would be used to access a phy over the mii bus, but
 	 * the internal phy is accessed through mapped registers.
 	 */
-	if (readl(dev->base_addr + ChipConfig) & CfgExtPhy)
+	if (readl(ioaddr + ChipConfig) & CfgExtPhy)
 		dev->if_port = PORT_MII;
 	else
 		dev->if_port = PORT_TP;
@@ -971,7 +978,7 @@
 
 	if (netif_msg_drv(np)) {
 		printk(KERN_INFO "natsemi %s: %s at %#08lx (%s), ",
-			dev->name, natsemi_pci_info[chip_idx].name, ioaddr,
+			dev->name, natsemi_pci_info[chip_idx].name, iostart,
 			pci_name(np->pci_dev));
 		for (i = 0; i < ETH_ALEN-1; i++)
 				printk("%02x:", dev->dev_addr[i]);
@@ -984,7 +991,7 @@
 	return 0;
 
  err_register_netdev:
-	iounmap ((void *) dev->base_addr);
+	iounmap(ioaddr);
 
  err_ioremap:
 	pci_release_regions(pdev);
@@ -1016,12 +1023,13 @@
 	EE_WriteCmd=(5 << 6), EE_ReadCmd=(6 << 6), EE_EraseCmd=(7 << 6),
 };
 
-static int eeprom_read(long addr, int location)
+static int eeprom_read(void __iomem *addr, int location)
 {
 	int i;
 	int retval = 0;
-	long ee_addr = addr + EECtrl;
+	void __iomem *ee_addr = addr + EECtrl;
 	int read_cmd = location | EE_ReadCmd;
+
 	writel(EE_Write0, ee_addr);
 
 	/* Shift the read command bits out. */
@@ -1058,15 +1066,16 @@
 /* clock transitions >= 20ns (25MHz)
  * One readl should be good to PCI @ 100MHz
  */
-#define mii_delay(dev)  readl(dev->base_addr + EECtrl)
+#define mii_delay(dev)  readl(ioaddr + EECtrl)
 
 static int mii_getbit (struct net_device *dev)
 {
 	int data;
+	void __iomem *ioaddr = ns_ioaddr(dev);
 
-	writel(MII_ShiftClk, dev->base_addr + EECtrl);
-	data = readl(dev->base_addr + EECtrl);
-	writel(0, dev->base_addr + EECtrl);
+	writel(MII_ShiftClk, ioaddr + EECtrl);
+	data = readl(ioaddr + EECtrl);
+	writel(0, ioaddr + EECtrl);
 	mii_delay(dev);
 	return (data & MII_Data)? 1 : 0;
 }
@@ -1074,16 +1083,17 @@
 static void mii_send_bits (struct net_device *dev, u32 data, int len)
 {
 	u32 i;
+	void __iomem *ioaddr = ns_ioaddr(dev);
 
 	for (i = (1 << (len-1)); i; i >>= 1)
 	{
 		u32 mdio_val = MII_Write | ((data & i)? MII_Data : 0);
-		writel(mdio_val, dev->base_addr + EECtrl);
+		writel(mdio_val, ioaddr + EECtrl);
 		mii_delay(dev);
-		writel(mdio_val | MII_ShiftClk, dev->base_addr + EECtrl);
+		writel(mdio_val | MII_ShiftClk, ioaddr + EECtrl);
 		mii_delay(dev);
 	}
-	writel(0, dev->base_addr + EECtrl);
+	writel(0, ioaddr + EECtrl);
 	mii_delay(dev);
 }
 
@@ -1129,13 +1139,14 @@
 static int mdio_read(struct net_device *dev, int reg)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
 
 	/* The 83815 series has two ports:
 	 * - an internal transceiver
 	 * - an external mii bus
 	 */
 	if (dev->if_port == PORT_TP)
-		return readw(dev->base_addr+BasicControl+(reg<<2));
+		return readw(ioaddr+BasicControl+(reg<<2));
 	else
 		return miiport_read(dev, np->phy_addr_external, reg);
 }
@@ -1143,10 +1154,11 @@
 static void mdio_write(struct net_device *dev, int reg, u16 data)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
 
 	/* The 83815 series has an internal transceiver; handle separately */
 	if (dev->if_port == PORT_TP)
-		writew(data, dev->base_addr+BasicControl+(reg<<2));
+		writew(data, ioaddr+BasicControl+(reg<<2));
 	else
 		miiport_write(dev, np->phy_addr_external, reg, data);
 }
@@ -1154,7 +1166,7 @@
 static void init_phy_fixup(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem *ioaddr = ns_ioaddr(dev);
 	int i;
 	u32 cfg;
 	u16 tmp;
@@ -1186,7 +1198,7 @@
 		 */
 	}
 	mdio_write(dev, MII_BMCR, tmp);
-	readl(dev->base_addr + ChipConfig);
+	readl(ioaddr + ChipConfig);
 	udelay(1);
 
 	/* find out what phy this is */
@@ -1208,7 +1220,7 @@
 	default:
 		break;
 	}
-	cfg = readl(dev->base_addr + ChipConfig);
+	cfg = readl(ioaddr + ChipConfig);
 	if (cfg & CfgExtPhy)
 		return;
 
@@ -1266,9 +1278,10 @@
 static int switch_port_external(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
 	u32 cfg;
 
-	cfg = readl(dev->base_addr + ChipConfig);
+	cfg = readl(ioaddr + ChipConfig);
 	if (cfg & CfgExtPhy)
 		return 0;
 
@@ -1278,8 +1291,8 @@
 	}
 
 	/* 1) switch back to external phy */
-	writel(cfg | (CfgExtPhy | CfgPhyDis), dev->base_addr + ChipConfig);
-	readl(dev->base_addr + ChipConfig);
+	writel(cfg | (CfgExtPhy | CfgPhyDis), ioaddr + ChipConfig);
+	readl(ioaddr + ChipConfig);
 	udelay(1);
 
 	/* 2) reset the external phy: */
@@ -1298,11 +1311,12 @@
 static int switch_port_internal(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
 	int i;
 	u32 cfg;
 	u16 bmcr;
 
-	cfg = readl(dev->base_addr + ChipConfig);
+	cfg = readl(ioaddr + ChipConfig);
 	if (!(cfg &CfgExtPhy))
 		return 0;
 
@@ -1312,17 +1326,17 @@
 	}
 	/* 1) switch back to internal phy: */
 	cfg = cfg & ~(CfgExtPhy | CfgPhyDis);
-	writel(cfg, dev->base_addr + ChipConfig);
-	readl(dev->base_addr + ChipConfig);
+	writel(cfg, ioaddr + ChipConfig);
+	readl(ioaddr + ChipConfig);
 	udelay(1);
 	
 	/* 2) reset the internal phy: */
-	bmcr = readw(dev->base_addr+BasicControl+(MII_BMCR<<2));
-	writel(bmcr | BMCR_RESET, dev->base_addr+BasicControl+(MII_BMCR<<2));
-	readl(dev->base_addr + ChipConfig);
+	bmcr = readw(ioaddr+BasicControl+(MII_BMCR<<2));
+	writel(bmcr | BMCR_RESET, ioaddr+BasicControl+(MII_BMCR<<2));
+	readl(ioaddr + ChipConfig);
 	udelay(10);
 	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
-		bmcr = readw(dev->base_addr+BasicControl+(MII_BMCR<<2));
+		bmcr = readw(ioaddr+BasicControl+(MII_BMCR<<2));
 		if (!(bmcr & BMCR_RESET))
 			break;
 		udelay(10);
@@ -1398,6 +1412,7 @@
 	u16 pmatch[3];
 	u16 sopass[3];
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
 
 	/*
 	 * Resetting the chip causes some registers to be lost.
@@ -1408,26 +1423,26 @@
 	 */
 
 	/* CFG */
-	cfg = readl(dev->base_addr + ChipConfig) & CFG_RESET_SAVE;
+	cfg = readl(ioaddr + ChipConfig) & CFG_RESET_SAVE;
 	/* WCSR */
-	wcsr = readl(dev->base_addr + WOLCmd) & WCSR_RESET_SAVE;
+	wcsr = readl(ioaddr + WOLCmd) & WCSR_RESET_SAVE;
 	/* RFCR */
-	rfcr = readl(dev->base_addr + RxFilterAddr) & RFCR_RESET_SAVE;
+	rfcr = readl(ioaddr + RxFilterAddr) & RFCR_RESET_SAVE;
 	/* PMATCH */
 	for (i = 0; i < 3; i++) {
-		writel(i*2, dev->base_addr + RxFilterAddr);
-		pmatch[i] = readw(dev->base_addr + RxFilterData);
+		writel(i*2, ioaddr + RxFilterAddr);
+		pmatch[i] = readw(ioaddr + RxFilterData);
 	}
 	/* SOPAS */
 	for (i = 0; i < 3; i++) {
-		writel(0xa+(i*2), dev->base_addr + RxFilterAddr);
-		sopass[i] = readw(dev->base_addr + RxFilterData);
+		writel(0xa+(i*2), ioaddr + RxFilterAddr);
+		sopass[i] = readw(ioaddr + RxFilterData);
 	}
 
 	/* now whack the chip */
-	writel(ChipReset, dev->base_addr + ChipCmd);
+	writel(ChipReset, ioaddr + ChipCmd);
 	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
-		if (!(readl(dev->base_addr + ChipCmd) & ChipReset))
+		if (!(readl(ioaddr + ChipCmd) & ChipReset))
 			break;
 		udelay(5);
 	}
@@ -1440,40 +1455,41 @@
 	}
 
 	/* restore CFG */
-	cfg |= readl(dev->base_addr + ChipConfig) & ~CFG_RESET_SAVE;
+	cfg |= readl(ioaddr + ChipConfig) & ~CFG_RESET_SAVE;
 	/* turn on external phy if it was selected */
 	if (dev->if_port == PORT_TP)
 		cfg &= ~(CfgExtPhy | CfgPhyDis);
 	else
 		cfg |= (CfgExtPhy | CfgPhyDis);
-	writel(cfg, dev->base_addr + ChipConfig);
+	writel(cfg, ioaddr + ChipConfig);
 	/* restore WCSR */
-	wcsr |= readl(dev->base_addr + WOLCmd) & ~WCSR_RESET_SAVE;
-	writel(wcsr, dev->base_addr + WOLCmd);
+	wcsr |= readl(ioaddr + WOLCmd) & ~WCSR_RESET_SAVE;
+	writel(wcsr, ioaddr + WOLCmd);
 	/* read RFCR */
-	rfcr |= readl(dev->base_addr + RxFilterAddr) & ~RFCR_RESET_SAVE;
+	rfcr |= readl(ioaddr + RxFilterAddr) & ~RFCR_RESET_SAVE;
 	/* restore PMATCH */
 	for (i = 0; i < 3; i++) {
-		writel(i*2, dev->base_addr + RxFilterAddr);
-		writew(pmatch[i], dev->base_addr + RxFilterData);
+		writel(i*2, ioaddr + RxFilterAddr);
+		writew(pmatch[i], ioaddr + RxFilterData);
 	}
 	for (i = 0; i < 3; i++) {
-		writel(0xa+(i*2), dev->base_addr + RxFilterAddr);
-		writew(sopass[i], dev->base_addr + RxFilterData);
+		writel(0xa+(i*2), ioaddr + RxFilterAddr);
+		writew(sopass[i], ioaddr + RxFilterData);
 	}
 	/* restore RFCR */
-	writel(rfcr, dev->base_addr + RxFilterAddr);
+	writel(rfcr, ioaddr + RxFilterAddr);
 }
 
 static void natsemi_reload_eeprom(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
 	int i;
 
-	writel(EepromReload, dev->base_addr + PCIBusCfg);
+	writel(EepromReload, ioaddr + PCIBusCfg);
 	for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
 		udelay(50);
-		if (!(readl(dev->base_addr + PCIBusCfg) & EepromReload))
+		if (!(readl(ioaddr + PCIBusCfg) & EepromReload))
 			break;
 	}
 	if (i==NATSEMI_HW_TIMEOUT) {
@@ -1487,7 +1503,7 @@
 
 static void natsemi_stop_rxtx(struct net_device *dev)
 {
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 	int i;
 
@@ -1509,7 +1525,7 @@
 static int netdev_open(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	int i;
 
 	/* Reset the chip, just in case. */
@@ -1558,6 +1574,7 @@
 static void do_cable_magic(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = ns_ioaddr(dev);
 
 	if (dev->if_port != PORT_TP)
 		return;
@@ -1571,15 +1588,15 @@
 	 * activity LED while idle.  This process is based on instructions
 	 * from engineers at National.
 	 */
-	if (readl(dev->base_addr + ChipConfig) & CfgSpeed100) {
+	if (readl(ioaddr + ChipConfig) & CfgSpeed100) {
 		u16 data;
 
-		writew(1, dev->base_addr + PGSEL);
+		writew(1, ioaddr + PGSEL);
 		/*
 		 * coefficient visibility should already be enabled via
 		 * DSPCFG | 0x1000
 		 */
-		data = readw(dev->base_addr + TSTDAT) & 0xff;
+		data = readw(ioaddr + TSTDAT) & 0xff;
 		/*
 		 * the value must be negative, and within certain values
 		 * (these values all come from National)
@@ -1588,13 +1605,13 @@
 			struct netdev_private *np = netdev_priv(dev);
 
 			/* the bug has been triggered - fix the coefficient */
-			writew(TSTDAT_FIXED, dev->base_addr + TSTDAT);
+			writew(TSTDAT_FIXED, ioaddr + TSTDAT);
 			/* lock the value */
-			data = readw(dev->base_addr + DSPCFG);
+			data = readw(ioaddr + DSPCFG);
 			np->dspcfg = data | DSPCFG_LOCK;
-			writew(np->dspcfg, dev->base_addr + DSPCFG);
+			writew(np->dspcfg, ioaddr + DSPCFG);
 		}
-		writew(0, dev->base_addr + PGSEL);
+		writew(0, ioaddr + PGSEL);
 	}
 }
 
@@ -1602,6 +1619,7 @@
 {
 	u16 data;
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	if (dev->if_port != PORT_TP)
 		return;
@@ -1609,18 +1627,18 @@
 	if (np->srr >= SRR_DP83816_A5)
 		return;
 
-	writew(1, dev->base_addr + PGSEL);
+	writew(1, ioaddr + PGSEL);
 	/* make sure the lock bit is clear */
-	data = readw(dev->base_addr + DSPCFG);
+	data = readw(ioaddr + DSPCFG);
 	np->dspcfg = data & ~DSPCFG_LOCK;
-	writew(np->dspcfg, dev->base_addr + DSPCFG);
-	writew(0, dev->base_addr + PGSEL);
+	writew(np->dspcfg, ioaddr + DSPCFG);
+	writew(0, ioaddr + PGSEL);
 }
 
 static void check_link(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	int duplex;
 	u16 bmsr;
        
@@ -1681,7 +1699,7 @@
 static void init_registers(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	init_phy_fixup(dev);
 
@@ -1760,6 +1778,7 @@
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	int next_tick = 5*HZ;
 
 	if (netif_msg_timer(np)) {
@@ -1771,7 +1790,6 @@
 	}
 
 	if (dev->if_port == PORT_TP) {
-		long ioaddr = dev->base_addr;
 		u16 dspcfg;
 
 		spin_lock_irq(&np->lock);
@@ -1814,7 +1832,7 @@
 		refill_rx(dev);
 		enable_irq(dev->irq);
 		if (!np->oom) {
-			writel(RxOn, dev->base_addr + ChipCmd);
+			writel(RxOn, ioaddr + ChipCmd);
 		} else {
 			next_tick = 1;
 		}
@@ -1848,7 +1866,7 @@
 static void tx_timeout(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	disable_irq(dev->irq);
 	spin_lock_irq(&np->lock);
@@ -2048,6 +2066,7 @@
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	unsigned entry;
 
 	/* Note: Ordering is important here, set the field with the
@@ -2076,7 +2095,7 @@
 				netif_stop_queue(dev);
 		}
 		/* Wake the potentially-idle transmit channel. */
-		writel(TxOn, dev->base_addr + ChipCmd);
+		writel(TxOn, ioaddr + ChipCmd);
 	} else {
 		dev_kfree_skb_irq(skb);
 		np->stats.tx_dropped++;
@@ -2141,7 +2160,7 @@
 {
 	struct net_device *dev = dev_instance;
 	struct netdev_private *np = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	int boguscnt = max_interrupt_work;
 	unsigned int handled = 0;
 
@@ -2203,6 +2222,7 @@
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	s32 desc_status = le32_to_cpu(np->rx_head_desc->cmd_status);
 	unsigned int buflen = np->rx_buf_sz;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	/* If the driver owns the next entry it's a new packet. Send it up. */
 	while (desc_status < 0) { /* e.g. & DescOwn */
@@ -2284,13 +2304,13 @@
 	if (np->oom)
 		mod_timer(&np->timer, jiffies + 1);
 	else
-		writel(RxOn, dev->base_addr + ChipCmd);
+		writel(RxOn, ioaddr + ChipCmd);
 }
 
 static void netdev_error(struct net_device *dev, int intr_status)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	spin_lock(&np->lock);
 	if (intr_status & LinkChange) {
@@ -2349,7 +2369,7 @@
 
 static void __get_stats(struct net_device *dev)
 {
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 
 	/* The chip only need report frame silently dropped. */
@@ -2382,7 +2402,7 @@
 #define HASH_TABLE	0x200
 static void __set_rx_mode(struct net_device *dev)
 {
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 	u8 mc_filter[64]; /* Multicast hash filter */
 	u32 rx_mode;
@@ -2428,7 +2448,7 @@
 	/* synchronized against open : rtnl_lock() held by caller */
 	if (netif_running(dev)) {
 		struct netdev_private *np = netdev_priv(dev);
-		long ioaddr = dev->base_addr;
+		void __iomem * ioaddr = ns_ioaddr(dev);
 
 		disable_irq(dev->irq);
 		spin_lock(&np->lock);
@@ -2631,7 +2651,8 @@
 static int netdev_set_wol(struct net_device *dev, u32 newval)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	u32 data = readl(dev->base_addr + WOLCmd) & ~WakeOptsSummary;
+	void __iomem * ioaddr = ns_ioaddr(dev);
+	u32 data = readl(ioaddr + WOLCmd) & ~WakeOptsSummary;
 
 	/* translate to bitmasks this chip understands */
 	if (newval & WAKE_PHY)
@@ -2652,7 +2673,7 @@
 		}
 	}
 
-	writel(data, dev->base_addr + WOLCmd);
+	writel(data, ioaddr + WOLCmd);
 
 	return 0;
 }
@@ -2660,7 +2681,8 @@
 static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 *cur)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	u32 regval = readl(dev->base_addr + WOLCmd);
+	void __iomem * ioaddr = ns_ioaddr(dev);
+	u32 regval = readl(ioaddr + WOLCmd);
 
 	*supported = (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST
 			| WAKE_ARP | WAKE_MAGIC);
@@ -2695,6 +2717,7 @@
 static int netdev_set_sopass(struct net_device *dev, u8 *newval)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	u16 *sval = (u16 *)newval;
 	u32 addr;
 
@@ -2703,22 +2726,22 @@
 	}
 
 	/* enable writing to these registers by disabling the RX filter */
-	addr = readl(dev->base_addr + RxFilterAddr) & ~RFCRAddressMask;
+	addr = readl(ioaddr + RxFilterAddr) & ~RFCRAddressMask;
 	addr &= ~RxFilterEnable;
-	writel(addr, dev->base_addr + RxFilterAddr);
+	writel(addr, ioaddr + RxFilterAddr);
 
 	/* write the three words to (undocumented) RFCR vals 0xa, 0xc, 0xe */
-	writel(addr | 0xa, dev->base_addr + RxFilterAddr);
-	writew(sval[0], dev->base_addr + RxFilterData);
+	writel(addr | 0xa, ioaddr + RxFilterAddr);
+	writew(sval[0], ioaddr + RxFilterData);
 
-	writel(addr | 0xc, dev->base_addr + RxFilterAddr);
-	writew(sval[1], dev->base_addr + RxFilterData);
+	writel(addr | 0xc, ioaddr + RxFilterAddr);
+	writew(sval[1], ioaddr + RxFilterData);
 
-	writel(addr | 0xe, dev->base_addr + RxFilterAddr);
-	writew(sval[2], dev->base_addr + RxFilterData);
+	writel(addr | 0xe, ioaddr + RxFilterAddr);
+	writew(sval[2], ioaddr + RxFilterData);
 
 	/* re-enable the RX filter */
-	writel(addr | RxFilterEnable, dev->base_addr + RxFilterAddr);
+	writel(addr | RxFilterEnable, ioaddr + RxFilterAddr);
 
 	return 0;
 }
@@ -2726,6 +2749,7 @@
 static int netdev_get_sopass(struct net_device *dev, u8 *data)
 {
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	u16 *sval = (u16 *)data;
 	u32 addr;
 
@@ -2735,18 +2759,18 @@
 	}
 
 	/* read the three words from (undocumented) RFCR vals 0xa, 0xc, 0xe */
-	addr = readl(dev->base_addr + RxFilterAddr) & ~RFCRAddressMask;
+	addr = readl(ioaddr + RxFilterAddr) & ~RFCRAddressMask;
 
-	writel(addr | 0xa, dev->base_addr + RxFilterAddr);
-	sval[0] = readw(dev->base_addr + RxFilterData);
+	writel(addr | 0xa, ioaddr + RxFilterAddr);
+	sval[0] = readw(ioaddr + RxFilterData);
 
-	writel(addr | 0xc, dev->base_addr + RxFilterAddr);
-	sval[1] = readw(dev->base_addr + RxFilterData);
+	writel(addr | 0xc, ioaddr + RxFilterAddr);
+	sval[1] = readw(ioaddr + RxFilterData);
 
-	writel(addr | 0xe, dev->base_addr + RxFilterAddr);
-	sval[2] = readw(dev->base_addr + RxFilterData);
+	writel(addr | 0xe, ioaddr + RxFilterAddr);
+	sval[2] = readw(ioaddr + RxFilterData);
 
-	writel(addr, dev->base_addr + RxFilterAddr);
+	writel(addr, ioaddr + RxFilterAddr);
 
 	return 0;
 }
@@ -2909,10 +2933,11 @@
 	int j;
 	u32 rfcr;
 	u32 *rbuf = (u32 *)buf;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	/* read non-mii page 0 of registers */
 	for (i = 0; i < NATSEMI_PG0_NREGS/2; i++) {
-		rbuf[i] = readl(dev->base_addr + i*4);
+		rbuf[i] = readl(ioaddr + i*4);
 	}
 
 	/* read current mii registers */
@@ -2920,20 +2945,20 @@
 		rbuf[i] = mdio_read(dev, i & 0x1f);
 
 	/* read only the 'magic' registers from page 1 */
-	writew(1, dev->base_addr + PGSEL);
-	rbuf[i++] = readw(dev->base_addr + PMDCSR);
-	rbuf[i++] = readw(dev->base_addr + TSTDAT);
-	rbuf[i++] = readw(dev->base_addr + DSPCFG);
-	rbuf[i++] = readw(dev->base_addr + SDCFG);
-	writew(0, dev->base_addr + PGSEL);
+	writew(1, ioaddr + PGSEL);
+	rbuf[i++] = readw(ioaddr + PMDCSR);
+	rbuf[i++] = readw(ioaddr + TSTDAT);
+	rbuf[i++] = readw(ioaddr + DSPCFG);
+	rbuf[i++] = readw(ioaddr + SDCFG);
+	writew(0, ioaddr + PGSEL);
 
 	/* read RFCR indexed registers */
-	rfcr = readl(dev->base_addr + RxFilterAddr);
+	rfcr = readl(ioaddr + RxFilterAddr);
 	for (j = 0; j < NATSEMI_RFDR_NREGS; j++) {
-		writel(j*2, dev->base_addr + RxFilterAddr);
-		rbuf[i++] = readw(dev->base_addr + RxFilterData);
+		writel(j*2, ioaddr + RxFilterAddr);
+		rbuf[i++] = readw(ioaddr + RxFilterData);
 	}
-	writel(rfcr, dev->base_addr + RxFilterAddr);
+	writel(rfcr, ioaddr + RxFilterAddr);
 
 	/* the interrupt status is clear-on-read - see if we missed any */
 	if (rbuf[4] & rbuf[5]) {
@@ -2958,10 +2983,11 @@
 {
 	int i;
 	u16 *ebuf = (u16 *)buf;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	/* eeprom_read reads 16 bits, and indexes by 16 bits */
 	for (i = 0; i < NATSEMI_EEPROM_SIZE/2; i++) {
-		ebuf[i] = eeprom_read(dev->base_addr, i);
+		ebuf[i] = eeprom_read(ioaddr, i);
 		/* The EEPROM itself stores data bit-swapped, but eeprom_read
 		 * reads it back "sanely". So we swap it back here in order to
 		 * present it to userland as it is stored. */
@@ -3031,7 +3057,7 @@
 
 static void enable_wol_mode(struct net_device *dev, int enable_intr)
 {
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 
 	if (netif_msg_wol(np))
@@ -3064,7 +3090,7 @@
 
 static int netdev_close(struct net_device *dev)
 {
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 
 	if (netif_msg_ifdown(np))
@@ -3141,10 +3167,11 @@
 static void __devexit natsemi_remove1 (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	unregister_netdev (dev);
 	pci_release_regions (pdev);
-	iounmap ((char *) dev->base_addr);
+	iounmap(ioaddr);
 	free_netdev (dev);
 	pci_set_drvdata(pdev, NULL);
 }
@@ -3178,7 +3205,7 @@
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
+	void __iomem * ioaddr = ns_ioaddr(dev);
 
 	rtnl_lock();
 	if (netif_running (dev)) {
