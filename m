Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTE2MIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTE2MIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:08:10 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:63458 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261292AbTE2MIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:08:05 -0400
Date: Thu, 29 May 2003 14:21:22 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.70: some power management changes
Message-ID: <20030529122122.GA21147@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

- much more verbose suspend output in order to actually enable people
  to see what's going on inside the still highly problematic suspend handling
  (on my Dell Inspiron 8000, only ACPI S1 works at all, and only
  after a LOT of investigation and tweaking)
  And let's be extra aggressive about drivers that don't have suspend
  handlers yet but might need them and thus cause problems on resume
  due to missing hardware state saving...
  A lot of drivers don't handle that yet, so point that out properly for the
  time being.
- fix invidual suspend handlers' output to be able to properly identify
  them
- rename strangely named INTERESTING define to IGNORE_SPECIAL_THREADS which
  makes much more sense
- some spelling stuff
- update my email address ;)

This patch doesn't include the pccardd suspend fix, since I noticed that
it has been fixed by someone else already ;-\
(which was pccardd-suspend-fix.patch)

Patch against vanilla 2.5.70.

I just hope that the right person knows that (s)he is supposed to commit it.
(or not...)

diff -urN linux-2.5.70.orig/drivers/acpi/sleep/main.c linux-2.5.70/drivers/acpi/sleep/main.c
--- linux-2.5.70.orig/drivers/acpi/sleep/main.c	2003-05-28 17:56:34.000000000 +0200
+++ linux-2.5.70/drivers/acpi/sleep/main.c	2003-05-27 14:26:25.000000000 +0200
@@ -67,8 +67,8 @@
  *
  * This handles saving all context to memory, and possibly disk.
  * First, we call to the device driver layer to save device state.
- * Once we have that, we save whatevery processor and kernel state we
- * need to memory.
+ * Once we have that, we save whatever processor and kernel state we
+ * need to memorize.
  * If we're entering S4, we then write the memory image to disk.
  *
  * Only then is it safe for us to power down devices, since we may need
@@ -250,8 +250,8 @@
 	/* perform OS-specific sleep actions */
 	status = acpi_system_suspend(state);
 
-	/* Even if we failed to go to sleep, all of the devices are in an suspended
-	 * mode. So, we run these unconditionaly to make sure we have a usable system
+	/* Even if we failed to go to sleep, all of the devices are in a suspended
+	 * mode. So, we run these unconditionally to make sure we have a usable system
 	 * no matter what.
 	 */
 	acpi_leave_sleep_state(state);
diff -urN linux-2.5.70.orig/drivers/base/power.c linux-2.5.70/drivers/base/power.c
--- linux-2.5.70.orig/drivers/base/power.c	2003-05-28 17:55:23.000000000 +0200
+++ linux-2.5.70/drivers/base/power.c	2003-05-29 02:16:03.000000000 +0200
@@ -20,7 +20,7 @@
 extern struct subsystem devices_subsys;
 
 /**
- * device_suspend - suspend/remove all devices on the device ree
+ * device_suspend - suspend/remove all devices on the device tree
  * @state:	state we're entering
  * @level:	what stage of the suspend process we're at
  *    (emb: it seems that these two arguments are described backwards of what
@@ -35,19 +35,25 @@
 	struct list_head * node;
 	int error = 0;
 
-	printk(KERN_EMERG "Suspending devices\n");
+	printk(KERN_EMERG "Suspending devices (%d, %d)\n", state, level);
 
 	down_write(&devices_subsys.rwsem);
 	list_for_each(node,&devices_subsys.kset.list) {
 		struct device * dev = to_dev(node);
-		if (dev->driver && dev->driver->suspend) {
-			pr_debug("suspending device %s\n",dev->name);
-			error = dev->driver->suspend(dev,state,level);
-			if (error)
-				printk(KERN_ERR "%s: suspend returned %d\n",dev->name,error);
+		if (dev->driver)
+		{
+			if (dev->driver->suspend) {
+				printk("suspending device %s\n",dev->name);
+				error = dev->driver->suspend(dev,state,level);
+				if (error)
+					printk(KERN_ERR "%s: suspend failed, error %d\n",dev->name,error);
+			}
+			else
+				printk("no suspend function (yet?) in driver for %s\n",dev->name);
 		}
 	}
 	up_write(&devices_subsys.rwsem);
+
 	return error;
 }
 
@@ -62,13 +68,16 @@
 void device_resume(u32 level)
 {
 	struct list_head * node;
+	int error = 0;
 
 	down_write(&devices_subsys.rwsem);
 	list_for_each_prev(node,&devices_subsys.kset.list) {
 		struct device * dev = to_dev(node);
 		if (dev->driver && dev->driver->resume) {
-			pr_debug("resuming device %s\n",dev->name);
-			dev->driver->resume(dev,level);
+			printk("resuming device %s\n",dev->name);
+			error = dev->driver->resume(dev,level);
+			if (error)
+				printk(KERN_ERR "%s: resume failed, error %d\n",dev->name,error);
 		}
 	}
 	up_write(&devices_subsys.rwsem);
diff -urN linux-2.5.70.orig/drivers/ide/ide-disk.c linux-2.5.70/drivers/ide/ide-disk.c
--- linux-2.5.70.orig/drivers/ide/ide-disk.c	2003-05-28 17:58:47.000000000 +0200
+++ linux-2.5.70/drivers/ide/ide-disk.c	2003-05-28 18:38:10.000000000 +0200
@@ -1509,7 +1509,7 @@
 {
 	ide_drive_t *drive = dev->driver_data;
 
-	printk("Suspending device %p\n", dev->driver_data);
+	printk("IDE device %s: suspend to state %d\n", drive->name, state);
 
 	/* I hope that every freeze operation from the upper levels have
 	 * already been done...
@@ -1519,7 +1519,6 @@
 		return 0;
 
 	/* set the drive to standby */
