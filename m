Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVKAFMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVKAFMe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVKAFMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:12:34 -0500
Received: from verein.lst.de ([213.95.11.210]:41389 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964980AbVKAFMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:12:33 -0500
Date: Tue, 1 Nov 2005 06:12:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH consolidate sys_ptrace
Message-ID: <20051101051221.GA26017@lst.de>
References: <20051101050900.GA25793@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101050900.GA25793@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 06:09:00AM +0100, Christoph Hellwig wrote:
> [Let's try again now that sys_ptrace returns long everywhere mainline..]
> 
> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.
> 
> Some architectures have a too different ptrace so we have to exclude
> them.  They continue to keep their implementations.  For sh64 I had to
> add a sh64_ptrace wrapper because it does some initialization on the
> first call.  For um I removed an ifdefed SUBARCH_PTRACE_SPECIAL block,
> but SUBARCH_PTRACE_SPECIAL isn't defined anywhere in the tree.

Umm, it might be a good idea to actually send the current patch instead
of the old one.  I really should write this text from scratch instead
of copying it :)


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/arm/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/ptrace.c	2005-10-31 13:15:47.000000000 +0100
+++ linux-2.6/arch/arm/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -648,7 +648,7 @@
 
 #endif
 
-static int do_ptrace(int request, struct task_struct *child, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	unsigned long tmp;
 	int ret;
@@ -782,53 +782,6 @@
 	return ret;
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
-{
-	struct task_struct *child;
-	int ret;
-
-	lock_kernel();
-	ret = -EPERM;
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret == 0)
-		ret = do_ptrace(request, child, addr, data);
-
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
-	return ret;
-}
-
 asmlinkage void syscall_trace(int why, struct pt_regs *regs)
 {
 	unsigned long ip;
Index: linux-2.6/arch/arm26/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/arm26/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/arm26/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -546,7 +546,7 @@
 			      sizeof(struct user_fp)) ? -EFAULT : 0;
 }
 
-static int do_ptrace(int request, struct task_struct *child, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	unsigned long tmp;
 	int ret;
@@ -665,53 +665,6 @@
 	return ret;
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
-{
-	struct task_struct *child;
-	int ret;
-
-	lock_kernel();
-	ret = -EPERM;
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret == 0)
-		ret = do_ptrace(request, child, addr, data);
-
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
-	return ret;
-}
-
 asmlinkage void syscall_trace(int why, struct pt_regs *regs)
 {
 	unsigned long ip;
Index: linux-2.6/arch/frv/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/frv/kernel/ptrace.c	2005-10-31 17:31:24.000000000 +0100
@@ -106,48 +106,11 @@
 	child->thread.frame0->__status |= REG__STATUS_STEP;
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	unsigned long tmp;
 	int ret;
 
-	lock_kernel();
-	ret = -EPERM;
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 		/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */
@@ -351,10 +314,6 @@
 		ret = -EIO;
 		break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
 	return ret;
 }
 
Index: linux-2.6/arch/h8300/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/h8300/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -57,43 +57,10 @@
 	h8300_disable_trace(child);
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int ret;
 
-	lock_kernel();
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 		case PTRACE_PEEKTEXT: /* read word at location addr. */ 
 		case PTRACE_PEEKDATA: {
@@ -251,10 +218,6 @@
 			ret = -EIO;
 			break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
 	return ret;
 }
 
Index: linux-2.6/arch/i386/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/i386/kernel/ptrace.c	2005-10-31 17:40:06.000000000 +0100
@@ -354,49 +354,12 @@
 	return 0;
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	struct user * dummy = NULL;
 	int i, ret;
 	unsigned long __user *datap = (unsigned long __user *)data;
 
-	lock_kernel();
-	ret = -EPERM;
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
@@ -663,10 +626,7 @@
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+ out_tsk:
 	return ret;
 }
 
Index: linux-2.6/arch/m68knommu/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m68knommu/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/m68knommu/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -101,43 +101,10 @@
 	put_reg(child, PT_SR, tmp);
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(truct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int ret;
 
-	lock_kernel();
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 		/* when I and D space are separate, these will need to be fixed. */
 		case PTRACE_PEEKTEXT: /* read word at location addr. */ 
@@ -357,10 +324,6 @@
 			ret = -EIO;
 			break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
 	return ret;
 }
 
