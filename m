Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSIEUUM>; Thu, 5 Sep 2002 16:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSIEUUM>; Thu, 5 Sep 2002 16:20:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34312 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318210AbSIEUUK>; Thu, 5 Sep 2002 16:20:10 -0400
Date: Thu, 5 Sep 2002 13:27:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: One more bio for for floppy users in 2.5.33..
In-Reply-To: <3D77B1EF.97B1FDDD@zip.com.au>
Message-ID: <Pine.LNX.4.33.0209051310190.5983-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 5 Sep 2002, Andrew Morton wrote:
> 
> >  - the code really cares about and uses the incremental information. At
> >    which point it will already have "handled" any previous incremental
> >    stuff, and the only thing it really cares about is the "new increment".
> 
> So the BIO client would need to keep some state somewhere about "this is
> the next page to unlock".  That would best be in the BIO somewhere.

Well, the information actually is there already, although I have to admit 
that it's kind of subtle. 

Look at the current mpage_end_io_read(), and realize that it already does 
a traversal in pages from

	start = bio->bi_io_vec

	end = bio->bi_io_vec + bio->bi_vcnt - 1

which is actually very close to what it would do with partial results.

With partial results, it would need to do only a slightly different 
traversal:

	end = bio->bi_io_vec + bio->bi_vcnt*PAGE_SIZE - bio->bi_size

	start = end - nr_sectors * 512

	PAGE_ALIGN(start)
	PAGE_ALIGN(end)

but it's otherwise the exact same code (doing all the edge calculations in 
bytes, and then only traversing pages that have now been fully done and 
weren't fully done last time).

It _looks_ like it literally needs just a few lines of changes.

So I would actually argue against adding new information: we _do_ actually 
have the information already, and adding more "convenient" forms of it 
adds more aliasing and coherency issues. The current form isn't _that_ 
complicated to use, and we might hide it behind a simple macro:

	#define GET_PAGE_INDEXES(bio, start, end) \
		... set start/end to point into the ...
		... proper bio->bi_io_vec subarray  ...

> Well we still will have the problem where reading 512 bytes from /dev/fd0
> does 64k of IO.  That is most sweet for reading a bunch of 32k ext2 files
> from a hard drive, not so nice for reading fd0's partition table.

I do think we might make the read-ahead window configurable, and make slow 
devices have slightly smaller windows. 

On the other hand, I don't think the 64kB IO actually _hurts_ per se, as 
long as it doesn't delay the stuff we care about.

		Linus

