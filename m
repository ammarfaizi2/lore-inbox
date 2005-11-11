Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVKKIWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVKKIWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVKKIWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:22:24 -0500
Received: from verein.lst.de ([213.95.11.210]:8167 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751069AbVKKIWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:22:24 -0500
Date: Fri, 11 Nov 2005 09:21:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com, davem@davemloft.net
Subject: Re: [PATCH] use ptrace_get_task_struct in various places
Message-ID: <20051111082157.GA25852@lst.de>
References: <20051108053049.GA9422@lst.de> <20051107221149.08aa0820.akpm@osdl.org> <20051110232711.GA18831@lst.de> <20051110160001.6cee5bed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110160001.6cee5bed.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 04:00:01PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> >
> > > In arch/ia64/ia32/sys_ia32.c this patch will cause PTRACE_TRACEME requests
> > > to be handled by ptrace_request()
> > 
> > you mean ptrace_get_task_struct?
> 
> No, I was referring to this code:
> 
> asmlinkage long
> sys32_ptrace (int request, pid_t pid, unsigned int addr, unsigned int data)
> {
> 	struct task_struct *child;
> 	unsigned int value, tmp;
> 	long i, ret;
> 
> 	lock_kernel();
> 	if (request == PTRACE_TRACEME) {
> 		ret = sys_ptrace(request, pid, addr, data);
> 		goto out;
> 	}
> 
> Your patch removes the PTRACE_TRACEME special-case.  Consequently
> sys32_ptrace() will fall all the way down to the default: case of the
> switch statement and will use ptrace_request() instead.  And
> ptrace_request() doesn't handle PTRACE_TRACEME, so I think it's busted.

But ptrace_get_task_struct deals with PTRACE_TRACEME, as the comment
patch explains ;-)

But after trying to write up the complicated calling convetions and this
thread I've decided that this is not a good interface.  So below there's
a new patch, that adds a ptrace_traceme() helper instead that needs to
be explicitly called, and simplifies the ptrace_get_task_struct
interface, we don't need the request argument now, and we return the
task_struct directly, using ERR_PTR() for error returns.  It's a bit
more code in the callers, but we have two sane routines that do one
thing well now.


Index: linux-2.6/arch/alpha/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/ptrace.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/alpha/kernel/ptrace.c	2005-11-11 00:08:15.000000000 +0100
@@ -265,30 +265,16 @@
 	lock_kernel();
 	DBG(DBG_MEM, ("request=%ld pid=%ld addr=0x%lx data=0x%lx\n",
 		      request, pid, addr, data));
-	ret = -EPERM;
 	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out_notsk;
-		ret = security_ptrace(current->parent, current);
-		if (ret)
-			goto out_notsk;
-		/* set the ptrace bit in the process ptrace flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
+		ret = ptrace_traceme();
 		goto out_notsk;
 	}
-	if (pid == 1)		/* you may not mess with init */
-		goto out_notsk;
 
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
 		goto out_notsk;
+	}
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
Index: linux-2.6/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.orig/arch/ia64/ia32/sys_ia32.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/ia64/ia32/sys_ia32.c	2005-11-11 00:07:39.000000000 +0100
@@ -1761,21 +1761,15 @@
 
 	lock_kernel();
 	if (request == PTRACE_TRACEME) {
-		ret = sys_ptrace(request, pid, addr, data);
+		ret = ptrace_traceme();
 		goto out;
 	}
 
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
 		goto out;
-	ret = -EPERM;
-	if (pid == 1)		/* no messing around with init! */
-		goto out_tsk;
+	}
 
 	if (request == PTRACE_ATTACH) {
 		ret = sys_ptrace(request, pid, addr, data);
Index: linux-2.6/arch/m32r/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/ptrace.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/m32r/kernel/ptrace.c	2005-11-11 00:07:44.000000000 +0100
@@ -762,28 +762,16 @@
 	int ret;
 
 	lock_kernel();
-	ret = -EPERM;
 	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
+		ret = ptrace_traceme();
 		goto out;
 	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
-		goto out;
 
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
 		goto out;
+	}
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
Index: linux-2.6/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/ptrace32.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/mips/kernel/ptrace32.c	2005-11-11 00:07:48.000000000 +0100
@@ -57,30 +57,16 @@
 	       (unsigned long) data);
 #endif
 	lock_kernel();
-	ret = -EPERM;
 	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
+		ret = ptrace_traceme();
 		goto out;
 	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
-		goto out;
 
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
+		goto out;
+	}
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
Index: linux-2.6/arch/s390/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/ptrace.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/s390/kernel/ptrace.c	2005-11-11 00:07:53.000000000 +0100
@@ -712,35 +712,18 @@
 	int ret;
 
 	lock_kernel();
