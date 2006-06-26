Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWFZXFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWFZXFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933272AbWFZWjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:39:52 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:20663 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933269AbWFZWjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:39:25 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/35] [Suspend2] Filewriter populate block list.
Date: Tue, 27 Jun 2006 08:39:23 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223922.4685.72772.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Populate the extent chain that contains the list of sectors we'll use for
writing the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   67 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 9046b80..97f97be 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -168,3 +168,70 @@ static int size_ignoring_ignored_pages(v
 		return filewriter_storage_available();
 }
 
+static void __populate_block_list(int min, int max)
+{
+	if (test_action_state(SUSPEND_TEST_BIO))
+		printk("Adding extent %d-%d.\n", min << devinfo.bmap_shift,
+		        ((max + 1) << devinfo.bmap_shift) - 1);
+
+	suspend_add_to_extent_chain(&block_chain, min, max);
+}
+
+static void populate_block_list(void)
+{
+	int i;
+	
+	if (block_chain.first)
+		suspend_put_extent_chain(&block_chain);
+
+	if (target_is_normal_file()) {
+		int extent_min = -1, extent_max = -1, got_header = 0;
+
+		for (i = 0;
+		     i < (target_inode->i_size >> PAGE_SHIFT);
+		     i++) {
+			sector_t new_sector;
+
+			if (!has_contiguous_blocks(i))
+				continue;
+
+			new_sector = bmap(target_inode,
+				(i * devinfo.blocks_per_page));
+
+			/* 
+			 * Ignore the first block in the file.
+			 * It gets the header.
+			 */
+			if (new_sector == target_firstblock >> devinfo.bmap_shift) {
+				got_header = 1;
+				continue;
+			}
+
+			/* 
+			 * I'd love to be able to fill in holes and resize 
+			 * files, but not yet...
+			 */
+
+			if (new_sector == extent_max + 1)
+				extent_max+= devinfo.blocks_per_page;
+			else {
+				if (extent_min > -1)
+					__populate_block_list(extent_min,
+							extent_max);
+
+				extent_min = new_sector;
+				extent_max = extent_min +
+					devinfo.blocks_per_page - 1;
+			}
+		}
+		if (extent_min > -1)
+			__populate_block_list(extent_min, extent_max);
+
+		BUG_ON(!got_header);
+	} else
+		if (target_storage_available > 0)
+			__populate_block_list(devinfo.blocks_per_page, 
+				(min(main_pages, target_storage_available) + 1) *
+			 	devinfo.blocks_per_page - 1);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
