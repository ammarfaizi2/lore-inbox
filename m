Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbUAHSyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUAHSyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:54:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:48603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265935AbUAHSyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:54:01 -0500
Date: Thu, 8 Jan 2004 10:53:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix runqueue corruption, 2.6.1-rc3-A0
In-Reply-To: <20040108173111.GA28875@elte.hu>
Message-ID: <Pine.LNX.4.58.0401081045570.2158@home.osdl.org>
References: <20040108173111.GA28875@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jan 2004, Ingo Molnar wrote:
> 
> the attached patch fixes a nasty, few-instructions race that can result
> in a corrupted runqueue at thread/process-creation time. The bug is this
> code in do_fork():

The bug is more than that - we don't do the proper accountign setup for 
the CLONE_STOPPED case. Look at all the interactive bias stuff that 
doesn't get run at all..

> the fix is to set it to TASK_STOPPED only if we dont call
> wake_up_forked_process(). (Also, to avoid this bug in the future i've
> added an assert to catch illegal uses of wake_up_forked_process().)

I don't like it. That "TASK_UNINTERRUPTIBLE" assert is simply wrong: it's 
perfectly ok to call the function with a TASK_RUNNING thread too, since 
such a process can not be added to the runqueue by anything else 
(wake_up_process() won't touch it since it's already awake).

So a more proper assert would be to check

	BUG_ON(p->state & ~TASK_UNINTERRUPIBLE);

or, preferably to get rid of the TASK_UNINTERRUPTIBLE special case
altogether, and just say "this function has to be called for something
that is already marked as being running".

In other words, wouldn't it be saner with something like this instead
(which still leaves the issue of the interactive bias unfixed, and is
TOTALLY UNTESTED!).

		Linus

---
===== kernel/fork.c 1.149 vs edited =====
--- 1.149/kernel/fork.c	Mon Dec 29 13:37:19 2003
+++ edited/kernel/fork.c	Thu Jan  8 10:50:13 2004
@@ -918,7 +918,7 @@
 	p->thread_info->preempt_count = 1;
 #endif
 	p->did_exec = 0;
-	p->state = TASK_UNINTERRUPTIBLE;
+	p->state = TASK_RUNNING;
 
 	copy_flags(clone_flags, p);
 	if (clone_flags & CLONE_IDLETASK)
@@ -1209,9 +1209,10 @@
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
-		p->state = TASK_STOPPED;
 		if (!(clone_flags & CLONE_STOPPED))
 			wake_up_forked_process(p);	/* do this last */
+		else
+			p->state = TASK_STOPPED;
 		++total_forks;
 
 		if (unlikely (trace)) {
===== kernel/sched.c 1.227 vs edited =====
--- 1.227/kernel/sched.c	Mon Dec 29 13:37:37 2003
+++ edited/kernel/sched.c	Thu Jan  8 10:50:36 2004
@@ -684,7 +684,8 @@
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
-	p->state = TASK_RUNNING;
+	BUG_ON(p->state != TASK_RUNNING);
+
 	/*
 	 * We decrease the sleep average of forking parents
 	 * and children as well, to keep max-interactive tasks
