Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSIWCv5>; Sun, 22 Sep 2002 22:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264834AbSIWCvx>; Sun, 22 Sep 2002 22:51:53 -0400
Received: from nameservices.net ([208.234.25.16]:15365 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264807AbSIWCvB>;
	Sun, 22 Sep 2002 22:51:01 -0400
Message-ID: <3D8E837C.50647D3B@opersys.com>
Date: Sun, 22 Sep 2002 22:59:08 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Adeos <adeos-main@mail.freesoftware.fsf.org>,
       Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] Adeos nanokernel for 2.5.38 2/2: i386 code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the i386 specific portion of the nanokernel.

Here are the files added:
 arch/i386/kernel/adeos.c          |  330 ++++++++++++++++++
 arch/i386/kernel/ipipe.c          |  686 ++++++++++++++++++++++++++++++++++++++
 include/asm-i386/adeos.h          |  242 +++++++++++++

Here are the files modified:
 arch/i386/kernel/Makefile         |    3
 arch/i386/kernel/apic.c           |    9
 arch/i386/kernel/bluesmoke.c      |    3
 arch/i386/kernel/entry.S          |  127 ++++++-
 arch/i386/kernel/i386_ksyms.c     |   21 +
 arch/i386/kernel/i8259.c          |   36 +
 arch/i386/kernel/irq.c            |    3
 arch/i386/kernel/process.c        |    3
 arch/i386/kernel/smp.c            |   25 +
 arch/i386/kernel/time.c           |   11
 arch/i386/kernel/traps.c          |   68 +++
 arch/i386/mach-generic/do_timer.h |    9
 arch/i386/mach-visws/do_timer.h   |    9
 arch/i386/mm/fault.c              |    6
 include/asm-i386/system.h         |   49 ++
 18 files changed, 1636 insertions, 4 deletions    

Again, these modifications ensure that Linux plays nice with the other
domains in the ipipe.

diff -urpN linux-2.5.38/arch/i386/kernel/Makefile linux-2.5.38-adeos/arch/i386/kernel/Makefile
--- linux-2.5.38/arch/i386/kernel/Makefile	Sun Sep 22 00:25:02 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/Makefile	Sun Sep 22 21:57:18 2002
@@ -4,7 +4,7 @@
 
 EXTRA_TARGETS := head.o init_task.o
 
-export-objs     := mca.o i386_ksyms.o time.o
+export-objs     := mca.o i386_ksyms.o time.o ipipe.o adeos.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
@@ -26,6 +26,7 @@ obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o n
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
+obj-$(CONFIG_ADEOS)		+= ipipe.o adeos.o
 
 EXTRA_AFLAGS   := -traditional
 
