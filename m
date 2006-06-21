Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWFUTg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWFUTg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWFUTgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:36:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43429 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932703AbWFUTg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:36:27 -0400
Date: Wed, 21 Jun 2006 20:36:22 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] dm: consolidate creation functions
Message-ID: <20060621193622.GZ4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge dm_create() and dm_create_with_minor() by introducing the
special value DM_ANY_MINOR to request the allocation of the next
available minor number.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.c	2006-06-21 18:32:01.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.c	2006-06-21 18:32:21.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2001, 2002 Sistina Software (UK) Limited.
- * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the GPL.
  */
@@ -804,7 +804,7 @@ static int dm_any_congested(void *conges
  *---------------------------------------------------------------*/
 static DEFINE_IDR(_minor_idr);
 
-static void free_minor(unsigned int minor)
+static void free_minor(int minor)
 {
 	spin_lock(&_minor_lock);
 	idr_remove(&_minor_idr, minor);
@@ -814,7 +814,7 @@ static void free_minor(unsigned int mino
 /*
  * See if the device with a specific minor # is free.
  */
-static int specific_minor(struct mapped_device *md, unsigned int minor)
+static int specific_minor(struct mapped_device *md, int minor)
 {
 	int r, m;
 
@@ -847,10 +847,9 @@ out:
 	return r;
 }
 
-static int next_free_minor(struct mapped_device *md, unsigned int *minor)
+static int next_free_minor(struct mapped_device *md, int *minor)
 {
-	int r;
-	unsigned int m;
+	int r, m;
 
 	r = idr_pre_get(&_minor_idr, GFP_KERNEL);
 	if (!r)
@@ -881,7 +880,7 @@ static struct block_device_operations dm
 /*
  * Allocate and initialise a blank device with a given minor.
  */
-static struct mapped_device *alloc_dev(unsigned int minor, int persistent)
+static struct mapped_device *alloc_dev(int minor)
 {
 	int r;
 	struct mapped_device *md = kmalloc(sizeof(*md), GFP_KERNEL);
@@ -896,7 +895,10 @@ static struct mapped_device *alloc_dev(u
 		goto bad0;
 
 	/* get a minor number for the dev */
-	r = persistent ? specific_minor(md, minor) : next_free_minor(md, &minor);
+	if (minor == DM_ANY_MINOR)
+		r = next_free_minor(md, &minor);
+	else
+		r = specific_minor(md, minor);
 	if (r < 0)
 		goto bad1;
 
@@ -969,7 +971,7 @@ static struct mapped_device *alloc_dev(u
 
 static void free_dev(struct mapped_device *md)
 {
-	unsigned int minor = md->disk->first_minor;
+	int minor = md->disk->first_minor;
 
 	if (md->suspended_bdev) {
 		thaw_bdev(md->suspended_bdev, NULL);
@@ -1055,12 +1057,11 @@ static void __unbind(struct mapped_devic
 /*
  * Constructor for a new device.
  */
-static int create_aux(unsigned int minor, int persistent,
-		      struct mapped_device **result)
+int dm_create(int minor, struct mapped_device **result)
 {
 	struct mapped_device *md;
 
-	md = alloc_dev(minor, persistent);
+	md = alloc_dev(minor);
 	if (!md)
 		return -ENXIO;
 
@@ -1068,16 +1069,6 @@ static int create_aux(unsigned int minor
 	return 0;
 }
 
-int dm_create(struct mapped_device **result)
-{
-	return create_aux(0, 0, result);
-}
-
-int dm_create_with_minor(unsigned int minor, struct mapped_device **result)
-{
-	return create_aux(minor, 1, result);
-}
-
 static struct mapped_device *dm_find_md(dev_t dev)
 {
 	struct mapped_device *md;
Index: linux-2.6.17/drivers/md/dm.h
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.h	2006-06-21 17:45:06.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.h	2006-06-21 18:32:21.000000000 +0100
@@ -2,7 +2,7 @@
  * Internal header file for device mapper
  *
  * Copyright (C) 2001, 2002 Sistina Software
- * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the LGPL.
  */
@@ -45,16 +45,21 @@ struct mapped_device;
  * Functions for manipulating a struct mapped_device.
  * Drop the reference with dm_put when you finish with the object.
  *---------------------------------------------------------------*/
-int dm_create(struct mapped_device **md);
-int dm_create_with_minor(unsigned int minor, struct mapped_device **md);
+
+/*
+ * DM_ANY_MINOR allocates any available minor number.
+ */
+#define DM_ANY_MINOR (-1)
+int dm_create(int minor, struct mapped_device **md);
+
 void dm_set_mdptr(struct mapped_device *md, void *ptr);
 void *dm_get_mdptr(struct mapped_device *md);
-struct mapped_device *dm_get_md(dev_t dev);
 
 /*
  * Reference counting for md.
  */
 void dm_get(struct mapped_device *md);
+struct mapped_device *dm_get_md(dev_t dev);
 void dm_put(struct mapped_device *md);
 
 /*
Index: linux-2.6.17/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-ioctl.c	2006-06-21 17:45:06.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-ioctl.c	2006-06-21 18:32:21.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2001, 2002 Sistina Software (UK) Limited.
- * Copyright (C) 2004 - 2005 Red Hat, Inc. All rights reserved.
+ * Copyright (C) 2004 - 2006 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the GPL.
  */
@@ -578,7 +578,7 @@ static int __dev_status(struct mapped_de
 
 static int dev_create(struct dm_ioctl *param, size_t param_size)
 {
-	int r;
+	int r, m = DM_ANY_MINOR;
 	struct mapped_device *md;
 
 	r = check_name(param->name);
@@ -586,10 +586,9 @@ static int dev_create(struct dm_ioctl *p
 		return r;
 
 	if (param->flags & DM_PERSISTENT_DEV_FLAG)
-		r = dm_create_with_minor(MINOR(huge_decode_dev(param->dev)), &md);
-	else
-		r = dm_create(&md);
+		m = MINOR(huge_decode_dev(param->dev));
 
+	r = dm_create(m, &md);
 	if (r)
 		return r;
 
