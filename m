Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUIPLT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUIPLT1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUIPLT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:19:27 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:7556 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267939AbUIPLSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:18:50 -0400
Subject: [PATCH] Suspend2 merge: New exports.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095333619.3327.189.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:20:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch adds exports for functions used by suspend2. Needed, of
course, when suspend is compiled as modules.

Regards,

Nigel

diff -ruN linux-2.6.9-rc1/drivers/acpi/hardware/hwsleep.c software-suspend-linux-2.6.9-rc1-rev3/drivers/acpi/hardware/hwsleep.c
--- linux-2.6.9-rc1/drivers/acpi/hardware/hwsleep.c	2004-09-07 21:58:30.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/acpi/hardware/hwsleep.c	2004-09-09 19:36:24.000000000 +1000
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
diff -ruN linux-2.6.9-rc1/drivers/char/keyboard.c software-suspend-linux-2.6.9-rc1-rev3/drivers/char/keyboard.c
--- linux-2.6.9-rc1/drivers/char/keyboard.c	2004-09-07 21:58:31.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/char/keyboard.c	2004-09-09 19:36:24.000000000 +1000
@@ -258,6 +265,7 @@
 	} else
 		kd_nosound(0);
 }
+EXPORT_SYMBOL(kd_mksound);
 
 /*
  * Setting the keyboard rate.
diff -ruN linux-2.6.9-rc1/fs/bio.c software-suspend-linux-2.6.9-rc1-rev3/fs/bio.c
--- linux-2.6.9-rc1/fs/bio.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/bio.c	2004-09-09 19:36:24.000000000 +1000
@@ -977,3 +977,4 @@
 EXPORT_SYMBOL(bio_split_pool);
 EXPORT_SYMBOL(bio_copy_user);
 EXPORT_SYMBOL(bio_uncopy_user);
+EXPORT_SYMBOL(bio_set_pages_dirty);
diff -ruN linux-2.6.9-rc1/fs/buffer.c software-suspend-linux-2.6.9-rc1-rev3/fs/buffer.c
--- linux-2.6.9-rc1/fs/buffer.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/buffer.c	2004-09-09 19:36:24.000000000 +1000
@@ -2916,7 +2975,7 @@
  *
  * try_to_free_buffers() is non-blocking.
  */
-static inline int buffer_busy(struct buffer_head *bh)
+inline int buffer_busy(struct buffer_head *bh)
 {
 	return atomic_read(&bh->b_count) |
 		(bh->b_state & ((1 << BH_Dirty) | (1 << BH_Lock)));
diff -ruN linux-2.6.9-rc1/fs/ioctl.c software-suspend-linux-2.6.9-rc1-rev3/fs/ioctl.c
--- linux-2.6.9-rc1/fs/ioctl.c	2004-09-07 21:58:53.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/ioctl.c	2004-09-09 19:36:24.000000000 +1000
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
diff -ruN linux-2.6.9-rc1/fs/namei.c software-suspend-linux-2.6.9-rc1-rev3/fs/namei.c
--- linux-2.6.9-rc1/fs/namei.c	2004-09-07 21:58:53.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/namei.c	2004-09-09 19:36:24.000000000 +1000
@@ -1644,6 +1644,8 @@
 	return error;
 }
 
+EXPORT_SYMBOL(sys_mkdir);
+
 /*
  * We try to drop the dentry early: we should have
  * a usage count of 2 if we're the only user of this
diff -ruN linux-2.6.9-rc1/fs/namespace.c software-suspend-linux-2.6.9-rc1-rev3/fs/namespace.c
--- linux-2.6.9-rc1/fs/namespace.c	2004-09-07 21:58:53.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/namespace.c	2004-09-09 19:36:24.000000000 +1000
@@ -490,6 +490,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(sys_umount);
+
 #ifdef __ARCH_WANT_SYS_OLDUMOUNT
 
 /*
@@ -1159,6 +1161,8 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(sys_mount);
+
 /*
  * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
  * It can block. Requires the big lock held.
diff -ruN linux-2.6.9-rc1/fs/proc/generic.c software-suspend-linux-2.6.9-rc1-rev3/fs/proc/generic.c
--- linux-2.6.9-rc1/fs/proc/generic.c	2004-09-07 21:58:54.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/proc/generic.c	2004-09-09 19:36:24.000000000 +1000
@@ -698,3 +698,5 @@
 out:
 	return;
 }
+
+EXPORT_SYMBOL(proc_match);
diff -ruN linux-2.6.9-rc1/fs/read_write.c software-suspend-linux-2.6.9-rc1-rev3/fs/read_write.c
--- linux-2.6.9-rc1/fs/read_write.c	2004-09-07 21:58:54.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/read_write.c	2004-09-09 19:36:24.000000000 +1000
@@ -314,6 +314,7 @@
 
 	return ret;
 }
+EXPORT_SYMBOL(sys_write);
 
 asmlinkage ssize_t sys_pread64(unsigned int fd, char __user *buf,
 			     size_t count, loff_t pos)
diff -ruN linux-2.6.9-rc1/kernel/panic.c software-suspend-linux-2.6.9-rc1-rev3/kernel/panic.c
--- linux-2.6.9-rc1/kernel/panic.c	2004-09-07 21:59:00.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/panic.c	2004-09-09 19:36:24.000000000 +1000
@@ -18,12 +18,14 @@
 #include <linux/sysrq.h>
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
+#include <linux/suspend.h>
 #include <linux/nmi.h>
 
 int panic_timeout;
 int panic_on_oops;
 int tainted;
 
+EXPORT_SYMBOL(tainted);
 EXPORT_SYMBOL(panic_timeout);
 
 struct notifier_block *panic_notifier_list;
diff -ruN linux-2.6.9-rc1/kernel/power/main.c software-suspend-linux-2.6.9-rc1-rev3/kernel/power/main.c
--- linux-2.6.9-rc1/kernel/power/main.c	2004-05-27 23:16:45.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/power/main.c	2004-09-09 19:36:24.000000000 +1000
@@ -257,3 +259,7 @@
 }
 
 core_initcall(pm_init);
+
+/* For Suspend2 ACPI support */
+EXPORT_SYMBOL(pm_ops);
+EXPORT_SYMBOL(pm_disk_mode);
diff -ruN linux-2.6.9-rc1/kernel/sched.c software-suspend-linux-2.6.9-rc1-rev3/kernel/sched.c
--- linux-2.6.9-rc1/kernel/sched.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/sched.c	2004-09-09 19:36:24.000000000 +1000
@@ -3265,6 +3264,7 @@
 
 	read_unlock(&tasklist_lock);
 }