diff -urpN linux-2.5.38/arch/i386/kernel/adeos.c linux-2.5.38-adeos/arch/i386/kernel/adeos.c
--- linux-2.5.38/arch/i386/kernel/adeos.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.38-adeos/arch/i386/kernel/adeos.c	Sun Sep 22 21:57:18 2002
@@ -0,0 +1,330 @@
+/*
+ *   linux/arch/i386/kernel/adeos.c
+ *
+ *   Copyright (C) 2002 Philippe Gerum.
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
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *   This code implements the architecture-dependent ADEOS support.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/errno.h>
+
+#ifdef CONFIG_SMP
+
+static volatile unsigned long adeos_cpu_sync_map;
+
+static volatile unsigned long adeos_cpu_lock_map;
+
+static spinlock_t adeos_cpu_barrier = SPIN_LOCK_UNLOCKED;
+
+static void (*adeos_cpu_sync)(void);
+
+void __adeos_do_critical_sync (unsigned irq)
+
+{
+    ipipe_declare_cpuid;
+
+    set_bit(cpuid,&adeos_cpu_sync_map);
+
+    /* Now we are in sync with the lock requestor running on another
+       CPU. Enter a spinning wait until he releases the global
+       lock. */
+    ipipe_hw_spin_lock_simple(&adeos_cpu_barrier);
+
+    /* Got it. Now get out. */
+
+    if (adeos_cpu_sync)
+	/* Call the sync routine if any. */
+	adeos_cpu_sync();
+
+    ipipe_hw_spin_unlock_simple(&adeos_cpu_barrier);
+
+    clear_bit(cpuid,&adeos_cpu_sync_map);
+}
+
+#endif /* CONFIG_SMP */
+
+void __adeos_bootstrap_domain (adomain_t *adp, adattr_t *attr)
+
+{
+    int estacksz = attr->estacksz > 0 ? attr->estacksz : 8192;
+    int **psp = &adp->esp;
+
+    adp->estackbase = (int *)kmalloc(estacksz,GFP_KERNEL);
+
+    if (adp->estackbase == NULL)
+	panic("no memory for domain entry stack");
+
+    adp->esp = adp->estackbase;
+    **psp = 0;
+    *psp = (int *)(((unsigned long)*psp + estacksz - 0x10) & ~0xf);
+    *--(*psp) = 0;
+    *--(*psp) = (int)attr->entry;
+}
+
+void __adeos_cleanup_domain (adomain_t *adp) {
+
+    kfree(adp->estackbase);
+}
+
+/* __adeos_switch_domain() -- Switch domain contexts. The current
+   domain is switched out while the domain pointed by "adp" is
+   switched in. */
+
+#ifdef CONFIG_SMP
+
+adomain_t **__adeos_get_smp_domain_slot (void) {
+    ipipe_declare_cpuid;
+    return adp_cpu_current + cpuid;
+}
+
+void __adeos_switch_domain (adomain_t *adp)
+
+{
+    __asm__ __volatile__( \
+	"pushl %%edx\n\t" \
+	"pushl %%ecx\n\t" \
+	"pushl %%ebx\n\t" \
+	"pushl %%ebp\n\t" \
+	"pushl %%edi\n\t" \
+	"pushl %%esi\n\t" \
+	  /* Prepare to switch: build a resume frame for the suspended
+	     domain, save it's stack pointer, load the incoming
+	     domain's stack pointer, update the global domain
+	     descriptor pointer, then finally activate the resume
+	     frame of the incoming domain. */
+	"pushl $1f\n\t" \
+	"pushl %%eax\n\t" \
+	"call __adeos_get_smp_domain_slot\n\t" \
+	"popl %%edx\n\t" \
+	"xchg (%%eax), %%edx\n\t" \
+	"movl %%esp, (%%edx)\n\t" \
+	"movl (%%eax), %%eax\n\t" \
+	"movl (%%eax), %%esp\n\t" \
+	"ret\n\t" \
+	  /* Call domain switch hook (if any) */
+"1:	call __adeos_get_smp_domain_slot\n\t" \
+	"movl (%%eax), %%eax\n\t" \
+	"movl 4(%%eax),%%eax\n\t" \
+	"testl %%eax,%%eax\n\t" \
+	"je 2f\n\t" \
+	"call *%%eax\n\t" \
+	  /* Domain resume point */
+"2:	 popl %%esi\n\t" \
+	"popl %%edi\n\t" \
+	"popl %%ebp\n\t" \
+	"popl %%ebx\n\t" \
+	"popl %%ecx\n\t" \
+	"popl %%edx\n\t" \
+	: /* no output */ \
+	: "a" (adp));
+}
+
+#else /* !CONFIG_SMP */
+
+void __adeos_switch_domain (adomain_t *adp)
+
+{
+    __asm__ __volatile__( \
+	"pushl %%edx\n\t" \
+	"pushl %%ecx\n\t" \
+	"pushl %%ebx\n\t" \
+	"pushl %%ebp\n\t" \
+	"pushl %%edi\n\t" \
+	"pushl %%esi\n\t" \
+	  /* Prepare to switch: build a resume frame for the suspended
+	     domain, save it's stack pointer, load the incoming
+	     domain's stack pointer, update the global domain
+	     descriptor pointer, then finally activate the resume
+	     frame of the incoming domain. */
+	"movl adp_cpu_current, %%edx\n\t" \
+	"pushl %%edx\n\t" \
+	"pushl $1f\n\t" \
+	"movl %%esp, (%%edx)\n\t" \
+	"movl (%%eax), %%esp\n\t" \
+	"movl %%eax, adp_cpu_current\n\t" \
+	"ret\n\t" \
+	  /* Call domain switch hook (if any) */
+"1:	 popl %%eax\n\t" \
+	"movl 4(%%eax),%%eax\n\t" \
+	"testl %%eax,%%eax\n\t" \
+	"je 2f\n\t" \
+	"call *%%eax\n\t" \
+	  /* Domain resume point */
+"2:	 popl %%esi\n\t" \
+	"popl %%edi\n\t" \
+	"popl %%ebp\n\t" \
+	"popl %%ebx\n\t" \
+	"popl %%ecx\n\t" \
+	"popl %%edx\n\t" \
+	: /* no output */ \
+        : "a" (adp));
+}
+
+#endif /* CONFIG_SMP */
+
+
+/* __adeos_critical_enter() -- Grab the superlock excluding all CPUs
+   but the current one from a critical section. This lock is used when
+   we must enforce a global critical section for a single CPU in a
+   possibly SMP system whichever context the CPUs are running
+   (i.e. interrupt handler or regular thread). */
+
+unsigned long __adeos_critical_enter (void (*syncfn)(void))
+
+{
+    unsigned long flags;
+
+    ipipe_hw_save_flags_and_cli(flags);
+
+#ifdef CONFIG_SMP
+    if (__adeos_online_cpus > 1) /* We might be running a SMP-kernel on a UP box... */
+	{
+	ipipe_declare_cpuid;
+
+	set_bit(cpuid,&adeos_cpu_lock_map);
+
+	while (test_and_set_bit(31,&adeos_cpu_lock_map))
+	    {
+	    /* Refer to the explanations found in
+	       linux/arch/asm-i386/irq.c about
+	       SUSPECTED_CPU_OR_CHIPSET_BUG_WORKAROUND for more about
+	       this strange loop. */
+	    int n = 0;
+	    do { cpu_relax(); } while (++n < cpuid);
+	    }
+
+	ipipe_hw_spin_lock_simple(&adeos_cpu_barrier);
+
+	adeos_cpu_sync = syncfn;
+
+	/* Send the sync IPI to all processors but the current one. */
+	__adeos_send_IPI_allbutself(ADEOS_CRITICAL_VECTOR);
+
+	while (adeos_cpu_sync_map != (cpu_online_map & ~adeos_cpu_lock_map))
+	    cpu_relax();
+	}
+#endif /* CONFIG_SMP */
+
+    return flags;
+}
+
+/* __adeos_critical_exit() -- Release the superlock. */
+
+void __adeos_critical_exit (unsigned long flags)
+
+{
+#ifdef CONFIG_SMP
+    if (__adeos_online_cpus > 1) /* We might be running a SMP-kernel on a UP box... */
+	{
+	ipipe_declare_cpuid;
+
+	ipipe_hw_spin_unlock_simple(&adeos_cpu_barrier);
+
+	while (adeos_cpu_sync_map != 0)
+	    cpu_relax();
+
+	if (test_and_clear_bit(cpuid,&adeos_cpu_lock_map))
+	    clear_bit(31,&adeos_cpu_lock_map);
+	}
+#endif /* CONFIG_SMP */
+
+    ipipe_hw_restore_flags(flags);
+}
+
+int __adeos_get_sysinfo (adsysinfo_t *info)
+
+{
+#ifdef CONFIG_X86_IO_APIC
+    if (!skip_ioapic_setup && nr_ioapics > 0)
+	info->timer.irq = IO_APIC_VECTOR(0) - FIRST_EXTERNAL_VECTOR;
+    else
+	info->timer.irq = 0;
+#else /* !CONFIG_X86_IO_APIC */
+    info->timer.irq = 0;
+#endif /* CONFIG_X86_IO_APIC */
+
+#ifdef CONFIG_SMP
+    info->ncpus = __adeos_online_cpus;
+#else /* !CONFIG_SMP */
+    info->ncpus = 1;
+#endif /* CONFIG_SMP */
+
+    if (cpu_has_tsc)
+	info->cpufreq = 1000 * cpu_khz;
+    else
+	info->cpufreq = CLOCK_TICK_RATE;
+
+    return 0;
+}
+
+int __adeos_tune_timer (unsigned long ns, int flags)
+
+{
+    unsigned ghz, latch;
+    unsigned long x;
+
+    if (flags & ADEOS_RESET_TIMER)
+	latch = LATCH;
+    else
+	{
+	if (ns < 122071 || ns > (1000 / HZ) * 1000000) /* HZ max, 8khz min */
+	    return -EINVAL;
+
+	ghz = 1000000000 / ns;
+	latch = (CLOCK_TICK_RATE + ghz/2) / ghz;
+	}
+
+    x = __adeos_critical_enter(NULL); /* Sync with all CPUs */
+
+    /* Shamelessly lifted from init_IRQ() in i8259.c */
+    outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
+    outb_p(latch & 0xff,0x40);	/* LSB */
+    outb(latch >> 8,0x40);	/* MSB */
+
+    __adeos_critical_exit(x);
+
+    return 0;
+}
+
+void __adeos_set_root_ptd (int key, void *value) {
+
+    current->ptd[key] = value;
+}
+
+void *__adeos_get_root_ptd (int key) {
+
+    return current->ptd[key];
+}
+
+asmlinkage void __adeos_enter_syscall (struct pt_regs *regs) {
+
+    if (__adeos_event_monitors[ADEOS_SYSCALL_PROLOGUE] > 0)
+	ipipe_handle_event(ADEOS_SYSCALL_PROLOGUE,regs);
+}
+
+asmlinkage void __adeos_exit_syscall (void) {
+
+    if (__adeos_event_monitors[ADEOS_SYSCALL_EPILOGUE] > 0)
+	ipipe_handle_event(ADEOS_SYSCALL_EPILOGUE,NULL);
+}
diff -urpN linux-2.5.38/arch/i386/kernel/apic.c linux-2.5.38-adeos/arch/i386/kernel/apic.c
--- linux-2.5.38/arch/i386/kernel/apic.c	Sun Sep 22 00:25:34 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/apic.c	Sun Sep 22 21:57:18 2002
@@ -1095,7 +1095,10 @@ void smp_apic_timer_interrupt(struct pt_
 	 * NOTE! We'd better ACK the irq immediately,
 	 * because timer handling can be slow.
 	 */
+#ifndef CONFIG_ADEOS
+	/* IRQ acknowledging is in the hands of the IPIPE exclusively. */
 	ack_APIC_irq();
+#endif
 	/*
 	 * update_process_times() expects us to have done irq_enter().
 	 * Besides, if we don't timer interrupts ignore the global
@@ -1120,8 +1123,11 @@ asmlinkage void smp_spurious_interrupt(v
 	 * Spurious interrupts should not be ACKed.
 	 */
 	v = apic_read(APIC_ISR + ((SPURIOUS_APIC_VECTOR & ~0x1f) >> 1));
+#ifndef CONFIG_ADEOS
+	/* IRQ acknowledging is in the hands of the IPIPE exclusively. */
 	if (v & (1 << (SPURIOUS_APIC_VECTOR & 0x1f)))
 		ack_APIC_irq();
+#endif
 
 	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
 	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
@@ -1142,7 +1148,10 @@ asmlinkage void smp_error_interrupt(void
 	v = apic_read(APIC_ESR);
 	apic_write(APIC_ESR, 0);
 	v1 = apic_read(APIC_ESR);
+#ifndef CONFIG_ADEOS
+	/* IRQ acknowledging is in the hands of the IPIPE exclusively. */
 	ack_APIC_irq();
+#endif
 	atomic_inc(&irq_err_count);
 
 	/* Here is what the APIC error bits mean:
diff -urpN linux-2.5.38/arch/i386/kernel/bluesmoke.c linux-2.5.38-adeos/arch/i386/kernel/bluesmoke.c
--- linux-2.5.38/arch/i386/kernel/bluesmoke.c	Sun Sep 22 00:25:05 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/bluesmoke.c	Sun Sep 22 21:57:18 2002
@@ -53,7 +53,10 @@ static void intel_thermal_interrupt(stru
 	u32 l, h;
 	unsigned int cpu = smp_processor_id();
 
+#ifndef CONFIG_ADEOS
+	/* IRQ acknowledging is in the hands of the IPIPE exclusively. */
 	ack_APIC_irq();
+#endif
 
 	rdmsr(MSR_IA32_THERM_STATUS, l, h);
 	if (l & 1) {
diff -urpN linux-2.5.38/arch/i386/kernel/entry.S linux-2.5.38-adeos/arch/i386/kernel/entry.S
--- linux-2.5.38/arch/i386/kernel/entry.S	Sun Sep 22 00:25:04 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/entry.S	Sun Sep 22 21:57:18 2002
@@ -71,7 +71,11 @@ NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
 #ifdef CONFIG_PREEMPT
+#ifdef CONFIG_ADEOS
+#define preempt_stop		call adeos_stall_ipipe
+#else /* !CONFIG_ADEOS */
 #define preempt_stop		cli
+#endif /* CONFIG_ADEOS */
 #else
 #define preempt_stop
 #define resume_kernel		restore_all
@@ -128,6 +132,12 @@ ENTRY(lcall7)
 				# gates, which has to be cleaned up later..
 	pushl %eax
 	SAVE_ALL
+#ifdef CONFIG_ADEOS
+	movl %esp,%eax		# Use a "soon-to-be-clobbered" reg
+	pushl %eax
+	call __adeos_enter_syscall
+	addl $4,%esp
+#endif /* CONFIG_ADEOS */
 	movl EIP(%esp), %eax	# due to call gates, this is eflags, not eip..
 	movl CS(%esp), %edx	# this is eip..
 	movl EFLAGS(%esp), %ecx	# and this is cs..
@@ -142,6 +152,9 @@ ENTRY(lcall7)
 	pushl $0x7
 	call *%edx
 	addl $4, %esp
+#ifdef CONFIG_ADEOS
+	call __adeos_exit_syscall
+#endif /* CONFIG_ADEOS */
 	popl %eax
 	jmp resume_userspace
 
@@ -150,6 +163,12 @@ ENTRY(lcall27)
 				# gates, which has to be cleaned up later..
 	pushl %eax
 	SAVE_ALL
+#ifdef CONFIG_ADEOS
+	movl %esp,%eax		# Use a "soon-to-be-clobbered" reg
+	pushl %eax
+	call __adeos_enter_syscall
+	addl $4,%esp
+#endif /* CONFIG_ADEOS */
 	movl EIP(%esp), %eax	# due to call gates, this is eflags, not eip..
 	movl CS(%esp), %edx	# this is eip..
 	movl EFLAGS(%esp), %ecx	# and this is cs..
@@ -164,11 +183,17 @@ ENTRY(lcall27)
 	pushl $0x27
 	call *%edx
 	addl $4, %esp
+#ifdef CONFIG_ADEOS
+	call __adeos_exit_syscall
+#endif /* CONFIG_ADEOS */
 	popl %eax
 	jmp resume_userspace
 
 
 ENTRY(ret_from_fork)
+#ifdef CONFIG_ADEOS
+	sti	# The pipeline is still stalled however.
+#endif /* CONFIG_ADEOS */	
 #if CONFIG_SMP || CONFIG_PREEMPT
 	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
@@ -187,6 +212,9 @@ ENTRY(ret_from_fork)
 	ALIGN
 ret_from_exception:
 	preempt_stop
+#ifdef CONFIG_ADEOS
+	/* FIXME: Set marker */
+#endif /* CONFIG_ADEOS */
 ret_from_intr:
 	GET_THREAD_INFO(%ebx)
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
@@ -194,14 +222,22 @@ ret_from_intr:
 	testl $(VM_MASK | 3), %eax
 	jz resume_kernel		# returning to kernel or vm86-space
 ENTRY(resume_userspace)
- 	cli				# make sure we don't miss an interrupt
+#ifdef CONFIG_ADEOS
+	call adeos_stall_ipipe
+#else /* !CONFIG_ADEOS */
+	cli				# make sure we don't miss an interrupt
+#endif /* CONFIG_ADEOS */
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_FLAGS(%ebx), %ecx
 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done on
 					# int/exception return?
 	jne work_pending
+#ifdef CONFIG_ADEOS
+	jmp unstall_and_restore_all
+#else /* !CONFIG_ADEOS */
 	jmp restore_all
+#endif /* CONFIG_ADEOS */
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
@@ -211,13 +247,21 @@ need_resched:
 	movl TI_FLAGS(%ebx), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
-	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (execption path) ?
+	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (execption path) ? ADEOS FIXME: Test marker
 	jz restore_all
 	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebx)
+#ifdef CONFIG_ADEOS
+	call adeos_unstall_ipipe
+#else /* !CONFIG_ADEOS */
 	sti
+#endif /* CONFIG_ADEOS */
 	call schedule
 	movl $0,TI_PRE_COUNT(%ebx) 
+#ifdef CONFIG_ADEOS
+	call adeos_stall_ipipe
+#else /* !CONFIG_ADEOS */
 	cli
+#endif /* CONFIG_ADEOS */
 	jmp need_resched
 #endif
 
@@ -226,6 +270,14 @@ need_resched:
 ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
+#ifdef CONFIG_ADEOS
+	pushl %eax
+	movl %esp,%ebx			# Use a "soon-to-be-clobbered" reg
+	pushl %ebx
+	call __adeos_enter_syscall
+	addl $4,%esp
+	popl  %eax
+#endif /* CONFIG_ADEOS */
 	GET_THREAD_INFO(%ebx)
 	cmpl $(NR_syscalls), %eax
 	jae syscall_badsys
@@ -235,13 +287,24 @@ ENTRY(system_call)
 syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
+#ifdef CONFIG_ADEOS
+	call __adeos_exit_syscall
+#endif /* CONFIG_ADEOS */
 syscall_exit:
+#ifdef CONFIG_ADEOS
+	call adeos_stall_ipipe
+#else /* !CONFIG_ADEOS */
 	cli				# make sure we don't miss an interrupt
+#endif /* CONFIG_ADEOS */
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_FLAGS(%ebx), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
+#ifdef CONFIG_ADEOS
+unstall_and_restore_all:
+	call adeos_unstall_ipipe
+#endif /* CONFIG_ADEOS */
 restore_all:
 	RESTORE_ALL
 
@@ -252,13 +315,21 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
+#ifdef CONFIG_ADEOS
+	call adeos_stall_ipipe
+#else /* !CONFIG_ADEOS */
 	cli				# make sure we don't miss an interrupt
+#endif /* CONFIG_ADEOS */
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_FLAGS(%ebx), %ecx
 	andl $_TIF_WORK_MASK, %ecx	# is there any work to be done other
 					# than syscall tracing?
+#ifdef CONFIG_ADEOS
+	jz unstall_and_restore_all
+#else /* !CONFIG_ADEOS */
 	jz restore_all
+#endif /* CONFIG_ADEOS */
 	testb $_TIF_NEED_RESCHED, %cl
 	jnz work_resched
 
@@ -270,7 +341,11 @@ work_notifysig:				# deal with pending s
 					# vm86-space
 	xorl %edx, %edx
 	call do_notify_resume
+#ifdef CONFIG_ADEOS
+	jmp unstall_and_restore_all
+#else /* !CONFIG_ADEOS */
 	jmp restore_all
+#endif /* CONFIG_ADEOS */
 
 	ALIGN
 work_notifysig_v86:
@@ -280,7 +355,11 @@ work_notifysig_v86:
 	movl %eax, %esp
 	xorl %edx, %edx
 	call do_notify_resume
+#ifdef CONFIG_ADEOS
+	jmp unstall_and_restore_all
+#else /* !CONFIG_ADEOS */
 	jmp restore_all
+#endif /* CONFIG_ADEOS */
 
 	# perform syscall exit tracing
 	ALIGN
@@ -299,7 +378,11 @@ syscall_trace_entry:
 syscall_exit_work:
 	testb $_TIF_SYSCALL_TRACE, %cl
 	jz work_pending
+#ifdef CONFIG_ADEOS
+	call adeos_unstall_ipipe
+#else /* !CONFIG_ADEOS */
 	sti				# could let do_syscall_trace() call
+#endif /* CONFIG_ADEOS */
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -347,6 +430,46 @@ ENTRY(name)				\
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
 
+#ifdef CONFIG_ADEOS
+
+.data
+ENTRY(ipipe_irq_trampolines)
+.text
+
+vector=0
+ENTRY(ipipe_irq_entries)
+.rept NR_IRQS
+	ALIGN
+1:	pushl $vector-256
+	jmp ipipe_irq_common
+.data
+	.long 1b
+.text
+vector=vector+1
+.endr
+
+	ALIGN
+ipipe_irq_common:
+	SAVE_ALL
+	call ipipe_handle_irq
+	testl %eax,%eax
+	jnz  1f
+	popl %ebx
+	popl %ecx
+	popl %edx
+	popl %esi
+	popl %edi
+	popl %ebp
+	popl %eax
+	popl %ds
+	popl %es
+	addl $4, %esp
+	iret
+1:	GET_THREAD_INFO(%ebx)
+        jmp ret_from_intr
+
+#endif /* !CONFIG_ADEOS */
+	
 ENTRY(divide_error)
 	pushl $0			# no error code
 	pushl $do_divide_error
diff -urpN linux-2.5.38/arch/i386/kernel/i386_ksyms.c linux-2.5.38-adeos/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.38/arch/i386/kernel/i386_ksyms.c	Sun Sep 22 00:25:09 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/i386_ksyms.c	Sun Sep 22 21:57:18 2002
@@ -176,3 +176,24 @@ extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+ 
+#ifdef CONFIG_ADEOS
+EXPORT_SYMBOL(ipipe_sync_irqs);
+/* The following are per-platform convenience exports which might be
+   needed by some Adeos domains loaded as kernel modules. */
+extern irq_desc_t irq_desc[];
+EXPORT_SYMBOL(irq_desc);
+extern struct desc_struct idt_table[];
+EXPORT_SYMBOL(idt_table);
+extern struct tty_driver console_driver;
+EXPORT_SYMBOL(console_driver);
+extern void (*kd_mksound)(unsigned int hz, unsigned int ticks);
+EXPORT_SYMBOL(kd_mksound);
+#ifdef CONFIG_SMP
+#ifdef CONFIG_MULTIQUAD
+EXPORT_SYMBOL(logical_apicid_2_cpu);
+#else
+EXPORT_SYMBOL(physical_apicid_2_cpu);
+#endif /* CONFIG_MULTIQUAD */
+#endif /* CONFIG_SMP */
+#endif /* CONFIG_ADEOS */
diff -urpN linux-2.5.38/arch/i386/kernel/i8259.c linux-2.5.38-adeos/arch/i386/kernel/i8259.c
--- linux-2.5.38/arch/i386/kernel/i8259.c	Sun Sep 22 00:25:25 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/i8259.c	Sun Sep 22 21:57:18 2002
@@ -93,13 +93,21 @@ void disable_8259A_irq(unsigned int irq)
 	unsigned int mask = 1 << irq;
 	unsigned long flags;
 
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_lock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_lock_irqsave(&i8259A_lock, flags);
+#endif /* CONFIG_ADEOS */
 	cached_irq_mask |= mask;
 	if (irq & 8)
 		outb(cached_A1,0xA1);
 	else
 		outb(cached_21,0x21);
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_unlock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_unlock_irqrestore(&i8259A_lock, flags);
+#endif /* CONFIG_ADEOS */
 }
 
 void enable_8259A_irq(unsigned int irq)
@@ -107,13 +115,21 @@ void enable_8259A_irq(unsigned int irq)
 	unsigned int mask = ~(1 << irq);
 	unsigned long flags;
 
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_lock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_lock_irqsave(&i8259A_lock, flags);
+#endif /* CONFIG_ADEOS */
 	cached_irq_mask &= mask;
 	if (irq & 8)
 		outb(cached_A1,0xA1);
 	else
 		outb(cached_21,0x21);
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_unlock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_unlock_irqrestore(&i8259A_lock, flags);
+#endif /* CONFIG_ADEOS */
 }
 
 int i8259A_irq_pending(unsigned int irq)
