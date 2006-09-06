Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWIFXBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWIFXBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWIFXB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:01:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:63691 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964897AbWIFXBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:01:03 -0400
Date: Wed, 6 Sep 2006 15:55:52 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jeffm@suse.com, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/37] dm: add DMF_FREEING
Message-ID: <20060906225552.GM15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-add-dmf_freeing.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Jeff Mahoney <jeffm@suse.com>

There is a chicken and egg problem between the block layer and dm in which the
gendisk associated with a mapping keeps a reference-less pointer to the
mapped_device.

This patch uses a new flag DMF_FREEING to indicate when the mapped_device is
no longer valid.  This is checked to prevent any attempt to open the device
from succeeding while the device is being destroyed.

[akpm: too late for 2.6.17 - suitable for 2.6.17.x after it has settled]

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/md/dm.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

--- linux-2.6.17.11.orig/drivers/md/dm.c
+++ linux-2.6.17.11/drivers/md/dm.c
@@ -63,6 +63,7 @@ union map_info *dm_get_mapinfo(struct bi
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
 #define DMF_FROZEN 2
+#define DMF_FREEING 3
 
 struct mapped_device {
 	struct rw_semaphore io_lock;
@@ -221,9 +222,23 @@ static int dm_blk_open(struct inode *ino
 {
 	struct mapped_device *md;
 
+	spin_lock(&_minor_lock);
+
 	md = inode->i_bdev->bd_disk->private_data;
+	if (!md)
+		goto out;
+
+	if (test_bit(DMF_FREEING, &md->flags)) {
+		md = NULL;
+		goto out;
+	}
+
 	dm_get(md);
-	return 0;
+
+out:
+	spin_unlock(&_minor_lock);
+
+	return md ? 0 : -ENXIO;
 }
 
 static int dm_blk_close(struct inode *inode, struct file *file)
@@ -919,6 +934,11 @@ static void free_dev(struct mapped_devic
 	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
 	free_minor(minor);
+
+	spin_lock(&_minor_lock);
+	md->disk->private_data = NULL;
+	spin_unlock(&_minor_lock);
+
 	put_disk(md->disk);
 	blk_cleanup_queue(md->queue);
 	kfree(md);
@@ -1023,9 +1043,14 @@ static struct mapped_device *dm_find_md(
 	spin_lock(&_minor_lock);
 
 	md = idr_find(&_minor_idr, minor);
-	if (md && (md == MINOR_ALLOCED || (dm_disk(md)->first_minor != minor)))
+	if (md && (md == MINOR_ALLOCED ||
+		   (dm_disk(md)->first_minor != minor) ||
+	           test_bit(DMF_FREEING, &md->flags))) {
 		md = NULL;
+		goto out;
+	}
 
+out:
 	spin_unlock(&_minor_lock);
 
 	return md;
@@ -1060,9 +1085,12 @@ void dm_put(struct mapped_device *md)
 {
 	struct dm_table *map;
 
+	BUG_ON(test_bit(DMF_FREEING, &md->flags));
+
 	if (atomic_dec_and_lock(&md->holders, &_minor_lock)) {
 		map = dm_get_table(md);
 		idr_replace(&_minor_idr, MINOR_ALLOCED, dm_disk(md)->first_minor);
+		set_bit(DMF_FREEING, &md->flags);
 		spin_unlock(&_minor_lock);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);

--
