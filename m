Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268655AbUIHQSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268655AbUIHQSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268844AbUIHQSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:18:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42888 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268655AbUIHQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:18:22 -0400
Date: Wed, 8 Sep 2004 11:17:27 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] sgiioc4 driver needs /proc/ide entries
Message-ID: <Pine.SGI.4.53.0409081059500.77854@subway.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes it so the proper /proc/ide files are created when
this driver is loaded.  Previously, /proc/ide would be empty even though
the devices could be used, etc.  This is creating problems for us because
some installers and daemons expect the proc files to be in place.

We're open to comments but would appreciate this being accepted ASAP
as this problem is affecting our progress on some projects.

I verified this exact patch works on 2.6.9-rc1 (and it applies without
fuzz).

One thing I'll probably hear about is that we create /proc/ide/sgiioc4
but don't produce info and metrics for it.  We may elect to produce some
metrics later but this driver is used primarily for the system CDROM and
having metrics there isn't a priority at this moment.  So I create the proc
file anyway but it just reports the type of driver it is.

diffstat:

 drivers/ide/pci/sgiioc4.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+)

Signed-off-by: Erik Jacobson <erikj@sgi.com>


diff -Naru linux-2.6.8-orig/drivers/ide/pci/sgiioc4.c linux-2.6.8/drivers/ide/pci/sgiioc4.c
--- linux-2.6.8-orig/drivers/ide/pci/sgiioc4.c	2004-08-14 01:36:58.000000000 -0400
+++ linux-2.6.8/drivers/ide/pci/sgiioc4.c	2004-09-08 08:40:39.624159397 -0400
@@ -34,6 +34,7 @@
 #include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/blkdev.h>
+#include <linux/proc_fs.h>
 #include <asm/io.h>

 #include <linux/ide.h>
@@ -92,6 +93,27 @@
 #define IOC4_PRD_BYTES       16
 #define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))

+/* Used so we only try to create the /proc/ide/sgiioc4 entry once. */
+static u8 sgiioc4_proc;
+
+/* Produce output for /proc/ide/sgiioc4:
+ * At this point, we don't produce any metrics information.
+ * Still, it seems we should create this so we behave like other IDE
+ * drivers do.  Perhaps someone will write in metrics information some day
+ * and that can be hooked in here.
+ */
+static int sgiioc4_get_info(char *buffer, char **addr, off_t offset, int count)
+{
+	char *p = buffer;
+	int len;
+
+	p += sprintf(p, "\nSGI IOC4 IDE Driver\n");
+	p += sprintf(p, "This space may be used in the future for metrics.\n");
+
+	len = (p - buffer) - offset;
+	*addr = buffer + offset;
+	return len > count ? count : len;
+}

 static void
 sgiioc4_init_hwif_ports(hw_regs_t * hw, unsigned long data_port,
@@ -702,6 +724,10 @@
 		       hwif->name, d->name);

 	probe_hwif_init(hwif);
+
+	/* Create /proc/ide entries */
+	create_proc_ide_interfaces();
+
 	return 0;
 }

@@ -732,6 +758,13 @@

 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
+
+	/* create /proc/ide/sgiioc4 entry */
+	if (!sgiioc4_proc) {
+		ide_pci_create_host_proc("sgiioc4", sgiioc4_get_info);
+		sgiioc4_proc = 1;
+	}
+
 	printk(KERN_INFO "%s: IDE controller at PCI slot %s, revision %d\n",
 			d->name, dev->slot_name, class_rev);
 	if (class_rev < IOC4_SUPPORTED_FIRMWARE_REV) {

