Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWCLWtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWCLWtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCLWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:49:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24239 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751399AbWCLWtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:49:14 -0500
Date: Sun, 12 Mar 2006 22:49:10 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dm: tidy mdptr
Message-ID: <20060312224910.GG4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change dm_get_mdptr() to take a struct mapped_device instead of dev_t.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc5/drivers/md/dm.h
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm.h	2006-03-12 17:47:41.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm.h	2006-03-12 18:15:24.000000000 +0000
@@ -47,7 +47,7 @@ struct mapped_device;
 int dm_create(struct mapped_device **md);
 int dm_create_with_minor(unsigned int minor, struct mapped_device **md);
 void dm_set_mdptr(struct mapped_device *md, void *ptr);
-void *dm_get_mdptr(dev_t dev);
+void *dm_get_mdptr(struct mapped_device *md);
 struct mapped_device *dm_get_md(dev_t dev);
 
 /*
Index: linux-2.6.16-rc5/drivers/md/dm.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm.c	2006-03-12 18:14:57.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm.c	2006-03-12 18:15:24.000000000 +0000
@@ -976,15 +976,9 @@ struct mapped_device *dm_get_md(dev_t de
 	return md;
 }
 
-void *dm_get_mdptr(dev_t dev)
+void *dm_get_mdptr(struct mapped_device *md)
 {
-	struct mapped_device *md;
-	void *mdptr = NULL;
-
-	md = dm_find_md(dev);
-	if (md)
-		mdptr = md->interface_ptr;
-	return mdptr;
+	return md->interface_ptr;
 }
 
 void dm_set_mdptr(struct mapped_device *md, void *ptr)
Index: linux-2.6.16-rc5/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm-ioctl.c	2006-02-27 05:09:35.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm-ioctl.c	2006-03-12 18:15:24.000000000 +0000
@@ -600,12 +600,22 @@ static int dev_create(struct dm_ioctl *p
  */
 static struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
 {
+	struct mapped_device *md;
+	void *mdptr = NULL;
+
 	if (*param->uuid)
 		return __get_uuid_cell(param->uuid);
-	else if (*param->name)
+
+	if (*param->name)
 		return __get_name_cell(param->name);
-	else
-		return dm_get_mdptr(huge_decode_dev(param->dev));
+
+	md = dm_get_md(huge_decode_dev(param->dev));
+	if (md) {
+		mdptr = dm_get_mdptr(md);
+		dm_put(md);
+	}
+
+	return mdptr;
 }
 
 static struct mapped_device *find_device(struct dm_ioctl *param)
