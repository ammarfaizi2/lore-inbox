Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRHTT03>; Mon, 20 Aug 2001 15:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268924AbRHTT0T>; Mon, 20 Aug 2001 15:26:19 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39182 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268916AbRHTT0I>; Mon, 20 Aug 2001 15:26:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Benjamin Redelings I <bredelin@ucla.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Mon, 20 Aug 2001 21:32:40 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3B813743.5080400@ucla.edu>
In-Reply-To: <3B813743.5080400@ucla.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010820192613Z16342-32383+573@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 20, 2001 06:13 pm, Benjamin Redelings I wrote:
> Daniel Phillips wrote:
> > Could you please try this patch against 2.4.9 (patch -p0):
> > 
> > --- ../2.4.9.clean/mm/memory.c	Mon Aug 13 19:16:41 2001
> > +++ ./mm/memory.c	Sun Aug 19 21:35:26 2001
> > @@ -1119,6 +1119,7 @@
> >  			 */
> >  			return pte_same(*page_table, orig_pte) ? -1 : 1;
> >  		}
> > +		SetPageReferenced(page);
> >  	}
> >  
> >  	/*
> > 
> 
> 
> Well, I tried this, and.... WOW!  Much better  [:)]
> Was it really true, that swapped in pages didn't get marked as 
> referenced before?  It almost felt that bad, but that seems kind of 
> crazy - I don't completely understand what this fix is doing...

With the use-once optimization, all pages start on the inactive queue 
instead of the active ring.  If the page doesn't get referenced before it 
gets to the other end of the inactive queue then it will be evicted and 
freed.  This means that somebody has to "rescue" each page that is actually 
used, before it gets to the end of the inactive queue.  This is implemented 
explicitly for generic_file_read and generic_file_write via the 
check_used_once function (which implements the use-once logic) and implicitly 
for buffers via the existing touch_buffer function.

There was no such rescue implemented for swap pages because when I originally 
submitted patch as an [RFC] I was doing all my testing without using any swap 
space, just file IO.  At the time, also, there other things wrong with the 
swap cache so that it was hard to see the bad effects of this omission.

Just setting the page referenced means that page_launder or reclaim_page will 
see the referenced bit and move the page to the active list, so it can live 
out its normal life cycle.

A similar thing has to be done in filemap_nopage (which will take care of 
mmap pages) and also for any filesystems whose page accesses bypass  
generic_read/write, for example, the new directory-in-pagecache code in ext2.
I'm thinking now about whether it's best to take an approach that plugs all 
the holes in a generic way, or instead just hunt them down one by one.  Once 
you know such holes are there it's not particularly hard to find and fill 
them.  It's tempting to try and move this logic to a more central place - the 
problem with that is, in the central place it's hard to filter out accesses 
that aren't real uses, such as readahead.

A final note: though the swap cache is not able to take full advantage of the 
use-once logic (because we don't have a good way of checking the state of the 
hardware page referenced bit - yet) it still does get a small benefit from 
the machinery: when we optimistically read ahead from swap, those pages that 
are not actually used will not be faulted in, thus will not have their 
referenced bit set, thus will be discarded quickly.

--
Daniel
