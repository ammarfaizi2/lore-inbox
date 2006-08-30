Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWH3X1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWH3X1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWH3X1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:27:37 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:45975 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932234AbWH3X1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:27:35 -0400
Date: Wed, 30 Aug 2006 19:27:30 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 16/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830232730.GQ17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-569-1156980450-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:26:52 up 7 days, 20:35,  9 users,  load average: 1.01, 0.88, 0.56
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-569-1156980450-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

16- LTTng architecture dependant instrumentation : x86_64
patch-2.6.17-lttng-0.5.95-instrumentation-x86_64.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-569-1156980450-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation-x86_64.diff"

--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -113,9 +113,34 @@ ENTRY(ia32_sysenter_target)
 sysenter_do_call:	
 	cmpl	$(IA32_NR_syscalls-1),%eax
 	ja	ia32_badsys
+
+#if (CONFIG_LTT)
+	/* trace_real_syscall32_entry expects a pointer to a pt_regs
+	   structure so that it can get %eax (%rax) and %eip (%rip).
+	   These are the only two members of the structure that are used,
+	   so we must be sure that their value will be at the proper
+	   offset from the pointer we give to trace_real_syscall32_entry. */
+	leaq	-ARGOFFSET(%rsp),%rdi	      # compensate for 6 regs that
+					      # we haven't saved on entry
+	movq	%r9,R9(%rdi)
+	call	trace_real_syscall32_entry
+	movq	ORIG_RAX-ARGOFFSET(%rsp),%rax # get the syscall # back into rax
+	movq	RCX-ARGOFFSET(%rsp),%rcx      # restore the argument registers
+	movq	RDX-ARGOFFSET(%rsp),%rdx
+	movq	RSI-ARGOFFSET(%rsp),%rsi
+	movq	RDI-ARGOFFSET(%rsp),%rdi
+	movq	R9-ARGOFFSET(%rsp),%r9
+#endif
+
 	IA32_ARG_FIXUP 1
 	call	*ia32_sys_call_table(,%rax,8)
 	movq	%rax,RAX-ARGOFFSET(%rsp)
+
+#if (CONFIG_LTT)
+	call trace_real_syscall_exit
+	movq RAX-ARGOFFSET(%rsp),%rax
+#endif
+
 	GET_THREAD_INFO(%r10)
 	cli
 	testl	$_TIF_ALLWORK_MASK,threadinfo_flags(%r10)
@@ -214,9 +239,34 @@ ENTRY(ia32_cstar_target)
 cstar_do_call:	
 	cmpl $IA32_NR_syscalls-1,%eax
 	ja  ia32_badsys
+
+#if (CONFIG_LTT)
+	/* trace_real_syscall32_entry expects a pointer to a pt_regs
+	   structure so that it can get %eax (%rax) and %eip (%rip).
+	   These are the only two members of the structure that are used,
+	   so we must be sure that their value will be at the proper
+	   offset from the pointer we give to trace_real_syscall32_entry. */
+	leaq -ARGOFFSET(%rsp),%rdi	   # compensate for 6 regs that
+					   # we haven't saved on entry
+	movq %r9,R9(%rdi)
+	call trace_real_syscall32_entry
+	movq ORIG_RAX-ARGOFFSET(%rsp),%rax # get the syscall # back into rax
+	movl %ebp,%ecx			   # restore the argument registers
+	movq RDX-ARGOFFSET(%rsp),%rdx
+	movq RSI-ARGOFFSET(%rsp),%rsi
+	movq RDI-ARGOFFSET(%rsp),%rdi
+	movq R9-ARGOFFSET(%rsp),%r9
+#endif
+
 	IA32_ARG_FIXUP 1
 	call *ia32_sys_call_table(,%rax,8)
 	movq %rax,RAX-ARGOFFSET(%rsp)
+
+#if (CONFIG_LTT)
+	call trace_real_syscall_exit
+	movq RAX-ARGOFFSET(%rsp),%rax
+#endif
+
 	GET_THREAD_INFO(%r10)
 	cli
 	testl $_TIF_ALLWORK_MASK,threadinfo_flags(%r10)
