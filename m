Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbUKXNEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbUKXNEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbUKXNDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:03:33 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:38292 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262645AbUKXNBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:16 -0500
Subject: Suspend 2 merge: 10/51: Exports for suspend built as modules.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101294252.5805.228.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:36 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New exports for suspend. I've cut them down some as a result of the last
review, but could perhaps do more? Would people prefer to see a single
struct wrapping exported functions?

The sys_ functions are exported because a while ago, people suggested I
use /dev/console to output text that doesn't need to be logged, and I
also use /dev/splash for the bootsplash support. These functions were
needed in order to get access to those files when we're resuming, and
the ioctl for setting up writing text (canon). I'd prefer to use
internal routines, but I suppose this way I get the text display on the
serial console too :>

Avenrun I'd gladly drop, but apparently sendmail has some ugliness where
it won't deliver your mail if the load average gets too high. Guess what
suspending to disk does to your load average? (So we save the avenrun
values at the start of the cycle and restore them at the end - anyone
got a better idea? I'd love to do something different here).

diff -ruN 400-exports-old/drivers/acpi/hardware/hwsleep.c 400-exports-new/drivers/acpi/hardware/hwsleep.c
--- 400-exports-old/drivers/acpi/hardware/hwsleep.c	2004-11-03 21:51:15.000000000 +1100
+++ 400-exports-new/drivers/acpi/hardware/hwsleep.c	2004-11-04 16:27:40.000000000 +1100
@@ -43,6 +43,7 @@
  */
 
 #include <acpi/acpi.h>
+#include <linux/module.h>
 
 #define _COMPONENT          ACPI_HARDWARE
 	 ACPI_MODULE_NAME    ("hwsleep")
@@ -591,3 +592,6 @@
 
 	return_ACPI_STATUS (status);
 }
+
+/* For suspend2 */
+EXPORT_SYMBOL(acpi_leave_sleep_state);
diff -ruN 400-exports-old/fs/bio.c 400-exports-new/fs/bio.c
--- 400-exports-old/fs/bio.c	2004-11-03 21:53:50.000000000 +1100
+++ 400-exports-new/fs/bio.c	2004-11-04 16:27:40.000000000 +1100
@@ -1002,3 +1002,4 @@
 EXPORT_SYMBOL(bio_split_pool);
 EXPORT_SYMBOL(bio_copy_user);
 EXPORT_SYMBOL(bio_uncopy_user);
+EXPORT_SYMBOL(bio_set_pages_dirty);
diff -ruN 400-exports-old/fs/ioctl.c 400-exports-new/fs/ioctl.c
--- 400-exports-old/fs/ioctl.c	2004-11-03 21:51:52.000000000 +1100
+++ 400-exports-new/fs/ioctl.c	2004-11-04 16:27:40.000000000 +1100
@@ -138,8 +138,7 @@
 
 /*
  * Platforms implementing 32 bit compatibility ioctl handlers in
- * modules need this exported
+ * modules need this exported. So does Suspend2 (when made as
+ * modules), so the export_symbol is now unconditional.
  */
-#ifdef CONFIG_COMPAT
 EXPORT_SYMBOL(sys_ioctl);
