Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUAVFw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 00:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAVFw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 00:52:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:14040 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264363AbUAVFv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 00:51:59 -0500
Subject: [PATCH] sungem: add support for G5 PowerMac, some PM fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074750642.974.109.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 16:50:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David !

Here's a patch against Linus current tree that update the sungem
driver. It adds support for the PowerMac G5, reduces a few mdelay's,
and try to schedule on some longer delays during the PM process.

There is still a race (from day 1 of the PM code actually) around
the PM semaphore when calling flush_scheduled_work() with the semaphore
held (since the workqueue can try to get it too). It's not fixed by
this patch yet, but I'd like this one to get in ASAP so we have the
G5 support in now.

Thye patch shouldn't affect non-powermac's.

Any comments ? If no, please submit to Andrew/Linus

Regards,
Ben.

diff -urN linux-2.5-merge/drivers/net/sungem.c linuxppc-2.5-benh/drivers/net/sungem.c
--- linux-2.5-merge/drivers/net/sungem.c	2004-01-22 14:25:56.748570272 +1100
+++ linuxppc-2.5-benh/drivers/net/sungem.c	2004-01-22 14:21:48.762269920 +1100
@@ -103,6 +103,8 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_GMAC2,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_GMAC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{0, }
 };
 
@@ -778,6 +780,10 @@
 	struct gem *gp = dev->priv;
 	u32 gem_status = readl(gp->regs + GREG_STAT);
 
