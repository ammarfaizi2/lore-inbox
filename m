Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTGOGTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTGOGTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:19:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63418
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263462AbTGOGTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:19:13 -0400
Date: Tue, 15 Jul 2003 08:33:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Chris Mason <mason@suse.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
Message-ID: <20030715063339.GC30537@dualathlon.random>
References: <20030713090116.GU843@suse.de> <20030713191921.GI16313@dualathlon.random> <20030714054918.GD843@suse.de> <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva> <20030714131206.GJ833@suse.de> <20030714195138.GX833@suse.de> <20030714201637.GQ16313@dualathlon.random> <20030715052640.GY833@suse.de> <20030715054806.GA30537@dualathlon.random> <20030715060135.GF833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715060135.GF833@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 08:01:36AM +0200, Jens Axboe wrote:
> On Tue, Jul 15 2003, Andrea Arcangeli wrote:
> > On Tue, Jul 15, 2003 at 07:26:40AM +0200, Jens Axboe wrote:
> > > On Mon, Jul 14 2003, Andrea Arcangeli wrote:
> > > > On Mon, Jul 14, 2003 at 09:51:39PM +0200, Jens Axboe wrote:
> > > > > -	rl = &q->rq;
> > > > > -	if (!list_empty(&rl->free) && !blk_oversized_queue(q)) {
> > > > > +	if ((rw == WRITE) && (blk_oversized_queue(q) || (rl->count < 4)))
> > > > 
> > > > did you disable the oversized queue check completely for reads? This
> > > 
> > > Yes
> > > 
> > > > looks unsafe, you can end with loads of ram locked up this way, the
> > > > request queue cannot be limited in requests anymore. this isn't the
> > > > "request reservation", this a "nearly unlimited amount of ram locked in
> > > > for reads".
> > > 
> > > Sorry, but I think that is nonsense. This is the way we have always
> > > worked. You just have to maintain a decent queue length still (like we
> > 
> > But things don't work that way anymore. dropping the check now will lead
> > to an overkill amount of ram to be locked in.
> > 
> > I enlarged the queue further, since I could, there's no point in having
> > a few kbytes of queue during seeks, when the big queue helps most. Now
> > you can have mbytes (not kbytes) of queue during seeks. But you can't
> > keep it unlimited anymore or you'll generate troubles to the VM and
> > it'll generate a 90/10 distribution as well, if you start filling it
> > with many readers. 
> 
> That you pushed MAX_NR_REQUESTS is a really bad idea in my oppinion.
> What is the point of having 4MB worth of seeks in the queue? Know you
> can fit exactly 1024 seeks in there, with a average seek time of 10 ms
> that's over 10 seconds of waiting. That logic is at least as warped as
> having 128 64KiB streamed writes in the queue (the problem we had
> before), if that is a streamed write it will only take a fraction of the
> time the seeky work load will. Even with one seek in between each write,
> it's still better...

they may be too many, feel free to shrink it, but I liked the idea of
having more than 128 requests to apply the elevator to an extensive
amount of requests. You know your 10msec mean seek time may go down if
we can pass all 1024 in order. Ordering in blocks of 128 is much worse
than in blocks of 1024.

> > the reasons things changed is that the "decent queue length" wasn't
> > decent nor for contigous I/O (it was way too permissive for contigous
> > I/O) nor for seeking I/O (it was way too restrictive for seeking I/O).
> 
> On that we agree. I just think you took it to the other extreme know,
> we'll see seek storms penalizing work loads now instead of write bombs.

possible.

> So yes it did solve the write bomb, but introduced another problem.
> Write bomb problem is easier hit of course, but hey you cannot leave the
> other one open can you? That'd be like allowing reads to pin down all
> memory :)

that's different. This is only a fariness issue across different tasks.
It won't affect VM reliability in freeing ram, or anything like that,
just the user wait time for its I/O.

> > > It is _not_ unsafe, stop spewing nonsense like that. The patch should
> > 
> > it isn't only unsafe for the potentially full ram of the box going
> > locked (on lowmem boxes of course) but also because you can easily
> 
> Correct. Speaking of low mem, using 4 times as many requests on a queue
> isn't exactly peaches for low mem consumption on big disk machines
> either.

I did the math, IIRC it was some hundred k per spindle, it didn't look
too bad. If you shrink it for other reasons this will go down too.

But regardless I wouldn't rely on the number of requests anymore as a
limiting factor.

Of course the 4M thing is terribly ugly too as a fixed magic number, but
it's still an order of magnitude better than the fixed magic number of
requests of pre2.

> > If you benchmarked with a 2-way or even better on an UP box, then likely
> > we can get still a relevant speedup even with the starvation fixed and w/o the
> > 90/10 distribution (i.e. too many reads in the queue).
> 
> I bench on a 2-way.

ok. If it was a UP I would been very impressed but even on a 2-way is
very significant (I mean, not too likely to have the starvation and
90/10 distribution effect with only 8 tasks on few dozen kbytes small .c
files where readahead can't pump too many async reads into the queue).

> > I thought contest was using a quite big -j, but it's ""only"" -j8 for a
> > 2-way (HT cpus have to be included). So your results may still
> > apply, despite the patch wasn't safe and it could penalize writes to the
> 
> You only had to look a the numbers posted to see that that was the case.

I wasn't sure how to measure the slowdown of the writer. Now I know it's
a 31% slowdown of the writer compared to a 2x% improvement for the
kernel compile.  It's still not completely obvious that some "sigstop
write" effect is going on. 

> > point of not allowing them to execute anymore for indefinite time (I
> > mean: a fixed patch that doesn't have those bugs could generate
> > similar good results [for reads] out of contest).
> 
> Completely agree, and I'll proceed to make such a patch today. I hope we
> can agree not to waste more time discussion the merrit (that is clear,
> it's a win) and applicability of the patch I posted. I showed numbers,
> and that was it.

If you can reproduce them today on a patch that can't block the writer
(with indefinite starvation or 90/10 distribution) I will sure agree
it's an obvious goodness that would bring a further responsiveness
improvement for reads on top of the elevator-lowlatency.

thanks,

Andrea
