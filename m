Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSEINZR>; Thu, 9 May 2002 09:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSEINZQ>; Thu, 9 May 2002 09:25:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49075 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311701AbSEINZO>;
	Thu, 9 May 2002 09:25:14 -0400
Date: Thu, 09 May 2002 06:13:11 -0700 (PDT)
Message-Id: <20020509.061311.59887036.davem@redhat.com>
To: andrea@suse.de
Cc: hugh@veritas.com, torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020509152116.A8428@dualathlon.random>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Thu, 9 May 2002 15:21:16 +0200

   The reason I did this patch is because it was functional equivalent to
   old 2.4 kernels.
   
   in turn old 2.4 kernels were all wrong:
   
   	if (no_share) {
   		struct page *new_page = alloc_page(GFP_HIGHUSER);
   
   		if (new_page) {
   			copy_user_highpage(new_page, old_page, address);
   			flush_page_to_ram(new_page);
   		} else
   			new_page = NOPAGE_OOM;
   		page_cache_release(page);
   		return new_page;
   	}
   
   	flush_page_to_ram(old_page);
   	return old_page;
   
   they don't flush old_page before the the memcpy, they only flush the
   _anon_ page _after_ the memcpy like current kernel with vm updates or Hugh's
   patch is doing (never the pagecache if it's an early cow).

filemap.c:filemap_nopage() does the flush in 2.4.x, what are you
talking about?

   It seems like
   moving the early cow into memory.c fixed the flush_page_to_ram bug by
   luck, because Hugh's patch is otherwise equivalent to old 2.4 kernels.
   
   Confirm?
   
No it isn't.  In 2.4.x kernels filemap_nopage does the flush just
like it does now in 2.5.x  What ancient 2.4.x sources are you looking
at where filemap_nopage does not do the flush_page_to_ram right after
the success: label?

   If yes, I prefer to move the flush_page_to_ram on the _pagecache_
   _before_ the memcpy into memory.c, it's cleaner if the pagecache layer
   doesn't need to care about cache aliasing between kernel direct mapping
   and userspace address space (but that it only cares about struct pages
   and filesystem, so only kernel side), and that such user-related part is
   covered only in memory.c.
   
NO!  The correct answer is to kill off flush_page_to_ram altogether.
It is broken by design, and trying to make it work somehow "better"
in 2.5.x is a losing game.  We should make the ports fix up their
stuff for a mechanism that we know _does_ work and that is
flush_dcache_page plus {copy,clear}_user_page().
