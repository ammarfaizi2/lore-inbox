Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269155AbUIYAwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269155AbUIYAwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 20:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269156AbUIYAw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 20:52:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15834 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269155AbUIYAvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 20:51:41 -0400
Date: Fri, 24 Sep 2004 17:51:24 -0700
Message-Id: <200409250051.i8P0pO5v007053@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Chris Wright <chrisw@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix PTRACE_ATTACH race with real parent's wait calls
In-Reply-To: Chris Wright's message of  Friday, 24 September 2004 16:32:10 -0700 <20040924163210.X1973@build.pdx.osdl.net>
Emacs: an inspiring example of form following function... to Hell.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, checking for setuid during exec does.  I wonder if this opens a
> race (again, this area is always touchy).  /me looks deeper

Hmm, I see.  If we stick with my change, it seems straightforward to make
that use read_lock(&tasklist_lock).  However, I've also noticed that every
arch's sys_execve has:

		current->ptrace &= ~PT_DTRACE;

with no locking at all.  So, if an exec happens in a race with
PTRACE_ATTACH, you could wind up with ->ptrace not having PT_PTRACED set
because this store clobbered it.  That will cause later BUG hits because
the parent links indicate ptracedness but the flag is not set.
write_lock_irq here is a bit heavy.  

Here is an alternative patch that takes a different approach, staying with
task_lock for setting ->ptrace.  First, it corrects all the places I found
to use task_lock around diddling ->ptrace when it's possible to be racing
with ptrace_attach.  (The ptrace operation code itself doesn't have this
issue because it already excludes anyone else being in ptrace_attach.)

Now to avoid the race I found, I've just made the wait code detect that
case directly.  For this a new PT_ATTACHED flag is set by ptrace_attach.
Now it's possible to see PT_PTRACED|PT_ATTACHED and be sure that the
real_parent should not be parent right now.  When it is, we have hit the
race, and the real parent's wait should not act as if it's ptracing this child.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>


--- linux-2.6/kernel/exit.c 24 Sep 2004 06:41:46 -0000
+++ linux-2.6/kernel/exit.c 25 Sep 2004 00:08:24 -0000
@@ -1228,6 +1229,22 @@
 	return retval;
 }
 
