Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRHEWck>; Sun, 5 Aug 2001 18:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264329AbRHEWca>; Sun, 5 Aug 2001 18:32:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:52753 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264244AbRHEWcO>; Sun, 5 Aug 2001 18:32:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] using writepage to start io
Date: Mon, 6 Aug 2001 00:38:01 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-mm@kvack.org, torvalds@transmeta.com
In-Reply-To: <209120000.997036451@tiny>
In-Reply-To: <209120000.997036451@tiny>
MIME-Version: 1.0
Message-Id: <01080600380103.00294@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 August 2001 20:34, Chris Mason wrote:
> I wrote:
> > Note that the fact that buffers dirtied by ->writepage are ordered
> > by time-dirtied means that the dirty_buffers list really does have
> > indirect knowledge of page aging.  There may well be benefits to
> > your approach but I doubt this is one of them.
>
> A problem is that under memory pressure, we'll flush a buffer that has
> been dirty for a long time, even if we are constantly redirtying it
> and have it more or less pinned.  This might not be common enough to
> cause problems, but it still isn't optimal.  Yes, it is a good idea to
> flush that page at some time, but under memory pressure we want to do
> the least amount of work that will lead to a freeable page.

But we don't have a choice.  The user has set an explicit limit on how 
long a dirty buffer can hang around before being flushed.  The 
old-buffer rule trumps the need to allocate new memory.  As you noted,
it doesn't cost a lot because if the system is that heavily loaded
then the rate of dirty buffer production is naturally throttled.

> > The most interesting part of your patch to me is the
> > anon_space_mapping. It's nice to make buffer handling look more like
> > page cache handling, and get rid of some special cases in the vm
> > scanning.  On the other hand, buffers are different from pages in
> > that, once buffers heads are removed, nobody can find them any more,
> > so they can not be rescued. Now, if I'm reading this correctly,
> > buffer pages *will* progress on to the inactive_clean list from the
> > inactive_dirty list instead of jumping that queue and being directly
> > freed by the page_cache_release.
>
> Without my patch, it looks to me like refill_inactive_scan will put
> buffer cache pages on the inactive dirty list by calling
> deactivate_page_nolock. page_launder catches these by checking
> page->buffers, and calling try_to_free_buffers which starts the io.
>
> So, the big difference now is just that page_launder sees the page is
> dirty, and uses writepage to start the io and try_to_free_buffers only
> waits on it.  The rest should work more or less the same.

And with your patch, buffers are no longer freed by page launder, they
are moved on to the inactive_clean list instead where they are picked
up by reclaim_page.  I'm just wondering if that's a little more
efficient than going through __free_pages_ok/__alloc_pages_limit.

> >  Maybe
> > this is good because it avoids the expensive-looking
> > __free_pages_ok.
> >
> > This looks scary:
> >
> > +        index = atomic_read(&buffermem_pages) ;
> >
> > Because buffermem_pages isn't unique.  This must mean you're never
> > doing page cache lookups for anon_space_mapping, because the
> > mapping+index key isn't unique.  There is a danger here of
> > overloading some hash buckets, which becomes a certainty if you use
> > 0 or some other constant for the index.  If you're never doing page
> > cache lookups, why even enter it into the page hash?
>
> path of least surprise I suppose; I knew add_to_page_cache_locked()
> would do what I wanted in terms of page setup, if there's a better way
> feel free to advise ;-)  No page lookups are done on the buffer cache
> pages.

If you must enter it into the page hash you'd be safer generating a 
random number for the page index.  But why not just take what you need
from add_to_page_cache_locked:

	page_cache_get(page);
	spin_lock(&pagecache_lock);
	add_page_to_inode_queue(mapping, page);
	lru_cache_add(page);
	spin_unlock(&pagecache_lock);

--
Daniel