@@ -252,7 +302,7 @@ cstar_tracesys:	
 				
 ia32_badarg:
 	movq $-EFAULT,%rax
-	jmp ia32_sysret
+	jmp ia32_sysret_notrace
 	CFI_ENDPROC
 
 /* 
@@ -300,9 +350,32 @@ ENTRY(ia32_syscall)
 ia32_do_syscall:	
 	cmpl $(IA32_NR_syscalls-1),%eax
 	ja  ia32_badsys
+#ifdef CONFIG_LTT
+	/* trace_real_syscall32_entry expects a pointer to a pt_regs
+	   structure so that it can get %eax (%rax) and %eip (%rip).
+	   These are the only two members of the structure that are used,
+	   so we must be sure that their value will be at the proper
+	   offset from the pointer we give to trace_real_syscall32_entry. */
+	leaq -ARGOFFSET(%rsp),%rdi	   # compensate for 6 regs that
+					   # we haven't saved on entry
+	call trace_real_syscall32_entry
+	movq ORIG_RAX-ARGOFFSET(%rsp),%rax # get the syscall back into rax
+	movq RCX-ARGOFFSET(%rsp),%rcx	   # restore the argument registers
+	movq RDX-ARGOFFSET(%rsp),%rdx
+	movq RSI-ARGOFFSET(%rsp),%rsi
+	movq RDI-ARGOFFSET(%rsp),%rdi
+#endif
 	IA32_ARG_FIXUP
 	call *ia32_sys_call_table(,%rax,8) # xxx: rip relative
 ia32_sysret:
+
+#if (CONFIG_LTT)
+	movq %rax,RAX-ARGOFFSET(%rsp)
+	call trace_real_syscall_exit
+	movq RAX-ARGOFFSET(%rsp),%rax
+#endif
+
+ia32_sysret_notrace:
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	jmp int_ret_from_sys_call 
 
@@ -696,4 +769,6 @@ #endif
 	.quad sys_sync_file_range
 	.quad sys_tee
 	.quad compat_sys_vmsplice
+	.quad sys_ltt_trace_generic	/* 317 */
+	.quad sys_ltt_register_generic	/* 318 */
 ia32_syscall_end:		
diff --git a/arch/x86_64/ia32/ipc32.c b/arch/x86_64/ia32/ipc32.c
index 369151d..88d42aa 100644
--- a/arch/x86_64/ia32/ipc32.c
+++ b/arch/x86_64/ia32/ipc32.c
@@ -8,6 +8,7 @@ #include <linux/msg.h>
 #include <linux/shm.h>
 #include <linux/ipc.h>
 #include <linux/compat.h>
+#include <linux/ltt/ltt-facility-ipc.h>
 
 #include <asm-i386/ipc.h>
 
