Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWHJTp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWHJTp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWHJTnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:43:04 -0400
Received: from ns1.suse.de ([195.135.220.2]:35985 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932138AbWHJThg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:36 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [134/145] x86_64: non lazy "sleazy" fpu implementation
Message-Id: <20060810193734.36AD013B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:34 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Arjan van de Ven <arjan@linux.intel.com>

Right now the kernel on x86-64 has a 100% lazy fpu behavior: after *every*
context switch a trap is taken for the first FPU use to restore the FPU
context lazily.  This is of course great for applications that have very
sporadic or no FPU use (since then you avoid doing the expensive
save/restore all the time).  However for very frequent FPU users...  you
take an extra trap every context switch.

The patch below adds a simple heuristic to this code: After 5 consecutive
context switches of FPU use, the lazy behavior is disabled and the context
gets restored every context switch.  If the app indeed uses the FPU, the
trap is avoided.  (the chance of the 6th time slice using FPU after the
previous 5 having done so are quite high obviously).

After 256 switches, this is reset and lazy behavior is returned (until
there are 5 consecutive ones again).  The reason for this is to give apps
that do longer bursts of FPU use still the lazy behavior back after some
time.

[akpm@osdl.org: place new task_struct field next to jit_keyring to save space]
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/kernel/process.c |   10 ++++++++++
 arch/x86_64/kernel/traps.c   |    1 +
 include/asm-x86_64/i387.h    |    5 ++++-
 include/linux/sched.h        |    9 +++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -552,6 +552,10 @@ __switch_to(struct task_struct *prev_p, 
 	int cpu = smp_processor_id();  
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
+	/* we're going to use this soon, after a few expensive things */
+	if (next_p->fpu_counter>5)
+		prefetch(&next->i387.fxsave);
+
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
@@ -629,6 +633,12 @@ __switch_to(struct task_struct *prev_p, 
 	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
 		__switch_to_xtra(prev_p, next_p, tss);
 
+	/* If the task has used fpu the last 5 timeslices, just do a full
+	 * restore of the math state immediately to avoid the trap; the
+	 * chances of needing FPU soon are obviously high now
+	 */
+	if (next_p->fpu_counter>5)
+		math_state_restore();
 	return prev_p;
 }
 
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -1134,6 +1134,7 @@ asmlinkage void math_state_restore(void)
 		init_fpu(me);
 	restore_fpu_checking(&me->thread.i387.fxsave);
 	task_thread_info(me)->status |= TS_USEDFPU;
+	me->fpu_counter++;
 }
 
 void __init trap_init(void)
Index: linux/include/asm-x86_64/i387.h
===================================================================
--- linux.orig/include/asm-x86_64/i387.h
+++ linux/include/asm-x86_64/i387.h
@@ -24,6 +24,7 @@ extern unsigned int mxcsr_feature_mask;
 extern void mxcsr_feature_mask_init(void);
 extern void init_fpu(struct task_struct *child);
 extern int save_i387(struct _fpstate __user *buf);
+extern asmlinkage void math_state_restore(void);
 
 /*
  * FPU lazy state save handling...
@@ -31,7 +32,9 @@ extern int save_i387(struct _fpstate __u
 
 #define unlazy_fpu(tsk) do { \
 	if (task_thread_info(tsk)->status & TS_USEDFPU) \
-		save_init_fpu(tsk); \
+		save_init_fpu(tsk); 			\
+	else						\
+		tsk->fpu_counter = 0;			\
 } while (0)
 
 /* Ignore delayed exceptions from user space */
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -865,6 +865,15 @@ struct task_struct {
 	struct key *thread_keyring;	/* keyring private to this thread */
 	unsigned char jit_keyring;	/* default keyring to attach requested keys to */
 #endif
+	/*
+	 * fpu_counter contains the number of consecutive context switches
+	 * that the FPU is used. If this is over a threshold, the lazy fpu
+	 * saving becomes unlazy to save the trap. This is an unsigned char
+	 * so that after 256 times the counter wraps and the behavior turns
+	 * lazy again; this to deal with bursty apps that only use FPU for
+	 * a short time
+	 */
+	unsigned char fpu_counter;
 	int oomkilladj; /* OOM kill score adjustment (bit shift). */
 	char comm[TASK_COMM_LEN]; /* executable name excluding path
 				     - access with [gs]et_task_comm (which lock
