Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131100AbRARQhT>; Thu, 18 Jan 2001 11:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131667AbRARQhK>; Thu, 18 Jan 2001 11:37:10 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:2916
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S131100AbRARQg4>; Thu, 18 Jan 2001 11:36:56 -0500
Date: Thu, 18 Jan 2001 08:36:55 -0800
From: Larry McVoy <lm@bitmover.com>
To: Russell Leighton <leighton@imake.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010118083655.D6787@work.bitmover.com>
Mail-Followup-To: Russell Leighton <leighton@imake.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200101181001.f0IA11I25258@webber.adilger.net> <3A66CDB1.B61CD27B@imake.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <3A66CDB1.B61CD27B@imake.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 06:04:17AM -0500, Russell Leighton wrote:
> 
> "copy this fd to that one, and optimize that if you can"
> 
> ... isn't this Larry M's "splice" (http://www.bitmover.com/lm/papers/splice.ps)?

Not really.  It's not clear to me that people really understood what I was
getting at in that and I've had some coffee and BK 2.0 is just about ready
to ship (shameless plug :-) so I'll give it another go.

The goal of splice is to avoid both data copies and virtual memory completely.
My SGI experience taught me that once you remove the data copy problem, the
next problem becomes setting up and tearing down the virtual mappings to the
data.  Linux is quite a bit lighter than IRIX but that doesn't remove this
issue, it just moves the point on the spectrum where the setup/teardown
becomes a problem.

Another goal of splice was to be general enough to allow data to flow from
any place to any place.  The idea was to have a good model and then iterate
over all the possible endpoints; I can think of files, sockets, and virtual
address spaces right off the top of my head, devices are subset of files
as will become apparent.

A final goal was to be able to be able to handle caching vs non-caching.
Sometimes one of the endpoints is a cache, such as the file system cache.
Sometimes you want data to stay in the cache and sometimes you want to
bypass it completely.  The model had to handle this.

OK, so the issues are
    - avoid copying
    - avoid virtual memory as much as possible
    - allow data flow to/from non aligned, non page sized objects
    - handle caching or non-caching

This leads pretty naturally to some observations about the shape of the
solution:

    - the basic unit of data is a physical page, or part of one.  That's
      physical page, not a virtual address which points to a physical page.
    - since we may be coming from sockets, where the payload is buried in
      the middle of page, there needs to be a vector of pages and a 
      vector of { pageno, offset, len } that goes along with the first
      vector.  There are two vectors because you could have multiple payloads
      in a single page, i.e., there is not a 1:1 between pages and payloads.
    - The page vector needs some flags, which handle caching.  I had just
      two flags, the "LOAN" flag and the "GIFT" flag.

In my mind, this was enough that everyone should "get it" at this point, but
that's me being lazy.

So how would this all work?  The first thing is that we are now dealing
in vectors of physical pages.  That's key - if you look at an OS, it
spends a lot of time with data going into a physical page, then being
translated to a virtual page, being copied to another virtual page, and
then being translated back to a physical page so that it can be sent to
a different device.  That's the basic FTP loop.

So you go "hey, just always talk physical pages and you avoid a lot of this
wasted time".  Now is a good time to observe that splice() is a library
interface.  The kernel level interfaces I called pull() and push().  The
idea was that you could do

	vectors = 0;

	do {
		vectors = pull(from_fd, vectors);
	} while (splice_size(vectors) < BIG_ENOUGH_SIZE);
	push(to_fd, vectors);

The idea was that you maintained a pointer to the vectors, the pointer is
a "cookie", you can't really dereference it in user space, at least not all
of it, but the kernel doesn't want to maintain this stuff, it wants you to
do that.  So you start pulling and then you push what you got.  And you,
being the user land process, are never looking at the data, in fact, you 
can't, you have a pointer to a data structure which describes the data
but you can't look at it.

A couple of interesting things: 
    - this design allows for multiplexing.  You could pull from multiple devices
      and then push to one.  The interface needs a little tweaking for that to
      be meaningful, we can steal from pipe semantics.  We need to be able to
      say how much to pull, so we add a length.  
    - there is no reason that you couldn't have an fd which was open to 
      /proc/self/my_address_space and you could essentially do an mmap()
      by seeking to where you want the mapping and doing a push to it.
      This is a fairly important point, it allows for end to end.  Lots of
      nasty issues with non-page sized chunks in the vector, what you do there
      depends on the semantics you want.

So what about the caching?  That's the loan/gift distinction.  The deal is that
these pages have reference counts and when the reference count goes to zero,
somebody has to free them.  So the page vector needs a free_page() function
pointer and if the pages are a loan, you call that function pointer when you
are done with them.   In other words, if the file system cache loaned you 
the pages, you do a call back to let the file system know you are done with
them.  If the pages were a gift, then the function pointer is null and you
have to manage them.  You can put the normal decrement_and_free() function
in there and when you get done with them you call that and the pages go back
to the free list.  You can also "free" them into your private page pool, etc.
The point is that if the end point which is being pulled() from wants the
pages cached, it "loans" them, if it doesn't, it "gifts" them.  Sockets as 
a "from" end point would always gift, files as a from endpoint would typically
loan.

So, there's the set of ideas.  I'm ashamed to admit that I don't really know
how close kiobufs are to this.  I am interested in hearing what you all think,
but especially what the people think who have been playing around with kiobufs
and sendfile.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
