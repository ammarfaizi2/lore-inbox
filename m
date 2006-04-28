Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWD1WAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWD1WAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 18:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWD1WAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 18:00:23 -0400
Received: from smtp-2.llnl.gov ([128.115.3.82]:3738 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1751442AbWD1WAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 18:00:23 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Date: Fri, 28 Apr 2006 14:59:27 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
       nickpiggin@yahoo.com.au, ak@suse.de, pj@sgi.com
References: <200604271308.10080.dsp@llnl.gov> <20060427155613.15d565b1.akpm@osdl.org>
In-Reply-To: <20060427155613.15d565b1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281459.27895.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Gad.  I guess if we're going to do this then a better implementation would
> be to use test_and_set_bit(some_unsigned_long).  And perhaps call some
> oom_kill.c interface function here rather than directly accessing
> oom-killer data structures (could be an inlined function).

This is the way I originally had things
(see http://lkml.org/lkml/2006/4/25/327).  If you prefer, I can change
it back to the way it was.

> But the broader question is "what do we want to do here".
>
> If we've picked a task and we've signalled it then the right thing to do
> would appear to be just to block all tasks as they enter the oom-killer.
> Send them to sleep until the killed task actually exits.  But
>
> a) memory can become free (or reclaimable) for other reasons, so those
>    now-sleeping tasks shouldn't be sleeping any more (this is a minor
>    problem).

This is one reason to have out_of_memory() return to its caller if an
OOM kill is in progress.  Since out_of_memory() is called from
__alloc_pages() this will cause the task to retry the memory allocation
(assuming it's a type of allocation where retrying is allowed).

> b) one of the sleeping tasks may be holding a lock which prevents the
>    killed task from reaching do_exit().  This is a showstopper.

Yes I am familiar with this sort of problem.  :-)  The same holds true
if you replace "one of the sleeping tasks" above with "tasks stuck
inside __alloc_pages()".  Or if there is a task stuck inside
__alloc_pages() that holds a mm_users reference to the mm_struct used
by the OOM killer's chosen victim.  I've actually seen this type of
behavior occur in practice.  In fact, I can make it reproduce quite
easily with the modified 2.6.9-based redhat kernel that I've been mostly
working in.  What I do is turn off swap and run several instances of my
"memory hog" program concurrently.  It results in deadlocks more often
than not if you run several instances of the program concurrently.

I've been tinkering with the OOM killer lately because we're moving
toward diskless clusters (i.e. no swap) where I work, and we want the
machines to be able to recover gracefully if users get too aggressive
with their memory allocations.  So far I've made the following OOM
killer changes to our RHEL4 2.6.9-based kernel:

    - Backported the latest OOM killer code from 2.6.16 to our kernel
      (I see much has changed in the OOM killer since 2.6.9).  This
      gives us the /proc/<pid>/oom_score and /proc/<pid>/oom_adjust
      functionality and other OOM killer improvements present in more
      recent kernels.

    - Made some of my own changes on top of the backported code.

Lately I've been taking my code changes, cleaning them up a bit, making
them into patches that apply cleanly to the latest 2.6.17-rcX kernel,
and posting to LKML.  However I haven't posted everything.  The code I
haven't posted is aimed specifically at addressing problem b) you
mention above.  My basic approach is as follows:

    - Change the OOM killer so we avoid looping in there.  It's better
      to return to the caller of out_of_memory() than to get stuck
      inside the OOM killer (since we may hold a semaphore or something
      that prevents the victim we shot from exiting and freeing its
      memory).

    - Change __alloc_pages() so that if an OOM kill is in progress,
      _all_ tasks looping inside __alloc_pages() are allowed to
      disregard all watermarks - thus satisfying their requests so they
      avoid getting stuck in __alloc_pages() (I know this sounds
      dangerous; see below).

    - Put a little piece of code at the start of the page fault handler
      (and also near the start of sys_mlock()) that will immediately put
      the process to sleep if we just entered the kernel from userspace
      and we have not been chosen as an OOM killer victim.  Thus the
      victim gets all the memory it needs to run itself out of the
      system and expire.  Other tasks that continue to need memory will
      go to sleep at a place where they just entered the kernel from
      userspace and therefore don't yet hold any semaphores that may
      prevent the victim from exiting.

