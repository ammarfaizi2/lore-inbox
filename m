Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWEAFam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWEAFam (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWEAFaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:30:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:35504 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750873AbWEAFaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:30:14 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:30:09 +1000
Message-Id: <1060501053009.22925@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 11] md: Remove arbitrary limit on chunk size.
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The largest chunk size the code can support without substantial
surgery is 2^30 bytes, so make that the limit instead of an arbitrary
4Meg.
Some day, the 'chunksize' should change to a sector-shift
instead of a byte-count.  Then no limit would be needed.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c       |    2 +-
 ./drivers/md/raid5.c        |    4 ++--
 ./drivers/md/raid6main.c    |    4 ++--
 ./include/linux/raid/md_k.h |    3 ++-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./drivers/md/raid10.c	2006-05-01 15:10:17.000000000 +1000
@@ -2050,7 +2050,7 @@ static int run(mddev_t *mddev)
 	 * maybe...
 	 */
 	{
-		int stripe = conf->raid_disks * mddev->chunk_size / PAGE_SIZE;
+		int stripe = conf->raid_disks * (mddev->chunk_size / PAGE_SIZE);
 		stripe /= conf->near_copies;
 		if (mddev->queue->backing_dev_info.ra_pages < 2* stripe)
 			mddev->queue->backing_dev_info.ra_pages = 2* stripe;

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./drivers/md/raid5.c	2006-05-01 15:10:17.000000000 +1000
@@ -2382,8 +2382,8 @@ static int run(mddev_t *mddev)
 	 * 2 * (n-1) * chunksize where 'n' is the number of raid devices
 	 */
 	{
-		int stripe = (mddev->raid_disks-1) * mddev->chunk_size
-			/ PAGE_SIZE;
+		int stripe = (mddev->raid_disks-1) *
+			(mddev->chunk_size / PAGE_SIZE);
 		if (mddev->queue->backing_dev_info.ra_pages < 2 * stripe)
 			mddev->queue->backing_dev_info.ra_pages = 2 * stripe;
 	}

diff ./drivers/md/raid6main.c~current~ ./drivers/md/raid6main.c
--- ./drivers/md/raid6main.c~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./drivers/md/raid6main.c	2006-05-01 15:10:17.000000000 +1000
@@ -2135,8 +2135,8 @@ static int run(mddev_t *mddev)
 	 * 2 * (n-2) * chunksize where 'n' is the number of raid devices
 	 */
 	{
-		int stripe = (mddev->raid_disks-2) * mddev->chunk_size
-			/ PAGE_SIZE;
+		int stripe = (mddev->raid_disks-2) *
+			(mddev->chunk_size / PAGE_SIZE);
 		if (mddev->queue->backing_dev_info.ra_pages < 2 * stripe)
 			mddev->queue->backing_dev_info.ra_pages = 2 * stripe;
 	}

diff ./include/linux/raid/md_k.h~current~ ./include/linux/raid/md_k.h
--- ./include/linux/raid/md_k.h~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./include/linux/raid/md_k.h	2006-05-01 15:10:17.000000000 +1000
@@ -40,7 +40,8 @@ typedef struct mdk_rdev_s mdk_rdev_t;
  * options passed in raidrun:
  */
 
-#define MAX_CHUNK_SIZE (4096*1024)
+/* Currently this must fix in an 'int' */
+#define MAX_CHUNK_SIZE (1<<30)
 
 /*
  * MD's 'extended' device