Index: linux-2.6/arch/mips/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/mips/kernel/ptrace.c	2005-10-31 17:40:36.000000000 +0100
@@ -174,51 +174,10 @@
 	return 0;
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int ret;
 
-#if 0
-	printk("ptrace(r=%d,pid=%d,addr=%08lx,data=%08lx)\n",
-	       (int) request, (int) pid, (unsigned long) addr,
-	       (unsigned long) data);
-#endif
-	lock_kernel();
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */
@@ -319,7 +278,7 @@
 			if (!cpu_has_dsp) {
 				tmp = 0;
 				ret = -EIO;
-				goto out_tsk;
+				goto out;
 			}
 			if (child->thread.dsp.used_dsp) {
 				dregs = __get_dsp_regs(child);
@@ -333,14 +292,14 @@
 			if (!cpu_has_dsp) {
 				tmp = 0;
 				ret = -EIO;
-				goto out_tsk;
+				goto out;
 			}
 			tmp = child->thread.dsp.dspcontrol;
 			break;
 		default:
 			tmp = 0;
 			ret = -EIO;
-			goto out_tsk;
+			goto out;
 		}
 		ret = put_user(tmp, (unsigned long __user *) data);
 		break;
@@ -495,11 +454,7 @@
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+ out:
 	return ret;
 }
 
Index: linux-2.6/arch/sh/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/ptrace.c	2005-10-31 13:15:49.000000000 +0100
+++ linux-2.6/arch/sh/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -80,48 +80,11 @@
 	/* nothing to do.. */
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	struct user * dummy = NULL;
 	int ret;
 
-	lock_kernel();
-	ret = -EPERM;
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
@@ -289,10 +252,7 @@
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+
 	return ret;
 }
 
Index: linux-2.6/arch/v850/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/v850/kernel/ptrace.c	2005-10-31 13:15:49.000000000 +0100
+++ linux-2.6/arch/v850/kernel/ptrace.c	2005-10-31 17:38:42.000000000 +0100
@@ -113,45 +113,10 @@
 	return 1;
 }
 
-long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int rval;
 
-	lock_kernel();
-
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED) {
-			rval = -EPERM;
-			goto out;
-		}
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		rval = 0;
-		goto out;
-	}
-	rval = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (!child)
-		goto out;
-
-	rval = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		rval = ptrace_attach(child);
-		goto out_tsk;
-	}
-	rval = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (rval < 0)
-		goto out_tsk;
-
 	switch (request) {
 		unsigned long val, copied;
 
@@ -248,11 +213,7 @@
 		rval = -EIO;
 		goto out;
 	}
-
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+ out:
 	return rval;
 }
 
Index: linux-2.6/arch/x86_64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/ptrace.c	2005-10-31 12:23:20.000000000 +0100
+++ linux-2.6/arch/x86_64/kernel/ptrace.c	2005-10-31 17:38:52.000000000 +0100
@@ -313,48 +313,11 @@
 
 }
 
-asmlinkage long sys_ptrace(long request, long pid, unsigned long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, unsigned long addr, long data)
 {
-	struct task_struct *child;
 	long i, ret;
 	unsigned ui;
 
-	/* This lock_kernel fixes a subtle race with suid exec */
-	lock_kernel();
-	ret = -EPERM;
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-	ret = ptrace_check_attach(child, request == PTRACE_KILL); 
-	if (ret < 0) 
-		goto out_tsk;
-
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
@@ -608,10 +571,6 @@
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
 	return ret;
 }
 
Index: linux-2.6/arch/xtensa/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/ptrace.c	2005-10-31 13:15:49.000000000 +0100
+++ linux-2.6/arch/xtensa/kernel/ptrace.c	2005-10-31 17:39:06.000000000 +0100
@@ -45,58 +45,10 @@
 	/* Nothing to do.. */
 }
 
-long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int ret = -EPERM;
 
