Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSHOWW4>; Thu, 15 Aug 2002 18:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSHOWW4>; Thu, 15 Aug 2002 18:22:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25770 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317571AbSHOWWy>;
	Thu, 15 Aug 2002 18:22:54 -0400
Date: Fri, 16 Aug 2002 00:26:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208151055440.3130-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208160003260.24255-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Linus Torvalds wrote:

> I do not understand why you want to link this to the stack at all. [...]

you are right, indeed 'releasing basic thread state' is the correct
concept. Any sane threading library merges this with the stackframe, this
is why i keep referring to it as the stack. Basic thread state has to be
intact for signal handlers to function even in the last moment.

> I personally believe that it would make a lot more sense to either pass
> in a totally independent pointer, or - my preferred approach - to just
> re-use the TID pointer. Think about it: thread creation sets the TID (if
> CLONE_SETTID is set) in the thread data structures, and thread exit
> clears the TID (if CLONE_CLRTID is set). That sounds like a _sensible_
> interface.

you have applied my independent-pointer patch already, but i think your
CLEARTID variant is the most elegant solution: it reuses a clone argument,
thus reduces the number of arguments and it's also a nice conceptual pair
to the existing SETTID call. And the TID field can be used as a 'usage'
field as well, because the TID (PID) can never be 0, reducing the number
of fields in the TCB. And we can change the userspace locking code to use
the TID field no problem.

personally i'd make it even more compact by merging the two clone flags as
well, something along: CLONE_MANAGE_TID. I cannot see any reason for a
thread library to use one of the bits only. This also reflects the fact
that it's thread state that the kernel helps managing, both in the
thread-create and in the thread-exit path. But this might be stretching
things a bit?

patch against BK-curr attached.

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Fri Aug 16 00:16:52 2002
+++ linux/arch/i386/kernel/process.c	Fri Aug 16 00:18:49 2002
@@ -566,7 +566,7 @@
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
-	p->user_vm_lock = NULL;
+	p->user_tid = NULL;
 
 	p->thread.esp = (unsigned long) childregs;
 	p->thread.esp0 = (unsigned long) (childregs+1);
@@ -591,7 +591,7 @@
 	/*
 	 * The common fastpath:
 	 */
-	if (!(clone_flags & (CLONE_SETTLS | CLONE_SETTID | CLONE_RELEASE_VM)))
+	if (!(clone_flags & (CLONE_SETTLS | CLONE_SETTID | CLONE_CLEARTID)))
 		return 0;
 	/*
 	 * Set a new TLS for the child thread?
@@ -623,10 +623,10 @@
 			return -EFAULT;
 
 	/*
-	 * Does the userspace VM want any unlock on mm_release()?
+	 * Does the userspace VM want the TID cleared on mm_release()?
 	 */
-	if (clone_flags & CLONE_RELEASE_VM)
-		p->user_vm_lock = (long *) childregs->edi;
+	if (clone_flags & CLONE_CLEARTID)
+		p->user_tid = (long *) childregs->edx;
 	return 0;
 }
 
--- linux/include/linux/sched.h.orig	Fri Aug 16 00:17:48 2002
+++ linux/include/linux/sched.h	Fri Aug 16 00:26:05 2002
@@ -47,8 +47,9 @@
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
 #define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
-#define CLONE_DETACHED	0x00200000	/* parent wants no child-exit signal */
-#define CLONE_RELEASE_VM 0x00400000	/* release the userspace VM */
+#define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
+#define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
+#define CLONE_RELEASE_VM 0x00800000	/* release the userspace VM */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 
@@ -307,7 +308,7 @@
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
-	long *user_vm_lock;			/* for CLONE_RELEASE_VM */
+	long *user_tid;				/* for CLONE_CLEARTID */
 
 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
--- linux/kernel/fork.c.orig	Fri Aug 16 00:19:00 2002
+++ linux/kernel/fork.c	Fri Aug 16 00:19:16 2002
@@ -368,12 +368,12 @@
 		tsk->vfork_done = NULL;
 		complete(vfork_done);
 	}
-	if (tsk->user_vm_lock)
+	if (tsk->user_tid)
 		/*
 		 * We dont check the error code - if userspace has
 		 * not set up a proper pointer then tough luck.
 		 */
-		put_user(0UL, tsk->user_vm_lock);
+		put_user(0UL, tsk->user_tid);
 }
 
 static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)

