Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbWD1CwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbWD1CwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWD1CwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:52:10 -0400
Received: from ns.suse.de ([195.135.220.2]:20355 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965194AbWD1Cvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:51:54 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Apr 2006 12:51:50 +1000
Message-Id: <1060428025150.30782@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 5] md: Improve detection of lack of barrier support in raid1
References: <20060428124313.29510.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Move the test for 'do barrier work' down a bit so that if the first
write to a raid1 is a BIO_RW_BARRIER write, the checking done by
superblock writes will cause the right thing to happen.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-04-28 12:17:27.000000000 +1000
+++ ./drivers/md/raid1.c	2006-04-28 12:17:40.000000000 +1000
@@ -753,18 +753,24 @@ static int make_request(request_queue_t 
 	const int rw = bio_data_dir(bio);
 	int do_barriers;
 
-	if (unlikely(!mddev->barriers_work && bio_barrier(bio))) {
-		bio_endio(bio, bio->bi_size, -EOPNOTSUPP);
-		return 0;
-	}
-
 	/*
 	 * Register the new request and wait if the reconstruction
 	 * thread has put up a bar for new requests.
 	 * Continue immediately if no resync is active currently.
+	 * We test barriers_work *after* md_write_start as md_write_start
+	 * may cause the first superblock write, and that will check out
+	 * if barriers work.
 	 */
+
 	md_write_start(mddev, bio); /* wait on superblock update early */
 
+	if (unlikely(!mddev->barriers_work && bio_barrier(bio))) {
+		if (rw == WRITE)
+			md_write_end(mddev);
+		bio_endio(bio, bio->bi_size, -EOPNOTSUPP);
+		return 0;
+	}
+
 	wait_barrier(conf);
 
 	disk_stat_inc(mddev->gendisk, ios[rw]);
