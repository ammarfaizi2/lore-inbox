Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319411AbSIFWKi>; Fri, 6 Sep 2002 18:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319415AbSIFWKE>; Fri, 6 Sep 2002 18:10:04 -0400
Received: from nameservices.net ([208.234.25.16]:37252 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S319411AbSIFWIZ>;
	Fri, 6 Sep 2002 18:08:25 -0400
Message-ID: <3D792946.7F90EA5F@opersys.com>
Date: Fri, 06 Sep 2002 18:16:38 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] 5/8 LTT for 2.5.33: PowerPC trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds trace support for the PowerPC. Here are the files
modified:
arch/ppc/config.in
arch/ppc/kernel/entry.S
arch/ppc/kernel/irq.c
arch/ppc/kernel/misc.S
arch/ppc/kernel/process.c
arch/ppc/kernel/syscalls.c
arch/ppc/kernel/time.c
arch/ppc/kernel/traps.c
arch/ppc/mm/fault.c
include/asm-ppc/trace.h

At this time, this patch doesn't include the syscall entry/exit
tests provided in the i386 patch. This is on the to-do list and
should be relatively easy for someone familiar with PPC assembly.

--- linux-2.5.33/arch/ppc/config.in	Sat Aug 31 18:04:45 2002
+++ linux-2.5.33-ltt/arch/ppc/config.in	Fri Sep  6 12:03:20 2002
@@ -588,6 +588,8 @@
 
 source lib/Config.in
 
+source drivers/trace/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -urN linux-2.5.33/arch/ppc/kernel/entry.S linux-2.5.33-ltt/arch/ppc/kernel/entry.S
--- linux-2.5.33/arch/ppc/kernel/entry.S	Sat Aug 31 18:05:34 2002
+++ linux-2.5.33-ltt/arch/ppc/kernel/entry.S	Fri Sep  6 12:03:20 2002
@@ -106,6 +106,32 @@
 	RFI
 #endif /* CONFIG_PPC_ISERIES */
 
+/* LTT stuff */
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+#define TRACE_REAL_ASM_SYSCALL_ENTRY	\
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
+	lwz	r8,GPR8(r1);
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
  * Handle a system call.
  */
@@ -136,12 +162,19 @@
 	slwi	r0,r0,2
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+ 	TRACE_REAL_ASM_SYSCALL_ENTRY ;
+#endif
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	blrl			/* Call handler */
 	.globl	ret_from_syscall
 ret_from_syscall:
 #ifdef SHOW_SYSCALLS
 	bl	do_show_syscall_exit
+#endif
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+	stw	r3,RESULT(r1)	/* Save result */
+ 	TRACE_REAL_ASM_SYSCALL_EXIT ; 
 #endif
 	mr	r6,r3
 	li	r11,-_LAST_ERRNO
diff -urN linux-2.5.33/arch/ppc/kernel/irq.c linux-2.5.33-ltt/arch/ppc/kernel/irq.c
--- linux-2.5.33/arch/ppc/kernel/irq.c	Sat Aug 31 18:04:53 2002
+++ linux-2.5.33-ltt/arch/ppc/kernel/irq.c	Fri Sep  6 12:03:20 2002
@@ -49,6 +49,8 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
 #include <asm/system.h>
@@ -427,6 +429,8 @@
 	int cpu = smp_processor_id();
 	irq_desc_t *desc = irq_desc + irq;
 
+	TRACE_IRQ_ENTRY(irq, !(user_mode(regs)));
+
 	kstat.irqs[cpu][irq]++;
 	spin_lock(&desc->lock);
 	ack_irq(irq);	
@@ -504,6 +508,8 @@
 			irq_desc[irq].handler->enable(irq);
 	}
 	spin_unlock(&desc->lock);
+
+	TRACE_IRQ_EXIT();
 }
 
 #ifndef CONFIG_PPC_ISERIES	/* iSeries version is in iSeries_pic.c */
