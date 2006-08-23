Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWHWLe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWHWLe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWHWLe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:34:59 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:64088 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932401AbWHWLe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:34:58 -0400
Message-Id: <20060823113317.402923034@localhost.localdomain>
References: <20060823113243.210352005@localhost.localdomain>
Date: Wed, 23 Aug 2006 20:32:46 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, okuji@enbug.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 3/5] fail-injection capability for alloc_pages()
Content-Disposition: inline; filename=fail_alloc_pages.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides fail-injection capability for alloc_pages()

boot option:

	fail_page_alloc=<probability>,<interval>,<times>,<space>

	<probability>

		specifies how often it should fail in percent.

	<interval>

		specifies the interval of failures.

	<times>

		specifies how many times failures may happen at most.

	<space>

		specifies the size of free space where memory can be allocated
		safely in pages.

Example:

	fail_page_alloc=100,10,-1,0

page allocation fails once per 10 times.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/should_fail.h |    4 ++++
 lib/Kconfig.debug           |    7 +++++++
 mm/page_alloc.c             |   20 ++++++++++++++++++++
 3 files changed, 31 insertions(+)

Index: work-failmalloc/lib/Kconfig.debug
===================================================================
--- work-failmalloc.orig/lib/Kconfig.debug
+++ work-failmalloc/lib/Kconfig.debug
@@ -379,3 +379,10 @@ config FAILSLAB
 	help
 	  This option provides fault-injection capabilitiy for kmalloc.
 
+config FAIL_PAGE_ALLOC
+	bool "fault-injection capabilitiy for alloc_pages()"
+	depends on DEBUG_KERNEL
+	select SHOULD_FAIL
+	help
+	  This option provides fault-injection capabilitiy for alloc_pages().
+
Index: work-failmalloc/mm/page_alloc.c
===================================================================
--- work-failmalloc.orig/mm/page_alloc.c
+++ work-failmalloc/mm/page_alloc.c
@@ -37,6 +37,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mempolicy.h>
 #include <linux/stop_machine.h>
+#include <linux/should_fail.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -903,6 +904,21 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	return page;
 }
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+
+static DEFINE_SHOULD_FAIL(fail_page_alloc_data);
+
+static int __init setup_fail_page_alloc(char *str)
+{
+	return setup_should_fail(&fail_page_alloc_data, str);
+}
+__setup("fail_page_alloc=", setup_fail_page_alloc);
+
+struct should_fail_data *fail_page_alloc = &fail_page_alloc_data;
+EXPORT_SYMBOL_GPL(fail_page_alloc);
+
+#endif
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  */
@@ -921,6 +937,10 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
+	if (!(gfp_mask & __GFP_NOFAIL) &&
+	    should_fail(fail_page_alloc, 1 << order))
+		return NULL;
+
 restart:
 	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
Index: work-failmalloc/include/linux/should_fail.h
===================================================================
--- work-failmalloc.orig/include/linux/should_fail.h
+++ work-failmalloc/include/linux/should_fail.h
@@ -39,6 +39,10 @@ int setup_should_fail(struct should_fail
 extern struct should_fail_data *failslab;
 #endif
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+extern struct should_fail_data *fail_page_alloc;
+#endif
+
 #else
 
 #define should_fail(data, size)	(0)

--
