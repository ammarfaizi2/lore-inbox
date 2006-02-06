Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWBFUb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWBFUb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWBFUbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:31:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:28349 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964797AbWBFU3h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:37 -0500
Cc: gregkh@suse.de
Subject: [PATCH] DRM: fix up classdev interface for drm core
In-Reply-To: <11392577577@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:17 -0800
Message-Id: <11392577571422@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] DRM: fix up classdev interface for drm core

Current drm code doesn't work with userspace programs that listen only
to the kernel event netlink socket as it is trying to create its own dev
interface.  Turns out lots of code can just be deleted as the driver
core can do all of this work automatically for you.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 0650fd5824e07570f0c43980b81bb23ae917f1d7
tree 97f586939d119045900e84808e5d1b1d2342c08c
parent f67d115fe48f494d4b7f4f2024217fe52578915f
author Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 14:08:59 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:17 -0800

 drivers/char/drm/drmP.h      |   10 +--
 drivers/char/drm/drm_stub.c  |    2 -
 drivers/char/drm/drm_sysfs.c |  129 +++++++++---------------------------------
 3 files changed, 34 insertions(+), 107 deletions(-)

diff --git a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
index 71b8b32..107df9f 100644
--- a/drivers/char/drm/drmP.h
+++ b/drivers/char/drm/drmP.h
@@ -980,7 +980,7 @@ extern int drm_put_head(drm_head_t * hea
 extern unsigned int drm_debug;
 extern unsigned int drm_cards_limit;
 extern drm_head_t **drm_heads;
-extern struct drm_sysfs_class *drm_class;
+extern struct class *drm_class;
 extern struct proc_dir_entry *drm_proc_root;
 
 				/* Proc support (drm_proc.h) */
@@ -1011,11 +1011,9 @@ extern void __drm_pci_free(drm_device_t 
 extern void drm_pci_free(drm_device_t * dev, drm_dma_handle_t * dmah);
 
 			       /* sysfs support (drm_sysfs.c) */
-struct drm_sysfs_class;
-extern struct drm_sysfs_class *drm_sysfs_create(struct module *owner,
-						char *name);
-extern void drm_sysfs_destroy(struct drm_sysfs_class *cs);
-extern struct class_device *drm_sysfs_device_add(struct drm_sysfs_class *cs,
+extern struct class *drm_sysfs_create(struct module *owner, char *name);
+extern void drm_sysfs_destroy(struct class *cs);
+extern struct class_device *drm_sysfs_device_add(struct class *cs,
 						 drm_head_t *head);
 extern void drm_sysfs_device_remove(struct class_device *class_dev);
 
diff --git a/drivers/char/drm/drm_stub.c b/drivers/char/drm/drm_stub.c
index 7a9263f..68073e1 100644
--- a/drivers/char/drm/drm_stub.c
+++ b/drivers/char/drm/drm_stub.c
@@ -50,7 +50,7 @@ module_param_named(cards_limit, drm_card
 module_param_named(debug, drm_debug, int, 0600);
 
 drm_head_t **drm_heads;
-struct drm_sysfs_class *drm_class;
+struct class *drm_class;
 struct proc_dir_entry *drm_proc_root;
 
 static int drm_fill_in_dev(drm_device_t * dev, struct pci_dev *pdev,
diff --git a/drivers/char/drm/drm_sysfs.c b/drivers/char/drm/drm_sysfs.c
index 68e43dd..0b9f98a 100644
--- a/drivers/char/drm/drm_sysfs.c
+++ b/drivers/char/drm/drm_sysfs.c
@@ -1,3 +1,4 @@
+
 /*
  * drm_sysfs.c - Modifications to drm_sysfs_class.c to support
  *               extra sysfs attribute from DRM. Normal drm_sysfs_class
@@ -19,36 +20,6 @@
 #include "drm_core.h"
 #include "drmP.h"
 
-struct drm_sysfs_class {
-	struct class_device_attribute attr;
-	struct class class;
-};
-#define to_drm_sysfs_class(d) container_of(d, struct drm_sysfs_class, class)
-
-struct simple_dev {
-	dev_t dev;
-	struct class_device class_dev;
-};
-#define to_simple_dev(d) container_of(d, struct simple_dev, class_dev)
-
-static void release_simple_dev(struct class_device *class_dev)
-{
-	struct simple_dev *s_dev = to_simple_dev(class_dev);
-	kfree(s_dev);
-}
-
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	struct simple_dev *s_dev = to_simple_dev(class_dev);
-	return print_dev_t(buf, s_dev->dev);
-}
-
-static void drm_sysfs_class_release(struct class *class)
-{
-	struct drm_sysfs_class *cs = to_drm_sysfs_class(class);
-	kfree(cs);
-}
-
 /* Display the version of drm_core. This doesn't work right in current design */
 static ssize_t version_show(struct class *dev, char *buf)
 {
@@ -69,38 +40,16 @@ static CLASS_ATTR(version, S_IRUGO, vers
  * Note, the pointer created here is to be destroyed when finished by making a
  * call to drm_sysfs_destroy().
  */
-struct drm_sysfs_class *drm_sysfs_create(struct module *owner, char *name)
+struct class *drm_sysfs_create(struct module *owner, char *name)
 {
-	struct drm_sysfs_class *cs;
-	int retval;
+	struct class *class;
+
+	class = class_create(owner, name);
+	if (!class)
+		return class;
 
-	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
-	if (!cs) {
-		retval = -ENOMEM;
-		goto error;
-	}
-	memset(cs, 0x00, sizeof(*cs));
-
-	cs->class.name = name;
-	cs->class.class_release = drm_sysfs_class_release;
-	cs->class.release = release_simple_dev;
-
-	cs->attr.attr.name = "dev";
-	cs->attr.attr.mode = S_IRUGO;
-	cs->attr.attr.owner = owner;
-	cs->attr.show = show_dev;
-	cs->attr.store = NULL;
-
-	retval = class_register(&cs->class);
-	if (retval)
-		goto error;
-	class_create_file(&cs->class, &class_attr_version);
-
-	return cs;
-
-      error:
-	kfree(cs);
-	return ERR_PTR(retval);
+	class_create_file(class, &class_attr_version);
+	return class;
 }
 
 /**
@@ -110,12 +59,13 @@ struct drm_sysfs_class *drm_sysfs_create
  * Note, the pointer to be destroyed must have been created with a call to
  * drm_sysfs_create().
  */
-void drm_sysfs_destroy(struct drm_sysfs_class *cs)
+void drm_sysfs_destroy(struct class *class)
 {
-	if ((cs == NULL) || (IS_ERR(cs)))
+	if ((class == NULL) || (IS_ERR(class)))
 		return;
 
-	class_unregister(&cs->class);
+	class_remove_file(class, &class_attr_version);
+	class_destroy(class);
 }
 
 static ssize_t show_dri(struct class_device *class_device, char *buf)
@@ -132,7 +82,7 @@ static struct class_device_attribute cla
 
 /**
  * drm_sysfs_device_add - adds a class device to sysfs for a character driver
- * @cs: pointer to the struct drm_sysfs_class that this device should be registered to.
+ * @cs: pointer to the struct class that this device should be registered to.
  * @dev: the dev_t for the device to be added.
  * @device: a pointer to a struct device that is assiociated with this class device.
  * @fmt: string for the class device's name
@@ -141,46 +91,26 @@ static struct class_device_attribute cla
  * class.  A "dev" file will be created, showing the dev_t for the device.  The
  * pointer to the struct class_device will be returned from the call.  Any further
  * sysfs files that might be required can be created using this pointer.
- * Note: the struct drm_sysfs_class passed to this function must have previously been
+ * Note: the struct class passed to this function must have previously been
  * created with a call to drm_sysfs_create().
  */
-struct class_device *drm_sysfs_device_add(struct drm_sysfs_class *cs,
-					  drm_head_t *head)
+struct class_device *drm_sysfs_device_add(struct class *cs, drm_head_t *head)
 {
-	struct simple_dev *s_dev = NULL;
-	int i, retval;
+	struct class_device *class_dev;
+	int i;
 
-	if ((cs == NULL) || (IS_ERR(cs))) {
-		retval = -ENODEV;
-		goto error;
-	}
-
-	s_dev = kmalloc(sizeof(*s_dev), GFP_KERNEL);
-	if (!s_dev) {
-		retval = -ENOMEM;
-		goto error;
-	}
-	memset(s_dev, 0x00, sizeof(*s_dev));
-
-	s_dev->dev = MKDEV(DRM_MAJOR, head->minor);
-	s_dev->class_dev.dev = &(head->dev->pdev)->dev;
-	s_dev->class_dev.class = &cs->class;
-
-	snprintf(s_dev->class_dev.class_id, BUS_ID_SIZE, "card%d", head->minor);
-	retval = class_device_register(&s_dev->class_dev);
-	if (retval)
-		goto error;
+	class_dev = class_device_create(cs, NULL,
+					MKDEV(DRM_MAJOR, head->minor),
+					&(head->dev->pdev)->dev,
+					"card%d", head->minor);
+	if (!class_dev)
+		return NULL;
 
-	class_device_create_file(&s_dev->class_dev, &cs->attr);
-	class_set_devdata(&s_dev->class_dev, head);
+	class_set_devdata(class_dev, head);
 
 	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_create_file(&s_dev->class_dev, &class_device_attrs[i]);
-	return &s_dev->class_dev;
-
-error:
-	kfree(s_dev);
-	return ERR_PTR(retval);
+		class_device_create_file(class_dev, &class_device_attrs[i]);
+	return class_dev;
 }
 
 /**
@@ -192,10 +122,9 @@ error:
  */
 void drm_sysfs_device_remove(struct class_device *class_dev)
 {
-	struct simple_dev *s_dev = to_simple_dev(class_dev);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_remove_file(&s_dev->class_dev, &class_device_attrs[i]);
-	class_device_unregister(&s_dev->class_dev);
+		class_device_remove_file(class_dev, &class_device_attrs[i]);
+	class_device_unregister(class_dev);
 }

