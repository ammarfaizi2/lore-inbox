Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWBZA6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWBZA6R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 19:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWBZA6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 19:58:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:11978 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750949AbWBZA6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 19:58:15 -0500
X-Authenticated: #31060655
Message-ID: <4400FC28.1060705@gmx.net>
Date: Sun, 26 Feb 2006 01:54:00 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: netdev@vger.kernel.org, Ian Kumlien <pomac@vapor.com>,
       Wolfgang Hoffmann <woho@woho.de>, Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] Revert sky2 to 0.13a
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

you may want to push this patch into 2.6.16. The version it reverts to
has been running stable for over four weeks for various folks (CC'ed)
and we have had no success communicating with the maintainer.

Regards,
Carl-Daniel


Revert sky2 to 0.13 with a four-line fix on top of it.
Later versions cause random oopses and just hang on some chips.

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>


diff -Nurp linux-2.6.16-rc4-git8/drivers/net/sky2.c linux-2.6.16-rc4-git8-sky2fix/drivers/net/sky2.c
--- linux-2.6.16-rc4-git8/drivers/net/sky2.c	2006-02-25 02:38:35.000000000 +0100
+++ linux-2.6.16-rc4-git8-sky2fix/drivers/net/sky2.c	2006-02-26 01:29:45.000000000 +0100
@@ -23,6 +23,12 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+/*
+ * TOTEST
+ *	- speed setting
+ *	- suspend/resume
+ */
+
 #include <linux/config.h>
 #include <linux/crc32.h>
 #include <linux/kernel.h>
@@ -51,7 +57,7 @@
 #include "sky2.h"
 
 #define DRV_NAME		"sky2"
-#define DRV_VERSION		"0.15"
+#define DRV_VERSION		"0.13a"
 #define PFX			DRV_NAME " "
 
 /*
@@ -96,10 +102,6 @@ static int copybreak __read_mostly = 256
 module_param(copybreak, int, 0);
 MODULE_PARM_DESC(copybreak, "Receive copy threshold");
 
-static int disable_msi = 0;
-module_param(disable_msi, int, 0);
-MODULE_PARM_DESC(disable_msi, "Disable Message Signaled Interrupt (MSI)");
-
 static const struct pci_device_id sky2_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9000) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9E00) },
@@ -195,11 +197,11 @@ static int sky2_set_power_state(struct s
 	pr_debug("sky2_set_power_state %d\n", state);
 	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
 
-	power_control = sky2_pci_read16(hw, hw->pm_cap + PCI_PM_PMC);
-	vaux = (sky2_read16(hw, B0_CTST) & Y2_VAUX_AVAIL) &&
+	pci_read_config_word(hw->pdev, hw->pm_cap + PCI_PM_PMC, &power_control);
+	vaux = (sky2_read8(hw, B0_CTST) & Y2_VAUX_AVAIL) &&
 		(power_control & PCI_PM_CAP_PME_D3cold);
 
-	power_control = sky2_pci_read16(hw, hw->pm_cap + PCI_PM_CTRL);
+	pci_read_config_word(hw->pdev, hw->pm_cap + PCI_PM_CTRL, &power_control);
 
 	power_control |= PCI_PM_CTRL_PME_STATUS;
 	power_control &= ~(PCI_PM_CTRL_STATE_MASK);
@@ -223,7 +225,7 @@ static int sky2_set_power_state(struct s
 			sky2_write8(hw, B2_Y2_CLK_GATE, 0);
 
 		/* Turn off phy power saving */
-		reg1 = sky2_pci_read32(hw, PCI_DEV_REG1);
+		pci_read_config_dword(hw->pdev, PCI_DEV_REG1, &reg1);
 		reg1 &= ~(PCI_Y2_PHY1_POWD | PCI_Y2_PHY2_POWD);
 
 		/* looks like this XL is back asswards .. */
@@ -232,28 +234,18 @@ static int sky2_set_power_state(struct s
 			if (hw->ports > 1)
 				reg1 |= PCI_Y2_PHY2_COMA;
 		}
-
-		if (hw->chip_id == CHIP_ID_YUKON_EC_U) {
-			sky2_pci_write32(hw, PCI_DEV_REG3, 0);
-			reg1 = sky2_pci_read32(hw, PCI_DEV_REG4);
-			reg1 &= P_ASPM_CONTROL_MSK;
-			sky2_pci_write32(hw, PCI_DEV_REG4, reg1);
-			sky2_pci_write32(hw, PCI_DEV_REG5, 0);
-		}
-
-		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
-
+		pci_write_config_dword(hw->pdev, PCI_DEV_REG1, reg1);
 		break;
 
 	case PCI_D3hot:
 	case PCI_D3cold:
 		/* Turn on phy power saving */
-		reg1 = sky2_pci_read32(hw, PCI_DEV_REG1);
+		pci_read_config_dword(hw->pdev, PCI_DEV_REG1, &reg1);
 		if (hw->chip_id == CHIP_ID_YUKON_XL && hw->chip_rev > 1)
 			reg1 &= ~(PCI_Y2_PHY1_POWD | PCI_Y2_PHY2_POWD);
 		else
 			reg1 |= (PCI_Y2_PHY1_POWD | PCI_Y2_PHY2_POWD);
-		sky2_pci_write32(hw, PCI_DEV_REG1, reg1);
+		pci_write_config_dword(hw->pdev, PCI_DEV_REG1, reg1);
 
 		if (hw->chip_id == CHIP_ID_YUKON_XL && hw->chip_rev > 1)
 			sky2_write8(hw, B2_Y2_CLK_GATE, 0);
@@ -275,7 +267,7 @@ static int sky2_set_power_state(struct s
 		ret = -1;
 	}
 
-	sky2_pci_write16(hw, hw->pm_cap + PCI_PM_CTRL, power_control);
+	pci_write_config_byte(hw->pdev, hw->pm_cap + PCI_PM_CTRL, power_control);
 	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 	return ret;
 }
