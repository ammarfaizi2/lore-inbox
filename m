Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290211AbSBGO0p>; Thu, 7 Feb 2002 09:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291089AbSBGO0g>; Thu, 7 Feb 2002 09:26:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:17811 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290211AbSBGO01>; Thu, 7 Feb 2002 09:26:27 -0500
Date: Thu, 7 Feb 2002 14:28:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au, bcrl@redhat.com,
        Hugh Dickins <hugh@lrel.veritas.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Rik van Riel wrote:
> On Thu, 7 Feb 2002, Hugh Dickins wrote:
> >
> > If this were a common case where many pages end up, yes, we'd
> > need a separate special list; but it's a very rare case
> 
> Think of a web or ftp server doing nothing but sendfile()

Aren't the sendfile() pages in the page cache, and normally taken
off LRU at the same time as removed from page cache, in shrink_cache?
The exception being when the file is truncated while it is being sent,
and buffers busy, so left behind on LRU by truncate_complete_page?

That's not a common case, nor were __free_pages_ok PageLRU BUG
reports on 2.4.14 to 2.4.17 common: most definitely a case that
needs to be handled correctly, but not common.

But I know very little of sendfile(), please correct me.

> > I was proposing we revert to distinguishing page_cache_release
> > from put_page, page_cache_release doing the lru_cache_del; and
> > I'd like to add my in_interrupt() BUG() there for now, just as
> > a sanity check.  You are proposing that we keep the current,
> > post-Ben, structure of doing it in __free_pages_ok if possible.
> 
> So how exactly would pages be freed ?
> 
> You still need to do the check of whether the page can
> be freed somewhere.

I imagined (not yet tried) in shrink_cache, something like:

		/*
		 * In exceptional cases, a page may still be on an
		 * LRU when it is "freed"; and it would not be possible
		 * to remove it from LRU at interrupt time: clean up here.
		 */
		if (unlikely(!page_count(page))) {
			page_cache_get(page);
			__lru_cache_del(page);
			page_cache_release(page);
			continue;
		}

(Using page_cache_get+page_cache_release instead of get_page+put_page
merely because page_cache_whatever is the local dialect in this module.
But over in unmap_kiobuf I ought to revert from page_cache_release to
put_page, in case it can be called at interrupt time, as Ben implied.)

Hugh

