Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312279AbSEINoP>; Thu, 9 May 2002 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312296AbSEINoO>; Thu, 9 May 2002 09:44:14 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26239 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312279AbSEINoN>; Thu, 9 May 2002 09:44:13 -0400
Date: Thu, 9 May 2002 15:44:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
Message-ID: <20020509154444.B8428@dualathlon.random>
In-Reply-To: <20020509150146.O12382@dualathlon.random> <20020509.055200.111470847.davem@redhat.com> <20020509152116.A8428@dualathlon.random> <20020509.061311.59887036.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 06:13:11AM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Thu, 9 May 2002 15:21:16 +0200
> 
>    The reason I did this patch is because it was functional equivalent to
>    old 2.4 kernels.
>    
>    in turn old 2.4 kernels were all wrong:
>    
>    	if (no_share) {
>    		struct page *new_page = alloc_page(GFP_HIGHUSER);
>    
>    		if (new_page) {
>    			copy_user_highpage(new_page, old_page, address);
>    			flush_page_to_ram(new_page);
>    		} else
>    			new_page = NOPAGE_OOM;
>    		page_cache_release(page);
>    		return new_page;
>    	}
>    
>    	flush_page_to_ram(old_page);
>    	return old_page;
>    
>    they don't flush old_page before the the memcpy, they only flush the
>    _anon_ page _after_ the memcpy like current kernel with vm updates or Hugh's
>    patch is doing (never the pagecache if it's an early cow).
> 
> filemap.c:filemap_nopage() does the flush in 2.4.x, what are you
> talking about?

I said "in turn old 2.4 kernels were all wrong", that means the _old_ 2.4
kernels not recent 2.4.x, look at 2.4.7 for istance.

> 
>    It seems like
>    moving the early cow into memory.c fixed the flush_page_to_ram bug by
>    luck, because Hugh's patch is otherwise equivalent to old 2.4 kernels.
>    
>    Confirm?
>    
> No it isn't.  In 2.4.x kernels filemap_nopage does the flush just

The change between 2.4.7 and 2.4.19pre8 doesn't look intentional, Hugh
just gone back to the old way of doing the flush in 2.4 that apparently
was buggy and that's why his patch his wrong (I assume this was the case
for him because I falled in the same trap too).

> like it does now in 2.5.x  What ancient 2.4.x sources are you looking
> at where filemap_nopage does not do the flush_page_to_ram right after
> the success: label?

anything older than 2.4.10.

> 
>    If yes, I prefer to move the flush_page_to_ram on the _pagecache_
>    _before_ the memcpy into memory.c, it's cleaner if the pagecache layer
>    doesn't need to care about cache aliasing between kernel direct mapping
>    and userspace address space (but that it only cares about struct pages
>    and filesystem, so only kernel side), and that such user-related part is
>    covered only in memory.c.
>    
> NO!  The correct answer is to kill off flush_page_to_ram altogether.
> It is broken by design, and trying to make it work somehow "better"
> in 2.5.x is a losing game.  We should make the ports fix up their
> stuff for a mechanism that we know _does_ work and that is
> flush_dcache_page plus {copy,clear}_user_page().

Fine with me if Marcelo drops it, but I guess sparc/m68k/mips users
won't like not be able to use 2.4 kernels anymore unless they first
rewrite the entere cache flushing in the middle of a stable series.
If you don't drop it in late 2.4 then my suggestion looks still a nice
common code cleanup and it's functional equivalent to the current
2.4.19pre8 code, so it cannot go wrong.

Andrea
