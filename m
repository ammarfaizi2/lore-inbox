Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWH3X3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWH3X3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWH3X3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:29:54 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:34755 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932233AbWH3X3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:29:52 -0400
Date: Wed, 30 Aug 2006 19:24:39 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 12/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830232439.GM17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-3735-1156980279-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:23:33 up 7 days, 20:32,  9 users,  load average: 1.23, 0.71, 0.45
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-3735-1156980279-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

12- LTTng architecture dependant instrumentation : PowerPC (32-bit/64-bit)
patch-2.6.17-lttng-0.5.95-instrumentation-powerpc.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-3735-1156980279-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation-powerpc.diff"

--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -191,6 +191,7 @@ stack_ovf:
 	.stabs	"entry_32.S",N_SO,0,0,0f
 0:
 
+
 _GLOBAL(DoSyscall)
 	stw	r0,THREAD+LAST_SYSCALL(r2)
 	stw	r3,ORIG_GPR3(r1)
@@ -213,10 +214,24 @@ syscall_dotrace_cont:
 	slwi	r0,r0,2
 	bge-	66f
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
+#ifdef CONFIG_LTT
+	stw	r10,GPR10(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	trace_real_syscall_entry
+	REST_GPR(0,r1)
+	REST_4GPRS(3,r1)
+	REST_2GPRS(7,r1)
+	lwz	r10,GPR10(r1)
+#endif //CONFIG_LTT
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	PPC440EP_ERR42
 	blrl			/* Call handler */
+#ifdef CONFIG_LTT
+	stw	r3,RESULT(r1)
+	bl	trace_real_syscall_exit
+	lwz	r3,RESULT(r1)
+#endif //CONFIG_LTT
 	.globl	ret_from_syscall
 ret_from_syscall:
 #ifdef SHOW_SYSCALLS
@@ -269,6 +284,11 @@ ret_from_fork:
 	REST_NVGPRS(r1)
 	bl	schedule_tail
 	li	r3,0
+#ifdef CONFIG_LTT
+	stw	r3,RESULT(r1)
+	bl	trace_real_syscall_exit
+	lwz	r3,RESULT(r1)
+#endif //CONFIG_LTT
 	b	ret_from_syscall
 
 /* Traced system call support */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 19ad5c6..96ca778 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -118,6 +118,16 @@ #endif
 syscall_dotrace_cont:
 	cmpldi	0,r0,NR_syscalls
 	bge-	syscall_enosys
+#ifdef CONFIG_LTT
+	std	r10,GPR10(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.trace_real_syscall_entry
+	REST_GPR(0,r1)
+	REST_4GPRS(3,r1)
+	REST_2GPRS(7,r1)
+	addi	r9,r1,STACK_FRAME_OVERHEAD
+	ld	r10,GPR10(r1)
+#endif //CONFIG_LTT
 
 system_call:			/* label this so stack traces look sane */
 /*
@@ -139,6 +149,11 @@ system_call:			/* label this so stack tr
 	ldx	r10,r11,r0	/* Fetch system call handler [ptr] */
 	mtctr   r10
 	bctrl			/* Call handler */
+#ifdef CONFIG_LTT
+	std	r3,GPR3(r1)
+	bl	.trace_real_syscall_exit
+	ld	r3,RESULT(r1)
+#endif //CONFIG_LTT
 
 syscall_exit:
 	std	r3,RESULT(r1)
@@ -304,6 +319,10 @@ _GLOBAL(ret_from_fork)
 	bl	.schedule_tail
 	REST_NVGPRS(r1)
 	li	r3,0
+#ifdef CONFIG_LTT
+	bl	.trace_real_syscall_exit
+	ld	r3,RESULT(r1)
+#endif //CONFIG_LTT
 	b	syscall_exit
 
 /*
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 57d560c..0b9a6a2 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -973,7 +973,11 @@ _GLOBAL(_get_SP)
  * Create a kernel thread
  *   kernel_thread(fn, arg, flags)
  */
+#ifdef CONFIG_LTT
+_GLOBAL(original_kernel_thread)
+#else
 _GLOBAL(kernel_thread)
+#endif //CONFIG_LTT
 	stwu	r1,-16(r1)
 	stw	r30,8(r1)
 	stw	r31,12(r1)
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 2778cce..a19cd6e 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -677,7 +677,11 @@ _GLOBAL(scom970_write)
  * Create a kernel thread
  *   kernel_thread(fn, arg, flags)
  */
+#ifdef CONFIG_LTT
+_GLOBAL(original_kernel_thread)
+#else
 _GLOBAL(kernel_thread)
+#endif //CONFIG_LTT
 	std	r29,-24(r1)
 	std	r30,-16(r1)
 	stdu	r1,-STACK_FRAME_OVERHEAD(r1)
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 4b052ae..dc6d6fb 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -35,6 +35,8 @@ #include <linux/kallsyms.h>
 #include <linux/mqueue.h>
 #include <linux/hardirq.h>
 #include <linux/utsname.h>
+#include <linux/kprobes.h>
+#include <linux/ltt/ltt-facility-process.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -462,6 +464,20 @@ #endif
 		show_instructions(regs);
 }
 
+#ifdef CONFIG_LTT
+long original_kernel_thread(int (*fn) (void*), void* arg, unsigned long flags);
+
+long kernel_thread(int (fn) (void *), void* arg, unsigned long flags)
+{
+	long retval;
+
+	retval = original_kernel_thread(fn, arg, flags);
+	if (retval > 0)
+		trace_process_kernel_thread(retval, fn);
+	return retval;
+}
+#endif //CONFIG_LTT
+
 void exit_thread(void)
 {
 	discard_lazy_cpu_state();
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 9b69d99..b8bbfd0 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -345,3 +345,5 @@ COMPAT_SYS(set_robust_list)
  * please add new calls to arch/powerpc/platforms/cell/spu_callbacks.c
  * as well when appropriate.
  */
+SYSCALL(ltt_trace_generic)
+SYSCALL(ltt_register_generic)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 24e3ad7..3bbaf5e 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -52,6 +52,7 @@ #include <linux/percpu.h>
 #include <linux/rtc.h>
 #include <linux/jiffies.h>
 #include <linux/posix-timers.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -652,6 +653,8 @@ void timer_interrupt(struct pt_regs * re
 	int next_dec;
 	int cpu = smp_processor_id();
 	unsigned long ticks;
+	
+	trace_kernel_trap_entry(regs->trap, (void*)instruction_pointer(regs));
 
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
@@ -718,6 +721,8 @@ #ifdef CONFIG_PPC64
 #endif
 
 	irq_exit();
+
+	trace_kernel_trap_exit();
 }
 
 void wakeup_decrementer(void)
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 064a525..c86dec5 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -32,6 +32,8 @@ #include <linux/prctl.h>
 #include <linux/delay.h>
 #include <linux/kprobes.h>
 #include <linux/kexec.h>
+#include <linux/ltt/ltt-facility-kernel.h>
+#include <linux/ltt-core.h>
 
 #include <asm/kdebug.h>
 #include <asm/pgtable.h>
@@ -41,6 +43,7 @@ #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/rtas.h>
 #include <asm/pmc.h>
+#include <asm/ltt/ltt-facility-kernel_arch_powerpc.h>
 #ifdef CONFIG_PPC32
 #include <asm/reg.h>
 #endif
@@ -126,6 +129,11 @@ #endif
 	printk("%s\n", ppc_md.name ? "" : ppc_md.name);
 
 	print_modules();
+#ifdef CONFIG_LTT
+	printk("LTT NESTING LEVEL : %u ",
+			ltt_nesting[smp_processor_id()]);
+	printk("\n");
+#endif
 	show_regs(regs);
 	bust_spinlocks(0);
 
@@ -168,6 +176,8 @@ void _exception(int signr, struct pt_reg
 			return;
 	}
 
+	trace_kernel_trap_entry(regs->trap, (void*)instruction_pointer(regs));
+
 	memset(&info, 0, sizeof(info));
 	info.si_signo = signr;
 	info.si_code = code;
@@ -195,6 +205,8 @@ void _exception(int signr, struct pt_reg
 			do_exit(signr);
 		}
 	}