-	printk(KERN_INFO "suspending: %s ", drive->name);
 	do_idedisk_standby(drive);
 	drive->blocked = 1;
 
diff -urN linux-2.5.70.orig/drivers/ide/ide-taskfile.c linux-2.5.70/drivers/ide/ide-taskfile.c
--- linux-2.5.70.orig/drivers/ide/ide-taskfile.c	2003-05-28 17:58:13.000000000 +0200
+++ linux-2.5.70/drivers/ide/ide-taskfile.c	2003-05-27 14:10:28.000000000 +0200
@@ -13,12 +13,12 @@
  *  Fill me in stupid !!!
  *
  *  HOST:
- *	General refers to the Controller and Driver "pair".
+ *	Generally refers to the Controller and Driver "pair".
  *  DATA HANDLER:
  *	Under the context of Linux it generally refers to an interrupt handler.
  *	However, it correctly describes the 'HOST'
  *  DATA BLOCK:
- *	The amount of data needed to be transfered as predefined in the
+ *	The amount of data needed to be transferred as predefined in the
  *	setup of the device.
  *  STORAGE ATOMIC:
  *	The 'DATA BLOCK' associated to the 'DATA HANDLER', and can be as
diff -urN linux-2.5.70.orig/kernel/suspend.c linux-2.5.70/kernel/suspend.c
--- linux-2.5.70.orig/kernel/suspend.c	2003-05-28 17:59:02.000000000 +0200
+++ linux-2.5.70/kernel/suspend.c	2003-05-27 16:05:06.000000000 +0200
@@ -24,7 +24,7 @@
  * Straightened the critical function in order to prevent compilers from
  * playing tricks with local variables.
  *
- * Andreas Mohr <a.mohr@mailto.de>
+ * Andreas Mohr <andi@lisas.de>
  *
  * Alex Badea <vampire@go.ro>:
  * Fixed runaway init
@@ -164,7 +164,7 @@
  * Refrigerator and related stuff
  */
 
-#define INTERESTING(p) \
+#define IGNORE_SPECIAL_THREADS(p) \
 			/* We don't want to touch kernel_threads..*/ \
 			if (p->flags & PF_IOTHREAD) \
 				continue; \
@@ -205,6 +205,9 @@
        unsigned long start_time;
 	struct task_struct *g, *p;
 	
+	/* keep iterating over all threads and signal to them that they
+	 * are supposed to freeze (in signal handler), until timeout happens.
+	 */
 	printk( "Stopping tasks: " );
 	start_time = jiffies;
 	do {
@@ -212,14 +215,16 @@
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
-			INTERESTING(p);
+			IGNORE_SPECIAL_THREADS(p);
 			if (p->flags & PF_FROZEN)
 				continue;
 
+			p->flags |= PF_FREEZE; /* this task should be frozen */
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
-			p->flags |= PF_FREEZE;
 			spin_lock_irqsave(&p->sighand->siglock, flags);
+			/* send signal to thread in order to schedule to it
+			 * and freeze it in its own context there */
 			signal_wake_up(p, 0);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
 			todo++;
@@ -232,7 +237,7 @@
 			return todo;
 		}
 	} while(todo);
-	
+ 	
 	printk( "|\n" );
 	BUG_ON(in_atomic());
 	return 0;
@@ -245,7 +250,7 @@
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
+		IGNORE_SPECIAL_THREADS(p);
 		
 		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
 		else

Andreas Mohr
