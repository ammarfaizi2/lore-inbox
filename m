Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTCBUz7>; Sun, 2 Mar 2003 15:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264748AbTCBUz6>; Sun, 2 Mar 2003 15:55:58 -0500
Received: from holomorphy.com ([66.224.33.161]:8591 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264610AbTCBUz5>;
	Sun, 2 Mar 2003 15:55:57 -0500
Date: Sun, 2 Mar 2003 13:06:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: percpu-2.5.63-bk5-1 (properly generated)
Message-ID: <20030302210606.GS24172@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <47970000.1046629477@[10.10.2.4]> <20030302202451.GJ1195@holomorphy.com> <50380000.1046637959@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50380000.1046637959@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> make -j44 bzImage > /dev/null  304.02s user 122.14s system 1299% cpu 32.792 total
[...]

On Sun, Mar 02, 2003 at 12:46:00PM -0800, Martin J. Bligh wrote:
> How does that compare with and without your patch though?

There's a relatively large (12s/44s == 27%) difference between absolute
timings on our machines, which suggests a large disturbance in the force.
2.5.63-bk5 virgin appears to get timings in the low 40's.


On Sun, Mar 02, 2003 at 12:46:00PM -0800, Martin J. Bligh wrote:
> Would be useful if you can grab a before and after profile, and see exactly
> what it is that's getting thrashed that you're fixing (may just be everything).

>From the profile posted it's the division in page_zone().


-- wli


diff -urpN pernode-2.5.63-bk5-1/include/linux/mm.h pernode-2.5.63-bk5-2/include/linux/mm.h
--- pernode-2.5.63-bk5-1/include/linux/mm.h	2003-03-02 02:55:14.000000000 -0800
+++ pernode-2.5.63-bk5-2/include/linux/mm.h	2003-03-02 12:55:20.000000000 -0800
@@ -316,6 +316,7 @@ static inline void put_page(struct page 
  * sets it, so none of the operations on it need to be atomic.
  */
 #define NODE_SHIFT 4
+#define ZONE_MASK  ((1UL << NODE_SHIFT) - 1)
 #define ZONE_SHIFT (BITS_PER_LONG - 8)
 
 struct zone;
@@ -324,7 +325,7 @@ DECLARE_PER_NODE(struct zone *[MAX_NR_ZO
 static inline struct zone *page_zone(struct page *page)
 {
 	unsigned long zone = page->flags >> ZONE_SHIFT;
-	return per_node(zone_table, zone/MAX_NR_ZONES)[zone % MAX_NR_ZONES];
+	return per_node(zone_table, zone >> NODE_SHIFT)[zone & ZONE_MASK];
 }
 
 static inline void set_page_zone(struct page *page, unsigned long zone_num)
diff -urpN pernode-2.5.63-bk5-1/mm/page_alloc.c pernode-2.5.63-bk5-2/mm/page_alloc.c
--- pernode-2.5.63-bk5-1/mm/page_alloc.c	2003-03-02 02:55:14.000000000 -0800
+++ pernode-2.5.63-bk5-2/mm/page_alloc.c	2003-03-02 12:15:00.000000000 -0800
@@ -1262,7 +1262,7 @@ static void __init free_area_init_core(s
 		 */
 		for (i = 0; i < size; i++) {
 			struct page *page = lmem_map + local_offset + i;
-			set_page_zone(page, nid * MAX_NR_ZONES + j);
+			set_page_zone(page, (nid << NODE_SHIFT) + j);
 			set_page_count(page, 0);
 			SetPageReserved(page);
 			INIT_LIST_HEAD(&page->list);
