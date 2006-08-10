Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWHJUO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWHJUO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWHJTfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:22672 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932121AbWHJTfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:45 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [30/145] x86_64: x86-64 TIF flags for debug regs and io bitmap in ctxsw
Message-Id: <20060810193543.B7AB713B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:43 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Stephane Eranian <eranian@hpl.hp.com>
Hello,

Following my discussion with Andi. Here is a patch that introduces
two new TIF flags to simplify the context switch code in __switch_to().
The idea is to minimize the number of cache lines accessed in the common
case, i.e., when neither the debug registers nor the I/O bitmap are used.

This patch covers the x86-64 modifications. A patch for i386 follows.

Changelog:
	- add TIF_DEBUG to track when debug registers are active
	- add TIF_IO_BITMAP to track when I/O bitmap is used
	- modify __switch_to() to use the new TIF flags

<signed-off-by>: eranian@hpl.hp.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/ia32/ptrace32.c      |    4 ++
 arch/x86_64/kernel/ioport.c      |    1 
 arch/x86_64/kernel/process.c     |   73 ++++++++++++++++++++++-----------------
 arch/x86_64/kernel/ptrace.c      |    8 +++-
 include/asm-x86_64/thread_info.h |    7 +++
 5 files changed, 60 insertions(+), 33 deletions(-)

Index: linux/arch/x86_64/ia32/ptrace32.c
===================================================================
--- linux.orig/arch/x86_64/ia32/ptrace32.c
+++ linux/arch/x86_64/ia32/ptrace32.c
@@ -117,6 +117,10 @@ static int putreg32(struct task_struct *
 			if ((0x5454 >> ((val >> (16 + 4*i)) & 0xf)) & 1)
 			       return -EIO;
 		child->thread.debugreg7 = val; 
+		if (val)
+			set_tsk_thread_flag(child, TIF_DEBUG);
+		else
+			clear_tsk_thread_flag(child, TIF_DEBUG);
 		break; 
 		    
 	default:
Index: linux/arch/x86_64/kernel/ioport.c
===================================================================
--- linux.orig/arch/x86_64/kernel/ioport.c
+++ linux/arch/x86_64/kernel/ioport.c
@@ -56,6 +56,7 @@ asmlinkage long sys_ioperm(unsigned long
 
 		memset(bitmap, 0xff, IO_BITMAP_BYTES);
 		t->io_bitmap_ptr = bitmap;
+		set_thread_flag(TIF_IO_BITMAP);
 	}
 
 	/*
Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -350,6 +350,7 @@ void exit_thread(void)
 
 		kfree(t->io_bitmap_ptr);
 		t->io_bitmap_ptr = NULL;
+		clear_thread_flag(TIF_IO_BITMAP);
 		/*
 		 * Careful, clear this in the TSS too:
 		 */
@@ -369,6 +370,7 @@ void flush_thread(void)
 		if (t->flags & _TIF_IA32)
 			current_thread_info()->status |= TS_COMPAT;
 	}
+	t->flags &= ~_TIF_DEBUG;
 
 	tsk->thread.debugreg0 = 0;
 	tsk->thread.debugreg1 = 0;
