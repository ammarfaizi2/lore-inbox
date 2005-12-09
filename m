Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVLIPXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVLIPXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVLIPXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:23:49 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:49657 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932251AbVLIPXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:23:46 -0500
Date: Fri, 9 Dec 2005 16:23:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cotte@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 3/17] s390: move s390_root_dev_* out of the cio layer.
Message-ID: <20051209152345.GD6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Otte <cotte@de.ibm.com>

[patch 3/17] s390: move s390_root_dev_* out of the cio layer.

Extract the s390_root_dev_* functions from the common I/O layer as they
are also used by non-ccw device drivers.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/Makefile        |    2 -
 drivers/s390/block/dcssblk.c |    2 -
 drivers/s390/cio/css.c       |   41 ---------------------------------
 drivers/s390/net/cu3088.c    |    3 +-
 drivers/s390/net/iucv.c      |    2 -
 drivers/s390/net/qeth_main.c |    1 
 drivers/s390/s390_rdev.c     |   53 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/ccwdev.h    |    3 --
 include/asm-s390/s390_rdev.h |   15 ++++++++++++
 9 files changed, 74 insertions(+), 48 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dcssblk.c linux-2.6-patched/drivers/s390/block/dcssblk.c
--- linux-2.6/drivers/s390/block/dcssblk.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dcssblk.c	2005-12-09 14:24:22.000000000 +0100
@@ -15,7 +15,7 @@
 #include <asm/io.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
