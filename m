Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965059AbVLHDCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVLHDCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 22:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVLHDCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 22:02:49 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:14056 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965055AbVLHDCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 22:02:48 -0500
Date: Thu, 8 Dec 2005 03:02:42 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051208030242.GA19923@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The included patch does three things:

1) It adds basic support for binding SCSI and SATA devices to ACPI 
device handles. At the moment this is limited to hosts, and in practice 
it's probably limited to SATA ones (ACPI doesn't spec how SCSI devices 
should appear in the DSDT, so I'm guessing that in general they don't). 
Given a host, you can DEVICE_ACPI_HANDLE(dev) it to get the handle to 
the ACPI device - this should be handy for implementing suspend 
functions, since the methods should be in a standard location underneath 
this.

Support for binding the devices hasn't been implemented yet. I'm not 
entire sure where they should be bound (the target, presumably?), and I 
haven't actually got it to work...

2) It adds support for attaching notification events to the host. These 
can be host-driver specific (they're just part of the host template). 
Whenever the hardware generates an event on that bus, the host will be 
called. I've added one of these to ata_piix (since that's what I have), 
which should really be implemented in the host and only call the generic 
one when appropriate. But still.

3) Adds a generic libata notification handler that currently treats all 
notifications as drive removal/insertion. It then calls Lukasz 
Kosewski's hotplug code to remove/add the drive as appropriate.

Most laptops generate ACPI notifications requesting bus rescans whenever 
a bay drive is inserted or removed. This handles the event 
appropriately. On my Dell d610, removing or plugging the drive results 
in it appearing or disappearing from /proc/scsi/scsi as appropriate.

Patch:

diff -u drivers/scsi/ata_piix.c /tmp/drivers/scsi/ata_piix.c
--- drivers/scsi/ata_piix.c	2005-12-05 14:30:58 +0000
+++ /tmp/drivers/scsi/ata_piix.c	2005-12-08 02:16:59 +0000
@@ -148,6 +148,7 @@
 	.ordered_flush		= 1,
 	.resume			= ata_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
+	.acpi_notify		= ata_acpi_notify,
 };
 
 static const struct ata_port_operations piix_pata_ops = {
diff -u drivers/scsi/libata-core.c /tmp/drivers/scsi/libata-core.c
--- drivers/scsi/libata-core.c	2005-12-08 02:27:02 +0000
+++ /tmp/drivers/scsi/libata-core.c	2005-12-08 02:16:50 +0000
@@ -50,6 +50,7 @@
 #include <linux/workqueue.h>
 #include <linux/jiffies.h>
 #include <linux/scatterlist.h>
+#include <linux/acpi.h>
 #include <scsi/scsi.h>
 #include "scsi_priv.h"
 #include <scsi/scsi_cmnd.h>
@@ -75,9 +76,11 @@
 				unsigned int *xfer_shift_out);
 static void __ata_qc_complete(struct ata_queued_cmd *qc);
 static void ata_pio_error(struct ata_port *ap);
+static int ata_bus_probe(struct ata_port *ap);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
+static struct workqueue_struct *ata_hotplug_wq;
 
 int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
