Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUKOKCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUKOKCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 05:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUKOKCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 05:02:38 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:50104 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261563AbUKOKBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 05:01:54 -0500
Subject: [PATCH] 8139too: use iomap for pio/mmio
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: linux-kernel@vger.kernel.org
Date: Mon, 15 Nov 2004 12:01:19 +0200
Message-Id: <1100512879.9826.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch converts the 8139too driver to use the iomap infrastructure
for PIO and MMIO instead of playing macro tricks.  I also had to fix
read_eeprom(), mdio_sync(), mdio_read(), and mdio_write() to not pass
PIO base address to MMIO read() and write() functions.  In addition,
the patch adds proper __iomem annotations for the driver.

I have tested this patch with RealTek RTL8139 card and would appreciate
if someone with an older RTL8129 could give it a spin so I can submit
this to the maintainers. Thank you.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 8139too.c |  194 +++++++++++++++++++++++++++-----------------------------------
 1 files changed, 87 insertions(+), 107 deletions(-)

Index: 2.6.10-rc1-bk14-netdev1/drivers/net/8139too.c
===================================================================
--- 2.6.10-rc1-bk14-netdev1.orig/drivers/net/8139too.c	2004-11-05 21:55:41.485808120 +0200
+++ 2.6.10-rc1-bk14-netdev1/drivers/net/8139too.c	2004-11-05 23:14:10.226970656 +0200
@@ -570,7 +570,7 @@
 };
 
 struct rtl8139_private {
-	void *mmio_addr;
+	void __iomem *mmio_addr;
 	int drv_flags;
 	struct pci_dev *pci_dev;
 	u32 msg_enable;
@@ -615,7 +615,7 @@
 MODULE_PARM_DESC (media, "8139too: Bits 4+9: force full duplex, bit 5: 100Mbps");
 MODULE_PARM_DESC (full_duplex, "8139too: Force full duplex for board(s) (1)");
 
-static int read_eeprom (void *ioaddr, int location, int addr_len);
+static int read_eeprom (void __iomem *ioaddr, int location, int addr_len);
 static int rtl8139_open (struct net_device *dev);
 static int mdio_read (struct net_device *dev, int phy_id, int location);
 static void mdio_write (struct net_device *dev, int phy_id, int location,
@@ -639,46 +639,20 @@
 static void rtl8139_hw_start (struct net_device *dev);
 static struct ethtool_ops rtl8139_ethtool_ops;
 
-#ifdef USE_IO_OPS
-
-#define RTL_R8(reg)		inb (((unsigned long)ioaddr) + (reg))
-#define RTL_R16(reg)		inw (((unsigned long)ioaddr) + (reg))
-#define RTL_R32(reg)		((unsigned long) inl (((unsigned long)ioaddr) + (reg)))
-#define RTL_W8(reg, val8)	outb ((val8), ((unsigned long)ioaddr) + (reg))
-#define RTL_W16(reg, val16)	outw ((val16), ((unsigned long)ioaddr) + (reg))
-#define RTL_W32(reg, val32)	outl ((val32), ((unsigned long)ioaddr) + (reg))
-#define RTL_W8_F		RTL_W8
-#define RTL_W16_F		RTL_W16
-#define RTL_W32_F		RTL_W32
-#undef readb
-#undef readw
-#undef readl
-#undef writeb
-#undef writew
-#undef writel
-#define readb(addr) inb((unsigned long)(addr))
-#define readw(addr) inw((unsigned long)(addr))
-#define readl(addr) inl((unsigned long)(addr))
-#define writeb(val,addr) outb((val),(unsigned long)(addr))
-#define writew(val,addr) outw((val),(unsigned long)(addr))
-#define writel(val,addr) outl((val),(unsigned long)(addr))
-
-#else
-
 /* write MMIO register, with flush */
 /* Flush avoids rtl8139 bug w/ posted MMIO writes */
-#define RTL_W8_F(reg, val8)	do { writeb ((val8), ioaddr + (reg)); readb (ioaddr + (reg)); } while (0)
-#define RTL_W16_F(reg, val16)	do { writew ((val16), ioaddr + (reg)); readw (ioaddr + (reg)); } while (0)
-#define RTL_W32_F(reg, val32)	do { writel ((val32), ioaddr + (reg)); readl (ioaddr + (reg)); } while (0)
+#define RTL_W8_F(reg, val8)	do { iowrite8 ((val8), ioaddr + (reg)); ioread8 (ioaddr + (reg)); } while (0)
+#define RTL_W16_F(reg, val16)	do { iowrite16 ((val16), ioaddr + (reg)); ioread16 (ioaddr + (reg)); } while (0)
+#define RTL_W32_F(reg, val32)	do { iowrite32 ((val32), ioaddr + (reg)); ioread32 (ioaddr + (reg)); } while (0)
 

 #define MMIO_FLUSH_AUDIT_COMPLETE 1
 #if MMIO_FLUSH_AUDIT_COMPLETE
 
 /* write MMIO register */
-#define RTL_W8(reg, val8)	writeb ((val8), ioaddr + (reg))
-#define RTL_W16(reg, val16)	writew ((val16), ioaddr + (reg))
-#define RTL_W32(reg, val32)	writel ((val32), ioaddr + (reg))
+#define RTL_W8(reg, val8)	iowrite8 ((val8), ioaddr + (reg))
+#define RTL_W16(reg, val16)	iowrite16 ((val16), ioaddr + (reg))
+#define RTL_W32(reg, val32)	iowrite32 ((val32), ioaddr + (reg))
 
 #else
 
@@ -690,11 +664,9 @@
 #endif /* MMIO_FLUSH_AUDIT_COMPLETE */
 
 /* read MMIO register */
-#define RTL_R8(reg)		readb (ioaddr + (reg))
-#define RTL_R16(reg)		readw (ioaddr + (reg))
-#define RTL_R32(reg)		((unsigned long) readl (ioaddr + (reg)))
-
-#endif /* USE_IO_OPS */
+#define RTL_R8(reg)		ioread8 (ioaddr + (reg))
+#define RTL_R16(reg)		ioread16 (ioaddr + (reg))
+#define RTL_R32(reg)		((unsigned long) ioread32 (ioaddr + (reg)))
 

 static const u16 rtl8139_intr_mask =
@@ -741,10 +713,13 @@
 	assert (tp->pci_dev != NULL);
 	pdev = tp->pci_dev;
 
-#ifndef USE_IO_OPS
+#ifdef USE_IO_OPS
+	if (tp->mmio_addr)
+		ioport_unmap (tp->mmio_addr);
+#else
 	if (tp->mmio_addr)
-		iounmap (tp->mmio_addr);
-#endif /* !USE_IO_OPS */
+		pci_iounmap (pdev, tp->mmio_addr);
+#endif /* USE_IO_OPS */
 
 	/* it's ok to call this even if we have no regions to free */
 	pci_release_regions (pdev);
@@ -755,7 +730,7 @@
 }
 

-static void rtl8139_chip_reset (void *ioaddr)
+static void rtl8139_chip_reset (void __iomem *ioaddr)
 {
 	int i;
 
@@ -775,7 +750,7 @@
 static int __devinit rtl8139_init_board (struct pci_dev *pdev,
 					 struct net_device **dev_out)
 {
-	void *ioaddr;
+	void __iomem *ioaddr;
 	struct net_device *dev;
 	struct rtl8139_private *tp;
 	u8 tmp8;
@@ -856,13 +831,18 @@
 	pci_set_master (pdev);
 
 #ifdef USE_IO_OPS
-	ioaddr = (void *) pio_start;
+	ioaddr = ioport_map(pio_start, pio_len);
+	if (!ioaddr) {
+		printk (KERN_ERR PFX "%s: cannot map PIO, aborting\n", pci_name(pdev));
+		rc = -EIO;
+		goto err_out;
+	}
 	dev->base_addr = pio_start;
 	tp->mmio_addr = ioaddr;
 	tp->regs_len = pio_len;
 #else
 	/* ioremap MMIO region */
-	ioaddr = ioremap (mmio_start, mmio_len);
+	ioaddr = pci_iomap(pdev, 1, 0);
 	if (ioaddr == NULL) {
 		printk (KERN_ERR PFX "%s: cannot remap MMIO, aborting\n", pci_name(pdev));
 		rc = -EIO;
@@ -946,7 +926,7 @@
 	struct net_device *dev = NULL;
 	struct rtl8139_private *tp;
 	int i, addr_len, option;
-	void *ioaddr;
+	void __iomem *ioaddr;
 	static int board_idx = -1;
 	u8 pci_rev;
 
@@ -1144,47 +1124,46 @@
    No extra delay is needed with 33Mhz PCI, but 66Mhz may change this.
  */
 
-#define eeprom_delay()	readl(ee_addr)
+#define eeprom_delay()	RTL_R32(Cfg9346)
 
 /* The EEPROM commands include the alway-set leading bit. */
 #define EE_WRITE_CMD	(5)
 #define EE_READ_CMD		(6)
 #define EE_ERASE_CMD	(7)
 
-static int __devinit read_eeprom (void *ioaddr, int location, int addr_len)
+static int __devinit read_eeprom (void __iomem *ioaddr, int location, int addr_len)
 {
 	int i;
 	unsigned retval = 0;
-	void *ee_addr = ioaddr + Cfg9346;
 	int read_cmd = location | (EE_READ_CMD << addr_len);
 
-	writeb (EE_ENB & ~EE_CS, ee_addr);
-	writeb (EE_ENB, ee_addr);
+	RTL_W8 (Cfg9346, EE_ENB & ~EE_CS);
+	RTL_W8 (Cfg9346, EE_ENB);
 	eeprom_delay ();
 
 	/* Shift the read command bits out. */
 	for (i = 4 + addr_len; i >= 0; i--) {
 		int dataval = (read_cmd & (1 << i)) ? EE_DATA_WRITE : 0;
-		writeb (EE_ENB | dataval, ee_addr);
+		RTL_W8 (Cfg9346, EE_ENB | dataval);
 		eeprom_delay ();
-		writeb (EE_ENB | dataval | EE_SHIFT_CLK, ee_addr);
+		RTL_W8 (Cfg9346, EE_ENB | dataval | EE_SHIFT_CLK);
 		eeprom_delay ();
 	}
-	writeb (EE_ENB, ee_addr);
+	RTL_W8 (Cfg9346, EE_ENB);
 	eeprom_delay ();
 
 	for (i = 16; i > 0; i--) {
-		writeb (EE_ENB | EE_SHIFT_CLK, ee_addr);
+		RTL_W8 (Cfg9346, EE_ENB | EE_SHIFT_CLK);
 		eeprom_delay ();
 		retval =
-		    (retval << 1) | ((readb (ee_addr) & EE_DATA_READ) ? 1 :
+		    (retval << 1) | ((RTL_R8 (Cfg9346) & EE_DATA_READ) ? 1 :
 				     0);
-		writeb (EE_ENB, ee_addr);
+		RTL_W8 (Cfg9346, EE_ENB);
 		eeprom_delay ();
 	}
 
 	/* Terminate the EEPROM access. */
-	writeb (~EE_CS, ee_addr);
+	RTL_W8 (Cfg9346, ~EE_CS);
 	eeprom_delay ();
 
 	return retval;
@@ -1203,7 +1182,7 @@
 #define MDIO_WRITE0 (MDIO_DIR)
 #define MDIO_WRITE1 (MDIO_DIR | MDIO_DATA_OUT)
 
-#define mdio_delay(mdio_addr)	readb(mdio_addr)
+#define mdio_delay()	RTL_R8(Config4)
 

 static char mii_2_8139_map[8] = {
@@ -1220,15 +1199,15 @@
 
 #ifdef CONFIG_8139TOO_8129
 /* Syncronize the MII management interface by shifting 32 one bits out. */
-static void mdio_sync (void *mdio_addr)
+static void mdio_sync (void __iomem *ioaddr)
 {
 	int i;
 
 	for (i = 32; i >= 0; i--) {
-		writeb (MDIO_WRITE1, mdio_addr);
-		mdio_delay (mdio_addr);
-		writeb (MDIO_WRITE1 | MDIO_CLK, mdio_addr);
-		mdio_delay (mdio_addr);
+		RTL_W8 (Config4, MDIO_WRITE1);
+		mdio_delay ();
+		RTL_W8 (Config4, MDIO_WRITE1 | MDIO_CLK);
+		mdio_delay ();
 	}
 }
 #endif
@@ -1238,35 +1217,36 @@
 	struct rtl8139_private *tp = netdev_priv(dev);
 	int retval = 0;
 #ifdef CONFIG_8139TOO_8129
-	void *mdio_addr = tp->mmio_addr + Config4;
+	void __iomem *ioaddr = tp->mmio_addr;
 	int mii_cmd = (0xf6 << 10) | (phy_id << 5) | location;
 	int i;
 #endif
 
 	if (phy_id > 31) {	/* Really a 8139.  Use internal registers. */
+		void __iomem *ioaddr = tp->mmio_addr;
 		return location < 8 && mii_2_8139_map[location] ?
-		    readw (tp->mmio_addr + mii_2_8139_map[location]) : 0;
+		    RTL_R16 (mii_2_8139_map[location]) : 0;
 	}
 
 #ifdef CONFIG_8139TOO_8129
-	mdio_sync (mdio_addr);
+	mdio_sync (ioaddr);
 	/* Shift the read command bits out. */
 	for (i = 15; i >= 0; i--) {
 		int dataval = (mii_cmd & (1 << i)) ? MDIO_DATA_OUT : 0;
 
-		writeb (MDIO_DIR | dataval, mdio_addr);
-		mdio_delay (mdio_addr);
-		writeb (MDIO_DIR | dataval | MDIO_CLK, mdio_addr);
-		mdio_delay (mdio_addr);
+		RTL_W8 (Config4, MDIO_DIR | dataval);
+		mdio_delay ();
+		RTL_W8 (Config4, MDIO_DIR | dataval | MDIO_CLK);
+		mdio_delay ();
 	}
 
 	/* Read the two transition, 16 data, and wire-idle bits. */
 	for (i = 19; i > 0; i--) {
-		writeb (0, mdio_addr);
-		mdio_delay (mdio_addr);
-		retval = (retval << 1) | ((readb (mdio_addr) & MDIO_DATA_IN) ? 1 : 0);
-		writeb (MDIO_CLK, mdio_addr);
-		mdio_delay (mdio_addr);
+		RTL_W8 (Config4, 0);
+		mdio_delay ();
+		retval = (retval << 1) | ((RTL_R8 (Config4) & MDIO_DATA_IN) ? 1 : 0);
+		RTL_W8 (Config4, MDIO_CLK);
+		mdio_delay ();
 	}
 #endif
 
@@ -1279,13 +1259,13 @@
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
 #ifdef CONFIG_8139TOO_8129
-	void *mdio_addr = tp->mmio_addr + Config4;
+	void __iomem *ioaddr = tp->mmio_addr;
 	int mii_cmd = (0x5002 << 16) | (phy_id << 23) | (location << 18) | value;
 	int i;
 #endif
 
 	if (phy_id > 31) {	/* Really a 8139.  Use internal registers. */
-		void *ioaddr = tp->mmio_addr;
+		void __iomem *ioaddr = tp->mmio_addr;
 		if (location == 0) {
 			RTL_W8 (Cfg9346, Cfg9346_Unlock);
 			RTL_W16 (BasicModeCtrl, value);
@@ -1296,23 +1276,23 @@
 	}
 
 #ifdef CONFIG_8139TOO_8129
-	mdio_sync (mdio_addr);
+	mdio_sync (ioaddr);
 
 	/* Shift the command bits out. */
 	for (i = 31; i >= 0; i--) {
 		int dataval =
 		    (mii_cmd & (1 << i)) ? MDIO_WRITE1 : MDIO_WRITE0;
-		writeb (dataval, mdio_addr);
-		mdio_delay (mdio_addr);
-		writeb (dataval | MDIO_CLK, mdio_addr);
-		mdio_delay (mdio_addr);
+		RTL_W8 (Config4, dataval);
+		mdio_delay ();
+		RTL_W8 (Config4, dataval | MDIO_CLK);
+		mdio_delay ();
 	}
 	/* Clear out extra bits. */
 	for (i = 2; i > 0; i--) {
-		writeb (0, mdio_addr);
-		mdio_delay (mdio_addr);
-		writeb (MDIO_CLK, mdio_addr);
-		mdio_delay (mdio_addr);
+		RTL_W8 (Config4, 0);
+		mdio_delay ();
+		RTL_W8 (Config4, MDIO_CLK);
+		mdio_delay ();
 	}
 #endif
 }
@@ -1322,7 +1302,7 @@
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
 	int retval;
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 
 	retval = request_irq (dev->irq, rtl8139_interrupt, SA_SHIRQ, dev->name, dev);
 	if (retval)
@@ -1379,7 +1359,7 @@
 static void rtl8139_hw_start (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	u32 i;
 	u8 tmp;
 
@@ -1481,7 +1461,7 @@
 				  struct rtl8139_private *tp)
 {
 	int linkcase;
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 
 	/* This is a complicated state machine to configure the "twister" for
 	   impedance/echos based on the cable length.
@@ -1565,7 +1545,7 @@
 
 static inline void rtl8139_thread_iter (struct net_device *dev,
 				 struct rtl8139_private *tp,
-				 void *ioaddr)
+				 void __iomem *ioaddr)
 {
 	int mii_lpa;
 
@@ -1673,7 +1653,7 @@
 static void rtl8139_tx_timeout (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	int i;
 	u8 tmp8;
 	unsigned long flags;
@@ -1718,7 +1698,7 @@
 static int rtl8139_start_xmit (struct sk_buff *skb, struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	unsigned int entry;
 	unsigned int len = skb->len;
 
@@ -1760,7 +1740,7 @@
 
 static void rtl8139_tx_interrupt (struct net_device *dev,
 				  struct rtl8139_private *tp,
-				  void *ioaddr)
+				  void __iomem *ioaddr)
 {
 	unsigned long dirty_tx, tx_left;
 
@@ -1830,7 +1810,7 @@
 
 /* TODO: clean this up!  Rx reset need not be this intensive */
 static void rtl8139_rx_err (u32 rx_status, struct net_device *dev,
-			    struct rtl8139_private *tp, void *ioaddr)
+			    struct rtl8139_private *tp, void __iomem *ioaddr)
 {
 	u8 tmp8;
 #ifdef CONFIG_8139_OLD_RX_RESET
@@ -1927,7 +1907,7 @@
 
 static void rtl8139_isr_ack(struct rtl8139_private *tp)
 {
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	u16 status;
 
 	status = RTL_R16 (IntrStatus) & RxAckBits;
@@ -1946,7 +1926,7 @@
 static int rtl8139_rx(struct net_device *dev, struct rtl8139_private *tp,
 		      int budget)
 {
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	int received = 0;
 	unsigned char *rx_ring = tp->rx_ring;
 	unsigned int cur_rx = tp->cur_rx;
@@ -2084,7 +2064,7 @@
 
 static void rtl8139_weird_interrupt (struct net_device *dev,
 				     struct rtl8139_private *tp,
-				     void *ioaddr,
+				     void __iomem *ioaddr,
 				     int status, int link_changed)
 {
 	DPRINTK ("%s: Abnormal interrupt, status %8.8x.\n",
@@ -2124,7 +2104,7 @@
 static int rtl8139_poll(struct net_device *dev, int *budget)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	int orig_budget = min(*budget, dev->quota);
 	int done = 1;
 
@@ -2162,7 +2142,7 @@
 {
 	struct net_device *dev = (struct net_device *) dev_instance;
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	u16 status, ackstat;
 	int link_changed = 0; /* avoid bogus "uninit" warning */
 	int handled = 0;
@@ -2238,7 +2218,7 @@
 static int rtl8139_close (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	int ret = 0;
 	unsigned long flags;
 
@@ -2301,7 +2281,7 @@
 static void rtl8139_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct rtl8139_private *np = netdev_priv(dev);
-	void *ioaddr = np->mmio_addr;
+	void __iomem *ioaddr = np->mmio_addr;
 
 	spin_lock_irq(&np->lock);
 	if (rtl_chip_info[np->chipset].flags & HasLWake) {
@@ -2335,7 +2315,7 @@
 static int rtl8139_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct rtl8139_private *np = netdev_priv(dev);
-	void *ioaddr = np->mmio_addr;
+	void __iomem *ioaddr = np->mmio_addr;
 	u32 support;
 	u8 cfg3, cfg5;
 
@@ -2503,7 +2483,7 @@
 static struct net_device_stats *rtl8139_get_stats (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	unsigned long flags;
 
 	if (netif_running(dev)) {
@@ -2522,7 +2502,7 @@
 static void __set_rx_mode (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	u32 mc_filter[2];	/* Multicast hash filter */
 	int i, rx_mode;
 	u32 tmp;
@@ -2583,7 +2563,7 @@
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = tp->mmio_addr;
 	unsigned long flags;
 
 	pci_save_state (pdev);


