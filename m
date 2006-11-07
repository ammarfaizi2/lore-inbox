Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753613AbWKGWKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbWKGWKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbWKGWKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:10:09 -0500
Received: from ns1.suse.de ([195.135.220.2]:23944 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753589AbWKGWKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:10:04 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 8 Nov 2006 09:10:07 +1100
Message-Id: <1061107221007.12586@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: [PATCH 009 of 9] md: Enable bypassing cache for reads.
References: <20061108085917.12064.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>

Call the chunk_aligned_read where appropriate.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    5 +++++
 1 file changed, 5 insertions(+)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-11-06 11:29:14.000000000 +1100
+++ ./drivers/md/raid5.c	2006-11-06 11:29:14.000000000 +1100
@@ -2798,6 +2798,11 @@ static int make_request(request_queue_t 
 	disk_stat_inc(mddev->gendisk, ios[rw]);
 	disk_stat_add(mddev->gendisk, sectors[rw], bio_sectors(bi));
 
+	if ( bio_data_dir(bi) == READ &&
+	     mddev->reshape_position == MaxSector &&
+	     chunk_aligned_read(q,bi))
+            		return 0;
+
 	logical_sector = bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
 	last_sector = bi->bi_sector + (bi->bi_size>>9);
 	bi->bi_next = NULL;
