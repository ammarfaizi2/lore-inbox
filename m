Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289448AbSAJOF1>; Thu, 10 Jan 2002 09:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289449AbSAJOFP>; Thu, 10 Jan 2002 09:05:15 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:36606 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289448AbSAJOFC>; Thu, 10 Jan 2002 09:05:02 -0500
Date: Thu, 10 Jan 2002 14:06:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Dave Jones <davej@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagecache lock ordering
In-Reply-To: <3C3CE5D6.2204BD27@zip.com.au>
Message-ID: <Pine.LNX.4.21.0201101332560.1121-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Andrew Morton wrote:
> Hugh Dickins wrote:
> > 
> > There's two places, do_buffer_fdatasync
> 
> generic_buffer_fdatasync() and hence do_buffer_fdatasync()
> are completely unused.  It may be simpler to just trash
> them.

Oh, nice observation.  writeout_one_page could be trashed at
the same time (but not waitfor_one_page, still in use elsewhere).

But what's the chance that an out-of-tree filesystem might
be using generic_buffer_fdatasync, which is still prototyped
and exported?  Remove from 2.5 but leave in 2.4?  I'd like to
see them go completely - revenge for being misled by them -
but Marcelo may decide otherwise.

> > and __find_lock_page_helper,
> 
> Yeah.  The code can't deadlock because:
> 
> 	page_cache_get();
===>	spin_unlock(&pagecache_lock);
===>	lock_page();
> 	spin_lock(&pagecache_lock);
> 	page_cache_release();
> 
> we implicitly *know* that page_cache_release won't try
> to acquire pagemap_lru_lock, because the page is in the
> pagecache and has count=2 or more.  Which is a bit, umm,
> subtle.

I'm not entirely convinced (you'll agree that the argument
depends on rather more than you've stated there), but today
I cannot support the counter-example I thought I had (a page
already "on its way out": but we're more careful to hold both
pagecache_lock and page lock when checking page count before
removing from inode cache than I remembered).

(Hmm, but if it's all thoroughly protected, why do we even bother
to recheck mapping and index same there?  Perhaps the shmem case.)

I was also overlooking that the lru_cache_del call was added into
page_cache_release to cope with the _anonymous_ pages Linus put
on LRU.  Cached pages were and are deleted from LRU before getting
there, and __find_lock_page_helper applies to cached not anon pages.

So I agree, both parts of my patch are unnecessary:
harmless, but no justification for applying it.

> I get the feeling that a lot of this would be cleaned up
> if presence on an LRU contributed to page->count.  It
> seems strange, kludgy and probably racy that this is not
> the case.

That makes a lot of sense: but I feel much safer in agreeing
with you than in making the corresponding changes!

Many thanks for looking it over,
Hugh

