Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270516AbTGZWZD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270576AbTGZWZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:25:03 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:28327 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270516AbTGZWY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:24:58 -0400
Date: Sun, 27 Jul 2003 00:39:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Split SOFTWARE_SUSPEND and ACPI_SLEEP
Message-ID: <20030726223958.GA473@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Splits two config options to avoid user confusion. Patrick already has
better version of that patch in his tree, and probably wants to avoid
applying this.

								Pavel

Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/Makefile	2003-07-17 22:22:58.000000000 +0200
@@ -24,7 +24,8 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
+obj-$(CONFIG_PM)		+= suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT)	+= summit.o
 obj-$(CONFIG_EDD)             	+= edd.o
Index: linux/arch/i386/kernel/suspend_asm.S
===================================================================
--- linux.orig/arch/i386/kernel/suspend_asm.S	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/suspend_asm.S	2003-07-20 15:02:12.000000000 +0200
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
Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/Kconfig	2003-07-17 22:22:58.000000000 +0200
@@ -58,8 +58,8 @@
 	default y
 
 config ACPI_SLEEP
-	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
+	bool "Sleep States (EXPERIMENTAL)"
+	depends on X86 && ACPI && !ACPI_HT_ONLY && EXPERIMENTAL
 	---help---
 	  This option adds support for ACPI suspend states. 
 
Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/suspend.h	2003-07-22 12:54:08.000000000 +0200
@@ -55,10 +55,6 @@
 
 extern int register_suspend_notifier(struct notifier_block *);
 extern int unregister_suspend_notifier(struct notifier_block *);
-extern void refrigerator(unsigned long);
-
-extern int freeze_processes(void);
-extern void thaw_processes(void);
 
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
@@ -76,15 +72,20 @@
 extern void do_suspend_lowlevel_s4bios(int resume);
 
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
+#ifdef CONFIG_PM
+extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+#else
 #define refrigerator(a)			do { BUG(); } while(0)
 #define freeze_processes()		do { panic("You need CONFIG_SOFTWARE_SUSPEND to do sleeps."); } while(0)
 #define thaw_processes()		do { } while(0)
 #endif
 
 #endif /* _LINUX_SWSUSP_H */


Index: linux/kernel/suspend.c
===================================================================
--- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
@@ -65,6 +65,7 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 extern long sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
@@ -139,3 +139,4 @@
 
 static const char name_suspend[] = "Suspend Machine: ";
 static const char name_resume[] = "Resume Machine: ";
+#endif

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

