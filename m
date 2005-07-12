Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVGLK2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVGLK2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 06:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVGLK0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 06:26:55 -0400
Received: from [203.171.93.254] ([203.171.93.254]:41677 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261324AbVGLKYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 06:24:23 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050711234121.25d8e2f8.akpm@osdl.org>
References: <11206164393426@foobar.com> <20050710230645.GD513@infradead.org>
	 <1121150172.13869.17.camel@localhost>
	 <20050711234121.25d8e2f8.akpm@osdl.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121163954.13869.146.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 20:25:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-12 at 16:41, Andrew Morton wrote:
> Am still futzing with the ongoing pm_message_t saga here.  I hope there's
> no overlap with that.

Perhaps I can help there. I've been preparing a patchset against the
latest mm. Here's a patch with additional changes I know about.

Hope it's helpful.

Regards,

Nigel

 arch/ppc/platforms/pmac_pic.c                 |    2 +-
 arch/ppc/syslib/open_pic.c                    |    2 +-
 drivers/base/power/resume.c                   |    8 ++++----
 drivers/base/power/runtime.c                  |    8 ++++----
 drivers/base/power/suspend.c                  |   14 +++++++-------
 drivers/base/power/sysfs.c                    |    9 +++++----
 drivers/ide/ide.c                             |    2 +-
 drivers/ide/pci/sc1200.c                      |    8 ++++----
 drivers/ide/ppc/pmac.c                        |   16 ++++++++--------
 drivers/macintosh/mediabay.c                  |    6 +++---
 drivers/macintosh/via-pmu.c                   |    2 +-
 drivers/media/dvb/cinergyT2/cinergyT2.c       |    2 +-
 drivers/media/video/bttv-driver.c             |    2 +-
 drivers/net/irda/vlsi_ir.c                    |   18 ++++++++++--------
 drivers/net/wireless/airo.c                   |    3 ++-
 drivers/net/wireless/orinoco_pci.c            |    2 +-
 drivers/net/wireless/prism54/islpci_hotplug.c |    2 +-
 drivers/pci/pci.c                             |   11 +++++++----
 drivers/scsi/lpfc/lpfc_init.c                 |    2 +-
 drivers/serial/pmac_zilog.c                   |    6 +++---
 drivers/usb/core/hub.c                        |   18 +++++++++---------
 drivers/usb/core/usb.c                        |    2 +-
 drivers/usb/host/ehci-dbg.c                   |    2 +-
 drivers/usb/host/ohci-dbg.c                   |    2 +-
 drivers/usb/host/sl811-hcd.c                  |    6 +++---
 drivers/video/aty/aty128fb.c                  |   12 ++++++------
 drivers/video/aty/atyfb_base.c                |   10 +++++-----
 drivers/video/aty/radeon_pm.c                 |   12 ++++++------
 drivers/video/i810/i810_main.c                |   22 ++++++++--------------
 drivers/video/savage/savagefb_driver.c        |    2 +-
 include/linux/pm.h                            |   18 ++++++++++++++----
 sound/pci/atiixp.c                            |    4 ++--
 32 files changed, 123 insertions(+), 112 deletions(-)
diff -ruNp 220-combined-pm_message_t.patch-old/arch/ppc/platforms/pmac_pic.c 220-combined-pm_message_t.patch-new/arch/ppc/platforms/pmac_pic.c
--- 220-combined-pm_message_t.patch-old/arch/ppc/platforms/pmac_pic.c	2005-02-03 22:33:18.000000000 +1100
+++ 220-combined-pm_message_t.patch-new/arch/ppc/platforms/pmac_pic.c	2005-07-12 20:10:30.000000000 +1000
@@ -619,7 +619,7 @@ not_found:
 	return viaint;
 }
 
-static int pmacpic_suspend(struct sys_device *sysdev, u32 state)
+static int pmacpic_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	int viaint = pmacpic_find_viaint();
 
