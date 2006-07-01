Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWGAROK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWGAROK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWGAROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 13:14:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34716 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751898AbWGARNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 13:13:52 -0400
Subject: [patch 2/2] sLeAZY FPU feature - i386 support
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
In-Reply-To: <1151773893.3195.45.camel@laptopd505.fenrus.org>
References: <1151773893.3195.45.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 19:13:35 +0200
Message-Id: <1151774015.3195.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Ebbert <76306.1226@compuserve.com>

i386 port of the sLeAZY-fpu feature. 
Chuck reports that this gives him a +/- 0.4% improvement on his
simple benchmark

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

 arch/i386/kernel/process.c |   12 ++++++++++++
 arch/i386/kernel/traps.c   |    3 ++-
 include/asm-i386/i387.h    |    5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

Index: linux-2.6.17-sleazyfpu/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.17-sleazyfpu.orig/arch/i386/kernel/process.c
+++ linux-2.6.17-sleazyfpu/arch/i386/kernel/process.c
@@ -631,6 +631,11 @@ struct task_struct fastcall * __switch_t
 
 	__unlazy_fpu(prev_p);
 
+
+	/* we're going to use this soon, after a few expensive things */
+	if (next_p->fpu_counter > 5)
+		prefetch(&next->i387.fxsave);
+
 	/*
 	 * Reload esp0.
 	 */
@@ -689,6 +694,13 @@ struct task_struct fastcall * __switch_t
 
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
 
Index: linux-2.6.17-sleazyfpu/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.17-sleazyfpu.orig/arch/i386/kernel/traps.c
+++ linux-2.6.17-sleazyfpu/arch/i386/kernel/traps.c
@@ -1063,7 +1063,7 @@ fastcall unsigned char * fixup_x86_bogus
  * Must be called with kernel preemption disabled (in this case,
  * local interrupts are disabled at the call-site in entry.S).
  */
-asmlinkage void math_state_restore(struct pt_regs regs)
+asmlinkage void math_state_restore(void)
 {
 	struct thread_info *thread = current_thread_info();
 	struct task_struct *tsk = thread->task;
@@ -1073,6 +1073,7 @@ asmlinkage void math_state_restore(struc
 		init_fpu(tsk);
 	restore_fpu(tsk);
 	thread->status |= TS_USEDFPU;	/* So we fnsave on switch_to() */
+	tsk->fpu_counter++;
 }
 
 #ifndef CONFIG_MATH_EMULATION
Index: linux-2.6.17-sleazyfpu/include/asm-i386/i387.h
===================================================================
--- linux-2.6.17-sleazyfpu.orig/include/asm-i386/i387.h
+++ linux-2.6.17-sleazyfpu/include/asm-i386/i387.h
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