-	lock_kernel();
-
-#if 0
-	if ((int)request != 1)
-	printk("ptrace(r=%d,pid=%d,addr=%08lx,data=%08lx)\n",
-	       (int) request, (int) pid, (unsigned long) addr,
-	       (unsigned long) data);
-#endif
-
-	if (request == PTRACE_TRACEME) {
-
-		/* Are we already being traced? */
-
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-
-		if ((ret = security_ptrace(current->parent, current)))
-			goto out;
-
-		/* Set the ptrace bit in the process flags. */
-
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	if ((ret = ptrace_check_attach(child, request == PTRACE_KILL)) < 0)
-		goto out_tsk;
-
 	switch (request) {
 	case PTRACE_PEEKTEXT: /* read word at location addr. */
 	case PTRACE_PEEKDATA:
@@ -375,10 +327,7 @@
 		ret = ptrace_request(child, request, addr, data);
 		goto out;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+ out:
 	return ret;
 }
 
Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-10-31 13:15:52.000000000 +0100
+++ linux-2.6/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -406,3 +406,85 @@
 
 	return ret;
 }
+
+#ifndef __ARCH_SYS_PTRACE
+static int ptrace_get_task_struct(long request, long pid,
+		struct task_struct **childp)
+{
+	struct task_struct *child;
+	int ret;
+
+	/*
+	 * Callers use child == NULL as an indication to exit early even
+	 * when the return value is 0, so make sure it is non-NULL here.
+	 */
+	*childp = NULL;
+
+	if (request == PTRACE_TRACEME) {
+		/*
+		 * Are we already being traced?
+		 */
+		if (current->ptrace & PT_PTRACED)
+			return -EPERM;
+		ret = security_ptrace(current->parent, current);
+		if (ret)
+			return -EPERM;
+		/*
+		 * Set the ptrace bit in the process ptrace flags.
+		 */
+		current->ptrace |= PT_PTRACED;
+		return 0;
+	}
+
+	/*
+	 * You may not mess with init
+	 */
+	if (pid == 1)
+		return -EPERM;
+
+	ret = -ESRCH;
+	read_lock(&tasklist_lock);
+	child = find_task_by_pid(pid);
+	if (child)
+		get_task_struct(child);
+	read_unlock(&tasklist_lock);
+	if (!child)
+		return -ESRCH;
+
+	*childp = child;
+	return 0;
+}
+
+asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+{
+	struct task_struct *child;
+	long ret;
+
+	/*
+	 * This lock_kernel fixes a subtle race with suid exec
+	 */
+	lock_kernel();
+	ret = ptrace_get_task_struct(request, pid, &child);
+	if (!child)
+		goto out;
+
+	if (request == PTRACE_ATTACH) {
+		ret = ptrace_attach(child);
+		goto out;
+	}
+
+	ret = ptrace_check_attach(child, request == PTRACE_KILL);
+	if (ret < 0)
+		goto out_put_task_struct;
+
+	ret = arch_ptrace(child, request, addr, data);
+	if (ret < 0)
+		goto out_put_task_struct;
+
+ out_put_task_struct:
+	put_task_struct(child);
+ out:
+	unlock_kernel();
+	return ret;
+}
+#endif /* __ARCH_SYS_PTRACE */
Index: linux-2.6/arch/cris/arch-v10/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v10/kernel/ptrace.c	2005-10-31 12:23:04.000000000 +0100
+++ linux-2.6/arch/cris/arch-v10/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -76,55 +76,11 @@
  * (in user space) where the result of the ptrace call is written (instead of
  * being returned).
  */
-asmlinkage int 
-sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int ret;
 	unsigned long __user *datap = (unsigned long __user *)data;
 
-	lock_kernel();
-	ret = -EPERM;
-	
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
-	
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	
-	if (child)
-		get_task_struct(child);
-	
-	read_unlock(&tasklist_lock);
-	
-	if (!child)
-		goto out;
-	
-	ret = -EPERM;
-	
-	if (pid == 1)		/* Leave the init process alone! */
-		goto out_tsk;
-	
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-	
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 		/* Read word at location address. */ 
 		case PTRACE_PEEKTEXT:
@@ -289,10 +245,7 @@
 			ret = ptrace_request(child, request, addr, data);
 			break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+
 	return ret;
 }
 
Index: linux-2.6/arch/cris/arch-v32/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/cris/arch-v32/kernel/ptrace.c	2005-10-31 12:23:04.000000000 +0100
+++ linux-2.6/arch/cris/arch-v32/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -99,55 +99,11 @@
 }
 
 
