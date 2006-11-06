Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753174AbWKFOMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbWKFOMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbWKFOMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:12:47 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:65456 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1753174AbWKFOMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:12:47 -0500
Date: Mon, 6 Nov 2006 09:11:54 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <20061106141502.GA164@oleg>
Message-ID: <Pine.LNX.4.58.0611060841260.15514@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.58.0611060729370.14553@gandalf.stny.rr.com>
 <20061106141502.GA164@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Nov 2006, Oleg Nesterov wrote:

> On 11/06, Steven Rostedt wrote:
> >
> > Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> Thanks.
>
> But on the other hand we probably have a similar code (set condition +
> wake_up_process()) in other places too, and __wake_up(wait_queue_head_t)
> has (in theory) the same problem. Probably we can add something like
>
> 	smp_wmb_unless_spin_lock_implies_memory_barrier_on_this_arch()

Probably smp_wmb_before_spin_lock would be a good name.

>
> somewhere in try_to_wake_up(). I dunno.
>

But I don't think it belongs in try_to_wake_up. That's just assuming too
much in that function. The event to wake up could simply be an interrupt
took place, where the smb_wmb would not be needed.

As Linus has stated.  Most cases where a process is going to sleep on an
event, it had better check to make sure that the event didn't happen
between the time it set itself to something other than TASK_RUNNING and
when it calls schedule.

I guess what this points out is that in such a case, the event maker must
make sure that the event is visible before it wakes up the process that's
waiting on the event.  But putting that logic into try_to_wake_up, IMHO is
an overkill.

But...

Doing a quick search on wake_up, I came across loop.c (also my first hit).

Here we have: (some funcs pulled in).

loop_make_request:
  lo->lo_bio = lo->lo_biotail = bio;
  wake_up(&lo->lo_event);

And with wait_event_interruptible(lo->lo_event, lo->lo_bio)
we have:

  prepare_to_wait(..., TASK_INTERRUPTIBLE);
  if (lo->bio)
     break;
  schedule_timeout();


So this probably also has the same bug!

There's nothing to prevent the CPU from showing lo->bio has changed
*after* setting wake_up to TASK_RUNNING.

So maybe this *is* a race condition that is all over the kernel for other
architectures!

-- Steve


