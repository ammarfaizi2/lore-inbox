Return-Path: <linux-kernel-owner+w=401wt.eu-S933042AbWLSWMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbWLSWMh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbWLSWMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:12:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44513 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932976AbWLSWMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:12:36 -0500
Date: Tue, 19 Dec 2006 17:12:19 -0500 (EST)
Message-Id: <20061219.171219.112284132.k-ueda@ct.jp.nec.com>
To: jens.axboe@oracle.com, agk@redhat.com, mchristi@redhat.com,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Cc: j-nomura@ce.jp.nec.com, k-ueda@ct.jp.nec.com
Subject: [RFC PATCH 3/8] rqbased-dm: dm_create()/alloc_dev() interface
 change
From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
X-Mailer: Mew version 2.3 on Emacs 20.7 / Mule 4.1
 =?iso-2022-jp?B?KBskQjAqGyhCKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the interface of dm_create() and alloc_dev()
so that the creator can specify whether the created device should
be hooked at bio-level or request-level.

Actual implementation of request-based initialization is done
in a separate patch.


Signed-off-by: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -rupN 2-add-generic-hook/drivers/md/dm.c 3-create-iface-change/drivers/md/dm.c
--- 2-add-generic-hook/drivers/md/dm.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-create-iface-change/drivers/md/dm.c	2006-12-15 10:24:52.000000000 -0500
@@ -923,7 +923,7 @@ static struct block_device_operations dm
 /*
  * Allocate and initialise a blank device with a given minor.
  */
-static struct mapped_device *alloc_dev(int minor)
+static struct mapped_device *alloc_dev(int minor, int request_base)
 {
 	int r;
 	struct mapped_device *md = kmalloc(sizeof(*md), GFP_KERNEL);
@@ -1109,11 +1109,12 @@ static void __unbind(struct mapped_devic
 /*
  * Constructor for a new device.
  */
-int dm_create(int minor, struct mapped_device **result)
+int dm_create(int minor, struct mapped_device **result, unsigned create_flags)
 {
 	struct mapped_device *md;
+	int request_base = create_flags & DM_CREATE_REQUEST_BASE_FLAG ? 1 : 0;
 
-	md = alloc_dev(minor);
+	md = alloc_dev(minor, request_base);
 	if (!md)
 		return -ENXIO;
 
diff -rupN 2-add-generic-hook/drivers/md/dm-ioctl.c 3-create-iface-change/drivers/md/dm-ioctl.c
--- 2-add-generic-hook/drivers/md/dm-ioctl.c	2006-12-11 14:32:53.000000000 -0500
+++ 3-create-iface-change/drivers/md/dm-ioctl.c	2006-12-15 10:24:52.000000000 -0500
@@ -565,6 +565,7 @@ static int dev_create(struct dm_ioctl *p
 {
 	int r, m = DM_ANY_MINOR;
 	struct mapped_device *md;
+	unsigned create_flags = 0;
 
 	r = check_name(param->name);
 	if (r)
@@ -573,7 +574,7 @@ static int dev_create(struct dm_ioctl *p
 	if (param->flags & DM_PERSISTENT_DEV_FLAG)
 		m = MINOR(huge_decode_dev(param->dev));
 
-	r = dm_create(m, &md);
+	r = dm_create(m, &md, create_flags);
 	if (r)
 		return r;
 
diff -rupN 2-add-generic-hook/include/linux/device-mapper.h 3-create-iface-change/include/linux/device-mapper.h
--- 2-add-generic-hook/include/linux/device-mapper.h	2006-12-11 14:32:53.000000000 -0500
+++ 3-create-iface-change/include/linux/device-mapper.h	2006-12-15 10:24:52.000000000 -0500
@@ -155,7 +155,7 @@ int dm_unregister_target(struct target_t
  * DM_ANY_MINOR chooses the next available minor number.
  */
 #define DM_ANY_MINOR (-1)
-int dm_create(int minor, struct mapped_device **md);
+int dm_create(int minor, struct mapped_device **md, unsigned create_flags);
 
 /*
  * Reference counting for md.

