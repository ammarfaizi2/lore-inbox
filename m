Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVCBTRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVCBTRZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVCBTRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:17:24 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:58272 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262423AbVCBTNh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:13:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.4191.474769.320391@jaguar.mkp.net>
Date: Wed, 2 Mar 2005 14:13:35 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [patch - 2.6.11-rc5-mm1] genalloc - general purpose allocator
X-Mailer: VM 7.19 under Emacs 21.3.1
From: jes@trained-monkey.org (Jes Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch implements a general purpose allocator which can be used by
device drivers to manage special purpose memory. In particular it's used
to manage uncached memory on ia64 for the mspec driver (patch to
follow), but it is in no way ia64 specific. The allocator is based on
the allocator from the sym53c8xx_2 driver.

The patch should be harmless for anyone who doesn't actually setup an
allocation pool.

This patch is against 2.6.11-rc5-mm1.

Cheers,
Jes

Signed-off-by: Jes Sorensen <jes@wildopensource.com>



diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc5-mm1-vanilla/include/linux/genalloc.h linux-2.6.11-rc5-mm1/include/linux/genalloc.h
--- linux-2.6.11-rc5-mm1-vanilla/include/linux/genalloc.h	1969-12-31 16:00:00 -08:00
+++ linux-2.6.11-rc5-mm1/include/linux/genalloc.h	2005-03-01 08:28:28 -08:00
@@ -0,0 +1,46 @@
+/*
+ * Basic general purpose allocator for managing special purpose memory
+ * not managed by the regular kmalloc/kfree interface.
+ * Uses for this includes on-device special memory, uncached memory
+ * etc.
+ *
+ * This code is based on the buddy allocator found in the sym53c8xx_2
+ * driver, adapted for general purpose use.
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/spinlock.h>
+
+#define ALLOC_MIN_SHIFT		5 /* 32 bytes minimum */
+/*
+ *  Link between free memory chunks of a given size.
+ */
+struct gen_pool_link {
+	struct gen_pool_link *next;
+};
+
+/*
+ *  Memory pool of a given kind.
+ *  Ideally, we want to use:
+ *  1) 1 pool for memory we donnot need to involve in DMA.
+ *  2) The same pool for controllers that require same DMA 
+ *     constraints and features.
+ *     The OS specific m_pool_id_t thing and the gen_pool_match() 
+ *     method are expected to tell the driver about.
+ */
+struct gen_pool {
+	spinlock_t lock;
+	unsigned long (*get_new_chunk)(struct gen_pool *);
+	struct gen_pool *next;
+	struct gen_pool_link *h;
+	unsigned long private;
+	int max_chunk_shift;
+};
+
+unsigned long gen_pool_alloc(struct gen_pool *poolp, int size);
+void gen_pool_free(struct gen_pool *mp, unsigned long ptr, int size);
+struct gen_pool *alloc_gen_pool(int nr_chunks, int max_chunk_shift,
+				unsigned long (*fp)(struct gen_pool *),
+				unsigned long data);
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc5-mm1-vanilla/init/main.c linux-2.6.11-rc5-mm1/init/main.c
--- linux-2.6.11-rc5-mm1-vanilla/init/main.c	2005-03-01 05:36:16 -08:00
+++ linux-2.6.11-rc5-mm1/init/main.c	2005-03-02 09:59:43 -08:00
@@ -78,6 +78,7 @@
 
 static int init(void *);
 
+extern void gen_pool_init(void);
 extern void init_IRQ(void);
 extern void sock_init(void);
 extern void fork_init(unsigned long);
@@ -489,6 +490,9 @@
 #endif
 	vfs_caches_init_early();
 	mem_init();
+#ifdef CONFIG_GENERIC_ALLOCATOR
+	gen_pool_init();
+#endif
 	kmem_cache_init();
 	numa_policy_init();
 	if (late_time_init)
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc5-mm1-vanilla/lib/Kconfig linux-2.6.11-rc5-mm1/lib/Kconfig
--- linux-2.6.11-rc5-mm1-vanilla/lib/Kconfig	2004-12-24 13:34:58 -08:00
+++ linux-2.6.11-rc5-mm1/lib/Kconfig	2005-03-02 09:59:20 -08:00
@@ -40,6 +40,12 @@
 	tristate
 
 #
+# Generic allocator support is selected if needed
+#
+config GENERIC_ALLOCATOR
+	boolean
+
+#
 # reed solomon support is select'ed if needed
 #
 config REED_SOLOMON
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc5-mm1-vanilla/lib/Makefile linux-2.6.11-rc5-mm1/lib/Makefile
--- linux-2.6.11-rc5-mm1-vanilla/lib/Makefile	2005-03-01 05:36:16 -08:00
+++ linux-2.6.11-rc5-mm1/lib/Makefile	2005-03-01 08:28:28 -08:00
@@ -6,7 +6,7 @@
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
 	 bitmap.o extable.o kobject_uevent.o prio_tree.o sort.o \
-	 sha1.o halfmd4.o
+	 sha1.o halfmd4.o genalloc.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
diff -urN -X /usr/people/jes/exclude-linux linux-2.6.11-rc5-mm1-vanilla/lib/genalloc.c linux-2.6.11-rc5-mm1/lib/genalloc.c
--- linux-2.6.11-rc5-mm1-vanilla/lib/genalloc.c	1969-12-31 16:00:00 -08:00
+++ linux-2.6.11-rc5-mm1/lib/genalloc.c	2005-03-01 08:28:28 -08:00
@@ -0,0 +1,220 @@
+/*
+ * Basic general purpose allocator for managing special purpose memory
+ * not managed by the regular kmalloc/kfree interface.
+ * Uses for this includes on-device special memory, uncached memory
+ * etc.
+ *
+ * This code is based on the buddy allocator found in the sym53c8xx_2
+ * driver Copyright (C) 1999-2001  Gerard Roudier <groudier@free.fr>,
+ * and adapted for general purpose use.
+ *
+ * Copyright 2005 (C) Jes Sorensen <jes@trained-monkey.org>
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/genalloc.h>
+
+#include <asm/page.h>
+#include <asm/pal.h>
+
+
+#define DEBUG	0
+
+struct gen_pool *alloc_gen_pool(int nr_chunks, int max_chunk_shift,
+				unsigned long (*fp)(struct gen_pool *),
+				unsigned long data)
+{
+	struct gen_pool *poolp;
+	unsigned long tmp;
+	int i;
+
+	/*
+	 * This is really an arbitrary limit, +10 is enough for
+	 * IA64_GRANULE_SHIFT.
+	 */
+	if ((max_chunk_shift > (PAGE_SHIFT + 10)) || 
+	    ((max_chunk_shift < ALLOC_MIN_SHIFT) && max_chunk_shift))
+		return NULL;
+
+	if (!max_chunk_shift)
+		max_chunk_shift = PAGE_SHIFT;
+
+	poolp = kmalloc(sizeof(struct gen_pool), GFP_KERNEL);
+	if (!poolp)
+		return NULL;
+	memset(poolp, 0, sizeof(struct gen_pool));
+	poolp->h = kmalloc(sizeof(struct gen_pool_link) *
+			   (max_chunk_shift - ALLOC_MIN_SHIFT + 1),
+			   GFP_KERNEL);
+	if (!poolp->h) {
+		printk(KERN_WARNING "gen_pool_alloc() failed to allocate\n");
+		kfree(poolp);
+		return NULL;
+	}
+	memset(poolp->h, 0, sizeof(struct gen_pool_link) *
+	       (max_chunk_shift - ALLOC_MIN_SHIFT + 1));
+
+	spin_lock_init(&poolp->lock);
+	poolp->get_new_chunk = fp;
+	poolp->max_chunk_shift = max_chunk_shift;
+	poolp->private = data;
+
+	for (i = 0; i < nr_chunks; i++) {
+		tmp = poolp->get_new_chunk(poolp);
+		printk(KERN_INFO "allocated %lx\n", tmp);
+		if (!tmp)
+			break;
+		gen_pool_free(poolp, tmp, (1 << poolp->max_chunk_shift));
+	}
+
+	return poolp;
+}
+
+
+/*
+ *  Simple power of two buddy-like generic allocator.
+ *  Provides naturally aligned memory chunks.
+ */
+unsigned long gen_pool_alloc(struct gen_pool *poolp, int size)
+{
+	int j, i, s, max_chunk_size;
+	unsigned long a, flags;
+	struct gen_pool_link *h = poolp->h;
+
+	max_chunk_size = 1 << poolp->max_chunk_shift;
+
+	if (size > max_chunk_size)
+		return 0;
+
+	i = 0;
+	s = (1 << ALLOC_MIN_SHIFT);
+	while (size > s) {
+		s <<= 1;
+		i++;
+	}
+
+#if DEBUG
+	printk(KERN_DEBUG "gen_pool_alloc: s %02x, i %i, h %p\n", s, i, h);
+#endif
+
+	j = i;
+
+	spin_lock_irqsave(&poolp->lock, flags);
+	while (!h[j].next) {
+		if (s == max_chunk_size) {
+			struct gen_pool_link *ptr;
+			spin_unlock_irqrestore(&poolp->lock, flags);
+			ptr = (struct gen_pool_link *)poolp->get_new_chunk(poolp);
+			spin_lock_irqsave(&poolp->lock, flags);
+			h[j].next = ptr;
+			if (h[j].next)
+				h[j].next->next = NULL;
+#if DEBUG
+			printk(KERN_DEBUG "gen_pool_alloc() max chunk j %i\n", j);
+#endif
+			break;
+		}
+		j++;
+		s <<= 1;
+	}
+	a = (unsigned long) h[j].next;
+	if (a) {
+		h[j].next = h[j].next->next;
+		/*
+		 * This should be split into a seperate function doing
+		 * the chunk split in order to support custom
+		 * handling memory not physically accessible by host
+		 */
+		while (j > i) {
+#if DEBUG
+			printk(KERN_DEBUG "gen_pool_alloc() splitting i %i j %i %x a %02lx\n", i, j, s, a);
+#endif
+			j -= 1;
+			s >>= 1;
+			h[j].next = (struct gen_pool_link *) (a + s);
+			h[j].next->next = NULL;
+		}
+	}
+	spin_unlock_irqrestore(&poolp->lock, flags);
+#if DEBUG
+	printk(KERN_DEBUG "gen_pool_alloc(%d) = %p\n", size, (void *) a);
+#endif
+	return a;
+}
+
+/*
+ *  Counter-part of the generic allocator.
+ */
+void gen_pool_free(struct gen_pool *poolp, unsigned long ptr, int size)
+{
+	struct gen_pool_link *q;
+	struct gen_pool_link *h = poolp->h;
+	unsigned long a, b, flags;
+	int i, max_chunk_size;
+	int s = (1 << ALLOC_MIN_SHIFT);
+
+#if DEBUG
+	printk(KERN_DEBUG "gen_pool_free(%lx, %d)\n", ptr, size);
+#endif
+
+	max_chunk_size = 1 << poolp->max_chunk_shift;
+
+	if (size > max_chunk_size)
+		return;
+
+	i = 0;
+	while (size > s) {
+		s <<= 1;
+		i++;
+	}
+
+	a = ptr;
+
+	spin_lock_irqsave(&poolp->lock, flags);
+	while (1) {
+		if (s == max_chunk_size) {
+			((struct gen_pool_link *)a)->next = h[i].next;
+			h[i].next = (struct gen_pool_link *)a;
+			break;
+		}
+		b = a ^ s;
+		q = &h[i];
+
+		while (q->next && q->next != (struct gen_pool_link *)b) {
+			q = q->next;
+		}
+
+		if (!q->next) {
+			((struct gen_pool_link *)a)->next = h[i].next;
+			h[i].next = (struct gen_pool_link *)a;
+			break;
+		}
+		q->next = q->next->next;
+		a = a & b;
+		s <<= 1;
+		i++;
+	}
+	spin_unlock_irqrestore(&poolp->lock, flags);
+}
+
+
+int __init gen_pool_init(void)
+{
+	printk(KERN_INFO "Generic memory pool allocator v1.0\n");
+	return 0;
+}
+
+EXPORT_SYMBOL(alloc_gen_pool);
+EXPORT_SYMBOL(gen_pool_alloc);
+EXPORT_SYMBOL(gen_pool_free);
