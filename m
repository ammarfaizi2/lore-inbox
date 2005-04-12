Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVDLNMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVDLNMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVDLNFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:05:48 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:9907 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262387AbVDLMtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:49:00 -0400
Message-ID: <425BC3B0.7020707@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:48:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch 2/9] mempool gfp flag
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------070009040001000301000907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070009040001000301000907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/9

-- 
SUSE Labs, Novell Inc.

--------------070009040001000301000907
Content-Type: text/plain;
 name="mempool-gfp-flag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempool-gfp-flag.patch"

Mempools have 2 problems.

The first is that mempool_alloc can possibly get stuck in __alloc_pages
when they should opt to fail, and take an element from their reserved pool.

The second is that it will happily eat emergency PF_MEMALLOC reserves
instead of going to their reserved pools.

Fix the first by passing __GFP_NORETRY in the allocation calls in
mempool_alloc. Fix the second by introducing a __GFP_MEMPOOL flag
which directs the page allocator not to allocate from the reserve
pool.


Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h	2005-04-12 22:26:10.000000000 +1000
+++ linux-2.6/include/linux/gfp.h	2005-04-12 22:26:11.000000000 +1000
@@ -38,14 +38,16 @@ struct vm_area_struct;
 #define __GFP_NO_GROW	0x2000u	/* Slab internal usage */
 #define __GFP_COMP	0x4000u	/* Add compound page metadata */
 #define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
+#define __GFP_MEMPOOL	0x10000u/* Mempool allocation */
 
-#define __GFP_BITS_SHIFT 16	/* Room for 16 __GFP_FOO bits */
+#define __GFP_BITS_SHIFT 17	/* Room for 17 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
 			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL| \
-			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_ZERO)
+			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_ZERO| \
+			__GFP_MEMPOOL)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c	2005-04-12 22:05:44.000000000 +1000
+++ linux-2.6/mm/page_alloc.c	2005-04-12 22:26:11.000000000 +1000
@@ -799,14 +799,18 @@ __alloc_pages(unsigned int __nocast gfp_
 	}
 
 	/* This allocation should allow future memory freeing. */
-	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE))) && !in_interrupt()) {
-		/* go through the zonelist yet again, ignoring mins */
-		for (i = 0; (z = zones[i]) != NULL; i++) {
-			if (!cpuset_zone_allowed(z))
-				continue;
-			page = buffered_rmqueue(z, order, gfp_mask);
-			if (page)
-				goto got_pg;
+
+	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
+			&& !in_interrupt()) {
+		if (!(gfp_mask & __GFP_MEMPOOL)) {
+			/* go through the zonelist yet again, ignoring mins */
+			for (i = 0; (z = zones[i]) != NULL; i++) {
+				if (!cpuset_zone_allowed(z))
+					continue;
+				page = buffered_rmqueue(z, order, gfp_mask);
+				if (page)
+					goto got_pg;
+			}
 		}
 		goto nopage;
 	}
Index: linux-2.6/mm/mempool.c
===================================================================
--- linux-2.6.orig/mm/mempool.c	2005-04-12 22:05:44.000000000 +1000
+++ linux-2.6/mm/mempool.c	2005-04-12 22:26:11.000000000 +1000
@@ -198,11 +198,16 @@ void * mempool_alloc(mempool_t *pool, un
 	void *element;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
-	int gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
+	int gfp_nowait;
+	
+	gfp_mask |= __GFP_MEMPOOL;
+	gfp_mask |= __GFP_NORETRY;	/* don't loop in __alloc_pages */
+	gfp_mask |= __GFP_NOWARN;	/* failures are OK */
+	gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO);
 
 	might_sleep_if(gfp_mask & __GFP_WAIT);
 repeat_alloc:
-	element = pool->alloc(gfp_nowait|__GFP_NOWARN, pool->pool_data);
+	element = pool->alloc(gfp_nowait, pool->pool_data);
 	if (likely(element != NULL))
 		return element;
 

--------------070009040001000301000907--

