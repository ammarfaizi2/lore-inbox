Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWFSSnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWFSSnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWFSSnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:43:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:31432 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932373AbWFSSnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:43:20 -0400
Message-Id: <20060619183404.507723000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:19 +0200
From: arnd@arndb.de
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [patch 04/20] cell: register SPUs as sysdevs
Content-Disposition: inline; filename=spufs-register-sysdev.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

SPUs are registered as system devices, exposing attributes through
sysfs. Since the sysdev includes a kref, we can remove the one in
struct spu (it isn't used at the moment anyway).

Currently only the interrupt source and numa node attributes are added.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: powerpc.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_base.c
+++ powerpc.git/arch/powerpc/platforms/cell/spu_base.c
@@ -649,6 +649,46 @@ out:
 	return ret;
 }
 
+struct sysdev_class spu_sysdev_class = {
+	set_kset_name("spu")
+};
+
+static ssize_t spu_show_isrc(struct sys_device *sysdev, char *buf)
+{
+	struct spu *spu = container_of(sysdev, struct spu, sysdev);
+	return sprintf(buf, "%d\n", spu->isrc);
+
+}
+static SYSDEV_ATTR(isrc, 0400, spu_show_isrc, NULL);
+
+extern int attach_sysdev_to_node(struct sys_device *dev, int nid);
+
+static int spu_create_sysdev(struct spu *spu)
+{
+	int ret;
+
+	spu->sysdev.id = spu->number;
+	spu->sysdev.cls = &spu_sysdev_class;
+	ret = sysdev_register(&spu->sysdev);
+	if (ret) {
+		printk(KERN_ERR "Can't register SPU %d with sysfs\n",
+				spu->number);
+		return ret;
+	}
+
+	sysdev_create_file(&spu->sysdev, &attr_isrc);
+	sysfs_add_device_to_node(&spu->sysdev, spu->nid);
+
+	return 0;
+}
+
+static void spu_destroy_sysdev(struct spu *spu)
+{
+	sysdev_remove_file(&spu->sysdev, &attr_isrc);
+	sysfs_remove_device_from_node(&spu->sysdev, spu->nid);
+	sysdev_unregister(&spu->sysdev);
+}
+
 static int __init create_spu(struct device_node *spe)
 {
 	struct spu *spu;
@@ -695,6 +735,10 @@ static int __init create_spu(struct devi
 	if (ret)
 		goto out_unmap;
 
+	ret = spu_create_sysdev(spu);
+	if (ret)
+		goto out_free_irqs;
+
 	list_add(&spu->list, &spu_list);
 	mutex_unlock(&spu_mutex);
 
@@ -703,6 +747,9 @@ static int __init create_spu(struct devi
 		spu->problem, spu->priv1, spu->priv2, spu->number);
 	goto out;
 
+out_free_irqs:
+	spu_free_irqs(spu);
+
 out_unmap:
 	mutex_unlock(&spu_mutex);
 	spu_unmap(spu);
@@ -716,6 +763,7 @@ static void destroy_spu(struct spu *spu)
 {
 	list_del_init(&spu->list);
 
+	spu_destroy_sysdev(spu);
 	spu_free_irqs(spu);
 	spu_unmap(spu);
 	kfree(spu);
@@ -728,6 +776,7 @@ static void cleanup_spu_base(void)
 	list_for_each_entry_safe(spu, tmp, &spu_list, list)
 		destroy_spu(spu);
 	mutex_unlock(&spu_mutex);
+	sysdev_class_unregister(&spu_sysdev_class);
 }
 module_exit(cleanup_spu_base);
 
@@ -736,6 +785,11 @@ static int __init init_spu_base(void)
 	struct device_node *node;
 	int ret;
 
+	/* create sysdev class for spus */
+	ret = sysdev_class_register(&spu_sysdev_class);
+	if (ret)
+		return ret;
+
 	ret = -ENODEV;
 	for (node = of_find_node_by_type(NULL, "spe");
 			node; node = of_find_node_by_type(node, "spe")) {
Index: powerpc.git/include/asm-powerpc/spu.h
===================================================================
--- powerpc.git.orig/include/asm-powerpc/spu.h
+++ powerpc.git/include/asm-powerpc/spu.h
@@ -25,8 +25,8 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-#include <linux/kref.h>
 #include <linux/workqueue.h>
+#include <linux/sysdev.h>
 
 #define LS_SIZE (256 * 1024)
 #define LS_ADDR_MASK (LS_SIZE - 1)
@@ -123,7 +123,6 @@ struct spu {
 	u64 flags;
 	u64 dar;
 	u64 dsisr;
-	struct kref kref;
 	size_t ls_size;
 	unsigned int slb_replace;
 	struct mm_struct *mm;
@@ -144,6 +143,8 @@ struct spu {
 	char irq_c0[8];
 	char irq_c1[8];
 	char irq_c2[8];
+
+	struct sys_device sysdev;
 };
 
 struct spu *spu_alloc(void);

--

