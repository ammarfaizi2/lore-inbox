Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbRESRRm>; Sat, 19 May 2001 13:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbRESRRc>; Sat, 19 May 2001 13:17:32 -0400
Received: from www.wen-online.de ([212.223.88.39]:14098 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261897AbRESRRZ>;
	Sat, 19 May 2001 13:17:25 -0400
Date: Sat, 19 May 2001 19:13:01 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <20010518235852.R8080@redhat.com>
Message-ID: <Pine.LNX.4.33.0105191743000.393-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 18 May 2001, Stephen C. Tweedie wrote:

> That's the main problem with static parameters.  The problem you are
> trying to solve is fundamentally dynamic in most cases (which is also
> why magic numbers tend to suck in the VM.)

Magic numbers might be sucking some performance right now ;-)

Three back to back make -j 30 runs for three different kernels.
Swap cache numbers are taken immediately after last completion.

Reference runs  (bad numbers.  cache collapse hurts.. a lot)
real    12m8.157s  11m41.192s  11m36.069s  2.4.4.virgin
user    7m57.710s   7m57.820s   7m57.150s
sys     0m37.200s   0m37.070s   0m37.020s
Swap cache: add 785029, delete 781670, find 243396/1051626

                    oddball.. infrequent, but happens
                    vvvv
real    10m30.470s  9m36.478s   9m50.512s  2.4.5-pre3.virgin
user    7m54.300s   7m53.430s   7m55.200s
sys     0m36.010s   0m36.850s   0m35.230s
Swap cache: add 1018892, delete 1007053, find 821456/1447811

real    9m9.679s    9m18.291s   8m55.981s  3.4.5-pre3.tweak
user    7m55.590s   7m57.060s   7m55.850s
sys     0m34.890s   0m34.370s   0m34.330s
Swap cache: add 656966, delete 646676, find 325186/865183

--- linux-2.4.5-pre3/mm/vmscan.c.org	Thu May 17 16:44:23 2001
+++ linux-2.4.5-pre3/mm/vmscan.c	Sat May 19 11:52:40 2001
@@ -824,39 +824,17 @@
 #define DEF_PRIORITY (6)
 static int refill_inactive(unsigned int gfp_mask, int user)
 {
-	int count, start_count, maxtry;
-
-	if (user) {
-		count = (1 << page_cluster);
-		maxtry = 6;
-	} else {
-		count = inactive_shortage();
-		maxtry = 1 << DEF_PRIORITY;
-	}
-
-	start_count = count;
-	do {
-		if (current->need_resched) {
-			__set_current_state(TASK_RUNNING);
-			schedule();
-			if (!inactive_shortage())
-				return 1;
-		}
-
-		count -= refill_inactive_scan(DEF_PRIORITY, count);
-		if (count <= 0)
-			goto done;
-
-		/* If refill_inactive_scan failed, try to page stuff out.. */
-		swap_out(DEF_PRIORITY, gfp_mask);
-
-		if (--maxtry <= 0)
-				return 0;
-
-	} while (inactive_shortage());
-
-done:
-	return (count < start_count);
+	int shortage = inactive_shortage();
+	int large = freepages.high/2;
+	int scale;
+
+	scale = shortage/large;
+	scale += free_shortage()/large;
+	if (scale > DEF_PRIORITY-1)
+		scale = DEF_PRIORITY-1;
+	if (refill_inactive_scan(DEF_PRIORITY-scale, shortage) < shortage)
+		return swap_out(DEF_PRIORITY, gfp_mask);
+	return 1;
 }

 static int do_try_to_free_pages(unsigned int gfp_mask, int user)
@@ -976,7 +954,8 @@
 		 * We go to sleep for one second, but if it's needed
 		 * we'll be woken up earlier...
 		 */
-		if (!free_shortage() || !inactive_shortage()) {
+		if (current->need_resched || !free_shortage() ||
+				!inactive_shortage()) {
 			interruptible_sleep_on_timeout(&kswapd_wait, HZ);
 		/*
 		 * If we couldn't free enough memory, we see if it was
@@ -1054,7 +1033,7 @@
 				if (!zone->size)
 					continue;

-				while (zone->free_pages < zone->pages_low) {
+				while (zone->free_pages < zone->inactive_clean_pages) {
 					struct page * page;
 					page = reclaim_page(zone);
 					if (!page)


Now, lets go back to the patch I posted which reduced context switches
under load by ~40% (of ~685000) for a moment.  Kswapd is asleep while
awaiting IO completion.  The guys who are pestering the sleeping kswapd
are going to be doing page_launder to fix the shortage they're yammering
at kswapd about.  We're nibbling away at the free shortage..  and the
inactive_dirty list.  So now, we have an inactive shortage as well as
a large free shortage when we enter refill_inactive.  (shortages became
large because kswapd is sleeping on the job)

6 * (1 << page_cluster) is larger than MAX_LAUNDER, but I don't see any
reason to sneak up on the shortage instead of correcting it all at once.
It takes too long to find out it's going to fail.  Why not just get it
over with before every scrubber in the system is sleeping on IO.. except
the ones doing swap pagebuffer allocations.  They can swapout, but they
can't help push swap, so it'll all sit there until somebody wakes up no?

If I'm interpreting the results right, taking it all on at once is saving
a lot of what looks to me to be unnecessary swap.  I can't see those
swap numbers as being anything other than unnecessary given that I see
no evidence of cache collapse as in 2.4.4 and earlier kernels, and the
job is getting done faster without them.

	-Mike

(yes, the last hunk looks out of place wrt my text.  however, it improves
throughput nicely, so I left it in.  swap reduction and time savings are
present without it.. just not quite as pretty;)

