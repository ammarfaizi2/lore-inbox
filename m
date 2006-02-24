Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWBXFWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWBXFWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 00:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWBXFWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 00:22:18 -0500
Received: from havoc.gtf.org ([69.61.125.42]:39345 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751840AbWBXFWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 00:22:16 -0500
Date: Fri, 24 Feb 2006 00:22:14 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060224052214.GA14586@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/r8169.c |  189 ++++++++++++++++++++++++++++++++++++++++------------
 drivers/net/skge.c  |   75 ++++++++++++--------
 drivers/net/skge.h  |    1 
 drivers/net/sky2.c  |  173 ++++++++++++++++++++++++++++-------------------
 drivers/net/sky2.h  |   85 ++++++++++++++++++++---
 drivers/net/tlan.c  |    2 
 6 files changed, 371 insertions(+), 154 deletions(-)

Adrian Bunk:
      drivers/net/tlan.c: #ifdef CONFIG_PCI the PCI specific code

Francois Romieu:
      r8169: fix broken ring index handling in suspend/resume
      r8169: enable wake on lan

Stephen Hemminger:
      sky2: yukon-ec-u chipset initialization
      sky2: limit coalescing values to ring size
      sky2: poke coalescing timer to fix hang
      sky2: force early transmit status
      sky2: use device iomem to access PCI config
      sky2: close race on IRQ mask update.
      skge: NAPI/irq race fix
      skge: genesis phy initialzation
      skge: protect interrupt mask

diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 6e10184..8cc0d0b 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -287,6 +287,20 @@ enum RTL8169_register_content {
 	TxInterFrameGapShift = 24,
 	TxDMAShift = 8,	/* DMA burst value (0-7) is shift this many bits */
 
+	/* Config1 register p.24 */
+	PMEnable	= (1 << 0),	/* Power Management Enable */
+
+	/* Config3 register p.25 */
+	MagicPacket	= (1 << 5),	/* Wake up when receives a Magic Packet */
+	LinkUp		= (1 << 4),	/* Wake up when the cable connection is re-established */
+
+	/* Config5 register p.27 */
+	BWF		= (1 << 6),	/* Accept Broadcast wakeup frame */
+	MWF		= (1 << 5),	/* Accept Multicast wakeup frame */
+	UWF		= (1 << 4),	/* Accept Unicast wakeup frame */
+	LanWake		= (1 << 1),	/* LanWake enable/disable */
+	PMEStatus	= (1 << 0),	/* PME status can be reset by PCI RST# */
+
 	/* TBICSR p.28 */
 	TBIReset	= 0x80000000,
 	TBILoopback	= 0x40000000,
@@ -433,6 +447,7 @@ struct rtl8169_private {
 	unsigned int (*phy_reset_pending)(void __iomem *);
 	unsigned int (*link_ok)(void __iomem *);
 	struct work_struct task;
+	unsigned wol_enabled : 1;
 };
 
 MODULE_AUTHOR("Realtek and the Linux r8169 crew <netdev@vger.kernel.org>");
@@ -607,6 +622,80 @@ static void rtl8169_link_option(int idx,
 	*duplex = p->duplex;
 }
 
+static void rtl8169_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	void __iomem *ioaddr = tp->mmio_addr;
+	u8 options;
+
+	wol->wolopts = 0;
+
+#define WAKE_ANY (WAKE_PHY | WAKE_MAGIC | WAKE_UCAST | WAKE_BCAST | WAKE_MCAST)
+	wol->supported = WAKE_ANY;
+
+	spin_lock_irq(&tp->lock);
+
+	options = RTL_R8(Config1);
+	if (!(options & PMEnable))
+		goto out_unlock;
+
+	options = RTL_R8(Config3);
+	if (options & LinkUp)
+		wol->wolopts |= WAKE_PHY;
+	if (options & MagicPacket)
+		wol->wolopts |= WAKE_MAGIC;
+
+	options = RTL_R8(Config5);
+	if (options & UWF)
+		wol->wolopts |= WAKE_UCAST;
+	if (options & BWF)
+	        wol->wolopts |= WAKE_BCAST;
+	if (options & MWF)
+	        wol->wolopts |= WAKE_MCAST;
+
+out_unlock:
+	spin_unlock_irq(&tp->lock);
+}
+
+static int rtl8169_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+	void __iomem *ioaddr = tp->mmio_addr;
+	int i;
+	static struct {
+		u32 opt;
+		u16 reg;
+		u8  mask;
+	} cfg[] = {
+		{ WAKE_ANY,   Config1, PMEnable },
+		{ WAKE_PHY,   Config3, LinkUp },
+		{ WAKE_MAGIC, Config3, MagicPacket },
+		{ WAKE_UCAST, Config5, UWF },
+		{ WAKE_BCAST, Config5, BWF },
+		{ WAKE_MCAST, Config5, MWF },
+		{ WAKE_ANY,   Config5, LanWake }
+	};
+
+	spin_lock_irq(&tp->lock);
+
+	RTL_W8(Cfg9346, Cfg9346_Unlock);
+
+	for (i = 0; i < ARRAY_SIZE(cfg); i++) {
+		u8 options = RTL_R8(cfg[i].reg) & ~cfg[i].mask;
+		if (wol->wolopts & cfg[i].opt)
+			options |= cfg[i].mask;
+		RTL_W8(cfg[i].reg, options);
+	}
+
+	RTL_W8(Cfg9346, Cfg9346_Lock);
+
+	tp->wol_enabled = (wol->wolopts) ? 1 : 0;
+
+	spin_unlock_irq(&tp->lock);
+
+	return 0;
+}
+
 static void rtl8169_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
