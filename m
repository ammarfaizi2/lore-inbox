Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUG1R0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUG1R0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUG1RZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:25:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:56018 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267343AbUG1RYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:24:14 -0400
Subject: Re: [PATCH] break out zone free list initialization
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091034585.2871.142.camel@nighthawk>
References: <1091034585.2871.142.camel@nighthawk>
Content-Type: multipart/mixed; boundary="=-4x/JSAw8ql1LssxcYOWx"
Message-Id: <1091035401.2871.162.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 10:23:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4x/JSAw8ql1LssxcYOWx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-07-28 at 10:09, Dave Hansen wrote:
> The following patch removes the individual free area initialization from
> free_area_init_core(), and puts it in a new function
> zone_init_free_lists().  It also creates pages_to_bitmap_size(), which
> is then used in zone_init_free_lists() as well as several times in my
> free area bitmap resizing patch.  
> 
> First of all, I think it looks nicer this way, but it's also necessary
> to have this if you want to initialize a zone after system boot, like if
> a NUMA node was hot-added.  In any case, it should be functionally
> equivalent to the old code.
> 
> Compiles and boots on x86.  I've been running with this for a few weeks,
> and haven't seen any problems with it yet.

OK, I suck.  Here's one that applies with -p1 properly and doesn't add
whitespace on the line above the zone_init_free_lists() call.

 page_alloc.c |   84 +++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 47 insertions(+), 37 deletions(-)

-- Dave

--=-4x/JSAw8ql1LssxcYOWx
Content-Disposition: attachment; filename=zoneinit_cleanup-2.6.8-rc1-mm1-1.patch
Content-Type: text/x-patch; name=zoneinit_cleanup-2.6.8-rc1-mm1-1.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- linux-2.6.8-rc1-mm1.work/mm/page_alloc.c.orig	2004-07-28 10:04:56.000000000 -0700
+++ linux-2.6.8-rc1-mm1.work/mm/page_alloc.c		2004-07-28 10:09:09.000000000 -0700
@@ -1413,6 +1413,52 @@
 	}
 }
 
+/*
+ * Page buddy system uses "index >> (i+1)", where "index" is 
+ * at most "size-1".
+ *
+ * The extra "+3" is to round down to byte size (8 bits per byte
+ * assumption). Thus we get "(size-1) >> (i+4)" as the last byte
+ * we can access.
+ *
+ * The "+1" is because we want to round the byte allocation up 
+ * rather than down. So we should have had a "+7" before we shifted
+ * down by three. Also, we have to add one as we actually _use_ the
+ * last bit (it's [0,n] inclusive, not [0,n[).
+ *
+ * So we actually had +7+1 before we shift down by 3. But 
+ * (n+8) >> 3 == (n >> 3) + 1 (modulo overflows, which we do not have).
+ *
+ * Finally, we LONG_ALIGN because all bitmap operations are on longs.
+ */
+unsigned long pages_to_bitmap_size(unsigned long order, unsigned long nr_pages)
+{
+	unsigned long bitmap_size;
+
+	bitmap_size = (nr_pages-1) >> (order+4);
+	bitmap_size = LONG_ALIGN(bitmap_size+1);
+
+	return bitmap_size;
+}
+
+void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone, unsigned long size)
+{
+	int order;
+	for (order = 0; ; order++) {
+		unsigned long bitmap_size;
+
+		INIT_LIST_HEAD(&zone->free_area[order].free_list);
+		if (order == MAX_ORDER-1) {
+			zone->free_area[order].map = NULL;
+			break;
+		}
+
+		bitmap_size = pages_to_bitmap_size(order, size);
+		zone->free_area[order].map = 
+		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
+	}
+}
+
 #ifndef __HAVE_ARCH_MEMMAP_INIT
 #define memmap_init(start, size, nid, zone, start_pfn) \
 	memmap_init_zone((start), (size), (nid), (zone), (start_pfn))
@@ -1529,43 +1575,7 @@
 		zone_start_pfn += size;
 		lmem_map += size;
 
-		for (i = 0; ; i++) {
-			unsigned long bitmap_size;
-
-			INIT_LIST_HEAD(&zone->free_area[i].free_list);
-			if (i == MAX_ORDER-1) {
-				zone->free_area[i].map = NULL;
-				break;
-			}
-
-			/*
-			 * Page buddy system uses "index >> (i+1)",
-			 * where "index" is at most "size-1".
-			 *
-			 * The extra "+3" is to round down to byte
-			 * size (8 bits per byte assumption). Thus
-			 * we get "(size-1) >> (i+4)" as the last byte
-			 * we can access.
-			 *
-			 * The "+1" is because we want to round the
-			 * byte allocation up rather than down. So
-			 * we should have had a "+7" before we shifted
-			 * down by three. Also, we have to add one as
-			 * we actually _use_ the last bit (it's [0,n]
-			 * inclusive, not [0,n[).
-			 *
-			 * So we actually had +7+1 before we shift
-			 * down by 3. But (n+8) >> 3 == (n >> 3) + 1
-			 * (modulo overflows, which we do not have).
-			 *
-			 * Finally, we LONG_ALIGN because all bitmap
-			 * operations are on longs.
-			 */
-			bitmap_size = (size-1) >> (i+4);
-			bitmap_size = LONG_ALIGN(bitmap_size+1);
-			zone->free_area[i].map = 
-			  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
-		}
+		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
 	}
 }
 

--=-4x/JSAw8ql1LssxcYOWx--

