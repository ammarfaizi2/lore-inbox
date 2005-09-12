Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVILXvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVILXvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVILXvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:51:22 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:38554 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S932213AbVILXvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:51:21 -0400
From: Lion Vollnhals <lion.vollnhals@web.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drivers/base/*: use kzalloc instead of kmalloc+memset
Date: Tue, 13 Sep 2005 01:51:18 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130151.18867.lion.vollnhals@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, against 2.6.13-mm3, replaces kmalloc and memset with kzalloc in drivers/base/* .
My prior kzalloc patches are included in this patch.
Jiri Slaby's hints / changes are also included.

Furthermore this patch fixes actually two bugs in drivers/base/class.c:
  The memset arguments were occasionally swaped and therefore wrong.

Usage of kzalloc makes this code shorter and more bugfree.

This patch is proof-read and compile-tested.

Please apply.


Signed-off-by: Lion Vollnhals <webmaster@schiggl.de>

diff -Nurp 2.6.13-mm3/drivers/base/attribute_container.c 2.6.13-mm3-patched/drivers/base/attribute_container.c
--- 2.6.13-mm3/drivers/base/attribute_container.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-patched/drivers/base/attribute_container.c	2005-09-13 01:28:09.000000000 +0200
@@ -152,12 +152,13 @@ attribute_container_add_device(struct de
 
 		if (!cont->match(cont, dev))
 			continue;
-		ic = kmalloc(sizeof(struct internal_container), GFP_KERNEL);
+		
+		ic = kzalloc(sizeof(*ic), GFP_KERNEL);
 		if (!ic) {
 			dev_printk(KERN_ERR, dev, "failed to allocate class container\n");
 			continue;
 		}
-		memset(ic, 0, sizeof(struct internal_container));
+		
 		ic->cont = cont;
 		class_device_initialize(&ic->classdev);
 		ic->classdev.dev = get_device(dev);
diff -Nurp 2.6.13-mm3/drivers/base/class.c 2.6.13-mm3-patched/drivers/base/class.c
--- 2.6.13-mm3/drivers/base/class.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-patched/drivers/base/class.c	2005-09-13 01:28:09.000000000 +0200
@@ -190,12 +190,11 @@ struct class *class_create(struct module
 	struct class *cls;
 	int retval;
 
-	cls = kmalloc(sizeof(struct class), GFP_KERNEL);
+	cls = kzalloc(sizeof(*cls), GFP_KERNEL);
 	if (!cls) {
 		retval = -ENOMEM;
 		goto error;
 	}
-	memset(cls, 0x00, sizeof(struct class));
 
 	cls->name = name;
 	cls->owner = owner;
@@ -519,13 +518,13 @@ int class_device_add(struct class_device
 	/* add the needed attributes to this device */
 	if (MAJOR(class_dev->devt)) {
 		struct class_device_attribute *attr;
-		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
 			kobject_del(&class_dev->kobj);
 			goto register_done;
 		}
-		memset(attr, sizeof(*attr), 0x00);
+		
 		attr->attr.name = "dev";
 		attr->attr.mode = S_IRUGO;
 		attr->attr.owner = parent->owner;
