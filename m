Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319066AbSHMUo0>; Tue, 13 Aug 2002 16:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319065AbSHMUo0>; Tue, 13 Aug 2002 16:44:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54187 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319066AbSHMUoX>;
	Tue, 13 Aug 2002 16:44:23 -0400
Date: Tue, 13 Aug 2002 22:47:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] user-vm-unlock-2.5.31-A1
In-Reply-To: <Pine.LNX.4.44.0208131244150.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132243230.12317-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch implements CLONE_VM_RELEASE, which lets the child
release the 'user VM' at mm_release() time.

note that a quick testing did not show the desired result yet, so there
must be some thinko in it, but this is how i think it would roughly look
like. The copy_thread() code takes a pointer away from the user-stack -
userspace should put the lock there.

the patch also accelerates the common 'no funky CLONE flags' case in
copy_thread(), since the flags started mounting up.

(the patch is ontop the SETTID/SETTLS and DETACHED patches, for dependency
reasons.)

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Tue Aug 13 22:26:39 2002
+++ linux/arch/i386/kernel/process.c	Tue Aug 13 22:35:45 2002
@@ -566,6 +566,7 @@
 	struct_cpy(childregs, regs);
 	childregs->eax = 0;
 	childregs->esp = esp;
+	p->user_vm_lock = NULL;
 
 	p->thread.esp = (unsigned long) childregs;
 	p->thread.esp0 = (unsigned long) (childregs+1);
@@ -579,6 +580,19 @@
 	unlazy_fpu(tsk);
 	struct_cpy(&p->thread.i387, &tsk->thread.i387);
 
+	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
+		p->thread.ts_io_bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
+		if (!p->thread.ts_io_bitmap)
+			return -ENOMEM;
+		memcpy(p->thread.ts_io_bitmap, tsk->thread.ts_io_bitmap,
+			IO_BITMAP_BYTES);
+	}
+
+	/*
+	 * The common fastpath:
+	 */
+	if (!(clone_flags & (CLONE_SETTLS | CLONE_SETTID | CLONE_RELEASE_VM)))
+		return 0;
 	/*
 	 * Set a new TLS for the child thread?
 	 */
@@ -608,14 +622,13 @@
 		if (put_user(p->pid, (pid_t *)childregs->edx))
 			return -EFAULT;
 
-	if (unlikely(NULL != tsk->thread.ts_io_bitmap)) {
-		p->thread.ts_io_bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!p->thread.ts_io_bitmap)
-			return -ENOMEM;
-		memcpy(p->thread.ts_io_bitmap, tsk->thread.ts_io_bitmap,
-			IO_BITMAP_BYTES);
+	/*
+	 * Does the userspace VM want any unlock on mm_release()?
+	 */
+	if (clone_flags & CLONE_RELEASE_VM) {
+		childregs->esp -= sizeof(0UL);
+		p->user_vm_lock = (long *) esp;
 	}
-
 	return 0;
 }
 
--- linux/include/linux/sched.h.orig	Tue Aug 13 22:20:41 2002
+++ linux/include/linux/sched.h	Tue Aug 13 22:35:20 2002
@@ -47,6 +47,7 @@
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
 #define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
+#define CLONE_RELEASE_VM 0x00200000	/* release the userspace stack */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 
@@ -305,6 +306,7 @@
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
+	long *user_vm_lock;			/* for CLONE_RELEASE_VM */
 
 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
--- linux/kernel/fork.c.orig	Tue Aug 13 22:21:52 2002
+++ linux/kernel/fork.c	Tue Aug 13 22:35:27 2002
@@ -367,6 +367,12 @@
 		tsk->vfork_done = NULL;
 		complete(vfork_done);
 	}
+	if (tsk->user_vm_lock)
+		/*
+		 * We dont check the error code - if userspace has
+		 * not set up a proper pointer then tough luck.
+		 */
+		put_user(0UL, tsk->user_vm_lock);
 }
 
 static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)

