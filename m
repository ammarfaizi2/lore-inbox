Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271580AbRIJSpX>; Mon, 10 Sep 2001 14:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271586AbRIJSpN>; Mon, 10 Sep 2001 14:45:13 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:19204 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S271580AbRIJSpA>; Mon, 10 Sep 2001 14:45:00 -0400
Date: Mon, 10 Sep 2001 11:45:21 -0700
From: Zach Brown <zab@osdlab.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] 2.4.9 si_swapinfo() speedup
Message-ID: <20010910114521.E19051@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the attached patch makes si_swapinfo() use the swapfile.c global page
accounting rather than walking the swapfiles to find the total and
free numbers.  Some folks have seen si_swapinfo() take an absurd amount
of time..

Rik hints at rumours of the global accounting being questionable in some
cases, perhaps more use of it would motivate that to be fixed :)

compiles, but totally untested.

- z

--- linux-2.4.9/mm/swapfile.c.swapinfo	Mon Sep 10 11:06:05 2001
+++ linux-2.4.9/mm/swapfile.c	Mon Sep 10 11:40:22 2001
@@ -877,27 +877,12 @@
 
 void si_swapinfo(struct sysinfo *val)
 {
-	unsigned int i;
-	unsigned long freeswap = 0;
-	unsigned long totalswap = 0;
+	swap_list_lock();
 
-	for (i = 0; i < nr_swapfiles; i++) {
-		unsigned int j;
-		if ((swap_info[i].flags & SWP_WRITEOK) != SWP_WRITEOK)
-			continue;
-		for (j = 0; j < swap_info[i].max; ++j) {
-			switch (swap_info[i].swap_map[j]) {
-				case SWAP_MAP_BAD:
-					continue;
-				case 0:
-					freeswap++;
-				default:
-					totalswap++;
-			}
-		}
-	}
-	val->freeswap = freeswap;
-	val->totalswap = totalswap;
+	val->totalswap = total_swap_pages;
+	val->freeswap = nr_swap_pages;
+
+	swap_list_unlock();
 	return;
 }
 
