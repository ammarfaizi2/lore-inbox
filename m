Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422798AbWJLHpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWJLHpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWJLHnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:43:49 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12718 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422794AbWJLHni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:43:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=g9JiIBOQq0KL4oGf6ahbbGgOdZug2yPgBka+ymYxSYg/W9shliQvgUnLjKeDCL8rnPsnULwlg0Mh0t4b4QnpR2n6P5ubkU0h2AFk1KQ9BfZHsCBOjFAhxSW5AvarXF46VAoKsqh/eiAfMnLOEuLNhs3K8OUk5leKpSaggMD/Moc=
References: <20061012074305.047696736@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 12 Oct 2006 16:43:09 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 4/7] fault-injection capability for alloc_pages()
Content-Disposition: inline; filename=fail_alloc_pages.patch
Message-ID: <452df22a.6ff794a4.60eb.4092@mx.google.com>
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

Example:

	fail_page_alloc=10,100,0,-1

The page allocation (alloc_pages(), ...) fails once per 10 times.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 lib/Kconfig.debug |    7 +++++++
 mm/page_alloc.c   |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

Index: work-fault-inject/lib/Kconfig.debug
===================================================================
--- work-fault-inject.orig/lib/Kconfig.debug
+++ work-fault-inject/lib/Kconfig.debug
@@ -480,6 +480,13 @@ config FAILSLAB
 	help
 	  This option provides fault-injection capabilitiy for kmalloc.
 
+config FAIL_PAGE_ALLOC
+	bool "fault-injection capabilitiy for alloc_pages()"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capabilitiy for alloc_pages().
+
 config FAULT_INJECTION_DEBUG_FS
 	bool "debugfs entries for fault-injection capabilities"
 	depends on FAULT_INJECTION && SYSFS
Index: work-fault-inject/mm/page_alloc.c
===================================================================
--- work-fault-inject.orig/mm/page_alloc.c
+++ work-fault-inject/mm/page_alloc.c
@@ -39,6 +39,7 @@
 #include <linux/stop_machine.h>
 #include <linux/sort.h>
 #include <linux/pfn.h>
+#include <linux/fault-inject.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -906,6 +907,44 @@ failed:
 #define ALLOC_HIGH		0x20 /* __GFP_HIGH set */
 #define ALLOC_CPUSET		0x40 /* check for correct cpuset */
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+
+static DEFINE_FAULT_ATTR(fail_page_alloc);
+
+static int __init setup_fail_page_alloc(char *str)
+{
+	should_fail_srandom(jiffies);
+
+	return setup_fault_attr(&fail_page_alloc, str);
+}
+__setup("fail_page_alloc=", setup_fail_page_alloc);
+
+static int should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+{
+	if (gfp_mask & __GFP_NOFAIL)
+		return 0;
+
+	return should_fail(&fail_page_alloc, 1 << order);
+}
+
+static int __init fail_page_alloc_debugfs(void)
+{
+	should_fail_srandom(jiffies);
+
+	return init_fault_attr_entries(&fail_page_alloc, "fail_page_alloc");
+}
+
+late_initcall(fail_page_alloc_debugfs);
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
@@ -1058,6 +1097,9 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
+	if (should_fail_alloc_page(gfp_mask, order))
+		return NULL;
+
 restart:
 	page = get_page_from_freelist(gfp_mask|__GFP_HARDWALL, order,
 				zonelist, ALLOC_WMARK_LOW|ALLOC_CPUSET);

--