+
+	trace_kernel_trap_exit();
 }
 
 #ifdef CONFIG_PPC64
@@ -875,7 +887,9 @@ #endif
 
 void performance_monitor_exception(struct pt_regs *regs)
 {
+	trace_kernel_trap_entry(regs->trap, (void*)instruction_pointer(regs));
 	perf_irq(regs);
+	trace_kernel_trap_exit();
 }
 
 #ifdef CONFIG_8xx
@@ -958,6 +972,8 @@ void altivec_assist_exception(struct pt_
 		return;
 	}
 
+	trace_kernel_trap_entry(regs->trap, (void*)instruction_pointer(regs));
+
 	if (err == -EFAULT) {
 		/* got an error reading the instruction */
 		_exception(SIGSEGV, regs, SEGV_ACCERR, regs->nip);
@@ -969,6 +985,7 @@ void altivec_assist_exception(struct pt_
 			       "in %s at %lx\n", current->comm, regs->nip);
 		current->thread.vscr.u[3] |= 0x10000;
 	}
+	trace_kernel_trap_exit();
 }
 #endif /* CONFIG_ALTIVEC */
 
@@ -1068,3 +1085,22 @@ void kernel_bad_stack(struct pt_regs *re
 void __init trap_init(void)
 {
 }
+
+/* Trace related code */
+#ifdef CONFIG_LTT
+
+/* Simple syscall tracing : only keep the caller's address. */
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+	trace_kernel_arch_syscall_entry(
+			(enum lttng_syscall_name)regs->gpr[0],
+			(void*)instruction_pointer(regs));
+}
+
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_kernel_arch_syscall_exit();
+}
+#endif	/* CONFIG_LTT */
+
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index fdbba42..8909bdf 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -29,6 +29,7 @@ #include <linux/interrupt.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -126,6 +127,8 @@ int __kprobes do_page_fault(struct pt_re
 	int is_write = 0;
 	int trap = TRAP(regs);
  	int is_exec = trap == 0x400;
