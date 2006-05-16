Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWEPBNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWEPBNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWEPBNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:13:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:30366 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750915AbWEPBN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:13:29 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 16 May 2006 11:13:12 +1000
Message-Id: <1060516011312.2735@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 3] md: Calculate correct array size for raid10 in new offset mode.
References: <20060516111036.2649.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The size calculation made assumtion which the new offset mode
didn't follow.  This gets the size right in all cases.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c~current~	2006-05-16 11:09:25.000000000 +1000
+++ ./drivers/md/raid10.c	2006-05-16 11:09:42.000000000 +1000
@@ -2060,7 +2060,13 @@ static int run(mddev_t *mddev)
 	/*
 	 * Ok, everything is just fine now
 	 */
-	size = conf->stride * conf->raid_disks;
+	if (conf->far_offset) {
+		size = mddev->size >> (conf->chunk_shift-1);
+		size *= conf->raid_disks;
+		size <<= conf->chunk_shift;
+		sector_div(size, conf->far_copies);
+	} else
+		size = conf->stride * conf->raid_disks;
 	sector_div(size, conf->near_copies);
 	mddev->array_size = size/2;
 	mddev->resync_max_sectors = size;
