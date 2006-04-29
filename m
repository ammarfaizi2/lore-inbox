Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWD2BV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWD2BV3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 21:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWD2BV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 21:21:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:48074 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750841AbWD2BV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 21:21:28 -0400
Message-Id: <20060429011908.122296000@localhost.localdomain>
References: <20060429011827.502138000@localhost.localdomain>
Date: Sat, 29 Apr 2006 03:18:28 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 1/4] spufs: fix for CONFIG_NUMA
Content-Disposition: inline; filename=memory-add-3.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel H Schopp <jschopp@us.ibm.com>

Based on an older patch from  Mike Kravetz <kravetz@us.ibm.com>

We need to have a mem_map for high addresses in order to make
fops->no_page work on spufs mem and register files. So far, we
have used the memory_present() function during early bootup,
but that did not work when CONFIG_NUMA was enabled.

We now use the __add_pages() function to add the mem_map
when loading the spufs module, which is a lot nicer.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/setup.c	2006-04-29 02:51:29.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/setup.c	2006-04-29 02:51:33.000000000 +0200
@@ -29,6 +29,8 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
+#include <linux/mutex.h>
+#include <linux/memory_hotplug.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -46,6 +48,7 @@
 #include <asm/cputable.h>
 #include <asm/ppc-pci.h>
 #include <asm/irq.h>
+#include <asm/spu.h>
 
 #include "interrupt.h"
 #include "iommu.h"
@@ -69,77 +72,6 @@
 	of_node_put(root);
 }
 
