Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWH3XXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWH3XXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWH3XXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:23:37 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:38343 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751168AbWH3XXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:23:36 -0400
Date: Wed, 30 Aug 2006 19:23:32 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 11/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830232332.GL17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-26297-1156980212-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:22:51 up 7 days, 20:31,  9 users,  load average: 0.24, 0.47, 0.36
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-26297-1156980212-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

11- LTTng architecture dependant instrumentation : MIPS
patch-2.6.17-lttng-0.5.95-instrumentation-mips.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-26297-1156980212-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation-mips.diff"

--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -22,6 +22,7 @@ #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include <asm/atomic.h>
 #include <asm/system.h>
@@ -59,8 +60,12 @@ asmlinkage unsigned int do_IRQ(unsigned 
 	irq_enter();
 
 	__DO_IRQ_SMTC_HOOK();
+	trace_kernel_irq_entry(irq, !(user_mode(regs)));
+
 	__do_IRQ(irq, regs);
 
+	trace_kernel_irq_exit();
+
 	irq_exit();
 
 	return 1;
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 199a06e..58bddec 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -26,6 +26,7 @@ #include <linux/a.out.h>
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/kallsyms.h>
+#include <linux/ltt/ltt-facility-process.h>
 
 #include <asm/abi.h>
 #include <asm/bootinfo.h>
@@ -256,6 +257,7 @@ ATTRIB_NORET void kernel_thread_helper(v
 long kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 {
 	struct pt_regs regs;
+	long pid;
 
 	memset(&regs, 0, sizeof(regs));
 
@@ -271,7 +273,13 @@ #else
 #endif
 
 	/* Ok, create the new process.. */
-	return do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
+	pid = do_fork(flags | CLONE_VM | CLONE_UNTRACED,
+			0, &regs, 0, NULL, NULL);
+#ifdef CONFIG_LTT
+	if(pid >= 0)
+		trace_process_kernel_thread(pid, fn);
+#endif //CONFIG_LTT
+	return pid;
 }
 
 static struct mips_frame_info {
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a0ac0e5..e32d298 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -11,6 +11,8 @@
  * Copyright (C) 2000, 01 MIPS Technologies, Inc.
  * Copyright (C) 2002, 2003, 2004, 2005  Maciej W. Rozycki
  */
+#include <linux/ltt/ltt-facility-kernel.h>
+#include <asm/ltt/ltt-facility-kernel_arch_mips.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -19,6 +21,7 @@ #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/spinlock.h>
+#include <linux/unistd.h>
 #include <linux/kallsyms.h>
 #include <linux/bootmem.h>
 
@@ -256,7 +259,7 @@ void show_regs(struct pt_regs *regs)
 
 	printk("Cause : %08x\n", cause);
 
-	cause = (cause & CAUSEF_EXCCODE) >> CAUSEB_EXCCODE;
+	cause = CAUSE_EXCCODE(cause);
 	if (1 <= cause && cause <= 5)
 		printk("BadVA : %0*lx\n", field, regs->cp0_badvaddr);
 
@@ -570,6 +573,7 @@ asmlinkage void do_ov(struct pt_regs *re
  */
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
+	trace_kernel_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), (void*)regs->cp0_epc);
 	if (fcr31 & FPU_CSR_UNI_X) {
 		int sig;
 
@@ -727,16 +731,22 @@ asmlinkage void do_cpu(struct pt_regs *r
 
 	die_if_kernel("do_cpu invoked from kernel context!", regs);
 
+	trace_kernel_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), (void*)regs->cp0_epc);
+
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
 
 	switch (cpid) {
 	case 0:
 		if (!cpu_has_llsc)
-			if (!simulate_llsc(regs))
+			if (!simulate_llsc(regs)) {
+				trace_kernel_trap_exit();
 				return;
+			}
 
-		if (!simulate_rdhwr(regs))
+		if (!simulate_rdhwr(regs)) {
+			trace_kernel_trap_exit();
 			return;
+		}
 
 		break;
 
@@ -789,7 +799,7 @@ #ifdef CONFIG_MIPS_MT_FPAFF
 			}
 #endif /* CONFIG_MIPS_MT_FPAFF */
 		}
-
+		trace_kernel_trap_exit();
 		return;
 
 	case 2:
@@ -799,6 +809,7 @@ #endif /* CONFIG_MIPS_MT_FPAFF */
 	}
 
 	force_sig(SIGILL, current);
