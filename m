Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278500AbRJPCXI>; Mon, 15 Oct 2001 22:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278502AbRJPCXD>; Mon, 15 Oct 2001 22:23:03 -0400
Received: from zok.sgi.com ([204.94.215.101]:671 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S278500AbRJPCWq>;
	Mon, 15 Oct 2001 22:22:46 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.4.13-pre3 arm/i386/mips/mips64/s390/s390x/sh die() deadlock
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Oct 2001 12:23:08 +1000
Message-ID: <18579.1003198988@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any die() routine that uses die_lock to avoid multiple cpu reentrancy
will deadlock on recursive die() errors.  This patch only affects the
architectures that use die_lock and only if the code is in Linus's
tree.

I have not looked at the arch CVS trees so other architectures may
still have problems, please check.  Several architectures have no
protection against multiple cpu reentrancy in die(), I left those
alone.

mips, mips64 and sh had uninitialized spinlock_t die_lock, naughty, it
breaks spin lock debugging.  Any other uninitialized spinlock_t lying
around in those trees?

Most of the patch is white space changes due to new indentation.
Speaking of white space, s390/s390x has a lot of leading spaces instead
of tabs, did somebody code on an 026 card punch ;)?  A white space
clean up on s390/s390x would be nice.

Patch against 2.4.13-pre3.  Compiled on i386, eyeballed (using IEHIBALL
on s390) but untested on other arch.

Index: 13-pre3.1/arch/arm/kernel/traps.c
--- 13-pre3.1/arch/arm/kernel/traps.c Fri, 12 Oct 2001 11:40:38 +1000 kaos (linux-2.4/w/c/46_traps.c 1.3.1.2.1.1 644)
+++ 13-pre3.1(w)/arch/arm/kernel/traps.c Tue, 16 Oct 2001 12:03:28 +1000 kaos (linux-2.4/w/c/46_traps.c 1.3.1.2.1.1 644)
@@ -159,43 +159,49 @@ void show_trace_task(struct task_struct 
 	}
 }
 
-spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
-
-/*
- * This function is protected against re-entrancy.
- */
 NORET_TYPE void die(const char *str, struct pt_regs *regs, int err)
 {
+	static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+	static int die_lock_owner = -1, die_lock_owner_depth;
 	struct task_struct *tsk = current;
 
-	console_verbose();
-	spin_lock_irq(&die_lock);
+	if (die_lock_owner != smp_processor_id()) {
+		console_verbose();
+		spin_lock_irq(&die_lock);
+		die_lock_owner = smp_processor_id();
+		die_lock_owner_depth = 0;
+	}
 
-	printk("Internal error: %s: %x\n", str, err);
-	printk("CPU: %d\n", smp_processor_id());
-	show_regs(regs);
-	printk("Process %s (pid: %d, stackpage=%08lx)\n",
-		current->comm, current->pid, 4096+(unsigned long)tsk);
-
-	if (!user_mode(regs) || in_interrupt()) {
-		mm_segment_t fs;
-
-		/*
-		 * We need to switch to kernel mode so that we can
-		 * use __get_user to safely read from kernel space.
-		 * Note that we now dump the code first, just in case
-		 * the backtrace kills us.
-		 */
-		fs = get_fs();
-		set_fs(KERNEL_DS);
-
-		dump_stack(tsk, (unsigned long)(regs + 1));
-		dump_backtrace(regs, tsk);
-		dump_instr(regs);
+	if (++die_lock_owner_depth < 3) {
+		printk("Internal error: %s: %x\n", str, err);
+		printk("CPU: %d\n", smp_processor_id());
+		show_regs(regs);
+		printk("Process %s (pid: %d, stackpage=%08lx)\n",
+			current->comm, current->pid, 4096+(unsigned long)tsk);
+
+		if (!user_mode(regs) || in_interrupt()) {
+			mm_segment_t fs;
+
+			/*
+			 * We need to switch to kernel mode so that we can
+			 * use __get_user to safely read from kernel space.
+			 * Note that we now dump the code first, just in case
+			 * the backtrace kills us.
+			 */
+			fs = get_fs();
+			set_fs(KERNEL_DS);
+
+			dump_stack(tsk, (unsigned long)(regs + 1));
+			dump_backtrace(regs, tsk);
+			dump_instr(regs);
 
-		set_fs(fs);
+			set_fs(fs);
+		}
 	}
+	else
+		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
 
+	die_lock_owner = -1;
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
 }
Index: 13-pre3.1/arch/i386/kernel/traps.c
--- 13-pre3.1/arch/i386/kernel/traps.c Tue, 02 Oct 2001 11:04:33 +1000 kaos (linux-2.4/S/c/22_traps.c 1.1.2.1.1.2.1.1.1.6 644)
+++ 13-pre3.1(w)/arch/i386/kernel/traps.c Tue, 16 Oct 2001 11:34:27 +1000 kaos (linux-2.4/S/c/22_traps.c 1.1.2.1.1.2.1.1.1.6 644)
@@ -237,16 +237,28 @@ bad:
 	printk("\n");
 }	
 
-spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
-
 void die(const char * str, struct pt_regs * regs, long err)
 {
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-	printk("%s: %04lx\n", str, err & 0xffff);
-	show_registers(regs);
+	static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+	static int die_lock_owner = -1, die_lock_owner_depth;
+
+	if (die_lock_owner != smp_processor_id()) {
+		console_verbose();
+		spin_lock_irq(&die_lock);
+		die_lock_owner = smp_processor_id();
+		die_lock_owner_depth = 0;
+		bust_spinlocks(1);
+	}
+
+	if (++die_lock_owner_depth < 3) {
+		printk("%s: %04lx\n", str, err & 0xffff);
+		show_registers(regs);
+	}
+	else
+		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
+
 	bust_spinlocks(0);
+	die_lock_owner = -1;
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
 }
Index: 13-pre3.1/arch/mips64/kernel/traps.c
--- 13-pre3.1/arch/mips64/kernel/traps.c Mon, 10 Sep 2001 15:46:51 +1000 kaos (linux-2.4/p/c/5_traps.c 1.1.1.1.1.1 644)
+++ 13-pre3.1(w)/arch/mips64/kernel/traps.c Tue, 16 Oct 2001 11:42:23 +1000 kaos (linux-2.4/p/c/5_traps.c 1.1.1.1.1.1 644)
@@ -159,23 +159,35 @@ void show_code(unsigned int *pc)
 	}
 }
 
-spinlock_t die_lock;
-
 void die(const char * str, struct pt_regs * regs, unsigned long err)
 {
+	static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+	static int die_lock_owner = -1, die_lock_owner_depth;
+
 	if (user_mode(regs))	/* Just return if in user mode.  */
 		return;
 
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	printk("%s: %04lx\n", str, err & 0xffff);
-	show_regs(regs);
-	printk("Process %s (pid: %d, stackpage=%08lx)\n",
-		current->comm, current->pid, (unsigned long) current);
-	show_stack((unsigned long *) regs->regs[29]);
-	show_trace((unsigned long *) regs->regs[29]);
-	show_code((unsigned int *) regs->cp0_epc);
-	printk("\n");
+	if (die_lock_owner != smp_processor_id()) {
+		console_verbose();
+		spin_lock_irq(&die_lock);
+		die_lock_owner = smp_processor_id();
+		die_lock_owner_depth = 0;
+	}
+
+	if (++die_lock_owner_depth < 3) {
+		printk("%s: %04lx\n", str, err & 0xffff);
+		show_regs(regs);
+		printk("Process %s (pid: %d, stackpage=%08lx)\n",
+			current->comm, current->pid, (unsigned long) current);
+		show_stack((unsigned long *) regs->regs[29]);
+		show_trace((unsigned long *) regs->regs[29]);
+		show_code((unsigned int *) regs->cp0_epc);
+		printk("\n");
+	}
+	else
+		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
+
+	die_lock_owner = -1;
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
 }
Index: 13-pre3.1/arch/mips/kernel/traps.c
--- 13-pre3.1/arch/mips/kernel/traps.c Mon, 10 Sep 2001 15:46:51 +1000 kaos (linux-2.4/M/c/26_traps.c 1.1.2.1.1.1.1.1 644)
+++ 13-pre3.1(w)/arch/mips/kernel/traps.c Tue, 16 Oct 2001 11:38:52 +1000 kaos (linux-2.4/M/c/26_traps.c 1.1.2.1.1.1.1.1 644)
@@ -188,24 +188,36 @@ void show_code(unsigned int *pc)
 	}
 }
 
-spinlock_t die_lock;
-
 extern void __die(const char * str, struct pt_regs * regs, const char *where,
                   unsigned long line)
 {
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	printk("%s", str);
-	if (where)
-		printk(" in %s, line %ld", where, line);
-	printk(":\n");
-	show_regs(regs);
-	printk("Process %s (pid: %d, stackpage=%08lx)\n",
-		current->comm, current->pid, (unsigned long) current);
-	show_stack((unsigned int *) regs->regs[29]);
-	show_trace((unsigned int *) regs->regs[29]);
-	show_code((unsigned int *) regs->cp0_epc);
-	printk("\n");
+	static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+	static int die_lock_owner = -1, die_lock_owner_depth;
+
+	if (die_lock_owner != smp_processor_id()) {
+		console_verbose();
+		spin_lock_irq(&die_lock);
+		die_lock_owner = smp_processor_id();
+		die_lock_owner_depth = 0;
+	}
+
+	if (++die_lock_owner_depth < 3) {
+		printk("%s", str);
+		if (where)
+			printk(" in %s, line %ld", where, line);
+		printk(":\n");
+		show_regs(regs);
+		printk("Process %s (pid: %d, stackpage=%08lx)\n",
+			current->comm, current->pid, (unsigned long) current);
+		show_stack((unsigned int *) regs->regs[29]);
+		show_trace((unsigned int *) regs->regs[29]);
+		show_code((unsigned int *) regs->cp0_epc);
+		printk("\n");
+	}
+	else
+		printk(KERN_ERR "Recursive __die() failure, output suppressed\n");
+
+	die_lock_owner = -1;
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
 }