@@ -122,12 +138,20 @@ int i8259A_irq_pending(unsigned int irq)
 	unsigned long flags;
 	int ret;
 
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_lock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_lock_irqsave(&i8259A_lock, flags);
+#endif /* CONFIG_ADEOS */
 	if (irq < 8)
 		ret = inb(0x20) & mask;
 	else
 		ret = inb(0xA0) & (mask >> 8);
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_unlock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_unlock_irqrestore(&i8259A_lock, flags);
+#endif /* CONFIG_ADEOS */
 
 	return ret;
 }
@@ -196,12 +220,16 @@ void mask_and_ack_8259A(unsigned int irq
 
 handle_real_irq:
 	if (irq & 8) {
+#ifndef CONFIG_ADEOS
 		inb(0xA1);		/* DUMMY - (do we need this?) */
+#endif
 		outb(cached_A1,0xA1);
 		outb(0x60+(irq&7),0xA0);/* 'Specific EOI' to slave */
 		outb(0x62,0x20);	/* 'Specific EOI' to master-IRQ2 */
 	} else {
+#ifndef CONFIG_ADEOS
 		inb(0x21);		/* DUMMY - (do we need this?) */
+#endif
 		outb(cached_21,0x21);
 		outb(0x60+irq,0x20);	/* 'Specific EOI' to master */
 	}
@@ -267,7 +295,11 @@ void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_lock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_lock_irqsave(&i8259A_lock, flags);
+#endif /* CONFIG_ADEOS */
 
 	outb(0xff, 0x21);	/* mask all of 8259A-1 */
 	outb(0xff, 0xA1);	/* mask all of 8259A-2 */
@@ -303,7 +335,11 @@ void init_8259A(int auto_eoi)
 	outb(cached_21, 0x21);	/* restore master IRQ mask */
 	outb(cached_A1, 0xA1);	/* restore slave IRQ mask */
 
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_unlock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_unlock_irqrestore(&i8259A_lock, flags);
+#endif /* CONFIG_ADEOS */
 }
 
 /*
diff -urpN linux-2.5.38/arch/i386/kernel/ipipe.c linux-2.5.38-adeos/arch/i386/kernel/ipipe.c
--- linux-2.5.38/arch/i386/kernel/ipipe.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.38-adeos/arch/i386/kernel/ipipe.c	Sun Sep 22 21:57:18 2002
@@ -0,0 +1,686 @@
+/*
+ *   linux/arch/i386/kernel/ipipe.c
+ *
+ *   Copyright (C) 2002 Philippe Gerum.
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
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *   This code implements the ADEOS interrupt pipeline mechanism.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/irq.h>
+#include <asm/system.h>
+#include <asm/hw_irq.h>
+#include <asm/irq.h>
+#include <asm/desc.h>
+#include <asm/errno.h>
+#include <asm/segment.h>
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/fixmap.h>
+#include <asm/bitops.h>
+#include <asm/mpspec.h>
+#ifdef CONFIG_X86_IO_APIC
+#include <asm/io_apic.h>
+#endif /* CONFIG_X86_IO_APIC */
+#include <asm/apic.h>
+#endif /* CONFIG_X86_LOCAL_APIC */
+
+extern struct desc_struct idt_table[];
+
+extern spinlock_t adeos_pipelock;
+
+extern struct list_head adeos_pipeline;
+
+/* Lifted from traps.c */ 
+#define ipipe_set_gate(gate_addr,type,dpl,addr)  \
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
+#define ipipe_set_irq_gate(vector,addr) \
+ipipe_set_gate(idt_table+vector,14,0,addr)
+
+#define ipipe_set_irq_bit(adp,cpuid,irq) \
+do { \
+    set_bit(irq & 0x1f,&(adp)->cpudata[cpuid].irq_pending_lo[irq >> 5]); \
+    set_bit(irq >> 5,&(adp)->cpudata[cpuid].irq_pending_hi); \
+} while(0)
+
+extern void (*ipipe_irq_trampolines[])(void); /* in entry.S now */
+
+#define ipipe_call_asm_irq_handler(adp,irq) \
+   __asm__ __volatile__ ("pushfl\n\t" \
+                         "push %%cs\n\t" \
+                         "call *%1\n" \
+			 : /* no output */ \
+			 : "a" (irq), "m" ((adp)->irqs[irq].handler))
+
+#define ipipe_call_c_irq_handler(adp,irq) \
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
+			 : "a" (irq), "m" ((adp)->irqs[irq].handler))
+
+static unsigned long ipipe_virtual_irq_map;
+
+static __inline__ unsigned long ffnz (unsigned long word) {
+    /* Derived from bitops.h's ffs() */
+    __asm__("bsfl %1, %0"
+	    : "=r" (word)
+	    : "r"  (word));
+    return word;
+}
+
+/* ipipe_sync_irqs() -- Flush the pending IRQs for the current domain
+   (and processor).  This routine flushes the interrupt log (see
+   "Optimistic interrupt protection" from D. Stodolsky et al. for more
+   on the deferred interrupt mecanism). Every interrupt that occurred
+   while the pipeline was stalled gets played. */
+
+void ipipe_sync_irqs (void)
+
+{
+    unsigned long mask, submask;
+    struct adcpudata *cpudata;
+    ipipe_declare_cpuid;
+    int level, rank;
+    adomain_t *adp;
+    unsigned irq;
+
+    adp = adp_cpu_current[cpuid];
+    cpudata = &adp->cpudata[cpuid];
+
+    do
+	{
+	if (test_and_set_bit(IPIPE_SYNC_FLAG,&cpudata->status))
+	    return;
+
+	set_bit(IPIPE_STALL_FLAG,&cpudata->status);
+
+	/* In order to update the pending irq mask atomically without
+	   fiddling with the processor interrupt state, the irq flag
+	   is first cleared, then reasserted if it appears that not
+	   all hits have been processed yet. */
+
+	while ((mask = cpudata->irq_pending_hi) != 0)
+	    {
+	    level = ffnz(mask);
+	    clear_bit(level,&cpudata->irq_pending_hi);
+
+	    while ((submask = cpudata->irq_pending_lo[level]) != 0)
+		{
+		rank = ffnz(submask);
+		clear_bit(rank,&cpudata->irq_pending_lo[level]);
+		irq = (level << 5) + rank;
+
+		if (!atomic_dec_and_test(&cpudata->irq_hits[irq]))
+		    {
+		    set_bit(rank,&cpudata->irq_pending_lo[level]);
+		    set_bit(level,&cpudata->irq_pending_hi);
+		    }
+
+		/* Allow the sync routine to be recursively called on
+		   behalf of the IRQ handler or even reentered on
+		   behalf of another execution context switched in by
+		   the IRQ handler. The latter also means that
+		   returning from the switched out context is always
+		   safe even if the sync routine has been reentered in
+		   the meantime. */
+
+		clear_bit(IPIPE_SYNC_FLAG,&cpudata->status);
+
+		if (test_bit(IPIPE_CALLASM_FLAG,&adp->irqs[irq].control))
+		    ipipe_call_asm_irq_handler(adp,irq);
+		else
+		    ipipe_call_c_irq_handler(adp,irq);
+
+#ifdef CONFIG_SMP
+		/* If the execution context on entry has migrated to
+		   another CPU, exit immediately and let the initial
+		   CPU rerun the sync routine in its own context when
+		   it sees fit (which it might be currently doing in
+		   parallel to this CPU, who knows). */
+
+		if (cpuid != adeos_processor_id())
+		    {
+		    clear_bit(IPIPE_STALL_FLAG,&cpudata->status);
+		    return;
+		    }
+#endif /* CONFIG_SMP */
+
+		if (test_and_set_bit(IPIPE_SYNC_FLAG,&cpudata->status))
+		    return;
+		}
+	    }
+
+	clear_bit(IPIPE_STALL_FLAG,&cpudata->status);
+	clear_bit(IPIPE_SYNC_FLAG,&cpudata->status);
+	}
+    while (cpudata->irq_pending_hi != 0);
+}
+
+int ipipe_ack_common_irq (unsigned irq)
+
+{
+    irq_desc_t *desc = irq_desc + irq;
+    desc->handler->ack(irq);
+    return 1;
+}
+
+int ipipe_ack_apic_irq (unsigned irq) {
+#ifdef CONFIG_X86_LOCAL_APIC
+    ack_APIC_irq();
+#endif
+    return 1;
+}
+
+/* ipipe_handle_irq() -- ADEOS' generic IRQ handler. An optimistic
+   interrupt protection log is maintained here for each domain. */
+
+int ipipe_handle_irq (struct pt_regs regs)
+
+{
+    unsigned irq = regs.orig_eax & 0xff;
+    int acked = regs.orig_eax >= 0;
+    struct list_head *pos;
+    ipipe_declare_cpuid;
+
+    /* First ack, then propagate the interrupt to each domain's log. */
+
+    list_for_each(pos,&adeos_pipeline) {
+
+    	adomain_t *_adp = list_entry(pos,adomain_t,link);
+
+	/* For each domain handling the incoming IRQ, mark it as
+           pending in its log. */
+
+	if (test_bit(IPIPE_HANDLE_FLAG,&_adp->irqs[irq].control))
+	    {
+	    /* Domains that handle this IRQ are polled for
+	       acknowledging it by decreasing priority order. */
+
+	    if (!acked)
+		acked = _adp->irqs[irq].acknowledge(irq);
+
+	    atomic_inc(&_adp->cpudata[cpuid].irq_hits[irq]);
+	    ipipe_set_irq_bit(_adp,cpuid,irq);
+	    }
+
+	/* If the domain does not want the IRQ to be passed down the
+	   interrupt pipe, exit the loop now. */
+
+	if (!test_bit(IPIPE_PASS_FLAG,&_adp->irqs[irq].control))
+	    break;
+    }
+
+    /* Now walk the pipeline, yielding control to the highest priority
+       domain that has pending interrupt(s). This search does not go
+       beyond the current domain in the pipeline. To understand this
+       code properly, one must keep in mind that domains having a
+       higher priority than the current one are sleeping on the
+       adeos_suspend_domain() service. In addition, domains having a
+       lower priority have been preempted by an interrupt dispatched
+       to a more prioritary domain. Once the first and most prioritary
+       stage has been selected here, the subsequent stages will be
+       activated in turn when each visited domain calls
+       adeos_suspend_domain() to wake up its neighbour down the
+       pipeline. */
+
+    list_for_each(pos,&adeos_pipeline) {
+
+    	adomain_t *_adp = list_entry(pos,adomain_t,link);
+
+	if (test_bit(IPIPE_STALL_FLAG,&_adp->cpudata[cpuid].status))
+	    break; /* Stalled stage -- do not go further. */
+
+	if (_adp->cpudata[cpuid].irq_pending_hi != 0)
+	    {
+	    /* Since the critical IPI might be serviced by the
+	       following actions, the current domain might not be
+	       linked to the pipeline anymore after its handler
+	       returns on SMP boxes, even if the domain remains valid
+	       (see adeos_unregister_domain()), so don't make any
+	       hazardous assumptions here. */
+
+	    if (_adp == adp_cpu_current[cpuid])
+		ipipe_sync_irqs();
+	    else
+		{
+		__adeos_switch_domain(_adp);
+		ipipe_reload_cpuid(); /* Processor might have changed. */
+		}
+
+	    break;
+	    }
+	else if (_adp == adp_cpu_current[cpuid])
+	    break;
+    }
+
+    return (adp_cpu_current[cpuid] == adp_root &&
+	    !test_bit(IPIPE_STALL_FLAG,&adp_root->cpudata[cpuid].status));
+}
+
+int ipipe_hook_irq (unsigned irq,
+		    void (*handler)(unsigned irq),
+		    int (*acknowledge)(unsigned irq),
+		    unsigned modemask)
+{
+    unsigned long flags;
+
+    ipipe_hw_spin_lock(&adeos_pipelock,flags);
+
+    if (handler != NULL)
+	{
+	if ((modemask & IPIPE_EXCLUSIVE_MASK) != 0)
+	    {
+	    if (adp_current->irqs[irq].handler != NULL)
+		return -EBUSY;
+	    }
+	}
+    else
+	modemask &= ~IPIPE_HANDLE_MASK;
+
+    if (acknowledge == NULL)
+	acknowledge = adp_root->irqs[irq].acknowledge;
+
+    adp_current->irqs[irq].handler = handler;
+    adp_current->irqs[irq].acknowledge = acknowledge;
+    adp_current->irqs[irq].control = modemask;
+
+    if (!ipipe_virtual_irq_p(irq) && handler != NULL)
+	{
+	irq_desc_t *desc = irq_desc + irq;
+
+	ipipe_set_irq_gate(irq + FIRST_EXTERNAL_VECTOR,
+			   ipipe_irq_trampolines[irq]);
+
+	if ((modemask & IPIPE_ENABLE_MASK) != 0)
+	    desc->handler->enable(irq);
+	}
+
+    ipipe_hw_spin_unlock(&adeos_pipelock,flags);
+
+    return 0;
+}
+
+int ipipe_control_irq (unsigned irq,
+		       unsigned clrmask,
+		       unsigned setmask)
+{
+    irq_desc_t *desc = irq_desc + irq;
+    unsigned long flags;
+
+    ipipe_hw_spin_lock(&adeos_pipelock,flags);
+
+    if (adp_current->irqs[irq].handler == NULL)
+	setmask &= ~IPIPE_HANDLE_MASK;
+
+    adp_current->irqs[irq].control &= ~clrmask;
+    adp_current->irqs[irq].control |= setmask;
+
+    if ((setmask & IPIPE_ENABLE_MASK) != 0)
+	desc->handler->enable(irq);
+    else if ((clrmask & IPIPE_ENABLE_MASK) != 0)
+	desc->handler->disable(irq);
+
+    ipipe_hw_spin_unlock(&adeos_pipelock,flags);
+
+    return 0;
+}
+
+int ipipe_propagate_irq (unsigned irq)
+
+{
+    struct list_head *ln;
+    unsigned long flags;
+    ipipe_declare_cpuid;
+
+    ipipe_hw_spin_lock(&adeos_pipelock,flags);
+
+    ln = adp_current->link.next;
+
+    while (ln != &adeos_pipeline)
+	{
+	adomain_t *adp = list_entry(ln,adomain_t,link);
+
+	if (test_bit(IPIPE_HANDLE_FLAG,&adp->irqs[irq].control))
+	    {
+	    atomic_inc(&adp->cpudata[cpuid].irq_hits[irq]);
+	    ipipe_set_irq_bit(adp,cpuid,irq);
+	    ipipe_hw_spin_unlock(&adeos_pipelock,flags);
+	    return 1;
+	    }
+
+	ln = adp->link.next;
+	}
+
+    ipipe_hw_spin_unlock(&adeos_pipelock,flags);
+
+    return 0;
+}
+
+unsigned ipipe_alloc_irq (void)
+
+{
+    unsigned long flags, irq = 0;
+    int ipos;
+
+    ipipe_hw_spin_lock(&adeos_pipelock,flags);
+
+    if (ipipe_virtual_irq_map != ~0)
+	{
+	ipos = ffz(ipipe_virtual_irq_map);
+	set_bit(ipos,&ipipe_virtual_irq_map);
+	irq = ipos + IPIPE_VIRQ_BASE;
+	}
+
+    ipipe_hw_spin_unlock(&adeos_pipelock,flags);
+
+    return irq;
+}
+
+void ipipe_free_irq (unsigned irq)
+
+{
+    int ipos = irq - IPIPE_VIRQ_BASE;
+    clear_bit(ipos,&ipipe_virtual_irq_map);
+}
+
+int ipipe_trigger_irq (unsigned irq)
+
+{
+    struct pt_regs regs;
+
+    if (ipipe_virtual_irq_p(irq) &&
+	!test_bit(irq - IPIPE_VIRQ_BASE,&ipipe_virtual_irq_map))
+	return -EINVAL;
+
+    regs.orig_eax = irq; /* Won't be acked */
+    return ipipe_handle_irq(regs);
+}
+
+int ipipe_trigger_ipi (int _cpuid)
+
+{
+#ifdef CONFIG_SMP
+    ipipe_declare_cpuid;
+
+    if (_cpuid == cpuid) /* Self-posting the service interrupt? */
+	ipipe_trigger_irq(ADEOS_SERVICE_IPI);
+    else
+	{
+	unsigned long flags = adeos_test_and_stall_ipipe();
+
+	if (cpuid == ADEOS_OTHER_CPUS)
+	    {
+	    if (__adeos_online_cpus > 1)
+		/* Send the service IPI to all processors but the current one. */
+		__adeos_send_IPI_allbutself(ADEOS_SERVICE_VECTOR);
+	    }
+	else if (_cpuid >= 0 && _cpuid < __adeos_online_cpus)
+	    __adeos_send_IPI_other(_cpuid,ADEOS_SERVICE_VECTOR);
+
+	adeos_restore_ipipe(flags);
+	}
+
+    return cpuid != ADEOS_OTHER_CPUS ? 1 : __adeos_online_cpus - 1;
+#else  /* !CONFIG_SMP */
+    return 0;
+#endif /* CONFIG_SMP */
+}
+
+void ipipe_init_stage (adomain_t *adp)
+
+{
+    int cpuid, n;
+
+    for (cpuid = 0; cpuid < ADEOS_NR_CPUS; cpuid++)
+	{
+	adp->cpudata[cpuid].irq_pending_hi = 0;
+
+	for (n = 0; n < IPIPE_IRQ_IWORDS; n++)
+	    adp->cpudata[cpuid].irq_pending_lo[n] = 0;
+
+	for (n = 0; n < IPIPE_NR_IRQS; n++)
+	    atomic_set(&adp->cpudata[cpuid].irq_hits[n],0);
+	}
+
+    for (n = 0; n < IPIPE_NR_IRQS; n++)
+	{
+	adp->irqs[n].acknowledge = NULL;
+	adp->irqs[n].handler = NULL;
+	adp->irqs[n].control = IPIPE_PASS_MASK;	/* Pass but don't handle */
+	}
+
+#ifdef CONFIG_SMP
+    ipipe_hook_irq(ADEOS_CRITICAL_IPI,
+		   &__adeos_do_critical_sync,
+		   &ipipe_ack_apic_irq,
+		   IPIPE_HANDLE_MASK);	/* Handle but *never* pass */
+#endif /* CONFIG_SMP */
+}
+
+#define BUILD_TRAP_PROTO(trapnr)  ipipe_trap_##trapnr(void)
+
+#define BUILD_TRAP_ERRCODE(trapnr) \
+asmlinkage void BUILD_TRAP_PROTO(trapnr); \
+__asm__ ( \
+	"\n" __ALIGN_STR"\n\t" \
+        "ipipe_trap_" #trapnr ":\n\t" \
+        "cld\n\t" \
+        "pushl %es\n\t" \
+        "pushl %ds\n\t" \
+        "pushl %eax\n\t" \
+        "pushl %ebp\n\t" \
+        "pushl %edi\n\t" \
+        "pushl %esi\n\t" \
+        "pushl %edx\n\t" \
+        "pushl %ecx\n\t" \
+        "pushl %ebx\n\t" \
+	"movl $"STR(__KERNEL_DS)",%edx\n\t" \
+	"mov %dx,%ds\n\t" \
+	"mov %dx,%es\n\t" \
+        "movl (__adeos_event_monitors + 4 * " #trapnr "),%eax\n\t" \
+	"testl %eax,%eax\n\t" \
+	"jz 1f\n\t" \
+	"movl %esp,%eax\n\t" \
+        "pushl %eax\n\t" \
+	"pushl $"#trapnr"\n\t" \
+        "call ipipe_handle_event\n\t" \
+	"addl $8,%esp\n\t" \
+	"testl %eax,%eax\n\t" \
+"1:      popl %ebx\n\t" \
+        "popl %ecx\n\t" \
+	"popl %edx\n\t" \
+        "popl %esi\n\t" \
+        "popl %edi\n\t" \
+	"popl %ebp\n\t" \
+	"jz 2f\n\t" \
+	"popl %eax\n\t" \
+	"popl %ds\n\t" \
+	"popl %es\n\t" \
+	"addl $4,%esp\n\t" \
+	"iret\n" \
+"2:      movl (ipipe_root_traps + 4 * " #trapnr "),%eax\n\t" \
+	"movl 8(%esp),%es\n\t" \
+	"movl %eax,8(%esp)\n\t" \
+	"popl %eax\n\t" \
+	"popl %ds\n\t" \
+	"ret\n");
+
+#define BUILD_TRAP_NOERRCODE(trapnr) \
+asmlinkage void BUILD_TRAP_PROTO(trapnr); \
+__asm__ ( \
+	"\n" __ALIGN_STR"\n\t" \
+        "ipipe_trap_" #trapnr ":\n\t" \
+        "cld\n\t" \
+        "pushl $0\n\t" \
+        "pushl %es\n\t" \
+        "pushl %ds\n\t" \
+        "pushl %eax\n\t" \
+        "pushl %ebp\n\t" \
+        "pushl %edi\n\t" \
+        "pushl %esi\n\t" \
+        "pushl %edx\n\t" \
+        "pushl %ecx\n\t" \
+        "pushl %ebx\n\t" \
+	"movl $"STR(__KERNEL_DS)",%edx\n\t" \
+	"mov %dx,%ds\n\t" \
+	"mov %dx,%es\n\t" \
+        "movl (__adeos_event_monitors + 4 * " #trapnr "),%eax\n\t" \
+	"testl %eax,%eax\n\t" \
+	"jz 1f\n\t" \
+	"movl %esp,%eax\n\t" \
+        "pushl %eax\n\t" \
+	"pushl $"#trapnr"\n\t" \
+        "call ipipe_handle_event\n\t" \
+	"addl $8,%esp\n\t" \
+	"testl %eax,%eax\n\t" \
+"1:      popl %ebx\n\t" \
+        "popl %ecx\n\t" \
+	"popl %edx\n\t" \
+        "popl %esi\n\t" \
+        "popl %edi\n\t" \
+	"popl %ebp\n\t" \
+	"jz 2f\n\t" \
+	"popl %eax\n\t" \
+	"popl %ds\n\t" \
+	"popl %es\n\t" \
+	"addl $4,%esp\n\t" \
+	"iret\n" \
+"2:      movl (ipipe_root_traps + 4 * " #trapnr "),%eax\n\t" \
+	"movl %eax,12(%esp)\n\t" \
+	"popl %eax\n\t" \
+	"popl %ds\n\t" \
+	"popl %es\n\t" \
+	"ret\n");
+
+void (*ipipe_root_traps[ADEOS_NR_FAULTS])(void);
+
+BUILD_TRAP_NOERRCODE(0x0)   BUILD_TRAP_NOERRCODE(0x1)   BUILD_TRAP_NOERRCODE(0x2)
+BUILD_TRAP_NOERRCODE(0x3)   BUILD_TRAP_NOERRCODE(0x4)   BUILD_TRAP_NOERRCODE(0x5)
+BUILD_TRAP_NOERRCODE(0x6)   BUILD_TRAP_NOERRCODE(0x7)   BUILD_TRAP_ERRCODE(0x8)
+BUILD_TRAP_NOERRCODE(0x9)   BUILD_TRAP_ERRCODE(0xa)     BUILD_TRAP_ERRCODE(0xb)
+BUILD_TRAP_ERRCODE(0xc)     BUILD_TRAP_ERRCODE(0xd)     BUILD_TRAP_ERRCODE(0xe)
+BUILD_TRAP_NOERRCODE(0xf)   BUILD_TRAP_NOERRCODE(0x10)  BUILD_TRAP_ERRCODE(0x11)
+BUILD_TRAP_NOERRCODE(0x12)  BUILD_TRAP_NOERRCODE(0x13)  BUILD_TRAP_ERRCODE(0x14)
+BUILD_TRAP_ERRCODE(0x15)    BUILD_TRAP_ERRCODE(0x16)    BUILD_TRAP_ERRCODE(0x17)
+BUILD_TRAP_ERRCODE(0x18)    BUILD_TRAP_ERRCODE(0x19)    BUILD_TRAP_ERRCODE(0x1a)
+BUILD_TRAP_ERRCODE(0x1b)    BUILD_TRAP_ERRCODE(0x1c)    BUILD_TRAP_ERRCODE(0x1d)
+BUILD_TRAP_ERRCODE(0x1e)    BUILD_TRAP_ERRCODE(0x1f)
+
+#define LIST_TRAP(trapnr) &ipipe_trap_ ## trapnr
+
+void (*ipipe_trap_trampolines[])(void) = {
+    LIST_TRAP(0x0), LIST_TRAP(0x1), LIST_TRAP(0x2), LIST_TRAP(0x3),
+    LIST_TRAP(0x4), LIST_TRAP(0x5), LIST_TRAP(0x6), LIST_TRAP(0x7),
+    LIST_TRAP(0x8), LIST_TRAP(0x9), LIST_TRAP(0xa), LIST_TRAP(0xb),
+    LIST_TRAP(0xc), LIST_TRAP(0xd), LIST_TRAP(0xe), LIST_TRAP(0xf),
+    LIST_TRAP(0x10), LIST_TRAP(0x11), LIST_TRAP(0x12), LIST_TRAP(0x13),
+    LIST_TRAP(0x14), LIST_TRAP(0x15), LIST_TRAP(0x16), LIST_TRAP(0x17),
+    LIST_TRAP(0x18), LIST_TRAP(0x19), LIST_TRAP(0x1a), LIST_TRAP(0x1b),
+    LIST_TRAP(0x1c), LIST_TRAP(0x1d), LIST_TRAP(0x1e), LIST_TRAP(0x1f)
+};
+
+int ipipe_handle_event(unsigned event,
+		       struct pt_regs *regs) __attribute__ ((__unused__));
+
+/* ipipe_handle_event() -- Adeos' generic event handler. This routine
+calls the per-domain handlers registered for a given
+exception/event. Each domain before the one which raised the event in
+the pipeline will get a chance to process the event. The latter will
+eventually be allowed to process its own event too if a valid handler
+exists for it.  Handler executions are always scheduled by the domain
+which raised the event for the prioritary domains wanting to be
+notified of such event.  Note: regs might be NULL. */
+
+int ipipe_handle_event (unsigned event, struct pt_regs *regs)
+
+{
+    struct list_head *pos, *npos;
+    unsigned long flags;
+    ipipe_declare_cpuid;
+    adevinfo_t evinfo;
+    int propagate = 1;
+
+    flags = adeos_test_and_stall_ipipe();
+
+    list_for_each_safe(pos,npos,&adeos_pipeline) {
+
+    	adomain_t *adp = list_entry(pos,adomain_t,link);
+
+	if (adp->events[event].handler != NULL)
+	    {
+	    if (adp == adp_cpu_current[cpuid])
+		{
+		evinfo.domid = adp->domid;
+		evinfo.event = event;
+		evinfo.regs = regs;
+		evinfo.propagate = 0;
+		adp->events[event].handler(&evinfo);
+		propagate = evinfo.propagate;
+		break;
+		}
+
+	    adp->cpudata[cpuid].event_data.domid = adp_cpu_current[cpuid]->domid;
+	    adp->cpudata[cpuid].event_data.event = event;
+	    adp->cpudata[cpuid].event_data.regs = regs;
+	    adp->cpudata[cpuid].event_data.propagate = 0;
+	    set_bit(IPIPE_XPEND_FLAG,&adp->cpudata[cpuid].status);
+
+	    /* Let the prioritary domain process the event. */
+	    __adeos_switch_domain(adp);
+	    
+	    if (!adp->cpudata[cpuid].event_data.propagate)
+		{
+		propagate = 0;
+		break;
+		}
+	    }
+
+	if (adp == adp_cpu_current[cpuid])
+	    break;
+    }
+
+    adeos_restore_ipipe(flags);
+
+    return !propagate;
+}
diff -urpN linux-2.5.38/arch/i386/kernel/irq.c linux-2.5.38-adeos/arch/i386/kernel/irq.c
--- linux-2.5.38/arch/i386/kernel/irq.c	Sun Sep 22 00:25:00 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/irq.c	Sun Sep 22 21:57:18 2002
@@ -332,7 +332,10 @@ asmlinkage unsigned int do_IRQ(struct pt
 	irq_enter();
 	kstat.irqs[cpu][irq]++;
 	spin_lock(&desc->lock);
+#ifndef CONFIG_ADEOS
+	/* IRQ acknowledging is in the hands of the IPIPE exclusively. */
 	desc->handler->ack(irq);
+#endif
 	/*
 	   REPLAY is when Linux resends an IRQ that was dropped earlier
 	   WAITING is used by probe to mark irqs that are being tested
diff -urpN linux-2.5.38/arch/i386/kernel/process.c linux-2.5.38-adeos/arch/i386/kernel/process.c
--- linux-2.5.38/arch/i386/kernel/process.c	Sun Sep 22 00:24:57 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/process.c	Sun Sep 22 21:57:18 2002
@@ -137,6 +137,9 @@ void cpu_idle (void)
 		if (!idle)
 			idle = default_idle;
 		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
+#ifdef CONFIG_ADEOS
+		adeos_suspend_domain();
+#endif /* CONFIG_ADEOS */
 		while (!need_resched())
 			idle();
 		schedule();
diff -urpN linux-2.5.38/arch/i386/kernel/smp.c linux-2.5.38-adeos/arch/i386/kernel/smp.c
--- linux-2.5.38/arch/i386/kernel/smp.c	Sun Sep 22 00:25:00 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/smp.c	Sun Sep 22 21:57:18 2002
@@ -159,7 +159,11 @@ static inline void send_IPI_mask_bitmask
 	unsigned long cfg;
 	unsigned long flags;
 
+#ifdef CONFIG_ADEOS
+	ipipe_hw_save_flags_and_cli(flags);
+#else
 	local_irq_save(flags);
+#endif
 		
 	/*
 	 * Wait for idle.
@@ -182,7 +186,11 @@ static inline void send_IPI_mask_bitmask
 	 */
 	apic_write_around(APIC_ICR, cfg);
 
+#ifdef CONFIG_ADEOS
+	ipipe_hw_restore_flags(flags);
+#else
 	local_irq_restore(flags);
+#endif
 }
 
 static inline void send_IPI_mask_sequence(int mask, int vector)
