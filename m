Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288326AbSAHUyH>; Tue, 8 Jan 2002 15:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288323AbSAHUx5>; Tue, 8 Jan 2002 15:53:57 -0500
Received: from zero.tech9.net ([209.61.188.187]:24840 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288322AbSAHUxp>;
	Tue, 8 Jan 2002 15:53:45 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Anton Blanchard <anton@samba.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20020108162930.E1894@inspiron.school.suse.de>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org>
	<20020108142117.F3221@inspiron.school.suse.de>
	<20020108133335.GB26307@krispykreme> <E16Nxjg-00009W-00@starship.berlin> 
	<20020108162930.E1894@inspiron.school.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 08 Jan 2002 15:55:38 -0500
Message-Id: <1010523340.3225.87.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-08 at 10:29, Andrea Arcangeli wrote:

> "extra schedule points all over the place", that's the -preempt kernel
> not the lowlatency kernel! (on yeah, you don't see them in the source
> but ask your CPU if it sees them)

How so?  The branch on drop of the last lock?  It's not a factor in
profiles I've seen.  And it is marked unlikely.  The other change is the
usual check for reschedule on return from interrupt, but that is the
case already, we just allow it when in-kernel, too.

This makes me think the end conclusion would be that preemptive
multitasking in general is bad.  Why don't we increase the timeslice and
and tick period, in that case?

One can argue the complexity degrades performance, but tests show
otherwise.  In throughput and latency.  Besides, like I always say, its
an option that uses existing kernel (SMP lock) infrastructure.  You
don't have to use it ;)

> > The preemptible approach is much less of a maintainance headache, since 
> > people don't have to be constantly doing audits to see if something changed, 
> > and going in to fiddle with scheduling points.
> 
> this yes, it requires less maintainance, but still you should keep in
> mind the details about the spinlocks, things like the checks the VM does
> in shrink_cache are needed also with preemptive kernel.

They impact SMP in the same way they impact preempt-kernel.  Long-held
locks are never good.  Weird locking rules are never good.

> The I/O pipeline is big enough that a few msec before or later in a
> submit_bh shouldn't make a difference, the batch logic in the
> ll_rw_block layer also try to reduce the reschedule, and last but not
> the least if the task is I/O bound preemptive kernel or not won't make
> any difference in the submit_bh latency because no task is eating cpu
> and latency will be the one of pure schedule call.

Yet throughput tests show marked increase.  I believe this is true with
Andrew's patch, too.  We multitask better.  We dispatch waiting tasks
faster.  Without the patch, a queued I/O task may stall for sometime
waiting for some hog to get out of the kernel.

Although the patch's goal is to improve interactivity (*), no one says
the higher priority task we preempt in favor of has to be CPU-bound.  A
woken up I/O-bound task is just as benefiting from the patch.

(*) this is, IMO, where we benefit most though.  By far the most
pleasing benchmark isn't to see some x% decrease in latency or y more
MB/s in bonnie, but to feel the improvement in interactivity.  On a
multitasking desktop, it is noticeable.

> I also don't want to devaluate the preemptive kernel approch (the mean
> latency it can reach is lower than the one of the lowlat kernel, however
> I personally care only about worst case latency and this is why I don't
> feel the need of -preempt), but I just wanted to make clear that the
> idea that is floating around that preemptive kernel is all goodness is
> very far from reality, you get very low mean latency but at a price.

Andrea, I don't want you or anyone to believe preemption is a free
ride.  On the other hand, the patch has a _huge_ userbase and you can't
question that.  You also can't question the benchmarks that show
improvements in average _and_ worst case latency _and_ throughput.

I don't expect you to use the patch.  If it were merged, it is an
option.  It provides a framework for continuing to improve latency.  It
is a solution to the problem (i.e. latency is poor because the kernel is
non-preemptible) instead of a hack.  I agree worst-case latency is
important, and I agree the patch shines more so in average case.  But we
do affect worse-case.  And now a framework exists for working on fixing
the worst-case latencies too.  And in the end, its just an option for
some, but a better kernel for others.

	Robert Love

