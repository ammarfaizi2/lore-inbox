Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUHGXwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUHGXwo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUHGXwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:52:17 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:34953 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S264815AbUHGXuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:50:40 -0400
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Solving suspend-level confusion
Date: Sat, 7 Aug 2004 16:30:37 -0700
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200408020940.14300.david-b@pacbell.net> <1091494202.7395.105.camel@gaston>
In-Reply-To: <1091494202.7395.105.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408071630.37086.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dYWFBmp1kQJJ7m7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dYWFBmp1kQJJ7m7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 02 August 2004 17:50, Benjamin Herrenschmidt wrote:

> you ask a driver to quiesce, it's the driver's policy to decide what is
> the best suitable HW state based on what system state we are going into
> (or what is asked by userland, that is quiesce, shutdown, or whatever
> semantics we'll provide once we clanup the sysfs side of things).

So long as it's policy, I want drivers _needing_ to handle it to be the
very last choice on the list ... not the very first one!

I think the "cleanup" needs to handle many different kinds of
suspend things ... policy objects, bus-specific states, driver-specific
states, system policy rules, and so on.  Step one, stop using "u32"
for all of them, instead of some kind of typed pointer!


> > How does your answer change when you go down the path I was
> > describing:  the drivers are passed a device-specific state?  Which for
> > PCI means no API changes; the drivers already expect to see
> > the PCI state number.
> 
> Change ? How so ? I always said the same thing... and no, that is NOT a
> PCI state number, 

Since 2.4, the PCI calls have said it's a PCI state number;
that'd be the change, making it NOT be a PCI state number.


> > > >			the PM core self-deadlocks since
> > > > suspend/resume outcalls are done while holding the semaphore
> > > > that device_pm_remove() needs, ugh.
> > > 
> > > That's an old problem,....
> > 
> > Patrick once posted a patch that morphed the semaphore into a
> > spinlock (in at least some cases), which worked for me, but that
> > never got merged.
> 
> Patrick ? Do you still have that around ?

I dug it up; attached, that machine hasn't quite entirely died yet!


> Low level drivers, at this point, don't really know if they are in use
> in some cases, do they ? 

There are levels of usage they can see, others they can't.
Higher level drivers can't tell what lower level ones
know either ... :)


> But anyway, to get userland originated suspend 
> to possibly do anything useful, we first need to fix sysfs so that it
> does partial tree suspend and not individual deviecs suspend only.

Yes, something that turns a tree into a list (that nobody else can
morph!) and then walks the list ... recursion ok only for prototypes.


> There's also a semantic breakage between who updates the power state in
> struct device, system suspend relies on the driver doing so afaik, while
> sysfs originated calls to the driver suspend will do it in sysfs (which
> I think is the wrong thing to do).

That is, drivers should always do this?  That makes sense to me; how
else are they going to be able to report actual suspend state (which
may not be as requested)? And hmm, sysfs PCI state would be better
read (and written!) as "PCI_D3" rather than "ACPI_D2".


> > Actually no; I was describing what would be an ACPI G0/S0 state
> > where most devices/drivers are powered down, not the G1/S1 state
> > described as "suspend".   CPU would be running, for example.  It's
> > a power management policy, not a suspend policy ... it kicks in
> > during normal operation.
> 
> And who wakes up the devices in this ACPI state ? (just curious)

Whoever suspended the device should be able to resume it;
they're the ones with the local knowledge, after all!  Unless
you're maybe thinking that global rules should apply too... :)

- Dave



--Boundary-00=_dYWFBmp1kQJJ7m7
Content-Type: text/x-diff;
  charset="utf-8";
  name="pm-pat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pm-pat.patch"

Date: Mon, 13 Oct 2003 15:29:03 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>

Oh man, I don't know what I was thinking, but there was some seriously 
wonky code in there. Appended is a patch that changes the semaphore to a 
spin lock and only keeps it held over operations dealing with the list and 
the dev->power.power_state field. 

Date: Wed, 15 Oct 2003 20:19:06 -0700 (PDT)
From: David Brownell <dbrownell@users.sourceforge.net>

I did the "apm -s" test on that machine, and this problem is gone.
(And looks more reasonable than my 2.6.0-test7 patch.)


--- 1.12/drivers/base/power/main.c	Tue Sep  9 11:22:35 2003
+++ edited/drivers/base/power/main.c	Wed Oct 15 17:37:19 2003
@@ -28,7 +28,7 @@
 LIST_HEAD(dpm_off);
 LIST_HEAD(dpm_off_irq);
 
-DECLARE_MUTEX(dpm_sem);
+spinlock_t dpm_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * PM Reference Counting.
@@ -76,12 +76,12 @@
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
 	atomic_set(&dev->power.pm_users,0);
