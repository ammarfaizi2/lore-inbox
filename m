Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVAaHlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVAaHlD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVAaHkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:40:10 -0500
Received: from waste.org ([216.27.176.166]:60652 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261956AbVAaHfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:02 -0500
Date: Mon, 31 Jan 2005 01:35:00 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6.416337461@selenic.com>
Message-Id: <7.416337461@selenic.com>
Subject: [PATCH 6/8] lib/sort: Replace insertion sort in exception tables
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace exception table insertion sort with lib/sort

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm2/lib/extable.c
===================================================================
--- mm2.orig/lib/extable.c	2005-01-30 20:33:18.000000000 -0800
+++ mm2/lib/extable.c	2005-01-30 20:40:53.000000000 -0800
@@ -13,6 +13,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sort.h>
 #include <asm/uaccess.h>
 
 extern struct exception_table_entry __start___ex_table[];
@@ -25,26 +26,17 @@
  * This is used both for the kernel exception table and for
  * the exception tables of modules that get loaded.
  */
+static int cmp_ex(const void *a, const void *b)
+{
+	const struct exception_table_entry *x = a, *y = b;
+	return x->insn - y->insn;
+}
+
 void sort_extable(struct exception_table_entry *start,
 		  struct exception_table_entry *finish)
 {
-	struct exception_table_entry el, *p, *q;
-
-	/* insertion sort */
-	for (p = start + 1; p < finish; ++p) {
-		/* start .. p-1 is sorted */
-		if (p[0].insn < p[-1].insn) {
-			/* move element p down to its right place */
-			el = *p;
-			q = p;
-			do {
-				/* el comes before q[-1], move q[-1] up one */
-				q[0] = q[-1];
-				--q;
-			} while (q > start && el.insn < q[-1].insn);
-			*q = el;
-		}
-	}
+	sort(start, finish - start, sizeof(struct exception_table_entry),
+	     cmp_ex, 0);
 }
 #endif
 
