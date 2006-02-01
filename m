Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422943AbWBAVao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422943AbWBAVao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422941AbWBAVao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:30:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:35771 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932461AbWBAVan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:30:43 -0500
Date: Wed, 1 Feb 2006 15:18:03 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, <netdev@vger.kernel.org>
Subject: [PATCH] gianfar: Fix sparse warnings
Message-ID: <Pine.LNX.4.44.0602011517340.22854-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed sparse warnings mainly due to lack of __iomem.

---
commit 682307be628635abd497a77bf26aa7ba6b5593e9
tree ac3156a394371416519566a8e4aff345575e8f33
parent 690e2cb75eb8fc41413a9e9f85919b275b4164a9
author Kumar Gala <galak@kernel.crashing.org> Wed, 01 Feb 2006 15:17:45 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 01 Feb 2006 15:17:45 -0600

 drivers/net/gianfar.c         |   24 +++++++++++-------------
 drivers/net/gianfar.h         |    8 ++++----
 drivers/net/gianfar_ethtool.c |    8 ++++----
 drivers/net/gianfar_mii.c     |   17 ++++++++---------
 4 files changed, 27 insertions(+), 30 deletions(-)

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
 

