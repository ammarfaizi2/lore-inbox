Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbUKIN0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbUKIN0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 08:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUKIN0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 08:26:33 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:11212 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261291AbUKIN0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 08:26:31 -0500
Message-ID: <4190D3D8.B7512745@tv-sign.ru>
Date: Tue, 09 Nov 2004 17:27:36 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] little schedule() cleanup: use cached current value
References: <4190ADD7.CE7EFB7C@tv-sign.ru> <20041109124553.GA25663@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> nack. We switch the kernel stack in switch_to() so 'next' here
> is the old task we switched to before we went off the CPU.

yes, sorry. here is corrected patch.

schedule() can use prev instead of get_current().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10-rc1/kernel/sched.c~	2004-11-09 18:57:45.000000000 +0300
+++ 2.6.10-rc1/kernel/sched.c	2004-11-09 19:16:22.798486040 +0300
@@ -2508,7 +2508,7 @@ need_resched:
 	 * The idle thread is not allowed to schedule!
 	 * Remove this check after it has been exercised a bit.
 	 */
-	if (unlikely(current == rq->idle) && current->state != TASK_RUNNING) {
+	if (unlikely(prev == rq->idle) && prev->state != TASK_RUNNING) {
 		printk(KERN_ERR "bad: scheduling from the idle thread!\n");
 		dump_stack();
 	}
@@ -2531,8 +2531,8 @@ need_resched:
 
 	spin_lock_irq(&rq->lock);
 
-	if (unlikely(current->flags & PF_DEAD))
-		current->state = EXIT_DEAD;
+	if (unlikely(prev->flags & PF_DEAD))
+		prev->state = EXIT_DEAD;
 	/*
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