Index: 13-pre3.1/arch/s390/kernel/traps.c
--- 13-pre3.1/arch/s390/kernel/traps.c Fri, 12 Oct 2001 11:40:38 +1000 kaos (linux-2.4/n/c/8_traps.c 1.4.1.1 644)
+++ 13-pre3.1(w)/arch/s390/kernel/traps.c Tue, 16 Oct 2001 11:54:35 +1000 kaos (linux-2.4/n/c/8_traps.c 1.4.1.1 644)
@@ -60,18 +60,30 @@ extern void pfault_fini(void);
 extern void pfault_interrupt(struct pt_regs *regs, __u16 error_code);
 #endif
 
-spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
-
 void die(const char * str, struct pt_regs * regs, long err)
 {
-        console_verbose();
-        spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-        printk("%s: %04lx\n", str, err & 0xffff);
-        show_regs(regs);
+	static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+	static int die_lock_owner = -1, die_lock_owner_depth;
+
+	if (die_lock_owner != smp_processor_id()) {
+		console_verbose();
+		spin_lock_irq(&die_lock);
+		die_lock_owner = smp_processor_id();
+		die_lock_owner_depth = 0;
+		bust_spinlocks(1);
+	}
+
+	if (++die_lock_owner_depth < 3) {
+		printk("%s: %04lx\n", str, err & 0xffff);
+		show_regs(regs);
+	}
+	else
+		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
+
 	bust_spinlocks(0);
-        spin_unlock_irq(&die_lock);
-        do_exit(SIGSEGV);
+	die_lock_owner = -1;
+	spin_unlock_irq(&die_lock);
+	do_exit(SIGSEGV);
 }
 
 #define DO_ERROR(signr, str, name) \
Index: 13-pre3.1/arch/s390x/kernel/traps.c
--- 13-pre3.1/arch/s390x/kernel/traps.c Fri, 12 Oct 2001 11:40:38 +1000 kaos (linux-2.4/p/d/19_traps.c 1.2.1.1 644)
+++ 13-pre3.1(w)/arch/s390x/kernel/traps.c Tue, 16 Oct 2001 11:54:45 +1000 kaos (linux-2.4/p/d/19_traps.c 1.2.1.1 644)
@@ -58,18 +58,30 @@ extern void pfault_fini(void);
 extern void pfault_interrupt(struct pt_regs *regs, __u16 error_code);
 #endif
 
-spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
-
 void die(const char * str, struct pt_regs * regs, long err)
 {
-        console_verbose();
-        spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-        printk("%s: %04lx\n", str, err & 0xffff);
-        show_regs(regs);
+	static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+	static int die_lock_owner = -1, die_lock_owner_depth;
+
+	if (die_lock_owner != smp_processor_id()) {
+		console_verbose();
+		spin_lock_irq(&die_lock);
+		die_lock_owner = smp_processor_id();
+		die_lock_owner_depth = 0;
+		bust_spinlocks(1);
+	}
+
+	if (++die_lock_owner_depth < 3) {
+		printk("%s: %04lx\n", str, err & 0xffff);
+		show_regs(regs);
+	}
+	else
+		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
+
 	bust_spinlocks(0);
-        spin_unlock_irq(&die_lock);
-        do_exit(SIGSEGV);
+	die_lock_owner = -1;
+	spin_unlock_irq(&die_lock);
+	do_exit(SIGSEGV);
 }
 
 #define DO_ERROR(signr, str, name) \
Index: 13-pre3.1/arch/sh/kernel/traps.c
--- 13-pre3.1/arch/sh/kernel/traps.c Sun, 09 Sep 2001 19:22:07 +1000 kaos (linux-2.4/t/c/26_traps.c 1.4 644)
+++ 13-pre3.1(w)/arch/sh/kernel/traps.c Tue, 16 Oct 2001 11:51:17 +1000 kaos (linux-2.4/t/c/26_traps.c 1.4 644)
@@ -54,14 +54,26 @@ asmlinkage void do_##name(unsigned long 
 #define VMALLOC_OFFSET (8*1024*1024)
 #define MODULE_RANGE (8*1024*1024)
 
-spinlock_t die_lock;
-
 void die(const char * str, struct pt_regs * regs, long err)
 {
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	printk("%s: %04lx\n", str, err & 0xffff);
-	show_regs(regs);
+	static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+	static int die_lock_owner = -1, die_lock_owner_depth;
+
+	if (die_lock_owner != smp_processor_id()) {
+		console_verbose();
+		spin_lock_irq(&die_lock);
+		die_lock_owner = smp_processor_id();
+		die_lock_owner_depth = 0;
+	}
+
+	if (++die_lock_owner_depth < 3) {
+		printk("%s: %04lx\n", str, err & 0xffff);
+		show_regs(regs);
+	}
+	else
+		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
+
+	die_lock_owner = -1;
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
 }

