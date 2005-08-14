Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVHNJi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVHNJi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 05:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVHNJi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 05:38:59 -0400
Received: from verein.lst.de ([213.95.11.210]:42161 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932465AbVHNJi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 05:38:58 -0400
Date: Sun, 14 Aug 2005 11:38:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/2] use ptrace_get_task_struct in all ptrace implementations
Message-ID: <20050814093850.GB28557@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of my previous sys_ptrace consolidation I introduce a
ptrace_get_task_struct helper, that gets a reference to the taskstruct
for a given pid, after doing all the ptrace attach checks.
This pathces makes all but a few ptrace and compat_ptrace
implementations use it.  The implementations not covered are:

  - m68k: has some large ptrace changes pending, should be converted to
    the common sys_ptrace later
  - ia64 (native ptrace only): does some wierd stuff about finding a
    different thread in the same threadgroup


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/alpha/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/ptrace.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/alpha/kernel/ptrace.c	2005-08-13 18:14:22.000000000 +0200
@@ -265,28 +265,7 @@
 	lock_kernel();
 	DBG(DBG_MEM, ("request=%ld pid=%ld addr=0x%lx data=0x%lx\n",
 		      request, pid, addr, data));
-	ret = -EPERM;
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out_notsk;
-		ret = security_ptrace(current->parent, current);
-		if (ret)
-			goto out_notsk;
-		/* set the ptrace bit in the process ptrace flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
-		goto out_notsk;
-	}
-	if (pid == 1)		/* you may not mess with init */
-		goto out_notsk;
-
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child)
 		goto out_notsk;
 
Index: linux-2.6/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.orig/arch/ia64/ia32/sys_ia32.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/ia64/ia32/sys_ia32.c	2005-08-13 18:14:22.000000000 +0200
@@ -1759,22 +1759,9 @@
 	long i, ret;
 
 	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		ret = sys_ptrace(request, pid, addr, data);
-		goto out;
-	}
-
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child)
 		goto out;
-	ret = -EPERM;
-	if (pid == 1)		/* no messing around with init! */
-		goto out_tsk;
 
 	if (request == PTRACE_ATTACH) {
 		ret = sys_ptrace(request, pid, addr, data);
Index: linux-2.6/arch/m32r/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/ptrace.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/m32r/kernel/ptrace.c	2005-08-13 18:14:22.000000000 +0200
@@ -762,29 +762,10 @@
 	int ret;
 
 	lock_kernel();
-	ret = -EPERM;
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
-		goto out;
-	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child)
 		goto out;
 
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out;
-
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
 		if (ret == 0)
Index: linux-2.6/arch/mips/kernel/ptrace32.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/ptrace32.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/mips/kernel/ptrace32.c	2005-08-13 18:14:22.000000000 +0200
@@ -50,31 +50,10 @@
 	       (unsigned long) data);
 #endif
 	lock_kernel();
-	ret = -EPERM;
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-		if ((ret = security_ptrace(current->parent, current)))
-			goto out;
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
-		goto out;
-	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child)
 		goto out;
 
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
 		goto out_tsk;
Index: linux-2.6/arch/parisc/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/ptrace.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/parisc/kernel/ptrace.c	2005-08-13 18:14:22.000000000 +0200
@@ -87,33 +87,9 @@
 #endif
 
 	lock_kernel();
-	ret = -EPERM;
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-
-		ret = security_ptrace(current->parent, current);
-		if (ret) 
-			goto out;
-
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		ret = 0;
-		goto out;
-	}
-
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child)
 		goto out;