@@ -461,7 +463,7 @@ int copy_thread(int nr, unsigned long cl
 	asm("mov %%es,%0" : "=m" (p->thread.es));
 	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
-	if (unlikely(me->thread.io_bitmap_ptr != NULL)) { 
+	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
 			p->thread.io_bitmap_max = 0;
@@ -469,6 +471,7 @@ int copy_thread(int nr, unsigned long cl
 		}
 		memcpy(p->thread.io_bitmap_ptr, me->thread.io_bitmap_ptr,
 				IO_BITMAP_BYTES);
+		set_tsk_thread_flag(p, TIF_IO_BITMAP);
 	} 
 
 	/*
@@ -498,6 +501,40 @@ out:
  */
 #define loaddebug(thread,r) set_debugreg(thread->debugreg ## r, r)
 
+static inline void __switch_to_xtra(struct task_struct *prev_p,
+			     	    struct task_struct *next_p,
+			     	    struct tss_struct *tss)
+{
+	struct thread_struct *prev, *next;
+
+	prev = &prev_p->thread,
+	next = &next_p->thread;
+
+	if (test_tsk_thread_flag(next_p, TIF_DEBUG)) {
+		loaddebug(next, 0);
+		loaddebug(next, 1);
+		loaddebug(next, 2);
+		loaddebug(next, 3);
+		/* no 4 and 5 */
+		loaddebug(next, 6);
+		loaddebug(next, 7);
+	}
+
+	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
+		/*
+		 * Copy the relevant range of the IO bitmap.
+		 * Normally this is 128 bytes or less:
+		 */
+		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
+		       max(prev->io_bitmap_max, next->io_bitmap_max));
+	} else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
+		/*
+		 * Clear any possible leftover bits:
+		 */
+		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
+	}
+}
+
 /*
  *	switch_to(x,y) should switch tasks from x to y.
  *
@@ -586,37 +623,11 @@ __switch_to(struct task_struct *prev_p, 
 		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
 
 	/*
-	 * Now maybe reload the debug registers
+	 * Now maybe reload the debug registers and handle I/O bitmaps
 	 */
-	if (unlikely(next->debugreg7)) {
-		loaddebug(next, 0);
-		loaddebug(next, 1);
-		loaddebug(next, 2);
-		loaddebug(next, 3);
-		/* no 4 and 5 */
-		loaddebug(next, 6);
-		loaddebug(next, 7);
-	}
-
-
-	/* 
-	 * Handle the IO bitmap 
-	 */ 
-	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr)) {
-		if (next->io_bitmap_ptr)
-			/*
-			 * Copy the relevant range of the IO bitmap.
-			 * Normally this is 128 bytes or less:
- 			 */
-			memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-				max(prev->io_bitmap_max, next->io_bitmap_max));
-		else {
-			/*
-			 * Clear any possible leftover bits:
-			 */
-			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
-		}
-	}
+	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
+	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
+		__switch_to_xtra(prev_p, next_p, tss);
 
 	return prev_p;
 }
Index: linux/arch/x86_64/kernel/ptrace.c
===================================================================
--- linux.orig/arch/x86_64/kernel/ptrace.c
+++ linux/arch/x86_64/kernel/ptrace.c
@@ -420,9 +420,13 @@ long arch_ptrace(struct task_struct *chi
 				if ((0x5554 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
 					break;
 			if (i == 4) {
-				child->thread.debugreg7 = data;
+			  child->thread.debugreg7 = data;
+			  if (data)
+			  	set_tsk_thread_flag(child, TIF_DEBUG);
+			  else
+			  	clear_tsk_thread_flag(child, TIF_DEBUG);
 			  ret = 0;
-		  }
+		  	}
 		  break;
 		}
 		break;
Index: linux/include/asm-x86_64/thread_info.h
===================================================================
--- linux.orig/include/asm-x86_64/thread_info.h
+++ linux/include/asm-x86_64/thread_info.h
@@ -120,6 +120,8 @@ static inline struct thread_info *stack_
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
 #define TIF_MEMDIE		20
+#define TIF_DEBUG		21	/* uses debug registers */
+#define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -133,6 +135,8 @@ static inline struct thread_info *stack_
 #define _TIF_IA32		(1<<TIF_IA32)
 #define _TIF_FORK		(1<<TIF_FORK)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
+#define _TIF_DEBUG		(1<<TIF_DEBUG)
+#define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -140,6 +144,9 @@ static inline struct thread_info *stack_
 /* work to do on any return to user space */
 #define _TIF_ALLWORK_MASK (0x0000FFFF & ~_TIF_SECCOMP)
 
+/* flags to check in __switch_to() */
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+
 #define PREEMPT_ACTIVE     0x10000000
 
 /*
