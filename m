Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750785AbWFEIgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWFEIgI (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWFEIfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:35:50 -0400
Received: from peabody.ximian.com ([130.57.169.10]:24974 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750786AbWFEIfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:35:42 -0400
Subject: [PATCH 5/9] PCI PM: remove PCI_D3cold, PCI_UNKNOWN, and
	PCI_POWER_ERROR
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:46:09 -0400
Message-Id: <1149497169.7831.159.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PCI_D3cold is not a software enter-able power state.  Rather, it's the
state a card enters when Vcc is removed.  Moreover, PCI power management
does not have any error reporting or failure states.  This patch removes
references to these features and limits drivers to the four power states
that can actually be entered directly through software: D0, D1, D2, and
D3.  D3cold support may be possible in the future if PCI bridge power
management is supported, but even so, there is no need to have drivers
explicitly request it.

Signed-off-by: Adam Belay <abelay@novell.com>

---
 arch/i386/pci/fixup.c                    |    2 -
 drivers/char/agp/via-agp.c               |    2 -
 drivers/net/3c59x.c                      |    2 -
 drivers/net/8139cp.c                     |    2 -
 drivers/net/8139too.c                    |    2 -
 drivers/net/amd8111e.c                   |   11 +++------
 drivers/net/bnx2.c                       |    4 +--
 drivers/net/e1000/e1000_main.c           |   21 +++---------------
 drivers/net/eepro100.c                   |    2 -
 drivers/net/pci-skeleton.c               |    2 -
 drivers/net/sis900.c                     |    2 -
 drivers/net/sky2.c                       |    7 ++----
 drivers/net/starfire.c                   |    2 -
 drivers/net/tg3.c                        |    6 ++---
 drivers/net/typhoon.c                    |    6 ++---
 drivers/net/via-velocity.c               |   12 +++++-----
 drivers/net/wireless/hostap/hostap_pci.c |    2 -
 drivers/net/wireless/ipw2100.c           |    2 -
 drivers/net/wireless/orinoco_pci.c       |    2 -
 drivers/pci/pm.c                         |   35 ++++++-------------------------
 drivers/scsi/libata-core.c               |    2 -
 drivers/usb/core/hcd-pci.c               |    7 ++----
 include/linux/pci.h                      |    5 ----
 sound/pci/als300.c                       |    2 -
 sound/pci/als4000.c                      |    2 -
 sound/pci/atiixp.c                       |    2 -
 sound/pci/atiixp_modem.c                 |    2 -
 sound/pci/cmipci.c                       |    2 -
 sound/pci/emu10k1/emu10k1.c              |    2 -
 sound/pci/ens1370.c                      |    2 -
 sound/pci/fm801.c                        |    2 -
 sound/pci/riptide/riptide.c              |    2 -
 sound/pci/via82xx.c                      |    2 -
 sound/pci/via82xx_modem.c                |    2 -
 sound/pci/vx222/vx222.c                  |    2 -
 35 files changed, 61 insertions(+), 103 deletions(-)

diff -urN a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2006-06-04 01:38:34.000000000 -0400
+++ b/arch/i386/pci/fixup.c	2006-06-03 17:04:57.000000000 -0400
@@ -428,7 +428,7 @@
 	if (!dmi_check_system(toshiba_ohci1394_dmi_table))
 		return; /* only applies to certain Toshibas (so far) */
 
-	dev->current_state = PCI_D3cold;
+	dev->current_state = PCI_D3;
 	pci_read_config_word(dev, PCI_CACHE_LINE_SIZE, &toshiba_line_size);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0x8032,
diff -urN a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
--- a/drivers/char/agp/via-agp.c	2006-06-04 01:38:34.000000000 -0400
+++ b/drivers/char/agp/via-agp.c	2006-06-03 17:08:31.000000000 -0400
@@ -456,7 +456,7 @@
 static int agp_via_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state (pdev);
-	pci_set_power_state (pdev, PCI_D3hot);
+	pci_set_power_state (pdev, PCI_D3);
 
 	return 0;
 }
diff -urN a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	2006-06-04 01:38:34.000000000 -0400
+++ b/drivers/net/3c59x.c	2006-06-03 18:27:52.000000000 -0400
@@ -3275,7 +3275,7 @@
 		pci_enable_wake(VORTEX_PCI(vp), 0, 1);
 
 		/* Change the power state to D3; RxEnable doesn't take effect. */
-		pci_set_power_state(VORTEX_PCI(vp), PCI_D3hot);
+		pci_set_power_state(VORTEX_PCI(vp), PCI_D3);
 	}
 }
 
