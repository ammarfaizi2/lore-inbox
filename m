Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbTGOPy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268586AbTGOPy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:54:29 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:14526 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S268019AbTGOPv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:51:57 -0400
Date: Tue, 15 Jul 2003 18:06:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Make ACPI_SLEEP and SOFTWARE_SUSPEND independend
Message-ID: <20030715160630.GA10383@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Users were getting confused, because ACPI_SLEEP required
SOFTWARE_SUSPEND. This patch separates them out, while creating
CONFIG_SLEEP option that is basically "needs refrigerator". Please
apply,
								Pavel

--- /usr/src/tmp/linux/arch/i386/Kconfig	2003-07-14 22:12:12.000000000 +0200
+++ /usr/src/linux/arch/i386/Kconfig	2003-07-15 17:16:26.000000000 +0200
@@ -829,24 +829,19 @@
 	  (patch for sysvinit needed). 
 
 	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
+	  booting the, pass 'resume=/dev/swappartition' and kernel will 
 	  detect the saved image, restore the memory from
 	  it and then it continues to run as before you've suspended.
 	  If you don't want the previous state to continue use the 'noresume'
 	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
+	  you must re-mkswap your swap partitions. It does not work with swap
+	  files.
 
 	  Right now you may boot without resuming and then later resume but
 	  in meantime you cannot use those swap partitions/files which were
 	  involved in suspending. Also in this case there is a risk that buffers
 	  on disk won't match with saved ones.
 
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
 	  For more information take a look at Documentation/swsusp.txt.
 
 source "drivers/acpi/Kconfig"
@@ -1410,3 +1405,8 @@
 	bool
 	depends on SMP || X86_VISWS
 	default y
+
+config SLEEP
+	bool
+	depends on SOFTWARE_SUSPEND || ACPI_SLEEP
+	default y
--- /usr/src/tmp/linux/arch/i386/kernel/Makefile	2003-07-06 20:06:50.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/Makefile	2003-07-15 17:25:32.000000000 +0200
@@ -24,7 +24,8 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
+obj-$(CONFIG_SLEEP)		+= suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT)	+= summit.o
 obj-$(CONFIG_EDD)             	+= edd.o
--- /usr/src/tmp/linux/arch/i386/kernel/suspend_asm.S	2003-05-27 13:42:29.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/suspend_asm.S	2003-07-15 17:25:55.000000000 +0200
@@ -32,6 +32,7 @@
 saved_context_eflags:
 	.long	0
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 	.text
 
 ENTRY(do_magic)
@@ -117,4 +118,4 @@
 loop2:
        .quad 0
        .previous
-	
\ No newline at end of file
+#endif
\ No newline at end of file
--- /usr/src/tmp/linux/drivers/acpi/Kconfig	2003-06-24 12:27:45.000000000 +0200
+++ /usr/src/linux/drivers/acpi/Kconfig	2003-07-15 17:08:40.000000000 +0200
@@ -58,8 +58,8 @@
 	default y
 
 config ACPI_SLEEP
-	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
+	bool "Sleep States (EXPERIMENTAL)"
+	depends on X86 && ACPI && !ACPI_HT_ONLY && EXPERIMENTAL
 	---help---
 	  This option adds support for ACPI suspend states. 
 
--- /usr/src/tmp/linux/include/linux/suspend.h	2003-03-06 23:26:14.000000000 +0100
+++ /usr/src/linux/include/linux/suspend.h	2003-07-15 17:18:03.000000000 +0200
@@ -55,10 +55,6 @@
 
 extern int register_suspend_notifier(struct notifier_block *);
 extern int unregister_suspend_notifier(struct notifier_block *);
-extern void refrigerator(unsigned long);
-
-extern int freeze_processes(void);
-extern void thaw_processes(void);
 
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
@@ -75,16 +71,26 @@
 extern void do_suspend_lowlevel(int resume);
 extern void do_suspend_lowlevel_s4bios(int resume);
 
+#ifndef CONFIG_SLEEP
+#error Bad config
+#endif
+
 #else
-static inline void software_suspend(void)
-{
-}
+static inline void software_suspend(void) { }
 #define software_resume()		do { } while(0)
 #define register_suspend_notifier(a)	do { } while(0)
 #define unregister_suspend_notifier(a)	do { } while(0)
+#endif
+
+#ifdef CONFIG_SLEEP
+extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+#else
 #define refrigerator(a)			do { BUG(); } while(0)
 #define freeze_processes()		do { panic("You need CONFIG_SOFTWARE_SUSPEND to do sleeps."); } while(0)
 #define thaw_processes()		do { } while(0)
 #endif
 
+
 #endif /* _LINUX_SWSUSP_H */
--- /usr/src/tmp/linux/kernel/Makefile	2003-05-27 13:44:02.000000000 +0200
+++ /usr/src/linux/kernel/Makefile	2003-07-15 17:17:04.000000000 +0200
@@ -17,7 +17,7 @@
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_SLEEP) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
 
 ifneq ($(CONFIG_IA64),y)
--- /usr/src/tmp/linux/kernel/suspend.c	2003-07-15 17:48:56.000000000 +0200
+++ /usr/src/linux/kernel/suspend.c	2003-07-15 17:19:39.000000000 +0200
@@ -65,6 +65,7 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 extern long sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
@@ -78,7 +79,6 @@
 #undef SUSPEND_CONSOLE
 #endif
 
-#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
 #define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
@@ -139,12 +139,12 @@
 
 static const char name_suspend[] = "Suspend Machine: ";
 static const char name_resume[] = "Resume Machine: ";
+#endif
 
 /*
  * Debug
  */
-#define	DEBUG_DEFAULT
-#undef	DEBUG_PROCESS
+#undef	DEBUG_DEFAULT
 #undef	DEBUG_SLOW
 #define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
 
@@ -173,6 +173,8 @@
 			if (p->state == TASK_ZOMBIE) \
 				continue;
 
+#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
+
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(unsigned long flag)
 {
@@ -260,6 +262,7 @@
 	MDELAY(500);
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * Saving part...
  */
@@ -1280,4 +1281,5 @@
 
 EXPORT_SYMBOL(software_suspend);
 EXPORT_SYMBOL(software_suspend_enabled);
+#endif
 EXPORT_SYMBOL(refrigerator);

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
