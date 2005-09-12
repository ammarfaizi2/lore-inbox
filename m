Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVILWrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVILWrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVILWrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:47:47 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:25287 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S932328AbVILWrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:47:46 -0400
From: Lion Vollnhals <lion.vollnhals@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use kzalloc instead of malloc+memset
Date: Tue, 13 Sep 2005 00:47:43 +0200
User-Agent: KMail/1.8.1
References: <200509130010.38483.lion.vollnhals@web.de>
In-Reply-To: <200509130010.38483.lion.vollnhals@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509130047.43301.lion.vollnhals@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 September 2005 00:10, Lion Vollnhals wrote:
> This patch against 2.6.13-mm3 replaces malloc and memset with kzalloc in
> drivers/base/class.c . 

The following patch converts further kmalllocs and memsets in drivers/base/* to kzallocs.

Please apply.

Signed-off-by: Lion Vollnhals <webmaster@schiggl.de>

diff -Nurp 2.6.13-mm3/drivers/base/attribute_container.c 2.6.13-mm3-changed/drivers/base/attribute_container.c
--- 2.6.13-mm3/drivers/base/attribute_container.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-changed/drivers/base/attribute_container.c	2005-09-13 00:30:59.000000000 +0200
@@ -152,12 +152,13 @@ attribute_container_add_device(struct de
 
 		if (!cont->match(cont, dev))
 			continue;
-		ic = kmalloc(sizeof(struct internal_container), GFP_KERNEL);
+		
+		ic = kzalloc(sizeof(struct internal_container), GFP_KERNEL);
 		if (!ic) {
 			dev_printk(KERN_ERR, dev, "failed to allocate class container\n");
 			continue;
 		}
-		memset(ic, 0, sizeof(struct internal_container));
+		
 		ic->cont = cont;
 		class_device_initialize(&ic->classdev);
 		ic->classdev.dev = get_device(dev);
diff -Nurp 2.6.13-mm3/drivers/base/firmware_class.c 2.6.13-mm3-changed/drivers/base/firmware_class.c
--- 2.6.13-mm3/drivers/base/firmware_class.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-changed/drivers/base/firmware_class.c	2005-09-13 00:26:03.000000000 +0200
@@ -301,9 +301,9 @@ fw_register_class_device(struct class_de
 			 const char *fw_name, struct device *device)
 {
 	int retval;
-	struct firmware_priv *fw_priv = kmalloc(sizeof (struct firmware_priv),
+	struct firmware_priv *fw_priv = kzalloc(sizeof (struct firmware_priv),
 						GFP_KERNEL);
-	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
+	struct class_device *class_dev = kzalloc(sizeof (struct class_device),
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
+	*firmware_p = firmware = kzalloc(sizeof (struct firmware), GFP_KERNEL);
 	if (!firmware) {
 		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
 		       __FUNCTION__);
 		retval = -ENOMEM;
 		goto out;
 	}
-	memset(firmware, 0, sizeof (*firmware));
 
 	retval = fw_setup_class_device(firmware, &class_dev, name, device,
 		hotplug);
diff -Nurp 2.6.13-mm3/drivers/base/map.c 2.6.13-mm3-changed/drivers/base/map.c
--- 2.6.13-mm3/drivers/base/map.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-changed/drivers/base/map.c	2005-09-13 00:16:35.000000000 +0200
@@ -135,7 +135,7 @@ retry:
 struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct semaphore *sem)
 {
 	struct kobj_map *p = kmalloc(sizeof(struct kobj_map), GFP_KERNEL);
-	struct probe *base = kmalloc(sizeof(struct probe), GFP_KERNEL);
+	struct probe *base = kzalloc(sizeof(struct probe), GFP_KERNEL);
 	int i;
 
 	if ((p == NULL) || (base == NULL)) {
@@ -144,7 +144,6 @@ struct kobj_map *kobj_map_init(kobj_prob
 		return NULL;
 	}
 
-	memset(base, 0, sizeof(struct probe));
 	base->dev = 1;
 	base->range = ~0;
 	base->get = base_probe;
diff -Nurp 2.6.13-mm3/drivers/base/memory.c 2.6.13-mm3-changed/drivers/base/memory.c
--- 2.6.13-mm3/drivers/base/memory.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-changed/drivers/base/memory.c	2005-09-13 00:31:55.000000000 +0200
@@ -341,14 +341,12 @@ int add_memory_block(unsigned long node_
 		     unsigned long state, int phys_device)
 {
 	size_t size = sizeof(struct memory_block);
-	struct memory_block *mem = kmalloc(size, GFP_KERNEL);
+	struct memory_block *mem = kzalloc(size, GFP_KERNEL);
 	int ret = 0;
 
 	if (!mem)
 		return -ENOMEM;
 
-	memset(mem, 0, size);
-
 	mem->phys_index = __section_nr(section);
 	mem->state = state;
 	init_MUTEX(&mem->state_sem);
diff -Nurp 2.6.13-mm3/drivers/base/platform.c 2.6.13-mm3-changed/drivers/base/platform.c
--- 2.6.13-mm3/drivers/base/platform.c	2005-09-12 23:42:47.000000000 +0200
+++ 2.6.13-mm3-changed/drivers/base/platform.c	2005-09-13 00:23:43.000000000 +0200
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