-#endif
diff -ruN 400-exports-old/fs/namei.c 400-exports-new/fs/namei.c
--- 400-exports-old/fs/namei.c	2004-11-03 21:53:11.000000000 +1100
+++ 400-exports-new/fs/namei.c	2004-11-04 16:27:40.000000000 +1100
@@ -1649,6 +1649,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(sys_mkdir);
+
 /*
  * We try to drop the dentry early: we should have
  * a usage count of 2 if we're the only user of this
diff -ruN 400-exports-old/fs/namespace.c 400-exports-new/fs/namespace.c
--- 400-exports-old/fs/namespace.c	2004-11-03 21:54:15.000000000 +1100
+++ 400-exports-new/fs/namespace.c	2004-11-04 16:27:40.000000000 +1100
@@ -490,6 +490,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(sys_umount);
+
 #ifdef __ARCH_WANT_SYS_OLDUMOUNT
 
 /*
@@ -1187,6 +1189,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(sys_mount);
+
 /*
  * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
  * It can block. Requires the big lock held.
diff -ruN 400-exports-old/fs/proc/generic.c 400-exports-new/fs/proc/generic.c
--- 400-exports-old/fs/proc/generic.c	2004-11-03 21:55:03.000000000 +1100
+++ 400-exports-new/fs/proc/generic.c	2004-11-04 16:27:40.000000000 +1100
@@ -698,3 +698,5 @@
 out:
 	return;
 }
+
+EXPORT_SYMBOL(proc_match);
diff -ruN 400-exports-old/fs/read_write.c 400-exports-new/fs/read_write.c
--- 400-exports-old/fs/read_write.c	2004-11-03 21:54:14.000000000 +1100
+++ 400-exports-new/fs/read_write.c	2004-11-04 16:27:40.000000000 +1100
@@ -314,6 +314,7 @@
 
 	return ret;
 }
+EXPORT_SYMBOL(sys_write);
 
 asmlinkage ssize_t sys_pread64(unsigned int fd, char __user *buf,
 			     size_t count, loff_t pos)
diff -ruN 400-exports-old/kernel/power/main.c 400-exports-new/kernel/power/main.c
--- 400-exports-old/kernel/power/main.c	2004-11-03 21:52:25.000000000 +1100
+++ 400-exports-new/kernel/power/main.c	2004-11-06 09:23:56.755461688 +1100
@@ -15,7 +15,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/pm.h>
-
+#include <linux/module.h>
 
 #include "power.h"
 
@@ -262,3 +262,7 @@
 }
 
 core_initcall(pm_init);
+
+/* For Suspend2 ACPI support */
+EXPORT_SYMBOL(pm_ops);
+EXPORT_SYMBOL(pm_disk_mode);
diff -ruN 400-exports-old/kernel/sched.c 400-exports-new/kernel/sched.c
--- 400-exports-old/kernel/sched.c	2004-11-06 09:23:53.364977120 +1100
+++ 400-exports-new/kernel/sched.c	2004-11-06 09:23:56.627481144 +1100
@@ -3798,6 +3798,7 @@
 
 	read_unlock(&tasklist_lock);
 }
+EXPORT_SYMBOL(show_state);
 
 void __devinit init_idle(task_t *idle, int cpu)
 {
diff -ruN 400-exports-old/kernel/sys.c 400-exports-new/kernel/sys.c
--- 400-exports-old/kernel/sys.c	2004-11-06 09:23:53.374975600 +1100
+++ 400-exports-new/kernel/sys.c	2004-11-05 21:36:13.000000000 +1100
@@ -523,6 +523,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(sys_reboot);
+
 static void deferred_cad(void *dummy)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
diff -ruN 400-exports-old/kernel/timer.c 400-exports-new/kernel/timer.c
--- 400-exports-old/kernel/timer.c	2004-11-03 21:54:44.000000000 +1100
+++ 400-exports-new/kernel/timer.c	2004-11-04 16:27:40.000000000 +1100
@@ -881,6 +881,7 @@
  * Requires xtime_lock to access.
  */
 unsigned long avenrun[3];
+EXPORT_SYMBOL(avenrun);
 
 /*
  * calc_load - given tick count, update the avenrun load estimates.
diff -ruN 400-exports-old/mm/page_alloc.c 400-exports-new/mm/page_alloc.c
--- 400-exports-old/mm/page_alloc.c	2004-11-03 21:51:15.000000000 +1100
+++ 400-exports-new/mm/page_alloc.c	2004-11-06 09:23:56.786456976 +1100
@@ -2069,3 +2069,7 @@
 
 	return table;
 }
+
+/* Exported for Software Suspend 2 */
+EXPORT_SYMBOL(nr_free_highpages);
+EXPORT_SYMBOL(pgdat_list);
diff -ruN 400-exports-old/mm/swapfile.c 400-exports-new/mm/swapfile.c
--- 400-exports-old/mm/swapfile.c	2004-11-06 09:23:53.188004024 +1100
+++ 400-exports-new/mm/swapfile.c	2004-11-06 09:23:56.639479320 +1100
@@ -1710,3 +1710,13 @@
 	swap_device_unlock(swapdev);
 	return ret;
 }
+
+/* Functions exported for Software Suspend's swapwriter */
+EXPORT_SYMBOL(swap_free);
+EXPORT_SYMBOL(swap_info);
+EXPORT_SYMBOL(sys_swapoff);
+EXPORT_SYMBOL(sys_swapon);
+EXPORT_SYMBOL(si_swapinfo);
+EXPORT_SYMBOL(map_swap_page);
+EXPORT_SYMBOL(get_swap_page);
+EXPORT_SYMBOL(get_swap_info_struct);
diff -ruN 400-exports-old/mm/vmscan.c 400-exports-new/mm/vmscan.c
--- 400-exports-old/mm/vmscan.c	2004-11-06 09:23:53.273990952 +1100
+++ 400-exports-new/mm/vmscan.c	2004-11-06 09:23:56.762460624 +1100
@@ -1221,6 +1221,9 @@
 	current->reclaim_state = NULL;
 	return ret;
 }
+
+/* For Suspend2 */	
+EXPORT_SYMBOL(shrink_all_memory);
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU


