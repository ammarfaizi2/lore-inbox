Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314658AbSEFTHo>; Mon, 6 May 2002 15:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314684AbSEFTHn>; Mon, 6 May 2002 15:07:43 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:51727 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314658AbSEFTHk>; Mon, 6 May 2002 15:07:40 -0400
Date: Mon, 6 May 2002 21:07:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <E174kNX-0004KS-00@starship>
Message-ID: <Pine.LNX.4.21.0205062053050.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 6 May 2002, Daniel Phillips wrote:

> I don't, I observed that in all known instances of config_discontigmem, that
> linear relationship is preserved.

That's true, but m68k isn't using config_discontigmem. :)

> > There is little common code (and only during
> > initialization), which assumes a direct mapping. I can send you the
> > patches to fix this.
> 
> I already have patches to do that, that is, config_nonlinear.  I'm interested in
> looking at your patches though, because we might as well give all the different
> approaches a fair examination.

See below, the patch is almost complete:
- the only other free_area_init_core() needs to be updated
- the virt_to_page(phys_to_virt()) sequence could be replaced now with
  pfn_page()

> You're talking about your 68K solution with the loops that search through
> memory regions?  If so, I've already looked at it and understand it.

That's just how the virtual<->physical conversion is implemented.

>  Or, if
> it's a new approach, then naturally I'd be interested.

It's not really new, you only have to take care, that you don't iterate
with the physical address over a pgdat, this is what the patch below
fixes, the rest can be hidden in the arch macros and no special config
options is needed.

bye, Roman

Index: mm/bootmem.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/mm/bootmem.c,v
retrieving revision 1.1.1.4
retrieving revision 1.5
diff -u -p -r1.1.1.4 -r1.5
--- mm/bootmem.c	11 Feb 2002 17:51:47 -0000	1.1.1.4
+++ mm/bootmem.c	11 Feb 2002 18:34:49 -0000	1.5
@@ -243,7 +243,7 @@ found:
 
 static unsigned long __init free_all_bootmem_core(pg_data_t *pgdat)
 {
-	struct page *page = pgdat->node_mem_map;
+	struct page *page;
 	bootmem_data_t *bdata = pgdat->bdata;
 	unsigned long i, count, total = 0;
 	unsigned long idx;
@@ -256,21 +256,22 @@ static unsigned long __init free_all_boo
 	map = bdata->node_bootmem_map;
 	for (i = 0; i < idx; ) {
 		unsigned long v = ~map[i / BITS_PER_LONG];
-		if (v) { 
-			unsigned long m;
-			for (m = 1; m && i < idx; m<<=1, page++, i++) { 
-				if (v & m) {
+		unsigned long m;
+		if (!v) {
+			i+=BITS_PER_LONG;
+			continue;
+		}
+		for (m = 1; m && i < idx; m<<=1, i++) {
+			if (!(v & m))
+				continue;
+			page = virt_to_page(phys_to_virt((i << PAGE_SHIFT) +
+							 bdata->node_boot_start));
 			count++;
 			ClearPageReserved(page);
 			set_page_count(page, 1);
 			__free_page(page);
 		}
 	}
-		} else {
-			i+=BITS_PER_LONG;
-			page+=BITS_PER_LONG; 
-		} 	
-	}	
 	total += count;
 
 	/*
Index: mm/page_alloc.c
===================================================================
RCS file: /home/linux-m68k/cvsroot/linux/mm/page_alloc.c,v
retrieving revision 1.1.1.14
retrieving revision 1.17
diff -u -p -r1.1.1.14 -r1.17
--- mm/page_alloc.c	6 May 2002 08:52:16 -0000	1.1.1.14
+++ mm/page_alloc.c	6 May 2002 09:11:36 -0000	1.17
@@ -796,7 +796,7 @@ static inline unsigned long wait_table_b
  *   - clear the memory bitmaps
  */
 void __init free_area_init_core(int nid, pg_data_t *pgdat, struct page **gmap,
-	unsigned long *zones_size, unsigned long zone_start_paddr, 
+	unsigned long *zones_size, unsigned long zone_start_vaddr, 
 	unsigned long *zholes_size, struct page *lmem_map)
 {
 	unsigned long i, j;
@@ -804,7 +804,7 @@ void __init free_area_init_core(int nid,
 	unsigned long totalpages, offset, realtotalpages;
 	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
 
-	if (zone_start_paddr & ~PAGE_MASK)
+	if (zone_start_vaddr & ~PAGE_MASK)
 		BUG();
 
 	totalpages = 0;
@@ -837,7 +837,7 @@ void __init free_area_init_core(int nid,
 	}
 	*gmap = pgdat->node_mem_map = lmem_map;
 	pgdat->node_size = totalpages;
-	pgdat->node_start_paddr = zone_start_paddr;
+	pgdat->node_start_paddr = __pa(zone_start_vaddr);
 	pgdat->node_start_mapnr = (lmem_map - mem_map);
 	pgdat->nr_zones = 0;
 
@@ -889,9 +889,9 @@ void __init free_area_init_core(int nid,
 
 		zone->zone_mem_map = mem_map + offset;
 		zone->zone_start_mapnr = offset;
-		zone->zone_start_paddr = zone_start_paddr;
+		zone->zone_start_paddr = __pa(zone_start_vaddr);
 
-		if ((zone_start_paddr >> PAGE_SHIFT) & (zone_required_alignment-1))
+		if ((zone_start_vaddr >> PAGE_SHIFT) & (zone_required_alignment-1))
 			printk("BUG: wrong zone alignment, it will crash\n");
 
 		/*
@@ -906,8 +906,8 @@ void __init free_area_init_core(int nid,
 			SetPageReserved(page);
 			memlist_init(&page->list);
 			if (j != ZONE_HIGHMEM)
-				set_page_address(page, __va(zone_start_paddr));
-			zone_start_paddr += PAGE_SIZE;
+				set_page_address(page, zone_start_vaddr);
+			zone_start_vaddr += PAGE_SIZE;
 		}
 
 		offset += size;
@@ -954,7 +954,7 @@ void __init free_area_init_core(int nid,
 
 void __init free_area_init(unsigned long *zones_size)
 {
-	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 0, 0, 0);
+	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, PAGE_OFFSET, 0, 0);
 }
 
 static int __init setup_mem_frac(char *str)


