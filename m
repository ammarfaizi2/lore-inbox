Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275959AbSIUXJZ>; Sat, 21 Sep 2002 19:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275956AbSIUXIL>; Sat, 21 Sep 2002 19:08:11 -0400
Received: from nameservices.net ([208.234.25.16]:9140 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S276233AbSIUXGU>;
	Sat, 21 Sep 2002 19:06:20 -0400
Message-ID: <3D8CFD5C.8B0E1AE4@opersys.com>
Date: Sat, 21 Sep 2002 19:14:36 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.37 4/9: i386 trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the trace support for the i386.

Here are the file modifications:
 arch/i386/config.in         |    2
 arch/i386/kernel/entry.S    |   18 +++++++
 arch/i386/kernel/irq.c      |    6 ++
 arch/i386/kernel/process.c  |    6 ++
 arch/i386/kernel/sys_i386.c |    4 +
 arch/i386/kernel/traps.c    |  105 +++++++++++++++++++++++++++++++++++++++++++-
 arch/i386/mm/fault.c        |   11 ++++
 include/asm-i386/trace.h    |   15 ++++++
 8 files changed, 166 insertions, 1 deletion   

diff -urpN linux-2.5.37/arch/i386/config.in linux-2.5.37-ltt/arch/i386/config.in
--- linux-2.5.37/arch/i386/config.in	Fri Sep 20 11:20:22 2002
+++ linux-2.5.37-ltt/arch/i386/config.in	Fri Sep 20 12:43:26 2002
@@ -421,6 +421,8 @@ source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
 
+source drivers/trace/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
diff -urpN linux-2.5.37/arch/i386/kernel/entry.S linux-2.5.37-ltt/arch/i386/kernel/entry.S
--- linux-2.5.37/arch/i386/kernel/entry.S	Fri Sep 20 11:20:21 2002
+++ linux-2.5.37-ltt/arch/i386/kernel/entry.S	Fri Sep 20 12:43:27 2002
@@ -233,9 +233,27 @@ ENTRY(system_call)
 	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebx)
 	jnz syscall_trace_entry
 syscall_call:
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+	movl syscall_entry_trace_active, %eax
+	cmpl $1, %eax                   # are we tracing system call entries
+	jne no_syscall_entry_trace
+	movl %esp, %eax                 # copy the stack pointer
+	pushl %eax                      # pass the stack pointer copy
+	call trace_real_syscall_entry
+	addl $4,%esp                    # return stack to state before pass
+no_syscall_entry_trace:
+	movl ORIG_EAX(%esp),%eax	# restore eax to it's original content
+#endif
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+	movl syscall_exit_trace_active, %eax
+	cmpl $1, %eax                   # are we tracing system call exits
+	jne no_syscall_exit_trace
+	call trace_real_syscall_exit
+no_syscall_exit_trace:	
+#endif
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
diff -urpN linux-2.5.37/arch/i386/kernel/irq.c linux-2.5.37-ltt/arch/i386/kernel/irq.c
--- linux-2.5.37/arch/i386/kernel/irq.c	Fri Sep 20 11:20:15 2002
+++ linux-2.5.37-ltt/arch/i386/kernel/irq.c	Fri Sep 20 12:43:27 2002
@@ -33,6 +33,8 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+#include <linux/trace.h>
+
 #include <asm/atomic.h>
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -202,6 +204,8 @@ int handle_IRQ_event(unsigned int irq, s
 {
 	int status = 1;	/* Force the "do bottom halves" bit */
 
+ 	TRACE_IRQ_ENTRY(irq, !(user_mode(regs)));
+
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
@@ -213,6 +217,8 @@ int handle_IRQ_event(unsigned int irq, s
 	if (status & SA_SAMPLE_RANDOM)
 		add_interrupt_randomness(irq);
 	local_irq_disable();
+
+ 	TRACE_IRQ_EXIT();
 
 	return status;
 }
diff -urpN linux-2.5.37/arch/i386/kernel/process.c linux-2.5.37-ltt/arch/i386/kernel/process.c
--- linux-2.5.37/arch/i386/kernel/process.c	Fri Sep 20 11:20:12 2002
+++ linux-2.5.37-ltt/arch/i386/kernel/process.c	Fri Sep 20 12:43:27 2002
@@ -34,6 +34,8 @@
 #include <linux/init.h>
 #include <linux/mc146818rtc.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -224,6 +226,10 @@ int kernel_thread(int (*fn)(void *), voi
 
 	/* Ok, create the new process.. */
 	p = do_fork(flags | CLONE_VM, 0, &regs, 0, NULL);
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+	if(!IS_ERR(p))
+		TRACE_PROCESS(TRACE_EV_PROCESS_KTHREAD, p->pid, (int) fn);
+#endif
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }
 
diff -urpN linux-2.5.37/arch/i386/kernel/sys_i386.c linux-2.5.37-ltt/arch/i386/kernel/sys_i386.c
--- linux-2.5.37/arch/i386/kernel/sys_i386.c	Fri Sep 20 11:20:25 2002
+++ linux-2.5.37-ltt/arch/i386/kernel/sys_i386.c	Fri Sep 20 12:43:27 2002
@@ -19,6 +19,8 @@
 #include <linux/file.h>
 #include <linux/utsname.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 
@@ -136,6 +138,8 @@ asmlinkage int sys_ipc (uint call, int f
 
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
+
+	TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
 
 	switch (call) {
 	case SEMOP:
diff -urpN linux-2.5.37/arch/i386/kernel/traps.c linux-2.5.37-ltt/arch/i386/kernel/traps.c
--- linux-2.5.37/arch/i386/kernel/traps.c	Fri Sep 20 11:20:19 2002
+++ linux-2.5.37-ltt/arch/i386/kernel/traps.c	Fri Sep 20 12:43:27 2002
@@ -28,6 +28,8 @@
 #include <linux/ioport.h>
 #endif
 
+#include <linux/trace.h>
+
 #ifdef CONFIG_MCA
 #include <linux/mca.h>
 #include <asm/processor.h>
@@ -278,6 +280,76 @@ bug:
 	printk("Kernel BUG\n");
 }
 
+/* Trace related code */
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+asmlinkage void trace_real_syscall_entry(struct pt_regs *regs)
+{
+	int use_depth;
+	int use_bounds;
+	int depth = 0;
+	int seek_depth;
+	unsigned long lower_bound;
+	unsigned long upper_bound;
+	unsigned long addr;
+	unsigned long *stack;
+	trace_syscall_entry trace_syscall_event;
+
+	/* Set the syscall ID */
+	trace_syscall_event.syscall_id = (uint8_t) regs->orig_eax;
+
+	/* Set the address in any case */
+	trace_syscall_event.address = regs->eip;
+
+	/* Are we in the kernel (This is a kernel thread)? */
+	if (!(regs->xcs & 3))
+		/* Don't go digining anywhere */
+		goto trace_syscall_end;
+
+	/* Get the trace configuration */
+	if (trace_get_config(&use_depth,
+			     &use_bounds,
+			     &seek_depth,
+			     (void *) &lower_bound,
+			     (void *) &upper_bound) < 0)
+		goto trace_syscall_end;
+
+	/* Do we have to search for an eip address range */
+	if ((use_depth == 1) || (use_bounds == 1)) {
+		/* Start at the top of the stack (bottom address since stacks grow downward) */
+		stack = (unsigned long *) regs->esp;
+
+		/* Keep on going until we reach the end of the process' stack limit (wherever it may be) */
+		while (!get_user(addr, stack)) {
+			/* Does this LOOK LIKE an address in the program */
+			if ((addr > current->mm->start_code)
+			    && (addr < current->mm->end_code)) {
+				/* Does this address fit the description */
+				if (((use_depth == 1) && (depth == seek_depth))
+				    || ((use_bounds == 1) && (addr > lower_bound) && (addr < upper_bound))) {
+					/* Set the address */
+					trace_syscall_event.address = addr;
+
+					/* We're done */
+					goto trace_syscall_end;
+				} else
+					/* We're one depth more */
+					depth++;
+			}
+			/* Go on to the next address */
+			stack++;
+		}
+	}
+trace_syscall_end:
+	/* Trace the event */
+	trace_event(TRACE_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_event(TRACE_EV_SYSCALL_EXIT, NULL);
+}
+#endif				/* (CONFIG_TRACE || CONFIG_TRACE_MODULE) */
+
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -311,6 +383,8 @@ static inline unsigned long get_cr2(void
 static void inline do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
+        TRACE_TRAP_ENTRY(trapnr, regs->eip);
+
 	if (vm86 && regs->eflags & VM_MASK)
 		goto vm86_trap;
 
@@ -325,6 +399,7 @@ static void inline do_trap(int trapnr, i
 			force_sig_info(signr, info, tsk);
 		else
 			force_sig(signr, tsk);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -350,14 +425,17 @@ static void inline do_trap(int trapnr, i
 			regs->eip = fixup;
 		else	
 			die(str, regs, error_code);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
 	vm86_trap: {
 		int ret = handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr);
 		if (ret) goto trap_signal;
+		TRACE_TRAP_EXIT();
 		return;
 	}
+	TRACE_TRAP_EXIT();
 }
 
 #define DO_ERROR(trapnr, signr, str, name) \
@@ -417,11 +495,15 @@ asmlinkage void do_general_protection(st
 
 	current->thread.error_code = error_code;
 	current->thread.trap_no = 13;
+        TRACE_TRAP_ENTRY(13, regs->eip);
 	force_sig(SIGSEGV, current);
+        TRACE_TRAP_EXIT();
 	return;
 
 gp_in_vm86:
+        TRACE_TRAP_ENTRY(13, regs->eip);
 	handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
+        TRACE_TRAP_EXIT();
 	return;
 
 gp_in_kernel:
@@ -481,6 +563,12 @@ asmlinkage void do_nmi(struct pt_regs * 
 {
 	unsigned char reason = inb(0x61);
 
+#ifndef CONFIG_X86_LOCAL_APIC
+/* On an machines with APIC enabled, NMIs are used to implement a watchdog
+and will hang the machine if traced. */
+        TRACE_TRAP_ENTRY(2, regs->eip);
+#endif
+
 	++nmi_count(smp_processor_id());
 
 	if (!(reason & 0xc0)) {
@@ -491,10 +579,14 @@ asmlinkage void do_nmi(struct pt_regs * 
 		 */
 		if (nmi_watchdog) {
 			nmi_watchdog_tick(regs);
+			TRACE_TRAP_EXIT();
 			return;
 		}
 #endif
 		unknown_nmi_error(reason, regs);
+#ifndef CONFIG_X86_LOCAL_APIC
+	        TRACE_TRAP_EXIT();
+#endif
 		return;
 	}
 	if (reason & 0x80)
@@ -509,6 +601,10 @@ asmlinkage void do_nmi(struct pt_regs * 
 	inb(0x71);		/* dummy */
 	outb(0x0f, 0x70);
 	inb(0x71);		/* dummy */
+
+#ifndef CONFIG_X86_LOCAL_APIC
+        TRACE_TRAP_EXIT();
+#endif
 }
 
 /*
@@ -582,7 +678,9 @@ asmlinkage void do_debug(struct pt_regs 
 	 */
 	info.si_addr = ((regs->xcs & 3) == 0) ? (void *)tsk->thread.eip : 
 	                                        (void *)regs->eip;
+        TRACE_TRAP_ENTRY(1, regs->eip);
 	force_sig_info(SIGTRAP, &info, tsk);
+        TRACE_TRAP_EXIT();
 
 	/* Disable additional traps. They'll be re-enabled when
 	 * the signal is delivered.
@@ -594,7 +692,9 @@ clear_dr7:
 	return;
 
 debug_vm86:
+        TRACE_TRAP_ENTRY(1, regs->eip);
 	handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, 1);
+        TRACE_TRAP_EXIT();
 	return;
 
 clear_TF:
@@ -743,10 +843,12 @@ asmlinkage void do_simd_coprocessor_erro
 asmlinkage void do_spurious_interrupt_bug(struct pt_regs * regs,
 					  long error_code)
 {
+        TRACE_TRAP_ENTRY(16, regs->eip);
 #if 0
 	/* No need to warn about this any longer. */
 	printk("Ignoring P6 Local APIC Spurious Interrupt Bug...\n");
 #endif
+        TRACE_TRAP_EXIT();	
 }
 
 /*
@@ -775,8 +877,10 @@ asmlinkage void math_emulate(long arg)
 {
 	printk("math-emulation not enabled and no coprocessor found.\n");
 	printk("killing %s.\n",current->comm);
+        TRACE_TRAP_ENTRY(7, 0);
 	force_sig(SIGFPE,current);
 	schedule();
+        TRACE_TRAP_EXIT();
 }
 
 #endif /* CONFIG_MATH_EMULATION */
@@ -807,7 +911,6 @@ do { \
 	:"i" ((short) (0x8000+(dpl<<13)+(type<<8))), \
 	 "3" ((char *) (addr)),"2" (__KERNEL_CS << 16)); \
 } while (0)
-
 
 /*
  * This needs to use 'idt_table' rather than 'idt', and
diff -urpN linux-2.5.37/arch/i386/mm/fault.c linux-2.5.37-ltt/arch/i386/mm/fault.c
--- linux-2.5.37/arch/i386/mm/fault.c	Fri Sep 20 11:20:13 2002
+++ linux-2.5.37-ltt/arch/i386/mm/fault.c	Fri Sep 20 12:43:27 2002
@@ -20,6 +20,8 @@
 #include <linux/tty.h>
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 
+#include <linux/trace.h>
+
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -180,6 +182,8 @@ asmlinkage void do_page_fault(struct pt_
 	mm = tsk->mm;
 	info.si_code = SEGV_MAPERR;
 
+	TRACE_TRAP_ENTRY(14, regs->eip);
+
 	/*
 	 * If we're in an interrupt, have no user context or are running in an
 	 * atomic region then we must not take the fault..
@@ -264,6 +268,7 @@ good_area:
 			tsk->thread.screen_bitmap |= 1 << bit;
 	}
 	up_read(&mm->mmap_sem);
+        TRACE_TRAP_EXIT();
 	return;
 
 /*
@@ -283,6 +288,7 @@ bad_area:
 		/* info.si_code has been set above */
 		info.si_addr = (void *)address;
 		force_sig_info(SIGSEGV, &info, tsk);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -297,6 +303,7 @@ bad_area:
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);
+			TRACE_TRAP_EXIT();
 			return;
 		}
 	}
@@ -306,6 +313,7 @@ no_context:
 	/* Are we prepared to handle this kernel fault?  */
 	if ((fixup = search_exception_table(regs->eip)) != 0) {
 		regs->eip = fixup;
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
@@ -379,6 +387,7 @@ do_sigbus:
 	/* Kernel mode? Handle exceptions or die */
 	if (!(error_code & 4))
 		goto no_context;
+        TRACE_TRAP_EXIT();
 	return;
 
 vmalloc_fault:
@@ -412,6 +421,8 @@ vmalloc_fault:
 		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))
 			goto no_context;
+		TRACE_TRAP_EXIT();
 		return;
 	}
+	TRACE_TRAP_EXIT();
 }
diff -urpN linux-2.5.37/include/asm-i386/trace.h linux-2.5.37-ltt/include/asm-i386/trace.h
--- linux-2.5.37/include/asm-i386/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.37-ltt/include/asm-i386/trace.h	Fri Sep 20 12:43:27 2002
@@ -0,0 +1,15 @@
+/*
+ * linux/include/asm-i386/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * i386 definitions for tracing system
+ */
+
+#include <linux/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_I386
+
+/* Current variant type */
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_NONE
