Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTFKJwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTFKJwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:52:07 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:52239 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264256AbTFKJwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:52:00 -0400
Date: Wed, 11 Jun 2003 11:05:42 +0100
From: Joe Thornber <thornber@sistina.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] dm: Repair persistent minors
Message-ID: <20030611100542.GD2499@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split the dm_create() function into two variants, depending on whether
you want the device to have a specific minor number.  This avoids
the broken overloading of the minor argument to the old dm_create().

--- diff/drivers/md/dm-ioctl.c	2003-06-11 10:31:17.000000000 +0100
+++ source/drivers/md/dm-ioctl.c	2003-06-11 10:32:11.000000000 +0100
@@ -560,7 +560,6 @@
 	int r;
 	struct dm_table *t;
 	struct mapped_device *md;
-	unsigned int minor = 0;
 
 	r = check_name(param->name);
 	if (r)
@@ -577,9 +576,10 @@
 	}
 
 	if (param->flags & DM_PERSISTENT_DEV_FLAG)
-		minor = minor(to_kdev_t(param->dev));
+		r = dm_create_with_minor(minor(to_kdev_t(param->dev)), t, &md);
+	else
+		r = dm_create(t, &md);
 
-	r = dm_create(minor, t, &md);
 	if (r) {
 		dm_table_put(t);
 		return r;
--- diff/drivers/md/dm.c	2003-06-11 10:31:41.000000000 +0100
+++ source/drivers/md/dm.c	2003-06-11 10:32:54.000000000 +0100
@@ -569,7 +569,7 @@
 /*
  * Allocate and initialise a blank device with a given minor.
  */
-static struct mapped_device *alloc_dev(unsigned int minor)
+static struct mapped_device *alloc_dev(unsigned int minor, int persistent)
 {
 	int r;
 	struct mapped_device *md = kmalloc(sizeof(*md), GFP_KERNEL);
@@ -580,7 +580,7 @@
 	}
 
 	/* get a minor number for the dev */
-	r = (minor < 0) ? next_free_minor(&minor) : specific_minor(minor);
+	r = persistent ? specific_minor(minor) : next_free_minor(&minor);
 	if (r < 0) {
 		kfree(md);
 		return NULL;
@@ -660,13 +660,13 @@
 /*
  * Constructor for a new device.
  */
-int dm_create(unsigned int minor, struct dm_table *table,
-	      struct mapped_device **result)
+static int create_aux(unsigned int minor, int persistent,
+		      struct dm_table *table, struct mapped_device **result)
 {
 	int r;
 	struct mapped_device *md;
 
-	md = alloc_dev(minor);
+	md = alloc_dev(minor, persistent);
 	if (!md)
 		return -ENXIO;
 
@@ -681,6 +681,17 @@
 	return 0;
 }
 
+int dm_create(struct dm_table *table, struct mapped_device **result)
+{
+	return create_aux(0, 0, table, result);
+}
+
+int dm_create_with_minor(unsigned int minor,
+			 struct dm_table *table, struct mapped_device **result)
+{
+	return create_aux(minor, 1, table, result);
+}
+
 void dm_get(struct mapped_device *md)
 {
 	atomic_inc(&md->holders);
--- diff/drivers/md/dm.h	2003-06-11 10:31:27.000000000 +0100
+++ source/drivers/md/dm.h	2003-06-11 10:32:11.000000000 +0100
@@ -51,8 +51,9 @@
  * Functions for manipulating a struct mapped_device.
  * Drop the reference with dm_put when you finish with the object.
  *---------------------------------------------------------------*/
-int dm_create(unsigned int minor, struct dm_table *table,
-	      struct mapped_device **md);
+int dm_create(struct dm_table *table, struct mapped_device **md);
+int dm_create_with_minor(unsigned int minor, struct dm_table *table,
+			 struct mapped_device **md);
 
 /*
  * Reference counting for md.