-asmlinkage int
-sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int ret;
 	unsigned long __user *datap = (unsigned long __user *)data;
 
-	lock_kernel();
-	ret = -EPERM;
-
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
-
-	ret = -ESRCH;
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-
-	if (child)
-		get_task_struct(child);
-
-	read_unlock(&tasklist_lock);
-
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-
-	if (pid == 1)		/* Leave the init process alone! */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 		/* Read word at location address. */
 		case PTRACE_PEEKTEXT:
@@ -347,10 +303,7 @@
 			ret = ptrace_request(child, request, addr, data);
 			break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+
 	return ret;
 }
 
Index: linux-2.6/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/ptrace.c	2005-10-31 12:23:19.000000000 +0100
+++ linux-2.6/arch/um/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -43,53 +43,10 @@
 extern int peek_user(struct task_struct * child, long addr, long data);
 extern int poke_user(struct task_struct * child, long addr, long data);
 
-long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int i, ret;
 
-	lock_kernel();
-	ret = -EPERM;
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED)
-			goto out;
-
-		ret = security_ptrace(current->parent, current);
-		if (ret)
- 			goto out;
-
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-#ifdef SUBACH_PTRACE_SPECIAL
-        SUBARCH_PTRACE_SPECIAL(child,request,addr,data);
-#endif
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 		/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
@@ -282,10 +239,7 @@
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
- out_tsk:
-	put_task_struct(child);
- out:
-	unlock_kernel();
+
 	return ret;
 }
 
Index: linux-2.6/include/asm-alpha/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/ptrace.h	2005-10-31 12:24:00.000000000 +0100
+++ linux-2.6/include/asm-alpha/ptrace.h	2005-10-31 17:30:43.000000000 +0100
@@ -67,6 +67,9 @@
 };
 
 #ifdef __KERNEL__
+
+#define __ARCH_SYS_PTRACE	1
+
 #define user_mode(regs) (((regs)->ps & 8) != 0)
 #define instruction_pointer(regs) ((regs)->pc)
 #define profile_pc(regs) instruction_pointer(regs)
Index: linux-2.6/include/asm-ia64/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/ptrace.h	2005-10-31 12:24:05.000000000 +0100
+++ linux-2.6/include/asm-ia64/ptrace.h	2005-10-31 17:30:43.000000000 +0100
@@ -229,6 +229,9 @@
 };
 
 #ifdef __KERNEL__
+
+#define __ARCH_SYS_PTRACE	1
+
 /*
  * We use the ia64_psr(regs)->ri to determine which of the three
  * instructions in bundle (16 bytes) took the sample. Generate
Index: linux-2.6/include/asm-m32r/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-m32r/ptrace.h	2005-10-31 12:24:05.000000000 +0100
+++ linux-2.6/include/asm-m32r/ptrace.h	2005-10-31 17:30:43.000000000 +0100
@@ -145,6 +145,9 @@
 #define PTRACE_O_TRACESYSGOOD	0x00000001
 
 #ifdef __KERNEL__
+
+#define __ARCH_SYS_PTRACE	1
+
 #if defined(CONFIG_ISA_M32R2) || defined(CONFIG_CHIP_VDEC2)
 #define user_mode(regs) ((M32R_PSW_BPM & (regs)->psw) != 0)
 #elif defined(CONFIG_ISA_M32R)
Index: linux-2.6/include/asm-sparc/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/ptrace.h	2005-10-31 12:24:12.000000000 +0100
+++ linux-2.6/include/asm-sparc/ptrace.h	2005-10-31 17:30:43.000000000 +0100
@@ -60,6 +60,9 @@
 #define STACKFRAME_SZ sizeof(struct sparc_stackf)
 
 #ifdef __KERNEL__
+
+#define __ARCH_SYS_PTRACE	1
+
 #define user_mode(regs) (!((regs)->psr & PSR_PS))
 #define instruction_pointer(regs) ((regs)->pc)
 unsigned long profile_pc(struct pt_regs *);
Index: linux-2.6/include/asm-sparc64/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/ptrace.h	2005-10-31 12:24:12.000000000 +0100
+++ linux-2.6/include/asm-sparc64/ptrace.h	2005-10-31 17:30:43.000000000 +0100
@@ -94,6 +94,9 @@
 #define STACKFRAME32_SZ	sizeof(struct sparc_stackf32)
 
 #ifdef __KERNEL__
+
+#define __ARCH_SYS_PTRACE	1
+
 #define force_successful_syscall_return()	    \
 do {	current_thread_info()->syscall_noerror = 1; \
 } while (0)
Index: linux-2.6/include/linux/ptrace.h
===================================================================
--- linux-2.6.orig/include/linux/ptrace.h	2005-10-31 12:24:14.000000000 +0100
+++ linux-2.6/include/linux/ptrace.h	2005-10-31 17:30:43.000000000 +0100
@@ -78,6 +78,8 @@
 #include <linux/compiler.h>		/* For unlikely.  */
 #include <linux/sched.h>		/* For struct task_struct.  */
 
