Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUFEBoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUFEBoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 21:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUFEBoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 21:44:14 -0400
Received: from cantor.suse.de ([195.135.220.2]:34699 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264492AbUFEBoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 21:44:01 -0400
Date: Sat, 5 Jun 2004 03:43:56 +0200
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [PATCH] Use numa policy API for boot time policy
Message-Id: <20040605034356.1037d299.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Suggested by Manfred Spraul.

__get_free_pages had a hack to do node interleaving allocation at boot time.
This patch sets an interleave process policy using the NUMA API for init
and the idle threads instead. Before entering the user space init the policy
is reset to default again. Result is the same.

Advantage is less code and removing of a check from a fast path.

Removes more code than it adds.

I verified that the memory distribution after boot is roughly the same.

diff -u linux-2.6.7rc2-work/include/linux/mempolicy.h-o linux-2.6.7rc2-work/include/linux/mempolicy.h
--- linux-2.6.7rc2-work/include/linux/mempolicy.h-o	2004-05-31 23:22:36.000000000 +0200
+++ linux-2.6.7rc2-work/include/linux/mempolicy.h	2004-06-05 00:40:54.000000000 +0200
@@ -153,6 +153,9 @@
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    unsigned long idx);
 
+extern void numa_default_policy(void);
+extern void numa_policy_init(void);
+
 #else
 
 struct mempolicy {};
@@ -215,6 +218,14 @@
 #define vma_policy(vma) NULL
 #define vma_set_policy(vma, pol) do {} while(0)
 
+static inline void numa_policy_init(void)
+{
+}
+
+static inline void numa_default_policy(void)
+{
+}
+
 #endif /* CONFIG_NUMA */
 #endif /* __KERNEL__ */
 
diff -u linux-2.6.7rc2-work/mm/page_alloc.c-o linux-2.6.7rc2-work/mm/page_alloc.c
--- linux-2.6.7rc2-work/mm/page_alloc.c-o	2004-05-31 23:22:37.000000000 +0200
+++ linux-2.6.7rc2-work/mm/page_alloc.c	2004-05-31 23:35:32.000000000 +0200
@@ -732,53 +732,12 @@
 
 EXPORT_SYMBOL(__alloc_pages);
 
-#ifdef CONFIG_NUMA
-/* Early boot: Everything is done by one cpu, but the data structures will be
- * used by all cpus - spread them on all nodes.
- */
-static __init unsigned long get_boot_pages(unsigned int gfp_mask, unsigned int order)
-{
-static int nodenr;
-	int i = nodenr;
-	struct page *page;
-
-	for (;;) {
-		if (i > nodenr + numnodes)
-			return 0;
-		if (node_present_pages(i%numnodes)) {
-			struct zone **z;
-			/* The node contains memory. Check that there is
-			 * memory in the intended zonelist.
-			 */
-			z = NODE_DATA(i%numnodes)->node_zonelists[gfp_mask & GFP_ZONEMASK].zones;
-			while (*z) {
-				if ( (*z)->free_pages > (1UL<<order))
-					goto found_node;
-				z++;
-			}
-		}
-		i++;
-	}
-found_node:
-	nodenr = i+1;
-	page = alloc_pages_node(i%numnodes, gfp_mask, order);
-	if (!page)
-		return 0;
-	return (unsigned long) page_address(page);
-}
-#endif
-
 /*
  * Common helper functions.
  */
 fastcall unsigned long __get_free_pages(unsigned int gfp_mask, unsigned int order)
 {
 	struct page * page;
-
-#ifdef CONFIG_NUMA
-	if (unlikely(system_state == SYSTEM_BOOTING))
-		return get_boot_pages(gfp_mask, order);
-#endif
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
diff -u linux-2.6.7rc2-work/mm/mempolicy.c-o linux-2.6.7rc2-work/mm/mempolicy.c
--- linux-2.6.7rc2-work/mm/mempolicy.c-o	2004-05-31 23:22:55.000000000 +0200
+++ linux-2.6.7rc2-work/mm/mempolicy.c	2004-06-05 00:50:50.000000000 +0200
@@ -1001,7 +1001,8 @@
 	up(&p->sem);
 }
 
-static __init int numa_policy_init(void)
+/* assumes fs == KERNEL_DS */
+void __init numa_policy_init(void)
 {
 	policy_cache = kmem_cache_create("numa_policy",
 					 sizeof(struct mempolicy),
@@ -1010,6 +1011,17 @@
 	sn_cache = kmem_cache_create("shared_policy_node",
 				     sizeof(struct sp_node),
 				     0, SLAB_PANIC, NULL, NULL);
-	return 0;
+
+	/* Set interleaving policy for system init. This way not all 
+	   the data structures allocated at system boot end up in node zero. */
+
+	if (sys_set_mempolicy(MPOL_INTERLEAVE, &node_online_map, MAX_NUMNODES) < 0) 
+		printk("numa_policy_init: interleaving failed\n");
+}
+
+/* Reset policy of current process to default.
+ * Assumes fs == KERNEL_DS */
+void __init numa_default_policy(void)
+{
+	sys_set_mempolicy(MPOL_DEFAULT, NULL, 0);
 }
-module_init(numa_policy_init);
diff -u linux-2.6.7rc2-work/init/main.c-o linux-2.6.7rc2-work/init/main.c
--- linux-2.6.7rc2-work/init/main.c-o	2004-05-31 23:22:55.000000000 +0200
+++ linux-2.6.7rc2-work/init/main.c	2004-06-02 03:45:14.000000000 +0200
@@ -43,6 +43,7 @@
 #include <linux/efi.h>
 #include <linux/unistd.h>
 #include <linux/rmap.h>
+#include <linux/mempolicy.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -385,6 +386,7 @@
 static void noinline rest_init(void)
 {
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
+	numa_default_policy();
 	unlock_kernel();
  	cpu_idle();
 } 
@@ -456,6 +458,7 @@
 #endif
 	mem_init();
 	kmem_cache_init();
+	numa_policy_init();
 	if (late_time_init)
 		late_time_init();
 	calibrate_delay();
@@ -645,6 +648,7 @@
 	free_initmem();
 	unlock_kernel();
 	system_state = SYSTEM_RUNNING;
+	numa_default_policy();
 
 	if (sys_open("/dev/console", O_RDWR, 0) < 0)
 		printk("Warning: unable to open an initial console.\n");
