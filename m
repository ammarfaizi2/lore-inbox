Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSJUWrY>; Mon, 21 Oct 2002 18:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbSJUWrY>; Mon, 21 Oct 2002 18:47:24 -0400
Received: from packet.digeo.com ([12.110.80.53]:8862 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261799AbSJUWrT>;
	Mon, 21 Oct 2002 18:47:19 -0400
Message-ID: <3DB4855F.D5DA002E@digeo.com>
Date: Mon, 21 Oct 2002 15:53:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
References: <309670000.1035236015@flay> <Pine.LNX.4.44L.0210212028100.22993-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 22:53:19.0588 (UTC) FILETIME=[A6689240:01C27954]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 21 Oct 2002, Martin J. Bligh wrote:
> 
> > > Blockdevices only use ZONE_NORMAL for their pagecache.  That cat will
> > > selectively put pressure on the normal zone (and DMA zone, of course).
> >
> > Ah, I recall that now. That's fundamentally screwed.
> 
> It's not too bad since the data can be reclaimed easily.
> 
> The problem in your case is that the dentry and inode cache
> didn't get reclaimed. Maybe there is a leak so they can't get
> reclaimed at all or maybe they just don't get reclaimed fast
> enough.
> 

He had 3 million dentries and only 100k pages on the LRU,
so we should have been reclaiming 60 dentries per scanned
page.

Conceivably the multiply in shrink_slab() overflowed, where
we calculate local variable `delta'.  But doubtful.

First, we need to make it happen again, then see if this (quick
hack) fixes it up.


--- 25/mm/vmscan.c~shrink_slab-overflow	Mon Oct 21 15:40:57 2002
+++ 25-akpm/mm/vmscan.c	Mon Oct 21 15:51:28 2002
@@ -147,14 +147,15 @@ static int shrink_slab(int scanned,  uns
 	list_for_each(lh, &shrinker_list) {
 		struct shrinker *shrinker;
 		int entries;
-		unsigned long delta;
+		long long delta;
 
 		shrinker = list_entry(lh, struct shrinker, list);
 		entries = (*shrinker->shrinker)(0, gfp_mask);
 		if (!entries)
 			continue;
-		delta = scanned * shrinker->seeks * entries;
-		shrinker->nr += delta / (pages + 1);
+		delta = scanned * shrinker->seeks;
+		delta *= entries;
+		shrinker->nr += do_div(delta, pages + 1);
 		if (shrinker->nr > SHRINK_BATCH) {
 			int nr = shrinker->nr;
 

.
