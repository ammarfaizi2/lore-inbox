Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWH3XWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWH3XWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWH3XWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:22:55 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:11463 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751636AbWH3XWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:22:53 -0400
Date: Wed, 30 Aug 2006 19:22:50 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 10/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830232250.GK17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-13398-1156980170-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:22:15 up 7 days, 20:31,  9 users,  load average: 0.29, 0.51, 0.37
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-13398-1156980170-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

10- LTTng architecture dependant instrumentation : i386
patch-2.6.17-lttng-0.5.95-instrumentation-i386.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-13398-1156980170-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation-i386.diff"

--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -237,9 +237,21 @@ no_singlestep:
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 syscall_call:
+#ifdef CONFIG_LTT
+	movl %esp, %eax			# copy the stack pointer
+	pushl %eax			# pass the stack pointer copy
+	call trace_real_syscall_entry
+	addl $4,%esp			# return stack to state before pass
+no_syscall_entry_trace:
+	movl ORIG_EAX(%esp),%eax	# restore eax to it's original content
+#endif
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
+#ifdef CONFIG_LTT
+	call trace_real_syscall_exit
+no_syscall_exit_trace:
+#endif
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
diff --git a/arch/i386/kernel/ltt.c b/arch/i386/kernel/ltt.c
new file mode 100644
index 0000000..6b9bd22
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_DOUBLEFAULT) 	+= doublefault.o
 obj-$(CONFIG_VM86)		+= vm86.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_LTT)		+= ltt.o
 
 EXTRA_AFLAGS   := -traditional
 
diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
index cfc683f..5d20cec 100644
--- /dev/null
+++ b/arch/i386/kernel/ltt.c
@@ -0,0 +1,42 @@
+/*
+ * ltt.c
+ *
+ * (C) Copyright  2006 -
+ * 		Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ * We need to fallback on calling functions instead of inlining only because of
+ * headers re-inclusion in critical kernel headers. This is necessary for irq,
+ * spinlock, ...
+ */
+
+#include <linux/module.h>
+#include <linux/ltt/ltt-facility-locking.h>
+#include <asm/ltt/ltt-facility-custom-locking.h>
+
+void _trace_locking_irq_save(const void * lttng_param_EIP,
+		unsigned long lttng_param_flags)
+{
+	trace_locking_irq_save(lttng_param_EIP, lttng_param_flags);
+}
+
+void _trace_locking_irq_restore(const void * lttng_param_EIP,
+		unsigned long lttng_param_flags)
+{
+	trace_locking_irq_restore(lttng_param_EIP, lttng_param_flags);
+}
+
+void _trace_locking_irq_disable(const void * lttng_param_EIP)
+{
+	trace_locking_irq_disable(lttng_param_EIP);
+}
+
+void _trace_locking_irq_enable(const void * lttng_param_EIP)
+{
+	trace_locking_irq_enable(lttng_param_EIP);
+}
+
+
+EXPORT_SYMBOL(_trace_locking_irq_save);
+EXPORT_SYMBOL(_trace_locking_irq_restore);
+EXPORT_SYMBOL(_trace_locking_irq_disable);
+EXPORT_SYMBOL(_trace_locking_irq_enable);
+
diff --git a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
index 6259afe..e44e040 100644
--- a/arch/i386/kernel/syscall_table.S
+++ b/arch/i386/kernel/syscall_table.S
@@ -316,3 +316,5 @@ ENTRY(sys_call_table)
 	.long sys_sync_file_range
 	.long sys_tee			/* 315 */
 	.long sys_vmsplice
+	.long sys_ltt_trace_generic
+	.long sys_ltt_register_generic
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index 9d30747..7346464 100644
--- a/arch/i386/kernel/process.c
+++ b/arch/i386/kernel/process.c
@@ -38,6 +38,8 @@ #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
 #include <linux/random.h>
+#include <linux/kprobes.h>
+#include <linux/ltt/ltt-facility-process.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -337,6 +339,7 @@ __asm__(".section .text\n"
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	struct pt_regs regs;
+	long pid;
 
 	memset(&regs, 0, sizeof(regs));
 
@@ -351,7 +354,13 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
-	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
+	pid = do_fork(flags | CLONE_VM | CLONE_UNTRACED,
+			0, &regs, 0, NULL, NULL);
+#ifdef CONFIG_LTT
+	if(pid >= 0)
+		trace_process_kernel_thread(pid, fn);
+#endif
+	return pid;
 }
 EXPORT_SYMBOL(kernel_thread);
 
