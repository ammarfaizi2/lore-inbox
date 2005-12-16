Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVLPAaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVLPAaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVLPAal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:30:41 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:1988 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751205AbVLPAaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:30:23 -0500
Message-ID: <43A20A9C.9020005@shadowconnect.com>
Date: Fri, 16 Dec 2005 01:30:20 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] I2O: Bugfixes
Content-Type: multipart/mixed;
 boundary="------------060608070109080102070004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060608070109080102070004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Changes:
--------
- Removed some kmalloc's with __GFP_ZERO and replace it with memset()
   because it didn't work properly.
- Fixed returned message frame in i2o_cfg_passthru() which caused
   raidutils to display wrong error message in case a disk was missing.
- Fixed size of printk() in i2o_scsi.c.
- Fixed get_device() and put_device() in probing of the I2O controller.

--------------060608070109080102070004
Content-Type: text/x-patch;
 name="i2o-bugfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-bugfix.patch"

Index: linux-2.6/drivers/message/i2o/driver.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/driver.c
+++ linux-2.6/drivers/message/i2o/driver.c
@@ -217,14 +217,15 @@ int i2o_driver_dispatch(struct i2o_contr
 		/* cut of header from message size (in 32-bit words) */
 		size = (le32_to_cpu(msg->u.head[0]) >> 16) - 5;
 
-		evt = kmalloc(size * 4 + sizeof(*evt), GFP_ATOMIC | __GFP_ZERO);
+		evt = kmalloc(size * 4 + sizeof(*evt), GFP_ATOMIC);
 		if (!evt)
 			return -ENOMEM;
+		memset(evt, 0, size * 4 + sizeof(*evt));
 
 		evt->size = size;
 		evt->tcntxt = le32_to_cpu(msg->u.s.tcntxt);
 		evt->event_indicator = le32_to_cpu(msg->body[0]);
-		memcpy(&evt->tcntxt, &msg->u.s.tcntxt, size * 4);
+		memcpy(&evt->data, &msg->body[1], size * 4);
 
 		list_for_each_entry_safe(dev, tmp, &c->devices, list)
 		    if (dev->lct_data.tid == tid) {
Index: linux-2.6/drivers/message/i2o/i2o_config.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_config.c
+++ linux-2.6/drivers/message/i2o/i2o_config.c
@@ -36,12 +36,12 @@
 
 #include <asm/uaccess.h>
 
-#include "core.h"
-
 #define SG_TABLESIZE		30
 
-static int i2o_cfg_ioctl(struct inode *inode, struct file *fp, unsigned int cmd,
-			 unsigned long arg);
+extern int i2o_parm_issue(struct i2o_device *, int, void *, int, void *, int);
+
+static int i2o_cfg_ioctl(struct inode *, struct file *, unsigned int,
+			 unsigned long);
 
 static spinlock_t i2o_config_lock;
 
@@ -593,9 +593,6 @@ static int i2o_cfg_passthru32(struct fil
 
 	sg_offset = (msg->u.head[0] >> 4) & 0x0f;
 
-	msg->u.s.icntxt = cpu_to_le32(i2o_config_driver.context);
-	msg->u.s.tcntxt = cpu_to_le32(i2o_cntxt_list_add(c, reply));
-
 	memset(sg_list, 0, sizeof(sg_list[0]) * SG_TABLESIZE);
 	if (sg_offset) {
 		struct sg_simple_element *sg;
@@ -629,7 +626,7 @@ static int i2o_cfg_passthru32(struct fil
 				goto cleanup;
 			}
 			sg_size = sg[i].flag_count & 0xffffff;
-			p = &(sg_list[sg_index++]);
+			p = &(sg_list[sg_index]);
 			/* Allocate memory for the transfer */
 			if (i2o_dma_alloc
 			    (&c->pdev->dev, p, sg_size,
@@ -640,6 +637,7 @@ static int i2o_cfg_passthru32(struct fil
 				rcode = -ENOMEM;
 				goto sg_list_cleanup;
 			}
+			sg_index++;
 			/* Copy in the user's SG buffer if necessary */
 			if (sg[i].
 			    flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR */ ) {
@@ -661,8 +659,10 @@ static int i2o_cfg_passthru32(struct fil
 	}
 
 	rcode = i2o_msg_post_wait(c, m, 60);
-	if (rcode)
+	if (rcode) {
+		reply[4] = ((u32) rcode) << 24;
 		goto sg_list_cleanup;
+	}
 
 	if (sg_offset) {
 		u32 msg[I2O_OUTBOUND_MSG_FRAME_SIZE];
@@ -712,6 +712,7 @@ static int i2o_cfg_passthru32(struct fil
 		}
 	}
 
+      sg_list_cleanup:
 	/* Copy back the reply to user space */
 	if (reply_size) {
 		// we wrote our own values for context - now restore the user supplied ones
@@ -729,7 +730,6 @@ static int i2o_cfg_passthru32(struct fil
 		}
 	}
 
-      sg_list_cleanup:
 	for (i = 0; i < sg_index; i++)
 		i2o_dma_free(&c->pdev->dev, &sg_list[i]);
 
@@ -827,9 +827,6 @@ static int i2o_cfg_passthru(unsigned lon
 
 	sg_offset = (msg->u.head[0] >> 4) & 0x0f;
 
-	msg->u.s.icntxt = cpu_to_le32(i2o_config_driver.context);
-	msg->u.s.tcntxt = cpu_to_le32(i2o_cntxt_list_add(c, reply));
-
 	memset(sg_list, 0, sizeof(sg_list[0]) * SG_TABLESIZE);
 	if (sg_offset) {
 		struct sg_simple_element *sg;
@@ -892,8 +889,10 @@ static int i2o_cfg_passthru(unsigned lon
 	}
 
 	rcode = i2o_msg_post_wait(c, msg, 60);
-	if (rcode)
+	if (rcode) {
+		reply[4] = ((u32) rcode) << 24;
 		goto sg_list_cleanup;
+	}
 
 	if (sg_offset) {
 		u32 msg[128];
@@ -943,6 +942,7 @@ static int i2o_cfg_passthru(unsigned lon
 		}
 	}
 
+      sg_list_cleanup:
 	/* Copy back the reply to user space */
 	if (reply_size) {
 		// we wrote our own values for context - now restore the user supplied ones
@@ -959,7 +959,6 @@ static int i2o_cfg_passthru(unsigned lon
 		}
 	}
 
-      sg_list_cleanup:
 	for (i = 0; i < sg_index; i++)
 		kfree(sg_list[i]);
 
Index: linux-2.6/drivers/message/i2o/i2o_scsi.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/i2o_scsi.c
+++ linux-2.6/drivers/message/i2o/i2o_scsi.c
@@ -309,9 +309,9 @@ static int i2o_scsi_probe(struct device 
 	sysfs_create_link(&i2o_dev->device.kobj, &scsi_dev->sdev_gendev.kobj,
 			  "scsi");
 
-	osm_info("device added (TID: %03x) channel: %d, id: %d, lun: %d\n",
+	osm_info("device added (TID: %03x) channel: %d, id: %d, lun: %ld\n",
 		 i2o_dev->lct_data.tid, channel, le32_to_cpu(id),
-		 (unsigned int)le64_to_cpu(lun));
+		 (long unsigned int)le64_to_cpu(lun));
 
 	return 0;
 };
Index: linux-2.6/drivers/message/i2o/pci.c
===================================================================
--- linux-2.6.orig/drivers/message/i2o/pci.c
+++ linux-2.6/drivers/message/i2o/pci.c
@@ -338,7 +338,7 @@ static int __devinit i2o_pci_probe(struc
 		       pci_name(pdev));
 
 	c->pdev = pdev;
-	c->device.parent = get_device(&pdev->dev);
+	c->device.parent = &pdev->dev;
 
 	/* Cards that fall apart if you hit them with large I/O loads... */
 	if (pdev->vendor == PCI_VENDOR_ID_NCR && pdev->device == 0x0630) {
@@ -407,8 +407,6 @@ static int __devinit i2o_pci_probe(struc
 	if ((rc = i2o_iop_add(c)))
 		goto uninstall;
 
-	get_device(&c->device);
-
 	if (i960)
 		pci_write_config_word(i960, 0x42, 0x03ff);
 
@@ -421,7 +419,6 @@ static int __devinit i2o_pci_probe(struc
 	i2o_pci_free(c);
 
       free_controller:
-	put_device(c->device.parent);
 	i2o_iop_free(c);
 
       disable:
@@ -450,7 +447,6 @@ static void __devexit i2o_pci_remove(str
 
 	printk(KERN_INFO "%s: Controller removed.\n", c->name);
 
-	put_device(c->device.parent);
 	put_device(&c->device);
 };
 
Index: linux-2.6/include/linux/i2o.h
===================================================================
--- linux-2.6.orig/include/linux/i2o.h
+++ linux-2.6/include/linux/i2o.h
@@ -384,7 +384,7 @@
 
 /* defines for max_sectors and max_phys_segments */
 #define I2O_MAX_SECTORS			1024
-#define I2O_MAX_SECTORS_LIMITED		256
+#define I2O_MAX_SECTORS_LIMITED		128
 #define I2O_MAX_PHYS_SEGMENTS		MAX_PHYS_SEGMENTS
 
 /*

--------------060608070109080102070004--
