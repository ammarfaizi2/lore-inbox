Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWJTDZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWJTDZh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWJTDZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:25:37 -0400
Received: from mail.suse.de ([195.135.220.2]:60322 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751648AbWJTDZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:25:36 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 20 Oct 2006 13:25:30 +1000
Message-Id: <1061020032530.1668@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@kernel.org
Subject: [PATCH 001 of 4] md: Fix calculation of ->degraded for multipath and raid10
References: <20061020120612.29297.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two less-used md personalities have bugs in the calculation of 
 ->degraded (the extent to which the array is degraded).

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/multipath.c |    2 +-
 ./drivers/md/raid10.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff .prev/drivers/md/multipath.c ./drivers/md/multipath.c
--- .prev/drivers/md/multipath.c	2006-10-20 11:41:02.000000000 +1000
+++ ./drivers/md/multipath.c	2006-10-20 12:00:56.000000000 +1000
@@ -501,7 +501,7 @@ static int multipath_run (mddev_t *mddev
 			mdname(mddev));
 		goto out_free_conf;
 	}
-	mddev->degraded = conf->raid_disks = conf->working_disks;
+	mddev->degraded = conf->raid_disks - conf->working_disks;
 
 	conf->pool = mempool_create_kzalloc_pool(NR_RESERVED_BUFS,
 						 sizeof(struct multipath_bh));

diff .prev/drivers/md/raid10.c ./drivers/md/raid10.c
--- .prev/drivers/md/raid10.c	2006-10-20 11:41:02.000000000 +1000
+++ ./drivers/md/raid10.c	2006-10-20 12:00:56.000000000 +1000
@@ -2079,7 +2079,7 @@ static int run(mddev_t *mddev)
 		disk = conf->mirrors + i;
 
 		if (!disk->rdev ||
-		    !test_bit(In_sync, &rdev->flags)) {
+		    !test_bit(In_sync, &disk->rdev->flags)) {
 			disk->head_position = 0;
 			mddev->degraded++;
 		}
