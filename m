Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752492AbWCQEwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbWCQEwv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWCQEtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:49:16 -0500
Received: from ns2.suse.de ([195.135.220.15]:14476 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751340AbWCQEsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:48:47 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 15:47:30 +1100
Message-Id: <1060317044730.16035@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 13] md: Fix the 'failed' count for version-0 superblocks.
References: <20060317154017.15880.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are counting failed devices twice, once of the device that is
failed, and once for the hole that has been left in the array.  Remove
the former so 'failed' matches 'missing'.  Storing these counts in the
superblock is a bit silly anyway....

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-03-17 11:48:08.000000000 +1100
+++ ./drivers/md/md.c	2006-03-17 11:48:08.000000000 +1100
@@ -893,10 +893,9 @@ static void super_90_sync(mddev_t *mddev
 			d->raid_disk = rdev2->raid_disk;
 		else
 			d->raid_disk = rdev2->desc_nr; /* compatibility */
-		if (test_bit(Faulty, &rdev2->flags)) {
+		if (test_bit(Faulty, &rdev2->flags))
 			d->state = (1<<MD_DISK_FAULTY);
-			failed++;
-		} else if (test_bit(In_sync, &rdev2->flags)) {
+		else if (test_bit(In_sync, &rdev2->flags)) {
 			d->state = (1<<MD_DISK_ACTIVE);
 			d->state |= (1<<MD_DISK_SYNC);
 			active++;
