Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268998AbUJQBZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268998AbUJQBZD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 21:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJQBZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 21:25:03 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:29373 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268989AbUJQBYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 21:24:40 -0400
Message-ID: <4171C9CD.4000303@yahoo.com.au>
Date: Sun, 17 Oct 2004 11:24:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org> <4171C20D.1000105@pobox.com>
In-Reply-To: <4171C20D.1000105@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------080102000801060902000305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080102000801060902000305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:

> Free pages:        2264kB (0kB HighMem)
> Active:31606 inactive:78376 dirty:12 writeback:0 unstable:0 free:566 slab:16353 mapped:31544 pagetables:121
> DMA free:80kB min:20kB low:40kB high:60kB active:0kB inactive:0kB present:16384kB
> protections[]: 0 0 0
> Normal free:2184kB min:700kB low:1400kB high:2100kB active:126424kB inactive:313504kB present:507840kB
> protections[]: 0 0 0
> HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
> protections[]: 0 0 0
> DMA: 10*4kB 1*8kB 0*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 80kB
> Normal: 8*4kB 31*8kB 11*16kB 10*32kB 4*64kB 1*128kB 0*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 2184kB
> HighMem: empty
> Swap cache: add 1976, delete 1938, find 120/152, race 0+0
> Free swap:       2041740kB
> 131056 pages of RAM
> 3391 reserved pages
> 79434 pages shared
> 38 pages swap cached

No LRU pages in ZONE_DMA. Lots of crap stops working in these sorts of
corner cases. I have (unfortunately?) been fairly good at exposing these
latent bugs.

Can you try this patch. It A fixes the (rare) possibility that DMA might
have reclaimable slab (this shouldn't affect you); and B fixes
all_unreclaimable to at least have a hope of working when there are no
LRU pages.

Thanks.

--------------080102000801060902000305
Content-Type: text/x-patch;
 name="vm-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-fix.patch"




---

 linux-2.6-npiggin/mm/vmscan.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN mm/vmscan.c~vm-fix mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-fix	2004-10-17 11:14:02.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-10-17 11:20:55.000000000 +1000
@@ -181,7 +181,7 @@ static int shrink_slab(unsigned long sca
 	struct shrinker *shrinker;
 
 	if (scanned == 0)
-		return 0;
+		scanned = 1;
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		return 0;
@@ -1065,7 +1065,8 @@ scan:
 			total_reclaimed += sc.nr_reclaimed;
 			if (zone->all_unreclaimable)
 				continue;
-			if (zone->pages_scanned > zone->present_pages * 2)
+			if (zone->pages_scanned > (zone->nr_active +
+							zone->nr_inactive) * 4)
 				zone->all_unreclaimable = 1;
 			/*
 			 * If we've done a decent amount of scanning and

_

--------------080102000801060902000305--