+	
+	trace_kernel_trap_entry(regs->trap, (void*)instruction_pointer(regs));
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	/*
@@ -143,29 +146,38 @@ #else
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
 
 	if (notify_die(DIE_PAGE_FAULT, "page_fault", regs, error_code,
-				11, SIGSEGV) == NOTIFY_STOP)
+				11, SIGSEGV) == NOTIFY_STOP) {
+		trace_kernel_trap_exit();
 		return 0;
+	}
 
 	if (trap == 0x300) {
-		if (debugger_fault_handler(regs))
+		if (debugger_fault_handler(regs)) {
+			trace_kernel_trap_exit();
 			return 0;
+		}
 	}
 
 	/* On a kernel SLB miss we can only check for a valid exception entry */
-	if (!user_mode(regs) && (address >= TASK_SIZE))
+	if (!user_mode(regs) && (address >= TASK_SIZE)) {
+		trace_kernel_trap_exit();
 		return SIGSEGV;
+	}
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
   	if (error_code & DSISR_DABRMATCH) {
 		/* DABR match */
 		do_dabr(regs, address, error_code);
+		trace_kernel_trap_exit();
 		return 0;
 	}
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
 
 	if (in_atomic() || mm == NULL) {
-		if (!user_mode(regs))
+		if (!user_mode(regs)) {
+			trace_kernel_trap_exit();
 			return SIGSEGV;
+		}
 		/* in_atomic() in user mode is really bad,
 		   as is current->mm == NULL. */
 		printk(KERN_EMERG "Page fault in user mode with"
@@ -286,6 +298,7 @@ #if defined(CONFIG_4xx) || defined(CONFI
 				_tlbie(address);
 				pte_unmap_unlock(ptep, ptl);
 				up_read(&mm->mmap_sem);
+				trace_kernel_trap_exit();
 				return 0;
 			}
 			pte_unmap_unlock(ptep, ptl);
@@ -327,6 +340,7 @@ #endif
 	}
 
 	up_read(&mm->mmap_sem);
+	trace_kernel_trap_exit();
 	return 0;
 
 bad_area:
@@ -336,6 +350,7 @@ bad_area_nosemaphore:
 	/* User mode accesses cause a SIGSEGV */
 	if (user_mode(regs)) {
 		_exception(SIGSEGV, regs, code, address);
+		trace_kernel_trap_exit();
 		return 0;
 	}
 
@@ -344,6 +359,7 @@ bad_area_nosemaphore:
 		printk(KERN_CRIT "kernel tried to execute NX-protected"
 		       " page (%lx) - exploit attempt? (uid: %d)\n",
 		       address, current->uid);
+	trace_kernel_trap_exit();
 
 	return SIGSEGV;
 
@@ -361,6 +377,7 @@ out_of_memory:
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
+	trace_kernel_trap_exit();
 	return SIGKILL;
 
 do_sigbus:
@@ -371,8 +388,10 @@ do_sigbus:
 		info.si_code = BUS_ADRERR;
 		info.si_addr = (void __user *)address;
 		force_sig_info(SIGBUS, &info, current);
+		trace_kernel_trap_exit();
 		return 0;
 	}
+	trace_kernel_trap_exit();
 	return SIGBUS;
 }
 
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index e9a8f5d..360597f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -86,8 +86,6 @@ #endif
 #endif /* CONFIG_PPC32 */
 
 #ifdef CONFIG_PPC64
-EXPORT_SYMBOL(irq_desc);
-
 int distribute_irqs = 1;
 u64 ppc64_interrupt_controller;
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index be98202..9f7f92f 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -194,7 +194,6 @@ #endif
 
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(timer_interrupt);
-EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
 EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(cacheable_memcpy);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2dd47d2..c7ae3ae 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -36,6 +36,7 @@ #include <linux/utsname.h>
 #include <linux/file.h>
 #include <linux/init.h>
 #include <linux/personality.h>
+#include <linux/ltt/ltt-facility-ipc.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -57,6 +58,8 @@ int sys_ipc(uint call, int first, unsign
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	trace_ipc_call(call, first);
+
 	ret = -ENOSYS;
 	switch (call) {
 	case SEMOP:
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 26ed1f5..ef059d1 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -323,8 +323,10 @@ #define __NR_fchmodat		297
 #define __NR_faccessat		298
 #define __NR_get_robust_list	299
 #define __NR_set_robust_list	300
+#define __NR_ltt_trace_generic	301
+#define __NR_ltt_register_generic	302
 
-#define __NR_syscalls		301
+#define __NR_syscalls		303
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
diff --git a/include/asm-ppc/ltt.h b/include/asm-ppc/ltt.h
new file mode 100644
index 0000000..ada3824

--=_Krystal-3735-1156980279-0001-2--
