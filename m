Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSK0SVF>; Wed, 27 Nov 2002 13:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSK0SVF>; Wed, 27 Nov 2002 13:21:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:61108 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262208AbSK0SVE>;
	Wed, 27 Nov 2002 13:21:04 -0500
Message-ID: <3DE50EC0.31354C37@digeo.com>
Date: Wed, 27 Nov 2002 10:28:16 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.49-mm2
References: <3DE48C4A.98979F0C@digeo.com> <Pine.LNX.4.44L.0211270930510.4103-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2002 18:28:17.0239 (UTC) FILETIME=[C1276E70:01C29642]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 27 Nov 2002, Andrew Morton wrote:
> 
> > +pf_memdie.patch
> >
> >  Fix the PF_MEMDIE logic
> 
> The first part of the patch looks suspicious. If PF_MEMALLOC
> is set we shouldn't be allowed to go into try_to_free_pages()
> in the first place, should we ?

Long story.  Someone sent out a 2.4 patch quite a long time ago to
preserve PF_MEMALLOC in there because they were running userspace
processes as PF_MEMALLOC.  These were realtime "userspace device drivers"
which actually provided block driver services to the kernel.

When you think about it, that's not totally dumb, and all the recursion
protection etc works OK.  Supporting it is just a two-liner, so...

hm.  OK, let's forget that idea ;)

> ...
> > page-reclaim-motion.patch
> >   Move reclaimable pages to the tail ofthe inactive list on IO completion
> 
> Very nice, though if you're worried about effective reclaiming
> you might be interested in Arjan's O(1) VM code, which I'll
> probably forward-port to 2.5 once I've got it properly tuned.

2.5 tends to refile pages more than 2.4, in preference to blocking
on them (the latency thing).  Of course this blows CPU and perverts
page aging (not that the LRU lists add much value in page aging under 
heavy loads anyway...)

Under stupid qsbench loads this patch took the reclaimed/scanned ratio
from ~15% to ~25% and reduced runtime from 7min 45sec to 6min 42sec.

Yup, splitting the lists up would make sense.  Of course, the interrupt-time
motion is "ideal" in that the right pages are placed in the right place
at the right time - we never have to scan past pages which are still
under IO due to elevator reordering, device speed differences, etc...
  
> > activate-unreleaseable-pages.patch
> >   Move unreleasable pages onto the active list
> 
> Interesting, does this make much difference ?

My notes are not clear :(  No, I wouldn't expect it to make a lot
of difference.  I was seeing quite a lot of normal zone pages which
were pinned by buffers getting churned around on the inactive list.
Things like ext2 group descriptor blocks, etc. 

There shouldn't normally be many of these, but there may be some
scenarios in which there are a lot of these, and the inactive list
gets really small due to large amounts of pinned memory.
