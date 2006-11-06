Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753206AbWKFPGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbWKFPGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 10:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbWKFPGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 10:06:09 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:31416 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1753206AbWKFPGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 10:06:08 -0500
Date: Mon, 6 Nov 2006 10:05:09 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, sct@redhat.com
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <Pine.LNX.4.58.0611060841260.15514@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0611060958450.16910@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.58.0611060729370.14553@gandalf.stny.rr.com>
 <20061106141502.GA164@oleg> <Pine.LNX.4.58.0611060841260.15514@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Nov 2006, Steven Rostedt wrote:

> But...
>
> Doing a quick search on wake_up, I came across loop.c (also my first hit).
>
> Here we have: (some funcs pulled in).
>
> loop_make_request:
>   lo->lo_bio = lo->lo_biotail = bio;
>   wake_up(&lo->lo_event);
>
> And with wait_event_interruptible(lo->lo_event, lo->lo_bio)
> we have:
>
>   prepare_to_wait(..., TASK_INTERRUPTIBLE);
>   if (lo->bio)
>      break;
>   schedule_timeout();
>
>
> So this probably also has the same bug!
>
> There's nothing to prevent the CPU from showing lo->bio has changed
> *after* setting wake_up to TASK_RUNNING.
>
> So maybe this *is* a race condition that is all over the kernel for other
> architectures!

Talking this over with Stephen Tweedie, he pointed out to me that the
setting of the task state is done within the wait queue locks, and thus,
the above is not a problem.

But the old paradigm of:

  add_wait_queue();
  for (;;) {
	task->state = TASK_INTERRUPTIBLE;
	if (condition)
		break;
	schedule();
  }

Can still be a bug, since the other CPU might hold off the condition
to after it set the state to TASK_RUNNING.

-- Steve
