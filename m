Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVAaMYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVAaMYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVAaMYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:24:14 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:13291 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261165AbVAaMUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:20:55 -0500
Message-ID: <41FE319E.E265C599@tv-sign.ru>
Date: Mon, 31 Jan 2005 16:24:46 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rc2-mm2: unneeded cli/sti in fix-preemption-race patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Thomas Gleixner wrote:
>
> The patch prevents this by leaving interrupts disabled and calling
> a seperate function preempt_schedule_irq().

sched-fix-preemption-race-core-i386.patch:
>
>	+++ 25-akpm/arch/i386/kernel/entry.S
>	@@ -189,6 +189,7 @@ ENTRY(resume_userspace)
>	 
>	 #ifdef CONFIG_PREEMPT
>	 ENTRY(resume_kernel)
>	+	cli

I think this 'cli' is unneeded. resume_kernel: is used on
return path from do_IRQ() which leaves interrupts disabled.
irq_desc->handler->end() should not enable interrupts, yes?

And we have preempt_stop==cli in ret_from_exception: case,
before ret_from_intr.

>	+++ 25-akpm/kernel/sched.c
>	@@ -2872,6 +2872,48 @@ need_resched:
>	...
>	+asmlinkage void __sched preempt_schedule_irq(void)
>	+{
>	...
>	+	local_irq_enable();
>	+	schedule();

It is ok to enter schedule() with interrupts disabled, so this
'sti' seems to be unneeded too.

Am I missed something?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11-rc2-mm2/arch/i386/kernel/entry.S~	Mon Jan 31 14:09:37 2005
+++ 2.6.11-rc2-mm2/arch/i386/kernel/entry.S	Mon Jan 31 14:55:25 2005
@@ -189,7 +189,6 @@ ENTRY(resume_userspace)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cli
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_all
 need_resched:
--- 2.6.11-rc2-mm2/kernel/sched.c~	Mon Jan 31 14:09:54 2005
+++ 2.6.11-rc2-mm2/kernel/sched.c	Mon Jan 31 14:57:44 2005
@@ -2971,7 +2971,6 @@ need_resched:
 	saved_lock_depth = task->lock_depth;
 	task->lock_depth = -1;
 #endif
-	local_irq_enable();
 	schedule();
 	local_irq_disable();
 #ifdef CONFIG_PREEMPT_BKL
