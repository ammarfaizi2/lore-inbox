Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVDRPhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVDRPhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVDRPhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:37:34 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:44480 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S261372AbVDRPgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:36:22 -0400
Date: Mon, 18 Apr 2005 10:36:44 -0500
From: mike.miller@hp.com
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com
Subject: [RFC 1 of 9] patches to add diskdump functionality to block layer
Message-ID: <20050418153644.GA25409@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please review the following patches and provide any comments or feedback.
Patch 1 of 9

Thanks,
mikem

 block_dump.c |  202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 block_dump.h |   29 ++++++++
 2 files changed, 231 insertions(+)
--------------------------------------------------------------------------------
Description:
This patch adds the .c and .h files for the mid-level block_dump driver.  
This driver will allow block device drivers to support diskdump while
offloading the dependencies of diskdump from the low-level driver.
--------------------------------------------------------------------------------
diff -burpN old/drivers/block/block_dump.c new/drivers/block/block_dump.c
--- old/drivers/block/block_dump.c	1969-12-31 19:00:00.000000000 -0500
+++ new/drivers/block/block_dump.c	2005-04-07 20:49:23.000000000 -0400
@@ -0,0 +1,202 @@
+
+/*
+ *    Block dump driver for block drivers  to support diskdump functionality wihtout
+ *    dependening on diskdump driver.
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation; either version 2 of the License, or
+ *    (at your option) any later version.
+ *
+ *    This program is distributed in the hope that it will be useful,
+ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *    MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ *    NON INFRINGEMENT.  See the GNU General Public License for more details.
+ *
+ *    You should have received a copy of the GNU General Public License
+ *    along with this program; if not, write to the Free Software
+ *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/blk.h>
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/crc32.h>
+#include <linux/diskdump.h>
+#include <linux/diskdumplib.h>
+#include "block_dump.h"
+
+/* Embedded module documentation macros - see modules.h */
+MODULE_AUTHOR("Hewlett-Packard Company");
+MODULE_DESCRIPTION("Mid-level Block Driver for diskdump");
+MODULE_LICENSE("GPL");
+
+static uint32_t module_crc;
+
+/* function prototypes */
+static int block_dump_sanity_check(struct disk_dump_device *dump_device);
+static int block_dump_rw_block(struct disk_dump_partition *dump_part, int rw, unsigned long dump_block_nr, void *buf, int len);
+static int block_dump_quiesce(struct disk_dump_device *dump_device);
+static int block_dump_shutdown(struct disk_dump_device *dump_device);
+static void *block_dump_probe(kdev_t dev);
+static int block_dump_add_device(struct disk_dump_device *dump_device);
+static void block_dump_remove_device(struct disk_dump_device *dump_device);
+
+/*
+ * This MACRO is to get the starting address of blcok_device_operations_dump strucutre using blk_fops pointer * , which is a member of block_device_operations_dump structure 
+ */
+#define BLOCK_OPS_EXT(blk_fops)	container_of(blk_fops, block_device_operations_dump, blk_fops)
+
+static struct disk_dump_type block_dump_type = {
+	.probe		= block_dump_probe,
+	.add_device	= block_dump_add_device,
+	.remove_device	= block_dump_remove_device,
+	.owner		= THIS_MODULE,
+};
+
+static struct disk_dump_device_ops block_dump_device_ops = {
+	.sanity_check	= block_dump_sanity_check,
+	.rw_block	= block_dump_rw_block,
+	.quiesce	= block_dump_quiesce,
+	.shutdown	= block_dump_shutdown,
+};
+
+
+static int block_dump_shutdown(struct disk_dump_device *dump_device) {
+
+	device_info_t *device_info = dump_device->device;
+	block_device_operations_dump *blk_dev_ops = device_info->blk_dump_ops;
+
+	if ( blk_dev_ops->block_dump_ops->shutdown != NULL ) {
+		return blk_dev_ops->block_dump_ops->shutdown(device_info->device);
+	}
+
+	return -1;	
+}
+
+static int block_dump_quiesce(struct disk_dump_device *dump_device) {
+
+	device_info_t *device_info = dump_device->device;
+	block_device_operations_dump *blk_dev_ops = device_info->blk_dump_ops;
+
+	if ( blk_dev_ops->block_dump_ops->quiesce == NULL ) {
+		return -1;
+	}
+
+	blk_dev_ops->block_dump_ops->quiesce(device_info->device);
+	diskdump_register_poll(device_info->device, (void *)blk_dev_ops->poll);
+
+	return 0;	
+}
+
+static int block_dump_rw_block(struct disk_dump_partition *dump_part, 
+			int rw, unsigned long dump_block_nr, void *buf, int len) {
+
+	device_info_t *device_info = ((struct disk_dump_device *)dump_part->device)->device;
+	block_device_operations_dump *blk_dev_ops = device_info->blk_dump_ops;
+	struct disk_dump_device *dump_device = dump_part->device;
+
+	if ( blk_dev_ops->block_dump_ops->rw_block != NULL ) {
+		return blk_dev_ops->block_dump_ops->rw_block(device_info->device, rw, 
+			dump_block_nr, buf, len, dump_part->start_sect, dump_part->nr_sects);
+	}
+
+	return -1;	
+}
+
+static int block_dump_sanity_check(struct disk_dump_device *dump_device){
+
+	device_info_t *device_info = dump_device->device;
+	block_device_operations_dump *blk_dev_ops = device_info->blk_dump_ops;
+
+	if (!check_crc_module()){
+		printk("<1>checksum error.  block dump module may be compromised\n");
+		return -EINVAL;
+	}
+
+	if ( blk_dev_ops->block_dump_ops->sanity_check != NULL ) {
+		return blk_dev_ops->block_dump_ops->sanity_check(device_info->device);
+	}
+
+	return -1;	
+}
+
+static void *block_dump_probe(kdev_t dev){
+	const struct block_device_operations *blk_fops;
+	struct block_device *blk_dev; 
+	block_device_operations_dump *blk_dump_ops;
+	device_info_t *device_info;
+	
+	set_crc_modules();	
+	device_info =  kmalloc(sizeof(device_info_t), GFP_KERNEL);
+
+	blk_dev = bdget( (dev_t)dev);
+	blk_fops = blk_dev->bd_op;
+
+	blk_dump_ops = BLOCK_OPS_EXT(blk_fops);
+
+	if (!blk_fops->diskdump)
+	{
+		printk("Dumpdevice Extended ops null\n");
+		return NULL;
+	}
+
+	if ( blk_dump_ops->block_probe != NULL ) {
+		device_info->device = blk_dump_ops->block_probe(dev);	
+
+		device_info->blk_dump_ops = blk_dump_ops;
+		return device_info;
+	}
+
+	return NULL;
+}
+
+static int block_dump_add_device(struct disk_dump_device *dump_device){
+	device_info_t *device_info = dump_device->device;
+	block_device_operations_dump *blk_dev_ops = device_info->blk_dump_ops;
+
+	if(!memcpy(&dump_device->ops, &block_dump_device_ops, sizeof(struct disk_dump_device_ops)))
+		return -1;
+
+	if ( blk_dev_ops->block_add_device != NULL ) {
+		dump_device->max_blocks = blk_dev_ops->block_add_device(device_info->device);
+	}
+
+	return 0;
+}
+
+static void block_dump_remove_device(struct disk_dump_device *dump_device){
+}
+
+static int __init init_block_dump_module(void)
+{
+	int ret;
+
+	/* register with diskdump here. */
+	if ((ret = register_disk_dump_type(&block_dump_type)) < 0 ) {
+		printk("<1>Register of diskdump type failed\n");
+		return ret;
+	}
+
+	set_crc_modules();	
+
+	return ret;
+}
+
+static void __exit cleanup_block_dump_module(void)
+{
+	if (unregister_disk_dump_type(&block_dump_type) < 0 )
+		printk("<1>Error unregistering diskdump\n");
+}
+
+module_init(init_block_dump_module);
+module_exit(cleanup_block_dump_module);
+
diff -burpN old/drivers/block/block_dump.h new/drivers/block/block_dump.h
--- old/drivers/block/block_dump.h	1969-12-31 19:00:00.000000000 -0500
+++ new/drivers/block/block_dump.h	2005-04-07 20:49:25.000000000 -0400
@@ -0,0 +1,29 @@
+
+#ifndef BLOCKDUMP_H
+#define BLOCKDUMP_H
+
+/*
+ * Extended block operations for dump for preserving binary compatibility.
+ */
+struct block_dump_ops {
+	int (*sanity_check)(void *device);
+	int (*rw_block)(void *device, int rw, unsigned long dump_block_nr, void *buf, int len, unsigned long start_sect, unsigned long nr_sects);
+	int (*quiesce)(void *device);
+	int (*shutdown)(void *device);
+};
+
+typedef struct __block_device_operations_dump {
+	struct block_device_operations blk_fops;
+	struct block_dump_ops *block_dump_ops;
+	void *(*block_probe)(kdev_t dev);
+	unsigned int (*block_add_device)(void *device);
+	unsigned long (*poll)(int ctlr);
+} block_device_operations_dump;
+
+typedef struct _device_info_t
+{
+	void *device;
+	void *blk_dump_ops;
+} device_info_t;
+
+#endif // BLOCKDUMP_H
