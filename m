Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSEINVx>; Thu, 9 May 2002 09:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311701AbSEINVr>; Thu, 9 May 2002 09:21:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22394 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311710AbSEINUf>; Thu, 9 May 2002 09:20:35 -0400
Date: Thu, 9 May 2002 15:21:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: hugh@veritas.com, torvalds@transmeta.com, akpm@zip.com.au, cr@sap.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double flush_page_to_ram
Message-ID: <20020509152116.A8428@dualathlon.random>
In-Reply-To: <Pine.LNX.4.21.0205091252350.1205-100000@localhost.localdomain> <20020509.045643.27562731.davem@redhat.com> <20020509150146.O12382@dualathlon.random> <20020509.055200.111470847.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 05:52:00AM -0700, David S. Miller wrote:
> That is correct.

so I will need to backout this one liner from my vm updates too.

--- 2.4.19-pre4/mm/filemap.c~aa-150-read_write_tweaks	Tue Mar 26
23:11:33 2002
+++ 2.4.19-pre4-akpm/mm/filemap.c	Tue Mar 26 23:11:33 2002
@@ -1968,7 +1968,6 @@ success:
 	 * and possibly copy it over to another page..
 	 */
 	mark_page_accessed(page);
-	flush_page_to_ram(page);
 	return page;
 
 no_cached_page:

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
patch is doing (never the pagecache if it's an early cow). It seems like
moving the early cow into memory.c fixed the flush_page_to_ram bug by
luck, because Hugh's patch is otherwise equivalent to old 2.4 kernels.

Confirm?

If yes, I prefer to move the flush_page_to_ram on the _pagecache_
_before_ the memcpy into memory.c, it's cleaner if the pagecache layer
doesn't need to care about cache aliasing between kernel direct mapping
and userspace address space (but that it only cares about struct pages
and filesystem, so only kernel side), and that such user-related part is
covered only in memory.c.

Andrea