@@ -534,13 +533,13 @@ int class_device_add(struct class_device
 		class_device_create_file(class_dev, attr);
 		class_dev->devt_attr = attr;
 
-		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 		if (!attr) {
 			error = -ENOMEM;
 			kobject_del(&class_dev->kobj);
 			goto register_done;
 		}
-		memset(attr, sizeof(*attr), 0x00);
+		
 		attr->attr.name = "sample.sh";
 		attr->attr.mode = S_IRUSR | S_IXUSR | S_IRUGO;
 		attr->attr.owner = parent->owner;
@@ -611,12 +610,11 @@ struct class_device *class_device_create
 	if (cls == NULL || IS_ERR(cls))
 		goto error;
 
-	class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
+	class_dev = kzalloc(sizeof(*class_dev), GFP_KERNEL);
 	if (!class_dev) {
 		retval = -ENOMEM;
 		goto error;
 	}
-	memset(class_dev, 0x00, sizeof(struct class_device));
 
 	class_dev->devt = devt;
 	class_dev->dev = device;
diff -Nurp 2.6.13-mm3/drivers/base/firmware_class.c 2.6.13-mm3-patched/drivers/base/firmware_class.c
--- 2.6.13-mm3/drivers/base/firmware_class.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-patched/drivers/base/firmware_class.c	2005-09-13 01:28:09.000000000 +0200
@@ -301,9 +301,9 @@ fw_register_class_device(struct class_de
 			 const char *fw_name, struct device *device)
 {
 	int retval;
-	struct firmware_priv *fw_priv = kmalloc(sizeof (struct firmware_priv),
+	struct firmware_priv *fw_priv = kzalloc(sizeof(*fw_priv),
 						GFP_KERNEL);
-	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
+	struct class_device *class_dev = kzalloc(sizeof(*class_dev),
 						 GFP_KERNEL);
 
 	*class_dev_p = NULL;
@@ -313,8 +313,6 @@ fw_register_class_device(struct class_de
 		retval = -ENOMEM;
 		goto error_kfree;
 	}
-	memset(fw_priv, 0, sizeof (*fw_priv));
-	memset(class_dev, 0, sizeof (*class_dev));
 
 	init_completion(&fw_priv->completion);
 	fw_priv->attr_data = firmware_attr_data_tmpl;
@@ -402,14 +400,13 @@ _request_firmware(const struct firmware 
 	if (!firmware_p)
 		return -EINVAL;
 
-	*firmware_p = firmware = kmalloc(sizeof (struct firmware), GFP_KERNEL);
+	*firmware_p = firmware = kzalloc(sizeof(*firmware), GFP_KERNEL);
 	if (!firmware) {
 		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
 		       __FUNCTION__);
 		retval = -ENOMEM;
 		goto out;
 	}
-	memset(firmware, 0, sizeof (*firmware));
 
 	retval = fw_setup_class_device(firmware, &class_dev, name, device,
 		hotplug);
diff -Nurp 2.6.13-mm3/drivers/base/map.c 2.6.13-mm3-patched/drivers/base/map.c
--- 2.6.13-mm3/drivers/base/map.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-patched/drivers/base/map.c	2005-09-13 01:28:09.000000000 +0200
@@ -135,7 +135,7 @@ retry:
 struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct semaphore *sem)
 {
 	struct kobj_map *p = kmalloc(sizeof(struct kobj_map), GFP_KERNEL);
-	struct probe *base = kmalloc(sizeof(struct probe), GFP_KERNEL);
+	struct probe *base = kzalloc(sizeof(*base), GFP_KERNEL);
 	int i;
 
 	if ((p == NULL) || (base == NULL)) {
@@ -144,7 +144,6 @@ struct kobj_map *kobj_map_init(kobj_prob
 		return NULL;
 	}
 
-	memset(base, 0, sizeof(struct probe));
 	base->dev = 1;
 	base->range = ~0;
 	base->get = base_probe;
diff -Nurp 2.6.13-mm3/drivers/base/memory.c 2.6.13-mm3-patched/drivers/base/memory.c
--- 2.6.13-mm3/drivers/base/memory.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-patched/drivers/base/memory.c	2005-09-13 01:28:38.000000000 +0200
@@ -340,15 +340,12 @@ static int memory_probe_init(void)
 int add_memory_block(unsigned long node_id, struct mem_section *section,
 		     unsigned long state, int phys_device)
 {
-	size_t size = sizeof(struct memory_block);
-	struct memory_block *mem = kmalloc(size, GFP_KERNEL);
+	struct memory_block *mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	int ret = 0;
 
 	if (!mem)
 		return -ENOMEM;
 
-	memset(mem, 0, size);
-
 	mem->phys_index = __section_nr(section);
 	mem->state = state;
 	init_MUTEX(&mem->state_sem);
diff -Nurp 2.6.13-mm3/drivers/base/platform.c 2.6.13-mm3-patched/drivers/base/platform.c
--- 2.6.13-mm3/drivers/base/platform.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-patched/drivers/base/platform.c	2005-09-13 01:28:09.000000000 +0200
@@ -225,13 +225,12 @@ struct platform_device *platform_device_
 	struct platform_object *pobj;
 	int retval;
 
-	pobj = kmalloc(sizeof(struct platform_object) + sizeof(struct resource) * num, GFP_KERNEL);
+	pobj = kzalloc(sizeof(struct platform_object) + sizeof(struct resource) * num, GFP_KERNEL);
 	if (!pobj) {
 		retval = -ENOMEM;
 		goto error;
 	}
 
-	memset(pobj, 0, sizeof(*pobj));
 	pobj->pdev.name = name;
 	pobj->pdev.id = id;
 	pobj->pdev.dev.release = platform_device_release_simple;
