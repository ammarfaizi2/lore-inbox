Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155056AbPHJH2X>; Tue, 10 Aug 1999 03:28:23 -0400
Received: by vger.rutgers.edu id <S154768AbPHJH2C>; Tue, 10 Aug 1999 03:28:02 -0400
Received: from isunix.it.ilstu.edu ([138.87.124.103]:4361 "EHLO isunix.it.ilstu.edu") by vger.rutgers.edu with ESMTP id <S154743AbPHJH14>; Tue, 10 Aug 1999 03:27:56 -0400
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <199908100653.BAA12955@isunix.it.ilstu.edu>
Subject: (again..) PATCH: CLONE_PPID and friends - comments>?
To: linux-kernel@vger.rutgers.edu
Date: Tue, 10 Aug 1999 01:53:42 -0500 (CDT)
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

Here is the (latest edition of the) final CLONE_PPID patch.  I reworked
sys_wait4, and few other comments I received.

Anyone see anything wrong with this?  Else I will make a 2.3.x diff and
pass it on to Linus before the 2.4 freeze..


Tim



diff -ru clean-linux-2.2.10/fs/exec.c clone-linux-2.2.10/fs/exec.c
--- clean-linux-2.2.10/fs/exec.c	Sun Jun 13 10:50:04 1999
+++ clone-linux-2.2.10/fs/exec.c	Thu Jul 22 03:17:00 1999
@@ -846,9 +846,12 @@
 
 	if (retval >= 0)
 		retval = search_binary_handler(&bprm,regs);
-	if (retval >= 0)
+	if (retval >= 0) {
+		/* clear any thread-special bits - JIC */
+		current->flags &= ~(PF_PPIDOK | PF_CLWAIT);
 		/* execve success */
 		return retval;
+	}
 
 	/* Something went wrong, return the inode and free the argument pages*/
 	if (bprm.dentry)
diff -ru clean-linux-2.2.10/include/linux/sched.h clone-linux-2.2.10/include/linux/sched.h
--- clean-linux-2.2.10/include/linux/sched.h	Tue May 11 10:35:45 1999
+++ clone-linux-2.2.10/include/linux/sched.h	Thu Jul 22 02:51:17 1999
@@ -34,6 +34,10 @@
 #define CLONE_PID	0x00001000	/* set if pid shared */
 #define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
 #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
+#define CLONE_PPIDOK	0x00008000	/* set if the child should be able to create siblings */
+#define CLONE_PPID	0x00010000	/* set if we want to create a sibling, not a child */
+#define CLONE_WAIT 	0x00020000	/* set if child is allowed to wait() for siblings */
+#define CLONE_SUSPENDED	0x00040000	/* create a process in the stopped state */
 
 /*
  * These are the constant used to fake the fixed-point load-average
@@ -332,6 +336,8 @@
 
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 #define PF_DTRACE	0x00200000	/* delayed trace (used on m68k, i386) */
+#define PF_PPIDOK	0x00400000	/* task is allowed to use CLONE_PPID */
+#define PF_CLWAIT	0x00800000	/* allowed to wait for siblings */
 
 /*
  * Limit the stack by to some sane default: root can always
diff -ru clean-linux-2.2.10/kernel/exit.c clone-linux-2.2.10/kernel/exit.c
--- clean-linux-2.2.10/kernel/exit.c	Fri Apr 30 08:13:37 1999
+++ clone-linux-2.2.10/kernel/exit.c	Sun Aug  8 16:28:33 1999
@@ -145,6 +145,7 @@
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
 		if (p->p_opptr == father) {
+			p->flags &= ~(PF_PPIDOK | PF_CLWAIT);
 			p->exit_signal = SIGCHLD;
 			p->p_opptr = child_reaper; /* init */
 			if (p->pdeath_signal) send_sig(p->pdeath_signal, p, 0);
@@ -407,16 +408,22 @@
 {
 	int flag, retval;
 	struct wait_queue wait = { current, NULL };
+	struct wait_queue wait_sib = { current, NULL };
 	struct task_struct *p;
+	struct task_struct *start;
 
 	if (options & ~(WNOHANG|WUNTRACED|__WCLONE))
 		return -EINVAL;
 
 	add_wait_queue(&current->wait_chldexit,&wait);
+	if (current->flags & PF_CLWAIT)
+		add_wait_queue(&current->p_pptr->wait_chldexit,&wait_sib);
+
+	start = current->p_cptr;
 repeat:
 	flag = 0;
 	read_lock(&tasklist_lock);
- 	for (p = current->p_cptr ; p ; p = p->p_osptr) {
+ 	for (p = start ; p ; p = p->p_osptr) {
 		if (pid>0) {
 			if (p->pid != pid)
 				continue;
@@ -484,10 +491,19 @@
 		current->state=TASK_INTERRUPTIBLE;
 		schedule();
 		goto repeat;
+	} else {
+		/* try the siblings ? */
+		if ((current->flags & PF_CLWAIT) && (start != current->p_pptr->p_cptr)) {
+			start = current->p_pptr->p_cptr;
+			goto repeat;
+		}
 	}
 	retval = -ECHILD;
 end_wait4:
 	remove_wait_queue(&current->wait_chldexit,&wait);
+	if (current->flags & PF_CLWAIT)
+		remove_wait_queue(&current->p_pptr->wait_chldexit,&wait_sib);
+
 	return retval;
 }
 
diff -ru clean-linux-2.2.10/kernel/fork.c clone-linux-2.2.10/kernel/fork.c
--- clean-linux-2.2.10/kernel/fork.c	Mon Apr 12 12:44:26 1999
+++ clone-linux-2.2.10/kernel/fork.c	Thu Jul 29 10:08:13 1999
@@ -517,12 +517,18 @@
 {
 	unsigned long new_flags = p->flags;
 
-	new_flags &= ~(PF_SUPERPRIV | PF_USEDFPU | PF_VFORK);
+	new_flags &= ~(PF_SUPERPRIV | PF_USEDFPU | PF_VFORK 
+		       | PF_PPIDOK | PF_CLWAIT);
 	new_flags |= PF_FORKNOEXEC;
 	if (!(clone_flags & CLONE_PTRACE))
 		new_flags &= ~(PF_PTRACED|PF_TRACESYS);
 	if (clone_flags & CLONE_VFORK)
 		new_flags |= PF_VFORK;
+	if (clone_flags & CLONE_PPIDOK)
+		new_flags |= PF_PPIDOK;
+	if (clone_flags & CLONE_WAIT)
+		new_flags |= PF_CLWAIT;
+
 	p->flags = new_flags;
 }
 
@@ -587,7 +593,14 @@
 	p->next_run = p;
 	p->prev_run = p;
 
-	p->p_pptr = p->p_opptr = current;
+	if (!(clone_flags & CLONE_PPID)) {
+		p->p_pptr = p->p_opptr = current;
+	} else if (current->flags & PF_PPIDOK) {
+		p->p_pptr = p->p_opptr = current->p_opptr;
+	} else {
+		retval = -EPERM;
+		goto bad_fork_cleanup;
+	}
 	p->p_cptr = NULL;
 	init_waitqueue(&p->wait_chldexit);
 	p->vfork_sem = NULL;
@@ -668,7 +681,10 @@
 
 		p->next_run = NULL;
 		p->prev_run = NULL;
-		wake_up_process(p);		/* do this last */
+		if (!(clone_flags & CLONE_SUSPENDED))
+			wake_up_process(p);	/* do this last */
+		else
+			p->state = TASK_STOPPED;
 	}
 	++total_forks;
 bad_fork:

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
