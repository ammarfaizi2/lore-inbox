Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265740AbUEZRCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265740AbUEZRCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 13:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUEZRBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 13:01:31 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40419 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265717AbUEZQ7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 12:59:24 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 4/5: dm: add static and __init qualifiers
Date: Wed, 26 May 2004 11:59:09 -0500
User-Agent: KMail/1.6
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200405261152.33233.kevcorry@us.ibm.com>
In-Reply-To: <200405261152.33233.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405261159.09848.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DM: Add static and __init qualifiers. [Dave Olien]

--- diff/drivers/md/dm-ioctl.c	2004-05-25 10:13:51.000000000 -0500
+++ source/drivers/md/dm-ioctl.c	2004-05-25 11:01:31.000000000 -0500
@@ -46,7 +46,7 @@
 static struct list_head _name_buckets[NUM_BUCKETS];
 static struct list_head _uuid_buckets[NUM_BUCKETS];
 
-void dm_hash_remove_all(void);
+static void dm_hash_remove_all(void);
 
 /*
  * Guards access to both hash tables.
@@ -61,7 +61,7 @@
 		INIT_LIST_HEAD(buckets + i);
 }
 
-int dm_hash_init(void)
+static int dm_hash_init(void)
 {
 	init_buckets(_name_buckets);
 	init_buckets(_uuid_buckets);
@@ -69,7 +69,7 @@
 	return 0;
 }
 
-void dm_hash_exit(void)
+static void dm_hash_exit(void)
 {
 	dm_hash_remove_all();
 	devfs_remove(DM_DIR);
@@ -195,7 +195,7 @@
  * The kdev_t and uuid of a device can never change once it is
  * initially inserted.
  */
-int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
+static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
 {
 	struct hash_cell *cell;
 
@@ -234,7 +234,7 @@
 	return -EBUSY;
 }
 
-void __hash_remove(struct hash_cell *hc)
+static void __hash_remove(struct hash_cell *hc)
 {
 	/* remove from the dev hash */
 	list_del(&hc->uuid_list);
@@ -246,7 +246,7 @@
 	free_cell(hc);
 }
 
-void dm_hash_remove_all(void)
+static void dm_hash_remove_all(void)
 {
 	int i;
 	struct hash_cell *hc;
@@ -262,7 +262,7 @@
 	up_write(&_hash_lock);
 }
 
-int dm_hash_rename(const char *old, const char *new)
+static int dm_hash_rename(const char *old, const char *new)
 {
 	char *new_name, *old_name;
 	struct hash_cell *hc;
--- diff/drivers/md/dm-target.c	2004-05-09 21:33:21.000000000 -0500
+++ source/drivers/md/dm-target.c	2004-05-25 11:01:31.000000000 -0500
@@ -7,6 +7,7 @@
 #include "dm.h"
 
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/kmod.h>
 #include <linux/bio.h>
 #include <linux/slab.h>
@@ -181,7 +182,7 @@
 	.map  = io_err_map,
 };
 
-int dm_target_init(void)
+int __init dm_target_init(void)
 {
 	return dm_register_target(&error_target);
 }
--- diff/drivers/md/dm.c	2004-05-25 10:31:11.000000000 -0500
+++ source/drivers/md/dm.c	2004-05-25 11:01:31.000000000 -0500
@@ -93,7 +93,7 @@
 static kmem_cache_t *_io_cache;
 static kmem_cache_t *_tio_cache;
 
-static __init int local_init(void)
+static int __init local_init(void)
 {
 	int r;
 
@@ -664,6 +664,8 @@
 	return r;
 }
 
+static struct block_device_operations dm_blk_dops;
+
 /*
  * Allocate and initialise a blank device with a given minor.
  */
@@ -1087,7 +1089,7 @@
 
 EXPORT_SYMBOL(dm_get_mapinfo);
 
-struct block_device_operations dm_blk_dops = {
+static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
 	.release = dm_blk_close,
 	.owner = THIS_MODULE
--- diff/drivers/md/dm.h	2004-05-25 10:20:54.000000000 -0500
+++ source/drivers/md/dm.h	2004-05-25 11:01:31.000000000 -0500
@@ -31,8 +31,6 @@
 
 #define SECTOR_SHIFT 9
 
-extern struct block_device_operations dm_blk_dops;
-
 /*
  * List of devices that a metadevice uses and should open/close.
  */
