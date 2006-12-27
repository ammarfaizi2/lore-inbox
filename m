Return-Path: <linux-kernel-owner+w=401wt.eu-S1754708AbWL0Tgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbWL0Tgv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 14:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbWL0Tgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 14:36:51 -0500
Received: from homer.mvista.com ([63.81.120.158]:18659 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754708AbWL0Tgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 14:36:50 -0500
Message-Id: <20061227193550.324850000@mvista.com>
User-Agent: quilt/0.45-1
Date: Wed, 27 Dec 2006 11:35:50 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] update kmap_atomic on !HIGHMEM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got some scheduling while atomic on x86-64 , and since x86-64 doesn't seem
to have HIGHMEM there's no workaround for kmap_atomic() .

This patch adds the same as i386 HIGHMEM for !HIGHMEM.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 include/linux/highmem.h |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

Index: linux-2.6.19/include/linux/highmem.h
===================================================================
--- linux-2.6.19.orig/include/linux/highmem.h
+++ linux-2.6.19/include/linux/highmem.h
@@ -42,13 +42,25 @@ static inline void *kmap(struct page *pa
 
 #define kunmap(page) do { (void) (page); } while (0)
 
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * kmap and kmunmap are above, and they don't really do anything
+ * interesting.
+ */
+# define kmap_atomic(page, idx)		kmap(page)
+# define kmap_atomic_pfn(pfn, idx)	kmap(pfn_to_page(pfn))
+# define kunmap_atomic(kvaddr, idx)	kunmap(kvaddr)
+#else
 #define kmap_atomic(page, idx) \
 	({ pagefault_disable(); page_address(page); })
 #define kunmap_atomic(addr, idx)	do { pagefault_enable(); } while (0)
 #define kmap_atomic_pfn(pfn, idx)	kmap_atomic(pfn_to_page(pfn), (idx))
-#define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 #endif
 
+#define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
+
+#endif /* ARCH_HAS_KMAP */
+
 #endif /* CONFIG_HIGHMEM */
 
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
--
