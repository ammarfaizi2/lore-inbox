Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423155AbWCXGB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423155AbWCXGB3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423159AbWCXGB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:01:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:27546 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423156AbWCXGB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:01:27 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 24 Mar 2006 16:59:28 +1100
Message-Id: <1060324055928.2444@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 3] md: Remove bi_end_io call out from under a spinlock.
References: <20060324165531.2372.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


raid5 overloads bi_phys_segments to count the number of blocks that
the request was broken in to so that it knows when the bio is completely handled. 

Accessing this must  always be done under a spinlock.   In one case we
also call bi_end_io under that spinlock, which probably isn't ideal as
bi_end_io could be expensive (even though it isn't allowed to sleep).

So we reducde the range of the spinlock to just accessing bi_phys_segments.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-24 14:01:30.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-24 14:06:47.000000000 +1100
@@ -1743,6 +1743,7 @@ static int make_request(request_queue_t 
 	sector_t logical_sector, last_sector;
 	struct stripe_head *sh;
 	const int rw = bio_data_dir(bi);
+	int remaining;
 
 	if (unlikely(bio_barrier(bi))) {
 		bio_endio(bi, bi->bi_size, -EOPNOTSUPP);
@@ -1852,7 +1853,9 @@ static int make_request(request_queue_t 
 			
 	}
 	spin_lock_irq(&conf->device_lock);
-	if (--bi->bi_phys_segments == 0) {
+	remaining = --bi->bi_phys_segments;
+	spin_unlock_irq(&conf->device_lock);
+	if (remaining == 0) {
 		int bytes = bi->bi_size;
 
 		if ( bio_data_dir(bi) == WRITE )
@@ -1860,7 +1863,6 @@ static int make_request(request_queue_t 
 		bi->bi_size = 0;
 		bi->bi_end_io(bi, bytes, 0);
 	}
-	spin_unlock_irq(&conf->device_lock);
 	return 0;
 }
 
