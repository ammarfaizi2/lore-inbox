Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWAEOcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWAEOcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWAEOcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:32:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52240 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751345AbWAEOcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:32:06 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg K-H <greg@kroah.com>
Subject: [CFT 5/29] Add AMBA bus_type probe/remove/shutdown methods
Date: Thu, 05 Jan 2006 14:32:00 +0000
Message-ID: <20060105142951.13.05@flint.arm.linux.org.uk>
In-reply-to: <20060105142951.13.01@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

---
 arch/arm/common/amba.c |   71 ++++++++++++++++++++++++++-----------------------
 1 files changed, 38 insertions(+), 33 deletions(-)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/arch/arm/common/amba.c linux/arch/arm/common/amba.c
--- linus/arch/arm/common/amba.c	Sun Nov  6 22:14:11 2005
+++ linux/arch/arm/common/amba.c	Sun Nov 13 15:49:25 2005
@@ -61,6 +61,41 @@ static int amba_hotplug(struct device *d
 #define amba_hotplug NULL
 #endif
 
+/*
+ * These are the device model conversion veneers; they convert the
+ * device model structures to our more specific structures.
+ */
+static int amba_probe(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
+	struct amba_id *id;
+	int ret = -ENODEV;
+
+	if (pcdrv->probe) {
+		id = amba_lookup(pcdrv->id_table, pcdev);
+		ret = pcdrv->probe(pcdev, id);
+	}
+	return ret;
+}
+
+static int amba_remove(struct device *dev)
+{
+	struct amba_driver *drv = to_amba_driver(dev->driver);
+	int ret = 0;
+
+	if (drv->remove)
+		ret = drv->remove(to_amba_device(dev));
+	return ret;
+}
+
+static void amba_shutdown(struct device *dev)
+{
+	struct amba_driver *drv = to_amba_driver(dev->driver);
+	if (dev->driver && drv->shutdown)
+		drv->shutdown(to_amba_device(dev));
+}
+
 static int amba_suspend(struct device *dev, pm_message_t state)
 {
 	struct amba_driver *drv = to_amba_driver(dev->driver);
@@ -89,6 +124,9 @@ static struct bus_type amba_bustype = {
 	.name		= "amba",
 	.match		= amba_match,
 	.hotplug	= amba_hotplug,
+	.probe		= amba_probe,
+	.remove		= amba_remove,
+	.shutdown	= amba_shutdown,
 	.suspend	= amba_suspend,
 	.resume		= amba_resume,
 };
@@ -100,33 +138,6 @@ static int __init amba_init(void)
 
 postcore_initcall(amba_init);
 
-/*
- * These are the device model conversion veneers; they convert the
- * device model structures to our more specific structures.
- */
-static int amba_probe(struct device *dev)
-{
-	struct amba_device *pcdev = to_amba_device(dev);
-	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
-	struct amba_id *id;
-
-	id = amba_lookup(pcdrv->id_table, pcdev);
-
-	return pcdrv->probe(pcdev, id);
-}
-
-static int amba_remove(struct device *dev)
-{
-	struct amba_driver *drv = to_amba_driver(dev->driver);
-	return drv->remove(to_amba_device(dev));
-}
-
-static void amba_shutdown(struct device *dev)
-{
-	struct amba_driver *drv = to_amba_driver(dev->driver);
-	drv->shutdown(to_amba_device(dev));
-}
-
 /**
  *	amba_driver_register - register an AMBA device driver
  *	@drv: amba device driver structure
@@ -138,12 +149,6 @@ static void amba_shutdown(struct device 
 int amba_driver_register(struct amba_driver *drv)
 {
 	drv->drv.bus = &amba_bustype;
-
-#define SETFN(fn)	if (drv->fn) drv->drv.fn = amba_##fn
-	SETFN(probe);
-	SETFN(remove);
-	SETFN(shutdown);
-
 	return driver_register(&drv->drv);
 }
 
