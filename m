Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbVKEK4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbVKEK4f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 05:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVKEK4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 05:56:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751442AbVKEK4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 05:56:34 -0500
Date: Sat, 5 Nov 2005 10:56:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] [DRIVER MODEL] Improved dynamically allocated platform_device interface
Message-ID: <20051105105628.GE28438@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-jig the simple platform device support to allow private data
to be attached to a platform device, as well as allowing the
parent device to be set.

Example usage:

	pdev = platform_device_alloc("mydev", id);
	if (pdev) {
		err = platform_device_add_resources(pdev, &resources,
						    ARRAY_SIZE(resources));
		if (err == 0)
			err = platform_device_add_data(pdev, &platform_data,
						       sizeof(platform_data));
		if (err == 0)
			err = platform_device_add(pdev);
	} else {
		err = -ENOMEM;
	}
	if (err)
		platform_device_put(pdev);

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/base/platform.c linux/drivers/base/platform.c
--- linus/drivers/base/platform.c	Fri Oct 28 21:31:47 2005
+++ linux/drivers/base/platform.c	Sun Oct 30 16:23:09 2005
@@ -116,12 +116,115 @@ int platform_add_devices(struct platform
 	return ret;
 }
 
+struct platform_object {
+	struct platform_device pdev;
+	char name[1];
+};
+
 /**
- *	platform_device_register - add a platform-level device
+ *	platform_device_put
+ *	@pdev:	platform device to free
+ *
+ *	Free all memory associated with a platform device.  This function
+ *	must _only_ be externally called in error cases.  All other usage
+ *	is a bug.
+ */
+void platform_device_put(struct platform_device *pdev)
+{
+	if (pdev)
+		put_device(&pdev->dev);
+}
+EXPORT_SYMBOL_GPL(platform_device_put);
+
+static void platform_device_release(struct device *dev)
+{
+	struct platform_object *pa = container_of(dev, struct platform_object, pdev.dev);
+
+	kfree(pa->pdev.dev.platform_data);
+	kfree(pa->pdev.resource);
+	kfree(pa);
+}
+
+/**
+ *	platform_device_alloc
+ *	@name:	base name of the device we're adding
+ *	@id:    instance id
+ *
+ *	Create a platform device object which can have other objects attached
+ *	to it, and which will have attached objects freed when it is released.
+ */
+struct platform_device *platform_device_alloc(const char *name, unsigned int id)
+{
+	struct platform_object *pa;
+
+	pa = kzalloc(sizeof(struct platform_object) + strlen(name), GFP_KERNEL);
+	if (pa) {
+		strcpy(pa->name, name);
+		pa->pdev.name = pa->name;
+		pa->pdev.id = id;
+		device_initialize(&pa->dev.dev);
+		pa->pdev.dev.release = platform_device_release;
+	}
+
+	return pa ? &pa->pdev : NULL;	
+}
+EXPORT_SYMBOL_GPL(platform_device_alloc);
+
+/**
+ *	platform_device_add_resources
+ *	@pdev:	platform device allocated by platform_device_alloc to add resources to
+ *	@res:   set of resources that needs to be allocated for the device
+ *	@num:	number of resources
+ *
+ *	Add a copy of the resources to the platform device.  The memory
+ *	associated with the resources will be freed when the platform
+ *	device is released.
+ */
+int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num)
+{
+	struct resource *r;
+
+	r = kmalloc(sizeof(struct resource) * num, GFP_KERNEL);
+	if (r) {
+		memcpy(r, res, sizeof(struct resource) * num);
+		pdev->resource = r;
+		pdev->num_resources = num;
+	}
+	return r ? 0 : -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(platform_device_add_resources);
+
+/**
+ *	platform_device_add_data
+ *	@pdev:	platform device allocated by platform_device_alloc to add resources to
+ *	@data:	platform specific data for this platform device
+ *	@size:	size of platform specific data
+ *
+ *	Add a copy of platform specific data to the platform device's platform_data
+ *	pointer.  The memory associated with the platform data will be freed
+ *	when the platform device is released.
+ */
+int platform_device_add_data(struct platform_device *pdev, void *data, size_t size)
+{
+	void *d;
+
+	d = kmalloc(size, GFP_KERNEL);
+	if (d) {
+		memcpy(d, data, size);
+		pdev->dev.platform_data = d;
+	}
+	return d ? 0 : -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(platform_device_add_data);
+
+/**
+ *	platform_device_add - add a platform device to device hierarchy
  *	@pdev:	platform device we're adding
  *
+ *	This is part 2 of platform_device_register(), though may be called
+ *	separately _iff_ pdev was allocated by platform_device_alloc().
  */
-int platform_device_register(struct platform_device * pdev)
+int platform_device_add(struct platform_device *pdev)
 {
 	int i, ret = 0;
 
@@ -174,6 +277,18 @@ int platform_device_register(struct plat
 			release_resource(&pdev->resource[i]);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(platform_device_add);
+
+/**
+ *	platform_device_register - add a platform-level device
+ *	@pdev:	platform device we're adding
+ *
+ */
+int platform_device_register(struct platform_device * pdev)
+{
+	device_init(&pdev->dev);
+	return platform_device_add(pdev);
+}
 
 /**
  *	platform_device_unregister - remove a platform-level device
@@ -197,18 +312,6 @@ void platform_device_unregister(struct p
 	}
 }
 
-struct platform_object {
-        struct platform_device pdev;
-        struct resource resources[0];
-};
-
-static void platform_device_release_simple(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	kfree(container_of(pdev, struct platform_object, pdev));
-}
-
 /**
  *	platform_device_register_simple
  *	@name:  base name of the device we're adding
@@ -225,33 +328,29 @@ static void platform_device_release_simp
 struct platform_device *platform_device_register_simple(char *name, unsigned int id,
 							struct resource *res, unsigned int num)
 {
-	struct platform_object *pobj;
+	struct platform_device *pdev;
 	int retval;
 
-	pobj = kzalloc(sizeof(*pobj) + sizeof(struct resource) * num, GFP_KERNEL);
-	if (!pobj) {
+	pdev = platform_device_alloc(name, id);
+	if (!pdev) {
 		retval = -ENOMEM;
 		goto error;
 	}
 
-	pobj->pdev.name = name;
-	pobj->pdev.id = id;
-	pobj->pdev.dev.release = platform_device_release_simple;
-
 	if (num) {
-		memcpy(pobj->resources, res, sizeof(struct resource) * num);
-		pobj->pdev.resource = pobj->resources;
-		pobj->pdev.num_resources = num;
+		retval = platform_device_add_resources(pdev, res, num);
+		if (retval)
+			goto error;
 	}
 
-	retval = platform_device_register(&pobj->pdev);
+	retval = platform_device_add(pdev);
 	if (retval)
 		goto error;
 
-	return &pobj->pdev;
+	return pdev;
 
 error:
-	kfree(pobj);
+	platform_device_put(pdev);
 	return ERR_PTR(retval);
 }
 
diff -u b/include/linux/platform_device.h b/include/linux/platform_device.h
--- b/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -37,4 +37,10 @@
 
 extern struct platform_device *platform_device_register_simple(char *, unsigned int, struct resource *, unsigned int);
 
+extern struct platform_device *platform_device_alloc(const char *name, unsigned int id);
+extern int platform_device_add_resources(struct platform_device *pdev, struct resource *res, unsigned int num);
+extern int platform_device_add_data(struct platform_device *pdev, void *data, size_t size);
+extern int platform_device_add(struct platform_device *pdev);
+extern void platform_device_put(struct platform_device *pdev);
+
 #endif /* _PLATFORM_DEVICE_H_ */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