+EXPORT_SYMBOL(show_state);
 
 void __devinit init_idle(task_t *idle, int cpu)
 {
diff -ruN linux-2.6.9-rc1/kernel/sys.c software-suspend-linux-2.6.9-rc1-rev3/kernel/sys.c
--- linux-2.6.9-rc1/kernel/sys.c	2004-06-18 12:44:22.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/sys.c	2004-09-09 19:36:24.000000000 +1000
@@ -520,6 +524,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(sys_reboot);
+
 static void deferred_cad(void *dummy)
 {
 	notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
@@ -1666,3 +1672,5 @@
 	}
 	return error;
 }
+
+EXPORT_SYMBOL(C_A_D);
diff -ruN linux-2.6.9-rc1/kernel/timer.c software-suspend-linux-2.6.9-rc1-rev3/kernel/timer.c
--- linux-2.6.9-rc1/kernel/timer.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/timer.c	2004-09-09 19:36:24.000000000 +1000
@@ -868,6 +868,7 @@
  * Requires xtime_lock to access.
  */
 unsigned long avenrun[3];
+EXPORT_SYMBOL(avenrun);
 
 /*
  * calc_load - given tick count, update the avenrun load estimates.
diff -ruN linux-2.6.9-rc1/mm/page_alloc.c software-suspend-linux-2.6.9-rc1-rev3/mm/page_alloc.c
--- linux-2.6.9-rc1/mm/page_alloc.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/page_alloc.c	2004-09-09 19:36:24.000000000 +1000
@@ -72,7 +72,7 @@
 	return 0;
 }
 
-static void bad_page(const char *function, struct page *page)
+void bad_page(const char *function, struct page *page)
 {
 	printk(KERN_EMERG "Bad page state at %s (in process '%s', page %p)\n",
 		function, current->comm, page);
@@ -96,6 +96,8 @@
 	page->mapcount = 0;
 }
 
+EXPORT_SYMBOL(bad_page);
+
 #ifndef CONFIG_HUGETLB_PAGE
 #define prep_compound_page(page, order) do { } while (0)
 #define destroy_compound_page(page, order) do { } while (0)
@@ -2050,3 +2086,7 @@
 
 	return table;
 }
+
+/* Exported for Software Suspend 2 */
+EXPORT_SYMBOL(nr_free_highpages);
+EXPORT_SYMBOL(pgdat_list);
diff -ruN linux-2.6.9-rc1/mm/page-writeback.c software-suspend-linux-2.6.9-rc1-rev3/mm/page-writeback.c
--- linux-2.6.9-rc1/mm/page-writeback.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/page-writeback.c	2004-09-09 19:36:24.000000000 +1000
@@ -329,6 +330,7 @@
 	}
 	return pdflush_operation(background_writeout, nr_pages);
 }
+EXPORT_SYMBOL(wakeup_bdflush);
 
 static void wb_timer_fn(unsigned long unused);
 static void laptop_timer_fn(unsigned long unused);
diff -ruN linux-2.6.9-rc1/mm/swapfile.c software-suspend-linux-2.6.9-rc1-rev3/mm/swapfile.c
--- linux-2.6.9-rc1/mm/swapfile.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/swapfile.c	2004-09-09 19:36:24.000000000 +1000
@@ -1679,3 +1681,13 @@
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
diff -ruN linux-2.6.9-rc1/mm/vmscan.c software-suspend-linux-2.6.9-rc1-rev3/mm/vmscan.c
--- linux-2.6.9-rc1/mm/vmscan.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/vmscan.c	2004-09-09 19:36:24.000000000 +1000
@@ -1237,3 +1237,6 @@
 }
 
 module_init(kswapd_init)
+
+/* For Suspend2 */	
+EXPORT_SYMBOL(shrink_all_memory);

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

