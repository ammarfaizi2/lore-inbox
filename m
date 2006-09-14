Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWINKWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWINKWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWINKWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:22:04 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:13388 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750753AbWINKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:20:35 -0400
Message-Id: <20060914102031.649791311@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
Date: Thu, 14 Sep 2006 18:20:16 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 4/8] fault-injection capability for alloc_pages()
Content-Disposition: inline; filename=fail_alloc_pages.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides fault-injection capability for alloc_pages()

Boot option:

fail_page_alloc=<interval>,<probability>,<space>,<times>

	<interval> -- specifies the interval of failures.

	<probability> -- specifies how often it should fail in percent.

	<space> -- specifies the size of free space where memory can be
		   allocated safely in pages.

	<times> -- specifies how many times failures may happen at most.

Example:

	fail_page_alloc=10,100,0,-1

The page allocation (alloc_pages(), ...) fails once per 10 times.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/fault-inject.h |    3 +++
 lib/Kconfig.debug            |    7 +++++++
 mm/page_alloc.c              |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

Index: work-shouldfail/lib/Kconfig.debug
===================================================================
--- work-shouldfail.orig/lib/Kconfig.debug
+++ work-shouldfail/lib/Kconfig.debug
@@ -379,3 +379,10 @@ config FAILSLAB
 	help
 	  This option provides fault-injection capabilitiy for kmalloc.
 
+config FAIL_PAGE_ALLOC
+	bool "fault-injection capabilitiy for alloc_pages()"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capabilitiy for alloc_pages().
+
Index: work-shouldfail/mm/page_alloc.c
===================================================================
--- work-shouldfail.orig/mm/page_alloc.c
+++ work-shouldfail/mm/page_alloc.c
@@ -37,6 +37,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
 #include <linux/stop_machine.h>
+#include <linux/fault-inject.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -903,6 +904,37 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	return page;
 }
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+
+static DEFINE_FAULT_ATTR(fail_page_alloc_attr);
+
+static int __init setup_fail_page_alloc(char *str)
+{
+	should_fail_srandom(jiffies);
+	return setup_fault_attr(&fail_page_alloc_attr, str);
+}
+__setup("fail_page_alloc=", setup_fail_page_alloc);
+
+struct fault_attr *fail_page_alloc = &fail_page_alloc_attr;
+EXPORT_SYMBOL_GPL(fail_page_alloc);
+
+static int should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+{
+	if (gfp_mask & __GFP_NOFAIL)
+		return 0;
+
+	return should_fail(fail_page_alloc, 1 << order);
+}
+
+#else
+
+static inline int should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+{
+	return 0;
+}
+
+#endif
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
@@ -921,6 +953,9 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
+	if (should_fail_alloc_page(gfp_mask, order))
+		return NULL;
+
 restart:
 	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
Index: work-shouldfail/include/linux/fault-inject.h
===================================================================
--- work-shouldfail.orig/include/linux/fault-inject.h
+++ work-shouldfail/include/linux/fault-inject.h
@@ -39,6 +39,9 @@ int should_fail(struct fault_attr *attr,
 #ifdef CONFIG_FAILSLAB
 extern struct fault_attr *failslab;
 #endif
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+extern struct fault_attr *fail_page_alloc;
+#endif
 
 #endif /* CONFIG_FAULT_INJECTION */
 

--
