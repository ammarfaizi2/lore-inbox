Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUGQWvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUGQWvW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUGQWri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:47:38 -0400
Received: from digitalimplant.org ([64.62.235.95]:61161 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S263003AbUGQWgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:36:20 -0400
Date: Sat, 17 Jul 2004 15:36:12 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [24/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171532480.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1866, 2004/07/17 14:09:36-07:00, mochel@digitalimplant.org

[Power Mgmt] Merge swsusp entry points with the PM core.

- Add {enable,disable}_nonboot_cpus() to prepare() and finish() in
  kernel/power/disk.c
- Move swsusp __setup options there. Remove resume_status variable in favor
  of simpler 'noresume' variable, and check it in pm_resume().
- Remove software_resume() from swsusp; rename pm_resume() to software_resume().
  The latter is considerably cleaner, and leverages the core code.
- Move software_suspend() to kernel/power/main.c and shrink it down a
  wrapper that  takes pm_sem and calls pm_suspend_disk(), which does the
  same as the old software_suspend() did.
  This keeps the same entry points (via ACPI sleep and the reboot() syscall),
  but actually allows those to use the low-level power states of the system
  rather than always shutting off the system.
- Remove now-unused functions from swsusp.


 include/linux/suspend.h |    1
 kernel/power/disk.c     |   49 ++++++++---
 kernel/power/main.c     |   15 +++
 kernel/power/swsusp.c   |  200 ------------------------------------------------
 4 files changed, 52 insertions(+), 213 deletions(-)


diff -Nru a/include/linux/suspend.h b/include/linux/suspend.h
--- a/include/linux/suspend.h	2004-07-17 14:50:25 -07:00
+++ b/include/linux/suspend.h	2004-07-17 14:50:25 -07:00
@@ -41,7 +41,6 @@
 	printk("Warning: fake suspend called\n");
 	return -EPERM;
 }
-#define software_resume()		do { } while(0)
 #endif	/* CONFIG_SOFTWARE_SUSPEND */


diff -Nru a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c	2004-07-17 14:50:25 -07:00
+++ b/kernel/power/disk.c	2004-07-17 14:50:25 -07:00
@@ -30,6 +30,9 @@
 extern int swsusp_free(void);


+static int noresume = 0;
+char resume_file[256] = CONFIG_PM_STD_PARTITION;
+
 /**
  *	power_down - Shut machine down for hibernate.
  *	@mode:		Suspend-to-disk mode
@@ -99,6 +102,7 @@
 {
 	device_resume();
 	platform_finish();
+	enable_nonboot_cpus();
 	thaw_processes();
 	pm_restore_console();
 }
@@ -126,6 +130,7 @@
 	/* Free memory before shutting down devices. */
 	free_some_memory();

+	disable_nonboot_cpus();
 	if ((error = device_suspend(PM_SUSPEND_DISK)))
 		goto Finish;

@@ -133,6 +138,7 @@
  Finish:
 	platform_finish();
  Thaw:
+	enable_nonboot_cpus();
 	thaw_processes();
 	pm_restore_console();
 	return error;
@@ -188,7 +194,7 @@


 /**
- *	pm_resume - Resume from a saved image.
+ *	software_resume - Resume from a saved image.
  *
  *	Called as a late_initcall (so all devices are discovered and
  *	initialized), we call pmdisk to see if we have a saved image or not.
@@ -199,10 +205,18 @@
  *
  */

-static int pm_resume(void)
+static int software_resume(void)
 {
 	int error;

+	if (noresume) {
+		/**
+		 * FIXME: If noresume is specified, we need to find the partition
+		 * and reset it back to normal swap space.
+		 */
+		return 0;
+	}
+
 	pr_debug("PM: Reading pmdisk image.\n");

 	if ((error = swsusp_read()))
@@ -216,16 +230,6 @@
 	barrier();
 	mb();

-	/* FIXME: The following (comment and mdelay()) are from swsusp.
-	 * Are they really necessary?
-	 *
-	 * We do not want some readahead with DMA to corrupt our memory, right?
-	 * Do it with disabled interrupts for best effect. That way, if some
-	 * driver scheduled DMA, we have good chance for DMA to finish ;-).
-	 */
-	pr_debug("PM: Waiting for DMAs to settle down.\n");
-	mdelay(1000);
-
 	pr_debug("PM: Restoring saved image.\n");
 	swsusp_resume();
 	pr_debug("PM: Restore failed, recovering.n");
@@ -237,7 +241,7 @@
 	return 0;
 }

-late_initcall(pm_resume);
+late_initcall(software_resume);


 static char * pm_disk_modes[] = {
@@ -336,3 +340,22 @@
 }

 core_initcall(pm_disk_init);
+
+
+static int __init resume_setup(char *str)
+{
+	if (noresume)
+		return 1;
+
+	strncpy( resume_file, str, 255 );
+	return 1;
+}
+
+static int __init noresume_setup(char *str)
+{
+	noresume = 1;
+	return 1;
+}
+
+__setup("noresume", noresume_setup);
+__setup("resume=", resume_setup);
diff -Nru a/kernel/power/main.c b/kernel/power/main.c
--- a/kernel/power/main.c	2004-07-17 14:50:25 -07:00
+++ b/kernel/power/main.c	2004-07-17 14:50:25 -07:00
@@ -169,6 +169,21 @@
 	return error;
 }

