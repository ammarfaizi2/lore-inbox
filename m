Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVIMQTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVIMQTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVIMQTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:19:23 -0400
Received: from serv01.siteground.net ([70.85.91.68]:20394 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964851AbVIMQTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:19:21 -0400
Date: Tue, 13 Sep 2005 09:19:14 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 11/11] mm: Reimplementation of dynamic per-cpu allocator -- hotplug_alloc_percpu_blocks
Message-ID: <20050913161914.GM3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to hotplug chunks of memory for alloc_percpu blocks when a cpu comes
up.  This is needed when alloc_percpu is used real early and the
cpu_possible mask is not fully setup.  Then, the backing chunks of memory
are allocated when cpus come up.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: alloc_percpu-2.6.13/include/linux/percpu.h
===================================================================
--- alloc_percpu-2.6.13.orig/include/linux/percpu.h	2005-09-12 12:23:34.000000000 -0700
+++ alloc_percpu-2.6.13/include/linux/percpu.h	2005-09-12 18:39:42.000000000 -0700
@@ -31,6 +31,7 @@
 
 extern void *__alloc_percpu(size_t size, size_t align, unsigned int gfpflags);
 extern void free_percpu(const void *);
+extern void __init alloc_percpu_init(void);
 
 #else /* CONFIG_SMP */
 
@@ -49,6 +50,8 @@
 	kfree(ptr);
 }
 
+#define alloc_percpu_init() do {} while (0) 
+
 #endif /* CONFIG_SMP */
 
 /* Simple wrapper for the common case: zeros memory. */
Index: alloc_percpu-2.6.13/init/main.c
===================================================================
--- alloc_percpu-2.6.13.orig/init/main.c	2005-09-12 12:23:34.000000000 -0700
+++ alloc_percpu-2.6.13/init/main.c	2005-09-12 18:25:05.000000000 -0700
@@ -495,6 +495,9 @@
 #endif
 	vfs_caches_init_early();
 	mem_init();
+
+	alloc_percpu_init();
+
 	kmem_cache_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
Index: alloc_percpu-2.6.13/mm/percpu.c
===================================================================
--- alloc_percpu-2.6.13.orig/mm/percpu.c	2005-09-12 12:23:34.000000000 -0700
+++ alloc_percpu-2.6.13/mm/percpu.c	2005-09-12 16:57:49.000000000 -0700
@@ -35,8 +35,9 @@
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-
 #include <linux/sort.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
 #ifdef CONFIG_HIGHMEM
 #include <asm/highmem.h>
 #endif
@@ -200,8 +201,10 @@
 rollback_pages:
 	j--;
 	for (; j >= 0; j--)
-		if (cpu_possible(j / cpu_pages))
+		if (cpu_possible(j / cpu_pages)) {
 			__free_pages(blkp->pages[j], 0);
+			blkp->pages[j] = NULL;
+		}
 
 	/* Unmap  block management */
 	tmp.addr = area->addr + NR_CPUS * PCPU_BLKSIZE;
@@ -222,6 +225,90 @@
 	return NULL;
 }
 
+static int __devinit __allocate_chunk(int cpu, struct pcpu_block *blkp)
+{
+	unsigned int cpu_pages = PCPU_BLKSIZE >> PAGE_SHIFT;
+	int start_idx, j;	
+	struct vm_struct tmp;
+	struct page **tmppage;
+
+	/* Alloc node local pages for the onlined cpu */
+	start_idx = cpu * cpu_pages;
+
+	if (blkp->pages[start_idx])
+		return 1;	/* Already allocated */
+
+	for (j = start_idx; j < start_idx + cpu_pages; j++) {
+		BUG_ON(blkp->pages[j]);
+		blkp->pages[j] = alloc_pages_node(cpu_to_node(cpu),
+						  GFP_ATOMIC |
+						  __GFP_HIGHMEM,
+						  0);
+		if (unlikely(!blkp->pages[j]))
+			goto rollback_pages;
+	}
+	
+	/* Map pages for each cpu by splitting vm_struct for each cpu */
+	tmppage = &blkp->pages[cpu * cpu_pages];
+	tmp.addr = blkp->start_addr + cpu * PCPU_BLKSIZE;
+	/* map_vm_area assumes a guard page of size PAGE_SIZE */
+	tmp.size = PCPU_BLKSIZE + PAGE_SIZE;
+	if (map_vm_area(&tmp, PAGE_KERNEL, &tmppage))
+		goto rollback_pages;
+
+	return 1; /* Success */
+
+rollback_pages:
+	j--;
+	for (; j >= 0; j--) {
+		__free_pages(blkp->pages[j], 0);
+		blkp->pages[j] = NULL;
+	}
+	return 0;
+}
+
+/* Allocate chunks for this cpu in all blocks */
+static int __devinit allocate_chunk(int cpu)
+{
+	struct pcpu_block *blkp = NULL;
+	unsigned long flags;
+	spin_lock_irqsave(&blklist_lock, flags);
+	list_for_each_entry(blkp, &blkhead, blklist) {
+		if (!__allocate_chunk(cpu, blkp)) {
+			spin_unlock_irqrestore(&blklist_lock, flags);
+			return 0;
+		}
+	}
+
+	spin_unlock_irqrestore(&blklist_lock, flags);
+	return 1;
+}
+
+	
+static int __devinit alloc_percpu_notify(struct notifier_block *self,
+					 unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+	switch (action) {
+	case CPU_UP_PREPARE:
+		if (!allocate_chunk(cpu))
+			return NOTIFY_BAD;
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata alloc_percpu_nb = {
+	.notifier_call = alloc_percpu_notify,
+};
+
+void __init alloc_percpu_init(void)
+{
+	register_cpu_notifier(&alloc_percpu_nb);
+}
+ 
 /* Free memory block allocated by valloc_percpu */
 static void vfree_percpu(void *addr)
 {
