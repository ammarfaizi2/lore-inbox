Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWFNOVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWFNOVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWFNOVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:21:00 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:40499 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964980AbWFNOU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:20:58 -0400
Date: Wed, 14 Jun 2006 16:20:45 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/8] lock validator: s390 irqtrace support
Message-ID: <20060614142045.GF1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

irqtrace support for s390.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/Kconfig.debug     |    4 +++
 arch/s390/kernel/entry.S    |   26 ++++++++++++++++++++++
 arch/s390/kernel/entry64.S  |   19 ++++++++++++++++
 arch/s390/kernel/process.c  |    1 
 drivers/s390/char/sclp.c    |    8 ++++---
 include/asm-s390/irqflags.h |   50 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/system.h   |   32 ----------------------------
 7 files changed, 106 insertions(+), 34 deletions(-)

diff -purN a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
--- a/arch/s390/Kconfig.debug	2006-06-06 02:57:02.000000000 +0200
+++ b/arch/s390/Kconfig.debug	2006-06-14 15:12:26.000000000 +0200
@@ -1,5 +1,9 @@
 menu "Kernel hacking"
 
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
 source "lib/Kconfig.debug"
 
 endmenu
diff -purN a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
--- a/arch/s390/kernel/entry.S	2006-06-14 15:11:20.000000000 +0200
+++ b/arch/s390/kernel/entry.S	2006-06-14 15:26:32.000000000 +0200
@@ -59,6 +59,21 @@ STACK_SIZE  = 1 << STACK_SHIFT
 
 #define BASED(name) name-system_call(%r13)
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.macro	TRACE_IRQS_ON
+	l	%r1,BASED(.Ltrace_irq_on)
+	basr	%r14,%r1
+	.endm
+
+	.macro	TRACE_IRQS_OFF
+	l	%r1,BASED(.Ltrace_irq_off)
+	basr	%r14,%r1
+	.endm
+#else
+#define TRACE_IRQS_ON
+#define TRACE_IRQS_OFF
+#endif
+
 /*
  * Register usage in interrupt handlers:
  *    R9  - pointer to current task structure
@@ -360,6 +375,7 @@ ret_from_fork:
 	st	%r15,SP_R15(%r15)	# store stack pointer for new kthread
 0:	l       %r1,BASED(.Lschedtail)
 	basr    %r14,%r1
+	TRACE_IRQS_ON
         stosm   __SF_EMPTY(%r15),0x03     # reenable interrupts
 	b	BASED(sysc_return)
 
@@ -515,6 +531,7 @@ pgm_no_vtime3:
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
 	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	b	BASED(sysc_do_svc)
 
@@ -538,9 +555,11 @@ io_int_handler:
 io_no_vtime:
 #endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
         l       %r1,BASED(.Ldo_IRQ)        # load address of do_IRQ
         la      %r2,SP_PTREGS(%r15) # address of register-save area
         basr    %r14,%r1          # branch to standard irq handler
+	TRACE_IRQS_ON
 
 io_return:
         tm      SP_PSW+1(%r15),0x01    # returning to user ?
@@ -650,10 +669,12 @@ ext_int_handler:
 ext_no_vtime:
 #endif
 	l	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	la	%r2,SP_PTREGS(%r15)    # address of register-save area
 	lh	%r3,__LC_EXT_INT_CODE  # get interruption code
 	l	%r1,BASED(.Ldo_extint)
 	basr	%r14,%r1
+	TRACE_IRQS_ON
 	b	BASED(io_return)
 
 __critical_end:
@@ -1010,6 +1031,11 @@ cleanup_io_leave_insn:
 .Ltrace:       .long  syscall_trace
 .Lvfork:       .long  sys_vfork
 .Lschedtail:   .long  schedule_tail
+#ifdef CONFIG_TRACE_IRQFLAGS
+.Ltrace_irq_on:.long  trace_hardirqs_on
+.Ltrace_irq_off:
+	       .long  trace_hardirqs_off
+#endif
 
 .Lcritical_start:
                .long  __critical_start + 0x80000000
diff -purN a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
--- a/arch/s390/kernel/entry64.S	2006-06-14 15:11:20.000000000 +0200
+++ b/arch/s390/kernel/entry64.S	2006-06-14 15:21:29.000000000 +0200
@@ -59,6 +59,19 @@ _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_
 
 #define BASED(name) name-system_call(%r13)
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+	.macro	TRACE_IRQS_ON
+	 brasl	%r14,trace_hardirqs_on
+	.endm
+
+	.macro	TRACE_IRQS_OFF
+	 brasl	%r14,trace_hardirqs_off
+	.endm
+#else
+#define TRACE_IRQS_ON
+#define TRACE_IRQS_OFF
+#endif
+
 	.macro  STORE_TIMER lc_offset
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 	stpt	\lc_offset
@@ -355,6 +368,7 @@ ret_from_fork:
 	jo	0f
 	stg	%r15,SP_R15(%r15)	# store stack pointer for new kthread
 0:	brasl   %r14,schedule_tail
+	TRACE_IRQS_ON
         stosm   24(%r15),0x03     # reenable interrupts
 	j	sysc_return
 
@@ -536,6 +550,7 @@ pgm_no_vtime3:
 	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
 	oi	__TI_flags+7(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
+	TRACE_IRQS_ON
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	j	sysc_do_svc
 
@@ -558,8 +573,10 @@ io_int_handler:
 io_no_vtime:
 #endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
         la      %r2,SP_PTREGS(%r15)    # address of register-save area
 	brasl   %r14,do_IRQ            # call standard irq handler
+	TRACE_IRQS_ON
 
 io_return:
         tm      SP_PSW+1(%r15),0x01    # returning to user ?
@@ -666,9 +683,11 @@ ext_int_handler:
 ext_no_vtime:
 #endif
 	lg	%r9,__LC_THREAD_INFO	# load pointer to thread_info struct
+	TRACE_IRQS_OFF
 	la	%r2,SP_PTREGS(%r15)    # address of register-save area
 	llgh	%r3,__LC_EXT_INT_CODE  # get interruption code
 	brasl   %r14,do_extint
+	TRACE_IRQS_ON
 	j	io_return
 
 __critical_end:
diff -purN a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
--- a/arch/s390/kernel/process.c	2006-06-06 02:57:02.000000000 +0200
+++ b/arch/s390/kernel/process.c	2006-06-14 15:12:26.000000000 +0200
@@ -143,6 +143,7 @@ static void default_idle(void)
 		return;
 	}
 
+	trace_hardirqs_on();
 	/* Wait for external, I/O or machine check interrupt. */
 	__load_psw_mask(PSW_KERNEL_BITS | PSW_MASK_WAIT |
 			PSW_MASK_IO | PSW_MASK_EXT);