+static inline int my_ptrace_child(struct task_struct *p)
+{
+	if (!(p->ptrace & PT_PTRACED))
+		return 0;
+	if (!(p->ptrace & PT_ATTACHED))
+		return 1;
+	/*
+	 * This child was PTRACE_ATTACH'd.  We should be seeing it only if
+	 * we are the attacher.  If we are the real parent, this is a race
+	 * inside ptrace_attach.  It is waiting for the tasklist_lock,
+	 * which we have to switch the parent links, but has already set
+	 * the flags in p->ptrace.
+	 */
+	return (p->parent != p->real_parent);
+}
+
 static long do_wait(pid_t pid, int options, struct siginfo __user *infop,
 		    int __user *stat_addr, struct rusage __user *ru)
 {
@@ -1256,12 +1273,12 @@
 
 			switch (p->state) {
 			case TASK_TRACED:
-				if (!(p->ptrace & PT_PTRACED))
+				if (!my_ptrace_child(p))
 					continue;
 				/*FALLTHROUGH*/
 			case TASK_STOPPED:
 				if (!(options & WUNTRACED) &&
-				    !(p->ptrace & PT_PTRACED))
+				    !my_ptrace_child(p))
 					continue;
 				retval = wait_task_stopped(p, ret == 2,
 							   (options & WNOWAIT),
--- linux-2.6/arch/i386/kernel/process.c 17 Sep 2004 19:09:12 -0000 1.89
+++ linux-2.6/arch/i386/kernel/process.c 25 Sep 2004 00:11:48 -0000
@@ -656,7 +656,9 @@ asmlinkage int sys_execve(struct pt_regs
 			(char __user * __user *) regs.edx,
 			&regs);
 	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
 		/* Make sure we don't return using sysenter.. */
 		set_thread_flag(TIF_IRET);
 	}
--- linux-2.6/arch/m32r/kernel/process.c 17 Sep 2004 19:04:42 -0000 1.3
+++ linux-2.6/arch/m32r/kernel/process.c 25 Sep 2004 00:11:55 -0000
@@ -335,8 +335,11 @@ asmlinkage int sys_execve(char __user *u
 		goto out;
 
 	error = do_execve(filename, uargv, uenvp, &regs);
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 out:
 	return error;
--- linux-2.6/arch/parisc/hpux/fs.c 7 Feb 2004 00:57:55 -0000 1.11
+++ linux-2.6/arch/parisc/hpux/fs.c 25 Sep 2004 00:14:53 -0000
@@ -43,8 +43,11 @@ int hpux_execve(struct pt_regs *regs)
 	error = do_execve(filename, (char **) regs->gr[25],
 		(char **)regs->gr[24], regs);
 
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 
 out:
--- linux-2.6/arch/parisc/kernel/process.c 24 Aug 2004 18:27:07 -0000 1.21
+++ linux-2.6/arch/parisc/kernel/process.c 25 Sep 2004 00:14:33 -0000
@@ -363,8 +363,11 @@ asmlinkage int sys_execve(struct pt_regs
 		goto out;
 	error = do_execve(filename, (char **) regs->gr[25],
 		(char **) regs->gr[24], regs);
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 out:
 
--- linux-2.6/arch/parisc/kernel/sys_parisc32.c 13 Aug 2004 17:49:08 -0000 1.31
+++ linux-2.6/arch/parisc/kernel/sys_parisc32.c 25 Sep 2004 00:14:39 -0000
@@ -80,8 +80,11 @@ asmlinkage int sys32_execve(struct pt_re
 		goto out;
 	error = compat_do_execve(filename, compat_ptr(regs->gr[25]),
 				 compat_ptr(regs->gr[24]), regs);
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 out:
 
--- linux-2.6/arch/ppc/kernel/process.c 8 Sep 2004 14:48:45 -0000 1.54
+++ linux-2.6/arch/ppc/kernel/process.c 25 Sep 2004 00:12:42 -0000
@@ -598,8 +598,11 @@ int sys_execve(unsigned long a0, unsigne
 	preempt_enable();
 	error = do_execve(filename, (char __user *__user *) a1,
 			  (char __user *__user *) a2, regs);
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 out:
 	return error;
--- linux-2.6/arch/ppc64/kernel/process.c 23 Sep 2004 01:20:57 -0000 1.51
+++ linux-2.6/arch/ppc64/kernel/process.c 25 Sep 2004 00:10:46 -0000
@@ -514,8 +514,11 @@ int sys_execve(unsigned long a0, unsigne
 	error = do_execve(filename, (char __user * __user *) a1,
 				    (char __user * __user *) a2, regs);
   
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 
 out:
--- linux-2.6/arch/ppc64/kernel/sys_ppc32.c 23 Sep 2004 01:20:57 -0000 1.79
+++ linux-2.6/arch/ppc64/kernel/sys_ppc32.c 25 Sep 2004 00:10:34 -0000
@@ -621,8 +621,11 @@ long sys32_execve(unsigned long a0, unsi
 
 	error = compat_do_execve(filename, compat_ptr(a1), compat_ptr(a2), regs);
 
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 
 out:
--- linux-2.6/arch/s390/kernel/compat_linux.c 24 Aug 2004 18:42:10 -0000 1.27
+++ linux-2.6/arch/s390/kernel/compat_linux.c 25 Sep 2004 00:14:31 -0000
@@ -751,7 +751,9 @@ sys32_execve(struct pt_regs regs)
 				 compat_ptr(regs.gprs[4]), &regs);
 	if (error == 0)
 	{
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
 		current->thread.fp_regs.fpc=0;
 		__asm__ __volatile__
 		        ("sr  0,0\n\t"
--- linux-2.6/arch/s390/kernel/process.c 31 Aug 2004 17:42:58 -0000 1.32
+++ linux-2.6/arch/s390/kernel/process.c 25 Sep 2004 00:13:16 -0000
@@ -340,7 +340,9 @@ asmlinkage long sys_execve(struct pt_reg
         error = do_execve(filename, (char __user * __user *) regs.gprs[3],
 			  (char __user * __user *) regs.gprs[4], &regs);
 	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
 		current->thread.fp_regs.fpc = 0;
 		if (MACHINE_HAS_IEEE)
 			asm volatile("sfpc %0,%0" : : "d" (0));
--- linux-2.6/arch/sh/kernel/process.c 24 Aug 2004 18:27:07 -0000 1.24
+++ linux-2.6/arch/sh/kernel/process.c 25 Sep 2004 00:14:24 -0000
@@ -481,8 +481,11 @@ asmlinkage int sys_execve(char *ufilenam
 			  (char __user * __user *)uargv,
 			  (char __user * __user *)uenvp,
 			  &regs);
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 out:
 	return error;
--- linux-2.6/arch/sh64/kernel/process.c 27 Aug 2004 17:42:02 -0000 1.4
+++ linux-2.6/arch/sh64/kernel/process.c 25 Sep 2004 00:13:36 -0000
@@ -862,8 +862,11 @@ asmlinkage int sys_execve(char *ufilenam
 			  (char __user * __user *)uargv,
 			  (char __user * __user *)uenvp,
 			  pregs);
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 out:
 	unlock_kernel();
--- linux-2.6/arch/sparc/kernel/process.c 24 Aug 2004 18:27:07 -0000 1.43
+++ linux-2.6/arch/sparc/kernel/process.c 25 Sep 2004 00:14:21 -0000
@@ -670,8 +670,11 @@ asmlinkage int sparc_execve(struct pt_re
 			  (char __user * __user *)regs->u_regs[base + UREG_I2],
 			  regs);
 	putname(filename);
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 out:
 	return error;
 }
--- linux-2.6/arch/sparc64/kernel/process.c 24 Aug 2004 18:27:07 -0000 1.50
+++ linux-2.6/arch/sparc64/kernel/process.c 25 Sep 2004 00:14:15 -0000
@@ -829,7 +829,9 @@ asmlinkage int sparc_execve(struct pt_re
 		current_thread_info()->xfsr[0] = 0;
 		current_thread_info()->fpsaved[0] = 0;
 		regs->tstate &= ~TSTATE_PEF;
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
 	}
 out:
 	return error;
--- linux-2.6/arch/sparc64/kernel/sys_sparc32.c 22 Sep 2004 04:16:22 -0000 1.97
+++ linux-2.6/arch/sparc64/kernel/sys_sparc32.c 25 Sep 2004 00:10:28 -0000
@@ -1274,7 +1274,9 @@ asmlinkage long sparc32_execve(struct pt
 		current_thread_info()->xfsr[0] = 0;
 		current_thread_info()->fpsaved[0] = 0;
 		regs->tstate &= ~TSTATE_PEF;
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
 	}
 out:
 	return error;
--- linux-2.6/arch/um/kernel/exec_kern.c 24 Aug 2004 18:13:23 -0000 1.6
+++ linux-2.6/arch/um/kernel/exec_kern.c 25 Sep 2004 00:14:04 -0000
@@ -43,7 +43,9 @@ static int execve1(char *file, char **ar
 #endif
         error = do_execve(file, argv, env, &current->thread.regs);
         if (error == 0){
+		task_lock(current);
                 current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
                 set_cmdline(current_cmd());
         }
         return(error);
--- linux-2.6/arch/x86_64/ia32/sys_ia32.c 21 Sep 2004 14:43:51 -0000 1.70
+++ linux-2.6/arch/x86_64/ia32/sys_ia32.c 25 Sep 2004 00:10:13 -0000
@@ -1135,8 +1135,11 @@ asmlinkage long sys32_execve(char __user
 	if (IS_ERR(filename))
 		return error;
 	error = compat_do_execve(filename, argv, envp, regs);
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 	return error;
 }
--- linux-2.6/arch/x86_64/kernel/process.c 17 Sep 2004 19:09:12 -0000 1.41
+++ linux-2.6/arch/x86_64/kernel/process.c 25 Sep 2004 00:11:12 -0000
@@ -542,8 +542,11 @@ long sys_execve(char __user *name, char 
 	if (IS_ERR(filename)) 
 		return error;
 	error = do_execve(filename, argv, envp, &regs); 
-	if (error == 0)
+	if (error == 0) {
+		task_lock(current);
 		current->ptrace &= ~PT_DTRACE;
+		task_unlock(current);
+	}
 	putname(filename);
 	return error;
 }
--- linux-2.6/include/linux/ptrace.h 7 Feb 2004 03:45:05 -0000 1.11
+++ linux-2.6/include/linux/ptrace.h 25 Sep 2004 00:01:32 -0000
@@ -63,6 +63,7 @@
 #define PT_TRACE_EXEC	0x00000080
 #define PT_TRACE_VFORK_DONE	0x00000100
 #define PT_TRACE_EXIT	0x00000200
+#define PT_ATTACHED	0x00000400	/* parent != real_parent */
 
 #define PT_TRACE_MASK	0x000003f4
 
--- linux-2.6/kernel/ptrace.c 23 Sep 2004 23:35:16 -0000 1.36
+++ linux-2.6/kernel/ptrace.c 25 Sep 2004 00:01:36 -0000
@@ -131,7 +131,7 @@ int ptrace_attach(struct task_struct *ta
 		goto bad;
 
 	/* Go */
-	task->ptrace |= PT_PTRACED;
+	task->ptrace |= PT_PTRACED | PT_ATTACHED;
 	if (capable(CAP_SYS_PTRACE))
 		task->ptrace |= PT_PTRACE_CAP;
 	task_unlock(task);
