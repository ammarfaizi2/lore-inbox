Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVKASi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVKASi2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVKASi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:38:28 -0500
Received: from waste.org ([216.27.176.166]:50064 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751074AbVKASi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:38:27 -0500
Date: Tue, 1 Nov 2005 12:33:12 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
Message-Id: <2.494767362@selenic.com>
Subject: [PATCH 1/2] slob: move kstrdup to lib/string.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This move kstrdup to lib/string.c. This a) matches its declaration in
string.h and b) avoids having to duplicate it for SLOB.

(this work has been sponsored in part by CELF)

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-slob/lib/string.c
===================================================================
--- 2.6.14-slob.orig/lib/string.c	2005-10-31 13:04:50.000000000 -0800
+++ 2.6.14-slob/lib/string.c	2005-10-31 18:14:39.000000000 -0800
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #ifndef __HAVE_ARCH_STRNICMP
 /**
@@ -602,3 +603,25 @@ void *memchr(const void *s, int c, size_
 }
 EXPORT_SYMBOL(memchr);
 #endif
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
Index: 2.6.14-slob/mm/slab.c
===================================================================
--- 2.6.14-slob.orig/mm/slab.c	2005-10-31 13:04:50.000000000 -0800
+++ 2.6.14-slob/mm/slab.c	2005-10-31 18:14:43.000000000 -0800
@@ -3596,26 +3596,3 @@ unsigned int ksize(const void *objp)
 
 	return obj_reallen(GET_PAGE_CACHE(virt_to_page(objp)));
 }
-
-
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
