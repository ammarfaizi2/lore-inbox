Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314690AbSFNXkI>; Fri, 14 Jun 2002 19:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314702AbSFNXkH>; Fri, 14 Jun 2002 19:40:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314690AbSFNXkG>;
	Fri, 14 Jun 2002 19:40:06 -0400
Message-ID: <3D0A7E78.588CEB9C@zip.com.au>
Date: Fri, 14 Jun 2002 16:38:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "Adam J. Richter" <adam@yggdrasil.com>, axboe@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO 
 simplification
In-Reply-To: <200206141652.JAA26744@adam.yggdrasil.com> <3D0A75A4.AB34AC59@zip.com.au> <20020614232943.GK22961@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Fri, Jun 14, 2002 at 04:00:52PM -0700, Andrew Morton wrote:
> > Everything is pretty much in place to do this now.  The main piece
> > which is missing is the gang page allocator (Hi, Bill).
> > It'll be damn fast, and nicely scalable.  It's all about reducing the
> > L1 cache footprint.  Making best use of data when it is in cache.
> > Making best use of locks once they have been acquired.  If it is
> > done right, it'll be almost as fast as 64k PAGE_CACHE_SIZE, with
> > none of its disadvantages.
> > In this context, bio_chain() is regression, because we're back
> > into doing stuff once-per-page, and longer per-page call graphs.
> > I'd rather not have to do it if it can be avoided.
> 
> gang_cpu is not quite ready to post, but work is happening on it
> and it's happening today -- I have a suitable target in hand and
> am preparing it for testing. The bits written thus far consist of
> a transparent per-cpu pool layer refilled using the gang transfer
> mechanism, and I'm in the process of refining that to non-prototypical
> code and extending it with appropriate deadlock avoidance so explicit
> gang allocation requests can be satisfied.
> 

Great, thanks.

Performing gang allocation within generic_file_write may not
be practical, especially if the application is being good and
is issuing 8k writes.  So there will still be pressure on the
single-page allocator.

Certainly, reads can perform gang allocation.

Which tends to point us in the direction of using the lockless
per-cpu page allocation for writes, and explicit gang allocation
for reads.  So possibly, gang allocation should go straight to
the main page list and not drain the per-cpu pools.  Leave them
reserved for the single-page allocators - write(2) and anon pages.

But it's early days yet...

-
