Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTJUPMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTJUPLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:11:54 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:38883 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263154AbTJUPKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:10:01 -0400
Date: Tue, 21 Oct 2003 17:10:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (7/8): static root object fix.
Message-ID: <20031021151008.GE1690@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add s390_root_dev_{register,unregister} to fix reference counting
for the root objects of group device drivers.

diffstat:
 drivers/s390/cio/css.c     |   44 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/s390/net/cu3088.c  |   25 +++++++++----------------
 drivers/s390/net/iucv.c    |   28 ++++++++++++----------------
 drivers/s390/net/iucv.h    |    2 +-
 drivers/s390/net/netiucv.c |    8 ++++----
 drivers/s390/net/qeth.c    |   25 +++++++++----------------
 include/asm-s390/ccwdev.h  |    3 +++
 7 files changed, 80 insertions(+), 55 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/css.c linux-2.6-s390/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	Fri Oct 17 23:42:55 2003
+++ linux-2.6-s390/drivers/s390/cio/css.c	Tue Oct 21 16:37:38 2003
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/css.c
  *  driver for channel subsystem
- *   $Revision: 1.49 $
+ *   $Revision: 1.51 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -236,6 +236,46 @@
 
 subsys_initcall(init_channel_subsystem);
 
+/*
+ * Register root devices for some drivers. The release function must not be
+ * in the device drivers, so we do it here.
+ */
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
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(css_bus_type);
-
+EXPORT_SYMBOL(s390_root_dev_register);
+EXPORT_SYMBOL(s390_root_dev_unregister);
diff -urN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-s390/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	Fri Oct 17 23:43:00 2003
+++ linux-2.6-s390/drivers/s390/net/cu3088.c	Tue Oct 21 16:37:38 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.31 2003/09/29 15:24:27 cohuck Exp $
+ * $Id: cu3088.c,v 1.33 2003/10/14 12:10:19 cohuck Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -25,6 +25,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/err.h>
 
 #include <asm/ccwdev.h>
 #include <asm/ccwgroup.h>
@@ -55,15 +56,7 @@
 
 static struct ccw_driver cu3088_driver;
 
-static void
-cu3088_root_dev_release (struct device *dev)
-{
-}
-
-struct device cu3088_root_dev = {
-	.bus_id = "cu3088",
-	.release = cu3088_root_dev_release,
-};
+struct device *cu3088_root_dev;
 
 static ssize_t
 group_write(struct device_driver *drv, const char *buf, size_t count)
@@ -90,7 +83,7 @@
 		start = end + 1;
 	}
 
-	ret = ccwgroup_create(&cu3088_root_dev, cdrv->driver_id,
+	ret = ccwgroup_create(cu3088_root_dev, cdrv->driver_id,
 			      &cu3088_driver, 2, argv);
 
 	return (ret == 0) ? count : ret;
@@ -144,12 +137,12 @@
 {
 	int rc;
 	
-	rc = device_register(&cu3088_root_dev);
-	if (rc)
-		return rc;
+	cu3088_root_dev = s390_root_dev_register("cu3088");
+	if (IS_ERR(cu3088_root_dev))
+		return PTR_ERR(cu3088_root_dev);
 	rc = ccw_driver_register(&cu3088_driver);
 	if (rc)
-		device_unregister(&cu3088_root_dev);
+		s390_root_dev_unregister(cu3088_root_dev);
 
 	return rc;
 }
@@ -158,7 +151,7 @@
 cu3088_exit (void)
 {
 	ccw_driver_unregister(&cu3088_driver);
-	device_unregister(&cu3088_root_dev);
+	s390_root_dev_unregister(cu3088_root_dev);
 }
 
 MODULE_DEVICE_TABLE(ccw,cu3088_ids);
diff -urN linux-2.6/drivers/s390/net/iucv.c linux-2.6-s390/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	Fri Oct 17 23:42:54 2003
+++ linux-2.6-s390/drivers/s390/net/iucv.c	Tue Oct 21 16:37:38 2003
@@ -1,5 +1,5 @@
 /* 
- * $Id: iucv.c,v 1.15 2003/10/01 09:25:15 mschwide Exp $
+ * $Id: iucv.c,v 1.17 2003/10/14 12:10:19 cohuck Exp $
  *
  * IUCV network driver
  *
@@ -29,7 +29,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.15 $
+ * RELEASE-TAG: IUCV lowlevel driver $Revision: 1.17 $
  *
  */
 
@@ -44,12 +44,14 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/device.h>
 #include <asm/atomic.h>
 #include "iucv.h"
 #include <asm/io.h>
 #include <asm/s390_ext.h>
 #include <asm/ebcdic.h>
+#include <asm/ccwdev.h> //for root device stuff
 
 #define DEBUG
 
@@ -79,20 +81,12 @@
 	return 0;
 }
 
