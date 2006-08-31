Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWHaKJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWHaKJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWHaKIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:08:54 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:9492 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751431AbWHaKIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:08:46 -0400
Message-Id: <20060831100820.467385110@localhost.localdomain>
References: <20060831100756.866727476@localhost.localdomain>
Date: Thu, 31 Aug 2006 19:07:58 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, okuji@enbug.org,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 2/6] fault-injection capability for kmalloc.
Content-Disposition: inline; filename=failslab.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides fault-injection capability for kmalloc.

Boot option:

	failslab=<probability>,<interval>,<times>,<space>

	<probability>

		specifies how often it should fail in percent.

	<interval>

		specifies the interval of failures.

	<times>

		specifies how many times failures may happen at most.

	<space>

		specifies the size of free space where memory can be allocated
		safely in bytes.

Example:

	failslab=100,10,-1,0

slab allocation (kmalloc, kmem_cache_alloc,..) fails once per 10 times.

Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/should_fail.h |    4 ++++
 lib/Kconfig.debug           |    7 +++++++
 mm/slab.c                   |   21 +++++++++++++++++++++
 3 files changed, 32 insertions(+)

Index: work-shouldfail/mm/slab.c
===================================================================
--- work-shouldfail.orig/mm/slab.c
+++ work-shouldfail/mm/slab.c
@@ -108,6 +108,7 @@
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
 #include	<linux/rtmutex.h>
+#include	<linux/should_fail.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -2963,11 +2964,31 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
+#ifdef CONFIG_FAILSLAB
+
+static DEFINE_SHOULD_FAIL(failslab_data);
+
+static int __init setup_failslab(char *str)
+{
+	should_fail_srandom(jiffies);
+	return setup_should_fail(&failslab_data, str);
+}
+__setup("failslab=", setup_failslab);
+
+struct should_fail_data *failslab = &failslab_data;
+EXPORT_SYMBOL_GPL(failslab);
+
+#endif
+
 static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
 
+	if (!(flags & __GFP_NOFAIL) && cachep != &cache_cache &&
+	    should_fail(failslab, obj_size(cachep)))
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
 config SHOULD_FAIL
 	bool
 
+config FAILSLAB
+	bool "fault-injection capabilitiy for kmalloc"
+	depends on DEBUG_KERNEL
+	select SHOULD_FAIL
+	help
+	  This option provides fault-injection capabilitiy for kmalloc.
+
Index: work-shouldfail/include/linux/should_fail.h
===================================================================
--- work-shouldfail.orig/include/linux/should_fail.h
+++ work-shouldfail/include/linux/should_fail.h
@@ -36,6 +36,10 @@ int setup_should_fail(struct should_fail
 void should_fail_srandom(unsigned long entropy);
 int should_fail(struct should_fail_data *data, ssize_t size);
 
+#ifdef CONFIG_FAILSLAB
+extern struct should_fail_data *failslab;
+#endif
+
 #else
 
 #define should_fail(data, size)	(0)

--
