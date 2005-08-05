Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263044AbVHEPPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbVHEPPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVHEPNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:13:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23731 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262635AbVHEPMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:12:20 -0400
Date: Fri, 5 Aug 2005 17:13:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] preempt-trace-fixes.patch
Message-ID: <20050805151312.GA3284@elte.hu>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <20050804152858.2ef2d72b.akpm@osdl.org> <20050805104819.GA20278@elte.hu> <200508051344.58848.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508051344.58848.dominik.karall@gmx.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Karall <dominik.karall@gmx.net> wrote:

> > yeah. I've done this today and have split it out of the -RT tree, see
> > the patch below. After some exposure in -mm i'd like this feature to go
> > upstream too.
> >
> > the patch is against recent Linus trees, 2.6.13-rc4 or later should all
> > work. Dominik, could you try it and send us the new kernel logs whenever
> > you happen to hit that warning message again? (Please also enable
> > CONFIG_KALLSYMS_ALL, so that we get as much symbolic data as possible.)
> 
> I tried to compile the patch on top of 2.6.13-rc4-mm1, it applied with a few 
> offsets, but it looked ok.
> Here is the error I get when I compiled it:

ok, does the additional patch below fix things for you?

	Ingo

------

- fix the x64 build

- get the preempt_count from the right task on x86 (it's usually 
  'current', but not always.)

- fix compiler warning in kernel/softirq.c on 64-bit platforms

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/traps.c     |    2 +-
 arch/x86_64/kernel/process.c |    2 +-
 arch/x86_64/kernel/traps.c   |    9 +++++----
 include/asm-x86_64/proto.h   |    2 +-
 kernel/softirq.c             |    2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

Index: linux-preempt-trace/arch/i386/kernel/traps.c
===================================================================
--- linux-preempt-trace.orig/arch/i386/kernel/traps.c
+++ linux-preempt-trace/arch/i386/kernel/traps.c
@@ -164,7 +164,7 @@ void show_trace(struct task_struct *task
 			break;
 		printk(" =======================\n");
 	}
-	print_preempt_trace(task, preempt_count());
+	print_preempt_trace(task, task->thread_info->preempt_count);
 }
 
 void show_stack(struct task_struct *task, unsigned long *esp)
Index: linux-preempt-trace/arch/x86_64/kernel/process.c
===================================================================
--- linux-preempt-trace.orig/arch/x86_64/kernel/process.c
+++ linux-preempt-trace/arch/x86_64/kernel/process.c
@@ -311,7 +311,7 @@ void __show_regs(struct pt_regs * regs)
 void show_regs(struct pt_regs *regs)
 {
 	__show_regs(regs);
-	show_trace(&regs->rsp);
+	show_trace(current, &regs->rsp);
 }
 
 /*
Index: linux-preempt-trace/arch/x86_64/kernel/traps.c
===================================================================
--- linux-preempt-trace.orig/arch/x86_64/kernel/traps.c
+++ linux-preempt-trace/arch/x86_64/kernel/traps.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
+#include <linux/sched.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -156,7 +157,7 @@ static unsigned long *in_exception_stack
  * severe exception (double fault, nmi, stack fault, debug, mce) hardware stack
  */
 
-void show_trace(unsigned long *stack)
+void show_trace(struct task_struct *task, unsigned long *stack)
 {
 	unsigned long addr;
 	const unsigned cpu = safe_smp_processor_id();
@@ -221,7 +222,7 @@ void show_trace(unsigned long *stack)
 	HANDLE_STACK (((long) stack & (THREAD_SIZE-1)) != 0);
 #undef HANDLE_STACK
 	printk("\n");
-	print_traces(task);
+	print_preempt_trace(task, task->thread_info->preempt_count);
 }
 
 void show_stack(struct task_struct *tsk, unsigned long * rsp)
@@ -258,7 +259,7 @@ void show_stack(struct task_struct *tsk,
 		printk("%016lx ", *stack++);
 		touch_nmi_watchdog();
 	}
-	show_trace((unsigned long *)rsp);
+	show_trace(tsk, (unsigned long *)rsp);
 }
 
 /*
@@ -267,7 +268,7 @@ void show_stack(struct task_struct *tsk,
 void dump_stack(void)
 {
 	unsigned long dummy;
-	show_trace(&dummy);
+	show_trace(current, &dummy);
 }
 
 EXPORT_SYMBOL(dump_stack);
Index: linux-preempt-trace/include/asm-x86_64/proto.h
===================================================================
--- linux-preempt-trace.orig/include/asm-x86_64/proto.h
+++ linux-preempt-trace/include/asm-x86_64/proto.h
@@ -66,7 +66,7 @@ extern unsigned long end_pfn_map; 
 
 extern cpumask_t cpu_initialized;
 
-extern void show_trace(unsigned long * rsp);
+extern void show_trace(struct task_struct *task, unsigned long *rsp);
 extern void show_registers(struct pt_regs *regs);
 
 extern void exception_table_check(void);
Index: linux-preempt-trace/kernel/softirq.c
===================================================================
--- linux-preempt-trace.orig/kernel/softirq.c
+++ linux-preempt-trace/kernel/softirq.c
@@ -99,7 +99,7 @@ restart:
 #ifdef CONFIG_DEBUG_PREEMPT
 			out_count = preempt_count();
 			if (in_count != out_count) {
-				printk(KERN_ERR "BUG: softirq %d preempt-count "
+				printk(KERN_ERR "BUG: softirq %ld preempt-count "
 					"imbalance: in=%08x, out=%08x!\n",
 					h - softirq_vec, in_count, out_count);
 				print_preempt_trace(current, out_count);