@@ -625,7 +633,10 @@ void smp_send_stop(void)
  */
 asmlinkage void smp_reschedule_interrupt(void)
 {
+#ifndef CONFIG_ADEOS
+	/* IRQ acknowledging is in the hands of the IPIPE exclusively. */
 	ack_APIC_irq();
+#endif
 }
 
 asmlinkage void smp_call_function_interrupt(void)
@@ -634,7 +645,10 @@ asmlinkage void smp_call_function_interr
 	void *info = call_data->info;
 	int wait = call_data->wait;
 
+#ifndef CONFIG_ADEOS
+	/* IRQ acknowledging is in the hands of the IPIPE exclusively. */
 	ack_APIC_irq();
+#endif
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
@@ -654,3 +668,14 @@ asmlinkage void smp_call_function_interr
 	}
 }
 
+#ifdef CONFIG_ADEOS
+
+void __adeos_send_IPI_allbutself (int vector) {
+    send_IPI_allbutself(vector);
+}
+
+void __adeos_send_IPI_other (int cpu, int vector) {
+    send_IPI_mask(1 << cpu,vector);
+}
+
+#endif /* CONFIG_ADEOS */
diff -urpN linux-2.5.38/arch/i386/kernel/time.c linux-2.5.38-adeos/arch/i386/kernel/time.c
--- linux-2.5.38/arch/i386/kernel/time.c	Sun Sep 22 00:25:10 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/time.c	Sun Sep 22 21:57:18 2002
@@ -370,11 +370,20 @@ static inline void do_timer_interrupt(in
 		 * This will also deassert NMI lines for the watchdog if run
 		 * on an 82489DX-based system.
 		 */
+#ifdef CONFIG_ADEOS
+		unsigned long flags;
+		ipipe_hw_spin_lock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 		spin_lock(&i8259A_lock);
+#endif /* CONFIG_ADEOS */
 		outb(0x0c, 0x20);
 		/* Ack the IRQ; AEOI will end it automatically. */
 		inb(0x20);
+#ifdef CONFIG_ADEOS
+		ipipe_hw_spin_unlock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 		spin_unlock(&i8259A_lock);
+#endif /* CONFIG_ADEOS */
 	}
 #endif
 
