Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264909AbUKAOmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbUKAOmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUKAOmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:42:36 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61387 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S264909AbUKAO2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:28:46 -0500
Subject: Re: net: generic netdev_ioaddr
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <m3wtx6jx9r.fsf@defiant.pm.waw.pl>
References: <1099044244.9566.0.camel@localhost>
	 <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
	 <courier.418290EC.00002E85@courier.cs.helsinki.fi>
	 <m3y8hpbaf9.fsf@defiant.pm.waw.pl>
	 <20041029193827.GV24336@parcelfarce.linux.theplanet.co.uk>
	 <m3u0sdb53f.fsf@defiant.pm.waw.pl> <1099129946.10961.9.camel@localhost>
	 <m3r7nfem2v.fsf@defiant.pm.waw.pl> <1099206669.9571.10.camel@localhost>
	 <m3wtx6jx9r.fsf@defiant.pm.waw.pl>
Date: Mon, 01 Nov 2004 16:27:47 +0200
Message-Id: <1099319267.9550.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2004-11-01 at 00:14 +0100, Krzysztof Halasa wrote:
> IMHO partially: base_addr etc should go from the core (to driver's
> local structs if needed). I think no general netdev-setup thing is
> needed, we have module parameters and library functions.
> 
> No ioctl for such things is needed either.
> /sbin/ifconfig shouldn't mess with hardware data such as I/O address,
> IRQ etc. - it should be a configuration tool for software protocols,
> not for hardware (i.e. as /sbin/ip is).
> 
> My opinion of course.

FWIW I am running this patch on my box.  ifconfig doesn't mind but I am
not sure about the rtnetlink part.  I can start stabbing other drivers
if the maintainers are interested in this cleanup...

		Pekka

---

 drivers/net/Space.c       |   23 ++-----
 drivers/net/natsemi.c     |  134 +++++++++++++++++++++----------------------
 include/linux/netdevice.h |   12 ---
 net/core/dev.c            |  141 ----------------------------------------------
 net/core/rtnetlink.c      |   12 ---
 net/ethernet/eth.c        |    4 -
 6 files changed, 74 insertions(+), 252 deletions(-)

Index: 2.6.10-rc1-mm1/drivers/net/Space.c
===================================================================
--- 2.6.10-rc1-mm1.orig/drivers/net/Space.c	2004-11-01 16:11:34.682350032 +0200
+++ 2.6.10-rc1-mm1/drivers/net/Space.c	2004-11-01 16:12:31.554704120 +0200
@@ -322,17 +322,12 @@
  
 static void __init ethif_probe2(int unit)
 {
-	unsigned long base_addr = netdev_boot_base("eth", unit);
-
-	if (base_addr == 1)
-		return;
-
-	(void)(	probe_list2(unit, m68k_probes, base_addr == 0) &&
-		probe_list2(unit, mips_probes, base_addr == 0) &&
-		probe_list2(unit, eisa_probes, base_addr == 0) &&
-		probe_list2(unit, mca_probes, base_addr == 0) &&
-		probe_list2(unit, isa_probes, base_addr == 0) &&
-		probe_list2(unit, parport_probes, base_addr == 0));
+	(void)(	probe_list2(unit, m68k_probes, 1) &&
+		probe_list2(unit, mips_probes, 1) &&
+		probe_list2(unit, eisa_probes, 1) &&
+		probe_list2(unit, mca_probes, 1) &&
+		probe_list2(unit, isa_probes, 1) &&
+		probe_list2(unit, parport_probes, 1));
 }
 
 #ifdef CONFIG_TR
@@ -374,11 +369,7 @@
 
 static void __init trif_probe2(int unit)
 {
-	unsigned long base_addr = netdev_boot_base("tr", unit);
-
-	if (base_addr == 1)
-		return;
-	probe_list2(unit, tr_probes2, base_addr == 0);
+	probe_list2(unit, tr_probes2, 1);
 }
 #endif
 
Index: 2.6.10-rc1-mm1/drivers/net/natsemi.c
===================================================================
--- 2.6.10-rc1-mm1.orig/drivers/net/natsemi.c	2004-11-01 16:11:33.217572712 +0200
+++ 2.6.10-rc1-mm1/drivers/net/natsemi.c	2004-11-01 16:12:31.700681928 +0200
@@ -327,7 +327,7 @@
 is set, then access is permitted under spin_lock_irq(&np->lock).
 
 Thus configuration functions that want to access everything must call
