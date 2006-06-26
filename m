Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWFZX3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWFZX3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933252AbWFZX3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:29:18 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:38815 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933168AbWFZWf3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:35:29 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/20] [Suspend2] Recalculate image contents.
Date: Tue, 27 Jun 2006 08:35:28 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223526.4050.31341.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate anew which pages should be saved, and which pageset they should
belong to.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/prepare_image.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/kernel/power/prepare_image.c b/kernel/power/prepare_image.c
index c85ce6b..6b3f2c9 100644
--- a/kernel/power/prepare_image.c
+++ b/kernel/power/prepare_image.c
@@ -362,3 +362,35 @@ static int amount_needed(int use_image_s
 	return max1;
 }
 
+/* suspend_recalculate_image_contents
+ *
+ * Eaten is the number of pages which have been eaten.
+ * Pagedirincluded is the number of pages which have been allocated for the pagedir.
+ */
+void suspend_recalculate_image_contents(int atomic_copy) 
+{
+	struct pageset_sizes_result result;
+
+	clear_dyn_pageflags(pageset1_map);
+	if (!atomic_copy) {
+		int pfn;
+		BITMAP_FOR_EACH_SET(pageset2_map, pfn)
+			ClearPagePageset1Copy(pfn_to_page(pfn));
+		/* Need to call this before getting pageset1_size! */
+		suspend_mark_pages_for_pageset2();
+	}
+	BUG_ON(in_atomic() && !irqs_disabled());
+	result = count_data_pages();
+	pageset1_sizelow = result.size1low;
+	pageset2_sizelow = result.size2low;
+	pagedir1.lastpageset_size = pagedir1.pageset_size = result.size1;
+	pagedir2.lastpageset_size = pagedir2.pageset_size = result.size2;
+
+	if (!atomic_copy) {
+		storage_available = suspend_active_writer->storage_available();
+		display_stats(1, 0);
+	}
+	BUG_ON(in_atomic() && !irqs_disabled());
+	return;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
