Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVB1UQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVB1UQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVB1UQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:16:07 -0500
Received: from gprs214-130.eurotel.cz ([160.218.214.130]:45211 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261735AbVB1UPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:15:49 -0500
Date: Mon, 28 Feb 2005 21:15:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Fix few remaining u32 vs. pm_message_t issues
Message-ID: <20050228201536.GA12861@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

-mm is pretty good in u32 vs. pm_message_t area, there are only few
-places missing. Some of them are in usb (and already on their way
-through greg), this should fix the rest. Only code change is
-pci_choose_state in savagefb. Please apply,
								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/drivers/base/power/runtime.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-mm/drivers/base/power/runtime.c	2005-02-28 21:05:15.000000000 +0100
@@ -16,7 +16,7 @@
 	if (!dev->power.power_state)
 		return;
 	if (!resume_device(dev))
-		dev->power.power_state = 0;
+		dev->power.power_state = PMSG_ON;
 }
 
 
--- clean-mm/drivers/base/power/sysfs.c	2004-08-15 19:14:55.000000000 +0200
+++ linux-mm/drivers/base/power/sysfs.c	2005-02-28 21:05:15.000000000 +0100
@@ -31,7 +31,7 @@
 
 static ssize_t state_store(struct device * dev, const char * buf, size_t n)
 {
-	u32 state;
+	pm_message_t state;
 	char * rest;
 	int error = 0;
 
Only in linux-mm/drivers/char: consolemap_deftbl.c
--- clean-mm/drivers/ide/ide-disk.c	2005-02-28 01:13:56.000000000 +0100
+++ linux-mm/drivers/ide/ide-disk.c	2005-02-28 21:05:15.000000000 +0100
@@ -1098,7 +1098,7 @@
 	}
 
 	printk("Shutdown: %s\n", drive->name);
-	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	dev->bus->suspend(dev, PMSG_SUSPEND);
 }
 
 /*
--- clean-mm/drivers/media/video/msp3400.c	2005-02-03 22:27:14.000000000 +0100
+++ linux-mm/drivers/media/video/msp3400.c	2005-02-28 21:05:15.000000000 +0100
@@ -1422,7 +1422,7 @@
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
-static int msp_suspend(struct device * dev, u32 state, u32 level);
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level);
 static int msp_resume(struct device * dev, u32 level);
 
 static void msp_wake_thread(struct i2c_client *client);
@@ -1830,7 +1830,7 @@
 	return 0;
 }
 
-static int msp_suspend(struct device * dev, u32 state, u32 level)
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
--- clean-mm/drivers/pci/pci.c	2005-02-28 01:13:58.000000000 +0100
+++ linux-mm/drivers/pci/pci.c	2005-02-28 21:05:55.000000000 +0100
@@ -312,13 +312,14 @@
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system
+ * @state: target sleep state for the whole system. This is the value
+ *	that is passed to suspend() function.
  *
  * Returns PCI power state suitable for given device and given system
  * message.
  */
 
-pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
--- clean-mm/drivers/video/i810/i810_main.c	2005-02-28 01:14:02.000000000 +0100
+++ linux-mm/drivers/video/i810/i810_main.c	2005-02-28 21:05:15.000000000 +0100
@@ -1492,7 +1492,7 @@
 /***********************************************************************
  *                         Power Management                            *
  ***********************************************************************/
-static int i810fb_suspend(struct pci_dev *dev, u32 state)
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
--- clean-mm/drivers/video/savage/savagefb.c	2005-02-28 01:14:02.000000000 +0100
+++ linux-mm/drivers/video/savage/savagefb.c	2005-02-28 21:05:15.000000000 +0100
@@ -2100,7 +2100,7 @@
 	}
 }
 
-static int savagefb_suspend (struct pci_dev* dev, u32 state)
+static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
 {
 	struct fb_info *info =
 		(struct fb_info *)pci_get_drvdata(dev);
@@ -2115,7 +2115,7 @@
 	release_console_sem();
 
 	pci_disable_device(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
