Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316423AbSEZUqP>; Sun, 26 May 2002 16:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSEZUpj>; Sun, 26 May 2002 16:45:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52752 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316423AbSEZUnR>;
	Sun, 26 May 2002 16:43:17 -0400
Message-ID: <3CF149A1.87274811@zip.com.au>
Date: Sun, 26 May 2002 13:46:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 12/18] remove mem_map_t
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Random cleanup: remove the mem_map_t typedef.  Just use 'struct page'
everywhere.


=====================================

--- 2.5.18/include/asm-mips64/mmzone.h~mem_map_t	Sat May 25 23:25:47 2002
+++ 2.5.18-akpm/include/asm-mips64/mmzone.h	Sat May 25 23:25:47 2002
@@ -76,7 +76,7 @@ extern plat_pg_data_t *plat_node_data[];
 #define MIPS64_NR(kaddr) (((unsigned long)(kaddr) > (unsigned long)high_memory)\
 		? (max_mapnr + 1) : (LOCAL_MAP_NR((kaddr)) + \
 		(((unsigned long)ADDR_TO_MAPBASE((kaddr)) - PAGE_OFFSET) / \
-		sizeof(mem_map_t))))
+		sizeof(struct page))))
 
 #define kern_addr_valid(addr)	((KVADDR_TO_NID((unsigned long)addr) > \
 	-1) ? 0 : (test_bit(LOCAL_MAP_NR((addr)), \
--- 2.5.18/include/linux/mm.h~mem_map_t	Sat May 25 23:25:47 2002
+++ 2.5.18-akpm/include/linux/mm.h	Sat May 25 23:25:47 2002
@@ -145,7 +145,7 @@ struct vm_operations_struct {
  *
  * TODO: make this structure smaller, it could be as small as 32 bytes.
  */
-typedef struct page {
+struct page {
 	struct list_head list;		/* ->mapping has some page lists. */
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
@@ -170,7 +170,7 @@ typedef struct page {
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* CONFIG_HIGMEM || WANT_PAGE_VIRTUAL */
-} mem_map_t;
+};
 
 /*
  * Methods to modify the page usage count.
@@ -306,7 +306,7 @@ static inline void set_page_zone(struct 
 #define NOPAGE_OOM	((struct page *) (-1))
 
 /* The array of struct pages */
-extern mem_map_t * mem_map;
+extern struct page *mem_map;
 
 extern void show_free_areas(void);
 extern void show_free_areas_node(pg_data_t *pgdat);
--- 2.5.18/include/linux/mmzone.h~mem_map_t	Sat May 25 23:25:47 2002
+++ 2.5.18-akpm/include/linux/mmzone.h	Sat May 25 23:25:47 2002
@@ -172,8 +172,8 @@ extern pg_data_t contig_page_data;
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
-#define MAP_ALIGN(x)	((((x) % sizeof(mem_map_t)) == 0) ? (x) : ((x) + \
-		sizeof(mem_map_t) - ((x) % sizeof(mem_map_t))))
+#define MAP_ALIGN(x)	((((x) % sizeof(struct page)) == 0) ? (x) : ((x) + \
+		sizeof(struct page) - ((x) % sizeof(struct page))))
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
--- 2.5.18/mm/memory.c~mem_map_t	Sat May 25 23:25:47 2002
+++ 2.5.18-akpm/mm/memory.c	Sat May 25 23:25:47 2002
@@ -69,7 +69,7 @@ static inline void copy_cow_page(struct 
 	copy_user_highpage(to, from, address);
 }
 