diff -urN a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c	2006-06-04 01:38:34.000000000 -0400
+++ b/drivers/net/8139cp.c	2006-06-03 17:09:44.000000000 -0400
@@ -1659,7 +1659,7 @@
 static void cp_set_d3_state (struct cp_private *cp)
 {
 	pci_enable_wake (cp->pdev, 0, 1); /* Enable PME# generation */
-	pci_set_power_state (cp->pdev, PCI_D3hot);
+	pci_set_power_state (cp->pdev, PCI_D3);
 }
 
 static int cp_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
diff -urN a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	2006-06-04 01:38:34.000000000 -0400
+++ b/drivers/net/8139too.c	2006-06-03 17:10:11.000000000 -0400
@@ -2583,7 +2583,7 @@
 
 	spin_unlock_irqrestore (&tp->lock, flags);
 
-	pci_set_power_state (pdev, PCI_D3hot);
+	pci_set_power_state (pdev, PCI_D3);
 
 	return 0;
 }
diff -urN a/drivers/net/amd8111e.c b/drivers/net/amd8111e.c
--- a/drivers/net/amd8111e.c	2006-06-04 01:38:34.000000000 -0400
+++ b/drivers/net/amd8111e.c	2006-06-03 17:11:07.000000000 -0400
@@ -1834,17 +1834,15 @@
 		if(lp->options & OPTION_WAKE_PHY_ENABLE)
 			amd8111e_enable_link_change(lp);	
 		
-		pci_enable_wake(pci_dev, PCI_D3hot, 1);
-		pci_enable_wake(pci_dev, PCI_D3cold, 1);
+		pci_enable_wake(pci_dev, PCI_D3, 1);
 
 	}
 	else{		
-		pci_enable_wake(pci_dev, PCI_D3hot, 0);
-		pci_enable_wake(pci_dev, PCI_D3cold, 0);
+		pci_enable_wake(pci_dev, PCI_D3, 0);
 	}
 	
 	pci_save_state(pci_dev);
-	pci_set_power_state(pci_dev, PCI_D3hot);
+	pci_set_power_state(pci_dev, PCI_D3);
 
 	return 0;
 }
@@ -1859,8 +1857,7 @@
 	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
-	pci_enable_wake(pci_dev, PCI_D3hot, 0);
-	pci_enable_wake(pci_dev, PCI_D3cold, 0); /* D3 cold */
+	pci_enable_wake(pci_dev, PCI_D3, 0);
 
 	netif_device_attach(dev);
 
diff -urN a/drivers/net/bnx2.c b/drivers/net/bnx2.c
--- a/drivers/net/bnx2.c	2006-06-04 01:38:34.000000000 -0400
+++ b/drivers/net/bnx2.c	2006-06-03 17:13:34.000000000 -0400
@@ -2415,7 +2415,7 @@
 		REG_WR(bp, BNX2_RPM_CONFIG, val);
 		break;
 	}