@@ -473,31 +465,16 @@ static void sky2_phy_init(struct sky2_hw
 		ledover |= PHY_M_LED_MO_RX(MO_LED_OFF);
 	}
 
-	if (hw->chip_id == CHIP_ID_YUKON_EC_U && hw->chip_rev >= 2) {
-		/* apply fixes in PHY AFE */
-		gm_phy_write(hw, port, 22, 255);
-		/* increase differential signal amplitude in 10BASE-T */
-		gm_phy_write(hw, port, 24, 0xaa99);
-		gm_phy_write(hw, port, 23, 0x2011);
-
-		/* fix for IEEE A/B Symmetry failure in 1000BASE-T */
-		gm_phy_write(hw, port, 24, 0xa204);
-		gm_phy_write(hw, port, 23, 0x2002);
-
-		/* set page register to 0 */
-		gm_phy_write(hw, port, 22, 0);
-	} else {
-		gm_phy_write(hw, port, PHY_MARV_LED_CTRL, ledctrl);
+	gm_phy_write(hw, port, PHY_MARV_LED_CTRL, ledctrl);
 
-		if (sky2->autoneg == AUTONEG_DISABLE || sky2->speed == SPEED_100) {
-			/* turn on 100 Mbps LED (LED_LINK100) */
-			ledover |= PHY_M_LED_MO_100(MO_LED_ON);
-		}
+	if (sky2->autoneg == AUTONEG_DISABLE || sky2->speed == SPEED_100) {
+		/* turn on 100 Mbps LED (LED_LINK100) */
+		ledover |= PHY_M_LED_MO_100(MO_LED_ON);
+	}
 
-		if (ledover)
-			gm_phy_write(hw, port, PHY_MARV_LED_OVER, ledover);
+	if (ledover)
+		gm_phy_write(hw, port, PHY_MARV_LED_OVER, ledover);
 
-	}
 	/* Enable phy interrupt on auto-negotiation complete (or link up) */
 	if (sky2->autoneg == AUTONEG_ENABLE)
 		gm_phy_write(hw, port, PHY_MARV_INT_MASK, PHY_M_IS_AN_COMPL);
