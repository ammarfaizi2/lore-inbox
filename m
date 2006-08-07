Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWHGAWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWHGAWr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 20:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWHGAWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 20:22:46 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:21956 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750840AbWHGAWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 20:22:46 -0400
Date: Sun, 6 Aug 2006 20:15:15 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] raid1: allow user to force reads from a specific disk
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Message-ID: <200608062018_MC3-1-C74D-B4E9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow user to force raid1 to read all data from a given disk.
This lets users do integrity checking by comparing results
from reading different disks.  If at any time the system finds
it cannot read from the given disk it resets the disk number
to -1, the default, which means to balance reads.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 drivers/md/raid1.c         |   72 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/raid/raid1.h |    1 
 2 files changed, 70 insertions(+), 3 deletions(-)

--- 2.6.18-rc3-32.orig/drivers/md/raid1.c
+++ 2.6.18-rc3-32/drivers/md/raid1.c
@@ -418,19 +418,37 @@ static int raid1_end_write_request(struc
 static int read_balance(conf_t *conf, r1bio_t *r1_bio)
 {
 	const unsigned long this_sector = r1_bio->sector;
-	int new_disk = conf->last_used, disk = new_disk;
-	int wonly_disk = -1;
+	int new_disk = conf->read_from_disk, disk = conf->last_used;
+	int wonly_disk = -1, forced_read = 0;
 	const int sectors = r1_bio->sectors;
 	sector_t new_distance, current_distance;
 	mdk_rdev_t *rdev;
 
 	rcu_read_lock();
+
+	if (new_disk != -1) {
+		/* user has forced reads to one disk */
+		forced_read = 1;
+		if (new_disk >= 0 && new_disk < conf->raid_disks)
+			goto rb_out;
+	}
+
+	new_disk = conf->last_used;
 	/*
 	 * Check if we can balance. We can balance on the whole
 	 * device if no resync is going on, or below the resync window.
 	 * We take the first readable disk when above the resync window.
 	 */
  retry:
+	/*
+	 * If we reach this point and user has forced reads from one disk,
+	 * disable the forced reads because they cannot be done.  User can
+	 * check the "read_from_disk" attribute after doing IO to see if
+	 * all the reads were really done from the correct disk.
+	 */
+	if (forced_read)
+		conf->read_from_disk = -1;
+
 	if (conf->mddev->recovery_cp < MaxSector &&
 	    (this_sector + sectors >= conf->next_resync)) {
 		/* Choose the first operation device, for consistancy */
@@ -518,7 +536,6 @@ static int read_balance(conf_t *conf, r1
 
  rb_out:
 
-
 	if (new_disk >= 0) {
 		rdev = rcu_dereference(conf->mirrors[new_disk].rdev);
 		if (!rdev)
@@ -1802,6 +1819,52 @@ static sector_t sync_request(mddev_t *md
 	return nr_sectors;
 }
 
+static ssize_t
+raid1_show_read_from_disk(mddev_t *mddev, char *page)
+{
+	conf_t *conf = mddev_to_conf(mddev);
+	if (conf)
+		return sprintf(page, "%d\n", conf->read_from_disk);
+	else
+		return 0;
+}
+
+static ssize_t
+raid1_store_read_from_disk(mddev_t *mddev, const char *page, size_t len)
+{
+	conf_t *conf = mddev_to_conf(mddev);
+	char *end;
+	int new;
+
+	if (len >= PAGE_SIZE)
+		return -EINVAL;
+	if (!conf)
+		return -ENODEV;
+
+	new = simple_strtoul(page, &end, 10);
+	if (!*page || (*end && *end != '\n') )
+		return -EINVAL;
+	if (new < -1 || new >= conf->raid_disks)
+		return -EINVAL;
+	conf->read_from_disk = new;
+
+	return len;
+}
+
+static struct md_sysfs_entry
+raid1_read_from_disk = __ATTR(read_from_disk, S_IRUGO | S_IWUSR,
+				raid1_show_read_from_disk,
+				raid1_store_read_from_disk);
+
+static struct attribute *raid1_attrs[] =  {
+	&raid1_read_from_disk.attr,
+	NULL,
+};
+static struct attribute_group raid1_attrs_group = {
+	.name = NULL,
+	.attrs = raid1_attrs,
+};
+
 static int run(mddev_t *mddev)
 {
 	conf_t *conf;
@@ -1913,6 +1976,7 @@ static int run(mddev_t *mddev)
 		      !test_bit(In_sync, &conf->mirrors[j].rdev->flags)) ; j++)
 		/* nothing */;
 	conf->last_used = j;
+	conf->read_from_disk = -1; /* default: balance reads */
 
 
 	mddev->thread = md_register_thread(raid1d, mddev, "%s_raid1");
@@ -1930,6 +1994,8 @@ static int run(mddev_t *mddev)
 	/*
 	 * Ok, everything is just fine now
 	 */
+	sysfs_create_group(&mddev->kobj, &raid1_attrs_group);
+
 	mddev->array_size = mddev->size;
 
 	mddev->queue->unplug_fn = raid1_unplug;
--- 2.6.18-rc3-32.orig/include/linux/raid/raid1.h
+++ 2.6.18-rc3-32/include/linux/raid/raid1.h
@@ -32,6 +32,7 @@ struct r1_private_data_s {
 	int			raid_disks;
 	int			working_disks;
 	int			last_used;
+	int			read_from_disk;
 	sector_t		next_seq_sect;
 	spinlock_t		device_lock;
 
-- 
Chuck
