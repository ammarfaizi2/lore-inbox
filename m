Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWE2VoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWE2VoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWE2VYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:24:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:15544 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751325AbWE2VX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:58 -0400
Date: Mon, 29 May 2006 23:24:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 15/61] lock validator: x86_64: use stacktrace to generate backtraces
Message-ID: <20060529212418.GO3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

this switches x86_64 to use the stacktrace infrastructure when generating
backtrace printouts, if CONFIG_FRAME_POINTER=y. (This patch will go away
once the dwarf2 stackframe parser in -mm goes upstream.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86_64/kernel/traps.c |   35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -235,7 +235,31 @@ in_exception_stack(unsigned cpu, unsigne
  * severe exception (double fault, nmi, stack fault, debug, mce) hardware stack
  */
 
-void show_trace(unsigned long *stack)
+#ifdef CONFIG_FRAME_POINTER
+
+#include <linux/stacktrace.h>
+
+#define MAX_TRACE_ENTRIES 64
+
+static void __show_trace(struct task_struct *task, unsigned long *stack)
+{
+	unsigned long entries[MAX_TRACE_ENTRIES];
+	struct stack_trace trace;
+
+	trace.nr_entries = 0;
+	trace.max_entries = MAX_TRACE_ENTRIES;
+	trace.entries = entries;
+
+	save_stack_trace(&trace, task, 1, 0);
+
+	pr_debug("got %d/%d entries.\n", trace.nr_entries, trace.max_entries);
+
+	print_stack_trace(&trace, 4);
+}
+
+#else
+
+void __show_trace(struct task_struct *task, unsigned long *stack)
 {
 	const unsigned cpu = safe_smp_processor_id();
 	unsigned long *irqstack_end = (unsigned long *)cpu_pda(cpu)->irqstackptr;
@@ -319,6 +343,13 @@ void show_trace(unsigned long *stack)
 	printk("\n");
 }
 
+#endif
+
+void show_trace(unsigned long *stack)
+{
+	__show_trace(current, stack);
+}
+
 void show_stack(struct task_struct *tsk, unsigned long * rsp)
 {
 	unsigned long *stack;
@@ -353,7 +384,7 @@ void show_stack(struct task_struct *tsk,
 		printk("%016lx ", *stack++);
 		touch_nmi_watchdog();
 	}
-	show_trace((unsigned long *)rsp);
+	__show_trace(tsk, (unsigned long *)rsp);
 }
 
 /*
