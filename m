Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSKUUvY>; Thu, 21 Nov 2002 15:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSKUUvY>; Thu, 21 Nov 2002 15:51:24 -0500
Received: from host194.steeleye.com ([66.206.164.34]:52485 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264743AbSKUUvO>; Thu, 21 Nov 2002 15:51:14 -0500
Message-Id: <200211212058.gALKwCi05471@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
cc: Project MCA Team <mcalinux@acc.umu.se>, David Weinehall <tao@acc.umu.se>
Subject: [PATCH] MCA sysfs part IV - implementation in the SCSI NCR_D700 driver
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-11824017980"
Date: Thu, 21 Nov 2002 14:58:12 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-11824017980
Content-Type: text/plain; charset=us-ascii

Well, this was what the previous patches were all aiming for:  a SCSI 
implementation which gives me a D700 driver that's correctly plumbed into 
sysfs and which can also DMA happily to/from all 4Gb on an x86.

I'll look at converting other devices over (probably the smc-mca, since that's 
my current ethernet card).

All of the patches are also available in the bitkeeper tree at:

http://linux-voyager.bkbits.net/mca-sysfs-2.5

James


--==_Exmh_-11824017980
Content-Type: text/plain ; name="mca-sysfs-d700.diff"; charset=us-ascii
Content-Description: mca-sysfs-d700.diff
Content-Disposition: attachment; filename="mca-sysfs-d700.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.846   -> 1.847  
#	drivers/scsi/NCR_D700.c	1.3     -> 1.4    
#	 include/linux/mca.h	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/21	jejb@mulgrave.(none)	1.847
# Move NCR_D700 to MCA sysfs
# 
# Make D700 use the sysfs based device probing code and the new
# MCA API entirely.
# --------------------------------------------
#
diff -Nru a/drivers/scsi/NCR_D700.c b/drivers/scsi/NCR_D700.c
--- a/drivers/scsi/NCR_D700.c	Thu Nov 21 14:44:50 2002
+++ b/drivers/scsi/NCR_D700.c	Thu Nov 21 14:44:50 2002
@@ -103,6 +103,7 @@
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/device.h>
 #include <linux/mca.h>
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -182,131 +183,140 @@
 __setup("NCR_D700=", param_setup);
 #endif
 
+/* private stack allocated structure for passing device information from
+ * detect to probe */
+struct NCR_700_info {
+	Scsi_Host_Template *tpnt;
+	int found;
+};
+
 /* Detect a D700 card.  Note, because of the set up---the chips are
  * essentially connectecd to the MCA bus independently, it is easier
  * to set them up as two separate host adapters, rather than one
  * adapter with two channels */
