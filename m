Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273047AbRIRReL>; Tue, 18 Sep 2001 13:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273066AbRIRRdw>; Tue, 18 Sep 2001 13:33:52 -0400
Received: from caracal.noc.ucla.edu ([169.232.10.11]:12466 "EHLO
	caracal.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S273047AbRIRRdu>; Tue, 18 Sep 2001 13:33:50 -0400
Message-ID: <3BA78561.27A89CF1@ucla.edu>
Date: Tue, 18 Sep 2001 10:33:21 -0700
From: Benjamin Redelings I <bredelin@ucla.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Make 2.4.10-pre10 use page->age [BUG] swap death
Content-Type: multipart/mixed;
 boundary="------------BAFE1D8C4B63FED01B751AB1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BAFE1D8C4B63FED01B751AB1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is a patch (also included as a MIME attatchment) which does
2 things:

	1. Make page aging be +3 for use and -1 for no use. I think that Rik
reported that this works well, and is what BSD uses?

	2. Make try_to_swap_out use page->age in deciding which pages to
deactivate.  This should work well and quite simply, by extending the
logic that Linus added:

Linus's logic rephrased (I think):
   a) if a page is inactive-clean [reclaim_page]
	scanning the list moves references pages to front of list
	double-referenced pages move to inactive-dirty
   b) if a page is inactive-dirty [page_launder]
	scanning the list moves referenced pages to front of list
	double-referenced pages move to inactive-dirty
   c) if a page is active [refill_inactive_scan]
	scanning the list:
		ages up referenced pages,
		ages down unreferenced pages
		(but we ignore the ages)
	don't swap out referenced pages

So, on the active list, referenced bits are converted to age.  If we
think of the referenced bit as an age with only two values, then
page->age is like a referenced-COUNT instead of a referenced BIT.
So age is like a proxy for the referenced bit that simply has more than
two states.  The result of this is that we deactivate the page only if
it has page->age==0 AND is unreferenced (which will soon be converted
into a positive age).
	This patch seems to work well.  It gives much better interactive feel
that 2.4.10-pre4 on low-memory boxes (e.g. 64Mb RAM), although I don't
know how much of that is due to Linus and how much is due to this small
change.
	However, with this patch my box swapped to death, using all available
64Mb memory and 128Mb swap running only netscape and 'find'.  So I
presume that around 128Mb of 'find' pages got swapped out.  The cache
shrunk to about 1 Mb before the system froze doing heavy disk activity
but not responding to mouse movements, although I got it back by
pressing Alt-SysReq-K and killing x-windows.  Is there any reason to
think that this is a result of the patch below, and not a problem with
2.4.10-pre10?  People have been reporting smaller cache sizes.

	1. Could this be because mark_page_accessed has no effect on pages on
the active list if they already marked referenced?  e.g. maybe I need to
add to mark_page_accessed:

+ 	if (PageActive(page) && PageReferenced(page)) {
+               age_page_up(page);
+               ClearPageReferenced(page);
+               return;
+       }



	2. Could this be because Linus removed Daniel Phillips hack which
marked swapped-in pages referenced?

thanks,
-benRI

--- vmscan.c.old	Tue Sep 18 09:49:16 2001
+++ vmscan.c	Tue Sep 18 09:49:46 2001
@@ -42,7 +42,8 @@
 
 static inline void age_page_down(struct page * page)
 {
-	page->age /= 2;
+        if (page->age>0)
+                page->age--;
 }
 
 /*
@@ -127,7 +128,7 @@
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		mm->rss--;
-		if (!PageReferenced(page))
+		if (!PageReferenced(page) && !page->age)
 			deactivate_page(page);
 		UnlockPage(page);
 		page_cache_release(page);

-- 
"I will begin again" - U2, 'New Year's Day'
Benjamin Redelings I      <><     http://www.bol.ucla.edu/~bredelin/
--------------BAFE1D8C4B63FED01B751AB1
Content-Type: text/plain; charset=us-ascii;
 name="aging.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aging.diff"

--- vmscan.c.old	Tue Sep 18 09:49:16 2001
+++ vmscan.c	Tue Sep 18 09:49:46 2001
@@ -42,7 +42,8 @@
 
 static inline void age_page_down(struct page * page)
 {
-	page->age /= 2;
+        if (page->age>0)
+                page->age--;
 }
 
 /*
@@ -127,7 +128,7 @@
 		set_pte(page_table, swp_entry_to_pte(entry));
 drop_pte:
 		mm->rss--;
-		if (!PageReferenced(page))
+		if (!PageReferenced(page) && !page->age)
 			deactivate_page(page);
 		UnlockPage(page);
 		page_cache_release(page);

--------------BAFE1D8C4B63FED01B751AB1--