-
 	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		ret = -EPERM;
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		ret = security_ptrace(current->parent, current);
-		if (ret)
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		goto out;
+		 ret = ptrace_traceme();
+		 goto out;
 	}
 
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out;
-
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
 		goto out;
+	}
 
 	ret = do_ptrace(child, request, addr, data);
-
 	put_task_struct(child);
 out:
 	unlock_kernel();
Index: linux-2.6/arch/sparc/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/ptrace.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/sparc/kernel/ptrace.c	2005-11-11 00:07:58.000000000 +0100
@@ -286,40 +286,17 @@
 			       s, (int) request, (int) pid, addr, data, addr2);
 	}
 #endif
-	if (request == PTRACE_TRACEME) {
-		int my_ret;
-
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED) {
-			pt_error_return(regs, EPERM);
-			goto out;
-		}
-		my_ret = security_ptrace(current->parent, current);
-		if (my_ret) {
-			pt_error_return(regs, -my_ret);
-			goto out;
-		}
 
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
+	if (request == PTRACE_TRACEME) {
+		ret = ptrace_traceme();
 		pt_succ_return(regs, 0);
 		goto out;
 	}
-#ifndef ALLOW_INIT_TRACING
-	if (pid == 1) {
-		/* Can't dork with init. */
-		pt_error_return(regs, EPERM);
-		goto out;
-	}
-#endif
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
 
-	if (!child) {
-		pt_error_return(regs, ESRCH);
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
+		pt_error_return(regs, -ret);
 		goto out;
 	}
 
Index: linux-2.6/arch/sparc64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/ptrace.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/sparc64/kernel/ptrace.c	2005-11-11 00:08:03.000000000 +0100
@@ -198,39 +198,15 @@
 	}
 #endif
 	if (request == PTRACE_TRACEME) {
-		int ret;
-
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED) {
-			pt_error_return(regs, EPERM);
-			goto out;
-		}
-		ret = security_ptrace(current->parent, current);
-		if (ret) {
-			pt_error_return(regs, -ret);
-			goto out;
-		}
-
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
+		ret = ptrace_traceme();
 		pt_succ_return(regs, 0);
 		goto out;
 	}
-#ifndef ALLOW_INIT_TRACING
-	if (pid == 1) {
-		/* Can't dork with init. */
-		pt_error_return(regs, EPERM);
-		goto out;
-	}
-#endif
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
 
-	if (!child) {
-		pt_error_return(regs, ESRCH);
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
+		pt_error_return(regs, -ret);
 		goto out;
 	}
 
Index: linux-2.6/arch/x86_64/ia32/ptrace32.c
===================================================================
--- linux-2.6.orig/arch/x86_64/ia32/ptrace32.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/x86_64/ia32/ptrace32.c	2005-11-11 00:08:08.000000000 +0100
@@ -196,36 +196,6 @@
 
 #undef R32
 
-static struct task_struct *find_target(int request, int pid, int *err)
-{ 
-	struct task_struct *child;
-
-	*err = -EPERM; 
-	if (pid == 1)
-		return NULL; 
-
-	*err = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (child) { 
-		*err = -EPERM;
-		if (child->pid == 1) 
-			goto out;
-		*err = ptrace_check_attach(child, request == PTRACE_KILL); 
-		if (*err < 0) 
-			goto out;
-		return child; 
-	} 
- out:
-	if (child)
-	put_task_struct(child);
-	return NULL; 
-	
-} 
-
 asmlinkage long sys32_ptrace(long request, u32 pid, u32 addr, u32 data)
 {
 	struct task_struct *child;
@@ -254,9 +224,16 @@
 		break;
 	} 
 
-	child = find_target(request, pid, &ret);
-	if (!child)
-		return ret;
+	if (request == PTRACE_TRACEME)
+		return ptrace_traceme();
+
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		return PTR_ERR(child);
+
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
+		goto out;
 
 	childregs = (struct pt_regs *)(child->thread.rsp0 - sizeof(struct pt_regs)); 
 
@@ -373,6 +350,7 @@
 		break;
 	}
 
+ out:
 	put_task_struct(child);
 	return ret;
 }
Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/kernel/ptrace.c	2005-11-11 00:10:29.000000000 +0100
@@ -407,54 +407,62 @@
 	return ret;
 }
 