-	disable_irq(dev->irq);
+	disable_irq(np->irq);
 	spin_lock_bh(dev->xmit_lock);
 	spin_lock_irq(&np->lock);
 
@@ -349,7 +349,7 @@
 
 
 
-enum pcistuff {
+enum {
 	PCI_USES_IO = 0x01,
 	PCI_USES_MEM = 0x02,
 	PCI_USES_MASTER = 0x04,
@@ -668,6 +668,8 @@
 };
 
 struct netdev_private {
+	void __iomem *mmioaddr;
+	unsigned int irq;
 	/* Descriptor rings first for alignment */
 	dma_addr_t ring_dma;
 	struct netdev_desc *rx_ring;
@@ -770,15 +772,10 @@
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
@@ -867,11 +864,11 @@
 		prev_eedata = eedata;
 	}
 
-	dev->base_addr = (unsigned long __force) ioaddr;
-	dev->irq = irq;
 
 	np = netdev_priv(dev);
 
+	np->mmioaddr = ioaddr;
+	np->irq = irq;
 	np->pci_dev = pdev;
 	pci_set_drvdata(pdev, dev);
 	np->iosize = iosize;
@@ -906,8 +903,6 @@
 	}
 
 	option = find_cnt < MAX_UNITS ? options[find_cnt] : 0;
