Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277208AbRJLEeO>; Fri, 12 Oct 2001 00:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277210AbRJLEeF>; Fri, 12 Oct 2001 00:34:05 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:42705 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S277208AbRJLEdw>;
	Fri, 12 Oct 2001 00:33:52 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Rik van Riel <riel@conectiva.com.br>
Date: Fri, 12 Oct 2001 00:33:59 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[02]: [CFT][PATCH] smoother VM for -ac
Reply-to: jlmales@softhome.net
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <3BC63A77.19202.29B1FD0@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Rik,

I just found out about your desire to have some workstation testing
done to get feedback on your current VM patch.

I am currently using Kernel 2.4.9-ac18.  I am still not happy about
some of the memory management.  I love to try your patch.  I would be
willing to do so against the 2.4.10-ac11 Kernel if a patch is
available.  If Alan is going to implement this patch in a later
2.4.10-acxx patch I will wait patiently.

I also be most interested in knowing how I can log my system memory
usage.  I can use top to log at say every 2-5 minutes depending on
how long I think my system will be up and running.  What I do not
know how to do yet is log the number of KDE 1.1.2 or XFCE 3.8.0
windows open.  I am basically using a SuSE 6.4 with the 2.4 kernel
and its updated element requirements and KDE 1.1.2.  Also any other
memory use logging I can do may prove useful in understanding the
Workstation memory use and effect of the VM logic you are working on.

I recently started exploring other Window managers as I am trying to
isolate other memory issues, i.e. memory leaks.  these leaks on a
workstation appear big time.  At this point I am having difficulty in
collecting data that will tell me if the kernel, KDE, XFree, KFM,
Netscape, and/or KPanel are all leaking because of the kernel or if
this is "Team" effort of all or some of these.  I know generally who
and what is getting out of hand, just not the who done it.  Bottom
line, a 256MB Ram, with 256MB Swap file is just not holding up to
Workstation use, i.e. it is filling up!.  I frequently have to shut
down applications just recover memory, and eventually I have to shut
down Linux as I cannot seem to get it to recover the memory.

I hate to say this, exact same system (I have SCSI trays to change
OS's) using NT 4.0 does generally never gets past 100 MB of swap
useage.  The core of the cause is surfing the net.  In Linux I seem
to reach a brick wall after 3-4 hours where swap and RAM are topped
off.  In NT can go a few days with no problems if need be (system is
left overnight or while I am at work downloading files via my humble
56K (49.3K) connection.  So ISO images do take a while ;).


Regards,

John L. Males
Willowdale, Ontario
Canada
12 October 2001 00:33
mailto:jlmales@softhome.net


From:    Rik van Riel <riel@conectiva.com.br>
To:      <kernelnewbies@nl.linux.org>
Subject: [CFT][PATCH] smoother VM for -ac
Date:    Wed, 10 Oct 2001 17:25:30 -0300 (BRST)
Cc:      <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
         Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

over the last week I've created a small patch which seems
to drastically improve VM performance and interactivity for
2.4.10-ac{9,10}. Initial test results mostly seem to suggest
that the system runs lots smoother for desktop use and doesn't
get into thrashing until the working set _really_ exceeds the
size of RAM.

People have already asked to have this patch integrated into
the -ac kernel, but it would be nice to have a few more test
results from this combined eatcache + stophog patch before
having it integrated ...

The patch implements the following things:
1) bypass page aging entirely for unused objects in
   the cache
2) increase the distance between inactive_shortage
   and inactive_plenty, so kswapd should spend less
   time shuffling random pages around  ...  shouldn't
   make a difference for most loads, but should add
   some robustness in worst cases
3) does page aging _before_ the zone_inactive_plenty()
   test, so old referenced bits get cleared
   [not a big cpu eater, since the code won't run unless
   we have a free or inactive shortage somewhere]
4) in page_alloc.c, the "slowdown" reschedule has been
   made stronger by turning it into a try_to_free_pages(),
   under memory load, this results in allocators calling
   try_to_free_pages() when the amount of work to be done
   isn't too bad yet and pretty much guarantees them they'll
   get to do their allocation immediately afterwards ...
   statistics make sure that the memory hogs are slowed down
   much more than well-behaved programs


Please test this patch and tell Alan and me how it works for
you and whether there are loads where the system performs
worse with this patch than without...

regards,

Rik
- -- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers
needed)

http://www.surriel.com/         http://distro.conectiva.com/



- --- linux-2.4.10-ac10/mm/page_alloc.c.orig      Mon Oct  8 18:22:51
2001
+++ linux-2.4.10-ac10/mm/page_alloc.c   Wed Oct 10 14:08:54 2001
@@ -346,22 +346,15 @@
         * We wake up kswapd, in the hope that kswapd will
         * resolve this situation before memory gets tight.
         *
