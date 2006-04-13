Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWDMUgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWDMUgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWDMUfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:35:54 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:33558 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964961AbWDMUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:35:49 -0400
Date: Thu, 13 Apr 2006 16:35:46 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 02/08] dm: use idr_replace for minor_idr
Message-ID: <20060413203546.GA3196@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 A patch was submitted in August 2004 to replace the old bitmap minor
 allocation tracking with an IDR to both track allocation and provide
 a mapping.

 This works pretty well in execution, but the author overlooked a pretty
 important detail. With the old bitmap, it was enough to just mark the
 minor as allocated and return it. With the IDR code, the mapped_device
 is used to mark the minor as in use. The problem with that approach is
 that the mapped_device isn't done initializing, and is placed on a
 subsystem-wide data structure, which is then unlocked. Even if the
 assignment was delayed or the lock was held until initialization
 completed, there would still be a race when we register the disk with
 the block subsystem since we'd need a minor to register, but we'd need
 to be done registering before making the device available.

 This patch uses a place holder value, MINOR_ALLOCED, to mark the minor
 as allocated but in a state where it can't be used, such as
 mid-allocation or mid-free. At the end of the initialization, we
 replace the place holder with the pointer to the mapped_device, making
 it available to the rest of the dm subsystem.

 During the free process, we again use the place holder value in the
 IDR to indicate the minor is allocated but unavailable for use.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
--
 drivers/md/dm.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff -ruNpX ../dontdiff linux-2.6.16-staging1/drivers/md/dm.c linux-2.6.16-staging2/drivers/md/dm.c
--- linux-2.6.16-staging1/drivers/md/dm.c	2006-04-11 13:57:50.000000000 -0400
+++ linux-2.6.16-staging2/drivers/md/dm.c	2006-04-13 16:18:16.000000000 -0400
@@ -51,6 +51,8 @@ union map_info *dm_get_mapinfo(struct bi
         return NULL;
 }
 
+#define MINOR_ALLOCED ((void *)-1)
+
 /*
  * Bits for the md->flags field.
  */
@@ -728,7 +730,7 @@ static int specific_minor(struct mapped_
 		goto out;
 	}
 
-	r = idr_get_new_above(&_minor_idr, md, minor, &m);
+	r = idr_get_new_above(&_minor_idr, MINOR_ALLOCED, minor, &m);
 	if (r) {
 		goto out;
 	}
@@ -757,7 +759,7 @@ static int next_free_minor(struct mapped
 		goto out;
 	}
 
-	r = idr_get_new(&_minor_idr, md, &m);
+	r = idr_get_new(&_minor_idr, MINOR_ALLOCED, &m);
 	if (r) {
 		goto out;
 	}
@@ -840,6 +842,12 @@ static struct mapped_device *alloc_dev(u
 	init_waitqueue_head(&md->wait);
 	init_waitqueue_head(&md->eventq);
 
+	/* Populate the mapping, nobody knows we exist yet */
+	down(&_minor_lock);
+	r = idr_replace(&_minor_idr, md, minor);
+	up(&_minor_lock);
+	BUG_ON(r < 0);
+
 	return md;
 
  bad4:
@@ -963,7 +971,7 @@ static struct mapped_device *dm_find_md(
 	down(&_minor_lock);
 
 	md = idr_find(&_minor_idr, minor);
-	if (!md || (dm_disk(md)->first_minor != minor))
+	if (md && (md == MINOR_ALLOCED || (dm_disk(md)->first_minor != minor)))
 		md = NULL;
 
 	up(&_minor_lock);
@@ -1007,6 +1015,9 @@ void dm_put(struct mapped_device *md)
 	struct dm_table *map = dm_get_table(md);
 
 	if (atomic_dec_and_test(&md->holders)) {
+		down(&_minor_lock);
+		idr_replace(&_minor_idr, MINOR_ALLOCED, md->disk->first_minor);
+		up(&_minor_lock);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
 			dm_table_postsuspend_targets(map);
