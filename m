Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUHTKGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUHTKGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 06:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUHTKGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 06:06:23 -0400
Received: from gprs214-64.eurotel.cz ([160.218.214.64]:4224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265099AbUHTKF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 06:05:57 -0400
Date: Fri, 20 Aug 2004 12:01:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>, benh@kernel.crashing.org,
       David Brownell <david-b@pacbell.net>
Subject: Re: Use global system_state to avoid system-state confusion
Message-ID: <20040820100153.GA866@elf.ucw.cz>
References: <20040819113600.GA1317@elf.ucw.cz> <1092913877.27919.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092913877.27919.13.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I started using system_state (already defined in kernel.h) to allow
> > drivers to do something different in response to swsusp. This at least
> > kills ide-disk.c hack.
> > 
> > Please apply,
> >  
> > -	printk("Shutdown: %s\n", drive->name);
> >  	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
> >  }
> 
> Please leave the printk - its very handy for debugging IDE exit paths,
> and those are not entirely bug free yet.

Okay, here's newer patch. It does:

* use system_state so that disk is not spun down during swsusp
* kill unused constants from old pm.h sections, and make those
  sections deprecated
* introduce enums into kernel/power so that we have more descriptive
  types than u32
* pass 3 to device_suspend in suspend-to-RAM case. This should solve
  EHCI problems.

Please apply, 

								Pavel

