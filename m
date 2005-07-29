Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVG2Uoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVG2Uoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVG2UnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:43:25 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:55019 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S262800AbVG2Umg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:42:36 -0400
Date: Fri, 29 Jul 2005 16:36:04 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc3] i386: semi-lazy i387 context switching
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux@horizon.com, Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Message-ID: <200507291639_MC3-1-A5E6-856C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is not for inclusion -- I just want to see if the idea
is sound.  It's based on suggestions from <linux@horizon.com>

When saving FP context, the current CPU number is saved in the
tasks thread structure, and a pointer to that structure is saved
in a per-cpu data area.

On loading an FP context, the per-cpu pointer is cleared.  (But
the CPU number in the task is untouched.)

Upon task switch, the CPU number in the per-task area is compared to
the current CPU and the per-CPU pointer is checked.  If everything
matches, loading of the FPU context will be skipped.

To prevent extra overhead when a task does short bursts of FP math
and then switches to integer, a normal FPU context load will be forced
after 100 skipped loads.

Problems:
        - As posted, the code only works on machines with fxsr.
          GCC internal errors prevent the commented-out code
          from compiling; I guess a conditional jump is needed.

        - May not be preempt-safe (but AFAICT it is.)

Volanomark profile results are promising:

     Before      After
      8304        8176          device_not_available
     11809       12334          math_state_restore
     -----------------
     20114       20500

So it seems to be reducing the number of traps but each trap takes
a bit longer.  This is a good result from a worst-case scenario.

The other worst-case test is for systems not using FP math at all.
This is untested, and best-case results are still pending as well.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Index: 2.6.13-rc3-mm3/arch/i386/kernel/i387.c
===================================================================
--- 2.6.13-rc3-mm3.orig/arch/i386/kernel/i387.c	2005-07-29 02:26:39.000000000 -0400
+++ 2.6.13-rc3-mm3/arch/i386/kernel/i387.c	2005-07-29 14:41:34.000000000 -0400
@@ -27,6 +27,8 @@
 
 static unsigned long mxcsr_feature_mask = 0xffffffff;
 
+DEFINE_PER_CPU(struct thread_struct *, current_i387_thread);
+
 void mxcsr_feature_mask_init(void)
 {
 	unsigned long mask = 0;
Index: 2.6.13-rc3-mm3/arch/i386/kernel/process.c
===================================================================
--- 2.6.13-rc3-mm3.orig/arch/i386/kernel/process.c	2005-07-29 02:26:39.000000000 -0400
+++ 2.6.13-rc3-mm3/arch/i386/kernel/process.c	2005-07-29 14:41:34.000000000 -0400
@@ -475,6 +475,8 @@
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 
+	p->thread.current_i387_cpu = -1;
+
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
 
@@ -679,8 +681,29 @@
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
-	__unlazy_fpu(prev_p);
+	if (prev_p->thread_info->status & TS_USEDFPU) {
+		save_init_fpu(prev_p);
+		goto lazy_load;
+	}
+
+	/* This breaks GCC 3.3 and 4.0.1 (internal compiler error)  */
+//	alternative_input( /* do lazy restore if fxsr unsupported */
+//		"jmp %1",
+//		"",
+//		X86_FEATURE_FXSR,
+//		"a" (*&&lazy_load));
+
+	if (next->current_i387_cpu == smp_processor_id()
+	    && next == per_cpu(current_i387_thread, smp_processor_id())) {
+
+		if (likely(++next->lazy_i387_switches < 100)) {
+			next_p->thread_info->status |= TS_USEDFPU;
+			clts();
+		} else
+			next->lazy_i387_switches = 0;
+	}
 
+lazy_load:
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
Index: 2.6.13-rc3-mm3/include/asm-i386/i387.h
===================================================================
--- 2.6.13-rc3-mm3.orig/include/asm-i386/i387.h	2005-07-29 14:32:03.000000000 -0400
+++ 2.6.13-rc3-mm3/include/asm-i386/i387.h	2005-07-29 14:41:34.000000000 -0400
@@ -17,6 +17,8 @@
 #include <asm/sigcontext.h>
 #include <asm/user.h>
 
+DECLARE_PER_CPU(struct thread_struct *, current_i387_thread);
+
 extern void mxcsr_feature_mask_init(void);
 extern void init_fpu(struct task_struct *);
 
@@ -24,16 +26,31 @@
  * FPU lazy state save handling...
  */
 
-/*
- * The "nop" is needed to make the instructions the same
- * length.
- */
-#define restore_fpu(tsk)			\
-	alternative_input(			\
-		"nop ; frstor %1",		\
-		"fxrstor %1",			\
-		X86_FEATURE_FXSR,		\
-		"m" ((tsk)->thread.i387.fxsave))
+static inline void restore_fpu( struct task_struct *tsk )
+{
+	/*
+	 * The "nop" is needed to make the instructions the same
+	 * length.
+	 */
+	alternative_input(
+		"frstor %1 ; nop",
+		"fxrstor %1",
+		X86_FEATURE_FXSR,
+		"m" (tsk->thread.i387.fxsave));
+
+	/* This breaks GCC 3.3 and 4.0.1 (internal compiler error)  */
+//	alternative_input( /* skip ahead if fxsr unsupported */
+//		"jmp %1",
+//		"",
+//		X86_FEATURE_FXSR,
+//		"a" (*&&no_fxsr));
+
+	/* ??? is preempt disabled when this is called? */
+	per_cpu(current_i387_thread, smp_processor_id()) = 0;
+no_fxsr:
+	__attribute__((unused))
+	return;  /* required to avoid gcc error */
+}
 
 extern void kernel_fpu_begin(void);
 #define kernel_fpu_end() do { stts(); preempt_enable(); } while(0)
@@ -49,6 +66,18 @@
 		X86_FEATURE_FXSR,
 		"m" (tsk->thread.i387.fxsave)
 		:"memory");
+
+	/* This breaks GCC 3.3 and 4.0.1 (internal compiler error)  */
+//	alternative_input( /* skip ahead if fxsr unsupported */
+//		"jmp %1",
+//		"",
+//		X86_FEATURE_FXSR,
+//		"a" (*&&no_fxsr));
+
+	tsk->thread.current_i387_cpu = smp_processor_id();
+	per_cpu(current_i387_thread, smp_processor_id()) = &tsk->thread;
+no_fxsr:
+	__attribute__((unused))
 	tsk->thread_info->status &= ~TS_USEDFPU;
 }
 
Index: 2.6.13-rc3-mm3/include/asm-i386/processor.h
===================================================================
--- 2.6.13-rc3-mm3.orig/include/asm-i386/processor.h	2005-07-13 16:20:26.000000000 -0400
+++ 2.6.13-rc3-mm3/include/asm-i386/processor.h	2005-07-29 14:41:34.000000000 -0400
@@ -447,6 +447,7 @@
 	unsigned long	cr2, trap_no, error_code;
 /* floating point info */
 	union i387_union	i387;
+	int    current_i387_cpu, lazy_i387_switches;
 /* virtual 86 mode info */
 	struct vm86_struct __user * vm86_info;
 	unsigned long		screen_bitmap;
__
Chuck
