Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263201AbUJ2KIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbUJ2KIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbUJ2KIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:08:50 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:64167 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S263201AbUJ2KEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:04:02 -0400
Subject: [PATCH 2/3] net: use netdev_ioaddr in natsemi
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: davem@davemloft.net
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <1099044278.9566.2.camel@localhost>
References: <1099044244.9566.0.camel@localhost>
	 <1099044278.9566.2.camel@localhost>
Date: Fri, 29 Oct 2004 13:05:15 +0300
Message-Id: <1099044315.9566.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts natsemi driver to use netdev_ioaddr.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 natsemi.c |   75 ++++++++++++++++++++++++++++----------------------------------
 1 files changed, 35 insertions(+), 40 deletions(-)

Index: 2.6.10-rc1-mm1/drivers/net/natsemi.c
===================================================================
--- 2.6.10-rc1-mm1.orig/drivers/net/natsemi.c	2004-10-29 11:07:52.000000000 +0300
+++ 2.6.10-rc1-mm1/drivers/net/natsemi.c	2004-10-29 11:38:30.000000000 +0300
@@ -770,15 +770,10 @@
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
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int target = 31;
 
 	/* 
@@ -1073,7 +1068,7 @@
 static int mii_getbit (struct net_device *dev)
 {
 	int data;
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	writel(MII_ShiftClk, ioaddr + EECtrl);
 	data = readl(ioaddr + EECtrl);
@@ -1085,7 +1080,7 @@
 static void mii_send_bits (struct net_device *dev, u32 data, int len)
 {
 	u32 i;
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	for (i = (1 << (len-1)); i; i >>= 1)
 	{
@@ -1141,7 +1136,7 @@
 static int mdio_read(struct net_device *dev, int reg)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	/* The 83815 series has two ports:
 	 * - an internal transceiver
@@ -1156,7 +1151,7 @@
 static void mdio_write(struct net_device *dev, int reg, u16 data)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	/* The 83815 series has an internal transceiver; handle separately */
 	if (dev->if_port == PORT_TP)
@@ -1168,7 +1163,7 @@
 static void init_phy_fixup(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int i;
 	u32 cfg;
 	u16 tmp;
@@ -1280,7 +1275,7 @@
 static int switch_port_external(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	u32 cfg;
 
 	cfg = readl(ioaddr + ChipConfig);
@@ -1313,7 +1308,7 @@
 static int switch_port_internal(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int i;
 	u32 cfg;
 	u16 bmcr;
@@ -1414,7 +1409,7 @@
 	u16 pmatch[3];
 	u16 sopass[3];
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	/*
 	 * Resetting the chip causes some registers to be lost.
@@ -1485,7 +1480,7 @@
 static void natsemi_reload_eeprom(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 	int i;
 
 	writel(EepromReload, ioaddr + PCIBusCfg);
@@ -1505,7 +1500,7 @@
 
 static void natsemi_stop_rxtx(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 	int i;
 
@@ -1527,7 +1522,7 @@
 static int netdev_open(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	int i;
 
 	/* Reset the chip, just in case. */
@@ -1576,7 +1571,7 @@
 static void do_cable_magic(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = netdev_ioaddr(dev);
 
 	if (dev->if_port != PORT_TP)
 		return;
@@ -1621,7 +1616,7 @@
 {
 	u16 data;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	if (dev->if_port != PORT_TP)
 		return;
@@ -1640,7 +1635,7 @@
 static void check_link(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	int duplex;
 	u16 bmsr;
        
@@ -1701,7 +1696,7 @@
 static void init_registers(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	init_phy_fixup(dev);
 
@@ -1780,7 +1775,7 @@
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	int next_tick = 5*HZ;
 
 	if (netif_msg_timer(np)) {
@@ -1868,7 +1863,7 @@
 static void tx_timeout(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	disable_irq(dev->irq);
 	spin_lock_irq(&np->lock);
@@ -2068,7 +2063,7 @@
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	unsigned entry;
 
 	/* Note: Ordering is important here, set the field with the
@@ -2162,7 +2157,7 @@
 {
 	struct net_device *dev = dev_instance;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	int boguscnt = max_interrupt_work;
 	unsigned int handled = 0;
 
@@ -2224,7 +2219,7 @@
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	s32 desc_status = le32_to_cpu(np->rx_head_desc->cmd_status);
 	unsigned int buflen = np->rx_buf_sz;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	/* If the driver owns the next entry it's a new packet. Send it up. */
 	while (desc_status < 0) { /* e.g. & DescOwn */
@@ -2312,7 +2307,7 @@
 static void netdev_error(struct net_device *dev, int intr_status)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	spin_lock(&np->lock);
 	if (intr_status & LinkChange) {
@@ -2371,7 +2366,7 @@
 
 static void __get_stats(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 
 	/* The chip only need report frame silently dropped. */
@@ -2404,7 +2399,7 @@
 #define HASH_TABLE	0x200
 static void __set_rx_mode(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 	u8 mc_filter[64]; /* Multicast hash filter */
 	u32 rx_mode;
@@ -2450,7 +2445,7 @@
 	/* synchronized against open : rtnl_lock() held by caller */
 	if (netif_running(dev)) {
 		struct netdev_private *np = netdev_priv(dev);
-		void __iomem * ioaddr = ns_ioaddr(dev);
+		void __iomem * ioaddr = netdev_ioaddr(dev);
 
 		disable_irq(dev->irq);
 		spin_lock(&np->lock);
@@ -2612,7 +2607,7 @@
 static int netdev_set_wol(struct net_device *dev, u32 newval)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	u32 data = readl(ioaddr + WOLCmd) & ~WakeOptsSummary;
 
 	/* translate to bitmasks this chip understands */
@@ -2642,7 +2637,7 @@
 static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 *cur)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	u32 regval = readl(ioaddr + WOLCmd);
 
 	*supported = (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST
@@ -2678,7 +2673,7 @@
 static int netdev_set_sopass(struct net_device *dev, u8 *newval)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	u16 *sval = (u16 *)newval;
 	u32 addr;
 
@@ -2710,7 +2705,7 @@
 static int netdev_get_sopass(struct net_device *dev, u8 *data)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	u16 *sval = (u16 *)data;
 	u32 addr;
 
@@ -2894,7 +2889,7 @@
 	int j;
 	u32 rfcr;
 	u32 *rbuf = (u32 *)buf;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	/* read non-mii page 0 of registers */
 	for (i = 0; i < NATSEMI_PG0_NREGS/2; i++) {
@@ -2944,7 +2939,7 @@
 {
 	int i;
 	u16 *ebuf = (u16 *)buf;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	/* eeprom_read reads 16 bits, and indexes by 16 bits */
 	for (i = 0; i < NATSEMI_EEPROM_SIZE/2; i++) {
@@ -3016,7 +3011,7 @@
 
 static void enable_wol_mode(struct net_device *dev, int enable_intr)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 
 	if (netif_msg_wol(np))
@@ -3049,7 +3044,7 @@
 
 static int netdev_close(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
 
 	if (netif_msg_ifdown(np))
@@ -3126,7 +3121,7 @@
 static void __devexit natsemi_remove1 (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	unregister_netdev (dev);
 	pci_release_regions (pdev);
@@ -3164,7 +3159,7 @@
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = netdev_ioaddr(dev);
 
 	rtnl_lock();
 	if (netif_running (dev)) {



