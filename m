Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUHaFop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUHaFop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 01:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUHaFoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 01:44:44 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:40626 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S266603AbUHaFnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 01:43:40 -0400
Date: Mon, 30 Aug 2004 22:43:36 -0700
Message-Id: <200408310543.i7V5hav8008826@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: Andrew Morton's message of  Monday, 30 August 2004 21:26:32 -0700 <20040830212632.392cf5f5.akpm@osdl.org>
X-Shopping-List: (1) Ceramic expectorants
   (2) Pleasant optimistic friction
   (3) Presidential ablutions
   (4) Reddy-Mix Honey
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well given that waitid ha baked for a bit longer I guess we'd best make
> this patch come afterwards.  So if you could redo this patch against
> rc1-mm1, please?

Here is the TASK_TRACED patch against 2.6.9-rc1-mm1.


Thanks,
Roland



diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/arm/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/arm/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/arm/kernel/ptrace.c	2004-08-14 03:54:49.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/arm/kernel/ptrace.c	2004-08-30 22:02:55.000000000 -0700
@@ -792,11 +792,8 @@ asmlinkage void syscall_trace(int why, s
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/arm26/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/arm26/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/arm26/kernel/ptrace.c	2004-08-14 03:55:32.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/arm26/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -729,11 +729,8 @@ asmlinkage void syscall_trace(int why, s
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/cris/arch-v10/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/cris/arch-v10/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/cris/arch-v10/kernel/ptrace.c	2004-08-14 03:56:23.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/cris/arch-v10/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -85,17 +85,8 @@ sys_ptrace(long request, long pid, long 
 		goto out_tsk;
 	}
 	
-	ret = -ESRCH;
-	
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
-	
-	if (child->parent != current)
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
 		goto out_tsk;
 
 	switch (request) {
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/h8300/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/h8300/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/h8300/kernel/ptrace.c	2004-08-14 03:55:10.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/h8300/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -89,13 +89,6 @@ asmlinkage int sys_ptrace(long request, 
 		ret = ptrace_attach(child);
 		goto out_tsk;
 	}
-	ret = -ESRCH;
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
 	if (ret < 0)
 		goto out_tsk;
@@ -270,10 +263,8 @@ asmlinkage void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/m68k/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/m68k/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/m68k/kernel/ptrace.c	2004-08-14 03:55:09.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/m68k/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -379,11 +379,8 @@ asmlinkage void syscall_trace(void)
 	if (!current->thread.work.delayed_trace &&
 	    !current->thread.work.syscall_trace)
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/m68knommu/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/m68knommu/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/m68knommu/kernel/ptrace.c	2004-08-14 03:55:33.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/m68knommu/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -133,13 +133,6 @@ asmlinkage int sys_ptrace(long request, 
 		ret = ptrace_attach(child);
 		goto out_tsk;
 	}
-	ret = -ESRCH;
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
 	if (ret < 0)
 		goto out_tsk;
@@ -376,10 +369,8 @@ asmlinkage void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP;
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/parisc/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/parisc/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/parisc/kernel/ptrace.c	2004-08-14 03:54:50.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/parisc/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -404,11 +404,8 @@ void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/sh64/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/sh64/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/sh64/kernel/ptrace.c	2004-08-14 03:55:47.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/sh64/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -311,11 +311,8 @@ asmlinkage void syscall_trace(void)
 	if (!(tsk->ptrace & PT_PTRACED))
 		return;
 
-	tsk->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				    ? 0x80 : 0);
-	tsk->state = TASK_STOPPED;
-	notify_parent(tsk, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/sparc/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/sparc/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/sparc/kernel/ptrace.c	2004-08-14 03:56:23.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/sparc/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -614,12 +614,9 @@ asmlinkage void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
 	current->thread.flags ^= MAGIC_CONSTANT;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/sparc64/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/sparc64/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/sparc64/kernel/ptrace.c	2004-08-14 03:56:23.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/sparc64/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -627,11 +627,8 @@ asmlinkage void syscall_trace(void)
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/arch/v850/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/arch/v850/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/arch/v850/kernel/ptrace.c	2004-08-14 03:55:32.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/arch/v850/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -147,14 +147,8 @@ int sys_ptrace(long request, long pid, l
 		rval = ptrace_attach(child);
 		goto out_tsk;
 	}
-	rval = -ESRCH;
-	if (!(child->ptrace & PT_PTRACED))
-		goto out_tsk;
-	if (child->state != TASK_STOPPED) {
-		if (request != PTRACE_KILL)
-			goto out_tsk;
-	}
-	if (child->parent != current)
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
 		goto out_tsk;
 
 	switch (request) {
@@ -269,11 +263,8 @@ asmlinkage void syscall_trace(void)
 		return;
 	/* The 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-					? 0x80 : 0);
-	current->state = TASK_STOPPED;
-	notify_parent(current, SIGCHLD);
-	schedule();
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
+				 ? 0x80 : 0));
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/fs/proc/array.c linux-2.6.9-rc1-mm1+TASK_TRACED/fs/proc/array.c
--- linux-2.6.9-rc1-mm1/fs/proc/array.c	2004-08-27 13:46:35.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/fs/proc/array.c	2004-08-30 22:02:56.000000000 -0700
@@ -130,8 +130,9 @@ static const char *task_state_array[] = 
 	"S (sleeping)",		/*  1 */
 	"D (disk sleep)",	/*  2 */
 	"T (stopped)",		/*  4 */
-	"Z (zombie)",		/*  8 */
-	"X (dead)"		/* 16 */
+	"T (tracing stop)",	/*  8 */
+	"Z (zombie)",		/* 16 */
+	"X (dead)"		/* 32 */
 };
 
 static inline const char * get_task_state(struct task_struct *tsk)
@@ -141,7 +142,8 @@ static inline const char * get_task_stat
 					   TASK_UNINTERRUPTIBLE |
 					   TASK_ZOMBIE |
 					   TASK_DEAD |
-					   TASK_STOPPED);
+					   TASK_STOPPED |
+					   TASK_TRACED);
 	const char **p = &task_state_array[0];
 
 	while (state) {
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/fs/proc/base.c linux-2.6.9-rc1-mm1+TASK_TRACED/fs/proc/base.c
--- linux-2.6.9-rc1-mm1/fs/proc/base.c	2004-08-27 13:46:35.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/fs/proc/base.c	2004-08-30 22:02:56.000000000 -0700
@@ -300,7 +300,8 @@ static int proc_root_link(struct inode *
 #define MAY_PTRACE(task) \
 	(task == current || \
 	(task->parent == current && \
-	(task->ptrace & PT_PTRACED) &&  task->state == TASK_STOPPED && \
+	(task->ptrace & PT_PTRACED) && \
+	 (task->state == TASK_STOPPED || task->state == TASK_TRACED) && \
 	 security_ptrace(current,task) == 0))
 
 static int may_ptrace_attach(struct task_struct *task)
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/include/linux/sched.h linux-2.6.9-rc1-mm1+TASK_TRACED/include/linux/sched.h
--- linux-2.6.9-rc1-mm1/include/linux/sched.h	2004-08-27 13:46:37.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/include/linux/sched.h	2004-08-30 22:02:56.657738337 -0700
@@ -107,8 +107,9 @@ extern unsigned long nr_iowait(void);
 #define TASK_INTERRUPTIBLE	1
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_STOPPED		4
-#define TASK_ZOMBIE		8
-#define TASK_DEAD		16
+#define TASK_TRACED		8
+#define TASK_ZOMBIE		16
+#define TASK_DEAD		32
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
@@ -758,7 +759,6 @@ extern int __kill_pg_info(int sig, struc
 extern int kill_pg_info(int, struct siginfo *, pid_t);
 extern int kill_sl_info(int, struct siginfo *, pid_t);
 extern int kill_proc_info(int, struct siginfo *, pid_t);
-extern void notify_parent(struct task_struct *, int);
 extern void do_notify_parent(struct task_struct *, int);
 extern void force_sig(int, struct task_struct *);
 extern void force_sig_specific(int, struct task_struct *);
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/kernel/exit.c linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/exit.c
--- linux-2.6.9-rc1-mm1/kernel/exit.c	2004-08-27 13:46:37.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/exit.c	2004-08-30 22:02:56.000000000 -0700
@@ -564,6 +564,14 @@ static inline void reparent_thread(task_
 		if (p->state == TASK_ZOMBIE && p->exit_signal != -1 &&
 		    thread_group_empty(p))
 			do_notify_parent(p, p->exit_signal);
+		else if (p->state == TASK_TRACED) {
+			/*
+			 * If it was at a trace stop, turn it into
+			 * a normal stop since it's no longer being
+			 * traced.
+			 */
+			p->state = TASK_STOPPED;
+		}
 	}
 
 	/*
@@ -1201,7 +1209,7 @@ static int wait_task_stopped(task_t *p, 
 	 * race with the TASK_ZOMBIE case.
 	 */
 	exit_code = xchg(&p->exit_code, 0);
-	if (unlikely(p->state > TASK_STOPPED)) {
+	if (unlikely(p->state >= TASK_ZOMBIE)) {
 		/*
 		 * The task resumed and then died.  Let the next iteration
 		 * catch it in TASK_ZOMBIE.  Note that exit_code might
@@ -1282,6 +1290,10 @@ repeat:
 			flag = 1;
 
 			switch (p->state) {
+			case TASK_TRACED:
+				if (!(p->ptrace & PT_PTRACED))
+					continue;
+				/*FALLTHROUGH*/
 			case TASK_STOPPED:
 				if (!(options & WUNTRACED) &&
 				    !(p->ptrace & PT_PTRACED))
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/kernel/power/process.c linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/power/process.c
--- linux-2.6.9-rc1-mm1/kernel/power/process.c	2004-08-14 03:54:47.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/power/process.c	2004-08-30 22:02:56.000000000 -0700
@@ -25,7 +25,8 @@ static inline int freezeable(struct task
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->state == TASK_ZOMBIE) ||
 	    (p->state == TASK_DEAD) ||
-	    (p->state == TASK_STOPPED))
+	    (p->state == TASK_STOPPED) ||
+	    (p->state == TASK_TRACED))
 		return 0;
 	return 1;
 }
@@ -70,6 +71,7 @@ int freeze_processes(void)
 			if (!freezeable(p))
 				continue;
 			if ((p->flags & PF_FROZEN) ||
+			    (p->state == TASK_TRACED) ||
 			    (p->state == TASK_STOPPED))
 				continue;
 
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/kernel/ptrace.c linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/ptrace.c
--- linux-2.6.9-rc1-mm1/kernel/ptrace.c	2004-08-14 03:56:24.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/ptrace.c	2004-08-30 22:02:56.000000000 -0700
@@ -55,6 +55,15 @@ void __ptrace_unlink(task_t *child)
 	REMOVE_LINKS(child);
 	child->parent = child->real_parent;
 	SET_LINKS(child);
+
+	if (child->state == TASK_TRACED) {
+		/*
+		 * Turn a tracing stop into a normal stop now,
+		 * since with no tracer there would be no way
+		 * to wake it up with SIGCONT or SIGKILL.
+		 */
+		child->state = TASK_STOPPED;
+	}
 }
 
 /*
@@ -62,20 +71,28 @@ void __ptrace_unlink(task_t *child)
  */
 int ptrace_check_attach(struct task_struct *child, int kill)
 {
-	if (!(child->ptrace & PT_PTRACED))
-		return -ESRCH;
+	int ret = -ESRCH;
 
-	if (child->parent != current)
-		return -ESRCH;
+	/*
+	 * We take the read lock around doing both checks to close a
+	 * possible race where someone else was tracing our child and
+	 * detached between these two checks.  After this locked check,
+	 * we are sure that this is our traced child and that can only
+	 * be changed by us so it's not changing right after this.
+	 */
+	read_lock(&tasklist_lock);
+	if ((child->ptrace & PT_PTRACED) && child->parent == current)
+		ret = 0;
+	read_unlock(&tasklist_lock);
 
-	if (!kill) {
-		if (child->state != TASK_STOPPED)
+	if (!ret && !kill) {
+		if (child->state != TASK_TRACED)
 			return -ESRCH;
 		wait_task_inactive(child);
 	}
 
 	/* All systems go.. */
-	return 0;
+	return ret;
 }
 
 int ptrace_attach(struct task_struct *task)
@@ -281,15 +298,13 @@ static int ptrace_setoptions(struct task
 
 static int ptrace_getsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	if (child->last_siginfo == NULL)
-		return -EINVAL;
+	BUG_ON(child->last_siginfo == NULL);
 	return copy_siginfo_to_user(data, child->last_siginfo);
 }
 
 static int ptrace_setsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	if (child->last_siginfo == NULL)
-		return -EINVAL;
+	BUG_ON(child->last_siginfo == NULL);
 	if (copy_from_user(child->last_siginfo, data, sizeof (siginfo_t)) != 0)
 		return -EFAULT;
 	return 0;
@@ -322,24 +337,3 @@ int ptrace_request(struct task_struct *c
 
 	return ret;
 }
-
-void ptrace_notify(int exit_code)
-{
-	BUG_ON (!(current->ptrace & PT_PTRACED));
-
-	/* Let the debugger run.  */
-	current->exit_code = exit_code;
-	set_current_state(TASK_STOPPED);
-	notify_parent(current, SIGCHLD);
-	schedule();
-
-	/*
-	 * Signals sent while we were stopped might set TIF_SIGPENDING.
-	 */
-
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
-}
-
-EXPORT_SYMBOL(ptrace_notify);
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/kernel/sched.c linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/sched.c
--- linux-2.6.9-rc1-mm1/kernel/sched.c	2004-08-27 13:46:37.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/sched.c	2004-08-30 22:03:27.000000000 -0700
@@ -1174,7 +1174,7 @@ out:
 
 int fastcall wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, TASK_STOPPED |
+	return try_to_wake_up(p, TASK_STOPPED | TASK_TRACED |
 				TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE, 0);
 }
 
@@ -3493,7 +3493,7 @@ static void show_task(task_t * p)
 	task_t *relative;
 	unsigned state;
 	unsigned long free = 0;
-	static const char *stat_nam[] = { "R", "S", "D", "T", "Z", "W" };
+	static const char *stat_nam[] = { "R", "S", "D", "T", "t", "Z", "X" };
 
 	printk("%-13.13s ", p->comm);
 	state = p->state ? __ffs(p->state) + 1 : 0;
diff -rzBpu --exclude='.*' --exclude='*.o' linux-2.6.9-rc1-mm1/kernel/signal.c linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/signal.c
--- linux-2.6.9-rc1-mm1/kernel/signal.c	2004-08-27 13:46:37.000000000 -0700
+++ linux-2.6.9-rc1-mm1+TASK_TRACED/kernel/signal.c	2004-08-30 22:08:42.000000000 -0700
@@ -636,7 +636,8 @@ static int check_kill_permission(int sig
 
 /* forward decl */
 static void do_notify_parent_cldstop(struct task_struct *tsk,
-				     struct task_struct *parent);
+				     struct task_struct *parent,
+				     int why);
 
 /*
  * Handle magic process-wide effects of stop/continue signals.
@@ -681,11 +682,13 @@ static void handle_stop_signal(int sig, 
 			p->signal->stop_state = 1;
 			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
-				do_notify_parent_cldstop(p, p->parent);
+				do_notify_parent_cldstop(p, p->parent,
+							 CLD_STOPPED);
 			else
 				do_notify_parent_cldstop(
 					p->group_leader,
-					p->group_leader->real_parent);
+					p->group_leader->real_parent,
+							 CLD_STOPPED);
 			spin_lock(&p->sighand->siglock);
 		}
 		rm_from_queue(SIG_KERNEL_STOP_MASK, &p->signal->shared_pending);
@@ -727,11 +730,13 @@ static void handle_stop_signal(int sig, 
 			p->signal->group_exit_code = 0;
 			spin_unlock(&p->sighand->siglock);
 			if (p->ptrace & PT_PTRACED)
-				do_notify_parent_cldstop(p, p->parent);
+				do_notify_parent_cldstop(p, p->parent,
+							 CLD_CONTINUED);
 			else
 				do_notify_parent_cldstop(
 					p->group_leader,
-					p->group_leader->real_parent);
+					p->group_leader->real_parent,
+							 CLD_CONTINUED);
 			spin_lock(&p->sighand->siglock);
 		}
 	}
@@ -899,11 +904,20 @@ force_sig_specific(int sig, struct task_
 
 
 static void
-__group_complete_signal(int sig, struct task_struct *p, unsigned int mask)
+__group_complete_signal(int sig, struct task_struct *p)
 {
+	unsigned int mask;
 	struct task_struct *t;
 
 	/*
+	 * Don't bother zombies and stopped tasks (but
+	 * SIGKILL will punch through stopped state)
+	 */
+	mask = TASK_DEAD | TASK_ZOMBIE | TASK_TRACED;
+	if (sig != SIGKILL)
+		mask |= TASK_STOPPED;
+
+	/*
 	 * Now find a thread we can wake up to take the signal off the queue.
 	 *
 	 * If the main thread wants the signal, it gets first crack.
@@ -1004,7 +1018,6 @@ __group_complete_signal(int sig, struct 
 static int
 __group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
-	unsigned int mask;
 	int ret = 0;
 
 #ifdef CONFIG_SMP
@@ -1028,14 +1041,6 @@ __group_send_sig_info(int sig, struct si
 		return ret;
 
 	/*
-	 * Don't bother zombies and stopped tasks (but
-	 * SIGKILL will punch through stopped state)
-	 */
-	mask = TASK_DEAD | TASK_ZOMBIE;
-	if (sig != SIGKILL)
-		mask |= TASK_STOPPED;
-
-	/*
 	 * Put this signal on the shared-pending queue, or fail with EAGAIN.
 	 * We always use the shared queue for process-wide signals,
 	 * to avoid several races.
@@ -1044,7 +1049,7 @@ __group_send_sig_info(int sig, struct si
 	if (unlikely(ret))
 		return ret;
 
-	__group_complete_signal(sig, p, mask);
+	__group_complete_signal(sig, p);
 	return 0;
 }
 
@@ -1405,7 +1410,6 @@ int
 send_group_sigqueue(int sig, struct sigqueue *q, struct task_struct *p)
 {
 	unsigned long flags;
-	unsigned int mask;
 	int ret = 0;
 
 	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
@@ -1430,13 +1434,6 @@ send_group_sigqueue(int sig, struct sigq
 		q->info.si_overrun++;
 		goto out;
 	} 
-	/*
-	 * Don't bother zombies and stopped tasks (but
-	 * SIGKILL will punch through stopped state)
-	 */
-	mask = TASK_DEAD | TASK_ZOMBIE;
-	if (sig != SIGKILL)
-		mask |= TASK_STOPPED;
 
 	/*
 	 * Put this signal on the shared-pending queue.
@@ -1447,7 +1444,7 @@ send_group_sigqueue(int sig, struct sigq
 	list_add_tail(&q->list, &p->signal->shared_pending.list);
 	sigaddset(&p->signal->shared_pending.signal, sig);
 
-	__group_complete_signal(sig, p, mask);
+	__group_complete_signal(sig, p);
 out:
 	spin_unlock_irqrestore(&p->sighand->siglock, flags);
 	read_unlock(&tasklist_lock);
@@ -1480,19 +1477,22 @@ static void __wake_up_parent(struct task
 }
 
 /*
- * Let a parent know about a status change of a child.
+ * Let a parent know about the death of a child.
+ * For a stopped/continued status change, use do_notify_parent_cldstop instead.
  */
 
 void do_notify_parent(struct task_struct *tsk, int sig)
 {
 	struct siginfo info;
 	unsigned long flags;
-	int why, status;
 	struct sighand_struct *psig;
 
 	if (sig == -1)
 		BUG();
 
+ 	/* do_notify_parent_cldstop should have been called instead.  */
+ 	BUG_ON(tsk->state & (TASK_STOPPED|TASK_TRACED));
+
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
@@ -1506,34 +1506,19 @@ void do_notify_parent(struct task_struct
 	info.si_stime = tsk->stime + tsk->signal->stime;
 	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
-	status = tsk->exit_code & 0x7f;
-	why = SI_KERNEL;	/* shouldn't happen */
-	switch (tsk->state) {
-	case TASK_STOPPED:
-		/* FIXME -- can we deduce CLD_TRAPPED or CLD_CONTINUED? */
-		if (tsk->ptrace & PT_PTRACED)
-			why = CLD_TRAPPED;
-		else
-			why = CLD_STOPPED;
-		break;
-
-	default:
-		if (tsk->exit_code & 0x80)
-			why = CLD_DUMPED;
-		else if (tsk->exit_code & 0x7f)
-			why = CLD_KILLED;
-		else {
-			why = CLD_EXITED;
-			status = tsk->exit_code >> 8;
-		}
-		break;
+	info.si_status = tsk->exit_code & 0x7f;
+	if (tsk->exit_code & 0x80)
+		info.si_code = CLD_DUMPED;
+	else if (tsk->exit_code & 0x7f)
+		info.si_code = CLD_KILLED;
+	else {
+		info.si_code = CLD_EXITED;
+		info.si_status = tsk->exit_code >> 8;
 	}
-	info.si_code = why;
-	info.si_status = status;
 
 	psig = tsk->parent->sighand;
 	spin_lock_irqsave(&psig->siglock, flags);
-	if (sig == SIGCHLD && tsk->state != TASK_STOPPED &&
+	if (sig == SIGCHLD &&
 	    (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN ||
 	     (psig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDWAIT))) {
 		/*
@@ -1561,26 +1546,9 @@ void do_notify_parent(struct task_struct
 	spin_unlock_irqrestore(&psig->siglock, flags);
 }
 
-
-/*
- * We need the tasklist lock because it's the only
- * thing that protects out "parent" pointer.
- *
- * exit.c calls "do_notify_parent()" directly, because
- * it already has the tasklist lock.
- */
-void
-notify_parent(struct task_struct *tsk, int sig)
-{
-	if (sig != -1) {
-		read_lock(&tasklist_lock);
-		do_notify_parent(tsk, sig);
-		read_unlock(&tasklist_lock);
-	}
-}
-
 static void
-do_notify_parent_cldstop(struct task_struct *tsk, struct task_struct *parent)
+do_notify_parent_cldstop(struct task_struct *tsk, struct task_struct *parent,
+			 int why)
 {
 	struct siginfo info;
 	unsigned long flags;
@@ -1596,14 +1564,20 @@ do_notify_parent_cldstop(struct task_str
 	info.si_stime = tsk->stime;
 	k_getrusage(tsk, RUSAGE_BOTH, &info.si_rusage);
 
-	info.si_status = (tsk->signal ? tsk->signal->group_exit_code :
-			  tsk->exit_code) & 0x7f;
-	if (info.si_status == 0) {
-		info.si_status = SIGCONT;
-		info.si_code = CLD_CONTINUED;
-	} else {
-		info.si_code = CLD_STOPPED;
-	}
+ 	info.si_code = why;
+ 	switch (why) {
+ 	case CLD_CONTINUED:
+ 		info.si_status = SIGCONT;
+ 		break;
+ 	case CLD_STOPPED:
+ 		info.si_status = tsk->signal->group_exit_code & 0x7f;
+ 		break;
+ 	case CLD_TRAPPED:
+ 		info.si_status = tsk->exit_code & 0x7f;
+ 		break;
+ 	default:
+ 		BUG();
+ 	}
 
 	sighand = parent->sighand;
 	spin_lock_irqsave(&sighand->siglock, flags);
@@ -1617,6 +1591,68 @@ do_notify_parent_cldstop(struct task_str
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+/*
+ * This must be called with current->sighand->siglock held.
+ *
+ * This should be the path for all ptrace stops.
+ * We always set current->last_siginfo while stopped here.
+ * That makes it a way to test a stopped process for
+ * being ptrace-stopped vs being job-control-stopped.
+ */
+static void ptrace_stop(int exit_code, siginfo_t *info)
+{
+	BUG_ON(!(current->ptrace & PT_PTRACED));
+
+	/*
+	 * If there is a group stop in progress,
+	 * we must participate in the bookkeeping.
+	 */
+	if (current->signal->group_stop_count > 0)
+		--current->signal->group_stop_count;
+
+	current->last_siginfo = info;
+	current->exit_code = exit_code;
+
+	/* Let the debugger run.  */
+	set_current_state(TASK_TRACED);
+	spin_unlock_irq(&current->sighand->siglock);
+	read_lock(&tasklist_lock);
+	do_notify_parent_cldstop(current, current->parent, CLD_TRAPPED);
+	read_unlock(&tasklist_lock);
+	schedule();
+
+	/*
+	 * We are back.  Now reacquire the siglock before touching
+	 * last_siginfo, so that we are sure to have synchronized with
+	 * any signal-sending on another CPU that wants to examine it.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	current->last_siginfo = NULL;
+
+	/*
+	 * Queued signals ignored us while we were stopped for tracing.
+	 * So check for any that we should take before resuming user mode.
+	 */
+	recalc_sigpending();
+}
+
+void ptrace_notify(int exit_code)
+{
+	siginfo_t info;
+
+	BUG_ON((exit_code & (0x7f | ~0xffff)) != SIGTRAP);
+
+	memset(&info, 0, sizeof info);
+	info.si_signo = SIGTRAP;
+	info.si_code = exit_code;
+	info.si_pid = current->pid;
+	info.si_uid = current->uid;
+
+	/* Let the debugger run.  */
+	spin_lock_irq(&current->sighand->siglock);
+	ptrace_stop(exit_code, &info);
+	spin_unlock_irq(&current->sighand->siglock);
+}
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 
@@ -1630,13 +1666,15 @@ finish_stop(int stop_count)
 	 */
 	if (stop_count < 0 || (current->ptrace & PT_PTRACED)) {
 		read_lock(&tasklist_lock);
-		do_notify_parent_cldstop(current, current->parent);
+		do_notify_parent_cldstop(current, current->parent,
+					 CLD_STOPPED);
 		read_unlock(&tasklist_lock);
 	}
 	else if (stop_count == 0) {
 		read_lock(&tasklist_lock);
 		do_notify_parent_cldstop(current->group_leader,
-					 current->group_leader->real_parent);
+					 current->group_leader->real_parent,
+					 CLD_STOPPED);
 		read_unlock(&tasklist_lock);
 	}
 
@@ -1819,25 +1857,10 @@ relock:
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			ptrace_signal_deliver(regs, cookie);
 
-			/*
-			 * If there is a group stop in progress,
-			 * we must participate in the bookkeeping.
-			 */
-			if (current->signal->group_stop_count > 0)
-				--current->signal->group_stop_count;
-
 			/* Let the debugger run.  */
-			current->exit_code = signr;
-			current->last_siginfo = info;
-			set_current_state(TASK_STOPPED);
-			spin_unlock_irq(&current->sighand->siglock);
-			notify_parent(current, SIGCHLD);
-			schedule();
-
-			current->last_siginfo = NULL;
+			ptrace_stop(signr, info);
 
 			/* We're back.  Did the debugger cancel the sig?  */
-			spin_lock_irq(&current->sighand->siglock);
 			signr = current->exit_code;
 			if (signr == 0)
 				continue;
@@ -1968,7 +1991,7 @@ EXPORT_SYMBOL(kill_proc);
 EXPORT_SYMBOL(kill_proc_info);
 EXPORT_SYMBOL(kill_sl);
 EXPORT_SYMBOL(kill_sl_info);
-EXPORT_SYMBOL(notify_parent);
+EXPORT_SYMBOL(ptrace_notify);
 EXPORT_SYMBOL(send_sig);
 EXPORT_SYMBOL(send_sig_info);
 EXPORT_SYMBOL(send_group_sig_info);
