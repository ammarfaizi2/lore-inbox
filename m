Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVFQXcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFQXcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 19:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFQXcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 19:32:33 -0400
Received: from soufre.accelance.net ([213.162.48.15]:14786 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261834AbVFQXV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 19:21:56 -0400
Message-ID: <42B35B0F.1000302@xenomai.org>
Date: Sat, 18 Jun 2005 01:21:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] I-pipe: x86 port
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diffstat:
  arch/i386/Kconfig                        |    3
  arch/i386/kernel/Makefile                |    1
  arch/i386/kernel/apic.c                  |    8
  arch/i386/kernel/entry.S                 |   87 +++-
  arch/i386/kernel/i386_ksyms.c            |   19
  arch/i386/kernel/i8259.c                 |   31 +
  arch/i386/kernel/io_apic.c               |   90 ++++
  arch/i386/kernel/ipipe.c                 |  646 
+++++++++++++++++++++++++++++++
  arch/i386/kernel/process.c               |    1
  arch/i386/kernel/smp.c                   |   29 +
  arch/i386/kernel/time.c                  |    5
  arch/i386/kernel/traps.c                 |    8
  arch/i386/mm/fault.c                     |    2
  arch/i386/mm/ioremap.c                   |    2
  include/asm-i386/apic.h                  |    6
  include/asm-i386/io_apic.h               |    4
  include/asm-i386/ipipe.h                 |  308 ++++++++++++++
  include/asm-i386/mach-default/do_timer.h |    5
  include/asm-i386/mach-visws/do_timer.h   |    5
  include/asm-i386/pgalloc.h               |   23 +
  include/asm-i386/spinlock.h              |    4
  include/asm-i386/system.h                |   31 +
  ipipe/x86.c                              |  577 
+++++++++++++++++++++++++++
  23 files changed, 1868 insertions(+), 27 deletions(-)


Signed-off-by: Philippe Gerum <rpm@xenomai.org>


--- linux-2.6.12-rc6/arch/i386/Kconfig	2005-06-06 17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/Kconfig	2005-06-15 
17:58:21.000000000 +0200
@@ -534,6 +534,8 @@ config PREEMPT_BKL
  	  Say Y here if you are building a kernel for a desktop system.
  	  Say N if you are unsure.

+source "ipipe/Kconfig"
+
  config X86_UP_APIC
  	bool "Local APIC support on uniprocessors"
  	depends on !SMP && !(X86_VISWS || X86_VOYAGER)
@@ -941,7 +943,6 @@ config SECCOMP

  endmenu

-
  menu "Power management options (ACPI, APM)"
  	depends on !X86_VOYAGER

--- linux-2.6.12-rc6/arch/i386/kernel/Makefile	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/Makefile	2005-06-15 
17:35:32.000000000 +0200
@@ -11,6 +11,7 @@ obj-y	:= process.o semaphore.o signal.o

  obj-y				+= cpu/
  obj-y				+= timers/
+obj-$(CONFIG_IPIPE_CORE)	+= ipipe.o
  obj-$(CONFIG_ACPI_BOOT)		+= acpi/
  obj-$(CONFIG_X86_BIOS_REBOOT)	+= reboot.o
  obj-$(CONFIG_MCA)		+= mca.o
--- linux-2.6.12-rc6/arch/i386/kernel/apic.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/apic.c	2005-06-15 
17:35:32.000000000 +0200
@@ -62,7 +62,7 @@ void ack_bad_irq(unsigned int irq)
  	 * unexpected vectors occur) that might lock up the APIC
  	 * completely.
  	 */
-	ack_APIC_irq();
+	__ack_APIC_irq();
  }

  void __init apic_intr_init(void)
@@ -1161,6 +1161,10 @@ inline void smp_local_timer_interrupt(st
  fastcall void smp_apic_timer_interrupt(struct pt_regs *regs)
  {
  	int cpu = smp_processor_id();
+#ifdef CONFIG_IPIPE_CORE
+        if (ipipe_running)
+	    regs =  __ipipe_tick_regs + cpu;
+#endif /* CONFIG_IPIPE_CORE */

  	/*
  	 * the NMI deadlock-detector uses this.
@@ -1197,7 +1201,7 @@ fastcall void smp_spurious_interrupt(str
  	 */
  	v = apic_read(APIC_ISR + ((SPURIOUS_APIC_VECTOR & ~0x1f) >> 1));
  	if (v & (1 << (SPURIOUS_APIC_VECTOR & 0x1f)))
-		ack_APIC_irq();
+		__ack_APIC_irq();

  	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
  	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never 
happen.\n",
--- linux-2.6.12-rc6/arch/i386/kernel/entry.S	2005-06-14 
13:57:27.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/entry.S	2005-06-15 
20:20:06.000000000 +0200
@@ -75,11 +75,27 @@ DF_MASK		= 0x00000400
  NT_MASK		= 0x00004000
  VM_MASK		= 0x00020000

+#ifdef CONFIG_IPIPE_CORE
+#define CLI                     call __ipipe_stall_root
+#define STI                     call __ipipe_unstall_root
+#define FIXUP_ROOT_IF           call __ipipe_if_fixup_root ; movl 
ORIG_EAX(%esp),%eax
+#define EMULATE_ROOT_IRET	call __ipipe_unstall_iret_root ; movl 
EAX(%esp),%eax
+#define TEST_PREEMPTIBLE(regs)  call __ipipe_kpreempt_root ; testl 
%eax,%eax
+#define restore_nocheck         .ipipe_unstall_and_restore_nocheck
+#else  /* !CONFIG_IPIPE_CORE */
+#define CLI                     cli
+#define STI                     sti
+#define FIXUP_ROOT_IF
+#define EMULATE_ROOT_IRET
+#define TEST_PREEMPTIBLE(regs)  testl $IF_MASK,EFLAGS(regs)
+#define restore_nmi             restore_all
+#endif /* CONFIG_IPIPE_CORE */
+
  #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli
+#define preempt_stop	  CLI
  #else
  #define preempt_stop
-#define resume_kernel		restore_nocheck
+#define resume_kernel	  restore_nocheck
  #endif

  #define SAVE_ALL \
@@ -141,14 +157,14 @@ ENTRY(ret_from_fork)
  	ALIGN
  ret_from_exception:
  	preempt_stop
-ret_from_intr:
+ENTRY(ret_from_intr)
  	GET_THREAD_INFO(%ebp)
  	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
  	movb CS(%esp), %al
  	testl $(VM_MASK | 3), %eax
  	jz resume_kernel
  ENTRY(resume_userspace)
- 	cli				# make sure we don't miss an interrupt
+	CLI				# make sure we don't miss an interrupt
  					# setting need_resched or sigpending
  					# between sampling and the iret
  	movl TI_flags(%ebp), %ecx
@@ -159,14 +175,14 @@ ENTRY(resume_userspace)

  #ifdef CONFIG_PREEMPT
  ENTRY(resume_kernel)
-	cli
+	CLI
  	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
  	jnz restore_nocheck
  need_resched:
  	movl TI_flags(%ebp), %ecx	# need_resched set ?
  	testb $_TIF_NEED_RESCHED, %cl
  	jz restore_all
-	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
+	TEST_PREEMPTIBLE(%esp)		# interrupts off (exception path) ?
  	jz restore_all
  	call preempt_schedule_irq
  	jmp need_resched
@@ -200,6 +216,7 @@ sysenter_past_esp:

  	pushl %eax
  	SAVE_ALL
+	FIXUP_ROOT_IF
  	GET_THREAD_INFO(%ebp)

  	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not 
testb */
@@ -209,11 +226,12 @@ sysenter_past_esp:
  	jae syscall_badsys
  	call *sys_call_table(,%eax,4)
  	movl %eax,EAX(%esp)
-	cli
+	CLI
  	movl TI_flags(%ebp), %ecx
  	testw $_TIF_ALLWORK_MASK, %cx
  	jne syscall_exit_work
  /* if something modifies registers it must also disable sysexit */
+	EMULATE_ROOT_IRET
  	movl EIP(%esp), %edx
  	movl OLDESP(%esp), %ecx
  	xorl %ebp,%ebp
@@ -225,6 +243,7 @@ sysenter_past_esp:
  ENTRY(system_call)
  	pushl %eax			# save orig_eax
  	SAVE_ALL
+	FIXUP_ROOT_IF
  	GET_THREAD_INFO(%ebp)
  					# system call tracing in operation
  	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not 
testb */
@@ -236,7 +255,7 @@ syscall_call:
  	call *sys_call_table(,%eax,4)
  	movl %eax,EAX(%esp)		# store the return value
  syscall_exit:
-	cli				# make sure we don't miss an interrupt
+ 	CLI				# make sure we don't miss an interrupt
  					# setting need_resched or sigpending
  					# between sampling and the iret
  	movl TI_flags(%ebp), %ecx
@@ -253,7 +272,15 @@ restore_all:
  	andl $(VM_MASK | (4 << 8) | 3), %eax
  	cmpl $((4 << 8) | 3), %eax
  	je ldt_ss			# returning to user-space with LDT SS
+#ifdef CONFIG_IPIPE_CORE
+.ipipe_unstall_and_restore_nocheck:
+	call __ipipe_unstall_iret_root
+restore_nmi:
+	# FIXME: we need to check for a return to
+	# user-space on a 16bit stack even in the NMI case
+#else /* !CONFIG_IPIPE_CORE */
  restore_nocheck:
+#endif /* CONFIG_IPIPE_CORE */
  	RESTORE_REGS
  	addl $4, %esp
  1:	iret
@@ -301,7 +328,7 @@ work_pending:
  	jz work_notifysig
  work_resched:
  	call schedule
-	cli				# make sure we don't miss an interrupt
+	CLI				# make sure we don't miss an interrupt
  					# setting need_resched or sigpending
  					# between sampling and the iret
  	movl TI_flags(%ebp), %ecx
@@ -348,7 +375,7 @@ syscall_trace_entry:
  syscall_exit_work:
  	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
  	jz work_pending
-	sti				# could let do_syscall_trace() call
+	STI				# could let do_syscall_trace() call
  					# schedule() instead
  	movl %esp, %eax
  	movl $1, %edx
@@ -399,7 +426,11 @@ ENTRY(interrupt)

  vector=0
  ENTRY(irq_entries_start)
+#ifdef CONFIG_IPIPE_CORE
+.rept 224
+#else
  .rept NR_IRQS
+#endif
  	ALIGN
  1:	pushl $vector-256
  	jmp common_interrupt
@@ -424,6 +455,36 @@ ENTRY(name)				\
  	call smp_/**/name;		\
  	jmp ret_from_intr;

+#ifdef CONFIG_IPIPE_CORE
+
+.data
+ENTRY(__ipipe_irq_trampolines)
+.text
+
+vector=0
+ENTRY(__ipipe_irq_entries)
+.rept 224
+	ALIGN
+1:	pushl $vector-256
+	jmp __ipipe_irq_common
+.data
+	.long 1b
+.text
+vector=vector+1
+.endr
+
+	ALIGN
+__ipipe_irq_common:
+	SAVE_ALL
+	call __ipipe_handle_irq
+	testl %eax,%eax
+	jnz  ret_from_intr
+	RESTORE_REGS
+	addl $4, %esp
+	iret	
+
+#endif /* CONFIG_IPIPE_CORE */
+	
  /* The include is where all of the SMP etc. interrupts come from */
  #include "entry_arch.h"

@@ -455,6 +516,7 @@ error_code:
  	movl %ecx, %es
  	movl %esp,%eax			# pt_regs pointer
  	call *%edi
+	FIXUP_ROOT_IF
  	jmp ret_from_exception

  ENTRY(coprocessor_error)
@@ -470,6 +532,7 @@ ENTRY(simd_coprocessor_error)
  ENTRY(device_not_available)
  	pushl $-1			# mark this as an int
  	SAVE_ALL
+	FIXUP_ROOT_IF
  	movl %cr0, %eax
  	testl $0x4, %eax		# EM (math emulation bit)
  	jne device_not_available_emulate
@@ -511,6 +574,7 @@ ENTRY(debug)
  debug_stack_correct:
  	pushl $-1			# mark this as an int
  	SAVE_ALL
+	FIXUP_ROOT_IF
  	xorl %edx,%edx			# error code 0
  	movl %esp,%eax			# pt_regs pointer
  	call do_debug
@@ -549,7 +613,7 @@ nmi_stack_correct:
  	xorl %edx,%edx		# zero error code
  	movl %esp,%eax		# pt_regs pointer
  	call do_nmi
-	jmp restore_all
+	jmp restore_nmi

  nmi_stack_fixup:
  	FIX_STACK(12,nmi_stack_correct, 1)
@@ -591,6 +655,7 @@ nmi_16bit_stack:
  ENTRY(int3)
  	pushl $-1			# mark this as an int
  	SAVE_ALL
+	FIXUP_ROOT_IF
  	xorl %edx,%edx		# zero error code
  	movl %esp,%eax		# pt_regs pointer
  	call do_int3
--- linux-2.6.12-rc6/arch/i386/kernel/i386_ksyms.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/i386_ksyms.c	2005-06-17 
17:36:33.000000000 +0200
@@ -36,6 +36,25 @@
  extern void dump_thread(struct pt_regs *, struct user *);
  extern spinlock_t rtc_lock;

+#ifdef CONFIG_IPIPE_CORE
+#ifdef CONFIG_IPIPE_MODULE
+extern int __ipipe_irq_trampolines;
+EXPORT_SYMBOL(__ipipe_irq_trampolines);
+#ifdef CONFIG_X86_LOCAL_APIC
+extern int using_apic_timer;
+EXPORT_SYMBOL(using_apic_timer);
+#endif /* CONFIG_X86_LOCAL_APIC */
+extern struct desc_struct idt_table[];
+EXPORT_SYMBOL(idt_table);
+#ifdef CONFIG_X86_IO_APIC
+EXPORT_SYMBOL(io_apic_irqs);
+EXPORT_SYMBOL(irq_vector);
+#endif /* CONFIG_X86_IO_APIC */
+#endif /* CONFIG_IPIPE_MODULE */
+extern irq_desc_t irq_desc[];
+EXPORT_SYMBOL(irq_desc);
+#endif /* CONFIG_IPIPE_CORE */
+
  /* This is definitely a GPL-only symbol */
  EXPORT_SYMBOL_GPL(cpu_gdt_table);

--- linux-2.6.12-rc6/arch/i386/kernel/i8259.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/i8259.c	2005-06-15 
17:35:32.000000000 +0200
@@ -170,6 +170,36 @@ static inline int i8259A_irq_real(unsign
   */
  static void mask_and_ack_8259A(unsigned int irq)
  {
+#ifdef CONFIG_IPIPE_CORE
+	unsigned int irqmask = 1 << irq;
+
+	spin_lock(&i8259A_lock);
+
+	if (cached_irq_mask & irqmask)
+		goto spurious_8259A_irq;
+
+	if (irq == 0) {
+	    /* Fast timer ack -- don't mask
+	      (unless supposedly spurious) */
+	    outb(0x20,PIC_MASTER_CMD);
+	    spin_unlock(&i8259A_lock);
+	    return;
+	}
+
+	cached_irq_mask |= irqmask;
+
+handle_real_irq:
+	if (irq & 8) {
+		outb(cached_slave_mask, PIC_SLAVE_IMR);
+		outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
+		outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' to 
master-IRQ2 */
+	} else {
+		outb(cached_master_mask, PIC_MASTER_IMR);
+		outb(0x60+irq,PIC_MASTER_CMD);	/* 'Specific EOI to master */
+	}
+	spin_unlock(&i8259A_lock);
+	return;
+#else /* !CONFIG_IPIPE_CORE */
  	unsigned int irqmask = 1 << irq;
  	unsigned long flags;

@@ -206,6 +236,7 @@ handle_real_irq:
  	}
  	spin_unlock_irqrestore(&i8259A_lock, flags);
  	return;
+#endif /* CONFIG_IPIPE_CORE */

  spurious_8259A_irq:
  	/*
--- linux-2.6.12-rc6/arch/i386/kernel/io_apic.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/io_apic.c	2005-06-16 
10:52:46.000000000 +0200
@@ -1828,6 +1828,26 @@ static unsigned int startup_edge_ioapic_
   * interrupt for real. This prevents IRQ storms from unhandled
   * devices.
   */
+
+#ifdef CONFIG_IPIPE_CORE
+
+static void ack_edge_ioapic_irq (unsigned irq)
+
+{
+    move_irq(irq);
+    if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED)) == 
(IRQ_PENDING | IRQ_DISABLED))
+	{
+	unsigned long flags;
+	spin_lock_irqsave_hw(&ioapic_lock,flags);
+	__mask_IO_APIC_irq(irq);
+	spin_unlock_irqrestore_hw(&ioapic_lock,flags);
+	}
+
+    __ack_APIC_irq();
+}
+
+#else /* !CONFIG_IPIPE_CORE */
+
  static void ack_edge_ioapic_irq(unsigned int irq)
  {
  	move_irq(irq);
@@ -1837,6 +1857,8 @@ static void ack_edge_ioapic_irq(unsigned
  	ack_APIC_irq();
  }

+#endif /* CONFIG_IPIPE_CORE */
+
  /*
   * Level triggered interrupts can just be masked,
   * and shutting down and starting up the interrupt
@@ -1858,6 +1880,70 @@ static unsigned int startup_level_ioapic
  	return 0; /* don't check for pending */
  }

