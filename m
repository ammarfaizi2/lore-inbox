Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965316AbVKBWaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965316AbVKBWaw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965317AbVKBWaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:30:52 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:43918 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S965316AbVKBWav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:30:51 -0500
Date: Thu, 3 Nov 2005 00:30:50 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] superhyway: multiple block support and VCR rework.
Message-ID: <20051102223050.GC27200@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This extends the API somewhat to allow for platform-specific VCR reading
and writing. Some platforms (like SH4-202) implement the VCR in a split
VCRL and VCRH, but end up being in reverse order or have other quirks
that need to be dealt with, so we add a set of superhyway_ops per-bus to
accomodate this.

We also have to extend the per-device resources somewhat, as some devices
now conveniently split control and data blocks. So we allow a platform to
register its set of SuperHyway devices via superhyway_add_devices() with
the control block always ordered as the first resource (as this is the
one that userspace cares about).

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/sh/superhyway/superhyway-sysfs.c |    2 -
 drivers/sh/superhyway/superhyway.c       |   75 ++++++++++++++++++++++--------
 include/linux/superhyway.h               |   38 +++++++++++++--
 3 files changed, 89 insertions(+), 26 deletions(-)

applies-to: 5fc5d4c409d79b3169d83d4c328594ee04d04e89
6953dc79aabf3938acfe2cb0860a3ea7da08dc54
diff --git a/drivers/sh/superhyway/superhyway-sysfs.c b/drivers/sh/superhyway/superhyway-sysfs.c
index dc119ce..5543433 100644
--- a/drivers/sh/superhyway/superhyway-sysfs.c
+++ b/drivers/sh/superhyway/superhyway-sysfs.c
@@ -30,7 +30,7 @@ superhyway_ro_attr(bot_mb, "0x%02x\n", v
 superhyway_ro_attr(top_mb, "0x%02x\n", vcr.top_mb);
 
 /* Misc */
-superhyway_ro_attr(resource, "0x%08lx\n", resource.start);
+superhyway_ro_attr(resource, "0x%08lx\n", resource[0].start);
 
 struct device_attribute superhyway_dev_attrs[] = {
 	__ATTR_RO(perr_flags),
diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
index 28757cb..7bdab2a 100644
--- a/drivers/sh/superhyway/superhyway.c
+++ b/drivers/sh/superhyway/superhyway.c
@@ -27,19 +27,20 @@ static struct device superhyway_bus_devi
 
 static void superhyway_device_release(struct device *dev)
 {
-	kfree(to_superhyway_device(dev));
+	struct superhyway_device *sdev = to_superhyway_device(dev);
+
+	kfree(sdev->resource);
+	kfree(sdev);
 }
 
 /**
  * superhyway_add_device - Add a SuperHyway module
- * @mod_id: Module ID (taken from MODULE.VCR.MOD_ID).
  * @base: Physical address where module is mapped.
- * @vcr: VCR value.
+ * @sdev: SuperHyway device to add, or NULL to allocate a new one.
+ * @bus: Bus where SuperHyway module resides.
  *
  * This is responsible for adding a new SuperHyway module. This sets up a new
- * struct superhyway_device for the module being added. Each one of @mod_id,
- * @base, and @vcr are registered with the new device for further use
- * elsewhere.
+ * struct superhyway_device for the module being added if @sdev == NULL.
  *
  * Devices are initially added in the order that they are scanned (from the
  * top-down of the memory map), and are assigned an ID based on the order that
@@ -49,28 +50,40 @@ static void superhyway_device_release(st
  * Further work can and should be done in superhyway_scan_bus(), to be sure
  * that any new modules are properly discovered and subsequently registered.
  */
-int superhyway_add_device(unsigned int mod_id, unsigned long base,
-			  unsigned long long vcr)
+int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
+			  struct superhyway_bus *bus)
 {
-	struct superhyway_device *dev;
+	struct superhyway_device *dev = sdev;
 
-	dev = kmalloc(sizeof(struct superhyway_device), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		dev = kmalloc(sizeof(struct superhyway_device), GFP_KERNEL);
+		if (!dev)
+			return -ENOMEM;
 
-	memset(dev, 0, sizeof(struct superhyway_device));
+		memset(dev, 0, sizeof(struct superhyway_device));
+	}
 
-	dev->id.id = mod_id;
-	sprintf(dev->name, "SuperHyway device %04x", dev->id.id);
+	dev->bus = bus;
+	superhyway_read_vcr(dev, base, &dev->vcr);
+
+	if (!dev->resource) {
+		dev->resource = kmalloc(sizeof(struct resource), GFP_KERNEL);
+		if (!dev->resource) {
+			kfree(dev);
+			return -ENOMEM;
+		}
+
+		dev->resource->name	= dev->name;
+		dev->resource->start	= base;
+		dev->resource->end	= dev->resource->start + 0x01000000;
+	}
 
-	dev->vcr		= *((struct vcr_info *)(&vcr));
-	dev->resource.name	= dev->name;
-	dev->resource.start	= base;
-	dev->resource.end	= dev->resource.start + 0x01000000;
 	dev->dev.parent		= &superhyway_bus_device;
 	dev->dev.bus		= &superhyway_bus_type;
 	dev->dev.release	= superhyway_device_release;
+	dev->id.id		= dev->vcr.mod_id;
 
+	sprintf(dev->name, "SuperHyway device %04x", dev->id.id);
 	sprintf(dev->dev.bus_id, "%02x", superhyway_devices);
 
 	superhyway_devices++;
@@ -78,10 +91,31 @@ int superhyway_add_device(unsigned int m
 	return device_register(&dev->dev);
 }
 
+int superhyway_add_devices(struct superhyway_bus *bus,
+			   struct superhyway_device **devices,
+			   int nr_devices)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < nr_devices; i++) {
+		struct superhyway_device *dev = devices[i];
+		ret |= superhyway_add_device(dev->resource[0].start, dev, bus);
+	}
+
+	return ret;
+}
+
 static int __init superhyway_init(void)
 {
+	struct superhyway_bus *bus;
+	int ret = 0;
+
 	device_register(&superhyway_bus_device);
-	return superhyway_scan_bus();
+
+	for (bus = superhyway_channels; bus->ops; bus++)
+		ret |= superhyway_scan_bus(bus);
+
+	return ret;
 }
 
 postcore_initcall(superhyway_init);
