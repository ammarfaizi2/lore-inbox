Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279389AbRJ3I4R>; Tue, 30 Oct 2001 03:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279528AbRJ3Iz5>; Tue, 30 Oct 2001 03:55:57 -0500
Received: from 25.ppp1-1.ski.worldonline.dk ([212.54.89.25]:27264 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S279389AbRJ3Iz4>; Tue, 30 Oct 2001 03:55:56 -0500
Date: Tue, 30 Oct 2001 09:56:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Zlatko Calusic <zlatko.calusic@iskon.hr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, linux-mm@kvack.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
Message-ID: <20011030095606.I618@suse.de>
In-Reply-To: <E15xu2b-0008QL-00@the-village.bc.nu> <Pine.LNX.4.33.0110280945150.7360-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110280945150.7360-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28 2001, Linus Torvalds wrote:
> 
> On Sun, 28 Oct 2001, Alan Cox wrote:
> >
> > > Does the -ac patches have any hpt366-specific stuff? Although I suspect
> > > you're right, and that it's just the driver (or controller itself) being
> >
> > The IDE code matches between the two. It isnt a driver change
> 
> It might, of course, just be timing, but that sounds like a bit _too_ easy
> an explanation. Even if it could easily be true.
> 
> The fact that -ac gets higher speeds, and -ac has a very different
> request watermark strategy makes me suspect that that might be the cause.
> 
> In particular, the standard kernel _requires_ that in order to get good
> performance you can merge many bh's onto one request. That's a very
> reasonable assumption: it basically says that any high-performance driver
> has to accept merging, because that in turn is required for the elevator
> overhead to not grow without bounds. And if the driver doesn't accept big
> requests, that driver cannot perform well because it won't have many
> requests pending.

Nod

> In contrast, the -ac logic says roughly "Who the hell cares if the driver
> can merge requests or not, we can just give it thousands of small requests
> instead, and cap the total number of _sectors_ instead of capping the
> total number of requests earlier".

Not true, that was not the intended goal. We always want the driver to
get merged requests, even if we can have ridicilously large queue
lengths. The large queues were a benchmark win (blush), since it allowed
the elevator to reorder seeks across a big bench run effieciently. I've
later done more real life testing and I don't think it matters too much
here, in fact it only seems to incur greater latency and starvation.

> In my opinion, the -ac logic is really bad, but one thing it does allow is
> for stupid drivers that look like high-performance drivers. Which may be
> why it got implemented.

Don't mix up the larger queues with lack of will to merge, that is not
the case.

> And it may be that the hpt366 IDE driver has always had this braindamage,
> which the -ac code hides. Or something like this.
> 
> Does anybody know the hpt driver? Does it, for example, limit the maximum
> number of sectors per merge somehow for some reason?

hpt366 has no special work arounds or stuff it disables, it can't be
anything like that.

-- 
Jens Axboe

