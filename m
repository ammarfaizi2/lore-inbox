Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWJWEQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWJWEQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWJWEQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:16:10 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:57474 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751454AbWJWEQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:16:08 -0400
Subject: [PATCH] Move swap allocation routines to swap.c
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 14:16:04 +1000
Message-Id: <1161576964.3466.12.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move swap allocation routines from swsusp.c to swap.c, so that all of
the swap related stuff really is in swap.c.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index fc713d5..89b3d14 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -46,6 +46,33 @@ static struct swsusp_header {
 
 static unsigned short root_swap = 0xffff;
 
+unsigned long alloc_swap_page(int swap, struct extent_chain *extents)
+{
+	swp_entry_t entry = get_swap_page_of_type(swap);
+	if (entry.val) {
+		unsigned long new_value = swap_entry_to_extent_val(entry);
+		suspend_add_to_extent_chain(extents, new_value, new_value);
+	}
+	return swp_offset(entry);
+}
+
+void free_all_swap_pages(int swap, struct extent_chain *extents)
+{
+	if (extents->first) {
+		/* Free swap entries */
+		struct extent *extentpointer;
+		unsigned long extentvalue;
+		swp_entry_t entry;
+		suspend_extent_for_each(extents, extentpointer, 
+				extentvalue) {
+			entry = extent_val_to_swap_entry(extentvalue);
+			swap_free(entry);
+		}
+
+		suspend_put_extent_chain(extents);
+	}
+}
+
 static int mark_swapfiles(swp_entry_t start)
 {
 	int error;
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index aa8205c..7bed461 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -73,33 +73,6 @@ static inline int restore_highmem(void) 
 static inline unsigned int count_highmem_pages(void) { return 0; }
 #endif
 
-unsigned long alloc_swap_page(int swap, struct extent_chain *extents)
-{
-	swp_entry_t entry = get_swap_page_of_type(swap);
-	if (entry.val) {
-		unsigned long new_value = swap_entry_to_extent_val(entry);
-		suspend_add_to_extent_chain(extents, new_value, new_value);
-	}
-	return swp_offset(entry);
-}
-
-void free_all_swap_pages(int swap, struct extent_chain *extents)
-{
-	if (extents->first) {
-		/* Free swap entries */
-		struct extent *extentpointer;
-		unsigned long extentvalue;
-		swp_entry_t entry;
-		suspend_extent_for_each(extents, extentpointer, 
-				extentvalue) {
-			entry = extent_val_to_swap_entry(extentvalue);
-			swap_free(entry);
-		}
-
-		suspend_put_extent_chain(extents);
-	}
-}
-
 /**
  *	swsusp_shrink_memory -  Try to free as much memory as needed
  *