-	down(&dpm_sem);
-	list_add_tail(&dev->power.entry,&dpm_active);
 	device_pm_set_parent(dev,dev->parent);
-	if ((error = dpm_sysfs_add(dev)))
-		list_del(&dev->power.entry);
-	up(&dpm_sem);
+	if (!(error = dpm_sysfs_add(dev))) {
+		spin_lock(&dpm_lock);
+		list_add_tail(&dev->power.entry,&dpm_active);
+		spin_unlock(&dpm_lock);
+	}
 	return error;
 }
 
@@ -89,11 +89,11 @@
 {
 	pr_debug("PM: Removing info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
-	down(&dpm_sem);
 	dpm_sysfs_remove(dev);
 	device_pm_release(dev->power.pm_parent);
+	spin_lock(&dpm_lock);
 	list_del(&dev->power.entry);
-	up(&dpm_sem);
+	spin_unlock(&dpm_lock);
 }
 
 
===== drivers/base/power/power.h 1.6 vs edited =====
--- 1.6/drivers/base/power/power.h	Mon Aug 25 11:08:21 2003
+++ edited/drivers/base/power/power.h	Wed Oct 15 17:37:19 2003
@@ -25,7 +25,7 @@
 /*
  * Used to synchronize global power management operations.
  */
-extern struct semaphore dpm_sem;
+extern spinlock_t dpm_lock;
 
 /* 
  * The PM lists.
===== drivers/base/power/resume.c 1.11 vs edited =====
--- 1.11/drivers/base/power/resume.c	Mon Aug 25 11:08:21 2003
+++ edited/drivers/base/power/resume.c	Wed Oct 15 17:37:19 2003
@@ -22,25 +22,23 @@
 
 int resume_device(struct device * dev)
 {
-	if (dev->bus && dev->bus->resume)
-		return dev->bus->resume(dev);
-	return 0;
-}
-
+	int error = 0;
 
+	if (dev->bus && dev->bus->resume)
+		error = dev->bus->resume(dev);
 
-void dpm_resume(void)
-{
-	while(!list_empty(&dpm_off)) {
-		struct list_head * entry = dpm_off.next;
-		struct device * dev = to_device(entry);
-		list_del_init(entry);
-		resume_device(dev);
-		list_add_tail(entry,&dpm_active);
-	}
+	spin_lock(&dpm_lock);
+	if (!error) {
+		list_add(&dev->power.entry,&dpm_active);
+		dev->power.power_state = 0;
+	} else
+		list_add(&dev->power.entry,&dpm_off);
+	spin_unlock(&dpm_lock);
+	return error;
 }
 
 
+
 /**
  *	device_resume - Restore state of each device in system.
  *
@@ -50,35 +48,21 @@
 
 void device_resume(void)
 {
-	down(&dpm_sem);
-	dpm_resume();
-	up(&dpm_sem);
+	spin_lock(&dpm_lock);
+	while(!list_empty(&dpm_off)) {
+		struct list_head * entry = dpm_off.next;
+		struct device * dev = to_device(entry);
+		list_del_init(entry);
+		spin_unlock(&dpm_lock);
+		resume_device(dev);
+		spin_lock(&dpm_lock);
+	}
+	spin_unlock(&dpm_lock);
 }
 
 EXPORT_SYMBOL(device_resume);
 
 
-/**
- *	device_power_up_irq - Power on some devices. 
- *
- *	Walk the dpm_off_irq list and power each device up. This 
- *	is used for devices that required they be powered down with
- *	interrupts disabled. As devices are powered on, they are moved to
- *	the dpm_suspended list.
- *
- *	Interrupts must be disabled when calling this. 
- */
-
-void dpm_power_up(void)
-{
-	while(!list_empty(&dpm_off_irq)) {
-		struct list_head * entry = dpm_off_irq.next;
-		list_del_init(entry);
-		resume_device(to_device(entry));
-		list_add_tail(entry,&dpm_active);
-	}
-}
-
 
 /**
  *	device_pm_power_up - Turn on all devices that need special attention.
@@ -91,7 +75,6 @@
 void device_power_up(void)
 {
 	sysdev_resume();
-	dpm_power_up();
 }
 
 EXPORT_SYMBOL(device_power_up);
===== drivers/base/power/runtime.c 1.2 vs edited =====
--- 1.2/drivers/base/power/runtime.c	Tue Aug 19 23:23:32 2003
+++ edited/drivers/base/power/runtime.c	Wed Oct 15 17:37:19 2003
@@ -10,14 +10,6 @@
 #include "power.h"
 
 
-static void runtime_resume(struct device * dev)
-{
-	if (!dev->power.power_state)
-		return;
-	resume_device(dev);
-}
-
-
 /**
  *	dpm_runtime_resume - Power one device back on.
  *	@dev:	Device.
@@ -30,9 +22,15 @@
 
 void dpm_runtime_resume(struct device * dev)
 {
-	down(&dpm_sem);
-	runtime_resume(dev);
-	up(&dpm_sem);
+	spin_lock(&dpm_lock);
+	if (list_empty(&dev->power.entry) || 
+	    !(dev->power.power_state)) {
+		spin_unlock(&dpm_lock);
+		return;
+	}
+	list_del_init(&dev->power.entry);
+	spin_unlock(&dpm_lock);
+	resume_device(dev);
 }
 
 
@@ -44,20 +42,17 @@
 
 int dpm_runtime_suspend(struct device * dev, u32 state)
 {
-	int error = 0;
-
-	down(&dpm_sem);
-	if (dev->power.power_state == state)
-		goto Done;
-
+	spin_lock(&dpm_lock);
+	if (list_empty(&dev->power.entry) || 
+	    (dev->power.power_state == state)) {
+		spin_unlock(&dpm_lock);
+		return 0;
+	}
+	list_del_init(&dev->power.entry);
+	spin_unlock(&dpm_lock);
 	if (dev->power.power_state)
 		dpm_runtime_resume(dev);
-
-	if (!(error = suspend_device(dev,state)))
-		dev->power.power_state = state;
- Done:
-	up(&dpm_sem);
-	return error;
+	return suspend_device(dev,state);
 }
 
 
@@ -73,7 +68,7 @@
  */
 void dpm_set_power_state(struct device * dev, u32 state)
 {
-	down(&dpm_sem);
+	spin_lock(&dpm_lock);
 	dev->power.power_state = state;
-	up(&dpm_sem);
+	spin_unlock(&dpm_lock);
 }
===== drivers/base/power/suspend.c 1.11 vs edited =====
--- 1.11/drivers/base/power/suspend.c	Mon Aug 25 11:08:21 2003
+++ edited/drivers/base/power/suspend.c	Wed Oct 15 17:37:19 2003
@@ -42,13 +42,13 @@
 	if (dev->bus && dev->bus->suspend)
 		error = dev->bus->suspend(dev,state);
 
+	spin_lock(&dpm_lock);
 	if (!error) {
-		list_del(&dev->power.entry);
 		list_add(&dev->power.entry,&dpm_off);
-	} else if (error == -EAGAIN) {
-		list_del(&dev->power.entry);
-		list_add(&dev->power.entry,&dpm_off_irq);
-	}
+		dev->power.power_state = state;
+	} else 
+		list_add(&dev->power.entry,&dpm_active);
+	spin_unlock(&dpm_lock);
 	return error;
 }
 