@@ -450,6 +459,7 @@ void timer_interrupt(int irq, void *dev_
 
 		rdtscl(last_tsc_low);
 
+#ifndef CONFIG_ADEOS
 		spin_lock(&i8253_lock);
 		outb_p(0x00, 0x43);     /* latch the count ASAP */
 
@@ -459,6 +469,7 @@ void timer_interrupt(int irq, void *dev_
 
 		count = ((LATCH-1) - count) * TICK_SIZE;
 		delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+#endif /* !CONFIG_ADEOS */
 	}
  
 	do_timer_interrupt(irq, NULL, regs);
diff -urpN linux-2.5.38/arch/i386/kernel/traps.c linux-2.5.38-adeos/arch/i386/kernel/traps.c
--- linux-2.5.38/arch/i386/kernel/traps.c	Sun Sep 22 00:25:02 2002
+++ linux-2.5.38-adeos/arch/i386/kernel/traps.c	Sun Sep 22 21:57:18 2002
@@ -815,6 +815,72 @@ do { \
  * Pentium F0 0F bugfix can have resulted in the mapped
  * IDT being write-protected.
  */
+#ifdef CONFIG_ADEOS
+
+extern irq_desc_t irq_desc[];
+
+extern int ipipe_ack_common_irq(unsigned irq);
+
+extern int ipipe_ack_apic_irq(unsigned irq);
+
+extern void (*ipipe_root_traps[])(void);
+
+extern void (*ipipe_trap_trampolines[])(void);
+
+void set_intr_gate(unsigned n, void *addr)
+
+{
+    /* Redirect external interrupts only but the 'TLB invalidate'
+       since we don't allow to virtualize it. */
+    if (n < FIRST_EXTERNAL_VECTOR || n == INVALIDATE_TLB_VECTOR)
+	{
+	if (n == 2 || n == 14)	/* Intercept NMI and Page Fault */
+	    {
+	    ipipe_root_traps[n] = (void (*)(void))addr;
+	    addr = (void *)ipipe_trap_trampolines[n];
+	    }
+
+	_set_gate(idt_table+n,14,0,addr);
+	}
+    else
+	{
+	unsigned irq = n - FIRST_EXTERNAL_VECTOR;
+	int (*ack)(unsigned);
+
+	if (n < FIRST_DEVICE_VECTOR)
+	    ack = &ipipe_ack_common_irq; /* Common ISA interrupts */
+	else
+	    ack = &ipipe_ack_apic_irq; /* APIC/SMP interrupts */
+
+	adeos_virtualize_irq(irq,
+			     (void (*)(unsigned))addr,
+			     ack,
+			     IPIPE_CALLASM_MASK|IPIPE_HANDLE_MASK|IPIPE_PASS_MASK);
+	}
+}
+
+static void __init set_trap_gate(unsigned int n, void *addr)
+
+{
+    ipipe_root_traps[n] = (void (*)(void))addr;
+    addr = (void *)ipipe_trap_trampolines[n];
+    _set_gate(idt_table+n,15,0,addr);
+}
+
+static void __init set_system_gate(unsigned int n, void *addr)
+
+{
+    if (n < FIRST_EXTERNAL_VECTOR) /* Trap exceptions only */
+	{
+	ipipe_root_traps[n] = (void (*)(void))addr;
+	addr = (void *)ipipe_trap_trampolines[n];
+	}
+
+    _set_gate(idt_table+n,15,3,addr);
+}
+
+#else  /* !CONFIG_ADEOS */
+
 void set_intr_gate(unsigned int n, void *addr)
 {
 	_set_gate(idt_table+n,14,0,addr);
@@ -829,6 +895,8 @@ static void __init set_system_gate(unsig
 {
 	_set_gate(idt_table+n,15,3,addr);
 }
+
+#endif /* CONFIG_ADEOS */
 
 static void __init set_call_gate(void *a, void *addr)
 {
diff -urpN linux-2.5.38/arch/i386/mach-generic/do_timer.h linux-2.5.38-adeos/arch/i386/mach-generic/do_timer.h
--- linux-2.5.38/arch/i386/mach-generic/do_timer.h	Sun Sep 22 00:25:18 2002
+++ linux-2.5.38-adeos/arch/i386/mach-generic/do_timer.h	Sun Sep 22 21:57:18 2002
@@ -46,13 +46,22 @@ static inline int do_timer_overflow(int 
 {
 	int i;
 
+#ifdef CONFIG_ADEOS
+	unsigned long flags;
+	ipipe_hw_spin_lock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_lock(&i8259A_lock);
+#endif /* CONFIG_ADEOS */
 	/*
 	 * This is tricky when I/O APICs are used;
 	 * see do_timer_interrupt().
 	 */
 	i = inb(0x20);
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_unlock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_unlock(&i8259A_lock);
+#endif /* CONFIG_ADEOS */
 	
 	/* assumption about timer being IRQ0 */
 	if (i & 0x01) {
diff -urpN linux-2.5.38/arch/i386/mach-visws/do_timer.h linux-2.5.38-adeos/arch/i386/mach-visws/do_timer.h
--- linux-2.5.38/arch/i386/mach-visws/do_timer.h	Sun Sep 22 00:25:05 2002
+++ linux-2.5.38-adeos/arch/i386/mach-visws/do_timer.h	Sun Sep 22 21:57:18 2002
@@ -27,13 +27,22 @@ static inline int do_timer_overflow(int 
 {
 	int i;
 
+#ifdef CONFIG_ADEOS
+	unsigned long flags;
+	ipipe_hw_spin_lock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_lock(&i8259A_lock);
+#endif /* CONFIG_ADEOS */
 	/*
 	 * This is tricky when I/O APICs are used;
 	 * see do_timer_interrupt().
 	 */
 	i = inb(0x20);
+#ifdef CONFIG_ADEOS
+	ipipe_hw_spin_unlock(&i8259A_lock, flags);
+#else /* !CONFIG_ADEOS */
 	spin_unlock(&i8259A_lock);
+#endif /* CONFIG_ADEOS */
 	
 	/* assumption about timer being IRQ0 */
 	if (i & 0x01) {
diff -urpN linux-2.5.38/arch/i386/mm/fault.c linux-2.5.38-adeos/arch/i386/mm/fault.c
--- linux-2.5.38/arch/i386/mm/fault.c	Sun Sep 22 00:24:57 2002
+++ linux-2.5.38-adeos/arch/i386/mm/fault.c	Sun Sep 22 21:57:18 2002
@@ -157,7 +157,11 @@ asmlinkage void do_page_fault(struct pt_
 
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
-		local_irq_enable();
+#ifdef CONFIG_ADEOS
+	    ipipe_hw_sti();
+#else
+	    local_irq_enable();
+#endif
 
 	tsk = current;
 
diff -urpN linux-2.5.38/include/asm-i386/adeos.h linux-2.5.38-adeos/include/asm-i386/adeos.h
--- linux-2.5.38/include/asm-i386/adeos.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.38-adeos/include/asm-i386/adeos.h	Sun Sep 22 21:57:18 2002
@@ -0,0 +1,242 @@
+/*
+ *   include/asm-i386/adeos.h
+ *
+ *   Copyright (C) 2002 Philippe Gerum.
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
+ *   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#ifndef __I386_ADEOS_H
+#define __I386_ADEOS_H
+
+#include <asm/atomic.h>
+#include <linux/version.h>
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,37)
+#include <asm/irq_vectors.h>
+#else
+#include <irq_vectors.h>
+#endif
+#include <asm/siginfo.h>
+#include <asm/ptrace.h>
+#include <linux/list.h>
+#include <linux/threads.h>
+
+#ifdef CONFIG_SMP
+
+#include <asm/fixmap.h>
+#include <asm/apicdef.h>
+
+extern unsigned long cpu_online_map;
+#define smp_num_cpus hweight32(cpu_online_map)
+
+#define ADEOS_NR_CPUS          NR_CPUS
+#define ADEOS_CRITICAL_VECTOR  0xe1 /* Used by __adeos_critical_enter/exit */
+#define ADEOS_SERVICE_VECTOR   0xe9
+#define ADEOS_CRITICAL_IPI     (ADEOS_CRITICAL_VECTOR - FIRST_EXTERNAL_VECTOR)
+#define ADEOS_SERVICE_IPI      (ADEOS_SERVICE_VECTOR - FIRST_EXTERNAL_VECTOR)
+
+static __inline int adeos_smp_apic_id(void) {
+    return GET_APIC_ID(*(unsigned long *)(APIC_BASE+APIC_ID));
+}
+
+/* Cannot include asm/smpboot.h safely, so we define here the little
+   we need to know about CPU/apicid mappings. */
+
+#ifdef CONFIG_MULTIQUAD
+extern volatile int logical_apicid_2_cpu[];
+#define adeos_processor_id()   (__adeos_online_cpus > 1 ? logical_apicid_2_cpu[adeos_smp_apic_id()] : 0)
+#else /* !CONFIG_MULTIQUAD */		/* use physical IDs to bootstrap */
+extern volatile int physical_apicid_2_cpu[];
+#define adeos_processor_id()   (__adeos_online_cpus > 1 ? physical_apicid_2_cpu[adeos_smp_apic_id()] : 0)
+#endif /* CONFIG_MULTIQUAD */
+
+#define ipipe_declare_cpuid    int cpuid = adeos_processor_id()
+#define ipipe_reload_cpuid()   do { cpuid = adeos_processor_id(); } while(0)
+
+#else  /* !CONFIG_SMP */
+
+#define ADEOS_NR_CPUS          1
+#define smp_num_cpus           1
+#define adeos_processor_id()   0
+/* Array references using this index should be optimized out. */
+#define ipipe_declare_cpuid  const int cpuid = 0
+#define ipipe_reload_cpuid()  /* nop */
+
+#endif /* CONFIG_SMP */
+
+#define ADEOS_NR_FAULTS    (32) /* IDT fault vectors */
+#define ADEOS_NR_EVENTS    (ADEOS_NR_FAULTS + 2) /* faults + 2 system events */
+
+/* Pseudo-vectors for syscalls entry/exit (std + lcall7 + lcall27) */
+#define ADEOS_SYSCALL_PROLOGUE  32
+#define ADEOS_SYSCALL_EPILOGUE  33
+
+typedef struct adevinfo {
+
+    unsigned domid;
+    unsigned event;
+    struct pt_regs *regs;
+
+    int propagate;		/* Private */
+
+} adevinfo_t;
+
+typedef struct adsysinfo {
+
+    struct {
+	unsigned irq;		/* Real timer tick IRQ */
+    } timer;
+
+    int ncpus;			/* Number of CPUs on board */
+
+    unsigned long cpufreq;	/* CPU frequency (in Hz) */
+
+} adsysinfo_t;
+
+/* Number of virtual IRQs */
+#define IPIPE_NR_VIRQS    32
+/* First virtual IRQ # */
+#define IPIPE_VIRQ_BASE   NR_IRQS
+/* IRQs + VIRQs */
+#define IPIPE_NR_IRQS     (NR_IRQS + IPIPE_NR_VIRQS)
+/* Number of indirect words needed to map the whole IRQ space. */
+#define IPIPE_IRQ_IWORDS  (IPIPE_NR_IRQS / 32)
+
+typedef struct adomain {
+
+    /* -- Section: offset-based references are made on these fields
+       from inline assembly code. Please don't move or reorder. */
+    int *esp;			/* Domain stack point */
+    void (*dswitch)(void);	/* Domain switch hook */
+    /* -- End of section. */
+
+    int *estackbase;
+    unsigned domid;
+    const char *name;
+    int priority;
+
+    struct adcpudata {
+	unsigned long status;
+	unsigned long irq_pending_hi;
+	unsigned long irq_pending_lo[IPIPE_IRQ_IWORDS];
+	atomic_t irq_hits[IPIPE_NR_IRQS];
+	adevinfo_t event_data;
+    } cpudata[ADEOS_NR_CPUS];
+
+    struct {
+	int (*acknowledge)(unsigned irq);
+	void (*handler)(unsigned irq);
+	unsigned long control;
+    } irqs[IPIPE_NR_IRQS];
+
+    struct {
+	void (*handler)(adevinfo_t *evinfo);
+    } events[ADEOS_NR_EVENTS];
+
+    int ptd_keymax;
+    int ptd_keycount;
+    unsigned long ptd_keymap;
+    void (*ptd_setfun)(int, void *);
+    void *(*ptd_getfun)(int);
+
+    struct list_head link;
+
+} adomain_t;
+
+#define ipipe_virtual_irq_p(irq) ((irq) >= IPIPE_VIRQ_BASE && \
+				  (irq) < IPIPE_NR_IRQS)
+
+#define ipipe_hw_spin_lock_init(x)     spin_lock_init(x)
+#define ipipe_hw_spin_lock(x,flags)    do { ipipe_hw_local_irq_save(flags); spin_lock(x); } while (0)
+#define ipipe_hw_spin_unlock(x,flags)  do { spin_unlock(x); ipipe_hw_local_irq_restore(flags); preempt_enable(); } while (0)
+#define ipipe_hw_spin_lock_disable(x)  do { ipipe_hw_cli(); spin_lock(x); } while (0)
+#define ipipe_hw_spin_unlock_enable(x) do { spin_unlock(x); ipipe_hw_sti(); preempt_enable(); } while (0)
+#define ipipe_hw_spin_lock_simple(x)   spin_lock(x)
+#define ipipe_hw_spin_unlock_simple(x) spin_unlock(x)
+
+#ifndef STR
+#define __STR(x) #x
+#define STR(x) __STR(x)
+#endif
+
+/* Private interface -- Internal use only */
+
+struct adattr;
+
+void __adeos_init(void);
+
+#ifdef CONFIG_PROC_FS
+void __adeos_init_proc(void);
+#endif /* CONFIG_PROC_FS */
+
+void __adeos_bootstrap_domain(adomain_t *adp,
+			      struct adattr *attr);
+
+void __adeos_cleanup_domain(adomain_t *adp);
+
+void __adeos_switch_domain(adomain_t *adp);
+
+unsigned long __adeos_critical_enter(void (*sync)(void));
+
+void __adeos_critical_exit(unsigned long flags);
+
+int __adeos_get_sysinfo(adsysinfo_t *info);
+
+int __adeos_tune_timer(unsigned long ns,
+		       int flags);
+
+void __adeos_set_root_ptd(int key,
+			  void *value);
+
+void *__adeos_get_root_ptd(int key);
+
+void __adeos_do_critical_sync(unsigned irq);
+
+void __adeos_send_IPI_allbutself(int vector);
+
+void __adeos_send_IPI_other(int cpu, int vector);
+
+void ipipe_init_stage(adomain_t *adp);
+
+int ipipe_hook_irq(unsigned irq,
+		   void (*handler)(unsigned irq),
+		   int (*acknowledge)(unsigned irq),
+		   unsigned modemask);
+
+int ipipe_control_irq(unsigned irq,
+		      unsigned clrmask,
+		      unsigned setmask);
+
+unsigned ipipe_alloc_irq(void);
+
+void ipipe_free_irq(unsigned irq);
+
+int FASTCALL(ipipe_trigger_irq(unsigned irq));
+
+int FASTCALL(ipipe_trigger_ipi(int cpuid));
+
+int FASTCALL(ipipe_propagate_irq(unsigned irq));
+
+void ipipe_sync_irqs(void);
+
+int ipipe_handle_event(unsigned event,
+		       struct pt_regs *regs);
+
+extern int __adeos_online_cpus;
+
+extern int __adeos_event_monitors[];
+
+#endif /* !__I386_ADEOS_H */
diff -urpN linux-2.5.38/include/asm-i386/system.h linux-2.5.38-adeos/include/asm-i386/system.h
--- linux-2.5.38/include/asm-i386/system.h	Sun Sep 22 00:24:58 2002
+++ linux-2.5.38-adeos/include/asm-i386/system.h	Sun Sep 22 21:57:18 2002
@@ -306,6 +306,53 @@ static inline unsigned long __cmpxchg(vo
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /* interrupt control.. */
+#ifdef CONFIG_ADEOS
+
+#include <linux/adeos.h>
+
+#define local_save_flags(x)	((x) = adeos_test_ipipe())
+#define local_irq_save(x)	((x) = adeos_test_and_stall_ipipe())
+#define local_irq_restore(x)	adeos_restore_ipipe(x)
+#define local_irq_disable()	adeos_stall_ipipe()
+#define local_irq_enable()	adeos_unstall_ipipe()
+#define irqs_disabled()		adeos_test_ipipe()
+
+#define safe_halt() \
+__asm__ __volatile__("call adeos_unstall_ipipe; hlt": : :"memory")
+
+#define ipipe_hw_save_flags(x)	       \
+__asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
+
+#define ipipe_hw_save_flags_and_cli(x)	\
+__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */)
+
+#define ipipe_hw_restore_flags(x) \
+__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
+
+#define ipipe_hw_cli() \
+__asm__ __volatile__("cli": : :"memory")
+
+#define ipipe_hw_sti() \
+__asm__ __volatile__("sti": : :"memory")
+
+#define ipipe_hw_local_irq_save(x) \
+__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+
+#define ipipe_hw_local_irq_restore(x) \
+__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
+
+/*
+ * Temporary defines for UP kernels until all code gets fixed.
+ * (Lifted from linux/interrupt.h since some drivers do not include
+ * it).
+ */
+#if !defined(CONFIG_SMP)
+# define cli()			local_irq_disable()
+# define sti()			local_irq_enable()
+#endif
+
+#else /* !CONFIG_ADEOS */
+
 #define local_save_flags(x)	__asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
 #define local_irq_restore(x) 	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
 #define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
@@ -322,6 +369,8 @@ static inline unsigned long __cmpxchg(vo
 
 /* For spinlocks etc */
 #define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+
+#endif /* CONFIG_ADEOS */
 
 /*
  * disable hlt during certain critical i/o operations
