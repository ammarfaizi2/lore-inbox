Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263208AbUJ2KKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbUJ2KKU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbUJ2KKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:10:19 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:64167 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S263208AbUJ2KEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:04:42 -0400
Subject: [PATCH 3/3] net: use netdev_ioaddr in 8139too
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: davem@davemloft.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <1099044315.9566.4.camel@localhost>
References: <1099044244.9566.0.camel@localhost>
	 <1099044278.9566.2.camel@localhost>  <1099044315.9566.4.camel@localhost>
Date: Fri, 29 Oct 2004 13:05:55 +0300
Message-Id: <1099044355.9566.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts 8139too driver to use netdev_ioaddr.

Not tested as I don't have access to the hardware right now.  Compiles and
passes sparse checks.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 8139too.c |  101 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 52 insertions(+), 49 deletions(-)

Index: 2.6.10-rc1-mm1/drivers/net/8139too.c
===================================================================
--- 2.6.10-rc1-mm1.orig/drivers/net/8139too.c	2004-10-29 12:02:27.132401800 +0300
+++ 2.6.10-rc1-mm1/drivers/net/8139too.c	2004-10-29 12:18:14.406394264 +0300
@@ -570,7 +570,6 @@
 };
 
 struct rtl8139_private {
-	void *mmio_addr;
 	int drv_flags;
 	struct pci_dev *pci_dev;
 	u32 msg_enable;
@@ -614,7 +613,7 @@
 MODULE_PARM_DESC (media, "8139too: Bits 4+9: force full duplex, bit 5: 100Mbps");
 MODULE_PARM_DESC (full_duplex, "8139too: Force full duplex for board(s) (1)");
 
-static int read_eeprom (void *ioaddr, int location, int addr_len);
+static int read_eeprom (void __iomem *ioaddr, int location, int addr_len);
 static int rtl8139_open (struct net_device *dev);
 static int mdio_read (struct net_device *dev, int phy_id, int location);
 static void mdio_write (struct net_device *dev, int phy_id, int location,
@@ -731,6 +730,16 @@
 static const unsigned int rtl8139_tx_config =
 	TxIFG96 | (TX_DMA_BURST << TxDMAShift) | (TX_RETRY << TxRetryShift);
 
+static void rtl8139_cleanup_iomem (struct net_device *dev)
+{
+#ifndef USE_IO_OPS
+	void __iomem *ioaddr = netdev_ioaddr(dev);
+
+	if (ioaddr)
+		iounmap(ioaddr);
+#endif /* !USE_IO_OPS */
+}
+
 static void __rtl8139_cleanup_dev (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
@@ -740,10 +749,7 @@
 	assert (tp->pci_dev != NULL);
 	pdev = tp->pci_dev;
 
-#ifndef USE_IO_OPS
-	if (tp->mmio_addr)
-		iounmap (tp->mmio_addr);
-#endif /* !USE_IO_OPS */
+	rtl8139_cleanup_iomem(dev);
 
 	/* it's ok to call this even if we have no regions to free */
 	pci_release_regions (pdev);
@@ -754,7 +760,7 @@
 }
 
 
-static void rtl8139_chip_reset (void *ioaddr)
+static void rtl8139_chip_reset (void __iomem *ioaddr)
 {
 	int i;
 
@@ -774,7 +780,7 @@
 static int __devinit rtl8139_init_board (struct pci_dev *pdev,
 					 struct net_device **dev_out)
 {
-	void *ioaddr;
+	void __iomem *ioaddr;
 	struct net_device *dev;
 	struct rtl8139_private *tp;
 	u8 tmp8;
@@ -855,9 +861,8 @@
 	pci_set_master (pdev);
 
 #ifdef USE_IO_OPS
-	ioaddr = (void *) pio_start;
+	ioaddr = (void __iomem *) pio_start;
 	dev->base_addr = pio_start;
-	tp->mmio_addr = ioaddr;
 	tp->regs_len = pio_len;
 #else
 	/* ioremap MMIO region */
@@ -867,8 +872,7 @@
 		rc = -EIO;
 		goto err_out;
 	}
-	dev->base_addr = (long) ioaddr;
-	tp->mmio_addr = ioaddr;
+	dev->base_addr = (__force long) ioaddr;
 	tp->regs_len = mmio_len;
 #endif /* USE_IO_OPS */
 
@@ -945,7 +949,7 @@
 	struct net_device *dev = NULL;
 	struct rtl8139_private *tp;
 	int i, addr_len, option;
-	void *ioaddr;
+	void __iomem *ioaddr;
 	static int board_idx = -1;
 	u8 pci_rev;
 
@@ -981,7 +985,7 @@
 	assert (dev != NULL);
 	tp = netdev_priv(dev);
 
-	ioaddr = tp->mmio_addr;
+	ioaddr = netdev_ioaddr(dev);
 	assert (ioaddr != NULL);
 
 	addr_len = read_eeprom (ioaddr, 0, 8) == 0x8129 ? 8 : 6;
@@ -1018,7 +1022,6 @@
 
 	/* note: tp->chipset set in rtl8139_init_board */
 	tp->drv_flags = board_info[ent->driver_data].hw_flags;
-	tp->mmio_addr = ioaddr;
 	tp->msg_enable =
 		(debug < 0 ? RTL8139_DEF_MSG_ENABLE : ((1 << debug) - 1));
 	spin_lock_init (&tp->lock);
@@ -1150,11 +1153,11 @@
 #define EE_READ_CMD		(6)
 #define EE_ERASE_CMD	(7)
 
-static int __devinit read_eeprom (void *ioaddr, int location, int addr_len)
+static int __devinit read_eeprom (void __iomem *ioaddr, int location, int addr_len)
 {
 	int i;
 	unsigned retval = 0;
-	void *ee_addr = ioaddr + Cfg9346;
+	void __iomem * ee_addr = ioaddr + Cfg9346;
 	int read_cmd = location | (EE_READ_CMD << addr_len);
 
 	writeb (EE_ENB & ~EE_CS, ee_addr);
@@ -1219,7 +1222,7 @@
 
 #ifdef CONFIG_8139TOO_8129
 /* Syncronize the MII management interface by shifting 32 one bits out. */
-static void mdio_sync (void *mdio_addr)
+static void mdio_sync (void __iomem *mdio_addr)
 {
 	int i;
 
@@ -1234,17 +1237,17 @@
 
 static int mdio_read (struct net_device *dev, int phy_id, int location)
 {
-	struct rtl8139_private *tp = netdev_priv(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int retval = 0;
 #ifdef CONFIG_8139TOO_8129
-	void *mdio_addr = tp->mmio_addr + Config4;
+	void __iomem * mdio_addr = ioaddr + Config4;
 	int mii_cmd = (0xf6 << 10) | (phy_id << 5) | location;
 	int i;
 #endif
 
 	if (phy_id > 31) {	/* Really a 8139.  Use internal registers. */
 		return location < 8 && mii_2_8139_map[location] ?
-		    readw (tp->mmio_addr + mii_2_8139_map[location]) : 0;
+		    readw (ioaddr + mii_2_8139_map[location]) : 0;
 	}
 
 #ifdef CONFIG_8139TOO_8129
@@ -1276,15 +1279,14 @@
 static void mdio_write (struct net_device *dev, int phy_id, int location,
 			int value)
 {
-	struct rtl8139_private *tp = netdev_priv(dev);
 #ifdef CONFIG_8139TOO_8129
-	void *mdio_addr = tp->mmio_addr + Config4;
+	void __iomem *mdio_addr = netdev_ioaddr(dev) + Config4;
 	int mii_cmd = (0x5002 << 16) | (phy_id << 23) | (location << 18) | value;
 	int i;
 #endif
 
 	if (phy_id > 31) {	/* Really a 8139.  Use internal registers. */
-		void *ioaddr = tp->mmio_addr;
+		void __iomem *ioaddr = netdev_ioaddr(dev);
 		if (location == 0) {
 			RTL_W8 (Cfg9346, Cfg9346_Unlock);
 			RTL_W16 (BasicModeCtrl, value);
@@ -1321,7 +1323,7 @@
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
 	int retval;
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	retval = request_irq (dev->irq, rtl8139_interrupt, SA_SHIRQ, dev->name, dev);
 	if (retval)
@@ -1378,7 +1380,7 @@
 static void rtl8139_hw_start (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	u32 i;
 	u8 tmp;
 
@@ -1480,7 +1482,7 @@
 				  struct rtl8139_private *tp)
 {
 	int linkcase;
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	/* This is a complicated state machine to configure the "twister" for
 	   impedance/echos based on the cable length.
@@ -1564,7 +1566,7 @@
 
 static inline void rtl8139_thread_iter (struct net_device *dev,
 				 struct rtl8139_private *tp,
-				 void *ioaddr)
+				 void __iomem *ioaddr)
 {
 	int mii_lpa;
 
@@ -1634,7 +1636,7 @@
 			break;
 
 		rtnl_lock ();
-		rtl8139_thread_iter (dev, tp, tp->mmio_addr);
+		rtl8139_thread_iter (dev, tp, netdev_ioaddr(dev));
 		rtnl_unlock ();
 	}
 
@@ -1672,7 +1674,7 @@
 static void rtl8139_tx_timeout (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int i;
 	u8 tmp8;
 	unsigned long flags;
@@ -1717,7 +1719,7 @@
 static int rtl8139_start_xmit (struct sk_buff *skb, struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	unsigned int entry;
 	unsigned int len = skb->len;
 
@@ -1759,7 +1761,7 @@
 
 static void rtl8139_tx_interrupt (struct net_device *dev,
 				  struct rtl8139_private *tp,
-				  void *ioaddr)
+				  void __iomem *ioaddr)
 {
 	unsigned long dirty_tx, tx_left;
 
@@ -1829,7 +1831,7 @@
 
 /* TODO: clean this up!  Rx reset need not be this intensive */
 static void rtl8139_rx_err (u32 rx_status, struct net_device *dev,
-			    struct rtl8139_private *tp, void *ioaddr)
+			    struct rtl8139_private *tp, void __iomem *ioaddr)
 {
 	u8 tmp8;
 #ifdef CONFIG_8139_OLD_RX_RESET
@@ -1924,9 +1926,10 @@
 }
 #endif
 
-static void rtl8139_isr_ack(struct rtl8139_private *tp)
+static void rtl8139_isr_ack(struct net_device *dev)
 {
-	void *ioaddr = tp->mmio_addr;
+	struct rtl8139_private *tp = netdev_priv(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	u16 status;
 
 	status = RTL_R16 (IntrStatus) & RxAckBits;
@@ -1945,7 +1948,7 @@
 static int rtl8139_rx(struct net_device *dev, struct rtl8139_private *tp,
 		      int budget)
 {
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int received = 0;
 	unsigned char *rx_ring = tp->rx_ring;
 	unsigned int cur_rx = tp->cur_rx;
@@ -2054,11 +2057,11 @@
 		cur_rx = (cur_rx + rx_size + 4 + 3) & ~3;
 		RTL_W16 (RxBufPtr, (u16) (cur_rx - 16));
 
-		rtl8139_isr_ack(tp);
+		rtl8139_isr_ack(dev);
 	}
 
 	if (unlikely(!received || rx_size == 0xfff0))
-		rtl8139_isr_ack(tp);
+		rtl8139_isr_ack(dev);
 
 #if RTL8139_DEBUG > 1
 	DPRINTK ("%s: Done rtl8139_rx(), current %4.4x BufAddr %4.4x,"
@@ -2083,7 +2086,7 @@
 
 static void rtl8139_weird_interrupt (struct net_device *dev,
 				     struct rtl8139_private *tp,
-				     void *ioaddr,
+				     void __iomem *ioaddr,
 				     int status, int link_changed)
 {
 	DPRINTK ("%s: Abnormal interrupt, status %8.8x.\n",
@@ -2123,7 +2126,7 @@
 static int rtl8139_poll(struct net_device *dev, int *budget)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int orig_budget = min(*budget, dev->quota);
 	int done = 1;
 
@@ -2159,9 +2162,9 @@
 static irqreturn_t rtl8139_interrupt (int irq, void *dev_instance,
 			       struct pt_regs *regs)
 {
-	struct net_device *dev = (struct net_device *) dev_instance;
+	struct net_device *dev = dev_instance;
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	u16 status, ackstat;
 	int link_changed = 0; /* avoid bogus "uninit" warning */
 	int handled = 0;
@@ -2237,7 +2240,7 @@
 static int rtl8139_close (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int ret = 0;
 	unsigned long flags;
 
@@ -2300,7 +2303,7 @@
 static void rtl8139_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct rtl8139_private *np = netdev_priv(dev);
-	void *ioaddr = np->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	spin_lock_irq(&np->lock);
 	if (rtl_chip_info[np->chipset].flags & HasLWake) {
@@ -2334,7 +2337,7 @@
 static int rtl8139_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct rtl8139_private *np = netdev_priv(dev);
-	void *ioaddr = np->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	u32 support;
 	u8 cfg3, cfg5;
 
@@ -2441,7 +2444,7 @@
 	regs->version = RTL_REGS_VER;
 
 	spin_lock_irq(&np->lock);
-	memcpy_fromio(regbuf, np->mmio_addr, regs->len);
+	memcpy_fromio(regbuf, netdev_ioaddr(dev), regs->len);
 	spin_unlock_irq(&np->lock);
 }
 #endif /* CONFIG_8139TOO_MMIO */
@@ -2502,7 +2505,7 @@
 static struct net_device_stats *rtl8139_get_stats (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	unsigned long flags;
 
 	if (netif_running(dev)) {
@@ -2521,7 +2524,7 @@
 static void __set_rx_mode (struct net_device *dev)
 {
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	u32 mc_filter[2];	/* Multicast hash filter */
 	int i, rx_mode;
 	u32 tmp;
@@ -2582,7 +2585,7 @@
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct rtl8139_private *tp = netdev_priv(dev);
-	void *ioaddr = tp->mmio_addr;
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	unsigned long flags;
 
 	pci_save_state (pdev);