+	trace_kernel_trap_exit();
 }
 
 asmlinkage void do_mdmx(struct pt_regs *regs)
@@ -1512,3 +1523,90 @@ #endif
 	flush_icache_range(ebase, ebase + 0x400);
 	flush_tlb_handlers();
 }
+
+
+
+#ifdef CONFIG_LTT
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+	trace_kernel_arch_syscall_entry(
+			(enum lttng_syscall_name)regs->regs[2],
+			(void*)regs->cp0_epc);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_kernel_arch_syscall_exit();
+}
+
+#endif //CONFIG_LTT
+
+
+#if 0
+asmlinkage void trace_real_syscall_entry(struct pt_regs * regs)
+{
+	unsigned long       addr;
+	int                 depth = 0;
+	unsigned long       end_code;
+	unsigned long       lower_bound;
+	int                 seek_depth;
+	unsigned long       *stack;
+	unsigned long       start_code;
+	unsigned long       *start_stack;
+	ltt_syscall_entry trace_syscall_event;
+	unsigned long       upper_bound;
+	int                 use_bounds;
+	int                 use_depth;
+
+	/* syscall_id will be negative for SVR4, IRIX5, BSD43, and POSIX
+	 * syscalls -- these are not supported at this point by LTT
+	 */
+	trace_syscall_event.syscall_id = (uint8_t) (regs->regs[2] - __NR_Linux);
+
+	trace_syscall_event.address  = regs->cp0_epc;
+
+	if (!user_mode(regs))
+		goto trace_syscall_end;
+
+	if (ltt_get_trace_config(&use_depth, &use_bounds, &seek_depth,
+				 (void*)&lower_bound, (void*)&upper_bound) < 0)
+		goto trace_syscall_end;
+
+	/* Heuristic that might work:
+	 * (BUT DOESN'T WORK for any of the cases I tested...) zzz
+	 * Search through stack until a value is found that is within the
+	 * range start_code .. end_code.  (This is looking for a return
+	 * pointer to where a shared library was called from.)  If a stack
+	 * variable contains a valid code address then an incorrect
+	 * result will be generated.
+	 */
+	if ((use_depth == 1) || (use_bounds == 1)) {
+		stack       = (unsigned long*) regs->regs[29];
+		end_code    = current->mm->end_code;
+		start_code  = current->mm->start_code;
+		start_stack = (unsigned long *)current->mm->start_stack;
+
+		while ((stack <= start_stack) && (!__get_user(addr, stack))) {
+			if ((addr > start_code) && (addr < end_code)) {
+				if (((use_depth  == 1) && (depth == seek_depth)) ||
+				    ((use_bounds == 1) && (addr > lower_bound) && (addr < upper_bound))) {
+					trace_syscall_event.address = addr;
+					goto trace_syscall_end;
+				} else {
+					depth++;
+				}
+			}
+		stack++;
+		}
+	}
+
+trace_syscall_end:
+	ltt_log_event(LTT_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	ltt_log_event(LTT_EV_SYSCALL_EXIT, NULL);
+}
+
+#endif /* 0 */
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 5b5a373..857d793 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -72,6 +72,7 @@
  *       A store crossing a page boundary might be executed only partially.
  *       Undo the partial store in this case.
  */
+#include <linux/ltt/ltt-facility-kernel.h>
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -497,14 +498,18 @@ asmlinkage void do_ade(struct pt_regs *r
 	unsigned int __user *pc;
 	mm_segment_t seg;
 
+	trace_kernel_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), (void*)regs->cp0_epc);
+
 	/*
 	 * Address errors may be deliberately induced by the FPU emulator to
 	 * retake control of the CPU after executing the instruction in the
 	 * delay slot of an emulated branch.
 	 */
 	/* Terminate if exception was recognized as a delay slot return */
