Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUEaWYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUEaWYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbUEaWYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:24:36 -0400
Received: from aun.it.uu.se ([130.238.12.36]:9661 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264821AbUEaWUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:20:06 -0400
Date: Tue, 1 Jun 2004 00:19:58 +0200 (MEST)
Message-Id: <200405312219.i4VMJwfG012325@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][3/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: x86_64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.3 for 2.6.7-rc1-mm1, part 3/6:

- x86_64 arch changes

 arch/x86_64/Kconfig              |    2 ++
 arch/x86_64/ia32/ia32entry.S     |    7 +++++++
 arch/x86_64/kernel/entry.S       |    5 +++++
 arch/x86_64/kernel/i8259.c       |    3 +++
 arch/x86_64/kernel/process.c     |    8 ++++++++
 include/asm-x86_64/hw_irq.h      |    5 +++--
 include/asm-x86_64/ia32_unistd.h |    9 ++++++++-
 include/asm-x86_64/irq.h         |    2 +-
 include/asm-x86_64/perfctr.h     |    1 +
 include/asm-x86_64/processor.h   |    2 ++
 include/asm-x86_64/unistd.h      |   14 +++++++++++++-
 11 files changed, 53 insertions(+), 5 deletions(-)

diff -ruN linux-2.6.7-rc1-mm1/arch/x86_64/Kconfig linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/Kconfig
--- linux-2.6.7-rc1-mm1/arch/x86_64/Kconfig	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/Kconfig	2004-05-31 23:46:05.932821000 +0200
@@ -318,6 +318,8 @@
 	bool
 	default y
 
+source "drivers/perfctr/Kconfig"
+
 endmenu
 
 
diff -ruN linux-2.6.7-rc1-mm1/arch/x86_64/ia32/ia32entry.S linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.7-rc1-mm1/arch/x86_64/ia32/ia32entry.S	2004-05-30 15:59:07.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/ia32/ia32entry.S	2004-05-31 23:46:05.932821000 +0200
@@ -588,6 +588,13 @@
 	.quad compat_sys_mq_timedreceive	/* 280 */
 	.quad compat_sys_mq_notify
 	.quad compat_sys_mq_getsetattr
+	.quad sys_ni_syscall	/* reserved for kexec */
+	.quad sys_perfctr_info
+	.quad sys_vperfctr_open
+	.quad sys_vperfctr_control
+	.quad sys_vperfctr_unlink
+	.quad sys_vperfctr_iresume
+	.quad sys_vperfctr_read
 	/* don't forget to change IA32_NR_syscalls */
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
diff -ruN linux-2.6.7-rc1-mm1/arch/x86_64/kernel/entry.S linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/kernel/entry.S
--- linux-2.6.7-rc1-mm1/arch/x86_64/kernel/entry.S	2004-05-10 11:14:36.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/kernel/entry.S	2004-05-31 23:46:05.932821000 +0200
@@ -557,6 +557,11 @@
 	apicinterrupt SPURIOUS_APIC_VECTOR,smp_spurious_interrupt
 #endif
 				
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PERFCTR)
+ENTRY(perfctr_interrupt)
+	apicinterrupt LOCAL_PERFCTR_VECTOR,smp_perfctr_interrupt
+#endif
+ 		
 /*
  * Exception entry points.
  */ 		
diff -ruN linux-2.6.7-rc1-mm1/arch/x86_64/kernel/i8259.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/kernel/i8259.c
--- linux-2.6.7-rc1-mm1/arch/x86_64/kernel/i8259.c	2004-05-10 11:14:36.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/kernel/i8259.c	2004-05-31 23:46:05.932821000 +0200
@@ -24,6 +24,7 @@
 #include <asm/delay.h>
 #include <asm/desc.h>
 #include <asm/apic.h>
+#include <asm/perfctr.h>
 
 #include <linux/irq.h>
 
@@ -485,6 +486,8 @@
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
 #endif
 
+	perfctr_vector_init();
+
 	/*
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
diff -ruN linux-2.6.7-rc1-mm1/arch/x86_64/kernel/process.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/kernel/process.c
--- linux-2.6.7-rc1-mm1/arch/x86_64/kernel/process.c	2004-05-30 15:59:07.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/arch/x86_64/kernel/process.c	2004-05-31 23:46:05.932821000 +0200
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/ptrace.h>
+#include <linux/perfctr.h>
 #include <linux/version.h>
 
 #include <asm/uaccess.h>
@@ -262,6 +263,7 @@
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	perfctr_exit_thread(&me->thread);
 }
 
 void flush_thread(void)
@@ -365,6 +367,8 @@
 	asm("movl %%es,%0" : "=m" (p->thread.es));
 	asm("movl %%ds,%0" : "=m" (p->thread.ds));
 
+	perfctr_copy_thread(&p->thread);
+
 	if (unlikely(me->thread.io_bitmap_ptr != NULL)) { 
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) 
@@ -411,6 +415,8 @@
 	int cpu = smp_processor_id();  
 	struct tss_struct *tss = init_tss + cpu;
 
+	perfctr_suspend_thread(prev);
+
 	unlazy_fpu(prev_p);
 
 	/*
@@ -514,6 +520,8 @@
 		}
 	}
 
+	perfctr_resume_thread(next);
+
 	return prev_p;
 }
 
diff -ruN linux-2.6.7-rc1-mm1/include/asm-x86_64/hw_irq.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/hw_irq.h
--- linux-2.6.7-rc1-mm1/include/asm-x86_64/hw_irq.h	2004-02-18 11:09:53.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/hw_irq.h	2004-05-31 23:46:05.932821000 +0200
@@ -65,14 +65,15 @@
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
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in irq.h */
 
 
 #ifndef __ASSEMBLY__
