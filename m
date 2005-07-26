Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVGZA0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVGZA0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGZA0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:26:19 -0400
Received: from kanga.kvack.org ([66.96.29.28]:49828 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261564AbVGZA0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:26:18 -0400
Date: Mon, 25 Jul 2005 20:26:57 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] make kmalloc() fail for swapped size / GFP flags
Message-ID: <20050726002657.GA13125@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes kmalloc() fail for swapped flags and size arguments 
as mention in Dave Jones keynote at OLS.  This is done by adding a new flag, 
__GFP_VALID, which is checked for in kmalloc(), that results in the size 
being too large.  Please apply.

		-ben

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -40,6 +40,7 @@ struct vm_area_struct;
 #define __GFP_ZERO	0x8000u	/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC 0x10000u /* Don't use emergency reserves */
 #define __GFP_NORECLAIM  0x20000u /* No realy zone reclaim during allocation */
+#define __GFP_VALID	0x80000000u /* valid GFP flags */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
@@ -50,12 +51,12 @@ struct vm_area_struct;
 			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
 			__GFP_NOMEMALLOC|__GFP_NORECLAIM)
 
-#define GFP_ATOMIC	(__GFP_HIGH)
-#define GFP_NOIO	(__GFP_WAIT)
-#define GFP_NOFS	(__GFP_WAIT | __GFP_IO)
-#define GFP_KERNEL	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_USER	(__GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_HIGHUSER	(__GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
+#define GFP_ATOMIC	(__GFP_VALID | __GFP_HIGH)
+#define GFP_NOIO	(__GFP_VALID | __GFP_WAIT)
+#define GFP_NOFS	(__GFP_VALID | __GFP_WAIT | __GFP_IO)
+#define GFP_KERNEL	(__GFP_VALID | __GFP_WAIT | __GFP_IO | __GFP_FS)
+#define GFP_USER	(__GFP_VALID | __GFP_WAIT | __GFP_IO | __GFP_FS)
+#define GFP_HIGHUSER	(__GFP_VALID | __GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
diff --git a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -78,6 +78,10 @@ extern void *__kmalloc(size_t, unsigned 
 
 static inline void *kmalloc(size_t size, unsigned int __nocast flags)
 {
+	if (__builtin_constant_p(flags) && !(flags & __GFP_VALID)) {
+		extern void __your_kmalloc_flags_are_not_valid(void);
+		__your_kmalloc_flags_are_not_valid();
+	}
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 #define CACHE(x) \
