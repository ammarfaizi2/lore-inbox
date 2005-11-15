Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVKOJbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVKOJbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVKOJbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:31:33 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:18598 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1751411AbVKOJb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:31:27 -0500
Message-ID: <4379AAED.3020307@shadowconnect.com>
Date: Tue, 15 Nov 2005 10:31:25 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] I2O: Bugfixes
Content-Type: multipart/mixed;
 boundary="------------080601010700020508020506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080601010700020508020506
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

Signed-off-by: Markus Lidel <Markus.Lidel@shadowconnect.com>

--------------080601010700020508020506
Content-Type: text/x-patch;
 name="i2o-bugfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o-bugfix.patch"

Index: linux-2.6.14/drivers/message/i2o/driver.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/driver.c	2005-11-13 20:24:50.885019905 +0100
+++ linux-2.6.14/drivers/message/i2o/driver.c	2005-11-13 21:45:05.523930221 +0100
@@ -213,9 +213,10 @@
 		/* cut of header from message size (in 32-bit words) */
 		size = (le32_to_cpu(msg->u.head[0]) >> 16) - 5;
 
-		evt = kmalloc(size * 4 + sizeof(*evt), GFP_ATOMIC | __GFP_ZERO);
+		evt = kmalloc(size * 4 + sizeof(*evt), GFP_ATOMIC);
 		if (!evt)
 			return -ENOMEM;
+		memset(evt, 0, size * 4 + sizeof(*evt));
 
 		evt->size = size;
 		evt->tcntxt = le32_to_cpu(msg->u.s.tcntxt);
Index: linux-2.6.14/drivers/message/i2o/i2o_config.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/i2o_config.c	2005-11-13 20:24:55.269252162 +0100
+++ linux-2.6.14/drivers/message/i2o/i2o_config.c	2005-11-13 21:45:05.527930434 +0100
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
 
@@ -593,9 +593,6 @@
 
 	sg_offset = (msg->u.head[0] >> 4) & 0x0f;
 
-	msg->u.s.icntxt = cpu_to_le32(i2o_config_driver.context);
-	msg->u.s.tcntxt = cpu_to_le32(i2o_cntxt_list_add(c, reply));
-
 	memset(sg_list, 0, sizeof(sg_list[0]) * SG_TABLESIZE);
 	if (sg_offset) {
 		struct sg_simple_element *sg;
@@ -629,7 +626,7 @@
 				goto cleanup;
 			}
 			sg_size = sg[i].flag_count & 0xffffff;
-			p = &(sg_list[sg_index++]);
+			p = &(sg_list[sg_index]);
 			/* Allocate memory for the transfer */
 			if (i2o_dma_alloc
 			    (&c->pdev->dev, p, sg_size,
@@ -640,6 +637,7 @@
 				rcode = -ENOMEM;
 				goto sg_list_cleanup;
 			}
+			sg_index++;
 			/* Copy in the user's SG buffer if necessary */
 			if (sg[i].
 			    flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR */ ) {
@@ -661,8 +659,10 @@
 	}
 
 	rcode = i2o_msg_post_wait(c, m, 60);
-	if (rcode)
+	if (rcode) {
+		reply[4] = ((u32) rcode) << 24;
 		goto sg_list_cleanup;
+	}
 
 	if (sg_offset) {
 		u32 msg[I2O_OUTBOUND_MSG_FRAME_SIZE];
@@ -712,6 +712,7 @@
 		}
 	}
 
+      sg_list_cleanup:
 	/* Copy back the reply to user space */
 	if (reply_size) {
 		// we wrote our own values for context - now restore the user supplied ones
@@ -729,7 +730,6 @@
 		}
 	}
 
-      sg_list_cleanup:
 	for (i = 0; i < sg_index; i++)
 		i2o_dma_free(&c->pdev->dev, &sg_list[i]);
 
@@ -827,9 +827,6 @@
 
 	sg_offset = (msg->u.head[0] >> 4) & 0x0f;
 