I have had excellent results with the above approach in our redhat
kernel.  The deadlocks completely disappear, and I can run 16 or 32
instances of my "memory hog" program (I think I even did 64 instances
once) without problems.  The OOM killer shoots the memory hog processes
one by one, avoids shooting any other processes (even without any
user-provided hints from /proc/<pid>/oom_adjust), and the system
recovers fully.

After the above success I started making my code changes into
2.6.17-rcX patches and testing them in that kernel.  Interestingly I
found that the 2.6.17-rcX OOM killer appears to work well in practice
with just the stuff I've posted so far (excluding the stuff described
above).  Therefore I've held off (at least for now) posting a patch that
does the stuff above.  I made such a patch for 2.6.17-rcX just for
myself to tinker with.  Surprisingly I see system hangs with the patch.
I haven't yet had time to debug this.  It's possible I made some obvious
blunder when porting the code from our redhat kernel.  The patch appears
below (just to better illustrate what I am doing).  It is definitely
_not_ ready for actual use.





Index: git5-oom/arch/i386/mm/fault.c
===================================================================
--- git5-oom.orig/arch/i386/mm/fault.c	2006-04-25 13:25:26.000000000 -0700
+++ git5-oom/arch/i386/mm/fault.c	2006-04-25 14:06:47.000000000 -0700
@@ -22,6 +22,7 @@
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/swap.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -337,9 +338,13 @@ fastcall void __kprobes do_page_fault(st
 
 	/* It's safe to allow irq's after cr2 has been saved and the vmalloc
 	   fault has been handled. */
-	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
+	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK)) {
 		local_irq_enable();
 
+		if (oom_kill_active() && user_mode(regs))
+			oom_kill_wait();
+	}
+
 	mm = tsk->mm;
 
 	/*
Index: git5-oom/arch/x86_64/mm/fault.c
===================================================================
--- git5-oom.orig/arch/x86_64/mm/fault.c	2006-04-25 13:25:26.000000000 -0700
+++ git5-oom/arch/x86_64/mm/fault.c	2006-04-25 14:07:10.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/swap.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -362,9 +363,13 @@ asmlinkage void __kprobes do_page_fault(
 					SIGSEGV) == NOTIFY_STOP)
 		return;
 
-	if (likely(regs->eflags & X86_EFLAGS_IF))
+	if (likely(regs->eflags & X86_EFLAGS_IF)) {
 		local_irq_enable();
 
+		if (oom_kill_active() && user_mode(regs))
+			oom_kill_wait();
+	}
+
 	if (unlikely(page_fault_trace))
 		printk("pagefault rip:%lx rsp:%lx cs:%lu ss:%lu address %lx error %lx\n",
 		       regs->rip,regs->rsp,regs->cs,regs->ss,address,error_code); 
Index: git5-oom/include/linux/swap.h
===================================================================
--- git5-oom.orig/include/linux/swap.h	2006-04-25 13:43:02.000000000 -0700
+++ git5-oom/include/linux/swap.h	2006-04-25 14:02:05.000000000 -0700
@@ -147,6 +147,17 @@ struct swap_list_t {
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
+extern volatile unsigned long oom_kill_in_progress;
+
+static inline int oom_kill_active(void)
+{
+	if (unlikely(oom_kill_in_progress))
+		return 1;
+
+	return 0;
+}
+
+extern void oom_kill_wait(void);
 extern void oom_kill_finish(void);
 extern void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order);
 
Index: git5-oom/mm/mlock.c
===================================================================
--- git5-oom.orig/mm/mlock.c	2006-04-25 13:25:26.000000000 -0700
+++ git5-oom/mm/mlock.c	2006-04-25 14:02:05.000000000 -0700
@@ -10,7 +10,7 @@
 #include <linux/mm.h>
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>
-
+#include <linux/swap.h>
 
 static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	unsigned long start, unsigned long end, unsigned int newflags)
@@ -130,6 +130,14 @@ asmlinkage long sys_mlock(unsigned long 
 	if (!can_do_mlock())
 		return -EPERM;
 
+	/* If an OOM kill operation starts just after we pass this point, we
+	 * will continue eating memory anyway.  In this case, hopefully we are
+	 * not about to mlock() a huge chunk of pages.  At least for now we
+	 * will ignore this potential problem.
+	 */
+	if (oom_kill_active())
+		oom_kill_wait();
+
 	down_write(&current->mm->mmap_sem);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
