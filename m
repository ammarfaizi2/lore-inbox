Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265487AbSJXO5W>; Thu, 24 Oct 2002 10:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265486AbSJXO4w>; Thu, 24 Oct 2002 10:56:52 -0400
Received: from kim.it.uu.se ([130.238.12.178]:6850 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265482AbSJXOzX>;
	Thu, 24 Oct 2002 10:55:23 -0400
Date: Thu, 24 Oct 2002 17:01:34 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210241501.RAA03599@kim.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] x86 performance counters driver 3.0-pre2 for 2.5.44: [4/4] kernel changes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is perfctr-3.0-pre2 for 2.5.44. This is the 2.5-ready version
of the Linux/x86 performance-monitoring counters kernel extension.
Please consider it for inclusion in 2.5/2.6.

This is part 4 of 4: kernel changes to actually integrate the perfctr driver.
The kernel will compile with this patch set applied, if part 1/4 (core) also
has been applied; the x86 and per-process patches are only needed of
CONFIG_PERFCTR is enabled.

/Mikael

 CREDITS                              |    1 +
 MAINTAINERS                          |    6 ++++++
 arch/i386/config.in                  |    2 ++
 arch/i386/kernel/entry.S             |   11 +++++++++++
 arch/i386/kernel/i8259.c             |    3 +++
 arch/i386/kernel/process.c           |    9 +++++++++
 arch/i386/mach-generic/irq_vectors.h |    5 +++--
 drivers/Makefile                     |    1 +
 include/asm-i386/apic.h              |    3 +++
 include/asm-i386/processor.h         |    2 ++
 include/asm-i386/unistd.h            |    1 +
 kernel/timer.c                       |    2 ++
 12 files changed, 44 insertions(+), 2 deletions(-)

diff -ruN linux-2.5.44/CREDITS linux-2.5.44.perfctr-3.0-pre2/CREDITS
--- linux-2.5.44/CREDITS	Sun Oct 20 18:51:07 2002
+++ linux-2.5.44.perfctr-3.0-pre2/CREDITS	Thu Oct 24 12:07:43 2002
@@ -2402,6 +2402,7 @@
 E: mikpe@csd.uu.se
 W: http://www.csd.uu.se/~mikpe/
 D: Miscellaneous fixes
+D: Performance-monitoring counters driver (x86)
 
 N: Reed H. Petty
 E: rhp@draper.net
diff -ruN linux-2.5.44/MAINTAINERS linux-2.5.44.perfctr-3.0-pre2/MAINTAINERS
--- linux-2.5.44/MAINTAINERS	Sun Oct 20 18:51:07 2002
+++ linux-2.5.44.perfctr-3.0-pre2/MAINTAINERS	Thu Oct 24 12:07:43 2002
@@ -1292,6 +1292,12 @@
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
+PERFORMANCE-MONITORING COUNTERS DRIVER (x86)
+P:	Mikael Pettersson
+M:	mikpe@csd.uu.se
+W:	http://www.csd.uu.se/~mikpe/linux/perfctr/
+S:	Maintained
+
 PNP SUPPORT
 P:	Adam Belay
 M:	ambx1@neo.rr.com
diff -ruN linux-2.5.44/arch/i386/config.in linux-2.5.44.perfctr-3.0-pre2/arch/i386/config.in
--- linux-2.5.44/arch/i386/config.in	Sun Oct 20 18:51:07 2002
+++ linux-2.5.44.perfctr-3.0-pre2/arch/i386/config.in	Thu Oct 24 12:07:43 2002
@@ -449,6 +449,8 @@
 
 source arch/i386/oprofile/Config.in
  
+source drivers/perfctr/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -ruN linux-2.5.44/arch/i386/kernel/entry.S linux-2.5.44.perfctr-3.0-pre2/arch/i386/kernel/entry.S
--- linux-2.5.44/arch/i386/kernel/entry.S	Wed Oct 16 18:30:56 2002
+++ linux-2.5.44.perfctr-3.0-pre2/arch/i386/kernel/entry.S	Thu Oct 24 12:07:43 2002
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
@@ -737,6 +747,7 @@
 	.long sys_free_hugepages
 	.long sys_exit_group
 	.long sys_lookup_dcookie
+	.long sys_perfctr
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -ruN linux-2.5.44/arch/i386/kernel/i8259.c linux-2.5.44.perfctr-3.0-pre2/arch/i386/kernel/i8259.c
--- linux-2.5.44/arch/i386/kernel/i8259.c	Sat Sep 28 11:40:03 2002
+++ linux-2.5.44.perfctr-3.0-pre2/arch/i386/kernel/i8259.c	Thu Oct 24 12:07:43 2002
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
diff -ruN linux-2.5.44/arch/i386/kernel/process.c linux-2.5.44.perfctr-3.0-pre2/arch/i386/kernel/process.c
--- linux-2.5.44/arch/i386/kernel/process.c	Sat Oct 12 13:44:40 2002
+++ linux-2.5.44.perfctr-3.0-pre2/arch/i386/kernel/process.c	Thu Oct 24 12:07:43 2002
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/perfctr.h>
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
 