+
+extern long arch_ptrace(struct task_struct *child, long request, long addr, long data);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len);
 extern int ptrace_attach(struct task_struct *tsk);
Index: linux-2.6/arch/sh64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sh64/kernel/ptrace.c	2005-10-31 13:15:49.000000000 +0100
+++ linux-2.6/arch/sh64/kernel/ptrace.c	2005-10-31 17:30:43.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/signal.h>
+#include <linux/syscalls.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -121,61 +122,11 @@
 	return 0;
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
-	extern void poke_real_address_q(unsigned long long addr, unsigned long long data);
-#define WPC_DBRMODE 0x0d104008
-	static int first_call = 1;
 	int ret;
 
-	lock_kernel();
-
-	if (first_call) {
-		/* Set WPC.DBRMODE to 0.  This makes all debug events get
-		 * delivered through RESVEC, i.e. into the handlers in entry.S.
-		 * (If the kernel was downloaded using a remote gdb, WPC.DBRMODE
-		 * would normally be left set to 1, which makes debug events get
-		 * delivered through DBRVEC, i.e. into the remote gdb's
-		 * handlers.  This prevents ptrace getting them, and confuses
-		 * the remote gdb.) */
-		printk("DBRMODE set to 0 to permit native debugging\n");
-		poke_real_address_q(WPC_DBRMODE, 0);
-		first_call = 0;
-	}
-
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-			goto out_tsk;
-		}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */
@@ -313,13 +264,33 @@
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
 	return ret;
 }
 
+asmlinkage int sh64_ptrace(long request, long pid, long addr, long data)
+{
+	extern void poke_real_address_q(unsigned long long addr, unsigned long long data);
+#define WPC_DBRMODE 0x0d104008
+	static int first_call = 1;
+
+	lock_kernel();
+	if (first_call) {
+		/* Set WPC.DBRMODE to 0.  This makes all debug events get
+		 * delivered through RESVEC, i.e. into the handlers in entry.S.
+		 * (If the kernel was downloaded using a remote gdb, WPC.DBRMODE
+		 * would normally be left set to 1, which makes debug events get
+		 * delivered through DBRVEC, i.e. into the remote gdb's
+		 * handlers.  This prevents ptrace getting them, and confuses
+		 * the remote gdb.) */
+		printk("DBRMODE set to 0 to permit native debugging\n");
+		poke_real_address_q(WPC_DBRMODE, 0);
+		first_call = 0;
+	}
+	unlock_kernel();
+
+	return sys_ptrace(request, pid, addr, data);
+}
+
 asmlinkage void syscall_trace(void)
 {
 	struct task_struct *tsk = current;
Index: linux-2.6/arch/sh64/kernel/syscalls.S
===================================================================
--- linux-2.6.orig/arch/sh64/kernel/syscalls.S	2005-10-31 12:23:19.000000000 +0100
+++ linux-2.6/arch/sh64/kernel/syscalls.S	2005-10-31 17:30:43.000000000 +0100
@@ -46,7 +46,7 @@
 	.long sys_setuid16
 	.long sys_getuid16
 	.long sys_stime			/* 25 */
-	.long sys_ptrace
+	.long sh64_ptrace
 	.long sys_alarm
 	.long sys_fstat
 	.long sys_pause
Index: linux-2.6/include/asm-s390/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-s390/ptrace.h	2005-10-31 12:24:12.000000000 +0100
+++ linux-2.6/include/asm-s390/ptrace.h	2005-10-31 17:30:43.000000000 +0100
@@ -468,6 +468,8 @@
 };
 
 #ifdef __KERNEL__
