Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbSI0TdT>; Fri, 27 Sep 2002 15:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262563AbSI0TdT>; Fri, 27 Sep 2002 15:33:19 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:23449 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262526AbSI0TdR>;
	Fri, 27 Sep 2002 15:33:17 -0400
Message-ID: <3D94B3B4.6090409@colorfullife.com>
Date: Fri, 27 Sep 2002 21:38:28 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <3D9372D3.3000908@colorfullife.com> <3D937E87.D387F358@digeo.com> <200209262041.11227.tomlins@cam.org> <3D949468.4010202@colorfullife.com> <3D94A2D4.55721A8A@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------040006080907050100070508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040006080907050100070508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> 
>>* After flushing a batch back into the lists, the number of free objects
>>in the lists is calculated. If freeable pages exist and the number
>>exceeds a target, then the freeable pages above the target are returned
>>to the page buddy.
> 
> 
> Probably OK for now.  But slab should _not_ hold onto an unused,
> cache-warm page.  Because do_anonymous_page() may want one.
> 
If the per-cpu caches are enabled on UP, too, then this is a moot point: 
by the time a batch is freed from the per-cpu array, it will be cache cold.
And btw, why do you think a page is cache-warm when the last object on a 
  page is freed? If the last 32-byte kmalloc is released on a page, 40xx 
bytes are probably cache-cold.

Back to your first problem: You've mentioned excess hits on the 
cache_chain_semaphore. Which app did you use for stress testing? Could 
you run a stress test with the applied patch?

I've tried dbench 50, with 128 MB RAM, on uniprocessor, with 2.4:

There were 9100 calls to kmem_cache_reap, and in 90% of the calls, no 
freeable memory was found. Alltogether, only 1300 pages were freed from 
the slabs.

Are there just too many calls to kmem_cache_reap()? Perhaps we should 
try to optimize the "nothing freeable exists" logic?

--
	Manfred

--------------040006080907050100070508
Content-Type: text/plain;
 name="patch-slab-stat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-stat"

--- 2.4/mm/slab.c	Fri Aug 30 18:39:22 2002
+++ build-2.4/mm/slab.c	Fri Sep 27 21:01:31 2002
@@ -1727,6 +1735,9 @@
 }
 #endif
 
+unsigned long g_calls = 0;
+unsigned long g_pages = 0;
+unsigned long g_success = 0;
 /**
  * kmem_cache_reap - Reclaim memory from caches.
  * @gfp_mask: the type of memory required.
@@ -1749,6 +1760,7 @@
 		if (down_trylock(&cache_chain_sem))
 			return 0;
 
+g_calls++;
 	scan = REAP_SCANLEN;
 	best_len = 0;
 	best_pages = 0;
@@ -1827,6 +1839,8 @@
 perfect:
 	/* free only 50% of the free slabs */
 	best_len = (best_len + 1)/2;
+g_success++;
+g_pages+=best_len;
 	for (scan = 0; scan < best_len; scan++) {
 		struct list_head *p;
 
@@ -1907,6 +1921,7 @@
 		 * Output format version, so at least we can change it
 		 * without _too_ many complaints.
 		 */
+		seq_printf(m, "%lu %lu %lu.\n",g_calls, g_pages, g_success);
 		seq_puts(m, "slabinfo - version: 1.1"
 #if STATS
 				" (statistics)"

--------------040006080907050100070508--