--- linux-mm.middle/drivers/base/power/power.h	2004-08-15 19:14:55.000000000 +0200
+++ linux-mm/drivers/base/power/power.h	2004-08-20 10:27:58.000000000 +0200
@@ -1,5 +1,4 @@
-
-
+/* FIXME: This needs explanation... */
 enum {
 	DEVICE_PM_ON,
 	DEVICE_PM1,
--- linux-mm.middle/drivers/ide/ide-disk.c	2004-08-17 12:21:43.000000000 +0200
+++ linux-mm/drivers/ide/ide-disk.c	2004-08-20 10:27:58.000000000 +0200
@@ -1406,7 +1406,7 @@
 {
 	switch (rq->pm->pm_step) {
 	case idedisk_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
-		if (rq->pm->pm_state == 4)
+		if (system_state == SYSTEM_SNAPSHOT)
 			rq->pm->pm_step = ide_pm_state_completed;
 		else
 			rq->pm->pm_step = idedisk_pm_standby;
--- linux-mm.middle/include/linux/kernel.h	2004-08-17 12:21:44.000000000 +0200
+++ linux-mm/include/linux/kernel.h	2004-08-20 10:27:58.000000000 +0200
@@ -136,6 +136,9 @@
 extern enum system_states {
 	SYSTEM_BOOTING,
 	SYSTEM_RUNNING,
+	SYSTEM_SNAPSHOT,
+	SYSTEM_DISK_SUSPEND,
+	SYSTEM_RAM_SUSPEND,
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
--- linux-mm.middle/include/linux/pm.h	2004-08-15 19:15:05.000000000 +0200
+++ linux-mm/include/linux/pm.h	2004-08-20 11:33:32.000000000 +0200
@@ -28,33 +28,20 @@
 #include <asm/atomic.h>
 
 /*
- * Power management requests
+ * Power management requests... these are passed to pm_send_all() and friends.
+ *
+ * these functions are old and deprecated, see below.
  */
-enum
+typedef enum pm_request
 {
 	PM_SUSPEND, /* enter D1-D3 */
 	PM_RESUME,  /* enter D0 */
-
-	PM_SAVE_STATE,  /* save device's state */
-
-	/* enable wake-on */
-	PM_SET_WAKEUP,
-
-	/* bus resource management */
-	PM_GET_RESOURCES,
-	PM_SET_RESOURCES,
-
-	/* base station management */
-	PM_EJECT,
-	PM_LOCK,
-};
-
-typedef int pm_request_t;
+} pm_request_t;
 
 /*
- * Device types
+ * Device types... these are passed to pm_register
  */
-enum
+typedef enum pm_dev_type
 {
 	PM_UNKNOWN_DEV = 0, /* generic */
 	PM_SYS_DEV,	    /* system device (fan, KB controller, ...) */
@@ -63,9 +50,7 @@
 	PM_SCSI_DEV,	    /* SCSI device */
 	PM_ISA_DEV,	    /* ISA device */
 	PM_MTD_DEV,	    /* Memory Technology Device */
-};
-
-typedef int pm_dev_t;
+} pm_dev_t;
 
 /*
  * System device hardware ID (PnP) values
@@ -186,6 +171,8 @@
 
 #endif /* CONFIG_PM */
 
+/* Functions above this comment are list-based old-style power
+ * managment. Please avoid using them.  */
 
 /*
  * Callbacks for platform drivers to implement.
@@ -193,15 +180,15 @@
 extern void (*pm_idle)(void);
 extern void (*pm_power_off)(void);
 
-enum {
-	PM_SUSPEND_ON,
-	PM_SUSPEND_STANDBY,
-	PM_SUSPEND_MEM,
-	PM_SUSPEND_DISK,
+enum suspend_state {
+	PM_SUSPEND_ON = 0,
+	PM_SUSPEND_STANDBY = 1,
+	PM_SUSPEND_MEM = 2,
+	PM_SUSPEND_DISK = 3,
 	PM_SUSPEND_MAX,
 };
 
-enum {
+enum suspend_disk_method {
 	PM_DISK_FIRMWARE = 1,
 	PM_DISK_PLATFORM,
 	PM_DISK_SHUTDOWN,
@@ -211,15 +198,15 @@
 
 
 struct pm_ops {
-	u32	pm_disk_mode;
-	int (*prepare)(u32 state);
-	int (*enter)(u32 state);
-	int (*finish)(u32 state);
+	enum suspend_disk_method pm_disk_mode;
+	int (*prepare)(enum suspend_state state);
+	int (*enter)(enum suspend_state state);
+	int (*finish)(enum suspend_state state);
 };
 
 extern void pm_set_ops(struct pm_ops *);
 
-extern int pm_suspend(u32 state);
+extern int pm_suspend(enum suspend_state state);
 
 
 /*
--- linux-mm.middle/kernel/power/disk.c	2004-08-17 12:21:44.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2004-08-20 11:38:15.000000000 +0200
@@ -15,10 +15,11 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/device.h>
 #include "power.h"
 
 
-extern u32 pm_disk_mode;
+extern enum suspend_disk_method pm_disk_mode;
 extern struct pm_ops * pm_ops;
 
 extern int swsusp_suspend(void);
@@ -41,7 +42,7 @@
  *	there ain't no turning back.
  */
 
-static int power_down(u32 mode)
+static int power_down(enum suspend_disk_method mode)
 {
 	unsigned long flags;
 	int error = 0;
@@ -49,18 +50,23 @@
 	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
+		system_state = SYSTEM_DISK_SUSPEND;
 		device_power_down(PM_SUSPEND_DISK);
 		error = pm_ops->enter(PM_SUSPEND_DISK);
 		break;
 	case PM_DISK_SHUTDOWN:
+		system_state = SYSTEM_POWER_OFF;
 		printk("Powering off system\n");
 		device_shutdown();
 		machine_power_off();
 		break;
 	case PM_DISK_REBOOT:
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		machine_restart(NULL);
 		break;
+	default:
+		BUG();
 	}
 	machine_halt();
 	/* Valid image is on the disk, if we continue we risk serious data corruption
@@ -114,6 +120,7 @@
 {
 	int error;
 
+	system_state = SYSTEM_SNAPSHOT;
 	pm_prepare_console();
 
 	sys_sync();
@@ -226,6 +233,7 @@
 
 	pr_debug("PM: Preparing system for restore.\n");
 
+	system_state = SYSTEM_SNAPSHOT;
 	if ((error = prepare()))
 		goto Free;
 
@@ -292,7 +300,7 @@
 	int i;
 	int len;
 	char *p;
-	u32 mode = 0;
+	enum suspend_disk_method mode = 0;
 
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
--- linux-mm.middle/kernel/power/main.c	2004-08-17 12:22:47.000000000 +0200
+++ linux-mm/kernel/power/main.c	2004-08-20 11:32:56.000000000 +0200
@@ -22,7 +22,7 @@
 DECLARE_MUTEX(pm_sem);
 
 struct pm_ops * pm_ops = NULL;
-u32 pm_disk_mode = PM_DISK_SHUTDOWN;
+enum suspend_disk_method pm_disk_mode = PM_DISK_SHUTDOWN;
 
 /**
  *	pm_set_ops - Set the global power method table. 
@@ -46,7 +46,7 @@
  *	the platform can enter the requested state.
  */
 
-static int suspend_prepare(u32 state)
+static int suspend_prepare(enum suspend_state state)
 {
 	int error = 0;
 
@@ -65,7 +65,11 @@
 			goto Thaw;
 	}
 
-	if ((error = device_suspend(state)))
+	/* FIXME: this is suspend confusion biting us. If we pass
+	   state, we'll pass 2 in suspend-to-RAM case; EHCI will
+	   actually break suspend, because it interprets 2 as PCI_D2
+	   state. Oops. */
+	if ((error = device_suspend(3)))
 		goto Finish;
 	return 0;
  Finish:
@@ -78,13 +82,14 @@
 }
 
 
-static int suspend_enter(u32 state)
+static int suspend_enter(enum suspend_state state)
 {
 	int error = 0;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if ((error = device_power_down(state)))
+	/* FIXME: see suspend_prepare */
+	if ((error = device_power_down(3)))
 		goto Done;
 	error = pm_ops->enter(state);
 	device_power_up();
@@ -102,7 +107,7 @@
  *	console that we've allocated.
  */
 
-static void suspend_finish(u32 state)
+static void suspend_finish(enum suspend_state state)
 {
 	device_resume();
 	if (pm_ops && pm_ops->finish)
@@ -133,7 +138,7 @@
  *	we've woken up).
  */
 
-static int enter_state(u32 state)
+static int enter_state(enum suspend_state state)
 {
 	int error;
 
@@ -151,6 +156,7 @@
 		goto Unlock;
 	}
 
+	system_state = SYSTEM_RAM_SUSPEND;
 	pr_debug("PM: Preparing system for suspend\n");
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
@@ -162,6 +168,7 @@
 	suspend_finish(state);
  Unlock:
 	up(&pm_sem);
+	system_state = SYSTEM_RUNNING;
 	return error;
 }
 
@@ -183,7 +190,7 @@
  *	structure, and enter (above).
  */
 
-int pm_suspend(u32 state)
+int pm_suspend(enum suspend_state state)
 {
 	if (state > PM_SUSPEND_ON && state < PM_SUSPEND_MAX)
 		return enter_state(state);
@@ -221,7 +228,7 @@
 
 static ssize_t state_store(struct subsystem * subsys, const char * buf, size_t n)
 {
-	u32 state = PM_SUSPEND_STANDBY;
+	enum suspend_state state = PM_SUSPEND_STANDBY;
 	char ** s;
 	char *p;
 	int error;
--- linux-mm.middle/kernel/power/swsusp.c	2004-08-17 13:02:45.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-08-20 10:27:58.000000000 +0200
@@ -1119,7 +1119,7 @@
 		 */
 		error = bio_write_page(0,&swsusp_header);
 	} else { 
-		pr_debug(KERN_ERR "swsusp: Invalid partition type.\n");
+		pr_debug(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
 	}
 	if (!error)




-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