+#ifdef CONFIG_IPIPE_CORE
+
+/* Prevent low priority IRQs grabbed by high priority domains from
+   being delayed, waiting for a high priority interrupt handler
+   running in a low priority domain to complete. */
+
+static unsigned long bugous_edge_triggers;
+
+static void end_level_ioapic_irq (unsigned irq)
+
+{
+    move_irq(irq);
+
+    spin_lock(&ioapic_lock);
+
+    if (test_and_clear_bit(irq,&bugous_edge_triggers))
+	{
+	atomic_inc(&irq_mis_count);
+	__unmask_and_level_IO_APIC_irq(irq);
+	}
+    else
+	__unmask_IO_APIC_irq(irq);
+
+    spin_unlock(&ioapic_lock);
+}
+
+static void mask_and_ack_level_ioapic_irq (unsigned irq)
+
+{
+    unsigned long v;
+    int i;
+
+    i = IO_APIC_VECTOR(irq);
+    v = apic_read(APIC_TMR + ((i & ~0x1f) >> 1));
+
+    spin_lock(&ioapic_lock);
+
+    if (!(v & (1 << (i & 0x1f))))
+	{
+	set_bit(irq,&bugous_edge_triggers);
+	__mask_and_edge_IO_APIC_irq(irq);
+	}
+    else
+	__mask_IO_APIC_irq(irq);
+
+    spin_unlock(&ioapic_lock);
+
+    __ack_APIC_irq();
+}
+
+#ifdef CONFIG_PCI_MSI
+
+static inline void mask_and_ack_level_ioapic_vector(unsigned int vector)
+
+{
+	int irq = vector_to_irq(vector);
+
+	mask_and_ack_level_ioapic_irq(irq);
+}
+
+#endif /* CONFIG_PCI_MSI */
+
+#else /* !CONFIG_IPIPE_CORE */
+
  static void end_level_ioapic_irq (unsigned int irq)
  {
  	unsigned long v;
@@ -1898,6 +1984,8 @@ static void end_level_ioapic_irq (unsign
  	}
  }

