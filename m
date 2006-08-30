Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWH3XZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWH3XZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWH3XZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:25:28 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:35221 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751055AbWH3XZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:25:27 -0400
Date: Wed, 30 Aug 2006 19:25:24 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 13/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830232524.GN17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-13566-1156980324-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:24:41 up 7 days, 20:33,  9 users,  load average: 1.21, 0.75, 0.48
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-13566-1156980324-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

13- LTTng architecture dependant instrumentation : PPC
patch-2.6.17-lttng-0.5.95-instrumentation-ppc.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-13566-1156980324-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation-ppc.diff"

--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -160,6 +160,33 @@ #ifdef CONFIG_6xx
 	b	power_save_6xx_restore
 #endif
 
+#ifdef CONFIG_LTT
+#define TRACE_REAL_ASM_SYSCALL_ENTRY	\
+	SAVE_NVGPRS(r1);	\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;  	/* Put pointer to registers into r3 */	\
+	mflr	r29;				/* Save LR */ \
+	bl	trace_real_syscall_entry;	/* Call real trace function */ \
+	mtlr	r29;				/* Restore LR */ \
+	lwz	r0,GPR0(r1);			/* Restore original registers */ \
+	lwz	r3,GPR3(r1);	\
+	lwz	r4,GPR4(r1);	\
+	lwz	r5,GPR5(r1);	\
+	lwz	r6,GPR6(r1);	\
+	lwz	r7,GPR7(r1);	\
+	lwz	r8,GPR8(r1);	\
+	REST_NVGPRS(r1);
+#define TRACE_REAL_ASM_SYSCALL_EXIT \
+	bl	trace_real_syscall_exit;	/* Call real trace function */ \
+	lwz	r0,GPR0(r1);			/* Restore original registers */ \
+	lwz	r3,RESULT(r1); \
+	lwz	r4,GPR4(r1); \
+	lwz	r5,GPR5(r1); \
+	lwz	r6,GPR6(r1); \
+	lwz	r7,GPR7(r1); \
+	lwz	r8,GPR8(r1); \
+	addi	r9,r1,STACK_FRAME_OVERHEAD;
+#endif
+
 /*
  * On kernel stack overflow, load up an initial stack pointer
  * and call StackOverflow(regs), which should not return.
@@ -214,9 +241,16 @@ syscall_dotrace_cont:
 	bge-	66f
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
+#ifdef CONFIG_LTT
+ 	TRACE_REAL_ASM_SYSCALL_ENTRY ;
+#endif
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	PPC440EP_ERR42
 	blrl			/* Call handler */
+#ifdef CONFIG_LTT
+	stw	r3,RESULT(r1)	/* Save result */
+ 	TRACE_REAL_ASM_SYSCALL_EXIT ;
+#endif
 	.globl	ret_from_syscall
 ret_from_syscall:
 #ifdef SHOW_SYSCALLS
@@ -269,6 +303,10 @@ ret_from_fork:
 	REST_NVGPRS(r1)
 	bl	schedule_tail
 	li	r3,0
+#ifdef CONFIG_LTT
+	stw	r3,RESULT(r1)	/* Save result */
+ 	TRACE_REAL_ASM_SYSCALL_EXIT ;
+#endif
 	b	ret_from_syscall
 
 /* Traced system call support */
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index 5a93656..a4054c1 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -1004,7 +1004,11 @@ _GLOBAL(_get_SP)
  * Create a kernel thread
  *   kernel_thread(fn, arg, flags)
  */
+#ifdef CONFIG_LTT
+_GLOBAL(original_kernel_thread)
+#else
 _GLOBAL(kernel_thread)
+#endif /* CONFIG_LTT */
 	stwu	r1,-16(r1)
 	stw	r30,8(r1)
 	stw	r31,12(r1)
diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
index 53ea723..747c209 100644
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -57,12 +57,14 @@ #include <linux/mc146818rtc.h>
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/profile.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include <asm/io.h>
 #include <asm/nvram.h>
 #include <asm/cache.h>
 #include <asm/8xx_immap.h>
 #include <asm/machdep.h>
+#include <asm/ltt.h>
 
 #include <asm/time.h>
 
