Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319115AbSHMVTb>; Tue, 13 Aug 2002 17:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319118AbSHMVTb>; Tue, 13 Aug 2002 17:19:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16047 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319115AbSHMVT2>;
	Tue, 13 Aug 2002 17:19:28 -0400
Date: Tue, 13 Aug 2002 23:23:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208132307340.12804-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208132320240.13244-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


and here's a merged CLONE_VM_RELEASE patch against the previous
clone-detached patch. (the sched.h reorganization broke it.)

I've tested it and userspace VM-release still works (after fixing the test
tool to use the repositioned clone flag bit):

  [mingo@a mingo]$ ./start-detached 1000 1 0
  stack end: 0x12341234
  started up 1000 threads!
  stack end after all threads exited: 0x00000000.

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Tue Aug 13 23:14:39 2002
+++ linux/arch/i386/kernel/process.c	Tue Aug 13 23:20:48 2002
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
 
--- linux/include/linux/sched.h.orig	Tue Aug 13 23:14:51 2002
+++ linux/include/linux/sched.h	Tue Aug 13 23:21:21 2002
@@ -48,6 +48,7 @@
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
 #define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
 #define CLONE_DETACHED	0x00200000	/* parent wants no child-exit signal */
+#define CLONE_RELEASE_VM 0x00400000	/* release the userspace VM */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 
@@ -306,6 +307,7 @@
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
+	long *user_vm_lock;			/* for CLONE_RELEASE_VM */
 
 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
--- linux/kernel/fork.c.orig	Tue Aug 13 23:14:51 2002
+++ linux/kernel/fork.c	Tue Aug 13 23:20:48 2002
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

