Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUDHSHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUDHSHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:07:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28081
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262106AbUDHSHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:07:51 -0400
Date: Thu, 8 Apr 2004 20:07:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rmap: page_mapping barrier
Message-ID: <20040408180749.GL31667@dualathlon.random>
References: <20040408151245.GA31667@dualathlon.random> <Pine.LNX.4.44.0404081805280.7404-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404081805280.7404-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 06:49:32PM +0100, Hugh Dickins wrote:
> "all are safe".  Most of them (e.g. in arch's flush_dcache_page)

I admit I didn't focus too much on flush_dcache_page since it's a noop
on x86 x86-64 alpha. I don't expect unfixable troubles there, but we
need to re-check non-x86 later.

> The one instance I am still a little worried about is sync_page:
> I didn't follow your argument above.  But I think I'm remembering

sync_page for anon pages is only called after the page is in the
swapcache. Not sure what your code does, my code sure will never call
sync_page unless the mapping is in place and the mapping for me depends
only on pageswapcache:

static inline struct address_space * page_mapping(struct page * page)
{
	extern struct address_space swapper_space;
	struct address_space * mapping = NULL;

	if (unlikely(PageSwapCache(page)))
		mapping = &swapper_space;
	else if (!PageAnon(page))
		mapping = page->mapping;
	return mapping;
}

PageAnon is absolutely worthless for any sync_page in my tree, no way
you will ever call sync_page on anything that isn't swapcache and is
anonymous at the same time, so I don't have to care about it.

if I've overlooking something let me know of course, but my review
showed no issues in terms of PageAnon locking (I mean modulo
flush_dcache_page that I didn't focus much on and as you found some arch
as much bigger troubles with flush_dcache_page regardless PageAnon).

> I think, ignore my PageAnon barrier concern; but allow me
> to say "I told you so" if we ever do find such a race.

I'll do further checking on this when I'm back from vacations on 14,
though if you didn't find anything by that time it most certainly means
there's no race ;). I don't want to discourage you in searching for more
races in this area ;), I just don't see problems. BTW, if my tree will
have a problem here, anonmm should have it too, maybe the other way
around not (really Hugh, my approch of being transparent with
page_mapping if far superior, you may find it ugly to check for
swapper_inode in the pagecache entry/exit points but then it gets
everything right and more obviously, just see the backing-dev-unplugging
code, and the swap_unplug_fn stuff, I only had to change a page->mapping
into a page_mapping in block_sync_page [the per-mapping unplug stuff]
and everything else just worked without rejects).
