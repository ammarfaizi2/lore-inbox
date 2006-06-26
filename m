Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933264AbWFZX3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264AbWFZX3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933161AbWFZWf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:35:28 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:37791 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933163AbWFZWfW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:22 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 10/20] [Suspend2] Count pages in image parts.
Date: Tue, 27 Jun 2006 08:35:20 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223519.4050.52436.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iterate over zones and pages, counting the number of pages of each type and
populating the pageset1 and pageset1_copy bitmaps (the pages that will be
atomically copied, and the destination pages for the copies).

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |  103 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index 0030661..14ab1a4 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -240,3 +240,106 @@ static int size_of_free_region(struct pa
 	return (posn - page);
 }
 
+static struct page *rotext_start, *rotext_end;
+static struct page *rodata_start, *rodata_end;
+static struct page *nosave_start, *nosave_end;
+
+static __init int page_nosave_init(void)
+{
+	rodata_start = rodata_start_page();
+	rodata_end = rodata_end_page();
+
+	rotext_start = rotext_start_page();
+	rotext_end = rotext_end_page();
+	
+	nosave_start = nosave_start_page();
+	nosave_end = nosave_end_page();
+
+	return 0;
+}
+
+subsys_initcall(page_nosave_init);
+
+/* count_data_pages
+ *
+ * This routine generates our lists of pages to be stored in each
+ * pageset. Since we store the data using extents, and adding new
+ * extents might allocate a new extent page, this routine may well
+ * be called more than once.
+ */
+static struct pageset_sizes_result count_data_pages(void)
+{
+	int num_free = 0;
+	unsigned long loop;
+	int use_pagedir2;
+	struct pageset_sizes_result result;
+	struct zone *zone;
+
+	result.size1 = 0;
+	result.size1low = 0;
+	result.size2 = 0;
+	result.size2low = 0;
+
+	num_nosave = 0;
+
+	clear_dyn_pageflags(pageset1_map);
+
+	generate_free_page_map();
+
+	if (test_result_state(SUSPEND_ABORTED))
+		return result;
+
+	/*
+	 * Pages not to be saved are marked Nosave irrespective of being reserved
+	 */
+	for_each_zone(zone) {
+		for (loop = 0; loop < zone->spanned_pages; loop++) {
+			unsigned long pfn = zone->zone_start_pfn + loop;
+			struct page *page;
+			int chunk_size;
+
+			if (!pfn_valid(pfn))
+				continue;
+
+			page = pfn_to_page(pfn);
+			chunk_size = size_of_free_region(page);
+
+			if (PageNosave(page) ||
+			    (page >= rodata_start && page < rodata_end) ||
+			    (PageReserved(page) &&
+			     ((page >= nosave_start && page < nosave_end) ||
+			      is_highmem(zone)))) {
+				num_nosave++;
+				continue;
+			}
+
+			if (chunk_size) {
+				num_free += chunk_size;
+				loop += chunk_size - 1;
+				continue;
+			}
+
+			use_pagedir2 = PagePageset2(page);
+
+			if (use_pagedir2) {
+				result.size2++;
+				if (!PageHighMem(page)) {
+					result.size2low++;
+					SetPagePageset1Copy(page);
+				}
+			} else {
+				result.size1++;
+				SetPagePageset1(page);
+				if (!PageHighMem(page))
+					result.size1low++;
+			}
+		}
+	}
+
+	suspend_message(SUSPEND_EAT_MEMORY, SUSPEND_MEDIUM, 0,
+		"Count data pages: Set1 (%d) + Set2 (%d) + Nosave (%d) + NumFree (%d) = %d.\n",
+		result.size1, result.size2, num_nosave, num_free,
+		result.size1 + result.size2 + num_nosave + num_free);
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