-#ifdef CONFIG_SPARSEMEM
-static int __init find_spu_node_id(struct device_node *spe)
-{
-	unsigned int *id;
-#ifdef CONFIG_NUMA
-	struct device_node *cpu;
-	cpu = spe->parent->parent;
-	id = (unsigned int *)get_property(cpu, "node-id", NULL);
-#else
-	id = NULL;
-#endif
-	return id ? *id : 0;
-}
-
-static void __init cell_spuprop_present(struct device_node *spe,
-				       const char *prop, int early)
-{
-	struct address_prop {
-		unsigned long address;
-		unsigned int len;
-	} __attribute__((packed)) *p;
-	int proplen;
-
-	unsigned long start_pfn, end_pfn, pfn;
-	int node_id;
-
-	p = (void*)get_property(spe, prop, &proplen);
-	WARN_ON(proplen != sizeof (*p));
-
-	node_id = find_spu_node_id(spe);
-
-	start_pfn = p->address >> PAGE_SHIFT;
-	end_pfn = (p->address + p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-	/* We need to call memory_present *before* the call to sparse_init,
-	   but we can initialize the page structs only *after* that call.
-	   Thus, we're being called twice. */
-	if (early)
-		memory_present(node_id, start_pfn, end_pfn);
-	else {
-		/* As the pages backing SPU LS and I/O are outside the range
-		   of regular memory, their page structs were not initialized
-		   by free_area_init. Do it here instead. */
-		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
-			struct page *page = pfn_to_page(pfn);
-			set_page_links(page, ZONE_DMA, node_id, pfn);
-			init_page_count(page);
-			reset_page_mapcount(page);
-			SetPageReserved(page);
-			INIT_LIST_HEAD(&page->lru);
-		}
-	}
-}
-
-static void __init cell_spumem_init(int early)
-{
-	struct device_node *node;
-	for (node = of_find_node_by_type(NULL, "spe");
-			node; node = of_find_node_by_type(node, "spe")) {
-		cell_spuprop_present(node, "local-store", early);
-		cell_spuprop_present(node, "problem", early);
-		cell_spuprop_present(node, "priv1", early);
-		cell_spuprop_present(node, "priv2", early);
-	}
-}
-#else
-static void __init cell_spumem_init(int early)
-{
-}
-#endif
-
 static void cell_progress(char *s, unsigned short hex)
 {
 	printk("*** %04x : %s\n", hex, s ? s : "");
@@ -172,8 +104,6 @@
 #endif
 
 	mmio_nvram_init();
-
-	cell_spumem_init(0);
 }
 
 /*
@@ -189,8 +119,6 @@
 
 	ppc64_interrupt_controller = IC_CELL_PIC;
 
-	cell_spumem_init(1);
-
 	DBG(" <- cell_init_early()\n");
 }
 
Index: linus-2.6/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/Kconfig	2006-04-29 02:51:29.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/Kconfig	2006-04-29 02:51:33.000000000 +0200
@@ -12,7 +12,8 @@
 
 config SPUFS_MMAP
 	bool
-	depends on SPU_FS && SPARSEMEM && !PPC_64K_PAGES
+	depends on SPU_FS && SPARSEMEM
+	select MEMORY_HOTPLUG
 	default y
 
 endmenu
Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c	2006-04-29 02:51:29.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c	2006-04-29 02:51:33.000000000 +0200
@@ -516,6 +516,56 @@
 }
 EXPORT_SYMBOL_GPL(spu_irq_setaffinity);
 
+static int __init find_spu_node_id(struct device_node *spe)
+{
+	unsigned int *id;
+	struct device_node *cpu;
+	cpu = spe->parent->parent;
+	id = (unsigned int *)get_property(cpu, "node-id", NULL);
+	return id ? *id : 0;
+}
+
+static int __init cell_spuprop_present(struct device_node *spe,
+					const char *prop)
+{
+	static DEFINE_MUTEX(add_spumem_mutex);
+
+	struct address_prop {
+		unsigned long address;
+		unsigned int len;
+	} __attribute__((packed)) *p;
+	int proplen;
+
+	unsigned long start_pfn, nr_pages;
+	int node_id;
+	struct pglist_data *pgdata;
+	struct zone *zone;
+	int ret;
+
+	p = (void*)get_property(spe, prop, &proplen);
+	WARN_ON(proplen != sizeof (*p));
+
+	start_pfn = p->address >> PAGE_SHIFT;
+	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	/*
+	 * XXX need to get the correct NUMA node in here. This may
+	 * be different from the spe::node_id property, e.g. when
+	 * the host firmware is not NUMA aware.
+	 */
+	node_id = 0;
+
+	pgdata = NODE_DATA(node_id);
+	zone = pgdata->node_zones;
+
+	/* XXX rethink locking here */
+	mutex_lock(&add_spumem_mutex);
+	ret = __add_pages(zone, start_pfn, nr_pages);
+	mutex_unlock(&add_spumem_mutex);
+
+	return ret;
+}
+
 static void __iomem * __init map_spe_prop(struct device_node *n,
 						 const char *name)
 {
@@ -526,6 +576,8 @@
 
 	void *p;
 	int proplen;
+	void* ret = NULL;
+	int err = 0;
 
 	p = get_property(n, name, &proplen);
 	if (proplen != sizeof (struct address_prop))
@@ -533,7 +585,14 @@
 
 	prop = p;
 
-	return ioremap(prop->address, prop->len);
+	err = cell_spuprop_present(n, name);
+	if (err && (err != -EEXIST))
+		goto out;
+
+	ret = ioremap(prop->address, prop->len);
+
+ out:
+	return ret;
 }
 
 static void spu_unmap(struct spu *spu)
@@ -593,17 +652,6 @@
 	return ret;
 }
 
-static int __init find_spu_node_id(struct device_node *spe)
-{
-	unsigned int *id;
-	struct device_node *cpu;
-
-	cpu = spe->parent->parent;
-	id = (unsigned int *)get_property(cpu, "node-id", NULL);
-
-	return id ? *id : 0;
-}
-
 static int __init create_spu(struct device_node *spe)
 {
 	struct spu *spu;
Index: linus-2.6/mm/memory_hotplug.c
===================================================================
--- linus-2.6.orig/mm/memory_hotplug.c	2006-04-29 02:51:29.000000000 +0200
+++ linus-2.6/mm/memory_hotplug.c	2006-04-29 02:51:33.000000000 +0200
@@ -69,12 +69,16 @@
 	for (i = 0; i < nr_pages; i += PAGES_PER_SECTION) {
 		err = __add_section(zone, phys_start_pfn + i);
 
-		if (err)
+		/* We want to keep adding the rest of the
+		 * sections if the first ones already exist
+		 */
+		if (err && (err != -EEXIST))
 			break;
 	}
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(__add_pages);
 
 static void grow_zone_span(struct zone *zone,
 		unsigned long start_pfn, unsigned long end_pfn)

--