-static void
-iucv_root_release (struct device *dev)
-{
-}
-
 struct bus_type iucv_bus = {
 	.name = "iucv",
 	.match = iucv_bus_match,
 };	
 
-struct device iucv_root = {
-	.bus_id = "iucv",
-	.release = iucv_root_release,
-};
+struct device *iucv_root;
 
 /* General IUCV interrupt structure */
 typedef struct {
@@ -355,7 +349,7 @@
 static void
 iucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.15 $";
+	char vbuf[] = "$Revision: 1.17 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -387,11 +381,11 @@
 		return ret;
 	}
 
-	ret = device_register(&iucv_root);
-	if (ret != 0) {
+	iucv_root = s390_root_dev_register("iucv");
+	if (IS_ERR(iucv_root)) {
 		printk(KERN_ERR "IUCV: failed to register iucv root.\n");
 		bus_unregister(&iucv_bus);
-		return ret;
+		return PTR_ERR(iucv_root);
 	}
 
 	/* Note: GFP_DMA used used to get memory below 2G */
@@ -401,6 +395,7 @@
 		printk(KERN_WARNING
 		       "%s: Could not allocate external interrupt buffer\n",
 		       __FUNCTION__);
+		s390_root_dev_unregister(iucv_root);
 		return -ENOMEM;
 	}
 	memset(iucv_external_int_buffer, 0, sizeof(iucv_GeneralInterrupt));
@@ -413,6 +408,7 @@
 		       __FUNCTION__);
 		kfree(iucv_external_int_buffer);
 		iucv_external_int_buffer = NULL;
+		s390_root_dev_unregister(iucv_root);
 		return -ENOMEM;
 	}
 	memset(iucv_param_pool, 0, sizeof(iucv_param) * PARAM_POOL_SIZE);
@@ -439,7 +435,7 @@
 		kfree(iucv_external_int_buffer);
 	if (iucv_param_pool)
 		kfree(iucv_param_pool);
-	device_unregister(&iucv_root);
+	s390_root_dev_unregister(iucv_root);
 	bus_unregister(&iucv_bus);
 	printk(KERN_INFO "IUCV lowlevel driver unloaded\n");
 }
diff -urN linux-2.6/drivers/s390/net/iucv.h linux-2.6-s390/drivers/s390/net/iucv.h
--- linux-2.6/drivers/s390/net/iucv.h	Fri Oct 17 23:43:36 2003
+++ linux-2.6-s390/drivers/s390/net/iucv.h	Tue Oct 21 16:37:38 2003
@@ -203,7 +203,7 @@
 } iucv_array_t __attribute__ ((aligned (8)));
 
 extern struct bus_type iucv_bus;
-extern struct device iucv_root;
+extern struct device *iucv_root;
 
 /*   -prototypes-    */
 /*                                                                
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Tue Oct 21 16:37:36 2003
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Tue Oct 21 16:37:38 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.27 2003/10/06 18:35:24 mschwide Exp $
+ * $Id: netiucv.c,v 1.28 2003/10/14 11:48:04 cohuck Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.27 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.28 $
  *
  */
 
