Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSFOIQI>; Sat, 15 Jun 2002 04:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSFOIQH>; Sat, 15 Jun 2002 04:16:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35521 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315120AbSFOIQC>;
	Sat, 15 Jun 2002 04:16:02 -0400
Date: Sat, 15 Jun 2002 10:15:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020615081544.GC1359@suse.de>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D09F769.8090704@evision-ventures.com> <20020614151703.GB1120@suse.de> <3D0A1692.6070304@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14 2002, Martin Dalecki wrote:
> >- current 2.5 bk deadlocks reading partition info off disk. Again a
> >  locking problem I suppose, to be honest I just got very tired when
> >  seeing it happen and didn't want to spend tim looking into it.
> 
> 2.5.21 + the patches I did doesn't. Likely it's the driverfs?

This particular problem I don't know, I'm simply just out lining it.

> >I thought IDE locking couldn't get worse than 2.4, but I think you are
> >well into doing just that. What exactly are you plans with the channel
> >locks? Right now, to me, it seems you are extending the use of them to
> >the point where they would be used to serialize the entire request
> >operation start? Heck, ide-cd is even holding the channel lock when
> >outputting the cdb now.
> 
> After extracting out 80% of the host controller register file
> access one has to realize that in reality we where releasing the lock
> just to regain it immediately. Or alternatively accessing them
> without any lock protection at all. (Same goes for BIO ummer layer
> memmbers.) This is why they are pushed up. It's just avoiding the
> "windows" between unlock and immediate relock and making the real
> behaviour more "obvious". You have just realized this.

I know the locking needs to be reworked, it just very much looks like
that you are just extending the scope of the channel lock to basically
be held the entire way through. I'm hoping this is just a transition?

> 2.4 prevents the locking problems basically by georgeously
> disabling IRQs. Too fine grained locking is a futile exercise.

Yep

> Unless I see the time spent in system state during concurrent disk
> access going really up (it doesn't right now), I don't see any thing
> bad in making the locking more coarse. Locks don't came for free and
> having fine grained locking isn't justifying itself.

That's silly. Most of the "locking" required is just serializing access
to the channel (or interface). Just making the locking coarse and
grabbing it to do just that is pretty dumb.

> Another "usual Marcin approach" - don't optimze for the sake of it.
> See futile unlikely() tagging and inlining in tcq.c for example.
> I don't do somethig like that. I have just written too much
> numerical code which was really time constrained to do something
> like this before looking at benchmarks.
> Really constrained means having a program running 7 or "just"
> 5 *days*. This can make a difference, a difference in hard real
> money on the range of multiple kEUR!

Listing to complaints about unlikely() as micro-optimization from
someone who doesn't think that using a spin lock to serialize looong
operations is a problem doesn't carry a lot of weight, sorry. I don't
know why you bring this up again, I've already stated my case in the
last mail and I see no reason to repeat it.

> Finally - unless there appears some aother way to block access to
> busy devices on the generic block layer I do it the only way
> we have right now - spinlocks. (... looking forward to working
> queue pugging and the work done by Adam richter).

First of all, queue plugging works now. Second, this is no excuse for
using a spin lock to serialize request starts?! Please tell me you don't
really mean this. At worst you could have spurious request_fn runs
before, but that's hardly a big problem. I know the start/stop queue is
a nicer interface (that's why it's there now), but there's nothing wrong
with simply recalling your queueing function once a request completes.
That's how it was done before too. In short, this is not an argument, it
has little relevance to this case. And the big-bio stuff, how is that
relevant?

> Unless there is a sane way to signal partial completion - we will
> be doing it at once. Unless we have a sane async io infrastructure
> most of the above will be likely not solved anyway.

??

> >  ata_device?! we are serializing requests for ata_device's on the
> >  ata_channel anyways, which is why it made sense to have the active
> >  request there.
> 
> Becouse it is going to go away altogether. We need it there
> just only for the purpose of the default ide_timer_expiry function, which
> is subject to go away since a long time. And finally becouse
> it doesn't hurt.

Because it doesn't hurt? From the same book of code writing an
optimization? Again, the serialization point is the channel, why move
the active request to the drive?! To me, this is loosing information
and making the whole thing more confusing.

> Further on I refer you to the discussion we had (or was it Linus?)
> once about the fact that attaching physical properties of the
> device to the request queue and replicating those parameters in
> every single request struct, is well ... "unpleasant" on behalf of the

The drive <-> queue relationship has no bearing on the active request
serialization.

> upper layers. Loop devices expose the same problem.

Please explain the loop case?

> Once again just grepping for hard_ memebers of the struct
> request makes it obvious.

Do you understand why we have the hard_ members? It seems you don't,
because I don't see how that is remotely related to this. The hard_
members are just there so that low level drivers can screw with the
nr_sectors and current_nr_sectors as much as they want, and the block
layer can still maintain a consistent request state regardless of what
happens.

> Somce people say that using the gratest common denominator in
> the case of the loop devices is the  solution,
> but I think that it's rather a work around.

This sounds like nonsense.

> >And finally a small plea for more testing. Do you even test before
> >blindly sending patches off to Linus?! Sometimes just watching how
> >quickly these big patches appears makes it impossible that they have
> >gotten any kind of testing other than the 'hey it compiles', which I
> >think it just way too little for something that could possible screw
> >peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
> >currently. The success ratio of posted over working patches is too big.
> 
> Fact is: many of the patches are just big becouse they contain
> host chip handling cleanups done by others, and becouse
> we have just too many different drivers for the same purpose:
> ATAPI packet command devices. Which I'm more and more tempted
> to scarp... in favour of just ide-scsi.c. But that's another
> story. (Adam J. Richter is givng me constant preassure to do just that and 
> I start really tending to admitt that he is just right.)

Yeah I know that they are mostly big because of cleanups, and I'm not
worried about that at all. But even when just maybe 10% of the patch is
changing stuff radically, problems can sneak in. Plus, there appears to
be no clear goal in what you are doing. Things change in one direction
one day, back in another the next day. I have a hard time seeing how
this will lead to a cleaner and more maintainable code base.

> As of testing. Well at least I can assure you that I'm eating my dogfood,
> since I run constantly on the patches. (Heck even the time I write this.)

That's good for you, but a single person testing is usually not enough.
Especially not with stuff like IDE where there are sooo many different
pieces of hardware and setups out there. I'm not saying that you should
do complete validation of the code every single time, but maybe having a
bleding edge tree and a linus tree would go along way. Then you could
ship cleanups as much as you want, but do the more radical changes a bit
slower. I think that would also solve your direction problem, letting
the more radical changes mature a bit before shipping it.

> But I don't use kernels from the BK repository at all.
> In fact I just don't use BK at all and I don't intend too.

Doesn't matter. Fact is, you don't know when Linus will tag the BK tree
as the next release. Or how many of your ide-xx patches are in at that
point.

-- 
Jens Axboe

