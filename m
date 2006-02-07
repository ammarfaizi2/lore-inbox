Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWBGIDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWBGIDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 03:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWBGIDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 03:03:13 -0500
Received: from havoc.gtf.org ([69.61.125.42]:14055 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750763AbWBGIDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 03:03:10 -0500
Date: Tue, 7 Feb 2006 03:03:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060207080301.GA27206@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/8139too.c            |   38 +++++--
 drivers/net/Kconfig              |    7 -
 drivers/net/bonding/bond_main.c  |   15 ++-
 drivers/net/bonding/bond_sysfs.c |    6 -
 drivers/net/e100.c               |    2 
 drivers/net/gianfar.c            |   24 ++---
 drivers/net/gianfar.h            |    8 -
 drivers/net/gianfar_ethtool.c    |    8 -
 drivers/net/gianfar_mii.c        |   17 +--
 drivers/net/r8169.c              |   13 +-
 drivers/net/sis900.h             |    1 
 drivers/net/sky2.c               |  186 +++++++++++++++++++++++++++++----------
 drivers/net/sky2.h               |    9 -
 drivers/net/tulip/uli526x.c      |    2 
 drivers/net/wan/dscc4.c          |    2 
 15 files changed, 222 insertions(+), 116 deletions(-)

Alexey Dobriyan:
      dscc4: fix dscc4_init_dummy_skb check
      dscc4: fix dscc4_init_dummy_skb check
      [same change, two different paths. -ed]

Andrew Morton:
      uli526x warning fix

Andy Gospodarek:
      r8169: fix forced-mode link settings

Francois Romieu:
      r8169: prevent excessive busy-waiting
      8139too: fix a TX timeout watchdog thread against NAPI softirq race

Jay Vosburgh:
      bonding: allow bond to use TSO if slaves support it

Jesse Brandeburg:
      e100: remove init_hw call to fix panic

Kumar Gala:
      gianfar: Fix sparse warnings

Lennert Buytenhek:
      sis900: remove cfgpmcsr I/O space register define

Luiz Fernando Capitulino:
      bonding: Sparse warnings fix

Paolo 'Blaisorblade' Giarrusso:
      Kbuild menu - hide empty NETDEVICES menu when NET is disabled

Stephen Hemminger:
      sky2: power management fix
      sky2: pci config space checking
      sky2: ethtool rx_coalesce settings fix
      sky2: set mac address fix
      sky2: clear irq race
      sky2: add irq to entropy pool
      sky2: support msi interrupt (revised)
      sky2: version 0.15 update

diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
index adfba44..2beac55 100644
--- a/drivers/net/8139too.c
+++ b/drivers/net/8139too.c
@@ -586,6 +586,7 @@ struct rtl8139_private {
 	dma_addr_t tx_bufs_dma;
 	signed char phys[4];		/* MII device addresses. */
 	char twistie, twist_row, twist_col;	/* Twister tune state. */
+	unsigned int watchdog_fired : 1;
 	unsigned int default_port : 4;	/* Last dev->if_port value. */
 	unsigned int have_thread : 1;
 	spinlock_t lock;
@@ -638,6 +639,7 @@ static void rtl8139_set_rx_mode (struct 
 static void __set_rx_mode (struct net_device *dev);
 static void rtl8139_hw_start (struct net_device *dev);
 static void rtl8139_thread (void *_data);
+static void rtl8139_tx_timeout_task(void *_data);
 static struct ethtool_ops rtl8139_ethtool_ops;
 
 /* write MMIO register, with flush */
@@ -1598,13 +1600,14 @@ static void rtl8139_thread (void *_data)
 {
 	struct net_device *dev = _data;
 	struct rtl8139_private *tp = netdev_priv(dev);
-	unsigned long thr_delay;
+	unsigned long thr_delay = next_tick;
 
-	if (rtnl_shlock_nowait() == 0) {
+	if (tp->watchdog_fired) {
+		tp->watchdog_fired = 0;
+		rtl8139_tx_timeout_task(_data);
+	} else if (rtnl_shlock_nowait() == 0) {
 		rtl8139_thread_iter (dev, tp, tp->mmio_addr);
 		rtnl_unlock ();
-
-		thr_delay = next_tick;
 	} else {
 		/* unlikely race.  mitigate with fast poll. */
 		thr_delay = HZ / 2;
@@ -1631,7 +1634,8 @@ static void rtl8139_stop_thread(struct r
 	if (tp->have_thread) {
 		cancel_rearming_delayed_work(&tp->thread);
 		tp->have_thread = 0;
-	}
+	} else
+		flush_scheduled_work();
 }
 
 static inline void rtl8139_tx_clear (struct rtl8139_private *tp)
@@ -1642,14 +1646,13 @@ static inline void rtl8139_tx_clear (str
 	/* XXX account for unsent Tx packets in tp->stats.tx_dropped */
 }
 
-
-static void rtl8139_tx_timeout (struct net_device *dev)
+static void rtl8139_tx_timeout_task (void *_data)
 {
+	struct net_device *dev = _data;
 	struct rtl8139_private *tp = netdev_priv(dev);
 	void __iomem *ioaddr = tp->mmio_addr;
 	int i;
 	u8 tmp8;
-	unsigned long flags;
 
 	printk (KERN_DEBUG "%s: Transmit timeout, status %2.2x %4.4x %4.4x "
 		"media %2.2x.\n", dev->name, RTL_R8 (ChipCmd),
@@ -1670,23 +1673,34 @@ static void rtl8139_tx_timeout (struct n
 	if (tmp8 & CmdTxEnb)
 		RTL_W8 (ChipCmd, CmdRxEnb);
 
-	spin_lock(&tp->rx_lock);
+	spin_lock_bh(&tp->rx_lock);
 	/* Disable interrupts by clearing the interrupt mask. */
 	RTL_W16 (IntrMask, 0x0000);
 
 	/* Stop a shared interrupt from scavenging while we are. */
-	spin_lock_irqsave (&tp->lock, flags);
+	spin_lock_irq(&tp->lock);
 	rtl8139_tx_clear (tp);
-	spin_unlock_irqrestore (&tp->lock, flags);
+	spin_unlock_irq(&tp->lock);
 
 	/* ...and finally, reset everything */
 	if (netif_running(dev)) {
 		rtl8139_hw_start (dev);
 		netif_wake_queue (dev);
 	}
-	spin_unlock(&tp->rx_lock);
+	spin_unlock_bh(&tp->rx_lock);
 }
 
+static void rtl8139_tx_timeout (struct net_device *dev)
+{
+	struct rtl8139_private *tp = netdev_priv(dev);
+
+	if (!tp->have_thread) {
+		INIT_WORK(&tp->thread, rtl8139_tx_timeout_task, dev);
+		schedule_delayed_work(&tp->thread, next_tick);
+	} else
+		tp->watchdog_fired = 1;
+
+}
 
 static int rtl8139_start_xmit (struct sk_buff *skb, struct net_device *dev)
 {
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 6a6a084..47c72a6 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -4,9 +4,9 @@
 #
 
 menu "Network device support"
+	depends on NET
 
 config NETDEVICES
-	depends on NET
 	default y if UML
 	bool "Network device support"
 	---help---
@@ -24,9 +24,6 @@ config NETDEVICES
 
 	  If unsure, say Y.
 
-# All the following symbols are dependent on NETDEVICES - do not repeat
-# that for each of the symbols.
-if NETDEVICES
 
 config IFB
 	tristate "Intermediate Functional Block support"
@@ -2718,8 +2715,6 @@ config NETCONSOLE
 	If you want to log kernel messages over the network, enable this.
 	See <file:Documentation/networking/netconsole.txt> for details.
 
-endif #NETDEVICES
-
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4ff006c..e0f51af 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1145,7 +1145,8 @@ int bond_sethwaddr(struct net_device *bo
 }
 
 #define BOND_INTERSECT_FEATURES \
-	(NETIF_F_SG|NETIF_F_IP_CSUM|NETIF_F_NO_CSUM|NETIF_F_HW_CSUM)
+	(NETIF_F_SG|NETIF_F_IP_CSUM|NETIF_F_NO_CSUM|NETIF_F_HW_CSUM|\
+	NETIF_F_TSO|NETIF_F_UFO)
 
 /* 
  * Compute the common dev->feature set available to all slaves.  Some
@@ -1168,6 +1169,16 @@ static int bond_compute_features(struct 
 			  NETIF_F_HW_CSUM)))
 		features &= ~NETIF_F_SG;
 
+	/* 
+	 * features will include NETIF_F_TSO (NETIF_F_UFO) iff all 
+	 * slave devices support NETIF_F_TSO (NETIF_F_UFO), which 
+	 * implies that all slaves also support scatter-gather 
+	 * (NETIF_F_SG), which implies that features also includes 
+	 * NETIF_F_SG. So no need to check whether we have an  
+	 * illegal combination of NETIF_F_{TSO,UFO} and 
+	 * !NETIF_F_SG 
+	 */
+
 	features |= (bond_dev->features & ~BOND_INTERSECT_FEATURES);
 	bond_dev->features = features;
 
@@ -4080,6 +4091,8 @@ static void bond_ethtool_get_drvinfo(str
 
 static struct ethtool_ops bond_ethtool_ops = {
 	.get_tx_csum		= ethtool_op_get_tx_csum,
+	.get_tso		= ethtool_op_get_tso,
+	.get_ufo		= ethtool_op_get_ufo,
 	.get_sg			= ethtool_op_get_sg,
 	.get_drvinfo		= bond_ethtool_get_drvinfo,
 };
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 32d13da..041bcc5 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -260,7 +260,7 @@ static ssize_t bonding_store_slaves(stru
 	char *ifname;
 	int i, res, found, ret = count;
 	struct slave *slave;
-	struct net_device *dev = 0;
+	struct net_device *dev = NULL;
 	struct bonding *bond = to_bond(cd);
 
 	/* Quick sanity check -- is the bond interface up? */
@@ -995,7 +995,7 @@ static ssize_t bonding_store_primary(str
 			printk(KERN_INFO DRV_NAME
 			       ": %s: Setting primary slave to None.\n",
 			       bond->dev->name);
-			bond->primary_slave = 0;
+			bond->primary_slave = NULL;
 				bond_select_active_slave(bond);
 		} else {
 			printk(KERN_INFO DRV_NAME
@@ -1123,7 +1123,7 @@ static ssize_t bonding_store_active_slav
 			printk(KERN_INFO DRV_NAME
 			       ": %s: Setting active slave to None.\n",
 			       bond->dev->name);
-			bond->primary_slave = 0;
+			bond->primary_slave = NULL;
 				bond_select_active_slave(bond);
 		} else {
 			printk(KERN_INFO DRV_NAME
diff --git a/drivers/net/e100.c b/drivers/net/e100.c
index bf1fd2b..24253c8 100644
--- a/drivers/net/e100.c
+++ b/drivers/net/e100.c
@@ -2752,8 +2752,6 @@ static int e100_resume(struct pci_dev *p
 	retval = pci_enable_wake(pdev, 0, 0);
 	if (retval)
 		DPRINTK(PROBE,ERR, "Error clearing wake events\n");
-	if(e100_hw_init(nic))
-		DPRINTK(HW, ERR, "e100_hw_init failed\n");
 
 	netif_device_attach(netdev);
 	if(netif_running(netdev))
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 0c18dbd..0e8e3fc 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -199,8 +199,7 @@ static int gfar_probe(struct platform_de
 
 	/* get a pointer to the register memory */
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = (struct gfar *)
-		ioremap(r->start, sizeof (struct gfar));
+	priv->regs = ioremap(r->start, sizeof (struct gfar));
 
 	if (NULL == priv->regs) {
 		err = -ENOMEM;
@@ -369,7 +368,7 @@ static int gfar_probe(struct platform_de
 	return 0;
 
 register_fail:
-	iounmap((void *) priv->regs);
+	iounmap(priv->regs);
 regs_fail:
 	free_netdev(dev);
 	return err;
@@ -382,7 +381,7 @@ static int gfar_remove(struct platform_d
 
 	platform_set_drvdata(pdev, NULL);
 
-	iounmap((void *) priv->regs);
+	iounmap(priv->regs);
 	free_netdev(dev);
 
 	return 0;
@@ -454,8 +453,7 @@ static void init_registers(struct net_de
 
 	/* Zero out the rmon mib registers if it has them */
 	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_RMON) {
-		memset((void *) &(priv->regs->rmon), 0,
-		       sizeof (struct rmon_mib));
+		memset_io(&(priv->regs->rmon), 0, sizeof (struct rmon_mib));
 
 		/* Mask off the CAM interrupts */
 		gfar_write(&priv->regs->rmon.cam1, 0xffffffff);
@@ -477,7 +475,7 @@ static void init_registers(struct net_de
 void gfar_halt(struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
-	struct gfar *regs = priv->regs;
+	struct gfar __iomem *regs = priv->regs;
 	u32 tempval;
 
 	/* Mask all interrupts */
@@ -507,7 +505,7 @@ void gfar_halt(struct net_device *dev)
 void stop_gfar(struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
-	struct gfar *regs = priv->regs;
+	struct gfar __iomem *regs = priv->regs;
 	unsigned long flags;
 
 	phy_stop(priv->phydev);
@@ -590,7 +588,7 @@ static void free_skb_resources(struct gf
 void gfar_start(struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
-	struct gfar *regs = priv->regs;
+	struct gfar __iomem *regs = priv->regs;
 	u32 tempval;
 
 	/* Enable Rx and Tx in MACCFG1 */
@@ -624,7 +622,7 @@ int startup_gfar(struct net_device *dev)
 	unsigned long vaddr;
 	int i;
 	struct gfar_private *priv = netdev_priv(dev);
-	struct gfar *regs = priv->regs;
+	struct gfar __iomem *regs = priv->regs;
 	int err = 0;
 	u32 rctrl = 0;
 	u32 attrs = 0;
@@ -1622,7 +1620,7 @@ static irqreturn_t gfar_interrupt(int ir
 static void adjust_link(struct net_device *dev)
 {
 	struct gfar_private *priv = netdev_priv(dev);
-	struct gfar *regs = priv->regs;
+	struct gfar __iomem *regs = priv->regs;
 	unsigned long flags;
 	struct phy_device *phydev = priv->phydev;
 	int new_state = 0;
@@ -1703,7 +1701,7 @@ static void gfar_set_multi(struct net_de
 {
 	struct dev_mc_list *mc_ptr;
 	struct gfar_private *priv = netdev_priv(dev);
-	struct gfar *regs = priv->regs;
+	struct gfar __iomem *regs = priv->regs;
 	u32 tempval;
 
 	if(dev->flags & IFF_PROMISC) {
@@ -1842,7 +1840,7 @@ static void gfar_set_mac_for_addr(struct
 	int idx;
 	char tmpbuf[MAC_ADDR_LEN];
 	u32 tempval;
-	u32 *macptr = &priv->regs->macstnaddr1;
+	u32 __iomem *macptr = &priv->regs->macstnaddr1;
 
 	macptr += num*2;
 
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index cb9d66a..d37d540 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -682,8 +682,8 @@ struct gfar_private {
 	struct rxbd8 *cur_rx;           /* Next free rx ring entry */
 	struct txbd8 *cur_tx;	        /* Next free ring entry */
 	struct txbd8 *dirty_tx;		/* The Ring entry to be freed. */
-	struct gfar *regs;	/* Pointer to the GFAR memory mapped Registers */
-	u32 *hash_regs[16];
+	struct gfar __iomem *regs;	/* Pointer to the GFAR memory mapped Registers */
+	u32 __iomem *hash_regs[16];
 	int hash_width;
 	struct net_device_stats stats; /* linux network statistics */
 	struct gfar_extra_stats extra_stats;
@@ -718,14 +718,14 @@ struct gfar_private {
 	uint32_t msg_enable;
 };
 
-static inline u32 gfar_read(volatile unsigned *addr)
+static inline u32 gfar_read(volatile unsigned __iomem *addr)
 {
 	u32 val;
 	val = in_be32(addr);
 	return val;
 }
 
-static inline void gfar_write(volatile unsigned *addr, u32 val)
+static inline void gfar_write(volatile unsigned __iomem *addr, u32 val)
 {
 	out_be32(addr, val);
 }
diff --git a/drivers/net/gianfar_ethtool.c b/drivers/net/gianfar_ethtool.c
index 765e810..5de7b2e 100644
--- a/drivers/net/gianfar_ethtool.c
+++ b/drivers/net/gianfar_ethtool.c
@@ -144,11 +144,11 @@ static void gfar_fill_stats(struct net_d
 	u64 *extra = (u64 *) & priv->extra_stats;
 
 	if (priv->einfo->device_flags & FSL_GIANFAR_DEV_HAS_RMON) {
-		u32 *rmon = (u32 *) & priv->regs->rmon;
+		u32 __iomem *rmon = (u32 __iomem *) & priv->regs->rmon;
 		struct gfar_stats *stats = (struct gfar_stats *) buf;
 
 		for (i = 0; i < GFAR_RMON_LEN; i++)
-			stats->rmon[i] = (u64) (rmon[i]);
+			stats->rmon[i] = (u64) gfar_read(&rmon[i]);
 
 		for (i = 0; i < GFAR_EXTRA_STATS_LEN; i++)
 			stats->extra[i] = extra[i];
@@ -221,11 +221,11 @@ static void gfar_get_regs(struct net_dev
 {
 	int i;
 	struct gfar_private *priv = netdev_priv(dev);
-	u32 *theregs = (u32 *) priv->regs;
+	u32 __iomem *theregs = (u32 __iomem *) priv->regs;
 	u32 *buf = (u32 *) regbuf;
 
 	for (i = 0; i < sizeof (struct gfar) / sizeof (u32); i++)
-		buf[i] = theregs[i];
+		buf[i] = gfar_read(&theregs[i]);
 }
 
 /* Convert microseconds to ethernet clock ticks, which changes
diff --git a/drivers/net/gianfar_mii.c b/drivers/net/gianfar_mii.c
index 74e52fc..c6b7255 100644
--- a/drivers/net/gianfar_mii.c
+++ b/drivers/net/gianfar_mii.c
@@ -50,7 +50,7 @@
  * All PHY configuration is done through the TSEC1 MIIM regs */
 int gfar_mdio_write(struct mii_bus *bus, int mii_id, int regnum, u16 value)
 {
-	struct gfar_mii *regs = bus->priv;
+	struct gfar_mii __iomem *regs = (void __iomem *)bus->priv;
 
 	/* Set the PHY address and the register address we want to write */
 	gfar_write(&regs->miimadd, (mii_id << 8) | regnum);
@@ -70,7 +70,7 @@ int gfar_mdio_write(struct mii_bus *bus,
  * configuration has to be done through the TSEC1 MIIM regs */
 int gfar_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
-	struct gfar_mii *regs = bus->priv;
+	struct gfar_mii __iomem *regs = (void __iomem *)bus->priv;
 	u16 value;
 
 	/* Set the PHY address and the register address we want to read */
@@ -94,7 +94,7 @@ int gfar_mdio_read(struct mii_bus *bus, 
 /* Reset the MIIM registers, and wait for the bus to free */
 int gfar_mdio_reset(struct mii_bus *bus)
 {
-	struct gfar_mii *regs = bus->priv;
+	struct gfar_mii __iomem *regs = (void __iomem *)bus->priv;
 	unsigned int timeout = PHY_INIT_TIMEOUT;
 
 	spin_lock_bh(&bus->mdio_lock);
@@ -126,7 +126,7 @@ int gfar_mdio_probe(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gianfar_mdio_data *pdata;
-	struct gfar_mii *regs;
+	struct gfar_mii __iomem *regs;
 	struct mii_bus *new_bus;
 	struct resource *r;
 	int err = 0;
@@ -155,15 +155,14 @@ int gfar_mdio_probe(struct device *dev)
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	/* Set the PHY base address */
-	regs = (struct gfar_mii *) ioremap(r->start,
-			sizeof (struct gfar_mii));
+	regs = ioremap(r->start, sizeof (struct gfar_mii));
 
 	if (NULL == regs) {
 		err = -ENOMEM;
 		goto reg_map_fail;
 	}
 
-	new_bus->priv = regs;
+	new_bus->priv = (void __force *)regs;
 
 	new_bus->irq = pdata->irq;
 
@@ -181,7 +180,7 @@ int gfar_mdio_probe(struct device *dev)
 	return 0;
 
 bus_register_fail:
-	iounmap((void *) regs);
+	iounmap(regs);
 reg_map_fail:
 	kfree(new_bus);
 
@@ -197,7 +196,7 @@ int gfar_mdio_remove(struct device *dev)
 
 	dev_set_drvdata(dev, NULL);
 
-	iounmap((void *) (&bus->priv));
+	iounmap((void __iomem *)bus->priv);
 	bus->priv = NULL;
 	kfree(bus);
 
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 2e1bed1..6e10184 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -484,13 +484,12 @@ static void mdio_write(void __iomem *ioa
 	int i;
 
 	RTL_W32(PHYAR, 0x80000000 | (RegAddr & 0xFF) << 16 | value);
-	udelay(1000);
 
-	for (i = 2000; i > 0; i--) {
+	for (i = 20; i > 0; i--) {
 		/* Check if the RTL8169 has completed writing to the specified MII register */
 		if (!(RTL_R32(PHYAR) & 0x80000000)) 
 			break;
-		udelay(100);
+		udelay(25);
 	}
 }
 
@@ -499,15 +498,14 @@ static int mdio_read(void __iomem *ioadd
 	int i, value = -1;
 
 	RTL_W32(PHYAR, 0x0 | (RegAddr & 0xFF) << 16);
-	udelay(1000);
 
-	for (i = 2000; i > 0; i--) {
+	for (i = 20; i > 0; i--) {
 		/* Check if the RTL8169 has completed retrieving data from the specified MII register */
 		if (RTL_R32(PHYAR) & 0x80000000) {
 			value = (int) (RTL_R32(PHYAR) & 0xFFFF);
 			break;
 		}
-		udelay(100);
+		udelay(25);
 	}
 	return value;
 }
@@ -677,6 +675,9 @@ static int rtl8169_set_speed_xmii(struct
 
 		if (duplex == DUPLEX_HALF)
 			auto_nego &= ~(PHY_Cap_10_Full | PHY_Cap_100_Full);
+
+		if (duplex == DUPLEX_FULL)
+			auto_nego &= ~(PHY_Cap_10_Half | PHY_Cap_100_Half);
 	}
 
 	tp->phy_auto_nego_reg = auto_nego;
diff --git a/drivers/net/sis900.h b/drivers/net/sis900.h
index 4233ea5..5032394 100644
--- a/drivers/net/sis900.h
+++ b/drivers/net/sis900.h
@@ -33,7 +33,6 @@ enum sis900_registers {
         rxcfg=0x34,             //Receive Configuration Register
         flctrl=0x38,            //Flow Control Register
         rxlen=0x3c,             //Receive Packet Length Register
-        cfgpmcsr=0x44,          //Configuration Power Management Control/Status Register
         rfcr=0x48,              //Receive Filter Control Register
         rfdr=0x4C,              //Receive Filter Data Register
         pmctrl=0xB0,            //Power Management Control Register
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index f8b973a..cae2edf 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -23,12 +23,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-/*
- * TOTEST
- *	- speed setting
- *	- suspend/resume
- */
-
 #include <linux/config.h>
 #include <linux/crc32.h>
 #include <linux/kernel.h>
@@ -57,7 +51,7 @@
 #include "sky2.h"
 
 #define DRV_NAME		"sky2"
-#define DRV_VERSION		"0.13"
+#define DRV_VERSION		"0.15"
 #define PFX			DRV_NAME " "
 
 /*
@@ -102,6 +96,10 @@ static int copybreak __read_mostly = 256
 module_param(copybreak, int, 0);
 MODULE_PARM_DESC(copybreak, "Receive copy threshold");
 
+static int disable_msi = 0;
+module_param(disable_msi, int, 0);
+MODULE_PARM_DESC(disable_msi, "Disable Message Signaled Interrupt (MSI)");
+
 static const struct pci_device_id sky2_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9000) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9E00) },
@@ -198,7 +196,7 @@ static int sky2_set_power_state(struct s
 	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
 
 	pci_read_config_word(hw->pdev, hw->pm_cap + PCI_PM_PMC, &power_control);
-	vaux = (sky2_read8(hw, B0_CTST) & Y2_VAUX_AVAIL) &&
+	vaux = (sky2_read16(hw, B0_CTST) & Y2_VAUX_AVAIL) &&
 		(power_control & PCI_PM_CAP_PME_D3cold);
 
 	pci_read_config_word(hw->pdev, hw->pm_cap + PCI_PM_CTRL, &power_control);
@@ -1834,6 +1832,8 @@ static int sky2_poll(struct net_device *
 	u16 hwidx;
 	u16 tx_done[2] = { TX_NO_STATUS, TX_NO_STATUS };
 
+	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
+
 	hwidx = sky2_read16(hw, STAT_PUT_IDX);
 	BUG_ON(hwidx >= STATUS_RING_SIZE);
 	rmb();
@@ -1913,12 +1913,10 @@ static int sky2_poll(struct net_device *
 	}
 
 exit_loop:
-	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
-
 	sky2_tx_check(hw, 0, tx_done[0]);
 	sky2_tx_check(hw, 1, tx_done[1]);
 
-	if (sky2_read16(hw, STAT_PUT_IDX) == hw->st_idx) {
+	if (likely(work_done < to_do)) {
 		/* need to restart TX timer */
 		if (is_ec_a1(hw)) {
 			sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_STOP);
@@ -2141,14 +2139,12 @@ static inline u32 sky2_clk2us(const stru
 
 static int sky2_reset(struct sky2_hw *hw)
 {
-	u32 ctst;
 	u16 status;
 	u8 t8, pmd_type;
-	int i;
-
-	ctst = sky2_read32(hw, B0_CTST);
+	int i, err;
 
 	sky2_write8(hw, B0_CTST, CS_RST_CLR);
+
 	hw->chip_id = sky2_read8(hw, B2_CHIP_ID);
 	if (hw->chip_id < CHIP_ID_YUKON_XL || hw->chip_id > CHIP_ID_YUKON_FE) {
 		printk(KERN_ERR PFX "%s: unsupported chip type 0x%x\n",
@@ -2156,12 +2152,6 @@ static int sky2_reset(struct sky2_hw *hw
 		return -EOPNOTSUPP;
 	}
 
-	/* ring for status responses */
-	hw->st_le = pci_alloc_consistent(hw->pdev, STATUS_LE_BYTES,
-					 &hw->st_dma);
-	if (!hw->st_le)
-		return -ENOMEM;
-
 	/* disable ASF */
 	if (hw->chip_id <= CHIP_ID_YUKON_EC) {
 		sky2_write8(hw, B28_Y2_ASF_STAT_CMD, Y2_ASF_RESET);
@@ -2173,19 +2163,24 @@ static int sky2_reset(struct sky2_hw *hw
 	sky2_write8(hw, B0_CTST, CS_RST_CLR);
 
 	/* clear PCI errors, if any */
-	pci_read_config_word(hw->pdev, PCI_STATUS, &status);
+	err = pci_read_config_word(hw->pdev, PCI_STATUS, &status);
+	if (err)
+		goto pci_err;
+
 	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-	pci_write_config_word(hw->pdev, PCI_STATUS,
-			      status | PCI_STATUS_ERROR_BITS);
+	err = pci_write_config_word(hw->pdev, PCI_STATUS,
+				    status | PCI_STATUS_ERROR_BITS);
+	if (err)
+		goto pci_err;
 
 	sky2_write8(hw, B0_CTST, CS_MRST_CLR);
 
 	/* clear any PEX errors */
-	if (is_pciex(hw)) {
-		u16 lstat;
-		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
-				       0xffffffffUL);
-		pci_read_config_word(hw->pdev, PEX_LNK_STAT, &lstat);
+	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP)) {
+		err = pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
+						 0xffffffffUL);
+		if (err)
+			goto pci_err;
 	}
 
 	pmd_type = sky2_read8(hw, B2_PMD_TYP);
@@ -2297,6 +2292,14 @@ static int sky2_reset(struct sky2_hw *hw
 	sky2_write8(hw, STAT_ISR_TIMER_CTRL, TIM_START);
 
 	return 0;
+
+pci_err:
+	/* This is to catch a BIOS bug workaround where
+	 * mmconfig table doesn't have other buses.
+	 */
+	printk(KERN_ERR PFX "%s: can't access PCI config space\n",
+	       pci_name(hw->pdev));
+	return err;
 }
 
 static u32 sky2_supported_modes(const struct sky2_hw *hw)
@@ -2551,19 +2554,24 @@ static struct net_device_stats *sky2_get
 static int sky2_set_mac_address(struct net_device *dev, void *p)
 {
 	struct sky2_port *sky2 = netdev_priv(dev);
-	struct sockaddr *addr = p;
+	struct sky2_hw *hw = sky2->hw;
+	unsigned port = sky2->port;
+	const struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-	memcpy_toio(sky2->hw->regs + B2_MAC_1 + sky2->port * 8,
+	memcpy_toio(hw->regs + B2_MAC_1 + port * 8,
 		    dev->dev_addr, ETH_ALEN);
-	memcpy_toio(sky2->hw->regs + B2_MAC_2 + sky2->port * 8,
+	memcpy_toio(hw->regs + B2_MAC_2 + port * 8,
 		    dev->dev_addr, ETH_ALEN);
 
-	if (netif_running(dev))
-		sky2_phy_reinit(sky2);
+	/* virtual address for data */
+	gma_set_addr(hw, port, GM_SRC_ADDR_2L, dev->dev_addr);
+
+	/* physical address: used for pause frames */
+	gma_set_addr(hw, port, GM_SRC_ADDR_1L, dev->dev_addr);
 
 	return 0;
 }
@@ -2843,7 +2851,7 @@ static int sky2_set_coalesce(struct net_
 	if (ecmd->rx_coalesce_usecs_irq == 0)
 		sky2_write8(hw, STAT_ISR_TIMER_CTRL, TIM_STOP);
 	else {
-		sky2_write32(hw, STAT_TX_TIMER_INI,
+		sky2_write32(hw, STAT_ISR_TIMER_INI,
 			     sky2_us2clk(hw, ecmd->rx_coalesce_usecs_irq));
 		sky2_write8(hw, STAT_ISR_TIMER_CTRL, TIM_START);
 	}
@@ -3055,6 +3063,61 @@ static void __devinit sky2_show_addr(str
 		       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
 }
 
+/* Handle software interrupt used during MSI test */
+static irqreturn_t __devinit sky2_test_intr(int irq, void *dev_id,
+					    struct pt_regs *regs)
+{
+	struct sky2_hw *hw = dev_id;
+	u32 status = sky2_read32(hw, B0_Y2_SP_ISRC2);
+
+	if (status == 0)
+		return IRQ_NONE;
+
+	if (status & Y2_IS_IRQ_SW) {
+		sky2_write8(hw, B0_CTST, CS_CL_SW_IRQ);
+		hw->msi = 1;
+	}
+	sky2_write32(hw, B0_Y2_SP_ICR, 2);
+
+	sky2_read32(hw, B0_IMSK);
+	return IRQ_HANDLED;
+}
+
+/* Test interrupt path by forcing a a software IRQ */
+static int __devinit sky2_test_msi(struct sky2_hw *hw)
+{
+	struct pci_dev *pdev = hw->pdev;
+	int i, err;
+
+	sky2_write32(hw, B0_IMSK, Y2_IS_IRQ_SW);
+
+	err = request_irq(pdev->irq, sky2_test_intr, SA_SHIRQ, DRV_NAME, hw);
+	if (err) {
+		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
+		       pci_name(pdev), pdev->irq);
+		return err;
+	}
+
+	sky2_write8(hw, B0_CTST, CS_ST_SW_IRQ);
+	wmb();
+
+	for (i = 0; i < 10; i++) {
+		barrier();
+		if (hw->msi)
+			goto found;
+		mdelay(1);
+	}
+
+	err = -EOPNOTSUPP;
+	sky2_write8(hw, B0_CTST, CS_CL_SW_IRQ);
+ found:
+	sky2_write32(hw, B0_IMSK, 0);
+
+	free_irq(pdev->irq, hw);
+
+	return err;
+}
+
 static int __devinit sky2_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -3135,6 +3198,12 @@ static int __devinit sky2_probe(struct p
 	}
 	hw->pm_cap = pm_cap;
 
+	/* ring for status responses */
+	hw->st_le = pci_alloc_consistent(hw->pdev, STATUS_LE_BYTES,
+					 &hw->st_dma);
+	if (!hw->st_le)
+		goto err_out_iounmap;
+
 	err = sky2_reset(hw);
 	if (err)
 		goto err_out_iounmap;
@@ -3169,7 +3238,22 @@ static int __devinit sky2_probe(struct p
 		}
 	}
 
-	err = request_irq(pdev->irq, sky2_intr, SA_SHIRQ, DRV_NAME, hw);
+	if (!disable_msi && pci_enable_msi(pdev) == 0) {
+		err = sky2_test_msi(hw);
+		if (err == -EOPNOTSUPP) {
+			/* MSI test failed, go back to INTx mode */
+			printk(KERN_WARNING PFX "%s: No interrupt was generated using MSI, "
+			       "switching to INTx mode. Please report this failure to "
+			       "the PCI maintainer and include system chipset information.\n",
+			       pci_name(pdev));
+			pci_disable_msi(pdev);
+		}
+		else if (err)
+			goto err_out_unregister;
+	}
+
+	err = request_irq(pdev->irq, sky2_intr, SA_SHIRQ | SA_SAMPLE_RANDOM,
+			  DRV_NAME, hw);
 	if (err) {
 		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
 		       pci_name(pdev), pdev->irq);
@@ -3184,6 +3268,8 @@ static int __devinit sky2_probe(struct p
 	return 0;
 
 err_out_unregister:
+	if (hw->msi)
+		pci_disable_msi(pdev);
 	if (dev1) {
 		unregister_netdev(dev1);
 		free_netdev(dev1);
@@ -3226,6 +3312,8 @@ static void __devexit sky2_remove(struct
 	sky2_read8(hw, B0_CTST);
 
 	free_irq(pdev->irq, hw);
+	if (hw->msi)
+		pci_disable_msi(pdev);
 	pci_free_consistent(pdev, STATUS_LE_BYTES, hw->st_le, hw->st_dma);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
@@ -3263,25 +3351,33 @@ static int sky2_suspend(struct pci_dev *
 static int sky2_resume(struct pci_dev *pdev)
 {
 	struct sky2_hw *hw = pci_get_drvdata(pdev);
-	int i;
+	int i, err;
 
 	pci_restore_state(pdev);
 	pci_enable_wake(pdev, PCI_D0, 0);
-	sky2_set_power_state(hw, PCI_D0);
+	err = sky2_set_power_state(hw, PCI_D0);
+	if (err)
+		goto out;
 
-	sky2_reset(hw);
+	err = sky2_reset(hw);
+	if (err)
+		goto out;
 
 	for (i = 0; i < 2; i++) {
 		struct net_device *dev = hw->dev[i];
-		if (dev) {
-			if (netif_running(dev)) {
-				netif_device_attach(dev);
-				if (sky2_up(dev))
-					dev_close(dev);
+		if (dev && netif_running(dev)) {
+			netif_device_attach(dev);
+			err = sky2_up(dev);
+			if (err) {
+				printk(KERN_ERR PFX "%s: could not up: %d\n",
+				       dev->name, err);
+				dev_close(dev);
+				break;
 			}
 		}
 	}
-	return 0;
+out:
+	return err;
 }
 #endif
 
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index 9551892..fd12c28 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -1841,6 +1841,7 @@ struct sky2_hw {
 	struct net_device    *dev[2];
 
 	int		     pm_cap;
+	int		     msi;
 	u8	     	     chip_id;
 	u8		     chip_rev;
 	u8		     copper;
@@ -1867,14 +1868,6 @@ static inline u8 sky2_read8(const struct
 	return readb(hw->regs + reg);
 }
 
-/* This should probably go away, bus based tweeks suck */
-static inline int is_pciex(const struct sky2_hw *hw)
-{
-	u32 status;
-	pci_read_config_dword(hw->pdev, PCI_DEV_STATUS, &status);
-	return (status & PCI_OS_PCI_X) == 0;
-}
-
 static inline void sky2_write32(const struct sky2_hw *hw, unsigned reg, u32 val)
 {
 	writel(val, hw->regs + reg);
diff --git a/drivers/net/tulip/uli526x.c b/drivers/net/tulip/uli526x.c
index 9839816..238e9c7 100644
--- a/drivers/net/tulip/uli526x.c
+++ b/drivers/net/tulip/uli526x.c
@@ -214,7 +214,7 @@ static u32 uli526x_cr6_user_set;
 /* For module input parameter */
 static int debug;
 static u32 cr6set;
-static unsigned char mode = 8;
+static int mode = 8;
 
 /* function declaration ------------------------------------- */
 static int uli526x_open(struct net_device *);
diff --git a/drivers/net/wan/dscc4.c b/drivers/net/wan/dscc4.c
index 2f61a47..1ff5de0 100644
--- a/drivers/net/wan/dscc4.c
+++ b/drivers/net/wan/dscc4.c
@@ -1943,7 +1943,7 @@ static int dscc4_init_ring(struct net_de
 					(++i%TX_RING_SIZE)*sizeof(*tx_fd));
 	} while (i < TX_RING_SIZE);
 
-	if (dscc4_init_dummy_skb(dpriv) < 0)
+	if (!dscc4_init_dummy_skb(dpriv))
 		goto err_free_dma_tx;
 
 	memset(dpriv->rx_skbuff, 0, sizeof(struct sk_buff *)*RX_RING_SIZE);
