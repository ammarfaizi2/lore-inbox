Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312747AbSDFTJy>; Sat, 6 Apr 2002 14:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312740AbSDFTJx>; Sat, 6 Apr 2002 14:09:53 -0500
Received: from zero.tech9.net ([209.61.188.187]:4358 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312747AbSDFTJv>;
	Sat, 6 Apr 2002 14:09:51 -0500
Subject: [PATCH] 2.5: don't miss a preemption oppurtunity
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 Apr 2002 14:09:49 -0500
Message-Id: <1018120190.899.100.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The new kernel preemption code in 2.5 is great.  The only missing bit is
a check for need to reschedule at the end of the preemption handling
code in preempt_schedule and entry.S.  Anytime preemption is disabled,
there is a possibility kernel code could set need_resched and try to
preempt.  We need to check need_resched as soon as we reenable
preemption (preempt_count=0) in these code paths.

Right now this window exists anytime after resume_kernel sets
preempt_count to 0 and after return from schedule when preempt_count is
also set to 0.  Note they can last as long as the next interrupt - or
longer if a lock was grabbed in the interim.  This is a decade in
real-time land.

This patch, against 2.4.8-pre2, adds a simple check for need_resched to
the end of these codepaths and jumps back into them if needed.  Please
apply.

	Robert Love

diff -urN linux-2.5.8-pre2/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.8-pre2/kernel/sched.c	Fri Apr  5 20:18:12 2002
+++ linux/kernel/sched.c	Fri Apr  5 21:02:54 2002
@@ -851,10 +851,15 @@
 	if (unlikely(ti->preempt_count))
 		return;
 
+need_resched:
 	ti->preempt_count = PREEMPT_ACTIVE;
 	schedule();
 	ti->preempt_count = 0;
 	barrier();
+
+	/* we could miss a preemption between schedule() and now */
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
+		goto need_resched;
 }
 #endif /* CONFIG_PREEMPT */

diff -urN linux-2.5.8-pre2/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.5.8-pre2/arch/i386/kernel/entry.S	Fri Apr  5 20:18:10 2002
+++ linux/arch/i386/kernel/entry.S	Sat Apr  6 01:59:17 2002
@@ -232,6 +232,7 @@
 ENTRY(resume_kernel)
 	cmpl $0,TI_PRE_COUNT(%ebx)
 	jnz restore_all
+need_resched:
 	movl TI_FLAGS(%ebx), %ecx
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
@@ -241,8 +242,9 @@
 	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebx)
 	sti
 	call SYMBOL_NAME(schedule)
-	movl $0,TI_PRE_COUNT(%ebx) 
-	jmp restore_all
+	movl $0,TI_PRE_COUNT(%ebx)
+	cli
+	jmp need_resched
 #endif
 
 	# system call handler stub



