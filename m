Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWA2HlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWA2HlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWA2HlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:41:13 -0500
Received: from fmr15.intel.com ([192.55.52.69]:27092 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751112AbWA2Hh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:37:28 -0500
X-RoutingDetailMGA: None determined and $ACCEPTED applied by InboundMail on OuterRail
X-IronPort-AV: i="4.01,231,1136188800"; 
   d="scan'208"; a="5623544:sNHT141098013"
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.01,231,1136188800"; 
   d="scan'208"; a="19591323:sNHT16335326"
Subject: [patch 1/9] mempool - Add page allocator
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: sri@us.ibm.com, andrea@suse.de, pavel@suse.cz, linux-mm@kvack.org
References: <20060125161321.647368000@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 25 Jan 2006 11:39:55 -0800
Message-Id: <1138217995.2092.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=0.93.5
X-Loop: owner-majordomo@kvack.org
X-OriginalArrivalTime: 29 Jan 2006 02:05:39.0714 (UTC) FILETIME=[807F4E20:01C62478]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (critical_mempools)
Add another allocator to the common mempool code: a simple page allocator

This will be used by the next patch in the series to replace duplicate
mempool-backed page allocators in 2 places in the kernel.  It is also very
likely that there will be more users in the future.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

 include/linux/mempool.h |    6 ++++++
 mm/mempool.c            |   17 +++++++++++++++++
 2 files changed, 23 insertions(+)

Index: linux-2.6.16-rc1+critical_mempools/mm/mempool.c
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/mm/mempool.c
+++ linux-2.6.16-rc1+critical_mempools/mm/mempool.c
@@ -289,3 +289,20 @@ void mempool_free_slab(void *element, vo
 	kmem_cache_free(mem, element);
 }
 EXPORT_SYMBOL(mempool_free_slab);
+
+/*
+ * A simple mempool-backed page allocator
+ */
+void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data)
+{
+	int order = (int)pool_data;
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL(mempool_alloc_pages);
+
+void mempool_free_pages(void *element, void *pool_data)
+{
+	int order = (int)pool_data;
+	__free_pages(element, order);
+}
+EXPORT_SYMBOL(mempool_free_pages);
Index: linux-2.6.16-rc1+critical_mempools/include/linux/mempool.h
===================================================================
--- linux-2.6.16-rc1+critical_mempools.orig/include/linux/mempool.h
+++ linux-2.6.16-rc1+critical_mempools/include/linux/mempool.h
@@ -38,4 +38,10 @@ extern void mempool_free(void *element, 
 void *mempool_alloc_slab(gfp_t gfp_mask, void *pool_data);
 void mempool_free_slab(void *element, void *pool_data);
 
+/*
+ * A mempool_alloc_t and mempool_free_t for a simple page allocator
+ */
+void *mempool_alloc_pages(gfp_t gfp_mask, void *pool_data);
+void mempool_free_pages(void *element, void *pool_data);
+
 #endif /* _LINUX_MEMPOOL_H */

--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