+/*
+ * This is main interface to the outside world. It needs to be
+ * called from process context.
+ */
+int software_suspend(void)
+{
+	int error;
+
+	if (down_trylock(&pm_sem))
+		return -EBUSY;
+	error = pm_suspend_disk();
+	up(&pm_sem);
+	return error;
+}
+

 /**
  *	pm_suspend - Externally visible function for suspending system.
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:25 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:25 -07:00
@@ -71,11 +71,6 @@

 #include "power.h"

-unsigned char software_suspend_enabled = 0;
-
-#define NORESUME		1
-#define RESUME_SPECIFIED	2
-
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;

@@ -85,8 +80,7 @@
 int pagedir_order_check;
 int nr_copy_pages_check;

-static int resume_status;
-static char resume_file[256] = CONFIG_PM_STD_PARTITION;
+extern char resume_file[];
 static dev_t resume_device;
 /* Local variables that should not be affected by save */
 unsigned int nr_copy_pages __nosavedata = 0;
@@ -664,30 +658,6 @@
 	free_pages(p, pagedir_order);
 }

-static int prepare_suspend_processes(void)
-{
-	sys_sync();	/* Syncing needs pdflushd, so do it before stopping processes */
-	if (freeze_processes()) {
-		printk( KERN_ERR "Suspend failed: Not all processes stopped!\n" );
-		thaw_processes();
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * Try to free as much memory as possible, but do not OOM-kill anyone
- *
- * Notice: all userland should be stopped at this point, or livelock is possible.
- */
-static void free_some_memory(void)
-{
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
-}
-

 static void calc_order(void)
 {
@@ -878,48 +848,6 @@

 }

-static void suspend_power_down(void)
-{
-	extern int C_A_D;
-	C_A_D = 0;
-	printk(KERN_EMERG "%s%s Trying to power down.\n", name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
-#ifdef CONFIG_VT
-	PRINTK(KERN_EMERG "shift_state: %04x\n", shift_state);
-	mdelay(1000);
-	if (TEST_SWSUSP ^ (!!(shift_state & (1 << KG_CTRL))))
-		machine_restart(NULL);
-	else
-#endif
-	{
-		device_suspend(3);
-		device_shutdown();
-		machine_power_off();
-	}
-
-	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", name_suspend);
-	machine_halt();
-	while (1);
-	/* NOTREACHED */
-}
-
-
-static void suspend_finish(void)
-{
-	free_pages((unsigned long) pagedir_nosave, pagedir_order);
-
-#ifdef CONFIG_HIGHMEM
-	printk( "Restoring highmem\n" );
-	restore_highmem();
-#endif
-	device_resume();
-
-#ifdef SUSPEND_CONSOLE
-	acquire_console_sem();
-	update_screen(fg_console);
-	release_console_sem();
-#endif
-}
-

 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
@@ -971,59 +899,6 @@



-static int in_suspend __nosavedata = 0;
-
-/*
- * This is main interface to the outside world. It needs to be
- * called from process context.
- */
-int software_suspend(void)
-{
-	int res;
-	if (!software_suspend_enabled)
-		return -EAGAIN;
-
-	software_suspend_enabled = 0;
-	might_sleep();
-
-	if (arch_prepare_suspend()) {
-		printk("%sArchitecture failed to prepare\n", name_suspend);
-		return -EPERM;
-	}
-	if (pm_prepare_console())
-		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
-	if (!prepare_suspend_processes()) {
-
-		/* At this point, all user processes and "dangerous"
-                   kernel threads are stopped. Free some memory, as we
-                   need half of memory free. */
-
-		free_some_memory();
-		disable_nonboot_cpus();
-		/* Save state of all device drivers, and stop them. */
-		printk("Suspending devices... ");
-		if ((res = device_suspend(3))==0) {
-			in_suspend = 1;
-
-			res = swsusp_save();
-
-			if (!res && in_suspend) {
-				swsusp_write();
-				suspend_power_down();
-			}
-			in_suspend = 0;
-			suspend_finish();
-		}
-		thaw_processes();
-		enable_nonboot_cpus();
-	} else
-		res = -EBUSY;
-	software_suspend_enabled = 1;
-	MDELAY(1000);
-	pm_restore_console();
-	return res;
-}
-
 /* More restore stuff */

 #define does_collide(addr) does_collide_order(pagedir_nosave, addr, 0)
@@ -1370,76 +1245,3 @@
 		pr_debug("pmdisk: Error %d resuming\n", error);
 	return error;
 }
-
-/**
- *	software_resume - Resume from a saved image.
- *
- *	Called as a late_initcall (so all devices are discovered and
- *	initialized), we call swsusp to see if we have a saved image or not.
- *	If so, we quiesce devices, then restore the saved image. We will
- *	return above (in pm_suspend_disk() ) if everything goes well.
- *	Otherwise, we fail gracefully and return to the normally
- *	scheduled program.
- *
- */
-static int __init software_resume(void)
-{
-	if (num_online_cpus() > 1) {
-		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");
-		return -EINVAL;
-	}
-	/* We enable the possibility of machine suspend */
-	software_suspend_enabled = 1;
-	if (!resume_status)
-		return 0;
-
-	printk( "%s", name_resume );
-	if (resume_status == NORESUME) {
-		/*
-		 * FIXME: If noresume is specified, we need to handle by finding
-		 * the right partition and resettting the signature.
-		 */
-		return 0;
-	}
-	MDELAY(1000);
-
-	if (pm_prepare_console())
-		printk("swsusp: Can't allocate a console... proceeding\n");
-
-	if (swsusp_read())
-		goto read_failure;
-	/* FIXME: Should we stop processes here, just to be safer? */
-	disable_nonboot_cpus();
-	device_suspend(3);
-	swsusp_resume();
-	panic("This never returns");
-
-read_failure:
-	pm_restore_console();
-	return 0;
-}
-
-late_initcall(software_resume);
-
-static int __init resume_setup(char *str)
-{
-	if (resume_status == NORESUME)
-		return 1;
-
-	strncpy( resume_file, str, 255 );
-	resume_status = RESUME_SPECIFIED;
-
-	return 1;
-}
-
-static int __init noresume_setup(char *str)
-{
-	resume_status = NORESUME;
-	return 1;
-}
-
-__setup("noresume", noresume_setup);
-__setup("resume=", resume_setup);
-
-EXPORT_SYMBOL(software_suspend);
-EXPORT_SYMBOL(software_suspend_enabled);
