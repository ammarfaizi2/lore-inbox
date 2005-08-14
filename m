Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVHNQOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVHNQOg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 12:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVHNQOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 12:14:36 -0400
Received: from verein.lst.de ([213.95.11.210]:45752 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932556AbVHNQOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 12:14:34 -0400
Date: Sun, 14 Aug 2005 18:14:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] consolidate sys_ptrace
Message-ID: <20050814161423.GA2188@lst.de>
References: <20050814093543.GA28557@lst.de> <20050814154848.GA4927@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050814154848.GA4927@twiddle.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 08:48:48AM -0700, Richard Henderson wrote:
> On Sun, Aug 14, 2005 at 11:35:43AM +0200, Christoph Hellwig wrote:
> > This version has the arch_ptrace return value changes to long as
> > recommended by Richard Henderson.
> ...
> > +extern int arch_ptrace(struct task_struct *child, long request, long addr, long data);
> 
> No it doesn't.

Sorry, looks like I sent out the old version of the patch again.
Here's the real one:

Index: linux-2.6/arch/arm/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/ptrace.c	2005-08-11 16:45:52.000000000 +0200
+++ linux-2.6/arch/arm/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
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
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
--- linux-2.6.orig/arch/arm26/kernel/ptrace.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/arm26/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
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
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
--- linux-2.6.orig/arch/frv/kernel/ptrace.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/frv/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -106,48 +106,11 @@
 	child->thread.frame0->__status |= REG__STATUS_STEP;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
--- linux-2.6.orig/arch/h8300/kernel/ptrace.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/h8300/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -57,43 +57,10 @@
 	h8300_disable_trace(child);
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
--- linux-2.6.orig/arch/i386/kernel/ptrace.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/i386/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -352,49 +352,12 @@
 	return 0;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
@@ -649,10 +612,7 @@
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
 
Index: linux-2.6/arch/m68knommu/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/m68knommu/kernel/ptrace.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/m68knommu/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -101,43 +101,10 @@
 	put_reg(child, PT_SR, tmp);
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
--- linux-2.6.orig/arch/mips/kernel/ptrace.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/mips/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -47,51 +47,10 @@
 	/* Nothing to do.. */
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
@@ -294,10 +253,6 @@
 		break;
 	}
 
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
 	return ret;
 }
 
Index: linux-2.6/arch/ppc/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/ptrace.c	2005-08-11 16:45:54.000000000 +0200
+++ linux-2.6/arch/ppc/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -240,46 +240,10 @@
 	clear_single_step(child);
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
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
@@ -451,10 +415,7 @@
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
 
Index: linux-2.6/arch/ppc64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/ptrace.c	2005-08-11 16:45:54.000000000 +0200
+++ linux-2.6/arch/ppc64/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -52,46 +52,10 @@
 	clear_single_step(child);
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
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
@@ -278,10 +242,7 @@
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
 
Index: linux-2.6/arch/sh/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/ptrace.c	2005-08-11 16:45:54.000000000 +0200
+++ linux-2.6/arch/sh/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -80,48 +80,11 @@
 	/* nothing to do.. */
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
--- linux-2.6.orig/arch/v850/kernel/ptrace.c	2005-08-11 16:45:55.000000000 +0200
+++ linux-2.6/arch/v850/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -113,45 +113,10 @@
 	return 1;
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
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
 
@@ -249,10 +214,6 @@
 		goto out;
 	}
 
-out_tsk:
-	put_task_struct(child);
-out:
-	unlock_kernel();
 	return rval;
 }
 
Index: linux-2.6/arch/x86_64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/ptrace.c	2005-08-11 16:45:55.000000000 +0200
+++ linux-2.6/arch/x86_64/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
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
--- linux-2.6.orig/arch/xtensa/kernel/ptrace.c	2005-08-11 16:45:55.000000000 +0200
+++ linux-2.6/arch/xtensa/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -45,58 +45,10 @@
 	/* Nothing to do.. */
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
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
+
 	return ret;
 }
 
Index: linux-2.6/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/kernel/ptrace.c	2005-08-11 16:46:07.000000000 +0200
+++ linux-2.6/kernel/ptrace.c	2005-08-13 18:20:49.000000000 +0200
@@ -388,3 +388,85 @@
 
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
--- linux-2.6.orig/arch/cris/arch-v10/kernel/ptrace.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/cris/arch-v10/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
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
--- linux-2.6.orig/arch/cris/arch-v32/kernel/ptrace.c	2005-08-11 16:45:53.000000000 +0200
+++ linux-2.6/arch/cris/arch-v32/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
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
--- linux-2.6.orig/arch/um/kernel/ptrace.c	2005-08-11 16:45:55.000000000 +0200
+++ linux-2.6/arch/um/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
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
--- linux-2.6.orig/include/asm-alpha/ptrace.h	2005-08-11 16:46:03.000000000 +0200
+++ linux-2.6/include/asm-alpha/ptrace.h	2005-08-13 13:18:11.000000000 +0200
@@ -67,6 +67,9 @@
 };
 
 #ifdef __KERNEL__
