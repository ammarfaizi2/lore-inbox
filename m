Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285129AbRLLKBY>; Wed, 12 Dec 2001 05:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285134AbRLLKBO>; Wed, 12 Dec 2001 05:01:14 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:32778 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285129AbRLLKA7>; Wed, 12 Dec 2001 05:00:59 -0500
Message-ID: <3C172A8A.3760C553@zip.com.au>
Date: Wed, 12 Dec 2001 01:59:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <3C15B0B3.1399043B@zip.com.au> <Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>, <Pine.LNX.4.33L.0112111130110.4079-100000@imladris.surriel.com>; <20011211144634.F4801@athlon.random> <3C1718E1.C22141B3@zip.com.au>,
		<3C1718E1.C22141B3@zip.com.au>; from akpm@zip.com.au on Wed, Dec 12, 2001 at 12:44:17AM -0800 <20011212102141.Q4801@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> > The swapstorm I agree is uninteresting.  The slowdown with a heavy write
> > load impacts a very common usage, and I've told you how to mostly fix
> > it.  You need to back out the change to bdflush.
> 
> I guess i should drop the run_task_queue(&tq_disk) instead of replacing
> it back with a wait_for_some_buffers().

hum.  Nope, it definitely wants the wait_for_locked_buffers() in there.
36 seconds versus 25.  (21 on stock kernel)

My theory is that balance_dirty() is directing heaps of wakeups
to bdflush, so bdflush just keeps on running.  I'll take a look
tomorrow.

(If we're sending that many wakeups, we should do a waitqueue_active
test in wakeup_bdflush...)

> ...
>
> Note that the first elevator (not elevator_linus) could handle this
> case, however it was too complicated and I'm been told it was hurting
> too much the performance of things like dbench etc.. But it was allowing
> you to take a few seconds for your test number 2 for example. Quite
> frankly all my benchmark were latency oriented, but I couldn't notice
> an huge drop of performance, but OTOH at that time my test box had a
> 10mbyte/sec HD, and I know for experience that on such HD numbers tends
> to be very different than on fast SCSI and my current test hd IDE
> 33mbyte/sec so I think they were right.

OK, well I think I'll make it so the feature defaults to "off" - no
change in behaviour.  People need to run `elvtune -b non-zero-value'
to turn it on.

So what is then needed is testing to determine the latency-versus-throughput
tradeoff.  Andries takes manpage patches :)

> ...
> > - Your attempt to address read latencies didn't work out, and should
> >   be dropped (hopefully Marcelo and Jens are OK with an elevator hack :))
> 
> It should not be dropped. And it's not an hack, I only enabled the code
> that was basically disabled due the huge numbers. It will work as 2.2.20.

Sorry, I was referring to the elevator-bypass patch.  Jens called
it a hack ;)

> Now what you want to add is an hack to move the read at the top of the
> request_queue and if you go back to 2.3.5x you'll see I was doing this,
> that's the first thing I did while playing with the elevator. And
> latency-wise it was working great. I'm sure somebody remebers the kind
> of latency you could get with such an elevator.
> 
> Then I got flames from Linus and Ingo claiming that I screwedup the
> elevator and that I was the source of the 2.3.x bad I/O performance and
> so they required to nearly rewrite the elevator in a way that was
> obvious that couldn't hurt the benchmarks and so Jens dropped part of my
> latency-capable elevator and he did the elevator_linus that of course
> cannot hurt performance of benchmarks, but that has the usual problem
> you need to wait 1 minute for xterm to be stared under a write flood.
> 
> However my object was to avoid nearly infinite starvation and the
> elevator_linus avoids it (you can start the xterm it in 1 minute,
> previously in early 2.3 and 2.2 you'd need to wait for the disk to be
> full, and that could take some day with some terabyte of data). So I was
> pretty much fine with elevator_linus too but we very well known reads
> would be starved again significantly (even if not indefinitely).
> 

OK, thanks.

As long as the elevator-bypass tunable gives a good range of
latency-versus-throughput tuning then I'll be happy.  It's a
bit sad that in even the best case, reads are penalised by a
factor of ten when there are writes happening.

But fixing that would require major readahead surgery, and perhaps
implementation of anticipatory scheduling, as described in
http://www.cse.ucsc.edu/~sbrandt/290S/anticipatoryscheduling.pdf
which is out of scope.

-
