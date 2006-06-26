Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933108AbWFZWcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933108AbWFZWcF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbWFZWb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:31:59 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:62954 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933111AbWFZWbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:31:52 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 6/7] [Suspend2] Relocate pageflags.
Date: Tue, 27 Jun 2006 08:31:50 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223148.3725.73364.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
References: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Relocate dynamically allocated pageflags to locations that won't be
overwritten by the memory we're about to restore. This is used for
restoring highmem pages after we've done the atomic restore of low memory.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pageflags.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pageflags.c b/kernel/power/pageflags.c
index 0b019de..b61b2a6 100644
--- a/kernel/power/pageflags.c
+++ b/kernel/power/pageflags.c
@@ -130,3 +130,39 @@ void load_dyn_pageflags(dyn_pageflags_t 
 	}
 }
 
+/* relocate_dyn_pageflags
+ *
+ * Description: Relocate a set of pageflags to ensure they don't collide with
+ *              pageset 1 data which will get overwritten on copyback.
+ * Arguments:   dyn_pageflags_t *: Pointer to the bitmap being relocated.
+ */
+
+void relocate_dyn_pageflags(dyn_pageflags_t *pagemap)
+{
+	int i, zone_num = 0;
+	struct zone *zone;
+
+	if (!*pagemap)
+		return;
+
+	suspend_relocate_if_required((void *) pagemap,
+			sizeof(void *) * num_zones());
+	BUG_ON(PagePageset1(virt_to_page(*pagemap)));
+
+	for_each_zone(zone) {
+		int pages = pages_for_zone(zone);
+
+		suspend_relocate_if_required((void *) &((*pagemap)[zone_num]),
+			       sizeof(void *) * pages);
+		BUG_ON(PagePageset1(virt_to_page((*pagemap)[zone_num])));
+
+		for (i = 0; i < pages; i++) {
+			suspend_relocate_if_required(
+				(void *) &((*pagemap)[zone_num][i]),
+				PAGE_SIZE);
+			BUG_ON(PagePageset1(virt_to_page(
+						(*pagemap)[zone_num][i])));
+		}
+		zone_num++;
+	}
+}

--
Nigel Cunningham		nigel at suspend2 dot net
