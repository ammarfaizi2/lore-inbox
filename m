Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269985AbRHESf0>; Sun, 5 Aug 2001 14:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269989AbRHESfQ>; Sun, 5 Aug 2001 14:35:16 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:25860
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S269985AbRHESe5>; Sun, 5 Aug 2001 14:34:57 -0400
Date: Sun, 05 Aug 2001 14:34:11 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: [RFC] using writepage to start io
Message-ID: <209120000.997036451@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, August 01, 2001 04:57:35 PM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:

> On Tuesday 31 July 2001 21:07, Chris Mason wrote:
>> This has been tested a little more now, both ext2 (1k, 4k) and
>> reiserfs.  dbench and iozone testing don't show any difference, but I
>> need to spend a little more time on the benchmarks.
> 
> It's impressive that such seemingly radical surgery on the vm innards 
> is a) possible and b) doesn't make the system perform noticably worse.

radical surgery is always possible ;-)  But, I was expecting better
performance results than I got.  I'm trying a few other things out here,
more details will come if they work.  

My real motivation for the patch is to allow better filesystem control of
how things get written though.  If I can do this without making things
slower, I've won.  The big drawback is how muddy writepage has gotten with
the patch, as I've more or less required checks for partial page writes.

> 
>> The idea is that using flush_dirty_buffers to start i/o under memory
>> pressure is less than optimal.  flush_dirty_buffers knows the oldest
>> dirty buffer, but has no page aging info, so it might not flush a
>> page that we actually want to free.
> 
> Note that the fact that buffers dirtied by ->writepage are ordered by 
> time-dirtied means that the dirty_buffers list really does have 
> indirect knowledge of page aging.  There may well be benefits to your 
> approach but I doubt this is one of them.

A problem is that under memory pressure, we'll flush a buffer that has been
dirty for a long time, even if we are constantly redirtying it and have it
more or less pinned.  This might not be common enough to cause problems,
but it still isn't optimal.  Yes, it is a good idea to flush that page at
some time, but under memory pressure we want to do the least amount of work
that will lead to a freeable page.

> 
> It's surprising that 1K buffer size isn't bothered by being grouped by 
> page in their IO requests.  I'd have thought that this would cause a 
> significant number of writes to be blocked waiting on the page lock 
> held by an unrelated buffer writeout.

Well, for non-buffer cache pages, we're getting a poor man's write
clustering.  If this doesn't slow down ext2 its because of good disk layout.

ext2 probably doesn't use the buffer cache enough to show bad results here.
reiserfs on ia64 or alpha might.

> 
> The most interesting part of your patch to me is the anon_space_mapping.
> It's nice to make buffer handling look more like page cache handling, 
> and get rid of some special cases in the vm scanning.  On the other 
> hand, buffers are different from pages in that, once buffers heads are 
> removed, nobody can find them any more, so they can not be rescued.
> Now, if I'm reading this correctly, buffer pages *will* progress on to 
> the inactive_clean list from the inactive_dirty list instead of jumping 
> that queue and being directly freed by the page_cache_release.

Without my patch, it looks to me like refill_inactive_scan will put buffer
cache pages on the inactive dirty list by calling deactivate_page_nolock.
page_launder catches these by checking page->buffers, and calling
try_to_free_buffers which starts the io.  

So, the big difference now is just that page_launder sees the page is
dirty, and uses writepage to start the io and try_to_free_buffers only
waits on it.  The rest should work more or less the same.

>  Maybe 
> this is good because it avoids the expensive-looking __free_pages_ok.
> 
> This looks scary:
> 
> +        index = atomic_read(&buffermem_pages) ;
> 
> Because buffermem_pages isn't unique.  This must mean you're never 
> doing page cache lookups for anon_space_mapping, because the 
> mapping+index key isn't unique.  There is a danger here of overloading 
> some hash buckets, which becomes a certainty if you use 0 or some other 
> constant for the index.  If you're never doing page cache lookups, why 
> even enter it into the page hash?

path of least surprise I suppose; I knew add_to_page_cache_locked() would
do what I wanted in terms of page setup, if there's a better way feel free
to advise ;-)  No page lookups are done on the buffer cache pages.

> That's all for now.  It's a very interesting patch.

thanks for the comments ;-)

-chris

