Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWITNzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWITNzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWITNzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:55:09 -0400
Received: from 85-210-218-110.dsl.pipex.com ([85.210.218.110]:60372 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751495AbWITNzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:55:07 -0400
Date: Wed, 20 Sep 2006 14:54:13 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] count defined zones to size ZONE_SHIFT
Message-ID: <20060920135413.GA7369@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent changes allowing ZONE_DMA etc to all be optional,
the ZONE_SHIFT calculation is very hard to follow.  Playing with
the compiler, it seems that the following is portable and IMO
much easier to read and understand.

-apw

=== 8< ===
count defined zones to size ZONE_SHIFT

Simplify calculation of the number of bits we need for ZONES_SHIFT
by adding up the definitions of the defined zones.  We make use of
the property of defined(X) that its value is one when X is defined
and zero otherwise.  From the GCC manuals:

  "defined name and defined (name) are both expressions whose
   value is 1 if name is defined as a macro at the current point
   in the program, and 0 otherwise."

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b7836c5..9e339da 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -149,15 +149,27 @@ #endif
  * match the requested limits. See gfp_zone() in include/linux/gfp.h
  */
 
-#if !defined(CONFIG_ZONE_DMA32) && !defined(CONFIG_HIGHMEM)
-#if !defined(CONFIG_ZONE_DMA)
+/*
+ * Count the active zones.  Note that the use of defined(X) outside
+ * #if and family is not necessarily defined so ensure we cannot use
+ * it later.  Use __ZONE_COUNT to work out how many shift bits we need.
+ */
+#define __ZONE_COUNT (			\
+	  defined(CONFIG_ZONE_DMA)	\
+	+ defined(CONFIG_ZONE_DMA32)	\
+	+ 1				\
+	+ defined(CONFIG_HIGHMEM)	\
+)
+#if __ZONE_COUNT < 2
 #define ZONES_SHIFT 0
-#else
+#elif __ZONE_COUNT <= 2
 #define ZONES_SHIFT 1
-#endif
-#else
+#elif __ZONE_COUNT <= 4
 #define ZONES_SHIFT 2
+#else
+#error ZONES_SHIFT -- too many zones configured adjust calculation
 #endif
+#undef __ZONE_COUNT
 
 struct zone {
 	/* Fields commonly accessed by the page allocator */
