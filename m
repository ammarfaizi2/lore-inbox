Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVKEVij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVKEVij (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 16:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVKEVij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 16:38:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16658 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751070AbVKEVij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 16:38:39 -0500
Date: Sat, 5 Nov 2005 21:38:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DRIVER MODEL] Improved dynamically allocated platform_device interface
Message-ID: <20051105213832.GF12228@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105105628.GE28438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105105628.GE28438@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were a couple of sillies (oops) in the last set of patches.
Here's them all rolled up into one convenient patch and the sillies
fixed.

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
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
+		device_initialize(&pa->pdev.dev);
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
+	device_initialize(&pdev->dev);
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
 
diff --git a/drivers/net/depca.c b/drivers/net/depca.c
--- a/drivers/net/depca.c
+++ b/drivers/net/depca.c
@@ -1470,15 +1470,6 @@ static int __init depca_mca_probe(struct
 ** ISA bus I/O device probe
 */
 
-static void depca_platform_release (struct device *device)
-{
-	struct platform_device *pldev;
-
-	/* free device */
-	pldev = to_platform_device (device);
-	kfree (pldev);
-}
-
 static void __init depca_platform_probe (void)
 {
 	int i;
@@ -1491,19 +1482,16 @@ static void __init depca_platform_probe 
 		 * line, use it (if valid) */
 		if (io && io != depca_io_ports[i].iobase)
 			continue;
-		
-		if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL)))
+
+		pldev = platform_device_alloc(depca_string, i);
+		if (!pldev)
 			continue;
 
-		memset (pldev, 0, sizeof (*pldev));
-		pldev->name = depca_string;
-		pldev->id   = i;
 		pldev->dev.platform_data = (void *) depca_io_ports[i].iobase;
-		pldev->dev.release       = depca_platform_release;
 		depca_io_ports[i].device = pldev;
 
-		if (platform_device_register (pldev)) {
-			kfree (pldev);
+		if (platform_device_add(pldev)) {
+			platform_device_put(pldev);
 			depca_io_ports[i].device = NULL;
 			continue;
 		}
@@ -1515,6 +1503,7 @@ static void __init depca_platform_probe 
 		 * allocated structure */
 			
 			depca_io_ports[i].device = NULL;
+			pldev->dev.platform_data = NULL;
 			platform_device_unregister (pldev);
 		}
 	}
@@ -2112,6 +2101,7 @@ static void __exit depca_module_exit (vo
 
 	for (i = 0; depca_io_ports[i].iobase; i++) {
 		if (depca_io_ports[i].device) {
+			depca_io_ports[i].device->dev.platform_data = NULL;
 			platform_device_unregister (depca_io_ports[i].device);
 			depca_io_ports[i].device = NULL;
 		}
diff --git a/drivers/net/jazzsonic.c b/drivers/net/jazzsonic.c
--- a/drivers/net/jazzsonic.c
+++ b/drivers/net/jazzsonic.c
@@ -285,18 +285,8 @@ static struct device_driver jazz_sonic_d
 	.remove	= __devexit_p(jazz_sonic_device_remove),
 };
 
-static void jazz_sonic_platform_release (struct device *device)
-{
-	struct platform_device *pldev;
-
-	/* free device */
-	pldev = to_platform_device (device);
-	kfree (pldev);
-}
-
 static int __init jazz_sonic_init_module(void)
 {
-	struct platform_device *pldev;
 	int err;
 
 	if ((err = driver_register(&jazz_sonic_driver))) {
@@ -304,27 +294,19 @@ static int __init jazz_sonic_init_module
 		return err;
 	}
 
-	jazz_sonic_device = NULL;
-
-	if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL))) {
+	jazz_sonic_device = platform_device_alloc(jazz_sonic_string, 0);
+	if (!jazz_sonnic_device)
 		goto out_unregister;
-	}
 
-	memset(pldev, 0, sizeof (*pldev));
-	pldev->name		= jazz_sonic_string;
-	pldev->id		= 0;
-	pldev->dev.release	= jazz_sonic_platform_release;
-	jazz_sonic_device	= pldev;
-
-	if (platform_device_register (pldev)) {
-		kfree(pldev);
+	if (platform_device_add(jazz_sonic_device)) {
+		platform_device_put(jazz_sonic_device);
 		jazz_sonic_device = NULL;
 	}
 
 	return 0;
 
 out_unregister:
-	platform_device_unregister(pldev);
+	driver_unregister(&jazz_sonic_driver);
 
 	return -ENOMEM;
 }
diff --git a/drivers/net/macsonic.c b/drivers/net/macsonic.c
--- a/drivers/net/macsonic.c
+++ b/drivers/net/macsonic.c
@@ -599,18 +599,8 @@ static struct device_driver mac_sonic_dr
 	.remove = __devexit_p(mac_sonic_device_remove),
 };
 
