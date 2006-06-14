Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWFNN6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWFNN6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWFNN6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:58:08 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:27710 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S964932AbWFNN6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:58:06 -0400
Date: Wed, 14 Jun 2006 15:58:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 2/24] s390: incomplete stack traces.
Message-ID: <20060614135808.GC9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] incomplete stack traces.

show_stack() passes a pointer to the current stack frame to show_trace().
Because of tail call optimization the pointer doesn't point to the original
stack frame anymory and therefore traces are wrong. Don't pass the pointer
of the current stack frame to show_trace(). Instead let show_trace()
calculate the pointer on its own.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/traps.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2006-06-14 14:29:32.000000000 +0200
@@ -150,13 +150,11 @@ void show_stack(struct task_struct *task
 	unsigned long *stack;
 	int i;
 
-	// debugging aid: "show_stack(NULL);" prints the
-	// back trace for this cpu.
-
 	if (!sp)
-		sp = task ? (unsigned long *) task->thread.ksp : __r15;
+		stack = task ? (unsigned long *) task->thread.ksp : __r15;
+	else
+		stack = sp;
 
-	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (((addr_t) stack & (THREAD_SIZE-1)) == 0)
 			break;
