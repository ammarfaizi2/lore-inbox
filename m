Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUBVGJR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUBVGJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:09:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:18649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbUBVGJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:09:13 -0500
Date: Sat, 21 Feb 2004 22:09:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: cw@f00f.org, torvalds@osdl.org, mfedyk@matchmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-Id: <20040221220927.198749d4.akpm@osdl.org>
In-Reply-To: <4038307B.2090405@cyberone.com.au>
References: <4037FCDA.4060501@matchmail.com>
	<20040222023638.GA13840@dingdong.cryptoapps.com>
	<Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
	<20040222031113.GB13840@dingdong.cryptoapps.com>
	<Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
	<20040222033111.GA14197@dingdong.cryptoapps.com>
	<4038299E.9030907@cyberone.com.au>
	<40382BAA.1000802@cyberone.com.au>
	<4038307B.2090405@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> Although, nr_used_zone_pages probably shouldn't be counting
>  highmem zones, which might be our problem.

yeah.  We should have made that change when making shrink_slab() ignore
highmem scanning.

Something like this (the function needs a rename)

--- 25/mm/page_alloc.c~shrink_slab-highmem-fix	2004-02-21 22:07:32.000000000 -0800
+++ 25-akpm/mm/page_alloc.c	2004-02-21 22:08:03.000000000 -0800
@@ -769,8 +769,10 @@ unsigned int nr_used_zone_pages(void)
 	unsigned int pages = 0;
 	struct zone *zone;
 
-	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
+	for_each_zone(zone) {
+		if (zone - zone->zone_pgdat->node_zones < ZONE_HIGHMEM)
+			pages += zone->nr_active + zone->nr_inactive;
+	}
 
 	return pages;
 }

_

