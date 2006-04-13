Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWDMUgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWDMUgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWDMUf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:58 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:37654 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964974AbWDMUfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:50 -0400
Date: Thu, 13 Apr 2006 16:35:46 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 06/08] dm: fix refcounting
Message-ID: <20060413203546.GA3246@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 For the most part, reference counting in the dm code is ok, but it must be
 taken under the _minor_lock. There are paths where a mapped_device pointer
 is returned and then a reference is taken - and taking the reference may be
 too late.

 This patch fixes a number of paths so that the reference is always taken
 under the lock.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
--
 drivers/md/dm-ioctl.c |   20 ++++++++++++++++----
 drivers/md/dm.c       |   16 ++++------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff -ruNpX ../dontdiff linux-2.6.16-staging1/drivers/md/dm.c linux-2.6.16-staging2/drivers/md/dm.c
--- linux-2.6.16-staging1/drivers/md/dm.c	2006-04-13 16:18:22.000000000 -0400
+++ linux-2.6.16-staging2/drivers/md/dm.c	2006-04-13 16:18:22.000000000 -0400
@@ -969,7 +969,7 @@ int dm_create_with_minor(unsigned int mi
 	return create_aux(minor, 1, result);
 }
 
-static struct mapped_device *dm_find_md(dev_t dev)
+struct mapped_device *dm_get_md(dev_t dev)
 {
 	struct mapped_device *md;
 	unsigned minor = MINOR(dev);
@@ -986,6 +986,8 @@ static struct mapped_device *dm_find_md(
 	if (md) {
 		if (test_bit(DMF_FREEING, &md->flags))
 			md = NULL;
+		else
+			dm_get(md);
 	}
 
 	spin_unlock(&_minor_lock);
@@ -993,22 +995,12 @@ static struct mapped_device *dm_find_md(
 	return md;
 }
 
-struct mapped_device *dm_get_md(dev_t dev)
-{
-	struct mapped_device *md = dm_find_md(dev);
-
-	if (md)
-		dm_get(md);
-
-	return md;
-}
-
 void *dm_get_mdptr(dev_t dev)
 {
 	struct mapped_device *md;
 	void *mdptr = NULL;
 
-	md = dm_find_md(dev);
+	md = dm_get_md(dev);
 	if (md)
 		mdptr = md->interface_ptr;
 	return mdptr;
diff -ruNpX ../dontdiff linux-2.6.16-staging1/drivers/md/dm-ioctl.c linux-2.6.16-staging2/drivers/md/dm-ioctl.c
--- linux-2.6.16-staging1/drivers/md/dm-ioctl.c	2006-04-05 14:02:34.000000000 -0400
+++ linux-2.6.16-staging2/drivers/md/dm-ioctl.c	2006-04-13 16:18:22.000000000 -0400
@@ -600,12 +600,16 @@ static int dev_create(struct dm_ioctl *p
  */
 static struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
 {
+	struct hash_cell *hc;
 	if (*param->uuid)
-		return __get_uuid_cell(param->uuid);
+		hc = __get_uuid_cell(param->uuid);
 	else if (*param->name)
-		return __get_name_cell(param->name);
+		hc = __get_name_cell(param->name);
 	else
 		return dm_get_mdptr(huge_decode_dev(param->dev));
+	if (hc)
+		dm_get(hc->md);
+	return hc;
 }
 
 static struct mapped_device *find_device(struct dm_ioctl *param)
@@ -617,7 +621,6 @@ static struct mapped_device *find_device
 	hc = __find_device_hash_cell(param);
 	if (hc) {
 		md = hc->md;
-		dm_get(md);
 
 		/*
 		 * Sneakily write in both the name and the uuid
@@ -642,6 +645,7 @@ static struct mapped_device *find_device
 static int dev_remove(struct dm_ioctl *param, size_t param_size)
 {
 	struct hash_cell *hc;
+	struct mapped_device *md;
 
 	down_write(&_hash_lock);
 	hc = __find_device_hash_cell(param);
@@ -652,8 +656,11 @@ static int dev_remove(struct dm_ioctl *p
 		return -ENXIO;
 	}
 
+	md = hc->md;
+
 	__hash_remove(hc);
 	up_write(&_hash_lock);
+	dm_put(md);
 	param->data_size = 0;
 	return 0;
 }
@@ -731,7 +738,6 @@ static int do_resume(struct dm_ioctl *pa
 	}
 
 	md = hc->md;
-	dm_get(md);
 
 	new_map = hc->new_map;
 	hc->new_map = NULL;
@@ -975,6 +981,7 @@ static int table_load(struct dm_ioctl *p
 	int r;
 	struct hash_cell *hc;
 	struct dm_table *t;
+	struct mapped_device *md;
 
 	r = dm_table_create(&t, get_mode(param), param->target_count);
 	if (r)
@@ -1001,7 +1008,9 @@ static int table_load(struct dm_ioctl *p
 	param->flags |= DM_INACTIVE_PRESENT_FLAG;
 
 	r = __dev_status(hc->md, param);
+	md = hc->md;
 	up_write(&_hash_lock);
+	dm_put(md);
 	return r;
 }
 
@@ -1009,6 +1018,7 @@ static int table_clear(struct dm_ioctl *
 {
 	int r;
 	struct hash_cell *hc;
+	struct mapped_device *md;
 
 	down_write(&_hash_lock);
 
@@ -1027,7 +1037,9 @@ static int table_clear(struct dm_ioctl *
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
 	r = __dev_status(hc->md, param);
+	md = hc->md;
 	up_write(&_hash_lock);
+	dm_put(md);
 	return r;
 }
 
