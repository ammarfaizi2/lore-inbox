Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285745AbSAIL1N>; Wed, 9 Jan 2002 06:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286238AbSAIL1E>; Wed, 9 Jan 2002 06:27:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:2894 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285745AbSAIL07>; Wed, 9 Jan 2002 06:26:59 -0500
Date: Wed, 9 Jan 2002 12:24:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Anton Blanchard <anton@samba.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020109122418.F1543@inspiron.school.suse.de>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <20020108142117.F3221@inspiron.school.suse.de> <20020108133335.GB26307@krispykreme> <E16Nxjg-00009W-00@starship.berlin> <20020108162930.E1894@inspiron.school.suse.de> <1010523340.3225.87.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1010523340.3225.87.camel@phantasy>; from rml@tech9.net on Tue, Jan 08, 2002 at 03:55:38PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 03:55:38PM -0500, Robert Love wrote:
> On Tue, 2002-01-08 at 10:29, Andrea Arcangeli wrote:
> 
> > "extra schedule points all over the place", that's the -preempt kernel
> > not the lowlatency kernel! (on yeah, you don't see them in the source
> > but ask your CPU if it sees them)
> 
> How so?  The branch on drop of the last lock?  It's not a factor in

exactly, this is the reschedule point I meant. Oh note that it's
unlikely also in the lowlatecy patch. Please count the number of time
you add this branch in the -preempt, and how many times we add this
branch in the lowlat and then tell me who is adding rescheduling points
in the kernel all over the place.

> This makes me think the end conclusion would be that preemptive
> multitasking in general is bad.  Why don't we increase the timeslice and
> and tick period, in that case?

that would increase performance, but we'd lost interactivity.

> One can argue the complexity degrades performance, but tests show
> otherwise.  In throughput and latency.  Besides, like I always say, its

which benchmarks? you should make sure the CPU spend all its cycles in
the kernel to benchmark the perfrormance degradation (this is the normal
case of webserving with a few gigabit ethernet cards using sendfile).

> ride.  On the other hand, the patch has a _huge_ userbase and you can't

I question this because it is too risky to apply. There is no way any
distribution or production system could ever consider applying the
preempt kernel and ship it in its next kernel update 2.4. You never know
if a driver will deadlock because it is doing a test and set bit busy
loop by hand instead of using spin_lock and you cannot audit all the
device drivers out there. It is not like the VM that is self contained
and that can be replaced without any caller noticing, this instead
impacts every single driver out there and you'd need to audit all of
them, which is not feasible I think and that should be done by giving
everybody the time to test. This is also what makes preempt config
option risky, if we go preempt we should force everybody to use it, at
least during 2.5, so we get the useful feedback from testers of all the
hardware, or nobody could trust -preempt.

NOTE: I trust your work with spinlocks, locks around per-cpu data
structures etc.. is perfect, I trust that part, as said it's the driver
doing test and set bit that you cannot audit that is the problem here
and that makes it potentially unstable, not your changes.  And also the
per-cpu data structures sounds a little risky (but for example for UP
that's not an issue).

> question that.  You also can't question the benchmarks that show
> improvements in average _and_ worst case latency _and_ throughput.

I don't question some benchmark is faster with -preempt, the interesting
thing is to find why because it shouldn't be the case, Andrew for
example mentioned software raid, there are good reasons for which
-preempt could be faster there, so we added a single sechdule point and
we just have that case covered in 18pre2aa1, we don't need reschedule
points all over the place like in -preempt to cover things like that.
It is good to find them out so we can fix those bugs, I consider them
bugs :).

Again: I'm not completly against preempt, it can reach an mean latency
much lower than mainline (it can reschedule immediatly in the middle of
long copy-users for example), so it definitely has a value, it's just
that I'm not sure if it worth it.

Andrea
