Return-Path: <linux-kernel-owner+w=401wt.eu-S1754725AbWLRWza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbWLRWza (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754732AbWLRWza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:55:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.174]:63822 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbWLRWz3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:55:29 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix sparsemem on Cell
Date: Mon, 18 Dec 2006 23:54:45 +0100
User-Agent: KMail/1.9.5
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, kmannth@us.ibm.com,
       linux-kernel@vger.kernel.org, hch@infradead.org, linux-mm@kvack.org,
       paulus@samba.org, mkravetz@us.ibm.com, gone@us.ibm.com,
       cbe-oss-dev@ozlabs.org, Dave Hansen <haveblue@us.ibm.com>
References: <20061215165335.61D9F775@localhost.localdomain> <20061215114536.dc5c93af.akpm@osdl.org> <20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612182354.47685.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 December 2006 09:03, KAMEZAWA Hiroyuki wrote:
> @@ -273,10 +284,13 @@
>                 if (ret)
>                         goto error;
>         }
> +       atomic_inc(&memory_hotadd_count);
>  
>         /* call arch's memory hotadd */
>         ret = arch_add_memory(nid, start, size);
>  
> +       atomic_dec(&memory_hotadd_count);
> +
>         if (ret < 0)
>                 goto error;
>  

This also doesn't fix the problem on cell, since the time when the bug
happens, we're not calling through this function, or arch_add_memory,
at all, but rather invoke __add_pages directly. As BenH already mentioned,
we shouldn't do really call __add_pages at all.

Let me attempt another fix that might address all cases. This is completely
untested as of now, but also addresses Dave's latest comment.

	Arnd <><

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 1a3d8a2..723d220 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -543,7 +543,7 @@ virtual_memmap_init (u64 start, u64 end, void *arg)
 
 	if (map_start < map_end)
 		memmap_init_zone((unsigned long)(map_end - map_start),
-				 args->nid, args->zone, page_to_pfn(map_start));
+				 args->nid, args->zone, page_to_pfn(map_start), 1);
 	return 0;
 }
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 7f2944d..1e52cd1 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -61,7 +61,7 @@ void memmap_init(unsigned long size, int nid, unsigned long zone,
 
 		if (map_start < map_end)
 			memmap_init_zone((unsigned long)(map_end - map_start),
-					 nid, zone, page_to_pfn(map_start));
+					 nid, zone, page_to_pfn(map_start), 1);
 	}
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a17b147..6d85068 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -978,7 +978,7 @@ extern int early_pfn_to_nid(unsigned long pfn);
 #endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
 #endif /* CONFIG_ARCH_POPULATES_NODE_MAP */
 extern void set_dma_reserve(unsigned long new_dma_reserve);
-extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long);
+extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long, int);
 extern void setup_per_zone_pages_min(void);
 extern void mem_init(void);
 extern void show_mem(void);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0c055a0..16c9930 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -71,7 +71,7 @@ static int __add_zone(struct zone *zone, unsigned long phys_start_pfn)
 		if (ret < 0)
 			return ret;
 	}
-	memmap_init_zone(nr_pages, nid, zone_type, phys_start_pfn);
+	memmap_init_zone(nr_pages, nid, zone_type, phys_start_pfn, 0);
 	return 0;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8c1a116..60d1ac8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1953,17 +1953,19 @@ static inline unsigned long wait_table_bits(unsigned long size)
  * done. Non-atomic initialization, single-pass.
  */
 void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
-		unsigned long start_pfn)
+		unsigned long start_pfn, int early)
 {
 	struct page *page;
 	unsigned long end_pfn = start_pfn + size;
 	unsigned long pfn;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-		if (!early_pfn_valid(pfn))
-			continue;
-		if (!early_pfn_in_nid(pfn, nid))
-			continue;
+		if (early) {
+			if (!early_pfn_valid(pfn))
+				continue;
+			if (!early_pfn_in_nid(pfn, nid))
+				continue;
+		}
 		page = pfn_to_page(pfn);
 		set_page_links(page, zone, nid, pfn);
 		init_page_count(page);
@@ -1990,7 +1992,7 @@ void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone,
 
 #ifndef __HAVE_ARCH_MEMMAP_INIT
 #define memmap_init(size, nid, zone, start_pfn) \
-	memmap_init_zone((size), (nid), (zone), (start_pfn))
+	memmap_init_zone((size), (nid), (zone), (start_pfn), 1)
 #endif
 
 static int __cpuinit zone_batchsize(struct zone *zone)
