Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVDCOwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVDCOwN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVDCOwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 10:52:13 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:971 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261773AbVDCOwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 10:52:09 -0400
Message-ID: <42500480.17FA45AB@tv-sign.ru>
Date: Sun, 03 Apr 2005 18:58:08 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] resend, unneeded cli/sti in ret_from_intr path
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386/kernel/entry.S:resume_kernel: is used on return path
from do_IRQ() which leaves interrupts disabled. And we have
preempt_stop == cli in ret_from_exception: case, before
ret_from_intr. So this 'cli' is unneeded.

It is ok to enter schedule() with interrupts disabled, so
this 'sti' in preempt_schedule_irq() seems to be unneeded too.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/arch/i386/kernel/entry.S~CLI	2005-03-21 19:55:51.000000000 +0300
+++ 2.6.12-rc1/arch/i386/kernel/entry.S	2005-03-21 19:57:58.000000000 +0300
@@ -176,7 +176,6 @@ ENTRY(resume_userspace)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cli
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_all
 need_resched:
--- 2.6.12-rc1/kernel/sched.c~CLI	2005-03-19 14:16:53.000000000 +0300
+++ 2.6.12-rc1/kernel/sched.c	2005-03-21 19:57:58.000000000 +0300
@@ -2851,7 +2851,6 @@ need_resched:
 	saved_lock_depth = task->lock_depth;
 	task->lock_depth = -1;
 #endif
-	local_irq_enable();
 	schedule();
 	local_irq_disable();
 #ifdef CONFIG_PREEMPT_BKL
