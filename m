Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288344AbSAHVHq>; Tue, 8 Jan 2002 16:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288360AbSAHVHh>; Tue, 8 Jan 2002 16:07:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:30728 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288344AbSAHVH0>;
	Tue, 8 Jan 2002 16:07:26 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C3B4CB7.FEAAF5FC@zip.com.au>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org>
	<20020108142117.F3221@inspiron.school.suse.de>
	<20020108133335.GB26307@krispykreme>, <20020108133335.GB26307@krispykreme>
	<E16Nxjg-00009W-00@starship.berlin>  <3C3B4CB7.FEAAF5FC@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 16:08:22 -0500
Message-Id: <1010524130.3383.102.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 14:47, Andrew Morton wrote:

> > What a preemptible kernel can do that a non-preemptible kernel can't is:
> > reschedule exactly as often as necessary, instead of having lots of extra
> > schedule points inserted all over the place, firing when *they* think the
> > time is right, which may well be earlier than necessary.
> 
> Nope.  `if (current->need_resched)' -> the time is right (beyond right,
> actually).

Eh, I disagree here.  The right time is the moment a high-priority task
becomes runnable.  Given your HZ, only a fully preemptible kernel can
come close to meeting that.

> > Finally, with preemption, rescheduling can be forced with essentially zero
> > latency in response to an arbitrary interrupt such as IO completion, whereas
> > the non-preemptive kernel will have to 'coast to a stop'.  In other words,
> > the non-preemptive kernel will have little lags between successive IOs,
> > whereas the preemptive kernel can submit the next IO immediately.  So there
> > are bound to be loads where the preemptive kernel turns in better latency
> > *and throughput* than the scheduling point hack.
> 
> Latency yes.  Throughout no.

I bet in _many_ (most?) workloads the preemptible kernel turns in better
throughput.  Anytime there is load on the system, there should be a
benefit.  I bet the same goes for your patch.  I've certainly verified
it for both in various loads myself.

> I don't think the "preempt slows down the kernel" argument is very valid
> really.  Let's invert the argument - Linux is multitasking, and that has a
> cost.  There's no reason why certain bits of the kernel need to violate that
> just to get a bit more throughput.  If it really worries you, set HZ=10 and
> increase all the timeslices, etc.

Very well said.  I always find an answer to the "more complexity, more
context switching, blah blah" arguments as ultimately being arguments
tantamount to "preemptive multitasking sucks".

> Now, there *may* be overheads added due to losing the implicit locking which
> per-CPU data gives you.

Perhaps, but note what preempt enable and disable statements effectively
are: an inc and a dec.  Not even atomic.

Yes, there is a branch on reenable.  This may be an interesting change
to look into.  FWIW, we have a construct that doesn't check for
reschedule on reenable, too.

> The main cost of preempt IMO is in complexity and stability risks.
> 
> (BTW: I took a weird oops testing the preempt patch on an SMP NFS client.
> The fault address was 0x0aXXXXXX.  No useful backtrace, unfortunately).

Should of sent me the oops :)

> > Mind you, I'm not devaluing Andrew's work, it's good and valuable.  However
> > it's good to be aware of why that approach can't equal the latency-busting
> > performance of the preemptive approach.
> 
> There's no point in just merging the preempt patch and saying "there,
> that's done".  It doesn't do anything.
> 
> Instead, a decision needs to be made: "Linux will henceforth be a 
> low-latency kernel".  Now, IF we can come to this decision, then
> internal preemption is the way to do it.  But it affects ALL kernel
> developers.  Because we'll need to introduce a new rule: "it is a
> bug to spend more than five milliseconds holding any locks".
> 
> So.  Do we we want a low-latency kernel?  Are we prepared to mandate
> the five-millisecond rule?   It can be done, but won't be easy, and
> we'll never get complete coverage.  But I don't see the will around
> here.

I agree here, but then I do have three points:

- proper lock use that benefits SMP scalability benefits preempt-kernel
induced latency improvements.  In other words, things like short lock
durations, fine-grained locking, and ditching the BKL benefit both
worlds.

- with the preemptible kernel in place, we can look at the long-held
locks and figure ways to combat them.  The preempt-stats patch helps us
find them.  Then, we can take a lock-break approach.  We can look into
finer grained locks.  We can localize lock the lock if it is global or
the BKL.  Or we can do something radical like make long-held spinlocks
priority-inheriting when preempt-kernel is enabled.  In other words,
preempt-kernel becomes a framework for proper solutions in the future.

- finally, the usual: it's an option.

	Robert Love

