Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136508AbRA1DzC>; Sat, 27 Jan 2001 22:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136528AbRA1Dyn>; Sat, 27 Jan 2001 22:54:43 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:53008 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S136508AbRA1Dyk>; Sat, 27 Jan 2001 22:54:40 -0500
Date: Sun, 28 Jan 2001 00:04:57 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre10 deadlock (Re: ps hang in 241-pre10)
In-Reply-To: <20010128031738.D31648@suse.de>
Message-ID: <Pine.LNX.4.21.0101280000550.12703-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Jan 2001, Jens Axboe wrote:

> On Sat, Jan 27 2001, Linus Torvalds wrote:
> > > What was the trace of this? Just curious, the below case outlined by
> > > Linus should be pretty generic, but I'd still like to know what
> > > can lead to this condition.
> > 
> > It was posted on linux-kernel - I don't save the dang things because I
> > have too much in my "archives" as is ;)
> 
> Ok I see it now, confused wrt the different threads...
> 
> > > Good spotting. Actually I see one more problem with it too. If
> > > we've started batching (under heavy I/O of course), we could
> > > splice the pending list and wake up X number of sleepers, but
> > > there's a) no guarentee that these sleepers will actually get
> > > the requests if new ones keep flooding in
> > 
> > (a) is ok. They'll go back to sleep - it's a loop waiting for requests..
> 
> My point is not that it's broken, but it will favor new comers
> instead of tasks having blocked on a free slot already. So it
> would still be nice to get right.
> 
> > >				 and b) no guarentee
> > > that X sleepers require X request slots.
> > 
> > Well, IF they are sleeping (and thus, if the wake_up_nr() will trigger on
> > them), they _will_ use a request. I don't think we have to worry about
> > that. At most we will wake up "too many" - we'll wake up processes even
> > though they end up not being able to get a request anyway because somebody
> > else got to it first. And that's ok. It's the "wake up too few" that
> > causes trouble, and I think that will be fixed by my suggestion.
> 
> Yes they may end up sleeing right away again as per the above a) case
> for instance. The logic now is 'we have X free slots now, wake up
> x sleepers' where it instead should be 'we have X free slots now,
> wake up people until the free list is exhausted'.
> 
> > Now, I'd worred if somebody wants several requests at the same time, and
> > doesn't feed them to the IO layer until it has gotten all of them. In that
> > case, you can get starvation with many people having "reserved" their
> > requests, and there not be enough free requests around to actually ever
> > wake anybody up again. But the regular IO paths do not do this: they will
> > all allocate a request and just submit it immediately, no "reservation".
> 
> Right, the I/O path doesn't do this and it would seem more appropriate
> to have such users use their own requests instead of eating from
> the internal pool.
> 
> -- 
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
