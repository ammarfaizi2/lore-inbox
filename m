Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263517AbUJ2UEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbUJ2UEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUJ2UDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:03:46 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:21392 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S263498AbUJ2UAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:00:13 -0400
Subject: [PATCH] net: fix natsemi base_addr casting
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: davem@davemloft.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       hch@infradead.org
In-Reply-To: <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
References: <1099044244.9566.0.camel@localhost>
	 <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
Date: Fri, 29 Oct 2004 23:01:28 +0300
Message-Id: <1099080089.9572.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds a mmioaddr field with proper void __iomem* type to
netdev_private struct and removes the ns_ioaddr function that messes around
with netdev->base_addr.

I tested this with actual hardware.  The code also passes sparse checks.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 natsemi.c |   83 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 42 insertions(+), 41 deletions(-)

Index: 2.6.10-rc1-mm1/drivers/net/natsemi.c
===================================================================
--- 2.6.10-rc1-mm1.orig/drivers/net/natsemi.c	2004-10-29 22:03:06.000000000 +0300
+++ 2.6.10-rc1-mm1/drivers/net/natsemi.c	2004-10-29 22:47:09.000000000 +0300
@@ -668,6 +668,7 @@
 };
 
 struct netdev_private {
+	void __iomem *mmioaddr;
 	/* Descriptor rings first for alignment */
 	dma_addr_t ring_dma;
 	struct netdev_desc *rx_ring;
@@ -770,15 +771,10 @@
 static int netdev_get_eeprom(struct net_device *dev, u8 *buf);
 static struct ethtool_ops ethtool_ops;
 
-static inline void __iomem *ns_ioaddr(struct net_device *dev)
-{
-	return (void __iomem *) dev->base_addr;
-}
-
 static void move_int_phy(struct net_device *dev, int addr)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	int target = 31;
 
 	/* 
@@ -867,11 +863,11 @@
 		prev_eedata = eedata;
 	}
 
-	dev->base_addr = (unsigned long __force) ioaddr;
 	dev->irq = irq;
 
 	np = netdev_priv(dev);
 
+	np->mmioaddr = ioaddr;
 	np->pci_dev = pdev;
 	pci_set_drvdata(pdev, dev);
 	np->iosize = iosize;
@@ -1073,7 +1069,8 @@
 static int mii_getbit (struct net_device *dev)
 {
 	int data;
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	writel(MII_ShiftClk, ioaddr + EECtrl);
 	data = readl(ioaddr + EECtrl);
@@ -1085,7 +1082,8 @@
 static void mii_send_bits (struct net_device *dev, u32 data, int len)
 {
 	u32 i;
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	for (i = (1 << (len-1)); i; i >>= 1)
 	{
@@ -1141,7 +1139,7 @@
 static int mdio_read(struct net_device *dev, int reg)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	/* The 83815 series has two ports:
 	 * - an internal transceiver
@@ -1156,7 +1154,7 @@
 static void mdio_write(struct net_device *dev, int reg, u16 data)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr; 
 
 	/* The 83815 series has an internal transceiver; handle separately */
 	if (dev->if_port == PORT_TP)
@@ -1168,7 +1166,7 @@
 static void init_phy_fixup(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	int i;
 	u32 cfg;
 	u16 tmp;
@@ -1280,7 +1278,7 @@
 static int switch_port_external(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	u32 cfg;
 
 	cfg = readl(ioaddr + ChipConfig);
@@ -1313,7 +1311,7 @@
 static int switch_port_internal(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	int i;
 	u32 cfg;
 	u16 bmcr;
@@ -1414,7 +1412,7 @@
 	u16 pmatch[3];
 	u16 sopass[3];
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	/*
 	 * Resetting the chip causes some registers to be lost.
@@ -1485,7 +1483,7 @@
 static void natsemi_reload_eeprom(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	int i;
 
 	writel(EepromReload, ioaddr + PCIBusCfg);
@@ -1505,8 +1503,8 @@
 
 static void natsemi_stop_rxtx(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int i;
 
 	writel(RxOff | TxOff, ioaddr + ChipCmd);
@@ -1527,7 +1525,7 @@
 static int netdev_open(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int i;
 
 	/* Reset the chip, just in case. */
@@ -1576,7 +1574,7 @@
 static void do_cable_magic(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	if (dev->if_port != PORT_TP)
 		return;
@@ -1621,7 +1619,7 @@
 {
 	u16 data;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	if (dev->if_port != PORT_TP)
 		return;
@@ -1640,7 +1638,7 @@
 static void check_link(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int duplex;
 	u16 bmsr;
        
@@ -1701,7 +1699,7 @@
 static void init_registers(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	init_phy_fixup(dev);
 
@@ -1780,7 +1778,7 @@
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int next_tick = 5*HZ;
 
 	if (netif_msg_timer(np)) {
@@ -1868,7 +1866,7 @@
 static void tx_timeout(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	disable_irq(dev->irq);
 	spin_lock_irq(&np->lock);
@@ -2068,7 +2066,7 @@
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	unsigned entry;
 
 	/* Note: Ordering is important here, set the field with the
@@ -2162,7 +2160,7 @@
 {
 	struct net_device *dev = dev_instance;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int boguscnt = max_interrupt_work;
 	unsigned int handled = 0;
 
@@ -2224,7 +2222,7 @@
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	s32 desc_status = le32_to_cpu(np->rx_head_desc->cmd_status);
 	unsigned int buflen = np->rx_buf_sz;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	/* If the driver owns the next entry it's a new packet. Send it up. */
 	while (desc_status < 0) { /* e.g. & DescOwn */
@@ -2312,7 +2310,7 @@
 static void netdev_error(struct net_device *dev, int intr_status)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	spin_lock(&np->lock);
 	if (intr_status & LinkChange) {
@@ -2371,8 +2369,8 @@
 
 static void __get_stats(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	/* The chip only need report frame silently dropped. */
 	np->stats.rx_crc_errors	+= readl(ioaddr + RxCRCErrs);
@@ -2404,8 +2402,8 @@
 #define HASH_TABLE	0x200
 static void __set_rx_mode(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u8 mc_filter[64]; /* Multicast hash filter */
 	u32 rx_mode;
 
@@ -2450,7 +2448,7 @@
 	/* synchronized against open : rtnl_lock() held by caller */
 	if (netif_running(dev)) {
 		struct netdev_private *np = netdev_priv(dev);
-		void __iomem * ioaddr = ns_ioaddr(dev);
+		void __iomem * ioaddr = np->mmioaddr;
 
 		disable_irq(dev->irq);
 		spin_lock(&np->lock);
@@ -2612,7 +2610,7 @@
 static int netdev_set_wol(struct net_device *dev, u32 newval)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u32 data = readl(ioaddr + WOLCmd) & ~WakeOptsSummary;
 
 	/* translate to bitmasks this chip understands */
@@ -2642,7 +2640,7 @@
 static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 *cur)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u32 regval = readl(ioaddr + WOLCmd);
 
 	*supported = (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST
@@ -2678,7 +2676,7 @@
 static int netdev_set_sopass(struct net_device *dev, u8 *newval)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u16 *sval = (u16 *)newval;
 	u32 addr;
 
@@ -2710,7 +2708,7 @@
 static int netdev_get_sopass(struct net_device *dev, u8 *data)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u16 *sval = (u16 *)data;
 	u32 addr;
 
@@ -2894,7 +2892,8 @@
 	int j;
 	u32 rfcr;
 	u32 *rbuf = (u32 *)buf;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	/* read non-mii page 0 of registers */
 	for (i = 0; i < NATSEMI_PG0_NREGS/2; i++) {
@@ -2944,7 +2943,8 @@
 {
 	int i;
 	u16 *ebuf = (u16 *)buf;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	/* eeprom_read reads 16 bits, and indexes by 16 bits */
 	for (i = 0; i < NATSEMI_EEPROM_SIZE/2; i++) {
@@ -3016,8 +3016,8 @@
 
 static void enable_wol_mode(struct net_device *dev, int enable_intr)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	if (netif_msg_wol(np))
 		printk(KERN_INFO "%s: remaining active for wake-on-lan\n",
@@ -3049,8 +3049,8 @@
 
 static int netdev_close(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	if (netif_msg_ifdown(np))
 		printk(KERN_DEBUG
@@ -3126,7 +3126,8 @@
 static void __devexit natsemi_remove1 (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	unregister_netdev (dev);
 	pci_release_regions (pdev);
@@ -3164,7 +3165,7 @@
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	rtnl_lock();
 	if (netif_running (dev)) {


