Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752558AbWCQHXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbWCQHXG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 02:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbWCQHXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 02:23:04 -0500
Received: from mx1.suse.de ([195.135.220.2]:51080 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752553AbWCQHW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 02:22:57 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 18:21:40 +1100
Message-Id: <1060317072140.28656@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 6] md: Improve comments about locking situation in raid5 make_request
References: <20060317181912.28543.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff ./drivers/md/raid5.c~current~ ./drivers/md/raid5.c
--- ./drivers/md/raid5.c~current~	2006-03-17 18:18:35.000000000 +1100
+++ ./drivers/md/raid5.c	2006-03-17 18:18:44.000000000 +1100
@@ -1766,6 +1766,14 @@ static int make_request(request_queue_t 
 		if (likely(conf->expand_progress == MaxSector))
 			disks = conf->raid_disks;
 		else {
+			/* spinlock is needed as expand_progress may be
+			 * 64bit on a 32bit platform, and so it might be
+			 * possible to see a half-updated value
+			 * Ofcourse expand_progress could change after
+			 * the lock is dropped, so once we get a reference
+			 * to the stripe that we think it is, we will have
+			 * to check again.
+			 */
 			spin_lock_irq(&conf->device_lock);
 			disks = conf->raid_disks;
 			if (logical_sector >= conf->expand_progress)
@@ -1789,7 +1797,12 @@ static int make_request(request_queue_t 
 		if (sh) {
 			if (unlikely(conf->expand_progress != MaxSector)) {
 				/* expansion might have moved on while waiting for a
-				 * stripe, so we much do the range check again.
+				 * stripe, so we must do the range check again.
+				 * Expansion could still move past after this
+				 * test, but as we are holding a reference to
+				 * 'sh', we know that if that happens,
+				 *  STRIPE_EXPANDING will get set and the expansion
+				 * won't proceed until we finish with the stripe.
 				 */
 				int must_retry = 0;
 				spin_lock_irq(&conf->device_lock);
