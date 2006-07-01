Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWGAQZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWGAQZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 12:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWGAQZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 12:25:04 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:23531 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751052AbWGAQZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 12:25:01 -0400
Date: Sat, 1 Jul 2006 12:22:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: RFC: unlazy fpu for frequent fpu users
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607011223_MC3-1-C3F2-7653@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1151756010.3195.31.camel@laptopd505.fenrus.org>

On Sat, 01 Jul 2006 14:13:30 +0200, Arjan van de Ven wrote:

> > You can do better that that.  FXSR doesn't destroy the FPU contents; if
> > you track the context carefully you can completely avoid the restore.
> > This requires keeping a per-cpu variable that holds a pointer to the
> 
> to be honest, while I like the idea, it does scare me from a security
> point of view, both in terms of leaks and in terms of injecting bad
> stuff. 

I thought about it and couldn't find any obvious problems.  If there
are leaks then they're already possible because we always leave the
stale context in the FPU when we switch (except on K7/K8.)  And if a
task touches the FPU the stale context gets overwritten first.

> Can you send me your patch so that I can integrate it (and I'll port
> your if() to the prefetch)... 

OK.  I ported your patch to i386 on top of the perfmon2 patchset, but
by hand editing I got one that will apply with offsets to 2.6.17-mm4.
Not even compile tested against that version...

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/kernel/process.c |   12 ++++++++++++
 arch/i386/kernel/traps.c   |    3 ++-
 include/asm-i386/i387.h    |    5 ++++-
 include/linux/sched.h      |    9 +++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

--- 2.6.17.1-32-pfmon.orig/arch/i386/kernel/process.c
+++ 2.6.17.1-32-pfmon/arch/i386/kernel/process.c
@@ -635,6 +635,11 @@ struct task_struct fastcall * __switch_t
 
 	__unlazy_fpu(prev_p);
 
+
+	if (next_p->fpu_counter > 5)
+		/* prefetch the fxsave area into the cache */
+		prefetch(&next->i387.fxsave);
+
 	/*
 	 * Reload esp0.
 	 */
@@ -693,6 +698,13 @@ struct task_struct fastcall * __switch_t
 
 	disable_tsc(prev_p, next_p);
 
+	/* If the task has used fpu the last 5 timeslices, just do a full
+	 * restore of the math state immediately to avoid the trap; the
+	 * chances of needing FPU soon are obviously high now
+	 */
+	if (next_p->fpu_counter > 5)
+		math_state_restore();
+
 	return prev_p;
 }
 
--- 2.6.17.1-32-pfmon.orig/arch/i386/kernel/traps.c
+++ 2.6.17.1-32-pfmon/arch/i386/kernel/traps.c
@@ -1046,7 +1046,7 @@ fastcall unsigned char * fixup_x86_bogus
  * Must be called with kernel preemption disabled (in this case,
  * local interrupts are disabled at the call-site in entry.S).
  */
-asmlinkage void math_state_restore(struct pt_regs regs)
+asmlinkage void math_state_restore(void)
 {
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = thread->task;
@@ -1056,6 +1056,7 @@ asmlinkage void math_state_restore(struc
 		init_fpu(tsk);
 	restore_fpu(tsk);
 	thread->status |= TS_USEDFPU;	/* So we fnsave on switch_to() */
+	tsk->fpu_counter++;
 }
 
 #ifndef CONFIG_MATH_EMULATION
--- 2.6.17.1-32-pfmon.orig/include/asm-i386/i387.h
+++ 2.6.17.1-32-pfmon/include/asm-i386/i387.h
@@ -76,7 +76,9 @@ static inline void __save_init_fpu( stru
 
 #define __unlazy_fpu( tsk ) do { \
 	if (task_thread_info(tsk)->status & TS_USEDFPU) \
-		save_init_fpu( tsk ); \
+		save_init_fpu( tsk ); 			\
+	else						\
+		tsk->fpu_counter = 0;			\
 } while (0)
 
 #define __clear_fpu( tsk )					\
@@ -118,6 +120,7 @@ static inline void save_init_fpu( struct
 extern unsigned short get_fpu_cwd( struct task_struct *tsk );
 extern unsigned short get_fpu_swd( struct task_struct *tsk );
 extern unsigned short get_fpu_mxcsr( struct task_struct *tsk );
+extern asmlinkage void math_state_restore(void);
 
 /*
  * Signal frame handlers...
--- 2.6.17.1-32-pfmon.orig/include/linux/sched.h
+++ 2.6.17.1-32-pfmon/include/linux/sched.h
@@ -893,6 +893,15 @@ struct task_struct {
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
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