-	case PCI_D3hot: {
+	case PCI_D3: {
 		int i;
 		u32 val, wol_msg;
 
@@ -4418,7 +4418,7 @@
 	bnx2_free_mem(bp);
 	bp->link_up = 0;
 	netif_carrier_off(bp->dev);
-	bnx2_set_power_state(bp, PCI_D3hot);
+	bnx2_set_power_state(bp, PCI_D3);
 	return 0;
 }
 
diff -urN a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	2006-06-04 01:38:34.000000000 -0400
+++ b/drivers/net/e1000/e1000_main.c	2006-06-03 17:15:42.000000000 -0400
@@ -4516,21 +4516,15 @@
 
 		E1000_WRITE_REG(&adapter->hw, WUC, E1000_WUC_PME_EN);
 		E1000_WRITE_REG(&adapter->hw, WUFC, wufc);
-		retval = pci_enable_wake(pdev, PCI_D3hot, 1);
+		retval = pci_enable_wake(pdev, PCI_D3, 1);
 		if (retval)
 			DPRINTK(PROBE, ERR, "Error enabling D3 wake\n");
-		retval = pci_enable_wake(pdev, PCI_D3cold, 1);
-		if (retval)
-			DPRINTK(PROBE, ERR, "Error enabling D3 cold wake\n");
 	} else {
 		E1000_WRITE_REG(&adapter->hw, WUC, 0);
 		E1000_WRITE_REG(&adapter->hw, WUFC, 0);
-		retval = pci_enable_wake(pdev, PCI_D3hot, 0);
+		retval = pci_enable_wake(pdev, PCI_D3, 0);
 		if (retval)
 			DPRINTK(PROBE, ERR, "Error enabling D3 wake\n");
-		retval = pci_enable_wake(pdev, PCI_D3cold, 0);
-		if (retval)
-			DPRINTK(PROBE, ERR, "Error enabling D3 cold wake\n");
 	}
 
 	if (adapter->hw.mac_type >= e1000_82540 &&
@@ -4539,13 +4533,9 @@
 		if (manc & E1000_MANC_SMBUS_EN) {
 			manc |= E1000_MANC_ARP_EN;
 			E1000_WRITE_REG(&adapter->hw, MANC, manc);
-			retval = pci_enable_wake(pdev, PCI_D3hot, 1);
+			retval = pci_enable_wake(pdev, PCI_D3, 1);
 			if (retval)
 				DPRINTK(PROBE, ERR, "Error enabling D3 wake\n");
-			retval = pci_enable_wake(pdev, PCI_D3cold, 1);
-			if (retval)
-				DPRINTK(PROBE, ERR,
-				        "Error enabling D3 cold wake\n");
 		}
 	}
 
@@ -4578,12 +4568,9 @@
 	ret_val = pci_enable_device(pdev);
 	pci_set_master(pdev);
 
-	retval = pci_enable_wake(pdev, PCI_D3hot, 0);
+	retval = pci_enable_wake(pdev, PCI_D3, 0);
 	if (retval)
 		DPRINTK(PROBE, ERR, "Error enabling D3 wake\n");
-	retval = pci_enable_wake(pdev, PCI_D3cold, 0);
-	if (retval)
-		DPRINTK(PROBE, ERR, "Error enabling D3 cold wake\n");
 
 	e1000_reset(adapter);
 	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
diff -urN a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	2006-06-04 01:38:34.000000000 -0400
+++ b/drivers/net/eepro100.c	2006-06-03 17:16:44.000000000 -0400
@@ -2289,7 +2289,7 @@
 	
 	/* XXX call pci_set_power_state ()? */
 	pci_disable_device(pdev);
-	pci_set_power_state (pdev, PCI_D3hot);
+	pci_set_power_state (pdev, PCI_D3);
 	return 0;
 }
 
diff -urN a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
--- a/drivers/net/pci-skeleton.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/pci-skeleton.c	2006-06-03 17:18:20.000000000 -0400
@@ -1921,7 +1921,7 @@
 	spin_unlock_irqrestore (&tp->lock, flags);
 
 	pci_save_state (pdev);
-	pci_set_power_state (pdev, PCI_D3hot);
+	pci_set_power_state (pdev, PCI_D3);
 
 	return 0;
 }
diff -urN a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/sis900.c	2006-06-03 17:18:48.000000000 -0400
@@ -2422,7 +2422,7 @@
 	/* Stop the chip's Tx and Rx Status Machine */
 	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
 
-	pci_set_power_state(pci_dev, PCI_D3hot);
+	pci_set_power_state(pci_dev, PCI_D3);
 	pci_save_state(pci_dev);
 
 	return 0;
diff -urN a/drivers/net/sky2.c b/drivers/net/sky2.c
--- a/drivers/net/sky2.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/sky2.c	2006-06-03 17:53:35.000000000 -0400
@@ -248,8 +248,7 @@
 
 		break;
 
