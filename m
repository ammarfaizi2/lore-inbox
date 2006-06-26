Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWFZQ5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWFZQ5M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWFZQ4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:56:48 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:53382 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750916AbWFZQyc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:32 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 9/9] [Suspend2] Extent header.
Date: Tue, 27 Jun 2006 02:54:36 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165434.11065.20895.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the header file for extents.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.h |   82 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.h b/kernel/power/extent.h
new file mode 100644
index 0000000..f68ca55
--- /dev/null
+++ b/kernel/power/extent.h
@@ -0,0 +1,82 @@
+/*
+ * kernel/power/extent.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations related to extents. Extents are
+ * suspend's method of storing some of the metadata for the image.
+ * See extent.c for more info.
+ *
+ */
+
+#include "modules.h"
+
+#ifndef EXTENT_H
+#define EXTENT_H
+struct extent_chain {
+	int size; /* size of the extent ie sum (max-min+1) */
+	int allocs, frees;
+	char *name;
+	struct extent *first, *last, *last_touched;
+};
+
+/*
+ * We rely on extents not fitting evenly into a page.
+ * The last four bytes are used to store the number
+ * of the page, to make saving & reloading pages simpler.
+ */
+struct extent {
+	unsigned long minimum, maximum;
+	struct extent *next;
+};
+
+struct extent_iterate_state {
+	struct extent_chain *chains;
+	int num_chains;
+	int current_chain;
+	struct extent *current_extent;
+	unsigned long current_offset;
+};
+
+struct extent_iterate_saved_state {
+	int chain_num;
+	int extent_num;
+	unsigned long offset;
+};
+
+#define suspend_extent_state_eof(state) ((state)->num_chains < (state)->current_chain)
+
+#define suspend_extent_for_each(extent_chain, extentpointer, value) \
+if ((extent_chain)->first) \
+	for ((extentpointer) = (extent_chain)->first, (value) = \
+			(extentpointer)->minimum; \
+	     ((extentpointer) && ((extentpointer)->next || (value) <= \
+				 (extentpointer)->maximum)); \
+	     (((value) == (extentpointer)->maximum) ? \
+		((extentpointer) = (extentpointer)->next, (value) = \
+		 ((extentpointer) ? (extentpointer)->minimum : 0)) : \
+			(value)++))
+
+extern int suspend_extents_allocated;
+void suspend_put_extent_chain(struct extent_chain *chain);
+int suspend_add_to_extent_chain(struct extent_chain *chain, 
+		unsigned long minimum, unsigned long maximum);
+int suspend_serialise_extent_chain(struct suspend_module_ops *owner,
+		struct extent_chain *chain);
+int suspend_load_extent_chain(struct extent_chain *chain);
+
+/* swap_entry_to_extent_val & extent_val_to_swap_entry: 
+ * We are putting offset in the low bits so consecutive swap entries
+ * make consecutive extent values */
+#define swap_entry_to_extent_val(swp_entry) (swp_entry.val)
+#define extent_val_to_swap_entry(val) (swp_entry_t) { (val) }
+
+void suspend_extent_state_save(struct extent_iterate_state *state,
+		struct extent_iterate_saved_state *saved_state);
+void suspend_extent_state_restore(struct extent_iterate_state *state,
+		struct extent_iterate_saved_state *saved_state);
+void suspend_extent_state_goto_start(struct extent_iterate_state *state);
+unsigned long suspend_extent_state_next(struct extent_iterate_state *state);
+#endif

--
Nigel Cunningham		nigel at suspend2 dot net
