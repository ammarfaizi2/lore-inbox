Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWGLDwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWGLDwD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWGLDwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:52:00 -0400
Received: from xenotime.net ([66.160.160.81]:10726 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932394AbWGLDv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:51:59 -0400
Date: Tue, 11 Jul 2006 20:45:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, akpm <akpm@osdl.org>
Subject: [PATCH -mm] IDE core: must_check fixes
Message-Id: <20060711204555.3b12eba4.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check all __must_check warnings in IDE core.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/ide/ide-probe.c |   25 +++++++++++++++++++++----
 drivers/ide/ide-proc.c  |   22 ++++++++++++++++++----
 drivers/ide/ide.c       |    8 +++++++-
 3 files changed, 46 insertions(+), 9 deletions(-)

--- linux-2618-rc1mm1.orig/drivers/ide/ide.c
+++ linux-2618-rc1mm1/drivers/ide/ide.c
@@ -1994,10 +1994,16 @@ EXPORT_SYMBOL_GPL(ide_bus_type);
  */
 static int __init ide_init(void)
 {
+	int ret;
+
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
 	system_bus_speed = ide_system_bus_speed();
 
-	bus_register(&ide_bus_type);
+	ret = bus_register(&ide_bus_type);
+	if (ret < 0) {
+		printk(KERN_WARNING "IDE: bus_register error: %d\n", ret);
+		return ret;
+	}
 
 	init_ide_data();
 
--- linux-2618-rc1mm1.orig/drivers/ide/ide-probe.c
+++ linux-2618-rc1mm1/drivers/ide/ide-probe.c
@@ -623,6 +623,8 @@ static void hwif_release_dev (struct dev
 
 static void hwif_register (ide_hwif_t *hwif)
 {
+	int ret;
+
 	/* register with global device tree */
 	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	hwif->gendev.driver_data = hwif;
@@ -634,7 +636,10 @@ static void hwif_register (ide_hwif_t *h
 			hwif->gendev.parent = NULL;
 	}
 	hwif->gendev.release = hwif_release_dev;
-	device_register(&hwif->gendev);
+	ret = device_register(&hwif->gendev);
+	if (ret < 0)
+		printk(KERN_WARNING "IDE: %s: device_register error: %d\n",
+			__FUNCTION__, ret);
 }
 
 static int wait_hwif_ready(ide_hwif_t *hwif)
@@ -884,13 +889,19 @@ int probe_hwif_init_with_fixup(ide_hwif_
 
 	if (hwif->present) {
 		u16 unit = 0;
+		int ret;
+
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
 			ide_drive_t *drive = &hwif->drives[unit];
 			/* For now don't attach absent drives, we may
 			   want them on default or a new "empty" class
 			   for hotplug reprobing ? */
 			if (drive->present) {
-				device_register(&drive->gendev);
+				ret = device_register(&drive->gendev);
+				if (ret < 0)
+					printk(KERN_WARNING "IDE: %s: "
+						"device_register error: %d\n",
+						__FUNCTION__, ret);
 			}
 		}
 	}
@@ -1409,8 +1420,14 @@ int ideprobe_init (void)
 			if (hwif->chipset == ide_unknown || hwif->chipset == ide_forced)
 				hwif->chipset = ide_generic;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
-				if (hwif->drives[unit].present)
-					device_register(&hwif->drives[unit].gendev);
+				if (hwif->drives[unit].present) {
+					int ret = device_register(
+						&hwif->drives[unit].gendev);
+					if (ret < 0)
+						printk(KERN_WARNING "IDE: %s: "
+							"device_register error: %d\n",
+							__FUNCTION__, ret);
+				}
 		}
 	}
 	return 0;
--- linux-2618-rc1mm1.orig/drivers/ide/ide-proc.c
+++ linux-2618-rc1mm1/drivers/ide/ide-proc.c
@@ -326,15 +326,24 @@ static int ide_replace_subdriver(ide_dri
 {
 	struct device *dev = &drive->gendev;
 	int ret = 1;
+	int err;
 
 	down_write(&dev->bus->subsys.rwsem);
 	device_release_driver(dev);
 	/* FIXME: device can still be in use by previous driver */
 	strlcpy(drive->driver_req, driver, sizeof(drive->driver_req));
-	device_attach(dev);
+	err = device_attach(dev);
+	if (err < 0)
+		printk(KERN_WARNING "IDE: %s: device_attach error: %d\n",
+			__FUNCTION__, err);
 	drive->driver_req[0] = 0;
-	if (dev->driver == NULL)
-		device_attach(dev);
+	if (dev->driver == NULL) {
+		err = device_attach(dev);
+		if (err < 0)
+			printk(KERN_WARNING
+				"IDE: %s: device_attach(2) error: %d\n",
+				__FUNCTION__, err);
+	}
 	if (dev->driver && !strcmp(dev->driver->name, driver))
 		ret = 0;
 	up_write(&dev->bus->subsys.rwsem);
@@ -524,7 +533,12 @@ static int proc_print_driver(struct devi
 
 static int ide_drivers_show(struct seq_file *s, void *p)
 {
-	bus_for_each_drv(&ide_bus_type, NULL, s, proc_print_driver);
+	int err;
+
+	err = bus_for_each_drv(&ide_bus_type, NULL, s, proc_print_driver);
+	if (err < 0)
+		printk(KERN_WARNING "IDE: %s: bus_for_each_drv error: %d\n",
+			__FUNCTION__, err);
 	return 0;
 }
 


---
