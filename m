Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbSKTUNX>; Wed, 20 Nov 2002 15:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSKTUNX>; Wed, 20 Nov 2002 15:13:23 -0500
Received: from ppp-217-133-219-180.dialup.tiscali.it ([217.133.219.180]:16268
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262371AbSKTUNM>; Wed, 20 Nov 2002 15:13:12 -0500
Subject: Re: [patch] threading enhancements, tid-2.5.48-A1
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211201050310.30357-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211201050310.30357-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xqaGi0MXCFEvlTiDUdwQ"
Organization: 
Message-Id: <1037823600.19667.83.camel@home.ldb.ods.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 20 Nov 2002 21:20:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xqaGi0MXCFEvlTiDUdwQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

But why not pass the child tidptr to ret_from_fork in a child register
rather than in a task_struct field?

The following patch implements this idea, but I only tested successful
compilation, not correct execution.


diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.48_ldb_no_tid/arch/i386/kernel/entry.S linux-2.5.48_ldb/arch/i386/kernel/entry.S
--- linux-2.5.48_ldb_no_tid/arch/i386/kernel/entry.S	2002-11-18 15:30:37.000000000 +0100
+++ linux-2.5.48_ldb/arch/i386/kernel/entry.S	2002-11-20 21:18:49.000000000 +0100
@@ -192,7 +192,20 @@ ENTRY(lcall27)
 	jmp resume_userspace


+#define CLONE_CHILD_SETTID	0x01000000
 ENTRY(ret_from_fork)
+	testl $CLONE_CHILD_SETTID, EBX(%esp)
+	je 2f
+	movl EDI(%esp), %ecx
+	movl EAX(%esp), %eax
+1:	movl %eax, (%ecx)
+2:
+.section __ex_table,"a"
+	.align 4
+	.long 1b,2b
+.previous
+
+	movl $0, EAX(%esp)
 #if CONFIG_SMP || CONFIG_PREEMPT
 	# NOTE: this function takes a parameter but it's unused on x86.
 	call schedule_tail
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.48_ldb_no_tid/arch/i386/kernel/process.c linux-2.5.48_ldb/arch/i386/kernel/process.c
--- linux-2.5.48_ldb_no_tid/arch/i386/kernel/process.c	2002-11-18 05:29:19.000000000 +0100
+++ linux-2.5.48_ldb/arch/i386/kernel/process.c	2002-11-20 15:26:24.000000000 +0100
@@ -225,7 +225,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.eflags = 0x286;

 	/* Ok, create the new process.. */
-	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL);
+	p = do_fork(flags | CLONE_VM | CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }

@@ -285,9 +285,8 @@ int copy_thread(int nr, unsigned long cl

 	childregs = ((struct pt_regs *) (THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
 	struct_cpy(childregs, regs);
-	childregs->eax = 0;
+	childregs->eax = p->pid;
 	childregs->esp = esp;
-	p->user_tid = NULL;

 	p->thread.esp = (unsigned long) childregs;
 	p->thread.esp0 = (unsigned long) (childregs+1);
@@ -502,7 +501,7 @@ asmlinkage int sys_fork(struct pt_regs r
 {
 	struct task_struct *p;

-	p = do_fork(SIGCHLD, regs.esp, &regs, 0, NULL);
+	p = do_fork(SIGCHLD, regs.esp, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }

@@ -511,14 +510,15 @@ asmlinkage int sys_clone(struct pt_regs
 	struct task_struct *p;
 	unsigned long clone_flags;
 	unsigned long newsp;
-	int *user_tid;
+	int *parent_tidptr, *child_tidptr;

 	clone_flags = regs.ebx;
 	newsp = regs.ecx;
-	user_tid = (int *)regs.edx;
+	parent_tidptr = (int *)regs.edx;
+	child_tidptr = (int *)regs.edi;
 	if (!newsp)
 		newsp = regs.esp;
-	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, user_tid);
+	p = do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, parent_tidptr, child_tidptr);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }

@@ -536,7 +536,7 @@ asmlinkage int sys_vfork(struct pt_regs
 {
 	struct task_struct *p;

-	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0, NULL);
+	p = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, regs.esp, &regs, 0, NULL, NULL);
 	return IS_ERR(p) ? PTR_ERR(p) : p->pid;
 }

diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.48_ldb_no_tid/arch/i386/kernel/smpboot.c linux-2.5.48_ldb/arch/i386/kernel/smpboot.c
--- linux-2.5.48_ldb_no_tid/arch/i386/kernel/smpboot.c	2002-11-18 05:29:45.000000000 +0100
+++ linux-2.5.48_ldb/arch/i386/kernel/smpboot.c	2002-11-20 14:55:19.000000000 +0100
@@ -498,7 +498,7 @@ static struct task_struct * __init fork_
 	 * don't care about the eip and regs settings since
 	 * we'll never reschedule the forked task.
 	 */
-	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL);
+	return do_fork(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
 }

 /* which physical APIC ID maps to which logical CPU number */
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.48_ldb_no_tid/include/linux/sched.h linux-2.5.48_ldb/include/linux/sched.h
--- linux-2.5.48_ldb_no_tid/include/linux/sched.h	2002-11-18 05:29:22.000000000 +0100
+++ linux-2.5.48_ldb/include/linux/sched.h	2002-11-20 15:31:55.000000000 +0100
@@ -46,10 +46,11 @@ struct exec_domain;
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
-#define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
-#define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
-#define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
-#define CLONE_UNTRACED  0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_PARENT_SETTID	0x00100000	/* set the TID in the parent */
+#define CLONE_CHILD_CLEARTID	0x00200000	/* clear the TID in the child */
+#define CLONE_DETACHED		0x00400000	/* parent wants no child-exit signal */
+#define CLONE_UNTRACED		0x00800000	/* set if the tracing process can't force CLONE_PTRACE on this clone */
+#define CLONE_CHILD_SETTID	0x01000000	/* set the TID in the child */

 /*
  * List of flags we want to share for kernel threads,
@@ -332,7 +333,7 @@ struct task_struct {

 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
-	int *user_tid;				/* for CLONE_CLEARTID */
+	int *user_tid;				/* CLONE_CHILD_CLEARTID */

 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
@@ -615,7 +616,7 @@ extern void daemonize(void);
 extern task_t *child_reaper;

 extern int do_execve(char *, char **, char **, struct pt_regs *);
-extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *);
+extern struct task_struct *do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int *, int *);

 #ifdef CONFIG_SMP
 extern void wait_task_inactive(task_t * p);
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.48_ldb_no_tid/kernel/fork.c linux-2.5.48_ldb/kernel/fork.c
--- linux-2.5.48_ldb_no_tid/kernel/fork.c	2002-11-18 17:08:55.000000000 +0100
+++ linux-2.5.48_ldb/kernel/fork.c	2002-11-20 15:55:10.000000000 +0100
@@ -409,15 +409,15 @@ void mm_release(void)
 		complete(vfork_done);
 	}
 	if (tsk->user_tid) {
-		int * user_tid = tsk->user_tid;
+		int * tidptr = tsk->user_tid;
 		tsk->user_tid = NULL;

 		/*
 		 * We dont check the error code - if userspace has
 		 * not set up a proper pointer then tough luck.
 		 */
-		put_user(0, user_tid);
-		sys_futex((unsigned long)user_tid, FUTEX_WAKE, 1, NULL);
+		__put_user(0, tidptr);
+		sys_futex((unsigned long)tidptr, FUTEX_WAKE, 1, NULL);
 	}
 }