diff --git a/arch/i386/kernel/sys_i386.c b/arch/i386/kernel/sys_i386.c
index 8fdb1fb..af2714c 100644
--- a/arch/i386/kernel/sys_i386.c
+++ b/arch/i386/kernel/sys_i386.c
@@ -19,6 +19,7 @@ #include <linux/syscalls.h>
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
+#include <linux/ltt/ltt-facility-ipc.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -129,6 +130,8 @@ asmlinkage int sys_ipc (uint call, int f
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	trace_ipc_call(call, first);
+
 	switch (call) {
 	case SEMOP:
 		return sys_semtimedop (first, (struct sembuf __user *)ptr, second, NULL);
diff --git a/arch/i386/kernel/syscall_table.S b/arch/i386/kernel/syscall_table.S
index af56987..ccdbfc7 100644
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -11,6 +11,8 @@
  * 'Traps.c' handles hardware traps and faults after we have saved some
  * state in 'asm.s'.
  */
+#include <linux/ltt/ltt-facility-kernel.h>
+#include <linux/ltt-core.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -51,6 +53,8 @@ #include <asm/nmi.h>
 #include <asm/smp.h>
 #include <asm/arch_hooks.h>
 #include <asm/kdebug.h>
+#include <asm/ltt/ltt-facility-kernel_arch_i386.h>
+#include <linux/ltt/ltt-facility-custom-stack.h>
 
 #include <linux/module.h>
 
@@ -332,6 +336,27 @@ bug:
 	printk(KERN_EMERG "Kernel BUG\n");
 }
 
+/* Trace related code */
+#ifdef CONFIG_LTT
+
+/* Simple syscall tracing : only keep the caller's address. */
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+	trace_kernel_arch_syscall_entry(
+			(enum lttng_syscall_name)regs->orig_eax,
+			(void*)regs->eip);
+#ifdef CONFIG_LTT_STACK_SYSCALL
+	trace_stack_dump(regs);
+#endif //CONFIG_LTT_STACK_SYSCALL
+}
+
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_kernel_arch_syscall_exit();
+}
+#endif	/* CONFIG_LTT */
+
 /* This is gone through when something in the kernel
  * has done something bad and is about to be terminated.
 */
@@ -386,6 +411,11 @@ #ifdef CONFIG_DEBUG_PAGEALLOC
 #endif
 		if (nl)
 			printk("\n");
+#ifdef CONFIG_LTT
+		printk("LTT NESTING LEVEL : %u ",
+				ltt_nesting[smp_processor_id()]);
+		printk("\n");
+#endif
 		if (notify_die(DIE_OOPS, str, regs, err,
 					current->thread.trap_no, SIGSEGV) !=
 				NOTIFY_STOP) {
@@ -442,6 +472,8 @@ static void __kprobes do_trap(int trapnr
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = trapnr;
 
+	trace_kernel_trap_entry(trapnr, (void*)regs->eip);
+
 	if (regs->eflags & VM_MASK) {
 		if (vm86)
 			goto vm86_trap;
@@ -456,20 +488,24 @@ static void __kprobes do_trap(int trapnr
 			force_sig_info(signr, info, tsk);
 		else
 			force_sig(signr, tsk);
+		trace_kernel_trap_exit();
 		return;
 	}
 
 	kernel_trap: {
 		if (!fixup_exception(regs))
 			die(str, regs, error_code);
+		trace_kernel_trap_exit();
 		return;
 	}
 
 	vm86_trap: {
 		int ret = handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr);
 		if (ret) goto trap_signal;
+		trace_kernel_trap_exit();
 		return;
 	}
+	trace_kernel_trap_exit();
 }
 
 #define DO_ERROR(trapnr, signr, str, name) \
@@ -577,12 +613,16 @@ fastcall void __kprobes do_general_prote
 
 	current->thread.error_code = error_code;
 	current->thread.trap_no = 13;
+	trace_kernel_trap_entry(13, (void*)regs->eip);
 	force_sig(SIGSEGV, current);
+	trace_kernel_trap_exit();
 	return;
 
 gp_in_vm86:
 	local_irq_enable();
+	trace_kernel_trap_entry(13, (void*)regs->eip);
 	handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
+	trace_kernel_trap_exit();
 	return;
 
 gp_in_kernel:
@@ -678,11 +718,18 @@ static void default_do_nmi(struct pt_reg
 	/* Only the BSP gets external NMIs from the system.  */
 	if (!smp_processor_id())
 		reason = get_nmi_reason();
+
+	trace_kernel_trap_entry(2, (void*)regs->eip);
+#ifdef CONFIG_LTT_STACK_NMI
+	trace_stack_dump(regs);
+#endif /* CONFIG_LTT_STACK_NMI */
  
 	if (!(reason & 0xc0)) {
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 2, SIGINT)
-							== NOTIFY_STOP)
+							== NOTIFY_STOP) {
+			trace_kernel_trap_exit();
 			return;
+		}
 #ifdef CONFIG_X86_LOCAL_APIC
 		/*
 		 * Ok, so this is none of the documented NMI sources,
@@ -690,14 +737,18 @@ #ifdef CONFIG_X86_LOCAL_APIC
 		 */
 		if (nmi_watchdog) {
 			nmi_watchdog_tick(regs);
+			trace_kernel_trap_exit();
 			return;
 		}
 #endif
 		unknown_nmi_error(reason, regs);