-STATIC int __init
-D700_detect(Scsi_Host_Template *tpnt)
+static int
+NCR_D700_probe(struct device *dev)
 {
-	int slot = 0;
-	int found = 0;
 	int differential;
-	int banner = 1;
-
-	if(!MCA_bus)
-		return 0;
-
-#ifdef MODULE
-	if(NCR_D700)
-		param_setup(NCR_D700);
-#endif
+	static int banner = 1;
+	struct mca_device *mca_dev = to_mca_device(dev);
+	int slot = mca_dev->slot;
+	struct NCR_700_info *info = to_mca_driver(dev->driver)->driver_data;
+	int found = 0;
+	int irq, i;
+	int pos3j, pos3k, pos3a, pos3b, pos4;
+	__u32 base_addr, offset_addr;
+	struct Scsi_Host *host = NULL;
+
+	/* enable board interrupt */
+	pos4 = mca_device_read_pos(mca_dev, 4);
+	pos4 |= 0x4;
+	mca_device_write_pos(mca_dev, 4, pos4);
+
+	mca_device_write_pos(mca_dev, 6, 9);
+	pos3j = mca_device_read_pos(mca_dev, 3);
+	mca_device_write_pos(mca_dev, 6, 10);
+	pos3k = mca_device_read_pos(mca_dev, 3);
+	mca_device_write_pos(mca_dev, 6, 0);
+	pos3a = mca_device_read_pos(mca_dev, 3);
+	mca_device_write_pos(mca_dev, 6, 1);
+	pos3b = mca_device_read_pos(mca_dev, 3);
+
+	base_addr = ((pos3j << 8) | pos3k) & 0xfffffff0;
+	offset_addr = ((pos3a << 8) | pos3b) & 0xffffff70;
+
+	irq = (pos4 & 0x3) + 11;
+	if(irq >= 13)
+		irq++;
+	if(banner) {
+		printk(KERN_NOTICE "NCR D700: Driver Version " NCR_D700_VERSION "\n"
+		       "NCR D700:  Copyright (c) 2001 by James.Bottomley@HansenPartnership.com\n"
+		       "NCR D700:\n");
+		banner = 0;
+	}
+	/* now do the bus related transforms */
+	irq = mca_device_transform_irq(mca_dev, irq);
+	base_addr = mca_device_transform_ioport(mca_dev, base_addr);
+	offset_addr = mca_device_transform_ioport(mca_dev, offset_addr);
+
+	printk(KERN_NOTICE "NCR D700: found in slot %d  irq = %d  I/O base = 0x%x\n", slot, irq, offset_addr);
+
+	info->tpnt->proc_name = "NCR_D700";
+
+	/*outb(BOARD_RESET, base_addr);*/
+
+	/* clear any pending interrupts */
+	(void)inb(base_addr + 0x08);
+	/* get modctl, used later for setting diff bits */
+	switch(differential = (inb(base_addr + 0x08) >> 6)) {
+	case 0x00:
+		/* only SIOP1 differential */
+		differential = 0x02;
+		break;
+	case 0x01:
+		/* Both SIOPs differential */
+		differential = 0x03;
+		break;
+	case 0x03:
+		/* No SIOPs differential */
+		differential = 0x00;
+		break;
+	default:
+		printk(KERN_ERR "D700: UNEXPECTED DIFFERENTIAL RESULT 0x%02x\n",
+		       differential);
+		differential = 0x00;
+		break;
+	}
 
-	for(slot = 0; (slot = mca_find_adapter(NCR_D700_MCA_ID, slot)) != MCA_NOTFOUND; slot++) {
-		int irq, i;
-		int pos3j, pos3k, pos3a, pos3b, pos4;
-		__u32 base_addr, offset_addr;
-		struct Scsi_Host *host = NULL;
-
-		/* enable board interrupt */
-		pos4 = mca_read_pos(slot, 4);
-		pos4 |= 0x4;
-		mca_write_pos(slot, 4, pos4);
-
-		mca_write_pos(slot, 6, 9);
-		pos3j = mca_read_pos(slot, 3);
-		mca_write_pos(slot, 6, 10);
-		pos3k = mca_read_pos(slot, 3);
-		mca_write_pos(slot, 6, 0);
-		pos3a = mca_read_pos(slot, 3);
-		mca_write_pos(slot, 6, 1);
-		pos3b = mca_read_pos(slot, 3);
-
-		base_addr = ((pos3j << 8) | pos3k) & 0xfffffff0;
-		offset_addr = ((pos3a << 8) | pos3b) & 0xffffff70;
-
-		irq = (pos4 & 0x3) + 11;
-		if(irq >= 13)
-			irq++;
-		if(banner) {
-			printk(KERN_NOTICE "NCR D700: Driver Version " NCR_D700_VERSION "\n"
-			       "NCR D700:  Copyright (c) 2001 by James.Bottomley@HansenPartnership.com\n"
-			       "NCR D700:\n");
-			banner = 0;
+	/* plumb in both 700 chips */
+	for(i=0; i<2; i++) {
+		__u32 region = offset_addr | (0x80 * i);
+		struct NCR_700_Host_Parameters *hostdata =
+			kmalloc(sizeof(struct NCR_700_Host_Parameters),
+				GFP_KERNEL);
+		if(hostdata == NULL) {
+			printk(KERN_ERR "NCR D700: Failed to allocate host data for channel %d, detatching\n", i);
+			continue;
 		}
-		printk(KERN_NOTICE "NCR D700: found in slot %d  irq = %d  I/O base = 0x%x\n", slot, irq, offset_addr);
-
-		tpnt->proc_name = "NCR_D700";
-
-		/*outb(BOARD_RESET, base_addr);*/
-
-		/* clear any pending interrupts */
-		(void)inb(base_addr + 0x08);
-		/* get modctl, used later for setting diff bits */
-		switch(differential = (inb(base_addr + 0x08) >> 6)) {
-		case 0x00:
-			/* only SIOP1 differential */
-			differential = 0x02;
-			break;
-		case 0x01:
-			/* Both SIOPs differential */
-			differential = 0x03;
-			break;
-		case 0x03:
-			/* No SIOPs differential */
-			differential = 0x00;
-			break;
-		default:
-			printk(KERN_ERR "D700: UNEXPECTED DIFFERENTIAL RESULT 0x%02x\n",
-			       differential);
-			differential = 0x00;
-			break;
+		memset(hostdata, 0, sizeof(struct NCR_700_Host_Parameters));
+		if(request_region(region, 64, "NCR_D700") == NULL) {
+			printk(KERN_ERR "NCR D700: Failed to reserve IO region 0x%x\n", region);
+			kfree(hostdata);
+			continue;
 		}
-
-		/* plumb in both 700 chips */
-		for(i=0; i<2; i++) {
-			__u32 region = offset_addr | (0x80 * i);
-			struct NCR_700_Host_Parameters *hostdata =
-				kmalloc(sizeof(struct NCR_700_Host_Parameters),
-					GFP_KERNEL);
-			if(hostdata == NULL) {
-				printk(KERN_ERR "NCR D700: Failed to allocate host data for channel %d, detatching\n", i);
-				continue;
-			}
-			memset(hostdata, 0, sizeof(struct NCR_700_Host_Parameters));
-			if(request_region(region, 64, "NCR_D700") == NULL) {
-				printk(KERN_ERR "NCR D700: Failed to reserve IO region 0x%x\n", region);
-				kfree(hostdata);
-				continue;
-			}
-
-			/* Fill in the three required pieces of hostdata */
-			hostdata->base = region;
-			hostdata->differential = (((1<<i) & differential) != 0);
-			hostdata->clock = NCR_D700_CLOCK_MHZ;
-			/* and register the chip */
-			if((host = NCR_700_detect(tpnt, hostdata)) == NULL) {
-				kfree(hostdata);
-				release_region(host->base, 64);
-				continue;
-			}
-			host->irq = irq;
-			/* FIXME: Read this from SUS */
-			host->this_id = id_array[slot * 2 + i];
-			printk(KERN_NOTICE "NCR D700: SIOP%d, SCSI id is %d\n",
-			       i, host->this_id);
-			if(request_irq(irq, NCR_700_intr, SA_SHIRQ, "NCR_D700", host)) {
-				printk(KERN_ERR "NCR D700, channel %d: irq problem, detatching\n", i);
-				scsi_unregister(host);
-				NCR_700_release(host);
-				continue;
-			}
-			found++;
-			mca_set_adapter_name(slot, "NCR D700 SCSI Adapter (version " NCR_D700_VERSION ")");
+		
+		/* Fill in the three required pieces of hostdata */
+		hostdata->base = region;
+		hostdata->differential = (((1<<i) & differential) != 0);
+		hostdata->clock = NCR_D700_CLOCK_MHZ;
+		/* and register the chip */
+		if((host = NCR_700_detect(info->tpnt, hostdata)) == NULL) {
+			kfree(hostdata);
+			release_region(host->base, 64);
+			continue;
 		}
+		host->irq = irq;
+		/* FIXME: Read this from SUS */
+		host->this_id = id_array[slot * 2 + i];
+		printk(KERN_NOTICE "NCR D700: SIOP%d, SCSI id is %d\n",
+		       i, host->this_id);
+		if(request_irq(irq, NCR_700_intr, SA_SHIRQ, "NCR_D700", host)) {
+			printk(KERN_ERR "NCR D700, channel %d: irq problem, detatching\n", i);
+			scsi_unregister(host);
+			NCR_700_release(host);
+			continue;
+		}
+		scsi_set_device(host, dev);
+		found++;
+	}
+	info->found += found;
+
+	if(found) {
+		mca_device_set_claim(mca_dev, 1);
+		strncpy(dev->name, "NCR_D700", sizeof(dev->name));
 	}
 
-	return found;
+	return found? 0 : -ENODEV;
 }
 
 
@@ -323,7 +333,38 @@
 	return 1;
 }
 
+static short NCR_D700_id_table[] = { NCR_D700_MCA_ID, 0 };
+
+struct mca_driver NCR_D700_driver = {
+	.id_table = NCR_D700_id_table,
+	.driver = {
+		.name = "NCR_D700",
+		.bus = &mca_bus_type,
+		.probe = NCR_D700_probe,
+	},
+};
+		
+
+STATIC int __init
+D700_detect(Scsi_Host_Template *tpnt)
+{
+	struct NCR_700_info info;
+
+	if(!MCA_bus)
+		return 0;
+
+#ifdef MODULE
+	if(NCR_D700)
+		param_setup(NCR_D700);
+#endif
+	info.tpnt = tpnt;
+	info.found = 0;
+	NCR_D700_driver.driver_data = &info;
+	mca_register_driver(&NCR_D700_driver);
 
+	return info.found;
+}
+	
 static Scsi_Host_Template driver_template = NCR_D700_SCSI;
 
 #include "scsi_module.c"
diff -Nru a/include/linux/mca.h b/include/linux/mca.h
--- a/include/linux/mca.h	Thu Nov 21 14:44:50 2002
+++ b/include/linux/mca.h	Thu Nov 21 14:44:50 2002
@@ -94,6 +94,7 @@
 
 struct mca_driver {
 	const short		*id_table;
+	void			*driver_data;
 	struct device_driver	driver;
 };
 #define to_mca_driver(mdriver) container_of(mdriver, struct mca_driver, driver)
@@ -119,6 +120,11 @@
 extern enum MCA_AdapterStatus mca_device_status(struct mca_device *mca_dev);
 
 extern struct bus_type mca_bus_type;
+
+static inline void mca_register_driver(struct mca_driver *drv)
+{
+	driver_register(&drv->driver);
+}
 
 /* for now, include the legacy API */
 #include <linux/mca-legacy.h>

--==_Exmh_-11824017980--


