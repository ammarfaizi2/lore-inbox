Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVEDUgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVEDUgj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVEDUe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:34:29 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:54147
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261548AbVEDU1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:27:09 -0400
To: akpm@osdl.org
Subject: [6/6] sparsemem hotplug base
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, apw@shadowen.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Message-Id: <E1DTQSP-0002Ve-80@pinky.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 04 May 2005 21:26:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sparse's initalization be accessible at runtime.  This
allows sparse mappings to be created after boot in a hotplug
situation.

This patch is separated from the previous one just to give an
indication how much of the sparse infrastructure is *just* for
hotplug memory.

The section_mem_map doesn't really store a pointer.  It stores
something that is convenient to do some math against to get a
pointer.  It isn't valid to just do *section_mem_map, so I
don't think it should be stored as a pointer.

There are a couple of things I'd like to store about a section.
First of all, the fact that it is !NULL does not mean that it
is present.  There could be such a combination where
section_mem_map *is* NULL, but the math gets you properly to
a real mem_map.  So, I don't think that check is safe.

Since we're storing 32-bit-aligned structures, we have a few
bits in the bottom of the pointer to play with.  Use one bit
to encode whether there's really a mem_map there, and the
other one to tell whether there's a valid section there. We
need to distinguish between the two because sometimes there's
a gap between when a section is discovered to be present and
when we can get the mem_map for it.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 include/linux/mmzone.h |   48 +++++++++++++++++++++++--
 mm/sparse.c            |   92 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 116 insertions(+), 24 deletions(-)

diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h	2005-05-04 20:54:41.000000000 +0100
+++ current/include/linux/mmzone.h	2005-05-04 20:54:43.000000000 +0100
@@ -459,12 +459,52 @@ extern struct pglist_data contig_page_da
 
 struct page;
 struct mem_section {
-	struct page *section_mem_map;
+	/*
+	 * This is, logically, a pointer to an array of struct
+	 * pages.  However, it is stored with some other magic.
+	 * (see sparse.c::sparse_init_one_section())
+	 *
+	 * Making it a UL at least makes someone do a cast
+	 * before using it wrong.
+	 */
+	unsigned long section_mem_map;
 };
 
 extern struct mem_section mem_section[NR_MEM_SECTIONS];
 
 /*
+ * We use the lower bits of the mem_map pointer to store
+ * a little bit of information.  There should be at least
+ * 3 bits here due to 32-bit alignment.
+ */
+#define	SECTION_MARKED_PRESENT	(1UL<<0)
+#define SECTION_HAS_MEM_MAP	(1UL<<1)
+#define SECTION_MAP_LAST_BIT	(1UL<<2)
+#define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
+
+static inline struct page *__section_mem_map_addr(struct mem_section *section)
+{
+	unsigned long map = section->section_mem_map;
+	map &= SECTION_MAP_MASK;
+	return (struct page *)map;
+}
+
+static inline int valid_section(struct mem_section *section)
+{
+	return (section->section_mem_map & SECTION_MARKED_PRESENT);
+}
+
+static inline int section_has_mem_map(struct mem_section *section)
+{
+	return (section->section_mem_map & SECTION_HAS_MEM_MAP);
+}
+
+static inline int valid_section_nr(int nr)
+{
+	return valid_section(&mem_section[nr]);
+}
+
+/*
  * Given a kernel address, find the home node of the underlying memory.
  */
 #define kvaddr_to_nid(kaddr)	pfn_to_nid(__pa(kaddr) >> PAGE_SHIFT)