Index: git5-oom/mm/oom_kill.c
===================================================================
--- git5-oom.orig/mm/oom_kill.c	2006-04-25 14:01:13.000000000 -0700
+++ git5-oom/mm/oom_kill.c	2006-04-25 14:02:05.000000000 -0700
@@ -21,12 +21,15 @@
 #include <linux/timex.h>
 #include <linux/jiffies.h>
 #include <linux/cpuset.h>
+#include <linux/wait.h>
 #include <asm/bitops.h>
 
 /* #define DEBUG */
 
 volatile unsigned long oom_kill_in_progress = 0;
 
+static DECLARE_WAIT_QUEUE_HEAD(oom_wait);
+
 /*
  * Attempt to start an OOM kill operation.  Return 0 on success, or 1 if an
  * OOM kill is already in progress.
@@ -37,6 +40,44 @@ static inline int oom_kill_start(void)
 }
 
 /*
+ * A task calls this function in one of two cases:
+ *
+ *     - It just page faulted from userspace and noticed that the
+ *       oom_kill_in_progress flag was set.
+ *
+ *     - It just started an mlock() system call and noticed that the
+ *       oom_kill_in_progress flag was set.
+ *
+ * Once an OOM kill starts, tasks that continue to demand memory while
+ * executing in userspace and are _not_ OOM killer victims will sleep here.
+ * This accomplishes the following:
+ *
+ *     - Once asleep, they no longer eat memory.  Therefore they do not
+ *       compete with the victim for memory.
+ *
+ *     - Non-victim tasks that would have otherwise gone to sleep inside the
+ *       memory allocator sleep here instead.  This is desirable because here
+ *       we just entered the kernel from userspace.  Therefore we don't hold
+ *       resources such as semaphores that may prevent the victim from exiting
+ *       and freeing its memory.
+ */
+void oom_kill_wait(void)
+{
+	/* Each time a zombie is cleaned up, a little bit of memory is freed.
+	 * Therefore it's probably best to let init continue running.
+	 */
+	if (current->pid == 1)
+		return;
+
+	/* Sleep until OOM kill operation has finished or we have been shot by
+	 * OOM killer.
+	 */
+	wait_event(oom_wait,
+		(!oom_kill_in_progress ||
+		test_tsk_thread_flag(current, TIF_MEMDIE)));
+}
+
+/*
  * Terminate an OOM kill operation.
  *
  * When the OOM killer chooses a victim, it sets the oom_notify flag of the
@@ -47,6 +88,7 @@ static inline int oom_kill_start(void)
 void oom_kill_finish(void)
 {
 	clear_bit(0, &oom_kill_in_progress);
+	wake_up(&oom_wait);
 }
 
 /**
@@ -312,6 +354,11 @@ static int oom_kill_task(task_t *p, cons
 			__oom_kill_task(q, message);
 	while_each_thread(g, q);
 
+	/* One or more tasks we just shot may be sleeping on oom_wait.  Wake
+	 * up any such tasks so they may exit.
+	 */
+	wake_up(&oom_wait);
+
 	return 0;
 }
 
@@ -402,11 +449,4 @@ out:
 
 	if (cancel)
 		oom_kill_finish();  /* cancel OOM kill operation */
-
-	/*
-	 * Give "p" a good chance of killing itself before we
-	 * retry to allocate memory unless "p" is current
-	 */
-	if (!test_thread_flag(TIF_MEMDIE))
-		schedule_timeout_uninterruptible(1);
 }
Index: git5-oom/mm/page_alloc.c
===================================================================
--- git5-oom.orig/mm/page_alloc.c	2006-04-25 13:25:26.000000000 -0700
+++ git5-oom/mm/page_alloc.c	2006-04-25 14:02:05.000000000 -0700
@@ -985,7 +985,7 @@ restart:
 
 	/* This allocation should allow future memory freeing. */
 
-	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
+	if (((p->flags & PF_MEMALLOC) || oom_kill_active())
 			&& !in_interrupt()) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
 nofail_alloc:
@@ -1022,7 +1022,7 @@ rebalance:
 
 	cond_resched();
 
-	if (likely(did_some_progress)) {
+	if (likely(did_some_progress) || oom_kill_active()) {
 		page = get_page_from_freelist(gfp_mask, order,
 						zonelist, alloc_flags);
 		if (page)
