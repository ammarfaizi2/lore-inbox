Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030601AbVKDEkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030601AbVKDEkc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbVKDEkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:40:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030601AbVKDEkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:40:31 -0500
Date: Thu, 3 Nov 2005 20:39:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mbligh@mbligh.org, mel@csn.ul.ie, arjan@infradead.org,
       nickpiggin@yahoo.com.au, haveblue@us.ibm.com, mingo@elte.hu,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, arjanv@infradead.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051103203958.7d28ab85.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511031459110.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>
	<20051101135651.GA8502@elte.hu>
	<1130854224.14475.60.camel@localhost>
	<20051101142959.GA9272@elte.hu>
	<1130856555.14475.77.camel@localhost>
	<20051101150142.GA10636@elte.hu>
	<1130858580.14475.98.camel@localhost>
	<20051102084946.GA3930@elte.hu>
	<436880B8.1050207@yahoo.com.au>
	<1130923969.15627.11.camel@localhost>
	<43688B74.20002@yahoo.com.au>
	<255360000.1130943722@[10.10.2.4]>
	<4369824E.2020407@yahoo.com.au>
	<306020000.1131032193@[10.10.2.4]>
	<1131032422.2839.8.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
	<Pine.LNX.4.58.0511031613560.3571@skynet>
	<Pine.LNX.4.64.0511030842050.27915@g5.osdl.org>
	<309420000.1131036740@[10.10.2.4]>
	<Pine.LNX.4.64.0511030918110.27915@g5.osdl.org>
	<311050000.1131040276@[10.10.2.4]>
	<314040000.1131043735@[10.10.2.4]>
	<Pine.LNX.4.64.0511031102590.27915@g5.osdl.org>
	<43370000.1131057466@flay>
	<Pine.LNX.4.64.0511031459110.27915@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Thu, 3 Nov 2005, Martin J. Bligh wrote:
>  > 
>  > Ummm. I was basing it on what we actually do now in the code, unless I
>  > misread it, which is perfectly possible. Do you want this patch?
>  > 
>  > diff -purN -X /home/mbligh/.diff.exclude linux-2.6.14/mm/page_alloc.c 2.6.14-no_water_cap/mm/page_alloc.c
>  > --- linux-2.6.14/mm/page_alloc.c	2005-10-27 18:52:20.000000000 -0700
>  > +++ 2.6.14-no_water_cap/mm/page_alloc.c	2005-11-03 14:36:06.000000000 -0800
>  > @@ -2387,8 +2387,6 @@ static void setup_per_zone_pages_min(voi
>  >  			min_pages = zone->present_pages / 1024;
>  >  			if (min_pages < SWAP_CLUSTER_MAX)
>  >  				min_pages = SWAP_CLUSTER_MAX;
>  > -			if (min_pages > 128)
>  > -				min_pages = 128;
>  >  			zone->pages_min = min_pages;
>  >  		} else {
>  >  			/* if it's a lowmem zone, reserve a number of pages
> 
>  Ahh, you're right, there's a totally separate watermark for highmem.
> 
>  I think I even remember this. I may even be responsible. I know some of 
>  our less successful highmem balancing efforts in the 2.4.x timeframe had 
>  serious trouble when they ran out of highmem, and started pruning lowmem 
>  very very aggressively. Limiting the highmem water marks meant that it 
>  wouldn't do that very often.

No, that was me and Matthew Dobson, circa 2.5.71.  The thinking was that
highmem is just for userspace pages and we don't need to keep the free
memory pool around for things like atomic allocations.  Especially as a
proportionally-sized highmem emergency pool would be potentially hundreds of
(wasted) megabytes.

iirc, things worked ok with a highmem min_pages threshold of zero pages.  Back
in 2.5.70, before everyone else broke it ;)