-mem_map_t * mem_map;
+struct page *mem_map;
 
 /*
  * Note: this doesn't free the actual pages themselves. That
--- 2.5.18/mm/numa.c~mem_map_t	Sat May 25 23:25:47 2002
+++ 2.5.18-akpm/mm/numa.c	Sat May 25 23:25:47 2002
@@ -65,8 +65,8 @@ void __init free_area_init_node(int nid,
 	int i, size = 0;
 	struct page *discard;
 
-	if (mem_map == (mem_map_t *)NULL)
-		mem_map = (mem_map_t *)PAGE_OFFSET;
+	if (mem_map == NULL)
+		mem_map = (struct page *)PAGE_OFFSET;
 
 	free_area_init_core(nid, pgdat, &discard, zones_size, zone_start_paddr,
 					zholes_size, pmap);
--- 2.5.18/sound/core/memory.c~mem_map_t	Sat May 25 23:25:47 2002
+++ 2.5.18-akpm/sound/core/memory.c	Sat May 25 23:25:47 2002
@@ -272,8 +272,8 @@ void *snd_malloc_pages(unsigned long siz
 	snd_assert(dma_flags != 0, return NULL);
 	for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
 	if ((res = (void *) __get_free_pages(dma_flags, pg)) != NULL) {
-		mem_map_t *page = virt_to_page(res);
-		mem_map_t *last_page = page + (1 << pg);
+		struct page *page = virt_to_page(res);
+		struct page *last_page = page + (1 << pg);
 		while (page < last_page)
 			SetPageReserved(page++);
 #ifdef CONFIG_SND_DEBUG_MEMORY
@@ -302,7 +302,7 @@ void *snd_malloc_pages_fallback(unsigned
 void snd_free_pages(void *ptr, unsigned long size)
 {
 	int pg;
-	mem_map_t *page, *last_page;
+	struct page *page, *last_page;
 
 	if (ptr == NULL)
 		return;
@@ -338,8 +338,8 @@ void *snd_malloc_isa_pages(unsigned long
 		for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
 		dma_area = pci_alloc_consistent(NULL, size, dma_addr);
 		if (dma_area != NULL) {
-			mem_map_t *page = virt_to_page(dma_area);
-			mem_map_t *last_page = page + (1 << pg);
+			struct page *page = virt_to_page(dma_area);
+			struct page *last_page = page + (1 << pg);
 			while (page < last_page)
 				SetPageReserved(page++);
 #ifdef CONFIG_SND_DEBUG_MEMORY
@@ -391,8 +391,8 @@ void *snd_malloc_pci_pages(struct pci_de
 	for (pg = 0; PAGE_SIZE * (1 << pg) < size; pg++);
 	res = pci_alloc_consistent(pci, PAGE_SIZE * (1 << pg), dma_addr);
 	if (res != NULL) {
-		mem_map_t *page = virt_to_page(res);
-		mem_map_t *last_page = page + (1 << pg);
+		struct page *page = virt_to_page(res);
+		struct page *last_page = page + (1 << pg);
 		while (page < last_page)
 			SetPageReserved(page++);
 #ifdef CONFIG_SND_DEBUG_MEMORY
@@ -426,7 +426,7 @@ void snd_free_pci_pages(struct pci_dev *
 			dma_addr_t dma_addr)
 {
 	int pg;
-	mem_map_t *page, *last_page;
+	struct page *page, *last_page;
 
 	if (ptr == NULL)
 		return;
--- 2.5.18/sound/pci/rme9652/rme9652_mem.c~mem_map_t	Sat May 25 23:25:47 2002
+++ 2.5.18-akpm/sound/pci/rme9652/rme9652_mem.c	Sat May 25 23:25:47 2002
@@ -111,8 +111,8 @@ static void *rme9652_malloc_pages(struct
 		*dmaaddr = virt_to_bus(res);
 #endif
 	if (res != NULL) {
-		mem_map_t *page = virt_to_page(res);
-		mem_map_t *last_page = page + (size + PAGE_SIZE - 1) / PAGE_SIZE;
+		struct page *page = virt_to_page(res);
+		struct page *last_page = page + (size + PAGE_SIZE - 1) / PAGE_SIZE;
 		while (page < last_page)
 			set_bit(PG_reserved, &(page++)->flags);
 	}
@@ -122,7 +122,7 @@ static void *rme9652_malloc_pages(struct
 static void rme9652_free_pages(struct pci_dev *pci, unsigned long size,
 			       void *ptr, dma_addr_t dmaaddr)
 {
-	mem_map_t *page, *last_page;
+	struct page *page, *last_page;
 
 	if (ptr == NULL)
 		return;

-
