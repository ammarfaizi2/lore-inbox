Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291378AbSBGWer>; Thu, 7 Feb 2002 17:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291382AbSBGWed>; Thu, 7 Feb 2002 17:34:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39428 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291378AbSBGWca>;
	Thu, 7 Feb 2002 17:32:30 -0500
Message-ID: <3C630045.24E74301@zip.com.au>
Date: Thu, 07 Feb 2002 14:31:33 -0800
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
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com> <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>, <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain> <20020207215854.P1743@athlon.random> <3C62ED05.F4683103@zip.com.au>,
		<3C62ED05.F4683103@zip.com.au> <20020207231837.S1743@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > Good to hear.  But what about the weird corner-case in truncate_complete_page(),
> > where a mapped page is not successfully released, and is converted into
> > an anon buffercache page?  It seems that a combination of sendfile
> > and truncate could result in one of those pages being subject to
> > final release in BH context?
> 
> Such a page is not in the lru so it doesn't matter.

static void truncate_complete_page(struct page *page)
{
        /* Leave it on the LRU if it gets converted into anonymous buffers */
        if (!page->buffers || do_flushpage(page, 0))
                lru_cache_del(page);

If the page has buffers, and do_flushpage() fails, what happens?

> As said in the previous email, from another point of view, the only
> thing that can be still in the lru during __free_pages_ok is an
> anonymous page. truncate_complete_page cannot run on an anonymous page.
> Anonymous pages cannot be truncated.

truncate_complete_page() can, in rare circumstances, take a page
which was in both the pagecache and on LRU, and leave it purely
on LRU.  And because that page *used* to be in pagecache, it
could be undergoing sendfile.

Or I'm missing something.  Did something change?

-