+#endif /* CONFIG_IPIPE_CORE */
+
  #ifdef CONFIG_PCI_MSI
  static unsigned int startup_edge_ioapic_vector(unsigned int vector)
  {
@@ -2035,7 +2123,7 @@ static void disable_lapic_irq (unsigned

  static void ack_lapic_irq (unsigned int irq)
  {
-	ack_APIC_irq();
+	__ack_APIC_irq();
  }

  static void end_lapic_irq (unsigned int i) { /* nothing */ }
--- linux-2.6.12-rc6/arch/i386/kernel/ipipe.c	1970-01-01 
01:00:00.000000000 +0100
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/ipipe.c	2005-06-16 
12:38:10.000000000 +0200
@@ -0,0 +1,646 @@
+/*   -*- linux-c -*-
+ *   linux/arch/i386/kernel/ipipe.c
+ *
+ *   Copyright (C) 2002-2005 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 
02111-1307, USA.
+ *
+ *   Architecture-dependent I-PIPE core support for x86.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/hw_irq.h>
+#include <asm/irq.h>
+#include <asm/desc.h>
+#include <asm/io.h>
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/fixmap.h>
+#include <asm/bitops.h>
+#include <asm/mpspec.h>
+#ifdef CONFIG_X86_IO_APIC
+#include <asm/io_apic.h>
+#endif	/* CONFIG_X86_IO_APIC */
+#include <asm/apic.h>
+#include <mach_ipi.h>
+#endif	/* CONFIG_X86_LOCAL_APIC */
+
+struct pt_regs __ipipe_tick_regs[IPIPE_NR_CPUS];
+
+int __ipipe_tick_irq;
+
+#ifdef CONFIG_SMP
+
+static cpumask_t __ipipe_cpu_sync_map;
+
+static cpumask_t __ipipe_cpu_lock_map;
+
+static raw_spinlock_t __ipipe_cpu_barrier = RAW_SPIN_LOCK_UNLOCKED;
+
+static atomic_t __ipipe_critical_count = ATOMIC_INIT(0);
+
+static void (*__ipipe_cpu_sync) (void);
+
+#endif	/* CONFIG_SMP */
+
+#define __ipipe_call_asm_irq_handler(ipd,irq) \
+   __asm__ __volatile__ ("pushfl\n\t" \
+                         "push %%cs\n\t" \
+                         "call *%1\n" \
+			 : /* no output */ \
+			 : "a" (irq), "m" ((ipd)->irqs[irq].handler))
+
+#define __ipipe_call_c_root_irq_handler(ipd,irq) \
+   __asm__ __volatile__ ("pushfl\n\t" \
+                         "pushl %%cs\n\t" \
+                         "pushl $1f\n\t" \
+	                 "pushl $-1\n\t" \
+	                 "pushl %%es\n\t" \
+	                 "pushl %%ds\n\t" \
+	                 "pushl %%eax\n\t" \
+	                 "pushl %%ebp\n\t" \
+	                 "pushl %%edi\n\t" \
+	                 "pushl %%esi\n\t" \
+	                 "pushl %%edx\n\t" \
+	                 "pushl %%ecx\n\t" \
+	                 "pushl %%ebx\n\t" \
+                         "pushl %%eax\n\t" \
+                         "call *%1\n\t" \
+			 "addl $4,%%esp\n\t" \
+	                 "jmp ret_from_intr\n\t" \
+	                 "1:\n" \
+			 : /* no output */ \
+			 : "a" (irq), "m" ((ipd)->irqs[irq].handler))
+
+/* Do _not_ forcibly re-enable hw IRQs in the following trampoline
+   used for non-root domains; unlike Linux handlers, non-root domain
+   handlers are fully in control of the hw masking state. */
+
+#define __ipipe_call_c_irq_handler(ipd,irq) \
+   __asm__ __volatile__ ("pushl %%ebp\n\t" \
+	                 "pushl %%edi\n\t" \
+                      	 "pushl %%esi\n\t" \
+	                 "pushl %%edx\n\t" \
+                         "pushl %%ecx\n\t" \
+	                 "pushl %%ebx\n\t" \
+                         "pushl %%eax\n\t" \
+                         "call *%1\n\t" \
+                         "addl $4,%%esp\n\t" \
+                         "popl %%ebx\n\t" \
+                         "popl %%ecx\n\t" \
+	                 "popl %%edx\n\t" \
+	                 "popl %%esi\n\t" \
+	                 "popl %%edi\n\t" \
+	                 "popl %%ebp\n" \
+			 : /* no output */ \
+			 : "a" (irq), "m" ((ipd)->irqs[irq].handler))
+
+static __inline__ unsigned long flnz(unsigned long word)
+{
+      __asm__("bsrl %1, %0":"=r"(word)
+      :	"r"(word));
+	return word;
+}
+
+int __ipipe_ack_system_irq(unsigned irq)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	__ack_APIC_irq();
+#endif	/* CONFIG_X86_LOCAL_APIC */
+	return 1;
+}
+
+#ifdef CONFIG_SMP
+
+/* Always called with hw interrupts off. */
+
+static void __ipipe_do_critical_sync(unsigned irq)
+{
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();
+
+	cpu_set(cpuid, __ipipe_cpu_sync_map);
+
+	/* Now we are in sync with the lock requestor running on another
+	   CPU. Enter a spinning wait until he releases the global
+	   lock. */
+	spin_lock_hw(&__ipipe_cpu_barrier);
+
+	/* Got it. Now get out. */
+
+	if (__ipipe_cpu_sync)
+		/* Call the sync routine if any. */
+		__ipipe_cpu_sync();
+
+	spin_unlock_hw(&__ipipe_cpu_barrier);
+
+	cpu_clear(cpuid, __ipipe_cpu_sync_map);
+}
+
+#endif	/* CONFIG_SMP */
+
+/* ipipe_critical_enter() -- Grab the superlock excluding all CPUs
+   but the current one from a critical section. This lock is used when
+   we must enforce a global critical section for a single CPU in a
+   possibly SMP system whichever context the CPUs are running. */
+
+unsigned long ipipe_critical_enter(void (*syncfn) (void))
+{
+	unsigned long flags;
+
+	local_irq_save_hw(flags);
+
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) {	/* We might be running a SMP-kernel on a 
UP box... */
+		ipipe_declare_cpuid;
+		cpumask_t lock_map;
+
+		ipipe_load_cpuid();
+
+		if (!cpu_test_and_set(cpuid, __ipipe_cpu_lock_map)) {
+			while (cpu_test_and_set
+			       (BITS_PER_LONG - 1, __ipipe_cpu_lock_map)) {
+				int n = 0;
+				do {
+					cpu_relax();
+				} while (++n < cpuid);
+			}
+
+			spin_lock_hw(&__ipipe_cpu_barrier);
+
+			__ipipe_cpu_sync = syncfn;
+
+			/* Send the sync IPI to all processors but the current one. */
+			send_IPI_allbutself(IPIPE_CRITICAL_VECTOR);
+
+			cpus_andnot(lock_map, cpu_online_map,
+				    __ipipe_cpu_lock_map);
+
+			while (!cpus_equal(__ipipe_cpu_sync_map, lock_map))
+				cpu_relax();
+		}
+
+		atomic_inc(&__ipipe_critical_count);
+	}
+#endif	/* CONFIG_SMP */
+
+	return flags;
+}
+
+/* ipipe_critical_exit() -- Release the superlock. */
+
+void ipipe_critical_exit(unsigned long flags)
+{
+#ifdef CONFIG_SMP
+	if (num_online_cpus() > 1) {	/* We might be running a SMP-kernel on a 
UP box... */
+		ipipe_declare_cpuid;
+
+		ipipe_load_cpuid();
+
+		if (atomic_dec_and_test(&__ipipe_critical_count)) {
+			spin_unlock_hw(&__ipipe_cpu_barrier);
+
+			while (!cpus_empty(__ipipe_cpu_sync_map))
+				cpu_relax();
+
+			cpu_clear(cpuid, __ipipe_cpu_lock_map);
+			cpu_clear(BITS_PER_LONG - 1, __ipipe_cpu_lock_map);
+		}
+	}
+#endif	/* CONFIG_SMP */
+
+	local_irq_restore_hw(flags);
+}
+
+void __ipipe_init_stage(struct ipipe_domain *ipd)
+{
+	int cpuid, n;
+
+	for (cpuid = 0; cpuid < IPIPE_NR_CPUS; cpuid++) {
+		ipd->cpudata[cpuid].irq_pending_hi = 0;
+
+		for (n = 0; n < IPIPE_IRQ_IWORDS; n++)
+			ipd->cpudata[cpuid].irq_pending_lo[n] = 0;
+
+		for (n = 0; n < IPIPE_NR_IRQS; n++)
+			ipd->cpudata[cpuid].irq_hits[n] = 0;
+	}
+
+	for (n = 0; n < IPIPE_NR_IRQS; n++) {
+		ipd->irqs[n].acknowledge = NULL;
+		ipd->irqs[n].handler = NULL;
+		ipd->irqs[n].control = IPIPE_PASS_MASK;	/* Pass but don't handle */
+	}
+
+#ifdef CONFIG_SMP
+	ipd->irqs[IPIPE_CRITICAL_IPI].acknowledge = &__ipipe_ack_system_irq;
+	ipd->irqs[IPIPE_CRITICAL_IPI].handler = &__ipipe_do_critical_sync;
+	/* Immediately handle in the current domain but *never* pass */
+	ipd->irqs[IPIPE_CRITICAL_IPI].control =
+	    IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK | IPIPE_SYSTEM_MASK;
+#endif	/* CONFIG_SMP */
+}
+
+/* __ipipe_sync_stage() -- Flush the pending IRQs for the current
+   domain (and processor).  This routine flushes the interrupt log
+   (see "Optimistic interrupt protection" from D. Stodolsky et al. for
+   more on the deferred interrupt scheme). Every interrupt that
+   occurred while the pipeline was stalled gets played.  WARNING:
+   callers on SMP boxen should always check for CPU migration on
+   return of this routine. One can control the kind of interrupts
+   which are going to be sync'ed using the syncmask
+   parameter. IPIPE_IRQMASK_ANY plays them all, IPIPE_IRQMASK_VIRT
+   plays virtual interrupts only. This routine must be called with hw
+   interrupts off. */
+
+void fastcall __ipipe_sync_stage(unsigned long syncmask)
+{
+	unsigned long mask, submask;
+	struct ipcpudata *cpudata;
+	struct ipipe_domain *ipd;
+	int level, rank, sync;
+	ipipe_declare_cpuid;
+	unsigned irq;
+
+	ipipe_load_cpuid();
+	ipd = ipipe_percpu_domain[cpuid];
+	cpudata = &ipd->cpudata[cpuid];
+
+	sync = __test_and_set_bit(IPIPE_SYNC_FLAG, &cpudata->status);
+
+	/* The policy here is to keep the dispatching code interrupt-free
+	   by stalling the current stage. If the upper domain handler
+	   (which we call) wants to re-enable interrupts while in a safe
+	   portion of the code (e.g. SA_INTERRUPT flag unset for Linux's
+	   sigaction()), it will have to unstall (then stall again before
+	   returning to us!) the stage when it sees fit. */
+
+	while ((mask = (cpudata->irq_pending_hi & syncmask)) != 0) {
+		/* Give a slight priority advantage to high-numbered IRQs
+		   like the virtual ones. */
+		level = flnz(mask);
+		__clear_bit(level, &cpudata->irq_pending_hi);
+
+		while ((submask = cpudata->irq_pending_lo[level]) != 0) {
+			rank = flnz(submask);
+			irq = (level << IPIPE_IRQ_ISHIFT) + rank;
+
+			if (test_bit(IPIPE_LOCK_FLAG, &ipd->irqs[irq].control)) {
+				__clear_bit(rank,
+					    &cpudata->irq_pending_lo[level]);
+				continue;
+			}
+
+			if (--cpudata->irq_hits[irq] == 0)
+				__clear_bit(rank,
+					    &cpudata->irq_pending_lo[level]);
+
+			__set_bit(IPIPE_STALL_FLAG, &cpudata->status);
+
+			if (ipd == ipipe_root_domain) {
+				/* Make sure to re-enable hw interrupts to reduce
+				   preemption latency by higher priority domains when
+				   calling the Linux handlers in the next two
+				   trampolines. Additionally, this ensures that the
+				   forged interrupt frame will allow the final check
+				   for a rescheduling opportunity in ret_from_intr. */
+
+				local_irq_enable_hw();
+
+				if (!test_bit
+				    (IPIPE_CALLASM_FLAG,
+				     &ipd->irqs[irq].control)) {
+					irq_enter();
+					__ipipe_call_c_root_irq_handler(ipd,irq);
+					irq_exit();
+				} else
+					__ipipe_call_asm_irq_handler(ipd, irq);
+			} else
+				__ipipe_call_c_irq_handler(ipd, irq);
+
+			local_irq_disable_hw();
+
+#ifdef CONFIG_SMP
+			{
+				int _cpuid = ipipe_processor_id();
+
+				if (_cpuid != cpuid) {	/* Handle CPU migration. */
+					/* We expect any domain to clear the SYNC bit each
+					   time it switches in a new task, so that preemptions
+					   and/or CPU migrations (in the SMP case) over the
+					   ISR do not lock out the log syncer for some
+					   indefinite amount of time. In the Linux case,
+					   schedule() handles this (see kernel/sched.c). For
+					   this reason, we don't bother clearing it here for
+					   the source CPU in the migration handling case,
+					   since it must have scheduled another task in by
+					   now. */
+					cpuid = _cpuid;
+					cpudata = &ipd->cpudata[cpuid];
+					__set_bit(IPIPE_SYNC_FLAG,
+						  &cpudata->status);
+				}
+			}
+#endif	/* CONFIG_SMP */
+
+			__clear_bit(IPIPE_STALL_FLAG, &cpudata->status);
+		}
+	}
+
+	if (!sync)
+		__clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);
+}
+
+/* __ipipe_walk_pipeline(): Plays interrupts pending in the log. Must
+   be called with local hw interrupts disabled. */
+
+static inline void __ipipe_walk_pipeline(struct list_head *pos, int cpuid)
+{
+	struct ipipe_domain *this_domain = ipipe_percpu_domain[cpuid];
+
+	while (pos != &__ipipe_pipeline) {
+		struct ipipe_domain *next_domain =
+		    list_entry(pos, struct ipipe_domain, p_link);
+
+		if (test_bit
+		    (IPIPE_STALL_FLAG, &next_domain->cpudata[cpuid].status))
+			break;	/* Stalled stage -- do not go further. */
+
+		if (next_domain->cpudata[cpuid].irq_pending_hi != 0) {
+
+			if (next_domain == this_domain)
+				__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			else {
+				__ipipe_switch_to(this_domain, next_domain,
+						  cpuid);
+
+				ipipe_load_cpuid();	/* Processor might have changed. */
+
+				if (this_domain->cpudata[cpuid].
+				    irq_pending_hi != 0
+				    && !test_bit(IPIPE_STALL_FLAG,
+						 &this_domain->cpudata[cpuid].
+						 status)
+				    && !test_bit(IPIPE_SYNC_FLAG,
+						 &this_domain->cpudata[cpuid].
+						 status))
+					__ipipe_sync_stage(IPIPE_IRQMASK_ANY);
+			}
+
+			break;
+		} else if (next_domain == this_domain)
+			break;
+
+		pos = next_domain->p_link.next;
+	}
+}
+
+/* __ipipe_handle_irq() -- IPIPE's generic IRQ handler. An optimistic
+   interrupt protection log is maintained here for each domain.  Hw
+   interrupts are off on entry. */
+
+int __ipipe_handle_irq(struct pt_regs regs)
+{
+	int m_ack = regs.orig_eax >= 0, s_ack;
+	unsigned irq = regs.orig_eax & 0xff;
+	struct list_head *head, *pos;
+	struct ipipe_domain *this_domain;
+	ipipe_declare_cpuid;
+
+	ipipe_load_cpuid();
+
+	this_domain = ipipe_percpu_domain[cpuid];
+
+	s_ack = m_ack;
+
+	if (test_bit(IPIPE_STICKY_FLAG, &this_domain->irqs[irq].control))
+		head = &this_domain->p_link;
+	else
+		head = __ipipe_pipeline.next;
+
+	/* Ack the interrupt. */
+
+	pos = head;
+
+	while (pos != &__ipipe_pipeline) {
+		struct ipipe_domain *next_domain =
+		    list_entry(pos, struct ipipe_domain, p_link);
+
+		/* For each domain handling the incoming IRQ, mark it as
+		   pending in its log. */
+
+		if (test_bit
+		    (IPIPE_HANDLE_FLAG, &next_domain->irqs[irq].control)) {
+			/* Domains that handle this IRQ are polled for
+			   acknowledging it by decreasing priority order. The
+			   interrupt must be made pending _first_ in the domain's
+			   status flags before the PIC is unlocked. */
+
+			next_domain->cpudata[cpuid].irq_hits[irq]++;
+			__ipipe_set_irq_bit(next_domain, cpuid, irq);
+
+			/* Always get the first master acknowledge available. Once
+			   we've got it, allow slave acknowledge handlers to run
+			   (until one of them stops us). */
+
+			if (!m_ack)
+				m_ack = next_domain->irqs[irq].acknowledge(irq);
+			else if (test_bit
+				 (IPIPE_SHARED_FLAG,
+				  &next_domain->irqs[irq].control) && !s_ack)
+				s_ack = next_domain->irqs[irq].acknowledge(irq);
+		}
+
+		/* If the domain does not want the IRQ to be passed down the
+		   interrupt pipe, exit the loop now. */
+
+		if (!test_bit(IPIPE_PASS_FLAG, &next_domain->irqs[irq].control))
+			break;
+
+		pos = next_domain->p_link.next;
+	}
+
+	if (irq == __ipipe_tick_irq) {
+		__ipipe_tick_regs[cpuid].eflags = regs.eflags;
+		__ipipe_tick_regs[cpuid].eip = regs.eip;
+		__ipipe_tick_regs[cpuid].xcs = regs.xcs;
+#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
+		/* Linux profiling code needs this. */
+		__ipipe_tick_regs[cpuid].ebp = regs.ebp;
+#endif	/* CONFIG_SMP && CONFIG_FRAME_POINTER */
+	}
+
+	/* Now walk the pipeline, yielding control to the highest
+	   priority domain that has pending interrupt(s) or
+	   immediately to the current domain if the interrupt has been
+	   marked as 'sticky'. This search does not go beyond the
+	   current domain in the pipeline. */
+
+	__ipipe_walk_pipeline(head, cpuid);
+
+	ipipe_load_cpuid();
+
+	if (ipipe_percpu_domain[cpuid] != ipipe_root_domain ||
+	    test_bit(IPIPE_STALL_FLAG,
+		     &ipipe_root_domain->cpudata[cpuid].status))
+		return 0;
+
+#ifdef CONFIG_SMP
+	/* Prevent a spurious rescheduling from being triggered on
+	   preemptible kernels along the way out through ret_from_intr. */
+	__set_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);
+#endif	/* CONFIG_SMP */
+
+	return 1;
+}
+
+/* ipipe_trigger_irq() -- Push the interrupt at front of the pipeline
+   just like if it has been actually received from a hw source. Also
+   works for virtual interrupts. */
+
+int fastcall ipipe_trigger_irq(unsigned irq)
+{
+	struct pt_regs regs;
+	unsigned long flags;
+
+	if (irq >= IPIPE_NR_IRQS ||
+	    (ipipe_virtual_irq_p(irq) &&
+	     !test_bit(irq - IPIPE_VIRQ_BASE, &__ipipe_virtual_irq_map)))
+		return -EINVAL;
+
+	local_irq_save_hw(flags);
+
+	regs.orig_eax = irq;	/* Won't be acked */
+	regs.xcs = __KERNEL_CS;
+	regs.eflags = flags;
+
+	__ipipe_handle_irq(regs);
+
+	local_irq_restore_hw(flags);
+
+	return 1;
+}
+
+static inline void __fixup_if(struct pt_regs *regs)
+{
+	ipipe_declare_cpuid;
+	unsigned long flags;
+
+	ipipe_get_cpu(flags);
+
+	if (ipipe_percpu_domain[cpuid] == ipipe_root_domain) {
+		/* Have the saved hw state look like the domain stall bit, so
+		   that __ipipe_unstall_iret_root() restores the proper
+		   pipeline state for the root stage upon exit. */
+
+		if (test_bit
+		    (IPIPE_STALL_FLAG,
+		     &ipipe_root_domain->cpudata[cpuid].status))
+			regs->eflags &= ~X86_EFLAGS_IF;
+		else
+			regs->eflags |= X86_EFLAGS_IF;
+	}
+
+	ipipe_put_cpu(flags);
+}
+
+asmlinkage void __ipipe_if_fixup_root(struct pt_regs regs)
+{
+	if (ipipe_running)
+		__fixup_if(&regs);
+}
+
+/*  Check the interrupt flag to make sure the existing preemption
+    opportunity upon in-kernel resumption could be exploited. If
+    pipelining is active, the stall bit of the root domain is checked,
+    otherwise, the EFLAGS register from the stacked interrupt frame is
+    tested. In case a rescheduling could take place in pipelined mode,
+    the root stage is stalled before the hw interrupts are
+    re-enabled. This routine must be called with hw interrupts off. */
+
+asmlinkage int __ipipe_kpreempt_root(struct pt_regs regs)
+{
+	ipipe_declare_cpuid;
+	unsigned long flags;
+
+	if (!ipipe_running)
+		return !!(regs.eflags & X86_EFLAGS_IF);
+
+	ipipe_get_cpu(flags);
+
+	if (test_bit
+	    (IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status)) {
+		ipipe_put_cpu(flags);
+		return 0;	/* Root stage is stalled: rescheduling denied. */
+	}
+
+	__ipipe_stall_root();
+	local_irq_enable_hw();
+
+	return 1;		/* Ok, may reschedule now. */
+}
+
+asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)
+{
+	ipipe_declare_cpuid;
+
+	if (!ipipe_running)
+		return;
+
+	/* Emulate IRET's handling of the interrupt flag. */
+
+	local_irq_disable_hw();
+
+	ipipe_load_cpuid();
+
+	/* Restore the software state as it used to be on kernel
+	   entry. CAUTION: NMIs must *not* return through this
+	   emulation. */
+
+	if (!(regs.eflags & X86_EFLAGS_IF)) {
+		__set_bit(IPIPE_STALL_FLAG,
+			  &ipipe_root_domain->cpudata[cpuid].status);
+		regs.eflags |= X86_EFLAGS_IF;
+	} else {
+		__clear_bit(IPIPE_STALL_FLAG,
+			    &ipipe_root_domain->cpudata[cpuid].status);
+
+		/* Only sync virtual IRQs here, so that we don't recurse
+		   indefinitely in case of an external interrupt flood. */
+
+		if ((ipipe_root_domain->cpudata[cpuid].
+		     irq_pending_hi & IPIPE_IRQMASK_VIRT) != 0)
+			__ipipe_sync_stage(IPIPE_IRQMASK_VIRT);
+	}
+}
+
+EXPORT_SYMBOL(__ipipe_init_stage);
+EXPORT_SYMBOL(__ipipe_sync_stage);
+EXPORT_SYMBOL(__ipipe_ack_system_irq);
+EXPORT_SYMBOL(__ipipe_handle_irq);
+EXPORT_SYMBOL(__ipipe_tick_irq);
+EXPORT_SYMBOL(ipipe_critical_enter);
+EXPORT_SYMBOL(ipipe_critical_exit);
+EXPORT_SYMBOL(ipipe_trigger_irq);
--- linux-2.6.12-rc6/arch/i386/kernel/process.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/process.c	2005-06-16 
17:36:34.000000000 +0200
@@ -161,6 +161,7 @@ void cpu_idle (void)
  				idle = default_idle;

  			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+ 			ipipe_suspend_domain();
  			idle();
  		}
  		schedule();
