Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274305AbRJJCv1>; Tue, 9 Oct 2001 22:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274299AbRJJCvS>; Tue, 9 Oct 2001 22:51:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:36380 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274305AbRJJCvF>; Tue, 9 Oct 2001 22:51:05 -0400
Date: Wed, 10 Oct 2001 04:51:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Robert Love <rml@ufl.edu>
Cc: safemode <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010045135.D726@athlon.random>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org> <20011010031803.F8384@athlon.random> <1002679828.866.33.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002679828.866.33.camel@phantasy>; from rml@ufl.edu on Tue, Oct 09, 2001 at 10:10:26PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 10:10:26PM -0400, Robert Love wrote:
> On Tue, 2001-10-09 at 21:18, Andrea Arcangeli wrote:
> > xmms skips during I/O should have nothing to do with preemption.
> 
> Why does preemption patch make a difference for me, then?  I'm not doing
> anything even remotely close to real-time processing.

I don't see how can it make any difference with buffered playback of
data. It doesn't make sense that it make any difference.

The only factors that can generate xmms skips are:

1) vm write throttling, xmms blocking for seconds during a page fault
   or while reading the mp3 from disk waiting I/O submitted by another
   I/O bound application (or also xmms blocking swapping out some page
   during swapout storms)

   I've ideas on how to avoid the write throttling of xmms with heuristics in
   balance_dirty(), the swapout blocking cannot be avoided instead (it
   has to block or die)

   This problem cannot be avioided from userspace.

2) xmms isn't getting enough cpu, like running xmms on a 386 with 16mhz,
   it will generate dropouts, run xmms RT or give it the right amount
   of cpu using priorities to fix the dropouts

3) a scheduler latency of the order of the seconds, the only thing
   that could generate that could be the read/write paths with lofs of
   cache

Ah, wait a moment, if the preemptive patch fixes your problem I guess
you're hitting the lack of preemption in read/write. I tend to forget
about that since I've fixed it ages ago in -aa in both 2.2 and 2.4 by
putting the needed preemption points in the copy-users exactly because
that could really hang the machine for many seconds on a multi-gb ram
box. Andrew suggested to move the scheduler points down to
generic_file_read/write and I plan to do that soon.

So could you please check if running -aa or the preemptive patch makes
any difference for you while using xmms?

> > As Alan noted for the ring of dma fragments to expire you need a
> > scheduler latency of the order of seconds, now (assuming the ll points
> > in read/write paths) when we've bad latencies under writes it's of the
> > order of 10msec and it can be turned down further by putting preemption
> > checks in the buffer lru lists write paths.
> 
> Isn't mp3 decoding done `just in time' ie we decode x and buffer x,

mp3 decoding is done with an huge buffering, this means even if xmms
runs after 0.5 sec after it got the wakeup (due scheduler latency
problems) it will have no problem to decode the rest of the mp3 and put
it in the buffer to the soundcard.

Of course if xmms runs after the soundcard dma ring dried out, then
there will be a dropout, but it would need seconds of scheduler latency
to generate such a dropout which isn't going to happen.

Of course if you divide the cpu across 100 tasks all cpu hogs, then it
is likely xmms will run once every few seconds, (if you assume all tasks
are pure cpu hogs it will be a round robin) but that's completly
unrelated to the preemption latency.

> decode y and buffer y...hopefully in a quick enough manner it sounds
> like coherent sound?  Thus, if the task can not be scheduled as
> required, there are noticeable latencies in the sound not because the
> sound card buffer ran dry but because the mp3 couldn't even be decoded
> to fill the buffer!
> 
> Anyhow, if we have latencies of 10ms (and in reality there are higher
> latencies, too), these can cause the sort of system response scenerios
> that are a problem.  Preemption makes these latencies effectively 0
> (outside of locks).

almost all kernel cpu hogs (except the copy users where I put the
reschedule points) that can stall the systems for mseconds are covered
by locks. So we need to do stuff like in vmscan.c::shrink_cache also
with the preemptive kernel patch, but then calling schedule explicitly
won't make any difference in both scheduler latency and performance (it
will be actually faster because you do the explicit preemption check
only in the cpu hogs rather than in the last spin_unlock.

Andrea
