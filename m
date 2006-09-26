Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWIZRzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWIZRzL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWIZRzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:55:10 -0400
Received: from [198.99.130.12] ([198.99.130.12]:8611 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932219AbWIZRyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:54:40 -0400
Message-Id: <200609261753.k8QHrGlI005530@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] UML - file renaming
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Sep 2006 13:53:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move some foo_kern.c files to foo.c now that the old foo.c files are out
of the way.

Also cleaned up some whitespace and an emacs formatting comment.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/Makefile	2006-09-22 09:16:05.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/Makefile	2006-09-22 09:56:32.000000000 -0400
@@ -7,7 +7,7 @@ extra-y := vmlinux.lds
 clean-files :=
 
 obj-y = config.o exec.o exitcode.o init_task.o irq.o ksyms.o mem.o \
-	physmem.o process_kern.o ptrace.o reboot.o resource.o sigio.o \
+	physmem.o process.o ptrace.o reboot.o resource.o sigio.o \
 	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o uaccess.o \
 	um_arch.o umid.o
 
Index: linux-2.6.18-mm/arch/um/kernel/process.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/kernel/process.c	2006-09-22 10:07:37.000000000 -0400
@@ -0,0 +1,483 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
+ * Licensed under the GPL
+ */
+
+#include "linux/kernel.h"
+#include "linux/sched.h"
+#include "linux/interrupt.h"
+#include "linux/string.h"
+#include "linux/mm.h"
+#include "linux/slab.h"
+#include "linux/utsname.h"
+#include "linux/fs.h"
+#include "linux/utime.h"
+#include "linux/smp_lock.h"
+#include "linux/module.h"
+#include "linux/init.h"
+#include "linux/capability.h"
+#include "linux/vmalloc.h"
+#include "linux/spinlock.h"
+#include "linux/proc_fs.h"
+#include "linux/ptrace.h"
+#include "linux/random.h"
+#include "linux/personality.h"
+#include "asm/unistd.h"
+#include "asm/mman.h"
+#include "asm/segment.h"
+#include "asm/stat.h"
+#include "asm/pgtable.h"
+#include "asm/processor.h"
+#include "asm/tlbflush.h"
+#include "asm/uaccess.h"
+#include "asm/user.h"
+#include "user_util.h"
+#include "kern_util.h"
+#include "kern.h"
+#include "signal_kern.h"
+#include "init.h"
+#include "irq_user.h"
+#include "mem_user.h"
+#include "tlb.h"
+#include "frame_kern.h"
+#include "sigcontext.h"
+#include "os.h"
+#include "mode.h"
+#include "mode_kern.h"
+#include "choose-mode.h"
+
+/* This is a per-cpu array.  A processor only modifies its entry and it only
+ * cares about its entry, so it's OK if another processor is modifying its
+ * entry.
+ */
+struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { -1, NULL } };
+
+int external_pid(void *t)
+{
+	struct task_struct *task = t ? t : current;
+
+	return(CHOOSE_MODE_PROC(external_pid_tt, external_pid_skas, task));
+}
+
+int pid_to_processor_id(int pid)
+{
+	int i;
+
+	for(i = 0; i < ncpus; i++){
+		if(cpu_tasks[i].pid == pid) return(i);
+	}
+	return(-1);
+}
+
+void free_stack(unsigned long stack, int order)
+{
+	free_pages(stack, order);
+}
+
+unsigned long alloc_stack(int order, int atomic)
+{
+	unsigned long page;
+	gfp_t flags = GFP_KERNEL;
+
+	if (atomic)
+		flags = GFP_ATOMIC;
+	page = __get_free_pages(flags, order);
+	if(page == 0)
+		return(0);
+	stack_protections(page);
+	return(page);
+}
+
+int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+{
+	int pid;
+
+	current->thread.request.u.thread.proc = fn;
+	current->thread.request.u.thread.arg = arg;
+	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0,
+		      &current->thread.regs, 0, NULL, NULL);
+	if(pid < 0)
+		panic("do_fork failed in kernel_thread, errno = %d", pid);
+	return(pid);
+}
+
+void set_current(void *t)
+{
+	struct task_struct *task = t;
+
+	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task)
+		{ external_pid(task), task });
+}
+
+void *_switch_to(void *prev, void *next, void *last)
+{
+	struct task_struct *from = prev;
+	struct task_struct *to= next;
+
+	to->thread.prev_sched = from;
+	set_current(to);
+
+	do {
+		current->thread.saved_task = NULL ;
+		CHOOSE_MODE_PROC(switch_to_tt, switch_to_skas, prev, next);
+		if(current->thread.saved_task)
+			show_regs(&(current->thread.regs));
+		next= current->thread.saved_task;
+		prev= current;
+	} while(current->thread.saved_task);
+
+	return(current->thread.prev_sched);
+
+}
+
+void interrupt_end(void)
+{
+	if(need_resched()) schedule();
+	if(test_tsk_thread_flag(current, TIF_SIGPENDING)) do_signal();
+}
+
+void release_thread(struct task_struct *task)
+{
+	CHOOSE_MODE(release_thread_tt(task), release_thread_skas(task));
+}
+
+void exit_thread(void)
+{
+	unprotect_stack((unsigned long) current_thread);
+}
+
+void *get_current(void)
+{
+	return(current);
+}
+
+int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
+		unsigned long stack_top, struct task_struct * p,
+		struct pt_regs *regs)
+{
+	int ret;
+
+	p->thread = (struct thread_struct) INIT_THREAD;
+	ret = CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr,
+				clone_flags, sp, stack_top, p, regs);
+
+	if (ret || !current->thread.forking)
+		goto out;
+
+	clear_flushed_tls(p);
+
+	/*
+	 * Set a new TLS for the child thread?
+	 */
+	if (clone_flags & CLONE_SETTLS)
+		ret = arch_copy_tls(p);
+
+out:
+	return ret;
+}
+
+void initial_thread_cb(void (*proc)(void *), void *arg)
+{
+	int save_kmalloc_ok = kmalloc_ok;
+
+	kmalloc_ok = 0;
+	CHOOSE_MODE_PROC(initial_thread_cb_tt, initial_thread_cb_skas, proc,
+			 arg);
+	kmalloc_ok = save_kmalloc_ok;
+}
+
+unsigned long stack_sp(unsigned long page)
+{
+	return(page + PAGE_SIZE - sizeof(void *));
+}
+
+int current_pid(void)
+{
+	return(current->pid);
+}
+
+void default_idle(void)
+{
+	CHOOSE_MODE(uml_idle_timer(), (void) 0);
+
+	while(1){
+		/* endless idle loop with no priority at all */
+
+		/*
+		 * although we are an idle CPU, we do not want to
+		 * get into the scheduler unnecessarily.
+		 */
+		if(need_resched())
+			schedule();
+
+		idle_sleep(10);
+	}
+}
+
+void cpu_idle(void)
+{
+	CHOOSE_MODE(init_idle_tt(), init_idle_skas());
+}
+
+int page_size(void)
+{
+	return(PAGE_SIZE);
+}
+
+void *um_virt_to_phys(struct task_struct *task, unsigned long addr,
+		      pte_t *pte_out)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	pte_t ptent;
+
+	if(task->mm == NULL)
+		return(ERR_PTR(-EINVAL));
+	pgd = pgd_offset(task->mm, addr);
+	if(!pgd_present(*pgd))
+		return(ERR_PTR(-EINVAL));
+
+	pud = pud_offset(pgd, addr);
+	if(!pud_present(*pud))
+		return(ERR_PTR(-EINVAL));
+
+	pmd = pmd_offset(pud, addr);
+	if(!pmd_present(*pmd))
+		return(ERR_PTR(-EINVAL));
+
+	pte = pte_offset_kernel(pmd, addr);
+	ptent = *pte;
+	if(!pte_present(ptent))
+		return(ERR_PTR(-EINVAL));
+
+	if(pte_out != NULL)
+		*pte_out = ptent;
+	return((void *) (pte_val(ptent) & PAGE_MASK) + (addr & ~PAGE_MASK));
+}
+
+char *current_cmd(void)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_HIGHMEM)
+	return("(Unknown)");
+#else
+	void *addr = um_virt_to_phys(current, current->mm->arg_start, NULL);
+	return IS_ERR(addr) ? "(Unknown)": __va((unsigned long) addr);
+#endif
+}
+
+void force_sigbus(void)
+{
+	printk(KERN_ERR "Killing pid %d because of a lack of memory\n",
+	       current->pid);
+	lock_kernel();
+	sigaddset(&current->pending.signal, SIGBUS);
+	recalc_sigpending();
+	current->flags |= PF_SIGNALED;
+	do_exit(SIGBUS | 0x80);
+}
+
+void dump_thread(struct pt_regs *regs, struct user *u)
+{
+}
+
+void enable_hlt(void)
+{
+	panic("enable_hlt");
+}
+
+EXPORT_SYMBOL(enable_hlt);
+
+void disable_hlt(void)
+{
+	panic("disable_hlt");
+}
+
+EXPORT_SYMBOL(disable_hlt);
+
+void *um_kmalloc(int size)
+{
+	return kmalloc(size, GFP_KERNEL);
+}
+
+void *um_kmalloc_atomic(int size)
+{
+	return kmalloc(size, GFP_ATOMIC);
+}
+
+void *um_vmalloc(int size)
+{
+	return vmalloc(size);
+}
+
+void *um_vmalloc_atomic(int size)
+{
+	return __vmalloc(size, GFP_ATOMIC | __GFP_HIGHMEM, PAGE_KERNEL);
+}
+
+int __cant_sleep(void) {
+	return in_atomic() || irqs_disabled() || in_interrupt();
+	/* Is in_interrupt() really needed? */
+}
+
+unsigned long get_fault_addr(void)
+{
+	return((unsigned long) current->thread.fault_addr);
+}
+
+EXPORT_SYMBOL(get_fault_addr);
+
+void not_implemented(void)
+{
+	printk(KERN_DEBUG "Something isn't implemented in here\n");
+}
+
+EXPORT_SYMBOL(not_implemented);
+
+int user_context(unsigned long sp)
+{
+	unsigned long stack;
+
+	stack = sp & (PAGE_MASK << CONFIG_KERNEL_STACK_ORDER);
+	return(stack != (unsigned long) current_thread);
+}
+
+extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
+
+void do_uml_exitcalls(void)
+{
+	exitcall_t *call;
+
+	call = &__uml_exitcall_end;
+	while (--call >= &__uml_exitcall_begin)
+		(*call)();
+}
+
+char *uml_strdup(char *string)
+{
+	return kstrdup(string, GFP_KERNEL);
+}
+
+int copy_to_user_proc(void __user *to, void *from, int size)
+{
+	return(copy_to_user(to, from, size));
+}
+
+int copy_from_user_proc(void *to, void __user *from, int size)
+{
+	return(copy_from_user(to, from, size));
+}
+
+int clear_user_proc(void __user *buf, int size)
+{
+	return(clear_user(buf, size));
+}
+
+int strlen_user_proc(char __user *str)
+{
+	return(strlen_user(str));
+}
+
+int smp_sigio_handler(void)
+{
+#ifdef CONFIG_SMP
+	int cpu = current_thread->cpu;
+	IPI_handler(cpu);
+	if(cpu != 0)
+		return(1);
+#endif
+	return(0);
+}
+
+int cpu(void)
+{
+	return(current_thread->cpu);
+}
+
+static atomic_t using_sysemu = ATOMIC_INIT(0);
+int sysemu_supported;
+
+void set_using_sysemu(int value)
+{
+	if (value > sysemu_supported)
+		return;
+	atomic_set(&using_sysemu, value);
+}
+
+int get_using_sysemu(void)
+{
+	return atomic_read(&using_sysemu);
+}
+
+static int proc_read_sysemu(char *buf, char **start, off_t offset, int size,int *eof, void *data)
+{
+	if (snprintf(buf, size, "%d\n", get_using_sysemu()) < size) /*No overflow*/
+		*eof = 1;
+
+	return strlen(buf);
+}
+
+static int proc_write_sysemu(struct file *file,const char __user *buf, unsigned long count,void *data)
+{
+	char tmp[2];
+
+	if (copy_from_user(tmp, buf, 1))
+		return -EFAULT;
+
+	if (tmp[0] >= '0' && tmp[0] <= '2')
+		set_using_sysemu(tmp[0] - '0');
+	return count; /*We use the first char, but pretend to write everything*/
+}
+
+int __init make_proc_sysemu(void)
+{
+	struct proc_dir_entry *ent;
+	if (!sysemu_supported)
+		return 0;
+
+	ent = create_proc_entry("sysemu", 0600, &proc_root);
+
+	if (ent == NULL)
+	{
+		printk(KERN_WARNING "Failed to register /proc/sysemu\n");
+		return(0);
+	}
+
+	ent->read_proc  = proc_read_sysemu;
+	ent->write_proc = proc_write_sysemu;
+
+	return 0;
+}
+
+late_initcall(make_proc_sysemu);
+
+int singlestepping(void * t)
+{
+	struct task_struct *task = t ? t : current;
+
+	if ( ! (task->ptrace & PT_DTRACE) )
+		return(0);
+
+	if (task->thread.singlestep_syscall)
+		return(1);
+
+	return 2;
+}
+
+/*
+ * Only x86 and x86_64 have an arch_align_stack().
+ * All other arches have "#define arch_align_stack(x) (x)"
+ * in their asm/system.h
+ * As this is included in UML from asm-um/system-generic.h,
+ * we can use it to behave as the subarch does.
+ */
+#ifndef arch_align_stack
+unsigned long arch_align_stack(unsigned long sp)
+{
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+		sp -= get_random_int() % 8192;
+	return sp & ~0xf;
+}
+#endif
Index: linux-2.6.18-mm/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/process_kern.c	2006-09-22 09:16:03.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,483 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Copyright 2003 PathScale, Inc.
- * Licensed under the GPL
- */
-
-#include "linux/kernel.h"
-#include "linux/sched.h"
-#include "linux/interrupt.h"
-#include "linux/string.h"
-#include "linux/mm.h"
-#include "linux/slab.h"
-#include "linux/utsname.h"
-#include "linux/fs.h"
-#include "linux/utime.h"
-#include "linux/smp_lock.h"
-#include "linux/module.h"
-#include "linux/init.h"
-#include "linux/capability.h"
-#include "linux/vmalloc.h"
-#include "linux/spinlock.h"
-#include "linux/proc_fs.h"
-#include "linux/ptrace.h"
-#include "linux/random.h"
-#include "linux/personality.h"
-#include "asm/unistd.h"
-#include "asm/mman.h"
-#include "asm/segment.h"
-#include "asm/stat.h"
-#include "asm/pgtable.h"
-#include "asm/processor.h"
-#include "asm/tlbflush.h"
-#include "asm/uaccess.h"
-#include "asm/user.h"
-#include "user_util.h"
-#include "kern_util.h"
-#include "kern.h"
-#include "signal_kern.h"
-#include "init.h"
-#include "irq_user.h"
-#include "mem_user.h"
-#include "tlb.h"
-#include "frame_kern.h"
-#include "sigcontext.h"
-#include "os.h"
-#include "mode.h"
-#include "mode_kern.h"
-#include "choose-mode.h"
-
-/* This is a per-cpu array.  A processor only modifies its entry and it only
- * cares about its entry, so it's OK if another processor is modifying its
- * entry.
- */
-struct cpu_task cpu_tasks[NR_CPUS] = { [0 ... NR_CPUS - 1] = { -1, NULL } };
-
-int external_pid(void *t)
-{
-	struct task_struct *task = t ? t : current;
-
-	return(CHOOSE_MODE_PROC(external_pid_tt, external_pid_skas, task));
-}
-
-int pid_to_processor_id(int pid)
-{
-	int i;
-
-	for(i = 0; i < ncpus; i++){
-		if(cpu_tasks[i].pid == pid) return(i);
-	}
-	return(-1);
-}
-
-void free_stack(unsigned long stack, int order)
-{
-	free_pages(stack, order);
-}
-
-unsigned long alloc_stack(int order, int atomic)
-{
-	unsigned long page;
-	gfp_t flags = GFP_KERNEL;
-
-	if (atomic)
-		flags = GFP_ATOMIC;
-	page = __get_free_pages(flags, order);
-	if(page == 0)
-		return(0);
-	stack_protections(page);
-	return(page);
-}
-
-int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
-{
-	int pid;
-
-	current->thread.request.u.thread.proc = fn;
-	current->thread.request.u.thread.arg = arg;
-	pid = do_fork(CLONE_VM | CLONE_UNTRACED | flags, 0,
-		      &current->thread.regs, 0, NULL, NULL);
-	if(pid < 0)
-		panic("do_fork failed in kernel_thread, errno = %d", pid);
-	return(pid);
-}
-
-void set_current(void *t)
-{
-	struct task_struct *task = t;
-
-	cpu_tasks[task_thread_info(task)->cpu] = ((struct cpu_task)
-		{ external_pid(task), task });
-}
-
-void *_switch_to(void *prev, void *next, void *last)
-{
-        struct task_struct *from = prev;
-        struct task_struct *to= next;
-
-        to->thread.prev_sched = from;
-        set_current(to);
-
-	do {
-		current->thread.saved_task = NULL ;
-		CHOOSE_MODE_PROC(switch_to_tt, switch_to_skas, prev, next);
-		if(current->thread.saved_task)
-			show_regs(&(current->thread.regs));
-		next= current->thread.saved_task;
-		prev= current;
-	} while(current->thread.saved_task);
-
-        return(current->thread.prev_sched);
-
-}
-
-void interrupt_end(void)
-{
-	if(need_resched()) schedule();
-	if(test_tsk_thread_flag(current, TIF_SIGPENDING)) do_signal();
-}
-
-void release_thread(struct task_struct *task)
-{
-	CHOOSE_MODE(release_thread_tt(task), release_thread_skas(task));
-}
- 
-void exit_thread(void)
-{
-	unprotect_stack((unsigned long) current_thread);
-}
- 
-void *get_current(void)
-{
-	return(current);
-}
-
-int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
-		unsigned long stack_top, struct task_struct * p, 
-		struct pt_regs *regs)
-{
-	int ret;
-
-	p->thread = (struct thread_struct) INIT_THREAD;
-	ret = CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr,
-				clone_flags, sp, stack_top, p, regs);
-
-	if (ret || !current->thread.forking)
-		goto out;
-
-	clear_flushed_tls(p);
-
-	/*
-	 * Set a new TLS for the child thread?
-	 */
-	if (clone_flags & CLONE_SETTLS)
-		ret = arch_copy_tls(p);
-
-out:
-	return ret;
-}
-
-void initial_thread_cb(void (*proc)(void *), void *arg)
-{
-	int save_kmalloc_ok = kmalloc_ok;
-
-	kmalloc_ok = 0;
-	CHOOSE_MODE_PROC(initial_thread_cb_tt, initial_thread_cb_skas, proc, 
-			 arg);
-	kmalloc_ok = save_kmalloc_ok;
-}
- 
-unsigned long stack_sp(unsigned long page)
-{
-	return(page + PAGE_SIZE - sizeof(void *));
-}
-
-int current_pid(void)
-{
-	return(current->pid);
-}
-
-void default_idle(void)
-{
-	CHOOSE_MODE(uml_idle_timer(), (void) 0);
-
-	while(1){
-		/* endless idle loop with no priority at all */
-
-		/*
-		 * although we are an idle CPU, we do not want to
-		 * get into the scheduler unnecessarily.
-		 */
-		if(need_resched())
-			schedule();
-		
-		idle_sleep(10);
-	}
-}
-
-void cpu_idle(void)
-{
-	CHOOSE_MODE(init_idle_tt(), init_idle_skas());
-}
-
-int page_size(void)
-{
-	return(PAGE_SIZE);
-}
-
-void *um_virt_to_phys(struct task_struct *task, unsigned long addr, 
-		      pte_t *pte_out)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	pte_t ptent;
-
-	if(task->mm == NULL) 
-		return(ERR_PTR(-EINVAL));
-	pgd = pgd_offset(task->mm, addr);
-	if(!pgd_present(*pgd))
-		return(ERR_PTR(-EINVAL));
-
-	pud = pud_offset(pgd, addr);
-	if(!pud_present(*pud))
-		return(ERR_PTR(-EINVAL));
-
-	pmd = pmd_offset(pud, addr);
-	if(!pmd_present(*pmd)) 
-		return(ERR_PTR(-EINVAL));
-
-	pte = pte_offset_kernel(pmd, addr);
-	ptent = *pte;
-	if(!pte_present(ptent))
-		return(ERR_PTR(-EINVAL));
-
-	if(pte_out != NULL)
-		*pte_out = ptent;
-	return((void *) (pte_val(ptent) & PAGE_MASK) + (addr & ~PAGE_MASK));
-}
-
-char *current_cmd(void)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_HIGHMEM)
-	return("(Unknown)");
-#else
-	void *addr = um_virt_to_phys(current, current->mm->arg_start, NULL);
-	return IS_ERR(addr) ? "(Unknown)": __va((unsigned long) addr);
-#endif
-}
-
-void force_sigbus(void)
-{
-	printk(KERN_ERR "Killing pid %d because of a lack of memory\n", 
-	       current->pid);
-	lock_kernel();
-	sigaddset(&current->pending.signal, SIGBUS);
-	recalc_sigpending();
-	current->flags |= PF_SIGNALED;
-	do_exit(SIGBUS | 0x80);
-}
-
-void dump_thread(struct pt_regs *regs, struct user *u)
-{
-}
-
-void enable_hlt(void)
-{
-	panic("enable_hlt");
-}
-
-EXPORT_SYMBOL(enable_hlt);
-
-void disable_hlt(void)
-{
-	panic("disable_hlt");
-}
-
-EXPORT_SYMBOL(disable_hlt);
-
-void *um_kmalloc(int size)
-{
-	return kmalloc(size, GFP_KERNEL);
-}
-
-void *um_kmalloc_atomic(int size)
-{
-	return kmalloc(size, GFP_ATOMIC);
-}
-
-void *um_vmalloc(int size)
-{
-	return vmalloc(size);
-}
-
-void *um_vmalloc_atomic(int size)
-{
-	return __vmalloc(size, GFP_ATOMIC | __GFP_HIGHMEM, PAGE_KERNEL);
-}
-
-int __cant_sleep(void) {
-	return in_atomic() || irqs_disabled() || in_interrupt();
-	/* Is in_interrupt() really needed? */
-}
-
-unsigned long get_fault_addr(void)
-{
-	return((unsigned long) current->thread.fault_addr);
-}
-
-EXPORT_SYMBOL(get_fault_addr);
-
-void not_implemented(void)
-{
-	printk(KERN_DEBUG "Something isn't implemented in here\n");
-}
-
-EXPORT_SYMBOL(not_implemented);
-
-int user_context(unsigned long sp)
-{
-	unsigned long stack;
-
-	stack = sp & (PAGE_MASK << CONFIG_KERNEL_STACK_ORDER);
-	return(stack != (unsigned long) current_thread);
-}
-
-extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
-
-void do_uml_exitcalls(void)
-{
-	exitcall_t *call;
-
-	call = &__uml_exitcall_end;
-	while (--call >= &__uml_exitcall_begin)
-		(*call)();
-}
-
-char *uml_strdup(char *string)
-{
-	return kstrdup(string, GFP_KERNEL);
-}
-
-int copy_to_user_proc(void __user *to, void *from, int size)
-{
-	return(copy_to_user(to, from, size));
-}
-
-int copy_from_user_proc(void *to, void __user *from, int size)
-{
-	return(copy_from_user(to, from, size));
-}
-
-int clear_user_proc(void __user *buf, int size)
-{
-	return(clear_user(buf, size));
-}
-
-int strlen_user_proc(char __user *str)
-{
-	return(strlen_user(str));
-}
-
-int smp_sigio_handler(void)
-{
-#ifdef CONFIG_SMP
-	int cpu = current_thread->cpu;
-	IPI_handler(cpu);
-	if(cpu != 0)
-		return(1);
-#endif
-	return(0);
-}
-
-int cpu(void)
-{
-	return(current_thread->cpu);
-}
-
-static atomic_t using_sysemu = ATOMIC_INIT(0);
-int sysemu_supported;
-
-void set_using_sysemu(int value)
-{
-	if (value > sysemu_supported)
-		return;
-	atomic_set(&using_sysemu, value);
-}
-
-int get_using_sysemu(void)
-{
-	return atomic_read(&using_sysemu);
-}
-
-static int proc_read_sysemu(char *buf, char **start, off_t offset, int size,int *eof, void *data)
-{
-	if (snprintf(buf, size, "%d\n", get_using_sysemu()) < size) /*No overflow*/
-		*eof = 1;
-
-	return strlen(buf);
-}
-
-static int proc_write_sysemu(struct file *file,const char __user *buf, unsigned long count,void *data)
-{
-	char tmp[2];
-
-	if (copy_from_user(tmp, buf, 1))
-		return -EFAULT;
-
-	if (tmp[0] >= '0' && tmp[0] <= '2')
-		set_using_sysemu(tmp[0] - '0');
-	return count; /*We use the first char, but pretend to write everything*/
-}
-
-int __init make_proc_sysemu(void)
-{
-	struct proc_dir_entry *ent;
-	if (!sysemu_supported)
-		return 0;
-
-	ent = create_proc_entry("sysemu", 0600, &proc_root);
-
-	if (ent == NULL)
-	{
-		printk(KERN_WARNING "Failed to register /proc/sysemu\n");
-		return(0);
-	}
-
-	ent->read_proc  = proc_read_sysemu;
-	ent->write_proc = proc_write_sysemu;
-
-	return 0;
-}
-
-late_initcall(make_proc_sysemu);
-
-int singlestepping(void * t)
-{
-	struct task_struct *task = t ? t : current;
-
-	if ( ! (task->ptrace & PT_DTRACE) )
-		return(0);
-
-	if (task->thread.singlestep_syscall)
-		return(1);
-
-	return 2;
-}
-
-/*
- * Only x86 and x86_64 have an arch_align_stack().
- * All other arches have "#define arch_align_stack(x) (x)"
- * in their asm/system.h
- * As this is included in UML from asm-um/system-generic.h,
- * we can use it to behave as the subarch does.
- */
-#ifndef arch_align_stack
-unsigned long arch_align_stack(unsigned long sp)
-{
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
-		sp -= get_random_int() % 8192;
-	return sp & ~0xf;
-}
-#endif
Index: linux-2.6.18-mm/arch/um/kernel/skas/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/skas/Makefile	2006-09-22 09:16:00.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/skas/Makefile	2006-09-22 09:56:51.000000000 -0400
@@ -3,8 +3,7 @@
 # Licensed under the GPL
 #
 
