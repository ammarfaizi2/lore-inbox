Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTHZCrp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 22:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTHZCrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 22:47:45 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:27825 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262502AbTHZCrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 22:47:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Date: Tue, 26 Aug 2003 12:47:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16202.51771.638332.396242@gargle.gargle.HOWL>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PATCH  odd code in bio_add_page
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was just taking a closer look at bio_add_page and there is some code
that doesn't mage sense.  The following patch explains the problem and
suggests a possible fix.

NeilBrown


==================================================
Fix strange code in bio_add_page

With the current code in bio_add_page, if fail_segments is ever set,
it stays set, so bio_add_page will eventually fail having recounted
the segmentation once.

I don't think this is intended.  This patch changes the code to allow
success if the recounting the segments helps.


 ----------- Diffstat output ------------
 ./fs/bio.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff ./fs/bio.c~current~ ./fs/bio.c
--- ./fs/bio.c~current~	2003-08-26 12:38:15.000000000 +1000
+++ ./fs/bio.c	2003-08-26 12:41:45.000000000 +1000
@@ -296,7 +296,7 @@ int bio_add_page(struct bio *bio, struct
 		 unsigned int offset)
 {
 	request_queue_t *q = bdev_get_queue(bio->bi_bdev);
-	int fail_segments = 0, retried_segments = 0;
+	int retried_segments = 0;
 	struct bio_vec *bvec;
 
 	/*
@@ -315,18 +315,15 @@ int bio_add_page(struct bio *bio, struct
 	 * we might lose a segment or two here, but rather that than
 	 * make this too complex.
 	 */
-retry_segments:
-	if (bio_phys_segments(q, bio) >= q->max_phys_segments
-	    || bio_hw_segments(q, bio) >= q->max_hw_segments)
-		fail_segments = 1;
 
-	if (fail_segments) {
+	while (bio_phys_segments(q, bio) >= q->max_phys_segments
+	    || bio_hw_segments(q, bio) >= q->max_hw_segments) {
+
 		if (retried_segments)
 			return 0;
 
 		bio->bi_flags &= ~(1 << BIO_SEG_VALID);
 		retried_segments = 1;
-		goto retry_segments;
 	}
 
 	/*
