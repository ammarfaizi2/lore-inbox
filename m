Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266340AbUBFDY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbUBFDY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:24:56 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:62084 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266403AbUBFDXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:23:39 -0500
Message-ID: <402308B6.3060802@cyberone.com.au>
Date: Fri, 06 Feb 2004 14:23:34 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Steve Lord <lord@xfs.org>, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: Limit hash table size
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>	<p73isilkm4x.fsf@verdi.suse.de>	<4021AC9F.4090408@xfs.org> <20040205191240.13638135.akpm@osdl.org>
In-Reply-To: <20040205191240.13638135.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Steve Lord <lord@xfs.org> wrote:
>
>> I have seen some dire cases with the dcache, SGI had some boxes with
>> millions of files out there, and every night a cron job would come
>> along and suck them all into memory. Resources got tight at some point,
>> and as more inodes and dentries were being read in, the try to free
>> pages path was continually getting called. There was always something
>> in filesystem cache which could get freed, and the inodes and dentries
>> kept getting more and more of the memory.
>>
>
>There are a number of variables here.  Certainly, the old
>inodes-pinned-by-highmem pagecache will cause this to happen - badly.  2.6
>is pretty aggressive at killing off those inodes.
>
>What kernel was it?
>
>Was it a highmem box?  If so, was the filesystem in question placing
>directory pagecache in highmem?  If so, that was really bad on older 2.4:
>the directory pagecache in highmem pins down all directory inodes.
>
>

2.6.2-mm1 should fix this I think.
In particular, this hunk in vm-shrink-zone.patch

@@ -918,6 +917,15 @@ int try_to_free_pages(struct zone **zone
 		get_page_state(&ps);
 		nr_reclaimed += shrink_caches(zones, priority, &total_scanned,
 						gfp_mask, nr_pages, &ps);
+
+		if (zones[0] - zones[0]->zone_pgdat->node_zones < ZONE_HIGHMEM) {
+			shrink_slab(total_scanned, gfp_mask);
+			if (reclaim_state) {
+				nr_reclaimed += reclaim_state->reclaimed_slab;
+				reclaim_state->reclaimed_slab = 0;
+			}
+		}
+
 		if (nr_reclaimed >= nr_pages) {
 			ret = 1;
 			goto out;
@@ -933,13 +941,6 @@ int try_to_free_pages(struct zone **zone
 
 		/* Take a nap, wait for some writeback to complete */
 		blk_congestion_wait(WRITE, HZ/10);
-		if (zones[0] - zones[0]->zone_pgdat->node_zones < ZONE_HIGHMEM) {
-			shrink_slab(total_scanned, gfp_mask);
-			if (reclaim_state) {
-				nr_reclaimed += reclaim_state->reclaimed_slab;
-				reclaim_state->reclaimed_slab = 0;
-			}
-		}
 	}
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
 		out_of_memory();


