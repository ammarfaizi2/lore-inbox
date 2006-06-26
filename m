Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWFZQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWFZQ4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWFZQyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:54:37 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:50822 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750882AbWFZQyO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:54:14 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 4/9] [Suspend2] Add extent to extent chain.
Date: Tue, 27 Jun 2006 02:54:18 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626165417.11065.15610.stgit@nigel.suspend2.net>
In-Reply-To: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new extent, possibly merging it with existing extents.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/extent.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/kernel/power/extent.c b/kernel/power/extent.c
index ab19509..31fcb65 100644
--- a/kernel/power/extent.c
+++ b/kernel/power/extent.c
@@ -70,3 +70,74 @@ void suspend_put_extent_chain(struct ext
 	chain->size = chain->allocs = chain->frees = 0;
 }
 
+/* 
+ * suspend_add_to_extent_chain
+ *
+ * Add an extent to an existing chain.
+ */
+int suspend_add_to_extent_chain(struct extent_chain *chain, 
+		unsigned long minimum, unsigned long maximum)
+{
+	struct extent *new_extent = NULL, *start_at;
+
+	/* Find the right place in the chain */
+	start_at = (chain->last_touched && 
+		    (chain->last_touched->minimum < minimum)) ?
+		chain->last_touched : NULL;
+
+	if (!start_at && chain->first && chain->first->minimum < minimum)
+		start_at = chain->first;
+
+	while (start_at && start_at->next && start_at->next->minimum < minimum)
+		start_at = start_at->next;
+
+	if (start_at && start_at->maximum == (minimum - 1)) {
+		start_at->maximum = maximum;
+
+		/* Merge with the following one? */
+		if (start_at->next &&
+		    start_at->maximum + 1 == start_at->next->minimum) {
+			struct extent *to_free = start_at->next;
+			start_at->maximum = start_at->next->maximum;
+			start_at->next = start_at->next->next;
+			chain->frees++;
+			suspend_put_extent(to_free);
+		}
+
+		chain->last_touched = start_at;
+		chain->size+= (maximum - minimum + 1);
+
+		return 0;
+	}
+
+	new_extent = suspend_get_extent();
+	if (!new_extent) {
+		printk("Error unable to append a new extent to the chain.\n");
+		return 2;
+	}
+
+	chain->allocs++;
+	chain->size+= (maximum - minimum + 1);
+	new_extent->minimum = minimum;
+	new_extent->maximum = maximum;
+	new_extent->next = NULL;
+
+	chain->last_touched = new_extent;
+
+	if (start_at) {
+		struct extent *next = start_at->next;
+		start_at->next = new_extent;
+		new_extent->next = next;
+		if (!next)
+			chain->last = new_extent;
+	} else {
+		if (chain->first) {
+			new_extent->next = chain->first;
+			chain->first = new_extent;
+		} else
+			chain->last = chain->first = new_extent;
+	}
+
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