@@ -88,6 +91,17 @@
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+void ata_acpi_notify(acpi_handle device, u32 type, void *data) {
+	struct device *dev = acpi_get_physical_device(device);
+	struct Scsi_Host *shost =  dev_to_shost(dev);
+	struct ata_port *ap = (struct ata_port *) &shost->hostdata[0];
+	
+	if (!ata_bus_probe(ap))
+		ata_hotplug_plug(ap);
+	else
+		ata_hotplug_unplug(ap);
+}
+
 /**
  *	ata_tf_load_pio - send taskfile registers to host controller
  *	@ap: Port to which output is sent
diff -u drivers/scsi/scsi.c /tmp/drivers/scsi/scsi.c
--- drivers/scsi/scsi.c	2005-12-04 16:48:07 +0000
+++ /tmp/drivers/scsi/scsi.c	2005-12-08 02:16:28 +0000
@@ -55,6 +55,7 @@
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/acpi.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -1305,6 +1306,48 @@
 #define unregister_scsi_cpu()
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_ACPI
+static int scsi_acpi_find_device(struct device *dev, acpi_handle *handle)
+{
+	return -ENODEV;
+}
+
+void ata_acpi_notify(acpi_handle handle, u32 type, void *data);
+
+static int scsi_acpi_find_channel(struct device *dev, acpi_handle *handle)
+{
+	int i;
+	struct Scsi_Host *shost;
+	
+	if (sscanf(dev->bus_id, "host%u", &i) != 1) {
+		return -ENODEV;
+	}
+
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), (acpi_integer) i);	
+	if (!*handle)
+		return -ENODEV;
+
+	shost = dev_to_shost(dev);
+	
+	if (shost->hostt->acpi_notify) { 
+		acpi_install_notify_handler(*handle, ACPI_ALL_NOTIFY, &ata_acpi_notify, (void *)i);
+	}
+	
+	return 0;
+}
+
+static struct acpi_bus_type scsi_acpi_bus = {
+	.bus = &scsi_bus_type,
+	.find_bridge = scsi_acpi_find_channel,
+	.find_device = scsi_acpi_find_device,
+};
+
+static __init int scsi_acpi_register(void)
+{
+	return register_acpi_bus_type(&scsi_acpi_bus);
+}
+#endif /* CONFIG_ACPI */
+
 MODULE_DESCRIPTION("SCSI core");
 MODULE_LICENSE("GPL");
 
@@ -1333,6 +1376,11 @@
 	error = scsi_sysfs_register();
 	if (error)
 		goto cleanup_sysctl;
+#ifdef CONFIG_ACPI
+	error = scsi_acpi_register();
+	if (error)
+		goto cleanup_sysfs;
+#endif
 
 	for (i = 0; i < NR_CPUS; i++)
 		INIT_LIST_HEAD(&per_cpu(scsi_done_q, i));
@@ -1343,6 +1391,8 @@
 	printk(KERN_NOTICE "SCSI subsystem initialized\n");
 	return 0;
 
+cleanup_sysfs:
+	scsi_sysfs_unregister();
 cleanup_sysctl:
 	scsi_exit_sysctl();
 cleanup_hosts:
--- include/linux/libata.h	2005-12-05 14:32:50 +0000
+++ /tmp/include/linux/libata.h	2005-12-08 02:35:59 +0000
@@ -453,7 +468,9 @@
 extern int ata_scsi_device_suspend(struct scsi_device *);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
 extern int ata_device_suspend(struct ata_port *, struct ata_device *);
-
+#ifdef CONFIG_ACPI
+extern void ata_acpi_notify(acpi_handle device, u32 type, void *data);
+#endif
 /*
  * Default driver ops implementations
  */
diff -u include/linux/libata.h /tmp/include/linux/libata.h
--- include/linux/libata.h	2005-12-05 14:32:50 +0000
+++ /tmp/include/linux/libata.h	2005-12-08 02:10:03 +0000
@@ -448,12 +463,16 @@
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
+extern void ata_hotplug_unplug(struct ata_port *ap);
+extern void ata_hotplug_plug(struct ata_port *ap);
 extern int ata_ratelimit(void);
 extern int ata_scsi_device_resume(struct scsi_device *);
 extern int ata_scsi_device_suspend(struct scsi_device *);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
 extern int ata_device_suspend(struct ata_port *, struct ata_device *);
-
+#ifdef CONFIG_ACPI
+extern void ata_acpi_notify(acpi_handle device, u32 type, void *data);
+#endif
 /*
  * Default driver ops implementations
  */
diff -u include/scsi/scsi_host.h /tmp/include/scsi/scsi_host.h
--- include/scsi/scsi_host.h	2005-11-14 14:57:13 +0000
+++ /tmp/include/scsi/scsi_host.h	2005-12-08 02:12:14 +0000
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/acpi.h>
 
 struct block_device;
 struct completion;
@@ -300,6 +301,13 @@
 	 */
 	int (*resume)(struct scsi_device *);
 	int (*suspend)(struct scsi_device *);
+	
+#ifdef CONFIG_ACPI
+	/*
+	 * ACPI notification handler
+	 */
+	void (*acpi_notify)(acpi_handle device, u32 type, void *data); 
+#endif
 
 	/*
 	 * Name of proc directory
-- 
Matthew Garrett | mjg59@srcf.ucam.org