diff -ruNp 220-combined-pm_message_t.patch-old/arch/ppc/syslib/open_pic.c 220-combined-pm_message_t.patch-new/arch/ppc/syslib/open_pic.c
--- 220-combined-pm_message_t.patch-old/arch/ppc/syslib/open_pic.c	2005-07-12 19:30:05.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/arch/ppc/syslib/open_pic.c	2005-07-12 20:10:30.000000000 +1000
@@ -948,7 +948,7 @@ static void openpic_cached_disable_irq(u
  * we need something better to deal with that... Maybe switch to S1 for
  * cpufreq changes
  */
-int openpic_suspend(struct sys_device *sysdev, u32 state)
+int openpic_suspend(struct sys_device *sysdev, pm_message_t state)
 {
 	int	i;
 	unsigned long flags;
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/base/power/resume.c 220-combined-pm_message_t.patch-new/drivers/base/power/resume.c
--- 220-combined-pm_message_t.patch-old/drivers/base/power/resume.c	2005-07-12 19:30:07.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/base/power/resume.c	2005-07-12 20:10:30.000000000 +1000
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
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/base/power/runtime.c 220-combined-pm_message_t.patch-new/drivers/base/power/runtime.c
--- 220-combined-pm_message_t.patch-old/drivers/base/power/runtime.c	2005-02-03 22:33:23.000000000 +1100
+++ 220-combined-pm_message_t.patch-new/drivers/base/power/runtime.c	2005-07-12 20:10:30.000000000 +1000
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
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/base/power/suspend.c 220-combined-pm_message_t.patch-new/drivers/base/power/suspend.c
--- 220-combined-pm_message_t.patch-old/drivers/base/power/suspend.c	2005-07-12 19:30:07.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/base/power/suspend.c	2005-07-12 20:10:30.000000000 +1000
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
 
-	dev->power.prev_state = dev->power.power_state;
+	dev->power.prev_state.event = dev->power.power_state.event;
 
-	if (dev->bus && dev->bus->suspend && !dev->power.power_state) {
+	if (dev->bus && dev->bus->suspend && !dev->power.power_state.event) {
 		dev_dbg(dev, "suspending\n");
 		error = dev->bus->suspend(dev, state);
 	}
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/base/power/sysfs.c 220-combined-pm_message_t.patch-new/drivers/base/power/sysfs.c
--- 220-combined-pm_message_t.patch-old/drivers/base/power/sysfs.c	2005-07-12 19:30:07.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/base/power/sysfs.c	2005-07-12 20:10:30.000000000 +1000
@@ -26,19 +26,20 @@
 
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
+	state.flags = PFL_RUNTIME;
 	if (*rest)
 		return -EINVAL;
-	if (state)
+	if (state.event)
 		error = dpm_runtime_suspend(dev, state);
 	else
 		dpm_runtime_resume(dev);
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/ide/ide.c 220-combined-pm_message_t.patch-new/drivers/ide/ide.c
--- 220-combined-pm_message_t.patch-old/drivers/ide/ide.c	2005-07-12 20:22:02.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/ide/ide.c	2005-07-12 20:10:31.000000000 +1000
@@ -1229,7 +1229,7 @@ static int generic_ide_suspend(struct de
 	rq.special = &args;
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
-	rqpm.pm_state = state;
+	rqpm.pm_state = state.event;
 
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/ide/pci/sc1200.c 220-combined-pm_message_t.patch-new/drivers/ide/pci/sc1200.c
--- 220-combined-pm_message_t.patch-old/drivers/ide/pci/sc1200.c	2005-07-12 19:30:10.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/ide/pci/sc1200.c	2005-07-12 20:10:31.000000000 +1000
@@ -350,9 +350,9 @@ static int sc1200_suspend (struct pci_de
 {
 	ide_hwif_t		*hwif = NULL;
 
-	printk("SC1200: suspend(%u)\n", state);
+	printk("SC1200: suspend(%u)\n", state.event);
 
-	if (state == 0) {
+	if (state.event == EVENT_ON) {
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
 
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/ide/ppc/pmac.c 220-combined-pm_message_t.patch-new/drivers/ide/ppc/pmac.c
--- 220-combined-pm_message_t.patch-old/drivers/ide/ppc/pmac.c	2005-07-12 19:31:56.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/ide/ppc/pmac.c	2005-07-12 20:10:31.000000000 +1000
@@ -1504,12 +1504,12 @@ pmac_ide_macio_attach(struct macio_dev *
 }
 
 static int
-pmac_ide_macio_suspend(struct macio_dev *mdev, u32 state)
+pmac_ide_macio_suspend(struct macio_dev *mdev, pm_message_t state)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 
-	if (state != mdev->ofdev.dev.power.power_state && state >= 2) {
+	if (state.event != mdev->ofdev.dev.power.power_state.event && state.event >= EVENT_SUSPEND) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			mdev->ofdev.dev.power.power_state = state;
@@ -1524,10 +1524,10 @@ pmac_ide_macio_resume(struct macio_dev *
 	ide_hwif_t	*hwif = (ide_hwif_t *)dev_get_drvdata(&mdev->ofdev.dev);
 	int		rc = 0;
 	
-	if (mdev->ofdev.dev.power.power_state != 0) {
+	if (mdev->ofdev.dev.power.power_state.event != EVENT_ON) {
 		rc = pmac_ide_do_resume(hwif);
 		if (rc == 0)
-			mdev->ofdev.dev.power.power_state = 0;
+			mdev->ofdev.dev.power.power_state = PMSG_ON;
 	}
 
 	return rc;
@@ -1608,12 +1608,12 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 }
 
 static int
-pmac_ide_pci_suspend(struct pci_dev *pdev, u32 state)
+pmac_ide_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (state != pdev->dev.power.power_state && state >= 2) {
+	if (state.event != pdev->dev.power.power_state.event && state.event >= 2) {
 		rc = pmac_ide_do_suspend(hwif);
 		if (rc == 0)
 			pdev->dev.power.power_state = state;
@@ -1628,10 +1628,10 @@ pmac_ide_pci_resume(struct pci_dev *pdev
 	ide_hwif_t	*hwif = (ide_hwif_t *)pci_get_drvdata(pdev);
 	int		rc = 0;
 	
-	if (pdev->dev.power.power_state != 0) {
+	if (pdev->dev.power.power_state.event != EVENT_ON) {
 		rc = pmac_ide_do_resume(hwif);
 		if (rc == 0)
-			pdev->dev.power.power_state = 0;
+			pdev->dev.power.power_state = PMSG_ON;
 	}
 
 	return rc;
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/macintosh/mediabay.c 220-combined-pm_message_t.patch-new/drivers/macintosh/mediabay.c
--- 220-combined-pm_message_t.patch-old/drivers/macintosh/mediabay.c	2005-07-12 19:31:59.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/macintosh/mediabay.c	2005-07-12 20:10:31.000000000 +1000
@@ -708,7 +708,7 @@ static int __pmac media_bay_suspend(stru
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (state != mdev->ofdev.dev.power.power_state && state == PM_SUSPEND_MEM) {
+	if (state.event != mdev->ofdev.dev.power.power_state.event && state.event == EVENT_SUSPEND) {
 		down(&bay->lock);
 		bay->sleeping = 1;
 		set_mb_power(bay, 0);
@@ -723,8 +723,8 @@ static int __pmac media_bay_resume(struc
 {
 	struct media_bay_info	*bay = macio_get_drvdata(mdev);
 
-	if (mdev->ofdev.dev.power.power_state != 0) {
-		mdev->ofdev.dev.power.power_state = 0;
+	if (mdev->ofdev.dev.power.power_state.event != EVENT_ON) {
+		mdev->ofdev.dev.power.power_state = PMSG_ON;
 
 	       	/* We re-enable the bay using it's previous content
 	       	   only if it did not change. Note those bozo timings,
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/macintosh/via-pmu.c 220-combined-pm_message_t.patch-new/drivers/macintosh/via-pmu.c
--- 220-combined-pm_message_t.patch-old/drivers/macintosh/via-pmu.c	2005-07-12 19:30:11.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/macintosh/via-pmu.c	2005-07-12 20:10:31.000000000 +1000
@@ -3065,7 +3065,7 @@ static int pmu_sys_suspended = 0;
 
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
-	if (state != PM_SUSPEND_DISK || pmu_sys_suspended)
+	if (state.event != EVENT_SUSPEND || pmu_sys_suspended)
 		return 0;
 
 	/* Suspend PMU event interrupts */
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/media/dvb/cinergyT2/cinergyT2.c 220-combined-pm_message_t.patch-new/drivers/media/dvb/cinergyT2/cinergyT2.c
--- 220-combined-pm_message_t.patch-old/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-07-12 19:31:59.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/media/dvb/cinergyT2/cinergyT2.c	2005-07-12 20:10:31.000000000 +1000
@@ -888,7 +888,7 @@ static int cinergyt2_suspend (struct usb
 	if (down_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
-	if (state > 0) {	/* state 0 seems to mean DEVICE_PM_ON */
+	if (state.event > 0) {	/* state 0 seems to mean DEVICE_PM_ON */
 		struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 #ifdef ENABLE_RC
 		cancel_delayed_work(&cinergyt2->rc_query_work);
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/media/video/bttv-driver.c 220-combined-pm_message_t.patch-new/drivers/media/video/bttv-driver.c
--- 220-combined-pm_message_t.patch-old/drivers/media/video/bttv-driver.c	2005-07-12 19:30:11.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/media/video/bttv-driver.c	2005-07-12 20:10:31.000000000 +1000
@@ -4043,7 +4043,7 @@ static int bttv_suspend(struct pci_dev *
 	struct bttv_buffer_set idle;
 	unsigned long flags;
 
-	dprintk("bttv%d: suspend %d\n", btv->c.nr, state);
+	dprintk("bttv%d: suspend %d\n", btv->c.nr, state.event);
 
 	/* stop dma + irqs */
 	spin_lock_irqsave(&btv->s_lock,flags);
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/net/irda/vlsi_ir.c 220-combined-pm_message_t.patch-new/drivers/net/irda/vlsi_ir.c
--- 220-combined-pm_message_t.patch-old/drivers/net/irda/vlsi_ir.c	2005-06-20 11:47:00.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/net/irda/vlsi_ir.c	2005-07-12 20:10:31.000000000 +1000
@@ -1748,10 +1748,11 @@ static int vlsi_irda_suspend(struct pci_
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
 	vlsi_irda_dev_t *idev;
+	pci_power_t new_state;
 
-	if (state < 1 || state > 3 ) {
+	if (state.event < EVENT_FREEZE || state.event > EVENT_SUSPEND ) {
 		IRDA_ERROR("%s - %s: invalid pm state request: %u\n",
-			   __FUNCTION__, PCIDEV_NAME(pdev), state);
+			   __FUNCTION__, PCIDEV_NAME(pdev), state.event);
 		return 0;
 	}
 	if (!ndev) {
@@ -1760,14 +1761,15 @@ static int vlsi_irda_suspend(struct pci_
 		return 0;
 	}
 	idev = ndev->priv;	
+	new_state = pci_choose_state(pdev, state);
 	down(&idev->sem);
 	if (pdev->current_state != 0) {			/* already suspended */
-		if (state > pdev->current_state) {	/* simply go deeper */
-			pci_set_power_state(pdev,state);
-			pdev->current_state = state;
+		if (new_state > pdev->current_state) {	/* simply go deeper */
+			pci_set_power_state(pdev, new_state);
+			pdev->current_state = new_state;
 		}
 		else
-			IRDA_ERROR("%s - %s: invalid suspend request %u -> %u\n", __FUNCTION__, PCIDEV_NAME(pdev), pdev->current_state, state);
+			IRDA_ERROR("%s - %s: invalid suspend request %u -> %u\n", __FUNCTION__, PCIDEV_NAME(pdev), pdev->current_state, state.event);
 		up(&idev->sem);
 		return 0;
 	}
@@ -1781,8 +1783,8 @@ static int vlsi_irda_suspend(struct pci_
 			idev->new_baud = idev->baud;
 	}
 
-	pci_set_power_state(pdev,state);
-	pdev->current_state = state;
+	pci_set_power_state(pdev,new_state);
+	pdev->current_state = new_state;
 	idev->resume_ok = 1;
 	up(&idev->sem);
 	return 0;
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/net/wireless/airo.c 220-combined-pm_message_t.patch-new/drivers/net/wireless/airo.c
--- 220-combined-pm_message_t.patch-old/drivers/net/wireless/airo.c	2005-07-12 19:32:02.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/net/wireless/airo.c	2005-07-12 20:10:32.000000000 +1000
@@ -5487,6 +5487,7 @@ static int airo_pci_suspend(struct pci_d
 	struct airo_info *ai = dev->priv;
 	Cmd cmd;
 	Resp rsp;
+	int new_state = pci_choose_state(pdev, state);
 
 	if ((ai->APList == NULL) &&
 		(ai->APList = kmalloc(sizeof(APListRid), GFP_KERNEL)) == NULL)
@@ -5502,7 +5503,7 @@ static int airo_pci_suspend(struct pci_d
 		return -EAGAIN;
 	disable_MAC(ai, 0);
 	netif_device_detach(dev);
-	ai->power = state;
+	ai->power = state.event;
 	cmd.cmd=HOSTSLEEP;
 	issuecommand(ai, &cmd, &rsp);
 
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/net/wireless/orinoco_pci.c 220-combined-pm_message_t.patch-new/drivers/net/wireless/orinoco_pci.c
--- 220-combined-pm_message_t.patch-old/drivers/net/wireless/orinoco_pci.c	2005-06-20 11:47:02.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/net/wireless/orinoco_pci.c	2005-07-12 20:10:32.000000000 +1000
@@ -302,7 +302,7 @@ static int orinoco_pci_suspend(struct pc
 	int err;
 	
 	printk(KERN_DEBUG "%s: Orinoco-PCI entering sleep mode (state=%d)\n",
-	       dev->name, state);
+	       dev->name, state.event);
 
 	err = orinoco_lock(priv, &flags);
 	if (err) {
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/net/wireless/prism54/islpci_hotplug.c 220-combined-pm_message_t.patch-new/drivers/net/wireless/prism54/islpci_hotplug.c
--- 220-combined-pm_message_t.patch-old/drivers/net/wireless/prism54/islpci_hotplug.c	2005-06-20 11:47:02.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/net/wireless/prism54/islpci_hotplug.c	2005-07-12 20:10:32.000000000 +1000
@@ -268,7 +268,7 @@ prism54_suspend(struct pci_dev *pdev, pm
 	BUG_ON(!priv);
 
 	printk(KERN_NOTICE "%s: got suspend request (state %d)\n",
-	       ndev->name, state);
+	       ndev->name, state.event);
 
 	pci_save_state(pdev);
 
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/pci/pci.c 220-combined-pm_message_t.patch-new/drivers/pci/pci.c
--- 220-combined-pm_message_t.patch-old/drivers/pci/pci.c	2005-07-12 19:32:03.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/pci/pci.c	2005-07-12 20:16:21.000000000 +1000
@@ -333,11 +333,14 @@ pci_power_t pci_choose_state(struct pci_
 		if (ret >= 0)
 			state = ret;
 	}
-	switch (state) {
-	case 0: return PCI_D0;
-	case 3: return PCI_D3hot;
+	switch (state.event) {
+	case EVENT_ON:
+	case EVENT_FREEZE:
+		return PCI_D0;
+	case EVENT_SUSPEND:
+		return PCI_D3hot;
 	default:
-		printk("They asked me for state %d\n", state);
+		printk("They asked me for state %d\n", state.event);
 		BUG();
 	}
 	return PCI_D0;
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/scsi/lpfc/lpfc_init.c 220-combined-pm_message_t.patch-new/drivers/scsi/lpfc/lpfc_init.c
--- 220-combined-pm_message_t.patch-old/drivers/scsi/lpfc/lpfc_init.c	2005-07-12 19:32:05.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/scsi/lpfc/lpfc_init.c	2005-07-12 20:10:32.000000000 +1000
@@ -1475,7 +1475,7 @@ lpfc_pci_probe_one(struct pci_dev *pdev,
 	phba->work_ha_mask |= (HA_RXMASK << (LPFC_ELS_RING * 4));
 
 	/* Startup the kernel thread for this host adapter. */
-	phba->worker_thread = kthread_run(lpfc_do_work, phba,
+	phba->worker_thread = kthread_run(lpfc_do_work, phba, PF_NOFREEZE,
 				       "lpfc_worker_%d", phba->brd_no);
 	if (IS_ERR(phba->worker_thread)) {
 		error = PTR_ERR(phba->worker_thread);
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/serial/pmac_zilog.c 220-combined-pm_message_t.patch-new/drivers/serial/pmac_zilog.c
--- 220-combined-pm_message_t.patch-old/drivers/serial/pmac_zilog.c	2005-07-12 19:32:05.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/serial/pmac_zilog.c	2005-07-12 20:10:32.000000000 +1000
@@ -1601,7 +1601,7 @@ static int pmz_suspend(struct macio_dev 
 		return 0;
 	}
 
-	if (pm_state == mdev->ofdev.dev.power.power_state || pm_state < 2)
+	if (pm_state.event == mdev->ofdev.dev.power.power_state.event || pm_state.event < EVENT_SUSPEND)
 		return 0;
 
 	pmz_debug("suspend, switching to state %d\n", pm_state);
@@ -1661,7 +1661,7 @@ static int pmz_resume(struct macio_dev *
 	if (uap == NULL)
 		return 0;
 
-	if (mdev->ofdev.dev.power.power_state == 0)
+	if (mdev->ofdev.dev.power.power_state.event == EVENT_ON)
 		return 0;
 	
 	pmz_debug("resume, switching to state 0\n");
@@ -1714,7 +1714,7 @@ static int pmz_resume(struct macio_dev *
 
 	pmz_debug("resume, switching complete\n");
 
-	mdev->ofdev.dev.power.power_state = 0;
+	mdev->ofdev.dev.power.power_state = PMSG_ON;
 
 	return 0;
 }
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/usb/core/hub.c 220-combined-pm_message_t.patch-new/drivers/usb/core/hub.c
--- 220-combined-pm_message_t.patch-old/drivers/usb/core/hub.c	2005-07-12 19:32:05.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/usb/core/hub.c	2005-07-12 20:10:32.000000000 +1000
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
+			if (!driver->suspend || state.event > EVENT_SUSPEND) {
 #if 1
 				dev_warn(&intf->dev, "resume is unsafe!\n");
 #else
@@ -1616,7 +1616,7 @@ static int __usb_suspend_device (struct 
 	 * policies (when HNP doesn't apply) once we have mechanisms to
 	 * turn power back on!  (Likely not before 2.7...)
 	 */
-	if (state > PM_SUSPEND_MEM) {
+	if (state.event > EVENT_SUSPEND) {
 		dev_warn(&udev->dev, "no poweroff yet, suspending instead\n");
 	}
 
@@ -1733,7 +1733,7 @@ static int finish_port_resume(struct usb
 			struct usb_driver	*driver;
 
 			intf = udev->actconfig->interface[i];
-			if (intf->dev.power.power_state == PMSG_ON)
+			if (intf->dev.power.power_state.event == EVENT_SUSPEND)
 				continue;
 			if (!intf->dev.driver) {
 				/* FIXME maybe force to alt 0 */
@@ -1747,11 +1747,11 @@ static int finish_port_resume(struct usb
 
 			/* can we do better than just logging errors? */
 			status = driver->resume(intf);
-			if (intf->dev.power.power_state != PMSG_ON
+			if (intf->dev.power.power_state.event != EVENT_ON
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
+	if (intf->dev.power.power_state.event == EVENT_ON)
 		return 0;
 
 	for (port1 = 1; port1 <= hdev->maxchild; port1++) {
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/usb/core/usb.c 220-combined-pm_message_t.patch-new/drivers/usb/core/usb.c
--- 220-combined-pm_message_t.patch-old/drivers/usb/core/usb.c	2005-07-12 19:32:06.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/usb/core/usb.c	2005-07-12 20:10:32.000000000 +1000
@@ -1400,7 +1400,7 @@ static int usb_generic_suspend(struct de
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/usb/host/ehci-dbg.c 220-combined-pm_message_t.patch-new/drivers/usb/host/ehci-dbg.c
--- 220-combined-pm_message_t.patch-old/drivers/usb/host/ehci-dbg.c	2005-07-12 19:32:06.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/usb/host/ehci-dbg.c	2005-07-12 20:10:32.000000000 +1000
@@ -643,7 +643,7 @@ show_registers (struct class_device *cla
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"%s\n"
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/usb/host/ohci-dbg.c 220-combined-pm_message_t.patch-new/drivers/usb/host/ohci-dbg.c
--- 220-combined-pm_message_t.patch-old/drivers/usb/host/ohci-dbg.c	2005-07-12 19:30:17.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/usb/host/ohci-dbg.c	2005-07-12 20:10:32.000000000 +1000
@@ -631,7 +631,7 @@ show_registers (struct class_device *cla
 		hcd->product_desc,
 		hcd_name);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size -= scnprintf (next, size,
 			"SUSPENDED (no register access)\n");
 		goto done;
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/usb/host/sl811-hcd.c 220-combined-pm_message_t.patch-new/drivers/usb/host/sl811-hcd.c
--- 220-combined-pm_message_t.patch-old/drivers/usb/host/sl811-hcd.c	2005-07-12 19:32:06.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/usb/host/sl811-hcd.c	2005-07-12 20:10:32.000000000 +1000
@@ -1781,9 +1781,9 @@ sl811h_suspend(struct device *dev, pm_me
 	if (phase != SUSPEND_POWER_DOWN)
 		return retval;
 
-	if (state <= PM_SUSPEND_MEM)
+	if (state.event == EVENT_FREEZE)
 		retval = sl811h_hub_suspend(hcd);
-	else
+	else if (state.event == EVENT_SUSPEND)
 		port_power(sl811, 0);
 	if (retval == 0)
 		dev->power.power_state = state;
@@ -1802,7 +1802,7 @@ sl811h_resume(struct device *dev, u32 ph
 	/* with no "check to see if VBUS is still powered" board hook,
 	 * let's assume it'd only be powered to enable remote wakeup.
 	 */
-	if (dev->power.power_state > PM_SUSPEND_MEM
+	if (dev->power.power_state.event > EVENT_FREEZE
 			|| !hcd->can_wakeup) {
 		sl811->port1 = 0;
 		port_power(sl811, 1);
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/video/aty/aty128fb.c 220-combined-pm_message_t.patch-new/drivers/video/aty/aty128fb.c
--- 220-combined-pm_message_t.patch-old/drivers/video/aty/aty128fb.c	2005-07-12 19:30:19.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/video/aty/aty128fb.c	2005-07-12 20:10:32.000000000 +1000
@@ -2329,11 +2329,11 @@ static int aty128_pci_suspend(struct pci
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
@@ -2367,7 +2367,7 @@ static int aty128_pci_suspend(struct pci
 	 * used dummy fb ops, 2.5 need proper support for this at the
 	 * fbdev level
 	 */
-	if (state == 2)
+	if (state.event == 2)
 		aty128_set_suspend(par, 1);
 
 	release_console_sem();
@@ -2382,11 +2382,11 @@ static int aty128_do_resume(struct pci_d
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct aty128fb_par *par = info->par;
 
-	if (pdev->dev.power.power_state == 0)
+	if (!pdev->dev.power.power_state.event)
 		return 0;
 
 	/* Wakeup chip */
-	if (pdev->dev.power.power_state == 2)
+	if (pdev->dev.power.power_state.event == 2)
 		aty128_set_suspend(par, 0);
 	par->asleep = 0;
 
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/video/aty/atyfb_base.c 220-combined-pm_message_t.patch-new/drivers/video/aty/atyfb_base.c
--- 220-combined-pm_message_t.patch-old/drivers/video/aty/atyfb_base.c	2005-06-20 11:47:10.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/video/aty/atyfb_base.c	2005-07-12 20:10:32.000000000 +1000
@@ -2028,11 +2028,11 @@ static int atyfb_pci_suspend(struct pci_
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
@@ -2071,12 +2071,12 @@ static int atyfb_pci_resume(struct pci_d
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
 
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/video/aty/radeon_pm.c 220-combined-pm_message_t.patch-new/drivers/video/aty/radeon_pm.c
--- 220-combined-pm_message_t.patch-old/drivers/video/aty/radeon_pm.c	2005-06-20 11:47:10.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/video/aty/radeon_pm.c	2005-07-12 20:10:32.000000000 +1000
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
+	if (state.event != EVENT_SUSPEND)
 		goto done;
 
 	acquire_console_sem();
@@ -2616,7 +2616,7 @@ int radeonfb_pci_resume(struct pci_dev *
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
 
-	if (pdev->dev.power.power_state == 0)
+	if (!pdev->dev.power.power_state.event)
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
+	if (pdev->dev.power.power_state.event == EVENT_SUSPEND) {
 		/* Wakeup chip. Check from config space if we were powered off
 		 * (todo: additionally, check CLK_PIN_CNTL too)
 		 */
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/video/i810/i810_main.c 220-combined-pm_message_t.patch-new/drivers/video/i810/i810_main.c
--- 220-combined-pm_message_t.patch-old/drivers/video/i810/i810_main.c	2005-07-12 19:30:19.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/video/i810/i810_main.c	2005-07-12 20:10:32.000000000 +1000
@@ -1506,23 +1506,17 @@ static int i810fb_suspend(struct pci_dev
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	int blank = 0, prev_state = par->cur_state;
 
-	if (state == prev_state)
+	if (state.event == prev_state)
 		return 0;
 
-	par->cur_state = state;
+	par->cur_state = state.event;
 
-	switch (state) {
-	case 1:
-		blank = VESA_VSYNC_SUSPEND;
-		break;
-	case 2:
-		blank = VESA_HSYNC_SUSPEND;
-		break;
-	case 3:
-		blank = VESA_POWERDOWN;
-		break;
-	default:
-		return -EINVAL;
+	switch (state.event) {
+		case EVENT_SUSPEND:
+			blank = VESA_POWERDOWN;
+			break;
+		default:
+			return -EINVAL;
 	}
 	info->fbops->fb_blank(blank, info);
 
diff -ruNp 220-combined-pm_message_t.patch-old/drivers/video/savage/savagefb_driver.c 220-combined-pm_message_t.patch-new/drivers/video/savage/savagefb_driver.c
--- 220-combined-pm_message_t.patch-old/drivers/video/savage/savagefb_driver.c	2005-07-12 19:32:08.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/drivers/video/savage/savagefb_driver.c	2005-07-12 20:19:56.000000000 +1000
@@ -2110,7 +2110,7 @@ static int savagefb_suspend (struct pci_
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
 
 	DBG("savagefb_suspend");
-	printk(KERN_DEBUG "state: %u\n", state);
+	printk(KERN_DEBUG "state: %u\n", state.event);
 
 	acquire_console_sem();
 	fb_set_suspend(info, pci_choose_state(dev, state));
diff -ruNp 220-combined-pm_message_t.patch-old/include/linux/pm.h 220-combined-pm_message_t.patch-new/include/linux/pm.h
--- 220-combined-pm_message_t.patch-old/include/linux/pm.h	2005-07-12 19:32:12.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/include/linux/pm.h	2005-07-12 20:10:32.000000000 +1000
@@ -186,7 +186,10 @@ extern int pm_suspend(suspend_state_t st
 
 struct device;
 
-typedef u32 __bitwise pm_message_t;
+typedef struct pm_message {
+	int event;
+	int flags;
+} pm_message_t;
 
 /*
  * There are 4 important states driver can be in:
@@ -207,9 +210,16 @@ typedef u32 __bitwise pm_message_t;
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
diff -ruNp 220-combined-pm_message_t.patch-old/sound/pci/atiixp.c 220-combined-pm_message_t.patch-new/sound/pci/atiixp.c
--- 220-combined-pm_message_t.patch-old/sound/pci/atiixp.c	2005-07-12 19:30:30.000000000 +1000
+++ 220-combined-pm_message_t.patch-new/sound/pci/atiixp.c	2005-07-12 20:10:32.000000000 +1000
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
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

