Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWC3FyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWC3FyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWC3FyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:54:25 -0500
Received: from mx1.suse.de ([195.135.220.2]:45745 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751085AbWC3FyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:54:23 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 30 Mar 2006 16:52:42 +1100
Message-Id: <1060330055242.25283@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 3] md: Remove some code that can sleep from under a spinlock.
References: <20060330164933.25210.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And remove the comments that were put in inplace of a fix too....

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-30 16:48:30.000000000 +1100
+++ ./drivers/md/md.c	2006-03-30 16:48:47.000000000 +1100
@@ -214,13 +214,11 @@ static void mddev_put(mddev_t *mddev)
 		return;
 	if (!mddev->raid_disks && list_empty(&mddev->disks)) {
 		list_del(&mddev->all_mddevs);
-		/* that blocks */
+		spin_unlock(&all_mddevs_lock);
 		blk_cleanup_queue(mddev->queue);
-		/* that also blocks */
 		kobject_unregister(&mddev->kobj);
-		/* result blows... */
-	}
-	spin_unlock(&all_mddevs_lock);
+	} else
+		spin_unlock(&all_mddevs_lock);
 }
 
 static mddev_t * mddev_find(dev_t unit)