diff -urN linux-2.5.33/arch/ppc/kernel/misc.S linux-2.5.33-ltt/arch/ppc/kernel/misc.S
--- linux-2.5.33/arch/ppc/kernel/misc.S	Sat Aug 31 18:04:56 2002
+++ linux-2.5.33-ltt/arch/ppc/kernel/misc.S	Fri Sep  6 12:03:20 2002
@@ -1016,7 +1016,11 @@
  * Create a kernel thread
  *   kernel_thread(fn, arg, flags)
  */
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+_GLOBAL(original_kernel_thread)
+#else
 _GLOBAL(kernel_thread)
+#endif /* (CONFIG_TRACE || CONFIG_TRACE_MODULE) */
 	stwu	r1,-16(r1)
 	stw	r30,8(r1)
 	stw	r31,12(r1)
diff -urN linux-2.5.33/arch/ppc/kernel/process.c linux-2.5.33-ltt/arch/ppc/kernel/process.c
--- linux-2.5.33/arch/ppc/kernel/process.c	Sat Aug 31 18:05:10 2002
+++ linux-2.5.33-ltt/arch/ppc/kernel/process.c	Fri Sep  6 14:23:50 2002
@@ -37,6 +37,8 @@
 #include <linux/prctl.h>
 #include <linux/init_task.h>
 
+#include <linux/trace.h>
+
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -296,6 +298,19 @@
 	printk("\n");
 	show_stack((unsigned long *)regs->gpr[1]);
 }
+
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+long original_kernel_thread(int (*fn) (void *), void* arg, unsigned long flags);
+long kernel_thread(int (*fn) (void *), void* arg, unsigned long flags)
+{
+        long   retval;
+
+	retval = original_kernel_thread(fn, arg, flags);
+	if (retval > 0)
+		TRACE_PROCESS(TRACE_EV_PROCESS_KTHREAD, retval, (int) fn);
+	return retval;
+}
+#endif /* (CONFIG_TRACE || CONFIG_TRACE_MODULE) */
 
 void exit_thread(void)
 {
diff -urN linux-2.5.33/arch/ppc/kernel/syscalls.c linux-2.5.33-ltt/arch/ppc/kernel/syscalls.c
--- linux-2.5.33/arch/ppc/kernel/syscalls.c	Sat Aug 31 18:05:34 2002
+++ linux-2.5.33-ltt/arch/ppc/kernel/syscalls.c	Fri Sep  6 12:03:20 2002
@@ -39,6 +39,8 @@
 #include <linux/utsname.h>
 #include <linux/file.h>
 
+#include <linux/trace.h>
+
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 #include <asm/semaphore.h>
@@ -84,6 +86,8 @@
 
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
+
+	TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
 
 	ret = -EINVAL;
 	switch (call) {
diff -urN linux-2.5.33/arch/ppc/kernel/time.c linux-2.5.33-ltt/arch/ppc/kernel/time.c
--- linux-2.5.33/arch/ppc/kernel/time.c	Sat Aug 31 18:04:52 2002
+++ linux-2.5.33-ltt/arch/ppc/kernel/time.c	Fri Sep  6 14:26:12 2002
@@ -60,6 +60,8 @@
 #include <linux/time.h>
 #include <linux/init.h>
 
+#include <linux/trace.h>
+
 #include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -161,6 +163,8 @@
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
 
+ 	TRACE_TRAP_ENTRY(regs->trap, instruction_pointer(regs));
+
 	irq_enter();
 	
 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
@@ -215,6 +219,8 @@
 		ppc_md.heartbeat();
 
 	irq_exit();
+
+ 	TRACE_TRAP_EXIT();
 }
 #endif /* CONFIG_PPC_ISERIES */
 
diff -urN linux-2.5.33/arch/ppc/kernel/traps.c linux-2.5.33-ltt/arch/ppc/kernel/traps.c
--- linux-2.5.33/arch/ppc/kernel/traps.c	Sat Aug 31 18:04:52 2002
+++ linux-2.5.33-ltt/arch/ppc/kernel/traps.c	Fri Sep  6 12:03:20 2002
@@ -33,6 +33,8 @@
 #include <linux/config.h>
 #include <linux/init.h>
 
+#include <linux/trace.h>
+
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -111,7 +113,9 @@
 		debugger(regs);
 		die("Exception in kernel mode", regs, signr);
 	}
