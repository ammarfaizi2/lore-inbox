Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUCaRKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUCaRKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:10:54 -0500
Received: from tench.street-vision.com ([212.18.235.100]:41120 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S262124AbUCaRKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:10:06 -0500
Subject: [PATCH] libata transport attributes
From: Justin Cormack <justin@street-vision.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>,
       mort@wildopensource.com
Content-Type: multipart/mixed; boundary="=-g3Mm97TrEUV4P8dRT9a8"
Message-Id: <1080752942.27347.43.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Mar 2004 18:09:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g3Mm97TrEUV4P8dRT9a8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a rough patch to add libata transport attributes, along the
lines of fibre channel and parallel scsi. I wrote it as it seemed to be
the cleanest way of extracting ata-specific information (currently drive
model, serial number and firmware revision) from sysfs (in
/sys/class/libata_transport/). There are a few issues, in particular:

1. it wont compile modular, as libata depends on scsi_transport_libata
and vice-versa at the moment. I am not sure how you are supposed to get
around this (and there arent any significant number of drivers in tree
using the transport modules yet).

2. It would be nice if the device directory in sysfs had a symlink to
the transport attributes directory, not just the other way round.

3. I couldnt work out what scsi_transport_template.size was the size of,
as I couldnt see where it was used anywhere...

patch against 2.6.5-rc3-libata1 but probably applies against most recent
kernels.

Justin Cormack


--=-g3Mm97TrEUV4P8dRT9a8
Content-Disposition: attachment; filename=patch-libata-transport
Content-Type: text/x-patch; name=patch-libata-transport; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.5-rc3-libata1-orig/drivers/scsi/Kconfig linux-2.6.5-rc3-libata1/drivers/scsi/Kconfig
--- linux-2.6.5-rc3-libata1-orig/drivers/scsi/Kconfig	2004-03-31 09:41:24.000000000 +0100
+++ linux-2.6.5-rc3-libata1/drivers/scsi/Kconfig	2004-03-31 09:44:39.024199360 +0100
@@ -214,6 +214,13 @@
 	  each attached FiberChannel device to sysfs, say Y.
 	  Otherwise, say N.
 
+config SCSI_LIBATA_ATTRS
+        tristate "Libata SCSI Transport Attributes"
+        depends on SCSI
+        help
+          If you wish to export transport-specific information about
+          each attached SATA device to sysfs, say Y.  Otherwise, say N.
+
 endmenu
 
 menu "SCSI low-level drivers"
diff -urN linux-2.6.5-rc3-libata1-orig/drivers/scsi/libata-core.c linux-2.6.5-rc3-libata1/drivers/scsi/libata-core.c
--- linux-2.6.5-rc3-libata1-orig/drivers/scsi/libata-core.c	2004-03-31 09:41:24.000000000 +0100
+++ linux-2.6.5-rc3-libata1/drivers/scsi/libata-core.c	2004-03-31 09:46:23.574305328 +0100
@@ -44,6 +44,8 @@
 
 #include "libata.h"
 
+#include <scsi/scsi_transport_libata.h>
+
 static void atapi_cdb_send(struct ata_port *ap);
 static unsigned int ata_busy_sleep (struct ata_port *ap,
 				    unsigned long tmout_pat,
@@ -2938,6 +2940,7 @@
 	host->max_channel = 1;
 	host->unique_id = ata_unique_id++;
 	host->max_cmd_len = 12;
+        host->transportt = &libata_transport_template;
 	scsi_set_device(host, &ent->pdev->dev);
 	scsi_assign_lock(host, &host_set->lock);
 
@@ -3532,3 +3535,4 @@
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
+EXPORT_SYMBOL_GPL(ata_dev_id_string);
diff -urN linux-2.6.5-rc3-libata1-orig/drivers/scsi/Makefile linux-2.6.5-rc3-libata1/drivers/scsi/Makefile
--- linux-2.6.5-rc3-libata1-orig/drivers/scsi/Makefile	2004-03-31 09:41:24.000000000 +0100
+++ linux-2.6.5-rc3-libata1/drivers/scsi/Makefile	2004-03-31 09:43:56.033734904 +0100
@@ -28,6 +28,7 @@
 # --------------------------
 obj-$(CONFIG_SCSI_SPI_ATTRS)	+= scsi_transport_spi.o
 obj-$(CONFIG_SCSI_FC_ATTRS) 	+= scsi_transport_fc.o
+obj-$(CONFIG_SCSI_LIBATA_ATTRS) += scsi_transport_libata.o
 
 
 obj-$(CONFIG_SCSI_AMIGA7XX)	+= amiga7xx.o	53c7xx.o
diff -urN linux-2.6.5-rc3-libata1-orig/drivers/scsi/scsi_transport_libata.c linux-2.6.5-rc3-libata1/drivers/scsi/scsi_transport_libata.c
--- linux-2.6.5-rc3-libata1-orig/drivers/scsi/scsi_transport_libata.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5-rc3-libata1/drivers/scsi/scsi_transport_libata.c	2004-03-31 09:42:42.784870424 +0100
@@ -0,0 +1,116 @@
+/* 
+   Libata transport specific attributes exported to sysfs.
+
+   Copyright (c) 2004 Justin Cormack
+ 
+   The contents of this file are subject to the Open
+   Software License version 1.1 that can be found at
+   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+   by reference.
+
+   Alternatively, the contents of this file may be used under the terms
+   of the GNU General Public License version 2 (the "GPL") as distributed
+   in the kernel source COPYING file, in which case the provisions of
+   the GPL are applicable instead of the above.  If you wish to allow
+   the use of your version of this file only under the terms of the
+   GPL and not to allow others to use your version of this file under
+   the OSL, indicate your decision by deleting the provisions above and
+   replace them with the notice and other provisions required by the GPL.
+   If you do not delete the provisions above, a recipient may use your
+   version of this file under either the OSL or the GPL.
+
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ata.h>
+#include <scsi/scsi.h>
+#include "scsi.h"
+#include "hosts.h"
+#include <linux/libata.h>
+#include "libata.h"
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_transport.h>
+
+static void transport_class_release(struct class_device *class_dev);
+
+struct class libata_transport_class = {
+	.name = "libata_transport",
+	.release = transport_class_release,
+};
+
+static __init int libata_transport_init(void)
+{
+	return class_register(&libata_transport_class);
+}
+
+static void __exit libata_transport_exit(void)
+{
+	class_unregister(&libata_transport_class);
+}
+
+static void transport_class_release(struct class_device *class_dev)
+{
+	struct scsi_device *sdev = transport_class_to_sdev(class_dev);
+	put_device(&sdev->sdev_gendev);
+}
+
+static ssize_t show_libata_transport_string(struct class_device *cdev, char *buf, int offset, int len)
+{
+        struct scsi_device *sdev = transport_class_to_sdev(cdev);
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+
+	ata_dev_id_string(dev, buf, offset, len);
+	buf[len + 1] = '\n';
+	buf[len + 2] = 0;
+
+	return len + 2;
+}
+
+static ssize_t show_libata_transport_model(struct class_device *cdev, char *buf)
+{
+        return show_libata_transport_string(cdev, buf, ATA_ID_PROD_OFS, ATA_PROD_LEN);
+}
+
+static ssize_t show_libata_transport_firmware(struct class_device *cdev, char *buf)
+{
+        return show_libata_transport_string(cdev, buf, ATA_ID_FW_OFS, ATA_FW_LEN);
+}
+
+static ssize_t show_libata_transport_serial(struct class_device *cdev, char *buf)
+{
+        return show_libata_transport_string(cdev, buf, ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
+}
+
+static CLASS_DEVICE_ATTR(model, S_IRUGO, show_libata_transport_model, NULL);
+static CLASS_DEVICE_ATTR(firmware, S_IRUGO, show_libata_transport_firmware, NULL);
+static CLASS_DEVICE_ATTR(serial, S_IRUGO, show_libata_transport_serial, NULL);
+
+struct class_device_attribute *libata_transport_attrs[] = {
+	&class_device_attr_model,
+	&class_device_attr_firmware,
+	&class_device_attr_serial,
+	NULL
+};
+
+struct scsi_transport_template libata_transport_template = {
+        .attrs = libata_transport_attrs,
+	.class = &libata_transport_class,
+	.setup = NULL,
+	.cleanup = NULL,
+	/* what is this the size of? */
+	.size = sizeof(libata_transport_attrs) - sizeof(unsigned long),
+};
+
+EXPORT_SYMBOL(libata_transport_template);
+
+MODULE_AUTHOR("Justin Cormack");
+MODULE_DESCRIPTION("Libata Transport Attributes");
+MODULE_LICENSE("GPL");
+
+module_init(libata_transport_init);
+module_exit(libata_transport_exit);
diff -urN linux-2.6.5-rc3-libata1-orig/include/linux/ata.h linux-2.6.5-rc3-libata1/include/linux/ata.h
--- linux-2.6.5-rc3-libata1-orig/include/linux/ata.h	2004-03-31 09:41:24.000000000 +0100
+++ linux-2.6.5-rc3-libata1/include/linux/ata.h	2004-03-31 09:48:13.945526352 +0100
@@ -39,13 +39,16 @@
 	ATA_ID_WORDS		= 256,
 	ATA_ID_PROD_OFS		= 27,
 	ATA_ID_SERNO_OFS	= 10,
+        ATA_ID_FW_OFS           = 23,
 	ATA_ID_MAJOR_VER	= 80,
 	ATA_ID_PIO_MODES	= 64,
 	ATA_ID_UDMA_MODES	= 88,
 	ATA_ID_PIO4		= (1 << 1),
 
 	ATA_PCI_CTL_OFS		= 2,
+        ATA_PROD_LEN            = 40,
 	ATA_SERNO_LEN		= 20,
+        ATA_FW_LEN              = 8,
 	ATA_UDMA0		= (1 << 0),
 	ATA_UDMA1		= ATA_UDMA0 | (1 << 1),
 	ATA_UDMA2		= ATA_UDMA1 | (1 << 2),
diff -urN linux-2.6.5-rc3-libata1-orig/include/scsi/scsi_transport_libata.h linux-2.6.5-rc3-libata1/include/scsi/scsi_transport_libata.h
--- linux-2.6.5-rc3-libata1-orig/include/scsi/scsi_transport_libata.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.5-rc3-libata1/include/scsi/scsi_transport_libata.h	2004-03-31 09:43:10.491658352 +0100
@@ -0,0 +1,12 @@
+/*
+    Libata transport specific attributes exported to sysfs.
+ */
+
+#ifndef SCSI_TRANSPORT_LIBATA_H
+#define SCSI_TRANSPORT_LIBATA_H
+
+struct scsi_transport_template;
+
+extern struct scsi_transport_template libata_transport_template;
+
+#endif /* SCSI_TRANSPORT_LIBATA_H */

--=-g3Mm97TrEUV4P8dRT9a8--

