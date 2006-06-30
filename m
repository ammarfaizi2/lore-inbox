Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWF3WMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWF3WMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWF3WMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:12:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63202 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751291AbWF3WMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:12:18 -0400
Subject: RFC: unlazy fpu for frequent fpu users
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 01 Jul 2006 00:12:16 +0200
Message-Id: <1151705536.11434.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

right now the kernel on x86-64 has a 100% lazy fpu behavior: after
*every* context switch a trap is taken for the first FPU use to restore
the FPU context lazily. This is of course great for applications that
have very sporadic or no FPU use (since then you avoid doing the
expensive save/restore all the time). However for very frequent FPU
users... you take an extra trap every context switch.

The patch below adds a simple heuristic to this code: After 5
consecutive context switches of FPU use, the lazy behavior is disabled
and the context gets restored every context switch. If the app indeed
uses the FPU, the trap is avoided. (the chance of the 6th time slice
using FPU after the previous 5 having done so are quite high obviously).

After 256 switches, this is reset and lazy behavior is returned (until
there are 5 consecutive ones again). The reason for this is to give apps
that do longer bursts of FPU use still the lazy behavior back after some
time.

I've done some very simple, unscientific, benchmarks and these showed a
very small performance increase; I'll try to do some better benchmarks
soon.


This is not a request for merge but a request for comments.. do people
think this is a useful idea? Also.. I'd love to get benchmarks on
not-my-machine with this...


---
 arch/x86_64/kernel/process.c |    9 +++++++++
 arch/x86_64/kernel/traps.c   |    1 +
 include/asm-x86_64/i387.h    |    5 ++++-
 include/linux/sched.h        |    9 +++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)

Index: linux-2.6.17-sleazyfpu/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.17-sleazyfpu.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.17-sleazyfpu/arch/x86_64/kernel/process.c
@@ -515,6 +515,9 @@ __switch_to(struct task_struct *prev_p, 
 	int cpu = smp_processor_id();  
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
+	/* prefetch the fxsave area into the cache */
+	prefetch(&next->i387.fxsave);
+
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
@@ -618,6 +621,12 @@ __switch_to(struct task_struct *prev_p, 
 		}
 	}
 
+	/* If the task has used fpu the last 5 timeslices, just do a full
+	 * restore of the math state immediately to avoid the trap; the
+	 * chances of needing FPU soon are obviously high now
+	 */
+	if (next_p->fpu_counter>5)
+		math_state_restore();
 	return prev_p;
 }
 
Index: linux-2.6.17-sleazyfpu/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.17-sleazyfpu.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.17-sleazyfpu/arch/x86_64/kernel/traps.c
@@ -1061,6 +1061,7 @@ asmlinkage void math_state_restore(void)
 		init_fpu(me);
 	restore_fpu_checking(&me->thread.i387.fxsave);
 	task_thread_info(me)->status |= TS_USEDFPU;
+	me->fpu_counter++;
 }
 
 void __init trap_init(void)
Index: linux-2.6.17-sleazyfpu/include/asm-x86_64/i387.h
===================================================================
--- linux-2.6.17-sleazyfpu.orig/include/asm-x86_64/i387.h
+++ linux-2.6.17-sleazyfpu/include/asm-x86_64/i387.h
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
Index: linux-2.6.17-sleazyfpu/include/linux/sched.h
===================================================================
--- linux-2.6.17-sleazyfpu.orig/include/linux/sched.h
+++ linux-2.6.17-sleazyfpu/include/linux/sched.h
@@ -1023,6 +1023,15 @@ struct task_struct {
 	spinlock_t delays_lock;
 	struct task_delay_info *delays;
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
 };
 
 static inline pid_t process_group(struct task_struct *tsk)


