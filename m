Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289104AbSAJA7j>; Wed, 9 Jan 2002 19:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289105AbSAJA7U>; Wed, 9 Jan 2002 19:59:20 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:61454 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289104AbSAJA7I>; Wed, 9 Jan 2002 19:59:08 -0500
Message-ID: <3C3CE5D6.2204BD27@zip.com.au>
Date: Wed, 09 Jan 2002 16:52:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Dave Jones <davej@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagecache lock ordering
In-Reply-To: <Pine.LNX.4.21.0201100007350.1080-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> There's two places, do_buffer_fdatasync

generic_buffer_fdatasync() and hence do_buffer_fdatasync()
are completely unused.  It may be simpler to just trash
them.

> and __find_lock_page_helper,

Yeah.  The code can't deadlock because:

	page_cache_get();
	spin_lock(&pagecache_lock);
	page_cache_release();

we implicitly *know* that page_cache_release won't try
to acquire pagemap_lru_lock, because the page is in the
pagecache and has count=2 or more.  Which is a bit, umm,
subtle.

I get the feeling that a lot of this would be cleaned up
if presence on an LRU contributed to page->count.  It
seems strange, kludgy and probably racy that this is not
the case.

-
