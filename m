Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUIAJ7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUIAJ7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 05:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUIAJ7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 05:59:40 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:31161 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S265973AbUIAJ67 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 05:58:59 -0400
Date: Wed, 01 Sep 2004 09:58:55 +0000
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: 3ware queue depth [was: Re: HIGHMEM4G config for 1GB RAM on
 desktop?]
To: lkml@lpbproductions.com
Cc: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
References: <200408021602.34320.swsnyder@insightbb.com>
	<1094030083l.3189l.2l@traveler> <1094030194l.3189l.3l@traveler>
	<200409010233.31643.lkml@lpbproductions.com>
In-Reply-To: <200409010233.31643.lkml@lpbproductions.com> (from
	lkml@lpbproductions.com on Wed Sep  1 11:33:31 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1094032735l.3189l.7l@traveler>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.09.01 11:33, Matt Heler wrote:
>
> I have a 3ware 7000-2 card. And I noticed the same problem. 
> 
> Actually what I just did now was change the max luns from 254 to 64. 
> Recompiled and booted up. This seems to fix all my problems, and the speed 
> seems to be quite faster then before.

Yes, that is because the queue_depth parameter gets set from
TW_MAX_CMDS_PER_LUN by the 3w-xxxx.c driver ...

I found the 3ware patch. The patch below makes the queue depth
an optional module parameter, makes sure that the initial
nr_requests is twice the size of the queue_depth, and
makes queue_depth writable for the 3ware driver.

Mike.

--- linux-2.6.5-rc2/drivers/scsi/3w-xxxx.c	2004-03-11 03:55:44.000000000 +0100
+++ linux-2.6.5-rc2-dmcong-tw/drivers/scsi/3w-xxxx.c	2004-03-23 14:56:41.000000000 +0100
@@ -13,6 +13,12 @@
    
    Further tiny build fixes and trivial hoovering    Alan Cox
 
+   Parameters (and default):
+
+   3w-xxxx.queue_depth		Queue depth per connected device (254)
+   3w-xxxx.reverse_scan		Set to "1" if you want the driver to detect
+				the 3ware cards in reverse order (0).
+
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; version 2 of the License.
@@ -179,6 +185,10 @@
    1.02.00.036 - Increase character ioctl timeout to 60 seconds.
    1.02.00.037 - Fix tw_ioctl() to handle all non-data ATA passthru cmds
                  for 'smartmontools' support.
+   1.02.00.XXX - Miquel van Smoorenburg - add command line parameters
+                 to set queue_depth/reverse_scan, make queue_depth
+                 sysfs parameter writable, adjust queue nr_requests.
+
 */
 
 #include <linux/module.h>
@@ -205,6 +215,7 @@
 #include <linux/reboot.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/moduleparam.h>
 
 #include <asm/errno.h>
 #include <asm/io.h>
@@ -246,6 +257,13 @@
 TW_Device_Extension *tw_device_extension_list[TW_MAX_SLOT];
 int tw_device_extension_count = 0;
 static int twe_major = -1;
+static int reverse_scan;
+static int queue_depth;
+
+module_param(reverse_scan, int, 0);
+MODULE_PARM_DESC(reverse_scan, "Scan PCI bus in reverse for 3ware cards");
+module_param(queue_depth, int, 0);
+MODULE_PARM_DESC(queue_depth, "Queue depth per device");
 
 /* Functions */
 
@@ -1029,7 +1047,15 @@
 	dprintk(KERN_NOTICE "3w-xxxx: tw_findcards()\n");
 
 	for (i=0;i<TW_NUMDEVICES;i++) {
-		while ((tw_pci_dev = pci_find_device(TW_VENDOR_ID, device[i], tw_pci_dev))) {
+		while (1) {
+			if (reverse_scan)
+				tw_pci_dev = pci_find_device_reverse(
+				TW_VENDOR_ID, device[i], tw_pci_dev);
+			else
+				tw_pci_dev = pci_find_device(
+				TW_VENDOR_ID, device[i], tw_pci_dev);
+			if (!tw_pci_dev)
+				break;
 			j++;
 			if (pci_enable_device(tw_pci_dev))
 				continue;
@@ -1141,14 +1167,6 @@
 			/* Set card status as online */
 			tw_dev->online = 1;
 
-#ifdef CONFIG_3W_XXXX_CMD_PER_LUN
-			tw_host->cmd_per_lun = CONFIG_3W_XXXX_CMD_PER_LUN;
-			if (tw_host->cmd_per_lun > TW_MAX_CMDS_PER_LUN)
-				tw_host->cmd_per_lun = TW_MAX_CMDS_PER_LUN;
-#else
-			/* Use SHT cmd_per_lun here */
-			tw_host->cmd_per_lun = TW_MAX_CMDS_PER_LUN;
-#endif
 			tw_dev->free_head = TW_Q_START;
 			tw_dev->free_tail = TW_Q_START;
 			tw_dev->free_wrap = TW_Q_LENGTH - 1;
@@ -3379,21 +3397,17 @@
 	return 0;
 } /* End tw_shutdown_device() */
 
-/* This function will configure individual target parameters */
+/* This function configures individual target parameters */
 int tw_slave_configure(Scsi_Device *SDptr)
 {
-	int max_cmds;
-
-	dprintk(KERN_WARNING "3w-xxxx: tw_slave_configure()\n");
-
-#ifdef CONFIG_3W_XXXX_CMD_PER_LUN
-	max_cmds = CONFIG_3W_XXXX_CMD_PER_LUN;
-	if (max_cmds > TW_MAX_CMDS_PER_LUN)
-		max_cmds = TW_MAX_CMDS_PER_LUN;
-#else
-	max_cmds = TW_MAX_CMDS_PER_LUN;
-#endif
-	scsi_adjust_queue_depth(SDptr, MSG_ORDERED_TAG, max_cmds);
+	/* Set SCSI queue depth to kerne/module param, or default. */
+	if (queue_depth < 1 || queue_depth > TW_MAX_CMDS_PER_LUN)
+		queue_depth = TW_MAX_CMDS_PER_LUN;
+	scsi_adjust_queue_depth(SDptr, 0, queue_depth);
+
+	/* make sure blockdev queue depth is at least 2 * scsi depth */
+	if (SDptr->request_queue->nr_requests < 2 * queue_depth)
+		SDptr->request_queue->nr_requests = 2 * queue_depth;
 
 	return 0;
 } /* End tw_slave_configure() */
@@ -3478,6 +3492,34 @@
 	outl(control_reg_value, control_reg_addr);
 } /* End tw_unmask_command_interrupt() */
 
+static ssize_t
+tw_store_queue_depth(struct device *dev, const char *buf, size_t count)
+{
+	int depth;
+										
+	struct scsi_device *SDp = to_scsi_device(dev);
+	if (sscanf(buf, "%d", &depth) != 1)
+		return -EINVAL;
+	if (depth < 1 || depth > TW_MAX_CMDS_PER_LUN)
+		return -EINVAL;
+	scsi_adjust_queue_depth(SDp, 0, depth);
+										
+	return count;
+}
+										
+static struct device_attribute tw_queue_depth_attr = {
+	.attr = {
+		.name =		"queue_depth",
+		.mode =		S_IWUSR,
+	},
+	.store = tw_store_queue_depth,
+};
+
+static struct device_attribute *tw_dev_attrs[] = {
+	&tw_queue_depth_attr,
+	NULL,
+};
+
 static Scsi_Host_Template driver_template = {
 	.proc_name		= "3w-xxxx",
 	.proc_info		= tw_scsi_proc_info,
@@ -3488,12 +3530,14 @@
 	.eh_abort_handler	= tw_scsi_eh_abort,
 	.eh_host_reset_handler	= tw_scsi_eh_reset,
 	.bios_param		= tw_scsi_biosparam,
+	.slave_configure	= tw_slave_configure,
 	.can_queue		= TW_Q_LENGTH-2,
 	.this_id		= -1,
 	.sg_tablesize		= TW_MAX_SGL_LENGTH,
 	.max_sectors		= TW_MAX_SECTORS,
 	.cmd_per_lun		= TW_MAX_CMDS_PER_LUN,	
 	.use_clustering		= ENABLE_CLUSTERING,
+	.sdev_attrs		= tw_dev_attrs,
 	.emulated		= 1
 };
 #include "scsi_module.c"


