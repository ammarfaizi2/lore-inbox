Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289764AbSBGWSH>; Thu, 7 Feb 2002 17:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291382AbSBGWR7>; Thu, 7 Feb 2002 17:17:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33120 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289764AbSBGWRm>; Thu, 7 Feb 2002 17:17:42 -0500
Date: Thu, 7 Feb 2002 23:18:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
        Hugh Dickins <hugh@lrel.veritas.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020207231837.S1743@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com> <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>, <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain> <20020207215854.P1743@athlon.random> <3C62ED05.F4683103@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C62ED05.F4683103@zip.com.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 01:09:25PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Thu, Feb 07, 2002 at 02:28:44PM +0000, Hugh Dickins wrote:
> > > On Thu, 7 Feb 2002, Rik van Riel wrote:
> > > > On Thu, 7 Feb 2002, Hugh Dickins wrote:
> > > > >
> > > > > If this were a common case where many pages end up, yes, we'd
> > > > > need a separate special list; but it's a very rare case
> > > >
> > > > Think of a web or ftp server doing nothing but sendfile()
> > >
> > > Aren't the sendfile() pages in the page cache, and normally taken
> > > off LRU at the same time as removed from page cache, in shrink_cache?
> > > The exception being when the file is truncated while it is being sent,
> > > and buffers busy, so left behind on LRU by truncate_complete_page?
> > 
> > the buffers will hold a reference on the page. So the pagecache is
> > either in the LRU with refcount > 1, or the refcount is 1 and the page
> > is not in the lru.
> > 
> > In short Ben's patch was useless but it was faster and cleaner than what
> > we had before with the special page_cache_release, and so it was good.
> > 
> > Said it in another manner: we'll never effectively free a page that is
> > in the LRU, unless it's an anonymous page (no brainer for
> > sendpage/sendfile).
> 
> Good to hear.  But what about the weird corner-case in truncate_complete_page(),
> where a mapped page is not successfully released, and is converted into
> an anon buffercache page?  It seems that a combination of sendfile
> and truncate could result in one of those pages being subject to
> final release in BH context?

Such a page is not in the lru so it doesn't matter.

As said in the previous email, from another point of view, the only
thing that can be still in the lru during __free_pages_ok is an
anonymous page. truncate_complete_page cannot run on an anonymous page.
Anonymous pages cannot be truncated.

> 
> 1: try_to_release_page() fails.  It becomes a buffercache page.
> 2: vm runs try_to_release_page() again.  This time it succeeds.
> 3: sendfile completes.
> 
> 
> > Hugh's patch is definitely valid and it's a nice bugcheck to have, it
> > should be merged IMHO (it's in a slow path), but there's no bug to fix I
> > think, the bugcheck is paranoid-in-slow-path kind of thing.
> 
> It's looking more and more like we need that test.

needed is the wrong word, but we do want it for long term paranoid
safety (actually it is a more interesting for 2.5 infact).

Andrea