-#ifndef __ARCH_SYS_PTRACE
-static int ptrace_get_task_struct(long request, long pid,
-		struct task_struct **childp)
+/**
+ * ptrace_traceme  --  helper for PTRACE_TRACEME
+ *
+ * Performs checks and sets PT_PTRACED.
+ * Should be used by all ptrace implementations for PTRACE_TRACEME.
+ */
+int ptrace_traceme(void)
 {
-	struct task_struct *child;
 	int ret;
 
 	/*
-	 * Callers use child == NULL as an indication to exit early even
-	 * when the return value is 0, so make sure it is non-NULL here.
+	 * Are we already being traced?
+	 */
+	if (current->ptrace & PT_PTRACED)
+		return -EPERM;
+	ret = security_ptrace(current->parent, current);
+	if (ret)
+		return -EPERM;
+	/*
+	 * Set the ptrace bit in the process ptrace flags.
 	 */
-	*childp = NULL;
+	current->ptrace |= PT_PTRACED;
+	return 0;
+}
 
-	if (request == PTRACE_TRACEME) {
-		/*
-		 * Are we already being traced?
-		 */
-		if (current->ptrace & PT_PTRACED)
-			return -EPERM;
-		ret = security_ptrace(current->parent, current);
-		if (ret)
-			return -EPERM;
-		/*
-		 * Set the ptrace bit in the process ptrace flags.
-		 */
-		current->ptrace |= PT_PTRACED;
-		return 0;
-	}
+/**
+ * ptrace_get_task_struct  --  grab a task struct reference for ptrace
+ * @pid:       process id to grab a task_struct reference of
+ *
+ * This function is a helper for ptrace implementations.  It checks
+ * permissions and then grabs a task struct for use of the actual
+ * ptrace implementation.
+ *
+ * Returns the task_struct for @pid or an ERR_PTR() on failure.
+ */
+struct task_struct *ptrace_get_task_struct(pid_t pid)
+{
+	struct task_struct *child;
 
 	/*
-	 * You may not mess with init
+	 * Tracing init is not allowed.
 	 */
 	if (pid == 1)
-		return -EPERM;
+		return ERR_PTR(-EPERM);
 
-	ret = -ESRCH;
 	read_lock(&tasklist_lock);
 	child = find_task_by_pid(pid);
 	if (child)
 		get_task_struct(child);
 	read_unlock(&tasklist_lock);
 	if (!child)
-		return -ESRCH;
-
-	*childp = child;
+		return ERR_PTR(-ESRCH);
 	return 0;
 }
 
+#ifndef __ARCH_SYS_PTRACE
 asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -464,9 +472,16 @@
 	 * This lock_kernel fixes a subtle race with suid exec
 	 */
 	lock_kernel();
-	ret = ptrace_get_task_struct(request, pid, &child);
-	if (!child)
+	if (request == PTRACE_TRACEME) {
+		ret = ptrace_traceme();
 		goto out;
+	}
+
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
+		goto out;
+	}
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
Index: linux-2.6/include/linux/ptrace.h
===================================================================
--- linux-2.6.orig/include/linux/ptrace.h	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/include/linux/ptrace.h	2005-11-11 00:07:24.000000000 +0100
@@ -80,6 +80,8 @@
 
 
 extern long arch_ptrace(struct task_struct *child, long request, long addr, long data);
+extern struct task_struct *ptrace_get_task_struct(pid_t pid);
+extern int ptrace_traceme(void);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len);
 extern int ptrace_attach(struct task_struct *tsk);
Index: linux-2.6/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/ptrace32.c	2005-11-10 16:02:04.000000000 +0100
+++ linux-2.6/arch/powerpc/kernel/ptrace32.c	2005-11-11 00:10:44.000000000 +0100
@@ -44,33 +44,19 @@
 		       unsigned long data)
 {
 	struct task_struct *child;
-	int ret = -EPERM;
+	int ret;
 
 	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		ret = security_ptrace(current->parent, current);
-		if (ret)
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
+	if (request == PTRACE_TRACEME) {=
+		ret = ptrace_traceme();
 		goto out;
 	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
-		goto out;
 
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
+	child = ptrace_get_task_struct(pid);
+	if (IS_ERR(child)) {
+		ret = PTR_ERR(child);
+		goto out;
+	}
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
Index: linux-2.6/arch/ia64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/ptrace.c	2005-10-31 17:50:44.000000000 +0100
+++ linux-2.6/arch/ia64/kernel/ptrace.c	2005-11-10 23:54:14.000000000 +0100
@@ -1422,14 +1422,7 @@
 	lock_kernel();
 	ret = -EPERM;
 	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		ret = security_ptrace(current->parent, current);
-		if (ret)
-			goto out;
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
+		ret = ptrace_traceme();
 		goto out;
 	}
 
