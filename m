Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbRIBTcq>; Sun, 2 Sep 2001 15:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbRIBTcg>; Sun, 2 Sep 2001 15:32:36 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:56484 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S268954AbRIBTcZ>;
	Sun, 2 Sep 2001 15:32:25 -0400
Date: Sun, 02 Sep 2001 20:32:36 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-ID: <1034195335.999462755@[169.254.198.40]>
In-Reply-To: <20010902181905Z16091-32383+3020@humbolt.nl.linux.org>
In-Reply-To: <20010902181905Z16091-32383+3020@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

> What do you do when a new module gets inserted, increasing the high order
> load and requiring that the slab be expanded? I.e, the need for
> dependable  handling of high order physical allocations doesn't go away
> entirely.  The slab would help even out the situation with atomic allocs
> because it can be expanded to a target size by a normal task, which can
> wait.

Yes, chew away to disk as this allocation is non atomic.
But this probably still needs something which goes and identifies
kernel allocated pages with buddies which can be relocated / pushed to
disk / freed etc.;

Alternatively something to temporarilly hold onto 'nearly freed'
high-order areas is probably useful. IE if there's an order=3
allocation stuck waiting for a suitable hole, and there's
a bit of bitmap that looks like '00010000' (i.e. order 1 hole,
order 0 hole, order 0 used, order 2 hole), I wonder if we can't
think of some hueristic to avoid allocating the next order 0
page request (atomic or not) from the order 0 hole even if
it's at the front of the order (0) free area list.

IDEA: Attempt not to allocate sets of pages buddied with 'nearly
free' sets of pages.

When freeing pages, we work our way up the orders until
we find a buddy which is non-empty. Let's assume that
the free area, and our (non-empty) buddy, are of order N.
Let's look at whether at order N-1, it's merely half full,
or completely full. If completely full, we guess that
the buddy is unlikely to become free soon, and thus
add our area to the front of the memory queue (mem_add_head)
else we guess it's more likely to have its buddy freed
and add it to the back of the memory queue (mem_add_tail).

/Completely/ untested (i.e. uncompiled) patch attached

> The only  problem with slab allocation is, it has more overhead than
> __alloc_pages  allocation.  For high-performance networking this may be a
> measurable hit.

I meant slab /like/. If all the objects it allocates are the same
size, it can't be slower than the buddy allocator. It could
be simplified (for instance, drop the cache colouring stuff
if that's heavy - everything we allocated is, by definition,
much > 1 page in size).

--
Alex Bligh


--- page_alloc.c        Mon Jan 15 20:35:12 2001
+++ /tmp/page_alloc.c   Sun Sep  2 20:28:08 2001
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
                if (!test_and_change_bit(index, area->map))
-                       /*
-                        * the buddy page is still allocated.
-                        */
-                       break;
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
+                                  && !test_bit((index^1)<<1, 
(area-1)->map) );
+                   break;
+                 }
                /*
                 * Move the buddy up one level.
                 */
@@ -132,7 +146,11 @@
                index >>= 1;
                page_idx &= mask;
        }
-       memlist_add_head(&(base + page_idx)->list, &area->free_list);
+
+       if (addfront)
+         memlist_add_head(&(base + page_idx)->list, &area->free_list);
+       else
+         memlist_add_tail(&(base + page_idx)->list, &area->free_list);

        spin_unlock_irqrestore(&zone->lock, flags);

