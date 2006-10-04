Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161579AbWJDQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161579AbWJDQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161564AbWJDQbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:31:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:24539 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161566AbWJDQbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:31:07 -0400
Message-Id: <20061004161507.554879000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:20 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 10/14] spufs: support new OF device tree format
Content-Disposition: inline; filename=spufs-new-devnode.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The properties we used traditionally in the device tree
are somewhat nonstandard, this adds support for a more
conventional format using 'interrupts' and 'reg'
properties.

The interrupts are specified in three cells (class 0,
1 and 2) and registered at the interrupt-parent.

The reg property contains either three or four register
areas in the order 'local-store', 'problem', 'priv2',
and 'priv1', so the priv1 one can be left out in
case of hypervisor driven systems that access these
through hcalls.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -25,11 +25,13 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/poll.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 
+#include <asm/firmware.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <linux/mutex.h>
@@ -576,7 +578,7 @@ static void spu_unmap(struct spu *spu)
 }
 
 /* This function shall be abstracted for HV platforms */
-static int __init spu_map_interrupts(struct spu *spu, struct device_node *np)
+static int __init spu_map_interrupts_old(struct spu *spu, struct device_node *np)
 {
 	unsigned int isrc;
 	const u32 *tmp;
@@ -600,7 +602,7 @@ static int __init spu_map_interrupts(str
 	return spu->irqs[2] == NO_IRQ ? -EINVAL : 0;
 }
 
-static int __init spu_map_device(struct spu *spu, struct device_node *node)
+static int __init spu_map_device_old(struct spu *spu, struct device_node *node)
 {
 	const char *prop;
 	int ret;
@@ -645,6 +647,88 @@ out:
 	return ret;
 }
 
+static int __init spu_map_interrupts(struct spu *spu, struct device_node *np)
+{
+	struct of_irq oirq;
+	int ret;
+	int i;
+
+	for (i=0; i < 3; i++) {
+		ret = of_irq_map_one(np, i, &oirq);
+		if (ret)
+			goto err;
+
+		ret = -EINVAL;
+		spu->irqs[i] = irq_create_of_mapping(oirq.controller,
+					oirq.specifier, oirq.size);
+		if (spu->irqs[i] == NO_IRQ)
+			goto err;
+	}
+	return 0;
+
+err:
+	pr_debug("failed to map irq %x for spu %s\n", *oirq.specifier, spu->name);
+	for (; i >= 0; i--) {
+		if (spu->irqs[i] != NO_IRQ)
+			irq_dispose_mapping(spu->irqs[i]);
+	}
+	return ret;
+}
+
+static int spu_map_resource(struct device_node *node, int nr,
+		void __iomem** virt, unsigned long *phys)
+{
+	struct resource resource = { };
+	int ret;
+
+	ret = of_address_to_resource(node, 0, &resource);
+	if (ret)
+		goto out;
+
+	if (phys)
+		*phys = resource.start;
+	*virt = ioremap(resource.start, resource.end - resource.start);
+	if (!*virt)
+		ret = -EINVAL;
+
+out:
+	return ret;
+}
+
+static int __init spu_map_device(struct spu *spu, struct device_node *node)
+{
+	int ret = -ENODEV;
+	spu->name = get_property(node, "name", NULL);
+	if (!spu->name)
+		goto out;
+
+	ret = spu_map_resource(node, 0, (void __iomem**)&spu->local_store,
+					&spu->local_store_phys);
+	if (ret)
+		goto out;
+	ret = spu_map_resource(node, 1, (void __iomem**)&spu->problem,
+					&spu->problem_phys);
+	if (ret)
+		goto out_unmap;
+	ret = spu_map_resource(node, 2, (void __iomem**)&spu->priv2,
+					NULL);
+	if (ret)
+		goto out_unmap;
+
+	if (!firmware_has_feature(FW_FEATURE_LPAR))
+		ret = spu_map_resource(node, 3, (void __iomem**)&spu->priv1,
+					NULL);
+	if (ret)
+		goto out_unmap;
+	return 0;
+
+out_unmap:
+	spu_unmap(spu);
+out:
+	pr_debug("failed to map spe %s: %d\n", spu->name, ret);
+	return ret;
+}
+
 struct sysdev_class spu_sysdev_class = {
 	set_kset_name("spu")
 };
@@ -698,6 +782,9 @@ static int __init create_spu(struct devi
 		goto out;
 
 	ret = spu_map_device(spu, spe);
+	/* try old method */
+	if (ret)
+		ret = spu_map_device_old(spu, spe);
 	if (ret)
 		goto out_free;
 
@@ -707,6 +794,8 @@ static int __init create_spu(struct devi
 		spu->nid = 0;
 	ret = spu_map_interrupts(spu, spe);
 	if (ret)
+		ret = spu_map_interrupts_old(spu, spe);
+	if (ret)
 		goto out_unmap;
 	spin_lock_init(&spu->register_lock);
 	spu_mfc_sdr_set(spu, mfspr(SPRN_SDR1));
@@ -716,7 +805,7 @@ static int __init create_spu(struct devi
 	spu->number = number++;
 	ret = spu_request_irqs(spu);
 	if (ret)
-		goto out_unmap;
+		goto out_unlock;
 
 	ret = spu_create_sysdev(spu);
 	if (ret)
@@ -732,9 +821,9 @@ static int __init create_spu(struct devi
 
 out_free_irqs:
 	spu_free_irqs(spu);
-
-out_unmap:
+out_unlock:
 	mutex_unlock(&spu_mutex);
+out_unmap:
 	spu_unmap(spu);
 out_free:
 	kfree(spu);

--

