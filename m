Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVAYT5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVAYT5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVAYT5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:57:22 -0500
Received: from gprs213-152.eurotel.cz ([160.218.213.152]:24192 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262109AbVAYTsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:48:01 -0500
Date: Tue, 25 Jan 2005 20:47:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel-janitors@osdl.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-pm@osdl.org, benh@kernel.crashing.org
Subject: driver model u32 -> pm_message_t conversion: help needed
Message-ID: <20050125194710.GA1711@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Two Long time ago, BenH said that making patches is easy, so I hope to
get his help now... And will probably need more.

Suspend routines change, slowly. 

-       int             (*suspend)(struct device * dev, u32 state);
+       int             (*suspend)(struct device * dev, pm_message_t state);

For now u32 is typedef-ed to pm_message_t, but that is not going to be
the case for 2.6.12. What needs to be done is changing all state
parameters from u32 to pm_message_t. suspend() functions should not
use state variable for now (except for PCI ones, those are allowed to
call pci_choose_state and convert state into pci_power_t, and use
that).

I already converted bunch of drivers in -rc2-mm1, patches look like
this:

--- clean/drivers/char/agp/via-agp.c    2005-01-22 02:49:22.000000000 +0100
+++ linux/drivers/char/agp/via-agp.c    2005-01-19 11:59:12.000000000 +0100
@@ -440,10 +440,10 @@

 #ifdef CONFIG_PM

-static int agp_via_suspend(struct pci_dev *pdev, u32 state)
+static int agp_via_suspend(struct pci_dev *pdev, pm_message_t state)
 {
        pci_save_state (pdev);
-       pci_set_power_state (pdev, 3);
+       pci_set_power_state (pdev, PCI_D3hot);

        return 0;
 }

Now, if you want to help, just convert some drivers... To quickly
break compilation in case of bad types, following patch can be used
(against 2.6.11-rc2-mm1), it actually switches pm_message_t to
typedef.

I'm looking forward to the patches, (please help),
								Pavel

--- clean-mm/drivers/base/power/resume.c	2005-01-22 02:48:48.000000000 +0100
+++ linux-mm/drivers/base/power/resume.c	2005-01-25 20:27:26.000000000 +0100
@@ -41,7 +41,7 @@
 		list_add_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state)
+		if (!dev->power.prev_state.event)
 			resume_device(dev);
 		down(&dpm_list_sem);
 		put_device(dev);
--- clean-mm/drivers/base/power/runtime.c	2005-01-22 02:48:35.000000000 +0100
+++ linux-mm/drivers/base/power/runtime.c	2005-01-25 20:27:26.000000000 +0100
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
 
 
@@ -49,10 +49,10 @@
 	int error = 0;
 
 	down(&dpm_sem);
-	if (dev->power.power_state == state)
+	if (dev->power.power_state.event == state.event)
 		goto Done;
 
-	if (dev->power.power_state)
+	if (dev->power.power_state.event)
 		runtime_resume(dev);
 
 	if (!(error = suspend_device(dev, state)))
--- clean-mm/drivers/base/power/shutdown.c	2005-01-22 02:48:28.000000000 +0100
+++ linux-mm/drivers/base/power/shutdown.c	2005-01-25 20:27:26.000000000 +0100
@@ -29,7 +29,8 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	/* FIXME */
+	return dpm_runtime_suspend(dev, PMSG_FREEZE);
 }
 
 
--- clean-mm/drivers/base/power/suspend.c	2005-01-22 02:48:48.000000000 +0100
+++ linux-mm/drivers/base/power/suspend.c	2005-01-25 20:27:26.000000000 +0100
@@ -43,7 +43,7 @@
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state)
+	if (dev->bus && dev->bus->suspend && (!dev->power.power_state.event))
 		error = dev->bus->suspend(dev, state);
 
 	return error;
