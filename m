Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288276AbSAHTxx>; Tue, 8 Jan 2002 14:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288280AbSAHTxn>; Tue, 8 Jan 2002 14:53:43 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:13319 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288276AbSAHTxZ>; Tue, 8 Jan 2002 14:53:25 -0500
Message-ID: <3C3B4CB7.FEAAF5FC@zip.com.au>
Date: Tue, 08 Jan 2002 11:47:03 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Anton Blanchard <anton@samba.org>, Andrea Arcangeli <andrea@suse.de>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <20020108142117.F3221@inspiron.school.suse.de> <20020108133335.GB26307@krispykreme>,
		<20020108133335.GB26307@krispykreme> <E16Nxjg-00009W-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On January 8, 2002 02:33 pm, Anton Blanchard wrote:
> > Andrea Arcangeli [apparently] wrote:
> > > So yes, mean latency will decrease with preemptive kernel, but your CPU
> > > is definitely paying something for it.
> >
> > And Andrew Morton's work suggests he can do a much better job of
> > reducing latency than -preempt.
> 
> That's not a particularly clueful comment, Anton.  Obviously, any
> latency-busting hacks that Andrew does could also be patched into a
> -preempt kernel.

Yes.  The important part is the implicit dropping of the BKL across
schedule().

> What a preemptible kernel can do that a non-preemptible kernel can't is:
> reschedule exactly as often as necessary, instead of having lots of extra
> schedule points inserted all over the place, firing when *they* think the
> time is right, which may well be earlier than necessary.

Nope.  `if (current->need_resched)' -> the time is right (beyond right,
actually).

> The preemptible approach is much less of a maintainance headache, since
> people don't have to be constantly doing audits to see if something changed,
> and going in to fiddle with scheduling points.

Except it doesn't work.  The full-on low-latency patch has ~60 rescheduling
points.  Of these, ~40 involve popping spinlocks.  Really, the only significant
latency sources which the preemptible kernel solves are generic_file_read()
and generic_file_write().

So preemptible kernel needs lock-break to be useful.  And then it's basically
the same thing, with the same maintainability problems.  And believe me, these
are considerable.  Mainly because the areas which needs busting up exactly
coincide with the areas where there has been most churn in the kernel.

> Finally, with preemption, rescheduling can be forced with essentially zero
> latency in response to an arbitrary interrupt such as IO completion, whereas
> the non-preemptive kernel will have to 'coast to a stop'.  In other words,
> the non-preemptive kernel will have little lags between successive IOs,
> whereas the preemptive kernel can submit the next IO immediately.  So there
> are bound to be loads where the preemptive kernel turns in better latency
> *and throughput* than the scheduling point hack.

Latency yes.  Throughout no.

I don't think the "preempt slows down the kernel" argument is very valid
really.  Let's invert the argument - Linux is multitasking, and that has a
cost.  There's no reason why certain bits of the kernel need to violate that
just to get a bit more throughput.  If it really worries you, set HZ=10 and
increase all the timeslices, etc.

Now, there *may* be overheads added due to losing the implicit locking which
per-CPU data gives you.

The main cost of preempt IMO is in complexity and stability risks.

(BTW: I took a weird oops testing the preempt patch on an SMP NFS client.
The fault address was 0x0aXXXXXX.  No useful backtrace, unfortunately).

> Mind you, I'm not devaluing Andrew's work, it's good and valuable.  However
> it's good to be aware of why that approach can't equal the latency-busting
> performance of the preemptive approach.

There's no point in just merging the preempt patch and saying "there,
that's done".  It doesn't do anything.

Instead, a decision needs to be made: "Linux will henceforth be a 
low-latency kernel".  Now, IF we can come to this decision, then
internal preemption is the way to do it.  But it affects ALL kernel
developers.  Because we'll need to introduce a new rule: "it is a
bug to spend more than five milliseconds holding any locks".

So.  Do we we want a low-latency kernel?  Are we prepared to mandate
the five-millisecond rule?   It can be done, but won't be easy, and
we'll never get complete coverage.  But I don't see the will around
here.

-
