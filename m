Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVIZGDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVIZGDP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVIZGDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:03:15 -0400
Received: from silver.veritas.com ([143.127.12.111]:46634 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932395AbVIZGDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:03:14 -0400
Date: Mon, 26 Sep 2005 07:02:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] mm: zap_pte_range dont dirty anon
In-Reply-To: <20050925152630.75560571.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509260659370.8065@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0509251649100.3490@goblin.wat.veritas.com>
 <20050925152630.75560571.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Sep 2005 06:03:10.0452 (UTC) FILETIME=[F8F69B40:01C5C25F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > zap_pte_range already avoids wasting time to mark_page_accessed on anon
> > pages: it can also skip anon set_page_dirty - the page only needs to be
> > marked dirty if shared with another mm, but that will say pte_dirty too.
> 
> Are you sure about this?

Yeerrrssss, well, I'm never _sure_ about anything,
especially when faced by the question.

> What is the page is (for example) clean swapcache, having been recently
> faulted in.  If this pte indicates that this process has modified the page
> and we don't run set_page_dirty(), the page could be reclaimed and the
> change is lost.

Absolutely.  But either the page is unique to this mm, shared only with
swapcache: in which case we're about to do a free_swap_cache on it (that
may be delayed in actually freeing the swap because of not getting page
lock, presumably because vmscan just got to it, but no matter), and we
don't care at all that the page no longer represents what's on swap disk.

Or, the page is shared with another mm.  But it's an anonymous page
(a private page), so it's shared via fork, and COW applies to it.
copy_one_pte did ptep_set_wrprotect on it, and did not pte_mkclean [*].

So if it's dirty from before the fork, the sharing mm will also have
it marked pte_dirty, which will get propagated through to the page
via that mm, and everything's fine even though we're ignoring the
pte_dirty in this unmapping mm.  Or if it's dirty from after the fork,
well, something's gone very wrong if the page is still shared - unless
it's because there's been a further fork since it was dirtied, in which
case that sibling carries the pte_dirty which guarantees its integrity.

The change would be very wrong for the !PageAnon pages:
but it's right for the PageAnon ones, don't you agree?

> Or what is the page was an anon page resulting from (say) a swapoff, and
> it's shared by two mm's and one has modified it and we drop that dirty pte?

Again, the one which tried to modify it will have got a Copy-On-Write
fault, been given a copy of the page, and the original won't be shared.

> Or <other scenarios>.
> 
> Need more convincing.

Convinced?  I hope it's just that you forgot something and now remember.
But do demand more from me if not (and don't feel obliged to devise more
cases to ask about, though they do help - thanks).  Or just drop the
patch, it was merely a passing observation - I'm not building any
great edifice upon it in later patches!

Hugh

[*]  This ignores the issue of the "Linus" pages, those anonymous
pages which have got into a shared vma by ptrace writing while the
vma was unwritable - copy_one_pte's tests are on VM_SHARED.  They're
in a limbo between private and shared, and may indeed behave oddly.
For the moment we'll continue to ignore the oddities of that case.
