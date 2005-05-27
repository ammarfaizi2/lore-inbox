Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVE0BKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVE0BKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVE0BJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:09:39 -0400
Received: from [151.97.230.9] ([151.97.230.9]:52497 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261454AbVE0BFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:23 -0400
Subject: [patch 1/4] uml: do_fork calling cleanup
To: jdike@addtoit.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 27 May 2005 02:40:15 +0200
Message-Id: <20050527004015.F3AE11AEE94@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the do_fork calling convention: normal arch pass the regs and the new sp
value to do_fork instead of NULL.

Currently the arch-independent code ignores these values, while the UML code
(actually it's copy_thread) gets the right values by itself.

With this patch, things are fixed up.

Low-priority.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/process_kern.c      |   17 ++-----------
 linux-2.6.git-paolo/arch/um/kernel/skas/process_kern.c |   13 ----------
 linux-2.6.git-paolo/arch/um/kernel/syscall_kern.c      |   19 +++-----------
 linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c   |   15 +----------
 linux-2.6.git-paolo/arch/um/sys-i386/syscalls.c        |   22 ++---------------
 linux-2.6.git-paolo/arch/um/sys-x86_64/syscalls.c      |   22 ++---------------
 6 files changed, 17 insertions(+), 91 deletions(-)

diff -puN arch/um/sys-i386/syscalls.c~uml-do_fork-param-cleanup arch/um/sys-i386/syscalls.c
--- linux-2.6.git/arch/um/sys-i386/syscalls.c~uml-do_fork-param-cleanup	2005-05-27 02:39:32.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-i386/syscalls.c	2005-05-27 02:39:32.000000000 +0200
@@ -69,15 +69,10 @@ long sys_clone(unsigned long clone_flags
 {
 	long ret;
 
-	/* XXX: normal arch do here this pass, and also pass the regs to
-	 * do_fork, instead of NULL. Currently the arch-independent code
-	 * ignores these values, while the UML code (actually it's
-	 * copy_thread) does the right thing. But this should change,
-	 probably. */
-	/*if (!newsp)
-		newsp = UPT_SP(current->thread.regs);*/
+	if (!newsp)
+		newsp = UPT_SP(&current->thread.regs.regs);
 	current->thread.forking = 1;
-	ret = do_fork(clone_flags, newsp, NULL, 0, parent_tid, child_tid);
+	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid, child_tid);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -197,14 +192,3 @@ long sys_sigaction(int sig, const struct
 
 	return ret;
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/tt/process_kern.c~uml-do_fork-param-cleanup arch/um/kernel/tt/process_kern.c
--- linux-2.6.git/arch/um/kernel/tt/process_kern.c~uml-do_fork-param-cleanup	2005-05-27 02:39:32.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/tt/process_kern.c	2005-05-27 02:39:32.000000000 +0200
@@ -266,8 +266,8 @@ int copy_thread_tt(int nr, unsigned long
 	}
 
 	if(current->thread.forking){
-		sc_to_sc(UPT_SC(&p->thread.regs.regs), 
-			 UPT_SC(&current->thread.regs.regs));
+		sc_to_sc(UPT_SC(&p->thread.regs.regs),
+			 UPT_SC(&regs->regs));
 		SC_SET_SYSCALL_RETURN(UPT_SC(&p->thread.regs.regs), 0);
 		if(sp != 0) SC_SP(UPT_SC(&p->thread.regs.regs)) = sp;
 	}
@@ -459,14 +459,3 @@ int is_valid_pid(int pid)
 	read_unlock(&tasklist_lock);
 	return(0);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/skas/process_kern.c~uml-do_fork-param-cleanup arch/um/kernel/skas/process_kern.c
--- linux-2.6.git/arch/um/kernel/skas/process_kern.c~uml-do_fork-param-cleanup	2005-05-27 02:39:32.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/skas/process_kern.c	2005-05-27 02:39:32.000000000 +0200
@@ -107,7 +107,7 @@ int copy_thread_skas(int nr, unsigned lo
 
 	if(current->thread.forking){
 	  	memcpy(&p->thread.regs.regs.skas, 
-		       &current->thread.regs.regs.skas, 
+		       &regs->regs.skas,
 		       sizeof(p->thread.regs.regs.skas));
 		REGS_SET_SYSCALL_RETURN(p->thread.regs.regs.skas.regs, 0);
 		if(sp != 0) REGS_SP(p->thread.regs.regs.skas.regs) = sp;
@@ -196,14 +196,3 @@ int thread_pid_skas(struct task_struct *
 #warning Need to look up userspace_pid by cpu
 	return(userspace_pid[0]);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/syscall_kern.c~uml-do_fork-param-cleanup arch/um/kernel/syscall_kern.c
--- linux-2.6.git/arch/um/kernel/syscall_kern.c~uml-do_fork-param-cleanup	2005-05-27 02:39:32.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/syscall_kern.c	2005-05-27 02:39:32.000000000 +0200
@@ -31,7 +31,8 @@ long sys_fork(void)
 	long ret;
 
 	current->thread.forking = 1;
-        ret = do_fork(SIGCHLD, 0, NULL, 0, NULL, NULL);
+	ret = do_fork(SIGCHLD, UPT_SP(&current->thread.regs.regs),
+			&current->thread.regs, 0, NULL, NULL);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -41,8 +42,9 @@ long sys_vfork(void)
 	long ret;
 
 	current->thread.forking = 1;
-	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0, NULL, 0, NULL,
-		      NULL);
+	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
+			UPT_SP(&current->thread.regs.regs), &current->thread.regs, 0,
+			NULL, NULL);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -162,14 +164,3 @@ int next_syscall_index(int limit)
 	spin_unlock(&syscall_lock);
 	return(ret);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/kernel/process_kern.c~uml-do_fork-param-cleanup arch/um/kernel/process_kern.c
--- linux-2.6.git/arch/um/kernel/process_kern.c~uml-do_fork-param-cleanup	2005-05-27 02:39:32.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/process_kern.c	2005-05-27 02:39:32.000000000 +0200
@@ -108,8 +108,9 @@ int kernel_thread(int (*fn)(void *), voi
 
 	current->thread.request.u.thread.proc = fn;
 	current->thread.request.u.thread.arg = arg;
-	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0, NULL, 0, NULL,
-		      NULL);
+	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags,
+			0, &current->thread.regs, 0,
+			NULL, NULL);
 	if(pid < 0)
 		panic("do_fork failed in kernel_thread, errno = %d", pid);
 	return(pid);
@@ -480,15 +481,3 @@ unsigned long arch_align_stack(unsigned 
 	return sp & ~0xf;
 }
 #endif
-
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff -puN arch/um/sys-x86_64/syscalls.c~uml-do_fork-param-cleanup arch/um/sys-x86_64/syscalls.c
--- linux-2.6.git/arch/um/sys-x86_64/syscalls.c~uml-do_fork-param-cleanup	2005-05-27 02:39:32.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/sys-x86_64/syscalls.c	2005-05-27 02:39:32.000000000 +0200
@@ -174,26 +174,10 @@ long sys_clone(unsigned long clone_flags
 {
 	long ret;
 
-	/* XXX: normal arch do here this pass, and also pass the regs to
-	 * do_fork, instead of NULL. Currently the arch-independent code
-	 * ignores these values, while the UML code (actually it's
-	 * copy_thread) does the right thing. But this should change,
-	 probably. */
-	/*if (!newsp)
-		newsp = UPT_SP(current->thread.regs);*/
+	if (!newsp)
+		newsp = UPT_SP(&current->thread.regs.regs);
 	current->thread.forking = 1;
-	ret = do_fork(clone_flags, newsp, NULL, 0, parent_tid, child_tid);
+	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid, child_tid);
 	current->thread.forking = 0;
 	return(ret);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_
