Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbUATW5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUATW47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:56:59 -0500
Received: from gprs214-112.eurotel.cz ([160.218.214.112]:57475 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265862AbUATWzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:55:47 -0500
Date: Tue, 20 Jan 2004 23:55:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Allow software_suspend to fail
Message-ID: <20040120225539.GA19202@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

software_suspend() can fail for quite a lot of reasons (for example not
enough swapspace). However current interface returned void, so you
could not propagate error back to userland. This fixes it.  Plus
__read_suspend_image() is only done during init time, so we might as
well mark it __init. Please apply,

								Pavel

Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2004-01-13 22:52:40.000000000 +0100
+++ linux/include/linux/suspend.h	2004-01-20 22:51:15.000000000 +0100
@@ -45,31 +43,43 @@
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
Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-01-13 22:52:40.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-01-09 20:33:05.000000000 +0100
@@ -694,11 +676,22 @@
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
@@ -728,24 +721,12 @@
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
@@ -915,7 +896,7 @@
 
 extern dev_t __init name_to_dev_t(const char *line);
 
-static int __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
+static int __init __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
 {
 	swp_entry_t next;
 	int i, nr_pgdir_pages;
Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c	2004-01-13 22:52:40.000000000 +0100
+++ linux/kernel/sys.c	2004-01-09 20:33:05.000000000 +0100
@@ -472,13 +472,11 @@
 
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
