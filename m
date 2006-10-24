Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWJXQmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWJXQmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWJXQml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:42:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:1530 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030434AbWJXQmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:42:13 -0400
Message-Id: <20061024163812.670608000@arndb.de>
References: <20061024163113.694643000@arndb.de>
User-Agent: quilt/0.45-1
Date: Tue, 24 Oct 2006 18:31:15 +0200
From: arnd@arndb.de
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH 02/16] cell: remove unused struct spu variable
Content-Disposition: inline; filename=spufs-remove-unused-var.diff
Cc: Geoff Levand <geoffrey.levand@am.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geoff Levand <geoffrey.levand@am.sony.com>

Remove the mostly unused variable isrc from struct spu and a forgotten
function declaration.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -364,8 +364,7 @@ struct spu *spu_alloc_node(int node)
 	if (!list_empty(&spu_list[node])) {
 		spu = list_entry(spu_list[node].next, struct spu, list);
 		list_del_init(&spu->list);
-		pr_debug("Got SPU %x %d %d\n",
-			 spu->isrc, spu->number, spu->node);
+		pr_debug("Got SPU %d %d\n", spu->number, spu->node);
 		spu_init_channels(spu);
 	}
 	mutex_unlock(&spu_mutex);
@@ -591,7 +590,6 @@ static int __init spu_map_interrupts_old
 
 	/* Add the node number */
 	isrc |= spu->node << IIC_IRQ_NODE_SHIFT;
-	spu->isrc = isrc;
 
 	/* Now map interrupts of all 3 classes */
 	spu->irqs[0] = irq_create_mapping(NULL, IIC_IRQ_CLASS_0 | isrc);
@@ -733,16 +731,6 @@ struct sysdev_class spu_sysdev_class = {
 	set_kset_name("spu")
 };
 
-static ssize_t spu_show_isrc(struct sys_device *sysdev, char *buf)
-{
-	struct spu *spu = container_of(sysdev, struct spu, sysdev);
-	return sprintf(buf, "%d\n", spu->isrc);
-
-}
-static SYSDEV_ATTR(isrc, 0400, spu_show_isrc, NULL);
-
-extern int attach_sysdev_to_node(struct sys_device *dev, int nid);
-
 static int spu_create_sysdev(struct spu *spu)
 {
 	int ret;
@@ -756,8 +744,6 @@ static int spu_create_sysdev(struct spu 
 		return ret;
 	}
 
-	if (spu->isrc != 0)
-		sysdev_create_file(&spu->sysdev, &attr_isrc);
 	sysfs_add_device_to_node(&spu->sysdev, spu->nid);
 
 	return 0;
@@ -765,7 +751,6 @@ static int spu_create_sysdev(struct spu 
 
 static void spu_destroy_sysdev(struct spu *spu)
 {
-	sysdev_remove_file(&spu->sysdev, &attr_isrc);
 	sysfs_remove_device_from_node(&spu->sysdev, spu->nid);
 	sysdev_unregister(&spu->sysdev);
 }
@@ -821,8 +806,8 @@ static int __init create_spu(struct devi
 	list_add(&spu->list, &spu_list[spu->node]);
 	mutex_unlock(&spu_mutex);
 
-	pr_debug(KERN_DEBUG "Using SPE %s %02x %p %p %p %p %d\n",
-		spu->name, spu->isrc, spu->local_store,
+	pr_debug(KERN_DEBUG "Using SPE %s %p %p %p %p %d\n",
+		spu->name, spu->local_store,
 		spu->problem, spu->priv1, spu->priv2, spu->number);
 	goto out;
 
Index: linux-2.6/include/asm-powerpc/spu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/spu.h
+++ linux-2.6/include/asm-powerpc/spu.h
@@ -118,7 +118,6 @@ struct spu {
 	int number;
 	int nid;
 	unsigned int irqs[3];
-	u32 isrc;
 	u32 node;
 	u64 flags;
 	u64 dar;

--