-#include <asm/ccwdev.h> 	// for s390_root_dev_(un)register()
+#include <asm/s390_rdev.h>
 
 //#define DCSSBLK_DEBUG		/* Debug messages on/off */
 #define DCSSBLK_NAME "dcssblk"
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/css.c	2005-12-09 14:24:22.000000000 +0100
@@ -481,45 +481,6 @@ struct bus_type css_bus_type = {
 
 subsys_initcall(init_channel_subsystem);
 
-/*
- * Register root devices for some drivers. The release function must not be
- * in the device drivers, so we do it here.
- */
-static void
-s390_root_dev_release(struct device *dev)
-{
-	kfree(dev);
-}
-
-struct device *
-s390_root_dev_register(const char *name)
-{
-	struct device *dev;
-	int ret;
-
-	if (!strlen(name))
-		return ERR_PTR(-EINVAL);
-	dev = kmalloc(sizeof(struct device), GFP_KERNEL);
-	if (!dev)
-		return ERR_PTR(-ENOMEM);
-	memset(dev, 0, sizeof(struct device));
-	strncpy(dev->bus_id, name, min(strlen(name), (size_t)BUS_ID_SIZE));
-	dev->release = s390_root_dev_release;
-	ret = device_register(dev);
-	if (ret) {
-		kfree(dev);
-		return ERR_PTR(ret);
-	}
-	return dev;
-}
-
-void
-s390_root_dev_unregister(struct device *dev)
-{
-	if (dev)
-		device_unregister(dev);
-}
-
 int
 css_enqueue_subchannel_slow(unsigned long schid)
 {
@@ -564,6 +525,4 @@ css_slow_subchannels_exist(void)
 
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(css_bus_type);
-EXPORT_SYMBOL(s390_root_dev_register);
-EXPORT_SYMBOL(s390_root_dev_unregister);
 EXPORT_SYMBOL_GPL(css_characteristics_avail);
diff -urpN linux-2.6/drivers/s390/Makefile linux-2.6-patched/drivers/s390/Makefile
--- linux-2.6/drivers/s390/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/Makefile	2005-12-09 14:24:22.000000000 +0100
@@ -2,7 +2,7 @@
 # Makefile for the S/390 specific device drivers
 #
 
-obj-y += s390mach.o sysinfo.o
+obj-y += s390mach.o sysinfo.o s390_rdev.o
 obj-y += cio/ block/ char/ crypto/ net/ scsi/
 
 drivers-y += drivers/s390/built-in.o
diff -urpN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-patched/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/cu3088.c	2005-12-09 14:24:22.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.35 2005/03/30 19:28:52 richtera Exp $
+ * $Id: cu3088.c,v 1.36 2005/10/25 14:37:17 cohuck Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 
+#include <asm/s390_rdev.h>
 #include <asm/ccwdev.h>
 #include <asm/ccwgroup.h>
 
diff -urpN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2005-12-09 14:24:15.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2005-12-09 14:24:22.000000000 +0100
@@ -54,7 +54,7 @@
 #include <asm/s390_ext.h>
 #include <asm/ebcdic.h>
 #include <asm/smp.h>
-#include <asm/ccwdev.h> //for root device stuff
+#include <asm/s390_rdev.h>
 
 /* FLAGS:
  * All flags are defined in the field IPFLAGS1 of each function
diff -urpN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2005-12-09 14:24:15.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-12-09 14:24:22.000000000 +0100
@@ -65,6 +65,7 @@
 #include <asm/timex.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
+#include <asm/s390_rdev.h>
 
 #include "qeth.h"
 #include "qeth_mpc.h"
diff -urpN linux-2.6/drivers/s390/s390_rdev.c linux-2.6-patched/drivers/s390/s390_rdev.c
--- linux-2.6/drivers/s390/s390_rdev.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/s390_rdev.c	2005-12-09 14:24:22.000000000 +0100
@@ -0,0 +1,53 @@
+/*
+ *  drivers/s390/s390_rdev.c
+ *  s390 root device
+ *   $Revision: 1.2 $
+ *
+ *    Copyright (C) 2002, 2005 IBM Deutschland Entwicklung GmbH,
+ *			 IBM Corporation
+ *    Author(s): Cornelia Huck (cohuck@de.ibm.com)
+ *		  Carsten Otte  (cotte@de.ibm.com)
+ */
+
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <asm/s390_rdev.h>
+
+static void
+s390_root_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+struct device *
+s390_root_dev_register(const char *name)
+{
+	struct device *dev;
+	int ret;
+
+	if (!strlen(name))
+		return ERR_PTR(-EINVAL);
+	dev = kmalloc(sizeof(struct device), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+	memset(dev, 0, sizeof(struct device));
+	strncpy(dev->bus_id, name, min(strlen(name), (size_t)BUS_ID_SIZE));
+	dev->release = s390_root_dev_release;
+	ret = device_register(dev);
+	if (ret) {
+		kfree(dev);
+		return ERR_PTR(ret);
+	}
+	return dev;
+}
+
+void
+s390_root_dev_unregister(struct device *dev)
+{
+	if (dev)
+		device_unregister(dev);
+}
+
+EXPORT_SYMBOL(s390_root_dev_register);
+EXPORT_SYMBOL(s390_root_dev_unregister);
diff -urpN linux-2.6/include/asm-s390/ccwdev.h linux-2.6-patched/include/asm-s390/ccwdev.h
--- linux-2.6/include/asm-s390/ccwdev.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/ccwdev.h	2005-12-09 14:24:22.000000000 +0100
@@ -185,8 +185,5 @@ extern struct ccw_device *ccw_device_pro
 extern int _ccw_device_get_device_number(struct ccw_device *);
 extern int _ccw_device_get_subchannel_number(struct ccw_device *);
 
-extern struct device *s390_root_dev_register(const char *);
-extern void s390_root_dev_unregister(struct device *);
-
 extern void *ccw_device_get_chp_desc(struct ccw_device *, int);
 #endif /* _S390_CCWDEV_H_ */
diff -urpN linux-2.6/include/asm-s390/s390_rdev.h linux-2.6-patched/include/asm-s390/s390_rdev.h
--- linux-2.6/include/asm-s390/s390_rdev.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/s390_rdev.h	2005-12-09 14:24:22.000000000 +0100
@@ -0,0 +1,15 @@
+/*
+ *  include/asm-s390/ccwdev.h
+ *
+ *    Copyright (C) 2002,2005 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Author(s): Cornelia Huck <cohuck@de.ibm.com>
+ *               Carsten Otte  <cotte@de.ibm.com>
+ *
+ *  Interface for s390 root device
+ */
+
+#ifndef _S390_RDEV_H_
+#define _S390_RDEV_H_
+extern struct device *s390_root_dev_register(const char *);
+extern void s390_root_dev_unregister(struct device *);
+#endif /* _S390_RDEV_H_ */
