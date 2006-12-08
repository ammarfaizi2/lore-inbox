Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164320AbWLHBF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164320AbWLHBF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164317AbWLHBF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:05:26 -0500
Received: from ns.suse.de ([195.135.220.2]:57923 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164319AbWLHBFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:05:24 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:05:37 +1100
Message-Id: <1061208010537.21307@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 5] md: Return a non-zero error to bi_end_io as appropriate in raid5.
References: <20061208120132.21203.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently raid5 depends on clearing the BIO_UPTODATE flag to signal an
error to higher levels.  While this should be sufficient, it is safer
to explicitly set the error code as well - less room for confusion.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-12-07 15:33:40.000000000 +1100
+++ ./drivers/md/raid5.c	2006-12-07 15:44:41.000000000 +1100
@@ -1818,7 +1818,9 @@ static void handle_stripe5(struct stripe
 		return_bi = bi->bi_next;
 		bi->bi_next = NULL;
 		bi->bi_size = 0;
-		bi->bi_end_io(bi, bytes, 0);
+		bi->bi_end_io(bi, bytes,
+			      test_bit(BIO_UPTODATE, &bi->bi_flags)
+			        ? 0 : -EIO);
 	}
 	for (i=disks; i-- ;) {
 		int rw;
@@ -2359,7 +2361,9 @@ static void handle_stripe6(struct stripe
 		return_bi = bi->bi_next;
 		bi->bi_next = NULL;
 		bi->bi_size = 0;
-		bi->bi_end_io(bi, bytes, 0);
+		bi->bi_end_io(bi, bytes,
+			      test_bit(BIO_UPTODATE, &bi->bi_flags)
+			        ? 0 : -EIO);
 	}
 	for (i=disks; i-- ;) {
 		int rw;
@@ -2859,7 +2863,9 @@ static int make_request(request_queue_t 
 		if ( rw == WRITE )
 			md_write_end(mddev);
 		bi->bi_size = 0;
-		bi->bi_end_io(bi, bytes, 0);
+		bi->bi_end_io(bi, bytes,
+			      test_bit(BIO_UPTODATE, &bi->bi_flags)
+			        ? 0 : -EIO);
 	}
 	return 0;
 }
@@ -3127,7 +3133,9 @@ static int  retry_aligned_read(raid5_con
 		int bytes = raid_bio->bi_size;
 
 		raid_bio->bi_size = 0;
-		raid_bio->bi_end_io(raid_bio, bytes, 0);
+		raid_bio->bi_end_io(raid_bio, bytes,
+			      test_bit(BIO_UPTODATE, &raid_bio->bi_flags)
+			        ? 0 : -EIO);
 	}
 	if (atomic_dec_and_test(&conf->active_aligned_reads))
 		wake_up(&conf->wait_for_stripe);
