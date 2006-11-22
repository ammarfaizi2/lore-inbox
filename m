Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752893AbWKVOjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbWKVOjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 09:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753357AbWKVOjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 09:39:03 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:53152
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1752893AbWKVOjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 09:39:01 -0500
Date: Wed, 22 Nov 2006 14:38:51 +0000
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: [PATCH] silence unused pgdat warning from alloc_bootmem_node and friends
Message-ID: <79c5d936eb213ae3169202f5f4c7e992@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

silence unused pgdat warning from alloc_bootmem_node and friends

x86 NUMA systems only define bootmem for node 0.  alloc_bootmem_node()
and friends therefore ignore the passed pgdat and use NODE_DATA(0)
in all cases.  This leads to the following warnings as we are not
using the passed parameter:

  .../mm/page_alloc.c: In function 'zone_wait_table_init':
  .../mm/page_alloc.c:2259: warning: unused variable 'pgdat'

One option would be to define all variables used with these macros
__attribute__ ((unused)), but this would leave us exposed should
these become genuinely unused.

The key here is that we _are_ using the value, we ignore it but that
is a deliberate action.  This patch adds a nested local variable
within the alloc_bootmem_node helper to which the pgdat parameter is
assigned making it 'used'.  The nested local is marked __attribute__
((unused)) to silence this same warning for it.

Against 2.6.19-rc5-mm2.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/include/asm-i386/mmzone.h b/include/asm-i386/mmzone.h
index 61b0733..3503ad6 100644
--- a/include/asm-i386/mmzone.h
+++ b/include/asm-i386/mmzone.h
@@ -120,13 +120,26 @@ static inline int pfn_valid(int pfn)
 	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
-#define alloc_bootmem_node(ignore, x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
-#define alloc_bootmem_pages_node(ignore, x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
-#define alloc_bootmem_low_pages_node(ignore, x) \
-	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0)
-
+#define alloc_bootmem_node(pgdat, x)					\
+({									\
+	struct pglist_data  __attribute__ ((unused))			\
+				*__alloc_bootmem_node__pgdat = (pgdat);	\
+	__alloc_bootmem_node(NODE_DATA(0), (x), SMP_CACHE_BYTES,	\
+						__pa(MAX_DMA_ADDRESS));	\
+})
+#define alloc_bootmem_pages_node(pgdat, x)				\
+({									\
+	struct pglist_data  __attribute__ ((unused))			\
+				*__alloc_bootmem_node__pgdat = (pgdat);	\
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE,		\
+						__pa(MAX_DMA_ADDRESS))	\
+})
+#define alloc_bootmem_low_pages_node(pgdat, x)				\
+({									\
+	struct pglist_data  __attribute__ ((unused))			\
+				*__alloc_bootmem_node__pgdat = (pgdat);	\
+	__alloc_bootmem_node(NODE_DATA(0), (x), PAGE_SIZE, 0);		\
+})
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
 
 #endif /* _ASM_MMZONE_H_ */
