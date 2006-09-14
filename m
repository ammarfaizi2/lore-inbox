Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWINKUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWINKUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWINKUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:20:37 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:9548 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750767AbWINKUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:20:34 -0400
Message-Id: <20060914102031.313830702@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
Date: Thu, 14 Sep 2006 18:20:15 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 3/8] fault-injection capability for kmalloc
Content-Disposition: inline; filename=failslab.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides fault-injection capability for kmalloc.

Boot option:

failslab=<interval>,<probability>,<space>,<times>

	<interval> -- specifies the interval of failures.

	<probability> -- specifies how often it should fail in percent.

	<space> -- specifies the size of free space where memory can be
		   allocated safely in bytes.

	<times> -- specifies how many times failures may happen at most.

Example:

	failslab=10,100,0,-1

slab allocation (kmalloc(), kmem_cache_alloc(),..) fails once per 10 times.

Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/fault-inject.h |    4 ++++
 lib/Kconfig.debug            |    7 +++++++
 mm/slab.c                    |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

Index: work-shouldfail/mm/slab.c
===================================================================
--- work-shouldfail.orig/mm/slab.c
+++ work-shouldfail/mm/slab.c
@@ -108,6 +108,7 @@
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
 #include	<linux/rtmutex.h>
+#include	<linux/fault-inject.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -2963,11 +2964,44 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
+#ifdef CONFIG_FAILSLAB
+
+static DEFINE_FAULT_ATTR(failslab_attr);
+
+static int __init setup_failslab(char *str)
+{
+	should_fail_srandom(jiffies);
+	return setup_fault_attr(&failslab_attr, str);
+}
+__setup("failslab=", setup_failslab);
+
+struct fault_attr *failslab = &failslab_attr;
+EXPORT_SYMBOL_GPL(failslab);
+
+static int should_failslab(struct kmem_cache *cachep, gfp_t flags)
+{
+	if ((flags & __GFP_NOFAIL) || cachep == &cache_cache)
+		return 0;
+	return should_fail(failslab, obj_size(cachep));
+}
+
+#else
+
+static inline int should_failslab(struct kmem_cache *cachep, gfp_t flags)
+{
+	return 0;
+}
+
+#endif
+
 static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
 
+	if (should_failslab(cachep, flags))
+		return NULL;
+
 #ifdef CONFIG_NUMA
 	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
 		objp = alternate_node_alloc(cachep, flags);
Index: work-shouldfail/lib/Kconfig.debug
===================================================================
--- work-shouldfail.orig/lib/Kconfig.debug
+++ work-shouldfail/lib/Kconfig.debug
@@ -372,3 +372,10 @@ config RCU_TORTURE_TEST
 config FAULT_INJECTION
 	bool
 
+config FAILSLAB
+	bool "fault-injection capabilitiy for kmalloc"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capabilitiy for kmalloc.
+
Index: work-shouldfail/include/linux/fault-inject.h
===================================================================
--- work-shouldfail.orig/include/linux/fault-inject.h
+++ work-shouldfail/include/linux/fault-inject.h
@@ -36,6 +36,10 @@ int setup_fault_attr(struct fault_attr *
 void should_fail_srandom(unsigned long entropy);
 int should_fail(struct fault_attr *attr, ssize_t size);
 
+#ifdef CONFIG_FAILSLAB
+extern struct fault_attr *failslab;
+#endif
+
 #endif /* CONFIG_FAULT_INJECTION */
 
 #endif /* _LINUX_FAULT_INJECT_H */

--
