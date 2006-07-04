Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWGDHhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWGDHhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWGDHhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:37:51 -0400
Received: from palrel13.hp.com ([156.153.255.238]:31888 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1751114AbWGDHhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:37:50 -0400
Date: Tue, 4 Jul 2006 00:29:39 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH 2/2] i386 TIF flags for debug regs and io bitmap in ctxsw
Message-ID: <20060704072939.GC5902@frankl.hpl.hp.com>
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

This patch covers the i386 modifications.

Changelog:
	- add TIF_DEBUG to track when debug registers are active
	- add TIF_IO_BITMAP to track when I/O bitmap is used
	- modify __switch_to() to use the new TIF flags

<signed-off-by>: eranian@hpl.hp.com

diff -urNp linux-2.6.17.2.orig/arch/i386/kernel/ioport.c linux-2.6.17.2-tif/arch/i386/kernel/ioport.c
--- linux-2.6.17.2.orig/arch/i386/kernel/ioport.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/arch/i386/kernel/ioport.c	2006-07-03 09:28:07.000000000 -0700
@@ -79,6 +79,7 @@ asmlinkage long sys_ioperm(unsigned long
 
 		memset(bitmap, 0xff, IO_BITMAP_BYTES);
 		t->io_bitmap_ptr = bitmap;
+		set_thread_flag(TIF_IO_BITMAP);
 	}
 
 	/*
diff -urNp linux-2.6.17.2.orig/arch/i386/kernel/process.c linux-2.6.17.2-tif/arch/i386/kernel/process.c
--- linux-2.6.17.2.orig/arch/i386/kernel/process.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/arch/i386/kernel/process.c	2006-07-04 00:06:16.000000000 -0700
@@ -370,6 +370,7 @@ void exit_thread(void)
 
 		kfree(t->io_bitmap_ptr);
 		t->io_bitmap_ptr = NULL;
+		clear_thread_flag(TIF_IO_BITMAP);
 		/*
 		 * Careful, clear this in the TSS too:
 		 */
@@ -388,6 +389,7 @@ void flush_thread(void)
 
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
+	clear_tsk_thread_flag(tsk, TIF_DEBUG);
 	/*
 	 * Forget coprocessor state..
 	 */
@@ -432,7 +434,7 @@ int copy_thread(int nr, unsigned long cl
 	savesegment(gs,p->thread.gs);
 
 	tsk = current;
-	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
+	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
 			p->thread.io_bitmap_max = 0;
@@ -440,6 +442,7 @@ int copy_thread(int nr, unsigned long cl
 		}
 		memcpy(p->thread.io_bitmap_ptr, tsk->thread.io_bitmap_ptr,
 			IO_BITMAP_BYTES);
+		set_tsk_thread_flag(p, TIF_IO_BITMAP);
 	}
 
 	/*
@@ -534,10 +537,24 @@ int dump_task_regs(struct task_struct *t
 	return 1;
 }
 
-static inline void
-handle_io_bitmap(struct thread_struct *next, struct tss_struct *tss)
+static inline void __switch_to_xtra(struct task_struct *next_p,
+				    struct tss_struct *tss)
 {
-	if (!next->io_bitmap_ptr) {
+	struct thread_struct *next;
+
+	next = &next_p->thread;
+
+	if (test_tsk_thread_flag(next_p, TIF_DEBUG)) {
+		set_debugreg(next->debugreg[0], 0);
+		set_debugreg(next->debugreg[1], 1);
+		set_debugreg(next->debugreg[2], 2);
+		set_debugreg(next->debugreg[3], 3);
+		/* no 4 and 5 */
+		set_debugreg(next->debugreg[6], 6);
+		set_debugreg(next->debugreg[7], 7);
+	}
+
+	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP) == 0) {
 		/*
 		 * Disable the bitmap via an invalid offset. We still cache
 		 * the previous bitmap owner and the IO bitmap contents:
@@ -545,6 +562,7 @@ handle_io_bitmap(struct thread_struct *n
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		return;
 	}
+
 	if (likely(next == tss->io_bitmap_owner)) {
 		/*
 		 * Previous owner of the bitmap (hence the bitmap content)
@@ -674,18 +692,9 @@ struct task_struct fastcall * __switch_t
 	/*
 	 * Now maybe reload the debug registers
 	 */
-	if (unlikely(next->debugreg[7])) {
-		set_debugreg(next->debugreg[0], 0);
-		set_debugreg(next->debugreg[1], 1);
-		set_debugreg(next->debugreg[2], 2);
-		set_debugreg(next->debugreg[3], 3);
-		/* no 4 and 5 */
-		set_debugreg(next->debugreg[6], 6);
-		set_debugreg(next->debugreg[7], 7);
-	}
-
-	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr))
-		handle_io_bitmap(next, tss);
+	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
+	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
+		__switch_to_xtra(next_p, tss);
 
 	disable_tsc(prev_p, next_p);
 
diff -urNp linux-2.6.17.2.orig/arch/i386/kernel/ptrace.c linux-2.6.17.2-tif/arch/i386/kernel/ptrace.c
--- linux-2.6.17.2.orig/arch/i386/kernel/ptrace.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/arch/i386/kernel/ptrace.c	2006-07-04 00:19:59.000000000 -0700
@@ -468,8 +468,11 @@ long arch_ptrace(struct task_struct *chi
 				  for(i=0; i<4; i++)
 					  if ((0x5f54 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
 						  goto out_tsk;
+				  if (data)
+					  set_tsk_thread_flag(child, TIF_DEBUG);
+				  else
+					  clear_tsk_thread_flag(child, TIF_DEBUG);
 			  }
-
 			  addr -= (long) &dummy->u_debugreg;
 			  addr = addr >> 2;
 			  child->thread.debugreg[addr] = data;
diff -urNp linux-2.6.17.2.orig/include/asm-i386/thread_info.h linux-2.6.17.2-tif/include/asm-i386/thread_info.h
--- linux-2.6.17.2.orig/include/asm-i386/thread_info.h	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/include/asm-i386/thread_info.h	2006-07-03 05:51:25.000000000 -0700
@@ -143,6 +143,8 @@ register unsigned long current_stack_poi
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		17
+#define TIF_DEBUG		18	/* uses debug registers */
+#define TIF_IO_BITMAP		19	/* uses I/O bitmap */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -155,6 +157,8 @@ register unsigned long current_stack_poi
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_DEBUG		(1<<TIF_DEBUG)
+#define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -163,6 +167,9 @@ register unsigned long current_stack_poi
 /* work to do on any return to u-space */
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
+/* flags to check in __switch_to() */
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+
 /*
  * Thread-synchronous status.
  *

