Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUIXPCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUIXPCh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUIXPCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:02:37 -0400
Received: from holub.nextsoft.cz ([195.122.198.235]:16583 "EHLO
	holub.nextsoft.cz") by vger.kernel.org with ESMTP id S267388AbUIXO77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:59:59 -0400
From: Michal Rokos <michal@rokos.info>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.9-rc2-mm3
Date: Fri, 24 Sep 2004 16:59:28 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040924014643.484470b1.akpm@osdl.org> <4153EED2.1050508@yahoo.com.au> <20040924102506.GB9106@holomorphy.com>
In-Reply-To: <20040924102506.GB9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241659.28475.michal@rokos.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I gave 1 more try for "natsemi-remove-compilation-warnings.patch".
(It means I rewrote it)

Could you test it? (I did - it works - but who knows :) )

Usage:
1) remove: natsemi-remove-compilation-warnings.patch from -mm3.
2) add: this one
3) pray

BR

Michal

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/24 16:42:19+02:00 michal@nb-rokos.nx.cz 
#   [PATCH 2.6] natsemi - tiny cleanup (ioaddr)
# 
# drivers/net/natsemi.c
#   2004/09/24 16:42:07+02:00 michal@nb-rokos.nx.cz +129 -111
#   Natsemi ioaddr cleanups - II
# 
# ChangeSet
#   2004/09/24 16:08:33+02:00 michal@nb-rokos.nx.cz 
#   [PATCH 2.6] natsemi - fix compile-time warnings
# 
# drivers/net/natsemi.c
#   2004/09/24 16:08:18+02:00 michal@nb-rokos.nx.cz +118 -118
#   Fix compile-time warnings.
# 
diff -Nru a/drivers/net/natsemi.c b/drivers/net/natsemi.c
--- a/drivers/net/natsemi.c 2004-09-24 16:53:46 +02:00
+++ b/drivers/net/natsemi.c 2004-09-24 16:53:46 +02:00
@@ -257,13 +257,13 @@
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
-MODULE_PARM_DESC(max_interrupt_work, 
+MODULE_PARM_DESC(max_interrupt_work,
  "DP8381x maximum events handled per interrupt");
 MODULE_PARM_DESC(mtu, "DP8381x MTU (all boards)");
 MODULE_PARM_DESC(debug, "DP8381x default debug level");
-MODULE_PARM_DESC(rx_copybreak, 
+MODULE_PARM_DESC(rx_copybreak,
  "DP8381x copy breakpoint for copy-only-tiny-frames");
-MODULE_PARM_DESC(options, 
+MODULE_PARM_DESC(options,
  "DP8381x: Bits 0-3: media type, bit 17: full duplex");
 MODULE_PARM_DESC(full_duplex, "DP8381x full duplex setting(s) (1)");
 
@@ -372,7 +372,7 @@
 #define MII_FX_SEL 0x0001 /* 100BASE-FX (fiber) */
 #define MII_EN_SCRM 0x0004 /* enable scrambler (tp) */
 
- 
+
 /* array of board data directly indexed by pci_tbl[x].driver_data */
 static struct {
  const char *name;
@@ -540,7 +540,7 @@
  TxCarrierIgn  = 0x80000000
 };
 
-/* 
+/*
  * Tx Configuration:
  * - 256 byte DMA burst length
  * - fill threshold 512 bytes (i.e. restart DMA when 512 bytes are 
free)
@@ -719,7 +719,7 @@
 };
 
 static void move_int_phy(struct net_device *dev, int addr);
-static int eeprom_read(long ioaddr, int location);
+static int eeprom_read(void *ioaddr, int location);
 static int mdio_read(struct net_device *dev, int reg);
 static void mdio_write(struct net_device *dev, int reg, u16 data);
 static void init_phy_fixup(struct net_device *dev);
@@ -772,9 +772,10 @@
 static void move_int_phy(struct net_device *dev, int addr)
 {
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  int target = 31;
 
- /* 
+ /*
   * The internal phy is visible on the external mii bus. Therefore we 
must
   * move it away before we can send commands to an external phy.
   * There are two addresses we must avoid:
@@ -788,8 +789,8 @@
   target--;
  if (target == np->phy_addr_external)
   target--;
- writew(target, dev->base_addr + PhyCtrl);
- readw(dev->base_addr + PhyCtrl);
+ writew(target, ioaddr + PhyCtrl);
+ readw(ioaddr + PhyCtrl);
  udelay(1);
 }
 
@@ -800,8 +801,8 @@
  struct netdev_private *np;
  int i, option, irq, chip_idx = ent->driver_data;
  static int find_cnt = -1;
- unsigned long ioaddr, iosize;
- const int pcibar = 1; /* PCI base address register */
+ void *ioaddr;
+ u32 iosize;
  int prev_eedata;
  u32 tmp;
 
@@ -827,8 +828,8 @@
  }
 
  find_cnt++;
- ioaddr = pci_resource_start(pdev, pcibar);
- iosize = pci_resource_len(pdev, pcibar);
+ ioaddr = (void *)pci_resource_start(pdev, 1);
+ iosize = pci_resource_len(pdev, 1);
  irq = pdev->irq;
 
  if (natsemi_pci_info[chip_idx].flags & PCI_USES_MASTER)
@@ -844,7 +845,7 @@
  if (i)
   goto err_pci_request_regions;
 
- ioaddr = (unsigned long) ioremap (ioaddr, iosize);
+ ioaddr = ioremap((unsigned long)ioaddr, iosize);
  if (!ioaddr) {
   i = -ENOMEM;
   goto err_ioremap;
@@ -859,7 +860,7 @@
   prev_eedata = eedata;
  }
 
- dev->base_addr = ioaddr;
+ dev->base_addr = (unsigned long)ioaddr;
  dev->irq = irq;
 
  np = netdev_priv(dev);
@@ -879,7 +880,7 @@
   * The address would be used to access a phy over the mii bus, but
   * the internal phy is accessed through mapped registers.
   */
- if (readl(dev->base_addr + ChipConfig) & CfgExtPhy)
+ if (readl(ioaddr + ChipConfig) & CfgExtPhy)
   dev->if_port = PORT_MII;
  else
   dev->if_port = PORT_TP;
@@ -970,7 +971,7 @@
   goto err_register_netdev;
 
  if (netif_msg_drv(np)) {
-  printk(KERN_INFO "natsemi %s: %s at %#08lx (%s), ",
+  printk(KERN_INFO "natsemi %s: %s at %p (%s), ",
    dev->name, natsemi_pci_info[chip_idx].name, ioaddr,
    pci_name(np->pci_dev));
   for (i = 0; i < ETH_ALEN-1; i++)
@@ -984,7 +985,7 @@
  return 0;
 
  err_register_netdev:
- iounmap ((void *) dev->base_addr);
+ iounmap(ioaddr);
 
  err_ioremap:
  pci_release_regions(pdev);
@@ -1016,11 +1017,11 @@
  EE_WriteCmd=(5 << 6), EE_ReadCmd=(6 << 6), EE_EraseCmd=(7 << 6),
 };
 
-static int eeprom_read(long addr, int location)
+static int eeprom_read(void *addr, int location)
 {
  int i;
  int retval = 0;
- long ee_addr = addr + EECtrl;
+ void *ee_addr = addr + EECtrl;
  int read_cmd = location | EE_ReadCmd;
  writel(EE_Write0, ee_addr);
 
@@ -1058,33 +1059,35 @@
 /* clock transitions >= 20ns (25MHz)
  * One readl should be good to PCI @ 100MHz
  */
-#define mii_delay(dev)  readl(dev->base_addr + EECtrl)
+#define mii_delay()  readl(ioaddr + EECtrl)
 
 static int mii_getbit (struct net_device *dev)
 {
+ void *ioaddr = (void *)dev->base_addr;
  int data;
 
- writel(MII_ShiftClk, dev->base_addr + EECtrl);
- data = readl(dev->base_addr + EECtrl);
- writel(0, dev->base_addr + EECtrl);
- mii_delay(dev);
+ writel(MII_ShiftClk, ioaddr + EECtrl);
+ data = readl(ioaddr + EECtrl);
+ writel(0, ioaddr + EECtrl);
+ mii_delay();
  return (data & MII_Data)? 1 : 0;
 }
 
 static void mii_send_bits (struct net_device *dev, u32 data, int len)
 {
+ void *ioaddr = (void *)dev->base_addr;
  u32 i;
 
  for (i = (1 << (len-1)); i; i >>= 1)
  {
   u32 mdio_val = MII_Write | ((data & i)? MII_Data : 0);
-  writel(mdio_val, dev->base_addr + EECtrl);
-  mii_delay(dev);
-  writel(mdio_val | MII_ShiftClk, dev->base_addr + EECtrl);
-  mii_delay(dev);
+  writel(mdio_val, ioaddr + EECtrl);
+  mii_delay();
+  writel(mdio_val | MII_ShiftClk, ioaddr + EECtrl);
+  mii_delay();
  }
- writel(0, dev->base_addr + EECtrl);
- mii_delay(dev);
+ writel(0, ioaddr + EECtrl);
+ mii_delay();
 }
 
 static int miiport_read(struct net_device *dev, int phy_id, int reg)
@@ -1135,7 +1138,7 @@
   * - an external mii bus
   */
  if (dev->if_port == PORT_TP)
-  return readw(dev->base_addr+BasicControl+(reg<<2));
+  return readw((void *)dev->base_addr+BasicControl+(reg<<2));
  else
   return miiport_read(dev, np->phy_addr_external, reg);
 }
@@ -1146,7 +1149,7 @@
 
  /* The 83815 series has an internal transceiver; handle separately */
  if (dev->if_port == PORT_TP)
-  writew(data, dev->base_addr+BasicControl+(reg<<2));
+  writew(data, (void *)dev->base_addr+BasicControl+(reg<<2));
  else
   miiport_write(dev, np->phy_addr_external, reg, data);
 }
@@ -1154,7 +1157,7 @@
 static void init_phy_fixup(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
  int i;
  u32 cfg;
  u16 tmp;
@@ -1177,7 +1180,7 @@
    tmp |= BMCR_SPEED100;
   if (np->duplex == DUPLEX_FULL)
    tmp |= BMCR_FULLDPLX;
-  /* 
+  /*
    * Note: there is no good way to inform the link partner
    * that our capabilities changed. The user has to unplug
    * and replug the network cable after some changes, e.g.
@@ -1186,7 +1189,7 @@
    */
  }
  mdio_write(dev, MII_BMCR, tmp);
- readl(dev->base_addr + ChipConfig);
+ readl(ioaddr + ChipConfig);
  udelay(1);
 
  /* find out what phy this is */
@@ -1208,7 +1211,7 @@
  default:
   break;
  }
- cfg = readl(dev->base_addr + ChipConfig);
+ cfg = readl(ioaddr + ChipConfig);
  if (cfg & CfgExtPhy)
   return;
 
@@ -1223,7 +1226,7 @@
     the start of the phy. Just retry writing these values until they
     stick.
  */
- for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
+ for (i=0; i<NATSEMI_HW_TIMEOUT; i++) {
 
   int dspcfg;
   writew(1, ioaddr + PGSEL);
@@ -1266,9 +1269,10 @@
 static int switch_port_external(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  u32 cfg;
 
- cfg = readl(dev->base_addr + ChipConfig);
+ cfg = readl(ioaddr + ChipConfig);
  if (cfg & CfgExtPhy)
   return 0;
 
@@ -1278,8 +1282,8 @@
  }
 
  /* 1) switch back to external phy */
- writel(cfg | (CfgExtPhy | CfgPhyDis), dev->base_addr + ChipConfig);
- readl(dev->base_addr + ChipConfig);
+ writel(cfg | (CfgExtPhy | CfgPhyDis), ioaddr + ChipConfig);
+ readl(ioaddr + ChipConfig);
  udelay(1);
 
  /* 2) reset the external phy: */
@@ -1298,11 +1302,12 @@
 static int switch_port_internal(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  int i;
  u32 cfg;
  u16 bmcr;
 
- cfg = readl(dev->base_addr + ChipConfig);
+ cfg = readl(ioaddr + ChipConfig);
  if (!(cfg &CfgExtPhy))
   return 0;
 
@@ -1312,17 +1317,17 @@
  }
  /* 1) switch back to internal phy: */
  cfg = cfg & ~(CfgExtPhy | CfgPhyDis);
- writel(cfg, dev->base_addr + ChipConfig);
- readl(dev->base_addr + ChipConfig);
+ writel(cfg, ioaddr + ChipConfig);
+ readl(ioaddr + ChipConfig);
  udelay(1);
- 
+
  /* 2) reset the internal phy: */
- bmcr = readw(dev->base_addr+BasicControl+(MII_BMCR<<2));
- writel(bmcr | BMCR_RESET, dev->base_addr+BasicControl+(MII_BMCR<<2));
- readl(dev->base_addr + ChipConfig);
+ bmcr = readw(ioaddr + BasicControl + (MII_BMCR<<2));
+ writel(bmcr | BMCR_RESET, ioaddr + BasicControl + (MII_BMCR<<2));
+ readl(ioaddr + ChipConfig);
  udelay(10);
- for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
-  bmcr = readw(dev->base_addr+BasicControl+(MII_BMCR<<2));
+ for (i=0; i<NATSEMI_HW_TIMEOUT; i++) {
+  bmcr = readw(ioaddr + BasicControl + (MII_BMCR<<2));
   if (!(bmcr & BMCR_RESET))
    break;
   udelay(10);
@@ -1355,7 +1360,7 @@
 
  /* Switch to external phy */
  did_switch = switch_port_external(dev);
-  
+
  /* Scan the possible phy addresses:
   *
   * PHY address 0 means that the phy is in isolate mode. Not yet
@@ -1398,6 +1403,7 @@
  u16 pmatch[3];
  u16 sopass[3];
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
 
  /*
   * Resetting the chip causes some registers to be lost.
@@ -1408,26 +1414,26 @@
   */
 
  /* CFG */
- cfg = readl(dev->base_addr + ChipConfig) & CFG_RESET_SAVE;
+ cfg = readl(ioaddr + ChipConfig) & CFG_RESET_SAVE;
  /* WCSR */
- wcsr = readl(dev->base_addr + WOLCmd) & WCSR_RESET_SAVE;
+ wcsr = readl(ioaddr + WOLCmd) & WCSR_RESET_SAVE;
  /* RFCR */
- rfcr = readl(dev->base_addr + RxFilterAddr) & RFCR_RESET_SAVE;
+ rfcr = readl(ioaddr + RxFilterAddr) & RFCR_RESET_SAVE;
  /* PMATCH */
  for (i = 0; i < 3; i++) {
-  writel(i*2, dev->base_addr + RxFilterAddr);
-  pmatch[i] = readw(dev->base_addr + RxFilterData);
+  writel(i*2, ioaddr + RxFilterAddr);
+  pmatch[i] = readw(ioaddr + RxFilterData);
  }
  /* SOPAS */
  for (i = 0; i < 3; i++) {
-  writel(0xa+(i*2), dev->base_addr + RxFilterAddr);
-  sopass[i] = readw(dev->base_addr + RxFilterData);
+  writel(0xa+(i*2), ioaddr + RxFilterAddr);
+  sopass[i] = readw(ioaddr + RxFilterData);
  }
 
  /* now whack the chip */
- writel(ChipReset, dev->base_addr + ChipCmd);
+ writel(ChipReset, ioaddr + ChipCmd);
  for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
-  if (!(readl(dev->base_addr + ChipCmd) & ChipReset))
+  if (!(readl(ioaddr + ChipCmd) & ChipReset))
    break;
   udelay(5);
  }
@@ -1440,40 +1446,41 @@
  }
 
  /* restore CFG */
- cfg |= readl(dev->base_addr + ChipConfig) & ~CFG_RESET_SAVE;
+ cfg |= readl(ioaddr + ChipConfig) & ~CFG_RESET_SAVE;
  /* turn on external phy if it was selected */
  if (dev->if_port == PORT_TP)
   cfg &= ~(CfgExtPhy | CfgPhyDis);
  else
   cfg |= (CfgExtPhy | CfgPhyDis);
- writel(cfg, dev->base_addr + ChipConfig);
+ writel(cfg, ioaddr + ChipConfig);
  /* restore WCSR */
- wcsr |= readl(dev->base_addr + WOLCmd) & ~WCSR_RESET_SAVE;
- writel(wcsr, dev->base_addr + WOLCmd);
+ wcsr |= readl(ioaddr + WOLCmd) & ~WCSR_RESET_SAVE;
+ writel(wcsr, ioaddr + WOLCmd);
  /* read RFCR */
- rfcr |= readl(dev->base_addr + RxFilterAddr) & ~RFCR_RESET_SAVE;
+ rfcr |= readl(ioaddr + RxFilterAddr) & ~RFCR_RESET_SAVE;
  /* restore PMATCH */
  for (i = 0; i < 3; i++) {
-  writel(i*2, dev->base_addr + RxFilterAddr);
-  writew(pmatch[i], dev->base_addr + RxFilterData);
+  writel(i*2, ioaddr + RxFilterAddr);
+  writew(pmatch[i], ioaddr + RxFilterData);
  }
  for (i = 0; i < 3; i++) {
-  writel(0xa+(i*2), dev->base_addr + RxFilterAddr);
-  writew(sopass[i], dev->base_addr + RxFilterData);
+  writel(0xa+(i*2), ioaddr + RxFilterAddr);
+  writew(sopass[i], ioaddr + RxFilterData);
  }
  /* restore RFCR */
- writel(rfcr, dev->base_addr + RxFilterAddr);
+ writel(rfcr, ioaddr + RxFilterAddr);
 }
 
 static void natsemi_reload_eeprom(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  int i;
 
- writel(EepromReload, dev->base_addr + PCIBusCfg);
+ writel(EepromReload, ioaddr + PCIBusCfg);
  for (i=0;i<NATSEMI_HW_TIMEOUT;i++) {
   udelay(50);
-  if (!(readl(dev->base_addr + PCIBusCfg) & EepromReload))
+  if (!(readl(ioaddr + PCIBusCfg) & EepromReload))
    break;
  }
  if (i==NATSEMI_HW_TIMEOUT) {
@@ -1487,8 +1494,8 @@
 
 static void natsemi_stop_rxtx(struct net_device *dev)
 {
- long ioaddr = dev->base_addr;
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  int i;
 
  writel(RxOff | TxOff, ioaddr + ChipCmd);
@@ -1509,7 +1516,7 @@
 static int netdev_open(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
  int i;
 
  /* Reset the chip, just in case. */
@@ -1558,6 +1565,7 @@
 static void do_cable_magic(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
 
  if (dev->if_port != PORT_TP)
   return;
@@ -1571,15 +1579,15 @@
   * activity LED while idle.  This process is based on instructions
   * from engineers at National.
   */
- if (readl(dev->base_addr + ChipConfig) & CfgSpeed100) {
+ if (readl(ioaddr + ChipConfig) & CfgSpeed100) {
   u16 data;
 
-  writew(1, dev->base_addr + PGSEL);
+  writew(1, ioaddr + PGSEL);
   /*
    * coefficient visibility should already be enabled via
    * DSPCFG | 0x1000
    */
-  data = readw(dev->base_addr + TSTDAT) & 0xff;
+  data = readw(ioaddr + TSTDAT) & 0xff;
   /*
    * the value must be negative, and within certain values
    * (these values all come from National)
@@ -1588,13 +1596,13 @@
    struct netdev_private *np = netdev_priv(dev);
 
    /* the bug has been triggered - fix the coefficient */
-   writew(TSTDAT_FIXED, dev->base_addr + TSTDAT);
+   writew(TSTDAT_FIXED, ioaddr + TSTDAT);
    /* lock the value */
-   data = readw(dev->base_addr + DSPCFG);
+   data = readw(ioaddr + DSPCFG);
    np->dspcfg = data | DSPCFG_LOCK;
-   writew(np->dspcfg, dev->base_addr + DSPCFG);
+   writew(np->dspcfg, ioaddr + DSPCFG);
   }
-  writew(0, dev->base_addr + PGSEL);
+  writew(0, ioaddr + PGSEL);
  }
 }
 
@@ -1602,6 +1610,7 @@
 {
  u16 data;
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
 
  if (dev->if_port != PORT_TP)
   return;
@@ -1609,21 +1618,21 @@
  if (np->srr >= SRR_DP83816_A5)
   return;
 
- writew(1, dev->base_addr + PGSEL);
+ writew(1, ioaddr + PGSEL);
  /* make sure the lock bit is clear */
- data = readw(dev->base_addr + DSPCFG);
+ data = readw(ioaddr + DSPCFG);
  np->dspcfg = data & ~DSPCFG_LOCK;
- writew(np->dspcfg, dev->base_addr + DSPCFG);
- writew(0, dev->base_addr + PGSEL);
+ writew(np->dspcfg, ioaddr + DSPCFG);
+ writew(0, ioaddr + PGSEL);
 }
 
 static void check_link(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
  int duplex;
  u16 bmsr;
-       
+
  /* The link status field is latched: it remains low after a temporary
   * link failure until it's read. We need the current link status,
   * thus read twice.
@@ -1681,7 +1690,7 @@
 static void init_registers(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
 
  init_phy_fixup(dev);
 
@@ -1760,6 +1769,7 @@
 {
  struct net_device *dev = (struct net_device *)data;
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  int next_tick = 5*HZ;
 
  if (netif_msg_timer(np)) {
@@ -1771,7 +1781,6 @@
  }
 
  if (dev->if_port == PORT_TP) {
-  long ioaddr = dev->base_addr;
   u16 dspcfg;
 
   spin_lock_irq(&np->lock);
@@ -1814,7 +1823,7 @@
   refill_rx(dev);
   enable_irq(dev->irq);
   if (!np->oom) {
-   writel(RxOn, dev->base_addr + ChipCmd);
+   writel(RxOn, ioaddr + ChipCmd);
   } else {
    next_tick = 1;
   }
@@ -1848,7 +1857,7 @@
 static void tx_timeout(struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
 
  disable_irq(dev->irq);
  spin_lock_irq(&np->lock);
@@ -2048,6 +2057,7 @@
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  unsigned entry;
 
  /* Note: Ordering is important here, set the field with the
@@ -2076,7 +2086,7 @@
     netif_stop_queue(dev);
   }
   /* Wake the potentially-idle transmit channel. */
-  writel(TxOn, dev->base_addr + ChipCmd);
+  writel(TxOn, ioaddr + ChipCmd);
  } else {
   dev_kfree_skb_irq(skb);
   np->stats.tx_dropped++;
@@ -2141,7 +2151,7 @@
 {
  struct net_device *dev = dev_instance;
  struct netdev_private *np = netdev_priv(dev);
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
  int boguscnt = max_interrupt_work;
  unsigned int handled = 0;
 
@@ -2284,13 +2294,13 @@
  if (np->oom)
   mod_timer(&np->timer, jiffies + 1);
  else
-  writel(RxOn, dev->base_addr + ChipCmd);
+  writel(RxOn, (void *)dev->base_addr + ChipCmd);
 }
 
 static void netdev_error(struct net_device *dev, int intr_status)
 {
  struct netdev_private *np = netdev_priv(dev);
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
 
  spin_lock(&np->lock);
  if (intr_status & LinkChange) {
@@ -2349,7 +2359,7 @@
 
 static void __get_stats(struct net_device *dev)
 {
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
  struct netdev_private *np = netdev_priv(dev);
 
  /* The chip only need report frame silently dropped. */
@@ -2382,8 +2392,8 @@
 #define HASH_TABLE 0x200
 static void __set_rx_mode(struct net_device *dev)
 {
- long ioaddr = dev->base_addr;
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  u8 mc_filter[64]; /* Multicast hash filter */
  u32 rx_mode;
 
@@ -2428,7 +2438,7 @@
  /* synchronized against open : rtnl_lock() held by caller */
  if (netif_running(dev)) {
   struct netdev_private *np = netdev_priv(dev);
-  long ioaddr = dev->base_addr;
+  void *ioaddr = (void *)dev->base_addr;
 
   disable_irq(dev->irq);
   spin_lock(&np->lock);
@@ -2631,7 +2641,9 @@
 static int netdev_set_wol(struct net_device *dev, u32 newval)
 {
  struct netdev_private *np = netdev_priv(dev);
- u32 data = readl(dev->base_addr + WOLCmd) & ~WakeOptsSummary;
+ void *ioaddr = (void *)dev->base_addr;
+
+ u32 data = readl(ioaddr + WOLCmd) & ~WakeOptsSummary;
 
  /* translate to bitmasks this chip understands */
  if (newval & WAKE_PHY)
@@ -2652,7 +2664,7 @@
   }
  }
 
- writel(data, dev->base_addr + WOLCmd);
+ writel(data, ioaddr + WOLCmd);
 
  return 0;
 }
@@ -2660,7 +2672,9 @@
 static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 
*cur)
 {
  struct netdev_private *np = netdev_priv(dev);
- u32 regval = readl(dev->base_addr + WOLCmd);
+ void *ioaddr = (void *)dev->base_addr;
+
+ u32 regval = readl(ioaddr + WOLCmd);
 
  *supported = (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST
    | WAKE_ARP | WAKE_MAGIC);
@@ -2695,6 +2709,7 @@
 static int netdev_set_sopass(struct net_device *dev, u8 *newval)
 {
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  u16 *sval = (u16 *)newval;
  u32 addr;
 
@@ -2703,22 +2718,22 @@
  }
 
  /* enable writing to these registers by disabling the RX filter */
- addr = readl(dev->base_addr + RxFilterAddr) & ~RFCRAddressMask;
+ addr = readl(ioaddr + RxFilterAddr) & ~RFCRAddressMask;
  addr &= ~RxFilterEnable;
- writel(addr, dev->base_addr + RxFilterAddr);
+ writel(addr, ioaddr + RxFilterAddr);
 
  /* write the three words to (undocumented) RFCR vals 0xa, 0xc, 0xe */
- writel(addr | 0xa, dev->base_addr + RxFilterAddr);
- writew(sval[0], dev->base_addr + RxFilterData);
+ writel(addr | 0xa, ioaddr + RxFilterAddr);
+ writew(sval[0], ioaddr + RxFilterData);
 
- writel(addr | 0xc, dev->base_addr + RxFilterAddr);
- writew(sval[1], dev->base_addr + RxFilterData);
+ writel(addr | 0xc, ioaddr + RxFilterAddr);
+ writew(sval[1], ioaddr + RxFilterData);
 
- writel(addr | 0xe, dev->base_addr + RxFilterAddr);
- writew(sval[2], dev->base_addr + RxFilterData);
+ writel(addr | 0xe, ioaddr + RxFilterAddr);
+ writew(sval[2], ioaddr + RxFilterData);
 
  /* re-enable the RX filter */
- writel(addr | RxFilterEnable, dev->base_addr + RxFilterAddr);
+ writel(addr | RxFilterEnable, ioaddr + RxFilterAddr);
 
  return 0;
 }
@@ -2726,6 +2741,7 @@
 static int netdev_get_sopass(struct net_device *dev, u8 *data)
 {
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
  u16 *sval = (u16 *)data;
  u32 addr;
 
@@ -2735,18 +2751,18 @@
  }
 
  /* read the three words from (undocumented) RFCR vals 0xa, 0xc, 0xe */
- addr = readl(dev->base_addr + RxFilterAddr) & ~RFCRAddressMask;
+ addr = readl(ioaddr + RxFilterAddr) & ~RFCRAddressMask;
 
- writel(addr | 0xa, dev->base_addr + RxFilterAddr);
- sval[0] = readw(dev->base_addr + RxFilterData);
+ writel(addr | 0xa, ioaddr + RxFilterAddr);
+ sval[0] = readw(ioaddr + RxFilterData);
 
- writel(addr | 0xc, dev->base_addr + RxFilterAddr);
- sval[1] = readw(dev->base_addr + RxFilterData);
+ writel(addr | 0xc, ioaddr + RxFilterAddr);
+ sval[1] = readw(ioaddr + RxFilterData);
 
- writel(addr | 0xe, dev->base_addr + RxFilterAddr);
- sval[2] = readw(dev->base_addr + RxFilterData);
+ writel(addr | 0xe, ioaddr + RxFilterAddr);
+ sval[2] = readw(ioaddr + RxFilterData);
 
- writel(addr, dev->base_addr + RxFilterAddr);
+ writel(addr, ioaddr + RxFilterAddr);
 
  return 0;
 }
@@ -2779,7 +2795,7 @@
   * phy, even if the internal phy is used. This is necessary
   * to work around a deficiency of the ethtool interface:
   * It's only possible to query the settings of the active
-  * port. Therefore 
+  * port. Therefore
   * # ethtool -s ethX port mii
   * actually sends an ioctl to switch to port mii with the
   * settings that are used for the current active port.
@@ -2905,6 +2921,7 @@
 
 static int netdev_get_regs(struct net_device *dev, u8 *buf)
 {
+ void *ioaddr = (void *)dev->base_addr;
  int i;
  int j;
  u32 rfcr;
@@ -2912,7 +2929,7 @@
 
  /* read non-mii page 0 of registers */
  for (i = 0; i < NATSEMI_PG0_NREGS/2; i++) {
-  rbuf[i] = readl(dev->base_addr + i*4);
+  rbuf[i] = readl(ioaddr + i*4);
  }
 
  /* read current mii registers */
@@ -2920,20 +2937,20 @@
   rbuf[i] = mdio_read(dev, i & 0x1f);
 
  /* read only the 'magic' registers from page 1 */
- writew(1, dev->base_addr + PGSEL);
- rbuf[i++] = readw(dev->base_addr + PMDCSR);
- rbuf[i++] = readw(dev->base_addr + TSTDAT);
- rbuf[i++] = readw(dev->base_addr + DSPCFG);
- rbuf[i++] = readw(dev->base_addr + SDCFG);
- writew(0, dev->base_addr + PGSEL);
+ writew(1, ioaddr + PGSEL);
+ rbuf[i++] = readw(ioaddr + PMDCSR);
+ rbuf[i++] = readw(ioaddr + TSTDAT);
+ rbuf[i++] = readw(ioaddr + DSPCFG);
+ rbuf[i++] = readw(ioaddr + SDCFG);
+ writew(0, ioaddr + PGSEL);
 
  /* read RFCR indexed registers */
- rfcr = readl(dev->base_addr + RxFilterAddr);
+ rfcr = readl(ioaddr + RxFilterAddr);
  for (j = 0; j < NATSEMI_RFDR_NREGS; j++) {
-  writel(j*2, dev->base_addr + RxFilterAddr);
-  rbuf[i++] = readw(dev->base_addr + RxFilterData);
+  writel(j*2, ioaddr + RxFilterAddr);
+  rbuf[i++] = readw(ioaddr + RxFilterData);
  }
- writel(rfcr, dev->base_addr + RxFilterAddr);
+ writel(rfcr, ioaddr + RxFilterAddr);
 
  /* the interrupt status is clear-on-read - see if we missed any */
  if (rbuf[4] & rbuf[5]) {
@@ -2956,12 +2973,13 @@
 
 static int netdev_get_eeprom(struct net_device *dev, u8 *buf)
 {
+ void *ioaddr = (void *)dev->base_addr;
  int i;
  u16 *ebuf = (u16 *)buf;
 
  /* eeprom_read reads 16 bits, and indexes by 16 bits */
  for (i = 0; i < NATSEMI_EEPROM_SIZE/2; i++) {
-  ebuf[i] = eeprom_read(dev->base_addr, i);
+  ebuf[i] = eeprom_read(ioaddr, i);
   /* The EEPROM itself stores data bit-swapped, but eeprom_read
    * reads it back "sanely". So we swap it back here in order to
    * present it to userland as it is stored. */
@@ -3031,8 +3049,8 @@
 
 static void enable_wol_mode(struct net_device *dev, int enable_intr)
 {
- long ioaddr = dev->base_addr;
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
 
  if (netif_msg_wol(np))
   printk(KERN_INFO "%s: remaining active for wake-on-lan\n",
@@ -3064,8 +3082,8 @@
 
 static int netdev_close(struct net_device *dev)
 {
- long ioaddr = dev->base_addr;
  struct netdev_private *np = netdev_priv(dev);
+ void *ioaddr = (void *)dev->base_addr;
 
  if (netif_msg_ifdown(np))
   printk(KERN_DEBUG
@@ -3144,7 +3162,7 @@
 
  unregister_netdev (dev);
  pci_release_regions (pdev);
- iounmap ((char *) dev->base_addr);
+ iounmap ((void *)dev->base_addr);
  free_netdev (dev);
  pci_set_drvdata(pdev, NULL);
 }
@@ -3178,7 +3196,7 @@
 {
  struct net_device *dev = pci_get_drvdata (pdev);
  struct netdev_private *np = netdev_priv(dev);
- long ioaddr = dev->base_addr;
+ void *ioaddr = (void *)dev->base_addr;
 
  rtnl_lock();
  if (netif_running (dev)) {

