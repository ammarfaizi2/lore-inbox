Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbUKGFFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUKGFFR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 00:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbUKGFFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 00:05:17 -0500
Received: from siaag1ae.compuserve.com ([149.174.40.7]:36545 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261537AbUKGFFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 00:05:03 -0500
Date: Sun, 7 Nov 2004 00:02:07 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Kernel memory requirements and BK
To: Art Haas <ahaas@airmail.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411070004_MC3-1-8E11-3F5E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Art Haas wrote:

> With the 2.6.9 and 2.6.10-rc kernels, BK bombs out with
> out-of-memory errors once the repository checking begins.

There's nothing wrong with BK's performance that can't be
solved by a terahertz processor and a terabyte of RAM. ;)

But these patches might help:

===============================================================================
# vm_pages_scanned_active_list.patch
#
#       Stop kswapd from looping.
#
#       Patch by Nick Piggin 24 Oct 2004
#       Signed-off-by: Andrew Morton <akpm@osdl.org>
#       Signed-off-by: Linus Torvalds <torvalds@osdl.org>
#       Status: in 2.6.10
#
--- 2.6.9/mm/vmscan.c
+++ 2.6.9.1/mm/vmscan.c
@@ -574,7 +574,6 @@ static void shrink_cache(struct zone *zo
                        nr_taken++;
                }
                zone->nr_inactive -= nr_taken;
-               zone->pages_scanned += nr_taken;
                spin_unlock_irq(&zone->lru_lock);
 
                if (nr_taken == 0)
@@ -675,6 +674,7 @@ refill_inactive_zone(struct zone *zone, 
                }
                pgscanned++;
        }
+       zone->pages_scanned += pgscanned;
        zone->nr_active -= pgmoved;
        spin_unlock_irq(&zone->lru_lock);
 
===============================================================================
# spurious_oomkill.patch
#
#       Prevent spurious out of memory process kills.
#       Reported to work by testers on lkml.
#
#       Patch by Rik van Riel <riel@redhat.com>
#       Status: NOT in 2.6.10
#
--- 2.6.9/mm/vmscan.c
+++ 2.6.9.1/mm/vmscan.c
@@ -379,7 +379,7 @@
 
                referenced = page_referenced(page, 1);
                /* In active use or really unfreeable?  Activate it. */
-               if (referenced && page_mapping_inuse(page))
+               if (referenced && sc->priority && page_mapping_inuse(page))
                        goto activate_locked;
 
 #ifdef CONFIG_SWAP
@@ -715,7 +715,7 @@
                if (page_mapped(page)) {
                        if (!reclaim_mapped ||
                            (total_swap_pages == 0 && PageAnon(page)) ||
-                           page_referenced(page, 0)) {
+                           (page_referenced(page, 0) && sc->priority)) {
                                list_add(&page->lru, &l_active);
                                continue;
                        }
===============================================================================

--Chuck Ebbert  06-Nov-04  23:55:23