+#define __ARCH_SYS_PTRACE	1
+
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
 #define instruction_pointer(regs) ((regs)->psw.addr & PSW_ADDR_INSN)
 #define profile_pc(regs) instruction_pointer(regs)
Index: linux-2.6/arch/m68k/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/m68k/kernel/ptrace.c	2005-10-31 17:33:38.000000000 +0100
@@ -121,48 +121,11 @@
 	child->thread.work.syscall_trace = 0;
 }
 
-asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	unsigned long tmp;
 	int i, ret = 0;
 
-	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		/* are we already being traced? */
-		if (current->ptrace & PT_PTRACED) {
-			ret = -EPERM;
-			goto out;
-		}
-		/* set the ptrace bit in the process flags. */
-		current->ptrace |= PT_PTRACED;
-		goto out;
-	}
-	read_lock(&tasklist_lock);
-	child = find_task_by_pid(pid);
-	if (child)
-		get_task_struct(child);
-	read_unlock(&tasklist_lock);
-	if (unlikely(!child)) {
-		ret = -ESRCH;
-		goto out;
-	}
-
-	/* you may not mess with init */
-	if (unlikely(pid == 1)) {
-		ret = -EPERM;
-		goto out_tsk;
-	}
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret)
-		goto out_tsk;
-
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT:	/* read word at location addr. */
@@ -317,14 +280,10 @@
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+
 	return ret;
 out_eio:
-	ret = -EIO;
-	goto out_tsk;
+	return -EIO;
 }
 
 asmlinkage void syscall_trace(void)
Index: linux-2.6/arch/parisc/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/parisc/kernel/ptrace.c	2005-10-31 17:36:23.000000000 +0100
@@ -78,52 +78,13 @@
 	pa_psw(child)->l = 0;
 }
 
-long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	long ret;
 #ifdef DEBUG_PTRACE
 	long oaddr=addr, odata=data;
 #endif
 
-	lock_kernel();
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
-	if (!child)
-		goto out;
-	ret = -EPERM;
-	if (pid == 1)		/* no messing around with init! */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
 	case PTRACE_PEEKDATA: {
@@ -383,11 +344,11 @@
 
 	case PTRACE_GETEVENTMSG:
                 ret = put_user(child->ptrace_message, (unsigned int __user *) data);
-		goto out_tsk;
+		goto out;
 
 	default:
 		ret = ptrace_request(child, request, addr, data);
-		goto out_tsk;
+		goto out;
 	}
 
 out_wake_notrap:
@@ -396,10 +357,7 @@
 	wake_up_process(child);
 	ret = 0;
 out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
-	DBG("sys_ptrace(%ld, %d, %lx, %lx) returning %ld\n",
+	DBG("arch_ptrace(%ld, %d, %lx, %lx) returning %ld\n",
 		request, pid, oaddr, odata, ret);
 	return ret;
 }
Index: linux-2.6/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/ptrace.c	2005-10-31 13:15:48.000000000 +0100
+++ linux-2.6/arch/powerpc/kernel/ptrace.c	2005-10-31 17:40:41.000000000 +0100
@@ -248,46 +248,10 @@
 	clear_single_step(child);
 }
 
-long sys_ptrace(long request, long pid, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	struct task_struct *child;
 	int ret = -EPERM;
 
-	lock_kernel();
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
-	if (!child)
-		goto out;
-
-	ret = -EPERM;
-	if (pid == 1)		/* you may not mess with init */
-		goto out_tsk;
-
-	if (request == PTRACE_ATTACH) {
-		ret = ptrace_attach(child);
-		goto out_tsk;
-	}
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_tsk;
-
 	switch (request) {
 	/* when I and D space are separate, these will need to be fixed. */
 	case PTRACE_PEEKTEXT: /* read word at location addr. */
@@ -540,10 +504,7 @@
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
+
 	return ret;
 }
 
