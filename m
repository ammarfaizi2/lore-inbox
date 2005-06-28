Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVF1UPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVF1UPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVF1UPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:15:05 -0400
Received: from [141.211.252.224] ([141.211.252.224]:11720 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261344AbVF1ULu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:11:50 -0400
Date: Tue, 28 Jun 2005 22:11:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] Fix few remaining u32 vs. pm_message_t problems
Message-ID: <20050628201131.GA30601@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix few remaining instances of u32 vs. pm_message_t confusion
discovered by make allyesconfig.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -386,7 +386,7 @@ static int sc1200_suspend (struct pci_de
 	/* You don't need to iterate over disks -- sysfs should have done that for you already */ 
 
 	pci_disable_device(dev);
-	pci_set_power_state(dev,state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 	dev->current_state = state;
 	return 0;
 }
@@ -396,7 +396,7 @@ static int sc1200_resume (struct pci_dev
 	ide_hwif_t	*hwif = NULL;
 
 printk("SC1200: resume\n");
-	pci_set_power_state(dev,0);	// bring chip back from sleep state
+	pci_set_power_state(dev, PCI_D0);	// bring chip back from sleep state
 	dev->current_state = 0;
 	pci_enable_device(dev);
 	//
diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1363,19 +1363,7 @@ mpt_suspend(struct pci_dev *pdev, pm_mes
 	u32 device_state;
 	MPT_ADAPTER *ioc = pci_get_drvdata(pdev);
 
-	switch(state)
-	{
-		case 1: /* S1 */
-			device_state=1; /* D1 */;
-			break;
-		case 3: /* S3 */
-		case 4: /* S4 */
-			device_state=3; /* D3 */;
-			break;
-		default:
-			return -EAGAIN /*FIXME*/;
-			break;
-	}
+	device_state=pci_choose_state(pdev, state);
 
 	printk(MYIOC_s_INFO_FMT
 	"pci-suspend: pdev=0x%p, slot=%s, Entering operating state [D%d]\n",
diff --git a/drivers/message/fusion/mptscsih.h b/drivers/message/fusion/mptscsih.h
--- a/drivers/message/fusion/mptscsih.h
+++ b/drivers/message/fusion/mptscsih.h
@@ -84,7 +84,7 @@
 extern void mptscsih_remove(struct pci_dev *);
 extern void mptscsih_shutdown(struct device *);
 #ifdef CONFIG_PM
-extern int mptscsih_suspend(struct pci_dev *pdev, u32 state);
+extern int mptscsih_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int mptscsih_resume(struct pci_dev *pdev);
 #endif
 extern int mptscsih_proc_info(struct Scsi_Host *host, char *buffer, char **start, off_t offset, int length, int func);
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
@@ -1763,7 +1758,7 @@ static int vlsi_irda_suspend(struct pci_
 	down(&idev->sem);
 	if (pdev->current_state != 0) {			/* already suspended */
 		if (state > pdev->current_state) {	/* simply go deeper */
-			pci_set_power_state(pdev,state);
+			pci_set_power_state(pdev, pci_choose_state(pdev, state));
 			pdev->current_state = state;
 		}
 		else
@@ -1781,7 +1776,7 @@ static int vlsi_irda_suspend(struct pci_
 			idev->new_baud = idev->baud;
 	}
 
-	pci_set_power_state(pdev,state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	pdev->current_state = state;
 	idev->resume_ok = 1;
 	up(&idev->sem);
@@ -1807,7 +1802,7 @@ static int vlsi_irda_resume(struct pci_d
 		return 0;
 	}
 	
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pdev->current_state = 0;
 
 	if (!idev->resume_ok) {
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -3311,7 +3311,7 @@ static void __devexit skge_remove(struct
 }
 
 #ifdef CONFIG_PM
-static int skge_suspend(struct pci_dev *pdev, u32 state)
+static int skge_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct skge_hw *hw  = pci_get_drvdata(pdev);
 	int i, wol = 0;
@@ -3331,7 +3331,7 @@ static int skge_suspend(struct pci_dev *
 	}
 
 	pci_save_state(pdev);
-	pci_enable_wake(pdev, state, wol);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), wol);
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
diff --git a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c
+++ b/drivers/net/typhoon.c
@@ -1906,9 +1906,9 @@ typhoon_sleep(struct typhoon *tp, pci_po
 	 */
 	netif_carrier_off(tp->dev);
 
-	pci_enable_wake(tp->pdev, pci_choose_state(pdev, state), 1);
+	pci_enable_wake(tp->pdev, state, 1);
 	pci_disable_device(pdev);
-	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	return pci_set_power_state(pdev, state);
 }
 
 static int
@@ -2274,7 +2274,7 @@ typhoon_suspend(struct pci_dev *pdev, pm
 		goto need_resume;
 	}
 
-	if(typhoon_sleep(tp, state, tp->wol_events) < 0) {
+	if(typhoon_sleep(tp, pci_choose_state(pdev, state), tp->wol_events) < 0) {
 		printk(KERN_ERR "%s: unable to put card to sleep\n", dev->name);
 		goto need_resume;
 	}
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -317,7 +317,7 @@ int pcie_port_device_register(struct pci
 static int suspend_iter(struct device *dev, void *data)
 {
 	struct pcie_port_service_driver *service_driver;
-	u32 state = (u32)data;
+	pm_message_t state = * (pm_message_t *) data;
 
  	if ((dev->bus == &pcie_port_bus_type) &&
  	    (dev->driver)) {
@@ -328,9 +328,9 @@ static int suspend_iter(struct device *d
 	return 0;
 }
 
-int pcie_port_device_suspend(struct pci_dev *dev, u32 state)
+int pcie_port_device_suspend(struct pci_dev *dev, pm_message_t state)
 {
-	device_for_each_child(&dev->dev, (void *)state, suspend_iter);
+	device_for_each_child(&dev->dev, &state, suspend_iter);
 	return 0;
 }
 
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2113,7 +2113,7 @@ static int savagefb_suspend (struct pci_
 	printk(KERN_DEBUG "state: %u\n", state);
 
 	acquire_console_sem();
-	fb_set_suspend(info, state);
+	fb_set_suspend(info, pci_choose_state(dev, state));
 	savage_disable_mmio(par);
 	release_console_sem();
 
diff --git a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c
+++ b/sound/oss/cs46xx.c
@@ -4174,7 +4174,7 @@ static int cs_ioctl_mixdev(struct inode 
 				list_for_each(entry, &cs46xx_devs)
 				{
 					card = list_entry(entry, struct cs_card, list);
-					cs46xx_suspend(card, 0);
+					cs46xx_suspend(card, PMSG_ON);
 				}
 
 			}
@@ -5749,7 +5749,7 @@ static int cs46xx_pm_callback(struct pm_
 			case PM_SUSPEND:
 				CS_DBGOUT(CS_PM, 2, printk(KERN_INFO
 					"cs46xx: PM suspend request\n"));
-				if(cs46xx_suspend(card, 0))
+				if(cs46xx_suspend(card, PMSG_SUSPEND))
 				{
 				    CS_DBGOUT(CS_ERROR, 2, printk(KERN_INFO
 					"cs46xx: PM suspend request refused\n"));
@@ -5779,7 +5779,7 @@ static int cs46xx_suspend_tbl(struct pci
 	struct cs_card *s = PCI_GET_DRIVER_DATA(pcidev);
 	CS_DBGOUT(CS_PM | CS_FUNCTION, 2, 
 		printk(KERN_INFO "cs46xx: cs46xx_suspend_tbl request\n"));
-	cs46xx_suspend(s, 0);
+	cs46xx_suspend(s, state);
 	return 0;
 }
 

