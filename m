Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWAJWUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWAJWUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWAJWUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:20:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13749 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932561AbWAJWUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:20:06 -0500
Message-ID: <43C43313.3000402@ce.jp.nec.com>
Date: Tue, 10 Jan 2006 17:20:03 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: device-mapper development <dm-devel@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] drivers/md/dm-raid1.c: Fix inconsistent mirroring after interrupted
 recovery
Content-Type: multipart/mixed;
 boundary="------------030401010002020505010006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401010002020505010006
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

dm-mirror has potential data corruption problem:
while on-disk log shows that all disk contents are in-sync,
actual contents of the disks are not synchronized.
This problem occurs if initial recovery (synching) is
interrupted and resumed.

Attached patch fixes this problem.
Please consider to apply.

Background:

rh_dec() changes the region state from RH_NOSYNC (out-of-sync)
to RH_CLEAN (in-sync), which results in the corresponding bit
of clean_bits being set.

This is harmful if on-disk log is used and the map is
removed/suspended before the initial sync is completed.
The clean_bits is written down to the on-disk log at the map
removal, and, upon resume, it's read and copied to sync_bits.
Since the recovery process refers to the sync_bits to find
a region to be recovered, the region whose state was changed
from RH_NOSYNC to RH_CLEAN is no longer recovered.

If you haven't applied dm-raid1-read-balancing.patch proposed
in dm-devel sometimes ago, the contents of the mirrored disk
just corrupt silently.
If you have, balanced read may get bogus data from out-of-sync
disks.

The patch keeps RH_NOSYNC state unchanged.
It will be changed to RH_RECOVERING when recovery starts
and get reclaimed when the recovery completes.
So it doesn't leak the region hash entry.

Thanks,
Jun'ichi "Nick" Nomura

--------------030401010002020505010006
Content-Type: text/x-patch;
 name="dm-mirror-keepnosync.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-mirror-keepnosync.patch"

Keep RH_NOSYNC state unchanged when I/O on the region completes.

rh_dec() changes the region state from RH_NOSYNC (out-of-sync)
to RH_CLEAN (in-sync), which results in the corresponding bit
of clean_bits being set.

This is harmful if on-disk log is used and the map is
removed/suspended before the initial sync is completed.
The clean_bits is written down to the on-disk log at the map
removal, and, upon resume, it's read and copied to sync_bits.
Since the recovery process refers to the sync_bits to find
a region to be recovered, the region whose state was changed
from RH_NOSYNC to RH_CLEAN is no longer recovered.

If you haven't applied dm-raid1-read-balancing.patch proposed
in dm-devel sometimes ago, the contents of the mirrored disk
just corrupt silently.
If you have, balanced read may get bogus data from out-of-sync
disks.

The RH_NOSYNC region will be changed to RH_RECOVERING when
recovery starts on the region and get reclaimed when the recovery
completes.
So it doesn't leak the region hash entry.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

diff -urp linux.orig/drivers/md/dm-raid1.c linux/drivers/md/dm-raid1.c
--- linux.orig/drivers/md/dm-raid1.c	2005-12-26 05:25:04.000000000 -0500
+++ linux/drivers/md/dm-raid1.c	2006-01-06 10:19:49.000000000 -0500
@@ -414,9 +414,21 @@ static void rh_dec(struct region_hash *r
 
 	spin_lock_irqsave(&rh->region_lock, flags);
 	if (atomic_dec_and_test(&reg->pending)) {
+		/*
+		 * There is no pending I/O for this region.
+		 * We can move the region to corresponding list for next action.
+		 * At this point, the region is not yet connected to any list.
+		 *
+		 * If the state is RH_NOSYNC, the region should be kept off
+		 * from clean list.
+		 * The hash entry for RH_NOSYNC will remain in memory
+		 * until the region is recovered or the map is reloaded.
+		 */
+
+		/* do nothing for RH_NOSYNC */
 		if (reg->state == RH_RECOVERING) {
 			list_add_tail(&reg->list, &rh->quiesced_regions);
-		} else {
+		} else if (reg->state == RH_DIRTY) {
 			reg->state = RH_CLEAN;
 			list_add(&reg->list, &rh->clean_regions);
 		}

--------------030401010002020505010006--
