Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVBNFot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVBNFot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 00:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVBNFot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 00:44:49 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:49347 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261343AbVBNFmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 00:42:15 -0500
Subject: PATCH: Address lots of pending pm_message_t changes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>, Bernard Blackham <bernard@blackham.com.au>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 14 Feb 2005 16:43:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch is a conglomeration of about 5 patches that complete (I
think!) the work of switching over to pm_message_t. Most of this work
was done by Bernard Blackham, some by me, some by Pavel I think (I was
out of action for part of the development). I believe it needs to go in
before 2.6.11 in order to avoid compilation warnings and errors. The
code has been in use by Suspend2 users for around three weeks. Please
apply.

Pavel and Bernard, can you review and give your signoff?

Regards,

Nigel

Signed-off by: Nigel Cunningham <ncunningham@cyclades.com>

diff -ruNp 940-combined-pm_message_t-patch-old/Documentation/power/devices.txt 940-combined-pm_message_t-patch-new/Documentation/power/devices.txt
--- 940-combined-pm_message_t-patch-old/Documentation/power/devices.txt	2005-02-03 22:33:12.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/Documentation/power/devices.txt	2005-02-14 09:26:35.000000000 +1100
@@ -15,7 +15,7 @@ The methods to suspend and resume device
 
 struct bus_type {
        ...
-       int             (*suspend)(struct device * dev, u32 state);
+       int             (*suspend)(struct device * dev, pm_message_t state);
        int             (*resume)(struct device * dev);
 };
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/base/power/resume.c 940-combined-pm_message_t-patch-new/drivers/base/power/resume.c
--- 940-combined-pm_message_t-patch-old/drivers/base/power/resume.c	2004-12-10 14:26:51.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/base/power/resume.c	2005-02-14 09:26:36.000000000 +1100
@@ -41,7 +41,7 @@ void dpm_resume(void)
 		list_add_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state)
+		if (!dev->power.prev_state.event)
 			resume_device(dev);
 		down(&dpm_list_sem);
 		put_device(dev);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/base/power/runtime.c 940-combined-pm_message_t-patch-new/drivers/base/power/runtime.c
--- 940-combined-pm_message_t-patch-old/drivers/base/power/runtime.c	2005-02-03 22:33:23.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/base/power/runtime.c	2005-02-14 09:26:36.000000000 +1100
@@ -13,10 +13,10 @@
 static void runtime_resume(struct device * dev)
 {
 	dev_dbg(dev, "resuming\n");
-	if (!dev->power.power_state)
+	if (!dev->power.power_state.event)
 		return;
 	if (!resume_device(dev))
-		dev->power.power_state = 0;
+		dev->power.power_state = PMSG_ON;
 }
 
 
