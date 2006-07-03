Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWGCJ6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWGCJ6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWGCJ6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:58:07 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:61078 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751006AbWGCJ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:58:05 -0400
Date: Mon, 3 Jul 2006 02:49:48 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060703094948.GA4460@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <p73fyhmx1zv.fsf@verdi.suse.de> <20060630123629.GA22381@frankl.hpl.hp.com> <p73bqsax0iu.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <p73bqsax0iu.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andi,

Here is a first cut at the patch to simplify the context
switch for the common case and also touch 2 cachelines (instead of 3).
There are 2 new TIF flags. I just tried this on x86_64 but I believe
we could do the same on i386.

Is that what you were thinking about?

Thanks

On Fri, Jun 30, 2006 at 02:59:05PM +0200, Andi Kleen wrote:
> Stephane Eranian <eranian@hpl.hp.com> writes:
> 
> > Andi,
> > 
> > Thanks for your feedback. I will make the changes you
> > requested.
> > 
> > About the context switch code, what about I do the following
> > in __switch_to():
> > 
> > __kprobes struct task_struct *
> > __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
> > {
> >         struct thread_struct *prev = &prev_p->thread,
> >                                  *next = &next_p->thread;
> >         int cpu = smp_processor_id();
> >         struct tss_struct *tss = &per_cpu(init_tss, cpu);
> > 
> >         if (unlikely(__get_cpu_var(pmu_ctx) || next_p->pfm_context))
> >                 __pfm_ctxswout(prev_p, next_p);
> > 
> >         /*
> >          * Reload esp0, LDT and the page table pointer:
> >          */
> >         tss->rsp0 = next->rsp0;
> > 
> > There is now a single hook and a conditional branch.
> > this is similar to what you have with the debug registers.
> 
> It's still more than there was before. Also __get_cpu_var 
> is quite a lot of instructions.
> 
> I would suggest you borrow some bits in one of the process
> or thread info flags and then do a single test
> 
> if (unlikely(thr->flags & (DEBUG|PERFMON)) != 0) { 
>         if (flags & DEBUG)
>                 ... do debug ...
>         if (flags & PERFMON)
>                 ... do perfmon ...
> }
> 
> [which you're at it you can probably add ioports in there too -
> improving existing code is always a good thing]
> 
> Ideally flags is in some cache line that is already 
> touched during context switch. If not you might need
> to change the layout.
> 
> It's ok to put the do_perfmon stuff into a separate noinline
> function because that will disturb the register allocation
> in the caller less.
> 
> I would suggest doing this in separate preparing patches that
> first just do it for existing facilities.
> 
> -Andi
> 
> P.S.: My comments probably apply to the i386 versions too
> although I haven't read them.

-- 

-Stephane

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tif.diff"

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
+++ linux-2.6.17.2-tif/arch/x86_64/kernel/process.c	2006-07-03 02:35:25.000000000 -0700
@@ -356,6 +356,7 @@ void exit_thread(void)
 		 */
 		memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
 		t->io_bitmap_max = 0;
+		clear_thread_flag(TIF_IO_BITMAP);
 		put_cpu();
 	}
 }
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
@@ -484,7 +486,7 @@ int copy_thread(int nr, unsigned long cl
 	}
 	err = 0;
 out:
-	if (err && p->thread.io_bitmap_ptr) {
+	if (err && test_tsk_thread_flag(p, TIF_IO_BITMAP)) {
 		kfree(p->thread.io_bitmap_ptr);
 		p->thread.io_bitmap_max = 0;
 	}
@@ -584,38 +586,34 @@ __switch_to(struct task_struct *prev_p, 
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
+	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
+		|| test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
 
-	/* 
-	 * Handle the IO bitmap 
-	 */ 
-	if (unlikely(prev->io_bitmap_ptr || next->io_bitmap_ptr)) {
-		if (next->io_bitmap_ptr)
+		if (test_tsk_thread_flag(next_p, TIF_DEBUG)) {
+			loaddebug(next, 0);
+			loaddebug(next, 1);
+			loaddebug(next, 2);
+			loaddebug(next, 3);
+			/* no 4 and 5 */
+			loaddebug(next, 6);
+			loaddebug(next, 7);
+		}
+		if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
 			/*
 			 * Copy the relevant range of the IO bitmap.
 			 * Normally this is 128 bytes or less:
  			 */
 			memcpy(tss->io_bitmap, next->io_bitmap_ptr,
-				max(prev->io_bitmap_max, next->io_bitmap_max));
-		else {
+			       max(prev->io_bitmap_max, next->io_bitmap_max));
+		} else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
 			/*
 			 * Clear any possible leftover bits:
 			 */
 			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 		}
 	}
-
 	return prev_p;
 }
 
diff -urNp linux-2.6.17.2.orig/arch/x86_64/kernel/ptrace.c linux-2.6.17.2-tif/arch/x86_64/kernel/ptrace.c
--- linux-2.6.17.2.orig/arch/x86_64/kernel/ptrace.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17.2-tif/arch/x86_64/kernel/ptrace.c	2006-06-30 09:30:57.000000000 -0700
@@ -420,9 +420,16 @@ long arch_ptrace(struct task_struct *chi
 				if ((0x5554 >> ((data >> (16 + 4*i)) & 0xf)) & 1)
 					break;
 			if (i == 4) {
-				child->thread.debugreg7 = data;
+			  child->thread.debugreg7 = data;
+			  if (data) {
+				pr_info("set TIF_DEBUG for [%d]\n", child->pid);
+			  	set_tsk_thread_flag(child, TIF_DEBUG);
+			  } else {
+				pr_info("clear TIF_DEBUG for [%d]\n", child->pid);
+			  	clear_tsk_thread_flag(child, TIF_DEBUG);
+			}
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

--uAKRQypu60I7Lcqm--