+
+#define __ARCH_SYS_PTRACE	1
+
 #define user_mode(regs) (((regs)->ps & 8) != 0)
 #define instruction_pointer(regs) ((regs)->pc)
 #define profile_pc(regs) instruction_pointer(regs)
Index: linux-2.6/include/asm-arm/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-arm/unistd.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-arm/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -537,7 +537,6 @@
 asmlinkage int sys_fork(struct pt_regs *regs);
 asmlinkage int sys_vfork(struct pt_regs *regs);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-arm26/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-arm26/unistd.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-arm26/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -480,7 +480,6 @@
 asmlinkage int sys_fork(struct pt_regs *regs);
 asmlinkage int sys_vfork(struct pt_regs *regs);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-cris/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-cris/unistd.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-cris/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -367,7 +367,6 @@
 asmlinkage int sys_vfork(long r10, long r11, long r12, long r13,
 			long mof, long srp, struct pt_regs *regs);
 asmlinkage int sys_pipe(unsigned long __user *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-h8300/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/unistd.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-h8300/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -528,7 +528,6 @@
 asmlinkage int sys_execve(char *name, char **argv, char **envp,
 			int dummy, ...);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-i386/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-i386/unistd.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-i386/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -448,7 +448,6 @@
 asmlinkage int sys_fork(struct pt_regs regs);
 asmlinkage int sys_vfork(struct pt_regs regs);
 asmlinkage int sys_pipe(unsigned long __user *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 asmlinkage long sys_iopl(unsigned long unused);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
Index: linux-2.6/include/asm-ia64/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/ptrace.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-ia64/ptrace.h	2005-08-13 13:18:11.000000000 +0200
@@ -227,6 +227,9 @@
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
--- linux-2.6.orig/include/asm-m32r/ptrace.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-m32r/ptrace.h	2005-08-13 13:18:11.000000000 +0200
@@ -145,6 +145,9 @@
 #define PTRACE_O_TRACESYSGOOD	0x00000001
 
 #ifdef __KERNEL__
+
+#define __ARCH_SYS_PTRACE	1
+
 #if defined(CONFIG_ISA_M32R2) || defined(CONFIG_CHIP_VDEC2)
 #define user_mode(regs) ((M32R_PSW_BPM & (regs)->psw) != 0)
 #elif defined(CONFIG_ISA_M32R)
Index: linux-2.6/include/asm-m68knommu/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/unistd.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-m68knommu/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -504,7 +504,6 @@
 			unsigned long fd, unsigned long pgoff);
 asmlinkage int sys_execve(char *name, char **argv, char **envp);
 asmlinkage int sys_pipe(unsigned long *fildes);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct pt_regs;
 int sys_request_irq(unsigned int,
 			irqreturn_t (*)(int, void *, struct pt_regs *),
Index: linux-2.6/include/asm-mips/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-mips/unistd.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-mips/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -1164,7 +1164,6 @@
 			unsigned long fd, unsigned long pgoff);
 asmlinkage int sys_execve(nabi_no_regargs struct pt_regs regs);
 asmlinkage int sys_pipe(nabi_no_regargs struct pt_regs regs);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-parisc/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/ptrace.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-parisc/ptrace.h	2005-08-13 13:18:11.000000000 +0200
@@ -45,6 +45,9 @@
 #define PTRACE_SINGLEBLOCK	12	/* resume execution until next branch */
 #ifdef __KERNEL__
 
+#define __ARCH_SYS_PTRACE	1
+
+
 /* XXX should we use iaoq[1] or iaoq[0] ? */
 #define user_mode(regs)			(((regs)->iaoq[0] & 3) ? 1 : 0)
 #define user_space(regs)		(((regs)->iasq[1] != 0) ? 1 : 0)
Index: linux-2.6/include/asm-ppc/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/unistd.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-ppc/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -469,7 +469,6 @@
 int sys_vfork(int p1, int p2, int p3, int p4, int p5, int p6,
 		struct pt_regs *regs);
 int sys_pipe(int __user *fildes);
-int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 long sys_rt_sigaction(int sig,
 		      const struct sigaction __user *act,
Index: linux-2.6/include/asm-ppc64/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/unistd.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-ppc64/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -467,7 +467,6 @@
 		unsigned long p4, unsigned long p5, unsigned long p6,
 		struct pt_regs *regs);
 int sys_pipe(int __user *fildes);
-int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 long sys_rt_sigaction(int sig, const struct sigaction __user *act,
 		      struct sigaction __user *oact, size_t sigsetsize);
Index: linux-2.6/include/asm-sh/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-sh/unistd.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-sh/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -497,7 +497,6 @@
 asmlinkage int sys_pipe(unsigned long r4, unsigned long r5,
 			unsigned long r6, unsigned long r7,
 			struct pt_regs regs);
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
 asmlinkage ssize_t sys_pread_wrapper(unsigned int fd, char *buf,
 				size_t count, long dummy, loff_t pos);
 asmlinkage ssize_t sys_pwrite_wrapper(unsigned int fd, const char *buf,
Index: linux-2.6/include/asm-sparc/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/ptrace.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-sparc/ptrace.h	2005-08-13 13:18:11.000000000 +0200
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
--- linux-2.6.orig/include/asm-sparc64/ptrace.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-sparc64/ptrace.h	2005-08-13 13:18:11.000000000 +0200
@@ -94,6 +94,9 @@
 #define STACKFRAME32_SZ	sizeof(struct sparc_stackf32)
 
 #ifdef __KERNEL__
+
+#define __ARCH_SYS_PTRACE	1
+
 #define force_successful_syscall_return()	    \
 do {	current_thread_info()->syscall_noerror = 1; \
 } while (0)
Index: linux-2.6/include/asm-v850/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-v850/unistd.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-v850/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -452,7 +452,6 @@
 struct pt_regs;
 int sys_execve (char *name, char **argv, char **envp, struct pt_regs *regs);
 int sys_pipe (int *fildes);
-int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
Index: linux-2.6/include/asm-x86_64/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/unistd.h	2005-08-11 16:46:06.000000000 +0200
+++ linux-2.6/include/asm-x86_64/unistd.h	2005-08-13 13:18:11.000000000 +0200
@@ -780,8 +780,6 @@
 #include <linux/types.h>
 #include <asm/ptrace.h>
 
-asmlinkage long sys_ptrace(long request, long pid,
-				unsigned long addr, long data);
 asmlinkage long sys_iopl(unsigned int level, struct pt_regs *regs);
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on);
 struct sigaction;
Index: linux-2.6/include/linux/ptrace.h
===================================================================
--- linux-2.6.orig/include/linux/ptrace.h	2005-08-11 16:46:06.000000000 +0200
+++ linux-2.6/include/linux/ptrace.h	2005-08-13 18:20:38.000000000 +0200
@@ -76,6 +76,8 @@
 #include <linux/compiler.h>		/* For unlikely.  */
 #include <linux/sched.h>		/* For struct task_struct.  */
 
+
+extern long arch_ptrace(struct task_struct *child, long request, long addr, long data);
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len);
 extern int ptrace_attach(struct task_struct *tsk);
