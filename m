Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWH2Fja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWH2Fja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWH2Fj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:39:29 -0400
Received: from mail.suse.de ([195.135.220.2]:9632 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751124AbWH2Fj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:39:28 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 29 Aug 2006 15:39:24 +1000
Message-Id: <1060829053924.6610@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 4] md: Define backing_dev_info.congested_fn for raid0 and linear
References: <20060829153414.6475.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Each backing_dev needs to be able to report whether it is congested,
either by modulating BDI_*_congested in ->state, or by
defining a ->congested_fn.
md/raid did neither of these.  This patch add a congested_fn
which simply checks all component devices to see if they are
congested.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/linear.c |   15 +++++++++++++++
 ./drivers/md/raid0.c  |   17 +++++++++++++++++
 2 files changed, 32 insertions(+)

diff .prev/drivers/md/linear.c ./drivers/md/linear.c
--- .prev/drivers/md/linear.c	2006-08-29 12:17:10.000000000 +1000
+++ ./drivers/md/linear.c	2006-08-29 14:12:26.000000000 +1000
@@ -111,6 +111,19 @@ static int linear_issue_flush(request_qu
 	return ret;
 }
 
+static int linear_congested(void *data, int bits)
+{
+	mddev_t *mddev = data;
+	linear_conf_t *conf = mddev_to_conf(mddev);
+	int i, ret = 0;
+
+	for (i = 0; i < mddev->raid_disks && !ret ; i++) {
+		request_queue_t *q = bdev_get_queue(conf->disks[i].rdev->bdev);
+		ret |= bdi_congested(&q->backing_dev_info, bits);
+	}
+	return ret;
+}
+
 static linear_conf_t *linear_conf(mddev_t *mddev, int raid_disks)
 {
 	linear_conf_t *conf;
@@ -269,6 +282,8 @@ static int linear_run (mddev_t *mddev)
 	blk_queue_merge_bvec(mddev->queue, linear_mergeable_bvec);
 	mddev->queue->unplug_fn = linear_unplug;
 	mddev->queue->issue_flush_fn = linear_issue_flush;
+	mddev->queue->backing_dev_info.congested_fn = linear_congested;
+	mddev->queue->backing_dev_info.congested_data = mddev;
 	return 0;
 }
 

diff .prev/drivers/md/raid0.c ./drivers/md/raid0.c
--- .prev/drivers/md/raid0.c	2006-08-29 12:50:07.000000000 +1000
+++ ./drivers/md/raid0.c	2006-08-29 14:11:49.000000000 +1000
@@ -60,6 +60,21 @@ static int raid0_issue_flush(request_que
 	return ret;
 }
 
+static int raid0_congested(void *data, int bits)
+{
+	mddev_t *mddev = data;
+	raid0_conf_t *conf = mddev_to_conf(mddev);
+	mdk_rdev_t **devlist = conf->strip_zone[0].dev;
+	int i, ret = 0;
+
+	for (i = 0; i < mddev->raid_disks && !ret ; i++) {
+		request_queue_t *q = bdev_get_queue(devlist[i]->bdev);
+
+		ret |= bdi_congested(&q->backing_dev_info, bits);
+	}
+	return ret;
+}
+
 
 static int create_strip_zones (mddev_t *mddev)
 {
@@ -236,6 +251,8 @@ static int create_strip_zones (mddev_t *
 	mddev->queue->unplug_fn = raid0_unplug;
 
 	mddev->queue->issue_flush_fn = raid0_issue_flush;
+	mddev->queue->backing_dev_info.congested_fn = raid0_congested;
+	mddev->queue->backing_dev_info.congested_data = mddev;
 
 	printk("raid0: done.\n");
 	return 0;