+		trace_kernel_trap_exit();
 		return;
 	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_STOP)
+	if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT) == NOTIFY_STOP) {
+		trace_kernel_trap_exit();
 		return;
+	}
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);
 	if (reason & 0x40)
@@ -707,6 +758,8 @@ #endif
 	 * as it's edge-triggered.
 	 */
 	reassert_nmi();
+
+	trace_kernel_trap_exit();
 }
 
 static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
@@ -821,7 +874,9 @@ fastcall void __kprobes do_debug(struct 
 	}
 
 	/* Ok, finally something we can handle */
+	trace_kernel_trap_entry(1, (void*)regs->eip);
 	send_sigtrap(tsk, regs, error_code);
+	trace_kernel_trap_exit();
 
 	/* Disable additional traps. They'll be re-enabled when
 	 * the signal is delivered.
@@ -831,7 +886,9 @@ clear_dr7:
 	return;
 
 debug_vm86:
+	trace_kernel_trap_entry(1, (void*)regs->eip);
 	handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, 1);
+	trace_kernel_trap_exit();
 	return;
 
 clear_TF_reenable:
@@ -985,10 +1042,12 @@ fastcall void do_simd_coprocessor_error(
 fastcall void do_spurious_interrupt_bug(struct pt_regs * regs,
 					  long error_code)
 {
+	trace_kernel_trap_entry(16, (void*)regs->eip);
 #if 0
 	/* No need to warn about this any longer. */
 	printk("Ignoring P6 Local APIC Spurious Interrupt Bug...\n");
 #endif
+	trace_kernel_trap_exit();
 }
 
 fastcall void setup_x86_bogus_stack(unsigned char * stk)
@@ -1064,8 +1123,10 @@ asmlinkage void math_emulate(long arg)
 {
 	printk(KERN_EMERG "math-emulation not enabled and no coprocessor found.\n");
 	printk(KERN_EMERG "killing %s.\n",current->comm);
+	trace_kernel_trap_entry(7, (void*)0);
 	force_sig(SIGFPE,current);
 	schedule();
+	trace_kernel_trap_exit();
 }
 
 #endif /* CONFIG_MATH_EMULATION */
@@ -1097,7 +1158,6 @@ do { \
 	 "3" ((char *) (addr)),"2" ((seg) << 16)); \
 } while (0)
 
-
 /*
  * This needs to use 'idt_table' rather than 'idt', and
  * thus use the _nonmapped_ version of the IDT, as the
diff --git a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
index 7f0fcf2..a8e7493 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -56,6 +56,7 @@ #include <asm/mpspec.h>
 #include <asm/uaccess.h>
 #include <asm/processor.h>
 #include <asm/timer.h>
+#include <asm/ltt.h>
 
 #include "mach_time.h"
 
@@ -298,6 +299,9 @@ irqreturn_t timer_interrupt(int irq, voi
 	write_seqlock(&xtime_lock);
 
 	cur_timer->mark_offset();
+#ifdef CONFIG_LTT
+	ltt_reset_timestamp();
+#endif //CONFIG_LTT
  
 	do_timer_interrupt(irq, regs);
 
diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
index 0e49836..047b799 100644
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -22,6 +22,7 @@ #include <linux/vt_kern.h>		/* For unbla
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -319,8 +320,11 @@ fastcall void __kprobes do_page_fault(st
 	 * protection error (error_code & 9) == 0.
 	 */
 	if (unlikely(address >= TASK_SIZE)) {
-		if (!(error_code & 0x0000000d) && vmalloc_fault(address) >= 0)
+		if (!(error_code & 0x0000000d) && vmalloc_fault(address) >= 0) {
+			trace_kernel_trap_entry(14, (void*)regs->eip);
+			trace_kernel_trap_exit();
 			return;
+		}
 		if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 						SIGSEGV) == NOTIFY_STOP)
 			return;
