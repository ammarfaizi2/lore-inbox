Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSIZRb7>; Thu, 26 Sep 2002 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSIZRb7>; Thu, 26 Sep 2002 13:31:59 -0400
Received: from packet.digeo.com ([12.110.80.53]:30949 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261375AbSIZRb6>;
	Thu, 26 Sep 2002 13:31:58 -0400
Message-ID: <3D9345C4.74CD73B8@digeo.com>
Date: Thu, 26 Sep 2002 10:37:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 17:37:09.0460 (UTC) FILETIME=[57010140:01C26583]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> > Slab caches no longer hold onto completely empty pages.  Instead, pages
> > are freed as soon as they have zero objects.  This is possibly a
> > performance hit for slabs which have constructors, but it's doubtful.
> 
> It could be a performance hit for slab with just one object - e.g the
> page sized names cache, used in every syscall that has a path name as a
> parameter.
> 
> Ed, have you benchmarked that there is no noticable slowdown?
> e.g. test the time needed for stat("."). on UP, otherwise the SMP arrays
> would perform the caching.
> 

(What Ed said - we do hang onto one page.  And I _have_ measured
cost in kmem_cache_shrink...)

For those things, the caching should be performed in the page
allocator.  This way, when names_cache requests a cache-hot page,
it may get a page which was very recently a (say) pagetable page,
rather than restricting itself only to pages which used to be
a names_cache page.

CPU caches are per-cpu global.  So the hot pages list should be
per-cpu global also.

Martin Bligh seems to have the patches up and running.  It isn't
very finetuned yet, but initial indications are promising:

Before:
Elapsed: 20.18s User: 192.914s System: 48.292s CPU: 1195.6%

After:
Elapsed: 19.798s User: 191.61s System: 43.322s CPU: 1186.4%

That's for a kernel compile.

And from the profiles, it appears that the benefit is coming
from cache locality, not from the buddylist lock amortisation
which we've also designed into those patches.

I need to stop being slack, and get that code into the pipeline.
