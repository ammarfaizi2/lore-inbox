Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVAaHlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVAaHlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVAaHjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:39:21 -0500
Received: from waste.org ([216.27.176.166]:60908 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261957AbVAaHfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:02 -0500
Date: Mon, 31 Jan 2005 01:35:01 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7.416337461@selenic.com>
Message-Id: <8.416337461@selenic.com>
Subject: [PATCH 7/8] lib/sort: Replace insertion sort in IA64 exception tables
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch IA64 exception tables to lib/sort.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/arch/ia64/mm/extable.c
===================================================================
--- tq.orig/arch/ia64/mm/extable.c	2005-01-25 09:20:53.000000000 -0800
+++ tq/arch/ia64/mm/extable.c	2005-01-30 13:56:18.000000000 -0800
@@ -6,29 +6,24 @@
  */
 
 #include <linux/config.h>
+#include <linux/sort.h>
 
 #include <asm/uaccess.h>
 #include <asm/module.h>
 
-static inline int
-compare_entries (struct exception_table_entry *l, struct exception_table_entry *r)
+static int cmp_ex(const void *a, const void *b)
 {
+	const struct exception_table_entry *l = a, *r = b;
 	u64 lip = (u64) &l->addr + l->addr;
 	u64 rip = (u64) &r->addr + r->addr;
 
-	if (lip < rip)
-		return -1;
-	if (lip == rip)
-		return 0;
-	else
-		return 1;
+	return lip - rip;
 }
 
-static inline void
-swap_entries (struct exception_table_entry *l, struct exception_table_entry *r)
+static void swap_ex(void *a, void *b)
 {
+	struct exception_table_entry *l = a, *r = b, tmp;
 	u64 delta = (u64) r - (u64) l;
-	struct exception_table_entry tmp;
 
 	tmp = *l;
 	l->addr = r->addr + delta;
@@ -38,23 +33,20 @@
 }
 
 /*
- * Sort the exception table.  It's usually already sorted, but there may be unordered
- * entries due to multiple text sections (such as the .init text section).  Note that the
- * exception-table-entries contain location-relative addresses, which requires a bit of
- * care during sorting to avoid overflows in the offset members (e.g., it would not be
- * safe to make a temporary copy of an exception-table entry on the stack, because the
- * stack may be more than 2GB away from the exception-table).
+ * Sort the exception table. It's usually already sorted, but there
+ * may be unordered entries due to multiple text sections (such as the
+ * .init text section). Note that the exception-table-entries contain
+ * location-relative addresses, which requires a bit of care during
+ * sorting to avoid overflows in the offset members (e.g., it would
+ * not be safe to make a temporary copy of an exception-table entry on
+ * the stack, because the stack may be more than 2GB away from the
+ * exception-table).
  */
-void
-sort_extable (struct exception_table_entry *start, struct exception_table_entry *finish)
+void sort_extable (struct exception_table_entry *start,
+		   struct exception_table_entry *finish)
 {
-	struct exception_table_entry *p, *q;
-
- 	/* insertion sort */
-	for (p = start + 1; p < finish; ++p)
-		/* start .. p-1 is sorted; push p down to it's proper place */
-		for (q = p; q > start && compare_entries(&q[0], &q[-1]) < 0; --q)
-			swap_entries(&q[0], &q[-1]);
+	sort(start, finish - start, sizeof(struct exception_table_entry),
+	     cmp_ex, swap_ex);
 }
 
 const struct exception_table_entry *
