Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264827AbRFXWMU>; Sun, 24 Jun 2001 18:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264828AbRFXWMK>; Sun, 24 Jun 2001 18:12:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12302 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264827AbRFXWLy>; Sun, 24 Jun 2001 18:11:54 -0400
Date: Sun, 24 Jun 2001 19:11:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix accounting of memory_pressure
Message-ID: <Pine.LNX.4.33L.0106241910030.23112-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the attached patch makes sure to only increase memory_pressure
in cases we actually found a page, this prevents the inactive
target from rising to infinite in case we don't have any
inactive_clean pages in the system...

(observed in testing)

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


--- linux-2.4.5-ac17/mm/page_alloc.c.unlazy	Sun Jun 24 19:03:03 2001
+++ linux-2.4.5-ac17/mm/page_alloc.c	Sun Jun 24 19:05:22 2001
@@ -440,7 +440,6 @@
 		 * 	  the inactive clean list. (done by page_launder)
 		 */
 		if (gfp_mask & __GFP_WAIT) {
-			memory_pressure++;
 			try_to_free_pages(gfp_mask);
 			goto try_again;
 		}
--- linux-2.4.5-ac17/mm/vmscan.c.unlazy	Sun Jun 24 19:03:03 2001
+++ linux-2.4.5-ac17/mm/vmscan.c	Sun Jun 24 19:05:36 2001
@@ -397,6 +397,7 @@
 	goto out;

 found_page:
+	memory_pressure++;
 	del_page_from_inactive_clean_list(page);
 	UnlockPage(page);
 	page->age = PAGE_AGE_START;
@@ -406,7 +407,6 @@
 out:
 	spin_unlock(&pagemap_lru_lock);
 	spin_unlock(&pagecache_lock);
-	memory_pressure++;
 	return page;
 }


