Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVKCXGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVKCXGE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVKCXGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:06:03 -0500
Received: from waste.org ([216.27.176.166]:45791 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751027AbVKCXGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:06:02 -0500
Date: Thu, 3 Nov 2005 17:00:43 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Message-Id: <2.505517440@selenic.com>
Subject: [PATCH 1/2] slob: introduce mm/util.c for shared functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add mm/util.c for functions common between SLAB and SLOB.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-slob/mm/Makefile
===================================================================
--- 2.6.14-slob.orig/mm/Makefile	2005-11-03 14:40:31.000000000 -0800
+++ 2.6.14-slob/mm/Makefile	2005-11-03 14:48:17.000000000 -0800
@@ -10,7 +10,7 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
-			   prio_tree.o $(mmu-y)
+			   prio_tree.o util.o $(mmu-y)
 
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
Index: 2.6.14-slob/mm/slab.c
===================================================================
--- 2.6.14-slob.orig/mm/slab.c	2005-11-03 14:40:32.000000000 -0800
+++ 2.6.14-slob/mm/slab.c	2005-11-03 14:47:04.000000000 -0800
@@ -2994,20 +2994,6 @@ void kmem_cache_free(kmem_cache_t *cache
 EXPORT_SYMBOL(kmem_cache_free);
 
 /**
- * kzalloc - allocate memory. The memory is set to zero.
- * @size: how many bytes of memory are required.
- * @flags: the type of memory to allocate.
- */
-void *kzalloc(size_t size, gfp_t flags)
-{
-	void *ret = kmalloc(size, flags);
-	if (ret)
-		memset(ret, 0, size);
-	return ret;
-}
-EXPORT_SYMBOL(kzalloc);
-
-/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *
@@ -3598,24 +3584,3 @@ unsigned int ksize(const void *objp)
 }
 
 
-/*
- * kstrdup - allocate space for and copy an existing string
- *
- * @s: the string to duplicate
- * @gfp: the GFP mask used in the kmalloc() call when allocating memory
- */
-char *kstrdup(const char *s, gfp_t gfp)
-{
-	size_t len;
-	char *buf;
-
-	if (!s)
-		return NULL;
-
-	len = strlen(s) + 1;
-	buf = kmalloc(len, gfp);
-	if (buf)
-		memcpy(buf, s, len);
-	return buf;
-}
-EXPORT_SYMBOL(kstrdup);
Index: 2.6.14-slob/mm/util.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ 2.6.14-slob/mm/util.c	2005-11-03 14:47:02.000000000 -0800
@@ -0,0 +1,39 @@
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+/**
+ * kzalloc - allocate memory. The memory is set to zero.
+ * @size: how many bytes of memory are required.
+ * @flags: the type of memory to allocate.
+ */
+void *kzalloc(size_t size, gfp_t flags)
+{
+	void *ret = kmalloc(size, flags);
+	if (ret)
+		memset(ret, 0, size);
+	return ret;
+}
+EXPORT_SYMBOL(kzalloc);
+
+/*
+ * kstrdup - allocate space for and copy an existing string
+ *
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+char *kstrdup(const char *s, gfp_t gfp)
+{
+	size_t len;
+	char *buf;
+
+	if (!s)
+		return NULL;
+
+	len = strlen(s) + 1;
+	buf = kmalloc(len, gfp);
+	if (buf)
+		memcpy(buf, s, len);
+	return buf;
+}
+EXPORT_SYMBOL(kstrdup);
