Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWALRP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWALRP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWALRP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:15:58 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:17849 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932200AbWALRPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:15:36 -0500
Date: Thu, 12 Jan 2006 18:15:16 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 5/13] s390: show_task oops.
Message-ID: <20060112171516.GF16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[patch 5/13] s390: show_task oops.

The show_task function walks the kernel stack backchain of
processes assuming that the processes are not running. Since
this assumption is not correct walking the backchain can lead
to an addressing exception and therefore to a kernel hang.
So prevent the kernel hang (you still get incorrect results)
verity that all read accesses are within the bounds of the
kernel stack before performing them.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/kernel/process.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/process.c linux-2.6-patched/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	2006-01-12 15:43:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/process.c	2006-01-12 15:43:55.000000000 +0100
@@ -58,10 +58,19 @@ asmlinkage void ret_from_fork(void) __as
  */
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
-	struct stack_frame *sf;
+	struct stack_frame *sf, *low, *high;
 
-	sf = (struct stack_frame *) tsk->thread.ksp;
-	sf = (struct stack_frame *) sf->back_chain;
+	if (!tsk || !tsk->thread_info)
+		return 0;
+	low = (struct stack_frame *) tsk->thread_info;
+	high = (struct stack_frame *)
+		((unsigned long) tsk->thread_info + THREAD_SIZE) - 1;
+	sf = (struct stack_frame *) (tsk->thread.ksp & PSW_ADDR_INSN);
+	if (sf <= low || sf > high)
+		return 0;
+	sf = (struct stack_frame *) (sf->back_chain & PSW_ADDR_INSN);
+	if (sf <= low || sf > high)
+		return 0;
 	return sf->gprs[8];
 }
 
