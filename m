Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVGNAtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVGNAtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVGNAq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:46:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54443 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262860AbVGNAqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:46:06 -0400
Date: Thu, 14 Jul 2005 02:45:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 02/04] swsusp: fix remaining u32 vs. pm_message_t confusion
Message-ID: <20050714004545.GB7836@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix remaining bits of u32 vs. pm_message confusion. Should not break
anything.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 9f2554eb9485d7e7a749515dfc4834c86d4e0010
tree 198c4de638e15842c5713ff67eecf272f348232d
parent 1e279dd855d15b72364b4103f872d67d8592647e
author <pavel@amd.(none)> Thu, 14 Jul 2005 00:59:22 +0200
committer <pavel@amd.(none)> Thu, 14 Jul 2005 00:59:22 +0200

 arch/i386/kernel/cpu/mtrr/main.c              |    2 +-
 arch/ppc/platforms/pmac_pic.c                 |    2 +-
 arch/ppc/syslib/open_pic.c                    |    2 +-
 drivers/ide/ppc/pmac.c                        |    8 ++++----
 drivers/macintosh/mediabay.c                  |    2 +-
 drivers/media/video/bttv-driver.c             |    1 -
 drivers/media/video/msp3400.c                 |    4 ++--
 drivers/media/video/tda9887.c                 |    2 +-
 drivers/media/video/tuner-core.c              |    2 +-
 drivers/net/bnx2.c                            |   18 +++++++++---------
 drivers/net/e1000/e1000_main.c                |   16 +++++++---------
 drivers/net/irda/vlsi_ir.c                    |   11 +++--------
 drivers/net/wireless/orinoco_pci.c            |    2 --
 drivers/net/wireless/prism54/islpci_hotplug.c |    2 --
 drivers/video/s1d13xxxfb.c                    |    2 +-
 drivers/video/savage/savagefb_driver.c        |    1 -
 sound/pci/atiixp.c                            |    4 ++--
 17 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/arch/i386/kernel/cpu/mtrr/main.c b/arch/i386/kernel/cpu/mtrr/main.c
