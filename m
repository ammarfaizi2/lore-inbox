Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136248AbRAGSRi>; Sun, 7 Jan 2001 13:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136262AbRAGSR2>; Sun, 7 Jan 2001 13:17:28 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:7432 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S136248AbRAGSRS>; Sun, 7 Jan 2001 13:17:18 -0500
Date: Sun, 7 Jan 2001 14:25:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] 2.4.0 VM improvements
In-Reply-To: <Pine.LNX.4.21.0101071529070.21675-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101071422180.4416-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Rik van Riel wrote:

> The patch is available at this URL:
> 
> 	http://www.surriel.com/patches/2.4/2.4.0-tunevm+rss

I have one improvement on top of your patch.

Now its not more "rare" (as the comment on the code stated) to have
pages with page->age == 0 being called on lru_cache_add. 

This patch should make the overhead of calling lru_cache_add on pages with
page->age == 0 smaller. 

--- mm/swap.c.orig      Sun Jan  7 15:59:37 2001
+++ mm/swap.c   Sun Jan  7 16:11:21 2001
@@ -233,10 +233,12 @@
        if (!PageLocked(page))
                BUG();
        DEBUG_ADD_PAGE
-       add_page_to_active_list(page);
-       /* This should be relatively rare */
-       if (!page->age)
-               deactivate_page_nolock(page);
+
+       if (page->age)
+               add_page_to_active_list(page);
+       else
+               add_page_to_inactive_dirty_list(page);
+
        spin_unlock(&pagemap_lru_lock);
 }
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
