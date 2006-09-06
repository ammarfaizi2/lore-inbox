Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWIFXLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWIFXLV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWIFXCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:02:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:54476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964954AbWIFXCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:02:08 -0400
Date: Wed, 6 Sep 2006 15:56:15 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jeffm@suse.com, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 13/37] dm: fix mapped device ref counting
Message-ID: <20060906225615.GN15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-fix-mapped-device-ref-counting.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

To avoid races, _minor_lock must be held while changing mapped device
reference counts.

There are a few paths where a mapped_device pointer is returned before a
reference is taken.  This patch fixes them.

[akpm: too late for 2.6.17 - suitable for 2.6.17.x after it has settled]

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm-ioctl.c |   34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

--- linux-2.6.17.11.orig/drivers/md/dm-ioctl.c
+++ linux-2.6.17.11/drivers/md/dm-ioctl.c
@@ -102,8 +102,10 @@ static struct hash_cell *__get_name_cell
 	unsigned int h = hash_str(str);
 
 	list_for_each_entry (hc, _name_buckets + h, name_list)
-		if (!strcmp(hc->name, str))
+		if (!strcmp(hc->name, str)) {
+			dm_get(hc->md);
 			return hc;
+		}
 
 	return NULL;
 }
@@ -114,8 +116,10 @@ static struct hash_cell *__get_uuid_cell
 	unsigned int h = hash_str(str);
 
 	list_for_each_entry (hc, _uuid_buckets + h, uuid_list)
-		if (!strcmp(hc->uuid, str))
+		if (!strcmp(hc->uuid, str)) {
+			dm_get(hc->md);
 			return hc;
+		}
 
 	return NULL;
 }
@@ -191,7 +195,7 @@ static int unregister_with_devfs(struct 
  */
 static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
 {
-	struct hash_cell *cell;
+	struct hash_cell *cell, *hc;
 
 	/*
 	 * Allocate the new cells.
@@ -204,14 +208,19 @@ static int dm_hash_insert(const char *na
 	 * Insert the cell into both hash tables.
 	 */
 	down_write(&_hash_lock);
-	if (__get_name_cell(name))
+	hc = __get_name_cell(name);
+	if (hc) {
+		dm_put(hc->md);
 		goto bad;
+	}
 
 	list_add(&cell->name_list, _name_buckets + hash_str(name));
 
 	if (uuid) {
-		if (__get_uuid_cell(uuid)) {
+		hc = __get_uuid_cell(uuid);
+		if (hc) {
 			list_del(&cell->name_list);
+			dm_put(hc->md);
 			goto bad;
 		}
 		list_add(&cell->uuid_list, _uuid_buckets + hash_str(uuid));
@@ -289,6 +298,7 @@ static int dm_hash_rename(const char *ol
 	if (hc) {
 		DMWARN("asked to rename to an already existing name %s -> %s",
 		       old, new);
+		dm_put(hc->md);
 		up_write(&_hash_lock);
 		kfree(new_name);
 		return -EBUSY;
@@ -328,6 +338,7 @@ static int dm_hash_rename(const char *ol
 		dm_table_put(table);
 	}
 
+	dm_put(hc->md);
 	up_write(&_hash_lock);
 	kfree(old_name);
 	return 0;
@@ -611,10 +622,8 @@ static struct hash_cell *__find_device_h
 		return __get_name_cell(param->name);
 
 	md = dm_get_md(huge_decode_dev(param->dev));
-	if (md) {
+	if (md)
 		mdptr = dm_get_mdptr(md);
-		dm_put(md);
-	}
 
 	return mdptr;
 }
@@ -628,7 +637,6 @@ static struct mapped_device *find_device
 	hc = __find_device_hash_cell(param);
 	if (hc) {
 		md = hc->md;
-		dm_get(md);
 
 		/*
 		 * Sneakily write in both the name and the uuid
@@ -653,6 +661,7 @@ static struct mapped_device *find_device
 static int dev_remove(struct dm_ioctl *param, size_t param_size)
 {
 	struct hash_cell *hc;
+	struct mapped_device *md;
 
 	down_write(&_hash_lock);
 	hc = __find_device_hash_cell(param);
@@ -663,8 +672,11 @@ static int dev_remove(struct dm_ioctl *p
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
@@ -790,7 +802,6 @@ static int do_resume(struct dm_ioctl *pa
 	}
 
 	md = hc->md;
-	dm_get(md);
 
 	new_map = hc->new_map;
 	hc->new_map = NULL;
@@ -1078,6 +1089,7 @@ static int table_clear(struct dm_ioctl *
 {
 	int r;
 	struct hash_cell *hc;
+	struct mapped_device *md;
 
 	down_write(&_hash_lock);
 
@@ -1096,7 +1108,9 @@ static int table_clear(struct dm_ioctl *
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
 	r = __dev_status(hc->md, param);
+	md = hc->md;
 	up_write(&_hash_lock);
+	dm_put(md);
 	return r;
 }
 

--