-	case PCI_D3hot:
-	case PCI_D3cold:
+	case PCI_D3:
 		/* Turn on phy power saving */
 		reg1 = sky2_pci_read32(hw, PCI_DEV_REG1);
 		if (hw->chip_id == CHIP_ID_YUKON_XL && hw->chip_rev > 1)
@@ -268,7 +267,7 @@
 				    Y2_COR_CLK_LNK2_DIS | Y2_CLK_GAT_LNK2_DIS);
 
 		/* switch power to VAUX */
-		if (vaux && state != PCI_D3cold)
+		if (vaux)
 			sky2_write8(hw, B0_POWER_CTRL,
 				    (PC_VAUX_ENA | PC_VCC_ENA |
 				     PC_VAUX_ON | PC_VCC_OFF));
@@ -3400,7 +3399,7 @@
 		unregister_netdev(dev1);
 	unregister_netdev(dev0);
 
-	sky2_set_power_state(hw, PCI_D3hot);
+	sky2_set_power_state(hw, PCI_D3);
 	sky2_write16(hw, B0_Y2LED, LED_STAT_OFF);
 	sky2_write8(hw, B0_CTST, CS_RST_SET);
 	sky2_read8(hw, B0_CTST);
diff -urN a/drivers/net/starfire.c b/drivers/net/starfire.c
--- a/drivers/net/starfire.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/starfire.c	2006-06-03 18:52:57.000000000 -0400
@@ -2131,7 +2131,7 @@
 
 
 	/* XXX: add wakeup code -- requires firmware for MagicPacket */
-	pci_set_power_state(pdev, PCI_D3hot);	/* go to sleep in D3 mode */
+	pci_set_power_state(pdev, PCI_D3);	/* go to sleep in D3 mode */
 	pci_disable_device(pdev);
 
 	iounmap(np->base);
diff -urN a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/tg3.c	2006-06-03 17:56:13.000000000 -0400
@@ -1225,7 +1225,7 @@
 		power_control |= 2;
 		break;
 
-	case PCI_D3hot:
+	case PCI_D3:
 		power_control |= 3;
 		break;
 
@@ -7128,7 +7128,7 @@
 
 	tg3_free_consistent(tp);
 
-	tg3_set_power_state(tp, PCI_D3hot);
+	tg3_set_power_state(tp, PCI_D3);
 
 	netif_carrier_off(tp->dev);
 
@@ -8639,7 +8639,7 @@
 		tg3_full_unlock(tp);
 	}
 	if (tp->link_config.phy_is_low_power)
-		tg3_set_power_state(tp, PCI_D3hot);
+		tg3_set_power_state(tp, PCI_D3);
 
 }
 
diff -urN a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/typhoon.c	2006-06-03 18:06:40.000000000 -0400
@@ -2154,7 +2154,7 @@
 		goto out;
 	}
 
-	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0) 
+	if(typhoon_sleep(tp, PCI_D3, 0) < 0) 
 		printk(KERN_ERR "%s: unable to go back to sleep\n", dev->name);
 
 out:
@@ -2181,7 +2181,7 @@
 	if(typhoon_boot_3XP(tp, TYPHOON_STATUS_WAITING_FOR_HOST) < 0)
 		printk(KERN_ERR "%s: unable to boot sleep image\n", dev->name);
 
-	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0)
+	if(typhoon_sleep(tp, PCI_D3, 0) < 0)
 		printk(KERN_ERR "%s: unable to put card to sleep\n", dev->name);
 
 	return 0;
@@ -2531,7 +2531,7 @@
 	if(xp_resp[0].numDesc != 0)
 		tp->capabilities |= TYPHOON_WAKEUP_NEEDS_RESET;
 
