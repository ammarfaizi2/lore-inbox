Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbRFXOTr>; Sun, 24 Jun 2001 10:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRFXOTh>; Sun, 24 Jun 2001 10:19:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62481 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262614AbRFXOT3>;
	Sun, 24 Jun 2001 10:19:29 -0400
Date: Sun, 24 Jun 2001 15:19:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: ARM show_trace_task and show_task cleanup
Message-ID: <20010624151925.K29636@flint.arm.linux.org.uk>
In-Reply-To: <20010624143356.J29636@flint.arm.linux.org.uk> <21595.993390483@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <21595.993390483@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Jun 24, 2001 at 11:48:03PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 11:48:03PM +1000, Keith Owens wrote:
> On Sun, 24 Jun 2001 14:33:56 +0100, 
> Russell King <rmk@arm.linux.org.uk> wrote:
> >-#if defined(CONFIG_X86) || defined(CONFIG_SPARC64)
> >+#if defined(CONFIG_X86) || defined(CONFIG_SPARC64) || defined(CONFIG_ARM)
> > /* This is very useful, but only works on x86 and sparc64 right now */
> 
> <nitpick>Comment needs updating</nitpick>

Here's a new patch to keep the nitpickers quiet. ;)

Linus,

Please disregard the previous patch if you haven't applied it already and
apply this one instead; if you have applied it, then I'll wait for the next
pre-patch and send a new diff.

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
 
@@ -143,12 +145,24 @@
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
  * This function is protected against re-entrancy.
  */
-void die(const char *str, struct pt_regs *regs, int err)
+NORET_TYPE void die(const char *str, struct pt_regs *regs, int err)
 {
 	struct task_struct *tsk = current;
 
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
+++ linux/kernel/sched.c	Sun Jun 24 15:16:43 2001
@@ -1104,7 +1104,7 @@
 	int state;
 	static const char * stat_nam[] = { "R", "S", "D", "Z", "T", "W" };
 
-	printk("%-8s  ", p->comm);
+	printk("%-13.13s ", p->comm);
 	state = p->state ? ffz(~p->state) + 1 : 0;
 	if (((unsigned) state) < sizeof(stat_nam)/sizeof(char *))
 		printk(stat_nam[state]);
@@ -1132,21 +1132,21 @@
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
-/* This is very useful, but only works on x86 and sparc64 right now */
+#if defined(CONFIG_X86) || defined(CONFIG_SPARC64) || defined(CONFIG_ARM)
+/* This is very useful, but only works on ARM, x86 and sparc64 right now */
 	{
 		extern void show_trace_task(struct task_struct *tsk);
 		show_trace_task(p);


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

