Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUBVCy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUBVCy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:54:58 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:58247 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261645AbUBVCyy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:54:54 -0500
Message-ID: <403819FB.2080306@cyberone.com.au>
Date: Sun, 22 Feb 2004 13:54:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
CC: Mike Fedyk <mfedyk@matchmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com> <40380DE2.4030702@matchmail.com> <403814E5.3070106@cyberone.com.au> <40381819.7000606@cyberone.com.au>
In-Reply-To: <40381819.7000606@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------050603030905080904000001"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050603030905080904000001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

>
>
> Nick Piggin wrote:
>
>>
>> I have an idea it might be worthwhile to try using inactive list
>> scanning as an input to slab pressure...
>>
>
> Err that is what it does, of course. My idea was the other way
> round - use active list scanning as input. So no, that probably
> won't help.
>
> Only one way to find out though. Patch against 2.6.3-mm2.
>

*cough*


--------------050603030905080904000001
Content-Type: text/plain;
 name="vm-inactive-shrink-slab.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-inactive-shrink-slab.patch"

 linux-2.6-npiggin/mm/vmscan.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN mm/vmscan.c~vm-inactive-shrink-slab mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-inactive-shrink-slab	2004-02-22 13:39:45.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-02-22 13:45:01.000000000 +1100
@@ -797,6 +797,7 @@ static int
 shrink_zone(struct zone *zone, unsigned int gfp_mask,
 	int nr_pages, int *nr_scanned, struct page_state *ps, int priority)
 {
+	int ret;
 	unsigned long imbalance;
 	unsigned long nr_refill_inact;
 	unsigned long max_scan;
@@ -836,7 +837,10 @@ shrink_zone(struct zone *zone, unsigned 
 	if (max_scan < nr_pages * 2)
 		max_scan = nr_pages * 2;
 
-	return shrink_cache(nr_pages, zone, gfp_mask, max_scan, nr_scanned);
+	ret = shrink_cache(nr_pages, zone, gfp_mask, max_scan, nr_scanned);
+	/* Account for active list scanning too */
+	*nr_scanned += nr_refill_inact;
+	return ret;
 }
 
 /*

_

--------------050603030905080904000001--
