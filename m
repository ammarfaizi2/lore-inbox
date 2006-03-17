Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWCQExl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWCQExl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbWCQEtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:49:11 -0500
Received: from mx1.suse.de ([195.135.220.2]:45033 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751382AbWCQEs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:48:57 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 15:47:40 +1100
Message-Id: <1060317044740.16060@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 13] md: Split disks array out of raid5 conf structure so it is easier to grow.
References: <20060317154017.15880.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Previously the array of disk information was included in the
raid5 'conf' structure which was allocated to an appropriate size.
This makes it awkward to change the size of that array.
So we split it off into a separate kmalloced array which will
require a little extra indexing, but is much easier to grow.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c         |   10 +++++++---
 ./drivers/md/raid6main.c     |   10 +++++++---
 ./include/linux/raid/raid5.h |    2 +-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-17 11:45:43.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-17 11:48:55.000000000 +1100
@@ -1822,11 +1822,13 @@ static int run(mddev_t *mddev)
 		return -EIO;
 	}
 
-	mddev->private = kzalloc(sizeof (raid5_conf_t)
-				 + mddev->raid_disks * sizeof(struct disk_info),
-				 GFP_KERNEL);
+	mddev->private = kzalloc(sizeof (raid5_conf_t), GFP_KERNEL);
 	if ((conf = mddev->private) == NULL)
 		goto abort;
+	conf->disks = kzalloc(mddev->raid_disks * sizeof(struct disk_info),
+			      GFP_KERNEL);
+	if (!conf->disks)
+		goto abort;
 
 	conf->mddev = mddev;
 
@@ -1966,6 +1968,7 @@ static int run(mddev_t *mddev)
 abort:
 	if (conf) {
 		print_raid5_conf(conf);
+		kfree(conf->disks);
 		kfree(conf->stripe_hashtbl);
 		kfree(conf);
 	}
@@ -1986,6 +1989,7 @@ static int stop(mddev_t *mddev)
 	kfree(conf->stripe_hashtbl);
 	blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 	sysfs_remove_group(&mddev->kobj, &raid5_attrs_group);
+	kfree(conf->disks);
 	kfree(conf);
 	mddev->private = NULL;
 	return 0;

diff ./drivers/md/raid6main.c~current~ ./drivers/md/raid6main.c
--- ./drivers/md/raid6main.c~current~	2006-03-17 11:45:43.000000000 +1100
+++ ./drivers/md/raid6main.c	2006-03-17 11:48:55.000000000 +1100
@@ -2006,11 +2006,14 @@ static int run(mddev_t *mddev)
 		return -EIO;
 	}
 
-	mddev->private = kzalloc(sizeof (raid6_conf_t)
-				 + mddev->raid_disks * sizeof(struct disk_info),
-				 GFP_KERNEL);
+	mddev->private = kzalloc(sizeof (raid6_conf_t), GFP_KERNEL);
 	if ((conf = mddev->private) == NULL)
 		goto abort;
+	conf->disks = kzalloc(mddev->raid_disks * sizeof(struct disk_info),
+				 GFP_KERNEL);
+	if (!conf->disks)
+		goto abort;
+
 	conf->mddev = mddev;
 
 	if ((conf->stripe_hashtbl = kzalloc(PAGE_SIZE, GFP_KERNEL)) == NULL)
@@ -2158,6 +2161,7 @@ abort:
 		print_raid6_conf(conf);
 		safe_put_page(conf->spare_page);
 		kfree(conf->stripe_hashtbl);
+		kfree(conf->disks);
 		kfree(conf);
 	}
 	mddev->private = NULL;

diff ./include/linux/raid/raid5.h~current~ ./include/linux/raid/raid5.h
--- ./include/linux/raid/raid5.h~current~	2006-03-17 11:45:43.000000000 +1100
+++ ./include/linux/raid/raid5.h	2006-03-17 11:48:55.000000000 +1100
@@ -240,7 +240,7 @@ struct raid5_private_data {
 							 * waiting for 25% to be free
 							 */        
 	spinlock_t		device_lock;
-	struct disk_info	disks[0];
+	struct disk_info	*disks;
 };
 
 typedef struct raid5_private_data raid5_conf_t;
