Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933107AbWFZWbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933107AbWFZWbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933113AbWFZWbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:31:52 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:62442 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933109AbWFZWbs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:31:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 5/7] [Suspend2] Serialise pageflags.
Date: Tue, 27 Jun 2006 08:31:46 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223145.3725.93463.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
References: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Routines for serialising pageflags in an image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pageflags.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pageflags.c b/kernel/power/pageflags.c
index 7c00257..0b019de 100644
--- a/kernel/power/pageflags.c
+++ b/kernel/power/pageflags.c
@@ -56,3 +56,77 @@ int suspend_pageflags_space_needed(void)
 	return total;
 }
 
+/* save_dyn_pageflags
+ *
+ * Description: Save a set of pageflags.
+ * Arguments:   dyn_pageflags_t *: Pointer to the bitmap being saved.
+ */
+
+void save_dyn_pageflags(dyn_pageflags_t pagemap)
+{
+	int i, zone_num = 0;
+	struct zone *zone;
+
+	if (!*pagemap)
+		return;
+
+	for_each_zone(zone) {
+		int size = pages_for_zone(zone);
+
+		suspend_active_writer->rw_header_chunk(WRITE, NULL,
+				(char *) &zone_num, sizeof(int));
+		suspend_active_writer->rw_header_chunk(WRITE, NULL,
+				(char *) &size, sizeof(int));
+
+		for (i = 0; i < size; i++)
+			suspend_active_writer->rw_header_chunk(WRITE, NULL,
+				(char *) pagemap[zone_num][i], PAGE_SIZE);
+		zone_num++;
+	}
+	zone_num = -1;
+	suspend_active_writer->rw_header_chunk(WRITE, NULL,
+			(char *) &zone_num, sizeof(int));
+}
+
+/* load_dyn_pageflags
+ *
+ * Description: Load a set of pageflags.
+ * Arguments:   dyn_pageflags_t *: Pointer to the bitmap being loaded.
+ *              (It must be allocated before calling this routine).
+ */
+
+void load_dyn_pageflags(dyn_pageflags_t pagemap)
+{
+	int i, zone_num = 0, zone_check = 0;
+	struct zone *zone;
+
+	if (!pagemap)
+		return;
+
+	for_each_zone(zone) {
+		int size = 0;
+		suspend_active_writer->rw_header_chunk(READ, NULL,
+				(char *) &zone_check, sizeof(int));
+		if (zone_check != zone_num) {
+			printk("Zone check (%d) != zone_num (%d).\n",
+					zone_check, zone_num);
+			BUG();
+		}
+		suspend_active_writer->rw_header_chunk(READ, NULL,
+				(char *) &size, sizeof(int));
+
+		for (i = 0; i < size; i++)
+			suspend_active_writer->rw_header_chunk(READ, NULL,
+					(char *) pagemap[zone_num][i],
+					PAGE_SIZE);
+		zone_num++;
+	}
+	suspend_active_writer->rw_header_chunk(READ, NULL, (char *) &zone_check,
+			sizeof(int));
+	if (zone_check != -1) {
+		printk("Didn't read end of dyn pageflag data marker.(%x)\n",
+				zone_check);
+		BUG();
+	}
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
