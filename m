Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWGDHgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWGDHgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWGDHgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:36:45 -0400
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:42686 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751100AbWGDHgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:36:44 -0400
Date: Tue, 4 Jul 2006 00:28:32 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>, ak@suse.de
Subject: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in ctxsw
Message-ID: <20060704072832.GB5902@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

diff -urNp linux-2.6.17.2.orig/arch/x86_64/ia32/ptrace32.c linux-2.6.17.2-tif/arch/x86_64/ia32/ptrace32.c
--- linux-2.6.17.2.orig/arch/x86_64/ia32/ptrace32.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/arch/x86_64/ia32/ptrace32.c	2006-06-30 09:02:16.000000000 -0700
@@ -118,6 +118,10 @@ static int putreg32(struct task_struct *
 			if ((0x5454 >> ((val >> (16 + 4*i)) & 0xf)) & 1)
 			       return -EIO;
 		child->thread.debugreg7 = val; 
+		if (val)
+			set_tsk_thread_flag(child, TIF_DEBUG);
+		else
+			clear_tsk_thread_flag(child, TIF_DEBUG);
 		break; 
 		    
 	default:
diff -urNp linux-2.6.17.2.orig/arch/x86_64/kernel/ioport.c linux-2.6.17.2-tif/arch/x86_64/kernel/ioport.c
--- linux-2.6.17.2.orig/arch/x86_64/kernel/ioport.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/arch/x86_64/kernel/ioport.c	2006-07-03 02:06:59.000000000 -0700
@@ -56,6 +56,7 @@ asmlinkage long sys_ioperm(unsigned long
 
 		memset(bitmap, 0xff, IO_BITMAP_BYTES);
 		t->io_bitmap_ptr = bitmap;
+		set_thread_flag(TIF_IO_BITMAP);
 	}
 
 	/*
diff -urNp linux-2.6.17.2.orig/arch/x86_64/kernel/process.c linux-2.6.17.2-tif/arch/x86_64/kernel/process.c
--- linux-2.6.17.2.orig/arch/x86_64/kernel/process.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/arch/x86_64/kernel/process.c	2006-07-03 23:48:08.000000000 -0700
@@ -351,6 +351,7 @@ void exit_thread(void)
 
 		kfree(t->io_bitmap_ptr);
 		t->io_bitmap_ptr = NULL;
+		clear_thread_flag(TIF_IO_BITMAP);
 		/*
 		 * Careful, clear this in the TSS too:
 		 */
@@ -366,7 +367,7 @@ void flush_thread(void)
 	struct thread_info *t = current_thread_info();
 
 	if (t->flags & _TIF_ABI_PENDING)
-		t->flags ^= (_TIF_ABI_PENDING | _TIF_IA32);
+		t->flags ^= (_TIF_ABI_PENDING | _TIF_IA32 | _TIF_DEBUG);
 
 	tsk->thread.debugreg0 = 0;
 	tsk->thread.debugreg1 = 0;
@@ -459,7 +460,7 @@ int copy_thread(int nr, unsigned long cl
 	asm("mov %%es,%0" : "=m" (p->thread.es));
 	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
-	if (unlikely(me->thread.io_bitmap_ptr != NULL)) { 
+	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) { 
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
 			p->thread.io_bitmap_max = 0;
@@ -467,6 +468,7 @@ int copy_thread(int nr, unsigned long cl
 		}
 		memcpy(p->thread.io_bitmap_ptr, me->thread.io_bitmap_ptr,
 				IO_BITMAP_BYTES);
+		set_tsk_thread_flag(p, TIF_IO_BITMAP);
 	} 
 
 	/*
@@ -496,6 +498,40 @@ out:
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
@@ -584,37 +620,11 @@ __switch_to(struct task_struct *prev_p, 
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
diff -urNp linux-2.6.17.2.orig/arch/x86_64/kernel/ptrace.c linux-2.6.17.2-tif/arch/x86_64/kernel/ptrace.c
--- linux-2.6.17.2.orig/arch/x86_64/kernel/ptrace.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/arch/x86_64/kernel/ptrace.c	2006-07-04 00:21:47.000000000 -0700
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
diff -urNp linux-2.6.17.2.orig/include/asm-x86_64/thread_info.h linux-2.6.17.2-tif/include/asm-x86_64/thread_info.h
--- linux-2.6.17.2.orig/include/asm-x86_64/thread_info.h	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/include/asm-x86_64/thread_info.h	2006-07-03 02:32:25.000000000 -0700
@@ -106,6 +106,8 @@ static inline struct thread_info *stack_
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
 #define TIF_MEMDIE		20
+#define TIF_DEBUG		21	/* uses debug registers */
+#define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -119,6 +121,8 @@ static inline struct thread_info *stack_
 #define _TIF_IA32		(1<<TIF_IA32)
 #define _TIF_FORK		(1<<TIF_FORK)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
+#define _TIF_DEBUG		(1<<TIF_DEBUG)
+#define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -126,6 +130,9 @@ static inline struct thread_info *stack_
 /* work to do on any return to user space */
 #define _TIF_ALLWORK_MASK (0x0000FFFF & ~_TIF_SECCOMP)
 
+/* flags to check in __switch_to() */
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+
 #define PREEMPT_ACTIVE     0x10000000
 
 /*