Index: linux-2.6/arch/sh64/kernel/ptrace.c
===================================================================
--- linux-2.6.orig/arch/sh64/kernel/ptrace.c	2005-08-11 16:45:54.000000000 +0200
+++ linux-2.6/arch/sh64/kernel/ptrace.c	2005-08-13 13:18:11.000000000 +0200
@@ -121,61 +121,11 @@
 	return 0;
 }
 
-asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
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
@@ -313,13 +263,33 @@
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
--- linux-2.6.orig/arch/sh64/kernel/syscalls.S	2005-08-11 16:45:54.000000000 +0200
+++ linux-2.6/arch/sh64/kernel/syscalls.S	2005-08-13 13:18:11.000000000 +0200
@@ -46,7 +46,7 @@
 	.long sys_setuid16
 	.long sys_getuid16
 	.long sys_stime			/* 25 */
-	.long sys_ptrace
+	.long sh64_ptrace
 	.long sys_alarm
 	.long sys_fstat
 	.long sys_pause
Index: linux-2.6/include/asm-m68k/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/ptrace.h	2005-08-11 16:46:04.000000000 +0200
+++ linux-2.6/include/asm-m68k/ptrace.h	2005-08-13 13:18:36.000000000 +0200
@@ -65,6 +65,7 @@
 #define PTRACE_SETFPREGS          15
 
 #ifdef __KERNEL__
+#define __ARCH_SYS_PTRACE	1
 
 #ifndef PS_S
 #define PS_S  (0x2000)
Index: linux-2.6/include/asm-s390/ptrace.h
===================================================================
--- linux-2.6.orig/include/asm-s390/ptrace.h	2005-08-11 16:46:05.000000000 +0200
+++ linux-2.6/include/asm-s390/ptrace.h	2005-08-13 13:18:46.000000000 +0200
@@ -468,6 +468,8 @@
 };
 
 #ifdef __KERNEL__
+#define __ARCH_SYS_PTRACE	1
+
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
 #define instruction_pointer(regs) ((regs)->psw.addr & PSW_ADDR_INSN)
 #define profile_pc(regs) instruction_pointer(regs)
