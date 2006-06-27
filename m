Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030718AbWF0HIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030718AbWF0HIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030717AbWF0HIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:08:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:65443 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030719AbWF0HGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:06:18 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:06:12 +1000
Message-Id: <1060627070612.26094@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 012 of 12] md: Include sector number in messages about corrected read errors.
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is generally useful, but particularly helps see if it is
the same sector that always needs correcting, or different ones.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c  |    3 +++
 ./drivers/md/raid10.c |    4 ++++
 ./drivers/md/raid5.c  |   30 +++++++++++++++++++++++-------
 3 files changed, 30 insertions(+), 7 deletions(-)

diff .prev/drivers/md/raid1.c ./drivers/md/raid1.c
--- .prev/drivers/md/raid1.c	2006-06-27 12:17:33.000000000 +1000
+++ ./drivers/md/raid1.c	2006-06-27 12:17:34.000000000 +1000
@@ -1509,6 +1509,9 @@ static void raid1d(mddev_t *mddev)
 									 s<<9, conf->tmppage, READ) == 0)
 								/* Well, this device is dead */
 								md_error(mddev, rdev);
+							else
+								printk(KERN_INFO "raid1:%s: read error corrected (%d sectors at %llu on %s)\n",
+								       mdname(mddev), s, sect + rdev->data_offset, bdevname(rdev->bdev, b));
 						}
 					}
 				} else {

diff .prev/drivers/md/raid10.c ./drivers/md/raid10.c
--- .prev/drivers/md/raid10.c	2006-06-27 12:15:15.000000000 +1000
+++ ./drivers/md/raid10.c	2006-06-27 12:17:34.000000000 +1000
@@ -1492,6 +1492,10 @@ static void raid10d(mddev_t *mddev)
 									 s<<9, conf->tmppage, READ) == 0)
 								/* Well, this device is dead */
 								md_error(mddev, rdev);
+							else
+								printk(KERN_INFO "raid10:%s: read error corrected (%d sectors at %llu on %s)\n",
+								       mdname(mddev), s, sect+rdev->data_offset, bdevname(rdev->bdev, b));
+
 							rdev_dec_pending(rdev, mddev);
 							rcu_read_lock();
 						}

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-06-27 12:17:34.000000000 +1000
+++ ./drivers/md/raid5.c	2006-06-27 12:17:34.000000000 +1000
@@ -524,6 +524,8 @@ static int raid5_end_read_request(struct
 	raid5_conf_t *conf = sh->raid_conf;
 	int disks = sh->disks, i;
 	int uptodate = test_bit(BIO_UPTODATE, &bi->bi_flags);
+	char b[BDEVNAME_SIZE];
+	mdk_rdev_t *rdev;
 
 	if (bi->bi_size)
 		return 1;
@@ -571,25 +573,39 @@ static int raid5_end_read_request(struct
 		set_bit(R5_UPTODATE, &sh->dev[i].flags);
 #endif
 		if (test_bit(R5_ReadError, &sh->dev[i].flags)) {
-			printk(KERN_INFO "raid5: read error corrected!!\n");
+			rdev = conf->disks[i].rdev;
+			printk(KERN_INFO "raid5:%s: read error corrected (%lu sectors at %llu on %s)\n",
+			       mdname(conf->mddev), STRIPE_SECTORS,
+			       (unsigned long long)sh->sector + rdev->data_offset,
+			       bdevname(rdev->bdev, b));
 			clear_bit(R5_ReadError, &sh->dev[i].flags);
 			clear_bit(R5_ReWrite, &sh->dev[i].flags);
 		}
 		if (atomic_read(&conf->disks[i].rdev->read_errors))
 			atomic_set(&conf->disks[i].rdev->read_errors, 0);
 	} else {
+		const char *bdn = bdevname(conf->disks[i].rdev->bdev, b);
 		int retry = 0;
+		rdev = conf->disks[i].rdev;
+
 		clear_bit(R5_UPTODATE, &sh->dev[i].flags);
-		atomic_inc(&conf->disks[i].rdev->read_errors);
+		atomic_inc(&rdev->read_errors);
 		if (conf->mddev->degraded)
-			printk(KERN_WARNING "raid5: read error not correctable.\n");
+			printk(KERN_WARNING "raid5:%s: read error not correctable (sector %llu on %s).\n",
+			       mdname(conf->mddev),
+			       (unsigned long long)sh->sector + rdev->data_offset,
+			       bdn);
 		else if (test_bit(R5_ReWrite, &sh->dev[i].flags))
 			/* Oh, no!!! */
-			printk(KERN_WARNING "raid5: read error NOT corrected!!\n");
-		else if (atomic_read(&conf->disks[i].rdev->read_errors)
+			printk(KERN_WARNING "raid5:%s: read error NOT corrected!! (sector %llu on %s).\n",
+			       mdname(conf->mddev),
+			       (unsigned long long)sh->sector + rdev->data_offset,
+			       bdn);
+		else if (atomic_read(&rdev->read_errors)
 			 > conf->max_nr_stripes)
 			printk(KERN_WARNING
-			       "raid5: Too many read errors, failing device.\n");
+			       "raid5:%s: Too many read errors, failing device %s.\n",
+			       mdname(conf->mddev), bdn);
 		else
 			retry = 1;
 		if (retry)
@@ -597,7 +613,7 @@ static int raid5_end_read_request(struct
 		else {
 			clear_bit(R5_ReadError, &sh->dev[i].flags);
 			clear_bit(R5_ReWrite, &sh->dev[i].flags);
-			md_error(conf->mddev, conf->disks[i].rdev);
+			md_error(conf->mddev, rdev);
 		}
 	}
 	rdev_dec_pending(conf->disks[i].rdev, conf->mddev);