diff -purN a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
--- a/drivers/s390/char/sclp.c	2006-06-06 02:57:02.000000000 +0200
+++ b/drivers/s390/char/sclp.c	2006-06-14 15:12:26.000000000 +0200
@@ -383,6 +383,7 @@ void
 sclp_sync_wait(void)
 {
 	unsigned long psw_mask;
+	unsigned long flags;
 	unsigned long cr0, cr0_sync;
 	u64 timeout;
 
@@ -395,9 +396,11 @@ sclp_sync_wait(void)
 			  sclp_tod_from_jiffies(sclp_request_timer.expires -
 						jiffies);
 	}
+	local_irq_save(flags);
 	/* Prevent bottom half from executing once we force interrupts open */
 	local_bh_disable();
 	/* Enable service-signal interruption, disable timer interrupts */
+	trace_hardirqs_on();
 	__ctl_store(cr0, 0, 0);
 	cr0_sync = cr0;
 	cr0_sync |= 0x00000200;
@@ -415,11 +418,10 @@ sclp_sync_wait(void)
 		barrier();
 		cpu_relax();
 	}
-	/* Restore interrupt settings */
-	asm volatile ("SSM 0(%0)"
-		      : : "a" (&psw_mask) : "memory");
+	local_irq_disable();
 	__ctl_load(cr0, 0, 0);
 	__local_bh_enable();
