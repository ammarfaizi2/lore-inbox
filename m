Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933338AbWFZWq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933338AbWFZWq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933342AbWFZWmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:42:04 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:43703 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933334AbWFZWl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:58 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 15/28] [Suspend2] Allocate swapwriter storage.
Date: Tue, 27 Jun 2006 08:41:57 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224155.4975.97208.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate swap for the swapwriter to use. We support any number of swap
devices, of both types (partitions and files). After allocating the swap,
update the list of sectors that the entries map to.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   70 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index ae33a4e..efd08ca 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -365,7 +365,6 @@ static void get_main_pool_phys_params(vo
 	struct extent *extentpointer = NULL;
 	unsigned long address;
 	int i, extent_min = -1, extent_max = -1, last_chain = -1;
-	int prev_header_pages_allocated;
 
 	for (i = 0; i < MAX_SWAPFILES; i++)
 		if (block_chain[i].first)
@@ -413,9 +412,7 @@ static void get_main_pool_phys_params(vo
 			extent_min, extent_max);
 	}
 
-	prev_header_pages_allocated = header_pages_allocated;
-	header_pages_allocated = 0;
-	swapwriter_allocate_header_space(prev_header_pages_allocated);
+	swapwriter_allocate_header_space(header_pages_allocated);
 }
 
 static int swapwriter_storage_allocated(void)
@@ -483,3 +480,68 @@ static int swapwriter_release_storage(vo
 	return 0;
 }
 
+/* 
+ * Round robin allocation (where swap storage has the same priority).
+ * could make this very inefficient, so we track extents allocated on
+ * a per-swapfiles basis.
+ */
+static int swapwriter_allocate_storage(int space_requested)
+{
+	int i, result = 0, first[MAX_SWAPFILES];
+	int pages_to_get = space_requested - swapextents.size;
+	unsigned long extent_min[MAX_SWAPFILES], extent_max[MAX_SWAPFILES];
+	
+	if (pages_to_get < 1)
+		return 0;
+
+	for (i=0; i < MAX_SWAPFILES; i++) {
+		struct swap_info_struct *si = get_swap_info_struct(i);
+		if ((devinfo[i].bdev = si->bdev))
+			devinfo[i].dev_t = si->bdev->bd_dev;
+		devinfo[i].bmap_shift = 3;
+		devinfo[i].blocks_per_page = 1;
+		first[i] = 1;
+	}
+
+	for(i=0; i < pages_to_get; i++) {
+		swp_entry_t entry;
+		unsigned long new_value;
+		unsigned swapfilenum;
+
+		entry = get_swap_page();
+		if (!entry.val) {
+			printk("Failed to get a swap page.\n");
+			result = -ENOSPC;
+			break;
+		}
+		
+		swapfilenum = swp_type(entry);
+		new_value = swap_entry_to_extent_val(entry);
+		if (first[swapfilenum]) {
+			first[swapfilenum] = 0;
+			extent_min[swapfilenum] = extent_max[swapfilenum] =
+				new_value;
+		} else {
+			if (new_value == extent_max[swapfilenum] + 1)
+				extent_max[swapfilenum]++;
+			else {
+				suspend_add_to_extent_chain(
+					&swapextents,
+					extent_min[swapfilenum],
+					extent_max[swapfilenum]);
+				extent_min[swapfilenum] =
+					extent_max[swapfilenum] = new_value;
+			}
+		}
+	}
+
+	for (i = 0; i < MAX_SWAPFILES; i++)
+		if (!first[i])
+			suspend_add_to_extent_chain(
+				&swapextents,
+				extent_min[i], extent_max[i]);
+
+	get_main_pool_phys_params();
+	return result;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
