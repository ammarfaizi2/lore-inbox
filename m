Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVKCWhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVKCWhw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVKCWhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:37:52 -0500
Received: from dvhart.com ([64.146.134.43]:18095 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932581AbVKCWhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:37:51 -0500
Date: Thu, 03 Nov 2005 14:37:46 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <43370000.1131057466@flay>
In-Reply-To: <Pine.LNX.4.64.0511031102590.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au><Pine.LNX.4.58.0511010137020.29390@skynet><4366D469.2010202@yahoo.com.au><Pine.LNX.4.58.0511011014060.14884@skynet><20051101135651.GA8502@elte.hu><1130854224.14475.60.camel@localhost><20051101142959.GA9272@elte.hu><1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu><1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu><436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost><43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]><4369824E.2020407@yahoo.com.au><306020000.1131032193@[10.10.2.4]><1131032422.2839.8.camel@laptopd505.fenrus.org><Pine.LNX.4.64.0511030747450.27915@g5.osdl.org><Pine.LNX.4.58.0511031613560.3571@skynet>
 <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org><309420000.1131036740@[10.10.2.4]><Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]><314040000.1131043735@[10.10.2.4]> <Pine.LNX.4.64.0511031102590.27915@g5.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ha. Just because I don't think I made you puke hard enough already with
>> foul approximations ... for order 2, I think it's
> 
> Your basic fault is in believing that the free watermark would stay 
> constant.
> 
> That's insane.
> 
> Would you keep 8MB free on a 64MB system?
> 
> Would you keep 8MB free on a 8GB system?
> 
> The point being, that if you start with insane assumptions, you'll get 
> insane answers.

Ummm. I was basing it on what we actually do now in the code, unless I
misread it, which is perfectly possible. Do you want this patch?

diff -purN -X /home/mbligh/.diff.exclude linux-2.6.14/mm/page_alloc.c 2.6.14-no_water_cap/mm/page_alloc.c
--- linux-2.6.14/mm/page_alloc.c	2005-10-27 18:52:20.000000000 -0700
+++ 2.6.14-no_water_cap/mm/page_alloc.c	2005-11-03 14:36:06.000000000 -0800
@@ -2387,8 +2387,6 @@ static void setup_per_zone_pages_min(voi
 			min_pages = zone->present_pages / 1024;
 			if (min_pages < SWAP_CLUSTER_MAX)
 				min_pages = SWAP_CLUSTER_MAX;
-			if (min_pages > 128)
-				min_pages = 128;
 			zone->pages_min = min_pages;
 		} else {
 			/* if it's a lowmem zone, reserve a number of pages


> The _correct_ assumption is that you aim to keep some fixed percentage of 
> memory free. With that assumption and your math, finding higher-order 
> pages is equally hard regardless of amount of memory. 

That would, indeed, make more sense.
 
> Now, your math then doesn't allow for the fact that buddy automatically 
> coalesces for you, so in fact things get _easier_ with more memory, but 
> hey, that needs more math than I can come up with (I never did it as math, 
> only as simulations with allocation patterns - "smart people use math, 
> plodding people just try to simulate an estimate" ;)

Not sure what people who do math, but wrongly, are called, but I'm sure 
it's not polite, and I'm sure I'm one of those ;-)

M.