@@ -349,6 +353,8 @@ fastcall void __kprobes do_page_fault(st
 	if (in_atomic() || !mm)
 		goto bad_area_nosemaphore;
 
+	trace_kernel_trap_entry(14, (void*)regs->eip);
+
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
@@ -446,6 +452,7 @@ #endif
 			tsk->thread.screen_bitmap |= 1 << bit;
 	}
 	up_read(&mm->mmap_sem);
+	trace_kernel_trap_exit();
 	return;
 
 /*
@@ -458,6 +465,7 @@ bad_area:
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
+		trace_kernel_trap_exit();
 		/* 
 		 * Valid to do another page fault here because this one came 
 		 * from user space.
@@ -484,6 +492,7 @@ #ifdef CONFIG_X86_F00F_BUG
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
+			trace_kernel_trap_exit();
 			return;
 		}
 	}
@@ -491,16 +500,20 @@ #endif
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	if (fixup_exception(regs))
+	if (fixup_exception(regs)) {
+		trace_kernel_trap_exit();
 		return;
+	}
 
 	/* 
 	 * Valid to do another page fault here, because if this fault
 	 * had been triggered by is_prefetch fixup_exception would have 
 	 * handled it.
 	 */
- 	if (is_prefetch(regs, address, error_code))
+ 	if (is_prefetch(regs, address, error_code)) {
+		trace_kernel_trap_exit();
  		return;
+	}
 
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
@@ -579,13 +592,16 @@ do_sigbus:
 		goto no_context;
 
 	/* User space => ok to do another page fault */
-	if (is_prefetch(regs, address, error_code))
+	if (is_prefetch(regs, address, error_code)) {
+		trace_kernel_trap_exit();
 		return;
+	}
 
 	tsk->thread.cr2 = address;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = 14;
 	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
+	trace_kernel_trap_exit();
 }
 
 #ifndef CONFIG_X86_PAE
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e8ff09f..fd36a69 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -322,6 +322,8 @@ #define __NR_splice		313
 #define __NR_sync_file_range	314
 #define __NR_tee		315
 #define __NR_vmsplice		316
+#define __NR_ltt_trace_generic	317
+#define __NR_ltt_register_generic	318
 
 #define NR_syscalls 317
 
diff --git a/include/asm-ia64/ltt.h b/include/asm-ia64/ltt.h
new file mode 100644
index 0000000..02ab950
--- a/include/asm-i386/system.h
+++ b/include/asm-i386/system.h
@@ -6,6 +6,7 @@ #include <linux/kernel.h>
 #include <asm/segment.h>
 #include <asm/cpufeature.h>
 #include <linux/bitops.h> /* for LOCK_PREFIX */
+#include <asm/ltt/ltt-facility-custom-locking.h>
 
 #ifdef __KERNEL__
 
@@ -459,9 +460,35 @@ #define set_wmb(var, value) do { var = v
 
 /* interrupt control.. */
 #define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
-#define local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+#define _local_irq_restore(x) 	do { typecheck(unsigned long,x); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
+#define _local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
+#define _local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+
+#ifdef CONFIG_LTT_FACILITY_LOCKING
+#define local_irq_restore(x) do { \
+	__label__ address;\
+address: \
+	_trace_locking_irq_restore(&&address,x); \
+	_local_irq_restore(x); \
+} while(0)
+#define local_irq_disable() do { \
+	__label__ address;\
+address: \
+	_local_irq_disable(); \
+	_trace_locking_irq_disable(&&address); \
+} while(0)
+#define local_irq_enable() do { \
+	__label__ address;\
+address: \
+	_trace_locking_irq_enable(&&address); \
+	_local_irq_enable(); \
+} while(0)
+#else
+#define local_irq_restore _local_irq_restore
+#define local_irq_disable _local_irq_disable
+#define local_irq_enable _local_irq_enable
+#endif //CONFIG_LTT_FACILITY_LOCKING
+
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 /* used when interrupts are already enabled or to shutdown the processor */
@@ -475,7 +502,18 @@ ({					\
 })
 
 /* For spinlocks etc */
-#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#define _local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+
+#ifdef CONFIG_LTT_FACILITY_LOCKING
+#define local_irq_save(x) do { \
+	__label__ address;\
+address: \
+	_local_irq_save(x); \
+	_trace_locking_irq_save(&&address,x); \
+} while(0)
+#else
+#define local_irq_save _local_irq_save
+#endif //CONFIG_LTT_FACILITY_LOCKING
 
 /*
  * disable hlt during certain critical i/o operations
diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index eb4b152..b3d7608 100644

--=_Krystal-13398-1156980170-0001-2--
