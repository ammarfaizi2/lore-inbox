Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSE2SEd>; Wed, 29 May 2002 14:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSE2SEc>; Wed, 29 May 2002 14:04:32 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23037 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314446AbSE2SEb>; Wed, 29 May 2002 14:04:31 -0400
Subject: Re: [PATCH] updated O(1) scheduler for 2.4
From: Robert Love <rml@mvista.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
In-Reply-To: <20020529151552.GJ31701@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 11:03:14 -0700
Message-Id: <1022695394.985.13.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 08:15, Andrea Arcangeli wrote:

> I merged it and I've almost finished moving everything on top of it but
> I've a few issues.
> 
> can you elaborate why you __save_flags in do_fork? do_fork is even a
> blocking operation. fork_by_hand runs as well with irq enabled.
> I don't like to safe flags in a fast path if it's not required.

s/you/Ingo/ ;)

We save flags for two reasons: First, we touch task->time_slice which is
touched from an interrupt handler (timer/idle/scheduler_tick) and second
because we may call scheduler_tick which must be called with interrupts
off.  Note we restore them just a few lines later...

Or, hm, are you asking why not just cli/sti?  I don't know the answer to
that... I would think we always enter do_fork with interrupts enabled,
but maybe Ingo thought otherwise.

> Then there are longstanding bugs that aren't yet fixed and I ported the
> fixed on top of it (see the parent-timeslice patch in -aa).
> 
> the child-run first approch in o1 is suspect, it seems the parent will
> keep running just after a wasteful reschedule, a sched yield instead
> should be invoked like in -aa in the share-timeslice patch in order to
> roll the current->run_list before the schedule is invoked while
> returning to userspace after fork.

I do not see this...

> another suspect thing I noticed is the wmb() in resched_task. Can you
> elaborate on what is it trying to serialize (I hope not the read of
> p->need_resched with the stuff below)? Also if something it should be a
> smp_wmb(), same smp_ prefix goes for the other mb() in schedule.

I suspect you may be right here.  I believe the wmb() is to serialize
the reading of need_resched vs the writing of need_resched below it vs
whatever may happen to need_resched elsewhere.

But resched_task is the only bit from 2.5 I have not fully back
ported...take a look at resched_task in 2.5: I need to bring that to
2.4.  I suspect idle polling is broken in 2.4, too.

> thanks,

You are welcome ;)

	Robert Love