-	if (dev->mem_start)
-		option = dev->mem_start;
 
 	/* The lower four bits are the media type. */
 	if (option) {
@@ -1073,7 +1068,8 @@
 static int mii_getbit (struct net_device *dev)
 {
 	int data;
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	writel(MII_ShiftClk, ioaddr + EECtrl);
 	data = readl(ioaddr + EECtrl);
@@ -1085,7 +1081,8 @@
 static void mii_send_bits (struct net_device *dev, u32 data, int len)
 {
 	u32 i;
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	for (i = (1 << (len-1)); i; i >>= 1)
 	{
@@ -1141,7 +1138,7 @@
 static int mdio_read(struct net_device *dev, int reg)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	/* The 83815 series has two ports:
 	 * - an internal transceiver
@@ -1156,7 +1153,7 @@
 static void mdio_write(struct net_device *dev, int reg, u16 data)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr; 
 
 	/* The 83815 series has an internal transceiver; handle separately */
 	if (dev->if_port == PORT_TP)
@@ -1168,7 +1165,7 @@
 static void init_phy_fixup(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	int i;
 	u32 cfg;
 	u16 tmp;
@@ -1280,7 +1277,7 @@
 static int switch_port_external(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	u32 cfg;
 
 	cfg = readl(ioaddr + ChipConfig);
@@ -1313,7 +1310,7 @@
 static int switch_port_internal(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	int i;
 	u32 cfg;
 	u16 bmcr;
@@ -1414,7 +1411,7 @@
 	u16 pmatch[3];
 	u16 sopass[3];
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	/*
 	 * Resetting the chip causes some registers to be lost.
@@ -1485,7 +1482,7 @@
 static void natsemi_reload_eeprom(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 	int i;
 
 	writel(EepromReload, ioaddr + PCIBusCfg);
@@ -1505,8 +1502,8 @@
 
 static void natsemi_stop_rxtx(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int i;
 
 	writel(RxOff | TxOff, ioaddr + ChipCmd);
@@ -1527,21 +1524,21 @@
 static int netdev_open(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int i;
 
 	/* Reset the chip, just in case. */
 	natsemi_reset(dev);
 
-	i = request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
+	i = request_irq(np->irq, &intr_handler, SA_SHIRQ, dev->name, dev);
 	if (i) return i;
 
 	if (netif_msg_ifup(np))
 		printk(KERN_DEBUG "%s: netdev_open() irq %d.\n",
-			dev->name, dev->irq);
+			dev->name, np->irq);
 	i = alloc_ring(dev);
 	if (i < 0) {
-		free_irq(dev->irq, dev);
+		free_irq(np->irq, dev);
 		return i;
 	}
 	init_ring(dev);
@@ -1576,7 +1573,7 @@
 static void do_cable_magic(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem *ioaddr = ns_ioaddr(dev);
+	void __iomem *ioaddr = np->mmioaddr;
 
 	if (dev->if_port != PORT_TP)
 		return;
@@ -1621,7 +1618,7 @@
 {
 	u16 data;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	if (dev->if_port != PORT_TP)
 		return;
@@ -1640,7 +1637,7 @@
 static void check_link(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int duplex;
 	u16 bmsr;
        
@@ -1701,7 +1698,7 @@
 static void init_registers(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	init_phy_fixup(dev);
 
@@ -1780,7 +1777,7 @@
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int next_tick = 5*HZ;
 
 	if (netif_msg_timer(np)) {
@@ -1805,14 +1802,14 @@
 				if (netif_msg_hw(np))
 					printk(KERN_NOTICE "%s: possible phy reset: "
 						"re-initializing\n", dev->name);
-				disable_irq(dev->irq);
+				disable_irq(np->irq);
 				spin_lock_irq(&np->lock);
 				natsemi_stop_rxtx(dev);
 				dump_ring(dev);
 				reinit_ring(dev);
 				init_registers(dev);
 				spin_unlock_irq(&np->lock);
-				enable_irq(dev->irq);
+				enable_irq(np->irq);
 			} else {
 				/* hurry back */
 				next_tick = HZ;
@@ -1829,10 +1826,10 @@
 		spin_unlock_irq(&np->lock);
 	}
 	if (np->oom) {
-		disable_irq(dev->irq);
+		disable_irq(np->irq);
 		np->oom = 0;
 		refill_rx(dev);
-		enable_irq(dev->irq);
+		enable_irq(np->irq);
 		if (!np->oom) {
 			writel(RxOn, ioaddr + ChipCmd);
 		} else {
@@ -1868,9 +1865,9 @@
 static void tx_timeout(struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
-	disable_irq(dev->irq);
+	disable_irq(np->irq);
 	spin_lock_irq(&np->lock);
 	if (!np->hands_off) {
 		if (netif_msg_tx_err(np))
@@ -1889,7 +1886,7 @@
 			dev->name);
 	}
 	spin_unlock_irq(&np->lock);
-	enable_irq(dev->irq);
+	enable_irq(np->irq);
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
@@ -2068,7 +2065,7 @@
 static int start_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	unsigned entry;
 
 	/* Note: Ordering is important here, set the field with the
@@ -2162,7 +2159,7 @@
 {
 	struct net_device *dev = dev_instance;
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	int boguscnt = max_interrupt_work;
 	unsigned int handled = 0;
 
@@ -2224,7 +2221,7 @@
 	int boguscnt = np->dirty_rx + RX_RING_SIZE - np->cur_rx;
 	s32 desc_status = le32_to_cpu(np->rx_head_desc->cmd_status);
 	unsigned int buflen = np->rx_buf_sz;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	/* If the driver owns the next entry it's a new packet. Send it up. */
 	while (desc_status < 0) { /* e.g. & DescOwn */
@@ -2312,7 +2309,7 @@
 static void netdev_error(struct net_device *dev, int intr_status)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	spin_lock(&np->lock);
 	if (intr_status & LinkChange) {
@@ -2371,8 +2368,8 @@
 
 static void __get_stats(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	/* The chip only need report frame silently dropped. */
 	np->stats.rx_crc_errors	+= readl(ioaddr + RxCRCErrs);
@@ -2395,17 +2392,17 @@
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void natsemi_poll_controller(struct net_device *dev)
 {
-	disable_irq(dev->irq);
-	intr_handler(dev->irq, dev, NULL);
-	enable_irq(dev->irq);
+	disable_irq(np->irq);
+	intr_handler(np->irq, dev, NULL);
+	enable_irq(np->irq);
 }
 #endif
 
 #define HASH_TABLE	0x200
 static void __set_rx_mode(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u8 mc_filter[64]; /* Multicast hash filter */
 	u32 rx_mode;
 
@@ -2450,9 +2447,9 @@
 	/* synchronized against open : rtnl_lock() held by caller */
 	if (netif_running(dev)) {
 		struct netdev_private *np = netdev_priv(dev);
-		void __iomem * ioaddr = ns_ioaddr(dev);
+		void __iomem * ioaddr = np->mmioaddr;
 
-		disable_irq(dev->irq);
+		disable_irq(np->irq);
 		spin_lock(&np->lock);
 		/* stop engines */
 		natsemi_stop_rxtx(dev);
@@ -2465,7 +2462,7 @@
 		/* restart engines */
 		writel(RxOn | TxOn, ioaddr + ChipCmd);
 		spin_unlock(&np->lock);
-		enable_irq(dev->irq);
+		enable_irq(np->irq);
 	}
 	return 0;
 }
@@ -2612,7 +2609,7 @@
 static int netdev_set_wol(struct net_device *dev, u32 newval)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u32 data = readl(ioaddr + WOLCmd) & ~WakeOptsSummary;
 
 	/* translate to bitmasks this chip understands */
@@ -2642,7 +2639,7 @@
 static int netdev_get_wol(struct net_device *dev, u32 *supported, u32 *cur)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u32 regval = readl(ioaddr + WOLCmd);
 
 	*supported = (WAKE_PHY | WAKE_UCAST | WAKE_MCAST | WAKE_BCAST
@@ -2678,7 +2675,7 @@
 static int netdev_set_sopass(struct net_device *dev, u8 *newval)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u16 *sval = (u16 *)newval;
 	u32 addr;
 
@@ -2710,7 +2707,7 @@
 static int netdev_get_sopass(struct net_device *dev, u8 *data)
 {
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 	u16 *sval = (u16 *)data;
 	u32 addr;
 
@@ -2894,7 +2891,8 @@
 	int j;
 	u32 rfcr;
 	u32 *rbuf = (u32 *)buf;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	/* read non-mii page 0 of registers */
 	for (i = 0; i < NATSEMI_PG0_NREGS/2; i++) {
@@ -2944,7 +2942,8 @@
 {
 	int i;
 	u16 *ebuf = (u16 *)buf;
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	/* eeprom_read reads 16 bits, and indexes by 16 bits */
 	for (i = 0; i < NATSEMI_EEPROM_SIZE/2; i++) {
@@ -3016,8 +3015,8 @@
 
 static void enable_wol_mode(struct net_device *dev, int enable_intr)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	if (netif_msg_wol(np))
 		printk(KERN_INFO "%s: remaining active for wake-on-lan\n",
@@ -3049,8 +3048,8 @@
 
 static int netdev_close(struct net_device *dev)
 {
-	void __iomem * ioaddr = ns_ioaddr(dev);
 	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	if (netif_msg_ifdown(np))
 		printk(KERN_DEBUG
@@ -3070,16 +3069,16 @@
 	 */
 
 	del_timer_sync(&np->timer);
-	disable_irq(dev->irq);
+	disable_irq(np->irq);
 	spin_lock_irq(&np->lock);
 	/* Disable interrupts, and flush posted writes */
 	writel(0, ioaddr + IntrEnable);
 	readl(ioaddr + IntrEnable);
 	np->hands_off = 1;
 	spin_unlock_irq(&np->lock);
-	enable_irq(dev->irq);
+	enable_irq(np->irq);
 
-	free_irq(dev->irq, dev);
+	free_irq(np->irq, dev);
 
 	/* Interrupt disabled, interrupt handler released,
 	 * queue stopped, timer deleted, rtnl_lock held
@@ -3126,7 +3125,8 @@
 static void __devexit natsemi_remove1 (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	struct netdev_private *np = netdev_priv(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	unregister_netdev (dev);
 	pci_release_regions (pdev);
@@ -3164,13 +3164,13 @@
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
-	void __iomem * ioaddr = ns_ioaddr(dev);
+	void __iomem * ioaddr = np->mmioaddr;
 
 	rtnl_lock();
 	if (netif_running (dev)) {
 		del_timer_sync(&np->timer);
 
-		disable_irq(dev->irq);
+		disable_irq(np->irq);
 		spin_lock_irq(&np->lock);
 
 		writel(0, ioaddr + IntrEnable);
@@ -3179,7 +3179,7 @@
 		netif_stop_queue(dev);
 
 		spin_unlock_irq(&np->lock);
-		enable_irq(dev->irq);
+		enable_irq(np->irq);
 
 		/* Update the error counts. */
 		__get_stats(dev);
@@ -3222,13 +3222,13 @@
 
 		natsemi_reset(dev);
 		init_ring(dev);
-		disable_irq(dev->irq);
+		disable_irq(np->irq);
 		spin_lock_irq(&np->lock);
 		np->hands_off = 0;
 		init_registers(dev);
 		netif_device_attach(dev);
 		spin_unlock_irq(&np->lock);
-		enable_irq(dev->irq);
+		enable_irq(np->irq);
 
 		mod_timer(&np->timer, jiffies + 1*HZ);
 	}
Index: 2.6.10-rc1-mm1/include/linux/netdevice.h
===================================================================
--- 2.6.10-rc1-mm1.orig/include/linux/netdevice.h	2004-11-01 16:11:34.683349880 +0200
+++ 2.6.10-rc1-mm1/include/linux/netdevice.h	2004-11-01 16:12:31.625693328 +0200
@@ -272,15 +272,6 @@
 	char			name[IFNAMSIZ];
 
 	/*
-	 *	I/O specific fields
-	 *	FIXME: Merge these and struct ifmap into one
-	 */
-	unsigned long		mem_end;	/* shared mem end	*/
-	unsigned long		mem_start;	/* shared mem start	*/
-	unsigned long		base_addr;	/* device I/O address	*/
-	unsigned int		irq;		/* device IRQ number	*/
-
-	/*
 	 *	Some hardware also needs these fields, but they are not
 	 *	part of the usual set specified in Space.c.
 	 */
@@ -522,9 +513,6 @@
 extern struct net_device		*dev_base;		/* All devices */
 extern rwlock_t				dev_base_lock;		/* Device list lock */
 
-extern int			netdev_boot_setup_add(char *name, struct ifmap *map);
-extern int 			netdev_boot_setup_check(struct net_device *dev);
-extern unsigned long		netdev_boot_base(const char *prefix, int unit);
 extern struct net_device    *dev_getbyhwaddr(unsigned short type, char *hwaddr);
 extern struct net_device *__dev_getfirstbyhwtype(unsigned short type);
 extern struct net_device *dev_getfirstbyhwtype(unsigned short type);
Index: 2.6.10-rc1-mm1/net/core/dev.c
===================================================================
--- 2.6.10-rc1-mm1.orig/net/core/dev.c	2004-11-01 16:11:35.376244544 +0200
+++ 2.6.10-rc1-mm1/net/core/dev.c	2004-11-01 16:12:31.559703360 +0200
@@ -343,129 +343,6 @@
 	synchronize_net();
 }
 
-/******************************************************************************
-
-		      Device Boot-time Settings Routines
-
-*******************************************************************************/
-
-/* Boot time configuration table */
-static struct netdev_boot_setup dev_boot_setup[NETDEV_BOOT_SETUP_MAX];
-
-/**
- *	netdev_boot_setup_add	- add new setup entry
- *	@name: name of the device
- *	@map: configured settings for the device
- *
- *	Adds new setup entry to the dev_boot_setup list.  The function
- *	returns 0 on error and 1 on success.  This is a generic routine to
- *	all netdevices.
- */
-int netdev_boot_setup_add(char *name, struct ifmap *map)
-{
-	struct netdev_boot_setup *s;
-	int i;
-
-	s = dev_boot_setup;
-	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
-		if (s[i].name[0] == '\0' || s[i].name[0] == ' ') {
-			memset(s[i].name, 0, sizeof(s[i].name));
-			strcpy(s[i].name, name);
-			memcpy(&s[i].map, map, sizeof(s[i].map));
-			break;
-		}
-	}
-
-	return i >= NETDEV_BOOT_SETUP_MAX ? 0 : 1;
-}
-
-/**
- *	netdev_boot_setup_check	- check boot time settings
- *	@dev: the netdevice
- *
- * 	Check boot time settings for the device.
- *	The found settings are set for the device to be used
- *	later in the device probing.
- *	Returns 0 if no settings found, 1 if they are.
- */
-int netdev_boot_setup_check(struct net_device *dev)
-{
-	struct netdev_boot_setup *s = dev_boot_setup;
-	int i;
-
-	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
-		if (s[i].name[0] != '\0' && s[i].name[0] != ' ' &&
-		    !strncmp(dev->name, s[i].name, strlen(s[i].name))) {
-			dev->irq 	= s[i].map.irq;
-			dev->base_addr 	= s[i].map.base_addr;
-			dev->mem_start 	= s[i].map.mem_start;
-			dev->mem_end 	= s[i].map.mem_end;
-			return 1;
-		}
-	}
-	return 0;
-}
-
-
-/**
- *	netdev_boot_base	- get address from boot time settings
- *	@prefix: prefix for network device
- *	@unit: id for network device
- *
- * 	Check boot time settings for the base address of device.
- *	The found settings are set for the device to be used
- *	later in the device probing.
- *	Returns 0 if no settings found.
- */
-unsigned long netdev_boot_base(const char *prefix, int unit)
-{
-	const struct netdev_boot_setup *s = dev_boot_setup;
-	char name[IFNAMSIZ];
-	int i;
-
-	sprintf(name, "%s%d", prefix, unit);
-
-	/*
-	 * If device already registered then return base of 1
-	 * to indicate not to probe for this interface
-	 */
-	if (__dev_get_by_name(name))
-		return 1;
-
-	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++)
-		if (!strcmp(name, s[i].name))
-			return s[i].map.base_addr;
-	return 0;
-}
-
-/*
- * Saves at boot time configured settings for any netdevice.
- */
-int __init netdev_boot_setup(char *str)
-{
-	int ints[5];
-	struct ifmap map;
-
-	str = get_options(str, ARRAY_SIZE(ints), ints);
-	if (!str || !*str)
-		return 0;
-
-	/* Save settings */
-	memset(&map, 0, sizeof(map));
-	if (ints[0] > 0)
-		map.irq = ints[1];
-	if (ints[0] > 1)
-		map.base_addr = ints[2];
-	if (ints[0] > 2)
-		map.mem_start = ints[3];
-	if (ints[0] > 3)
-		map.mem_end = ints[4];
-
-	/* Add new entry to the list */
-	return netdev_boot_setup_add(str, &map);
-}
-
-__setup("netdev=", netdev_boot_setup);
 
 /*******************************************************************************
 
@@ -2404,23 +2281,6 @@
 					    NETDEV_CHANGEADDR, dev);
 			return 0;
 
-		case SIOCGIFMAP:
-			ifr->ifr_map.mem_start = dev->mem_start;
-			ifr->ifr_map.mem_end   = dev->mem_end;
-			ifr->ifr_map.base_addr = dev->base_addr;
-			ifr->ifr_map.irq       = dev->irq;
-			ifr->ifr_map.dma       = dev->dma;
-			ifr->ifr_map.port      = dev->if_port;
-			return 0;
-
-		case SIOCSIFMAP:
-			if (dev->set_config) {
-				if (!netif_device_present(dev))
-					return -ENODEV;
-				return dev->set_config(dev, &ifr->ifr_map);
-			}
-			return -EOPNOTSUPP;
-
 		case SIOCADDMULTI:
 			if (!dev->set_multicast_list ||
 			    ifr->ifr_hwaddr.sa_family != AF_UNSPEC)
@@ -3264,7 +3124,6 @@
 EXPORT_SYMBOL(dev_change_name);
 EXPORT_SYMBOL(dev_set_mtu);
 EXPORT_SYMBOL(free_netdev);
-EXPORT_SYMBOL(netdev_boot_setup_check);
 EXPORT_SYMBOL(netdev_set_master);
 EXPORT_SYMBOL(netdev_state_change);
 EXPORT_SYMBOL(netif_receive_skb);
Index: 2.6.10-rc1-mm1/net/core/rtnetlink.c
===================================================================
--- 2.6.10-rc1-mm1.orig/net/core/rtnetlink.c	2004-11-01 16:11:32.428692640 +0200
+++ 2.6.10-rc1-mm1/net/core/rtnetlink.c	2004-11-01 16:12:31.755673568 +0200
@@ -181,18 +181,6 @@
 		RTA_PUT(skb, IFLA_WEIGHT, sizeof(weight), &weight);
 	}
 
-	if (1) {
-		struct rtnl_link_ifmap map = {
-			.mem_start   = dev->mem_start,
-			.mem_end     = dev->mem_end,
-			.base_addr   = dev->base_addr,
-			.irq         = dev->irq,
-			.dma         = dev->dma,
-			.port        = dev->if_port,
-		};
-		RTA_PUT(skb, IFLA_MAP, sizeof(map), &map);
-	}
-
 	if (dev->addr_len) {
 		RTA_PUT(skb, IFLA_ADDRESS, dev->addr_len, dev->dev_addr);
 		RTA_PUT(skb, IFLA_BROADCAST, dev->addr_len, dev->broadcast);
Index: 2.6.10-rc1-mm1/net/ethernet/eth.c
===================================================================
--- 2.6.10-rc1-mm1.orig/net/ethernet/eth.c	2004-11-01 16:11:34.687349272 +0200
+++ 2.6.10-rc1-mm1/net/ethernet/eth.c	2004-11-01 16:12:31.560703208 +0200
@@ -62,10 +62,6 @@
 #include <asm/system.h>
 #include <asm/checksum.h>
 
-extern int __init netdev_boot_setup(char *str);
-
-__setup("ether=", netdev_boot_setup);
-
 /*
  *	 Create the Ethernet MAC header for an arbitrary protocol layer 
  *


