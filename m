Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289711AbSBNEpp>; Wed, 13 Feb 2002 23:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289715AbSBNEpg>; Wed, 13 Feb 2002 23:45:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:62413 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289711AbSBNEpZ>; Wed, 13 Feb 2002 23:45:25 -0500
Date: Thu, 14 Feb 2002 10:16:53 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, arjanv@redhat.com
Subject: Re: patch: aio + bio for raw io
Message-ID: <20020214101653.A1641@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020208190117.A12959@redhat.com> <Pine.LNX.4.33.0202081611490.11791-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202081611490.11791-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Feb 08, 2002 at 04:25:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A variation in perspective on this. 

One could look at a bio simply as a completion unit. A caller into 
block would split up its i/os depending on the granularity (latency) 
at which it would like to see partial completion information 
propagated about the i/o as it progresses, in case it is available. 
Of course this would at best be a hint, as the true granularity 
depends on how much the driver handles in one go, and in case of 
merges this would be coarser than what the bio splitup indicates. 
(Arjan, this is also in the light of your concerns about latency 
impacts of making readv/writev vectors mappable to the same kvec; 
the same kvec can be mapped to multiple bios without any difficulty
and the advantage is that it can be split uniformly irrespective
of user space iovec element boundaries)

Alignment requirements might need to be honoured at this level
(this seems inevitable), but when it comes to the size restrictions, 
here are a few aspects to keep in mind.


> bio can handle arbitrarily large IO's, BUT it can never split them. 
> 
> The answer to the "can" question is: merging can be fast, splitting
> fundamentally cannot.
> 
> Splitting a request _fundamentally_ involves memory management (at the
> very least you have to allocate a new request), while growing a request
> can (and does) mean just adding an entry to the end of a list (until you
> cannot grow it any more, of course, but that's the point where you have
> to end anyway, so..)

Splitting of bios by block layer or a driver should only be needed 
in case the i/o needs to be split or striped across multiple 
devices/queues/offsets as in the case of lvm or software raid 
(remappings). If the caller sends down bios with the right limits 
(with the help of grow_bio), then the need for allocating bios for 
splits may be avoided in several such cases, but not always 
(e.g raid5, bad block remapping).

In situations where it is just a matter of the low level driver not 
being able to handle a single request in one shot, it only needs 
a bit of state information to be able to complete it in chunks. 
There is _no_ need for memory allocation in this case. Most of the 
infrastructure for this already exists in bio and is in use for 
a few IDE cases; I have in mind a few enhancements and helpers to 
make this more generic. 

The maximum i/o limits (size + segment limits etc) do have another
implication in terms of how much it makes sense to merge into a 
single request, especially when it comes to more complicated 
merge decisions accounting for latencies/deadlines/priorities. 

So, having a grow_bio or some such function which _combines_ the 
constraints of all the driver layers involved as far as possible, 
could help with minimizing bio splitting due to remapping and 
account for balanced merges. 

It is just that the degree of benefits seem less that it might 
appear at first sight if we are willing to depend on the bio 
infrastructure available to enable drivers to handle a partial 
requests (i.e. complete a single request in smaller chunks). 

Also, notice that combining these layered constraints to the most 
conservative sizes could result in more granular splits than might 
be absolutely necessary, which incurs extra costs down the 
completion path (the need to combine completion status from all 
the pieces, even though they might have ultimately been transferred 
to the device in one shot). 

Regards
Suparna

On Fri, Feb 08, 2002 at 04:25:25PM -0800, Linus Torvalds wrote:
> On Fri, 8 Feb 2002, Benjamin LaHaise wrote:
> >
> > Yup.  What we need is an interface for getting the max size of an io --
> 
> No. There is no such thing.
> 
> There is no "max size". There are various different limits, and "size" is
> usually the last one on the list. The limitations are things like "I can
> have at most N consecutive segments" or "crossing a 64kB border is fine,
> but implies a new segment" or "a single segment is limited to X bytes, and
> the _sum_ of all segments are limited to Y bytes" or..
> 
> And it can depend on the _address_ of the thing you're writing. If the
> address is above a bounce limit, the bouncing code ends up having to copy
> it to accessible memory, so you can have a device that can do a 4MB
> request in one go if it's directly accessible, but if it is not in the low
> XXX bits, then it gets split into chunks and copied down, at which point
> you may only be able to do N chunks at a time.
> 
> And no, I didn't make any of these examples up.
> 
> A "max size" does not work. It needs to be a lot more complex than that.
> For block devices, you need the whole "struct request_queue" to describe
> the default cases, and even then there are function pointers to let
> individual drivers limits of their own _outside_ those cases.
> 
> So it basically needs to be a "grow_bio()" function that does the choice,
> not a size limitation.
> 
> (And then most devices will just use one of a few standard "grow()"
> functions, of course - you need the flexibility, but at the same time
> there is a lot of common cases).
> 
> 		Linus
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