@@ -1025,6 +1114,8 @@ static struct ethtool_ops rtl8169_ethtoo
 	.get_tso		= ethtool_op_get_tso,
 	.set_tso		= ethtool_op_set_tso,
 	.get_regs		= rtl8169_get_regs,
+	.get_wol		= rtl8169_get_wol,
+	.set_wol		= rtl8169_set_wol,
 	.get_strings		= rtl8169_get_strings,
 	.get_stats_count	= rtl8169_get_stats_count,
 	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
@@ -1442,6 +1533,11 @@ rtl8169_init_board(struct pci_dev *pdev,
 	}
 	tp->chipset = i;
 
+	RTL_W8(Cfg9346, Cfg9346_Unlock);
+	RTL_W8(Config1, RTL_R8(Config1) | PMEnable);
+	RTL_W8(Config5, RTL_R8(Config5) & PMEStatus);
+	RTL_W8(Cfg9346, Cfg9346_Lock);
+
 	*ioaddr_out = ioaddr;
 	*dev_out = dev;
 out:
@@ -1612,49 +1708,6 @@ rtl8169_remove_one(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
-#ifdef CONFIG_PM
-
-static int rtl8169_suspend(struct pci_dev *pdev, pm_message_t state)
-{
-	struct net_device *dev = pci_get_drvdata(pdev);
-	struct rtl8169_private *tp = netdev_priv(dev);
-	void __iomem *ioaddr = tp->mmio_addr;
-	unsigned long flags;
-
-	if (!netif_running(dev))
-		return 0;
-	
-	netif_device_detach(dev);
-	netif_stop_queue(dev);
-	spin_lock_irqsave(&tp->lock, flags);
-
-	/* Disable interrupts, stop Rx and Tx */
-	RTL_W16(IntrMask, 0);
-	RTL_W8(ChipCmd, 0);
-		
-	/* Update the error counts. */
-	tp->stats.rx_missed_errors += RTL_R32(RxMissed);
-	RTL_W32(RxMissed, 0);
-	spin_unlock_irqrestore(&tp->lock, flags);
-	
-	return 0;
-}
-
-static int rtl8169_resume(struct pci_dev *pdev)
-{
-	struct net_device *dev = pci_get_drvdata(pdev);
-
-	if (!netif_running(dev))
-	    return 0;
-
-	netif_device_attach(dev);
-	rtl8169_hw_start(dev);
-
-	return 0;
-}
-                                                                                
-#endif /* CONFIG_PM */
-
 static void rtl8169_set_rxbufsize(struct rtl8169_private *tp,
 				  struct net_device *dev)
 {
@@ -2700,6 +2753,56 @@ static struct net_device_stats *rtl8169_
 	return &tp->stats;
 }
 
+#ifdef CONFIG_PM
+
+static int rtl8169_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct rtl8169_private *tp = netdev_priv(dev);
+	void __iomem *ioaddr = tp->mmio_addr;
+
+	if (!netif_running(dev))
+		goto out;
+
+	netif_device_detach(dev);
+	netif_stop_queue(dev);
+
+	spin_lock_irq(&tp->lock);
+
+	rtl8169_asic_down(ioaddr);
+
+	tp->stats.rx_missed_errors += RTL_R32(RxMissed);
+	RTL_W32(RxMissed, 0);
+
+	spin_unlock_irq(&tp->lock);
+
+	pci_save_state(pdev);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), tp->wol_enabled);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+out:
+	return 0;
+}
+
+static int rtl8169_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+
+	if (!netif_running(dev))
+		goto out;
+
+	netif_device_attach(dev);
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_wake(pdev, PCI_D0, 0);
+
+	rtl8169_schedule_work(dev, rtl8169_reset_task);
+out:
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static struct pci_driver rtl8169_pci_driver = {
 	.name		= MODULENAME,
 	.id_table	= rtl8169_pci_tbl,
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index 67fb19b..25e028b 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -879,13 +879,12 @@ static int __xm_phy_read(struct skge_hw 
 	int i;
 
 	xm_write16(hw, port, XM_PHY_ADDR, reg | hw->phy_addr);
-	xm_read16(hw, port, XM_PHY_DATA);
+	*val = xm_read16(hw, port, XM_PHY_DATA);
 
-	/* Need to wait for external PHY */
 	for (i = 0; i < PHY_RETRIES; i++) {
-		udelay(1);
 		if (xm_read16(hw, port, XM_MMU_CMD) & XM_MMU_PHY_RDY)
 			goto ready;
+		udelay(1);
 	}
 
 	return -ETIMEDOUT;
@@ -918,7 +917,12 @@ static int xm_phy_write(struct skge_hw *
 
  ready:
 	xm_write16(hw, port, XM_PHY_DATA, val);
-	return 0;
+	for (i = 0; i < PHY_RETRIES; i++) {
+		if (!(xm_read16(hw, port, XM_MMU_CMD) & XM_MMU_PHY_BUSY))
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
 }
 
 static void genesis_init(struct skge_hw *hw)
@@ -1168,13 +1172,17 @@ static void genesis_mac_init(struct skge
 	u32 r;
 	const u8 zero[6]  = { 0 };
 
-	/* Clear MIB counters */
-	xm_write16(hw, port, XM_STAT_CMD,
-			XM_SC_CLR_RXC | XM_SC_CLR_TXC);
-	/* Clear two times according to Errata #3 */
-	xm_write16(hw, port, XM_STAT_CMD,
-			XM_SC_CLR_RXC | XM_SC_CLR_TXC);
+	for (i = 0; i < 10; i++) {
+		skge_write16(hw, SK_REG(port, TX_MFF_CTRL1),
+			     MFF_SET_MAC_RST);
+		if (skge_read16(hw, SK_REG(port, TX_MFF_CTRL1)) & MFF_SET_MAC_RST)
+			goto reset_ok;
+		udelay(1);
+	}
+
+	printk(KERN_WARNING PFX "%s: genesis reset failed\n", dev->name);
 
+ reset_ok:
 	/* Unreset the XMAC. */
 	skge_write16(hw, SK_REG(port, TX_MFF_CTRL1), MFF_CLR_MAC_RST);
 
@@ -1191,7 +1199,7 @@ static void genesis_mac_init(struct skge
 		r |= GP_DIR_2|GP_IO_2;
 
 	skge_write32(hw, B2_GP_IO, r);
-	skge_read32(hw, B2_GP_IO);
+
 
 	/* Enable GMII interface */
 	xm_write16(hw, port, XM_HW_CFG, XM_HW_GMII_MD);
@@ -1205,6 +1213,13 @@ static void genesis_mac_init(struct skge
 	for (i = 1; i < 16; i++)
 		xm_outaddr(hw, port, XM_EXM(i), zero);
 
+	/* Clear MIB counters */
+	xm_write16(hw, port, XM_STAT_CMD,
+			XM_SC_CLR_RXC | XM_SC_CLR_TXC);
+	/* Clear two times according to Errata #3 */
+	xm_write16(hw, port, XM_STAT_CMD,
+			XM_SC_CLR_RXC | XM_SC_CLR_TXC);
+
 	/* configure Rx High Water Mark (XM_RX_HI_WM) */
 	xm_write16(hw, port, XM_RX_HI_WM, 1450);
 
@@ -2170,8 +2185,10 @@ static int skge_up(struct net_device *de
 	skge->tx_avail = skge->tx_ring.count - 1;
 
 	/* Enable IRQ from port */
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask |= portirqmask[port];
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
+	spin_unlock_irq(&hw->hw_lock);
 
 	/* Initialize MAC */
 	spin_lock_bh(&hw->phy_lock);
@@ -2229,8 +2246,10 @@ static int skge_down(struct net_device *
 	else
 		yukon_stop(skge);
 
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask &= ~portirqmask[skge->port];
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
+	spin_unlock_irq(&hw->hw_lock);
 
 	/* Stop transmitter */
 	skge_write8(hw, Q_ADDR(txqaddr[port], Q_CSR), CSR_STOP);
@@ -2678,8 +2697,7 @@ static int skge_poll(struct net_device *
 
 	/* restart receiver */
 	wmb();
-	skge_write8(hw, Q_ADDR(rxqaddr[skge->port], Q_CSR),
-		    CSR_START | CSR_IRQ_CL_F);
+	skge_write8(hw, Q_ADDR(rxqaddr[skge->port], Q_CSR), CSR_START);
 
 	*budget -= work_done;
 	dev->quota -= work_done;
@@ -2687,10 +2705,11 @@ static int skge_poll(struct net_device *
 	if (work_done >=  to_do)
 		return 1; /* not done */
 
-	netif_rx_complete(dev);
-	hw->intr_mask |= portirqmask[skge->port];
-	skge_write32(hw, B0_IMSK, hw->intr_mask);
-	skge_read32(hw, B0_IMSK);
+	spin_lock_irq(&hw->hw_lock);
+	__netif_rx_complete(dev);
+  	hw->intr_mask |= portirqmask[skge->port];
+  	skge_write32(hw, B0_IMSK, hw->intr_mask);
+ 	spin_unlock_irq(&hw->hw_lock);
 
 	return 0;
 }
@@ -2850,18 +2869,10 @@ static void skge_extirq(unsigned long da
 	}
 	spin_unlock(&hw->phy_lock);
 
-	local_irq_disable();
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask |= IS_EXT_REG;
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
-	local_irq_enable();
-}
-
-static inline void skge_wakeup(struct net_device *dev)
-{
-	struct skge_port *skge = netdev_priv(dev);
-
-	prefetch(skge->rx_ring.to_clean);
-	netif_rx_schedule(dev);
+	spin_unlock_irq(&hw->hw_lock);
 }
 
 static irqreturn_t skge_intr(int irq, void *dev_id, struct pt_regs *regs)
@@ -2872,15 +2883,17 @@ static irqreturn_t skge_intr(int irq, vo
 	if (status == 0 || status == ~0) /* hotplug or shared irq */
 		return IRQ_NONE;
 
-	status &= hw->intr_mask;
+	spin_lock(&hw->hw_lock);
 	if (status & IS_R1_F) {
+		skge_write8(hw, Q_ADDR(Q_R1, Q_CSR), CSR_IRQ_CL_F);
 		hw->intr_mask &= ~IS_R1_F;
-		skge_wakeup(hw->dev[0]);
+		netif_rx_schedule(hw->dev[0]);
 	}
 
 	if (status & IS_R2_F) {
+		skge_write8(hw, Q_ADDR(Q_R2, Q_CSR), CSR_IRQ_CL_F);
 		hw->intr_mask &= ~IS_R2_F;
-		skge_wakeup(hw->dev[1]);
+		netif_rx_schedule(hw->dev[1]);
 	}
 
 	if (status & IS_XA1_F)
@@ -2922,6 +2935,7 @@ static irqreturn_t skge_intr(int irq, vo
 	}
 
 	skge_write32(hw, B0_IMSK, hw->intr_mask);
+	spin_unlock(&hw->hw_lock);
 
 	return IRQ_HANDLED;
 }
@@ -3290,6 +3304,7 @@ static int __devinit skge_probe(struct p
 
 	hw->pdev = pdev;
 	spin_lock_init(&hw->phy_lock);
+	spin_lock_init(&hw->hw_lock);
 	tasklet_init(&hw->ext_tasklet, skge_extirq, (unsigned long) hw);
 
 	hw->regs = ioremap_nocache(pci_resource_start(pdev, 0), 0x4000);
diff --git a/drivers/net/skge.h b/drivers/net/skge.h
index 2efdacc..941f12a 100644
--- a/drivers/net/skge.h
+++ b/drivers/net/skge.h
@@ -2402,6 +2402,7 @@ struct skge_hw {
 
 	struct tasklet_struct ext_tasklet;
 	spinlock_t	     phy_lock;
+	spinlock_t	     hw_lock;
 };
 
 enum {
diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index bfeba5b..ca8160d 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -195,11 +195,11 @@ static int sky2_set_power_state(struct s
 	pr_debug("sky2_set_power_state %d\n", state);
 	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
 
-	pci_read_config_word(hw->pdev, hw->pm_cap + PCI_PM_PMC, &power_control);
+	power_control = sky2_pci_read16(hw, hw->pm_cap + PCI_PM_PMC);
 	vaux = (sky2_read16(hw, B0_CTST) & Y2_VAUX_AVAIL) &&
 		(power_control & PCI_PM_CAP_PME_D3cold);
 
-	pci_read_config_word(hw->pdev, hw->pm_cap + PCI_PM_CTRL, &power_control);
+	power_control = sky2_pci_read16(hw, hw->pm_cap + PCI_PM_CTRL);
 
 	power_control |= PCI_PM_CTRL_PME_STATUS;
 	power_control &= ~(PCI_PM_CTRL_STATE_MASK);
@@ -223,7 +223,7 @@ static int sky2_set_power_state(struct s
 			sky2_write8(hw, B2_Y2_CLK_GATE, 0);
 
 		/* Turn off phy power saving */
-		pci_read_config_dword(hw->pdev, PCI_DEV_REG1, &reg1);
+		reg1 = sky2_pci_read32(hw, PCI_DEV_REG1);
 		reg1 &= ~(PCI_Y2_PHY1_POWD | PCI_Y2_PHY2_POWD);
 
 		/* looks like this XL is back asswards .. */
@@ -232,18 +232,28 @@ static int sky2_set_power_state(struct s
 			if (hw->ports > 1)
 				reg1 |= PCI_Y2_PHY2_COMA;
 		}
-		pci_write_config_dword(hw->pdev, PCI_DEV_REG1, reg1);
+
+		if (hw->chip_id == CHIP_ID_YUKON_EC_U) {
+			sky2_pci_write32(hw, PCI_DEV_REG3, 0);
+			reg1 = sky2_pci_read32(hw, PCI_DEV_REG4);
+			reg1 &= P_ASPM_CONTROL_MSK;
+			sky2_pci_write32(hw, PCI_DEV_REG4, reg1);
+			sky2_pci_write32(hw, PCI_DEV_REG5, 0);
+		}
+
+		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
+
 		break;
 
 	case PCI_D3hot:
 	case PCI_D3cold:
 		/* Turn on phy power saving */
-		pci_read_config_dword(hw->pdev, PCI_DEV_REG1, &reg1);
+		reg1 = sky2_pci_read32(hw, PCI_DEV_REG1);
 		if (hw->chip_id == CHIP_ID_YUKON_XL && hw->chip_rev > 1)
 			reg1 &= ~(PCI_Y2_PHY1_POWD | PCI_Y2_PHY2_POWD);
 		else
 			reg1 |= (PCI_Y2_PHY1_POWD | PCI_Y2_PHY2_POWD);
-		pci_write_config_dword(hw->pdev, PCI_DEV_REG1, reg1);
+		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
 
 		if (hw->chip_id == CHIP_ID_YUKON_XL && hw->chip_rev > 1)
 			sky2_write8(hw, B2_Y2_CLK_GATE, 0);
@@ -265,7 +275,7 @@ static int sky2_set_power_state(struct s
 		ret = -1;
 	}
 
-	pci_write_config_byte(hw->pdev, hw->pm_cap + PCI_PM_CTRL, power_control);
+	sky2_pci_write16(hw, hw->pm_cap + PCI_PM_CTRL, power_control);
 	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 	return ret;
 }
@@ -463,16 +473,31 @@ static void sky2_phy_init(struct sky2_hw
 		ledover |= PHY_M_LED_MO_RX(MO_LED_OFF);
 	}
 
-	gm_phy_write(hw, port, PHY_MARV_LED_CTRL, ledctrl);
+	if (hw->chip_id == CHIP_ID_YUKON_EC_U && hw->chip_rev >= 2) {
+		/* apply fixes in PHY AFE */
+		gm_phy_write(hw, port, 22, 255);
+		/* increase differential signal amplitude in 10BASE-T */
+		gm_phy_write(hw, port, 24, 0xaa99);
+		gm_phy_write(hw, port, 23, 0x2011);
+
+		/* fix for IEEE A/B Symmetry failure in 1000BASE-T */
+		gm_phy_write(hw, port, 24, 0xa204);
+		gm_phy_write(hw, port, 23, 0x2002);
 
-	if (sky2->autoneg == AUTONEG_DISABLE || sky2->speed == SPEED_100) {
-		/* turn on 100 Mbps LED (LED_LINK100) */
-		ledover |= PHY_M_LED_MO_100(MO_LED_ON);
-	}
+		/* set page register to 0 */
+		gm_phy_write(hw, port, 22, 0);
+	} else {
+		gm_phy_write(hw, port, PHY_MARV_LED_CTRL, ledctrl);
 
-	if (ledover)
-		gm_phy_write(hw, port, PHY_MARV_LED_OVER, ledover);
+		if (sky2->autoneg == AUTONEG_DISABLE || sky2->speed == SPEED_100) {
+			/* turn on 100 Mbps LED (LED_LINK100) */
+			ledover |= PHY_M_LED_MO_100(MO_LED_ON);
+		}
+
+		if (ledover)
+			gm_phy_write(hw, port, PHY_MARV_LED_OVER, ledover);
 
+	}
 	/* Enable phy interrupt on auto-negotiation complete (or link up) */
 	if (sky2->autoneg == AUTONEG_ENABLE)
 		gm_phy_write(hw, port, PHY_MARV_INT_MASK, PHY_M_IS_AN_COMPL);
@@ -953,6 +978,12 @@ static int sky2_rx_start(struct sky2_por
 
 	sky2->rx_put = sky2->rx_next = 0;
 	sky2_qset(hw, rxq);
+
+	if (hw->chip_id == CHIP_ID_YUKON_EC_U && hw->chip_rev >= 2) {
+		/* MAC Rx RAM Read is controlled by hardware */
+		sky2_write32(hw, Q_ADDR(rxq, Q_F), F_M_RX_RAM_DIS);
+	}
+
 	sky2_prefetch_init(hw, rxq, sky2->rx_le_map, RX_LE_SIZE - 1);
 
 	rx_set_checksum(sky2);
@@ -1035,9 +1066,10 @@ static int sky2_up(struct net_device *de
 		    RB_RST_SET);
 
 	sky2_qset(hw, txqaddr[port]);
-	if (hw->chip_id == CHIP_ID_YUKON_EC_U)
-		sky2_write16(hw, Q_ADDR(txqaddr[port], Q_AL), 0x1a0);
 
+	/* Set almost empty threshold */
+	if (hw->chip_id == CHIP_ID_YUKON_EC_U && hw->chip_rev == 1)
+		sky2_write16(hw, Q_ADDR(txqaddr[port], Q_AL), 0x1a0);
 
 	sky2_prefetch_init(hw, txqaddr[port], sky2->tx_le_map,
 			   TX_RING_SIZE - 1);
@@ -1047,8 +1079,10 @@ static int sky2_up(struct net_device *de
 		goto err_out;
 
 	/* Enable interrupts from phy/mac for port */
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask |= (port == 0) ? Y2_IS_PORT_1 : Y2_IS_PORT_2;
 	sky2_write32(hw, B0_IMSK, hw->intr_mask);
+	spin_unlock_irq(&hw->hw_lock);
 	return 0;
 
 err_out:
@@ -1348,10 +1382,10 @@ static int sky2_down(struct net_device *
 	netif_stop_queue(dev);
 
 	/* Disable port IRQ */
-	local_irq_disable();
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask &= ~((sky2->port == 0) ? Y2_IS_IRQ_PHY1 : Y2_IS_IRQ_PHY2);
 	sky2_write32(hw, B0_IMSK, hw->intr_mask);
-	local_irq_enable();
+	spin_unlock_irq(&hw->hw_lock);
 
 	flush_scheduled_work();
 
@@ -1633,10 +1667,10 @@ static void sky2_phy_task(void *arg)
 out:
 	up(&sky2->phy_sema);
 
-	local_irq_disable();
+	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask |= (sky2->port == 0) ? Y2_IS_IRQ_PHY1 : Y2_IS_IRQ_PHY2;
 	sky2_write32(hw, B0_IMSK, hw->intr_mask);
-	local_irq_enable();
+	spin_unlock_irq(&hw->hw_lock);
 }
 
 
@@ -1863,6 +1897,17 @@ static int sky2_poll(struct net_device *
 
 	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
 
+	/*
+	 * Kick the STAT_LEV_TIMER_CTRL timer.
+	 * This fixes my hangs on Yukon-EC (0xb6) rev 1.
+	 * The if clause is there to start the timer only if it has been
+	 * configured correctly and not been disabled via ethtool.
+	 */
+	if (sky2_read8(hw, STAT_LEV_TIMER_CTRL) == TIM_START) {
+		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_STOP);
+		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_START);
+	}
+
 	hwidx = sky2_read16(hw, STAT_PUT_IDX);
 	BUG_ON(hwidx >= STATUS_RING_SIZE);
 	rmb();
@@ -1945,16 +1990,19 @@ exit_loop:
 	sky2_tx_check(hw, 0, tx_done[0]);
 	sky2_tx_check(hw, 1, tx_done[1]);
 
+	if (sky2_read8(hw, STAT_TX_TIMER_CTRL) == TIM_START) {
+		sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_STOP);
+		sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_START);
+	}
+
 	if (likely(work_done < to_do)) {
-		/* need to restart TX timer */
-		if (is_ec_a1(hw)) {
-			sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_STOP);
-			sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_START);
-		}
+		spin_lock_irq(&hw->hw_lock);
+		__netif_rx_complete(dev0);
 
-		netif_rx_complete(dev0);
 		hw->intr_mask |= Y2_IS_STAT_BMU;
 		sky2_write32(hw, B0_IMSK, hw->intr_mask);
+		spin_unlock_irq(&hw->hw_lock);
+
 		return 0;
 	} else {
 		*budget -= work_done;
@@ -2017,13 +2065,13 @@ static void sky2_hw_intr(struct sky2_hw 
 	if (status & (Y2_IS_MST_ERR | Y2_IS_IRQ_STAT)) {
 		u16 pci_err;
 
-		pci_read_config_word(hw->pdev, PCI_STATUS, &pci_err);
+		pci_err = sky2_pci_read16(hw, PCI_STATUS);
 		if (net_ratelimit())
 			printk(KERN_ERR PFX "%s: pci hw error (0x%x)\n",
 			       pci_name(hw->pdev), pci_err);
 
 		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-		pci_write_config_word(hw->pdev, PCI_STATUS,
+		sky2_pci_write16(hw, PCI_STATUS,
 				      pci_err | PCI_STATUS_ERROR_BITS);
 		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 	}
@@ -2032,7 +2080,7 @@ static void sky2_hw_intr(struct sky2_hw 
 		/* PCI-Express uncorrectable Error occurred */
 		u32 pex_err;
 
-		pci_read_config_dword(hw->pdev, PEX_UNC_ERR_STAT, &pex_err);
+		pex_err = sky2_pci_read32(hw, PEX_UNC_ERR_STAT);
 
 		if (net_ratelimit())
 			printk(KERN_ERR PFX "%s: pci express error (0x%x)\n",
@@ -2040,7 +2088,7 @@ static void sky2_hw_intr(struct sky2_hw 
 
 		/* clear the interrupt */
 		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
+		sky2_pci_write32(hw, PEX_UNC_ERR_STAT,
 				       0xffffffffUL);
 		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 
@@ -2086,6 +2134,7 @@ static void sky2_phy_intr(struct sky2_hw
 
 	hw->intr_mask &= ~(port == 0 ? Y2_IS_IRQ_PHY1 : Y2_IS_IRQ_PHY2);
 	sky2_write32(hw, B0_IMSK, hw->intr_mask);
+
 	schedule_work(&sky2->phy_task);
 }
 
@@ -2099,6 +2148,7 @@ static irqreturn_t sky2_intr(int irq, vo
 	if (status == 0 || status == ~0)
 		return IRQ_NONE;
 
+	spin_lock(&hw->hw_lock);
 	if (status & Y2_IS_HW_ERR)
 		sky2_hw_intr(hw);
 
@@ -2127,7 +2177,7 @@ static irqreturn_t sky2_intr(int irq, vo
 
 	sky2_write32(hw, B0_Y2_SP_ICR, 2);
 
-	sky2_read32(hw, B0_IMSK);
+	spin_unlock(&hw->hw_lock);
 
 	return IRQ_HANDLED;
 }
@@ -2170,7 +2220,7 @@ static int sky2_reset(struct sky2_hw *hw
 {
 	u16 status;
 	u8 t8, pmd_type;
-	int i, err;
+	int i;
 
 	sky2_write8(hw, B0_CTST, CS_RST_CLR);
 
@@ -2192,25 +2242,18 @@ static int sky2_reset(struct sky2_hw *hw
 	sky2_write8(hw, B0_CTST, CS_RST_CLR);
 
 	/* clear PCI errors, if any */
-	err = pci_read_config_word(hw->pdev, PCI_STATUS, &status);
-	if (err)
-		goto pci_err;
+	status = sky2_pci_read16(hw, PCI_STATUS);
 
 	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-	err = pci_write_config_word(hw->pdev, PCI_STATUS,
-				    status | PCI_STATUS_ERROR_BITS);
-	if (err)
-		goto pci_err;
+	sky2_pci_write16(hw, PCI_STATUS, status | PCI_STATUS_ERROR_BITS);
+
 
 	sky2_write8(hw, B0_CTST, CS_MRST_CLR);
 
 	/* clear any PEX errors */
-	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP)) {
-		err = pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
-						 0xffffffffUL);
-		if (err)
-			goto pci_err;
-	}
+	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP)) 
+		sky2_pci_write32(hw, PEX_UNC_ERR_STAT, 0xffffffffUL);
+
 
 	pmd_type = sky2_read8(hw, B2_PMD_TYP);
 	hw->copper = !(pmd_type == 'L' || pmd_type == 'S');
@@ -2309,8 +2352,7 @@ static int sky2_reset(struct sky2_hw *hw
 			sky2_write8(hw, STAT_FIFO_ISR_WM, 16);
 
 		sky2_write32(hw, STAT_TX_TIMER_INI, sky2_us2clk(hw, 1000));
-		sky2_write32(hw, STAT_LEV_TIMER_INI, sky2_us2clk(hw, 100));
-		sky2_write32(hw, STAT_ISR_TIMER_INI, sky2_us2clk(hw, 20));
+		sky2_write32(hw, STAT_ISR_TIMER_INI, sky2_us2clk(hw, 7));
 	}
 
 	/* enable status unit */
@@ -2321,14 +2363,6 @@ static int sky2_reset(struct sky2_hw *hw
 	sky2_write8(hw, STAT_ISR_TIMER_CTRL, TIM_START);
 
 	return 0;
-
-pci_err:
-	/* This is to catch a BIOS bug workaround where
-	 * mmconfig table doesn't have other buses.
-	 */
-	printk(KERN_ERR PFX "%s: can't access PCI config space\n",
-	       pci_name(hw->pdev));
-	return err;
 }
 
 static u32 sky2_supported_modes(const struct sky2_hw *hw)
@@ -2852,11 +2886,11 @@ static int sky2_set_coalesce(struct net_
 	    (ecmd->rx_coalesce_usecs_irq < tmin || ecmd->rx_coalesce_usecs_irq > tmax))
 		return -EINVAL;
 
-	if (ecmd->tx_max_coalesced_frames > 0xffff)
+	if (ecmd->tx_max_coalesced_frames >= TX_RING_SIZE-1)
 		return -EINVAL;
-	if (ecmd->rx_max_coalesced_frames > 0xff)
+	if (ecmd->rx_max_coalesced_frames > RX_MAX_PENDING)
 		return -EINVAL;
-	if (ecmd->rx_max_coalesced_frames_irq > 0xff)
+	if (ecmd->rx_max_coalesced_frames_irq >RX_MAX_PENDING)
 		return -EINVAL;
 
 	if (ecmd->tx_coalesce_usecs == 0)
@@ -3198,17 +3232,6 @@ static int __devinit sky2_probe(struct p
 		}
 	}
 
-#ifdef __BIG_ENDIAN
-	/* byte swap descriptors in hardware */
-	{
-		u32 reg;
-
-		pci_read_config_dword(pdev, PCI_DEV_REG2, &reg);
-		reg |= PCI_REV_DESC;
-		pci_write_config_dword(pdev, PCI_DEV_REG2, reg);
-	}
-#endif
-
 	err = -ENOMEM;
 	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
 	if (!hw) {
@@ -3226,6 +3249,18 @@ static int __devinit sky2_probe(struct p
 		goto err_out_free_hw;
 	}
 	hw->pm_cap = pm_cap;
+	spin_lock_init(&hw->hw_lock);
+
+#ifdef __BIG_ENDIAN
+	/* byte swap descriptors in hardware */
+	{
+		u32 reg;
+
+		reg = sky2_pci_read32(hw, PCI_DEV_REG2);
+		reg |= PCI_REV_DESC;
+		sky2_pci_write32(hw, PCI_DEV_REG2, reg);
+	}
+#endif
 
 	/* ring for status responses */
 	hw->st_le = pci_alloc_consistent(hw->pdev, STATUS_LE_BYTES,
diff --git a/drivers/net/sky2.h b/drivers/net/sky2.h
index fd12c28..3edb980 100644
--- a/drivers/net/sky2.h
+++ b/drivers/net/sky2.h
@@ -5,14 +5,22 @@
 #define _SKY2_H
 
 /* PCI config registers */
-#define PCI_DEV_REG1	0x40
-#define PCI_DEV_REG2	0x44
-#define PCI_DEV_STATUS  0x7c
-#define PCI_OS_PCI_X    (1<<26)
-
-#define PEX_LNK_STAT	0xf2
-#define PEX_UNC_ERR_STAT 0x104
-#define PEX_DEV_CTRL	0xe8
+enum {
+	PCI_DEV_REG1	= 0x40,
+	PCI_DEV_REG2	= 0x44,
+	PCI_DEV_STATUS  = 0x7c,
+	PCI_DEV_REG3	= 0x80,
+	PCI_DEV_REG4	= 0x84,
+	PCI_DEV_REG5    = 0x88,
+};
+
+enum {
+	PEX_DEV_CAP	= 0xe4,
+	PEX_DEV_CTRL	= 0xe8,
+	PEX_DEV_STA	= 0xea,
+	PEX_LNK_STAT	= 0xf2,
+	PEX_UNC_ERR_STAT= 0x104,
+};
 
 /* Yukon-2 */
 enum pci_dev_reg_1 {
@@ -37,6 +45,25 @@ enum pci_dev_reg_2 {
 	PCI_USEDATA64	= 1<<0,		/* Use 64Bit Data bus ext */
 };
 
+/*	PCI_OUR_REG_4		32 bit	Our Register 4 (Yukon-ECU only) */
+enum pci_dev_reg_4 {
+					/* (Link Training & Status State Machine) */
+	P_TIMER_VALUE_MSK	= 0xffL<<16,	/* Bit 23..16:	Timer Value Mask */
+					/* (Active State Power Management) */
+	P_FORCE_ASPM_REQUEST	= 1<<15, /* Force ASPM Request (A1 only) */
+	P_ASPM_GPHY_LINK_DOWN	= 1<<14, /* GPHY Link Down (A1 only) */
+	P_ASPM_INT_FIFO_EMPTY	= 1<<13, /* Internal FIFO Empty (A1 only) */
+	P_ASPM_CLKRUN_REQUEST	= 1<<12, /* CLKRUN Request (A1 only) */
+
+	P_ASPM_FORCE_CLKREQ_ENA	= 1<<4,	/* Force CLKREQ Enable (A1b only) */
+	P_ASPM_CLKREQ_PAD_CTL	= 1<<3,	/* CLKREQ PAD Control (A1 only) */
+	P_ASPM_A1_MODE_SELECT	= 1<<2,	/* A1 Mode Select (A1 only) */
+	P_CLK_GATE_PEX_UNIT_ENA	= 1<<1,	/* Enable Gate PEX Unit Clock */
+	P_CLK_GATE_ROOT_COR_ENA	= 1<<0,	/* Enable Gate Root Core Clock */
+	P_ASPM_CONTROL_MSK	= P_FORCE_ASPM_REQUEST | P_ASPM_GPHY_LINK_DOWN
+				  | P_ASPM_CLKRUN_REQUEST | P_ASPM_INT_FIFO_EMPTY,
+};
+
 
 #define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
@@ -507,6 +534,16 @@ enum {
 };
 #define Q_ADDR(reg, offs) (B8_Q_REGS + (reg) + (offs))
 
+/*	Q_F				32 bit	Flag Register */
+enum {
+	F_ALM_FULL	= 1<<27, /* Rx FIFO: almost full */
+	F_EMPTY		= 1<<27, /* Tx FIFO: empty flag */
+	F_FIFO_EOF	= 1<<26, /* Tag (EOF Flag) bit in FIFO */
+	F_WM_REACHED	= 1<<25, /* Watermark reached */
+	F_M_RX_RAM_DIS	= 1<<24, /* MAC Rx RAM Read Port disable */
+	F_FIFO_LEVEL	= 0x1fL<<16, /* Bit 23..16:	# of Qwords in FIFO */
+	F_WATER_MARK	= 0x0007ffL, /* Bit 10.. 0:	Watermark */
+};
 
 /* Queue Prefetch Unit Offsets, use Y2_QADDR() to address (Yukon-2 only)*/
 enum {
@@ -909,10 +946,12 @@ enum {
 	PHY_BCOM_ID1_C0	= 0x6044,
 	PHY_BCOM_ID1_C5	= 0x6047,
 
-	PHY_MARV_ID1_B0	= 0x0C23, /* Yukon (PHY 88E1011) */
+	PHY_MARV_ID1_B0	= 0x0C23, /* Yukon 	(PHY 88E1011) */
 	PHY_MARV_ID1_B2	= 0x0C25, /* Yukon-Plus (PHY 88E1011) */
-	PHY_MARV_ID1_C2	= 0x0CC2, /* Yukon-EC (PHY 88E1111) */
-	PHY_MARV_ID1_Y2	= 0x0C91, /* Yukon-2 (PHY 88E1112) */
+	PHY_MARV_ID1_C2	= 0x0CC2, /* Yukon-EC	(PHY 88E1111) */
+	PHY_MARV_ID1_Y2	= 0x0C91, /* Yukon-2	(PHY 88E1112) */
+	PHY_MARV_ID1_FE = 0x0C83, /* Yukon-FE   (PHY 88E3082 Rev.A1) */
+	PHY_MARV_ID1_ECU= 0x0CB0, /* Yukon-ECU  (PHY 88E1149 Rev.B2?) */
 };
 
 /* Advertisement register bits */
@@ -1837,8 +1876,9 @@ struct sky2_port {
 struct sky2_hw {
 	void __iomem  	     *regs;
 	struct pci_dev	     *pdev;
-	u32		     intr_mask;
 	struct net_device    *dev[2];
+	spinlock_t	     hw_lock;
+	u32		     intr_mask;
 
 	int		     pm_cap;
 	int		     msi;
@@ -1912,4 +1952,25 @@ static inline void gma_set_addr(struct s
 	gma_write16(hw, port, reg+4,(u16) addr[2] | ((u16) addr[3] << 8));
 	gma_write16(hw, port, reg+8,(u16) addr[4] | ((u16) addr[5] << 8));
 }
+
+/* PCI config space access */
+static inline u32 sky2_pci_read32(const struct sky2_hw *hw, unsigned reg)
+{
+	return sky2_read32(hw, Y2_CFG_SPC + reg);
+}
+
+static inline u16 sky2_pci_read16(const struct sky2_hw *hw, unsigned reg)
+{
+	return sky2_read16(hw, Y2_CFG_SPC + reg);
+}
+
+static inline void sky2_pci_write32(struct sky2_hw *hw, unsigned reg, u32 val)
+{
+	sky2_write32(hw, Y2_CFG_SPC + reg, val);
+}
+
+static inline void sky2_pci_write16(struct sky2_hw *hw, unsigned reg, u16 val)
+{
+	sky2_write16(hw, Y2_CFG_SPC + reg, val);
+}
 #endif
diff --git a/drivers/net/tlan.c b/drivers/net/tlan.c
index c2506b5..12076f8 100644
--- a/drivers/net/tlan.c
+++ b/drivers/net/tlan.c
@@ -536,6 +536,7 @@ static int __devinit TLan_probe1(struct 
 	u16		   device_id;
 	int		   reg, rc = -ENODEV;
 
+#ifdef CONFIG_PCI
 	if (pdev) {
 		rc = pci_enable_device(pdev);
 		if (rc)
@@ -547,6 +548,7 @@ static int __devinit TLan_probe1(struct 
 			goto err_out;
 		}
 	}
+#endif  /*  CONFIG_PCI  */
 
 	dev = alloc_etherdev(sizeof(TLanPrivateInfo));
 	if (dev == NULL) {