-	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0) {
+	if(typhoon_sleep(tp, PCI_D3, 0) < 0) {
 		printk(ERR_PFX "%s: cannot put adapter to sleep\n",
 		       pci_name(pdev));
 		err = -EIO;
diff -urN a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
--- a/drivers/net/via-velocity.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/via-velocity.c	2006-06-03 18:08:16.000000000 -0400
@@ -803,7 +803,7 @@
 	
 	/* and leave the chip powered down */
 	
-	pci_set_power_state(pdev, PCI_D3hot);
+	pci_set_power_state(pdev, PCI_D3);
 #ifdef CONFIG_PM
 	{
 		unsigned long flags;
@@ -1750,7 +1750,7 @@
 			  dev->name, dev);
 	if (ret < 0) {
 		/* Power down the chip */
-		pci_set_power_state(vptr->pdev, PCI_D3hot);
+		pci_set_power_state(vptr->pdev, PCI_D3);
 		goto err_free_td_ring;
 	}
 
@@ -1868,7 +1868,7 @@
 		free_irq(dev->irq, dev);
 		
 	/* Power down the chip */
-	pci_set_power_state(vptr->pdev, PCI_D3hot);
+	pci_set_power_state(vptr->pdev, PCI_D3);
 	
 	/* Free the resources */
 	velocity_free_td_ring(vptr);
@@ -2208,7 +2208,7 @@
 		ret = -EOPNOTSUPP;
 	}
 	if (!netif_running(dev))
-		pci_set_power_state(vptr->pdev, PCI_D3hot);
+		pci_set_power_state(vptr->pdev, PCI_D3);
 		
 		
 	return ret;
@@ -2835,7 +2835,7 @@
 {
 	struct velocity_info *vptr = dev->priv;
 	if (!netif_running(dev))
-		pci_set_power_state(vptr->pdev, PCI_D3hot);
+		pci_set_power_state(vptr->pdev, PCI_D3);
 }
 
 static int velocity_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
@@ -3230,7 +3230,7 @@
 		velocity_shutdown(vptr);
 		velocity_set_wol(vptr);
 		pci_enable_wake(pdev, 3, 1);
-		pci_set_power_state(pdev, PCI_D3hot);
+		pci_set_power_state(pdev, PCI_D3);
 	} else {
 		velocity_save_context(vptr, &vptr->context);
 		velocity_shutdown(vptr);
diff -urN a/drivers/net/wireless/hostap/hostap_pci.c b/drivers/net/wireless/hostap/hostap_pci.c
--- a/drivers/net/wireless/hostap/hostap_pci.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/wireless/hostap/hostap_pci.c	2006-06-03 18:09:06.000000000 -0400
@@ -418,7 +418,7 @@
 	prism2_suspend(dev);
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
+	pci_set_power_state(pdev, PCI_D3);
 
 	return 0;
 }
diff -urN a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
--- a/drivers/net/wireless/ipw2100.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/wireless/ipw2100.c	2006-06-03 18:10:12.000000000 -0400
@@ -6403,7 +6403,7 @@
 
 	pci_save_state(pci_dev);
 	pci_disable_device(pci_dev);
-	pci_set_power_state(pci_dev, PCI_D3hot);
+	pci_set_power_state(pci_dev, PCI_D3);
 
 	mutex_unlock(&priv->action_mutex);
 
diff -urN a/drivers/net/wireless/orinoco_pci.c b/drivers/net/wireless/orinoco_pci.c
--- a/drivers/net/wireless/orinoco_pci.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/net/wireless/orinoco_pci.c	2006-06-03 18:10:54.000000000 -0400
@@ -305,7 +305,7 @@
 	orinoco_unlock(priv, &flags);
 
 	pci_save_state(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
+	pci_set_power_state(pdev, PCI_D3);
 
 	return 0;
 }
diff -urN a/drivers/pci/pm.c b/drivers/pci/pm.c
--- a/drivers/pci/pm.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/pci/pm.c	2006-06-04 01:38:10.000000000 -0400
@@ -127,17 +127,12 @@
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int need_restore = 0;
 	u16 pmcsr;
 	struct pci_dev_pm *pm = dev->pm;
 
 	if (!pm)
 		return -EIO;
 
-	/* bound the state we're entering */
-	if (state > PCI_D3hot)
-		state = PCI_D3hot;
-
 	/* Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper 
 	 * to sleep if we're already in a low power state
@@ -168,11 +163,6 @@
 		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
 		pmcsr |= state;
 		break;
-	case PCI_UNKNOWN: /* Boot-up */
-		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
-		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
-			need_restore = 1;
-		/* Fall-through: force to D0 */
 	default:
 		pmcsr = 0;
 		break;
