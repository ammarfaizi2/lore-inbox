Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWFWSlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWFWSlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWFWSlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:41:50 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16079 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751910AbWFWSlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:49 -0400
Message-Id: <20060623183910.241438000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:00 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/21] small flush_icache() cleanup
Content-Disposition: inline; filename=0004-M68K-small-flush_icache-cleanup.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make flush_icache() an inline function and clean it up a litte.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/asm-m68k/cacheflush.h |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

01911c188ddfe00537e598d3feaf5451627271a3
diff --git a/include/asm-m68k/cacheflush.h b/include/asm-m68k/cacheflush.h
index 8aba971..24d3ff4 100644
--- a/include/asm-m68k/cacheflush.h
+++ b/include/asm-m68k/cacheflush.h
@@ -3,26 +3,30 @@ #define _M68K_CACHEFLUSH_H
 
 #include <linux/mm.h>
 
+/* cache code */
+#define FLUSH_I_AND_D	(0x00000808)
+#define FLUSH_I		(0x00000008)
+
 /*
  * Cache handling functions
  */
 
-#define flush_icache()						\
-({								\
-	if (CPU_IS_040_OR_060)					\
-		__asm__ __volatile__("nop\n\t"			\
-				     ".chip 68040\n\t"		\
-				     "cinva %%ic\n\t"		\
-				     ".chip 68k" : );		\
-	else {							\
-		unsigned long _tmp;				\
-		__asm__ __volatile__("movec %%cacr,%0\n\t"	\
-				     "orw %1,%0\n\t"		\
-				     "movec %0,%%cacr"		\
-				     : "=&d" (_tmp)		\
-				     : "id" (FLUSH_I));	\
-	}							\
-})
+static inline void flush_icache(void)
+{
+	if (CPU_IS_040_OR_060)
+		asm volatile (	"nop\n"
+			"	.chip	68040\n"
+			"	cpusha	%bc\n"
+			"	.chip	68k");
+	else {
+		unsigned long tmp;
+		asm volatile (	"movec	%%cacr,%0\n"
+			"	or.w	%1,%0\n"
+			"	movec	%0,%%cacr"
+			: "=&d" (tmp)
+			: "id" (FLUSH_I));
+	}
+}
 
 /*
  * invalidate the cache for the specified memory range.
@@ -43,10 +47,6 @@ extern void cache_push(unsigned long pad
  */
 extern void cache_push_v(unsigned long vaddr, int len);
 
-/* cache code */
-#define FLUSH_I_AND_D	(0x00000808)
-#define FLUSH_I		(0x00000008)
-
 /* This is needed whenever the virtual mapping of the current
    process changes.  */
 #define __flush_cache_all()					\
-- 
1.3.3

--

