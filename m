Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291308AbSBGVLz>; Thu, 7 Feb 2002 16:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291314AbSBGVLo>; Thu, 7 Feb 2002 16:11:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4371 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291308AbSBGVL0>;
	Thu, 7 Feb 2002 16:11:26 -0500
Message-ID: <3C62ED05.F4683103@zip.com.au>
Date: Thu, 07 Feb 2002 13:09:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
        Hugh Dickins <hugh@lrel.veritas.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com> <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>,
		<Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain> <20020207215854.P1743@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Thu, Feb 07, 2002 at 02:28:44PM +0000, Hugh Dickins wrote:
> > On Thu, 7 Feb 2002, Rik van Riel wrote:
> > > On Thu, 7 Feb 2002, Hugh Dickins wrote:
> > > >
> > > > If this were a common case where many pages end up, yes, we'd
> > > > need a separate special list; but it's a very rare case
> > >
> > > Think of a web or ftp server doing nothing but sendfile()
> >
> > Aren't the sendfile() pages in the page cache, and normally taken
> > off LRU at the same time as removed from page cache, in shrink_cache?
> > The exception being when the file is truncated while it is being sent,
> > and buffers busy, so left behind on LRU by truncate_complete_page?
> 
> the buffers will hold a reference on the page. So the pagecache is
> either in the LRU with refcount > 1, or the refcount is 1 and the page
> is not in the lru.
> 
> In short Ben's patch was useless but it was faster and cleaner than what
> we had before with the special page_cache_release, and so it was good.
> 
> Said it in another manner: we'll never effectively free a page that is
> in the LRU, unless it's an anonymous page (no brainer for
> sendpage/sendfile).

Good to hear.  But what about the weird corner-case in truncate_complete_page(),
where a mapped page is not successfully released, and is converted into
an anon buffercache page?  It seems that a combination of sendfile
and truncate could result in one of those pages being subject to
final release in BH context?

1: try_to_release_page() fails.  It becomes a buffercache page.
2: vm runs try_to_release_page() again.  This time it succeeds.
3: sendfile completes.


> Hugh's patch is definitely valid and it's a nice bugcheck to have, it
> should be merged IMHO (it's in a slow path), but there's no bug to fix I
> think, the bugcheck is paranoid-in-slow-path kind of thing.

It's looking more and more like we need that test.

-
