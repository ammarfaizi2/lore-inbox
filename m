Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSEVUXv>; Wed, 22 May 2002 16:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSEVUXu>; Wed, 22 May 2002 16:23:50 -0400
Received: from ns.suse.de ([213.95.15.193]:59140 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313537AbSEVUXt>;
	Wed, 22 May 2002 16:23:49 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Have the 2.4 kernel memory management problems on large machines  been fixed?
In-Reply-To: <E17AaR0-0002QM-00@the-village.bc.nu.suse.lists.linux.kernel> <Pine.LNX.4.33.0205221048570.23621-100000@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 May 2002 22:23:49 +0200
Message-ID: <p73sn4kaq3u.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> 	bigpage = alloc_bigpage_from_magic_zone();

How should magic zone be handled? Do you propose to just size it with
__setup() and not put anything smaller than 4MB pages into it ?
Otherwise fragmentation will likely kill it quickly.

It would be still a bit ugly that the memory couldn't be used for anything
else. I guess that would be ok for a pure Oracle hack, but even for a pure
Oracle hack it would be awfully special purpose and hard to use
(needed a reboot for tuning and lots of memory potentially usable) 

[BTW if you wanted to make it a truly bad Oracle hack(tm) then you could even
add a mode where there are no struct page in mem_map for magic zone; after
all 32+GB machines start to get limited by the size of mem_map in low mem;
drawback is that it would need some hacks to enable RAWIO again] 

One idea I had was to have a zone where you do not put any pte highmem
pages or other not easily freeable highmem pages, but only pure user pages.
Then assuming rmap was included it would be possible to do a simple 
dumb defragment pass for this magic zone that frees a 4MB page by freeing
or moving smaller pages.

Corner case is mlock() - it would likely need a page move. raw io etc.
could likely be handled by just blocking on the page (under the assumption
that it should always have bounded livetime), with perhaps 
some measures to avoid livelock.

Do you think something like that would be worth it or do you prefer
the really dumb version that just never tries to use the pages in 
magic dumb zone for anything else?

-Andi