- -        * We also yield the CPU, because that:
- -        * - gives kswapd a chance to do something
- -        * - slows down allocations, in particular the
- -        *   allocations from the fast allocator that's
- -        *   causing the problems ...
- -        * - ... which minimises the impact the "bad guys"
- -        *   have on the rest of the system
- -        * - if we don't have __GFP_IO set, kswapd may be
- -        *   able to free some memory we can't free ourselves
+        * We'll also help a bit trying to free pages, this
+        * way statistics will make sure really fast allocators
+        * are slowed down more than slow allocators and other
+        * programs in the system shouldn't be impacted as much
+        * by the hogs.
         */
        wakeup_kswapd();
- -       if (gfp_mask & __GFP_WAIT) {
- -               __set_current_state(TASK_RUNNING);
- -               current->policy |= SCHED_YIELD;
- -               schedule();
- -       }
+       if (gfp_mask & __GFP_WAIT)
+               try_to_free_pages(gfp_mask);

        /*
         * After waking up kswapd, we try to allocate a page
- --- linux-2.4.10-ac10/mm/vmscan.c.orig  Mon Oct  8 18:22:51 2001
+++ linux-2.4.10-ac10/mm/vmscan.c       Mon Oct  8 19:18:12 2001
@@ -50,7 +50,7 @@
        inactive += zone->inactive_clean_pages;
        inactive += zone->free_pages;

- -       return (inactive > (zone->size / 3));
+       return (inactive > (zone->size * 2 / 5));
 }

 #define FREE_PLENTY_FACTOR 2
@@ -97,6 +97,24 @@
        return pagecache > limit;
 }

+static inline int page_mapping_notused(struct page * page)
+{
+       struct address_space * mapping = page->mapping;
+
+       if (!mapping)
+               return 0;
+
+       /* This mapping is really large and would monopolise the
pagecache. */
+       if (mapping->nrpages > atomic_read(&page_cache_size) / 20);
+               return 0;
+
+       /* File is mmaped by somebody */
+       if (mapping->i_mmap || mapping->i_mmap_shared)
+               return 1;
+
+       return 0;
+}
+
 /*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
@@ -826,14 +844,14 @@
                }

                /*
- -                * Don't deactivate pages from zones which have
- -                * plenty inactive pages.
+                * Do aging on the pages.  Every time a page is
referenced,
+                * page->age gets incremented.  If it wasn't
referenced, we
+                * decrement page->age.  The page gets moved to the
inactive
+                * list when one of the following is true:
+                * - the page age reaches 0
+                * - the object the page belongs to isn't in active
use
+                * - the object the page belongs to is hogging the
cache
                 */
- -               if (zone_inactive_plenty(page->zone)) {
- -                       goto skip_page;
- -               }
- -
- -               /* Do aging on the pages. */
                if (PageTestandClearReferenced(page)) {
                        age_page_up(page);
                } else {
@@ -843,20 +861,26 @@
                }

                /*
- -                * If the amount of buffer cache pages is too
- -                * high we just move every buffer cache page we
- -                * find to the inactive list. Eventually they'll
- -                * be reclaimed there...
+                * Don't deactivate pages from zones which have
+                * plenty inactive pages.
+                */
+               if (zone_inactive_plenty(page->zone)) {
+                       goto skip_page;
+               }
+
+               /*
+                * If the buffer cache is large, don't do page aging.
+                * If this page really is used, it'll be referenced
+                * again while on the inactive list.
                 */
                if (page->buffers && !page->mapping &&
too_many_buffers())
                        deactivate_page_nolock(page);

                /*
- -                * If the page cache is too large, we deactivate all
- -                * page cache pages which are not in use by a
process.
+                * Deactivate pages from files which aren't in use,
busy
+                * pages will be referenced while on the inactive
list.
                 */
- -               if (pagecache_too_large() && page->mapping &&
- -                               page_count(page) <= (page->buffers ?
2 : 1))
+               if (page_mapping_notused(page))
                        deactivate_page_nolock(page);

                /*
- --- linux-2.4.10-ac10/include/linux/swap.h.orig Mon Oct  8 18:23:03
2001
+++ linux-2.4.10-ac10/include/linux/swap.h      Mon Oct  8 19:15:09
2001
@@ -261,7 +261,7 @@
        if (vm_static_inactive_target)
                return vm_static_inactive_target;

- -       return num_physpages / 4;
+       return num_physpages / 5;
 }

 /*

- -
To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO8aAr+AqzTDdanI2EQK5PACg3VrHzhPuVgFBGZle0xR2qRE8wC8AoLmu
3D4RbMocXN7IVTdacDT4WTAb
=oppX
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