@@ -1483,7 +1483,7 @@
 
 	snprintf(dev->bus_id, BUS_ID_SIZE, "%s%x", str, ifno);
 	dev->bus = &iucv_bus;
-	dev->parent = &iucv_root;
+	dev->parent = iucv_root;
 
 	ret = device_register(dev);
 
@@ -1729,7 +1729,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.27 $";
+	char vbuf[] = "$Revision: 1.28 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Tue Oct 21 16:37:38 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Tue Oct 21 16:37:38 2003
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth.c ($Revision: 1.163 $)
+ * linux/drivers/s390/net/qeth.c ($Revision: 1.165 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -165,7 +165,7 @@
 		 "reserved for low memory situations");
 
 /****************** MODULE STUFF **********************************/
-#define VERSION_QETH_C "$Revision: 1.163 $"
+#define VERSION_QETH_C "$Revision: 1.165 $"
 static const char *version = "qeth S/390 OSA-Express driver ("
     VERSION_QETH_C "/" VERSION_QETH_H "/" VERSION_QETH_MPC_H
     QETH_VERSION_IPV6 QETH_VERSION_VLAN ")";
@@ -9798,15 +9798,7 @@
 	.remove = ccwgroup_remove_ccwdev,
 };
 
-static void
-qeth_root_dev_release (struct device *dev)
-{
-}
-
-static struct device qeth_root_dev = {
-	.bus_id = "qeth",
-	.release = qeth_root_dev_release,
-};
+static struct device *qeth_root_dev;
 
 static struct ccwgroup_driver qeth_ccwgroup_driver;
 static ssize_t
@@ -9832,7 +9824,7 @@
 	}
 	pr_debug("creating qeth group device from '%s', '%s' and '%s'\n",
 		 bus_ids[0], bus_ids[1], bus_ids[2]);
-	ccwgroup_create(&qeth_root_dev, qeth_ccwgroup_driver.driver_id,
+	ccwgroup_create(qeth_root_dev, qeth_ccwgroup_driver.driver_id,
 			&qeth_ccw_driver, 3, argv);
 	return count;
 }
@@ -10792,10 +10784,11 @@
 	if (result)
 		goto out_cdrv;
 
-	result = device_register(&qeth_root_dev);
-	if (result)
+	qeth_root_dev = s390_root_dev_register("qeth");
+	if (IS_ERR(qeth_root_dev)) {
+		result = PTR_ERR(qeth_root_dev);
 		goto out_file;
-
+	}
 	qeth_register_notifiers();
 	qeth_add_procfs_entries();
 
@@ -10834,7 +10827,7 @@
 	driver_remove_file(&qeth_ccwgroup_driver.driver, &driver_attr_group);
 	ccw_driver_unregister(&qeth_ccw_driver);
 	ccwgroup_driver_unregister(&qeth_ccwgroup_driver);
-	device_unregister(&qeth_root_dev);
+	s390_root_dev_unregister(qeth_root_dev);
 
 	while (firstcard) {
 		struct qeth_card *card = firstcard;
diff -urN linux-2.6/include/asm-s390/ccwdev.h linux-2.6-s390/include/asm-s390/ccwdev.h
--- linux-2.6/include/asm-s390/ccwdev.h	Fri Oct 17 23:43:28 2003
+++ linux-2.6-s390/include/asm-s390/ccwdev.h	Tue Oct 21 16:37:38 2003
@@ -167,4 +167,7 @@
 extern int _ccw_device_get_device_number(struct ccw_device *);
 extern int _ccw_device_get_subchannel_number(struct ccw_device *);
 
+extern struct device *s390_root_dev_register(const char *);
+extern void s390_root_dev_unregister(struct device *);
+
 #endif /* _S390_CCWDEV_H_ */
