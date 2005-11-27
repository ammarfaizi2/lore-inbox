Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVK0LsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVK0LsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 06:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVK0LsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 06:48:21 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:34211 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751002AbVK0LsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 06:48:20 -0500
Message-ID: <4389AE80.3ED0CA59@tv-sign.ru>
Date: Sun, 27 Nov 2005 16:02:56 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
References: <4385E3FF.C99DBCF5@tv-sign.ru> <20051125051232.GB22230@elte.hu>
	  <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org> <43883D01.8CCB31A6@tv-sign.ru>
	 <Pine.LNX.4.64.0511260949030.13959@g5.osdl.org> <4388B5AA.34CE5294@tv-sign.ru> <Pine.LNX.4.64.0511261023500.13959@g5.osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> HOWEVER. I just noticed something strange. EXIT_DEAD should be in
> "task->exit_state", not in "task->state". So there's something strange
> going on in that neck of the woods _anyway_. That whole
>
> 	...
>         if (unlikely(prev->flags & PF_DEAD))
>                 prev->state = EXIT_DEAD;
> 	...
>
> in kernel/sched.c seems totally bogus.

We can use any random value instead of EXIT_DEAD (except RUNNING,INTERRUPTIBLE,
and UNINTERRUPTIBLE). The only reason for changing the state's value is this
check below:

	if (->state && !PREEMPT_ACTIVE) {
		...
		deactivate_task();
	}

This state is invisible to proc/array.c because yes, we already have something
in ->exit_state.

We can add new TASK_DEAD or something for that. Or we can do:

-	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
+	// PF_DEAD means that preemption was disabled
+	if (PF_DEAD || (prev->state && !(preempt_count() & PREEMPT_ACTIVE))) {

but this is so ugly.

> I think we should remove that thing entirely, since it's actually a total
> no-op, apart from doing something that is actively wrong. The "exit_state"
> flag should already _be_ EXIT_DEAD, no?

No, it could be EXIT_ZOMBIE if the task was not auto-reaped. So the task
should be deactivated when ->exit_state != 0. But see below.

> And now that "exit_state" is already separate from "state", the reason for
> PF_DEAD really is gone, and it could be replaced with a
>
> 	tsk->exit_state & EXIT_DEAD
>
> test instead.

No, I don't think this is right. After exit_notify() sets ->exit_state this
process is still valid from the scheduler POV, it may be preempted, may sleep.

So I beleive we really need to do something special when exiting process does
it's last context switch from do_exit(). If the process enters schedule() in
TASK_RUNNUNG, we should pass the hint to scheduler - PF_DEAD. Or we can change
the ->state before calling schedule().

Oleg.
