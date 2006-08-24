Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWHXHUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWHXHUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 03:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWHXHUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 03:20:20 -0400
Received: from ns2.suse.de ([195.135.220.15]:63929 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750791AbWHXHUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 03:20:18 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 17:20:18 +1000
Message-Id: <1060824072018.14153@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 2] md: Avoid backward event updates in md superblock when degraded.
References: <20060824171215.14077.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If we
  - shut down a clean array,
  - restart with one (or more) drive(s) missing
  - make some changes
  - pause, so that they array gets marked 'clean',
the event count on the superblock of included drives
will be the same as that of the removed drives.
So adding the removed drive back in will cause it
to be included with no resync.

To avoid this, we only update the eventcount backwards when the array
is not degraded.  In this case there can (should) be no non-connected
drives that we can get confused with, and this is the particular case
where updating-backwards is valuable.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-08-24 17:03:33.000000000 +1000
+++ ./drivers/md/md.c	2006-08-24 17:03:47.000000000 +1000
@@ -1597,6 +1597,19 @@ void md_update_sb(mddev_t * mddev)
 
 repeat:
 	spin_lock_irq(&mddev->write_lock);
+
+	if (mddev->degraded && mddev->sb_dirty == 3)
+		/* If the array is degraded, then skipping spares is both
+		 * dangerous and fairly pointless.
+		 * Dangerous because a device that was removed from the array
+		 * might have a event_count that still looks up-to-date,
+		 * so it can be re-added without a resync.
+		 * Pointless because if there are any spares to skip,
+		 * then a recovery will happen and soon that array won't
+		 * be degraded any more and the spare can go back to sleep then.
+		 */
+		mddev->sb_dirty = 1;
+
 	sync_req = mddev->in_sync;
 	mddev->utime = get_seconds();
 	if (mddev->sb_dirty == 3)
