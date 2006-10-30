Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161499AbWJ3VZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161499AbWJ3VZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 16:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161504AbWJ3VZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 16:25:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161499AbWJ3VZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 16:25:54 -0500
Message-ID: <45466D6C.802@ce.jp.nec.com>
Date: Mon, 30 Oct 2006 16:23:56 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: torvalds@osdl.org, akpm@osdl.org, rdunlap@xenotime.net, mst@mellanox.co.il,
       linux-kernel@vger.kernel.org
CC: bunk@stusta.de, pavel@suse.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org, martin@lorenz.eu.org
Subject: [PATCH 2.6.19-rc3] (2/2) clean up add_bd_holder()
Content-Type: multipart/mixed;
 boundary="------------000700020208060306060303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000700020208060306060303
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

This is an additional clean-up to "[PATCH 2.6.19-rc3] (1/2)
fix bd_claim_by_kobject error handling".

add_bd_holder() is called from bd_claim_by_kobject to
put a given struct bd_holder in the list if there is no
matching entry.

There are 3 possible results of add_bd_holder():
  1. there is no matching entry and add the given one to the list
  2. there is matching entry, so just increment reference count of
     the existing one
  3. something failed during its course

1 and 2 are success. But for the case 2, someone has to free
the unused struct bd_holder.
Current 2.6.19-rc3 code frees it inside of add_bd_holder and
returns same value 0 for both cases 1 and 2.
However, it's natural and less error-prone if caller frees it
since it's allocated by the caller.

The attached patch separates the function in 2 parts to make things
clear. The patch depends on the previous fix.

Please consider to apply.

Thanks,
-- 
Jun'ichi Nomura, NEC Corporation of America

--------------000700020208060306060303
Content-Type: text/x-patch;
 name="clean-up-add_bd_holder.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="clean-up-add_bd_holder.patch"

add_bd_holder() is called from bd_claim_by_kobject to
put a given struct bd_holder in the list if there is no
matching entry.

There are 3 possible results of add_bd_holder():
  1. there is no matching entry and add the given one to the list
  2. there is matching entry, so just increment reference count of
     the existing one
  3. something failed during its course

1 and 2 are success. But for the case 2, someone has to free
the unused struct bd_holder.
Current 2.6.19-rc3 code frees it inside of add_bd_holder and
returns same value 0 for both cases 1 and 2.
However, it's natural and less error-prone if caller frees it
since it's allocated by the caller.

 fs/block_dev.c |   53 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 18 deletions(-)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.withfix/fs/block_dev.c	2006-10-30 15:38:21.000000000 -0500
+++ linux-2.6/fs/block_dev.c	2006-10-30 13:24:09.000000000 -0500
@@ -642,16 +642,38 @@ static void free_bd_holder(struct bd_hol
 }
 
 /**
+ * find_bd_holder - find matching struct bd_holder from the block device
+ *
+ * @bdev:	struct block device to be searched
+ * @bo:		target struct bd_holder
+ *
+ * Returns matching entry with @bo in @bdev->bd_holder_list.
+ * If found, increment the reference count and return the pointer.
+ * If not found, returns NULL.
+ */
+static int find_bd_holder(struct block_device *bdev, struct bd_holder *bo)
+{
+	struct bd_holder *tmp;
+
+	list_for_each_entry(tmp, &bdev->bd_holder_list, list)
+		if (tmp->sdir == bo->sdir) {
+			tmp->count++;
+			return tmp;
+		}
+
+	return NULL;
+}
+
+/**
  * add_bd_holder - create sysfs symlinks for bd_claim() relationship
  *
  * @bdev:	block device to be bd_claimed
  * @bo:		preallocated and initialized by alloc_bd_holder()
  *
- * If there is no matching entry with @bo in @bdev->bd_holder_list,
- * add @bo to the list, create symlinks.
+ * Add @bo to @bdev->bd_holder_list, create symlinks.
  *
- * Returns 0 if symlinks are created or already there.
- * Returns -ve if something fails and @bo can be freed.
+ * Returns 0 if symlinks are created.
+ * Returns -ve if something fails.
  */
 static int add_bd_holder(struct block_device *bdev, struct bd_holder *bo)
 {
@@ -661,15 +683,6 @@ static int add_bd_holder(struct block_de
 	if (!bo)
 		return -EINVAL;
 
-	list_for_each_entry(tmp, &bdev->bd_holder_list, list) {
-		if (tmp->sdir == bo->sdir) {
-			tmp->count++;
-			/* We've already done what we need to do here. */
-			free_bd_holder(bo);
-			return 0;
-		}
-	}
-
 	if (!bd_holder_grab_dirs(bdev, bo))
 		return -EBUSY;
 
@@ -740,7 +753,7 @@ static int bd_claim_by_kobject(struct bl
 				struct kobject *kobj)
 {
 	int res;
-	struct bd_holder *bo;
+	struct bd_holder *bo, *found;
 
 	if (!kobj)
 		return -EINVAL;
@@ -752,11 +765,15 @@ static int bd_claim_by_kobject(struct bl
 	mutex_lock_nested(&bdev->bd_mutex, BD_MUTEX_PARTITION);
 	res = bd_claim(bdev, holder);
 	if (res == 0) {
-		res = add_bd_holder(bdev, bo);
-		if (res)
-			bd_release(bdev);
+		found = find_bd_holder(bdev, bo);
+		if (found == NULL) {
+			res = add_bd_holder(bdev, bo);
+			if (res)
+				bd_release(bdev);
+		}
 	}
-	if (res)
+
+	if (res || found)
 		free_bd_holder(bo);
 	mutex_unlock(&bdev->bd_mutex);
 

--------------000700020208060306060303--
