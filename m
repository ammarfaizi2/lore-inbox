Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWHMKWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWHMKWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 06:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWHMKWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 06:22:24 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:5730 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750931AbWHMKWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 06:22:23 -0400
Date: Sun, 13 Aug 2006 18:22:19 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: okuji@enbug.org
Subject: [PATCH] failslab - failmalloc for slab allocator
Message-ID: <20060813102219.GA8784@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not intended for inclusion. But I could find
several interesting crashes.

The idea behind failslab is to demonstrate what really happens if
slab allocation fails. The idea of failslab is completely taken
from failmalloc (http://www.nongnu.org/failmalloc/).

boot option:

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

examples:

failslab=100,10,-1,0

slab allocation (kmalloc, kmem_cache_alloc,..) fails once per 10 times.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/failmalloc.h |   39 ++++++++++++++++++++++++++++++++
 lib/Kconfig.debug          |    6 +++++
 mm/Makefile                |    1 
 mm/failmalloc.c            |   54 +++++++++++++++++++++++++++++++++++++++++++++
 mm/slab.c                  |   19 +++++++++++++++
 5 files changed, 119 insertions(+)

Index: work-failmalloc/mm/failmalloc.c
===================================================================
--- /dev/null
+++ work-failmalloc/mm/failmalloc.c
@@ -0,0 +1,54 @@
+/* failmalloc - force to fail in allocating memory sometimes */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/random.h>
+#include <linux/failmalloc.h>
+
+int setup_failmalloc(struct failmalloc_data *failmalloc, char *str)
+{
+	struct failmalloc_data tmp;
+
+	/* "<probability>,<interval>,<times>,<space>" */
+	if (sscanf(str, "%d,%lu,%ld,%u", &tmp.failure_probability,
+		   &tmp.failure_interval, &tmp.max_failures,
+		   &tmp.max_space) < 4)
+		return 0;
+
+	*failmalloc = tmp;
+	return 1;
+}
+
+int should_fail(struct failmalloc_data *failmalloc, size_t size)
+{
+	if (failmalloc->max_failures == 0)
+		return 0;
+
+	if (failmalloc->max_space) {
+		if (failmalloc->current_space < failmalloc->max_space - size) {
+			failmalloc->current_space += size;
+			return 0;
+		}
+	}
+
+	if (failmalloc->failure_interval > 1) {
+		failmalloc->count++;
+		if (failmalloc->count < failmalloc->failure_interval)
+			return 0;
+
+		failmalloc->count = 0;
+	}
+
+	if (failmalloc->failure_probability == 100 ||
+	    INT_MAX / 100 * failmalloc->failure_probability > get_random_int())
+		goto fail;
+
+	return 0;
+
+fail:
+
+	if (failmalloc->max_failures > 0)
+		failmalloc->max_failures--;
+
+	return 1;
+}
Index: work-failmalloc/lib/Kconfig.debug
===================================================================
--- work-failmalloc.orig/lib/Kconfig.debug
+++ work-failmalloc/lib/Kconfig.debug
@@ -368,3 +368,9 @@ config RCU_TORTURE_TEST
 	  at boot time (you probably don't).
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
+
+config FAILMALLOC
+	bool "failmalloc"
+	depends on DEBUG_KERNEL
+	help
+	  This option enables failmalloc.
Index: work-failmalloc/mm/Makefile
===================================================================
--- work-failmalloc.orig/mm/Makefile
+++ work-failmalloc/mm/Makefile
@@ -23,4 +23,5 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_FAILMALLOC) += failmalloc.o
 
Index: work-failmalloc/include/linux/failmalloc.h
===================================================================
--- /dev/null
+++ work-failmalloc/include/linux/failmalloc.h
@@ -0,0 +1,39 @@
+#ifndef _LINUX_FAILMALLOC_H
+#define	_LINUX_FAILMALLOC_H
+
+#ifdef CONFIG_FAILMALLOC
+
+struct failmalloc_data {
+
+	/* how often it should fail, in percent. */
+	int failure_probability;
+
+	/* the interval of failures. */
+	unsigned long failure_interval;
+
+	/*
+	 * how many times failures may happen at most.
+	 * negative value means unlimited.
+	 */
+	long max_failures;
+
+	/*
+	 * the size of free space where memory can be allocated safely in bytes.
+	 * A value of '0' means infinity.
+	 */
+	size_t max_space;
+
+	unsigned long count;
+	size_t current_space;
+};
+
+int should_fail(struct failmalloc_data *failmalloc, size_t size);
+int setup_failmalloc(struct failmalloc_data *data, char *str);
+
+#else
+
+#define should_fail(failmalloc, size)	(0)
+
+#endif /* CONFIG_FAILMALLOC */
+
+#endif /* _LINUX_FAILMALLOC_H */
Index: work-failmalloc/mm/slab.c
===================================================================
--- work-failmalloc.orig/mm/slab.c
+++ work-failmalloc/mm/slab.c
@@ -108,6 +108,7 @@
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
 #include	<linux/rtmutex.h>
+#include	<linux/failmalloc.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -2963,11 +2964,29 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
+#ifdef CONFIG_FAILMALLOC
+
+struct failmalloc_data failslab;
+
+static int __init setup_failslab(char *str)
+{
+	return setup_failmalloc(&failslab, str);
+}
+
+__setup("failslab=", setup_failslab);
+
+#endif
+
 static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
 
+	/* This is not SMP safe, but that's OK. */
+	if (!(flags & __GFP_NOFAIL) && cachep != &cache_cache &&
+			should_fail(&failslab, obj_size(cachep)))
+		return NULL;
+
 #ifdef CONFIG_NUMA
 	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
 		objp = alternate_node_alloc(cachep, flags);