-	msg->u.s.icntxt = cpu_to_le32(i2o_config_driver.context);
-	msg->u.s.tcntxt = cpu_to_le32(i2o_cntxt_list_add(c, reply));
-
 	memset(sg_list, 0, sizeof(sg_list[0]) * SG_TABLESIZE);
 	if (sg_offset) {
 		struct sg_simple_element *sg;
@@ -892,8 +889,10 @@
 	}
 
 	rcode = i2o_msg_post_wait(c, msg, 60);
-	if (rcode)
+	if (rcode) {
+		reply[4] = ((u32) rcode) << 24;
 		goto sg_list_cleanup;
+	}
 
 	if (sg_offset) {
 		u32 msg[128];
@@ -943,6 +942,7 @@
 		}
 	}
 
+      sg_list_cleanup:
 	/* Copy back the reply to user space */
 	if (reply_size) {
 		// we wrote our own values for context - now restore the user supplied ones
@@ -959,7 +959,6 @@
 		}
 	}
 
-      sg_list_cleanup:
 	for (i = 0; i < sg_index; i++)
 		kfree(sg_list[i]);
 
Index: linux-2.6.14/drivers/message/i2o/i2o_scsi.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/i2o_scsi.c	2005-11-13 20:24:57.205354729 +0100
+++ linux-2.6.14/drivers/message/i2o/i2o_scsi.c	2005-11-13 21:45:05.531930646 +0100
@@ -309,9 +309,9 @@
 	sysfs_create_link(&i2o_dev->device.kobj, &scsi_dev->sdev_gendev.kobj,
 			  "scsi");
 
-	osm_info("device added (TID: %03x) channel: %d, id: %d, lun: %d\n",
+	osm_info("device added (TID: %03x) channel: %d, id: %d, lun: %ld\n",
 		 i2o_dev->lct_data.tid, channel, le32_to_cpu(id),
-		 (unsigned int)le64_to_cpu(lun));
+		 (long unsigned int)le64_to_cpu(lun));
 
 	return 0;
 };
Index: linux-2.6.14/drivers/message/i2o/pci.c
===================================================================
--- linux-2.6.14.orig/drivers/message/i2o/pci.c	2005-11-13 20:24:55.273252374 +0100
+++ linux-2.6.14/drivers/message/i2o/pci.c	2005-11-13 21:45:05.531930646 +0100
@@ -338,7 +338,7 @@
 		       pci_name(pdev));
 
 	c->pdev = pdev;
-	c->device.parent = get_device(&pdev->dev);
+	c->device.parent = &pdev->dev;
 
 	/* Cards that fall apart if you hit them with large I/O loads... */
 	if (pdev->vendor == PCI_VENDOR_ID_NCR && pdev->device == 0x0630) {
@@ -407,8 +407,6 @@
 	if ((rc = i2o_iop_add(c)))
 		goto uninstall;
 
-	get_device(&c->device);
-
 	if (i960)
 		pci_write_config_word(i960, 0x42, 0x03ff);
 
@@ -422,7 +420,6 @@
 
       free_controller:
 	i2o_iop_free(c);
-	put_device(c->device.parent);
 
       disable:
 	pci_disable_device(pdev);
@@ -450,7 +447,6 @@
 
 	printk(KERN_INFO "%s: Controller removed.\n", c->name);
 
-	put_device(c->device.parent);
 	put_device(&c->device);
 };
 
Index: linux-2.6.14/include/linux/i2o.h
===================================================================
--- linux-2.6.14.orig/include/linux/i2o.h	2005-11-13 20:24:58.685433137 +0100
+++ linux-2.6.14/include/linux/i2o.h	2005-11-13 21:45:33.469412311 +0100
@@ -380,7 +380,7 @@
 
 /* defines for max_sectors and max_phys_segments */
 #define I2O_MAX_SECTORS			1024
-#define I2O_MAX_SECTORS_LIMITED		256
+#define I2O_MAX_SECTORS_LIMITED		128
 #define I2O_MAX_PHYS_SEGMENTS		MAX_PHYS_SEGMENTS
 
 /*

--------------080601010700020508020506--
