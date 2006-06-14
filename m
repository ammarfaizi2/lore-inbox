Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWFNOQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWFNOQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWFNOQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:16:56 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:48690 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964924AbWFNOQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:16:55 -0400
Date: Wed, 14 Jun 2006 16:16:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/8] lock validator: s390 stacktrace interface
Message-ID: <20060614141640.GB1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

stacktrace interface for s390 as needed by lock validator.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/Makefile     |    2 
 arch/s390/kernel/stacktrace.c |   90 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

diff -purN a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
--- a/arch/s390/kernel/Makefile	2006-06-06 02:57:02.000000000 +0200
+++ b/arch/s390/kernel/Makefile	2006-06-14 12:42:13.000000000 +0200
@@ -4,7 +4,7 @@
 
 EXTRA_AFLAGS	:= -traditional
 
-obj-y	:=  bitmap.o traps.o time.o process.o \
+obj-y	:=  bitmap.o traps.o time.o process.o stacktrace.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
             semaphore.o s390_ext.o debug.o profile.o irq.o reipl_diag.o
 
diff -purN a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
--- a/arch/s390/kernel/stacktrace.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/s390/kernel/stacktrace.c	2006-06-14 12:42:13.000000000 +0200
@@ -0,0 +1,90 @@
+/*
+ * arch/s390/kernel/stacktrace.c
+ *
+ * Stack trace management functions
+ *
+ *  Copyright (C) IBM Corp. 2006
+ *  Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+#include <linux/kallsyms.h>
+
+static inline unsigned long save_context_stack(struct stack_trace *trace,
+					       unsigned int *skip,
+					       unsigned long sp,
+					       unsigned long low,
+					       unsigned long high)
+{
+	struct stack_frame *sf;
+	struct pt_regs *regs;
+	unsigned long addr;
+
+	while(1) {
+		sp &= PSW_ADDR_INSN;
+		if (sp < low || sp > high)
+			return sp;
+		sf = (struct stack_frame *)sp;
+		while(1) {
+			addr = sf->gprs[8] & PSW_ADDR_INSN;
+			if (!(*skip))
+				trace->entries[trace->nr_entries++] = addr;
+			else
+				(*skip)--;
+			if (trace->nr_entries >= trace->max_entries)
+				return sp;
+			low = sp;
+			sp = sf->back_chain & PSW_ADDR_INSN;
+			if (!sp)
+				break;
+			if (sp <= low || sp > high - sizeof(*sf))
+				return sp;
+			sf = (struct stack_frame *)sp;
+		}
+		/* Zero backchain detected, check for interrupt frame. */
+		sp = (unsigned long)(sf + 1);
+		if (sp <= low || sp > high - sizeof(*regs))
+			return sp;
+		regs = (struct pt_regs *)sp;
+		addr = regs->psw.addr & PSW_ADDR_INSN;
+		if (!(*skip))
+			trace->entries[trace->nr_entries++] = addr;
+		else
+			(*skip)--;
+		if (trace->nr_entries >= trace->max_entries)
+			return sp;
+		low = sp;
+		sp = regs->gprs[15];
+	}
+}
+
+void save_stack_trace(struct stack_trace *trace,
+		      struct task_struct *task, int all_contexts,
+		      unsigned int skip)
+{
+	register unsigned long sp asm ("15");
+	unsigned long orig_sp;
+
+	sp &= PSW_ADDR_INSN;
+	orig_sp = sp;
+
+	sp = save_context_stack(trace, &skip, sp,
+				S390_lowcore.panic_stack - PAGE_SIZE,
+				S390_lowcore.panic_stack);
+	if ((sp != orig_sp) && !all_contexts)
+		return;
+	sp = save_context_stack(trace, &skip, sp,
+				S390_lowcore.async_stack - ASYNC_SIZE,
+				S390_lowcore.async_stack);
+	if ((sp != orig_sp) && !all_contexts)
+		return;
+	if (task)
+		save_context_stack(trace, &skip, sp,
+				   (unsigned long) task_stack_page(task),
+				   (unsigned long) task_stack_page(task) + THREAD_SIZE);
+	else
+		save_context_stack(trace, &skip, sp, S390_lowcore.thread_info,
+				   S390_lowcore.thread_info + THREAD_SIZE);
+	return;
+}
