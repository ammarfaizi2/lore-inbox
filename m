Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276270AbRI1Tr3>; Fri, 28 Sep 2001 15:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276271AbRI1TrU>; Fri, 28 Sep 2001 15:47:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:34054 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276270AbRI1TrE>; Fri, 28 Sep 2001 15:47:04 -0400
Date: Fri, 28 Sep 2001 15:24:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.10 does not set accessed bit for readahead pages
Message-ID: <Pine.LNX.4.21.0109281506430.3230-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi people,

I was taking a closer look at 2.4.10's mark_page_accessed() changes
(unfortunately just now, I've been quite busy lately with other issues)
and I noticed that readahead pages are not having their referenced bit set
when they are found in cache.

page_cache_read() (called by generic_file_readahead()), will simply do a
pagecache lookup and return in case the (being readahead) page is already
there. 

I've done some experiments in the past trying to use a new GFP_ flag for
allocation of readahead pages. This new GFP flag was the indicator to
__alloc_pages() that it should fail very easily (so, in theory, we would
not spend time on page reclaiming for readahead, which is simply a guess).

With the above working, I got much slower results: It showed me in
practice, with real numbers, that the additional page reclaiming work for
readahead pages was worth due to the avoided disk seeks.

So I think it makes quite some sense to avoid readahead pages from being
removed from the cache easily, by calling mark_page_accessed() at
page_cache_read():

--- filemap.c.orig      Fri Sep 28 16:43:57 2001
+++ filemap.c   Fri Sep 28 16:44:56 2001
@@ -670,8 +670,10 @@
        spin_lock(&pagecache_lock);
        page = __find_page_nolock(mapping, offset, *hash);
        spin_unlock(&pagecache_lock);
-       if (page)
+       if (page) {
+               mark_page_accessed(page);
                return 0;
+       }
 
        page = page_cache_alloc(mapping);
        if (!page)


NOTE: I'm saying that it is _bad_ to throw away readahead pages easily
because I've seen it in practice. I'll try to test this in real practice
again soon (not this week) to make sure.

Comments ? 

