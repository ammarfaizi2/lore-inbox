Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbTCRBvc>; Mon, 17 Mar 2003 20:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261977AbTCRBvc>; Mon, 17 Mar 2003 20:51:32 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:10989 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261867AbTCRBvb>;
	Mon, 17 Mar 2003 20:51:31 -0500
Message-ID: <3E767C04.3000604@us.ibm.com>
Date: Mon, 17 Mar 2003 17:53:08 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: [patch] GFP_ZONEMASK vs. MAX_NR_ZONES
Content-Type: multipart/mixed;
 boundary="------------010107000802010205050907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010107000802010205050907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok...  hot on the heels of the other GFP_ZONEMASK patch:

struct bootmem_data;
typedef struct pglist_data {
	struct zone node_zones[MAX_NR_ZONES];
	struct zonelist node_zonelists[GFP_ZONEMASK+1];
	int nr_zones;
	struct page *node_mem_map;
	unsigned long *valid_addr_bitmap;
	struct bootmem_data *bdata;
	unsigned long node_start_pfn;
	unsigned long node_size;
	int node_id;
	struct pglist_data *pgdat_next;
	wait_queue_head_t       kswapd_wait;
} pg_data_t;

node_zonelists looks like it should really be declared of size 
MAX_NR_ZONES, not GFP_ZONEMASK.  GFP_ZONEMASK is currently 15, making 
node_zonelists an array of 16 elements.  The extra zonelists are all 
just duplicates of the *real* zonelists, namely the first 3 entries. 
Again, if anyone can explain to me why I'm wrong in my thinking, I'd 
love to know.  There's certainly no way you could bitwise-and something 
with any combination of the GFP_DMA and GFP_HIGHMEM flags to refer to 
the 12th zonelist or some such!  Or am I crazy?

Cheers!

-Matt

--------------010107000802010205050907
Content-Type: text/plain;
 name="zonelist_fix-2.5.65.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zonelist_fix-2.5.65.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/include/linux/mmzone.h linux-2.5.64-zonelist_fix/include/linux/mmzone.h
--- linux-2.5.64-vanilla/include/linux/mmzone.h	Tue Mar  4 19:29:22 2003
+++ linux-2.5.64-zonelist_fix/include/linux/mmzone.h	Mon Mar 17 14:13:02 2003
@@ -178,7 +178,7 @@
 struct bootmem_data;
 typedef struct pglist_data {
 	struct zone node_zones[MAX_NR_ZONES];
-	struct zonelist node_zonelists[GFP_ZONEMASK+1];
+	struct zonelist node_zonelists[MAX_NR_ZONES];
 	int nr_zones;
 	struct page *node_mem_map;
 	unsigned long *valid_addr_bitmap;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.64-vanilla/mm/page_alloc.c linux-2.5.64-zonelist_fix/mm/page_alloc.c
--- linux-2.5.64-vanilla/mm/page_alloc.c	Tue Mar  4 19:28:58 2003
+++ linux-2.5.64-zonelist_fix/mm/page_alloc.c	Mon Mar 17 14:13:02 2003
@@ -1028,7 +1028,7 @@
 
 	local_node = pgdat->node_id;
 	printk("Building zonelist for node : %d\n", local_node);
-	for (i = 0; i <= GFP_ZONEMASK; i++) {
+	for (i = 0; i < MAX_NR_ZONES; i++) {
 		struct zonelist *zonelist;
 
 		zonelist = pgdat->node_zonelists + i;

--------------010107000802010205050907--

