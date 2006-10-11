Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWJKNgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWJKNgl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWJKNgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:36:41 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:62160 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751309AbWJKNgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:36:40 -0400
Date: Wed, 11 Oct 2006 15:36:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] stacktrace bug.
Message-ID: <20061011133640.GG9305@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] stacktrace bug.

The latest kernel 2.6.19-rc1 triggers a bug in the s390 specific stack
trace code when compiled with gcc 3.4.
This patch fixes the latest lock dependency validator code (2.6.19-rc1)
on s390 gcc 3.4. The variable sp was fixed to r15 (which is the stack
pointer in the s390 abi) and assigned new values to r15. Therefore,
gcc 3.4 assigns a new value to r15 and does not restore it on exit (r15
is supposed to be call save) - the kernel stack is broken. Avoid trouble
by not assigning any new value to sp (r15).

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/stacktrace.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/stacktrace.c linux-2.6-patched/arch/s390/kernel/stacktrace.c
--- linux-2.6/arch/s390/kernel/stacktrace.c	2006-10-11 15:23:16.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/stacktrace.c	2006-10-11 15:23:40.000000000 +0200
@@ -62,27 +62,26 @@ static inline unsigned long save_context
 void save_stack_trace(struct stack_trace *trace, struct task_struct *task)
 {
 	register unsigned long sp asm ("15");
-	unsigned long orig_sp;
+	unsigned long orig_sp, new_sp;
 
-	sp &= PSW_ADDR_INSN;
-	orig_sp = sp;
+	orig_sp = sp & PSW_ADDR_INSN;
 
-	sp = save_context_stack(trace, &trace->skip, sp,
+	new_sp = save_context_stack(trace, &trace->skip, orig_sp,
 				S390_lowcore.panic_stack - PAGE_SIZE,
 				S390_lowcore.panic_stack);
-	if ((sp != orig_sp) && !trace->all_contexts)
+	if ((new_sp != orig_sp) && !trace->all_contexts)
 		return;
-	sp = save_context_stack(trace, &trace->skip, sp,
+	new_sp = save_context_stack(trace, &trace->skip, new_sp,
 				S390_lowcore.async_stack - ASYNC_SIZE,
 				S390_lowcore.async_stack);
-	if ((sp != orig_sp) && !trace->all_contexts)
+	if ((new_sp != orig_sp) && !trace->all_contexts)
 		return;
 	if (task)
-		save_context_stack(trace, &trace->skip, sp,
+		save_context_stack(trace, &trace->skip, new_sp,
 				   (unsigned long) task_stack_page(task),
 				   (unsigned long) task_stack_page(task) + THREAD_SIZE);
 	else
-		save_context_stack(trace, &trace->skip, sp,
+		save_context_stack(trace, &trace->skip, new_sp,
 				   S390_lowcore.thread_info,
 				   S390_lowcore.thread_info + THREAD_SIZE);
 	return;
