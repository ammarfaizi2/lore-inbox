Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbULUJUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbULUJUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 04:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULUJSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 04:18:41 -0500
Received: from siaag2aa.compuserve.com ([149.174.40.131]:14811 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261438AbULUJQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 04:16:10 -0500
Date: Tue, 21 Dec 2004 04:11:41 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Linux 2.6.9-ac16
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Ross <chris@tebibyte.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200412210413_MC3-1-9172-2609@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Chuck Ebbert wrote:
> 
> >  Nobody has found an answer for the freezes, which persist even in the latest
> > 2.6.10-rc but there's a vm_writeout throttling patch in -ac that I haven't tried.
>
> Heh.  Figures.  Those freezes are what bothers me most, since I've already got a 
> patch that protects critical processes from being OOM-killed as long as they're 
> sane.

 I backported this patch to 2.6.9 but haven't tested it yet.  It requires the
'spurious oomkill' patch I posted earlier in this thread.  Early reports
are that it stops the freezes during heavy paging.

 Also appended is a newer patch from Andrew that may help as well.  It's obviously
correct but I haven't done anything with it yet so it may not apply to 2.6.9.

===================================================================================
# mm_swap_token_timeout.patch
#
#       Disable token-based thrashing control when token
#       timeout is zero and make zero the default value.
#
#       NOTE: On 2.6.9 there is no way to change the
#       token timeout at runtime like there is on 2.6.10.
#       You must edit mm/thrash.c instead.
#
#       Patch by Con Kolivas for 2.6.10-rc3 20 Dec 2004
#       Backported to 2.6.9 by Chuck Ebbert
#
--- 2.6.9.1/mm/rmap.c
+++ 2.6.9.2/mm/rmap.c
@@ -395,6 +395,9 @@ int page_referenced(struct page *page, i
 {
        int referenced = 0;
 
+       if (!SWAP_TOKEN_TIMEOUT)
+               ignore_token = 1;
+
        if (page_test_and_clear_young(page))
                referenced++;
 
--- 2.6.9.1/mm/thrash.c
+++ 2.6.9.2/mm/thrash.c
@@ -19,7 +19,10 @@ unsigned long swap_token_check;
 struct mm_struct * swap_token_mm = &init_mm;
 
 #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
-#define SWAP_TOKEN_TIMEOUT (HZ * 300)
+#define SWAP_TOKEN_TIMEOUT     0
+/*
+ * Currently disabled; Needs further code to work at HZ * 300.
+ */
 
 /*
  * Take the token away if the process had no page faults
===================================================================================
# We haven't been incrementing local variable total_scanned since the
# scan_control stuff went in.  That broke kswapd throttling.
# 
# Signed-off-by: Andrew Morton <akpm@osdl.org>
# ---
# 
#  25-akpm/mm/vmscan.c |    1 +
#  1 files changed, 1 insertion(+)
# 
# diff -puN mm/vmscan.c~vmscan-total_scanned-fix mm/vmscan.c
--- 25/mm/vmscan.c~vmscan-total_scanned-fix     2004-12-20 12:47:25.855643408 -0800
+++ 25-akpm/mm/vmscan.c 2004-12-20 12:47:25.860642648 -0800
@@ -1063,6 +1063,7 @@ scan:
                        shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
                        sc.nr_reclaimed += reclaim_state->reclaimed_slab;
                        total_reclaimed += sc.nr_reclaimed;
+                       total_scanned += sc.nr_scanned;
                        if (zone->all_unreclaimable)
                                continue;
                        if (zone->pages_scanned >= (zone->nr_active +
===================================================================================
--
Please take it as a sign of my infinite respect for you,
that I insist on you doing all the work.
                                        -- Rusty Russell