+	/* Swallow interrupts when shutting the chip down */
+	if (gp->hw_running == 0)
+		goto out;
+
 	spin_lock(&gp->lock);
 
 	if (gem_status & GREG_STAT_ABNORMAL) {
@@ -1240,6 +1246,12 @@
 		gp->lstate = link_force_ok;
 		return 0;
 	case link_aneg:
+		/* We try forced modes after a failed aneg only on PHYs that don't
+		 * have "magic_aneg" bit set, which means they internally do the
+		 * while forced-mode thingy. On these, we just restart aneg
+		 */
+		if (gp->phy_mii.def->magic_aneg)
+			return 1;
 		if (netif_msg_link(gp))
 			printk(KERN_INFO "%s: switching to forced 100bt\n",
 				gp->dev->name);
@@ -1497,19 +1509,27 @@
 		 * to schedule instead
 		 */
 		pmac_call_feature(PMAC_FTR_GMAC_PHY_RESET, gp->of_node, 0, 0);
-		mdelay(10);
 		for (j = 0; j < 3; j++) {
 			/* Some PHYs used by apple have problem getting back to us,
-			 * we _know_ it's actually at addr 0, that's a hack, but
+			 * we _know_ it's actually at addr 0 or 1, that's a hack, but
 			 * it helps to do that reset now. I suspect some motherboards
 			 * don't wire the PHY reset line properly, thus the PHY doesn't
 			 * come back with the above pmac_call_feature.
 			 */
 			gp->mii_phy_addr = 0;
 			phy_write(gp, MII_BMCR, BMCR_RESET);
+			gp->mii_phy_addr = 1;
+			phy_write(gp, MII_BMCR, BMCR_RESET);
 			/* We should probably break some locks here and schedule... */
 			mdelay(10);
-			for (i = 0; i < 32; i++) {
+			
+			/* On K2, we only probe the internal PHY at address 1, other
+			 * addresses tend to return garbage.
+			 */
+			if (gp->pdev->device == PCI_DEVICE_ID_APPLE_K2_GMAC)
+				break;
+
+       			for (i = 0; i < 32; i++) {
 				gp->mii_phy_addr = i;
 				if (phy_read(gp, MII_BMCR) != 0xffff)
 					break;
@@ -1770,6 +1790,8 @@
 /* Must be invoked under gp->lock. */
 static void gem_init_pause_thresholds(struct gem *gp)
 {
+       	u32 cfg;
+
 	/* Calculate pause thresholds.  Setting the OFF threshold to the
 	 * full RX fifo size effectively disables PAUSE generation which
 	 * is what we do for 10/100 only GEMs which have FIFOs too small
@@ -1786,17 +1808,28 @@
 		gp->rx_pause_on = on;
 	}
 
-	{
-		u32 cfg;
 
-		cfg  = 0;
+	/* Configure the chip "burst" DMA mode & enable some
+	 * HW bug fixes on Apple version
+	 */
+       	cfg  = 0;
+       	if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE)
+		cfg |= GREG_CFG_RONPAULBIT | GREG_CFG_ENBUG2FIX;
 #if !defined(CONFIG_SPARC64) && !defined(CONFIG_ALPHA)
-		cfg |= GREG_CFG_IBURST;
+       	cfg |= GREG_CFG_IBURST;
 #endif
-		cfg |= ((31 << 1) & GREG_CFG_TXDMALIM);
-		cfg |= ((31 << 6) & GREG_CFG_RXDMALIM);
+       	cfg |= ((31 << 1) & GREG_CFG_TXDMALIM);
+       	cfg |= ((31 << 6) & GREG_CFG_RXDMALIM);
+       	writel(cfg, gp->regs + GREG_CFG);
+
+	/* If Infinite Burst didn't stick, then use different
+	 * thresholds (and Apple bug fixes don't exist)
+	 */
+	if (readl(gp->regs + GREG_CFG) & GREG_CFG_IBURST) {
+		cfg = ((2 << 1) & GREG_CFG_TXDMALIM);
+		cfg = ((8 << 6) & GREG_CFG_RXDMALIM);
 		writel(cfg, gp->regs + GREG_CFG);
-	}
+	}	
 }
 
 static int gem_check_invariants(struct gem *gp)
@@ -1931,18 +1964,10 @@
 	u16 cmd;
 	u32 mif_cfg;
 
+	mb();
 	pmac_call_feature(PMAC_FTR_GMAC_ENABLE, gp->of_node, 0, 1);
 
-	current->state = TASK_UNINTERRUPTIBLE;
-	schedule_timeout((21 * HZ) / 1000);
-
-	pci_read_config_word(gp->pdev, PCI_COMMAND, &cmd);
-	cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE;
-    	pci_write_config_word(gp->pdev, PCI_COMMAND, cmd);
-    	pci_write_config_byte(gp->pdev, PCI_LATENCY_TIMER, 6);
-    	pci_write_config_byte(gp->pdev, PCI_CACHE_LINE_SIZE, 8);
-
-	mdelay(1);
+	udelay(3);
 	
 	mif_cfg = readl(gp->regs + MIF_CFG);
 	mif_cfg &= ~(MIF_CFG_PSELECT|MIF_CFG_POLL|MIF_CFG_BBMODE|MIF_CFG_MDI1);
@@ -1950,8 +1975,6 @@
 	writel(mif_cfg, gp->regs + MIF_CFG);
 	writel(PCS_DMODE_MGM, gp->regs + PCS_DMODE);
 	writel(MAC_XIFCFG_OE, gp->regs + MAC_XIFCFG);
-
-	mdelay(1);
 }
 
 /* Turn off the chip's clock */
@@ -1962,10 +1985,17 @@
 
 #endif /* CONFIG_PPC_PMAC */
 
-/* Must be invoked under gp->lock. */
+/* Must be invoked with no lock held. */
 static void gem_stop_phy(struct gem *gp)
 {
 	u32 mifcfg;
+	unsigned long flags;
+
+	/* Let the chip settle down a bit, it seems that helps
+	 * for sleep mode on some models
+	 */
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ/100);
 
 	/* Make sure we aren't polling PHY status change. We
 	 * don't currently use that feature though
@@ -1976,17 +2006,28 @@
 
 	if (gp->wake_on_lan) {
 		/* Setup wake-on-lan */
-	} else
+	} else {
 		writel(0, gp->regs + MAC_RXCFG);
+		(void)readl(gp->regs + MAC_RXCFG);
+		/* Machine sleep will die in strange ways if we
+		 * dont wait a bit here, looks like the chip takes
+		 * some time to really shut down
+		 */
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/100);
+	}
+
 	writel(0, gp->regs + MAC_TXCFG);
 	writel(0, gp->regs + MAC_XIFCFG);
 	writel(0, gp->regs + TXDMA_CFG);
 	writel(0, gp->regs + RXDMA_CFG);
 
 	if (!gp->wake_on_lan) {
+		spin_lock_irqsave(&gp->lock, flags);
 		gem_stop(gp);
 		writel(MAC_TXRST_CMD, gp->regs + MAC_TXRST);
 		writel(MAC_RXRST_CMD, gp->regs + MAC_RXRST);
+		spin_unlock_irqrestore(&gp->lock, flags);
 	}
 
 	if (found_mii_phy(gp) && gp->phy_mii.def->ops->suspend)
