Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWC3Fyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWC3Fyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWC3Fy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:54:27 -0500
Received: from ns2.suse.de ([195.135.220.15]:12448 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751084AbWC3FyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:54:23 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 30 Mar 2006 16:52:37 +1100
Message-Id: <1060330055237.25270@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 3] md: Don't clear bits in bitmap when writing to one device fails during recovery.
References: <20060330164933.25210.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently a device failure during recovery leaves bits set in the
bitmap.  This normally isn't a problem as the offending device will be
rejected because of errors.  However if device re-adding is being used
with non-persistent bitmaps, this can be a problem.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-03-30 16:48:29.000000000 +1100
+++ ./drivers/md/raid1.c	2006-03-30 16:48:40.000000000 +1100
@@ -1135,8 +1135,19 @@ static int end_sync_write(struct bio *bi
 			mirror = i;
 			break;
 		}
-	if (!uptodate)
+	if (!uptodate) {
+		int sync_blocks = 0;
+		sector_t s = r1_bio->sector;
+		long sectors_to_go = r1_bio->sectors;
+		/* make sure these bits doesn't get cleared. */
+		do {
+			bitmap_end_sync(mddev->bitmap, r1_bio->sector,
+					&sync_blocks, 1);
+			s += sync_blocks;
+			sectors_to_go -= sync_blocks;
+		} while (sectors_to_go > 0);
 		md_error(mddev, conf->mirrors[mirror].rdev);
+	}
 
 	update_head_pos(mirror, r1_bio);
 
