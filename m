Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272256AbTHDV1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 17:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272257AbTHDV1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 17:27:23 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:59104 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272252AbTHDV1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 17:27:02 -0400
Date: Mon, 4 Aug 2003 23:26:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, linux-laptop@vger.kernel.org,
       sfr@canb.auug.org.au, david-b@pacbell.net
Subject: Do not suspend PCI devices twice [PATCH for testing]
Message-ID: <20030804212624.GA2452@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

PCI devices are suspendend twice; once using pm_send_all() and once
because of driver model (when using ACPI). That's bad.

If I kill pm_send_all() hook, they will not be suspended at all with
APM, because APM does not call device_suspend(...,
SUSPEND_SAVE_STATE). This patch fixes both of these.

Ouch, no it does not. You should > drivers/pci/power.c. Its no longer
needed.

It compiles, and I'd like someone to test it ;-).
								Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/apm.c	2003-05-27 13:42:28.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/apm.c	2003-08-04 23:11:06.000000000 +0200
@@ -1185,19 +1185,23 @@
 	int		err;
 	struct apm_user	*as;
 
+	if (device_suspend(3, SUSPEND_NOTIFY))
+		if (vetoable)
+			goto veto;
+	if (device_suspend(3, SUSPEND_SAVE_STATE)) {
+		if (vetoable) {
+			device_resume(RESUME_RESTORE_STATE);
+			goto veto;
+		}
+	}
 	if (pm_send_all(PM_SUSPEND, (void *)3)) {
 		/* Vetoed */
 		if (vetoable) {
-			if (apm_info.connection_version > 0x100)
-				set_system_power_state(APM_STATE_REJECT);
-			err = -EBUSY;
-			ignore_sys_suspend = 0;
-			printk(KERN_WARNING "apm: suspend was vetoed.\n");
-			goto out;
+			device_resume(RESUME_RESTORE_STATE);
+			goto veto;
 		}
 		printk(KERN_CRIT "apm: suspend was vetoed, but suspending anyway.\n");
 	}
-
 	device_suspend(3, SUSPEND_POWER_DOWN);
 
 	/* serialize with the timer interrupt */
@@ -1234,7 +1238,17 @@
 	err = (err == APM_SUCCESS) ? 0 : -EIO;
 	device_resume(RESUME_POWER_ON);
 	pm_send_all(PM_RESUME, (void *)0);
+	device_resume(RESUME_RESTORE_STATE);
 	queue_event(APM_NORMAL_RESUME, NULL);
+
+	if (0) {
+ veto:
+		if (apm_info.connection_version > 0x100)
+			set_system_power_state(APM_STATE_REJECT);
+		err = -EBUSY;
+		ignore_sys_suspend = 0;
+		printk(KERN_WARNING "apm: suspend was vetoed.\n");
+	}
  out:
 	spin_lock(&user_list_lock);
 	for (as = user_list; as != NULL; as = as->next) {
--- /usr/src/tmp/linux/drivers/pci/power.c	2003-06-15 22:42:54.000000000 +0200
+++ /usr/src/linux/drivers/pci/power.c	2003-08-04 21:22:38.000000000 +0200
@@ -157,3 +157,4 @@
 }
 
 subsys_initcall(pci_pm_init);
+
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' -x '*.cmd' /usr/src/tmp/linux/drivers/pci/probe.c /usr/src/linux/drivers/pci/probe.c
--- /usr/src/tmp/linux/drivers/pci/probe.c	2003-07-11 21:38:38.000000000 +0200
+++ /usr/src/linux/drivers/pci/probe.c	2003-07-31 12:19:04.000000000 +0200
@@ -633,6 +633,9 @@
 	return max;
 }
 