@@ -240,6 +241,7 @@
 		kfree(tsk->thread.ts_io_bitmap);
 		tsk->thread.ts_io_bitmap = NULL;
 	}
+	perfctr_exit_thread(&tsk->thread);
 }
 
 void flush_thread(void)
@@ -299,6 +301,8 @@
 	unlazy_fpu(tsk);
 	struct_cpy(&p->thread.i387, &tsk->thread.i387);
 
+	perfctr_copy_thread(&p->thread);
+
 	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
 		p->thread.ts_io_bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.ts_io_bitmap)
@@ -413,6 +417,8 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
+	perfctr_suspend_thread(prev);
+
 	unlazy_fpu(prev_p);
 
 	/*
@@ -475,6 +481,8 @@
 			 */
 			tss->bitmap = INVALID_IO_BITMAP_OFFSET;
 	}
+
+	perfctr_resume_thread(next);
 }
 
 asmlinkage int sys_fork(struct pt_regs regs)
@@ -685,3 +693,4 @@
 	return 0;
 }
 
+cond_syscall(sys_perfctr)
diff -ruN linux-2.5.44/arch/i386/mach-generic/irq_vectors.h linux-2.5.44.perfctr-3.0-pre2/arch/i386/mach-generic/irq_vectors.h
--- linux-2.5.44/arch/i386/mach-generic/irq_vectors.h	Sat Sep 21 18:15:16 2002
+++ linux-2.5.44.perfctr-3.0-pre2/arch/i386/mach-generic/irq_vectors.h	Thu Oct 24 12:07:43 2002
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
 
diff -ruN linux-2.5.44/drivers/Makefile linux-2.5.44.perfctr-3.0-pre2/drivers/Makefile
--- linux-2.5.44/drivers/Makefile	Wed Oct 16 18:30:58 2002
+++ linux-2.5.44.perfctr-3.0-pre2/drivers/Makefile	Thu Oct 24 12:07:43 2002
@@ -41,5 +41,6 @@
 obj-$(CONFIG_BT)		+= bluetooth/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
+obj-$(CONFIG_PERFCTR)		+= perfctr/
 
 include $(TOPDIR)/Rules.make
diff -ruN linux-2.5.44/include/asm-i386/apic.h linux-2.5.44.perfctr-3.0-pre2/include/asm-i386/apic.h
--- linux-2.5.44/include/asm-i386/apic.h	Sun Oct 20 18:51:08 2002
+++ linux-2.5.44.perfctr-3.0-pre2/include/asm-i386/apic.h	Thu Oct 24 12:07:43 2002
@@ -96,6 +96,9 @@
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
+extern struct pm_dev *nmi_pmdev;
+extern unsigned int nmi_perfctr_msr;
+
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #endif /* __ASM_APIC_H */
diff -ruN linux-2.5.44/include/asm-i386/processor.h linux-2.5.44.perfctr-3.0-pre2/include/asm-i386/processor.h
--- linux-2.5.44/include/asm-i386/processor.h	Sat Oct 12 13:44:43 2002
+++ linux-2.5.44.perfctr-3.0-pre2/include/asm-i386/processor.h	Thu Oct 24 12:07:43 2002
@@ -383,6 +383,8 @@
 	unsigned long		v86flags, v86mask, saved_esp0;
 /* IO permissions */
 	unsigned long	*ts_io_bitmap;
+/* performance counters */
+	struct vperfctr *perfctr;
 };
 
 #define INIT_THREAD  {						\
diff -ruN linux-2.5.44/include/asm-i386/unistd.h linux-2.5.44.perfctr-3.0-pre2/include/asm-i386/unistd.h
--- linux-2.5.44/include/asm-i386/unistd.h	Wed Oct 16 18:31:11 2002
+++ linux-2.5.44.perfctr-3.0-pre2/include/asm-i386/unistd.h	Thu Oct 24 12:07:43 2002
@@ -258,6 +258,7 @@
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
+#define __NR_perfctr		254
   
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
diff -ruN linux-2.5.44/kernel/timer.c linux-2.5.44.perfctr-3.0-pre2/kernel/timer.c
--- linux-2.5.44/kernel/timer.c	Wed Oct 16 18:31:13 2002
+++ linux-2.5.44.perfctr-3.0-pre2/kernel/timer.c	Thu Oct 24 12:07:43 2002
@@ -24,6 +24,7 @@
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/perfctr.h>
 
 #include <asm/uaccess.h>
 
@@ -643,6 +644,7 @@
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);
+	perfctr_sample_thread(&p->thread);
 }	
 
 /*
