Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422956AbWBBI0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422956AbWBBI0T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423377AbWBBI0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:26:19 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:9679 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1422956AbWBBI0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:26:18 -0500
Date: Thu, 2 Feb 2006 10:25:59 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: "Kevin O'Connor" <kevin@koconnor.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, manfred@colorfullife.com
Subject: [PATCH] slab leak detector (Was: Size-128 slab leak)
Message-ID: <Pine.LNX.4.58.0602021021240.32240@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a version that uses dbg_userword() instead of overriding bufctls 
and adds a CONFIG_DEBUG_SLAB_LEAK config option. Upside is that this works 
with the slab verifier patch and is less invasive. Downside is that now 
some slabs don't get leak reports (those that don't get SLAB_STORE_USER 
enabled in kmem_cache_create). However, I think we should improve 
dbg_userword() mechanism instead if we need leak reports for all caches.

			Pekka

From: Manfred Spraul <manfred@colorfullife.com>

Maintenance work from Alexander Nyberg <alexn@telia.com>

With the patch applied,

	echo "size-32 0 0 0" > /proc/slabinfo

walks the objects in the size-32 slab, printing out the calling address
of whoever allocated that object.

It is for leak detection.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 lib/Kconfig.debug |   12 ++++++++++++
 mm/slab.c         |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

Index: 2.6-git/mm/slab.c
===================================================================
--- 2.6-git.orig/mm/slab.c
+++ 2.6-git/mm/slab.c
@@ -3669,6 +3669,54 @@ struct seq_operations slabinfo_op = {
 	.show = s_show,
 };
 
+#ifdef CONFIG_DEBUG_SLAB_LEAK
+
+static void print_slab_last_users(struct kmem_cache *cache, struct slab *slab)
+{
+	int i;
+
+	for (i = 0; i < cache->num; i++) {
+		void *obj = slab->s_mem + cache->buffer_size * i;
+		unsigned long sym = (unsigned long) *dbg_userword(cache, obj);
+
+		printk("obj %p/%d: %p", slab, i, (void *)sym);
+		print_symbol(" <%s>", sym);
+		printk("\n");
+	}
+}
+
+static void print_cache_last_users(struct kmem_cache *cache)
+{
+	int node;
+
+	if (!(cache->flags & SLAB_STORE_USER))
+		return;
+
+	check_irq_on();
+	spin_lock_irq(&cache->spinlock);
+	for_each_online_node(node) {
+		struct kmem_list3 *lists = cache->nodelists[node];
+		struct list_head *q;
+
+		spin_lock(&lists->list_lock);
+
+		list_for_each(q, &lists->slabs_full) {
+			struct slab *slab = list_entry(q, struct slab, list);
+			print_slab_last_users(cache, slab);
+		}
+		spin_unlock(&lists->list_lock);
+	}
+	spin_unlock_irq(&cache->spinlock);
+}
+
+#else
+
+static void print_cache_last_users(struct kmem_cache *cache)
+{
+}
+
+#endif
+
 #define MAX_SLABINFO_WRITE 128
 /**
  * slabinfo_write - Tuning for the slab allocator
@@ -3709,6 +3757,7 @@ ssize_t slabinfo_write(struct file *file
 			if (limit < 1 ||
 			    batchcount < 1 ||
 			    batchcount > limit || shared < 0) {
+				print_cache_last_users(cachep);
 				res = 0;
 			} else {
 				res = do_tune_cpucache(cachep, limit,
Index: 2.6-git/lib/Kconfig.debug
===================================================================
--- 2.6-git.orig/lib/Kconfig.debug
+++ 2.6-git/lib/Kconfig.debug
@@ -85,6 +85,18 @@ config DEBUG_SLAB
 	  allocation as well as poisoning memory on free to catch use of freed
 	  memory. This can make kmalloc/kfree-intensive workloads much slower.
 
+config DEBUG_SLAB_LEAK
+	bool "Debug memory leaks"
+	depends on DEBUG_SLAB
+	help
+	  Say Y here to have the kernel track last user of a slab object which
+	  can be used to detect memory leaks. With this config option enabled,
+
+	      echo "size-32 0 0 0" > /proc/slabinfo
+
+	  walks the objects in the size-32 slab, printing out the calling
+	  address of whoever allocated that object.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT
