Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWHHLMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWHHLMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWHHLM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:12:29 -0400
Received: from ns.suse.de ([195.135.220.2]:42624 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964820AbWHHLM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:12:28 -0400
From: Neil Brown <neilb@suse.de>
To: Alexandre Oliva <aoliva@redhat.com>
Date: Tue, 8 Aug 2006 21:12:14 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17624.29070.246605.213021@cse.unsw.edu.au>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modifying degraded raid 1 then re-adding other members is bad
In-Reply-To: message from Alexandre Oliva on Tuesday August 8
References: <or8xlztvn8.fsf@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 8, aoliva@redhat.com wrote:
> Assume I have a fully-functional raid 1 between two disks, one
> hot-pluggable and the other fixed.
> 
> If I unplug the hot-pluggable disk and reboot, the array will come up
> degraded, as intended.
> 
> If I then modify a lot of the data in the raid device (say it's my
> root fs and I'm running daily Fedora development updates :-), which
> modifies only the fixed disk, and then plug the hot-pluggable disk in
> and re-add its members, it appears that it comes up without resyncing
> and, well, major filesystem corruption ensues.
> 
> Is this a known issue, or should I try to gather more info about it?

Looks a lot like
   http://bugzilla.kernel.org/show_bug.cgi?id=6965

Attached are two patches.  One against -mm and one against -linus.

They are below.

Please confirm if the appropriate one help.

NeilBrown

(-mm)

Avoid backward event updates in md superblock when degraded.

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
 ./drivers/md/md.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-08-03 11:42:48.000000000 +1000
+++ ./drivers/md/md.c	2006-08-07 08:57:10.000000000 +1000
@@ -1609,6 +1609,17 @@ repeat:
 		nospares = 1;
 	if (force_change)
 		nospares = 0;
+	if (mddev->degraded)
+		/* If the array is degraded, then skipping spares is both
+		 * dangerous and fairly pointless.
+		 * Dangerous because a device that was removed from the array
+		 * might have a event_count that still looks up-to-date,
+		 * so it can be re-added without a resync.
+		 * Pointless because if there are any spares to skip,
+		 * then a recovery will happen and soon that array won't
+		 * be degraded any more and the spare can go back to sleep then.
+		 */
+		nospares = 0;
 
 	sync_req = mddev->in_sync;
 	mddev->utime = get_seconds();

---------------------------------------

(-linus)

Avoid backward event updates in md superblock when degraded.

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
--- .prev/drivers/md/md.c	2006-08-08 09:00:44.000000000 +1000
+++ ./drivers/md/md.c	2006-08-08 09:04:04.000000000 +1000
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
