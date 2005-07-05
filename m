Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVGERgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVGERgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 13:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVGERgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 13:36:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56737 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261947AbVGERaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 13:30:02 -0400
Date: Tue, 5 Jul 2005 19:29:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: [RFT] solve "swsusp plays yoyo" with disks
Message-ID: <20050705172953.GA18748@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'd like to get this tested under as many configurations as
possible. With this, your hdd should no longer do "yoyo" (spindown,
spinup, spindown) during suspend...
							Pavel

--- a/arch/ppc/platforms/pmac_cpufreq.c
+++ b/arch/ppc/platforms/pmac_cpufreq.c
@@ -452,7 +452,7 @@ static u32 __pmac read_gpio(struct devic
 	return offset;
 }
 
-static int __pmac pmac_cpufreq_suspend(struct cpufreq_policy *policy, u32 state)
+static int __pmac pmac_cpufreq_suspend(struct cpufreq_policy *policy, pm_message_t pmsg)
 {
 	/* Ok, this could be made a bit smarter, but let's be robust for now. We
 	 * always force a speed change to high speed before sleep, to make sure
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
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -869,7 +869,7 @@ EXPORT_SYMBOL(cpufreq_get);
  *	cpufreq_suspend - let the low level driver prepare for suspend
  */
 
-static int cpufreq_suspend(struct sys_device * sysdev, u32 state)
+static int cpufreq_suspend(struct sys_device * sysdev, pm_message_t pmsg)
 {
 	int cpu = sysdev->id;
 	unsigned int ret = 0;
@@ -897,7 +897,7 @@ static int cpufreq_suspend(struct sys_de
 	}
 
 	if (cpufreq_driver->suspend) {
-		ret = cpufreq_driver->suspend(cpu_policy, state);
+		ret = cpufreq_driver->suspend(cpu_policy, pmsg);
 		if (ret) {
 			printk(KERN_ERR "cpufreq: suspend failed in ->suspend "
 					"step on CPU %u\n", cpu_policy->cpu);
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
--- a/drivers/media/dvb/cinergyT2/cinergyT2.c
+++ b/drivers/media/dvb/cinergyT2/cinergyT2.c
@@ -886,7 +886,7 @@ static int cinergyt2_suspend (struct usb
 	if (down_interruptible(&cinergyt2->sem))
 		return -ERESTARTSYS;
 
-	if (state > 0) {	/* state 0 seems to mean DEVICE_PM_ON */
+	if (state.event > PM_EVENT_ON) {
 		struct cinergyt2 *cinergyt2 = usb_get_intfdata (intf);
 #ifdef ENABLE_RC
 		cancel_delayed_work(&cinergyt2->rc_query_work);
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
@@ -1762,12 +1757,12 @@ static int vlsi_irda_suspend(struct pci_
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
@@ -1781,8 +1776,8 @@ static int vlsi_irda_suspend(struct pci_
 			idev->new_baud = idev->baud;
 	}
 
-	pci_set_power_state(pdev,state);
-	pdev->current_state = state;
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	pdev->current_state = state.event;
 	idev->resume_ok = 1;
 	up(&idev->sem);
 	return 0;
@@ -1807,8 +1802,8 @@ static int vlsi_irda_resume(struct pci_d
 		return 0;
 	}
 	
-	pci_set_power_state(pdev, 0);
-	pdev->current_state = 0;
+	pci_set_power_state(pdev, PCI_D0);
+	pdev->current_state = PM_EVENT_ON;
 
 	if (!idev->resume_ok) {
 		/* should be obsolete now - but used to happen due to:
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
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -316,14 +316,14 @@ pci_set_power_state(struct pci_dev *dev,
 
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
-	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
+	switch (state.event) {
+	case PM_EVENT_ON:
 		return PCI_D0;
-
-	switch (state) {
-	case 0: return PCI_D0;
-	case 3: return PCI_D3hot;
-	default:
-		printk("They asked me for state %d\n", state);
+	case PM_EVENT_FREEZE:
+	case PM_EVENT_SUSPEND:
+		return PCI_D3hot;
+	default: 
+		printk("They asked me for state %d\n", state.event);
 		BUG();
 	}
 	return PCI_D0;
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
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1400,7 +1400,7 @@ static int usb_generic_suspend(struct de
 	driver = to_usb_driver(dev->driver);
 
 	/* there's only one USB suspend state */
-	if (intf->dev.power.power_state)
+	if (intf->dev.power.power_state.event)
 		return 0;
 
 	if (driver->suspend)
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -641,7 +641,7 @@ show_registers (struct class_device *cla
 
 	spin_lock_irqsave (&ehci->lock, flags);
 
-	if (bus->controller->power.power_state) {
+	if (bus->controller->power.power_state.event) {
 		size = scnprintf (next, size,
 			"bus %s, device %s (driver " DRIVER_VERSION ")\n"
 			"%s\n"
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
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -2113,7 +2113,7 @@ static int savagefb_suspend (struct pci_
 	printk(KERN_DEBUG "state: %u\n", state);
 
 	acquire_console_sem();
-	fb_set_suspend(info, state);
+	fb_set_suspend(info, pci_choose_state(dev, state));
 	savage_disable_mmio(par);
 	release_console_sem();
 
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -201,7 +201,7 @@ struct cpufreq_driver {
 
 	/* optional */
 	int	(*exit)		(struct cpufreq_policy *policy);
-	int	(*suspend)	(struct cpufreq_policy *policy, u32 state);
+	int	(*suspend)	(struct cpufreq_policy *policy, pm_message_t pmsg);
 	int	(*resume)	(struct cpufreq_policy *policy);
 	struct freq_attr	**attr;
 };
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
+#define PMSG_FREEZE	({struct pm_message m; m.event = PM_EVENT_FREEZE; m; })
+#define PMSG_SUSPEND	({struct pm_message m; m.event = PM_EVENT_SUSPEND; m; })
+#define PMSG_ON		({struct pm_message m; m.event = PM_EVENT_ON; m; })
 
 struct dev_pm_info {
 	pm_message_t		power_state;
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
