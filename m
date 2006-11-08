Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161383AbWKHRrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbWKHRrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbWKHRrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:47:05 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:23158 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1754623AbWKHRrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:47:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=O7Vt2hycas34dDIde6GVjVxk9chYDsMw9cOfPuRworN+61aIy4SxTys0M1zPqyBVjdcZWRMcdI12MQVH87yWcQODHYQxYaAGpg7Ohb8ThHCGcEczwzFoDS7GVFgZ07bX30VmxJKZWJGiR8hKfy6LTcEMiZdXPoyUmWjnQbGVc6M=
References: <20061108174540.976625689@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 09 Nov 2006 02:45:44 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [patch 3/7] fault-injection capability for kmalloc
Content-Disposition: inline; filename=failslab.patch
Message-ID: <45521813.412c5676.7a02.7181@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

This patch provides fault-injection capability for kmalloc.

Boot option:

failslab=<interval>,<probability>,<space>,<times>

	<interval> -- specifies the interval of failures.

	<probability> -- specifies how often it should fail in percent.

	<space> -- specifies the size of free space where memory can be
		   allocated safely in bytes.

	<times> -- specifies how many times failures may happen at most.

Debugfs:

/debug/failslab/interval
/debug/failslab/probability
/debug/failslab/specifies
/debug/failslab/times
/debug/failslab/ignore-gfp-highmem
/debug/failslab/ignore-gfp-wait

Example:

	failslab=10,100,0,-1

slab allocation (kmalloc(), kmem_cache_alloc(),..) fails once per 10 times.

Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 lib/Kconfig.debug |    7 ++++
 mm/slab.c         |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

Index: 2.6-rc/mm/slab.c
===================================================================
--- 2.6-rc.orig/mm/slab.c
+++ 2.6-rc/mm/slab.c
@@ -107,6 +107,7 @@
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
 #include	<linux/rtmutex.h>
+#include	<linux/fault-inject.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -3069,12 +3070,101 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
+#ifdef CONFIG_FAILSLAB
+
+static struct failslab_attr {
+
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
+} failslab = {
+	.attr = FAULT_ATTR_INITIALIZER,
+};
+
+static int __init setup_failslab(char *str)
+{
+	return setup_fault_attr(&failslab.attr, str);
+}
+__setup("failslab=", setup_failslab);
+
+static int should_failslab(struct kmem_cache *cachep, gfp_t flags)
+{
+	if (cachep == &cache_cache)
+		return 0;
+	if (flags & __GFP_NOFAIL)
+		return 0;
+	if (failslab.ignore_gfp_highmem && (flags & __GFP_HIGHMEM))
+		return 0;
+	if (failslab.ignore_gfp_wait && (flags & __GFP_WAIT))
+		return 0;
+
+	return should_fail(&failslab.attr, obj_size(cachep));
+}
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+static int __init failslab_debugfs(void)
+{
+	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
+	struct dentry *dir;
+	int err;
+
+       	err = init_fault_attr_dentries(&failslab.attr, "failslab");
+	if (err)
+		return err;
+	dir = failslab.attr.dentries.dir;
+
+	failslab.ignore_gfp_wait_file =
+		debugfs_create_bool("ignore-gfp-wait", mode, dir,
+				      &failslab.ignore_gfp_wait);
+
+	failslab.ignore_gfp_highmem_file =
+		debugfs_create_bool("ignore-gfp-highmem", mode, dir,
+				      &failslab.ignore_gfp_highmem);
+
+	if (!failslab.ignore_gfp_wait_file ||
+			!failslab.ignore_gfp_highmem_file) {
+		err = -ENOMEM;
+		debugfs_remove(failslab.ignore_gfp_wait_file);
+		debugfs_remove(failslab.ignore_gfp_highmem_file);
+		cleanup_fault_attr_dentries(&failslab.attr);
+	}
+
+	return err;
+}
+
+late_initcall(failslab_debugfs);
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
+
+#else /* CONFIG_FAILSLAB */
+
+static inline int should_failslab(struct kmem_cache *cachep, gfp_t flags)
+{
+	return 0;
+}
+
+#endif /* CONFIG_FAILSLAB */
+
 static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *objp;
 	struct array_cache *ac;
 
 	check_irq_off();
+
+	if (should_failslab(cachep, flags))
+		return NULL;
+
 	ac = cpu_cache_get(cachep);
 	if (likely(ac->avail)) {
 		STATS_INC_ALLOCHIT(cachep);
Index: 2.6-rc/lib/Kconfig.debug
===================================================================
--- 2.6-rc.orig/lib/Kconfig.debug
+++ 2.6-rc/lib/Kconfig.debug
@@ -416,6 +416,13 @@ config LKDTM
 config FAULT_INJECTION
 	bool
 
+config FAILSLAB
+	bool "Fault-injection capabilitiy for kmalloc"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capabilitiy for kmalloc.
+
 config FAULT_INJECTION_DEBUG_FS
 	bool "Debugfs entries for fault-injection capabilities"
 	depends on FAULT_INJECTION && SYSFS

--
