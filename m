Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbTCIQ3a>; Sun, 9 Mar 2003 11:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262537AbTCIQ3a>; Sun, 9 Mar 2003 11:29:30 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:3812 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262536AbTCIQ31>; Sun, 9 Mar 2003 11:29:27 -0500
Date: Sun, 9 Mar 2003 17:39:45 +0100
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] Fast path context switch - microoptimize FPU reload
Message-ID: <20030309163945.GA2443@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following some changes on x86-64.

When cpu_has_fxsr is defined to 1 like in many kernels unlazy_fpu can 
collapse to three instructions. For that inlining is a very good idea.
Otherwise it's 10 instructions or so, which can be still inlined.

We don't need the lock prefix to test our local thread flags state.
Unfortunately test_thread_flag currently always uses test_bit which
has a LOCK on SMP, but that's unnecessary. LOCK is costly on P4,
so it's a good idea to avoid it.

Work around this for now by testing directly. Better would be 
probably to define __set_bit for all architectures to not guarantee
atomicity and then always use that for local thread_info accesses
in linux/thread_info.h

-Andi

diff -u linux-2.5.63-work/arch/i386/kernel/i387.c-FPU linux-2.5.63-work/arch/i386/kernel/i387.c
--- linux-2.5.63-work/arch/i386/kernel/i387.c-FPU	2003-02-10 19:39:17.000000000 +0100
+++ linux-2.5.63-work/arch/i386/kernel/i387.c	2003-03-05 00:23:19.000000000 +0100
@@ -52,24 +52,6 @@
  * FPU lazy state save handling.
  */
 
-static inline void __save_init_fpu( struct task_struct *tsk )
-{
-	if ( cpu_has_fxsr ) {
-		asm volatile( "fxsave %0 ; fnclex"
-			      : "=m" (tsk->thread.i387.fxsave) );
-	} else {
-		asm volatile( "fnsave %0 ; fwait"
-			      : "=m" (tsk->thread.i387.fsave) );
-	}
-	clear_tsk_thread_flag(tsk, TIF_USEDFPU);
-}
-
-void save_init_fpu( struct task_struct *tsk )
-{
-	__save_init_fpu(tsk);
-	stts();
-}
-
 void kernel_fpu_begin(void)
 {
 	preempt_disable();
diff -u linux-2.5.63-work/include/asm-i386/i387.h-FPU linux-2.5.63-work/include/asm-i386/i387.h
--- linux-2.5.63-work/include/asm-i386/i387.h-FPU	2003-02-10 19:38:49.000000000 +0100
+++ linux-2.5.63-work/include/asm-i386/i387.h	2003-03-05 00:23:19.000000000 +0100
@@ -21,23 +21,41 @@
 /*
  * FPU lazy state save handling...
  */
-extern void save_init_fpu( struct task_struct *tsk );
 extern void restore_fpu( struct task_struct *tsk );
 
 extern void kernel_fpu_begin(void);
 #define kernel_fpu_end() do { stts(); preempt_enable(); } while(0)
 
 
+static inline void __save_init_fpu( struct task_struct *tsk )
+{
+	if ( cpu_has_fxsr ) {
+		asm volatile( "fxsave %0 ; fnclex"
+			      : "=m" (tsk->thread.i387.fxsave) );
+	} else {
+		asm volatile( "fnsave %0 ; fwait"
+			      : "=m" (tsk->thread.i387.fsave) );
+	}
+	tsk->thread_info->flags &= ~TIF_USEDFPU;
+}
+
+static inline void save_init_fpu( struct task_struct *tsk )
+{
+	__save_init_fpu(tsk);
+	stts();
+}
+
+
 #define unlazy_fpu( tsk ) do { \
-	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) \
+	if ((tsk)->thread_info->flags & _TIF_USEDFPU) \
 		save_init_fpu( tsk ); \
 } while (0)
 
 #define clear_fpu( tsk )					\
 do {								\
-	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) {		\
+	if ((tsk)->thread_info->flags & _TIF_USEDFPU) {		\
 		asm volatile("fwait");				\
-		clear_tsk_thread_flag(tsk, TIF_USEDFPU);	\
+		(tsk)->thread_info->flags &= ~_TIF_USEDFPU;	\
 		stts();						\
 	}							\
 } while (0)