+struct device_driver pci_driver = {
+};
+
 struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
 {
 	struct pci_bus *b;
@@ -664,6 +667,7 @@
 	b->dev->parent = parent;
 	sprintf(b->dev->bus_id,"pci%04x:%02x", pci_domain_nr(b), bus);
 	strcpy(b->dev->name,"Host/PCI Bridge");
+	b->dev->driver = &pci_driver;
 	device_register(b->dev);
 
 	b->number = b->secondary = bus;
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' -x '*.cmd' /usr/src/tmp/linux/drivers/usb/core/hcd.c /usr/src/linux/drivers/usb/core/hcd.c
--- /usr/src/tmp/linux/drivers/usb/core/hcd.c	2003-07-27 22:31:27.000000000 +0200
+++ /usr/src/linux/drivers/usb/core/hcd.c	2003-07-31 11:31:06.000000000 +0200
@@ -1487,8 +1487,26 @@
 
 static void hcd_panic (void *_hcd)
 {
-	struct usb_hcd *hcd = _hcd;
-	hcd->driver->stop (hcd);
+	struct usb_hcd		*hcd = _hcd;
+	struct usb_device	*hub = hcd->self.root_hub;
+
+	hub = usb_get_dev (hub);
+	usb_disconnect (&hub);
+
+	/* FIXME either try to restart, or arrange to clean up the 
+	 * hc-internal state, like usb_hcd_pci_remove() does
+	 */
+}
+
+void mark_gone (struct usb_device *dev)
+{
+	unsigned	i;
+
+	dev->state = USB_STATE_NOTATTACHED;
+	for (i = 0; i < dev->maxchild; i++) {
+		if (dev->children [i])
+			mark_gone (dev->children [i]);
+	}
 }
 
 /**
@@ -1501,29 +1519,12 @@
  */
 void usb_hc_died (struct usb_hcd *hcd)
 {
-	struct list_head	*devlist, *urblist;
-	struct hcd_dev		*dev;
-	struct urb		*urb;
-	unsigned long		flags;
-	
-	/* flag every pending urb as done */
-	spin_lock_irqsave (&hcd_data_lock, flags);
-	list_for_each (devlist, &hcd->dev_list) {
-		dev = list_entry (devlist, struct hcd_dev, dev_list);
-		list_for_each (urblist, &dev->urb_list) {
-			urb = list_entry (urblist, struct urb, urb_list);
-			dev_dbg (hcd->controller, "shutdown %s urb %p pipe %x, current status %d\n",
-				hcd->self.bus_name, urb, urb->pipe, urb->status);
-			if (urb->status == -EINPROGRESS)
-				urb->status = -ESHUTDOWN;
-		}
-	}
-	urb = (struct urb *) hcd->rh_timer.data;
-	if (urb)
-		urb->status = -ESHUTDOWN;
-	spin_unlock_irqrestore (&hcd_data_lock, flags);
+	dev_err (hcd->controller, "HC died; pending I/O will be aborted.\n");
 
-	/* hcd->stop() needs a task context */
+	/* prevent new submissions to devices in this tree */
+	mark_gone (hcd->self.root_hub);
+	
+	/* then usb_disconnect() them all, in a task context */
 	INIT_WORK (&hcd->work, hcd_panic, hcd);
 	(void) schedule_work (&hcd->work);
 }
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' -x '*.cmd' /usr/src/tmp/linux/drivers/usb/host/ohci-pci.c /usr/src/linux/drivers/usb/host/ohci-pci.c
--- /usr/src/tmp/linux/drivers/usb/host/ohci-pci.c	2003-04-21 22:31:45.000000000 +0200
+++ /usr/src/linux/drivers/usb/host/ohci-pci.c	2003-07-31 11:31:06.000000000 +0200
@@ -199,6 +199,11 @@
 	int			retval = 0;
 	unsigned long		flags;
 
+	if (hcd->state == USB_STATE_HALT) {
+		ohci_dbg (ohci, "USB restart of halted device\n");
+		return -EL3HLT;
+	}
+
 #ifdef CONFIG_PMAC_PBOOK
 	{
 		struct device_node *of_node;
Only in /usr/src/linux/drivers/video/logo: logo_linux_clut224.c
Only in /usr/src/linux/include/asm-i386: asm_offsets.h
Only in /usr/src/linux/include: config
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' -x '*.cmd' /usr/src/tmp/linux/kernel/suspend.c /usr/src/linux/kernel/suspend.c
--- /usr/src/tmp/linux/kernel/suspend.c	2003-08-04 23:13:49.000000000 +0200
+++ /usr/src/linux/kernel/suspend.c	2003-08-04 23:07:11.000000000 +0200
@@ -630,16 +630,20 @@
 static void drivers_unsuspend(void)
 {
 	device_resume(RESUME_RESTORE_STATE);
+	pm_send_all(PM_RESUME, (void *)0);
 	device_resume(RESUME_ENABLE);
 }
 
 /* Called from process context */
 static int drivers_suspend(void)
 {
-	device_suspend(4, SUSPEND_NOTIFY);
-	device_suspend(4, SUSPEND_SAVE_STATE);
-	device_suspend(4, SUSPEND_DISABLE);
-	if(!pm_suspend_state) {
+	if (device_suspend(4, SUSPEND_NOTIFY))
+		return -EIO;
+	if (device_suspend(4, SUSPEND_SAVE_STATE)) {
+		device_resume(RESUME_RESTORE_STATE);
+		return -EIO;
+	}
+	if (!pm_suspend_state) {
 		if(pm_send_all(PM_SUSPEND,(void *)3)) {
 			printk(KERN_WARNING "Problem while sending suspend event\n");
 			return(1);
@@ -647,6 +651,7 @@
 		pm_suspend_state=1;
 	} else
 		printk(KERN_WARNING "PM suspend state already raised\n");
+	device_suspend(4, SUSPEND_DISABLE);
 	  
 	return(0);
 }
@@ -868,7 +873,7 @@
 		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
+		if (drivers_suspend()==0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
Only in /usr/src/linux/lib: crc32table.h
Only in /usr/src/linux/lib: gen_crc32table
Only in /usr/src/linux: patches
Only in /usr/src/linux/scripts: docproc
Only in /usr/src/linux/scripts: elfconfig.h
Only in /usr/src/linux/scripts: fixdep
Only in /usr/src/linux/scripts: kallsyms
Only in /usr/src/linux/scripts/kconfig: conf
Only in /usr/src/linux/scripts/kconfig: lex.zconf.c
Only in /usr/src/linux/scripts/kconfig: libkconfig.so
Only in /usr/src/linux/scripts/kconfig: zconf.tab.c
Only in /usr/src/linux/scripts/kconfig: zconf.tab.h
Only in /usr/src/linux/scripts: mk_elfconfig
Only in /usr/src/linux/scripts: modpost
Only in /usr/src/linux/scripts: pnmtologo
Only in /usr/src/linux/scripts: split-include
Only in /usr/src/linux: txt
Only in /usr/src/linux/usr: gen_init_cpio
Only in /usr/src/linux/usr: initramfs_data.cpio
Only in /usr/src/linux/usr: initramfs_data.cpio.gz

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
