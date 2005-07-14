Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVGNAtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVGNAtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVGNArK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:47:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54955 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262858AbVGNAqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:46:19 -0400
Date: Thu, 14 Jul 2005 02:45:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 03/04] swsusp: switch pm_message_t to struct
Message-ID: <20050714004549.GC7836@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@ucw.cz>

This adds type-checking to pm_message_t, so that people can't confuse
it with int or u32.  It also allows us to fix "disk yoyo" during
suspend (disk spinning down/up/down).

[We've tried that before; since that cpufreq problems were fixed and
I've tried make allyes config and fixed resulting damage.]

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit e006f49294867a0602b9bdf1f9b85009bdde31ba
tree 8b9ea20d1c0e9bf2bbb5575cbd0ad3fd102870a4
parent 9f2554eb9485d7e7a749515dfc4834c86d4e0010
author <pavel@amd.(none)> Thu, 14 Jul 2005 01:22:25 +0200
committer <pavel@amd.(none)> Thu, 14 Jul 2005 01:22:25 +0200

 drivers/base/power/resume.c             |    8 ++++----
 drivers/base/power/runtime.c            |    8 ++++----
 drivers/base/power/suspend.c            |   12 ++++++------
 drivers/base/power/sysfs.c              |    8 ++++----
 drivers/ide/ide.c                       |    4 ++--
 drivers/ide/pci/sc1200.c                |   12 ++++++------
 drivers/ide/ppc/pmac.c                  |    8 ++++----
 drivers/macintosh/mediabay.c            |    4 ++--
 drivers/macintosh/via-pmu.c             |    2 +-
 drivers/media/dvb/cinergyT2/cinergyT2.c |    2 +-
 drivers/net/irda/vlsi_ir.c              |   10 +++++-----
 drivers/net/wireless/airo.c             |   10 +++++-----
 drivers/pci/pci.c                       |   16 ++++++++++------
 drivers/serial/pmac_zilog.c             |    4 ++--
 drivers/usb/core/hub.c                  |   18 +++++++++---------
 drivers/usb/core/usb.c                  |    2 +-
 drivers/usb/host/ehci-dbg.c             |    2 +-
 drivers/usb/host/ohci-dbg.c             |    2 +-
 drivers/usb/host/sl811-hcd.c            |    6 +++---
 drivers/usb/misc/usbtest.c              |    2 +-
 drivers/video/aty/aty128fb.c            |   14 ++++++--------
 drivers/video/aty/atyfb_base.c          |   11 +++++------
 drivers/video/aty/radeon_pm.c           |   12 ++++++------
 drivers/video/i810/i810_main.c          |    6 +++---
 include/linux/pm.h                      |   14 ++++++++++----
 25 files changed, 102 insertions(+), 95 deletions(-)

diff --git a/drivers/base/power/resume.c b/drivers/base/power/resume.c
--- a/drivers/base/power/resume.c
+++ b/drivers/base/power/resume.c
@@ -26,11 +26,11 @@ int resume_device(struct device * dev)
 
 	down(&dev->sem);
 	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state) {
+			&& dev->power.pm_parent->power.power_state.event) {
 		dev_err(dev, "PM: resume from %d, parent %s still %d\n",
-			dev->power.power_state,
+			dev->power.power_state.event,
 			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state);
+			dev->power.pm_parent->power.power_state.event);
 	}
 	if (dev->bus && dev->bus->resume) {
 		dev_dbg(dev,"resuming\n");
@@ -54,7 +54,7 @@ void dpm_resume(void)
 		list_add_tail(entry, &dpm_active);
 
 		up(&dpm_list_sem);
-		if (!dev->power.prev_state)
+		if (!dev->power.prev_state.event)
 			resume_device(dev);
 		down(&dpm_list_sem);
 		put_device(dev);
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
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
diff --git a/drivers/base/power/suspend.c b/drivers/base/power/suspend.c
--- a/drivers/base/power/suspend.c
+++ b/drivers/base/power/suspend.c
@@ -40,22 +40,22 @@ int suspend_device(struct device * dev, 
 	int error = 0;
 
 	down(&dev->sem);
-	if (dev->power.power_state) {
+	if (dev->power.power_state.event) {
 		dev_dbg(dev, "PM: suspend %d-->%d\n",
-			dev->power.power_state, state);
+			dev->power.power_state.event, state.event);
 	}
 	if (dev->power.pm_parent
-			&& dev->power.pm_parent->power.power_state) {
+			&& dev->power.pm_parent->power.power_state.event) {
 		dev_err(dev,
 			"PM: suspend %d->%d, parent %s already %d\n",
-			dev->power.power_state, state,
+			dev->power.power_state.event, state.event,
 			dev->power.pm_parent->bus_id,
-			dev->power.pm_parent->power.power_state);
+			dev->power.pm_parent->power.power_state.event);
 	}
 
 	dev->power.prev_state = dev->power.power_state;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state) {
+	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
 		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
 	}
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -26,19 +26,19 @@
 
 static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
 {
-	return sprintf(buf, "%u\n", dev->power.power_state);
+	return sprintf(buf, "%u\n", dev->power.power_state.event);
 }
 
 static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
 {
-	u32 state;
+	pm_message_t state;
 	char * rest;
 	int error = 0;
 
-	state = simple_strtoul(buf, &rest, 10);
+	state.event = simple_strtoul(buf, &rest, 10);
 	if (*rest)
 		return -EINVAL;
-	if (state)
+	if (state.event)
 		error = dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1229,7 +1229,7 @@ static int generic_ide_suspend(struct de
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state;
+	rqpm.pm_state = state.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
@@ -1248,7 +1248,7 @@ static int generic_ide_resume(struct dev
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_resume;
-	rqpm.pm_state = 0;
+	rqpm.pm_state = PM_EVENT_ON;
 
 	return ide_do_drive_cmd(drive, &rq, ide_head_wait);
 }
diff --git a/drivers/ide/pci/sc1200.c b/drivers/ide/pci/sc1200.c
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -350,9 +350,9 @@ static int sc1200_suspend (struct pci_de
 {
 	ide_hwif_t		*hwif = NULL;
 
-	printk("SC1200: suspend(%u)\n", state);
+	printk("SC1200: suspend(%u)\n", state.event);
 
-	if (state == 0) {
+	if (state.event == PM_EVENT_ON) {
 		// we only save state when going from full power to less
 
 		//
@@ -386,8 +386,8 @@ static int sc1200_suspend (struct pci_de
 	/* You don't need to iterate over disks -- sysfs should have done that for you already */ 
 
 	pci_disable_device(dev);
-	pci_set_power_state(dev,state);
-	dev->current_state = state;
+	pci_set_power_state(dev, pci_choose_state(dev, state));
+	dev->current_state = state.event;
 	return 0;
 }
 
@@ -396,8 +396,8 @@ static int sc1200_resume (struct pci_dev
 	ide_hwif_t	*hwif = NULL;
 
 printk("SC1200: resume\n");
-	pci_set_power_state(dev,0);	// bring chip back from sleep state
-	dev->current_state = 0;
+	pci_set_power_state(dev, PCI_D0);	// bring chip back from sleep state
+	dev->current_state = PM_EVENT_ON;
 	pci_enable_device(dev);
 	//
 	// loop over all interfaces that are part of this pci device:
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1509,7 +1509,7 @@ pmac_ide_macio_suspend(struct macio_dev 
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 
-	if (state != mdev->ofdev.dev.power.power_state && state >= 2) {
+	if (state.event != mdev->ofdev.dev.power.power_state.event && state.event >= PM_EVENT_SUSPEND) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			mdev->ofdev.dev.power.power_state = state;
@@ -1524,7 +1524,7 @@ pmac_ide_macio_resume(struct macio_dev *
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 	
-	if (mdev->ofdev.dev.power.power_state != 0) {
+	if (mdev->ofdev.dev.power.power_state.event != PM_EVENT_ON) {
 		rc = pmac_ide_do_resume(hwif);
 		if (rc == 0)
 			mdev->ofdev.dev.power.power_state = PMSG_ON;
@@ -1613,7 +1613,7 @@ pmac_ide_pci_suspend(struct pci_dev *pde
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (state != pdev->dev.power.power_state && state >= 2) {
+	if (state.event != pdev->dev.power.power_state.event && state.event >= 2) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			pdev->dev.power.power_state = state;
@@ -1628,7 +1628,7 @@ pmac_ide_pci_resume(struct pci_dev *pdev
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (pdev->dev.power.power_state != 0) {
+	if (pdev->dev.power.power_state.event != PM_EVENT_ON) {
 		rc = pmac_ide_do_resume(hwif);
 		if (rc == 0)
 			pdev->dev.power.power_state = PMSG_ON;
diff --git a/drivers/macintosh/mediabay.c b/drivers/macintosh/mediabay.c
--- a/drivers/macintosh/mediabay.c
+++ b/drivers/macintosh/mediabay.c
@@ -708,7 +708,7 @@ static int __pmac media_bay_suspend(stru
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (state != mdev->ofdev.dev.power.power_state && state == PM_SUSPEND_MEM) {
+	if (state.event != mdev->ofdev.dev.power.power_state.event && state.event == PM_EVENT_SUSPEND) {
 		down(&bay->lock);
 		bay->sleeping = 1;
 		set_mb_power(bay, 0);
@@ -723,7 +723,7 @@ static int __pmac media_bay_resume(struc
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (mdev->ofdev.dev.power.power_state != 0) {
+	if (mdev->ofdev.dev.power.power_state.event != PM_EVENT_ON) {
 		mdev->ofdev.dev.power.power_state = PMSG_ON;
 
 	       	/* We re-enable the bay using it's previous content
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -3065,7 +3065,7 @@ static int pmu_sys_suspended = 0;
 
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
-	if (state != PM_SUSPEND_DISK || pmu_sys_suspended)
+	if (state.event != PM_EVENT_SUSPEND || pmu_sys_suspended)
 		return 0;
 
 	/* Suspend PMU event interrupts */
diff --git a/drivers/media/dvb/cinergyT2/cinergyT2.c b/drivers/media/dvb/cinergyT2/cinergyT2.c
--- a/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ b/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -888,7 +888,7 @@ static int cinergyt2_suspend (struct usb
 	if (down_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
-	if (state > 0) {	/* state 0 seems to mean DEVICE_PM_ON */
+	if (state.event > PM_EVENT_ON) {
 		struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 #ifdef ENABLE_RC
 		cancel_delayed_work(&cinergyt2->rc_query_work);
diff --git a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
--- a/drivers/net/irda/vlsi_ir.c
+++ b/drivers/net/irda/vlsi_ir.c
@@ -1757,12 +1757,12 @@ static int vlsi_irda_suspend(struct pci_
 	idev = ndev->priv;	
 	down(&idev->sem);
 	if (pdev->current_state != 0) {			/* already suspended */
-		if (state > pdev->current_state) {	/* simply go deeper */
-			pci_set_power_state(pdev,state);
-			pdev->current_state = state;
+		if (state.event > pdev->current_state) {	/* simply go deeper */
+			pci_set_power_state(pdev, pci_choose_state(pdev, state));
+			pdev->current_state = state.event;
 		}
 		else
-			IRDA_ERROR("%s - %s: invalid suspend request %u -> %u\n", __FUNCTION__, PCIDEV_NAME(pdev), pdev->current_state, state);
+			IRDA_ERROR("%s - %s: invalid suspend request %u -> %u\n", __FUNCTION__, PCIDEV_NAME(pdev), pdev->current_state, state.event);
 		up(&idev->sem);
 		return 0;
 	}
@@ -1777,7 +1777,7 @@ static int vlsi_irda_suspend(struct pci_
 	}
 
 	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-	pdev->current_state = state;
+	pdev->current_state = state.event;
 	idev->resume_ok = 1;
 	up(&idev->sem);
 	return 0;
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -2232,7 +2232,7 @@ static void airo_read_stats(struct airo_
 	u32 *vals = stats_rid.vals;
 
 	clear_bit(JOB_STATS, &ai->flags);
-	if (ai->power) {
+	if (ai->power.event) {
 		up(&ai->sem);
 		return;
 	}
@@ -2962,7 +2962,7 @@ static int airo_thread(void *data) {
 			break;
 		}
 
-		if (ai->power || test_bit(FLAG_FLASHING, &ai->flags)) {
+		if (ai->power.event || test_bit(FLAG_FLASHING, &ai->flags)) {
 			up(&ai->sem);
 			continue;
 		}
@@ -5514,7 +5514,7 @@ static int airo_pci_resume(struct pci_de
 	pci_restore_state(pdev);
 	pci_enable_wake(pdev, pci_choose_state(pdev, ai->power), 0);
 
-	if (ai->power > 1) {
+	if (ai->power.event > 1) {
 		reset_card(dev, 0);
 		mpi_init_descriptors(ai);
 		setup_card(ai, dev->dev_addr, 0);
@@ -7116,7 +7116,7 @@ static int airo_ioctl(struct net_device 
 	int rc = 0;
 	struct airo_info *ai = (struct airo_info *)dev->priv;
 
-	if (ai->power)
+	if (ai->power.event)
 		return 0;
 
 	switch (cmd) {
@@ -7195,7 +7195,7 @@ static void airo_read_wireless_stats(str
 
 	/* Get stats out of the card */
 	clear_bit(JOB_WSTATS, &local->flags);
-	if (local->power) {
+	if (local->power.event) {
 		up(&local->sem);
 		return;
 	}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -333,13 +333,17 @@ pci_power_t pci_choose_state(struct pci_
 	if (platform_pci_choose_state) {
 		ret = platform_pci_choose_state(dev, state);
 		if (ret >= 0)
-			state = ret;
+			state.event = ret;
 	}
- 	switch (state) {
-	case 0: return PCI_D0;
-	case 3: return PCI_D3hot;
-	default:
-		printk("They asked me for state %d\n", state);
+
+	switch (state.event) {
+	case PM_EVENT_ON:
+		return PCI_D0;
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_SUSPEND:
+		return PCI_D3hot;
+	default: 
+		printk("They asked me for state %d\n", state.event);
 		BUG();
 	}
 	return PCI_D0;
diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -1601,7 +1601,7 @@ static int pmz_suspend(struct macio_dev 
 		return 0;
 	}
 
-	if (pm_state == mdev->ofdev.dev.power.power_state || pm_state < 2)
+	if (pm_state.event == mdev->ofdev.dev.power.power_state.event)
 		return 0;
 
 	pmz_debug("suspend, switching to state %d\n", pm_state);
@@ -1661,7 +1661,7 @@ static int pmz_resume(struct macio_dev *
 	if (uap == NULL)
 		return 0;
 
-	if (mdev->ofdev.dev.power.power_state == 0)
+	if (mdev->ofdev.dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 	
 	pmz_debug("resume, switching to state 0\n");
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1570,7 +1570,7 @@ static int __usb_suspend_device (struct 
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (state <= intf->dev.power.power_state)
+			if (state.event <= intf->dev.power.power_state.event)
 				continue;
 			if (!intf->dev.driver)
 				continue;
@@ -1578,11 +1578,11 @@ static int __usb_suspend_device (struct 
 
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
@@ -1595,7 +1595,7 @@ static int __usb_suspend_device (struct 
 			 * since we know every driver's probe/disconnect works
 			 * even for drivers that can't suspend.
 			 */
-			if (!driver->suspend || state > PM_SUSPEND_MEM) {
+			if (!driver->suspend || state.event > PM_EVENT_FREEZE) {
 #if 1
 				dev_warn(&intf->dev, "resume is unsafe!\n");
 #else
@@ -1616,7 +1616,7 @@ static int __usb_suspend_device (struct 
 	 * policies (when HNP doesn't apply) once we have mechanisms to
 	 * turn power back on!  (Likely not before 2.7...)
 	 */
-	if (state > PM_SUSPEND_MEM) {
+	if (state.event > PM_EVENT_FREEZE) {
 		dev_warn(&udev->dev, "no poweroff yet, suspending instead\n");
 	}
 
@@ -1733,7 +1733,7 @@ static int finish_port_resume(struct usb
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (intf->dev.power.power_state == PMSG_ON)
+			if (intf->dev.power.power_state.event == PM_EVENT_ON)
 				continue;
 			if (!intf->dev.driver) {
 				/* FIXME maybe force to alt 0 */
@@ -1747,11 +1747,11 @@ static int finish_port_resume(struct usb
 
 			/* can we do better than just logging errors? */
 			status = driver->resume(intf);
-			if (intf->dev.power.power_state != PMSG_ON
+			if (intf->dev.power.power_state.event != PM_EVENT_ON
 					|| status)
 				dev_dbg(&intf->dev,
 					"resume fail, state %d code %d\n",
-					intf->dev.power.power_state, status);
+					intf->dev.power.power_state.event, status);
 		}
 		status = 0;
 
@@ -1934,7 +1934,7 @@ static int hub_resume(struct usb_interfa
 	unsigned		port1;
 	int			status;
 
-	if (intf->dev.power.power_state == PM_SUSPEND_ON)
+	if (intf->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1400,7 +1400,7 @@ static int usb_generic_suspend(struct de
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -641,7 +641,7 @@ show_registers (struct class_device *cla
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"%s\n"
diff --git a/drivers/usb/host/ohci-dbg.c b/drivers/usb/host/ohci-dbg.c
--- a/drivers/usb/host/ohci-dbg.c
+++ b/drivers/usb/host/ohci-dbg.c
@@ -631,7 +631,7 @@ show_registers (struct class_device *cla
 		hcd->product_desc,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1781,9 +1781,9 @@ sl811h_suspend(struct device *dev, pm_me
 	if (phase != SUSPEND_POWER_DOWN)
 		return retval;
 
-	if (state <= PM_SUSPEND_MEM)
+	if (state.event == PM_EVENT_FREEZE)
 		retval = sl811h_hub_suspend(hcd);
-	else
+	else if (state.event == PM_EVENT_SUSPEND)
 		port_power(sl811, 0);
 	if (retval == 0)
 		dev->power.power_state = state;
@@ -1802,7 +1802,7 @@ sl811h_resume(struct device *dev, u32 ph
 	/* with no "check to see if VBUS is still powered" board hook,
 	 * let's assume it'd only be powered to enable remote wakeup.
 	 */
-	if (dev->power.power_state > PM_SUSPEND_MEM
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND
 			|| !hcd->can_wakeup) {
 		sl811->port1 = 0;
 		port_power(sl811, 1);
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -1533,7 +1533,7 @@ usbtest_ioctl (struct usb_interface *int
 	if (down_interruptible (&dev->sem))
 		return -ERESTARTSYS;
 
-	if (intf->dev.power.power_state != PMSG_ON) {
+	if (intf->dev.power.power_state.event != PM_EVENT_ON) {
 		up (&dev->sem);
 		return -EHOSTUNREACH;
 	}
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -2323,17 +2323,16 @@ static int aty128_pci_suspend(struct pci
 	 * can properly take care of D3 ? Also, with swsusp, we
 	 * know we'll be rebooted, ...
 	 */
-#ifdef CONFIG_PPC_PMAC
+#ifndef CONFIG_PPC_PMAC
 	/* HACK ALERT ! Once I find a proper way to say to each driver
 	 * individually what will happen with it's PCI slot, I'll change
 	 * that. On laptops, the AGP slot is just unclocked, so D2 is
 	 * expected, while on desktops, the card is powered off
 	 */
-	if (state >= 3)
-		state = 2;
+	return 0;
 #endif /* CONFIG_PPC_PMAC */
 	 
-	if (state != 2 || state == pdev->dev.power.power_state)
+	if (state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	printk(KERN_DEBUG "aty128fb: suspending...\n");
@@ -2367,7 +2366,7 @@ static int aty128_pci_suspend(struct pci
 	 * used dummy fb ops, 2.5 need proper support for this at the
 	 * fbdev level
 	 */
-	if (state == 2)
+	if (state.event != PM_EVENT_ON)
 		aty128_set_suspend(par, 1);
 
 	release_console_sem();
@@ -2382,12 +2381,11 @@ static int aty128_do_resume(struct pci_d
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	/* Wakeup chip */
-	if (pdev->dev.power.power_state == 2)
-		aty128_set_suspend(par, 0);
+	aty128_set_suspend(par, 0);
 	par->asleep = 0;
 
 	/* Restore display & engine */
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2022,17 +2022,16 @@ static int atyfb_pci_suspend(struct pci_
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
-#ifdef CONFIG_PPC_PMAC
+#ifndef CONFIG_PPC_PMAC
 	/* HACK ALERT ! Once I find a proper way to say to each driver
 	 * individually what will happen with it's PCI slot, I'll change
 	 * that. On laptops, the AGP slot is just unclocked, so D2 is
 	 * expected, while on desktops, the card is powered off
 	 */
-	if (state >= 3)
-		state = 2;
+	return 0;
 #endif /* CONFIG_PPC_PMAC */
 
-	if (state != 2 || state == pdev->dev.power.power_state)
+	if (state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	acquire_console_sem();
@@ -2071,12 +2070,12 @@ static int atyfb_pci_resume(struct pci_d
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	acquire_console_sem();
 
-	if (pdev->dev.power.power_state == 2)
+	if (pdev->dev.power.power_state.event == 2)
 		aty_power_mgmt(0, par);
 	par->asleep = 0;
 
diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -2526,18 +2526,18 @@ int radeonfb_pci_suspend(struct pci_dev 
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
+	if (state.event == PM_EVENT_FREEZE)
 		goto done;
 
 	acquire_console_sem();
@@ -2616,7 +2616,7 @@ int radeonfb_pci_resume(struct pci_dev *
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
 	if (rinfo->no_schedule) {
@@ -2626,7 +2626,7 @@ int radeonfb_pci_resume(struct pci_dev *
 		acquire_console_sem();
 
 	printk(KERN_DEBUG "radeonfb (%s): resuming from state: %d...\n",
-	       pci_name(pdev), pdev->dev.power.power_state);
+	       pci_name(pdev), pdev->dev.power.power_state.event);
 
 
 	if (pci_enable_device(pdev)) {
@@ -2637,7 +2637,7 @@ int radeonfb_pci_resume(struct pci_dev *
 	}
 	pci_set_master(pdev);
 
-	if (pdev->dev.power.power_state == PM_SUSPEND_MEM) {
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1506,12 +1506,12 @@ static int i810fb_suspend(struct pci_dev
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
diff --git a/include/linux/pm.h b/include/linux/pm.h
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -186,7 +186,9 @@ extern int pm_suspend(suspend_state_t st
 
 struct device;
 
-typedef u32 __bitwise pm_message_t;
+typedef struct pm_message {
+	int event;
+} pm_message_t;
 
 /*
  * There are 4 important states driver can be in:
@@ -207,9 +209,13 @@ typedef u32 __bitwise pm_message_t;
  * or something similar soon.
  */
 
-#define PMSG_FREEZE	((__force pm_message_t) 3)
-#define PMSG_SUSPEND	((__force pm_message_t) 3)
-#define PMSG_ON		((__force pm_message_t) 0)
+#define PM_EVENT_ON 0
+#define PM_EVENT_FREEZE 1
+#define PM_EVENT_SUSPEND 2
+
+#define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
+#define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
+#define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
 
 struct dev_pm_info {
 	pm_message_t		power_state;

-- 
teflon -- maybe it is a trademark, but it should not be.
