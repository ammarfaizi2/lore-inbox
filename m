Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVGCVDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVGCVDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 17:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVGCVDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 17:03:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52657 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261539AbVGCVB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 17:01:56 -0400
Date: Sun, 3 Jul 2005 22:32:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch] few more u32 vs. pm_message_t fixes
Message-ID: <20050703203232.GA24650@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few more u32 vs. pm_message_t fixes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit c404aafd79492185d7ef6cb23a88977caf652f88
tree 889eed06c38ffa9f4bc83e1092202f05c145d7c9
parent 4b632470fc69174a9732c19419be5d1fc2cdeb0e
author <pavel@amd.(none)> Sun, 03 Jul 2005 22:31:54 +0200
committer <pavel@amd.(none)> Sun, 03 Jul 2005 22:31:54 +0200

 drivers/message/fusion/mptbase.c       |   14 +-------------
 drivers/message/fusion/mptscsih.h      |    2 +-
 drivers/net/skge.c                     |    4 ++--
 drivers/net/typhoon.c                  |    6 +++---
 drivers/pci/pcie/portdrv_core.c        |    6 +++---
 drivers/video/savage/savagefb_driver.c |    2 +-
 sound/oss/cs46xx.c                     |    6 +++---
 7 files changed, 14 insertions(+), 26 deletions(-)

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
 extern void mptscsih_shutdown(struct pci_dev *);
 #ifdef CONFIG_PM
-extern int mptscsih_suspend(struct pci_dev *pdev, u32 state);
+extern int mptscsih_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int mptscsih_resume(struct pci_dev *pdev);
 #endif
 extern int mptscsih_proc_info(struct Scsi_Host *host, char *buffer, char **start, off_t offset, int length, int func);
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -3259,7 +3259,7 @@ static void __devexit skge_remove(struct
 }
 
 #ifdef CONFIG_PM
-static int skge_suspend(struct pci_dev *pdev, u32 state)
+static int skge_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct skge_hw *hw  = pci_get_drvdata(pdev);
 	int i, wol = 0;
@@ -3279,7 +3279,7 @@ static int skge_suspend(struct pci_dev *
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
 

-- 
teflon -- maybe it is a trademark, but it should not be.