-static void mac_sonic_platform_release(struct device *device)
-{
-	struct platform_device *pldev;
-
-	/* free device */
-	pldev = to_platform_device (device);
-	kfree (pldev);
-}
-
 static int __init mac_sonic_init_module(void)
 {
-	struct platform_device *pldev;
 	int err;
 
 	if ((err = driver_register(&mac_sonic_driver))) {
@@ -618,27 +608,20 @@ static int __init mac_sonic_init_module(
 		return err;
 	}
 
-	mac_sonic_device = NULL;
-
-	if (!(pldev = kmalloc (sizeof (*pldev), GFP_KERNEL))) {
+	mac_sonic_device = platform_device_alloc(mac_sonic_string, 0);
+	if (!mac_sonic_device) {
 		goto out_unregister;
 	}
 
-	memset(pldev, 0, sizeof (*pldev));
-	pldev->name		= mac_sonic_string;
-	pldev->id		= 0;
-	pldev->dev.release	= mac_sonic_platform_release;
-	mac_sonic_device	= pldev;
-
-	if (platform_device_register (pldev)) {
-		kfree(pldev);
+	if (platform_device_add(mac_sonic_device)) {
+		platform_device_put(mac_sonic_device);
 		mac_sonic_device = NULL;
 	}
 
 	return 0;
 
 out_unregister:
-	platform_device_unregister(pldev);
+	driver_unregister(&mac_sonic_driver);
 
 	return -ENOMEM;
 }
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -502,10 +502,6 @@ static ssize_t arcfb_write(struct file *
 	return err;
 }
 
-static void arcfb_platform_release(struct device *device)
-{
-}
-
 static struct fb_ops arcfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= arcfb_open,
@@ -624,13 +620,7 @@ static struct device_driver arcfb_driver
 	.remove = arcfb_remove,
 };
 
-static struct platform_device arcfb_device = {
-	.name	= "arcfb",
-	.id	= 0,
-	.dev	= {
-		.release = arcfb_platform_release,
-	}
-};
+static struct platform_device *arcfb_device;
 
 static int __init arcfb_init(void)
 {
@@ -641,9 +631,16 @@ static int __init arcfb_init(void)
 
 	ret = driver_register(&arcfb_driver);
 	if (!ret) {
-		ret = platform_device_register(&arcfb_device);
-		if (ret)
+		arcfb_device = platform_device_alloc("arcfb", 0);
+		if (arcfb_device) {
+			ret = platform_device_add(arcfb_device);
+		} else {
+			ret = -ENOMEM;
+		}
+		if (ret) {
+			platform_device_put(arcfb_device);
 			driver_unregister(&arcfb_driver);
+		}
 	}
 	return ret;
 
@@ -651,7 +648,7 @@ static int __init arcfb_init(void)
 
 static void __exit arcfb_exit(void)
 {
-	platform_device_unregister(&arcfb_device);
+	platform_device_unregister(arcfb_device);
 	driver_unregister(&arcfb_driver);
 }
 
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1260,24 +1260,30 @@ static struct device_driver gbefb_driver
 	.remove = __devexit_p(gbefb_remove),
 };
 
-static struct platform_device gbefb_device = {
-	.name = "gbefb",
-};
+static struct platform_device *gbefb_device;
 
 int __init gbefb_init(void)
 {
 	int ret = driver_register(&gbefb_driver);
 	if (!ret) {
-		ret = platform_device_register(&gbefb_device);
-		if (ret)
+		gbefb_device = platform_device_alloc("gbefb", 0);
+		if (gbefb_device) {
+			ret = platform_device_add(gbefb_device);
+		} else {
+			ret = -ENOMEM;
+		}
+		if (ret) {
+			platform_device_put(gbefb_device);
 			driver_unregister(&gbefb_driver);
+		}
 	}
 	return ret;
 }
 
 void __exit gbefb_exit(void)
 {
-	 driver_unregister(&gbefb_driver);
+	platform_device_unregister(gbefb_device);
+	driver_unregister(&gbefb_driver);
 }
 
 module_init(gbefb_init);
diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -751,10 +751,6 @@ int __init sgivwfb_setup(char *options)
 /*
  *  Initialisation
  */
-static void sgivwfb_release(struct device *device)
-{
-}
-
 static int __init sgivwfb_probe(struct device *device)
 {
 	struct platform_device *dev = to_platform_device(device);
@@ -859,13 +855,7 @@ static struct device_driver sgivwfb_driv
 	.remove	= sgivwfb_remove,
 };
 
-static struct platform_device sgivwfb_device = {
-	.name	= "sgivwfb",
-	.id	= 0,
-	.dev	= {
-		.release = sgivwfb_release,
-	}
-};
+static struct platform_device *sgivwfb_device;
 
 int __init sgivwfb_init(void)
 {
@@ -880,9 +870,15 @@ int __init sgivwfb_init(void)
 #endif
 	ret = driver_register(&sgivwfb_driver);
 	if (!ret) {
-		ret = platform_device_register(&sgivwfb_device);
-		if (ret)
+		sgivwfb_device = platform_device_alloc("sgivwfb", 0);
+		if (sgivwfb_device) {
+			ret = platform_device_add(sgivwfb_device);
+		} else
+			ret = -ENOMEM;
+		if (ret) {
 			driver_unregister(&sgivwfb_driver);
+			platform_device_put(sgivwfb_device);
+		}
 	}
 	return ret;
 }
@@ -894,7 +890,7 @@ MODULE_LICENSE("GPL");
 
 static void __exit sgivwfb_exit(void)
 {
-	platform_device_unregister(&sgivwfb_device);
+	platform_device_unregister(sgivwfb_device);
 	driver_unregister(&sgivwfb_driver);
 }
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -37,4 +37,10 @@ extern int platform_add_devices(struct p
 
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