@@ -20,6 +21,8 @@ sys32_ipc(u32 call, int first, int secon
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	trace_ipc_call(call, first);
+
 	switch (call) {
 	      case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
index 059c883..0e159fc 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -142,6 +142,12 @@ ENTRY(ret_from_fork)
 	jnz rff_trace
 rff_action:	
 	RESTORE_REST
+
+#if (CONFIG_LTT)
+	call trace_real_syscall_exit
+	GET_THREAD_INFO(%rcx)
+#endif
+
 	testl $3,CS-ARGOFFSET(%rsp)	# from kernel_thread?
 	je   int_ret_from_sys_call
 	testl $_TIF_IA32,threadinfo_flags(%rcx)
@@ -205,9 +211,24 @@ ENTRY(system_call)
 	jnz tracesys
 	cmpq $__NR_syscall_max,%rax
 	ja badsys
+#if (CONFIG_LTT)
+	SAVE_REST
+	FIXUP_TOP_OF_STACK %rdi
+	movq %rsp, %rdi                 # pass the stack pointer
+	call trace_real_syscall_entry
+	LOAD_ARGS ARGOFFSET             # reload args from stack in case
+	                                # trace_real_syscall_entry changed it
+	RESTORE_TOP_OF_STACK %rbx
+	RESTORE_REST
+	movq ORIG_RAX-ARGOFFSET(%rsp),%rax # restore rax to it's original content
+#endif
 	movq %r10,%rcx
 	call *sys_call_table(,%rax,8)  # XXX:	 rip relative
 	movq %rax,RAX-ARGOFFSET(%rsp)
+#if (CONFIG_LTT)
+	call trace_real_syscall_exit
+#endif
+
 /*
  * Syscall return path ending with SYSRET (fast path)
  * Has incomplete stack frame and undefined top of stack. 
@@ -279,8 +300,25 @@ tracesys:			 
 	RESTORE_REST
 	cmpq $__NR_syscall_max,%rax
 	ja  1f
+
+#if (CONFIG_LTT)
+	SAVE_REST
+	movq %rsp, %rdi                 # pass the stack pointer
+	call trace_real_syscall_entry
+	LOAD_ARGS ARGOFFSET             # reload args from stack in case
+	                                # trace_real_syscall_entry changed it
+	RESTORE_REST
+#endif
+
 	movq %r10,%rcx	/* fixup for C */
 	call *sys_call_table(,%rax,8)
+
+#if (CONFIG_LTT)
+	movq %rax,RAX-ARGOFFSET(%rsp)
+	call trace_real_syscall_exit
+	movq RAX-ARGOFFSET(%rsp),%rax
+#endif
+
 1:	movq %rax,RAX-ARGOFFSET(%rsp)
 	/* Use IRET because user could have changed frame */
 	jmp int_ret_from_sys_call
@@ -413,6 +451,13 @@ ENTRY(stub_execve)
 	SAVE_REST
 	FIXUP_TOP_OF_STACK %r11
 	call sys_execve
+
+#if (CONFIG_LTT)
+	pushq %rax
+	call trace_real_syscall_exit
+	popq %rax
+#endif
+
 	RESTORE_TOP_OF_STACK %r11
 	movq %rax,RAX(%rsp)
 	RESTORE_REST
@@ -432,6 +477,11 @@ ENTRY(stub_rt_sigreturn)
 	FIXUP_TOP_OF_STACK %r11
 	call sys_rt_sigreturn
 	movq %rax,RAX(%rsp) # fixme, this could be done at the higher layer
+
+#if (CONFIG_LTT)
+	call trace_real_syscall_exit
+#endif
+
 	RESTORE_REST
 	jmp int_ret_from_sys_call
 	CFI_ENDPROC
@@ -834,6 +884,15 @@ ENTRY(kernel_thread)
 	# clone now
 	call do_fork
 	movq %rax,RAX(%rsp)
+
+#if (CONFIG_LTT)
+	cmp  $0, %rax	#if pid >=0 call trace_process_kernel_thread
+	jl   no_trace_thread
+	movq %rdi, %rsi	#fn (%rdi) as second function argument
+	movq %rax, %rdi	#pid (%rax) as first function argument
+	call trace_process_kernel_thread__
+no_trace_thread:
+#endif
 	xorl %edi,%edi
 
 	/*
@@ -884,10 +943,19 @@ ENTRY(execve)
 	movq %rax, RAX(%rsp)	
 	RESTORE_REST
 	testq %rax,%rax
+#if (CONFIG_LTT)
+	je ltt_exit_trace_label
+#else
 	je int_ret_from_sys_call
+#endif
 	RESTORE_ARGS
 	UNFAKE_STACK_FRAME
 	ret
+#if (CONFIG_LTT)
+ltt_exit_trace_label:
+	call trace_real_syscall_exit
+	jmp int_ret_from_sys_call
+#endif
 	CFI_ENDPROC
 
 KPROBE_ENTRY(page_fault)
diff --git a/arch/x86_64/kernel/ltt.c b/arch/x86_64/kernel/ltt.c
new file mode 100644
index 0000000..b06dfe5
--- /dev/null
+++ b/arch/x86_64/kernel/ltt.c
@@ -0,0 +1,39 @@
+/*
+ * ltt.c
+ *
+ * We need to fallback on calling functions instead of inlining only because of
+ * headers re-inclusion in critical kernel headers. This is necessary for irq,
+ * spinlock, ...
+ */
+
+#include <linux/module.h>
+#include <linux/ltt/ltt-facility-locking.h>
+#include <asm/ltt/ltt-facility-custom-locking.h>
+
+void _trace_locking_irq_save(const void * lttng_param_RIP,
+			     unsigned long lttng_param_flags)
+{
+	trace_locking_irq_save(lttng_param_RIP, lttng_param_flags);
+}
+
+void _trace_locking_irq_restore(const void * lttng_param_RIP,
+				unsigned long lttng_param_flags)
+{
+	trace_locking_irq_restore(lttng_param_RIP, lttng_param_flags);
+}
+
+void _trace_locking_irq_disable(const void * lttng_param_RIP)
+{
+	trace_locking_irq_disable(lttng_param_RIP);
+}
+
+void _trace_locking_irq_enable(const void * lttng_param_RIP)
+{
+	trace_locking_irq_enable(lttng_param_RIP);
+}
+
+
+EXPORT_SYMBOL(_trace_locking_irq_save);
+EXPORT_SYMBOL(_trace_locking_irq_restore);
+EXPORT_SYMBOL(_trace_locking_irq_disable);
+EXPORT_SYMBOL(_trace_locking_irq_enable);
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 7392570..8d53184 100644
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_SWIOTLB)		+= pci-swiotlb.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_X86_PM_TIMER)	+= pmtimer.o
 obj-$(CONFIG_X86_VSMP)		+= vsmp.o
