Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274666AbRJJEDi>; Wed, 10 Oct 2001 00:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRJJED2>; Wed, 10 Oct 2001 00:03:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:55840 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274634AbRJJEDP>; Wed, 10 Oct 2001 00:03:15 -0400
Date: Wed, 10 Oct 2001 06:03:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@ufl.edu>
Cc: safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010060334.G726@athlon.random>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010031803.F8384@athlon.random> <20011010020935.50DEF1E756@Cantor.suse.de> <20011010043003.C726@athlon.random> <1002681480.1044.67.camel@phantasy> <20011010050630.E726@athlon.random> <1002684288.862.123.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002684288.862.123.camel@phantasy>; from rml@ufl.edu on Tue, Oct 09, 2001 at 11:24:36PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 11:24:36PM -0400, Robert Love wrote:
> On Tue, 2001-10-09 at 23:06, Andrea Arcangeli wrote:
> > [...]
> > I think the issue you raise is that dbench gets a 10msec more of cpu
> > time and xmms starts running 10msec later than expected (because of the
> > scheduler latency peak worst case of 10msec).
> > 
> > But that doesn't matter. The scheduler isn't perfect anyways. The
> > resolution of the scheduler is 10msec too, so you can easily lose 10msec
> > anywhere else no matter of whatever scheduler latency of 10msec. [...]
> 
> I agree with generally everything you say.
> 
> I think, however,  you are making two assumptions:
> 
> (a) xmms has a very large leeway in the timing of its execution

Yes.

> (b) the maximum time a process sits in kernel space is 10ms.

Actually a task can sit in the kernel for its whole life and still
provide usec scheduler latencies (ksoftirqd)

> While I agree (a) is true, it may not be so in all scenerios. 

Correct, of course if you run xmms on a 16mhz CPU it will dropout no
matter of the size of the dma buffer. And you're right the slower the
CPU is the strictier the scheduler latency requirements to avoid the
dropouts are.  If the CPU is very slow as soon as xmms gets runnable it
may not have enough time to decode the next mp3 data before the DMA ring
drys out.

So yes I'm assuming doing playback on any recent cpu where xmms just
hurts because it generates high frequency reschedule that in turns means
tlb flushing on x86 (not because of the real cpu load). And mostly
because of its "moving" GUI, not even because of the sound backend :). 

> Furthermore, the specified leeway does not exist for all timing-critical
> tasks.  Not all of these tasks are specialized real-time applications,
> either.
> 
> Most importantly, however, the maximum latency of the system is not
> 10ms.  Even _with_ preemption, we have observed greater latencies (due
> to long held locks).

I was reading a very detailed latency analyse done on the 2.4.10 SuSE
kernel by Takashi and it showed 10msec peaks of worst case latency.

The stress during the latency measurement were x11perf (but ok, that's
mostly userspace), /proc with top, disk write, disk read and disk copy.

But of course in -aa as said there's just the most important part of the
low latency patch included, so without -aa I know for sure that the
scheduler latency can run up to several seconds with lots of ram in the
system (this is why I included only those scheduler points even in 2.2
for the multigigabyte machines, where the lack of rescheduling in
read/write could become a patological case visible with eyes while
typing in the shell).

And of course if you only apply the preempt patch and you don't add the
explicit points in the cpu hogs under locks, you'll cover only
copy-user lock less and semaphore parts, but not the other bits like the
ones in the memory management that are also covered since 2.4.1[01] and
in recent 2.2.

> This is why I believe the a preemptible kernel benefits more than just
> real-time signal processing.

Provided that read/write gets fixed like in either Andrew's patch,
Ingo's patch or -aa, I believe it cannot make any visible difference for
mp3 playback in any recent machine. Feel free to experiment yourself
with 2.4.11aa1.

Andrea
