Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276669AbRJGUZf>; Sun, 7 Oct 2001 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276670AbRJGUZ0>; Sun, 7 Oct 2001 16:25:26 -0400
Received: from [195.223.140.107] ([195.223.140.107]:42226 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276669AbRJGUZJ>;
	Sun, 7 Oct 2001 16:25:09 -0400
Date: Sun, 7 Oct 2001 22:24:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: george anzinger <george@mvista.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011007222440.G726@athlon.random>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com> <20011004175526.C18528@redhat.com> <9piokt$8v9$1@penguin.transmeta.com> <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com> <20011005024526.E724@athlon.random> <20011004213507.B1032@w-mikek2.sequent.com> <20011007195928.D726@athlon.random> <3BC0B2E0.C6421F8F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC0B2E0.C6421F8F@mvista.com>; from george@mvista.com on Sun, Oct 07, 2001 at 12:54:08PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2001 at 12:54:08PM -0700, george anzinger wrote:
> Andrea Arcangeli wrote:
> > 
> > On Thu, Oct 04, 2001 at 09:35:07PM -0700, Mike Kravetz wrote:
> > > [..] the pipe routines only call
> > > the non-synchronous form of wake_up. [..]
> > 
> > Ok I see, I overlooked that when we don't need to block we wakeup-async.
> > 
> > So first of all it would be interesting to change the token passed
> > thorugh the pipe so that it always fills in the PAGE_SIZE pipe buffer so
> > that the task goes to sleep before reading from the next pipe in the
> > ring.
> > 
> > And if we want to optimize the current benchmark (with the small token that
> > triggers the async-wakeup and it always goes to sleep in read() rather
> > than write()) we'd need to invalidate a basic point of the scheduler
> > that have nothing to do with IPI reschedule, the point to invalidate is
> > that if the current task (the one that is running wake_up()) has a small
> > avg_slice we'd better not reschedule the wakenup task on a new idle cpu
> > but we'd better wait the current task to go away instead. 
> 
> A couple of questions: 
> 
> 1.) Do you want to qualify that the wake_up is not from an interrupt?

If the avg_slice is very small we know the task will probabilistically
go away soon regardless where the wakeup cames from. I don't think the
logic has connection to the kind of wakeup, it only has connection to
the kind of "running task".

Infact waiting "bash" or "ksoftirqd" to go away is the right thing to do
to fix the suprious migrations of cpu intensive tasks too, no matter
where the wakeup cames from.

The only risk here is that we never know from the scheduler if the
running task with the small avg_slice will really go away this time too
or not. And if it doesn't go away this time, we may not do the best
global decision by not migrating the wakenup task to the idle cpus, but
the probability information provided by avg_slice should cover this
problem.

Of course this is theory, I didn't attempted to test it.

btw, I remeber Ingo some year ago said on l-k that rescheduling
immediatly every idle cpu isn't the best thing to do.

> 2.) Having done this AND the task doesn't block THIS time, do we wait
> for the slice to end or is some other "dead man" timer needed?

Of course waiting for the slice to end anyways is the natural first
step. As said above the point of the probability information of
avg_slice is to render very unlikely the "task doesn't block THIS time"
case.

Andrea