diff -ruN linux-2.6.7-rc1-mm1/include/asm-x86_64/ia32_unistd.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/ia32_unistd.h
--- linux-2.6.7-rc1-mm1/include/asm-x86_64/ia32_unistd.h	2004-05-10 11:14:37.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/ia32_unistd.h	2004-05-31 23:46:05.932821000 +0200
@@ -288,7 +288,14 @@
 #define __NR_ia32_mq_timedreceive	(__NR_ia32_mq_open+3)
 #define __NR_ia32_mq_notify		(__NR_ia32_mq_open+4)
 #define __NR_ia32_mq_getsetattr	(__NR_ia32_mq_open+5)
+/* 283: reserved for kexec */
+#define __NR_ia32_perfctr_info		284
+#define __NR_ia32_vperfctr_open		(__NR_ia32_perfctr_info+1)
+#define __NR_ia32_vperfctr_control	(__NR_ia32_perfctr_info+2)
+#define __NR_ia32_vperfctr_unlink	(__NR_ia32_perfctr_info+3)
+#define __NR_ia32_vperfctr_iresume	(__NR_ia32_perfctr_info+4)
+#define __NR_ia32_vperfctr_read		(__NR_ia32_perfctr_info+5)
 
-#define IA32_NR_syscalls 285	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 290	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff -ruN linux-2.6.7-rc1-mm1/include/asm-x86_64/irq.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/irq.h
--- linux-2.6.7-rc1-mm1/include/asm-x86_64/irq.h	2004-05-10 11:14:37.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/irq.h	2004-05-31 23:46:05.932821000 +0200
@@ -29,7 +29,7 @@
  */
 #define NR_VECTORS 256
 
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in hw_irq.h */
 
 #ifdef CONFIG_PCI_USE_VECTOR
 #define NR_IRQS FIRST_SYSTEM_VECTOR
diff -ruN linux-2.6.7-rc1-mm1/include/asm-x86_64/perfctr.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/perfctr.h
--- linux-2.6.7-rc1-mm1/include/asm-x86_64/perfctr.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/perfctr.h	2004-05-31 23:46:05.932821000 +0200
@@ -0,0 +1 @@
+#include <asm-i386/perfctr.h>
diff -ruN linux-2.6.7-rc1-mm1/include/asm-x86_64/processor.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/processor.h
--- linux-2.6.7-rc1-mm1/include/asm-x86_64/processor.h	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/processor.h	2004-05-31 23:46:05.932821000 +0200
@@ -253,6 +253,8 @@
 	unsigned long	*io_bitmap_ptr;
 /* cached TLS descriptors. */
 	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
+/* performance counters */
+	struct vperfctr *perfctr;
 } __attribute__((aligned(16)));
 
 #define INIT_THREAD  {}
diff -ruN linux-2.6.7-rc1-mm1/include/asm-x86_64/unistd.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/unistd.h
--- linux-2.6.7-rc1-mm1/include/asm-x86_64/unistd.h	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.x86_64/include/asm-x86_64/unistd.h	2004-05-31 23:46:05.932821000 +0200
@@ -554,8 +554,20 @@
 __SYSCALL(__NR_mq_getsetattr, sys_mq_getsetattr)
 #define __NR_kexec_load 	246
 __SYSCALL(__NR_kexec_load, sys_ni_syscall)
+#define __NR_perfctr_info	247
+__SYSCALL(__NR_perfctr_info, sys_perfctr_info)
+#define __NR_vperfctr_open	(__NR_perfctr_info+1)
+__SYSCALL(__NR_vperfctr_open, sys_vperfctr_open)
+#define __NR_vperfctr_control	(__NR_perfctr_info+2)
+__SYSCALL(__NR_vperfctr_control, sys_vperfctr_control)
+#define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
+__SYSCALL(__NR_vperfctr_unlink, sys_vperfctr_unlink)
+#define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
+__SYSCALL(__NR_vperfctr_iresume, sys_vperfctr_iresume)
+#define __NR_vperfctr_read	(__NR_perfctr_info+5)
+__SYSCALL(__NR_vperfctr_read, sys_vperfctr_read)
 
-#define __NR_syscall_max __NR_kexec_load
+#define __NR_syscall_max __NR_vperfctr_read
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
