Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288531AbSAHWjh>; Tue, 8 Jan 2002 17:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288528AbSAHWj2>; Tue, 8 Jan 2002 17:39:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1548 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288531AbSAHWjU>; Tue, 8 Jan 2002 17:39:20 -0500
Message-ID: <3C3B7356.3361F4ED@zip.com.au>
Date: Tue, 08 Jan 2002 14:31:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0201081920130.2985-100000@imladris.surriel.com>,
		<Pine.LNX.4.33L.0201081920130.2985-100000@imladris.surriel.com> <1010526342.3225.133.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Tue, 2002-01-08 at 16:24, Rik van Riel wrote:
> 
> > So what exactly _is_ the difference between an explicit
> > preemption point and a place where we need to explicitly
> > drop a spinlock ?
> 
> In that case nothing, except that when we drop the lock and check it is
> the earliest place where preemption is allowed.  In the normal scenario,
> however, we have a check for reschedule on return from interrupt (e.g.
> the timer) and thus preempt in the same manner as with user space and
> that is the key.

One could do:

static inline void spin_unlock(spinlock_t *lock)
{
        __asm__ __volatile__(
                spin_unlock_string
        );

	if (--current->lock_depth == 0 &&
		current->need_resched &&
		current->state == TASK_RUNNING)
		schedule();
}

But I have generally avoided "global" solutions like this, in favour
of nailing the _specific_ code which is causing the problem.  Which
is a lot more work, but more useful.

The scheduling points in bread() and submit_bh() in the mini-ll patch
go against this (masochistic) philosophy.

> > > Future work would be to look into long-held locks and see what we can
> > > do.
> >
> > One thing we could do is download Andrew Morton's patch ;)
> 
> That is certainly one option, and Andrew's patch is very good.
> Nonetheless, I think we need a more general framework that tackles the
> problem itself.  Preemptible kernel does this, yields results now, and
> allows for greater return later on.

We need something which makes 2.4.x not suck.

-
