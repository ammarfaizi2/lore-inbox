Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbRCCUOG>; Sat, 3 Mar 2001 15:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbRCCUN4>; Sat, 3 Mar 2001 15:13:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23721 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129734AbRCCUNi>;
	Sat, 3 Mar 2001 15:13:38 -0500
Date: Sat, 3 Mar 2001 15:13:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jens Axboe <axboe@suse.de>
cc: agrawal@ais.org, linux-kernel@vger.kernel.org
Subject: Re: lingering loopback bugs?
In-Reply-To: <20010303205036.N2528@suse.de>
Message-ID: <Pine.GSO.4.21.0103031455430.19484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Mar 2001, Jens Axboe wrote:

> On Sat, Mar 03 2001, Alexander Viro wrote:
> > > Look for the patch I posted yesterday (hint: just remove these two
> > > lines from loop_end_io_transfer)
> > > 
> > >                if (atomic_dec_and_test(&lo->lo_pending))
> > >                        up(&lo->lo_bh_mutex);
> > 
> > Uhh... And what will compensate for atomic_inc() in loop_make_request() in
> > case of loop over block device?
> 
> There is no atomic_inc() in loop_make_request, I moved it to
> count pending bh on the queue only. But hmm, we should not
> be able to remove it while it has bhs in flight. Ok, I'll
> rearrange this a bit again...

Notice that up() is triggered _only_ on the clr_fd() - until then
->lo_pending is at least 1. Lo_rundown is exactly that - mode when
we've already given that barrier up and just wait for the last
guy to up that semaphore while loop_thread queue is empty. Which
will make loop_thread terminate.

	BTW, I think I see a possible problem. How about replacing
atomic_dec() in loop_thread with
		if (atomic_dec_and_test(...))
			break;
to handle the case where we have pending requests at the clr_fd time
and the last one happens to be in the queue?
							Cheers,
								Al

