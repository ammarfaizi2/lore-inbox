Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164333AbWLHBGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164333AbWLHBGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164325AbWLHBFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:05:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:46650 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164303AbWLHBFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:05:34 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:05:47 +1100
Message-Id: <1061208010547.21331@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 5] md: Close a race between destroying and recreating an md device.
References: <20061208120132.21203.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For each md device, we need a gendisk.  As that gendisk has a name
that gets registered in sysfs, we need to make sure that when an md
device is shut down, we don't create it again until the shutdown is
complete and the gendisk has been deleted.

This patches utilises the disks_mutex to ensure the proper exclusion.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-12-07 15:45:31.000000000 +1100
+++ ./drivers/md/md.c	2006-12-07 21:01:11.000000000 +1100
@@ -222,18 +222,36 @@ static inline mddev_t *mddev_get(mddev_t
 	return mddev;
 }
 
+static DEFINE_MUTEX(disks_mutex);
 static void mddev_put(mddev_t *mddev)
 {
+	/* We need to hold disks_mutex to safely destroy the gendisk
+	 * info before someone else creates a new gendisk with the same
+	 * name, but we don't want to take that mutex just to decrement
+	 * the ->active counter.  So we first test if this is the last
+	 * reference.  If it is, we put things back as they were found
+	 * and take disks_mutex before trying again.
+	 */
 	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
+	atomic_inc(&mddev->active);
+	spin_unlock(&all_mddevs_lock);
+
+	mutex_lock(&disks_mutex);
+
+	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock)) {
+		mutex_unlock(&disks_mutex);
+		return;
+	}
 	list_del(&mddev->all_mddevs);
 	spin_unlock(&all_mddevs_lock);
 
-	del_gendisk(mddev->gendisk);
-	mddev->gendisk = NULL;
+	if (mddev->gendisk)
+		del_gendisk(mddev->gendisk);
 	blk_cleanup_queue(mddev->queue);
-	mddev->queue = NULL;
 	kobject_unregister(&mddev->kobj);
+
+	mutex_unlock(&disks_mutex);
 }
 
 static mddev_t * mddev_find(dev_t unit)
@@ -2948,7 +2966,6 @@ int mdp_major = 0;
 
 static struct kobject *md_probe(dev_t dev, int *part, void *data)
 {
-	static DEFINE_MUTEX(disks_mutex);
 	mddev_t *mddev = mddev_find(dev);
 	struct gendisk *disk;
 	int partitioned = (MAJOR(dev) != MD_MAJOR);
