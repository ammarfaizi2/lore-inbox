Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVCQAev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVCQAev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVCQAeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:34:19 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21469 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262907AbVCQA2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:28:18 -0500
Subject: [RFC][PATCH 3/6] sparsemem: steal some bits from mem_map
To: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 16 Mar 2005 16:28:15 -0800
Message-Id: <E1DBis4-0000dF-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


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
---

 memhotplug-dave/include/linux/mmzone.h |   48 +++++++++++++++++++++++++++++----
 memhotplug-dave/mm/sparse.c            |   37 +++++++++++++++++--------
 2 files changed, 69 insertions(+), 16 deletions(-)

diff -puN include/linux/mmzone.h~B-sparse-153-sparse-bits include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~B-sparse-153-sparse-bits	2005-03-16 16:13:09.000000000 -0800
+++ memhotplug-dave/include/linux/mmzone.h	2005-03-16 16:13:09.000000000 -0800
@@ -440,12 +440,50 @@ extern struct pglist_data contig_page_da
 
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
 
-#define	SECTION_MARKED_PRESENT	((void *)-1)
+/*
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
 
 /*
  * Given a kernel address, find the home node of the underlying memory.
@@ -460,18 +498,18 @@ static inline struct mem_section *__pfn_
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
 	if ((pfn >> PFN_SECTION_SHIFT) >= NR_MEM_SECTIONS)
 		return 0;
-	return mem_section[pfn >> PFN_SECTION_SHIFT].section_mem_map != 0;
+	return valid_section(&mem_section[pfn >> PFN_SECTION_SHIFT]);
 }
 
 /*
diff -puN mm/sparse.c~B-sparse-153-sparse-bits mm/sparse.c
--- memhotplug/mm/sparse.c~B-sparse-153-sparse-bits	2005-03-16 16:13:09.000000000 -0800
+++ memhotplug-dave/mm/sparse.c	2005-03-16 16:13:09.000000000 -0800
@@ -25,7 +25,7 @@ void memory_present(int nid, unsigned lo
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
 		int section = pfn >> PFN_SECTION_SHIFT;
 		if (!mem_section[section].section_mem_map) {
-			mem_section[section].section_mem_map = (void *) -1;
+			mem_section[section].section_mem_map = SECTION_MARKED_PRESENT;
 			size += (PAGES_PER_SECTION * sizeof (struct page));
 		}
 	}
@@ -52,17 +52,32 @@ unsigned long __init node_memmap_size_by
 	return nr_pages * sizeof(struct page);
 }
 
+/*
+ * Subtle, we encode the real pfn into the mem_map such that
+ * the identity pfn - section_mem_map will return the actual
+ * physical page frame number.
+ */
+static unsigned long sparse_encode_mem_map(struct page *mem_map, int pnum)
+{
+	return (unsigned long)(mem_map - (pnum << PFN_SECTION_SHIFT));
+}
+
+/*
+ * We need this if we ever free the mem_maps.  While not implemented yet,
+ * this function is included for parity with its sibling.
+ */
+static __attribute((unused))
+struct page *sparse_decode_mem_map(unsigned long coded_mem_map, int pnum)
+{
+	return ((struct page *)coded_mem_map) + (pnum << PFN_SECTION_SHIFT);
+}
+
 static int sparse_init_one_section(struct mem_section *ms, int pnum, struct page *mem_map)
 {
-	if (ms->section_mem_map &&
-	    (ms->section_mem_map != SECTION_MARKED_PRESENT))
-		return -EEXIST;
-	/*
-	 * Subtle, we encode the real pfn into the mem_map such that
-	 * the identity pfn - section_mem_map will return the actual
-	 * physical page frame number.
-	 */
-	ms->section_mem_map = mem_map - (pnum << PFN_SECTION_SHIFT);
+	if (!valid_section(ms))
+		return -EINVAL;
+
+	ms->section_mem_map |= sparse_encode_mem_map(mem_map, pnum);
 
 	return 1;
 }
@@ -96,7 +111,7 @@ void sparse_init(void)
 	struct page *map;
 
 	for (pnum = 0; pnum < NR_MEM_SECTIONS; pnum++) {
-		if (!mem_section[pnum].section_mem_map)
+		if (!valid_section_nr(pnum))
 			continue;
 
 		map = sparse_early_mem_map_alloc(pnum);
_
