Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTILFIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 01:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTILFIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 01:08:40 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:32443 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261695AbTILFIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 01:08:35 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: dick.streefland@xs4all.nl (Dick Streefland)
Date: Fri, 12 Sep 2003 15:08:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16225.21682.619106.670945@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5: Oops on mount /dev/md0
In-Reply-To: message from Dick Streefland on Wednesday September 10
References: <2ba3.3f5f8da3.bf8df@altium.nl>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 10, spam@streefland.xs4all.nl wrote:
> While experimenting with RAID-1 on two loopback devices, I got a
> kernel Oops. The RAID-1 volume contains an ext2 filesystem, which I
> can mount just fine. However, trying to mount it after turning off the
> RAID device with raidstop (which should fail of course), results in a
> segmentation fault and kernel Oops. Something is stuck after this,
> causing "sync" to hang. This is the scenario:

Yeh... thanks for the report.
This patch should fix it, and another case where an array that is
really stopped accepts io requests and crashes.

NeilBrown

=========================================
Don't setup make_request_fn for md array until *after* it has been start.

Also revert to md_fail_request before stopping an array.

The ->stop method can never fail, so there is not point checking it.

 ----------- Diffstat output ------------
 ./drivers/md/md.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2003-09-12 14:44:39.000000000 +1000
+++ ./drivers/md/md.c	2003-09-12 15:05:18.000000000 +1000
@@ -1607,9 +1607,6 @@ static int do_md_run(mddev_t * mddev)
 	mddev->pers = pers[pnum];
 	spin_unlock(&pers_lock);
 
-	blk_queue_make_request(mddev->queue, mddev->pers->make_request);
-	mddev->queue->queuedata = mddev;
-
 	err = mddev->pers->run(mddev);
 	if (err) {
 		printk(KERN_ERR "md: pers->run() failed ...\n");
@@ -1627,6 +1624,10 @@ static int do_md_run(mddev_t * mddev)
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_wakeup_thread(mddev->thread);
 	set_capacity(disk, mddev->array_size<<1);
+
+	blk_queue_make_request(mddev->queue, mddev->pers->make_request);
+	mddev->queue->queuedata = mddev;
+
 	return 0;
 }
 
@@ -1698,12 +1699,8 @@ static int do_md_stop(mddev_t * mddev, i
 		} else {
 			if (mddev->ro)
 				set_disk_ro(disk, 0);
-			if (mddev->pers->stop(mddev)) {
-				err = -EBUSY;
-				if (mddev->ro)
-					set_disk_ro(disk, 1);
-				goto out;
-			}
+			blk_queue_make_request(mddev->queue, md_fail_request);
+			mddev->pers->stop(mddev);
 			module_put(mddev->pers->owner);
 			mddev->pers = NULL;
 			if (mddev->ro)
