Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWD2BVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWD2BVa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 21:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWD2BV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 21:21:29 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:1264 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751157AbWD2BV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 21:21:28 -0400
Message-Id: <20060429011909.077738000@localhost.localdomain>
References: <20060429011827.502138000@localhost.localdomain>
Date: Sat, 29 Apr 2006 03:18:31 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 4/4] powerpc: cell: Add numa id to struct spu
Content-Disposition: inline; filename=spufs-numa-id.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

Add an nid member to the spu structure, and store the numa id of the spu
there on creation.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spu_base.c	2006-04-29 02:51:33.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/spu_base.c	2006-04-29 02:56:58.000000000 +0200
@@ -525,8 +525,8 @@
 	return id ? *id : 0;
 }
 
-static int __init cell_spuprop_present(struct device_node *spe,
-					const char *prop)
+static int __init cell_spuprop_present(struct spu *spu, struct device_node *spe,
+		const char *prop)
 {
 	static DEFINE_MUTEX(add_spumem_mutex);
 
@@ -537,7 +537,6 @@
 	int proplen;
 
 	unsigned long start_pfn, nr_pages;
-	int node_id;
 	struct pglist_data *pgdata;
 	struct zone *zone;
 	int ret;
@@ -548,14 +547,7 @@
 	start_pfn = p->address >> PAGE_SHIFT;
 	nr_pages = ((unsigned long)p->len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	/*
-	 * XXX need to get the correct NUMA node in here. This may
-	 * be different from the spe::node_id property, e.g. when
-	 * the host firmware is not NUMA aware.
-	 */
-	node_id = 0;
-
-	pgdata = NODE_DATA(node_id);
+	pgdata = NODE_DATA(spu->nid);
 	zone = pgdata->node_zones;
 
 	/* XXX rethink locking here */
@@ -566,8 +558,8 @@
 	return ret;
 }
 
-static void __iomem * __init map_spe_prop(struct device_node *n,
-						 const char *name)
+static void __iomem * __init map_spe_prop(struct spu *spu,
+		struct device_node *n, const char *name)
 {
 	struct address_prop {
 		unsigned long address;
@@ -585,7 +577,7 @@
 
 	prop = p;
 
-	err = cell_spuprop_present(n, name);
+	err = cell_spuprop_present(spu, n, name);
 	if (err && (err != -EEXIST))
 		goto out;
 
@@ -603,44 +595,45 @@
 	iounmap((u8 __iomem *)spu->local_store);
 }
 
-static int __init spu_map_device(struct spu *spu, struct device_node *spe)
+static int __init spu_map_device(struct spu *spu, struct device_node *node)
 {
 	char *prop;
 	int ret;
 
 	ret = -ENODEV;
-	prop = get_property(spe, "isrc", NULL);
+	prop = get_property(node, "isrc", NULL);
 	if (!prop)
 		goto out;
 	spu->isrc = *(unsigned int *)prop;
 
-	spu->name = get_property(spe, "name", NULL);
+	spu->name = get_property(node, "name", NULL);
 	if (!spu->name)
 		goto out;
 
-	prop = get_property(spe, "local-store", NULL);
+	prop = get_property(node, "local-store", NULL);
 	if (!prop)
 		goto out;
 	spu->local_store_phys = *(unsigned long *)prop;
 
 	/* we use local store as ram, not io memory */
-	spu->local_store = (void __force *)map_spe_prop(spe, "local-store");
+	spu->local_store = (void __force *)
+		map_spe_prop(spu, node, "local-store");
 	if (!spu->local_store)
 		goto out;
 
-	prop = get_property(spe, "problem", NULL);
+	prop = get_property(node, "problem", NULL);
 	if (!prop)
 		goto out_unmap;
 	spu->problem_phys = *(unsigned long *)prop;
 
-	spu->problem= map_spe_prop(spe, "problem");
+	spu->problem= map_spe_prop(spu, node, "problem");
 	if (!spu->problem)
 		goto out_unmap;
 
-	spu->priv1= map_spe_prop(spe, "priv1");
+	spu->priv1= map_spe_prop(spu, node, "priv1");
 	/* priv1 is not available on a hypervisor */
 
-	spu->priv2= map_spe_prop(spe, "priv2");
+	spu->priv2= map_spe_prop(spu, node, "priv2");
 	if (!spu->priv2)
 		goto out_unmap;
 	ret = 0;
@@ -668,6 +661,10 @@
 		goto out_free;
 
 	spu->node = find_spu_node_id(spe);
+	spu->nid = of_node_to_nid(spe);
+	if (spu->nid == -1)
+		spu->nid = 0;
+
 	spu->stop_code = 0;
 	spu->slb_replace = 0;
 	spu->mm = NULL;
Index: linus-2.6/include/asm-powerpc/spu.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/spu.h	2006-04-29 02:51:29.000000000 +0200
+++ linus-2.6/include/asm-powerpc/spu.h	2006-04-29 02:56:58.000000000 +0200
@@ -117,6 +117,7 @@
 	struct list_head list;
 	struct list_head sched_list;
 	int number;
+	int nid;
 	u32 isrc;
 	u32 node;
 	u64 flags;

--