--- linux-2.6.12-rc6/arch/i386/kernel/smp.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/smp.c	2005-06-15 
17:35:32.000000000 +0200
@@ -131,6 +131,9 @@ void __send_IPI_shortcut(unsigned int sh
  	 * to the APIC.
  	 */
  	unsigned int cfg;
+	unsigned long flags;
+
+	local_irq_save_hw_cond(flags);

  	/*
  	 * Wait for idle.
@@ -146,6 +149,8 @@ void __send_IPI_shortcut(unsigned int sh
  	 * Send the IPI. The write to APIC_ICR fires this off.
  	 */
  	apic_write_around(APIC_ICR, cfg);
+
+	local_irq_restore_hw_cond(flags);
  }

  void fastcall send_IPI_self(int vector)
@@ -162,7 +167,7 @@ void send_IPI_mask_bitmask(cpumask_t cpu
  	unsigned long cfg;
  	unsigned long flags;

-	local_irq_save(flags);
+	local_irq_save_hw(flags);
  		
  	/*
  	 * Wait for idle.
@@ -185,7 +190,7 @@ void send_IPI_mask_bitmask(cpumask_t cpu
  	 */
  	apic_write_around(APIC_ICR, cfg);

-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
  }

  void send_IPI_mask_sequence(cpumask_t mask, int vector)