+	TRACE_TRAP_ENTRY(regs->trap, instruction_pointer(regs));
 	force_sig(signr, current);
+	TRACE_TRAP_EXIT();
 }
 
 void
@@ -369,6 +373,89 @@
 	show_regs(regs);
 	panic("kernel stack overflow");
 }
+
+/* Trace related code */
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+asmlinkage void trace_real_syscall_entry(struct pt_regs * regs)
+{
+        int                 use_depth;
+	int                 use_bounds;
+	int                 depth = 0;
+        int                 seek_depth;
+        unsigned long       lower_bound;
+        unsigned long       upper_bound;
+	unsigned long       addr;
+	unsigned long*      stack;
+	trace_syscall_entry trace_syscall_event;
+
+        /* Set the syscall ID */
+	trace_syscall_event.syscall_id = (uint8_t) regs->gpr[0];
+
+	/* Set the address in any case */
+	trace_syscall_event.address  = instruction_pointer(regs);
+
+	/* Are we in the kernel (This is a kernel thread)? */
+	if(!user_mode(regs))
+	  /* Don't go digining anywhere */
+	  goto trace_syscall_end;
+
+	/* Get the trace configuration */
+	if(trace_get_config(&use_depth,
+			    &use_bounds,
+			    &seek_depth,
+			    (void*)&lower_bound,
+			    (void*)&upper_bound) < 0)
+	  goto trace_syscall_end;
+
+	/* Do we have to search for an eip address range */
+	if((use_depth == 1) || (use_bounds == 1))
+	  {
+	  /* Start at the top of the stack (bottom address since stacks grow downward) */
+	  stack = (unsigned long*) regs->gpr[1];
+
+	  /* Skip over first stack frame as the return address isn't valid */
+	  if(get_user(addr, stack))
+	    goto trace_syscall_end;
+	  stack = (unsigned long*) addr;
+
+	  /* Keep on going until we reach the end of the process' stack limit (wherever it may be) */
+	  while(!get_user(addr, stack + 1)) /* "stack + 1", since this is where the IP is */
+	    {
+	    /* Does this LOOK LIKE an address in the program */
+	    if((addr > current->mm->start_code)
+             &&(addr < current->mm->end_code))
+	      {
+	      /* Does this address fit the description */
+	      if(((use_depth == 1) && (depth == seek_depth))
+               ||((use_bounds == 1) && (addr > lower_bound) && (addr < upper_bound)))
+		{
+		/* Set the address */
+		trace_syscall_event.address = addr;
+
+		/* We're done */
+		goto trace_syscall_end;
+		}
+	      else
+		/* We're one depth more */
+		depth++;
+	      }
+	    /* Go on to the next address */
+	    if(get_user(addr, stack))
+	      goto trace_syscall_end;
+	    stack = (unsigned long*) addr;
+	    }
+	  }
+
+trace_syscall_end:
+	/* Trace the event */
+	trace_event(TRACE_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+        trace_event(TRACE_EV_SYSCALL_EXIT, NULL);
+}
+#endif /* (CONFIG_TRACE || CONFIG_TRACE_MODULE) */
 
 void nonrecoverable_exception(struct pt_regs *regs)
 {
diff -urN linux-2.5.33/arch/ppc/mm/fault.c linux-2.5.33-ltt/arch/ppc/mm/fault.c
--- linux-2.5.33/arch/ppc/mm/fault.c	Sat Aug 31 18:04:54 2002
+++ linux-2.5.33-ltt/arch/ppc/mm/fault.c	Fri Sep  6 12:03:20 2002
@@ -31,6 +31,8 @@
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
 
+#include <linux/trace.h>
+
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/mmu.h>
@@ -88,22 +90,28 @@
 		is_write = error_code & 0x02000000;
 #endif /* CONFIG_4xx */
 
+	TRACE_TRAP_ENTRY(regs->trap, instruction_pointer(regs));
+
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_fault_handler && TRAP(regs) == 0x300) {
 		debugger_fault_handler(regs);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 #if !defined(CONFIG_4xx)
 	if (error_code & 0x00400000) {
 		/* DABR match */
-		if (debugger_dabr_match(regs))
+		if (debugger_dabr_match(regs)){
+			TRACE_TRAP_EXIT();
 			return;
+		}
 	}
 #endif /* !CONFIG_4xx */
 #endif /* CONFIG_XMON || CONFIG_KGDB */
 
 	if (in_interrupt() || mm == NULL) {
 		bad_page_fault(regs, address, SIGSEGV);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 	down_read(&mm->mmap_sem);
@@ -168,6 +176,7 @@
 			_tlbie(address);
 			pte_unmap(ptep);
 			up_read(&mm->mmap_sem);
+			TRACE_TRAP_EXIT();
 			return;
 		}
 		if (ptep != NULL)
@@ -210,6 +219,7 @@
 	 * -- Cort
 	 */
 	pte_misses++;
+	TRACE_TRAP_EXIT();
 	return;
 
 bad_area:
@@ -223,10 +233,12 @@
 		info.si_code = code;
 		info.si_addr = (void *) address;
 		force_sig_info(SIGSEGV, &info, current);
+		TRACE_TRAP_EXIT();
 		return;
 	}
 
 	bad_page_fault(regs, address, SIGSEGV);
+	TRACE_TRAP_EXIT();
 	return;
 
 /*
@@ -244,6 +256,7 @@
 	if (user_mode(regs))
 		do_exit(SIGKILL);
 	bad_page_fault(regs, address, SIGKILL);
+	TRACE_TRAP_EXIT();
 	return;
 
 do_sigbus:
@@ -255,6 +268,7 @@
 	force_sig_info (SIGBUS, &info, current);
 	if (!user_mode(regs))
 		bad_page_fault(regs, address, SIGBUS);
+	TRACE_TRAP_EXIT();
 }
 
 /*
diff -urN linux-2.5.33/include/asm-ppc/trace.h linux-2.5.33-ltt/include/asm-ppc/trace.h
--- linux-2.5.33/include/asm-ppc/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.33-ltt/include/asm-ppc/trace.h	Fri Sep  6 12:03:21 2002
@@ -0,0 +1,30 @@
+/*
+ * linux/include/asm-ppc/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * PowerPC definitions for tracing system
+ */
+
+#include <linux/config.h>
+#include <linux/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_PPC
+
+/* PowerPC variants */
+#define TRACE_ARCH_VARIANT_PPC_4xx          1   /* 4xx systems (IBM embedded series) */
+#define TRACE_ARCH_VARIANT_PPC_6xx          2   /* 6xx/7xx/74xx/8260/POWER3 systems (desktop flavor) */
+#define TRACE_ARCH_VARIANT_PPC_8xx          3   /* 8xx system (Motoral embedded series) */
+#define TRACE_ARCH_VARIANT_PPC_ISERIES      4   /* 8xx system (iSeries) */
+
+/* Current variant type */
+#if defined(CONFIG_4xx)
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_PPC_4xx
+#elif defined(CONFIG_6xx)
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_PPC_6xx
+#elif defined(CONFIG_8xx)
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_PPC_8xx
+#elif defined(CONFIG_PPC_ISERIES)
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_PPC_ISERIES
+#endif
