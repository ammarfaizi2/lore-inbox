Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274099AbRITCwa>; Wed, 19 Sep 2001 22:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274159AbRITCwV>; Wed, 19 Sep 2001 22:52:21 -0400
Received: from [195.223.140.107] ([195.223.140.107]:3575 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274099AbRITCwG>;
	Wed, 19 Sep 2001 22:52:06 -0400
Date: Thu, 20 Sep 2001 04:52:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Shane Wegner <shane@cm.nu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
Message-ID: <20010920045235.N720@athlon.random>
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz> <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz> <20010919153441.A30940@cm.nu> <20010920004543.Z720@athlon.random> <20010919193128.A8650@cm.nu> <20010919193649.A8824@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010919193649.A8824@cm.nu>; from shane@cm.nu on Wed, Sep 19, 2001 at 07:36:49PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 07:36:49PM -0700, Shane Wegner wrote:
> On Wed, Sep 19, 2001 at 07:31:28PM -0700, Shane Wegner wrote:
> > On Thu, Sep 20, 2001 at 12:45:43AM +0200, Andrea Arcangeli wrote:
> > > On Wed, Sep 19, 2001 at 03:34:41PM -0700, Shane Wegner wrote:
> > > > 
> > > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > > c012e052
> > > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > > c012e052
> > > > __alloc_pages: 0-order allocation failed (gfp=0x20/0) from
> > > > c012e052
> > > 
> > > yes, please try this fix and let me know if it helps:
> > 
> > After some stress testing, the fix does appear to fix the
> > error.
> 
> Hi,
> 
> Well just after I sent the email, it came up again.
> 
> 
> Sep 19 19:31:52 continuum kernel: __alloc_pages: 0-order
> allocation failed (gfp=0x20/0) from c012e052
> Sep 19 19:33:51 continuum kernel: __alloc_pages: 0-order
> allocation failed (gfp=0x20/0) from c012e052

did it happen as frequently/easily as before or did you need to stress
it much harder? And I'm also curious what happens if we simply lower the
watemark (possibly it was too high). Anyways the other patch is a good
idea to apply anyways.

So can now try the below new one?

--- 2.4.10pre11aa1/mm/page_alloc.c.~1~	Thu Sep 20 00:36:11 2001
+++ 2.4.10pre11aa1/mm/page_alloc.c	Thu Sep 20 04:45:44 2001
@@ -346,7 +346,7 @@
 		if (!z)
 			break;
 
-		if (zone_free_pages(z, order) > (gfp_mask & __GFP_HIGH ? z->pages_min / 2 : z->pages_min)) {
+		if (zone_free_pages(z, order) > (gfp_mask & __GFP_HIGH ? z->pages_min / 4 : z->pages_min)) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;


the fact is, kswapd is the only entity meant to shrink the caches for
the atomic pages, it exactly knows what are the zones that needs to be
balanced and we have a min-min/2 of pages of GAP that must be refilled
in time. It just seems kswapd doesn't cope with the frequency of the
allocations sometime, this may be ok but maybe we must find a way to
more aggressively free memory for the atomic allocations or it could
simply mean that the watermark GAP was too small as Marcelo just
suggested previously.

Can you also resolve "c012e052" so we know who's allocating those pages
just in case?

Andrea