@@ -2008,31 +2049,33 @@
 /* Shut down the chip, must be called with pm_sem held.  */
 static void gem_shutdown(struct gem *gp)
 {
-	/* Make us not-running to avoid timers respawning */
+	/* Make us not-running to avoid timers respawning
+	 * and swallow irqs 
+	 */
 	gp->hw_running = 0;
+	wmb();
 
 	/* Stop the link timer */
 	del_timer_sync(&gp->link_timer);
 
 	/* Stop the reset task */
 	while (gp->reset_task_pending)
-		schedule();
+		yield();
 	
 	/* Actually stop the chip */
-	spin_lock_irq(&gp->lock);
 	if (gp->pdev->vendor == PCI_VENDOR_ID_APPLE) {
 		gem_stop_phy(gp);
 
-		spin_unlock_irq(&gp->lock);
-
 #ifdef CONFIG_PPC_PMAC
 		/* Power down the chip */
 		gem_apple_powerdown(gp);
 #endif /* CONFIG_PPC_PMAC */
-	} else {
-		gem_stop(gp);
+	} else{
+		unsigned long flags;
 
-		spin_unlock_irq(&gp->lock);
+		spin_lock_irqsave(&gp->lock, flags);
+		gem_stop(gp);
+		spin_unlock_irqrestore(&gp->lock, flags);	
 	}
 }
 
@@ -2692,6 +2735,7 @@
 	 * not have properly shut down the PHY.
 	 */
 #ifdef CONFIG_PPC_PMAC
+	gp->of_node = pci_device_to_OF_node(pdev);
 	if (pdev->vendor == PCI_VENDOR_ID_APPLE)
 		gem_apple_powerup(gp);
 #endif
@@ -2725,9 +2769,6 @@
 		goto err_out_iounmap;
 	}
 
-#ifdef CONFIG_PPC_PMAC
-	gp->of_node = pci_device_to_OF_node(pdev);
-#endif	
 	if (gem_get_device_address(gp))
 		goto err_out_free_consistent;
 
diff -urN linux-2.5-merge/drivers/net/sungem.h linuxppc-2.5-benh/drivers/net/sungem.h
--- linux-2.5-merge/drivers/net/sungem.h	2004-01-22 14:25:56.752569664 +1100
+++ linuxppc-2.5-benh/drivers/net/sungem.h	2004-01-22 14:21:48.780267184 +1100
@@ -28,6 +28,9 @@
 #define GREG_CFG_IBURST		0x00000001	/* Infinite Burst		*/
 #define GREG_CFG_TXDMALIM	0x0000003e	/* TX DMA grant limit		*/
 #define GREG_CFG_RXDMALIM	0x000007c0	/* RX DMA grant limit		*/
+#define GREG_CFG_RONPAULBIT	0x00000800	/* Use mem read multiple for PCI read
+						 * after infinite burst (Apple) */
+#define GREG_CFG_ENBUG2FIX	0x00001000	/* Fix Rx hang after overflow */
 
 /* Global Interrupt Status Register.
  *
diff -urN linux-2.5-merge/drivers/net/sungem_phy.c linuxppc-2.5-benh/drivers/net/sungem_phy.c
--- linux-2.5-merge/drivers/net/sungem_phy.c	2004-01-22 14:25:56.772566624 +1100
+++ linuxppc-2.5-benh/drivers/net/sungem_phy.c	2004-01-22 14:21:48.782266880 +1100
@@ -72,7 +72,7 @@
 	int limit = 10000;
 	
 	val = __phy_read(phy, phy_id, MII_BMCR);
-	val &= ~BMCR_ISOLATE;
+	val &= ~(BMCR_ISOLATE | BMCR_PDOWN);
 	val |= BMCR_RESET;
 	__phy_write(phy, phy_id, MII_BMCR, val);
 
@@ -157,7 +157,7 @@
 	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
 	phy_write(phy, MII_BCM5400_GB_CONTROL, data);
 	
-	mdelay(10);
+	udelay(100);
 
 	/* Reset and configure cascaded 10/100 PHY */
 	(void)reset_one_mii_phy(phy, 0x1f);