+obj-$(CONFIG_LTT)		+= ltt.o
 
 obj-$(CONFIG_MODULES)		+= module.o
 
diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index 586b34c..35dbe74 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -36,6 +36,7 @@ #include <asm/timex.h>
 #include <asm/proto.h>
 #include <asm/hpet.h>
 #include <asm/sections.h>
+#include <asm/ltt.h>
 #include <linux/cpufreq.h>
 #include <linux/hpet.h>
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -355,6 +356,10 @@ void main_timer_handler(struct pt_regs *
 
 	write_seqlock(&xtime_lock);
 
+#ifdef CONFIG_LTT
+	ltt_reset_timestamp();
+#endif //CONFIG_LTT
+
 	if (vxtime.hpet_address)
 		offset = hpet_readl(HPET_COUNTER);
 
diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index cea335e..bf2a741 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -14,6 +14,8 @@
  * 'Traps.c' handles hardware traps and faults after we have saved some
  * state in 'entry.S'.
  */
+#include <linux/ltt/ltt-facility-kernel.h>
+#include <linux/ltt-core.h>
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -31,6 +33,8 @@ #include <linux/moduleparam.h>
 #include <linux/nmi.h>
 #include <linux/kprobes.h>
 #include <linux/kexec.h>
+#include <linux/ltt/ltt-facility-process.h>
+
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -41,6 +45,8 @@ #include <asm/desc.h>
 #include <asm/i387.h>
 #include <asm/kdebug.h>
 #include <asm/processor.h>
+#include <asm/ltt/ltt-facility-kernel_arch_x86_64.h>
+#include <linux/ltt/ltt-facility-custom-stack.h>
 
 #include <asm/smp.h>
 #include <asm/pgalloc.h>
@@ -385,6 +391,42 @@ void out_of_line_bug(void)
 } 
 #endif
 
+/* Trace related code.  These functions are defined as simple wrappers
+   around the macros so that tracing code can be called from
+   assembly. */
+#ifdef CONFIG_LTT
+
+/* Simple syscall tracing : only keep the caller's address. */
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+	trace_kernel_arch_syscall_entry(
+			(enum lttng_syscall_name)regs->orig_rax,
+			(void*)regs->rip);
+}
+asmlinkage void trace_real_syscall32_entry(struct pt_regs *regs)
+{
+	// 32-bits system calls doesn't have the same number as 64-bits,
+	// so we add a constant (5000) not to mix the two system call
+	// tables.  See asm/ltt/ltt-facility-kernel_arch_x86_64.h
+	trace_kernel_arch_syscall_entry(
+			(enum lttng_syscall_name)regs->orig_rax + 5000,
+			(void*)regs->rip);
+}
+
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_kernel_arch_syscall_exit();
+}
+
+
+asmlinkage void trace_process_kernel_thread__(uint32_t pid, void * function)
+{
+	trace_process_kernel_thread(pid, function);
+}
+#endif	/* CONFIG_LTT */
+
+
 static DEFINE_SPINLOCK(die_lock);
 static int die_owner = -1;
 static unsigned int die_nest_count;