@@ -63,36 +63,30 @@
  *	the device to the dpm_off list. If it returns -EAGAIN, we move it to 
  *	the dpm_off_irq list. If we get a different error, try and back out. 
  *
- *	If we hit a failure with any of the devices, call device_resume()
+ *	If we hit a failure with any of the devices, call dpm_resume()
  *	above to bring the suspended devices back to life. 
  *
- *	Note this function leaves dpm_sem held to
- *	a) block other devices from registering.
- *	b) prevent other PM operations from happening after we've begun.
- *	c) make sure we're exclusive when we disable interrupts.
- *
  */
 
 int device_suspend(u32 state)
 {
 	int error = 0;
 
-	down(&dpm_sem);
+	spin_lock(&dpm_lock);
 	while(!list_empty(&dpm_active)) {
 		struct list_head * entry = dpm_active.prev;
 		struct device * dev = to_device(entry);
-		if ((error = suspend_device(dev,state))) {
-			if (error != -EAGAIN)
-				goto Error;
-			else
-				error = 0;
-		}
+		list_del_init(entry);
+		spin_unlock(&dpm_lock);
+		if ((error = suspend_device(dev,state)))
+			goto Error;
+		spin_lock(&dpm_lock);
 	}
+	spin_unlock(&dpm_lock);
  Done:
-	up(&dpm_sem);
 	return error;
  Error:
-	dpm_resume();
+	device_resume();
 	goto Done;
 }
 
@@ -110,23 +104,7 @@
 
 int device_power_down(u32 state)
 {
-	int error = 0;
-	struct device * dev;
-
-	list_for_each_entry_reverse(dev,&dpm_off_irq,power.entry) {
-		if ((error = suspend_device(dev,state)))
-			break;
-	} 
-	if (error)
-		goto Error;
-	if ((error = sysdev_suspend(state)))
-		goto Error;
- Done:
-	return error;
- Error:
-	dpm_power_up();
-	goto Done;
+	return sysdev_suspend(state);
 }
 
 EXPORT_SYMBOL(device_power_down);
-

--Boundary-00=_dYWFBmp1kQJJ7m7--
