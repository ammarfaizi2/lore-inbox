Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265468AbSJaXGW>; Thu, 31 Oct 2002 18:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265482AbSJaXFg>; Thu, 31 Oct 2002 18:05:36 -0500
Received: from kim.it.uu.se ([130.238.12.178]:31944 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265468AbSJaXET>;
	Thu, 31 Oct 2002 18:04:19 -0500
Date: Fri, 1 Nov 2002 00:10:45 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210312310.AAA07615@kim.it.uu.se>
To: torvalds@transmeta.com
Subject: [PATCH] performance counters 3.1 for 2.5.45 [4/4]: kernel changes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 4 of 4 of perfctr-3.1 for the 2.5.45 kernel:
kernel changes to integrate the low and high-level drivers.

/Mikael

 CREDITS                              |    1 +
 MAINTAINERS                          |    6 ++++++
 arch/i386/Kconfig                    |    1 +
 arch/i386/kernel/entry.S             |   11 +++++++++++
 arch/i386/kernel/i8259.c             |    3 +++
 arch/i386/kernel/process.c           |    9 +++++++++
 arch/i386/mach-generic/irq_vectors.h |    5 +++--
 drivers/Makefile                     |    1 +
 include/asm-i386/apic.h              |    3 +++
 include/asm-i386/processor.h         |    2 ++
 include/asm-i386/unistd.h            |    1 +
 kernel/timer.c                       |    2 ++
 12 files changed, 43 insertions(+), 2 deletions(-)

diff -uN linux-2.5.45/CREDITS linux-2.5.45.perfctr-3.1/CREDITS
--- linux-2.5.45/CREDITS	Thu Oct 31 11:07:29 2002
+++ linux-2.5.45.perfctr-3.1/CREDITS	Thu Oct 31 23:26:02 2002
@@ -2402,6 +2402,7 @@
 E: mikpe@csd.uu.se
 W: http://www.csd.uu.se/~mikpe/
 D: Miscellaneous fixes
+D: Performance-monitoring counters driver
 
 N: Reed H. Petty
 E: rhp@draper.net
diff -uN linux-2.5.45/MAINTAINERS linux-2.5.45.perfctr-3.1/MAINTAINERS
--- linux-2.5.45/MAINTAINERS	Thu Oct 31 11:07:29 2002
+++ linux-2.5.45.perfctr-3.1/MAINTAINERS	Thu Oct 31 23:26:02 2002
@@ -1292,6 +1292,12 @@
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
+PERFORMANCE-MONITORING COUNTERS DRIVER
+P:	Mikael Pettersson
+M:	mikpe@csd.uu.se
+W:	http://www.csd.uu.se/~mikpe/linux/perfctr/
+S:	Maintained
+
 PNP SUPPORT
 P:	Adam Belay
 M:	ambx1@neo.rr.com
diff -uN linux-2.5.45/arch/i386/Kconfig linux-2.5.45.perfctr-3.1/arch/i386/Kconfig
--- linux-2.5.45/arch/i386/Kconfig	Thu Oct 31 11:07:31 2002
+++ linux-2.5.45.perfctr-3.1/arch/i386/Kconfig	Thu Oct 31 23:26:03 2002
@@ -1513,6 +1513,7 @@
 
 source "arch/i386/oprofile/Kconfig"
 
+source "drivers/perfctr/Kconfig"
 
 menu "Kernel hacking"
 
diff -uN linux-2.5.45/arch/i386/kernel/entry.S linux-2.5.45.perfctr-3.1/arch/i386/kernel/entry.S
--- linux-2.5.45/arch/i386/kernel/entry.S	Thu Oct 31 11:07:31 2002
+++ linux-2.5.45.perfctr-3.1/arch/i386/kernel/entry.S	Thu Oct 31 23:26:03 2002
@@ -347,6 +347,16 @@
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
 
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PERFCTR)
+ENTRY(perfctr_interrupt)
+	pushl $LOCAL_PERFCTR_VECTOR-256
+	SAVE_ALL
+	pushl %esp
+	call do_perfctr_interrupt
+	addl $4, %esp
+	jmp ret_from_intr
+#endif
+
 ENTRY(divide_error)
 	pushl $0			# no error code
 	pushl $do_divide_error
@@ -740,6 +750,7 @@
 	.long sys_epoll_create
 	.long sys_epoll_ctl	/* 255 */
 	.long sys_epoll_wait
+	.long sys_vperfctr
 
 
 	.rept NR_syscalls-(.-sys_call_table)/4
diff -uN linux-2.5.45/arch/i386/kernel/i8259.c linux-2.5.45.perfctr-3.1/arch/i386/kernel/i8259.c
--- linux-2.5.45/arch/i386/kernel/i8259.c	Sat Sep 28 11:40:03 2002
+++ linux-2.5.45.perfctr-3.1/arch/i386/kernel/i8259.c	Thu Oct 31 23:26:03 2002
@@ -22,6 +22,7 @@
 #include <asm/desc.h>
 #include <asm/apic.h>
 #include <asm/arch_hooks.h>
+#include <asm/perfctr.h>
 
 #include <linux/irq.h>
 
@@ -389,6 +390,8 @@
 	 * the architecture specific gates */
 	intr_init_hook();
 
