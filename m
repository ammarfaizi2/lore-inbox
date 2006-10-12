Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWJLOLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWJLOLD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWJLOKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:10:49 -0400
Received: from cantor.suse.de ([195.135.220.2]:2497 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932083AbWJLOK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:10:26 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-Id: <20061012120150.29671.48586.sendpatchset@linux.site>
In-Reply-To: <20061012120102.29671.31163.sendpatchset@linux.site>
References: <20061012120102.29671.31163.sendpatchset@linux.site>
Subject: [patch 5/5] oom: invoke OOM killer from pagefault handler
Date: Thu, 12 Oct 2006 16:10:21 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than have the pagefault handler kill a process directly if it gets a
VM_FAULT_OOM, have it call into the OOM killer.

Only converted a few architectures so far - this is just an RFC.

Index: linux-2.6/mm/oom_kill.c
===================================================================
--- linux-2.6.orig/mm/oom_kill.c
+++ linux-2.6/mm/oom_kill.c
@@ -376,6 +376,57 @@ int unregister_oom_notifier(struct notif
 }
 EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 
+/*
+ * Must be called with cpuset_lock and tasklist_lock held for read.
+ */
+void __out_of_memory(void)
+{
+	unsigned long points = 0;
+	struct task_struct *p;
+
+	if (sysctl_panic_on_oom)
+		panic("out of memory. panic_on_oom is selected\n");
+retry:
+	/*
+	 * Rambo mode: Shoot down a process and hope it solves whatever
+	 * issues we may have.
+	 */
+	p = select_bad_process(&points);
+
+	if (PTR_ERR(p) == -1UL)
+		return;
+
+	/* Found nothing?!?! Either we hang forever, or we panic. */
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		cpuset_unlock();
+		panic("Out of memory and no killable processes...\n");
+	}
+
+	if (oom_kill_process(p, points, "Out of memory"))
+		goto retry;
+}
+
+/*
+ * pagefault handler calls into here because it is out of memory but
+ * doesn't know exactly how or why.
+ */
+void pagefault_out_of_memory(void)
+{
+	if (printk_ratelimit()) {
+		printk(KERN_WARNING "%s invoked oom-killer from pagefault: "
+			"oomkilladj=%d\n", current->oomkilladj);
+		dump_stack();
+		show_mem();
+	}
+
+	cpuset_lock();
+	read_lock(&tasklist_lock);
+	__out_of_memory();
+	read_unlock(&tasklist_lock);
+	cpuset_unlock();
+}
+
 /**
  * out_of_memory - kill the "best" process when we run out of memory
  *
@@ -386,8 +437,6 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifie
  */
 void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order)
 {
-	struct task_struct *p;
-	unsigned long points = 0;
 	unsigned long freed = 0;
 
 	blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
@@ -412,42 +461,18 @@ void out_of_memory(struct zonelist *zone
 	 */
 	switch (constrained_alloc(zonelist, gfp_mask)) {
 	case CONSTRAINT_MEMORY_POLICY:
-		oom_kill_process(current, points,
-				"No available memory (MPOL_BIND)");
+		oom_kill_process(current, 0, "No available memory (MPOL_BIND)");
 		break;
 
 	case CONSTRAINT_CPUSET:
-		oom_kill_process(current, points,
-				"No available memory in cpuset");
+		oom_kill_process(current, 0, "No available memory in cpuset");
 		break;
 
 	case CONSTRAINT_NONE:
-		if (sysctl_panic_on_oom)
-			panic("out of memory. panic_on_oom is selected\n");
-retry:
-		/*
-		 * Rambo mode: Shoot down a process and hope it solves whatever
-		 * issues we may have.
-		 */
-		p = select_bad_process(&points);
-
-		if (PTR_ERR(p) == -1UL)
-			goto out;
-
-		/* Found nothing?!?! Either we hang forever, or we panic. */
-		if (!p) {
-			read_unlock(&tasklist_lock);
-			cpuset_unlock();
-			panic("Out of memory and no killable processes...\n");
-		}
-
-		if (oom_kill_process(p, points, "Out of memory"))
-			goto retry;
-
+		__out_of_memory();
 		break;
 	}
 
-out:
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
 
Index: linux-2.6/arch/alpha/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/alpha/mm/fault.c
+++ linux-2.6/arch/alpha/mm/fault.c
@@ -143,7 +143,6 @@ do_page_fault(unsigned long address, uns
 			goto bad_area;
 	}
 
- survive:
 	/* If for any reason at all we couldn't handle the fault,
 	   make sure we exit gracefully rather than endlessly redo
 	   the fault.  */
@@ -190,19 +189,13 @@ do_page_fault(unsigned long address, uns
 	die_if_kernel("Oops", regs, cause, (unsigned long*)regs - 16);
 	do_exit(SIGKILL);
 
-	/* We ran out of memory, or some other thing happened to us that
-	   made us unable to handle the page fault gracefully.  */
+	/*
+	 * We ran out of memory, call the OOM killer, and return to userspace
+	 * (the fault will be retried if we weren't killed)
+	 */
  out_of_memory:
-	if (is_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk(KERN_ALERT "VM: killing process %s(%d)\n",
-	       current->comm, current->pid);
-	if (!user_mode(regs))
-		goto no_context;
-	do_exit(SIGKILL);
+	pagefault_out_of_memory();
+	return;
 
  do_sigbus:
 	/* Send a sigbus, regardless of whether we were in kernel
Index: linux-2.6/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/i386/mm/fault.c
+++ linux-2.6/arch/i386/mm/fault.c
@@ -444,7 +444,6 @@ good_area:
 				goto bad_area;
 	}
 
- survive:
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
@@ -583,21 +582,14 @@ no_context:
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
 
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
- */
 out_of_memory:
+	/*
+	 * We ran out of memory, call the OOM killer, and return to userspace
+	 * (the fault will be retried if we weren't killed)
+	 */
 	up_read(&mm->mmap_sem);
-	if (is_init(tsk)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", tsk->comm);
-	if (error_code & 4)
-		do_exit(SIGKILL);
-	goto no_context;
+	pagefault_out_of_memory();
+	return;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
Index: linux-2.6/arch/ia64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/ia64/mm/fault.c
+++ linux-2.6/arch/ia64/mm/fault.c
@@ -155,7 +155,6 @@ ia64_do_page_fault (unsigned long addres
 	if ((vma->vm_flags & mask) != mask)
 		goto bad_area;
 
-  survive:
 	/*
 	 * If for any reason at all we couldn't handle the fault, make
 	 * sure we exit gracefully rather than endlessly redo the
@@ -280,13 +279,10 @@ ia64_do_page_fault (unsigned long addres
 
   out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (is_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk(KERN_CRIT "VM: killing process %s\n", current->comm);
-	if (user_mode(regs))
-		do_exit(SIGKILL);
-	goto no_context;
+	/*
+	 * We ran out of memory, call the OOM killer, and return to userspace
+	 * (the fault will be retried if we weren't killed)
+	 */
+	pagefault_out_of_memory();
+	return;
 }
Index: linux-2.6/arch/powerpc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/fault.c
+++ linux-2.6/arch/powerpc/mm/fault.c
@@ -342,7 +342,6 @@ good_area:
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
- survive:
 	switch (handle_mm_fault(mm, vma, address, is_write)) {
 
 	case VM_FAULT_MINOR:
@@ -380,21 +379,14 @@ bad_area_nosemaphore:
 
 	return SIGSEGV;
 
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
- */
 out_of_memory:
+	/*
+	 * We ran out of memory, call the OOM killer, and return to userspace
+	 * (the fault will be retried if we weren't killed)
+	 */
 	up_read(&mm->mmap_sem);
-	if (is_init(current)) {
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	printk("VM: killing process %s\n", current->comm);
-	if (user_mode(regs))
-		do_exit(SIGKILL);
-	return SIGKILL;
+	pagefault_out_of_memory();
+	return 0;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
Index: linux-2.6/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/x86_64/mm/fault.c
+++ linux-2.6/arch/x86_64/mm/fault.c
@@ -407,7 +407,6 @@ asmlinkage void __kprobes do_page_fault(
 	if (unlikely(in_atomic() || !mm))
 		goto bad_area_nosemaphore;
 
- again:
 	/* When running in the kernel we expect faults to occur only to
 	 * addresses in user space.  All other faults represent errors in the
 	 * kernel and should generate an OOPS.  Unfortunatly, in the case of an
@@ -574,20 +573,14 @@ no_context:
 	oops_end(flags);
 	do_exit(SIGKILL);
 
-/*
- * We ran out of memory, or some other thing happened to us that made
- * us unable to handle the page fault gracefully.
- */
 out_of_memory:
+	/*
+	 * We ran out of memory, call the OOM killer, and return to userspace
+	 * (the fault will be retried if we weren't killed)
+	 */
 	up_read(&mm->mmap_sem);
-	if (is_init(current)) {
-		yield();
-		goto again;
-	}
-	printk("VM: killing process %s\n", tsk->comm);
-	if (error_code & 4)
-		do_exit(SIGKILL);
-	goto no_context;
+	pagefault_out_of_memory();
+	return;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -617,6 +617,11 @@ static inline int page_mapped(struct pag
  */
 #define VM_FAULT_WRITE	0x10
 
+/*
+ * Can be called by the pagefault handler when it gets a VM_FAULT_OOM.
+ */
+extern void pagefault_out_of_memory(void);
+
 #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
 
 extern void show_free_areas(void);
Index: linux-2.6/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/trap.c
+++ linux-2.6/arch/um/kernel/trap.c
@@ -75,7 +75,6 @@ good_area:
                 goto out;
 
 	do {
-survive:
 		switch (handle_mm_fault(mm, vma, address, is_write)){
 		case VM_FAULT_MINOR:
 			current->min_flt++;
@@ -119,13 +118,13 @@ out_nosemaphore:
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	if (is_init(current)) {
-		up_read(&mm->mmap_sem);
-		yield();
-		down_read(&mm->mmap_sem);
-		goto survive;
-	}
-	goto out;
+	/*
+	 * We ran out of memory, call the OOM killer, and return to userspace
+	 * (the fault will be retried if we weren't killed)
+	 */
+	up_read(&mm->mmap_sem);
+	pagefault_out_of_memory();
+	goto out_nosemaphore;
 }
 
 void segv_handler(int sig, union uml_pt_regs *regs)
