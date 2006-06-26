Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933355AbWFZWtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933355AbWFZWtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933326AbWFZWtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:49:21 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:41655 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933314AbWFZWlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 11/28] [Suspend2] Get block chains for swapwriter.
Date: Tue, 27 Jun 2006 08:41:42 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224141.4975.36440.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the (previously allocated) swap entries, get the sectors for each
device to which we'll be writing the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   58 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index 8e4221d..af6640f 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -360,3 +360,61 @@ static int swapwriter_allocate_header_sp
 	return 0;
 }
 
+static void get_main_pool_phys_params(void)
+{
+	struct extent *extentpointer = NULL;
+	unsigned long address;
+	int i, extent_min = -1, extent_max = -1, last_chain = -1;
+	int prev_header_pages_allocated;
+
+	for (i = 0; i < MAX_SWAPFILES; i++)
+		if (block_chain[i].first)
+			suspend_put_extent_chain(&block_chain[i]);
+
+	suspend_extent_for_each(&swapextents, extentpointer, address) {
+		swp_entry_t swap_address = extent_val_to_swap_entry(address);
+		pgoff_t offset = swp_offset(swap_address);
+		unsigned swapfilenum = swp_type(swap_address);
+		struct swap_info_struct *sis = get_swap_info_struct(swapfilenum);
+		sector_t new_sector = map_swap_page(sis, offset);
+
+		if ((new_sector == extent_max + 1) &&
+		    (last_chain == swapfilenum))
+			extent_max++;
+		else {
+			if (extent_min > -1) {
+				if (test_action_state(SUSPEND_TEST_BIO))
+					printk("Adding extent chain %d %d-%d.\n",
+						swapfilenum,
+						extent_min <<
+						 devinfo[last_chain].bmap_shift,
+						extent_max <<
+						 devinfo[last_chain].bmap_shift);
+						
+				suspend_add_to_extent_chain(
+					&block_chain[last_chain],
+					extent_min, extent_max);
+			}
+			extent_min = extent_max = new_sector;
+			last_chain = swapfilenum;
+		}
+	}
+
+	if (extent_min > -1) {
+		if (test_action_state(SUSPEND_TEST_BIO))
+			printk("Adding extent chain %d %d-%d.\n",
+				last_chain,
+				extent_min <<
+					devinfo[last_chain].bmap_shift,
+				extent_max <<
+					devinfo[last_chain].bmap_shift);
+		suspend_add_to_extent_chain(
+			&block_chain[last_chain],
+			extent_min, extent_max);
+	}
+
+	prev_header_pages_allocated = header_pages_allocated;
+	header_pages_allocated = 0;
+	swapwriter_allocate_header_space(prev_header_pages_allocated);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