@@ -488,6 +530,8 @@ static void __kprobes do_trap(int trapnr
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = trapnr;
 
+	trace_kernel_trap_entry(trapnr, (void*)regs->rip);
+
 	if (user_mode(regs)) {
 		if (exception_trace && unhandled_signal(tsk, signr))
 			printk(KERN_INFO
@@ -499,6 +543,7 @@ static void __kprobes do_trap(int trapnr
 			force_sig_info(signr, info, tsk);
 		else
 			force_sig(signr, tsk);
+		trace_kernel_trap_exit();
 		return;
 	}
 
@@ -511,8 +556,10 @@ static void __kprobes do_trap(int trapnr
 			regs->rip = fixup->fixup;
 		else	
 			die(str, regs, error_code);
+		trace_kernel_trap_exit();
 		return;
 	}
+	trace_kernel_trap_exit();
 }
 
 #define DO_ERROR(trapnr, signr, str, name) \
@@ -596,7 +643,9 @@ asmlinkage void __kprobes do_general_pro
 			       tsk->comm, tsk->pid,
 			       regs->rip, regs->rsp, error_code); 
 
+		trace_kernel_trap_entry(13, (void*)regs->rip);
 		force_sig(SIGSEGV, tsk);
+		trace_kernel_trap_exit();
 		return;
 	} 
 
@@ -654,6 +703,13 @@ asmlinkage __kprobes void default_do_nmi
 	unsigned char reason = 0;
 	int cpu;
 
+	/* On machines with APIC enabled, NMIs are used to implement a watchdog
+	   and will hang the machine if traced. */
+	trace_kernel_trap_entry(2, (void*)regs->rip);
+#ifdef CONFIG_LTT_STACK_NMI
+	trace_stack_dump(regs);
+#endif /* CONFIG_LTT_STACK_NMI */
+
 	cpu = smp_processor_id();
 
 	/* Only the BSP gets external NMIs from the system.  */
@@ -662,8 +718,10 @@ asmlinkage __kprobes void default_do_nmi
 
 	if (!(reason & 0xc0)) {
 		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 2, SIGINT)
-								== NOTIFY_STOP)
+								== NOTIFY_STOP) {
+			trace_kernel_trap_exit();
 			return;
+		}
 #ifdef CONFIG_X86_LOCAL_APIC
 		/*
 		 * Ok, so this is none of the documented NMI sources,
@@ -671,14 +729,18 @@ #ifdef CONFIG_X86_LOCAL_APIC
 		 */
 		if (nmi_watchdog > 0) {
 			nmi_watchdog_tick(regs,reason);
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
 
 	/* AK: following checks seem to be broken on modern chipsets. FIXME */
 
@@ -686,6 +748,8 @@ #endif
 		mem_parity_error(reason, regs);
 	if (reason & 0x40)
 		io_check_error(reason, regs);
+
+	trace_kernel_trap_exit();
 }
 
 /* runs on IST stack. */
@@ -775,7 +839,9 @@ asmlinkage void __kprobes do_debug(struc
 	info.si_errno = 0;
 	info.si_code = TRAP_BRKPT;
 	info.si_addr = user_mode(regs) ? (void __user *)regs->rip : NULL;
+	trace_kernel_trap_entry(1, (void*)regs->rip);
 	force_sig_info(SIGTRAP, &info, tsk);
+	trace_kernel_trap_exit();
 
 clear_dr7:
 	set_debugreg(0UL, 7);
@@ -933,6 +999,9 @@ asmlinkage void do_simd_coprocessor_erro
 
 asmlinkage void do_spurious_interrupt_bug(struct pt_regs * regs)
 {
+	trace_kernel_trap_entry(16, (void*)regs->rip);
+
+	trace_kernel_trap_exit();
 }
 
 asmlinkage void __attribute__((weak)) smp_thermal_interrupt(void)
diff --git a/arch/x86_64/mm/fault.c b/arch/x86_64/mm/fault.c
index 5525059..b1a4ce8 100644
--- a/arch/x86_64/mm/fault.c
+++ b/arch/x86_64/mm/fault.c
@@ -24,6 +24,7 @@ #include <linux/vt_kern.h>		/* For unbla
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -345,8 +346,11 @@ asmlinkage void __kprobes do_page_fault(
 		 */
 		if (!(error_code & (PF_RSVD|PF_USER|PF_PROT)) &&
 		      ((address >= VMALLOC_START && address < VMALLOC_END))) {
-			if (vmalloc_fault(address) >= 0)
+			if (vmalloc_fault(address) >= 0) {
+				trace_kernel_trap_entry(14, (void*)regs->rip);
+				trace_kernel_trap_exit();
 				return;
+			}
 		}
 		if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
 						SIGSEGV) == NOTIFY_STOP)
