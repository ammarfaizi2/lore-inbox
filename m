Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136114AbREHARZ>; Mon, 7 May 2001 20:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136710AbREHARP>; Mon, 7 May 2001 20:17:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15019 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136114AbREHAQ4>;
	Mon, 7 May 2001 20:16:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.15091.45238.172746@pizda.ninka.net>
Date: Mon, 7 May 2001 17:16:51 -0700 (PDT)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071920080.7515-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0105071645070.7915-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0105071920080.7515-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > My point is that its _ok_ for us to check if the page is a dead swap cache
 > page _without_ the lock since writepage() will recheck again with the page
 > _locked_. Quoting you two messages back: 
 > 
 > "But it is important to re-calculate the deadness after getting the lock.
 > Before, it was just an informed guess. After the lock, it is knowledge."
 > 
 > See ? 

In fact my patch isn't changing writepage behavior wrt. that page, it
is changing behavior with respect to laundering policy for that page.

Here, let's talk code a little bit so there are no misunderstandings,
I really want to put this to rest:

+		int dead_swap_page;
+
 		page = list_entry(page_lru, struct page, lru);
 
+		dead_swap_page =
+			(PageSwapCache(page) &&
+			 page_count(page) == (1 + !!page->buffers));
+

Calculate dead_swap_page outside of lock.

 		/* Page is or was in use?  Move it to the active list. */
-		if (PageTestandClearReferenced(page) || page->age > 0 ||
-				(!page->buffers && page_count(page) > 1) ||
-				page_ramdisk(page)) {
+		if (!dead_swap_page &&
+		    (PageTestandClearReferenced(page) || page->age > 0 ||
+		     (!page->buffers && page_count(page) > 1) ||
+		     page_ramdisk(page))) {
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_active_list(page);
 			continue;

If dead_swap_page, ignore referenced bit heuristics.

-			/* First time through? Move it to the back of the list */
-			if (!launder_loop) {
+			/* First time through? Move it to the back of the list,
+			 * but not if it is a dead swap page. We want to reap
+			 * those as fast as possible.
+			 */
+			if (!launder_loop && !dead_swap_page) {
 				list_del(page_lru);
 				list_add(page_lru, &inactive_dirty_list);
 				UnlockPage(page);

If dead_swap_page, ignore launder_loop.  Again, another heuristic
test, not a "state correctness" test.  "launder_loop" is not
protecting "state correctness" of what we do to the page.

Really, what does this have to do with swap counts and page counts?

It's a heuristic. In fact it even seems stupid to me to recalculate
dead_swap_page after we get the lock just for the sake of these
heuristics.

Maybe I should have diguised this bit as:

if (dead_swap_page)
	do_writepage_first_pass = 1;

To divert people's brains to what the intent was :-)

Later,
David S. Miller
davem@redhat.com
