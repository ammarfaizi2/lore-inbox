Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268813AbRIBUSB>; Sun, 2 Sep 2001 16:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269174AbRIBURk>; Sun, 2 Sep 2001 16:17:40 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:8456 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268813AbRIBURh>; Sun, 2 Sep 2001 16:17:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Date: Sun, 2 Sep 2001 22:24:42 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010902181905Z16091-32383+3020@humbolt.nl.linux.org> <1034195335.999462755@[169.254.198.40]>
In-Reply-To: <1034195335.999462755@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010902201748Z16294-32383+3038@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 2, 2001 09:32 pm, Alex Bligh - linux-kernel wrote:
> IDEA: Attempt not to allocate sets of pages buddied with 'nearly
> free' sets of pages.
> 
> When freeing pages, we work our way up the orders until
> we find a buddy which is non-empty. Let's assume that
> the free area, and our (non-empty) buddy, are of order N.
> Let's look at whether at order N-1, it's merely half full,
> or completely full. If completely full, we guess that
> the buddy is unlikely to become free soon, and thus
> add our area to the front of the memory queue (mem_add_head)
> else we guess it's more likely to have its buddy freed
> and add it to the back of the memory queue (mem_add_tail).
> 
> /Completely/ untested (i.e. uncompiled) patch attached

Rediffed to 2.4.9, whitespace and wrapping problems fixed, and compiled
but not tested.  Now we just need a victi^H^H^H^H^H volunteer to try it...
(Stephan?)

--- ../2.4.9.clean/mm/page_alloc.c	Thu Aug 16 12:43:02 2001
+++ ./mm/page_alloc.c	Sun Sep  2 21:09:05 2001
@@ -69,6 +69,8 @@
 	struct page *base;
 	zone_t *zone;
 
+       int addfront=1;
+
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
@@ -112,10 +114,22 @@
 		if (area >= zone->free_area + MAX_ORDER)
 			BUG();
 		if (!__test_and_change_bit(index, area->map))
-			/*
-			 * the buddy page is still allocated.
-			 */
-			break;
+                 {
+                   /*
+                    * the buddy page is still allocated.
+                    *
+                    * see how many bits are set in its bitmap;
+                    * if 50% or more, we conclude the buddy is
+                    * unlikely to be freed soon, and add the
+                    * area to the head of the queue; else we
+                    * conclude the buddy may be free soon and
+                    * add it to the head.
+                    */
+                   if (mask & 1) /* not order 0 merge */
+                     addfront = ( !test_bit((index^1)<<1, (area-1)->map)
+                                  && !test_bit((index^1)<<1, (area-1)->map) );
+                   break;
+                 }
 		/*
 		 * Move the buddy up one level.
 		 */
@@ -132,7 +146,11 @@
 		index >>= 1;
 		page_idx &= mask;
 	}
-	memlist_add_head(&(base + page_idx)->list, &area->free_list);
+
+       if (addfront)
+         memlist_add_head(&(base + page_idx)->list, &area->free_list);
+       else
+         memlist_add_tail(&(base + page_idx)->list, &area->free_list);
 
 	spin_unlock_irqrestore(&zone->lock, flags);
 
