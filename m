Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUDHRtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUDHRtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:49:42 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:45022 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262078AbUDHRtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:49:36 -0400
Date: Thu, 8 Apr 2004 18:49:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: rmap: page_mapping barrier
In-Reply-To: <20040408151245.GA31667@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404081805280.7404-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Andrea Arcangeli wrote:
> On Thu, Apr 08, 2004 at 02:22:29PM +0100, Hugh Dickins wrote:
> > My page_mapping(page) says PageAnon(page)? NULL: page->mapping;
> > I've just realized, looking again at sync_page but it goes way
> > beyond it, that we need smp barriers of some kind somewhere,
> > don't we?  That is, we cannot just write the address of one of
> > our non-address_space structures into page->mapping, without
> > being very careful that others will see the PageAnon and treat
> > it as NULL.  There are places all over using page_mapping(page)
> > while another cpu might be right in page_add_rmap.  I go very
> > mushy when it comes to barriers, you understand them better
> > than most, any idea what we need to do in page_mapping(page),
> > and when setting and clearing PageAnon?
> 
> could you elaborate those many places that execute page_mapping while
> the other cpu does page_add_rmap or page_remove_rmap?

Good challenge.  I thought they were all over, but closer inspection
shows almost all seem safe.  I can't quite bring myself to say
"all are safe".  Most of them (e.g. in arch's flush_dcache_page)
look like they're called when we know there's a real file mapping
(might be truncated beneath us, but won't turn anon), and we could
BUG_ON(PageAnon(page)) - but I don't feel quite sure enough to do
that (nor to use straight page->mapping instead).

> If the VM does a page_mapping in the pagecache layer in my tree, that
> means we already executed page_add_rmap long before calling
> __add_to_page_cache, the __add_to_page_cache/__remove_from_page_cache
> spinlocks are enough to serialize PageAnon. That covers sync_page and
> the rest of the pagecache layer.

I'd expected set_page_dirty to be a problem (it often has been),
but failed to find a problematic instance: there's a nice habit
of doing the set_page_dirty before lowering mapcount.

The one instance I am still a little worried about is sync_page:
I didn't follow your argument above.  But I think I'm remembering
a time long past when there was code which did lock_page on a page
without holding a reference to that page (in which case it could
turn into something else by the time lock acquired); but we don't
do that now - find_lock_page is good, and you've put a good
BUG_ON(PageAnon(page)) into it.

> There's just one place that I'm wondering about and it's page_mapping in
> memory.c but it only changes a mark_page_accessed so I don't see any
> trouble whatever happens there (mark_page_accessed can be run on any
> random page anytime and it cannot do any harm). I believe we can live
> with that race just fine, it's controlled by mark_page_accessed
> internally by checking PageLru inside the zone->lru_lock.

As you say, it wouldn't be a problem anyway; but that one is perfectly
okay because it's before the page_remove_rmap, so it's either stably
PageAnon there, or stably !PageAnon.

There's an (I think) unstable one in refill_inactive_zone, below
the ancient FIXME, but again that's entirely safe because we don't
dereference mapping, and it doesn't matter if we sometimes make a
wrong decision.

I think, ignore my PageAnon barrier concern; but allow me
to say "I told you so" if we ever do find such a race.

Hugh

