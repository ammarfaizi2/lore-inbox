Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274278AbRISXt3>; Wed, 19 Sep 2001 19:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274281AbRISXtU>; Wed, 19 Sep 2001 19:49:20 -0400
Received: from [195.223.140.107] ([195.223.140.107]:48881 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274278AbRISXtH>;
	Wed, 19 Sep 2001 19:49:07 -0400
Date: Thu, 20 Sep 2001 01:49:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: pre12 VM doubts and patch
Message-ID: <20010920014905.G720@athlon.random>
In-Reply-To: <20010919232818.T720@athlon.random> <Pine.LNX.4.33.0109191611550.2507-100000@penguin.transmeta.com> <20010920013153.C720@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010920013153.C720@athlon.random>; from andrea@suse.de on Thu, Sep 20, 2001 at 01:31:53AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 01:31:53AM +0200, Andrea Arcangeli wrote:
> --- 2.4.10pre11aa1/mm/vmscan.c.~1~	Tue Sep 18 21:23:49 2001
> +++ 2.4.10pre11aa1/mm/vmscan.c	Thu Sep 20 01:29:58 2001
> @@ -415,7 +415,10 @@
>  				spin_unlock(&pagemap_lru_lock);
>  
>  				ClearPageDirty(page);
> +
> +				page_cache_get(page);
>  				writepage(page);
> +				page_cache_release(page);
>  
>  				spin_lock(&pagemap_lru_lock);
>  				continue;

then in turn we can backout this bit (patch -R)

diff -urN 2.4.10pre11/mm/page_io.c 2.4.10pre12/mm/page_io.c
--- 2.4.10pre11/mm/page_io.c	Tue May  1 19:35:33 2001
+++ 2.4.10pre12/mm/page_io.c	Thu Sep 20 01:44:20 2001
@@ -78,7 +78,15 @@
  	if (!wait) {
  		SetPageDecrAfter(page);
  		atomic_inc(&nr_async_pages);
- 	}
+ 	} else
+		/*
+		 * Must hold a reference until after wait_on_page()
+		 * returned or it could be freed by the VM after
+		 * I/O is completed and the page is been unlocked.
+		 * The asynchronous path is fine since it never
+		 * references the page after brw_page().
+		 */
+		page_cache_get(page);
 
  	/* block_size == PAGE_SIZE/zones_used */
  	brw_page(rw, page, dev, zones, block_size);
@@ -94,6 +102,7 @@
 	/* This shouldn't happen, but check to be sure. */
 	if (page_count(page) == 0)
 		printk(KERN_ERR "rw_swap_page: page unused while waiting!\n");
+	page_cache_release(page);
 
 	return 1;
 }

Andrea