-	if (do_dsemulret(regs))
+	if (do_dsemulret(regs)) {
+		trace_kernel_trap_exit();
 		return;
+	}
 
 	/* Otherwise handle as normal */
 
@@ -538,6 +543,8 @@ asmlinkage void do_ade(struct pt_regs *r
 	}
 	set_fs(seg);
 
+	trace_kernel_trap_exit();
+
 	return;
 
 sigbus:
@@ -547,4 +554,6 @@ sigbus:
 	/*
 	 * XXX On return from the signal handler we should advance the epc
 	 */
+
+	trace_kernel_trap_exit();
 }
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index e3a6172..24f4333 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -7,6 +7,7 @@
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2001 MIPS Technologies, Inc.
  */
+#include <linux/ltt/ltt-facility-ipc.h>
 #include <linux/config.h>
 #include <linux/a.out.h>
 #include <linux/capability.h>
@@ -308,6 +309,8 @@ asmlinkage int sys_ipc (uint call, int f
 
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
+	
+	trace_ipc_call(call, first);
 
 	switch (call) {
 	case SEMOP:
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 13ff4da..f3f20bb 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -54,6 +54,17 @@ #endif
 	bgez	t3, stackargs
 
 stack_done:
+#ifdef CONFIG_LTT
+	sw  t2, PT_R1(sp)
+	move  a0, sp
+	jal     trace_real_syscall_entry
+	lw  t2, PT_R1(sp)
+
+	lw  a0, PT_R4(sp)		# Restore argument registers
+	lw  a1, PT_R5(sp)
+	lw  a2, PT_R6(sp)
+	lw  a3, PT_R7(sp)
+#endif // CONFIG_LTT
 	lw	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
 	and	t0, t1
@@ -71,6 +82,10 @@ stack_done:
 					# restarting
 1:	sw	v0, PT_R2(sp)		# result
 
+#ifdef CONFIG_LTT
+	jal trace_real_syscall_exit
+#endif // CONFIG_LTT
+
 o32_syscall_exit:
 	local_irq_disable		# make sure need_resched and
 					# signals dont change between
@@ -112,6 +127,10 @@ syscall_trace_entry:
 					# restarting
 1:	sw	v0, PT_R2(sp)		# result
 
+#ifdef CONFIG_LTT
+ jal trace_real_syscall_exit
+#endif //CONFIG_LTT)
+
 	j	syscall_exit
 
 /* ------------------------------------------------------------------------ */
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 9ba7508..10c2a7e 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -52,6 +52,18 @@ #endif
 					# syscall routine
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
+#ifdef CONFIG_LTT
+	sd  t2, PT_R1(sp)
+	move  a0, sp
+	jal trace_real_syscall_entry
+	ld  t2, PT_R1(sp)
+	ld  a0, PT_R4(sp)		# Restore argument registers
+	ld  a1, PT_R5(sp)
+	ld  a2, PT_R6(sp)
+	ld  a3, PT_R7(sp)
+	ld  a4, PT_R8(sp)
+	ld  a5, PT_R9(sp)
+#endif
 
 	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
@@ -69,6 +81,9 @@ #endif
 	sd	v0, PT_R0(sp)		# set flag for syscall
 					# restarting
 1:	sd	v0, PT_R2(sp)		# result
+#ifdef CONFIG_LTT
+	jal trace_real_syscall_exit
+#endif
 
 n64_syscall_exit:
 	local_irq_disable		# make sure need_resched and
@@ -111,6 +126,9 @@ syscall_trace_entry:
 	dnegu	v0			# error
 	sd	v0, PT_R0(sp)		# set flag for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
+#ifdef CONFIG_LTT
+	jal trace_real_syscall_exit
+#endif
 
 	j	syscall_exit
 
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 942aca2..41a82ab 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -52,6 +52,18 @@ #endif
 
 	sd	a3, PT_R26(sp)		# save a3 for syscall restarting
 
+#ifdef CONFIG_LTT
+	sd  t2, PT_R1(sp)
+	move  a0, sp
+	jal trace_real_syscall_entry
+	ld  t2, PT_R1(sp)
+	ld  a0, PT_R4(sp)		# Restore argument registers
+	ld  a1, PT_R5(sp)
+	ld  a2, PT_R6(sp)
+	ld  a3, PT_R7(sp)
+	ld  a4, PT_R8(sp)
+	ld  a5, PT_R9(sp)
+#endif
 	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -67,6 +79,9 @@ #endif
 	dnegu	v0			# error
 	sd	v0, PT_R0(sp)		# set flag for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
+#ifdef CONFIG_LTT
+	jal trace_real_syscall_exit
+#endif
 
 	local_irq_disable		# make sure need_resched and
 					# signals dont change between
@@ -108,6 +123,9 @@ n32_syscall_trace_entry:
 	dnegu	v0			# error
 	sd	v0, PT_R0(sp)		# set flag for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
+#ifdef CONFIG_LTT
+	jal trace_real_syscall_exit
+#endif
 
 	j	syscall_exit
 
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 8efb23a..2dc7b72 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -80,6 +80,25 @@ #endif
 	PTR	4b, bad_stack
 	.previous
 
+#ifdef CONFIG_LTT
+	sd	a4, PT_R8(sp)					 # Save argument registers
+	sd	a5, PT_R9(sp)
+	sd	a6, PT_R10(sp)
+	sd	a7, PT_R11(sp)					# For indirect syscalls
+	sd	t2, PT_R1(sp)
+	move	a0, sp
+	jal trace_real_syscall_entry
+	ld	t2, PT_R1(sp)
+	ld	a0, PT_R4(sp)					 # Restore argument registers
+	ld	a1, PT_R5(sp)
+	ld	a2, PT_R6(sp)
+	ld	a3, PT_R7(sp)
+	ld	a4, PT_R8(sp)
+	ld	a5, PT_R9(sp)
+	ld	a6, PT_R10(sp)
+	ld	a7, PT_R11(sp)					# For indirect syscalls
+#endif
+
 	li	t1, _TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT
 	LONG_L	t0, TI_FLAGS($28)	# syscall tracing enabled?
 	and	t0, t1, t0
@@ -95,6 +114,9 @@ #endif
 	dnegu	v0			# error
 	sd	v0, PT_R0(sp)		# flag for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
+#ifdef CONFIG_LTT
+	jal trace_real_syscall_exit
+#endif
 
 o32_syscall_exit:
 	local_irq_disable		# make need_resched and
@@ -144,6 +166,9 @@ trace_a_syscall:
 	dnegu	v0			# error
 	sd	v0, PT_R0(sp)		# set flag for syscall restarting
 1:	sd	v0, PT_R2(sp)		# result
+#ifdef CONFIG_LTT
+	jal trace_real_syscall_exit
+#endif
 
 	j	syscall_exit
 
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 5e8a18a..476f7ff 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 1995 - 2000 by Ralf Baechle
  */
+#include <linux/ltt/ltt-facility-kernel.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
@@ -61,6 +62,8 @@ #endif
 	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
 		goto vmalloc_fault;
 
+	trace_kernel_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), (void*)regs->cp0_epc);
+
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -115,6 +118,7 @@ survive:
 	}
 
 	up_read(&mm->mmap_sem);
+	trace_kernel_trap_exit();
 	return;
 
 /*
@@ -143,6 +147,7 @@ #endif
 		/* info.si_code has been set above */
 		info.si_addr = (void __user *) address;
 		force_sig_info(SIGSEGV, &info, tsk);
+		trace_kernel_trap_exit();
 		return;
 	}
 
@@ -208,6 +213,7 @@ #endif
 	info.si_addr = (void __user *) address;
 	force_sig_info(SIGBUS, &info, tsk);
 
+	trace_kernel_trap_exit();
 	return;
 vmalloc_fault:
 	{
@@ -245,6 +251,9 @@ vmalloc_fault:
 		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))
 			goto no_context;
+		trace_kernel_trap_entry(CAUSE_EXCCODE(regs->cp0_cause), (void*)regs->cp0_epc);
+		trace_kernel_trap_exit();
 		return;
 	}
+	trace_kernel_trap_exit();
 }
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6729c98..1c770b3 100644

--=_Krystal-26297-1156980212-0001-2--