@@ -379,6 +383,7 @@ asmlinkage void __kprobes do_page_fault(
 	if (unlikely(in_atomic() || !mm))
 		goto bad_area_nosemaphore;
 
+	trace_kernel_trap_entry(14, (void*)regs->rip);
  again:
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
@@ -403,19 +408,22 @@ asmlinkage void __kprobes do_page_fault(
 	}
 
 	vma = find_vma(mm, address);
-	if (!vma)
+	if (!vma) {
 		goto bad_area;
+	}
 	if (likely(vma->vm_start <= address))
 		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
+	if (!(vma->vm_flags & VM_GROWSDOWN)) {
 		goto bad_area;
+	}
 	if (error_code & 4) {
 		// XXX: align red zone size with ABI 
 		if (address + 128 < regs->rsp)
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address)) {
 		goto bad_area;
+	}
 /*
  * Ok, we have a good vm_area for this memory access, so
  * we can handle it..
@@ -427,15 +435,17 @@ good_area:
 		default:	/* 3: write, present */
 			/* fall through */
 		case PF_WRITE:		/* write, not present */
-			if (!(vma->vm_flags & VM_WRITE))
+			if (!(vma->vm_flags & VM_WRITE)) {
 				goto bad_area;
+			}
 			write++;
 			break;
 		case PF_PROT:		/* read, present */
 			goto bad_area;
 		case 0:			/* read, not present */
-			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+			if (!(vma->vm_flags & (VM_READ | VM_EXEC))) {
 				goto bad_area;
+			}
 	}
 
 	/*
@@ -457,6 +467,7 @@ good_area:
 	}
 
 	up_read(&mm->mmap_sem);
+	trace_kernel_trap_exit();
 	return;
 
 /*
@@ -469,6 +480,7 @@ bad_area:
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & PF_USER) {
+		trace_kernel_trap_exit();
 		if (is_prefetch(regs, address, error_code))
 			return;
 
@@ -556,16 +568,19 @@ out_of_memory:
 		goto again;
 	}
 	printk("VM: killing process %s\n", tsk->comm);
-	if (error_code & 4)
+	if (error_code & 4) {
+		trace_kernel_trap_exit();
 		do_exit(SIGKILL);
+	}
 	goto no_context;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
 
 	/* Kernel mode? Handle exceptions or die */
-	if (!(error_code & PF_USER))
+	if (!(error_code & PF_USER)) {
 		goto no_context;
+	}
 
 	tsk->thread.cr2 = address;
 	tsk->thread.error_code = error_code;
@@ -575,6 +590,9 @@ do_sigbus:
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void __user *)address;
 	force_sig_info(SIGBUS, &info, tsk);
+	/* No need to test for kernel page fault, we know we are not
+	   in one or else we would have jumped to no_context */
+	trace_kernel_trap_exit();
 	return;
 }
 
diff --git a/block/blktrace.c b/block/blktrace.c
index 36f3a17..6c0690c 100644
--- a/include/asm-x86_64/ia32_unistd.h
+++ b/include/asm-x86_64/ia32_unistd.h
@@ -317,4 +317,9 @@ #define __NR_ia32_pselect6		308
 #define __NR_ia32_ppoll			309
 #define __NR_ia32_unshare		310
 