--- a/arch/i386/kernel/cpu/mtrr/main.c
+++ b/arch/i386/kernel/cpu/mtrr/main.c
@@ -561,7 +561,7 @@ struct mtrr_value {
 
 static struct mtrr_value * mtrr_state;
 
-static int mtrr_save(struct sys_device * sysdev, u32 state)
+static int mtrr_save(struct sys_device * sysdev, pm_message_t state)
 {
 	int i;
 	int size = num_var_ranges * sizeof(struct mtrr_value);
diff --git a/arch/ppc/platforms/pmac_pic.c b/arch/ppc/platforms/pmac_pic.c
--- a/arch/ppc/platforms/pmac_pic.c
+++ b/arch/ppc/platforms/pmac_pic.c
@@ -619,7 +619,7 @@ not_found:
 	return viaint;
 }
 
-static int pmacpic_suspend(struct sys_device *sysdev, u32 state)
+static int pmacpic_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	int viaint = pmacpic_find_viaint();
 
diff --git a/arch/ppc/syslib/open_pic.c b/arch/ppc/syslib/open_pic.c
--- a/arch/ppc/syslib/open_pic.c
+++ b/arch/ppc/syslib/open_pic.c
@@ -948,7 +948,7 @@ static void openpic_cached_disable_irq(u
  * we need something better to deal with that... Maybe switch to S1 for
  * cpufreq changes
  */
-int openpic_suspend(struct sys_device *sysdev, u32 state)
+int openpic_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	int	i;
 	unsigned long flags;
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1504,7 +1504,7 @@ pmac_ide_macio_attach(struct macio_dev *
 }
 
 static int
-pmac_ide_macio_suspend(struct macio_dev *mdev, u32 state)
+pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
@@ -1527,7 +1527,7 @@ pmac_ide_macio_resume(struct macio_dev *
 	if (mdev->ofdev.dev.power.power_state != 0) {
 		rc = pmac_ide_do_resume(hwif);
 		if (rc == 0)
-			mdev->ofdev.dev.power.power_state = 0;
+			mdev->ofdev.dev.power.power_state = PMSG_ON;
 	}
 
 	return rc;
@@ -1608,7 +1608,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 }
 
 static int
-pmac_ide_pci_suspend(struct pci_dev *pdev, u32 state)
+pmac_ide_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
@@ -1631,7 +1631,7 @@ pmac_ide_pci_resume(struct pci_dev *pdev
 	if (pdev->dev.power.power_state != 0) {
 		rc = pmac_ide_do_resume(hwif);
 		if (rc == 0)
-			pdev->dev.power.power_state = 0;
+			pdev->dev.power.power_state = PMSG_ON;
 	}
 
 	return rc;
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -724,7 +724,7 @@ static int __pmac media_bay_resume(struc
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
 	if (mdev->ofdev.dev.power.power_state != 0) {
-		mdev->ofdev.dev.power.power_state = 0;
+		mdev->ofdev.dev.power.power_state = PMSG_ON;
 
 	       	/* We re-enable the bay using it's previous content
 	       	   only if it did not change. Note those bozo timings,
diff --git a/drivers/media/video/bttv-driver.c b/drivers/media/video/bttv-driver.c
--- a/drivers/media/video/bttv-driver.c
+++ b/drivers/media/video/bttv-driver.c
@@ -4032,7 +4032,6 @@ static int bttv_suspend(struct pci_dev *
 	struct bttv_buffer_set idle;
 	unsigned long flags;
 
-	dprintk("bttv%d: suspend %d\n", btv->c.nr, state);
 
 	/* stop dma + irqs */
 	spin_lock_irqsave(&btv->s_lock,flags);
diff --git a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c
+++ b/drivers/media/video/msp3400.c
@@ -1418,7 +1418,7 @@ static int msp_detach(struct i2c_client 
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
-static int msp_suspend(struct device * dev, u32 state, u32 level);
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level);
 static int msp_resume(struct device * dev, u32 level);
 
 static void msp_wake_thread(struct i2c_client *client);
@@ -1819,7 +1819,7 @@ static int msp_command(struct i2c_client
 	return 0;
 }
 
-static int msp_suspend(struct device * dev, u32 state, u32 level)
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -760,7 +760,7 @@ tda9887_command(struct i2c_client *clien
 	return 0;
 }
 
-static int tda9887_suspend(struct device * dev, u32 state, u32 level)
+static int tda9887_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	dprintk("tda9887: suspend\n");
 	return 0;
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -638,7 +638,7 @@ static int tuner_command(struct i2c_clie
 	return 0;
 }
 
-static int tuner_suspend(struct device *dev, u32 state, u32 level)
+static int tuner_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of (dev, struct i2c_client, dev);
 	struct tuner *t = i2c_get_clientdata (c);
diff --git a/drivers/net/bnx2.c b/drivers/net/bnx2.c
--- a/drivers/net/bnx2.c
+++ b/drivers/net/bnx2.c
@@ -1998,14 +1998,14 @@ bnx2_init_cpus(struct bnx2 *bp)
 }
 
 static int
-bnx2_set_power_state(struct bnx2 *bp, int state)
+bnx2_set_power_state(struct bnx2 *bp, pci_power_t state)
 {
 	u16 pmcsr;
 
 	pci_read_config_word(bp->pdev, bp->pm_cap + PCI_PM_CTRL, &pmcsr);
 
 	switch (state) {
-	case 0: {
+	case PCI_D0: {
 		u32 val;
 
 		pci_write_config_word(bp->pdev, bp->pm_cap + PCI_PM_CTRL,
@@ -2026,7 +2026,7 @@ bnx2_set_power_state(struct bnx2 *bp, in
 		REG_WR(bp, BNX2_RPM_CONFIG, val);
 		break;
 	}
-	case 3: {
+	case PCI_D3hot: {
 		int i;
 		u32 val, wol_msg;
 
@@ -3877,7 +3877,7 @@ bnx2_open(struct net_device *dev)
 	struct bnx2 *bp = dev->priv;
 	int rc;
 
-	bnx2_set_power_state(bp, 0);
+	bnx2_set_power_state(bp, PCI_D0);
 	bnx2_disable_int(bp);
 
 	rc = bnx2_alloc_mem(bp);
@@ -4190,7 +4190,7 @@ bnx2_close(struct net_device *dev)
 	bnx2_free_mem(bp);
 	bp->link_up = 0;
 	netif_carrier_off(bp->dev);
-	bnx2_set_power_state(bp, 3);
+	bnx2_set_power_state(bp, PCI_D3hot);
 	return 0;
 }
 
@@ -5192,7 +5192,7 @@ bnx2_init_board(struct pci_dev *pdev, st
 			       BNX2_PCICFG_MISC_CONFIG_REG_WINDOW_ENA |
 			       BNX2_PCICFG_MISC_CONFIG_TARGET_MB_WORD_SWAP);
 
-	bnx2_set_power_state(bp, 0);
+	bnx2_set_power_state(bp, PCI_D0);
 
 	bp->chip_id = REG_RD(bp, BNX2_MISC_ID);
 
@@ -5466,7 +5466,7 @@ bnx2_remove_one(struct pci_dev *pdev)
 }
 
 static int
-bnx2_suspend(struct pci_dev *pdev, u32 state)
+bnx2_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct bnx2 *bp = dev->priv;
@@ -5484,7 +5484,7 @@ bnx2_suspend(struct pci_dev *pdev, u32 s
 		reset_code = BNX2_DRV_MSG_CODE_SUSPEND_NO_WOL;
 	bnx2_reset_chip(bp, reset_code);
 	bnx2_free_skbs(bp);
-	bnx2_set_power_state(bp, state);
+	bnx2_set_power_state(bp, pci_choose_state(pdev, state));
 	return 0;
 }
 
@@ -5497,7 +5497,7 @@ bnx2_resume(struct pci_dev *pdev)
 	if (!netif_running(dev))
 		return 0;
 
-	bnx2_set_power_state(bp, 0);
+	bnx2_set_power_state(bp, PCI_D0);
 	netif_device_attach(dev);
 	bnx2_init_nic(bp);
 	bnx2_netif_start(bp);
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -163,7 +163,7 @@ static void e1000_vlan_rx_kill_vid(struc
 static void e1000_restore_vlan(struct e1000_adapter *adapter);
 
 static int e1000_notify_reboot(struct notifier_block *, unsigned long event, void *ptr);
-static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
+static int e1000_suspend(struct pci_dev *pdev, pm_message_t state);
 #ifdef CONFIG_PM
 static int e1000_resume(struct pci_dev *pdev);
 #endif
@@ -3662,14 +3662,14 @@ e1000_notify_reboot(struct notifier_bloc
 	case SYS_POWER_OFF:
 		while((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev))) {
 			if(pci_dev_driver(pdev) == &e1000_driver)
-				e1000_suspend(pdev, 3);
+				e1000_suspend(pdev, PMSG_SUSPEND);
 		}
 	}
 	return NOTIFY_DONE;
 }
 
 static int
-e1000_suspend(struct pci_dev *pdev, uint32_t state)
+e1000_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
@@ -3753,9 +3753,7 @@ e1000_suspend(struct pci_dev *pdev, uint
 	}
 
 	pci_disable_device(pdev);
-
-	state = (state > 0) ? 3 : 0;
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
@@ -3768,13 +3766,13 @@ e1000_resume(struct pci_dev *pdev)
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	uint32_t manc, ret_val, swsm;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	ret_val = pci_enable_device(pdev);
 	pci_set_master(pdev);
 
-	pci_enable_wake(pdev, 3, 0);
-	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
+	pci_enable_wake(pdev, PCI_D3hot, 0);
+	pci_enable_wake(pdev, PCI_D3cold, 0);
 
 	e1000_reset(adapter);
 	E1000_WRITE_REG(&adapter->hw, WUS, ~0);
diff --git a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
--- a/drivers/net/irda/vlsi_ir.c
+++ b/drivers/net/irda/vlsi_ir.c
@@ -1749,11 +1749,6 @@ static int vlsi_irda_suspend(struct pci_
 	struct net_device *ndev = pci_get_drvdata(pdev);
 	vlsi_irda_dev_t *idev;
 
-	if (state < 1 || state > 3 ) {
-		IRDA_ERROR("%s - %s: invalid pm state request: %u\n",
-			   __FUNCTION__, PCIDEV_NAME(pdev), state);
-		return 0;
-	}
 	if (!ndev) {
 		IRDA_ERROR("%s - %s: no netdevice \n",
 			   __FUNCTION__, PCIDEV_NAME(pdev));
@@ -1781,7 +1776,7 @@ static int vlsi_irda_suspend(struct pci_
 			idev->new_baud = idev->baud;
 	}
 
-	pci_set_power_state(pdev,state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	pdev->current_state = state;
 	idev->resume_ok = 1;
 	up(&idev->sem);
@@ -1807,8 +1802,8 @@ static int vlsi_irda_resume(struct pci_d
 		return 0;
 	}
 	
-	pci_set_power_state(pdev, 0);
-	pdev->current_state = 0;
+	pci_set_power_state(pdev, PCI_D0);
+	pdev->current_state = PM_EVENT_ON;
 
 	if (!idev->resume_ok) {
 		/* should be obsolete now - but used to happen due to:
diff --git a/drivers/net/wireless/orinoco_pci.c b/drivers/net/wireless/orinoco_pci.c
--- a/drivers/net/wireless/orinoco_pci.c
+++ b/drivers/net/wireless/orinoco_pci.c
@@ -301,8 +301,6 @@ static int orinoco_pci_suspend(struct pc
 	unsigned long flags;
 	int err;
 	
-	printk(KERN_DEBUG "%s: Orinoco-PCI entering sleep mode (state=%d)\n",
-	       dev->name, state);
 
 	err = orinoco_lock(priv, &flags);
 	if (err) {
diff --git a/drivers/net/wireless/prism54/islpci_hotplug.c b/drivers/net/wireless/prism54/islpci_hotplug.c
--- a/drivers/net/wireless/prism54/islpci_hotplug.c
+++ b/drivers/net/wireless/prism54/islpci_hotplug.c
@@ -267,8 +267,6 @@ prism54_suspend(struct pci_dev *pdev, pm
 	islpci_private *priv = ndev ? netdev_priv(ndev) : NULL;
 	BUG_ON(!priv);
 
-	printk(KERN_NOTICE "%s: got suspend request (state %d)\n",
-	       ndev->name, state);
 
 	pci_save_state(pdev);
 
diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -655,7 +655,7 @@ bail:
 }
 
 #ifdef CONFIG_PM
-static int s1d13xxxfb_suspend(struct device *dev, u32 state, u32 level)
+static int s1d13xxxfb_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct s1d13xxxfb_par *s1dfb = info->par;
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2110,7 +2110,6 @@ static int savagefb_suspend (struct pci_
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
 
 	DBG("savagefb_suspend");
-	printk(KERN_DEBUG "state: %u\n", state);
 
 	acquire_console_sem();
 	fb_set_suspend(info, pci_choose_state(dev, state));
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1419,7 +1419,7 @@ static int snd_atiixp_suspend(snd_card_t
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1430,7 +1430,7 @@ static int snd_atiixp_resume(snd_card_t 
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);

-- 
teflon -- maybe it is a trademark, but it should not be.
