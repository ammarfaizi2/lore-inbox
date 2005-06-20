Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVFTTuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVFTTuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFTTG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:06:59 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:26122 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261484AbVFTS4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:56:49 -0400
Message-Id: <200506201851.j5KIpFiY008483@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade@yahoo.it
Subject: [PATCH 3/8] UML - fork cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Jun 2005 14:51:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the do_fork calling convention: normal arch pass the regs and the new sp
value to do_fork instead of NULL.

Currently the arch-independent code ignores these values, while the UML code
(actually it's copy_thread) gets the right values by itself.

With this patch, things are fixed up.

Low-priority.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/process_kern.c	2005-06-20 11:54:49.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/process_kern.c	2005-06-20 12:02:19.000000000 -0400
@@ -96,8 +96,8 @@ int kernel_thread(int (*fn)(void *), voi
 
 	current->thread.request.u.thread.proc = fn;
 	current->thread.request.u.thread.arg = arg;
-	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0, NULL, 0, NULL,
-		      NULL);
+	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0, 
+		      &current->thread.regs, 0, NULL, NULL);
 	if(pid < 0)
 		panic("do_fork failed in kernel_thread, errno = %d", pid);
 	return(pid);
Index: linux-2.6.12/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/process_kern.c	2005-06-20 11:54:56.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/process_kern.c	2005-06-20 12:02:32.000000000 -0400
@@ -111,8 +111,7 @@ int copy_thread_skas(int nr, unsigned lo
   	void (*handler)(int);
 
 	if(current->thread.forking){
-	  	memcpy(&p->thread.regs.regs.skas, 
-		       &current->thread.regs.regs.skas, 
+	  	memcpy(&p->thread.regs.regs.skas, &regs->regs.skas,
 		       sizeof(p->thread.regs.regs.skas));
 		REGS_SET_SYSCALL_RETURN(p->thread.regs.regs.skas.regs, 0);
 		if(sp != 0) REGS_SP(p->thread.regs.regs.skas.regs) = sp;
@@ -201,14 +200,3 @@ int thread_pid_skas(struct task_struct *
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
Index: linux-2.6.12/arch/um/kernel/syscall_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/syscall_kern.c	2005-06-20 11:54:44.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/syscall_kern.c	2005-06-20 12:03:19.000000000 -0400
@@ -31,7 +31,8 @@ long sys_fork(void)
 	long ret;
 
 	current->thread.forking = 1;
-        ret = do_fork(SIGCHLD, 0, NULL, 0, NULL, NULL);
+	ret = do_fork(SIGCHLD, UPT_SP(&current->thread.regs.regs),
+		      &current->thread.regs, 0, NULL, NULL);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -41,8 +42,9 @@ long sys_vfork(void)
 	long ret;
 
 	current->thread.forking = 1;
-	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD, 0, NULL, 0, NULL,
-		      NULL);
+	ret = do_fork(CLONE_VFORK | CLONE_VM | SIGCHLD,
+		      UPT_SP(&current->thread.regs.regs), 
+		      &current->thread.regs, 0, NULL, NULL);
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
Index: linux-2.6.12/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/process_kern.c	2005-06-20 11:54:54.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/process_kern.c	2005-06-20 12:03:45.000000000 -0400
@@ -266,10 +266,10 @@ int copy_thread_tt(int nr, unsigned long
 	}
 
 	if(current->thread.forking){
-		sc_to_sc(UPT_SC(&p->thread.regs.regs), 
-			 UPT_SC(&current->thread.regs.regs));
+		sc_to_sc(UPT_SC(&p->thread.regs.regs), UPT_SC(&regs->regs));
 		SC_SET_SYSCALL_RETURN(UPT_SC(&p->thread.regs.regs), 0);
-		if(sp != 0) SC_SP(UPT_SC(&p->thread.regs.regs)) = sp;
+		if(sp != 0) 
+			SC_SP(UPT_SC(&p->thread.regs.regs)) = sp;
 	}
 	p->thread.mode.tt.extern_pid = new_pid;
 
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
Index: linux-2.6.12/arch/um/sys-i386/syscalls.c
===================================================================
--- linux-2.6.12.orig/arch/um/sys-i386/syscalls.c	2005-06-20 11:54:44.000000000 -0400
+++ linux-2.6.12/arch/um/sys-i386/syscalls.c	2005-06-20 12:04:32.000000000 -0400
@@ -69,15 +69,11 @@ long sys_clone(unsigned long clone_flags
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
+	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid,
+		      child_tid);
 	current->thread.forking = 0;
 	return(ret);
 }
@@ -197,14 +193,3 @@ long sys_sigaction(int sig, const struct
 
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
Index: linux-2.6.12/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6.12.orig/arch/um/sys-x86_64/syscalls.c	2005-06-20 11:54:52.000000000 -0400
+++ linux-2.6.12/arch/um/sys-x86_64/syscalls.c	2005-06-20 12:04:14.000000000 -0400
@@ -174,26 +174,11 @@ long sys_clone(unsigned long clone_flags
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
+	ret = do_fork(clone_flags, newsp, &current->thread.regs, 0, parent_tid,
+		      child_tid);
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