@@ -183,7 +173,7 @@
 
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */
-	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
+	if (state == PCI_D3 || dev->current_state == PCI_D3)
 		msleep(10);
 	else if (state == PCI_D2 || dev->current_state == PCI_D2)
 		udelay(200);
@@ -197,21 +187,6 @@
 
 	dev->current_state = state;
 
-	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
-	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
-	 * from D3hot to D0 _may_ perform an internal reset, thereby
-	 * going to "D0 Uninitialized" rather than "D0 Initialized".
-	 * For example, at least some versions of the 3c905B and the
-	 * 3c556B exhibit this behaviour.
-	 *
-	 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
-	 * devices in a D3hot state at boot.  Consequently, we need to
-	 * restore at least the BARs so that the device will be
-	 * accessible to its driver.
-	 */
-	if (need_restore)
-		pci_restore_bars(dev);
-
 	return 0;
 }
 
@@ -247,7 +222,7 @@
 		return PCI_D0;
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_SUSPEND:
-		return PCI_D3hot;
+		return PCI_D3;
 	default:
 		printk("They asked me for state %d\n", state.event);
 		BUG();
@@ -280,6 +255,7 @@
 {
 	u16 value;
 	struct pci_dev_pm *pm = dev->pm;
+	unsigned char pme_supported;
 
 	/* If device doesn't support PM Capabilities, but request is to disable
 	 * wake events, it's a nop; otherwise fail */
@@ -287,7 +263,10 @@
 		return enable ? -EIO : 0;
 
 	/* Check if it can generate PME# from requested state. */
-	if (!pm->pme_mask || !(pm->pme_mask & (1 << state)))
+	pme_supported = pm->pme_mask & (1 << state);
+	if (state == PCI_D3) /* also check for D3 cold */
+		pme_supported |= pm->pme_mask & PCI_PME_D3cold;
+	if (!pme_supported)
 		return enable ? -EINVAL : 0;
 
 	pci_read_config_word(dev, pm->pm_offset + PCI_PM_CTRL, &value);
diff -urN a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/scsi/libata-core.c	2006-06-03 18:30:13.000000000 -0400
@@ -4840,7 +4840,7 @@
 {
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
-	pci_set_power_state(pdev, PCI_D3hot);
+	pci_set_power_state(pdev, PCI_D3);
 	return 0;
 }
 
diff -urN a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
--- a/drivers/usb/core/hcd-pci.c	2006-06-04 01:38:35.000000000 -0400
+++ b/drivers/usb/core/hcd-pci.c	2006-06-03 18:12:57.000000000 -0400
@@ -260,7 +260,7 @@
 		 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
 		 * some device state (e.g. as part of clock reinit).
 		 */
-		retval = pci_set_power_state (dev, PCI_D3hot);
+		retval = pci_set_power_state (dev, PCI_D3);
 		suspend_report_result(pci_set_power_state, retval);
 		if (retval == 0) {
 			int wake = device_can_wakeup(&hcd->self.root_hub->dev);
@@ -274,8 +274,7 @@
 			 * reject requests the hardware can't implement, rather
 			 * than coding the same thing.
 			 */
-			(void) pci_enable_wake (dev, PCI_D3hot, wake);
-			(void) pci_enable_wake (dev, PCI_D3cold, wake);
+			(void) pci_enable_wake (dev, PCI_D3, wake);
 		} else {
 			dev_dbg (&dev->dev, "PCI D3 suspend fail, %d\n",
 					retval);
@@ -375,7 +374,7 @@
 #endif
 		/* yes, ignore these results too... */
 		(void) pci_enable_wake (dev, dev->current_state, 0);
-		(void) pci_enable_wake (dev, PCI_D3cold, 0);
+		(void) pci_enable_wake (dev, PCI_D3, 0);
 	} else {
 		/* Same basic cases: clean (powered/not), dirty */
 		dev_dbg(hcd->self.controller, "PCI legacy resume\n");
diff -urN a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2006-06-04 01:38:35.000000000 -0400
+++ b/include/linux/pci.h	2006-06-03 16:53:42.000000000 -0400
@@ -91,10 +91,7 @@
 #define PCI_D0		((pci_power_t __force) 0)
 #define PCI_D1		((pci_power_t __force) 1)
 #define PCI_D2		((pci_power_t __force) 2)
-#define PCI_D3hot	((pci_power_t __force) 3)
-#define PCI_D3cold	((pci_power_t __force) 4)
-#define PCI_UNKNOWN	((pci_power_t __force) 5)
-#define PCI_POWER_ERROR	((pci_power_t __force) -1)
+#define PCI_D3		((pci_power_t __force) 3)
 
 typedef int __bitwise pci_wake_t;
 
diff -urN a/sound/pci/als300.c b/sound/pci/als300.c
--- a/sound/pci/als300.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/als300.c	2006-06-03 18:23:55.000000000 -0400
@@ -770,7 +770,7 @@
 	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/als4000.c b/sound/pci/als4000.c
--- a/sound/pci/als4000.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/als4000.c	2006-06-03 18:13:42.000000000 -0400
@@ -804,7 +804,7 @@
 	snd_pcm_suspend_all(chip->pcm);
 	snd_sbmixer_suspend(chip);
 
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/atiixp.c b/sound/pci/atiixp.c
--- a/sound/pci/atiixp.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/atiixp.c	2006-06-03 18:16:02.000000000 -0400
@@ -1442,7 +1442,7 @@
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
--- a/sound/pci/atiixp_modem.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/atiixp_modem.c	2006-06-03 18:20:08.000000000 -0400
@@ -1128,7 +1128,7 @@
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/cmipci.c b/sound/pci/cmipci.c
--- a/sound/pci/cmipci.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/cmipci.c	2006-06-03 18:20:38.000000000 -0400
@@ -3120,7 +3120,7 @@
 	/* disable ints */
 	snd_cmipci_write(cm, CM_REG_INT_HLDCLR, 0);
 
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
--- a/sound/pci/emu10k1/emu10k1.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/emu10k1/emu10k1.c	2006-06-03 18:21:03.000000000 -0400
@@ -226,7 +226,7 @@
 
 	snd_emu10k1_done(emu);
 
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/ens1370.c b/sound/pci/ens1370.c
--- a/sound/pci/ens1370.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/ens1370.c	2006-06-03 18:21:30.000000000 -0400
@@ -2072,7 +2072,7 @@
 	udelay(100);
 	snd_ak4531_suspend(ensoniq->u.es1370.ak4531);
 #endif	
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/fm801.c b/sound/pci/fm801.c
--- a/sound/pci/fm801.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/fm801.c	2006-06-03 18:21:53.000000000 -0400
@@ -1501,7 +1501,7 @@
 		chip->saved_regs[i] = inw(chip->port + saved_regs[i]);
 	/* FIXME: tea575x suspend */
 
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
--- a/sound/pci/riptide/riptide.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/riptide/riptide.c	2006-06-03 18:24:14.000000000 -0400
@@ -1174,7 +1174,7 @@
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/via82xx.c	2006-06-03 18:22:13.000000000 -0400
@@ -2159,7 +2159,7 @@
 		chip->capture_src_saved[1] = inb(chip->port + VIA_REG_CAPTURE_CHANNEL + 0x10);
 	}
 
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
--- a/sound/pci/via82xx_modem.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/via82xx_modem.c	2006-06-03 18:22:26.000000000 -0400
@@ -1032,7 +1032,7 @@
 		snd_via82xx_channel_reset(chip, &chip->devs[i]);
 	synchronize_irq(chip->irq);
 	snd_ac97_suspend(chip->ac97);
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return 0;
diff -urN a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
--- a/sound/pci/vx222/vx222.c	2006-06-04 01:38:35.000000000 -0400
+++ b/sound/pci/vx222/vx222.c	2006-06-03 18:23:13.000000000 -0400
@@ -259,7 +259,7 @@
 	int err;
 
 	err = snd_vx_suspend(&vx->core, state);
-	pci_set_power_state(pci, PCI_D3hot);
+	pci_set_power_state(pci, PCI_D3);
 	pci_disable_device(pci);
 	pci_save_state(pci);
 	return err;


