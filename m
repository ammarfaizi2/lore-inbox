Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281950AbRKUS46>; Wed, 21 Nov 2001 13:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281943AbRKUS4t>; Wed, 21 Nov 2001 13:56:49 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:65187 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281451AbRKUS4h>; Wed, 21 Nov 2001 13:56:37 -0500
Date: Wed, 21 Nov 2001 11:56:27 -0700
Message-Id: <200111211856.fALIuRX22920@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v196 available
In-Reply-To: <Pine.LNX.4.33.0111211332070.7061-100000@serv>
In-Reply-To: <200111201819.fAKIJpp10565@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0111211332070.7061-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> On Tue, 20 Nov 2001, Richard Gooch wrote:
> 
> > Delayed events are harmless, since devfs ensures correct ordering.
> 
> It's not about ordering, timing is currently unpredictable, anything
> timing sensitive has to be very careful to touch anything in devfs.

Are you talking about user-space or kernel-space? I assume you mean
user-space. And it's only a problem if you have module autoloading
enabled, *and* you are attempting a lookup of a non-existant inode.
I'd argue that if you have applications which are timing sensitive,
you shouldn't be autoloading modules anyway, you should have them
statically loaded or built into the kernel. Loading a module remains a
heavyweight operation.

> > After consideration, I've decided to dynamically grow the event buffer
> > as required, and free up space as it's not needed.
> 
> You should use a slab cache and acknowledge events as soon as they
> are finished. Right now all processes are waiting until the devfsd
> is completely finished and restarted at the same time. This is
> currently limited by dropping events, with a dynamic event queue
> this can become a problem.

I'm concerned about the overhead of allocating an entry. With the
current scheme, the common case is that the buffer doesn't overflow,
and hence it's usually "good enough". In addition, it's very fast,
since it takes few instructions to "allocate" an entry (grab a lock,
test and update some pointers).

If the slab cache is fast enough on allocations (for the common case),
then it has clear advantages, since it makes cleaning up very easy,
and hence it's easier to wake up waiters as events are processed.

Changing to a wake-per-event-processed scheme will require some
careful consideration, though, since the current devfs+devfsd behviour
ensures there are few surprises (everyone waits until devfsd has
finished, so you know the system is in a "finished" state before
providing access). I'm not going to be rushed into changing it until
I'm satisfied that the new behaviour is reasonable. This is definately
not a v1.1 thing.

> > Since devfsd has to
> > wait for a module load to complete, it's not a good idea to block
> > waiting for free space in the event buffer (potential deadlock).
> 
> What do you mean?

One thought I had was to have event generators wait if the queue is
full, until devfsd consumes (at least) one event. But that's no good
if devfsd is responsible for generating those events (i.e. REGISTER
events when devsfd loads a module). Since devsfd can't process new
events while waiting for the module to finish loading, in effect
devfsd would have to wait on itself: deadlock.

I tried to come up with ways around this deadlock, but none of them
were pretty, so I abandoned that approach (fortunately before cutting
any code:-). So a dynamic buffer (possibly a slab cache) is probably
the only reasonable solution.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