--- clean-mm/drivers/base/power/sysfs.c	2005-01-22 02:49:20.000000000 +0100
+++ linux-mm/drivers/base/power/sysfs.c	2005-01-25 20:27:26.000000000 +0100
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
--- clean-mm/drivers/ide/ide.c	2005-01-25 18:24:07.000000000 +0100
+++ linux-mm/drivers/ide/ide.c	2005-01-25 20:27:28.000000000 +0100
@@ -1403,7 +1403,7 @@
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state;
+	rqpm.pm_state = state.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
--- clean-mm/drivers/ieee1394/nodemgr.c	2005-01-25 18:24:07.000000000 +0100
+++ linux-mm/drivers/ieee1394/nodemgr.c	2005-01-25 20:27:28.000000000 +0100
@@ -1254,7 +1254,7 @@
 
 		if (ud->device.driver &&
 		    (!ud->device.driver->suspend ||
-		      ud->device.driver->suspend(&ud->device, 0, 0)))
+		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND, 0)))
 			device_release_driver(&ud->device);
 	}
 	up_write(&ne->device.bus->subsys.rwsem);
--- clean-mm/drivers/pci/pci.c	2005-01-25 18:24:10.000000000 +0100
+++ linux-mm/drivers/pci/pci.c	2005-01-25 20:30:26.000000000 +0100
@@ -312,7 +312,8 @@
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system
+ * @state: target sleep state for the whole system. This is the value
+ *	that is passed to suspend() function.
  *
  * Returns PCI power state suitable for given device and given system
  * message.
@@ -323,11 +324,15 @@
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
--- clean-mm/drivers/usb/core/hcd-pci.c	2005-01-25 18:24:11.000000000 +0100
+++ linux-mm/drivers/usb/core/hcd-pci.c	2005-01-25 20:27:28.000000000 +0100
@@ -71,7 +71,7 @@
 	if (pci_enable_device (dev) < 0)
 		return -ENODEV;
 	dev->current_state = 0;
-	dev->dev.power.power_state = 0;
+	dev->dev.power.power_state.event = 0;
 	
         if (!dev->irq) {
         	dev_err (&dev->dev,
@@ -363,9 +363,6 @@
 		break;
 	}
 
-	/* update power_state **ONLY** to make sysfs happier */
-	if (retval == 0)
-		dev->dev.power.power_state = state;
 	return retval;
 }
 EXPORT_SYMBOL (usb_hcd_pci_suspend);
--- clean-mm/drivers/usb/core/usb.c	2005-01-25 18:24:11.000000000 +0100
+++ linux-mm/drivers/usb/core/usb.c	2005-01-25 20:27:28.000000000 +0100
@@ -1364,7 +1364,7 @@
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
--- clean-mm/drivers/video/aty/radeon_pm.c	2005-01-25 18:24:12.000000000 +0100
+++ linux-mm/drivers/video/aty/radeon_pm.c	2005-01-25 20:37:57.000000000 +0100
@@ -2509,18 +2509,18 @@
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
 		printk("suspending to disk but state = %d\n", state);
@@ -2596,7 +2596,7 @@
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (!pdev->dev.power.power_state.event)
 		return 0;
 
 	if (rinfo->no_schedule) {
@@ -2617,7 +2617,7 @@
 	}
 	pci_set_master(pdev);
 