@@ -545,16 +522,10 @@ static void sky2_mac_init(struct sky2_hw
 
 		switch (sky2->speed) {
 		case SPEED_1000:
-			reg &= ~GM_GPCR_SPEED_100;
 			reg |= GM_GPCR_SPEED_1000;
-			break;
+			/* fallthru */
 		case SPEED_100:
-			reg &= ~GM_GPCR_SPEED_1000;
 			reg |= GM_GPCR_SPEED_100;
-			break;
-		case SPEED_10:
-			reg &= ~(GM_GPCR_SPEED_1000 | GM_GPCR_SPEED_100);
-			break;
 		}
 
 		if (sky2->duplex == DUPLEX_FULL)
@@ -978,12 +949,6 @@ static int sky2_rx_start(struct sky2_por
 
 	sky2->rx_put = sky2->rx_next = 0;
 	sky2_qset(hw, rxq);
-
-	if (hw->chip_id == CHIP_ID_YUKON_EC_U && hw->chip_rev >= 2) {
-		/* MAC Rx RAM Read is controlled by hardware */
-		sky2_write32(hw, Q_ADDR(rxq, Q_F), F_M_RX_RAM_DIS);
-	}
-
 	sky2_prefetch_init(hw, rxq, sky2->rx_le_map, RX_LE_SIZE - 1);
 
 	rx_set_checksum(sky2);
@@ -1066,11 +1031,10 @@ static int sky2_up(struct net_device *de
 		    RB_RST_SET);
 
 	sky2_qset(hw, txqaddr[port]);
-
-	/* Set almost empty threshold */
-	if (hw->chip_id == CHIP_ID_YUKON_EC_U && hw->chip_rev == 1)
+	if (hw->chip_id == CHIP_ID_YUKON_EC_U)
 		sky2_write16(hw, Q_ADDR(txqaddr[port], Q_AL), 0x1a0);
 
+
 	sky2_prefetch_init(hw, txqaddr[port], sky2->tx_le_map,
 			   TX_RING_SIZE - 1);
 
@@ -1079,10 +1043,8 @@ static int sky2_up(struct net_device *de
 		goto err_out;
 
 	/* Enable interrupts from phy/mac for port */
-	spin_lock_irq(&hw->hw_lock);
 	hw->intr_mask |= (port == 0) ? Y2_IS_PORT_1 : Y2_IS_PORT_2;
 	sky2_write32(hw, B0_IMSK, hw->intr_mask);
-	spin_unlock_irq(&hw->hw_lock);
 	return 0;
 
 err_out:
@@ -1382,10 +1344,10 @@ static int sky2_down(struct net_device *
 	netif_stop_queue(dev);
 
 	/* Disable port IRQ */
-	spin_lock_irq(&hw->hw_lock);
+	local_irq_disable();
 	hw->intr_mask &= ~((sky2->port == 0) ? Y2_IS_IRQ_PHY1 : Y2_IS_IRQ_PHY2);
 	sky2_write32(hw, B0_IMSK, hw->intr_mask);
-	spin_unlock_irq(&hw->hw_lock);
+	local_irq_enable();
 
 	flush_scheduled_work();
 
@@ -1486,29 +1448,6 @@ static void sky2_link_up(struct sky2_por
 	sky2_write8(hw, SK_REG(port, GMAC_IRQ_MSK), GMAC_DEF_MSK);
 
 	reg = gma_read16(hw, port, GM_GP_CTRL);
-	if (sky2->autoneg == AUTONEG_DISABLE) {
-		reg |= GM_GPCR_AU_ALL_DIS;
-
-		/* Is write/read necessary?  Copied from sky2_mac_init */
-		gma_write16(hw, port, GM_GP_CTRL, reg);
-		gma_read16(hw, port, GM_GP_CTRL);
-
-		switch (sky2->speed) {
-		case SPEED_1000:
-			reg &= ~GM_GPCR_SPEED_100;
-			reg |= GM_GPCR_SPEED_1000;
-			break;
-		case SPEED_100:
-			reg &= ~GM_GPCR_SPEED_1000;
-			reg |= GM_GPCR_SPEED_100;
-			break;
-		case SPEED_10:
-			reg &= ~(GM_GPCR_SPEED_1000 | GM_GPCR_SPEED_100);
-			break;
-		}
-	} else
-		reg &= ~GM_GPCR_AU_ALL_DIS;
-
 	if (sky2->duplex == DUPLEX_FULL || sky2->autoneg == AUTONEG_ENABLE)
 		reg |= GM_GPCR_DUP_FULL;
 
@@ -1667,10 +1606,10 @@ static void sky2_phy_task(void *arg)
 out:
 	up(&sky2->phy_sema);
 
-	spin_lock_irq(&hw->hw_lock);
+	local_irq_disable();
 	hw->intr_mask |= (sky2->port == 0) ? Y2_IS_IRQ_PHY1 : Y2_IS_IRQ_PHY2;
 	sky2_write32(hw, B0_IMSK, hw->intr_mask);
-	spin_unlock_irq(&hw->hw_lock);
+	local_irq_enable();
 }
 
 
@@ -1895,19 +1834,6 @@ static int sky2_poll(struct net_device *
 	u16 hwidx;
 	u16 tx_done[2] = { TX_NO_STATUS, TX_NO_STATUS };
 
-	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
-
-	/*
-	 * Kick the STAT_LEV_TIMER_CTRL timer.
-	 * This fixes my hangs on Yukon-EC (0xb6) rev 1.
-	 * The if clause is there to start the timer only if it has been
-	 * configured correctly and not been disabled via ethtool.
-	 */
-	if (sky2_read8(hw, STAT_LEV_TIMER_CTRL) == TIM_START) {
-		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_STOP);
-		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_START);
-	}
-
 	hwidx = sky2_read16(hw, STAT_PUT_IDX);
 	BUG_ON(hwidx >= STATUS_RING_SIZE);
 	rmb();
@@ -1987,22 +1913,32 @@ static int sky2_poll(struct net_device *
 	}
 
 exit_loop:
-	sky2_tx_check(hw, 0, tx_done[0]);
-	sky2_tx_check(hw, 1, tx_done[1]);
+	sky2_write32(hw, STAT_CTRL, SC_STAT_CLR_IRQ);
 
-	if (sky2_read8(hw, STAT_TX_TIMER_CTRL) == TIM_START) {
-		sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_STOP);
-		sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_START);
+	/*
+	 * Kick the STAT_LEV_TIMER_CTRL timer.
+	 * This fixes the hangs on Yukon-EC (0xb6) rev 1.
+	 * The if clause is there to start the timer only if it has been
+	 * configured correctly and not been disabled via ethtool.
+	 */
+	if (sky2_read8(hw, STAT_LEV_TIMER_CTRL) == TIM_START) {
+		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_STOP);
+		sky2_write8(hw, STAT_LEV_TIMER_CTRL, TIM_START);
 	}
 
-	if (likely(work_done < to_do)) {
-		spin_lock_irq(&hw->hw_lock);
-		__netif_rx_complete(dev0);
+	sky2_tx_check(hw, 0, tx_done[0]);
+	sky2_tx_check(hw, 1, tx_done[1]);
 
+	if (sky2_read16(hw, STAT_PUT_IDX) == hw->st_idx) {
+		/* need to restart TX timer */
+		if (is_ec_a1(hw)) {
+			sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_STOP);
+			sky2_write8(hw, STAT_TX_TIMER_CTRL, TIM_START);
+		}
+
+		netif_rx_complete(dev0);
 		hw->intr_mask |= Y2_IS_STAT_BMU;
 		sky2_write32(hw, B0_IMSK, hw->intr_mask);
-		spin_unlock_irq(&hw->hw_lock);
-
 		return 0;
 	} else {
 		*budget -= work_done;
@@ -2065,13 +2001,13 @@ static void sky2_hw_intr(struct sky2_hw 
 	if (status & (Y2_IS_MST_ERR | Y2_IS_IRQ_STAT)) {
 		u16 pci_err;
 
-		pci_err = sky2_pci_read16(hw, PCI_STATUS);
+		pci_read_config_word(hw->pdev, PCI_STATUS, &pci_err);
 		if (net_ratelimit())
 			printk(KERN_ERR PFX "%s: pci hw error (0x%x)\n",
 			       pci_name(hw->pdev), pci_err);
 
 		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-		sky2_pci_write16(hw, PCI_STATUS,
+		pci_write_config_word(hw->pdev, PCI_STATUS,
 				      pci_err | PCI_STATUS_ERROR_BITS);
 		sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 	}
@@ -2080,7 +2016,7 @@ static void sky2_hw_intr(struct sky2_hw 
 		/* PCI-Express uncorrectable Error occurred */
 		u32 pex_err;
 
-		pex_err = sky2_pci_read32(hw, PEX_UNC_ERR_STAT);
+		pci_read_config_dword(hw->pdev, PEX_UNC_ERR_STAT, &pex_err);
 
 		if (net_ratelimit())
 			printk(KERN_ERR PFX "%s: pci express error (0x%x)\n",
@@ -2088,7 +2024,7 @@ static void sky2_hw_intr(struct sky2_hw 
 
 		/* clear the interrupt */
 		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-		sky2_pci_write32(hw, PEX_UNC_ERR_STAT,
+		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
 				       0xffffffffUL);
 		sky2_write32(hw, B2_TST_CTRL1, TST_CFG_WRITE_OFF);
 
@@ -2134,7 +2070,6 @@ static void sky2_phy_intr(struct sky2_hw
 
 	hw->intr_mask &= ~(port == 0 ? Y2_IS_IRQ_PHY1 : Y2_IS_IRQ_PHY2);
 	sky2_write32(hw, B0_IMSK, hw->intr_mask);
-
 	schedule_work(&sky2->phy_task);
 }
 
@@ -2148,7 +2083,6 @@ static irqreturn_t sky2_intr(int irq, vo
 	if (status == 0 || status == ~0)
 		return IRQ_NONE;
 
-	spin_lock(&hw->hw_lock);
 	if (status & Y2_IS_HW_ERR)
 		sky2_hw_intr(hw);
 
@@ -2177,7 +2111,7 @@ static irqreturn_t sky2_intr(int irq, vo
 
 	sky2_write32(hw, B0_Y2_SP_ICR, 2);
 
-	spin_unlock(&hw->hw_lock);
+	sky2_read32(hw, B0_IMSK);
 
 	return IRQ_HANDLED;
 }
@@ -2218,12 +2152,14 @@ static inline u32 sky2_clk2us(const stru
 
 static int sky2_reset(struct sky2_hw *hw)
 {
+	u32 ctst;
 	u16 status;
 	u8 t8, pmd_type;
 	int i;
 
-	sky2_write8(hw, B0_CTST, CS_RST_CLR);
+	ctst = sky2_read32(hw, B0_CTST);
 
+	sky2_write8(hw, B0_CTST, CS_RST_CLR);
 	hw->chip_id = sky2_read8(hw, B2_CHIP_ID);
 	if (hw->chip_id < CHIP_ID_YUKON_XL || hw->chip_id > CHIP_ID_YUKON_FE) {
 		printk(KERN_ERR PFX "%s: unsupported chip type 0x%x\n",
@@ -2231,6 +2167,12 @@ static int sky2_reset(struct sky2_hw *hw
 		return -EOPNOTSUPP;
 	}
 
+	/* ring for status responses */
+	hw->st_le = pci_alloc_consistent(hw->pdev, STATUS_LE_BYTES,
+					 &hw->st_dma);
+	if (!hw->st_le)
+		return -ENOMEM;
+
 	/* disable ASF */
 	if (hw->chip_id <= CHIP_ID_YUKON_EC) {
 		sky2_write8(hw, B28_Y2_ASF_STAT_CMD, Y2_ASF_RESET);
@@ -2242,18 +2184,20 @@ static int sky2_reset(struct sky2_hw *hw
 	sky2_write8(hw, B0_CTST, CS_RST_CLR);
 
 	/* clear PCI errors, if any */
-	status = sky2_pci_read16(hw, PCI_STATUS);
-
+	pci_read_config_word(hw->pdev, PCI_STATUS, &status);
 	sky2_write8(hw, B2_TST_CTRL1, TST_CFG_WRITE_ON);
-	sky2_pci_write16(hw, PCI_STATUS, status | PCI_STATUS_ERROR_BITS);
-
+	pci_write_config_word(hw->pdev, PCI_STATUS,
+			      status | PCI_STATUS_ERROR_BITS);
 
 	sky2_write8(hw, B0_CTST, CS_MRST_CLR);
 
 	/* clear any PEX errors */
-	if (pci_find_capability(hw->pdev, PCI_CAP_ID_EXP)) 
-		sky2_pci_write32(hw, PEX_UNC_ERR_STAT, 0xffffffffUL);
-
+	if (is_pciex(hw)) {
+		u16 lstat;
+		pci_write_config_dword(hw->pdev, PEX_UNC_ERR_STAT,
+				       0xffffffffUL);
+		pci_read_config_word(hw->pdev, PEX_LNK_STAT, &lstat);
+	}
 
 	pmd_type = sky2_read8(hw, B2_PMD_TYP);
 	hw->copper = !(pmd_type == 'L' || pmd_type == 'S');
@@ -2352,7 +2296,8 @@ static int sky2_reset(struct sky2_hw *hw
 			sky2_write8(hw, STAT_FIFO_ISR_WM, 16);
 
 		sky2_write32(hw, STAT_TX_TIMER_INI, sky2_us2clk(hw, 1000));
-		sky2_write32(hw, STAT_ISR_TIMER_INI, sky2_us2clk(hw, 7));
+		sky2_write32(hw, STAT_LEV_TIMER_INI, sky2_us2clk(hw, 100));
+		sky2_write32(hw, STAT_ISR_TIMER_INI, sky2_us2clk(hw, 20));
 	}
 
 	/* enable status unit */
@@ -2617,24 +2562,19 @@ static struct net_device_stats *sky2_get
 static int sky2_set_mac_address(struct net_device *dev, void *p)
 {
 	struct sky2_port *sky2 = netdev_priv(dev);
-	struct sky2_hw *hw = sky2->hw;
-	unsigned port = sky2->port;
-	const struct sockaddr *addr = p;
+	struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-	memcpy_toio(hw->regs + B2_MAC_1 + port * 8,
+	memcpy_toio(sky2->hw->regs + B2_MAC_1 + sky2->port * 8,
 		    dev->dev_addr, ETH_ALEN);
-	memcpy_toio(hw->regs + B2_MAC_2 + port * 8,
+	memcpy_toio(sky2->hw->regs + B2_MAC_2 + sky2->port * 8,
 		    dev->dev_addr, ETH_ALEN);
 
-	/* virtual address for data */
-	gma_set_addr(hw, port, GM_SRC_ADDR_2L, dev->dev_addr);
-
-	/* physical address: used for pause frames */
-	gma_set_addr(hw, port, GM_SRC_ADDR_1L, dev->dev_addr);
+	if (netif_running(dev))
+		sky2_phy_reinit(sky2);
 
 	return 0;
 }
@@ -2886,11 +2826,11 @@ static int sky2_set_coalesce(struct net_
 	    (ecmd->rx_coalesce_usecs_irq < tmin || ecmd->rx_coalesce_usecs_irq > tmax))
 		return -EINVAL;
 
-	if (ecmd->tx_max_coalesced_frames >= TX_RING_SIZE-1)
+	if (ecmd->tx_max_coalesced_frames > 0xffff)
 		return -EINVAL;
-	if (ecmd->rx_max_coalesced_frames > RX_MAX_PENDING)
+	if (ecmd->rx_max_coalesced_frames > 0xff)
 		return -EINVAL;
-	if (ecmd->rx_max_coalesced_frames_irq >RX_MAX_PENDING)
+	if (ecmd->rx_max_coalesced_frames_irq > 0xff)
 		return -EINVAL;
 
 	if (ecmd->tx_coalesce_usecs == 0)
@@ -3126,61 +3066,6 @@ static void __devinit sky2_show_addr(str
 		       dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
 }
 
-/* Handle software interrupt used during MSI test */
-static irqreturn_t __devinit sky2_test_intr(int irq, void *dev_id,
-					    struct pt_regs *regs)
-{
-	struct sky2_hw *hw = dev_id;
-	u32 status = sky2_read32(hw, B0_Y2_SP_ISRC2);
-
-	if (status == 0)
-		return IRQ_NONE;
-
-	if (status & Y2_IS_IRQ_SW) {
-		sky2_write8(hw, B0_CTST, CS_CL_SW_IRQ);
-		hw->msi = 1;
-	}
-	sky2_write32(hw, B0_Y2_SP_ICR, 2);
-
-	sky2_read32(hw, B0_IMSK);
-	return IRQ_HANDLED;
-}
-
-/* Test interrupt path by forcing a a software IRQ */
-static int __devinit sky2_test_msi(struct sky2_hw *hw)
-{
-	struct pci_dev *pdev = hw->pdev;
-	int i, err;
-
-	sky2_write32(hw, B0_IMSK, Y2_IS_IRQ_SW);
-
-	err = request_irq(pdev->irq, sky2_test_intr, SA_SHIRQ, DRV_NAME, hw);
-	if (err) {
-		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
-		       pci_name(pdev), pdev->irq);
-		return err;
-	}
-
-	sky2_write8(hw, B0_CTST, CS_ST_SW_IRQ);
-	wmb();
-
-	for (i = 0; i < 10; i++) {
-		barrier();
-		if (hw->msi)
-			goto found;
-		mdelay(1);
-	}
-
-	err = -EOPNOTSUPP;
-	sky2_write8(hw, B0_CTST, CS_CL_SW_IRQ);
- found:
-	sky2_write32(hw, B0_IMSK, 0);
-
-	free_irq(pdev->irq, hw);
-
-	return err;
-}
-
 static int __devinit sky2_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
@@ -3232,6 +3117,17 @@ static int __devinit sky2_probe(struct p
 		}
 	}
 
+#ifdef __BIG_ENDIAN
+	/* byte swap descriptors in hardware */
+	{
+		u32 reg;
+
+		pci_read_config_dword(pdev, PCI_DEV_REG2, &reg);
+		reg |= PCI_REV_DESC;
+		pci_write_config_dword(pdev, PCI_DEV_REG2, reg);
+	}
+#endif
+
 	err = -ENOMEM;
 	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
 	if (!hw) {
@@ -3249,24 +3145,6 @@ static int __devinit sky2_probe(struct p
 		goto err_out_free_hw;
 	}
 	hw->pm_cap = pm_cap;
-	spin_lock_init(&hw->hw_lock);
-
-#ifdef __BIG_ENDIAN
-	/* byte swap descriptors in hardware */
-	{
-		u32 reg;
-
-		reg = sky2_pci_read32(hw, PCI_DEV_REG2);
-		reg |= PCI_REV_DESC;
-		sky2_pci_write32(hw, PCI_DEV_REG2, reg);
-	}
-#endif
-
-	/* ring for status responses */
-	hw->st_le = pci_alloc_consistent(hw->pdev, STATUS_LE_BYTES,
-					 &hw->st_dma);
-	if (!hw->st_le)
-		goto err_out_iounmap;
 
 	err = sky2_reset(hw);
 	if (err)
@@ -3302,22 +3180,7 @@ static int __devinit sky2_probe(struct p
 		}
 	}
 
-	if (!disable_msi && pci_enable_msi(pdev) == 0) {
-		err = sky2_test_msi(hw);
-		if (err == -EOPNOTSUPP) {
-			/* MSI test failed, go back to INTx mode */
-			printk(KERN_WARNING PFX "%s: No interrupt was generated using MSI, "
-			       "switching to INTx mode. Please report this failure to "
-			       "the PCI maintainer and include system chipset information.\n",
-			       pci_name(pdev));
-			pci_disable_msi(pdev);
-		}
-		else if (err)
-			goto err_out_unregister;
-	}
-
-	err = request_irq(pdev->irq, sky2_intr, SA_SHIRQ | SA_SAMPLE_RANDOM,
-			  DRV_NAME, hw);
+	err = request_irq(pdev->irq, sky2_intr, SA_SHIRQ, DRV_NAME, hw);
 	if (err) {
 		printk(KERN_ERR PFX "%s: cannot assign irq %d\n",
 		       pci_name(pdev), pdev->irq);
@@ -3332,8 +3195,6 @@ static int __devinit sky2_probe(struct p
 	return 0;
 
 err_out_unregister:
-	if (hw->msi)
-		pci_disable_msi(pdev);
 	if (dev1) {
 		unregister_netdev(dev1);
 		free_netdev(dev1);
@@ -3376,8 +3237,6 @@ static void __devexit sky2_remove(struct
 	sky2_read8(hw, B0_CTST);
 
 	free_irq(pdev->irq, hw);
-	if (hw->msi)
-		pci_disable_msi(pdev);
 	pci_free_consistent(pdev, STATUS_LE_BYTES, hw->st_le, hw->st_dma);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
@@ -3415,33 +3274,25 @@ static int sky2_suspend(struct pci_dev *
 static int sky2_resume(struct pci_dev *pdev)
 {
 	struct sky2_hw *hw = pci_get_drvdata(pdev);
-	int i, err;
+	int i;
 
 	pci_restore_state(pdev);
 	pci_enable_wake(pdev, PCI_D0, 0);
-	err = sky2_set_power_state(hw, PCI_D0);
-	if (err)
-		goto out;
+	sky2_set_power_state(hw, PCI_D0);
 
-	err = sky2_reset(hw);
-	if (err)
-		goto out;
+	sky2_reset(hw);
 
 	for (i = 0; i < 2; i++) {
 		struct net_device *dev = hw->dev[i];
-		if (dev && netif_running(dev)) {
-			netif_device_attach(dev);
-			err = sky2_up(dev);
-			if (err) {
-				printk(KERN_ERR PFX "%s: could not up: %d\n",
-				       dev->name, err);
-				dev_close(dev);
-				break;
+		if (dev) {
+			if (netif_running(dev)) {
+				netif_device_attach(dev);
+				if (sky2_up(dev))
+					dev_close(dev);
 			}
 		}
 	}
-out:
-	return err;
+	return 0;
 }
 #endif
 
diff -Nurp linux-2.6.16-rc4-git8/drivers/net/sky2.h linux-2.6.16-rc4-git8-sky2fix/drivers/net/sky2.h
--- linux-2.6.16-rc4-git8/drivers/net/sky2.h	2006-02-25 02:38:35.000000000 +0100
+++ linux-2.6.16-rc4-git8-sky2fix/drivers/net/sky2.h	2006-02-04 15:43:58.000000000 +0100
@@ -5,22 +5,14 @@
 #define _SKY2_H
 
 /* PCI config registers */
-enum {
-	PCI_DEV_REG1	= 0x40,
-	PCI_DEV_REG2	= 0x44,
-	PCI_DEV_STATUS  = 0x7c,
-	PCI_DEV_REG3	= 0x80,
-	PCI_DEV_REG4	= 0x84,
-	PCI_DEV_REG5    = 0x88,
-};
-
-enum {
-	PEX_DEV_CAP	= 0xe4,
-	PEX_DEV_CTRL	= 0xe8,
-	PEX_DEV_STA	= 0xea,
-	PEX_LNK_STAT	= 0xf2,
-	PEX_UNC_ERR_STAT= 0x104,
-};
+#define PCI_DEV_REG1	0x40
+#define PCI_DEV_REG2	0x44
+#define PCI_DEV_STATUS  0x7c
+#define PCI_OS_PCI_X    (1<<26)
+
+#define PEX_LNK_STAT	0xf2
+#define PEX_UNC_ERR_STAT 0x104
+#define PEX_DEV_CTRL	0xe8
 
 /* Yukon-2 */
 enum pci_dev_reg_1 {
@@ -45,25 +37,6 @@ enum pci_dev_reg_2 {
 	PCI_USEDATA64	= 1<<0,		/* Use 64Bit Data bus ext */
 };
 
-/*	PCI_OUR_REG_4		32 bit	Our Register 4 (Yukon-ECU only) */
-enum pci_dev_reg_4 {
-					/* (Link Training & Status State Machine) */
-	P_TIMER_VALUE_MSK	= 0xffL<<16,	/* Bit 23..16:	Timer Value Mask */
-					/* (Active State Power Management) */
-	P_FORCE_ASPM_REQUEST	= 1<<15, /* Force ASPM Request (A1 only) */
-	P_ASPM_GPHY_LINK_DOWN	= 1<<14, /* GPHY Link Down (A1 only) */
-	P_ASPM_INT_FIFO_EMPTY	= 1<<13, /* Internal FIFO Empty (A1 only) */
-	P_ASPM_CLKRUN_REQUEST	= 1<<12, /* CLKRUN Request (A1 only) */
-
-	P_ASPM_FORCE_CLKREQ_ENA	= 1<<4,	/* Force CLKREQ Enable (A1b only) */
-	P_ASPM_CLKREQ_PAD_CTL	= 1<<3,	/* CLKREQ PAD Control (A1 only) */
-	P_ASPM_A1_MODE_SELECT	= 1<<2,	/* A1 Mode Select (A1 only) */
-	P_CLK_GATE_PEX_UNIT_ENA	= 1<<1,	/* Enable Gate PEX Unit Clock */
-	P_CLK_GATE_ROOT_COR_ENA	= 1<<0,	/* Enable Gate Root Core Clock */
-	P_ASPM_CONTROL_MSK	= P_FORCE_ASPM_REQUEST | P_ASPM_GPHY_LINK_DOWN
-				  | P_ASPM_CLKRUN_REQUEST | P_ASPM_INT_FIFO_EMPTY,
-};
-
 
 #define PCI_STATUS_ERROR_BITS (PCI_STATUS_DETECTED_PARITY | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
@@ -534,16 +507,6 @@ enum {
 };
 #define Q_ADDR(reg, offs) (B8_Q_REGS + (reg) + (offs))
 
-/*	Q_F				32 bit	Flag Register */
-enum {
-	F_ALM_FULL	= 1<<27, /* Rx FIFO: almost full */
-	F_EMPTY		= 1<<27, /* Tx FIFO: empty flag */
-	F_FIFO_EOF	= 1<<26, /* Tag (EOF Flag) bit in FIFO */
-	F_WM_REACHED	= 1<<25, /* Watermark reached */
-	F_M_RX_RAM_DIS	= 1<<24, /* MAC Rx RAM Read Port disable */
-	F_FIFO_LEVEL	= 0x1fL<<16, /* Bit 23..16:	# of Qwords in FIFO */
-	F_WATER_MARK	= 0x0007ffL, /* Bit 10.. 0:	Watermark */
-};
 
 /* Queue Prefetch Unit Offsets, use Y2_QADDR() to address (Yukon-2 only)*/
 enum {
@@ -946,12 +909,10 @@ enum {
 	PHY_BCOM_ID1_C0	= 0x6044,
 	PHY_BCOM_ID1_C5	= 0x6047,
 
-	PHY_MARV_ID1_B0	= 0x0C23, /* Yukon 	(PHY 88E1011) */
+	PHY_MARV_ID1_B0	= 0x0C23, /* Yukon (PHY 88E1011) */
 	PHY_MARV_ID1_B2	= 0x0C25, /* Yukon-Plus (PHY 88E1011) */
-	PHY_MARV_ID1_C2	= 0x0CC2, /* Yukon-EC	(PHY 88E1111) */
-	PHY_MARV_ID1_Y2	= 0x0C91, /* Yukon-2	(PHY 88E1112) */
-	PHY_MARV_ID1_FE = 0x0C83, /* Yukon-FE   (PHY 88E3082 Rev.A1) */
-	PHY_MARV_ID1_ECU= 0x0CB0, /* Yukon-ECU  (PHY 88E1149 Rev.B2?) */
+	PHY_MARV_ID1_C2	= 0x0CC2, /* Yukon-EC (PHY 88E1111) */
+	PHY_MARV_ID1_Y2	= 0x0C91, /* Yukon-2 (PHY 88E1112) */
 };
 
 /* Advertisement register bits */
@@ -1876,12 +1837,10 @@ struct sky2_port {
 struct sky2_hw {
 	void __iomem  	     *regs;
 	struct pci_dev	     *pdev;
-	struct net_device    *dev[2];
-	spinlock_t	     hw_lock;
 	u32		     intr_mask;
+	struct net_device    *dev[2];
 
 	int		     pm_cap;
-	int		     msi;
 	u8	     	     chip_id;
 	u8		     chip_rev;
 	u8		     copper;
@@ -1908,6 +1867,14 @@ static inline u8 sky2_read8(const struct
 	return readb(hw->regs + reg);
 }
 
+/* This should probably go away, bus based tweeks suck */
+static inline int is_pciex(const struct sky2_hw *hw)
+{
+	u32 status;
+	pci_read_config_dword(hw->pdev, PCI_DEV_STATUS, &status);
+	return (status & PCI_OS_PCI_X) == 0;
+}
+
 static inline void sky2_write32(const struct sky2_hw *hw, unsigned reg, u32 val)
 {
 	writel(val, hw->regs + reg);
@@ -1952,25 +1919,4 @@ static inline void gma_set_addr(struct s
 	gma_write16(hw, port, reg+4,(u16) addr[2] | ((u16) addr[3] << 8));
 	gma_write16(hw, port, reg+8,(u16) addr[4] | ((u16) addr[5] << 8));
 }
-
-/* PCI config space access */
-static inline u32 sky2_pci_read32(const struct sky2_hw *hw, unsigned reg)
-{
-	return sky2_read32(hw, Y2_CFG_SPC + reg);
-}
-
-static inline u16 sky2_pci_read16(const struct sky2_hw *hw, unsigned reg)
-{
-	return sky2_read16(hw, Y2_CFG_SPC + reg);
-}
-
-static inline void sky2_pci_write32(struct sky2_hw *hw, unsigned reg, u32 val)
-{
-	sky2_write32(hw, Y2_CFG_SPC + reg, val);
-}
-
-static inline void sky2_pci_write16(struct sky2_hw *hw, unsigned reg, u16 val)
-{
-	sky2_write16(hw, Y2_CFG_SPC + reg, val);
-}
 #endif

-- 
http://www.hailfinger.org/


