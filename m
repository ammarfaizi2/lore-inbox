Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVHHWiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVHHWiq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVHHWiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:38:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45072 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932306AbVHHWip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:38:45 -0400
Date: Tue, 9 Aug 2005 00:38:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make kcalloc() a static inline
Message-ID: <20050808223842.GM4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kcalloc() doesn't do much more than calling kzalloc(), and gcc has 
better optimizing opportunities when it's inlined.

The result of this patch with a fulll kernel compile (roughly equivalent 
to "make allyesconfig") shows a minimal size improvement:

    text           data     bss     dec             hex filename
25864955        5891214 2012840 33769009        2034631 vmlinux-before
25864635        5891206 2012840 33768681        20344e9 vmlinux-staticinline


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/slab.h |   15 ++++++++++++++-
 mm/slab.c            |   14 --------------
 2 files changed, 14 insertions(+), 15 deletions(-)

--- linux-2.6.13-rc5-mm1-full/include/linux/slab.h.old	2005-08-08 12:28:32.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/include/linux/slab.h	2005-08-08 12:29:59.000000000 +0200
@@ -103,8 +103,21 @@
 	return __kmalloc(size, flags);
 }
 
-extern void *kcalloc(size_t, size_t, unsigned int __nocast);
 extern void *kzalloc(size_t, unsigned int __nocast);
+
+/**
+ * kcalloc - allocate memory for an array. The memory is set to zero.
+ * @n: number of elements.
+ * @size: element size.
+ * @flags: the type of memory to allocate.
+ */
+static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
+{
+	if (n != 0 && size > INT_MAX / n)
+		return NULL;
+	return kzalloc(n * size, flags);
+}
+
 extern void kfree(const void *);
 extern unsigned int ksize(const void *);
 
--- linux-2.6.13-rc5-mm1-full/mm/slab.c.old	2005-08-08 12:29:26.000000000 +0200
+++ linux-2.6.13-rc5-mm1-full/mm/slab.c	2005-08-08 12:29:53.000000000 +0200
@@ -3028,20 +3028,6 @@
 EXPORT_SYMBOL(kzalloc);
 
 /**
- * kcalloc - allocate memory for an array. The memory is set to zero.
- * @n: number of elements.
- * @size: element size.
- * @flags: the type of memory to allocate.
- */
-void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
-{
-	if (n != 0 && size > INT_MAX / n)
-		return NULL;
-	return kzalloc(n * size, flags);
-}
-EXPORT_SYMBOL(kcalloc);
-
-/**
  * kfree - free previously allocated memory
  * @objp: pointer returned by kmalloc.
  *