@@ -680,9 +680,9 @@ static inline void copy_flags(unsigned l
 	p->flags = new_flags;
 }

-asmlinkage int sys_set_tid_address(int *user_tid)
+asmlinkage int sys_set_tid_address(int *tidptr)
 {
-	current->user_tid = user_tid;
+	current->user_tid = tidptr;

 	return current->pid;
 }
@@ -699,7 +699,8 @@ static struct task_struct *copy_process(
 			    unsigned long stack_start,
 			    struct pt_regs *regs,
 			    unsigned long stack_size,
-			    int *user_tid)
+			    int *parent_tidptr,
+			    int *child_tidptr)
 {
 	int retval;
 	struct task_struct *p = NULL;
@@ -716,6 +717,10 @@ static struct task_struct *copy_process(
 	if ((clone_flags & CLONE_DETACHED) && !(clone_flags & CLONE_THREAD))
 		return ERR_PTR(-EINVAL);

+	if ((clone_flags & (CLONE_CHILD_SETTID | CLONE_CHILD_CLEARTID))
+	    && (retval = verify_area(VERIFY_WRITE, child_tidptr, sizeof(int))))
+		return ERR_PTR(retval);
+
 	retval = security_ops->task_create(clone_flags);
 	if (retval)
 		goto fork_out;
@@ -823,19 +828,15 @@ static struct task_struct *copy_process(
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_namespace;
-	/*
-	 * Notify the child of the TID?
-	 */
+
 	retval = -EFAULT;
-	if (clone_flags & CLONE_SETTID)
-		if (put_user(p->pid, user_tid))
+	if (clone_flags & CLONE_PARENT_SETTID)
+		if (put_user(p->pid, parent_tidptr))
 			goto bad_fork_cleanup_namespace;
-
 	/*
-	 * Does the userspace VM want the TID cleared on mm_release()?
+	 * Clear TID on mm_release()?
 	 */
-	if (clone_flags & CLONE_CLEARTID)
-		p->user_tid = user_tid;
+	p->user_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? child_tidptr : 0;

 	/*
 	 * Syscall tracing should be turned off in the child regardless
@@ -1004,7 +1005,8 @@ struct task_struct *do_fork(unsigned lon
 			    unsigned long stack_start,
 			    struct pt_regs *regs,
 			    unsigned long stack_size,
-			    int *user_tid)
+			    int *parent_tidptr,
+			    int *child_tidptr)
 {
 	struct task_struct *p;
 	int trace = 0;
@@ -1015,7 +1017,7 @@ struct task_struct *do_fork(unsigned lon
 			clone_flags |= CLONE_PTRACE;
 	}

-	p = copy_process(clone_flags, stack_start, regs, stack_size, user_tid);
+	p = copy_process(clone_flags, stack_start, regs, stack_size, parent_tidptr, child_tidptr);
 	if (!IS_ERR(p)) {
 		struct completion vfork;



--=-xqaGi0MXCFEvlTiDUdwQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA92+5vdjkty3ft5+cRAnIWAJ9jRkiUcTglTWpm8MA30Ubz4xGMfACcCykP
MTjsLuOGI14jGrE2nsTEb2M=
=jY5+
-----END PGP SIGNATURE-----

--=-xqaGi0MXCFEvlTiDUdwQ--
