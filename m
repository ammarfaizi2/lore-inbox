Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSEXWrz>; Fri, 24 May 2002 18:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSEXWry>; Fri, 24 May 2002 18:47:54 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3233 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312601AbSEXWrk>;
	Fri, 24 May 2002 18:47:40 -0400
Date: Fri, 24 May 2002 18:47:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] change of ->bd_op->open() semantics
In-Reply-To: <Pine.LNX.4.44.0205241323240.11918-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0205241821580.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Linus Torvalds wrote:

> 
> 
> On Fri, 24 May 2002, Alexander Viro wrote:
> >
> > 	It has an additional benefit of killing the array of default
> > queues on the same pass - a thing we will need to do sooner or later
> > anyway.
> 
> I'd like to see this, because we want to make the "find the right queue" a
> much more expensive operation (no longer some fairly simple mapping from
> major number - a more dynamic and general "register this queue for minors
> xxxx-yyyy of major zzz").
> 
> Doing it just once at open() time allows for that to happen without any
> performance downside.

OK.  Plan of company:

1) killing the last caller of get_hardsect_size() (switching it to
bdev_hardsect_size()).

2) killing blk_get_queue() and switching to bdev_get_queue()

3) moving the contents of bdev_get_queue() into do_open() and check_partitions()
and caching result in new field of struct block_device; cleaning it at the
same places that reset ->bd_op, etc.; making bdev_get_queue() return cached
pointer.

4) moving the call of partition-reading code into do_open() (for cases when
->bd_contains is non-NULL), killing the "set block_device fields by hand"
mess in check_partitions()

5) moving the code that sets ->bd_queue into instances of ->open() (leaving
the code in do_open() in place for a while - it's OK since it would be
conditional by ->bd_queue == NULL).

6) after the series of per-driver patches (see 5) is over, kill that code
in do_open() and kill (now unused) array.

7) deal with devfs-related fallout from (4).

(4) is needed since we really can't afford any IO-before-open() anymore and
we need lazy partition-reading to deal with that.  OTOH, we can very well
do (1)--(3) and stay at that - result will still have the array, etc., but at
least we won't have recalculate the damn thing for each request.

I would prefer to go all way and move all code that chooses queue into
the ->open(), but it might make sense to split it into several series.
Your call...

Now, I've already sent a patch that does (1) and (2) (last one sent on
Wednesday), but it doesn't show up on bkbits.  If there were any problems
with it - please, tell.  If not - I can
	* resend it, following it by (3)
	* send (3) alone
	* wait for 2.5.18, rediff and send (1)--(3).
Take your pick...

I'd definitely like to have a testing point between (3) and (4)--(7), so
unless you are going to release 2.5.18 right now I'd prefer to get (1)--(3)
into it...

