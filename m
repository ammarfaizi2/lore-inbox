Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264214AbRFXNe1>; Sun, 24 Jun 2001 09:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264229AbRFXNeS>; Sun, 24 Jun 2001 09:34:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49168 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264214AbRFXNeA>;
	Sun, 24 Jun 2001 09:34:00 -0400
Date: Sun, 24 Jun 2001 14:33:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch: ARM show_trace_task and show_task cleanup
Message-ID: <20010624143356.J29636@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

(CC:'d to lkml in case someone wants to object to the show_task() cleanup;
Alan has accepted it many -ac versions ago into his tree, and is happy for
me to send it on).

The following patch adds ARM support for show_trace_task() and changes
die() to display the instruction trace as ksymoops expects it (code
line last).

In addition, it cleans up show_task so that the displayed data is aligned
with the header that show_state displays:

1. We have some kernel tasks with more than 8 characters in their name.
2. Lazy-TLB state is shown at the end of each line, not in the middle of
   the PID lists.

diff -urN linux-orig/arch/arm/kernel/traps.c linux/arch/arm/kernel/traps.c
--- linux-orig/arch/arm/kernel/traps.c	Thu Feb 22 11:24:58 2001
+++ linux/arch/arm/kernel/traps.c	Thu Jun 21 11:54:53 2001
@@ -20,6 +20,7 @@
 #include <linux/mm.h>
 #include <linux/spinlock.h>
 #include <linux/ptrace.h>
+#include <linux/elf.h>
 #include <linux/init.h>
 
 #include <asm/atomic.h>
@@ -27,6 +28,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 #include "ptrace.h"
 
@@ -143,6 +145,18 @@
 		c_backtrace(fp, processor_mode(regs));
 }
 
+/*
+ * This is called from SysRq-T (show_task) to display the current
+ * call trace for each process.  Very useful.
+ */
+void show_trace_task(struct task_struct *tsk)
+{
+	if (tsk != current) {
+		unsigned int fp = tsk->thread.save->fp;
+		c_backtrace(fp, 0x10);
+	}
+}
+
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
 /*
@@ -173,9 +187,9 @@
 		fs = get_fs();
 		set_fs(KERNEL_DS);
 
-		dump_instr(regs);
 		dump_stack(tsk, (unsigned long)(regs + 1));
 		dump_backtrace(regs, tsk);
+		dump_instr(regs);
 
 		set_fs(fs);
 	}
diff -urN linux-orig/kernel/sched.c linux/kernel/sched.c
--- linux-orig/kernel/sched.c	Sun May 20 15:09:47 2001
+++ linux/kernel/sched.c	Sun Jun 10 19:58:42 2001
@@ -1104,7 +1104,7 @@
 	int state;
 	static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };
 
-	printk("%-8s  ", p->comm);
+	printk("%-13.13s ", p->comm);
 	state = p->state ? ffz(~p->state) + 1 : 0;
 	if (((unsigned) state) < sizeof(stat_nam)/sizeof(char *))
 		printk(stat_nam[state]);
@@ -1132,20 +1132,20 @@
 		printk("%5d ", p->p_cptr->pid);
 	else
 		printk("      ");
-	if (!p->mm)
-		printk(" (L-TLB) ");
-	else
-		printk(" (NOTLB) ");
 	if (p->p_ysptr)
 		printk("%7d", p->p_ysptr->pid);
 	else
 		printk("       ");
 	if (p->p_osptr)
-		printk(" %5d\n", p->p_osptr->pid);
+		printk(" %5d", p->p_osptr->pid);
+	else
+		printk("      ");
+	if (!p->mm)
+		printk(" (L-TLB)\n");
 	else
-		printk("\n");
+		printk(" (NOTLB)\n");
 
-#if defined(CONFIG_X86) || defined(CONFIG_SPARC64)
+#if defined(CONFIG_X86) || defined(CONFIG_SPARC64) || defined(CONFIG_ARM)
 /* This is very useful, but only works on x86 and sparc64 right now */
 	{
 		extern void show_trace_task(struct task_struct *tsk);



--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