@@ -197,6 +231,7 @@ module_exit(superhyway_bus_exit);
 
 EXPORT_SYMBOL(superhyway_bus_type);
 EXPORT_SYMBOL(superhyway_add_device);
+EXPORT_SYMBOL(superhyway_add_devices);
 EXPORT_SYMBOL(superhyway_register_driver);
 EXPORT_SYMBOL(superhyway_unregister_driver);
 
diff --git a/include/linux/superhyway.h b/include/linux/superhyway.h
index c906c5a..17ea468 100644
--- a/include/linux/superhyway.h
+++ b/include/linux/superhyway.h
@@ -19,7 +19,7 @@
  */
 #define SUPERHYWAY_DEVICE_ID_SH5_DMAC	0x0183
 
-struct vcr_info {
+struct superhyway_vcr_info {
 	u8	perr_flags;	/* P-port Error flags */
 	u8	merr_flags;	/* Module Error flags */
 	u16	mod_vers;	/* Module Version */
@@ -28,6 +28,17 @@ struct vcr_info {
 	u8	top_mb;		/* Top Memory block */
 };
 
+struct superhyway_ops {
+	int (*read_vcr)(unsigned long base, struct superhyway_vcr_info *vcr);
+	int (*write_vcr)(unsigned long base, struct superhyway_vcr_info vcr);
+};
+
+struct superhyway_bus {
+	struct superhyway_ops *ops;
+};
+
+extern struct superhyway_bus superhyway_channels[];
+
 struct superhyway_device_id {
 	unsigned int id;
 	unsigned long driver_data;
@@ -55,9 +66,11 @@ struct superhyway_device {
 
 	struct superhyway_device_id id;
 	struct superhyway_driver *drv;
+	struct superhyway_bus *bus;
 
-	struct resource resource;
-	struct vcr_info vcr;
+	int num_resources;
+	struct resource *resource;
+	struct superhyway_vcr_info vcr;
 };
 
 #define to_superhyway_device(d)	container_of((d), struct superhyway_device, dev)
@@ -65,12 +78,27 @@ struct superhyway_device {
 #define superhyway_get_drvdata(d)	dev_get_drvdata(&(d)->dev)
 #define superhyway_set_drvdata(d,p)	dev_set_drvdata(&(d)->dev, (p))
 
-extern int superhyway_scan_bus(void);
+static inline int
+superhyway_read_vcr(struct superhyway_device *dev, unsigned long base,
+		    struct superhyway_vcr_info *vcr)
+{
+	return dev->bus->ops->read_vcr(base, vcr);
+}
+
+static inline int
+superhyway_write_vcr(struct superhyway_device *dev, unsigned long base,
+		     struct superhyway_vcr_info vcr)
+{
+	return dev->bus->ops->write_vcr(base, vcr);
+}
+
+extern int superhyway_scan_bus(struct superhyway_bus *);
 
 /* drivers/sh/superhyway/superhyway.c */
 int superhyway_register_driver(struct superhyway_driver *);
 void superhyway_unregister_driver(struct superhyway_driver *);
-int superhyway_add_device(unsigned int, unsigned long, unsigned long long);
+int superhyway_add_device(unsigned long base, struct superhyway_device *, struct superhyway_bus *);
+int superhyway_add_devices(struct superhyway_bus *bus, struct superhyway_device **devices, int nr_devices);
 
 /* drivers/sh/superhyway/superhyway-sysfs.c */
 extern struct device_attribute superhyway_dev_attrs[];
---
0.99.8.GIT
