Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTJRVHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 17:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTJRVHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 17:07:32 -0400
Received: from gprs144-147.eurotel.cz ([160.218.144.147]:39044 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261823AbTJRVH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 17:07:28 -0400
Date: Sat, 18 Oct 2003 23:07:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [pm] Add error handling to software_suspend
Message-ID: <20031018210705.GA22191@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds error handling to software_suspend(), and kills
software_suspend_enabled variable; it is cleaner that
way. do_software_suspend() is now gone. __read_suspend_image can be
init, so mark it as such to avoid tool warnings. Add prototypes for
freeze_processes and thaw_proceses (or are those elsewhere,
already?). Please apply,
							Pavel

--- clean/kernel/power/swsusp.c	2003-10-18 20:26:48.000000000 +0200
+++ linux/kernel/power/swsusp.c	2003-10-18 20:46:48.000000000 +0200
@@ -694,11 +697,22 @@
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 }
 
-static void do_software_suspend(void)
+/*
+ * This is main interface to the outside world. It needs to be
+ * called from process context.
+ */
+int software_suspend(void)
 {
+	int res;
+	if (!software_suspend_enabled)
+		return -EAGAIN;
+
+	software_suspend_enabled = 0;
+	might_sleep();
+
 	if (arch_prepare_suspend()) {
 		printk("%sArchitecture failed to prepare\n", name_suspend);
-		return;
+		return -EPERM;
 	}		
 	if (pm_prepare_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
@@ -716,7 +730,7 @@
 		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
+		if ((res = drivers_suspend())==0)
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -728,24 +742,12 @@
 			 */
 			do_magic(0);
 		thaw_processes();
-	}
+	} else
+		res = -EBUSY;
 	software_suspend_enabled = 1;
 	MDELAY(1000);
 	pm_restore_console();
-}
-
-/*
- * This is main interface to the outside world. It needs to be
- * called from process context.
- */
-void software_suspend(void)
-{
-	if(!software_suspend_enabled)
-		return;
-
-	software_suspend_enabled = 0;
-	might_sleep();
-	do_software_suspend();
+	return res;
 }
 
 /* More restore stuff */
@@ -915,7 +917,7 @@
 
 extern dev_t __init name_to_dev_t(const char *line);
 
-static int __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
+static int __init __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
 {
 	swp_entry_t next;
 	int i, nr_pgdir_pages;
--- clean/include/linux/suspend.h	2003-10-18 20:26:47.000000000 +0200
+++ linux/include/linux/suspend.h	2003-10-18 22:54:53.000000000 +0200
@@ -45,31 +44,43 @@
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
 
+/* kernel/power/swsusp.c */
+extern int software_suspend(void);
+
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
-#endif /* CONFIG_PM */
-
-#ifdef CONFIG_SOFTWARE_SUSPEND
-
-extern unsigned char software_suspend_enabled;
 
-extern void software_suspend(void);
 #else	/* CONFIG_SOFTWARE_SUSPEND */
-static inline void software_suspend(void)
+static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
+	return -EPERM;
 }
+#define software_resume()		do { } while(0)
 #endif	/* CONFIG_SOFTWARE_SUSPEND */
 
 
 #ifdef CONFIG_PM
 extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
 
 #else
 static inline void refrigerator(unsigned long flag)
 {
 
 }
+static inline int freeze_processes(void)
+{
+	return 0;
+}
+static inline void thaw_processes(void)
+{
+
+}
 #endif	/* CONFIG_PM */
 
 #endif /* _LINUX_SWSUSP_H */
--- clean/kernel/sys.c	2003-10-18 20:26:48.000000000 +0200
+++ linux/kernel/sys.c	2003-10-18 20:44:57.000000000 +0200
@@ -474,13 +474,11 @@
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
-		if (!software_suspend_enabled) {
+		{
+			int ret = software_suspend();
 			unlock_kernel();
-			return -EAGAIN;
+			return ret;
 		}
-		software_suspend();
-		do_exit(0);
-		break;
 #endif
 
 	default:

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
