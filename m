Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSBGXIy>; Thu, 7 Feb 2002 18:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288985AbSBGXIo>; Thu, 7 Feb 2002 18:08:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8293 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287287AbSBGXIc>; Thu, 7 Feb 2002 18:08:32 -0500
Date: Fri, 8 Feb 2002 00:09:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>, bcrl@redhat.com,
        Hugh Dickins <hugh@lrel.veritas.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020208000942.V1743@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com> <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>, <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain> <20020207215854.P1743@athlon.random> <3C62ED05.F4683103@zip.com.au>, <3C62ED05.F4683103@zip.com.au> <20020207231837.S1743@athlon.random> <3C630045.24E74301@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C630045.24E74301@zip.com.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 02:31:33PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > > Good to hear.  But what about the weird corner-case in truncate_complete_page(),
> > > where a mapped page is not successfully released, and is converted into
> > > an anon buffercache page?  It seems that a combination of sendfile
> > > and truncate could result in one of those pages being subject to
> > > final release in BH context?
> > 
> > Such a page is not in the lru so it doesn't matter.
> 
> static void truncate_complete_page(struct page *page)
> {
>         /* Leave it on the LRU if it gets converted into anonymous buffers */
>         if (!page->buffers || do_flushpage(page, 0))
>                 lru_cache_del(page);
> 
> If the page has buffers, and do_flushpage() fails, what happens?
> 
> > As said in the previous email, from another point of view, the only
> > thing that can be still in the lru during __free_pages_ok is an
> > anonymous page. truncate_complete_page cannot run on an anonymous page.
> > Anonymous pages cannot be truncated.
> 
> truncate_complete_page() can, in rare circumstances, take a page
> which was in both the pagecache and on LRU, and leave it purely
> on LRU.  And because that page *used* to be in pagecache, it
> could be undergoing sendfile.
> 
> Or I'm missing something.  Did something change?

as said in the previous email that becomes a buffercache mapped in
userspace, with refcount > 1 (unfreeable from the vm side), so the
__free_page from irq will do nothing (it will only decrease the refcount
of 1 unit, and then the page will be released by the vm). If the
refcount was 1 instead, then it means the page wasn't in the lru in the
first place and so the check won't trigger either.

Only truly anonymous pages (not ex pagecache, later become buffercache)
can trigger such PageLRU check in __free_pages_ok.  Infact if it wasn't
the case all the kernels before 2.4.1x would been broken.

Andrea
