Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267486AbRGSJCL>; Thu, 19 Jul 2001 05:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267495AbRGSJCC>; Thu, 19 Jul 2001 05:02:02 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62989 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267486AbRGSJBn>; Thu, 19 Jul 2001 05:01:43 -0400
Date: Thu, 19 Jul 2001 04:30:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.33.0107181801320.7602-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107190419280.9510-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jul 2001, Linus Torvalds wrote:

> 
> On Wed, 18 Jul 2001, Marcelo Tosatti wrote:
> > >
> > > Wait. Don't you mean:
> 
> Yes. Just ignore me when I show extreme signs of Alzheimers.

Ok.

Well, here is a patch on top of -ac5 (which already includes the first
zoned based approach patch).

I changed inactive_plenty() to use "zone->size / 3" instead "zone->size /
2".

Under _my_ tests using half of the perzone total pages as the inactive
target was too high.

I also changed refill_inactive_scan() to return the number of deactivated
pages for the zone which we are scanning (if perzone scanning is being
done at all, of course). This avoids miscalculations of the number of
deactivated pages.

I'm still using a zone pointer as a boolean in try_to_swap_out(). Reason:
Its 6am in the morning, I already generated the patch, and the cab is down
there waiting.


Comments?

diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/include/linux/swap.h linux/include/linux/swap.h
--- linux.orig/include/linux/swap.h	Thu Jul 19 05:40:34 2001
+++ linux/include/linux/swap.h	Wed Jul 18 23:19:05 2001
@@ -131,6 +131,7 @@
 
 extern unsigned int zone_free_shortage(zone_t *zone);
 extern unsigned int zone_inactive_shortage(zone_t *zone);
+extern unsigned int zone_inactive_plenty(zone_t *zone);
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.orig/mm/page_alloc.c	Thu Jul 19 05:40:34 2001
+++ linux/mm/page_alloc.c	Thu Jul 19 05:41:39 2001
@@ -707,6 +707,20 @@
 	return sum;
 }
 
+unsigned int zone_inactive_plenty(zone_t *zone)
+{
+	int inactive;
+
+	if (!zone->size)
+		return 0;
+		
+	inactive = zone->inactive_dirty_pages;
+	inactive += zone->inactive_clean_pages;
+	inactive += zone->free_pages;
+
+	return (inactive > (zone->size / 3));
+
+}
 unsigned int zone_inactive_shortage(zone_t *zone) 
 {
 	int sum = 0;
diff -Nur --exclude-from=/home/marcelo/exclude linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Thu Jul 19 05:40:34 2001
+++ linux/mm/vmscan.c	Thu Jul 19 05:48:18 2001
@@ -46,7 +46,7 @@
 	 * touch pages from zones which don't have a 
 	 * shortage.
 	 */
-	if (zone && !zone_inactive_shortage(page->zone))
+	if (zone_inactive_plenty(page->zone))
 		return;
 
 	/* Don't look at this pte if it's been accessed recently. */
@@ -637,8 +637,7 @@
 	 * loads, flush out the dirty pages before we have to wait on
 	 * IO.
 	 */
-	if (CAN_DO_IO && !launder_loop && (free_shortage() 
-				|| (zone && zone_free_shortage(zone)))) {
+	if (CAN_DO_IO && !launder_loop && total_free_shortage()) {
 		launder_loop = 1;
 		/* If we cleaned pages, never do synchronous IO. */
 		if (cleaned_pages)
@@ -718,11 +717,11 @@
 		}
 
 		/*
-		 * If we are doing zone-specific scanning, ignore
-		 * pages from zones without shortage.
+		 * Do not deactivate pages from zones which 
+		 * have plenty inactive pages.
 		 */
 
-		if (zone && !zone_inactive_shortage(page->zone)) {
+		if (zone_inactive_plenty(page->zone)) {
 			page_active = 1;
 			goto skip_page;
 		}
@@ -756,12 +755,13 @@
 		 * to the other end of the list. Otherwise we exit if
 		 * we have done enough work.
 		 */
-skip_page:
 		if (page_active || PageActive(page)) {
+skip_page:
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
 		} else {
-			nr_deactivated++;
+			if (!zone || (zone && (zone == page->zone)))
+				nr_deactivated++;
 			if (target && nr_deactivated >= target)
 				break;
 		}

