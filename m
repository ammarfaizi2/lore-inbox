Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbSKMA0h>; Tue, 12 Nov 2002 19:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267058AbSKMA0h>; Tue, 12 Nov 2002 19:26:37 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:42128 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267057AbSKMA0f>;
	Tue, 12 Nov 2002 19:26:35 -0500
Date: Wed, 13 Nov 2002 01:33:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Message-ID: <20021113003312.GF6133@dualathlon.random>
References: <20021112035723.GA17642@dualathlon.random> <3DD0C0E6.4A8035A4@digeo.com> <20021112181532.GA6133@dualathlon.random> <3DD15A79.768C1066@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD15A79.768C1066@digeo.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 11:46:01AM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > 
> > no, you forgot readahead, that's buggy and needs fixing in readpage too
> > (same in 2.4 and 2.5).
> 
> readahead in 2.5 unplugs.  Which is quite wrong for AIO, but is unavoidable
> given the current situation...

Current situation?? I fixed these bugs and you certainly didn't know
about them previously. Furthmore writeback won't unplug or it would suck
totally period, so you still need it at the page layer too.

> > > I dunno.  I bet there are still more holes, and I for one am heartily sick
> > > of unplug bugs.  Why not make the damn queue unplug itself after ten
> > > milliseconds or 16 requests?  I bet that would actually increase throughput,
> > > especially in the presence of kernel preemption and scheduling points.
> > 
> > This doesn't remove the need to avoid the mean 5 msec delay before the
> > queue unplug (I know the race triggers rarely though, but if we left all the
> > places broken the number of 5msec mean waits will increase bug by bug
> > over time). I'm not very excited by the idea (in particular for 2.4), if
> > it performs so much better I would say it's a broken length of the queue
> > that is way too oversized and that leads to other problems with fariness
> > of task against task etc... We need the big number of requests with
> > small requests only, with big requests we should allow only very few
> > requests to be returned.
> 
> No, no, no.  Step back, miles back.  Forget the current implementation
> and ask yourself "what is a good design for plugging?".  Because I can
> assure you that if someone came out and proposed the current design for
> inclusion in today's kernel, they would be pulverised.
> 
> Plugging is an optimisation which is specific to, and internal to the
> request layer.  It should not require that every client of that layer
> know about it, and be careful to unplug (with bizarrely complex locking
> and ordering rules) simply because the request layer is too lame to look
> after its own stuff.
> 
> Particularly because the clients of the request layer do not have enough
> information to make a good decision about when to unplug.  Only the
> request layer knows that.
> 
> And particularly because we've been hitting the same darn bug for years.
> And we've been blaming the poor old callers!
> 
> The request layer should perform its own unplug "when the time is right",
> and the external unplug should be viewed as an optimisation hint.
> 
> It all becomes rather obvious when you try to answer the question "when
> should the kernel unplug for AIO reads"?
> 
> And yes, the fact that the time-based component of the unplug decision
> would obscure failure by callers to make use of the optimisation hint
> is unfortunate.  But it's only a few callsites, and 99.9999% coverage
> there is good enough.

so what? you agree the hint is needed and if you don't fix the race it's
like no hint at all and you wait 5 msec in mean which I don't want to,
period. Ok 5 msec isn't too bad (yeah also the current 2.5sec hangs with
ext2 aren't too bad) but they're still a not too bad _bugs_. The more
not too bad bugs you add the more the things will start to get worse and
worse.

then tell me how to unplug from a timer irq, with a context switch, not
nice.

Anyways I think the answer to the question "when to unplug" has nothing
to do with these races, when wait_on_buffer arrives and says "I need
this I/O completed ASAP" that request must arrive to the blkdev layer,
no matter how and no matter if it would lead to a deadlock or not.

We have bugs in delivering the "I need this I/O completed ASAP" message,
not in the "when to unplug" algorithm. You're arguing about a totally
different thing. Incidentally now the two things tends to overlap but
that's just incidental and IMHO it is very an efficient solution, more
than doing a context switch at every unplug like you're suggesting, most
probably to hide an overkill size of some I/O queue. We just have a
background unplug every 5 sec (unless the system hangs for bugs in other
places), if there are only a few requests in the queue that's fine to
delay them every 5 sec. So in short I think the current logic is just
fine, feel free to prove me wrong send me a patch and I will benchmark
it, I only reserve the possibility of fixing the blkdev layer in case
your patch would workaround any stupid thing there.

Last but not the least by your argument that these fixes are useless I
could as well fix our hang completely by simply adding a new kernel
thread doing schedule_timeout(1); run_queue_task(&tq_disk) in a loop, if
I would ever remotely do anything like that you would be flaming me for
not fixing the real bug, and still I would suffer from 5 msec slowdowns
in the buggy places, just like your universal unplug solution suffers
too.

Not fixing these races would be very bad, I'm totally stunned that
you're against these fixes and you propose to hide these bugs and to
make the system worse and worse over time.

Andrea
