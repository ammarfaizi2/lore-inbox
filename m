Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUHRQLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUHRQLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUHRQLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 12:11:30 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:33168 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267319AbUHRQLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 12:11:20 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] enums to clear suspend-state confusion
Date: Wed, 18 Aug 2004 08:17:17 -0700
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040812120220.GA30816@elf.ucw.cz> <20040818061227.GA7854@elf.ucw.cz> <1092812149.9932.180.camel@gaston>
In-Reply-To: <1092812149.9932.180.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9L3IBdgE7OPL9k+"
Message-Id: <200408180817.17822.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_9L3IBdgE7OPL9k+
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 17 August 2004 11:55 pm, Benjamin Herrenschmidt wrote:
> 
> > Yes, that's exactly what I did... Unfortunately typedef means ugly
> > code. So I'll just switch it back to enum system_state, and lets care
> > about device power managment when it hits us, okay?
> 
> I don't agree... with this approach, we'll have to change all drivers
> _twice_ when we move to something more descriptive than a scalar

The advantage of switching _now_ to enums is that it can be done
without actually changing drivers ... however, there are actually
two different suspend-state confusions.  That patch just affects
the first of them, whereas it's the second which actively breaks
things today:

 - Confusion #1 ... "generic" PM framework uses a u32, and the
   meaning of that u32 has never been formally defined.

   In practice, most kernel code (except swsusp) passes an
   enum there already ... PM_SUSPEND_* values, which are
   unfortunately in an anonymous enum so there's no way
   even a smartened "sparse" could report errors.

 - Confusion #2 ... PCI suspend calls use a u32, which has since
   at least 2.4 meant a PCI power state.   Those values are not
   the same as PM_SUSPEND_* values.

   PCI drivers that use that u32 are currently getting burnt by the
   way PM_SUSPEND_* values get passed in when the drivers
   expect a PCI power state.  Example, passing PM_SUSPEND_MEM
   when the intention is PCI_D3hot (2 rather than 3).

I happen to think the _right_ fix involves switching from a scalar to
something that recognizes {bus,device,driver}-specific PM states.

Such a switch would be extremely disruptive; it'd mean changing
every driver.   So it's something I'd not rush into ... it'd be worth
doing as part of fixing multiple holes in the PM framework.

Which leaves me thinking that the desirable near-term fix involves
cleanup for #1, and minor sleight-of-hand to fix #2.  Something
like the attached patch (untested) ... which would let us answer
Andrew's "why?" question by pointing to some bugtraq IDs.

- Dave


--Boundary-00=_9L3IBdgE7OPL9k+
Content-Type: text/x-diff;
  charset="utf-8";
  name="pmcore-0818.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmcore-0818.patch"

Cleanup of some of the "new 2.6" suspend call path:

  - Documents existing practice for non-PCI drivers by naming an enum
    that was previously anonymous (as "enum system_state"), and by passing
    it where an undefined "u32" previously appeared.  GCC won't complain
    if a constant is passed, but other tools could ... and before this,
    it's been unclear what that "u32" meant.

  - Changes the PM_SUSPEND_MEM (and PM_SUSPEND_DISK) enum values so that
    they make sense as PCI power states.  This is a bit ugly, but it

	(a) fixes bugs whereby PCI drivers are being given bogus values,
	    without changing the PCI PM calls (unchanged since 2.4)

	(b) doesn't break the (IMO unwise) assumptions in the "new 2.6" PM
	    code that dev->power.power_state and dev->detach_state and
	    /sys/power/state (and /sys/bus/*/devices/power/state) files all
	    use the same numeric codes.

Really there ought to be distinct "struct" types for device power states
(accomodating bus-specific and device-specific power states) and for system
power policies, but such changes would be rather disruptive.


--- 1.16/include/linux/pm.h	Thu Jul  1 22:23:53 2004
+++ edited/include/linux/pm.h	Wed Aug 18 08:10:49 2004
@@ -193,11 +193,12 @@
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
-enum {
-	PM_SUSPEND_ON,
-	PM_SUSPEND_STANDBY,
-	PM_SUSPEND_MEM,
-	PM_SUSPEND_DISK,
+enum system_state {
+	PM_SUSPEND_ON = 0,
+	PM_SUSPEND_STANDBY = 1,
+	/* HACK ALERT:  PM_SUSPEND_MEM == PCI_D3cold */
+	PM_SUSPEND_MEM = 3,
+	PM_SUSPEND_DISK = 4,
 	PM_SUSPEND_MAX,
 };
 
