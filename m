Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVAaHlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVAaHlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVAaHjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:39:37 -0500
Received: from waste.org ([216.27.176.166]:61164 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261959AbVAaHfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:35:03 -0500
Date: Mon, 31 Jan 2005 01:35:01 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.com>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8.416337461@selenic.com>
Message-Id: <9.416337461@selenic.com>
Subject: [PATCH 8/8] lib/sort: Use generic sort on x86_64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 wasn't doing anything special in its sort_extable. Use the
generic lib/extable sort.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: tq/arch/x86_64/mm/extable.c
===================================================================
--- tq.orig/arch/x86_64/mm/extable.c	2004-04-03 19:38:16.000000000 -0800
+++ tq/arch/x86_64/mm/extable.c	2005-01-30 14:01:16.000000000 -0800
@@ -33,26 +33,3 @@
         }
         return NULL;
 }
-
-/* When an exception handler is in an non standard section (like __init)
-   the fixup table can end up unordered. Fix that here. */
-void sort_extable(struct exception_table_entry *start,
-		  struct exception_table_entry *finish)
-{
-	struct exception_table_entry *e;
-	int change;
-
-	/* The input is near completely presorted, which makes bubble sort the
-	   best (and simplest) sort algorithm. */
-	do {
-		change = 0;
-		for (e = start+1; e < finish; e++) {
-			if (e->insn < e[-1].insn) {
-				struct exception_table_entry tmp = e[-1];
-				e[-1] = e[0];
-				e[0] = tmp;
-				change = 1;
-			}
-		}
-	} while (change != 0);
-}
Index: tq/include/asm-x86_64/uaccess.h
===================================================================
--- tq.orig/include/asm-x86_64/uaccess.h	2005-01-25 09:30:00.000000000 -0800
+++ tq/include/asm-x86_64/uaccess.h	2005-01-30 14:02:17.000000000 -0800
@@ -73,6 +73,7 @@
 	unsigned long insn, fixup;
 };
 
+#define ARCH_HAS_SEARCH_EXTABLE
 
 /*
  * These are the main single-value transfer routines.  They automatically
