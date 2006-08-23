Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWHWLfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWHWLfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWHWLfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:35:00 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:61016 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932398AbWHWLe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:34:58 -0400
Message-Id: <20060823113317.025510267@localhost.localdomain>
References: <20060823113243.210352005@localhost.localdomain>
Date: Wed, 23 Aug 2006 20:32:45 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, okuji@enbug.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 2/5] fail-injection capability for kmalloc.
Content-Disposition: inline; filename=failslab.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides fail-injection capability for kmalloc.

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
 mm/slab.c                   |   20 ++++++++++++++++++++
 3 files changed, 31 insertions(+)

Index: work-failmalloc/mm/slab.c
===================================================================
--- work-failmalloc.orig/mm/slab.c
+++ work-failmalloc/mm/slab.c
@@ -108,6 +108,7 @@
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
 #include	<linux/rtmutex.h>
+#include	<linux/should_fail.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -2963,11 +2964,30 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
+#ifdef CONFIG_FAILSLAB
+
+static DEFINE_SHOULD_FAIL(failslab_data);
+
+static int __init setup_failslab(char *str)
+{
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
Index: work-failmalloc/lib/Kconfig.debug
===================================================================
--- work-failmalloc.orig/lib/Kconfig.debug
+++ work-failmalloc/lib/Kconfig.debug
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
Index: work-failmalloc/include/linux/should_fail.h
===================================================================
--- work-failmalloc.orig/include/linux/should_fail.h
+++ work-failmalloc/include/linux/should_fail.h
@@ -35,6 +35,10 @@ struct should_fail_data {
 int should_fail(struct should_fail_data *data, unsigned long size);
 int setup_should_fail(struct should_fail_data *data, char *str);
 
+#ifdef CONFIG_FAILSLAB
+extern struct should_fail_data *failslab;
+#endif
+
 #else
 
 #define should_fail(data, size)	(0)

--
