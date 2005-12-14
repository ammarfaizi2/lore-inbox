Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbVLNXxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbVLNXxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVLNXxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:53:40 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:23729 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965126AbVLNXxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:53:39 -0500
Message-ID: <43A0B081.2080707@us.ibm.com>
Date: Wed, 14 Dec 2005 15:53:37 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dm-devel@redhat.com, linux-kernel@vger.kernel.org
CC: Chris McDermott <lcm@us.ibm.com>
Subject: [PATCH] make dm-mirror not issue invalid resync requests
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been attempting to set up a (Host)RAID mirror with dm_mirror on
2.6.14.3, and I've been having a strange little problem.  The
configuration in question is a set of 9GB SCSI disks that have 17942584
sectors.  I set up the dm_mirror table as such:

0 17942528 mirror core 2 2048 nosync 2 8:48 0 8:64 0

If I'm not mistaken, this sets up a 9GB RAID1 mriror with 1MB stripes
across both SCSI disks.  The sector count of the dm device is less than
the size of the disks, so we shouldn't fall off the end.  However, I
always get the messages like this in dmesg when I set up the dm table:

attempt to access beyond end of device
sdd: rw=0, want=17958656, limit=17942584

Clearly, something is trying to read sectors past the end of the drive.
 I traced it down to the __rh_recovery_prepare function in dm-raid1.c,
which gets called when we're putting the mirror set together.  This
function calls the dirty region log's get_resync_work function to see if
there's any resync that needs to be done, and queues up any areas that
are out of sync.  The log's get_resync_work function is actually a
pointer to the core_get_resync_work function in dm-log.c.

The core_get_resync_work function queries a bitset lc->sync_bits to find
out if there are any regions that are out of date (i.e. the bit is 0),
which is where the problem occurs.  If every bit in lc->sync_bits is 1
(which is the case when we've just configured a new RAID1 with the
nosync option), the find_next_zero_bit does NOT return the size
parameter (lc->region_count in this case), it returns the size parameter
rounded up to the nearest multiple of 32!  I don't know if this is
intentional, but i386 and x86_64 both exhibit this behavior.

In any case, the statement "if (*region == lc->region_count)" looks like
it's supposed to catch the case where are no regions to resync and
return 0.  Since find_next_zero_bit apparently has a habit of returning
a value that's larger than lc->region_count, the enclosed patch changes
the equality test to a greater-than test so that we don't try to resync
areas outside of the RAID1 region.  Seeing as the HostRAID metadata
lives just past the end of the RAID1 data, mucking around in that area
is not a good idea.

I suppose another way to fix this would be to amend find_next_zero_bit
so that it doesn't return values larger than "size", but I don't know if
there's a reason for the current behavior.

Questions?  Comments?  Any objections to including this?  Please cc: me;
I'm not subscribed to lkml or dm-devel.

--D

----------------------

Signed-Off-By: Darrick J. Wong <djwong@us.ibm.com>

--- a/drivers/md/dm-log.c	2005-11-24 14:10:21.000000000 -0800
+++ b/drivers/md/dm-log.c	2005-12-14 14:26:12.000000000 -0800
@@ -573,7 +573,7 @@ static int core_get_resync_work(struct d
 					     lc->sync_search);
 		lc->sync_search = *region + 1;

-		if (*region == lc->region_count)
+		if (*region >= lc->region_count)
 			return 0;

 	} while (log_test_bit(lc->recovering_bits, *region));
