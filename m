Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269571AbRHHVwf>; Wed, 8 Aug 2001 17:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269583AbRHHVw0>; Wed, 8 Aug 2001 17:52:26 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:47376 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269571AbRHHVwV>; Wed, 8 Aug 2001 17:52:21 -0400
Date: Wed, 8 Aug 2001 17:23:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.33.0108080020120.923-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0108081721001.13989-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Aug 2001, Linus Torvalds wrote:

> 
> On Wed, 8 Aug 2001, Marcelo Tosatti wrote:
> >
> > Having "zone->pages_low" as the low water mark to when start kswapd does
> > _not_ mean we want "zone->pages_low" as the freetarget (or the "free
> > shortage" indicator).
> 
> Right. We want the free target to obviously be larger than the low target,
> to avoid hysteresis around it.  And at the same time the free target
> obviously has to be smaller than the more-than-enough "plenty" case.
> 
> So we actually have _three_ numbers, not two.
> 
> > Could you be more verbose ?
> 
> I already was, our mails crossed. I think the main thing I have decided to
> be a "Good Feature (tm)" is to consider the free target to be more of a
> global thing, and not a per-zone thing. While the low water mark and
> "plenty" mark obviously have to be per-zone decisions.
> 
> And we've actually done exactly this - this is how "inactive_target" works
> already, and how "global_free_shortage()" ends up working too. We just
> didn't write it down explicitly.

Your change in pre7 makes zone_inactive_shortage() not return the shortage
size, which is needed by refill_inactive().

--- linux.orig/mm/vmscan.c	Wed Aug  8 17:55:26 2001
+++ linux/mm/vmscan.c	Wed Aug  8 18:04:18 2001
@@ -54,16 +54,19 @@
 
 static unsigned int zone_inactive_shortage(zone_t *zone) 
 {
-	unsigned int inactive;
+	unsigned int sum;
 
 	if (!zone->size)
 		return 0;
 
-	inactive = zone->inactive_dirty_pages;
-	inactive += zone->inactive_clean_pages;
-	inactive += zone->free_pages;
-
-	return inactive < zone->pages_high;
+	sum = zone->pages_high;
+	sum -= zone->inactive_dirty_pages;
+	sum -= zone->inactive_clean_pages;
+	sum -= zone->free_pages;
+	
+	if (sum > 0)
+		return sum;
+	return 0;
 }
 
 static unsigned int zone_free_plenty(zone_t *zone)
 