@@ -49,10 +49,10 @@ int dpm_runtime_suspend(struct device * 
 	int error = 0;
 
 	down(&dpm_sem);
-	if (dev->power.power_state == state)
+	if (dev->power.power_state.event == state.event)
 		goto Done;
 
-	if (dev->power.power_state)
+	if (dev->power.power_state.event)
 		runtime_resume(dev);
 
 	if (!(error = suspend_device(dev, state)))
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/base/power/shutdown.c 940-combined-pm_message_t-patch-new/drivers/base/power/shutdown.c
--- 940-combined-pm_message_t-patch-old/drivers/base/power/shutdown.c	2005-02-14 16:34:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/base/power/shutdown.c	2005-02-14 09:26:36.000000000 +1100
@@ -29,7 +29,8 @@ int device_detach_shutdown(struct device
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME */
+	return dpm_runtime_suspend(dev, PMSG_FREEZE);
 }
 
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/base/power/suspend.c 940-combined-pm_message_t-patch-new/drivers/base/power/suspend.c
--- 940-combined-pm_message_t-patch-old/drivers/base/power/suspend.c	2005-02-03 22:33:23.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/base/power/suspend.c	2005-02-14 09:26:36.000000000 +1100
@@ -43,7 +43,7 @@ int suspend_device(struct device * dev, 
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && (!dev->power.power_state.event))
 		error = dev->bus->suspend(dev, state);
 
 	return error;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/base/power/sysfs.c 940-combined-pm_message_t-patch-new/drivers/base/power/sysfs.c
--- 940-combined-pm_message_t-patch-old/drivers/base/power/sysfs.c	2004-11-03 21:55:04.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/base/power/sysfs.c	2005-02-14 09:26:36.000000000 +1100
@@ -26,19 +26,20 @@
 
 static ssize_t state_show(struct device * dev, char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state);
+	return sprintf(buf, "%u\n", dev->power.power_state.event);
 }
 
 static ssize_t state_store(struct device * dev, const char * buf, size_t n)
 {
-	u32 state;
+	pm_message_t state;
 	char * rest;
 	int error = 0;
 
-	state = simple_strtoul(buf, &rest, 10);
+	state.event = simple_strtoul(buf, &rest, 10);
+	state.flags = PFL_RUNTIME;
 	if (*rest)
 		return -EINVAL;
-	if (state)
+	if (state.event)
 		error = dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/char/agp/via-agp.c 940-combined-pm_message_t-patch-new/drivers/char/agp/via-agp.c
--- 940-combined-pm_message_t-patch-old/drivers/char/agp/via-agp.c	2005-02-03 22:33:24.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/char/agp/via-agp.c	2005-02-14 09:26:35.000000000 +1100
@@ -440,10 +440,10 @@ static void __devexit agp_via_remove(str
 
 #ifdef CONFIG_PM
 
-static int agp_via_suspend(struct pci_dev *pdev, u32 state)
+static int agp_via_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	pci_save_state (pdev);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -452,7 +452,7 @@ static int agp_via_resume(struct pci_dev
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
-	pci_set_power_state (pdev, 0);
+	pci_set_power_state (pdev, PCI_D0);
 	pci_restore_state(pdev);
 
 	if (bridge->driver == &via_agp3_driver)
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/i2c/i2c-core.c 940-combined-pm_message_t-patch-new/drivers/i2c/i2c-core.c
--- 940-combined-pm_message_t-patch-old/drivers/i2c/i2c-core.c	2004-12-10 14:27:09.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/i2c/i2c-core.c	2005-02-14 09:26:35.000000000 +1100
@@ -530,7 +530,7 @@ static int i2c_device_match(struct devic
 	return 1;
 }
 
-static int i2c_bus_suspend(struct device * dev, u32 state)
+static int i2c_bus_suspend(struct device * dev, pm_message_t state)
 {
 	int rc = 0;
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/ide/ide.c 940-combined-pm_message_t-patch-new/drivers/ide/ide.c
--- 940-combined-pm_message_t-patch-old/drivers/ide/ide.c	2005-02-14 16:34:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/ide/ide.c	2005-02-14 09:26:36.000000000 +1100
@@ -1394,7 +1394,7 @@ static int generic_ide_suspend(struct de
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state;
+	rqpm.pm_state = state.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/ide/ide-disk.c 940-combined-pm_message_t-patch-new/drivers/ide/ide-disk.c
--- 940-combined-pm_message_t-patch-old/drivers/ide/ide-disk.c	2005-02-14 16:34:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/ide/ide-disk.c	2005-02-14 09:26:35.000000000 +1100
@@ -1156,7 +1156,7 @@ static void ide_device_shutdown(struct d
 	}
 
 	printk("Shutdown: %s\n", drive->name);
-	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	dev->bus->suspend(dev, PMSG_SUSPEND);
 }
 
 /*
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/ieee1394/nodemgr.c 940-combined-pm_message_t-patch-new/drivers/ieee1394/nodemgr.c
--- 940-combined-pm_message_t-patch-old/drivers/ieee1394/nodemgr.c	2005-02-03 22:33:27.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/ieee1394/nodemgr.c	2005-02-14 09:26:36.000000000 +1100
@@ -1253,7 +1253,7 @@ static void nodemgr_suspend_ne(struct no
 
 		if (ud->device.driver &&
 		    (!ud->device.driver->suspend ||
-		      ud->device.driver->suspend(&ud->device, 0, 0)))
+		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND, 0)))
 			device_release_driver(&ud->device);
 	}
 	up_write(&ne->device.bus->subsys.rwsem);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/ieee1394/ohci1394.c 940-combined-pm_message_t-patch-new/drivers/ieee1394/ohci1394.c
--- 940-combined-pm_message_t-patch-old/drivers/ieee1394/ohci1394.c	2004-12-27 10:03:25.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/ieee1394/ohci1394.c	2005-02-14 09:26:35.000000000 +1100
@@ -3510,7 +3510,7 @@ static int ohci1394_pci_resume (struct p
 }
 
 
-static int ohci1394_pci_suspend (struct pci_dev *pdev, u32 state)
+static int ohci1394_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 #ifdef CONFIG_PMAC_PBOOK
 	{
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/input/serio/i8042.c 940-combined-pm_message_t-patch-new/drivers/input/serio/i8042.c
--- 940-combined-pm_message_t-patch-old/drivers/input/serio/i8042.c	2005-02-14 16:34:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/input/serio/i8042.c	2005-02-14 09:26:35.000000000 +1100
@@ -869,7 +869,7 @@ static long i8042_panic_blink(long count
  * Here we try to restore the original BIOS settings
  */
 
-static int i8042_suspend(struct device *dev, u32 state, u32 level)
+static int i8042_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	if (level == SUSPEND_DISABLE) {
 		del_timer_sync(&i8042_timer);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/media/video/bttv-driver.c 940-combined-pm_message_t-patch-new/drivers/media/video/bttv-driver.c
--- 940-combined-pm_message_t-patch-old/drivers/media/video/bttv-driver.c	2005-02-03 22:33:28.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/media/video/bttv-driver.c	2005-02-14 09:26:35.000000000 +1100
@@ -3921,7 +3921,7 @@ static void __devexit bttv_remove(struct
         return;
 }
 
-static int bttv_suspend(struct pci_dev *pci_dev, u32 state)
+static int bttv_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
         struct bttv *btv = pci_get_drvdata(pci_dev);
 	struct bttv_buffer_set idle;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/media/video/msp3400.c 940-combined-pm_message_t-patch-new/drivers/media/video/msp3400.c
--- 940-combined-pm_message_t-patch-old/drivers/media/video/msp3400.c	2005-02-14 16:34:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/media/video/msp3400.c	2005-02-14 09:26:36.000000000 +1100
@@ -1426,7 +1426,7 @@ static int msp_detach(struct i2c_client 
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
-static int msp_suspend(struct device * dev, u32 state, u32 level);
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level);
 static int msp_resume(struct device * dev, u32 level);
 
 static void msp_wake_thread(struct i2c_client *client);
@@ -1834,7 +1834,7 @@ static int msp_command(struct i2c_client
 	return 0;
 }
 
-static int msp_suspend(struct device * dev, u32 state, u32 level)
+static int msp_suspend(struct device * dev, pm_message_t state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/mmc/mmc_block.c 940-combined-pm_message_t-patch-new/drivers/mmc/mmc_block.c
--- 940-combined-pm_message_t-patch-old/drivers/mmc/mmc_block.c	2005-02-03 22:33:29.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/mmc/mmc_block.c	2005-02-14 09:26:35.000000000 +1100
@@ -437,7 +437,7 @@ static void mmc_blk_remove(struct mmc_ca
 }
 
 #ifdef CONFIG_PM
-static int mmc_blk_suspend(struct mmc_card *card, u32 state)
+static int mmc_blk_suspend(struct mmc_card *card, pm_message_t state)
 {
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/mmc/mmc_sysfs.c 940-combined-pm_message_t-patch-new/drivers/mmc/mmc_sysfs.c
--- 940-combined-pm_message_t-patch-old/drivers/mmc/mmc_sysfs.c	2004-11-03 21:54:15.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/mmc/mmc_sysfs.c	2005-02-14 09:26:35.000000000 +1100
@@ -74,7 +74,7 @@ mmc_bus_hotplug(struct device *dev, char
 	return 0;
 }
 
-static int mmc_bus_suspend(struct device *dev, u32 state)
+static int mmc_bus_suspend(struct device *dev, pm_message_t state)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = dev_to_mmc_card(dev);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/3c59x.c 940-combined-pm_message_t-patch-new/drivers/net/3c59x.c
--- 940-combined-pm_message_t-patch-old/drivers/net/3c59x.c	2005-02-03 22:33:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/3c59x.c	2005-02-14 09:26:35.000000000 +1100
@@ -964,7 +964,7 @@ static void poll_vortex(struct net_devic
 
 #ifdef CONFIG_PM
 
-static int vortex_suspend (struct pci_dev *pdev, u32 state)
+static int vortex_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/8139too.c 940-combined-pm_message_t-patch-new/drivers/net/8139too.c
--- 940-combined-pm_message_t-patch-old/drivers/net/8139too.c	2005-02-03 22:33:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/8139too.c	2005-02-14 09:26:35.000000000 +1100
@@ -2581,7 +2581,7 @@ static void rtl8139_set_rx_mode (struct 
 
 #ifdef CONFIG_PM
 
-static int rtl8139_suspend (struct pci_dev *pdev, u32 state)
+static int rtl8139_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct rtl8139_private *tp = dev->priv;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/amd8111e.c 940-combined-pm_message_t-patch-new/drivers/net/amd8111e.c
--- 940-combined-pm_message_t-patch-old/drivers/net/amd8111e.c	2005-02-03 22:33:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/amd8111e.c	2005-02-14 09:26:35.000000000 +1100
@@ -1797,7 +1797,7 @@ static void amd8111e_tx_timeout(struct n
 	if(!err)
 		netif_wake_queue(dev);
 }
-static int amd8111e_suspend(struct pci_dev *pci_dev, u32 state)
+static int amd8111e_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {	
 	struct net_device *dev = pci_get_drvdata(pci_dev);
 	struct amd8111e_priv *lp = netdev_priv(dev);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/b44.c 940-combined-pm_message_t-patch-new/drivers/net/b44.c
--- 940-combined-pm_message_t-patch-old/drivers/net/b44.c	2005-02-14 16:34:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/b44.c	2005-02-14 09:26:35.000000000 +1100
@@ -1903,7 +1903,7 @@ static void __devexit b44_remove_one(str
 	}
 }
 
-static int b44_suspend(struct pci_dev *pdev, u32 state)
+static int b44_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct b44 *bp = netdev_priv(dev);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/e100.c 940-combined-pm_message_t-patch-new/drivers/net/e100.c
--- 940-combined-pm_message_t-patch-old/drivers/net/e100.c	2005-02-03 22:33:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/e100.c	2005-02-14 16:34:40.000000000 +1100
@@ -2310,7 +2310,7 @@ static void __devexit e100_remove(struct
 }
 
 #ifdef CONFIG_PM
-static int e100_suspend(struct pci_dev *pdev, u32 state)
+static int e100_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct nic *nic = netdev_priv(netdev);
@@ -2321,7 +2321,7 @@ static int e100_suspend(struct pci_dev *
 	netif_device_detach(netdev);
 
 	pci_save_state(pdev);
-	pci_enable_wake(pdev, state, nic->flags & (wol_magic | e100_asf(nic)));
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), nic->flags & (wol_magic | e100_asf(nic)));
 	pci_disable_device(pdev);
 	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/eepro100.c 940-combined-pm_message_t-patch-new/drivers/net/eepro100.c
--- 940-combined-pm_message_t-patch-old/drivers/net/eepro100.c	2005-02-03 22:33:31.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/eepro100.c	2005-02-14 09:26:35.000000000 +1100
@@ -2281,7 +2281,7 @@ static void set_rx_mode(struct net_devic
 }
 
 #ifdef CONFIG_PM
-static int eepro100_suspend(struct pci_dev *pdev, u32 state)
+static int eepro100_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct speedo_private *sp = netdev_priv(dev);
@@ -2299,7 +2299,7 @@ static int eepro100_suspend(struct pci_d
 	
 	/* XXX call pci_set_power_state ()? */
 	pci_disable_device(pdev);
-	pci_set_power_state (pdev, 3);
+	pci_set_power_state (pdev, PCI_D3hot);
 	return 0;
 }
 
@@ -2309,7 +2309,7 @@ static int eepro100_resume(struct pci_de
 	struct speedo_private *sp = netdev_priv(dev);
 	void __iomem *ioaddr = sp->regs;
 
-	pci_set_power_state(pdev, 0);
+	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/epic100.c 940-combined-pm_message_t-patch-new/drivers/net/epic100.c
--- 940-combined-pm_message_t-patch-old/drivers/net/epic100.c	2005-02-03 22:33:31.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/epic100.c	2005-02-14 09:26:35.000000000 +1100
@@ -1624,7 +1624,7 @@ static void __devexit epic_remove_one (s
 
 #ifdef CONFIG_PM
 
-static int epic_suspend (struct pci_dev *pdev, u32 state)
+static int epic_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	long ioaddr = dev->base_addr;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/irda/donauboe.c 940-combined-pm_message_t-patch-new/drivers/net/irda/donauboe.c
--- 940-combined-pm_message_t-patch-old/drivers/net/irda/donauboe.c	2005-02-03 22:33:31.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/irda/donauboe.c	2005-02-14 09:26:35.000000000 +1100
@@ -1712,7 +1712,7 @@ freeself:
 }
 
 static int
-toshoboe_gotosleep (struct pci_dev *pci_dev, u32 crap)
+toshoboe_gotosleep (struct pci_dev *pci_dev, pm_message_t crap)
 {
   struct toshoboe_cb *self = (struct toshoboe_cb*)pci_get_drvdata(pci_dev);
   unsigned long flags;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/natsemi.c 940-combined-pm_message_t-patch-new/drivers/net/natsemi.c
--- 940-combined-pm_message_t-patch-old/drivers/net/natsemi.c	2005-02-03 22:33:31.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/natsemi.c	2005-02-14 09:26:35.000000000 +1100
@@ -3160,7 +3160,7 @@ static void __devexit natsemi_remove1 (s
  * Interrupts must be disabled, otherwise hands_off can cause irq storms.
  */
 
-static int natsemi_suspend (struct pci_dev *pdev, u32 state)
+static int natsemi_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct netdev_private *np = netdev_priv(dev);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/ne2k-pci.c 940-combined-pm_message_t-patch-new/drivers/net/ne2k-pci.c
--- 940-combined-pm_message_t-patch-old/drivers/net/ne2k-pci.c	2005-02-03 22:33:31.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/ne2k-pci.c	2005-02-14 09:26:35.000000000 +1100
@@ -654,13 +654,13 @@ static void __devexit ne2k_pci_remove_on
 }
 
 #ifdef CONFIG_PM
-static int ne2k_pci_suspend (struct pci_dev *pdev, u32 state)
+static int ne2k_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
 
 	netif_device_detach(dev);
 	pci_save_state(pdev);
-	pci_set_power_state(pdev, state);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 
 	return 0;
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/sis900.c 940-combined-pm_message_t-patch-new/drivers/net/sis900.c
--- 940-combined-pm_message_t-patch-old/drivers/net/sis900.c	2005-02-03 22:33:32.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/sis900.c	2005-02-14 09:26:35.000000000 +1100
@@ -2226,7 +2226,7 @@ static void __devexit sis900_remove(stru
 
 #ifdef CONFIG_PM
 
-static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
+static int sis900_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
 	struct net_device *net_dev = pci_get_drvdata(pci_dev);
 	long ioaddr = net_dev->base_addr;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/sungem.c 940-combined-pm_message_t-patch-new/drivers/net/sungem.c
--- 940-combined-pm_message_t-patch-old/drivers/net/sungem.c	2004-12-10 14:26:53.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/sungem.c	2005-02-14 09:26:35.000000000 +1100
@@ -2356,7 +2356,7 @@ static int gem_close(struct net_device *
 }
 
 #ifdef CONFIG_PM
-static int gem_suspend(struct pci_dev *pdev, u32 state)
+static int gem_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct gem *gp = dev->priv;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/tg3.c 940-combined-pm_message_t-patch-new/drivers/net/tg3.c
--- 940-combined-pm_message_t-patch-old/drivers/net/tg3.c	2005-02-14 09:05:26.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/tg3.c	2005-02-14 09:26:35.000000000 +1100
@@ -8924,7 +8924,7 @@ static void __devexit tg3_remove_one(str
 	}
 }
 
-static int tg3_suspend(struct pci_dev *pdev, u32 state)
+static int tg3_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct tg3 *tp = netdev_priv(dev);
@@ -8951,7 +8951,7 @@ static int tg3_suspend(struct pci_dev *p
 	spin_unlock(&tp->tx_lock);
 	spin_unlock_irq(&tp->lock);
 
-	err = tg3_set_power_state(tp, state);
+	err = tg3_set_power_state(tp, pci_choose_state(pdev, state));
 	if (err) {
 		spin_lock_irq(&tp->lock);
 		spin_lock(&tp->tx_lock);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/tulip/tulip_core.c 940-combined-pm_message_t-patch-new/drivers/net/tulip/tulip_core.c
--- 940-combined-pm_message_t-patch-old/drivers/net/tulip/tulip_core.c	2005-02-03 22:33:32.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/tulip/tulip_core.c	2005-02-14 09:26:35.000000000 +1100
@@ -1749,7 +1749,7 @@ err_out_free_netdev:
 
 #ifdef CONFIG_PM
 
-static int tulip_suspend (struct pci_dev *pdev, u32 state)
+static int tulip_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/typhoon.c 940-combined-pm_message_t-patch-new/drivers/net/typhoon.c
--- 940-combined-pm_message_t-patch-old/drivers/net/typhoon.c	2005-02-03 22:33:32.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/typhoon.c	2005-02-14 09:26:35.000000000 +1100
@@ -1855,7 +1855,7 @@ typhoon_free_rx_rings(struct typhoon *tp
 }
 
 static int
-typhoon_sleep(struct typhoon *tp, int state, u16 events)
+typhoon_sleep(struct typhoon *tp, pci_power_t state, u16 events)
 {
 	struct pci_dev *pdev = tp->pdev;
 	void __iomem *ioaddr = tp->ioaddr;
@@ -1889,7 +1889,7 @@ typhoon_sleep(struct typhoon *tp, int st
 
 	pci_enable_wake(tp->pdev, state, 1);
 	pci_disable_device(pdev);
-	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	return pci_set_power_state(pdev, state);
 }
 
 static int
@@ -2136,7 +2136,7 @@ out_sleep:
 		goto out;
 	}
 
-	if(typhoon_sleep(tp, 3, 0) < 0) 
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0) 
 		printk(KERN_ERR "%s: unable to go back to sleep\n", dev->name);
 
 out:
@@ -2163,7 +2163,7 @@ typhoon_close(struct net_device *dev)
 	if(typhoon_boot_3XP(tp, TYPHOON_STATUS_WAITING_FOR_HOST) < 0)
 		printk(KERN_ERR "%s: unable to boot sleep image\n", dev->name);
 
-	if(typhoon_sleep(tp, 3, 0) < 0)
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0)
 		printk(KERN_ERR "%s: unable to put card to sleep\n", dev->name);
 
 	return 0;
@@ -2203,7 +2203,7 @@ reset:
 }
 
 static int
-typhoon_suspend(struct pci_dev *pdev, u32 state)
+typhoon_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct typhoon *tp = netdev_priv(dev);
@@ -2255,7 +2255,7 @@ typhoon_suspend(struct pci_dev *pdev, u3
 		goto need_resume;
 	}
 
-	if(typhoon_sleep(tp, state, tp->wol_events) < 0) {
+	if(typhoon_sleep(tp, pci_choose_state(pdev, state), tp->wol_events) < 0) {
 		printk(KERN_ERR "%s: unable to put card to sleep\n", dev->name);
 		goto need_resume;
 	}
@@ -2454,7 +2454,7 @@ typhoon_init_one(struct pci_dev *pdev, c
 	if(xp_resp[0].numDesc != 0)
 		tp->capabilities |= TYPHOON_WAKEUP_NEEDS_RESET;
 
-	if(typhoon_sleep(tp, 3, 0) < 0) {
+	if(typhoon_sleep(tp, PCI_D3hot, 0) < 0) {
 		printk(ERR_PFX "%s: cannot put adapter to sleep\n",
 		       pci_name(pdev));
 		err = -EIO;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/via-rhine.c 940-combined-pm_message_t-patch-new/drivers/net/via-rhine.c
--- 940-combined-pm_message_t-patch-old/drivers/net/via-rhine.c	2005-02-03 22:33:32.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/via-rhine.c	2005-02-14 09:26:35.000000000 +1100
@@ -1937,7 +1937,7 @@ static void rhine_shutdown (struct devic
 }
 
 #ifdef CONFIG_PM
-static int rhine_suspend(struct pci_dev *pdev, u32 state)
+static int rhine_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct rhine_private *rp = netdev_priv(dev);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/net/via-velocity.c 940-combined-pm_message_t-patch-new/drivers/net/via-velocity.c
--- 940-combined-pm_message_t-patch-old/drivers/net/via-velocity.c	2005-02-03 22:33:32.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/net/via-velocity.c	2005-02-14 09:26:35.000000000 +1100
@@ -263,7 +263,7 @@ static int velocity_set_media_mode(struc
 
 #ifdef CONFIG_PM
 
-static int velocity_suspend(struct pci_dev *pdev, u32 state);
+static int velocity_suspend(struct pci_dev *pdev, pm_message_t state);
 static int velocity_resume(struct pci_dev *pdev);
 
 static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr);
@@ -3210,7 +3210,7 @@ static int velocity_set_wol(struct veloc
 	return 0;
 }
 
-static int velocity_suspend(struct pci_dev *pdev, u32 state)
+static int velocity_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct velocity_info *vptr = pci_get_drvdata(pdev);
 	unsigned long flags;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/pci/pci.c 940-combined-pm_message_t-patch-new/drivers/pci/pci.c
--- 940-combined-pm_message_t-patch-old/drivers/pci/pci.c	2005-02-03 22:33:33.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/pci/pci.c	2005-02-14 09:26:36.000000000 +1100
@@ -312,22 +312,27 @@ pci_set_power_state(struct pci_dev *dev,
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
 
-	switch (state) {
-	case 0:	return PCI_D0;
-	case 2: return PCI_D2;
-	case 3: return PCI_D3hot;
-	default: BUG();
+	switch (state.event) {
+	case EVENT_ON:
+	case EVENT_FREEZE:
+		return PCI_D0;
+	case EVENT_SUSPEND:
+		return PCI_D3hot;
+	default: 
+		printk("They asked me for state %d\n", state.event);
+		BUG();
 	}
 	return PCI_D0;
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/pcmcia/cs.c 940-combined-pm_message_t-patch-new/drivers/pcmcia/cs.c
--- 940-combined-pm_message_t-patch-old/drivers/pcmcia/cs.c	2005-02-03 22:33:34.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/pcmcia/cs.c	2005-02-14 09:26:35.000000000 +1100
@@ -140,7 +140,7 @@ static u8 pcmcia_used_irq[NR_IRQS];
 static int socket_resume(struct pcmcia_socket *skt);
 static int socket_suspend(struct pcmcia_socket *skt);
 
-int pcmcia_socket_dev_suspend(struct device *dev, u32 state)
+int pcmcia_socket_dev_suspend(struct device *dev, pm_message_t state)
 {
 	struct pcmcia_socket *socket;
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/pcmcia/i82092.c 940-combined-pm_message_t-patch-new/drivers/pcmcia/i82092.c
--- 940-combined-pm_message_t-patch-old/drivers/pcmcia/i82092.c	2005-02-03 22:33:34.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/pcmcia/i82092.c	2005-02-14 09:26:35.000000000 +1100
@@ -42,7 +42,7 @@ static struct pci_device_id i82092aa_pci
 };
 MODULE_DEVICE_TABLE(pci, i82092aa_pci_ids);
 
-static int i82092aa_socket_suspend (struct pci_dev *dev, u32 state)
+static int i82092aa_socket_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/pcmcia/i82365.c 940-combined-pm_message_t-patch-new/drivers/pcmcia/i82365.c
--- 940-combined-pm_message_t-patch-old/drivers/pcmcia/i82365.c	2005-02-14 09:05:26.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/pcmcia/i82365.c	2005-02-14 09:26:35.000000000 +1100
@@ -1339,7 +1339,7 @@ static struct pccard_operations pcic_ope
 
 /*====================================================================*/
 
-static int i82365_suspend(struct device *dev, u32 state, u32 level)
+static int i82365_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/pcmcia/pd6729.c 940-combined-pm_message_t-patch-new/drivers/pcmcia/pd6729.c
--- 940-combined-pm_message_t-patch-old/drivers/pcmcia/pd6729.c	2005-02-03 22:33:34.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/pcmcia/pd6729.c	2005-02-14 09:26:35.000000000 +1100
@@ -833,7 +833,7 @@ static void __devexit pd6729_pci_remove(
 	kfree(socket);
 }
 
-static int pd6729_socket_suspend(struct pci_dev *dev, u32 state)
+static int pd6729_socket_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/pcmcia/tcic.c 940-combined-pm_message_t-patch-new/drivers/pcmcia/tcic.c
--- 940-combined-pm_message_t-patch-old/drivers/pcmcia/tcic.c	2005-02-03 22:33:34.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/pcmcia/tcic.c	2005-02-14 09:26:35.000000000 +1100
@@ -373,7 +373,7 @@ static int __init get_tcic_id(void)
 
 /*====================================================================*/
 
-static int tcic_drv_suspend(struct device *dev, u32 state, u32 level)
+static int tcic_drv_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int ret = 0;
 	if (level == SUSPEND_SAVE_STATE)
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/pcmcia/yenta_socket.c 940-combined-pm_message_t-patch-new/drivers/pcmcia/yenta_socket.c
--- 940-combined-pm_message_t-patch-old/drivers/pcmcia/yenta_socket.c	2005-02-03 22:33:34.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/pcmcia/yenta_socket.c	2005-02-14 09:26:35.000000000 +1100
@@ -1019,7 +1019,7 @@ static int __devinit yenta_probe (struct
 }
 
 
-static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
+static int yenta_dev_suspend (struct pci_dev *dev, pm_message_t state)
 {
 	struct yenta_socket *socket = pci_get_drvdata(dev);
 	int ret;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/serial/8250.c 940-combined-pm_message_t-patch-new/drivers/serial/8250.c
--- 940-combined-pm_message_t-patch-old/drivers/serial/8250.c	2005-02-14 16:34:30.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/serial/8250.c	2005-02-14 09:26:35.000000000 +1100
@@ -2316,7 +2316,7 @@ static int __devexit serial8250_remove(s
 	return 0;
 }
 
-static int serial8250_suspend(struct device *dev, u32 state, u32 level)
+static int serial8250_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	int i;
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/serial/8250_pci.c 940-combined-pm_message_t-patch-new/drivers/serial/8250_pci.c
--- 940-combined-pm_message_t-patch-old/drivers/serial/8250_pci.c	2004-12-10 14:27:10.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/serial/8250_pci.c	2005-02-14 09:26:35.000000000 +1100
@@ -1759,7 +1759,7 @@ static void __devexit pciserial_remove_o
 	}
 }
 
-static int pciserial_suspend_one(struct pci_dev *dev, u32 state)
+static int pciserial_suspend_one(struct pci_dev *dev, pm_message_t state)
 {
 	struct serial_private *priv = pci_get_drvdata(dev);
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/core/hcd.h 940-combined-pm_message_t-patch-new/drivers/usb/core/hcd.h
--- 940-combined-pm_message_t-patch-old/drivers/usb/core/hcd.h	2005-02-03 22:33:37.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/core/hcd.h	2005-02-14 09:26:36.000000000 +1100
@@ -176,7 +176,7 @@ struct hc_driver {
 	 * a whole, not just the root hub; they're for bus glue.
 	 */
 	/* called after all devices were suspended */
-	int	(*suspend) (struct usb_hcd *hcd, u32 state);
+	int	(*suspend) (struct usb_hcd *hcd, pm_message_t state);
 
 	/* called before any devices get resumed */
 	int	(*resume) (struct usb_hcd *hcd);
@@ -223,7 +223,7 @@ extern int usb_hcd_pci_probe (struct pci
 extern void usb_hcd_pci_remove (struct pci_dev *dev);
 
 #ifdef CONFIG_PM
-extern int usb_hcd_pci_suspend (struct pci_dev *dev, u32 state);
+extern int usb_hcd_pci_suspend (struct pci_dev *dev, pm_message_t state);
 extern int usb_hcd_pci_resume (struct pci_dev *dev);
 #endif /* CONFIG_PM */
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/core/hcd-pci.c 940-combined-pm_message_t-patch-new/drivers/usb/core/hcd-pci.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/core/hcd-pci.c	2005-02-03 22:33:37.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/core/hcd-pci.c	2005-02-14 09:26:36.000000000 +1100
@@ -71,7 +71,7 @@ int usb_hcd_pci_probe (struct pci_dev *d
 	if (pci_enable_device (dev) < 0)
 		return -ENODEV;
 	dev->current_state = 0;
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state.event = 0;
 	
         if (!dev->irq) {
         	dev_err (&dev->dev,
@@ -274,11 +274,12 @@ static char __attribute_used__ *pci_stat
  *
  * Store this function in the HCD's struct pci_driver as suspend().
  */
-int usb_hcd_pci_suspend (struct pci_dev *dev, u32 state)
+int usb_hcd_pci_suspend (struct pci_dev *dev, pm_message_t pmsg)
 {
 	struct usb_hcd		*hcd;
 	int			retval = 0;
 	int			has_pci_pm;
+	pci_power_t		state;
 
 	hcd = pci_get_drvdata(dev);
 
@@ -287,8 +288,10 @@ int usb_hcd_pci_suspend (struct pci_dev 
 	 * PM-sensitive HCDs may already have done this.
 	 */
 	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (state > 4)
-		state = 4;
+
+	state = pci_choose_state(dev, pmsg);
+	if (state > PCI_D3cold)
+		state = PCI_D3cold;
 
 	switch (hcd->state) {
 
@@ -297,7 +300,7 @@ int usb_hcd_pci_suspend (struct pci_dev 
 	 */
 	case USB_STATE_RUNNING:
 		hcd->state = USB_STATE_QUIESCING;
-		retval = hcd->driver->suspend (hcd, state);
+		retval = hcd->driver->suspend (hcd, pmsg);
 		if (retval) {
 			dev_dbg (hcd->self.controller, 
 					"suspend fail, retval %d\n",
@@ -360,9 +363,6 @@ int usb_hcd_pci_suspend (struct pci_dev 
 		break;
 	}
 
-	/* update power_state **ONLY** to make sysfs happier */
-	if (retval == 0)
-		dev->dev.power.power_state = state;
 	return retval;
 }
 EXPORT_SYMBOL (usb_hcd_pci_suspend);
@@ -396,7 +396,7 @@ int usb_hcd_pci_resume (struct pci_dev *
 
 	if (has_pci_pm)
 		pci_set_power_state (dev, 0);
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state = PMSG_ON;
 	retval = request_irq (dev->irq, usb_hcd_irq, SA_SHIRQ,
 				hcd->driver->description, hcd);
 	if (retval < 0) {
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/core/hub.c 940-combined-pm_message_t-patch-new/drivers/usb/core/hub.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/core/hub.c	2005-02-03 22:33:37.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/core/hub.c	2005-02-14 09:26:36.000000000 +1100
@@ -1235,10 +1235,10 @@ int usb_new_device(struct usb_device *ud
 		 */
 		if (udev->bus->b_hnp_enable || udev->bus->is_b_host) {
 			static int __usb_suspend_device (struct usb_device *,
-						int port1, u32 state);
+						int port1, pm_message_t state);
 			err = __usb_suspend_device(udev,
 					udev->bus->otg_port,
-					PM_SUSPEND_MEM);
+					PMSG_SUSPEND);
 			if (err < 0)
 				dev_dbg(&udev->dev, "HNP fail, %d\n", err);
 		}
@@ -1523,7 +1523,7 @@ static int hub_port_suspend(struct usb_h
  * Linux (2.6) currently has NO mechanisms to initiate that:  no khubd
  * timer, no SRP, no requests through sysfs.
  */
-int __usb_suspend_device (struct usb_device *udev, int port1, u32 state)
+int __usb_suspend_device (struct usb_device *udev, int port1, pm_message_t state)
 {
 	int	status;
 
@@ -1547,7 +1547,7 @@ int __usb_suspend_device (struct usb_dev
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (state <= intf->dev.power.power_state)
+			if (state.event <= intf->dev.power.power_state.event)
 				continue;
 			if (!intf->dev.driver)
 				continue;
@@ -1555,11 +1555,11 @@ int __usb_suspend_device (struct usb_dev
 
 			if (driver->suspend) {
 				status = driver->suspend(intf, state);
-				if (intf->dev.power.power_state != state
+				if (intf->dev.power.power_state.event != state.event
 						|| status)
 					dev_err(&intf->dev,
 						"suspend %d fail, code %d\n",
-						state, status);
+						state.event, status);
 			}
 
 			/* only drivers with suspend() can ever resume();
@@ -1572,7 +1572,7 @@ int __usb_suspend_device (struct usb_dev
 			 * since we know every driver's probe/disconnect works
 			 * even for drivers that can't suspend.
 			 */
-			if (!driver->suspend || state > PM_SUSPEND_MEM) {
+			if (!driver->suspend || state.event > EVENT_FREEZE) {
 #if 1
 				dev_warn(&intf->dev, "resume is unsafe!\n");
 #else
@@ -1593,7 +1593,7 @@ int __usb_suspend_device (struct usb_dev
 	 * policies (when HNP doesn't apply) once we have mechanisms to
 	 * turn power back on!  (Likely not before 2.7...)
 	 */
-	if (state > PM_SUSPEND_MEM) {
+	if (state.event > EVENT_FREEZE) {
 		dev_warn(&udev->dev, "no poweroff yet, suspending instead\n");
 	}
 
@@ -1621,7 +1621,7 @@ int __usb_suspend_device (struct usb_dev
 /**
  * usb_suspend_device - suspend a usb device
  * @udev: device that's no longer in active use
- * @state: PM_SUSPEND_MEM to suspend
+ * @state: PMSG_SUSPEND to suspend
  * Context: must be able to sleep; device not locked
  *
  * Suspends a USB device that isn't in active use, conserving power.
@@ -1636,7 +1636,7 @@ int __usb_suspend_device (struct usb_dev
  *
  * Returns 0 on success, else negative errno.
  */
-int usb_suspend_device(struct usb_device *udev, u32 state)
+int usb_suspend_device(struct usb_device *udev, pm_message_t state)
 {
 	int	port1, status;
 
@@ -1670,7 +1670,7 @@ static int finish_port_resume(struct usb
 	usb_set_device_state(udev, udev->actconfig
 			? USB_STATE_CONFIGURED
 			: USB_STATE_ADDRESS);
-	udev->dev.power.power_state = PM_SUSPEND_ON;
+	udev->dev.power.power_state = PMSG_ON;
 
  	/* 10.5.4.5 says be sure devices in the tree are still there.
  	 * For now let's assume the device didn't go crazy on resume,
@@ -1708,7 +1708,7 @@ static int finish_port_resume(struct usb
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (intf->dev.power.power_state == PM_SUSPEND_ON)
+			if (intf->dev.power.power_state.event == EVENT_ON)
 				continue;
 			if (!intf->dev.driver) {
 				/* FIXME maybe force to alt 0 */
@@ -1722,11 +1722,11 @@ static int finish_port_resume(struct usb
 
 			/* can we do better than just logging errors? */
 			status = driver->resume(intf);
-			if (intf->dev.power.power_state != PM_SUSPEND_ON
+			if (intf->dev.power.power_state.event != EVENT_ON
 					|| status)
 				dev_dbg(&intf->dev,
 					"resume fail, state %d code %d\n",
-					intf->dev.power.power_state, status);
+					intf->dev.power.power_state.event, status);
 		}
 		status = 0;
 
@@ -1871,7 +1871,7 @@ static int remote_wakeup(struct usb_devi
 	return status;
 }
 
-static int hub_suspend(struct usb_interface *intf, u32 state)
+static int hub_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct usb_hub		*hub = usb_get_intfdata (intf);
 	struct usb_device	*hdev = hub->hdev;
@@ -1907,7 +1907,7 @@ static int hub_resume(struct usb_interfa
 	unsigned		port1;
 	int			status;
 
-	if (intf->dev.power.power_state == PM_SUSPEND_ON)
+	if (intf->dev.power.power_state.event == EVENT_ON)
 		return 0;
 
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
@@ -1943,7 +1943,7 @@ static int hub_resume(struct usb_interfa
 		}
 		up(&udev->serialize);
 	}
-	intf->dev.power.power_state = PM_SUSPEND_ON;
+	intf->dev.power.power_state = PMSG_ON;
 
 	hub_activate(hub);
 	return 0;
@@ -1951,7 +1951,7 @@ static int hub_resume(struct usb_interfa
 
 #else	/* !CONFIG_USB_SUSPEND */
 
-int usb_suspend_device(struct usb_device *udev, u32 state)
+int usb_suspend_device(struct usb_device *udev, pm_message_t state)
 {
 	return 0;
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/core/usb.c 940-combined-pm_message_t-patch-new/drivers/usb/core/usb.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/core/usb.c	2005-02-03 22:33:37.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/core/usb.c	2005-02-14 09:26:36.000000000 +1100
@@ -1348,7 +1348,7 @@ void usb_buffer_unmap_sg (struct usb_dev
 			usb_pipein (pipe) ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 }
 
-static int usb_generic_suspend(struct device *dev, u32 state)
+static int usb_generic_suspend(struct device *dev, pm_message_t state)
 {
 	struct usb_interface *intf;
 	struct usb_driver *driver;
@@ -1364,7 +1364,7 @@ static int usb_generic_suspend(struct de
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/host/ehci-dbg.c 940-combined-pm_message_t-patch-new/drivers/usb/host/ehci-dbg.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/host/ehci-dbg.c	2005-02-03 22:33:38.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/host/ehci-dbg.c	2005-02-14 09:26:36.000000000 +1100
@@ -641,7 +641,7 @@ show_registers (struct class_device *cla
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"SUSPENDED (no register access)\n",
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/host/ehci-hcd.c 940-combined-pm_message_t-patch-new/drivers/usb/host/ehci-hcd.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/host/ehci-hcd.c	2005-02-03 22:33:38.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/host/ehci-hcd.c	2005-02-14 09:26:36.000000000 +1100
@@ -677,7 +677,7 @@ static int ehci_get_frame (struct usb_hc
  * the right sort of wakeup.  
  */
 
-static int ehci_suspend (struct usb_hcd *hcd, u32 state)
+static int ehci_suspend (struct usb_hcd *hcd, pm_message_t state)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/host/ohci-dbg.c 940-combined-pm_message_t-patch-new/drivers/usb/host/ohci-dbg.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/host/ohci-dbg.c	2005-02-03 22:33:38.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/host/ohci-dbg.c	2005-02-14 09:26:36.000000000 +1100
@@ -625,7 +625,7 @@ show_registers (struct class_device *cla
 		hcd->self.controller->bus_id,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/host/ohci-pci.c 940-combined-pm_message_t-patch-new/drivers/usb/host/ohci-pci.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/host/ohci-pci.c	2005-02-03 22:33:38.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/host/ohci-pci.c	2005-02-14 09:26:36.000000000 +1100
@@ -102,7 +102,7 @@ ohci_pci_start (struct usb_hcd *hcd)
 
 #ifdef	CONFIG_PM
 
-static int ohci_pci_suspend (struct usb_hcd *hcd, u32 state)
+static int ohci_pci_suspend (struct usb_hcd *hcd, pm_message_t state)
 {
 	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/host/sl811-hcd.c 940-combined-pm_message_t-patch-new/drivers/usb/host/sl811-hcd.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/host/sl811-hcd.c	2005-02-03 22:33:38.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/host/sl811-hcd.c	2005-02-14 09:26:35.000000000 +1100
@@ -103,12 +103,12 @@ static void port_power(struct sl811 *sl8
 
 		sl811->port1 = (1 << USB_PORT_FEAT_POWER);
 		sl811->irq_enable = SL11H_INTMASK_INSRMV;
-		hcd->self.controller->power.power_state = PM_SUSPEND_ON;
+		hcd->self.controller->power.power_state = PMSG_ON;
 	} else {
 		sl811->port1 = 0;
 		sl811->irq_enable = 0;
 		hcd->state = USB_STATE_HALT;
-		hcd->self.controller->power.power_state = PM_SUSPEND_DISK;
+		hcd->self.controller->power.power_state = PMSG_SUSPEND;
 	}
 	sl811->ctrl1 = 0;
 	sl811_write(sl811, SL11H_IRQ_ENABLE, 0);
@@ -1799,7 +1799,7 @@ sl811h_probe(struct device *dev)
  */
 
 static int
-sl811h_suspend(struct device *dev, u32 state, u32 phase)
+sl811h_suspend(struct device *dev, pm_message_t state, u32 phase)
 {
 	struct sl811	*sl811 = dev_get_drvdata(dev);
 	int		retval = 0;
@@ -1807,9 +1807,9 @@ sl811h_suspend(struct device *dev, u32 s
 	if (phase != SUSPEND_POWER_DOWN)
 		return retval;
 
-	if (state <= PM_SUSPEND_MEM)
+	if (state.event == EVENT_FREEZE)
 		retval = sl811h_hub_suspend(sl811_to_hcd(sl811));
-	else
+	else if (state.event == EVENT_SUSPEND)
 		port_power(sl811, 0);
 	if (retval == 0)
 		dev->power.power_state = state;
@@ -1827,14 +1827,14 @@ sl811h_resume(struct device *dev, u32 ph
 	/* with no "check to see if VBUS is still powered" board hook,
 	 * let's assume it'd only be powered to enable remote wakeup.
 	 */
-	if (dev->power.power_state > PM_SUSPEND_MEM
+	if (dev->power.power_state.event == EVENT_SUSPEND
 			|| !sl811_to_hcd(sl811)->can_wakeup) {
 		sl811->port1 = 0;
 		port_power(sl811, 1);
 		return 0;
 	}
 
-	dev->power.power_state = PM_SUSPEND_ON;
+	dev->power.power_state = PMSG_ON;
 	return sl811h_hub_resume(sl811_to_hcd(sl811));
 }
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/host/uhci-hcd.c 940-combined-pm_message_t-patch-new/drivers/usb/host/uhci-hcd.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/host/uhci-hcd.c	2005-02-03 22:33:38.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/host/uhci-hcd.c	2005-02-14 09:26:36.000000000 +1100
@@ -2231,7 +2231,7 @@ static void uhci_stop(struct usb_hcd *hc
 }
 
 #ifdef CONFIG_PM
-static int uhci_suspend(struct usb_hcd *hcd, u32 state)
+static int uhci_suspend(struct usb_hcd *hcd, pm_message_t state)
 {
 	struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/input/hid-core.c 940-combined-pm_message_t-patch-new/drivers/usb/input/hid-core.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/input/hid-core.c	2005-02-14 09:05:26.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/input/hid-core.c	2005-02-14 09:26:35.000000000 +1100
@@ -1866,7 +1866,7 @@ static int hid_probe (struct usb_interfa
 	return 0;
 }
 
-static int hid_suspend(struct usb_interface *intf, u32 state)
+static int hid_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct hid_device *hid = usb_get_intfdata (intf);
 
@@ -1881,7 +1881,7 @@ static int hid_resume(struct usb_interfa
 	struct hid_device *hid = usb_get_intfdata (intf);
 	int status;
 
-	intf->dev.power.power_state = PM_SUSPEND_ON;
+	intf->dev.power.power_state = PMSG_ON;
 	if (hid->open)
 		status = usb_submit_urb(hid->urbin, GFP_NOIO);
 	else
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/usb/net/pegasus.c 940-combined-pm_message_t-patch-new/drivers/usb/net/pegasus.c
--- 940-combined-pm_message_t-patch-old/drivers/usb/net/pegasus.c	2005-02-03 22:33:38.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/usb/net/pegasus.c	2005-02-14 09:26:35.000000000 +1100
@@ -1253,7 +1253,7 @@ static void pegasus_disconnect(struct us
 	free_netdev(pegasus->net);
 }
 
-static int pegasus_suspend (struct usb_interface *intf, u32 state)
+static int pegasus_suspend (struct usb_interface *intf, pm_message_t state)
 {
 	struct pegasus *pegasus = usb_get_intfdata(intf);
 	
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/video/aty/aty128fb.c 940-combined-pm_message_t-patch-new/drivers/video/aty/aty128fb.c
--- 940-combined-pm_message_t-patch-old/drivers/video/aty/aty128fb.c	2005-02-14 09:05:26.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/video/aty/aty128fb.c	2005-02-14 09:26:35.000000000 +1100
@@ -166,7 +166,7 @@ static const char *r128_family[] __devin
 static int aty128_probe(struct pci_dev *pdev,
                                const struct pci_device_id *ent);
 static void aty128_remove(struct pci_dev *pdev);
-static int aty128_pci_suspend(struct pci_dev *pdev, u32 state);
+static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 static int aty128_pci_resume(struct pci_dev *pdev);
 static int aty128_do_resume(struct pci_dev *pdev);
 
@@ -2330,7 +2330,7 @@ static void aty128_set_suspend(struct at
 	}
 }
 
-static int aty128_pci_suspend(struct pci_dev *pdev, u32 state)
+static int aty128_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
@@ -2346,11 +2346,11 @@ static int aty128_pci_suspend(struct pci
 	 * that. On laptops, the AGP slot is just unclocked, so D2 is
 	 * expected, while on desktops, the card is powered off
 	 */
-	if (state >= 3)
-		state = 2;
+	if (state.event >= 3)
+		state.event = 2;
 #endif /* CONFIG_PPC_PMAC */
 	 
-	if (state != 2 || state == pdev->dev.power.power_state)
+	if (state.event != 2 || state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	printk(KERN_DEBUG "aty128fb: suspending...\n");
@@ -2376,7 +2376,7 @@ static int aty128_pci_suspend(struct pci
 	 * used dummy fb ops, 2.5 need proper support for this at the
 	 * fbdev level
 	 */
-	if (state == 2)
+	if (state.event == 2)
 		aty128_set_suspend(par, 1);
 
 	release_console_sem();
@@ -2413,7 +2413,7 @@ static int aty128_do_resume(struct pci_d
 	par->lock_blank = 0;
 	aty128fb_blank(0, info);
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	printk(KERN_DEBUG "aty128fb: resumed !\n");
 
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/video/aty/atyfb_base.c 940-combined-pm_message_t-patch-new/drivers/video/aty/atyfb_base.c
--- 940-combined-pm_message_t-patch-old/drivers/video/aty/atyfb_base.c	2005-02-03 22:33:39.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/video/aty/atyfb_base.c	2005-02-14 09:26:35.000000000 +1100
@@ -2016,7 +2016,7 @@ static int aty_power_mgmt(int sleep, str
 	return timeout ? 0 : -EIO;
 }
 
-static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)
+static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -2027,11 +2027,11 @@ static int atyfb_pci_suspend(struct pci_
 	 * that. On laptops, the AGP slot is just unclocked, so D2 is
 	 * expected, while on desktops, the card is powered off
 	 */
-	if (state >= 3)
-		state = 2;
+	if (state.event >= 3)
+		state.event = 2;
 #endif /* CONFIG_PPC_PMAC */
 
-	if (state != 2 || state == pdev->dev.power.power_state)
+	if (state.event != 2 || state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	acquire_console_sem();
@@ -2070,12 +2070,12 @@ static int atyfb_pci_resume(struct pci_d
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == EVENT_ON)
 		return 0;
 
 	acquire_console_sem();
 
-	if (pdev->dev.power.power_state == 2)
+	if (pdev->dev.power.power_state.event == 2)
 		aty_power_mgmt(0, par);
 	par->asleep = 0;
 
@@ -2091,7 +2091,7 @@ static int atyfb_pci_resume(struct pci_d
 
 	release_console_sem();
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
 	return 0;
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/video/aty/radeonfb.h 940-combined-pm_message_t-patch-new/drivers/video/aty/radeonfb.h
--- 940-combined-pm_message_t-patch-old/drivers/video/aty/radeonfb.h	2005-02-14 09:05:26.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/video/aty/radeonfb.h	2005-02-14 09:26:35.000000000 +1100
@@ -624,7 +624,7 @@ extern void radeon_delete_i2c_busses(str
 extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
 
 /* PM Functions */
-extern int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state);
+extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int radeonfb_pci_resume(struct pci_dev *pdev);
 extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk);
 extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/video/aty/radeon_pm.c 940-combined-pm_message_t-patch-new/drivers/video/aty/radeon_pm.c
--- 940-combined-pm_message_t-patch-old/drivers/video/aty/radeon_pm.c	2005-02-14 09:05:26.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/video/aty/radeon_pm.c	2005-02-14 09:26:36.000000000 +1100
@@ -2503,27 +2503,27 @@ static int radeon_restore_pci_cfg(struct
 
 static/*extern*/ int susdisking = 0;
 
-int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state)
+int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 	int i;
 
-	if (state == pdev->dev.power.power_state)
+	if (state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
-	       pci_name(pdev), state);
+	       pci_name(pdev), state.event);
 
 	/* For suspend-to-disk, we cheat here. We don't suspend anything and
 	 * let fbcon continue drawing until we are all set. That shouldn't
 	 * really cause any problem at this point, provided that the wakeup
 	 * code knows that any state in memory may not match the HW
 	 */
-	if (state != PM_SUSPEND_MEM)
+	if (state.event != EVENT_SUSPEND)
 		goto done;
 	if (susdisking) {
-		printk("suspending to disk but state = %d\n", state);
+		printk("suspending to disk but state = %d\n", state.event);
 		goto done;
 	}
 
@@ -2596,7 +2596,7 @@ int radeonfb_pci_resume(struct pci_dev *
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (!pdev->dev.power.power_state.event)
 		return 0;
 
 	if (rinfo->no_schedule) {
@@ -2617,7 +2617,7 @@ int radeonfb_pci_resume(struct pci_dev *
 	}
 	pci_set_master(pdev);
 
-	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+	if (pdev->dev.power.power_state.event == EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
@@ -2663,7 +2663,7 @@ int radeonfb_pci_resume(struct pci_dev *
 	else if (rinfo->dynclk == 0)
 		radeon_pm_disable_dynamic_mode(rinfo);
 
-	pdev->dev.power.power_state = 0;
+	pdev->dev.power.power_state = PMSG_ON;
 
  bail:
 	release_console_sem();
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/video/cyber2000fb.c 940-combined-pm_message_t-patch-new/drivers/video/cyber2000fb.c
--- 940-combined-pm_message_t-patch-old/drivers/video/cyber2000fb.c	2005-02-03 22:33:39.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/video/cyber2000fb.c	2005-02-14 09:26:35.000000000 +1100
@@ -1665,7 +1665,7 @@ static void __devexit cyberpro_pci_remov
 	}
 }
 
-static int cyberpro_pci_suspend(struct pci_dev *dev, u32 state)
+static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return 0;
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/video/i810/i810_main.c 940-combined-pm_message_t-patch-new/drivers/video/i810/i810_main.c
--- 940-combined-pm_message_t-patch-old/drivers/video/i810/i810_main.c	2005-02-03 22:33:39.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/video/i810/i810_main.c	2005-02-14 09:26:35.000000000 +1100
@@ -1492,18 +1492,18 @@ static struct fb_ops i810fb_ops __devini
 /***********************************************************************
  *                         Power Management                            *
  ***********************************************************************/
-static int i810fb_suspend(struct pci_dev *dev, u32 state)
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	int blank = 0, prev_state = par->cur_state;
 
-	if (state == prev_state)
+	if (state.event == prev_state)
 		return 0;
 
-	par->cur_state = state;
+	par->cur_state = state.event;
 
-	switch (state) {
+	switch (state.event) {
 	case 1:
 		blank = VESA_VSYNC_SUSPEND;
 		break;
@@ -1524,7 +1524,7 @@ static int i810fb_suspend(struct pci_dev
 		pci_disable_device(dev);
 	}
 	pci_save_state(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/video/i810/i810_main.h 940-combined-pm_message_t-patch-new/drivers/video/i810/i810_main.h
--- 940-combined-pm_message_t-patch-old/drivers/video/i810/i810_main.h	2004-11-03 21:54:14.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/video/i810/i810_main.h	2005-02-14 09:26:35.000000000 +1100
@@ -18,7 +18,7 @@ static int  __devinit i810fb_init_pci (s
 				       const struct pci_device_id *entry);
 static void __exit i810fb_remove_pci(struct pci_dev *dev);
 static int i810fb_resume(struct pci_dev *dev);
-static int i810fb_suspend(struct pci_dev *dev, u32 state);
+static int i810fb_suspend(struct pci_dev *dev, pm_message_t state);
 
 /*
  * voffset - framebuffer offset in MiB from aperture start address.  In order for
diff -ruNp 940-combined-pm_message_t-patch-old/drivers/video/savage/savagefb.c 940-combined-pm_message_t-patch-new/drivers/video/savage/savagefb.c
--- 940-combined-pm_message_t-patch-old/drivers/video/savage/savagefb.c	2004-12-10 14:27:10.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/drivers/video/savage/savagefb.c	2005-02-14 09:26:35.000000000 +1100
@@ -2100,22 +2100,22 @@ static void __devexit savagefb_remove (s
 	}
 }
 
-static int savagefb_suspend (struct pci_dev* dev, u32 state)
+static int savagefb_suspend (struct pci_dev* dev, pm_message_t state)
 {
 	struct fb_info *info =
 		(struct fb_info *)pci_get_drvdata(dev);
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
 
 	DBG("savagefb_suspend");
-	printk(KERN_DEBUG "state: %u\n", state);
+	printk(KERN_DEBUG "state: %u\n", state.event);
 
 	acquire_console_sem();
-	fb_set_suspend(info, state);
+	fb_set_suspend(info, (state.event != EVENT_ON));
 	savage_disable_mmio(par);
 	release_console_sem();
 
 	pci_disable_device(dev);
-	pci_set_power_state(dev, state);
+	pci_set_power_state(dev, pci_choose_state(dev, state));
 
 	return 0;
 }
diff -ruNp 940-combined-pm_message_t-patch-old/include/linux/device.h 940-combined-pm_message_t-patch-new/include/linux/device.h
--- 940-combined-pm_message_t-patch-old/include/linux/device.h	2005-02-03 22:33:47.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/include/linux/device.h	2005-02-14 09:26:35.000000000 +1100
@@ -111,7 +111,7 @@ struct device_driver {
 	int	(*probe)	(struct device * dev);
 	int 	(*remove)	(struct device * dev);
 	void	(*shutdown)	(struct device * dev);
-	int	(*suspend)	(struct device * dev, u32 state, u32 level);
+	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
 	int	(*resume)	(struct device * dev, u32 level);
 };
 
diff -ruNp 940-combined-pm_message_t-patch-old/include/linux/mmc/card.h 940-combined-pm_message_t-patch-new/include/linux/mmc/card.h
--- 940-combined-pm_message_t-patch-old/include/linux/mmc/card.h	2004-11-03 21:54:43.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/include/linux/mmc/card.h	2005-02-14 09:26:35.000000000 +1100
@@ -75,7 +75,7 @@ struct mmc_driver {
 	struct device_driver drv;
 	int (*probe)(struct mmc_card *);
 	void (*remove)(struct mmc_card *);
-	int (*suspend)(struct mmc_card *, u32);
+	int (*suspend)(struct mmc_card *, pm_message_t);
 	int (*resume)(struct mmc_card *);
 };
 
diff -ruNp 940-combined-pm_message_t-patch-old/include/linux/pm.h 940-combined-pm_message_t-patch-new/include/linux/pm.h
--- 940-combined-pm_message_t-patch-old/include/linux/pm.h	2005-02-03 22:33:48.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/include/linux/pm.h	2005-02-14 09:26:36.000000000 +1100
@@ -195,7 +195,10 @@ extern int pm_suspend(suspend_state_t st
 
 struct device;
 
-typedef u32 __bitwise pm_message_t;
+typedef struct pm_message {
+	int event;
+	int flags;
+} pm_message_t;
 
 /*
  * There are 4 important states driver can be in:
@@ -215,9 +218,16 @@ typedef u32 __bitwise pm_message_t;
  * or something similar soon.
  */
 
-#define PMSG_FREEZE	((__force pm_message_t) 3)
-#define PMSG_SUSPEND	((__force pm_message_t) 3)
-#define PMSG_ON		((__force pm_message_t) 0)
+#define EVENT_ON 0
+#define EVENT_FREEZE 1
+#define EVENT_SUSPEND 2
+
+#define PFL_RUNTIME 1
+
+#define PMSG_FREEZE	({struct pm_message m; m.event = EVENT_FREEZE; m.flags = 0; m; })
+#define PMSG_SUSPEND	({struct pm_message m; m.event = EVENT_SUSPEND; m.flags = 0; m; })
+#define PMSG_ON		({struct pm_message m; m.event = EVENT_ON; m.flags = 0; m; })
+
 
 struct dev_pm_info {
 	pm_message_t		power_state;
diff -ruNp 940-combined-pm_message_t-patch-old/include/linux/usb.h 940-combined-pm_message_t-patch-new/include/linux/usb.h
--- 940-combined-pm_message_t-patch-old/include/linux/usb.h	2005-02-03 22:33:48.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/include/linux/usb.h	2005-02-14 09:26:35.000000000 +1100
@@ -547,7 +547,7 @@ struct usb_driver {
 
 	int (*ioctl) (struct usb_interface *intf, unsigned int code, void *buf);
 
-	int (*suspend) (struct usb_interface *intf, u32 state);
+	int (*suspend) (struct usb_interface *intf, pm_message_t state);
 	int (*resume) (struct usb_interface *intf);
 
 	const struct usb_device_id *id_table;
@@ -966,7 +966,7 @@ extern int usb_bulk_msg(struct usb_devic
 	int timeout);
 
 /* selective suspend/resume */
-extern int usb_suspend_device(struct usb_device *dev, u32 state);
+extern int usb_suspend_device(struct usb_device *dev, pm_message_t state);
 extern int usb_resume_device(struct usb_device *dev);
 
 
diff -ruNp 940-combined-pm_message_t-patch-old/include/pcmcia/ss.h 940-combined-pm_message_t-patch-new/include/pcmcia/ss.h
--- 940-combined-pm_message_t-patch-old/include/pcmcia/ss.h	2005-02-03 22:33:49.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/include/pcmcia/ss.h	2005-02-14 09:26:35.000000000 +1100
@@ -248,7 +248,7 @@ extern void pcmcia_unregister_socket(str
 extern struct class pcmcia_socket_class;
 
 /* socket drivers are expected to use these callbacks in their .drv struct */
-extern int pcmcia_socket_dev_suspend(struct device *dev, u32 state);
+extern int pcmcia_socket_dev_suspend(struct device *dev, pm_message_t state);
 extern int pcmcia_socket_dev_resume(struct device *dev);
 
 #endif /* _LINUX_SS_H */
diff -ruNp 940-combined-pm_message_t-patch-old/include/sound/core.h 940-combined-pm_message_t-patch-new/include/sound/core.h
--- 940-combined-pm_message_t-patch-old/include/sound/core.h	2005-02-03 22:33:49.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/include/sound/core.h	2005-02-14 09:26:36.000000000 +1100
@@ -26,6 +26,7 @@
 #include <asm/semaphore.h>		/* struct semaphore */
 #include <linux/rwsem.h>		/* struct rw_semaphore */
 #include <linux/workqueue.h>		/* struct workqueue_struct */
+#include <linux/pm.h>			/* pm_message_t */
 
 /* Typedef's */
 typedef struct timespec snd_timestamp_t;
@@ -206,18 +207,18 @@ static inline void snd_power_change_stat
 	wake_up(&card->power_sleep);
 }
 int snd_card_set_pm_callback(snd_card_t *card,
-			     int (*suspend)(snd_card_t *, unsigned int),
+			     int (*suspend)(snd_card_t *, pm_message_t),
 			     int (*resume)(snd_card_t *, unsigned int),
 			     void *private_data);
 int snd_card_set_dev_pm_callback(snd_card_t *card, int type,
-				 int (*suspend)(snd_card_t *, unsigned int),
+				 int (*suspend)(snd_card_t *, pm_message_t),
 				 int (*resume)(snd_card_t *, unsigned int),
 				 void *private_data);
 #define snd_card_set_isa_pm_callback(card,suspend,resume,data) \
 	snd_card_set_dev_pm_callback(card, PM_ISA_DEV, suspend, resume, data)
 #ifdef CONFIG_PCI
 #ifndef SND_PCI_PM_CALLBACKS
-int snd_card_pci_suspend(struct pci_dev *dev, u32 state);
+int snd_card_pci_suspend(struct pci_dev *dev, pm_message_t state);
 int snd_card_pci_resume(struct pci_dev *dev);
 #define SND_PCI_PM_CALLBACKS \
 	.suspend = snd_card_pci_suspend,  .resume = snd_card_pci_resume
diff -ruNp 940-combined-pm_message_t-patch-old/sound/core/init.c 940-combined-pm_message_t-patch-new/sound/core/init.c
--- 940-combined-pm_message_t-patch-old/sound/core/init.c	2005-02-03 22:33:54.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/core/init.c	2005-02-14 09:26:36.000000000 +1100
@@ -719,7 +719,7 @@ int snd_power_wait(snd_card_t *card, uns
  * handler and from the control API.
  */
 int snd_card_set_pm_callback(snd_card_t *card,
-			     int (*suspend)(snd_card_t *, unsigned int),
+			     int (*suspend)(snd_card_t *, pm_message_t),
 			     int (*resume)(snd_card_t *, unsigned int),
 			     void *private_data)
 {
@@ -765,7 +765,7 @@ static int snd_generic_pm_callback(struc
  * from the ALSA's common PM handler and from the control API.
  */
 int snd_card_set_dev_pm_callback(snd_card_t *card, int type,
-				 int (*suspend)(snd_card_t *, unsigned int),
+				 int (*suspend)(snd_card_t *, pm_message_t),
 				 int (*resume)(snd_card_t *, unsigned int),
 				 void *private_data)
 {
@@ -778,7 +778,7 @@ int snd_card_set_dev_pm_callback(snd_car
 }
 
 #ifdef CONFIG_PCI
-int snd_card_pci_suspend(struct pci_dev *dev, u32 state)
+int snd_card_pci_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	snd_card_t *card = pci_get_drvdata(dev);
 	int err;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/drivers/vx/vx_core.c 940-combined-pm_message_t-patch-new/sound/drivers/vx/vx_core.c
--- 940-combined-pm_message_t-patch-old/sound/drivers/vx/vx_core.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/drivers/vx/vx_core.c	2005-02-14 09:26:35.000000000 +1100
@@ -718,7 +718,7 @@ int snd_vx_dsp_load(vx_core_t *chip, con
 /*
  * suspend
  */
-static int snd_vx_suspend(snd_card_t *card, unsigned int state)
+static int snd_vx_suspend(snd_card_t *card, pm_message_t state)
 {
 	vx_core_t *chip = card->pm_private_data;
 	unsigned int i;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/isa/ad1848/ad1848_lib.c 940-combined-pm_message_t-patch-new/sound/isa/ad1848/ad1848_lib.c
--- 940-combined-pm_message_t-patch-old/sound/isa/ad1848/ad1848_lib.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/isa/ad1848/ad1848_lib.c	2005-02-14 09:26:35.000000000 +1100
@@ -644,7 +644,7 @@ static void snd_ad1848_thinkpad_twiddle(
 }
 
 #ifdef CONFIG_PM
-static int snd_ad1848_suspend(snd_card_t *card, unsigned int state)
+static int snd_ad1848_suspend(snd_card_t *card, pm_message_t state)
 {
 	ad1848_t *chip = card->pm_private_data;
 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/isa/cs423x/cs4231_lib.c 940-combined-pm_message_t-patch-new/sound/isa/cs423x/cs4231_lib.c
--- 940-combined-pm_message_t-patch-old/sound/isa/cs423x/cs4231_lib.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/isa/cs423x/cs4231_lib.c	2005-02-14 09:26:35.000000000 +1100
@@ -1394,7 +1394,7 @@ static void snd_cs4231_resume(cs4231_t *
 #endif
 }
 
-static int snd_cs4231_pm_suspend(snd_card_t *card, unsigned int state)
+static int snd_cs4231_pm_suspend(snd_card_t *card, pm_message_t state)
 {
 	cs4231_t *chip = card->pm_private_data;
 	if (chip->suspend)
diff -ruNp 940-combined-pm_message_t-patch-old/sound/isa/es18xx.c 940-combined-pm_message_t-patch-new/sound/isa/es18xx.c
--- 940-combined-pm_message_t-patch-old/sound/isa/es18xx.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/isa/es18xx.c	2005-02-14 09:26:35.000000000 +1100
@@ -1612,7 +1612,7 @@ static int __devinit snd_es18xx_pcm(es18
 
 /* Power Management support functions */
 #ifdef CONFIG_PM
-static int snd_es18xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_es18xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	es18xx_t *chip = card->pm_private_data;
 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/isa/opl3sa2.c 940-combined-pm_message_t-patch-new/sound/isa/opl3sa2.c
--- 940-combined-pm_message_t-patch-old/sound/isa/opl3sa2.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/isa/opl3sa2.c	2005-02-14 09:26:35.000000000 +1100
@@ -529,7 +529,7 @@ static int __init snd_opl3sa2_mixer(opl3
 
 /* Power Management support functions */
 #ifdef CONFIG_PM
-static int snd_opl3sa2_suspend(snd_card_t *card, unsigned int state)
+static int snd_opl3sa2_suspend(snd_card_t *card, pm_message_t state)
 {
 	opl3sa2_t *chip = card->pm_private_data;
 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/ali5455.c 940-combined-pm_message_t-patch-new/sound/oss/ali5455.c
--- 940-combined-pm_message_t-patch-old/sound/oss/ali5455.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/ali5455.c	2005-02-14 09:26:35.000000000 +1100
@@ -3528,7 +3528,7 @@ static void __devexit ali_remove(struct 
 }
 
 #ifdef CONFIG_PM
-static int ali_pm_suspend(struct pci_dev *dev, u32 pm_state)
+static int ali_pm_suspend(struct pci_dev *dev, pm_message_t pm_state)
 {
 	struct ali_card *card = pci_get_drvdata(dev);
 	struct ali_state *state;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/cs4281/cs4281_wrapper-24.c 940-combined-pm_message_t-patch-new/sound/oss/cs4281/cs4281_wrapper-24.c
--- 940-combined-pm_message_t-patch-old/sound/oss/cs4281/cs4281_wrapper-24.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/cs4281/cs4281_wrapper-24.c	2005-02-14 09:26:35.000000000 +1100
@@ -27,7 +27,7 @@
 #include <linux/spinlock.h>
 
 static int cs4281_resume_null(struct pci_dev *pcidev) { return 0; }
-static int cs4281_suspend_null(struct pci_dev *pcidev, u32 state) { return 0; }
+static int cs4281_suspend_null(struct pci_dev *pcidev, pm_message_t state) { return 0; }
 
 #define free_dmabuf(state, dmabuf) \
 	pci_free_consistent(state->pcidev, \
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/cs46xx.c 940-combined-pm_message_t-patch-new/sound/oss/cs46xx.c
--- 940-combined-pm_message_t-patch-old/sound/oss/cs46xx.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/cs46xx.c	2005-02-14 09:26:35.000000000 +1100
@@ -388,7 +388,7 @@ static int cs_hardware_init(struct cs_ca
 static int cs46xx_powerup(struct cs_card *card, unsigned int type);
 static int cs461x_powerdown(struct cs_card *card, unsigned int type, int suspendflag);
 static void cs461x_clear_serial_FIFOs(struct cs_card *card, int type);
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
 
 #ifndef CS46XX_ACPI_SUPPORT
@@ -5774,7 +5774,7 @@ static int cs46xx_pm_callback(struct pm_
 #endif
 
 #if CS46XX_ACPI_SUPPORT
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state)
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state)
 {
 	struct cs_card *s = PCI_GET_DRIVER_DATA(pcidev);
 	CS_DBGOUT(CS_PM | CS_FUNCTION, 2, 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/cs46xxpm-24.h 940-combined-pm_message_t-patch-new/sound/oss/cs46xxpm-24.h
--- 940-combined-pm_message_t-patch-old/sound/oss/cs46xxpm-24.h	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/cs46xxpm-24.h	2005-02-14 09:26:35.000000000 +1100
@@ -36,7 +36,7 @@
 * for now (12/22/00) only enable the pm_register PM support.
 * allow these table entries to be null.
 */
-static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
+static int cs46xx_suspend_tbl(struct pci_dev *pcidev, pm_message_t state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
 #define cs_pm_register(a, b, c)  NULL
 #define cs_pm_unregister_all(a) 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/esssolo1.c 940-combined-pm_message_t-patch-new/sound/oss/esssolo1.c
--- 940-combined-pm_message_t-patch-old/sound/oss/esssolo1.c	2004-12-10 14:26:33.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/esssolo1.c	2005-02-14 09:26:35.000000000 +1100
@@ -2257,7 +2257,7 @@ static int setup_solo1(struct solo1_stat
 }
 
 static int
-solo1_suspend(struct pci_dev *pci_dev, u32 state) {
+solo1_suspend(struct pci_dev *pci_dev, pm_message_t state) {
 	struct solo1_state *s = (struct solo1_state*)pci_get_drvdata(pci_dev);
 	if (!s)
 		return 1;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/i810_audio.c 940-combined-pm_message_t-patch-new/sound/oss/i810_audio.c
--- 940-combined-pm_message_t-patch-old/sound/oss/i810_audio.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/i810_audio.c	2005-02-14 09:26:35.000000000 +1100
@@ -3470,7 +3470,7 @@ static void __devexit i810_remove(struct
 }
 
 #ifdef CONFIG_PM
-static int i810_pm_suspend(struct pci_dev *dev, u32 pm_state)
+static int i810_pm_suspend(struct pci_dev *dev, pm_message_t pm_state)
 {
         struct i810_card *card = pci_get_drvdata(dev);
         struct i810_state *state;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/maestro3.c 940-combined-pm_message_t-patch-new/sound/oss/maestro3.c
--- 940-combined-pm_message_t-patch-old/sound/oss/maestro3.c	2005-02-03 22:33:55.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/maestro3.c	2005-02-14 09:26:35.000000000 +1100
@@ -375,7 +375,7 @@ static struct m3_card *devs;
  * I'm not very good at laying out functions in a file :)
  */
 static int m3_notifier(struct notifier_block *nb, unsigned long event, void *buf);
-static int m3_suspend(struct pci_dev *pci_dev, u32 state);
+static int m3_suspend(struct pci_dev *pci_dev, pm_message_t state);
 static void check_suspend(struct m3_card *card);
 
 static struct notifier_block m3_reboot_nb = {
@@ -2777,12 +2777,12 @@ static int m3_notifier(struct notifier_b
 
     for(card = devs; card != NULL; card = card->next) {
         if(!card->in_suspend)
-            m3_suspend(card->pcidev, 3); /* XXX legal? */
+            m3_suspend(card->pcidev, PMSG_SUSPEND); /* XXX legal? */
     }
     return 0;
 }
 
-static int m3_suspend(struct pci_dev *pci_dev, u32 state)
+static int m3_suspend(struct pci_dev *pci_dev, pm_message_t state)
 {
     unsigned long flags;
     int i;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/trident.c 940-combined-pm_message_t-patch-new/sound/oss/trident.c
--- 940-combined-pm_message_t-patch-old/sound/oss/trident.c	2005-02-03 22:33:56.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/trident.c	2005-02-14 09:26:35.000000000 +1100
@@ -487,7 +487,7 @@ static struct trident_channel *ali_alloc
 static struct trident_channel *ali_alloc_pcm_channel(struct trident_card *card);
 static void ali_restore_regs(struct trident_card *card);
 static void ali_save_regs(struct trident_card *card);
-static int trident_suspend(struct pci_dev *dev, u32 unused);
+static int trident_suspend(struct pci_dev *dev, pm_message_t unused);
 static int trident_resume(struct pci_dev *dev);
 static void ali_free_pcm_channel(struct trident_card *card, unsigned int channel);
 static int ali_setup_multi_channels(struct trident_card *card, int chan_nums);
@@ -3723,7 +3723,7 @@ ali_restore_regs(struct trident_card *ca
 }
 
 static int
-trident_suspend(struct pci_dev *dev, u32 unused)
+trident_suspend(struct pci_dev *dev, pm_message_t unused)
 {
 	struct trident_card *card = pci_get_drvdata(dev);
 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/oss/ymfpci.c 940-combined-pm_message_t-patch-new/sound/oss/ymfpci.c
--- 940-combined-pm_message_t-patch-old/sound/oss/ymfpci.c	2005-02-03 22:33:56.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/oss/ymfpci.c	2005-02-14 09:26:35.000000000 +1100
@@ -2074,7 +2074,7 @@ static /*const*/ struct file_operations 
 /*
  */
 
-static int ymf_suspend(struct pci_dev *pcidev, u32 unused)
+static int ymf_suspend(struct pci_dev *pcidev, pm_message_t unused)
 {
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/ali5451/ali5451.c 940-combined-pm_message_t-patch-new/sound/pci/ali5451/ali5451.c
--- 940-combined-pm_message_t-patch-old/sound/pci/ali5451/ali5451.c	2005-02-03 22:33:56.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/ali5451/ali5451.c	2005-02-14 09:26:36.000000000 +1100
@@ -1894,7 +1894,7 @@ static int __devinit snd_ali_mixer(ali_t
 }
 
 #ifdef CONFIG_PM
-static int ali_suspend(snd_card_t *card, unsigned int state)
+static int ali_suspend(snd_card_t *card, pm_message_t state)
 {
 	ali_t *chip = card->pm_private_data;
 	ali_image_t *im;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/atiixp.c 940-combined-pm_message_t-patch-new/sound/pci/atiixp.c
--- 940-combined-pm_message_t-patch-old/sound/pci/atiixp.c	2005-02-14 09:05:27.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/atiixp.c	2005-02-14 09:26:36.000000000 +1100
@@ -1398,7 +1398,7 @@ static int __devinit snd_atiixp_mixer_ne
 /*
  * power management
  */
-static int snd_atiixp_suspend(snd_card_t *card, unsigned int state)
+static int snd_atiixp_suspend(snd_card_t *card, pm_message_t state)
 {
 	atiixp_t *chip = card->pm_private_data;
 	int i;
@@ -1412,7 +1412,7 @@ static int snd_atiixp_suspend(snd_card_t
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1423,7 +1423,7 @@ static int snd_atiixp_resume(snd_card_t 
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/atiixp_modem.c 940-combined-pm_message_t-patch-new/sound/pci/atiixp_modem.c
--- 940-combined-pm_message_t-patch-old/sound/pci/atiixp_modem.c	2005-02-03 22:33:56.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/atiixp_modem.c	2005-02-14 09:26:36.000000000 +1100
@@ -1108,7 +1108,7 @@ static int __devinit snd_atiixp_mixer_ne
 /*
  * power management
  */
-static int snd_atiixp_suspend(snd_card_t *card, unsigned int state)
+static int snd_atiixp_suspend(snd_card_t *card, pm_message_t state)
 {
 	atiixp_t *chip = card->pm_private_data;
 	int i;
@@ -1122,7 +1122,7 @@ static int snd_atiixp_suspend(snd_card_t
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1133,7 +1133,7 @@ static int snd_atiixp_resume(snd_card_t 
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/cs4281.c 940-combined-pm_message_t-patch-new/sound/pci/cs4281.c
--- 940-combined-pm_message_t-patch-old/sound/pci/cs4281.c	2005-02-03 22:33:56.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/cs4281.c	2005-02-14 09:26:36.000000000 +1100
@@ -1376,7 +1376,7 @@ static int snd_cs4281_dev_free(snd_devic
 
 static int snd_cs4281_chip_init(cs4281_t *chip); /* defined below */
 #ifdef CONFIG_PM
-static int cs4281_suspend(snd_card_t *card, unsigned int state);
+static int cs4281_suspend(snd_card_t *card, pm_message_t state);
 static int cs4281_resume(snd_card_t *card, unsigned int state);
 #endif
 
@@ -2037,7 +2037,7 @@ static int saved_regs[SUSPEND_REGISTERS]
 
 #define CLKCR1_CKRA                             0x00010000L
 
-static int cs4281_suspend(snd_card_t *card, unsigned int state)
+static int cs4281_suspend(snd_card_t *card, pm_message_t state)
 {
 	cs4281_t *chip = card->pm_private_data;
 	u32 ulCLK;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/cs46xx/cs46xx_lib.c 940-combined-pm_message_t-patch-new/sound/pci/cs46xx/cs46xx_lib.c
--- 940-combined-pm_message_t-patch-old/sound/pci/cs46xx/cs46xx_lib.c	2005-02-03 22:33:56.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/cs46xx/cs46xx_lib.c	2005-02-14 09:26:36.000000000 +1100
@@ -3704,7 +3704,7 @@ static struct cs_card_type __devinitdata
  * APM support
  */
 #ifdef CONFIG_PM
-static int snd_cs46xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_cs46xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	cs46xx_t *chip = card->pm_private_data;
 	int amp_saved;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/es1938.c 940-combined-pm_message_t-patch-new/sound/pci/es1938.c
--- 940-combined-pm_message_t-patch-old/sound/pci/es1938.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/es1938.c	2005-02-14 09:26:36.000000000 +1100
@@ -1381,7 +1381,7 @@ static unsigned char saved_regs[SAVED_RE
 };
 
 
-static int es1938_suspend(snd_card_t *card, unsigned int state)
+static int es1938_suspend(snd_card_t *card, pm_message_t state)
 {
 	es1938_t *chip = card->pm_private_data;
 	unsigned char *s, *d;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/es1968.c 940-combined-pm_message_t-patch-new/sound/pci/es1968.c
--- 940-combined-pm_message_t-patch-old/sound/pci/es1968.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/es1968.c	2005-02-14 09:26:36.000000000 +1100
@@ -2404,7 +2404,7 @@ static void snd_es1968_start_irq(es1968_
 /*
  * PM support
  */
-static int es1968_suspend(snd_card_t *card, unsigned int state)
+static int es1968_suspend(snd_card_t *card, pm_message_t state)
 {
 	es1968_t *chip = card->pm_private_data;
 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/intel8x0.c 940-combined-pm_message_t-patch-new/sound/pci/intel8x0.c
--- 940-combined-pm_message_t-patch-old/sound/pci/intel8x0.c	2005-02-14 09:05:27.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/intel8x0.c	2005-02-14 09:26:36.000000000 +1100
@@ -2320,7 +2320,7 @@ static int snd_intel8x0_free(intel8x0_t 
 /*
  * power management
  */
-static int intel8x0_suspend(snd_card_t *card, unsigned int state)
+static int intel8x0_suspend(snd_card_t *card, pm_message_t state)
 {
 	intel8x0_t *chip = card->pm_private_data;
 	int i;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/intel8x0m.c 940-combined-pm_message_t-patch-new/sound/pci/intel8x0m.c
--- 940-combined-pm_message_t-patch-old/sound/pci/intel8x0m.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/intel8x0m.c	2005-02-14 09:26:36.000000000 +1100
@@ -1078,7 +1078,7 @@ static int snd_intel8x0_free(intel8x0_t 
 /*
  * power management
  */
-static int intel8x0m_suspend(snd_card_t *card, unsigned int state)
+static int intel8x0m_suspend(snd_card_t *card, pm_message_t state)
 {
 	intel8x0_t *chip = card->pm_private_data;
 	int i;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/maestro3.c 940-combined-pm_message_t-patch-new/sound/pci/maestro3.c
--- 940-combined-pm_message_t-patch-old/sound/pci/maestro3.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/maestro3.c	2005-02-14 09:26:36.000000000 +1100
@@ -2385,7 +2385,7 @@ static int snd_m3_free(m3_t *chip)
  * APM support
  */
 #ifdef CONFIG_PM
-static int m3_suspend(snd_card_t *card, unsigned int state)
+static int m3_suspend(snd_card_t *card, pm_message_t state)
 {
 	m3_t *chip = card->pm_private_data;
 	int i, index;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/nm256/nm256.c 940-combined-pm_message_t-patch-new/sound/pci/nm256/nm256.c
--- 940-combined-pm_message_t-patch-old/sound/pci/nm256/nm256.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/nm256/nm256.c	2005-02-14 09:26:36.000000000 +1100
@@ -1267,7 +1267,7 @@ snd_nm256_peek_for_sig(nm256_t *chip)
  * APM event handler, so the card is properly reinitialized after a power
  * event.
  */
-static int nm256_suspend(snd_card_t *card, unsigned int state)
+static int nm256_suspend(snd_card_t *card, pm_message_t state)
 {
 	nm256_t *chip = card->pm_private_data;
 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/trident/trident_main.c 940-combined-pm_message_t-patch-new/sound/pci/trident/trident_main.c
--- 940-combined-pm_message_t-patch-old/sound/pci/trident/trident_main.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/trident/trident_main.c	2005-02-14 09:26:36.000000000 +1100
@@ -48,7 +48,7 @@ static int snd_trident_pcm_mixer_build(t
 static int snd_trident_pcm_mixer_free(trident_t *trident, snd_trident_voice_t * voice, snd_pcm_substream_t *substream);
 static irqreturn_t snd_trident_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 #ifdef CONFIG_PM
-static int snd_trident_suspend(snd_card_t *card, unsigned int state);
+static int snd_trident_suspend(snd_card_t *card, pm_message_t state);
 static int snd_trident_resume(snd_card_t *card, unsigned int state);
 #endif
 static int snd_trident_sis_reset(trident_t *trident);
@@ -3921,7 +3921,7 @@ static void snd_trident_clear_voices(tri
 }
 
 #ifdef CONFIG_PM
-static int snd_trident_suspend(snd_card_t *card, unsigned int state)
+static int snd_trident_suspend(snd_card_t *card, pm_message_t state)
 {
 	trident_t *trident = card->pm_private_data;
 
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/via82xx.c 940-combined-pm_message_t-patch-new/sound/pci/via82xx.c
--- 940-combined-pm_message_t-patch-old/sound/pci/via82xx.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/via82xx.c	2005-02-14 09:26:36.000000000 +1100
@@ -1895,7 +1895,7 @@ static int __devinit snd_via82xx_chip_in
 /*
  * power management
  */
-static int snd_via82xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_via82xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	via82xx_t *chip = card->pm_private_data;
 	int i;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/via82xx_modem.c 940-combined-pm_message_t-patch-new/sound/pci/via82xx_modem.c
--- 940-combined-pm_message_t-patch-old/sound/pci/via82xx_modem.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/via82xx_modem.c	2005-02-14 09:26:36.000000000 +1100
@@ -1034,7 +1034,7 @@ static int __devinit snd_via82xx_chip_in
 /*
  * power management
  */
-static int snd_via82xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_via82xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	via82xx_t *chip = card->pm_private_data;
 	int i;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pci/ymfpci/ymfpci_main.c 940-combined-pm_message_t-patch-new/sound/pci/ymfpci/ymfpci_main.c
--- 940-combined-pm_message_t-patch-old/sound/pci/ymfpci/ymfpci_main.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pci/ymfpci/ymfpci_main.c	2005-02-14 09:26:36.000000000 +1100
@@ -2142,7 +2142,7 @@ static int saved_regs_index[] = {
 };
 #define YDSXGR_NUM_SAVED_REGS	ARRAY_SIZE(saved_regs_index)
 
-static int snd_ymfpci_suspend(snd_card_t *card, unsigned int state)
+static int snd_ymfpci_suspend(snd_card_t *card, pm_message_t state)
 {
 	ymfpci_t *chip = card->pm_private_data;
 	unsigned int i;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pcmcia/pdaudiocf/pdaudiocf.c 940-combined-pm_message_t-patch-new/sound/pcmcia/pdaudiocf/pdaudiocf.c
--- 940-combined-pm_message_t-patch-old/sound/pcmcia/pdaudiocf/pdaudiocf.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pcmcia/pdaudiocf/pdaudiocf.c	2005-02-14 09:26:36.000000000 +1100
@@ -342,7 +342,7 @@ static int pdacf_event(event_t event, in
 		link->state |= DEV_SUSPEND;
 		if (chip) {
 			snd_printdd(KERN_DEBUG "snd_pdacf_suspend calling\n");
-			snd_pdacf_suspend(chip->card, 0);
+			snd_pdacf_suspend(chip->card, PMSG_SUSPEND);
 		}
 		/* Fall through... */
 	case CS_EVENT_RESET_PHYSICAL:
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pcmcia/pdaudiocf/pdaudiocf_core.c 940-combined-pm_message_t-patch-new/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
--- 940-combined-pm_message_t-patch-old/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2005-02-14 09:26:36.000000000 +1100
@@ -255,7 +255,7 @@ void snd_pdacf_powerdown(pdacf_t *chip)
 
 #ifdef CONFIG_PM
 
-int snd_pdacf_suspend(snd_card_t *card, unsigned int state)
+int snd_pdacf_suspend(snd_card_t *card, pm_message_t state)
 {
 	pdacf_t *chip = card->pm_private_data;
 	u16 val;
diff -ruNp 940-combined-pm_message_t-patch-old/sound/pcmcia/pdaudiocf/pdaudiocf.h 940-combined-pm_message_t-patch-new/sound/pcmcia/pdaudiocf/pdaudiocf.h
--- 940-combined-pm_message_t-patch-old/sound/pcmcia/pdaudiocf/pdaudiocf.h	2005-02-03 22:33:57.000000000 +1100
+++ 940-combined-pm_message_t-patch-new/sound/pcmcia/pdaudiocf/pdaudiocf.h	2005-02-14 09:26:36.000000000 +1100
@@ -134,7 +134,7 @@ pdacf_t *snd_pdacf_create(snd_card_t *ca
 int snd_pdacf_ak4117_create(pdacf_t *pdacf);
 void snd_pdacf_powerdown(pdacf_t *chip);
 #ifdef CONFIG_PM
-int snd_pdacf_suspend(snd_card_t *card, unsigned int state);
+int snd_pdacf_suspend(snd_card_t *card, pm_message_t state);
 int snd_pdacf_resume(snd_card_t *card, unsigned int state);
 #endif
 int snd_pdacf_pcm_new(pdacf_t *chip);


