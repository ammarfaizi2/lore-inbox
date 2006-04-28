Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbWD1Cwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbWD1Cwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 22:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWD1CwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 22:52:08 -0400
Received: from mail.suse.de ([195.135.220.2]:21123 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965199AbWD1Cv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 22:51:59 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Apr 2006 12:51:55 +1000
Message-Id: <1060428025155.30796@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 5] md: Fix 'rdev->nr_pending' count when retrying barrier requests.
References: <20060428124313.29510.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When retrying a failed BIO_RW_BARRIER request, we need to
keep the reference in ->nr_pending over the whole retry.
Currently, we only hold the reference if the failed request is
the *last* one to finish - which is silly, because it would normally 
be the first to finish.

So move the rdev_dec_pending call up into the didn't-fail branch.
As the rdev isn't used in the later code, calling rdev_dec_pending
earlier doesn't hurt.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid1.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff ./drivers/md/raid1.c~current~ ./drivers/md/raid1.c
--- ./drivers/md/raid1.c~current~	2006-04-28 12:17:40.000000000 +1000
+++ ./drivers/md/raid1.c	2006-04-28 12:17:58.000000000 +1000
@@ -319,6 +319,7 @@ static int raid1_end_write_request(struc
 		set_bit(BarriersNotsupp, &conf->mirrors[mirror].rdev->flags);
 		set_bit(R1BIO_BarrierRetry, &r1_bio->state);
 		r1_bio->mddev->barriers_work = 0;
+		/* Don't rdev_dec_pending in this branch - keep it for the retry */
 	} else {
 		/*
 		 * this branch is our 'one mirror IO has finished' event handler:
@@ -365,6 +366,7 @@ static int raid1_end_write_request(struc
 				}
 			}
 		}
+		rdev_dec_pending(conf->mirrors[mirror].rdev, conf->mddev);
 	}
 	/*
 	 *
@@ -374,11 +376,9 @@ static int raid1_end_write_request(struc
 	if (atomic_dec_and_test(&r1_bio->remaining)) {
 		if (test_bit(R1BIO_BarrierRetry, &r1_bio->state)) {
 			reschedule_retry(r1_bio);
-			/* Don't dec_pending yet, we want to hold
-			 * the reference over the retry
-			 */
 			goto out;
 		}
+		/* it really is the end of this request */
 		if (test_bit(R1BIO_BehindIO, &r1_bio->state)) {
 			/* free extra copy of the data pages */
 			int i = bio->bi_vcnt;
@@ -393,8 +393,6 @@ static int raid1_end_write_request(struc
 		md_write_end(r1_bio->mddev);
 		raid_end_bio_io(r1_bio);
 	}
-
-	rdev_dec_pending(conf->mirrors[mirror].rdev, conf->mddev);
  out:
 	if (to_put)
 		bio_put(to_put);
@@ -1414,6 +1412,7 @@ static void raid1d(mddev_t *mddev)
 			 * Better resubmit without the barrier.
 			 * We know which devices to resubmit for, because
 			 * all others have had their bios[] entry cleared.
+			 * We already have a nr_pending reference on these rdevs.
 			 */
 			int i;
 			clear_bit(R1BIO_BarrierRetry, &r1_bio->state);
