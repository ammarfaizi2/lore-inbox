Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUHXT5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUHXT5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUHXT5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:57:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42405 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267312AbUHXT4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:56:23 -0400
Date: Tue, 24 Aug 2004 15:20:36 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <20040824182036.GB8806@logos.cnet>
References: <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org> <20040812180033.62b389db@laptop.delusion.de> <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org> <20040820000238.55e22081@laptop.delusion.de> <20040820001154.0a5cf331.akpm@osdl.org> <20040820001905.27a9ff8f@laptop.delusion.de> <4125AD23.4000705@yahoo.com.au> <20040823230824.3c937d88@laptop.delusion.de> <412AF113.6000804@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412AF113.6000804@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 05:41:07PM +1000, Nick Piggin wrote:
> Udo A. Steinberg wrote:
> 
> >On Fri, 20 Aug 2004 17:49:55 +1000 Nick Piggin (NP) wrote:
> >
> >NP> Can you reproduce the OOM with the following patch please? Then
> >NP> send the output.
> >
> >I reproduced the problem using a slightly different setup to trigger the
> >problem faster:  128 MB RAM, 188992 KB swap
> >
> >Here's the output of the OOM killer with your patch applied:
> >
> >oom-killer: gfp_mask=0x1d2
> >DMA per-cpu:
> >cpu 0 hot: low 2, high 6, batch 1
> >cpu 0 cold: low 0, high 2, batch 1
> >Normal per-cpu:
> >cpu 0 hot: low 14, high 42, batch 7
> >cpu 0 cold: low 0, high 14, batch 7
> >HighMem per-cpu: empty
> >
> >Free pages:        1316kB (0kB HighMem)
> >Active:5281 inactive:23611 dirty:0 writeback:0 unstable:0 free:329 
> >slab:1403 mapped:12232 pagetables:167
> >DMA free:712kB min:44kB low:88kB high:132kB active:5076kB inactive:5332kB 
> >present:16384kB pages_scanned:10112 all_unreclaimable? yes
> >protections[]: 22 178 178
> >Normal free:604kB min:312kB low:624kB high:936kB active:16048kB 
> >inactive:89112kB present:114688kB pages_scanned:62432 all_unreclaimable? 
> >yes
> >protections[]: 0 156 156
> >HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB 
> >present:0kB pages_scanned:0 all_unreclaimable? no
> >protections[]: 0 0 0
> >DMA: 0*4kB 3*8kB 13*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 
> >0*2048kB 0*4096kB = 712kB
> >Normal: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 
> >0*2048kB 0*4096kB = 604kB
> >HighMem: empty
> >Swap cache: add 90886, delete 74524, find 4659/4974, race 0+0
> >Out of Memory: Killed process 1217 (gphoto2).
> >
> >

Hi Nick,

> OK, all_unreclaimable caused the scanner to virtually stop. If 
> all_unreclaimable
> gets set, it throttles the scanning of that zone right back, which in 
> turn greatly
> lowers the chance that all_unreclaimable will get cleared.

Which is the logic to stop tasks from shrink_zone()ing zones
which are known to be heavily scanned by kswapd 
(ie zone->pages_scanned > zone->present_pages * 2).

With that logic we want tasks doing direct free to 
blk_congestion_wait(WRITE, HZ/10) instead shrink_zone()ing 
(and blk_congestion_wait(WRITE, HZ/50) on __alloc_pages()).

I dont fully understand the all_unreclaimable logic yet. AFAICS it was
added to prevent tasks from wasting excessive CPU time on shrinking
the lists.

But at the same time it stops tasks from potentially throttling on IO 
(on shrink_list -> pageout). Is that a feature?

> When we get to priority = 0 in try_to_free_pages (ie. close to OOM), it 
> might be
> worth clearing each zone's all_unreclaimable for this last time 'round 
> the loop.

Or ignore all_unreclaimable when priority == 0 like this?

It feels hackish for me but will effectively work as cleaning all_unreclaimable
on zero priority.

Against 2.6.9-rc1-bktoday. 

Udo, one question, do you have swap space available when the OOM killer triggers ?
Dont remember seeing any info wrt to that.

--- mm/vmscan.c.orig	2004-08-24 16:48:09.467086840 -0300
+++ mm/vmscan.c	2004-08-24 16:51:55.304754296 -0300
@@ -878,7 +878,8 @@
 		if (zone->prev_priority > sc->priority)
 			zone->prev_priority = sc->priority;
 
-		if (zone->all_unreclaimable && sc->priority != DEF_PRIORITY)
+		if (zone->all_unreclaimable && 
+				(sc->priority < DEF_PRIORITY && sc->priority > 0))
 			continue;	/* Let kswapd poll it */
 
 		shrink_zone(zone, sc);
@@ -1054,7 +1055,8 @@
 		for (i = 0; i <= end_zone; i++) {
 			struct zone *zone = pgdat->node_zones + i;
 
-			if (zone->all_unreclaimable && priority != DEF_PRIORITY)
+			if (zone->all_unreclaimable && 
+					(priority < DEF_PRIORITY && priority > 0))
 				continue;
 
 			if (nr_pages == 0) {	/* Not software suspend */
