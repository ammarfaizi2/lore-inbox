Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422801AbWJLHpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWJLHpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWJLHnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:43:47 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:12718 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422797AbWJLHnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:43:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:references:user-agent:date:from:to:cc:subject:content-disposition:message-id;
        b=O66Gqkh0oNTCIoA+ukG2a+We0nPktazD7tjRlmu4Y9crl0f/fhTyJEC2aMhm2RXD/9u6iv2Q+be8zi0nj5km7M5sOLEyLiMB3/u93O59E+7ny6r/ztuWc6Ue+19tVA9lzTBRNo0iQ3iI109RYABKWQflvmALkGsjFIhxHhsA5dg=
References: <20061012074305.047696736@gmail.com>>
User-Agent: quilt/0.45-1
Date: Thu, 12 Oct 2006 16:43:08 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [patch 3/7] fault-injection capability for kmalloc
Content-Disposition: inline; filename=failslab.patch
Message-ID: <452df222.0804022e.60ae.67a6@mx.google.com>
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

Example:

	failslab=10,100,0,-1

slab allocation (kmalloc(), kmem_cache_alloc(),..) fails once per 10 times.

Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 lib/Kconfig.debug |    7 +++++++
 mm/slab.c         |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

Index: work-fault-inject/mm/slab.c
===================================================================
--- work-fault-inject.orig/mm/slab.c
+++ work-fault-inject/mm/slab.c
@@ -107,6 +107,7 @@
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
 #include	<linux/rtmutex.h>
+#include	<linux/fault-inject.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -3075,12 +3076,54 @@ static void *cache_alloc_debugcheck_afte
 #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
 #endif
 
+#ifdef CONFIG_FAILSLAB
+
+static DEFINE_FAULT_ATTR(failslab);
+
+static int __init setup_failslab(char *str)
+{
+	should_fail_srandom(jiffies);
+
+	return setup_fault_attr(&failslab, str);
+}
+__setup("failslab=", setup_failslab);
+
+static int should_failslab(struct kmem_cache *cachep, gfp_t flags)
+{
+	if ((flags & __GFP_NOFAIL) || cachep == &cache_cache)
+		return 0;
+
+	return should_fail(&failslab, obj_size(cachep));
+}
+
+static int __init failslab_debugfs(void)
+{
+	should_fail_srandom(jiffies);
+
+	return init_fault_attr_entries(&failslab, "failslab");
+}
+
+late_initcall(failslab_debugfs);
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
Index: work-fault-inject/lib/Kconfig.debug
===================================================================
--- work-fault-inject.orig/lib/Kconfig.debug
+++ work-fault-inject/lib/Kconfig.debug
@@ -473,6 +473,13 @@ config LKDTM
 config FAULT_INJECTION
 	bool
 
+config FAILSLAB
+	bool "fault-injection capabilitiy for kmalloc"
+	depends on DEBUG_KERNEL
+	select FAULT_INJECTION
+	help
+	  This option provides fault-injection capabilitiy for kmalloc.
+
 config FAULT_INJECTION_DEBUG_FS
 	bool "debugfs entries for fault-injection capabilities"
 	depends on FAULT_INJECTION && SYSFS

--
