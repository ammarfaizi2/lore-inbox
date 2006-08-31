Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWHaKIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWHaKIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWHaKIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:08:46 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:20 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751418AbWHaKIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:08:45 -0400
Message-Id: <20060831100820.697247381@localhost.localdomain>
References: <20060831100756.866727476@localhost.localdomain>
Date: Thu, 31 Aug 2006 19:07:59 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, okuji@enbug.org,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 3/6] fault-injection capability for alloc_pages()
Content-Disposition: inline; filename=fail_alloc_pages.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides fault-injection capability for alloc_pages()

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
 mm/page_alloc.c             |   21 +++++++++++++++++++++
 3 files changed, 32 insertions(+)

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
+	select SHOULD_FAIL
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
+#include <linux/should_fail.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -903,6 +904,22 @@ get_page_from_freelist(gfp_t gfp_mask, u
 	return page;
 }
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+
+static DEFINE_SHOULD_FAIL(fail_page_alloc_data);
+
+static int __init setup_fail_page_alloc(char *str)
+{
+	should_fail_srandom(jiffies);
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
@@ -921,6 +938,10 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
+	if (!(gfp_mask & __GFP_NOFAIL) &&
+	    should_fail(fail_page_alloc, 1 << order))
+		return NULL;
+
 restart:
 	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
Index: work-shouldfail/include/linux/should_fail.h
===================================================================
--- work-shouldfail.orig/include/linux/should_fail.h
+++ work-shouldfail/include/linux/should_fail.h
@@ -40,6 +40,10 @@ int should_fail(struct should_fail_data 
 extern struct should_fail_data *failslab;
 #endif
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+extern struct should_fail_data *fail_page_alloc;
+#endif
+
 #else
 
 #define should_fail(data, size)	(0)

--