+	local_irq_restore(flags);
 }
 
 EXPORT_SYMBOL(sclp_sync_wait);
diff -purN a/include/asm-s390/irqflags.h b/include/asm-s390/irqflags.h
--- a/include/asm-s390/irqflags.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-s390/irqflags.h	2006-06-14 15:25:44.000000000 +0200
@@ -0,0 +1,50 @@
+/*
+ *  include/asm-s390/irqflags.h
+ *
+ *    Copyright (C) IBM Corp. 2006
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#ifndef __ASM_IRQFLAGS_H
+#define __ASM_IRQFLAGS_H
+
+#ifdef __KERNEL__
+
+/* interrupt control.. */
+#define raw_local_irq_enable() ({ \
+	unsigned long  __dummy; \
+	__asm__ __volatile__ ( \
+		"stosm 0(%1),0x03" \
+		: "=m" (__dummy) : "a" (&__dummy) : "memory" ); \
+	})
+
+#define raw_local_irq_disable() ({ \
+	unsigned long __flags; \
+	__asm__ __volatile__ ( \
+		"stnsm 0(%1),0xfc" : "=m" (__flags) : "a" (&__flags) ); \
+	__flags; \
+	})
+
+#define raw_local_save_flags(x) \
+	__asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x), "m" (x) )
+
+#define raw_local_irq_restore(x) \
+	__asm__ __volatile__("ssm   0(%0)" : : "a" (&x), "m" (x) : "memory")
+
+#define raw_irqs_disabled()		\
+({					\
+	unsigned long flags;		\
+	local_save_flags(flags);	\
+	!((flags >> __FLAG_SHIFT) & 3);	\
+})
+
+static inline int raw_irqs_disabled_flags(unsigned long flags)
+{
+	return !((flags >> __FLAG_SHIFT) & 3);
+}
+
+/* For spinlocks etc */
+#define raw_local_irq_save(x)	((x) = raw_local_irq_disable())
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_IRQFLAGS_H */
diff -purN a/include/asm-s390/system.h b/include/asm-s390/system.h
--- a/include/asm-s390/system.h	2006-06-14 15:11:29.000000000 +0200
+++ b/include/asm-s390/system.h	2006-06-14 15:12:26.000000000 +0200
@@ -301,34 +301,6 @@ __cmpxchg(volatile void *ptr, unsigned l
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
 #define set_wmb(var, value)     do { var = value; wmb(); } while (0)
 
-/* interrupt control.. */
-#define local_irq_enable() ({ \
-        unsigned long  __dummy; \
-        __asm__ __volatile__ ( \
-                "stosm 0(%1),0x03" \
-		: "=m" (__dummy) : "a" (&__dummy) : "memory" ); \
-        })
-
-#define local_irq_disable() ({ \
-        unsigned long __flags; \
-        __asm__ __volatile__ ( \
-                "stnsm 0(%1),0xfc" : "=m" (__flags) : "a" (&__flags) ); \
-        __flags; \
-        })
-
-#define local_save_flags(x) \
-        __asm__ __volatile__("stosm 0(%1),0" : "=m" (x) : "a" (&x), "m" (x) )
-
-#define local_irq_restore(x) \
-        __asm__ __volatile__("ssm   0(%0)" : : "a" (&x), "m" (x) : "memory")
-
-#define irqs_disabled()			\
-({					\
-	unsigned long flags;		\
-	local_save_flags(flags);	\
-        !((flags >> __FLAG_SHIFT) & 3);	\
-})
-
 #ifdef __s390x__
 
 #define __ctl_load(array, low, high) ({ \
@@ -442,8 +414,7 @@ __cmpxchg(volatile void *ptr, unsigned l
         })
 #endif /* __s390x__ */
 
-/* For spinlocks etc */
-#define local_irq_save(x)	((x) = local_irq_disable())
+#include <linux/trace_irqflags.h>
 
 /*
  * Use to set psw mask except for the first byte which
@@ -482,4 +453,3 @@ extern void (*_machine_power_off)(void);
 #endif /* __KERNEL__ */
 
 #endif
-