+	perfctr_vector_init();
+
 	/*
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
diff -uN linux-2.5.45/arch/i386/kernel/process.c linux-2.5.45.perfctr-3.1/arch/i386/kernel/process.c
--- linux-2.5.45/arch/i386/kernel/process.c	Sat Oct 12 13:44:40 2002
+++ linux-2.5.45.perfctr-3.1/arch/i386/kernel/process.c	Thu Oct 31 23:26:03 2002
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/vperfctr.h>
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
 
@@ -240,6 +241,7 @@
 		kfree(tsk->thread.ts_io_bitmap);
 		tsk->thread.ts_io_bitmap = NULL;
 	}
+	vperfctr_exit_thread(&tsk->thread);
 }
 
 void flush_thread(void)
@@ -299,6 +301,8 @@
 	unlazy_fpu(tsk);
 	struct_cpy(&p->thread.i387, &tsk->thread.i387);
 
+	vperfctr_copy_thread(&p->thread);
+
 	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
 		p->thread.ts_io_bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.ts_io_bitmap)
@@ -413,6 +417,8 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	vperfctr_suspend_thread(prev);
+
 	unlazy_fpu(prev_p);
 
 	/*
@@ -475,6 +481,8 @@
 			 */
 			tss->bitmap = INVALID_IO_BITMAP_OFFSET;
 	}
+
+	vperfctr_resume_thread(next);
 }
 
 asmlinkage int sys_fork(struct pt_regs regs)
@@ -685,3 +693,4 @@
 	return 0;
 }
 
+cond_syscall(sys_vperfctr)
diff -uN linux-2.5.45/arch/i386/mach-generic/irq_vectors.h linux-2.5.45.perfctr-3.1/arch/i386/mach-generic/irq_vectors.h
--- linux-2.5.45/arch/i386/mach-generic/irq_vectors.h	Sat Sep 21 18:15:16 2002
+++ linux-2.5.45.perfctr-3.1/arch/i386/mach-generic/irq_vectors.h	Thu Oct 31 23:26:03 2002
@@ -56,14 +56,15 @@
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFCTR_VECTOR	0xee
 
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * First APIC vector available to drivers: (vectors 0x30-0xed)
  * we start at 0x31 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
+#define FIRST_SYSTEM_VECTOR	0xee
 
 #define TIMER_IRQ 0
 
diff -uN linux-2.5.45/drivers/Makefile linux-2.5.45.perfctr-3.1/drivers/Makefile
--- linux-2.5.45/drivers/Makefile	Wed Oct 16 18:30:58 2002
+++ linux-2.5.45.perfctr-3.1/drivers/Makefile	Thu Oct 31 23:26:03 2002
@@ -41,5 +41,6 @@
 obj-$(CONFIG_BT)		+= bluetooth/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
+obj-$(CONFIG_PERFCTR)		+= perfctr/
 
 include $(TOPDIR)/Rules.make
diff -uN linux-2.5.45/include/asm-i386/apic.h linux-2.5.45.perfctr-3.1/include/asm-i386/apic.h
--- linux-2.5.45/include/asm-i386/apic.h	Sun Oct 20 18:51:08 2002
+++ linux-2.5.45.perfctr-3.1/include/asm-i386/apic.h	Thu Oct 31 23:26:03 2002
@@ -96,6 +96,9 @@
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
+extern struct pm_dev *nmi_pmdev;
+extern unsigned int nmi_perfctr_msr;
+
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #endif /* __ASM_APIC_H */
diff -uN linux-2.5.45/include/asm-i386/processor.h linux-2.5.45.perfctr-3.1/include/asm-i386/processor.h
--- linux-2.5.45/include/asm-i386/processor.h	Sat Oct 12 13:44:43 2002
+++ linux-2.5.45.perfctr-3.1/include/asm-i386/processor.h	Thu Oct 31 23:26:03 2002
@@ -383,6 +383,8 @@
 	unsigned long		v86flags, v86mask, saved_esp0;
 /* IO permissions */
 	unsigned long	*ts_io_bitmap;
+/* performance counters */
+	struct vperfctr *vperfctr;
 };
 
 #define INIT_THREAD  {						\
diff -uN linux-2.5.45/include/asm-i386/unistd.h linux-2.5.45.perfctr-3.1/include/asm-i386/unistd.h
--- linux-2.5.45/include/asm-i386/unistd.h	Thu Oct 31 11:07:58 2002
+++ linux-2.5.45.perfctr-3.1/include/asm-i386/unistd.h	Thu Oct 31 23:26:03 2002
@@ -261,6 +261,7 @@
 #define __NR_sys_epoll_create	254
 #define __NR_sys_epoll_ctl	255
 #define __NR_sys_epoll_wait	256
+#define __NR_vperfctr		257
   
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
diff -uN linux-2.5.45/kernel/timer.c linux-2.5.45.perfctr-3.1/kernel/timer.c
--- linux-2.5.45/kernel/timer.c	Thu Oct 31 11:08:00 2002
+++ linux-2.5.45.perfctr-3.1/kernel/timer.c	Thu Oct 31 23:26:03 2002
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/vperfctr.h>
 
 #include <asm/uaccess.h>
 
@@ -667,6 +668,7 @@
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);
+	vperfctr_sample_thread(&p->thread);
 }	
 
 /*
