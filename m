Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVLIPZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVLIPZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVLIPZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:25:24 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32696 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932314AbVLIPZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:25:22 -0500
Date: Fri, 9 Dec 2005 16:25:20 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, Andreas.Krebbel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 6/17] s390: add oprofile callgraph support.
Message-ID: <20051209152520.GG6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Krebbel <krebbel1@de.ibm.com>

[patch 6/17] s390: add oprofile callgraph support.

Signed-off-by: Andreas Krebbel <krebbel1@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/oprofile/Makefile    |    2 -
 arch/s390/oprofile/backtrace.c |   79 +++++++++++++++++++++++++++++++++++++++++
 arch/s390/oprofile/init.c      |    4 ++
 3 files changed, 84 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/oprofile/backtrace.c linux-2.6-patched/arch/s390/oprofile/backtrace.c
--- linux-2.6/arch/s390/oprofile/backtrace.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/oprofile/backtrace.c	2005-12-09 14:24:25.000000000 +0100
@@ -0,0 +1,79 @@
+/**
+ * arch/s390/oprofile/backtrace.c
+ *
+ * S390 Version
+ *   Copyright (C) 2005 IBM Corporation, IBM Deutschland Entwicklung GmbH.
+ *   Author(s): Andreas Krebbel <Andreas.Krebbel@de.ibm.com>
+ */
+
+#include <linux/oprofile.h>
+
+#include <asm/processor.h> /* for struct stack_frame */
+
+static unsigned long
+__show_trace(unsigned int *depth, unsigned long sp,
+	     unsigned long low, unsigned long high)
+{
+	struct stack_frame *sf;
+	struct pt_regs *regs;
+
+	while (*depth) {
+		sp = sp & PSW_ADDR_INSN;
+		if (sp < low || sp > high - sizeof(*sf))
+			return sp;
+		sf = (struct stack_frame *) sp;
+		(*depth)--;
+		oprofile_add_trace(sf->gprs[8] & PSW_ADDR_INSN);
+
+		/* Follow the backchain.  */
+		while (*depth) {
+			low = sp;
+			sp = sf->back_chain & PSW_ADDR_INSN;
+			if (!sp)
+				break;
+			if (sp <= low || sp > high - sizeof(*sf))
+				return sp;
+			sf = (struct stack_frame *) sp;
+			(*depth)--;
+			oprofile_add_trace(sf->gprs[8] & PSW_ADDR_INSN);
+
+		}
+
+		if (*depth == 0)
+			break;
+
+		/* Zero backchain detected, check for interrupt frame.  */
+		sp = (unsigned long) (sf + 1);
+		if (sp <= low || sp > high - sizeof(*regs))
+			return sp;
+		regs = (struct pt_regs *) sp;
+		(*depth)--;
+		oprofile_add_trace(sf->gprs[8] & PSW_ADDR_INSN);
+		low = sp;
+		sp = regs->gprs[15];
+	}
+	return sp;
+}
+
+void s390_backtrace(struct pt_regs * const regs, unsigned int depth)
+{
+	unsigned long head;
+	struct stack_frame* head_sf;
+
+	if (user_mode (regs))
+		return;
+
+	head = regs->gprs[15];
+	head_sf = (struct stack_frame*)head;
+
+	if (!head_sf->back_chain)
+		return;
+
+	head = head_sf->back_chain;
+
+	head = __show_trace(&depth, head, S390_lowcore.async_stack - ASYNC_SIZE,
+			    S390_lowcore.async_stack);
+
+	__show_trace(&depth, head, S390_lowcore.thread_info,
+		     S390_lowcore.thread_info + THREAD_SIZE);
+}
diff -urpN linux-2.6/arch/s390/oprofile/init.c linux-2.6-patched/arch/s390/oprofile/init.c
--- linux-2.6/arch/s390/oprofile/init.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/oprofile/init.c	2005-12-09 14:24:25.000000000 +0100
@@ -12,8 +12,12 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 
+
+extern void s390_backtrace(struct pt_regs * const regs, unsigned int depth);
+
 int __init oprofile_arch_init(struct oprofile_operations* ops)
 {
+	ops->backtrace = s390_backtrace;
 	return -ENODEV;
 }
 
diff -urpN linux-2.6/arch/s390/oprofile/Makefile linux-2.6-patched/arch/s390/oprofile/Makefile
--- linux-2.6/arch/s390/oprofile/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/oprofile/Makefile	2005-12-09 14:24:25.000000000 +0100
@@ -6,4 +6,4 @@ DRIVER_OBJS = $(addprefix ../../../drive
 		oprofilefs.o oprofile_stats.o  \
 		timer_int.o )
 
-oprofile-y				:= $(DRIVER_OBJS) init.o
+oprofile-y				:= $(DRIVER_OBJS) init.o backtrace.o
