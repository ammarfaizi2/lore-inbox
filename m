Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSKRGjd>; Mon, 18 Nov 2002 01:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSKRGjd>; Mon, 18 Nov 2002 01:39:33 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:60547
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261529AbSKRGjb>; Mon, 18 Nov 2002 01:39:31 -0500
Message-ID: <3DD88CB5.5070904@redhat.com>
Date: Sun, 17 Nov 2002 22:46:13 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211172003050.1206-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------010801080402080006090309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010801080402080006090309
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

> I'm convinced. However, I still want som elargely cosmetic changes to the 
> patch, Ingo:
> [...]

I'm not Ingo but changing the patch seemed easy enough to do, even for
me.  I append the patch below.  It is not meant for inclusion since
there is onw more problem to solve.  Ingo patch had another bug.  The
user_tid field in the child didn't get set if CLONE_CHILD_CLEARTID was
set.  This obviously has bad results.

I've changed the test to read

+       if (clone_flags & (CLONE_CHILD_SETTID|CLONE_CHILD_CLEARTID))

which works for me.  But since in schedule_tail() the code reads

+       if (current->user_tid)
+               put_user(current->pid, current->user_tid);

this enables writing the TID even if CLONE_CHILD_SETTID isn't set.  The
question is: how to access the clone flag information in the child?

Anyway, since this distinction isn't important for my tests I've applied
the attached patch and all runs fine.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------010801080402080006090309
Content-Type: text/plain;
 name="d-tid"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-tid"

--- linux-2.5/arch/i386/kernel/entry.S.tid	2002-11-17 16:11:26.000000000 -0800
+++ linux-2.5/arch/i386/kernel/entry.S	2002-11-17 21:56:18.000000000 -0800
@@ -193,10 +193,8 @@
 
 
 ENTRY(ret_from_fork)
-#if CONFIG_SMP || CONFIG_PREEMPT
 	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
-#endif
 	GET_THREAD_INFO(%ebx)
 	jmp syscall_exit
 
--- linux-2.5/include/linux/sched.h.tid	2002-11-17 16:11:26.000000000 -0800
+++ linux-2.5/include/linux/sched.h	2002-11-17 22:04:56.000000000 -0800
@@ -46,10 +46,11 @@
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
-#define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
-#define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
+#define CLONE_PARENT_SETTID	0x00100000	/* write the TID back to userspace */
+#define CLONE_CHILD_CLEARTID	0x00200000	/* clear the userspace TID */
 #define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
 #define CLONE_UNTRACED  0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */
 
 /*
  * List of flags we want to share for kernel threads,
@@ -332,7 +333,7 @@
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
-	int *user_tid;				/* for CLONE_CLEARTID */
+	int *user_tid;				/* for CLONE_[SET|CLEAR]TID */
 
 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
--- linux-2.5/kernel/sched.c.tid	2002-11-17 16:11:26.000000000 -0800
+++ linux-2.5/kernel/sched.c	2002-11-17 21:59:58.000000000 -0800
@@ -503,12 +503,17 @@
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
  */
-#if CONFIG_SMP || CONFIG_PREEMPT
+asmlinkage void FASTCALL(schedule_tail(task_t *prev));
 asmlinkage void schedule_tail(task_t *prev)
 {
 	finish_arch_switch(this_rq(), prev);
+
+	/*
+	 * Does the child thread/process want to be notified of the TID/PID?
+	 */
+	if (current->user_tid)
+		put_user(current->pid, current->user_tid);
 }
-#endif
 
 /*
  * context_switch - switch to the new MM and the new
--- linux-2.5/kernel/fork.c.tid	2002-11-17 16:11:26.000000000 -0800
+++ linux-2.5/kernel/fork.c	2002-11-17 22:06:00.000000000 -0800
@@ -822,18 +822,15 @@
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
-	/*
-	 * Notify the child of the TID?
-	 */
 	retval = -EFAULT;
-	if (clone_flags & CLONE_SETTID)
+	if (clone_flags & CLONE_PARENT_SETTID)
 		if (put_user(p->pid, user_tid))
 			goto bad_fork_cleanup_namespace;
-
 	/*
-	 * Does the userspace VM want the TID cleared on mm_release()?
+	 * Does the userspace VM want the TID set in the child's
+	 * address space and it cleared on mm_release()?
 	 */
-	if (clone_flags & CLONE_CLEARTID)
+	if (clone_flags & (CLONE_CHILD_SETTID|CLONE_CHILD_CLEARTID))
 		p->user_tid = user_tid;
 
 	/*

--------------010801080402080006090309--