@@ -241,11 +242,13 @@
 
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
-extern int device_suspend(u32 state);
-extern int device_power_down(u32 state);
+/*
+ * apply system suspend policy to all devices
+ */
+extern int device_suspend(enum system_state reason);
+extern int device_power_down(enum system_state reason);
 extern void device_power_up(void);
 extern void device_resume(void);
-
 
 #endif /* __KERNEL__ */
 
--- 1.7/drivers/base/power/power.h	Wed Jun  9 23:34:24 2004
+++ edited/drivers/base/power/power.h	Wed Aug 18 07:48:04 2004
@@ -66,14 +66,14 @@
 /*
  * suspend.c
  */
-extern int suspend_device(struct device *, u32);
+extern int suspend_device(struct device *, enum system_state);
 
 
 /*
  * runtime.c
  */
 
-extern int dpm_runtime_suspend(struct device *, u32);
+extern int dpm_runtime_suspend(struct device *, enum system_state);
 extern void dpm_runtime_resume(struct device *);
 
 #else /* CONFIG_PM */
@@ -88,7 +88,7 @@
 
 }
 
-static inline int dpm_runtime_suspend(struct device * dev, u32 state)
+static inline int dpm_runtime_suspend(struct device * dev, enum system_state state)
 {
 	return 0;
 }
--- 1.32/drivers/base/power/shutdown.c	Wed Jun  9 23:34:24 2004
+++ edited/drivers/base/power/shutdown.c	Wed Aug 18 07:48:04 2004
@@ -29,7 +29,7 @@
 			dev->driver->shutdown(dev);
 		return 0;
 	}
-	return dpm_runtime_suspend(dev, dev->detach_state);
+	return dpm_runtime_suspend(dev, (enum system_state) dev->detach_state);
 }
 
 
--- 1.16/drivers/base/power/suspend.c	Wed Jun  9 23:34:24 2004
+++ edited/drivers/base/power/suspend.c	Wed Aug 18 07:48:04 2004
@@ -35,7 +35,7 @@
  *	@state:	Power state device is entering.
  */
 
-int suspend_device(struct device * dev, u32 state)
+int suspend_device(struct device * dev, enum system_state state)
 {
 	int error = 0;
 
@@ -70,7 +70,7 @@
  *
  */
 
-int device_suspend(u32 state)
+int device_suspend(enum system_state state)
 {
 	int error = 0;
 
@@ -112,7 +112,7 @@
  *	done, power down system devices.
  */
 
-int device_power_down(u32 state)
+int device_power_down(enum system_state state)
 {
 	int error = 0;
 	struct device * dev;
--- 1.86/kernel/power/swsusp.c	Thu Jul  1 22:23:48 2004
+++ edited/kernel/power/swsusp.c	Wed Aug 18 07:48:04 2004
@@ -699,7 +699,7 @@
 	else
 #endif
 	{
-		device_suspend(3);
+		device_suspend(PM_SUSPEND_DISK);
 		device_shutdown();
 		machine_power_off();
 	}
@@ -720,7 +720,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
-	device_power_down(3);
+	device_power_down(PM_SUSPEND_DISK);
 	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
@@ -789,7 +789,7 @@
 {
 	int is_problem;
 	read_swapfiles();
-	device_power_down(3);
+	device_power_down(PM_SUSPEND_DISK);
 	is_problem = suspend_prepare_image();
 	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
@@ -845,7 +845,7 @@
 		disable_nonboot_cpus();
 		/* Save state of all device drivers, and stop them. */
 		printk("Suspending devices... ");
-		if ((res = device_suspend(3))==0) {
+		if ((res = device_suspend(PM_SUSPEND_DISK))==0) {
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -1200,7 +1200,7 @@
 		goto read_failure;
 	/* FIXME: Should we stop processes here, just to be safer? */
 	disable_nonboot_cpus();
-	device_suspend(3);
+	device_suspend(PM_SUSPEND_DISK);
 	do_magic(1);
 	panic("This never returns");
 

--Boundary-00=_9L3IBdgE7OPL9k+--
