Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267682AbTAaCQZ>; Thu, 30 Jan 2003 21:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267684AbTAaCQZ>; Thu, 30 Jan 2003 21:16:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:53639 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267682AbTAaCQW>; Thu, 30 Jan 2003 21:16:22 -0500
Message-ID: <3E39DCE8.8050101@us.ibm.com>
Date: Thu, 30 Jan 2003 18:18:16 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
       Rik van Riel <riel@conectiva.com.br>
Subject: [rfc][patch] GFP_ZONEMASK vs. MAX_NR_ZONES
Content-Type: multipart/mixed;
 boundary="------------080904080809070506000609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080904080809070506000609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Whilst reading through some code for an unrelated patch the other day, I 
stumbled across the build_zonelist* functions.  It seemed to me that the 
bounds on the loop seemed too large.

There are only 3 memory zones: DMA (__GFP_DMA = 0x01), NORMAL, & HIGHMEM 
(__GFP_DMA = 0x02).  Thus, GFP_ZONEMASK doesn't need to be 0x0f, but 
only 0x03.  My guess this was to leave room for future zones?  In any 
case, the loop in build_zonelists should almost certainly not go from 
i=0..GFP_ZONEMASK.  This instantiates 13 zones that are never used, 
because there is no case that I could find where any zonemask above 0x02 
is used.  A zonemask of 0x03 would be DMA | HIGHMEM, but I could not 
find an instance of that either, probably because it wouldn't make much 
sense to request a chunk of memory from DMA & HIGHMEM.

By changing the value of GFP_ZONEMASK to accurately represent the number 
of zones, and changing the size of the node_zonelists array to 
MAX_NR_ZONES, we save ((156 * MAX_NUMNODES) + 42) bytes per pglist_data 
structure (basically per node).  This translates to 198 bytes on UP/SMP, 
and 1290 bytes per node (MAX_NUMNODES=8) on NUMAQ.  Not a stagerring 
savings, but why waste it?

Can anyone point out why this patch would be wrong (other arch's using 
it differently, fundamental misunderstanding on my part, etc)?  BTW, 
this patch boots for me on NUMAQ, and really should affect UP (except 
for the slight size savings).

Cheers!

-Matt

--------------080904080809070506000609
Content-Type: text/plain;
 name="zonelist_fix-2.5.59.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zonelist_fix-2.5.59.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/linux/gfp.h linux-2.5.59-zonelist_fix/include/linux/gfp.h
--- linux-2.5.59-vanilla/include/linux/gfp.h	Thu Jan 16 18:21:47 2003
+++ linux-2.5.59-zonelist_fix/include/linux/gfp.h	Thu Jan 30 11:49:04 2003
@@ -7,7 +7,7 @@
 /*
  * GFP bitmasks..
  */
-/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low four bits) */
+/* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
 #define __GFP_DMA	0x01
 #define __GFP_HIGHMEM	0x02
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/include/linux/mmzone.h linux-2.5.59-zonelist_fix/include/linux/mmzone.h
--- linux-2.5.59-vanilla/include/linux/mmzone.h	Thu Jan 16 18:21:34 2003
+++ linux-2.5.59-zonelist_fix/include/linux/mmzone.h	Thu Jan 30 12:20:24 2003
@@ -162,7 +162,7 @@
 	struct zone *zones[MAX_NUMNODES * MAX_NR_ZONES + 1]; // NULL delimited
 };
 
-#define GFP_ZONEMASK	0x0f
+#define GFP_ZONEMASK	0x03
 
 /*
  * The pg_data_t structure is used in machines with CONFIG_DISCONTIGMEM
@@ -178,7 +178,7 @@
 struct bootmem_data;
 typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
-	struct zonelist node_zonelists[GFP_ZONEMASK+1];
+	struct zonelist node_zonelists[MAX_NR_ZONES];
 	int nr_zones;
 	struct page *node_mem_map;
 	unsigned long *valid_addr_bitmap;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.59-vanilla/mm/page_alloc.c linux-2.5.59-zonelist_fix/mm/page_alloc.c
--- linux-2.5.59-vanilla/mm/page_alloc.c	Thu Jan 16 18:21:38 2003
+++ linux-2.5.59-zonelist_fix/mm/page_alloc.c	Thu Jan 30 11:47:11 2003
@@ -962,7 +962,7 @@
 
 	local_node = pgdat->node_id;
 	printk("Building zonelist for node : %d\n", local_node);
-	for (i = 0; i <= GFP_ZONEMASK; i++) {
+	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;

--------------080904080809070506000609--