+/* A few defines seem to have been forgotten by kernel developers.
+   See arch/x86_64/ia32/ia32entry.S and include/asm-i386/unistd.h */
+#define __NR_ia32_ltt_trace_generic	317
+#define __NR_ia32_ltt_register_generic	318
+
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff --git a/include/asm-x86_64/ltt.h b/include/asm-x86_64/ltt.h
new file mode 100644
index 0000000..aa93db7
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -617,8 +617,12 @@ #define __NR_sync_file_range	277
 __SYSCALL(__NR_sync_file_range, sys_sync_file_range)
 #define __NR_vmsplice		278
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
+#define __NR_ltt_trace_generic		279
+__SYSCALL(__NR_ltt_trace_generic,	sys_ltt_trace_generic)
+#define __NR_ltt_register_generic		280
+__SYSCALL(__NR_ltt_register_generic,	sys_ltt_register_generic)
 
-#define __NR_syscall_max __NR_vmsplice
+#define __NR_syscall_max __NR_ltt_register_generic
 
 #ifndef __NO_STUBS
 
diff --git a/include/linux/ltt-core.h b/include/linux/ltt-core.h
new file mode 100644
index 0000000..fc83774
--- a/include/asm-x86_64/system.h
+++ b/include/asm-x86_64/system.h
@@ -328,12 +328,12 @@ #define warn_if_not_ulong(x) do { unsign
 
 /* interrupt control.. */
 #define local_save_flags(x)	do { warn_if_not_ulong(x); __asm__ __volatile__("# save_flags \n\t pushfq ; popq %q0":"=g" (x): /* no input */ :"memory"); } while (0)
-#define local_irq_restore(x) 	__asm__ __volatile__("# restore_flags \n\t pushq %0 ; popfq": /* no output */ :"g" (x):"memory", "cc")
+#define _local_irq_restore(x) 	__asm__ __volatile__("# restore_flags \n\t pushq %0 ; popfq": /* no output */ :"g" (x):"memory", "cc")
 
 #ifdef CONFIG_X86_VSMP
 /* Interrupt control for VSMP  architecture */
-#define local_irq_disable()	do { unsigned long flags; local_save_flags(flags); local_irq_restore((flags & ~(1 << 9)) | (1 << 18)); } while (0)
-#define local_irq_enable()	do { unsigned long flags; local_save_flags(flags); local_irq_restore((flags | (1 << 9)) & ~(1 << 18)); } while (0)
+#define _local_irq_disable()	do { unsigned long flags; local_save_flags(flags); local_irq_restore((flags & ~(1 << 9)) | (1 << 18)); } while (0)
+#define _local_irq_enable()	do { unsigned long flags; local_save_flags(flags); local_irq_restore((flags | (1 << 9)) & ~(1 << 18)); } while (0)
 
 #define irqs_disabled()					\
 ({							\
@@ -343,10 +343,10 @@ ({							\
 })
 
 /* For spinlocks etc */
-#define local_irq_save(x)	do { local_save_flags(x); local_irq_restore((x & ~(1 << 9)) | (1 << 18)); } while (0)
+#define _local_irq_save(x)	do { local_save_flags(x); local_irq_restore((x & ~(1 << 9)) | (1 << 18)); } while (0)
 #else  /* CONFIG_X86_VSMP */
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
-#define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
+#define _local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
+#define _local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
 
 #define irqs_disabled()			\
 ({					\
@@ -356,9 +356,41 @@ ({					\
 })
 
 /* For spinlocks etc */
-#define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
+#define _local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
 #endif
 
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
+#define local_irq_save(x) do { \
+	__label__ address;\
+address: \
+	_local_irq_save(x); \
+	_trace_locking_irq_save(&&address,x); \
+} while(0)
+#else
+#define local_irq_restore _local_irq_restore
+#define local_irq_disable _local_irq_disable
+#define local_irq_enable _local_irq_enable
+#define local_irq_save _local_irq_save
+#endif //CONFIG_LTT_FACILITY_LOCKING
+
 /* used in the idle loop; sti takes one instruction cycle to complete */
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 /* used when interrupts are already enabled or to shutdown the processor */
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index feb77cb..97eee2c 100644

--=_Krystal-569-1156980450-0001-2--
