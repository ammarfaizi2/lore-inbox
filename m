Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSBGU7O>; Thu, 7 Feb 2002 15:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291298AbSBGU6z>; Thu, 7 Feb 2002 15:58:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33364 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S291308AbSBGU6f>; Thu, 7 Feb 2002 15:58:35 -0500
Date: Thu, 7 Feb 2002 21:58:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        akpm@zip.com.au, bcrl@redhat.com, Hugh Dickins <hugh@lrel.veritas.com>,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020207215854.P1743@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0202071120160.17850-100000@imladris.surriel.com> <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202071355450.1149-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 02:28:44PM +0000, Hugh Dickins wrote:
> On Thu, 7 Feb 2002, Rik van Riel wrote:
> > On Thu, 7 Feb 2002, Hugh Dickins wrote:
> > >
> > > If this were a common case where many pages end up, yes, we'd
> > > need a separate special list; but it's a very rare case
> > 
> > Think of a web or ftp server doing nothing but sendfile()
> 
> Aren't the sendfile() pages in the page cache, and normally taken
> off LRU at the same time as removed from page cache, in shrink_cache?
> The exception being when the file is truncated while it is being sent,
> and buffers busy, so left behind on LRU by truncate_complete_page?

the buffers will hold a reference on the page. So the pagecache is
either in the LRU with refcount > 1, or the refcount is 1 and the page
is not in the lru.

In short Ben's patch was useless but it was faster and cleaner than what
we had before with the special page_cache_release, and so it was good.

Said it in another manner: we'll never effectively free a page that is
in the LRU, unless it's an anonymous page (no brainer for
sendpage/sendfile).

Hugh's patch is definitely valid and it's a nice bugcheck to have, it
should be merged IMHO (it's in a slow path), but there's no bug to fix I
think, the bugcheck is paranoid-in-slow-path kind of thing.

Andrea
