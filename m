Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUIWXPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUIWXPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUIWXEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:04:10 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:16611 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S267516AbUIWXCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:02:42 -0400
Date: Thu, 23 Sep 2004 16:02:24 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch/RFC]Make second level zone_table[2/3]
Cc: Linux Hotplug Memory Support <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20040923135108.D8CC.YGOTO@us.fujitsu.com>
References: <20040923135108.D8CC.YGOTO@us.fujitsu.com>
Message-Id: <20040923160059.D8D0.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.11.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch make second level of zone_table to reduce size of
first level zone_table like below.

     zone_table_directory.
     +------------+             zone_table
     |            |------------>+-----------+
     |------------|             |           |-> zone
     |            |             |-----------|
     |------------|             |           |-> zone
     |            |             +-----------+
     +------------+

Yasunori Goto <ygoto at us.fujitsu.com>

---

 erase_zoneid-goto/include/linux/mm.h |   37 +++++++++++++++++++++++++++++++---
 erase_zoneid-goto/mm/page_alloc.c    |   38 +++++++++++++++++++++++++++++------
 2 files changed, 66 insertions(+), 9 deletions(-)

diff -puN include/linux/mm.h~double_zone_table include/linux/mm.h
--- erase_zoneid/include/linux/mm.h~double_zone_table	Thu Sep 23 11:20:12 2004
+++ erase_zoneid-goto/include/linux/mm.h	Thu Sep 23 11:20:12 2004
@@ -378,22 +378,53 @@ static inline void put_page(struct page 
 #define PAGEZONE_SIZE (1 << PAGEZONE_SHIFT)
 #define PAGEZONE_MASK (PAGEZONE_SIZE - 1)
 
+#define PAGEZONE_DIR_SHIFT 8          /* XXX */
+#define PAGEZONE_DIR_SIZE (1 << PAGEZONE_DIR_SHIFT)
+#define PAGEZONE_DIR_MASK (PAGEZONE_DIR_SIZE - 1)
+
+#define PZDIR_SHIFT (PAGEZONE_SHIFT + PAGEZONE_DIR_SHIFT)
+#define PZDIR_SIZE (1 << PZDIR_SHIFT)
+#define PZDIR_MASK (PZDIR_SIZE - 1)
+
 #ifndef PAGE_INDEX_OFFSET
 #define PAGE_INDEX_OFFSET PAGE_OFFSET
 #endif
 
 static inline unsigned long page_to_index(struct page *page)
 {
-	unsigned long out = (unsigned long)(page - (struct page *)PAGE_INDEX_OFFSET);
+	return (unsigned long)(page - (struct page *)PAGE_INDEX_OFFSET);
+}
+
+static inline unsigned long page_to_primary_index(struct page *page)
+{
+	return  page_to_index(page) >> PZDIR_SHIFT;
+}
+
+static inline unsigned long page_to_secondary_index(struct page *page)
+{
+	unsigned long out = page_to_index(page);
+	out &= PZDIR_MASK;
 	return out >> PAGEZONE_SHIFT;
 }
 
 struct zone;
-extern struct zone *zone_table[];
+struct zone_tbl{
+	union {
+		struct zone *zone;
+		struct zone_tbl *sec_zone_table;
+	};
+};
+
+extern struct zone_tbl pri_zone_table[];
 
 static inline struct zone *page_zone(struct page *page)
 {
-	return zone_table[ page_to_index(page)];
+	struct zone_tbl *entry;
+
+	entry = pri_zone_table + page_to_primary_index(page);
+	entry = entry->sec_zone_table;
+	entry += page_to_secondary_index(page);
+	return entry->zone;
 }
 
 static inline unsigned long page_to_nid(struct page *page)
diff -puN mm/page_alloc.c~double_zone_table mm/page_alloc.c
--- erase_zoneid/mm/page_alloc.c~double_zone_table	Thu Sep 23 11:20:12 2004
+++ erase_zoneid-goto/mm/page_alloc.c	Thu Sep 23 11:20:12 2004
@@ -52,8 +52,8 @@ EXPORT_SYMBOL(nr_swap_pages);
  * Used by page_zone() to look up the address of the struct zone whose
  * id is encoded in the upper bits of page->flags
  */
-struct zone *zone_table[ (~PAGE_OFFSET + 1) >> (PAGEZONE_SHIFT + PAGE_SHIFT) ];
-EXPORT_SYMBOL(zone_table);
+struct zone_tbl pri_zone_table[ (~PAGE_OFFSET + 1) >> (PZDIR_SHIFT + PAGE_SHIFT) ];
+EXPORT_SYMBOL(pri_zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 int min_free_kbytes = 1024;
@@ -1578,15 +1578,41 @@ void zone_init_free_lists(struct pglist_
 
 void set_page_zone(struct page *lmem_map, unsigned int size,  struct zone *zone)
 {
-	struct zone **entry;
-	entry = &zone_table[page_to_index(lmem_map)];
+ 	struct zone_tbl *pri_entry;
+	struct page *page = lmem_map;
+
+	pri_entry = &pri_zone_table[page_to_primary_index(page)];
 
 	size = size + PAGEZONE_MASK; /* round up */
 	size >>= PAGEZONE_SHIFT;
 
-	for ( ; size > 0; entry++, size--)
-		*entry = zone;
+ 	for ( ; size > 0; pri_entry++){
+ 		struct zone_tbl *sec_entry, *sec_start_entry;
+ 		unsigned int sec_index, sec_count;
+
+ 		sec_start_entry = pri_entry->sec_zone_table;
+ 		if (!sec_start_entry){
+ 			unsigned int entry_size;
+ 			entry_size = sizeof(struct zone_tbl) <<	PAGEZONE_DIR_SHIFT;
+
+ 			sec_start_entry = alloc_bootmem_node(NODE_DATA(nid), entry_size);
+ 			memset(sec_start_entry, 0, entry_size);
+ 		}
+
+ 		sec_index = page_to_secondary_index(page);
+ 		sec_entry = sec_start_entry + sec_index;
+
+ 		for (sec_count = sec_index; sec_count < PAGEZONE_DIR_SIZE;
+		     sec_count++, sec_entry++){
+ 			sec_entry->zone = zone;
+ 			page += PAGEZONE_SIZE;
+ 			size--;
+ 			if (size == 0)
+ 				break;
+ 		}
 
+  		pri_entry->sec_zone_table = sec_start_entry;
+  	}
 }
 
 /*
_


