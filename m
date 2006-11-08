Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754625AbWKHRrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbWKHRrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754623AbWKHRrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:47:16 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:23158 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754625AbWKHRrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:47:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=P4NDBQBLRAy/gniKGynD1q4rk4yIXlfvf/87ynP1SzXi+5V9h9DQpvw7AtRjkkpuZE4+OXNAVTqLNXehbpxSGPLcYcZDlm8+PF/0QtRR71ZQ+CSaDg9RmAb6WMKOlxDzCUB+wgRf32Y5v9owXc4qXMqcrFuJcomGGqB2u/xxbIQ=
References: <20061108174540.976625689@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 09 Nov 2006 02:45:45 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 4/7] fault-injection capability for alloc_pages()
Content-Disposition: inline; filename=fail_alloc_pages.patch
Message-ID: <4552181f.433fa8bd.2171.457e@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

This patch provides fault-injection capability for alloc_pages()

Boot option:

fail_page_alloc=<interval>,<probability>,<space>,<times>

	<interval> -- specifies the interval of failures.

	<probability> -- specifies how often it should fail in percent.

	<space> -- specifies the size of free space where memory can be
		   allocated safely in pages.

	<times> -- specifies how many times failures may happen at most.

Debugfs:

/debug/fail_page_alloc/interval
/debug/fail_page_alloc/probability
/debug/fail_page_alloc/specifies
/debug/fail_page_alloc/times
/debug/fail_page_alloc/ignore-gfp-highmem
/debug/fail_page_alloc/ignore-gfp-wait

Example:

	fail_page_alloc=10,100,0,-1

The page allocation (alloc_pages(), ...) fails once per 10 times.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 lib/Kconfig.debug |    7 ++++
 mm/page_alloc.c   |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

Index: 2.6-rc/lib/Kconfig.debug
===================================================================
--- 2.6-rc.orig/lib/Kconfig.debug
+++ 2.6-rc/lib/Kconfig.debug
@@ -423,6 +423,13 @@ config FAILSLAB
 	help
 	  This option provides fault-injection capabilitiy for kmalloc.
 
+config FAIL_PAGE_ALLOC
+	bool "Fault-injection capabilitiy for alloc_pages()"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capabilitiy for alloc_pages().
+
 config FAULT_INJECTION_DEBUG_FS
 	bool "Debugfs entries for fault-injection capabilities"
 	depends on FAULT_INJECTION && SYSFS
Index: 2.6-rc/mm/page_alloc.c
===================================================================
--- 2.6-rc.orig/mm/page_alloc.c
+++ 2.6-rc/mm/page_alloc.c
@@ -40,6 +40,7 @@
 #include <linux/sort.h>
 #include <linux/pfn.h>
 #include <linux/backing-dev.h>
+#include <linux/fault-inject.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -893,6 +894,89 @@ failed:
 #define ALLOC_HIGH		0x20 /* __GFP_HIGH set */
 #define ALLOC_CPUSET		0x40 /* check for correct cpuset */
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+
+static struct fail_page_alloc_attr {
+	struct fault_attr attr;
+
+	u32 ignore_gfp_highmem;
+	u32 ignore_gfp_wait;
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+	struct dentry *ignore_gfp_highmem_file;
+	struct dentry *ignore_gfp_wait_file;
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+} fail_page_alloc = {
+	.attr = FAULT_ATTR_INITIALIZER,
+};
+
+static int __init setup_fail_page_alloc(char *str)
+{
+	return setup_fault_attr(&fail_page_alloc.attr, str);
+}
+__setup("fail_page_alloc=", setup_fail_page_alloc);
+
+static int should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+{
+	if (gfp_mask & __GFP_NOFAIL)
+		return 0;
+	if (fail_page_alloc.ignore_gfp_highmem && (gfp_mask & __GFP_HIGHMEM))
+		return 0;
+	if (fail_page_alloc.ignore_gfp_wait && (gfp_mask & __GFP_WAIT))
+		return 0;
+
+	return should_fail(&fail_page_alloc.attr, 1 << order);
+}
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+static int __init fail_page_alloc_debugfs(void)
+{
+	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+	struct dentry *dir;
+	int err;
+
+	err = init_fault_attr_dentries(&fail_page_alloc.attr,
+				       "fail_page_alloc");
+	if (err)
+		return err;
+	dir = fail_page_alloc.attr.dentries.dir;
+
+	fail_page_alloc.ignore_gfp_wait_file =
+		debugfs_create_bool("ignore-gfp-wait", mode, dir,
+				      &fail_page_alloc.ignore_gfp_wait);
+
+	fail_page_alloc.ignore_gfp_highmem_file =
+		debugfs_create_bool("ignore-gfp-highmem", mode, dir,
+				      &fail_page_alloc.ignore_gfp_highmem);
+
+	if (!fail_page_alloc.ignore_gfp_wait_file ||
+			!fail_page_alloc.ignore_gfp_highmem_file) {
+		err = -ENOMEM;
+		debugfs_remove(fail_page_alloc.ignore_gfp_wait_file);
+		debugfs_remove(fail_page_alloc.ignore_gfp_highmem_file);
+		cleanup_fault_attr_dentries(&fail_page_alloc.attr);
+	}
+
+	return err;
+}
+
+late_initcall(fail_page_alloc_debugfs);
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+#else /* CONFIG_FAIL_PAGE_ALLOC */
+
+static inline int should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+{
+	return 0;
+}
+
+#endif /* CONFIG_FAIL_PAGE_ALLOC */
+
 /*
  * Return 1 if free pages are above 'mark'. This takes into account the order
  * of the allocation.
@@ -992,6 +1076,9 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
+	if (should_fail_alloc_page(gfp_mask, order))
+		return NULL;
+
 restart:
 	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 

--