@@ -477,18 +517,18 @@ static inline struct mem_section *__pfn_
 #define pfn_to_page(pfn) 						\
 ({ 									\
 	unsigned long __pfn = (pfn);					\
-	__pfn_to_section(__pfn)->section_mem_map + __pfn;		\
+	__section_mem_map_addr(__pfn_to_section(__pfn)) + __pfn;	\
 })
 #define page_to_pfn(page)						\
 ({									\
-	page - mem_section[page_to_section(page)].section_mem_map;	\
+	page - __section_mem_map_addr(&mem_section[page_to_section(page)]);	\
 })
 
 static inline int pfn_valid(unsigned long pfn)
 {
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
-	return mem_section[pfn_to_section_nr(pfn)].section_mem_map != 0;
+	return valid_section(&mem_section[pfn_to_section_nr(pfn)]);
 }
 
 /*
diff -X /home/apw/brief/lib/vdiff.excl -rupN reference/mm/sparse.c current/mm/sparse.c
--- reference/mm/sparse.c	2005-05-04 20:54:33.000000000 +0100
+++ current/mm/sparse.c	2005-05-04 20:54:44.000000000 +0100
@@ -25,7 +25,7 @@ void memory_present(int nid, unsigned lo
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
 		unsigned long section = pfn_to_section_nr(pfn);
 		if (!mem_section[section].section_mem_map)
-			mem_section[section].section_mem_map = (void *) -1;
+			mem_section[section].section_mem_map = SECTION_MARKED_PRESENT;
 	}
 }
 
@@ -51,6 +51,56 @@ unsigned long __init node_memmap_size_by
 }
 
 /*
+ * Subtle, we encode the real pfn into the mem_map such that
+ * the identity pfn - section_mem_map will return the actual
+ * physical page frame number.
+ */
+static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long pnum)
+{
+	return (unsigned long)(mem_map - (section_nr_to_pfn(pnum)));
+}
+
+/*
+ * We need this if we ever free the mem_maps.  While not implemented yet,
+ * this function is included for parity with its sibling.
+ */
+static __attribute((unused))
+struct page *sparse_decode_mem_map(unsigned long coded_mem_map, unsigned long pnum)
+{
+	return ((struct page *)coded_mem_map) + section_nr_to_pfn(pnum);
+}
+
+static int sparse_init_one_section(struct mem_section *ms,
+		unsigned long pnum, struct page *mem_map)
+{
+	if (!valid_section(ms))
+		return -EINVAL;
+
+	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum);
+
+	return 1;
+}
+
+static struct page *sparse_early_mem_map_alloc(unsigned long pnum)
+{
+	struct page *map;
+	int nid = early_pfn_to_nid(section_nr_to_pfn(pnum));
+
+	map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
+	if (map)
+		return map;
+
+	map = alloc_bootmem_node(NODE_DATA(nid),
+			sizeof(struct page) * PAGES_PER_SECTION);
+	if (map)
+		return map;
+
+	printk(KERN_WARNING "%s: allocation failed\n", __FUNCTION__);
+	mem_section[pnum].section_mem_map = 0;
+	return NULL;
+}
+
+/*
  * Allocate the accumulated non-linear sections, allocate a mem_map
  * for each and record the physical to section mapping.
  */
@@ -58,28 +108,30 @@ void sparse_init(void)
 {
 	unsigned long pnum;
 	struct page *map;
-	int nid;
 
 	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
-		if (!mem_section[pnum].section_mem_map)
-			continue;
-
-		nid = early_pfn_to_nid(section_nr_to_pfn(pnum));
-		map = alloc_remap(nid, sizeof(struct page) * PAGES_PER_SECTION);
-		if (!map)
-			map = alloc_bootmem_node(NODE_DATA(nid),
-				sizeof(struct page) * PAGES_PER_SECTION);
-		if (!map) {
-			mem_section[pnum].section_mem_map = 0;
+		if (!valid_section_nr(pnum))
 			continue;
-		}
 
-		/*
-		 * Subtle, we encode the real pfn into the mem_map such that
-		 * the identity pfn - section_mem_map will return the actual
-		 * physical page frame number.
-		 */
-		mem_section[pnum].section_mem_map = map -
-						section_nr_to_pfn(pnum);
+		map = sparse_early_mem_map_alloc(pnum);
+		if (map)
+			sparse_init_one_section(&mem_section[pnum], pnum, map);
 	}
 }
+
+/*
+ * returns the number of sections whose mem_maps were properly
+ * set.  If this is <=0, then that means that the passed-in
+ * map was not consumed and must be freed.
+ */
+int sparse_add_one_section(int start_pfn, int nr_pages, struct page *map)
+{
+	struct mem_section *ms = __pfn_to_section(start_pfn);
+
+	if (ms->section_mem_map & SECTION_MARKED_PRESENT)
+		return -EEXIST;
+
+	ms->section_mem_map |= SECTION_MARKED_PRESENT;
+
+	return sparse_init_one_section(ms, pfn_to_section_nr(start_pfn), map);
+}