-	ret = -EPERM;
-	if (pid == 1)		/* no messing around with init! */
-		goto out_tsk;
 
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
Index: linux-2.6/arch/ppc64/kernel/ptrace32.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/ptrace32.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/ppc64/kernel/ptrace32.c	2005-08-13 18:14:22.000000000 +0200
@@ -45,31 +45,10 @@
 	int ret = -EPERM;
 
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
-		goto out;
-	}
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child)
 		goto out;
 
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
 	if (request == PTRACE_ATTACH) {
 		ret = ptrace_attach(child);
 		goto out_tsk;
Index: linux-2.6/arch/s390/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/ptrace.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/s390/kernel/ptrace.c	2005-08-13 18:14:22.000000000 +0200
@@ -712,36 +712,11 @@
 	int ret;
 
 	lock_kernel();
-
-	if (request == PTRACE_TRACEME) {
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
+	ret = ptrace_get_task_struct(request, pid, &child);
+	if (child) {
+		ret = do_ptrace(child, request, addr, data);
+		put_task_struct(child);
 	}
-
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
-		goto out;
-
-	ret = do_ptrace(child, request, addr, data);
-
-	put_task_struct(child);
 out:
 	unlock_kernel();
 	return ret;
Index: linux-2.6/arch/sparc/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/ptrace.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/sparc/kernel/ptrace.c	2005-08-13 18:14:22.000000000 +0200
@@ -286,40 +286,13 @@
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
-
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		pt_succ_return(regs, 0);
-		goto out;
-	}
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
 
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child) {
-		pt_error_return(regs, ESRCH);
+		if (ret)
+			pt_error_return(regs, -ret);
+		else
+			pt_succ_return(regs, 0);
 		goto out;
 	}
 
Index: linux-2.6/arch/sparc64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/ptrace.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/sparc64/kernel/ptrace.c	2005-08-13 18:14:22.000000000 +0200
@@ -188,40 +188,12 @@
 			       s, request, pid, addr, data, addr2);
 	}
 #endif
-	if (request == PTRACE_TRACEME) {
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
-		pt_succ_return(regs, 0);
-		goto out;
-	}
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
-
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child) {
-		pt_error_return(regs, ESRCH);
+		if (ret)
+			pt_error_return(regs, -ret);
+		else
+			pt_succ_return(regs, 0);
 		goto out;
 	}
 
Index: linux-2.6/arch/x86_64/ia32/ptrace32.c
===================================================================
--- linux-2.6.orig/arch/x86_64/ia32/ptrace32.c	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/arch/x86_64/ia32/ptrace32.c	2005-08-13 18:14:22.000000000 +0200
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
@@ -254,10 +224,14 @@
 		break;
 	} 
 
-	child = find_target(request, pid, &ret);
+	ret = ptrace_get_task_struct(request, pid, &child);
 	if (!child)
 		return ret;
 
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
+		goto out;
+
 	childregs = (struct pt_regs *)(child->thread.rsp0 - sizeof(struct pt_regs)); 
 
 	switch (request) {
@@ -373,6 +347,7 @@
 		break;
 	}
 
+ out:
 	put_task_struct(child);
 	return ret;
 }
Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-08-13 18:14:17.000000000 +0200
+++ linux-2.6/kernel/ptrace.c	2005-08-13 18:14:22.000000000 +0200
@@ -389,9 +389,7 @@
 	return ret;
 }
 
-#ifndef __ARCH_SYS_PTRACE
-static int ptrace_get_task_struct(long request, long pid,
-		struct task_struct **childp)
+int ptrace_get_task_struct(long request, long pid, struct task_struct **childp)
 {
 	struct task_struct *child;
 	int ret;
@@ -437,6 +435,7 @@
 	return 0;
 }
 
+#ifndef __ARCH_SYS_PTRACE
 asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
Index: linux-2.6/include/linux/ptrace.h
===================================================================
--- linux-2.6.orig/include/linux/ptrace.h	2005-08-13 18:13:26.000000000 +0200
+++ linux-2.6/include/linux/ptrace.h	2005-08-13 18:14:22.000000000 +0200
@@ -78,6 +78,7 @@
 
 
 extern long arch_ptrace(struct task_struct *child, long request, long addr, long data);
+extern int ptrace_get_task_struct(long request, long pid, struct task_struct **childp);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len);
 extern int ptrace_attach(struct task_struct *tsk);