@@ -199,7 +204,7 @@ void send_IPI_mask_sequence(cpumask_t ma
  	 * should be modified to do 1 message per cluster ID - mbligh
  	 */

-	local_irq_save(flags);
+	local_irq_save_hw(flags);

  	for (query_cpu = 0; query_cpu < NR_CPUS; ++query_cpu) {
  		if (cpu_isset(query_cpu, mask)) {
@@ -226,7 +231,7 @@ void send_IPI_mask_sequence(cpumask_t ma
  			apic_write_around(APIC_ICR, cfg);
  		}
  	}
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
  }

  #include <mach_ipi.h> /* must come after the send_IPI functions above 
for inlining */
@@ -310,7 +315,9 @@ static inline void leave_mm (unsigned lo

  fastcall void smp_invalidate_interrupt(struct pt_regs *regs)
  {
-	unsigned long cpu;
+    	unsigned long cpu, flags;
+
+	local_irq_save_hw_cond(flags);

  	cpu = get_cpu();

@@ -340,6 +347,7 @@ fastcall void smp_invalidate_interrupt(s
  	smp_mb__after_clear_bit();
  out:
  	put_cpu_no_resched();
+	local_irq_restore_hw_cond(flags);
  }

  static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
@@ -400,14 +408,19 @@ void flush_tlb_current_task(void)
  {
  	struct mm_struct *mm = current->mm;
  	cpumask_t cpu_mask;
+	unsigned long flags;

  	preempt_disable();
+	local_irq_save_hw_cond(flags);
+
  	cpu_mask = mm->cpu_vm_mask;
  	cpu_clear(smp_processor_id(), cpu_mask);

  	local_flush_tlb();
  	if (!cpus_empty(cpu_mask))
  		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
+
+	local_irq_restore_hw_cond(flags);
  	preempt_enable();
  }

@@ -435,8 +448,11 @@ void flush_tlb_page(struct vm_area_struc
  {
  	struct mm_struct *mm = vma->vm_mm;
  	cpumask_t cpu_mask;
+	unsigned long flags;

  	preempt_disable();
+	local_irq_save_hw_cond(flags);
+
  	cpu_mask = mm->cpu_vm_mask;
  	cpu_clear(smp_processor_id(), cpu_mask);

@@ -447,6 +463,8 @@ void flush_tlb_page(struct vm_area_struc
  		 	leave_mm(smp_processor_id());
  	}

+	local_irq_restore_hw_cond(flags);
+
  	if (!cpus_empty(cpu_mask))
  		flush_tlb_others(cpu_mask, mm, va);

@@ -609,4 +627,3 @@ fastcall void smp_call_function_interrup
  		atomic_inc(&call_data->finished);
  	}
  }
-
--- linux-2.6.12-rc6/arch/i386/kernel/time.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/time.c	2005-06-15 
17:35:32.000000000 +0200
@@ -258,11 +258,12 @@ static inline void do_timer_interrupt(in
  		 * This will also deassert NMI lines for the watchdog if run
  		 * on an 82489DX-based system.
  		 */
-		spin_lock(&i8259A_lock);
+		unsigned long flags;
+		spin_lock_irqsave_hw_cond(&i8259A_lock,flags);
  		outb(0x0c, PIC_MASTER_OCW3);
  		/* Ack the IRQ; AEOI will end it automatically. */
  		inb(PIC_MASTER_POLL);
-		spin_unlock(&i8259A_lock);
+		spin_unlock_irqrestore_hw_cond(&i8259A_lock,flags);
  	}
  #endif

--- linux-2.6.12-rc6/arch/i386/kernel/traps.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/kernel/traps.c	2005-06-16 
17:36:30.000000000 +0200
@@ -226,6 +226,11 @@ void show_registers(struct pt_regs *regs
  		regs->esi, regs->edi, regs->ebp, esp);
  	printk("ds: %04x   es: %04x   ss: %04x\n",
  		regs->xds & 0xffff, regs->xes & 0xffff, ss);
+#ifdef CONFIG_IPIPE_CORE
+	if (ipipe_current_domain != ipipe_root_domain)
+	    printk("I-pipe domain %s",ipipe_current_domain->name);
+	else
+#endif /* CONFIG_IPIPE_CORE */
  	printk("Process %s (pid: %d, threadinfo=%p task=%p)",
  		current->comm, current->pid, current_thread_info(), current);
  	/*
@@ -946,12 +951,15 @@ asmlinkage void math_state_restore(struc
  {
  	struct thread_info *thread = current_thread_info();
  	struct task_struct *tsk = thread->task;
+	unsigned long flags;

+	local_irq_save_hw_cond(flags);
  	clts();		/* Allow maths ops (or we recurse) */
  	if (!tsk_used_math(tsk))
  		init_fpu(tsk);
  	restore_fpu(tsk);
  	thread->status |= TS_USEDFPU;	/* So we fnsave on switch_to() */
+	local_irq_restore_hw_cond(flags);
  }

  #ifndef CONFIG_MATH_EMULATION
--- linux-2.6.12-rc6/arch/i386/mm/fault.c	2005-06-06 17:22:29.000000000 
+0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/mm/fault.c	2005-06-15 
17:35:32.000000000 +0200
@@ -224,6 +224,8 @@ fastcall void do_page_fault(struct pt_re
  	/* get the address */
  	__asm__("movl %%cr2,%0":"=r" (address));

+	local_irq_enable_hw_cond();
+
  	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
  					SIGSEGV) == NOTIFY_STOP)
  		return;
--- linux-2.6.12-rc6/arch/i386/mm/ioremap.c	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/arch/i386/mm/ioremap.c	2005-06-15 
18:28:03.000000000 +0200
@@ -16,6 +16,7 @@
  #include <asm/cacheflush.h>
  #include <asm/tlbflush.h>
  #include <asm/pgtable.h>
+#include <asm/pgalloc.h>

  #define ISA_START_ADDRESS	0xa0000
  #define ISA_END_ADDRESS		0x100000
@@ -92,6 +93,7 @@ static int ioremap_page_range(unsigned l
  		err = ioremap_pud_range(pgd, addr, next, phys_addr+addr, flags);
  		if (err)
  			break;
+		set_pgdir(addr, *pgd);
  	} while (pgd++, addr = next, addr != end);
  	spin_unlock(&init_mm.page_table_lock);
  	flush_tlb_all();
--- linux-2.6.12-rc6/include/asm-i386/apic.h	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/asm-i386/apic.h	2005-06-15 
17:35:32.000000000 +0200
@@ -69,7 +69,13 @@ int get_physical_broadcast(void);
  # define apic_write_around(x,y) apic_write_atomic((x),(y))
  #endif

+#ifdef CONFIG_IPIPE_CORE
+#define ack_APIC_irq() do { if (!ipipe_running) __ack_APIC_irq(); } 
while(0)
+static inline void __ack_APIC_irq(void)
+#else /* !CONFIG_IPIPE_CORE */
+#define __ack_APIC_irq() ack_APIC_irq()
  static inline void ack_APIC_irq(void)
+#endif /* CONFIG_IPIPE_CORE */
  {
  	/*
  	 * ack_APIC_irq() actually gets compiled as a single instruction:
--- linux-2.6.12-rc6/include/asm-i386/io_apic.h	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/asm-i386/io_apic.h	2005-06-15 
17:35:32.000000000 +0200
@@ -16,7 +16,9 @@
  #ifdef CONFIG_PCI_MSI
  static inline int use_pci_vector(void)	{return 1;}
  static inline void disable_edge_ioapic_vector(unsigned int vector) { }
+#ifndef CONFIG_IPIPE_CORE
  static inline void mask_and_ack_level_ioapic_vector(unsigned int 
vector) { }
+#endif /* !CONFIG_IPIPE_CORE */
  static inline void end_edge_ioapic_vector (unsigned int vector) { }
  #define startup_level_ioapic	startup_level_ioapic_vector
  #define shutdown_level_ioapic	mask_IO_APIC_vector
@@ -35,7 +37,9 @@ static inline void end_edge_ioapic_vecto
  #else
  static inline int use_pci_vector(void)	{return 0;}
  static inline void disable_edge_ioapic_irq(unsigned int irq) { }
+#ifndef CONFIG_IPIPE_CORE
  static inline void mask_and_ack_level_ioapic_irq(unsigned int irq) { }
+#endif /* !CONFIG_IPIPE_CORE */
  static inline void end_edge_ioapic_irq (unsigned int irq) { }
  #define startup_level_ioapic	startup_level_ioapic_irq
  #define shutdown_level_ioapic	mask_IO_APIC_irq
--- linux-2.6.12-rc6/include/asm-i386/ipipe.h	1970-01-01 
01:00:00.000000000 +0100
+++ linux-2.6.12-rc6-ipipe-0.5/include/asm-i386/ipipe.h	2005-06-17 
20:26:33.000000000 +0200
@@ -0,0 +1,308 @@
+/*   -*- linux-c -*-
+ *   include/asm-i386/ipipe.h
+ *
+ *   Copyright (C) 2002-2005 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 
02111-1307, USA.
+ */
+
+#ifndef __I386_IPIPE_H
+#define __I386_IPIPE_H
+
+#include <irq_vectors.h>
+#include <asm/ptrace.h>
+#include <linux/cpumask.h>
+#include <linux/list.h>
+#include <linux/threads.h>
+
+#define IPIPE_ARCH_STRING   "0.5/x86"
+#define IPIPE_MAJOR_NUMBER  0
+#define IPIPE_MINOR_NUMBER  5
+
+#ifdef CONFIG_SMP
+
+#include <asm/fixmap.h>
+#include <asm/mpspec.h>
+#include <mach_apicdef.h>
+#include <linux/thread_info.h>
+
+#define IPIPE_NR_CPUS          NR_CPUS
+#define IPIPE_CRITICAL_VECTOR  0xf9	/* Used by 
ipipe_critical_enter/exit() */
+#define IPIPE_CRITICAL_IPI     (IPIPE_CRITICAL_VECTOR - 
FIRST_EXTERNAL_VECTOR)
+
+#define ipipe_processor_id()   (current_thread_info()->cpu)
+
+#define ipipe_declare_cpuid    int cpuid
+#define ipipe_load_cpuid()     do { \
+                                  (cpuid) = ipipe_processor_id();	\
+                               } while(0)
+#define ipipe_lock_cpu(flags)  do { \
+                                  local_irq_save_hw(flags); \
+                                  (cpuid) = ipipe_processor_id(); \
+                               } while(0)
+#define ipipe_unlock_cpu(flags) local_irq_restore_hw(flags)
+#define ipipe_get_cpu(flags)    ipipe_lock_cpu(flags)
+#define ipipe_put_cpu(flags)    ipipe_unlock_cpu(flags)
+#define ipipe_current_domain    (ipipe_percpu_domain[ipipe_processor_id()])
+
+#else	/* !CONFIG_SMP */
+
+#define IPIPE_NR_CPUS           1
+#define ipipe_processor_id()    0
+#define ipipe_declare_cpuid     const int cpuid = 0
+#define ipipe_load_cpuid()	/* nop */
+#define ipipe_lock_cpu(flags)   local_irq_save_hw(flags)
+#define ipipe_unlock_cpu(flags) local_irq_restore_hw(flags)
+#define ipipe_get_cpu(flags)    do { flags = flags; } while(0)
+#define ipipe_put_cpu(flags)	/* nop */
+#define ipipe_current_domain    (ipipe_percpu_domain[0])
+
+#endif	/* CONFIG_SMP */
+
+#define prepare_arch_switch(rq, next)	do { } while (0)
+#define finish_arch_switch(rq, prev)	do {	\
+ 
__clear_bit(IPIPE_SYNC_FLAG,&ipipe_root_domain->cpudata[task_cpu(prev)].status); 
\
+	spin_unlock_irq(&(rq)->lock);		\
+} while(0)
+#define task_running(rq, p)		((rq)->curr == (p))
+
+struct ipipe_sysinfo {
+
+	int ncpus;		/* Number of CPUs on board */
+	u64 cpufreq;		/* CPU frequency (in Hz) */
+
+	/* Arch-dependent block */
+
+	struct {
+		unsigned tmirq;	/* Timer tick IRQ */
+		u64 tmfreq;	/* Timer frequency */
+	} archdep;
+};
+
+#ifdef CONFIG_X86_LOCAL_APIC
+/* We must cover the whole IRQ space to map the local timer interrupt
+   (#207). */
+#ifdef CONFIG_PCI_MSI
+#define IPIPE_NR_XIRQS NR_IRQS
+#else	/* CONFIG_PCI_MSI */
+#define IPIPE_NR_XIRQS   224
+#endif	/* CONFIG_PCI_MSI */
+#else	/* !CONFIG_X86_LOCAL_APIC */
+#define IPIPE_NR_XIRQS   NR_IRQS
+#endif	/* CONFIG_X86_LOCAL_APIC */
+
+/* Number of virtual IRQs */
+#define IPIPE_NR_VIRQS   BITS_PER_LONG
+/* First virtual IRQ # */
+#define IPIPE_VIRQ_BASE  (((IPIPE_NR_XIRQS + BITS_PER_LONG - 1) / 
BITS_PER_LONG) * BITS_PER_LONG)
+/* Total number of IRQ slots */
+#define IPIPE_NR_IRQS     (IPIPE_VIRQ_BASE + IPIPE_NR_VIRQS)
+/* Number of indirect words needed to map the whole IRQ space. */
+#define IPIPE_IRQ_IWORDS  ((IPIPE_NR_IRQS + BITS_PER_LONG - 1) / 
BITS_PER_LONG)
+#define IPIPE_IRQ_IMASK   (BITS_PER_LONG - 1)
+#define IPIPE_IRQ_ISHIFT  5	/* 2^5 for 32bits arch. */
+
+#define IPIPE_IRQMASK_ANY   (~0L)
+#define IPIPE_IRQMASK_VIRT  (IPIPE_IRQMASK_ANY << (IPIPE_VIRQ_BASE / 
BITS_PER_LONG))
+
+struct ipipe_domain {
+
+	struct list_head p_link;	/* Link in pipeline */
+
+	struct ipcpudata {
+		volatile unsigned long status;
+		volatile unsigned long irq_pending_hi;
+		volatile unsigned long irq_pending_lo[IPIPE_IRQ_IWORDS];
+		volatile unsigned irq_hits[IPIPE_NR_IRQS];
+	} cpudata[IPIPE_NR_CPUS];
+
+	struct {
+		int (*acknowledge) (unsigned irq);
+		void (*handler) (unsigned irq);
+		unsigned long control;
+	} irqs[IPIPE_NR_IRQS];
+
+	unsigned long flags;
+	unsigned domid;
+	const char *name;
+	int priority;
+	void *pdd;
+};
+
+/* The following macros must be used hw interrupts off. */
+
+#define __ipipe_set_irq_bit(ipd,cpuid,irq) \
+do { \
+    if (!test_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) { \
+        __set_bit(irq & 
IPIPE_IRQ_IMASK,&(ipd)->cpudata[cpuid].irq_pending_lo[irq >> 
IPIPE_IRQ_ISHIFT]); \
+        __set_bit(irq >> 
IPIPE_IRQ_ISHIFT,&(ipd)->cpudata[cpuid].irq_pending_hi); \
+       } \
+} while(0)
+
+#define __ipipe_clear_pend(ipd,cpuid,irq) \
+do { \
+    __clear_bit(irq & 
IPIPE_IRQ_IMASK,&(ipd)->cpudata[cpuid].irq_pending_lo[irq >> 
IPIPE_IRQ_ISHIFT]); \
+    if ((ipd)->cpudata[cpuid].irq_pending_lo[irq >> IPIPE_IRQ_ISHIFT] 
== 0) \
+        __clear_bit(irq >> 
IPIPE_IRQ_ISHIFT,&(ipd)->cpudata[cpuid].irq_pending_hi); \
+} while(0)
+
+#define __ipipe_lock_irq(ipd,cpuid,irq) \
+do { \
+    if (!test_and_set_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) \
+	__ipipe_clear_pend(ipd,cpuid,irq); \
+} while(0)
+
+#define __ipipe_unlock_irq(ipd,irq) \
+do { \
+    int __cpuid, __nr_cpus = num_online_cpus();			       \
+    if (test_and_clear_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control)) \
+	for (__cpuid = 0; __cpuid < __nr_cpus; __cpuid++)      \
+         if ((ipd)->cpudata[__cpuid].irq_hits[irq] > 0) { /* We need 
atomic ops next. */ \
+           set_bit(irq & 
IPIPE_IRQ_IMASK,&(ipd)->cpudata[__cpuid].irq_pending_lo[irq >> 
IPIPE_IRQ_ISHIFT]); \
+           set_bit(irq >> 
IPIPE_IRQ_ISHIFT,&(ipd)->cpudata[__cpuid].irq_pending_hi); \
+         } \
+} while(0)
+
+#define __ipipe_clear_irq(ipd,irq) \
+do { \
+    int __cpuid, __nr_cpus = num_online_cpus(); \
+    clear_bit(IPIPE_LOCK_FLAG,&(ipd)->irqs[irq].control); \
+    for (__cpuid = 0; __cpuid < __nr_cpus; __cpuid++) {	\
+       (ipd)->cpudata[__cpuid].irq_hits[irq] = 0; \
+       __ipipe_clear_pend(ipd,__cpuid,irq); \
+    } \
+} while(0)
+
+#define ipipe_virtual_irq_p(irq) ((irq) >= IPIPE_VIRQ_BASE && \
+				  (irq) < IPIPE_NR_IRQS)
+
+#define ipipe_hw_save_flags_and_sti(x)	__asm__ __volatile__("pushfl ; 
popl %0 ; sti":"=g" (x): /* no input */ :"memory")
+#define local_irq_disable_hw() 			__asm__ __volatile__("cli": : :"memory")
+#define local_irq_enable_hw()			__asm__ __volatile__("sti": : :"memory")
+#define local_irq_save_hw(x)    __asm__ __volatile__("pushfl ; popl %0 
; cli":"=g" (x): /* no input */ :"memory")
+#define local_irq_restore_hw(x) __asm__ __volatile__("pushl %0 ; 
popfl": /* no output */ :"g" (x):"memory", "cc")
+#define local_save_flags_hw(x)   __asm__ __volatile__("pushfl ; popl 
%0":"=g" (x): /* no input */)
+#define local_test_iflag_hw(x)   ((x) & (1<<9))
+#define irqs_disabled_hw()	\
+({					\
+	unsigned long flags;		\
+	local_save_flags_hw(flags);	\
+	!local_test_iflag_hw(flags);	\
+})
+
+#define ipipe_read_tsc(t)  __asm__ __volatile__("rdtsc" : "=A" (t))
+#define ipipe_cpu_freq() ({ unsigned long long __freq = 
cpu_has_tsc?(1000LL * cpu_khz):CLOCK_TICK_RATE; __freq; })
+
+#ifdef CONFIG_IPIPE_PREEMPT_RT
+/* We are over a combo I-pipe+PREEMPT_RT _patched_ kernel, but
+   CONFIG_PREEMPT_RT is not necessarily enabled; use the raw spinlock
+   support for the I-pipe. */
+#define spin_lock_hw(x)     __raw_spin_lock(x)
+#define spin_unlock_hw(x)   __raw_spin_unlock(x)
+#define spin_trylock_hw(x)  __raw_spin_trylock(x)
+#define write_lock_hw(x)    __raw_write_lock(x)
+#define write_unlock_hw(x)  __raw_write_unlock(x)
+#define write_trylock_hw(x) __raw_write_trylock(x)
+#define read_lock_hw(x)     __raw_read_lock(x)
+#define read_unlock_hw(x)   __raw_read_unlock(x)
+#else	/* !CONFIG_IPIPE_PREEMPT_RT */
+#define spin_lock_hw(x)     _spin_lock(x)
+#define spin_unlock_hw(x)   _spin_unlock(x)
+#define spin_trylock_hw(x)  _spin_trylock(x)
+#define write_lock_hw(x)    _write_lock(x)
+#define write_unlock_hw(x)  _write_unlock(x)
+#define write_trylock_hw(x) _write_trylock(x)
+#define read_lock_hw(x)     _read_lock(x)
+#define read_unlock_hw(x)   _read_unlock(x)
+#define raw_spinlock_t         spinlock_t
+#define RAW_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
+#define raw_rwlock_t           rwlock_t
+#define RAW_RW_LOCK_UNLOCKED   RW_LOCK_UNLOCKED
+#endif	/* CONFIG_IPIPE_PREEMPT_RT */
+
+#define spin_lock_irqsave_hw(x,flags)  \
+do { \
+   local_irq_save_hw(flags); \
+   spin_lock_hw(x); \
+} while (0)
+
+#define spin_unlock_irqrestore_hw(x,flags)  \
+do { \
+   spin_unlock_hw(x); \
+   local_irq_restore_hw(flags); \
+} while (0)
+
+#define spin_lock_irq_hw(x)  \
+do { \
+   local_irq_disable_hw(); \
+   spin_lock_hw(x); \
+} while (0)
+
+#define spin_unlock_irq_hw(x)  \
+do { \
+   spin_unlock_hw(x); \
+   local_irq_enable_hw(); \
+} while (0)
+
+#define read_lock_irqsave_hw(lock, flags) \
+do { \
+   local_irq_save_hw(flags); \
+   read_lock_hw(lock); \
+} while (0)
+
+#define read_unlock_irqrestore_hw(lock, flags) \
+do { \
+   read_unlock_hw(lock); \
+   local_irq_restore_hw(flags); \
+} while (0)
+
+#define write_lock_irqsave_hw(lock, flags) \
+do { \
+   local_irq_save_hw(flags); \
+   write_lock_hw(lock); \
+} while (0)
+
+#define write_unlock_irqrestore_hw(lock, flags) \
+do { \
+   write_unlock_hw(lock); \
+   local_irq_restore_hw(flags); \
+} while (0)
+
+/* Private interface -- Internal use only */
+
+void __ipipe_cleanup_domain(struct ipipe_domain *ipd);
+
+#define __ipipe_check_platform() do { } while(0)
+
+#define __ipipe_init_platform() do { } while(0)
+
+void __ipipe_enable_pipeline(void);
+
+void __ipipe_disable_pipeline(void);
+
+void __ipipe_init_stage(struct ipipe_domain *ipd);
+
+void fastcall __ipipe_sync_stage(unsigned long syncmask);
+
+int __ipipe_ack_system_irq(unsigned irq);
+
+int __ipipe_handle_irq(struct pt_regs regs);
+
+extern struct pt_regs __ipipe_tick_regs[];
+
+extern int __ipipe_tick_irq;
+
+#endif	/* !__I386_IPIPE_H */
--- linux-2.6.12-rc6/include/asm-i386/mach-default/do_timer.h	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/asm-i386/mach-default/do_timer.h 
2005-06-15 17:35:32.000000000 +0200
@@ -49,14 +49,15 @@ static inline void do_timer_interrupt_ho
  static inline int do_timer_overflow(int count)
  {
  	int i;
+	unsigned long flags;

-	spin_lock(&i8259A_lock);
+	spin_lock_irqsave_hw_cond(&i8259A_lock, flags);
  	/*
  	 * This is tricky when I/O APICs are used;
  	 * see do_timer_interrupt().
  	 */
  	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
+	spin_unlock_irqrestore_hw_cond(&i8259A_lock, flags);
  	
  	/* assumption about timer being IRQ0 */
  	if (i & 0x01) {
--- linux-2.6.12-rc6/include/asm-i386/mach-visws/do_timer.h	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/asm-i386/mach-visws/do_timer.h 
2005-06-15 17:35:32.000000000 +0200
@@ -28,14 +28,15 @@ static inline void do_timer_interrupt_ho
  static inline int do_timer_overflow(int count)
  {
  	int i;
+	unsigned long flags;

-	spin_lock(&i8259A_lock);
+	spin_lock_irqsave_hw_cond(&i8259A_lock, flags);
  	/*
  	 * This is tricky when I/O APICs are used;
  	 * see do_timer_interrupt().
  	 */
  	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
+	spin_unlock_irqrestore_hw_cond(&i8259A_lock, flags);
  	
  	/* assumption about timer being IRQ0 */
  	if (i & 0x01) {
--- linux-2.6.12-rc6/include/asm-i386/pgalloc.h	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/asm-i386/pgalloc.h	2005-06-15 
18:32:05.000000000 +0200
@@ -47,4 +47,27 @@ static inline void pte_free(struct page

  #define check_pgt_cache()	do { } while (0)

+static inline void set_pgdir(unsigned long address, pgd_t entry)
+{
+#ifdef CONFIG_IPIPE_CORE
+	struct task_struct * p;
+	struct page *page;
+	pgd_t *pgd;
+	
+	read_lock(&tasklist_lock);
+
+	for_each_process(p) {
+		if(p->mm)
+		    *pgd_offset(p->mm,address) = entry;
+	}
+
+	read_unlock(&tasklist_lock);
+
+	for (page = pgd_list; page; page = (struct page *)page->index) {
+		pgd = (pgd_t *)page_address(page);
+		pgd[address >> PGDIR_SHIFT] = entry;
+	}
+#endif /* CONFIG_IPIPE_CORE */
+}
+
  #endif /* _I386_PGALLOC_H */
--- linux-2.6.12-rc6/include/asm-i386/spinlock.h	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/asm-i386/spinlock.h	2005-06-15 
17:35:32.000000000 +0200
@@ -57,6 +57,9 @@ typedef struct {
  	"jmp 1b\n" \
  	"3:\n\t"

+#ifdef CONFIG_IPIPE_CORE
+#define spin_lock_string_flags spin_lock_string
+#else /* !CONFIG_IPIPE_CORE */
  #define spin_lock_string_flags \
  	"\n1:\t" \
  	"lock ; decb %0\n\t" \
@@ -72,6 +75,7 @@ typedef struct {
  	"cli\n\t" \
  	"jmp 1b\n" \
  	"4:\n\t"
+#endif /* CONFIG_IPIPE_CORE */

  /*
   * This works. Despite all the confusion.
--- linux-2.6.12-rc6/include/asm-i386/system.h	2005-06-06 
17:22:29.000000000 +0200
+++ linux-2.6.12-rc6-ipipe-0.5/include/asm-i386/system.h	2005-06-16 
17:37:34.000000000 +0200
@@ -441,6 +441,35 @@ struct alt_instr {
  #define set_wmb(var, value) do { var = value; wmb(); } while (0)

  /* interrupt control.. */
+#ifdef CONFIG_IPIPE_CORE
+
+#include <linux/linkage.h>
+
+void __ipipe_stall_root(void);
+
+void __ipipe_unstall_root(void);
+
+unsigned long __ipipe_test_root(void);
+
+unsigned long __ipipe_test_and_stall_root(void);
+
+void fastcall __ipipe_restore_root(unsigned long flags);
+
+#define local_save_flags(x)	((x) = __ipipe_test_root())
+#define local_irq_save(x)	((x) = __ipipe_test_and_stall_root())
+#define local_irq_restore(x)	__ipipe_restore_root(x)
+#define local_irq_disable()	__ipipe_stall_root()
+#define local_irq_enable()	__ipipe_unstall_root()
+
+#define irqs_disabled()		__ipipe_test_root()
+
+#define safe_halt() do { \
+    __ipipe_unstall_root(); \
+    __asm__ __volatile__("sti; hlt": : :"memory"); \
+} while(0)
+
+#else /* !CONFIG_IPIPE_CORE */
+
  #define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ 
__volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
  #define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ 
__volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", 
"cc"); } while (0)
  #define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
@@ -458,6 +487,8 @@ struct alt_instr {
  /* For spinlocks etc */
  #define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; 
cli":"=g" (x): /* no input */ :"memory")

+#endif /* CONFIG_IPIPE_CORE */
+
  /*
   * disable hlt during certain critical i/o operations
   */
--- linux-2.6.12-rc6/ipipe/x86.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc6-ipipe-0.5/ipipe/x86.c	2005-06-17 12:13:30.000000000 
+0200
@@ -0,0 +1,577 @@
+/*   -*- linux-c -*-
+ *   linux/ipipe/x86.c
+ *
+ *   Copyright (C) 2002-2005 Philippe Gerum.
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 
02111-1307, USA.
+ *
+ *   Architecture-dependent I-PIPE support for x86.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/hw_irq.h>
+#include <asm/irq.h>
+#include <asm/desc.h>
+#include <asm/io.h>
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/fixmap.h>
+#include <asm/bitops.h>
+#include <asm/mpspec.h>
+#ifdef CONFIG_X86_IO_APIC
+#include <asm/io_apic.h>
+#endif	/* CONFIG_X86_IO_APIC */
+#include <asm/apic.h>
+#include <mach_ipi.h>
+#endif	/* CONFIG_X86_LOCAL_APIC */
+
+extern struct desc_struct idt_table[];
+
+extern void (*__ipipe_irq_trampolines[]) (void);	/* in entry.S */
+
+static void (*__ipipe_std_vector_table[256]) (void);
+
+static struct hw_interrupt_type __ipipe_std_irq_dtype[NR_IRQS];
+
+/* Lifted from arch/i386/kernel/traps.c */
+#define __ipipe_set_gate(gate_addr,type,dpl,addr)  \
+do { \
+  int __d0, __d1; \
+  __asm__ __volatile__ ("movw %%dx,%%ax\n\t" \
+	"movw %4,%%dx\n\t" \
+	"movl %%eax,%0\n\t" \
+	"movl %%edx,%1" \
+	:"=m" (*((long *) (gate_addr))), \
+	 "=m" (*(1+(long *) (gate_addr))), "=&a" (__d0), "=&d" (__d1) \
+	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
+	 "3" ((char *) (addr)),"2" (__KERNEL_CS << 16)); \
+} while (0)
+
+#define __ipipe_get_gate_addr(v) \
+	((void *)((idt_table[v].b & 0xffff0000)|(idt_table[v].a & 0xffff)))
+
+#define __ipipe_set_irq_gate(vector,addr) \
+__ipipe_set_gate(idt_table+vector,14,0,addr)
+
+#define __ipipe_set_trap_gate(vector,addr) \
+__ipipe_set_gate(idt_table+vector,15,0,addr)
+
+#define __ipipe_set_sys_gate(vector,addr) \
+__ipipe_set_gate(idt_table+vector,15,3,addr)
+
+static int __ipipe_ack_common_irq(unsigned irq)
+{
+	preempt_disable();
+	__ipipe_std_irq_dtype[irq].ack(irq);
+	preempt_enable_no_resched();
+
+	return 1;
+}
+
+static unsigned __ipipe_override_irq_startup(unsigned irq)
+{
+	unsigned long adflags, hwflags;
+	ipipe_declare_cpuid;
+	unsigned s;
+
+	ipipe_lock_cpu(hwflags);
+	adflags = ipipe_test_and_stall_pipeline();
+	preempt_disable();
+	__ipipe_unlock_irq(ipipe_percpu_domain[cpuid], irq);
+	s = __ipipe_std_irq_dtype[irq].startup(irq);
+	preempt_enable_no_resched();
+	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], adflags,
+				      cpuid);
+	ipipe_unlock_cpu(hwflags);
+
+	return s;
+}
+
+static void __ipipe_override_irq_shutdown(unsigned irq)
+{
+	unsigned long adflags, hwflags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(hwflags);
+	adflags = ipipe_test_and_stall_pipeline();
+	preempt_disable();
+	__ipipe_std_irq_dtype[irq].shutdown(irq);
+	__ipipe_clear_irq(ipipe_percpu_domain[cpuid], irq);
+	preempt_enable_no_resched();
+	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], adflags,
+				      cpuid);
+	ipipe_unlock_cpu(hwflags);
+}
+
+static void __ipipe_override_irq_enable(unsigned irq)
+{
+	unsigned long adflags, hwflags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(hwflags);
+	adflags = ipipe_test_and_stall_pipeline();
+	preempt_disable();
+	__ipipe_unlock_irq(ipipe_percpu_domain[cpuid], irq);
+	__ipipe_std_irq_dtype[irq].enable(irq);
+	preempt_enable_no_resched();
+	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], adflags,
+				      cpuid);
+	ipipe_unlock_cpu(hwflags);
+}
+
+static void __ipipe_override_irq_disable(unsigned irq)
+{
+	unsigned long adflags, hwflags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(hwflags);
+	adflags = ipipe_test_and_stall_pipeline();
+	preempt_disable();
+	__ipipe_std_irq_dtype[irq].disable(irq);
+	__ipipe_lock_irq(ipipe_percpu_domain[cpuid], cpuid, irq);
+	preempt_enable_no_resched();
+	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], adflags,
+				      cpuid);
+	ipipe_unlock_cpu(hwflags);
+}
+
+static void __ipipe_override_irq_ack(unsigned irq)
+{
+	if (!ipipe_running)
+		__ipipe_std_irq_dtype[irq].ack(irq);
+}
+
+static void __ipipe_override_irq_end(unsigned irq)
+{
+	unsigned long adflags, hwflags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(hwflags);
+	adflags = ipipe_test_and_stall_pipeline();
+	preempt_disable();
+
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+		__ipipe_unlock_irq(ipipe_percpu_domain[cpuid], irq);
+
+	__ipipe_std_irq_dtype[irq].end(irq);
+
+	preempt_enable_no_resched();
+	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], adflags,
+				      cpuid);
+	ipipe_unlock_cpu(hwflags);
+}
+
+static void __ipipe_override_irq_affinity(unsigned irq, cpumask_t mask)
+{
+	unsigned long adflags, hwflags;
+	ipipe_declare_cpuid;
+
+	ipipe_lock_cpu(hwflags);
+	adflags = ipipe_test_and_stall_pipeline();
+	preempt_disable();
+	__ipipe_std_irq_dtype[irq].set_affinity(irq, mask);
+	preempt_enable_no_resched();
+	ipipe_restore_pipeline_nosync(ipipe_percpu_domain[cpuid], adflags,
+				      cpuid);
+	ipipe_unlock_cpu(hwflags);
+}
+
+/* __ipipe_enable_pipeline() -- Take over the interrupt control from
+   the root domain (i.e. Linux). After this routine has returned, all
+   interrupts go through the pipeline. */
+
+void __ipipe_enable_pipeline(void)
+{
+	unsigned vector, irq, rirq;
+	unsigned long flags;
+
+	/* Collect the original vector table. */
+
+	for (vector = 0; vector < 256; vector++)
+		__ipipe_std_vector_table[vector] =
+		    __ipipe_get_gate_addr(vector);
+
+#ifdef CONFIG_SMP
+
+	/* This vector must be set up prior to call
+	   ipipe_critical_enter(). */
+
+	__ipipe_set_irq_gate(IPIPE_CRITICAL_VECTOR,
+			     __ipipe_irq_trampolines[IPIPE_CRITICAL_IPI]);
+
+#endif	/* CONFIG_SMP */
+
+	flags = ipipe_critical_enter(NULL);
+
+	/* First, grab the ISA and IO-APIC interrupts. */
+
+	for (irq = 0;
+	     irq < NR_IRQS && irq + FIRST_EXTERNAL_VECTOR < FIRST_SYSTEM_VECTOR;
+	     irq++) {
+		rirq = irq;
+
+#ifdef CONFIG_X86_IO_APIC
+		if (IO_APIC_IRQ(irq)) {
+			vector = IO_APIC_VECTOR(irq);
+
+			if (vector == 0)
+				continue;
+
+#ifdef CONFIG_PCI_MSI
+			/* Account specifically for MSI routing. */
+			if (!platform_legacy_irq(irq))
+				rirq = vector;
+#endif	/* CONFIG_PCI_MSI */
+		} else
+#endif	/* CONFIG_X86_IO_APIC */
+		{
+			vector = irq + FIRST_EXTERNAL_VECTOR;
+
+			if (vector == SYSCALL_VECTOR)
+				continue;
+		}
+
+		/* Fails for IPIPE_CRITICAL_IPI but that's ok. */
+
+		ipipe_virtualize_irq(rirq,
+				     (void (*)(unsigned))
+				     __ipipe_std_vector_table[vector],
+				     &__ipipe_ack_common_irq,
+				     IPIPE_CALLASM_MASK | IPIPE_HANDLE_MASK |
+				     IPIPE_PASS_MASK);
+
+		__ipipe_set_irq_gate(vector, __ipipe_irq_trampolines[rirq]);
+	}
+
+	/* Interpose on the IRQ control routines so we can make them
+	   atomic using hw masking and prevent the interrupt log from
+	   being untimely flushed. Since we don't want to be too smart
+	   about what's going on into irq.c and we want to change only
+	   some of the controller members, let's be dumb and interpose the
+	   rough way. */
+
+	for (irq = 0; irq < NR_IRQS; irq++)
+		__ipipe_std_irq_dtype[irq] = *irq_desc[irq].handler;
+
+	/* The original controller structs may be shared, so we first
+	   save them all before changing any of them. Notice that we
+	   don't redirect the ack handler since the relevant
+	   XT-PIC/IO-APIC management code is already IPIPE-aware. */
+
+	for (irq = 0; irq < NR_IRQS; irq++) {
+		irq_desc[irq].handler->startup = &__ipipe_override_irq_startup;
+		irq_desc[irq].handler->shutdown =
+		    &__ipipe_override_irq_shutdown;
+		irq_desc[irq].handler->enable = &__ipipe_override_irq_enable;
+		irq_desc[irq].handler->disable = &__ipipe_override_irq_disable;
+		irq_desc[irq].handler->ack = &__ipipe_override_irq_ack;
+		irq_desc[irq].handler->end = &__ipipe_override_irq_end;
+
+		if (irq_desc[irq].handler->set_affinity != NULL)
+			irq_desc[irq].handler->set_affinity =
+			    &__ipipe_override_irq_affinity;
+	}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+	/* Map the APIC system vectors including the unused ones so that
+	   client domains can virtualize the corresponding IRQs. */
+
+	for (vector = FIRST_SYSTEM_VECTOR; vector < CALL_FUNCTION_VECTOR;
+	     vector++) {
+		ipipe_virtualize_irq(vector - FIRST_EXTERNAL_VECTOR,
+				     (void (*)(unsigned))
+				     __ipipe_std_vector_table[vector],
+				     &__ipipe_ack_system_irq,
+				     IPIPE_CALLASM_MASK | IPIPE_HANDLE_MASK |
+				     IPIPE_PASS_MASK);
+
+		__ipipe_set_irq_gate(vector,
+				     __ipipe_irq_trampolines[vector -
+							     FIRST_EXTERNAL_VECTOR]);
+	}
+
+	__ipipe_tick_irq =
+	    using_apic_timer ? LOCAL_TIMER_VECTOR - FIRST_EXTERNAL_VECTOR : 0;
+
+#else	/* !CONFIG_X86_LOCAL_APIC */
+
+	__ipipe_tick_irq = 0;
+
+#endif	/* CONFIG_X86_LOCAL_APIC */
+
+#ifdef CONFIG_SMP
+
+	/* All interrupts must be pipelined, but the spurious one since we
+	   don't even want to acknowledge it. */
+
+	for (vector = CALL_FUNCTION_VECTOR; vector < SPURIOUS_APIC_VECTOR;
+	     vector++) {
+		ipipe_virtualize_irq(vector - FIRST_EXTERNAL_VECTOR,
+				     (void (*)(unsigned))
+				     __ipipe_std_vector_table[vector],
+				     &__ipipe_ack_system_irq,
+				     IPIPE_CALLASM_MASK | IPIPE_HANDLE_MASK |
+				     IPIPE_PASS_MASK);
+
+		__ipipe_set_irq_gate(vector,
+				     __ipipe_irq_trampolines[vector -
+							     FIRST_EXTERNAL_VECTOR]);
+	}
+
+#endif	/* CONFIG_SMP */
+
+	ipipe_running = 1;
+
+	ipipe_critical_exit(flags);
+
+	printk(KERN_WARNING "I-pipe: Pipelining started.\n");
+}
+
+/* __ipipe_disable_pipeline() -- Disengage the pipeline. */
+
+void __ipipe_disable_pipeline(void)
+{
+	unsigned vector, irq;
+	unsigned long flags;
+
+	flags = ipipe_critical_enter(NULL);
+
+	/* Restore interrupt controllers. */
+
+	for (irq = 0; irq < NR_IRQS; irq++)
+		*irq_desc[irq].handler = __ipipe_std_irq_dtype[irq];
+
+	/* Restore original IDT settings. */
+
+	for (irq = 0;
+	     irq < NR_IRQS && irq + FIRST_EXTERNAL_VECTOR < FIRST_SYSTEM_VECTOR;
+	     irq++) {
+#ifdef CONFIG_X86_IO_APIC
+		if (IO_APIC_IRQ(irq)) {
+			vector = IO_APIC_VECTOR(irq);
+
+			if (vector == 0)
+				continue;
+		} else
+#endif	/* CONFIG_X86_IO_APIC */
+		{
+			vector = irq + FIRST_EXTERNAL_VECTOR;
+
+			if (vector == SYSCALL_VECTOR)
+				continue;
+		}
+
+		__ipipe_set_irq_gate(vector, __ipipe_std_vector_table[vector]);
+	}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+
+	for (vector = FIRST_SYSTEM_VECTOR; vector < CALL_FUNCTION_VECTOR;
+	     vector++)
+		__ipipe_set_irq_gate(vector, __ipipe_std_vector_table[vector]);
+
+#endif	/* CONFIG_X86_LOCAL_APIC */
+
+#ifdef CONFIG_SMP
+
+	for (vector = CALL_FUNCTION_VECTOR; vector < SPURIOUS_APIC_VECTOR;
+	     vector++)
+		__ipipe_set_irq_gate(vector, __ipipe_std_vector_table[vector]);
+
+	__ipipe_set_irq_gate(IPIPE_CRITICAL_VECTOR,
+			     __ipipe_std_vector_table[IPIPE_CRITICAL_VECTOR]);
+
+#endif	/* CONFIG_SMP */
+
+	ipipe_running = 0;
+
+	ipipe_critical_exit(flags);
+
+	printk(KERN_WARNING "I-pipe: Pipelining stopped.\n");
+}
+
+/* ipipe_virtualize_irq_from() -- Attach a handler (and optionally a
+   hw acknowledge routine) to an interrupt for the given domain. */
+
+int ipipe_virtualize_irq_from(struct ipipe_domain *ipd,
+			      unsigned irq,
+			      void (*handler) (unsigned irq),
+			      int (*acknowledge) (unsigned irq),
+			      unsigned modemask)
+{
+	unsigned long flags;
+	int err;
+
+	if (irq >= IPIPE_NR_IRQS)
+		return -EINVAL;
+
+	if (ipd->irqs[irq].control & IPIPE_SYSTEM_MASK)
+		return -EPERM;
+
+	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+
+	if (handler != NULL) {
+
+		if (handler == IPIPE_SAME_HANDLER) {
+			handler = ipd->irqs[irq].handler;
+
+			if (handler == NULL) {
+				err = -EINVAL;
+				goto unlock_and_exit;
+			}
+		} else if ((modemask & IPIPE_EXCLUSIVE_MASK) != 0 &&
+			   ipd->irqs[irq].handler != NULL) {
+			err = -EBUSY;
+			goto unlock_and_exit;
+		}
+
+		if ((modemask & (IPIPE_SHARED_MASK | IPIPE_PASS_MASK)) ==
+		    IPIPE_SHARED_MASK) {
+			err = -EINVAL;
+			goto unlock_and_exit;
+		}
+
+		if ((modemask & IPIPE_STICKY_MASK) != 0)
+			modemask |= IPIPE_HANDLE_MASK;
+	} else
+		modemask &=
+		    ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK |
+		      IPIPE_SHARED_MASK);
+
+	if (acknowledge == NULL) {
+		if ((modemask & IPIPE_SHARED_MASK) == 0)
+			/* Acknowledge handler unspecified -- this is ok in
+			   non-shared management mode, but we will force the use
+			   of the Linux-defined handler instead. */
+			acknowledge = ipipe_root_domain->irqs[irq].acknowledge;
+		else {
+			/* A valid acknowledge handler to be called in shared mode
+			   is required when declaring a shared IRQ. */
+			err = -EINVAL;
+			goto unlock_and_exit;
+		}
+	}
+
+	ipd->irqs[irq].handler = handler;
+	ipd->irqs[irq].acknowledge = acknowledge;
+	ipd->irqs[irq].control = modemask;
+
+	if (irq < NR_IRQS &&
+	    handler != NULL &&
+	    !ipipe_virtual_irq_p(irq) && (modemask & IPIPE_ENABLE_MASK) != 0) {
+		if (ipd != ipipe_current_domain) {
+			/* IRQ enable/disable state is domain-sensitive, so we may
+			   not change it for another domain. What is allowed
+			   however is forcing some domain to handle an interrupt
+			   source, by passing the proper 'ipd' descriptor which
+			   thus may be different from ipipe_current_domain. */
+			err = -EPERM;
+			goto unlock_and_exit;
+		}
+
+		irq_desc[irq].handler->enable(irq);
+	}
+
+	err = 0;
+
+      unlock_and_exit:
+
+	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+
+	return err;
+}
+
+/* ipipe_control_irq() -- Change modes of a pipelined interrupt for
+ * the current domain. */
+
+int ipipe_control_irq(unsigned irq, unsigned clrmask, unsigned setmask)
+{
+	struct ipipe_domain *ipd;
+	unsigned long flags;
+	irq_desc_t *desc;
+
+	if (irq >= IPIPE_NR_IRQS)
+		return -EINVAL;
+
+	ipd = ipipe_current_domain;
+
+	if (ipd->irqs[irq].control & IPIPE_SYSTEM_MASK)
+		return -EPERM;
+
+	if (((setmask | clrmask) & IPIPE_SHARED_MASK) != 0)
+		return -EINVAL;
+
+	desc = irq_desc + irq;
+
+	if (ipd->irqs[irq].handler == NULL)
+		setmask &= ~(IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK);
+
+	if ((setmask & IPIPE_STICKY_MASK) != 0)
+		setmask |= IPIPE_HANDLE_MASK;
+
+	if ((clrmask & (IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK)) != 0)	/* If 
one goes, both go. */
+		clrmask |= (IPIPE_HANDLE_MASK | IPIPE_STICKY_MASK);
+
+	spin_lock_irqsave_hw(&__ipipe_pipelock, flags);
+
+	ipd->irqs[irq].control &= ~clrmask;
+	ipd->irqs[irq].control |= setmask;
+
+	if ((setmask & IPIPE_ENABLE_MASK) != 0)
+		desc->handler->enable(irq);
+	else if ((clrmask & IPIPE_ENABLE_MASK) != 0)
+		desc->handler->disable(irq);
+
+	spin_unlock_irqrestore_hw(&__ipipe_pipelock, flags);
+
+	return 0;
+}
+
+void __ipipe_cleanup_domain(struct ipipe_domain *ipd)
+{
+	ipipe_unstall_pipeline_from(ipd);
+
+#ifdef CONFIG_SMP
+	{
+		int nr_cpus = num_online_cpus(), _cpuid;
+
+		for (_cpuid = 0; _cpuid < nr_cpus; _cpuid++)
+			while (ipd->cpudata[_cpuid].irq_pending_hi != 0)
+				cpu_relax();
+	}
+#endif	/* CONFIG_SMP */
+}
+
+int ipipe_get_sysinfo(struct ipipe_sysinfo *info)
+{
+	info->ncpus = num_online_cpus();
+	info->cpufreq = ipipe_cpu_freq();
+	info->archdep.tmirq = __ipipe_tick_irq;
+#ifdef CONFIG_X86_TSC
+	info->archdep.tmfreq = ipipe_cpu_freq();
+#else	/* !CONFIG_X86_TSC */
+	info->archdep.tmfreq = CLOCK_TICK_RATE;
+#endif	/* CONFIG_X86_TSC */
+
+	return 0;
+}
-- 

Philippe.