-	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+	if (pdev->dev.power.power_state.event == EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
--- clean-mm/include/linux/pm.h	2005-01-22 02:48:21.000000000 +0100
+++ linux-mm/include/linux/pm.h	2005-01-25 20:27:30.000000000 +0100
@@ -195,7 +195,10 @@
 
 struct device;
 
-typedef u32 __bitwise pm_message_t;
+typedef struct pm_message {
+	int event;
+	int flags;
+} pm_message_t;
 
 /*
  * There are 4 important states driver can be in:
@@ -215,9 +218,16 @@
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
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' -x '*.cmd' -x '*kallsyms?.S' -x config -x config_data.h -x ikconfig.h -x '.tmp_*' clean-mm/include/sound/core.h linux-mm/include/sound/core.h
--- clean-mm/include/sound/core.h	2005-01-22 02:49:19.000000000 +0100
+++ linux-mm/include/sound/core.h	2005-01-25 20:27:30.000000000 +0100
@@ -26,6 +26,7 @@
 #include <asm/semaphore.h>		/* struct semaphore */
 #include <linux/rwsem.h>		/* struct rw_semaphore */
 #include <linux/workqueue.h>		/* struct workqueue_struct */
+#include <linux/pm.h>			/* pm_message_t */
 
 /* Typedef's */
 typedef struct timespec snd_timestamp_t;
@@ -206,18 +207,18 @@
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
--- clean-mm/sound/core/init.c	2005-01-25 18:24:13.000000000 +0100
+++ linux-mm/sound/core/init.c	2005-01-25 20:27:30.000000000 +0100
@@ -719,7 +719,7 @@
  * handler and from the control API.
  */
 int snd_card_set_pm_callback(snd_card_t *card,
-			     int (*suspend)(snd_card_t *, unsigned int),
+			     int (*suspend)(snd_card_t *, pm_message_t),
 			     int (*resume)(snd_card_t *, unsigned int),
 			     void *private_data)
 {
@@ -765,7 +765,7 @@
  * from the ALSA's common PM handler and from the control API.
  */
 int snd_card_set_dev_pm_callback(snd_card_t *card, int type,
-				 int (*suspend)(snd_card_t *, unsigned int),
+				 int (*suspend)(snd_card_t *, pm_message_t),
 				 int (*resume)(snd_card_t *, unsigned int),
 				 void *private_data)
 {
@@ -778,7 +778,7 @@
 }
 
 #ifdef CONFIG_PCI
-int snd_card_pci_suspend(struct pci_dev *dev, u32 state)
+int snd_card_pci_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	snd_card_t *card = pci_get_drvdata(dev);
 	int err;
--- clean-mm/sound/pci/es1968.c	2005-01-22 02:48:34.000000000 +0100
+++ linux-mm/sound/pci/es1968.c	2005-01-25 20:27:30.000000000 +0100
@@ -2404,7 +2404,7 @@
 /*
  * PM support
  */
-static int es1968_suspend(snd_card_t *card, unsigned int state)
+static int es1968_suspend(snd_card_t *card, pm_message_t state)
 {
 	es1968_t *chip = card->pm_private_data;
 
--- clean-mm/sound/pci/intel8x0.c	2005-01-25 18:24:13.000000000 +0100
+++ linux-mm/sound/pci/intel8x0.c	2005-01-25 20:27:30.000000000 +0100
@@ -2320,7 +2320,7 @@
 /*
  * power management
  */
-static int intel8x0_suspend(snd_card_t *card, unsigned int state)
+static int intel8x0_suspend(snd_card_t *card, pm_message_t state)
 {
 	intel8x0_t *chip = card->pm_private_data;
 	int i;
--- clean-mm/sound/pci/maestro3.c	2005-01-22 02:48:21.000000000 +0100
+++ linux-mm/sound/pci/maestro3.c	2005-01-25 20:27:30.000000000 +0100
@@ -2385,7 +2385,7 @@
  * APM support
  */
 #ifdef CONFIG_PM
-static int m3_suspend(snd_card_t *card, unsigned int state)
+static int m3_suspend(snd_card_t *card, pm_message_t state)
 {
 	m3_t *chip = card->pm_private_data;
 	int i, index;
--- clean-mm/sound/pci/via82xx.c	2005-01-22 02:48:48.000000000 +0100
+++ linux-mm/sound/pci/via82xx.c	2005-01-25 20:27:30.000000000 +0100
@@ -1895,7 +1895,7 @@
 /*
  * power management
  */
-static int snd_via82xx_suspend(snd_card_t *card, unsigned int state)
+static int snd_via82xx_suspend(snd_card_t *card, pm_message_t state)
 {
 	via82xx_t *chip = card->pm_private_data;
 	int i;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
