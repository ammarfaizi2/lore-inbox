Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWEAFaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWEAFaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWEAFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:30:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:34224 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750870AbWEAFaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:30:08 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:30:03 +1000
Message-Id: <1060501053003.22913@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 11] md: Reformat code in raid1_end_write_request to avoid goto
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A recent change made this goto unnecessary, so reformat the
code to make it clearer what is happening.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./drivers/md/raid1.c	2006-05-01 15:10:00.000000000 +1000
@@ -374,26 +374,26 @@ static int raid1_end_write_request(struc
 	 * already.
 	 */
 	if (atomic_dec_and_test(&r1_bio->remaining)) {
-		if (test_bit(R1BIO_BarrierRetry, &r1_bio->state)) {
+		if (test_bit(R1BIO_BarrierRetry, &r1_bio->state))
 			reschedule_retry(r1_bio);
-			goto out;
+		else {
+			/* it really is the end of this request */
+			if (test_bit(R1BIO_BehindIO, &r1_bio->state)) {
+				/* free extra copy of the data pages */
+				int i = bio->bi_vcnt;
+				while (i--)
+					safe_put_page(bio->bi_io_vec[i].bv_page);
+			}
+			/* clear the bitmap if all writes complete successfully */
+			bitmap_endwrite(r1_bio->mddev->bitmap, r1_bio->sector,
+					r1_bio->sectors,
+					!test_bit(R1BIO_Degraded, &r1_bio->state),
+					behind);
+			md_write_end(r1_bio->mddev);
+			raid_end_bio_io(r1_bio);
 		}
-		/* it really is the end of this request */
-		if (test_bit(R1BIO_BehindIO, &r1_bio->state)) {
-			/* free extra copy of the data pages */
-			int i = bio->bi_vcnt;
-			while (i--)
-				safe_put_page(bio->bi_io_vec[i].bv_page);
-		}
-		/* clear the bitmap if all writes complete successfully */
-		bitmap_endwrite(r1_bio->mddev->bitmap, r1_bio->sector,
-				r1_bio->sectors,
-				!test_bit(R1BIO_Degraded, &r1_bio->state),
-				behind);
-		md_write_end(r1_bio->mddev);
-		raid_end_bio_io(r1_bio);
 	}
- out:
+
 	if (to_put)
 		bio_put(to_put);
 