@@ -217,7 +217,7 @@
 	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
 	phy_write(phy, MII_BCM5400_GB_CONTROL, data);
 
-	mdelay(10);
+	udelay(10);
 
 	/* Reset and configure cascaded 10/100 PHY */
 	(void)reset_one_mii_phy(phy, 0x1f);
@@ -258,7 +258,7 @@
 	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
 	phy_write(phy, MII_BCM5400_GB_CONTROL, data);
 
-	mdelay(10);
+	udelay(10);
 
 	/* Reset and configure cascaded 10/100 PHY */
 	(void)reset_one_mii_phy(phy, 0x1f);
@@ -302,6 +302,15 @@
 	return 0;
 }
 
+static int bcm5421k2_init(struct mii_phy* phy)
+{
+	/* Init code borrowed from OF */
+	phy_write(phy, 4, 0x01e1);
+	phy_write(phy, 9, 0x0300);
+
+	return 0;
+}
+
 static int bcm54xx_setup_aneg(struct mii_phy *phy, u32 advertise)
 {
 	u16 ctl, adv;
@@ -647,7 +656,7 @@
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5201",
 	.features	= MII_BASIC_FEATURES,
-	.magic_aneg	= 0,
+	.magic_aneg	= 1,
 	.ops		= &bcm5201_phy_ops
 };
 
@@ -666,7 +675,7 @@
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "BCM5221",
 	.features	= MII_BASIC_FEATURES,
-	.magic_aneg	= 0,
+	.magic_aneg	= 1,
 	.ops		= &bcm5221_phy_ops
 };
 
@@ -746,6 +755,25 @@
 	.ops		= &bcm5421_phy_ops
 };
 
+/* Broadcom BCM 5421 built-in K2 */
+static struct mii_phy_ops bcm5421k2_phy_ops = {
+	.init		= bcm5421k2_init,
+	.suspend	= bcm5411_suspend,
+	.setup_aneg	= bcm54xx_setup_aneg,
+	.setup_forced	= bcm54xx_setup_forced,
+	.poll_link	= genmii_poll_link,
+	.read_link	= bcm54xx_read_link,
+};
+
+static struct mii_phy_def bcm5421k2_phy_def = {
+	.phy_id		= 0x002062e0,
+	.phy_id_mask	= 0xfffffff0,
+	.name		= "BCM5421-K2",
+	.features	= MII_GBIT_FEATURES,
+	.magic_aneg	= 1,
+	.ops		= &bcm5421k2_phy_ops
+};
+
 /* Marvell 88E1101 (Apple seem to deal with 2 different revs,
  * I masked out the 8 last bits to get both, but some specs
  * would be useful here) --BenH.
@@ -790,6 +818,7 @@
 	&bcm5401_phy_def,
 	&bcm5411_phy_def,
 	&bcm5421_phy_def,
+	&bcm5421k2_phy_def,
 	&marvell_phy_def,
 	&genmii_phy_def,
 	NULL
@@ -813,8 +842,8 @@
 		goto fail;
 
 	/* Read ID and find matching entry */	
-	id = (phy_read(phy, MII_PHYSID1) << 16 | phy_read(phy, MII_PHYSID2))
-			 	& 0xfffffff0;
+	id = (phy_read(phy, MII_PHYSID1) << 16 | phy_read(phy, MII_PHYSID2));
+	printk(KERN_DEBUG "PHY ID: %x, addr: %x\n", id, mii_id);
 	for (i=0; (def = mii_phy_table[i]) != NULL; i++)
 		if ((id & def->phy_id_mask) == def->phy_id)
 			break;


