Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315476AbSFCUOT>; Mon, 3 Jun 2002 16:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSFCUOT>; Mon, 3 Jun 2002 16:14:19 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13215 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315476AbSFCUOL>;
	Mon, 3 Jun 2002 16:14:11 -0400
Date: Mon, 3 Jun 2002 22:11:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Fix suspend-to-RAM in 2.5.20
Message-ID: <20020603201144.GA31808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I created arch/i386/suspend.c not to clash with ACPI people so much in
future. (More stuff is going to move into it in the future, to clean
up functions that really do not belong to the headers.) Please apply,

									Pavel

--- clean/arch/i386/kernel/Makefile	Thu May 30 12:21:00 2002
+++ linux-swsusp/arch/i386/kernel/Makefile	Mon Jun  3 19:06:05 2002
@@ -24,6 +24,8 @@
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
+obj-$(CONFIG_ACPI_SLEEP)	+= suspend.o
 ifdef CONFIG_VISWS
 obj-y += setup-visws.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
--- clean/arch/i386/kernel/suspend.c	Mon Jun  3 11:48:17 2002
+++ linux-swsusp/arch/i386/kernel/suspend.c	Mon Jun  3 19:01:07 2002
@@ -0,0 +1,45 @@
+/*
+ * Suspend support specific for i386.
+ *
+ * Distribute under GPLv2
+ *
+ * Copyright (c) 2002 Pavel Machek <pavel@suse.cz>
+ */
+
+#define ACPI_C
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/poll.h>
+#include <linux/delay.h>
+#include <linux/sysrq.h>
+#include <linux/compatmac.h>
+#include <linux/proc_fs.h>
+#include <linux/irq.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <asm/uaccess.h>
+#include <asm/acpi.h>
+
+
+void do_suspend_lowlevel(int resume)
+{
+/*
+ * FIXME: This function should really be written in assembly. Actually
+ * requirement is that it does not touch stack, because %esp will be
+ * wrong during resume before restore_processor_context(). Check
+ * assembly if you modify this.
+ */
+	if (!resume) {
+		save_processor_context();
+		acpi_save_register_state((unsigned long)&&acpi_sleep_done);
+		acpi_enter_sleep_state(3);
+		return;
+	}
+acpi_sleep_done:
+	restore_processor_context();
+}
--- clean/drivers/acpi/system.c	Mon Jun  3 11:43:30 2002
+++ linux-swsusp/drivers/acpi/system.c	Mon Jun  3 18:57:34 2002
@@ -260,10 +260,8 @@
 	u32			state)
 {
 	acpi_status		status = AE_ERROR;
-#if 0
 	unsigned long		flags = 0;
 
-	/* this is very broken, so don't do anything until it's fixed */
 	save_flags(flags);
 	
 	switch (state)
@@ -289,8 +287,6 @@
 	fix_processor_context();
 
 	restore_flags(flags);
-#endif
-	printk("ACPI: ACPI-based suspend currently broken, aborting\n");
 
 	return status;
 }
--- clean/include/asm-i386/suspend.h	Thu May 30 12:21:13 2002
+++ linux-swsusp/include/asm-i386/suspend.h	Mon Jun  3 19:15:52 2002
@@ -294,3 +294,27 @@
 }
 #endif 
 
+#ifdef CONFIG_ACPI_SLEEP
+extern unsigned long saved_eip;
+extern unsigned long saved_esp;
+extern unsigned long saved_ebp;
+extern unsigned long saved_ebx;
+extern unsigned long saved_esi;
+extern unsigned long saved_edi;
+
+static inline void acpi_save_register_state(unsigned long return_point)
+{
+	saved_eip = return_point;
+	asm volatile ("movl %%esp,(%0)" : "=m" (saved_esp));
+	asm volatile ("movl %%ebp,(%0)" : "=m" (saved_ebp));
+	asm volatile ("movl %%ebx,(%0)" : "=m" (saved_ebx));
+	asm volatile ("movl %%edi,(%0)" : "=m" (saved_edi));
+	asm volatile ("movl %%esi,(%0)" : "=m" (saved_esi));
+}
+
+#define acpi_restore_register_state()  do {} while (0)
+
+/* routines for saving/restoring kernel state */
+extern int acpi_save_state_mem(void);
+extern int acpi_save_state_disk(void);
+#endif

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