@@ -140,6 +142,8 @@ void timer_interrupt(struct pt_regs * re
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
 
+	trace_kernel_trap_entry(regs->trap, (void *)instruction_pointer(regs));
+
 	irq_enter();
 
 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) <= 0) {
@@ -154,6 +158,9 @@ void timer_interrupt(struct pt_regs * re
 		/* We are in an interrupt, no need to save/restore flags */
 		write_seqlock(&xtime_lock);
 		tb_last_stamp = jiffy_stamp;
+#ifdef CONFIG_LTT
+		ltt_reset_timestamp();
+#endif //CONFIG_LTT
 		do_timer(regs);
 
 		/*
@@ -192,6 +199,8 @@ void timer_interrupt(struct pt_regs * re
 		ppc_md.heartbeat();
 
 	irq_exit();
+
+ 	trace_kernel_trap_exit();
 }
 
 /*
diff --git a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
index 1c0d680..9d78487 100644
--- a/arch/ppc/kernel/traps.c
+++ b/arch/ppc/kernel/traps.c
@@ -29,6 +29,8 @@ #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/prctl.h>
+#include <linux/ltt/ltt-facility-kernel.h>
+#include <linux/ltt-core.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -37,6 +39,7 @@ #include <asm/io.h>
 #include <asm/reg.h>
 #include <asm/xmon.h>
 #include <asm/pmc.h>
+#include <asm/ltt/ltt-facility-kernel_arch_ppc.h>
 
 #ifdef CONFIG_XMON
 extern int xmon_bpt(struct pt_regs *regs);
@@ -107,11 +110,13 @@ void _exception(int signr, struct pt_reg
 		debugger(regs);
 		die("Exception in kernel mode", regs, signr);
 	}
+	trace_kernel_trap_entry(regs->trap, (void *)instruction_pointer(regs));
 	info.si_signo = signr;
 	info.si_errno = 0;
 	info.si_code = code;
 	info.si_addr = (void __user *) addr;
 	force_sig_info(signr, &info, current);
+	trace_kernel_trap_exit();
 
 	/*
 	 * Init gets no signals that it doesn't have a handler for.
@@ -737,6 +742,23 @@ void StackOverflow(struct pt_regs *regs)
 	panic("kernel stack overflow");
 }
 
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
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_kernel_arch_syscall_exit();
+}
+#endif				/* CONFIG_LTT */
+
 void nonrecoverable_exception(struct pt_regs *regs)
 {
 	printk(KERN_ERR "Non-recoverable exception at PC=%lx MSR=%lx\n",
diff --git a/arch/ppc/mm/fault.c b/arch/ppc/mm/fault.c
index 8e08ca3..10850a7 100644
--- a/arch/ppc/mm/fault.c
+++ b/arch/ppc/mm/fault.c
@@ -26,6 +26,7 @@ #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
+#include <linux/ltt/ltt-facility-kernel.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -114,22 +115,29 @@ #else
 		is_write = error_code & 0x02000000;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
 
+	trace_kernel_trap_entry(regs->trap, (void*)instruction_pointer(regs));
+
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_fault_handler && TRAP(regs) == 0x300) {
 		debugger_fault_handler(regs);
+		trace_kernel_trap_exit();
 		return 0;
 	}
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	if (error_code & 0x00400000) {
 		/* DABR match */
-		if (debugger_dabr_match(regs))
+		if (debugger_dabr_match(regs)) {
+			trace_kernel_trap_exit();;
 			return 0;
+		}
 	}
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
 #endif /* CONFIG_XMON || CONFIG_KGDB */
 
-	if (in_atomic() || mm == NULL)
+	if (in_atomic() || mm == NULL) {
+		trace_kernel_trap_exit();
 		return SIGSEGV;
+	}
 
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
@@ -230,6 +238,7 @@ #endif
 				_tlbie(address);
 				pte_unmap_unlock(ptep, ptl);
 				up_read(&mm->mmap_sem);
+				trace_kernel_trap_exit();
 				return 0;
 			}
 			pte_unmap_unlock(ptep, ptl);
@@ -272,6 +281,7 @@ #endif
 	 * -- Cort
 	 */
 	pte_misses++;
+	trace_kernel_trap_exit();
 	return 0;
 
 bad_area:
@@ -281,9 +291,10 @@ bad_area:
 	/* User mode accesses cause a SIGSEGV */
 	if (user_mode(regs)) {
 		_exception(SIGSEGV, regs, code, address);
+		trace_kernel_trap_exit();
 		return 0;
 	}
-
+	trace_kernel_trap_exit();
 	return SIGSEGV;
 
 /*
@@ -300,6 +311,7 @@ out_of_memory:
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
+	trace_kernel_trap_exit();
 	return SIGKILL;
 
 do_sigbus:
@@ -309,6 +321,7 @@ do_sigbus:
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void __user *)address;
 	force_sig_info (SIGBUS, &info, current);
+	trace_kernel_trap_exit();
 	if (!user_mode(regs))
 		return SIGBUS;
 	return 0;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index b244848..50dd365 100644

--=_Krystal-13566-1156980324-0001-2--