-obj-y := clone.o exec_kern.o mem.o mmu.o process_kern.o \
-	syscall.o tlb.o uaccess.o
+obj-y := clone.o exec.o mem.o mmu.o process.o syscall.o tlb.o uaccess.o
 
 # clone.o is in the stub, so it can't be built with profiling
 # GCC hardened also auto-enables -fpic, but we need %ebx so it can't work ->
Index: linux-2.6.18-mm/arch/um/kernel/skas/exec.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/kernel/skas/exec.c	2006-09-22 10:08:28.000000000 -0400
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/kernel.h"
+#include "asm/current.h"
+#include "asm/page.h"
+#include "asm/signal.h"
+#include "asm/ptrace.h"
+#include "asm/uaccess.h"
+#include "asm/mmu_context.h"
+#include "tlb.h"
+#include "skas.h"
+#include "um_mmu.h"
+#include "os.h"
+
+void flush_thread_skas(void)
+{
+	force_flush_all();
+	switch_mm_skas(&current->mm->context.skas.id);
+}
+
+void start_thread_skas(struct pt_regs *regs, unsigned long eip,
+		       unsigned long esp)
+{
+	set_fs(USER_DS);
+	PT_REGS_IP(regs) = eip;
+	PT_REGS_SP(regs) = esp;
+}
Index: linux-2.6.18-mm/arch/um/kernel/skas/exec_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/skas/exec_kern.c	2006-09-22 09:16:00.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,41 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/kernel.h"
-#include "asm/current.h"
-#include "asm/page.h"
-#include "asm/signal.h"
-#include "asm/ptrace.h"
-#include "asm/uaccess.h"
-#include "asm/mmu_context.h"
-#include "tlb.h"
-#include "skas.h"
-#include "um_mmu.h"
-#include "os.h"
-
-void flush_thread_skas(void)
-{
-	force_flush_all();
-        switch_mm_skas(&current->mm->context.skas.id);
-}
-
-void start_thread_skas(struct pt_regs *regs, unsigned long eip, 
-		       unsigned long esp)
-{
-	set_fs(USER_DS);
-        PT_REGS_IP(regs) = eip;
-	PT_REGS_SP(regs) = esp;
-}
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
Index: linux-2.6.18-mm/arch/um/kernel/skas/process.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/kernel/skas/process.c	2006-09-22 10:08:13.000000000 -0400
@@ -0,0 +1,217 @@
+/*
+ * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include "linux/sched.h"
+#include "linux/slab.h"
+#include "linux/ptrace.h"
+#include "linux/proc_fs.h"
+#include "linux/file.h"
+#include "linux/errno.h"
+#include "linux/init.h"
+#include "asm/uaccess.h"
+#include "asm/atomic.h"
+#include "kern_util.h"
+#include "skas.h"
+#include "os.h"
+#include "user_util.h"
+#include "tlb.h"
+#include "kern.h"
+#include "mode.h"
+#include "registers.h"
+
+void switch_to_skas(void *prev, void *next)
+{
+	struct task_struct *from, *to;
+
+	from = prev;
+	to = next;
+
+	/* XXX need to check runqueues[cpu].idle */
+	if(current->pid == 0)
+		switch_timers(0);
+
+	switch_threads(&from->thread.mode.skas.switch_buf,
+		       &to->thread.mode.skas.switch_buf);
+
+	arch_switch_to_skas(current->thread.prev_sched, current);
+
+	if(current->pid == 0)
+		switch_timers(1);
+}
+
+extern void schedule_tail(struct task_struct *prev);
+
+/* This is called magically, by its address being stuffed in a jmp_buf
+ * and being longjmp-d to.
+ */
+void new_thread_handler(void)
+{
+	int (*fn)(void *), n;
+	void *arg;
+
+	if(current->thread.prev_sched != NULL)
+		schedule_tail(current->thread.prev_sched);
+	current->thread.prev_sched = NULL;
+
+	fn = current->thread.request.u.thread.proc;
+	arg = current->thread.request.u.thread.arg;
+
+	/* The return value is 1 if the kernel thread execs a process,
+	 * 0 if it just exits
+	 */
+	n = run_kernel_thread(fn, arg, &current->thread.exec_buf);
+	if(n == 1){
+		/* Handle any immediate reschedules or signals */
+		interrupt_end();
+		userspace(&current->thread.regs.regs);
+	}
+	else do_exit(0);
+}
+
+void release_thread_skas(struct task_struct *task)
+{
+}
+
+/* Called magically, see new_thread_handler above */
+void fork_handler(void)
+{
+	force_flush_all();
+	if(current->thread.prev_sched == NULL)
+		panic("blech");
+
+	schedule_tail(current->thread.prev_sched);
+
+	/* XXX: if interrupt_end() calls schedule, this call to
+	 * arch_switch_to_skas isn't needed. We could want to apply this to
+	 * improve performance. -bb */
+	arch_switch_to_skas(current->thread.prev_sched, current);
+
+	current->thread.prev_sched = NULL;
+
+/* Handle any immediate reschedules or signals */
+	interrupt_end();
+
+	userspace(&current->thread.regs.regs);
+}
+
+int copy_thread_skas(int nr, unsigned long clone_flags, unsigned long sp,
+		     unsigned long stack_top, struct task_struct * p,
+		     struct pt_regs *regs)
+{
+	void (*handler)(void);
+
+	if(current->thread.forking){
+	  	memcpy(&p->thread.regs.regs.skas, &regs->regs.skas,
+		       sizeof(p->thread.regs.regs.skas));
+		REGS_SET_SYSCALL_RETURN(p->thread.regs.regs.skas.regs, 0);
+		if(sp != 0) REGS_SP(p->thread.regs.regs.skas.regs) = sp;
+
+		handler = fork_handler;
+
+		arch_copy_thread(&current->thread.arch, &p->thread.arch);
+	}
+	else {
+		init_thread_registers(&p->thread.regs.regs);
+		p->thread.request.u.thread = current->thread.request.u.thread;
+		handler = new_thread_handler;
+	}
+
+	new_thread(task_stack_page(p), &p->thread.mode.skas.switch_buf,
+		   handler);
+	return(0);
+}
+
+int new_mm(unsigned long stack)
+{
+	int fd;
+
+	fd = os_open_file("/proc/mm", of_cloexec(of_write(OPENFLAGS())), 0);
+	if(fd < 0)
+		return(fd);
+
+	if(skas_needs_stub)
+		map_stub_pages(fd, CONFIG_STUB_CODE, CONFIG_STUB_DATA, stack);
+
+	return(fd);
+}
+
+void init_idle_skas(void)
+{
+	cpu_tasks[current_thread->cpu].pid = os_getpid();
+	default_idle();
+}
+
+extern void start_kernel(void);
+
+static int start_kernel_proc(void *unused)
+{
+	int pid;
+
+	block_signals();
+	pid = os_getpid();
+
+	cpu_tasks[0].pid = pid;
+	cpu_tasks[0].task = current;
+#ifdef CONFIG_SMP
+	cpu_online_map = cpumask_of_cpu(0);
+#endif
+	start_kernel();
+	return(0);
+}
+
+extern int userspace_pid[];
+
+int start_uml_skas(void)
+{
+	if(proc_mm)
+		userspace_pid[0] = start_userspace(0);
+
+	init_new_thread_signals();
+
+	init_task.thread.request.u.thread.proc = start_kernel_proc;
+	init_task.thread.request.u.thread.arg = NULL;
+	return(start_idle_thread(task_stack_page(&init_task),
+				 &init_task.thread.mode.skas.switch_buf));
+}
+
+int external_pid_skas(struct task_struct *task)
+{
+#warning Need to look up userspace_pid by cpu
+	return(userspace_pid[0]);
+}
+
+int thread_pid_skas(struct task_struct *task)
+{
+#warning Need to look up userspace_pid by cpu
+	return(userspace_pid[0]);
+}
+
+void kill_off_processes_skas(void)
+{
+	if(proc_mm)
+#warning need to loop over userspace_pids in kill_off_processes_skas
+		os_kill_ptraced_process(userspace_pid[0], 1);
+	else {
+		struct task_struct *p;
+		int pid, me;
+
+		me = os_getpid();
+		for_each_process(p){
+			if(p->mm == NULL)
+				continue;
+
+			pid = p->mm->context.skas.id.u.pid;
+			os_kill_ptraced_process(pid, 1);
+		}
+	}
+}
+
+unsigned long current_stub_stack(void)
+{
+	if(current->mm == NULL)
+		return(0);
+
+	return(current->mm->context.skas.id.stack);
+}
Index: linux-2.6.18-mm/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/skas/process_kern.c	2006-09-22 09:51:26.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,217 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include "linux/sched.h"
-#include "linux/slab.h"
-#include "linux/ptrace.h"
-#include "linux/proc_fs.h"
-#include "linux/file.h"
-#include "linux/errno.h"
-#include "linux/init.h"
-#include "asm/uaccess.h"
-#include "asm/atomic.h"
-#include "kern_util.h"
-#include "skas.h"
-#include "os.h"
-#include "user_util.h"
-#include "tlb.h"
-#include "kern.h"
-#include "mode.h"
-#include "registers.h"
-
-void switch_to_skas(void *prev, void *next)
-{
-	struct task_struct *from, *to;
-
-	from = prev;
-	to = next;
-
-	/* XXX need to check runqueues[cpu].idle */
-	if(current->pid == 0)
-		switch_timers(0);
-
-	switch_threads(&from->thread.mode.skas.switch_buf,
-		       &to->thread.mode.skas.switch_buf);
-
-	arch_switch_to_skas(current->thread.prev_sched, current);
-
-	if(current->pid == 0)
-		switch_timers(1);
-}
-
-extern void schedule_tail(struct task_struct *prev);
-
-/* This is called magically, by its address being stuffed in a jmp_buf
- * and being longjmp-d to.
- */
-void new_thread_handler(void)
-{
-	int (*fn)(void *), n;
-	void *arg;
-
-	if(current->thread.prev_sched != NULL)
-		schedule_tail(current->thread.prev_sched);
-	current->thread.prev_sched = NULL;
-
-	fn = current->thread.request.u.thread.proc;
-	arg = current->thread.request.u.thread.arg;
-
-	/* The return value is 1 if the kernel thread execs a process,
-	 * 0 if it just exits
-	 */
-	n = run_kernel_thread(fn, arg, &current->thread.exec_buf);
-	if(n == 1){
-		/* Handle any immediate reschedules or signals */
-		interrupt_end();
-		userspace(&current->thread.regs.regs);
-	}
-	else do_exit(0);
-}
-
-void release_thread_skas(struct task_struct *task)
-{
-}
-
-/* Called magically, see new_thread_handler above */
-void fork_handler(void)
-{
-	force_flush_all();
-	if(current->thread.prev_sched == NULL)
-		panic("blech");
-
-	schedule_tail(current->thread.prev_sched);
-
-	/* XXX: if interrupt_end() calls schedule, this call to
-	 * arch_switch_to_skas isn't needed. We could want to apply this to
-	 * improve performance. -bb */
-	arch_switch_to_skas(current->thread.prev_sched, current);
-
-	current->thread.prev_sched = NULL;
-
-/* Handle any immediate reschedules or signals */
-	interrupt_end();
-
-	userspace(&current->thread.regs.regs);
-}
-
-int copy_thread_skas(int nr, unsigned long clone_flags, unsigned long sp,
-		     unsigned long stack_top, struct task_struct * p,
-		     struct pt_regs *regs)
-{
-  	void (*handler)(void);
-
-	if(current->thread.forking){
-	  	memcpy(&p->thread.regs.regs.skas, &regs->regs.skas,
-		       sizeof(p->thread.regs.regs.skas));
-		REGS_SET_SYSCALL_RETURN(p->thread.regs.regs.skas.regs, 0);
-		if(sp != 0) REGS_SP(p->thread.regs.regs.skas.regs) = sp;
-
-		handler = fork_handler;
-
-		arch_copy_thread(&current->thread.arch, &p->thread.arch);
-	}
-	else {
-		init_thread_registers(&p->thread.regs.regs);
-                p->thread.request.u.thread = current->thread.request.u.thread;
-		handler = new_thread_handler;
-	}
-
-	new_thread(task_stack_page(p), &p->thread.mode.skas.switch_buf,
-		   handler);
-	return(0);
-}
-
-int new_mm(unsigned long stack)
-{
-	int fd;
-
-	fd = os_open_file("/proc/mm", of_cloexec(of_write(OPENFLAGS())), 0);
-	if(fd < 0)
-		return(fd);
-
-	if(skas_needs_stub)
-		map_stub_pages(fd, CONFIG_STUB_CODE, CONFIG_STUB_DATA, stack);
-
-	return(fd);
-}
-
-void init_idle_skas(void)
-{
-	cpu_tasks[current_thread->cpu].pid = os_getpid();
-	default_idle();
-}
-
-extern void start_kernel(void);
-
-static int start_kernel_proc(void *unused)
-{
-	int pid;
-
-	block_signals();
-	pid = os_getpid();
-
-	cpu_tasks[0].pid = pid;
-	cpu_tasks[0].task = current;
-#ifdef CONFIG_SMP
- 	cpu_online_map = cpumask_of_cpu(0);
-#endif
-	start_kernel();
-	return(0);
-}
-
-extern int userspace_pid[];
-
-int start_uml_skas(void)
-{
-	if(proc_mm)
-		userspace_pid[0] = start_userspace(0);
-
-	init_new_thread_signals();
-
-	init_task.thread.request.u.thread.proc = start_kernel_proc;
-	init_task.thread.request.u.thread.arg = NULL;
-	return(start_idle_thread(task_stack_page(&init_task),
-				 &init_task.thread.mode.skas.switch_buf));
-}
-
-int external_pid_skas(struct task_struct *task)
-{
-#warning Need to look up userspace_pid by cpu
-	return(userspace_pid[0]);
-}
-
-int thread_pid_skas(struct task_struct *task)
-{
-#warning Need to look up userspace_pid by cpu
-	return(userspace_pid[0]);
-}
-
-void kill_off_processes_skas(void)
-{
-	if(proc_mm)
-#warning need to loop over userspace_pids in kill_off_processes_skas
-		os_kill_ptraced_process(userspace_pid[0], 1);
-	else {
-		struct task_struct *p;
-		int pid, me;
-
-		me = os_getpid();
-		for_each_process(p){
-			if(p->mm == NULL)
-				continue;
-
-			pid = p->mm->context.skas.id.u.pid;
-			os_kill_ptraced_process(pid, 1);
-		}
-	}
-}
-
-unsigned long current_stub_stack(void)
-{
-	if(current->mm == NULL)
-		return(0);
-
-	return(current->mm->context.skas.id.stack);
-}

