Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWCOVsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWCOVsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWCOVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:48:36 -0500
Received: from smtp.uaf.edu ([137.229.34.30]:6919 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S1751038AbWCOVsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:48:36 -0500
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.6.16-rc6 RAID size reporting
Date: Wed, 15 Mar 2006 12:48:29 -0900
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603151248.29893.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my quest to get some stability in my system with large RAID devices, I 
installed mdadm 2.3.1 and compiled and installed 2.6.16-rc6.

Ran this command:

mdadm -C /dev/md1 --auto=yes -l raid1 -n 2 /dev/etherd/e0.0 /dev/etherd/e1.0

Those are AoE devices, by the way.

Started fine, syncing at 43000K/sec or so.  Came in this morning, 
and /proc/mdstat had this to report:

Personalities : [raid1] 
md1 : active raid1 etherd/e1.0[1] etherd/e0.0[0]
      5469958900 blocks super 1.0 [2/2] [UU]
      [==========================================================>]  resync 
=292.8% (3440402688/1174991604) finish=785.8min speed=43043K/sec

You'll notice that it says 5469958900 blocks, but 3440402688/1174991604 done.  
Oops.

I tried this with two 400GB drives:

mdadm -C /dev/md2 --auto=yes -l raid1 -n 2 /dev/sdc /dev/sdd

And they report correctly:

md2 : active raid1 sdd[1] sdc[0]
      390711296 blocks [2/2] [UU]
      [=>...................]  resync =  8.1% (31782144/390711296) 
finish=152.8min speed=39133K/sec

Line 4045, and following,  in drivers/md/md.c seems to be the offending code:

if (test_bit(MD_RECOVERY_SYNC, &mddev->recovery))
	max_blocks = mddev->resync_max_sectors >> 1;
else
	max_blocks = mddev->size;

Should max_blocks be mddev->size even if it is resyncing?

The resyncing isn't done, so I can't tell you if the block count is correct 
after it's done.  I'll let you know as soon as it's done (about 37 hours, 
since I had to do a hard reboot due to another unrelated issue...i.e. 
PEBKAC).

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
