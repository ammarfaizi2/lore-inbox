Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278567AbRJZPBn>; Fri, 26 Oct 2001 11:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278605AbRJZPBY>; Fri, 26 Oct 2001 11:01:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5383 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S278583AbRJZPBS>;
	Fri, 26 Oct 2001 11:01:18 -0400
Date: Fri, 26 Oct 2001 17:01:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
Message-ID: <20011026170152.E3324@suse.de>
In-Reply-To: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com> <dnr8rqu30x.fsf@magla.zg.iskon.hr> <20011026163958.C3324@suse.de> <dnpu7asb37.fsf@magla.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dnpu7asb37.fsf@magla.zg.iskon.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26 2001, Zlatko Calusic wrote:
> > On Fri, Oct 26 2001, Zlatko Calusic wrote:
> > > Linus Torvalds <torvalds@transmeta.com> writes:
> > > 
> > > > On 25 Oct 2001, Zlatko Calusic wrote:
> > > > >
> > > > > Yes, I definitely have DMA turned ON. All parameters are OK. :)
> > > > 
> > > > I suspect it may just be that "queue_nr_requests"/"batch_count" is
> > > > different in -ac: what happens if you tweak them to the same values?
> > > > 
> > > 
> > > Next test:
> > > 
> > > block: 1024 slots per queue, batch=341
> > 
> > That's way too much, batch should just stay around 32, that is fine.
> 
> OK. Anyway, neither configuration works well, so the problem might be
> somewhere else.

Most likely, yes.

> While at it, could you give short explanation of those two parameters?

Sure. queue_nr_requests is the total number of free request slots per
queue. There are queue_nr_requests / 2 free slots for READ and WRITE.
Each request can be anywhere from fs block size and up to 127kB of data
per default. batch only matters once the request free list has been
depleted. In order to give the elevator some input to work with, we free
request slots in batches of 'batch' to get decent merging etc. That's
why numbers bigger than ~ 32 would not be such a good idea and only add
to bad latency.

> > > Still very spiky, and during the write disk is uncapable of doing any
> > > reads. IOW, no serious application can be started before writing has
> > > finished. Shouldn't we favour reads over writes? Or is it just that
> > > the elevator is not doing its job right, so reads suffer?
> > 
> > You are probably just seeing starvation due to the very long queues.
> > 
> 
> Is there anything we could do about that? I remember Linux once had a
> favoured reads, but I'm not sure if we do that likewise these days.

It still favors reads, take a look at the initial sequence numbers given
to reads and writes. We use to favor reads in the request slots too --
you could try and change the blk_init_freelist split so that you get a
1/3 - 2/3 ratio between WRITE's and READ's and see if that makes the
system more smooth.

> When I find some time, I'll dig around that code. It is very
> interesting part of the kernel, I'm sure, I just didn't have enough
> time so far, to spend hacking on that part.

Indeed it is.

-- 
Jens Axboe

