Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWJOI3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWJOI3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 04:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWJOI3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 04:29:25 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:34212 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932322AbWJOI3Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 04:29:24 -0400
Date: Sun, 15 Oct 2006 11:29:21 +0300
From: Ville Herva <vherva@vianova.fi>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Message-ID: <20061015082921.GC22674@vianova.fi>
Reply-To: vherva@vianova.fi
References: <17710.54489.486265.487078@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17710.54489.486265.487078@cse.unsw.edu.au>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 09:50:49AM +1000, you [Neil Brown] wrote:
> 
> Hi,
>  I was looking into an issue that someone was having with raid5.
> They made an md/raid5 out of 5 whole devices and by luck the data
> that was written to the first block of the 5th device looked
> slightly like a partition table.  fdisk output below for the curious.
> However some partitions were beyond the end of the device.

That reminds me of an old long-standing mystery I had with a machine that
had a RAID-5 of three whole devices. 

I wonder if there's ever a change the kernel partition detection code could
_write_ on the disk, even when there's really no partition table?

Below is a description of the problem. I'm afraid I only replicated in on
2.2 and 2.4, but it just might still be present in 2.6. Unfortunately, the
actual raid device is now on different disks that have partition table on
them. I'm just asking if this rings any bells, since I really spent a long
time debugging it, and never found a real clue.


------------------------------------------------------------

The raid device is:

   md4 : active raid5 hdc[2] hdb[1] hdg[0] 156367872 blocks level 5, 16k chunk, algorithm 0 [3/3] [UUU]

The kernel is 2.2.x + RAID-0.90 patch. Fs is ext2. After unmounting the
filesystem, I can mount it again without problems. I can also raidstop the
raid device in between and all is still fine:

   -> umount /dev/md4; mount /dev/md4 
      - no corruption
   -> umount /dev/md4; raidstop /dev/md4; raidstart /dev/md4; mount /dev/md4
      - no corruption
          
But after a reboot, the filesystem is corrupted - few bytes differ in the
beginning of /dev/md4 between 1k and and 5k.

cmp -l md4 afterboot/md4
   1083      1    3
   4641     35    0
   4642    205    0
   4643     10    0
   bytepos after  before
           boot   boot

I found out that the difference (corruption) is usually on three bytes on
/dev/hdg, but sometimes on /dev/hdc, too. (/dev/md4 = hdb+hdc+hdg; hdb&hdc
are on i810, hdg is on hpt370).
          
First, I did
   umount /dev/md4
   raidstop /dev/md4
   head -c 50k /dev/hdg > /save/hdg
   reboot
          
To rule out kernel raid autodetect and raid code in general, I
booted 2.2.25 with "single init=/bin/bash raid=noautodetect".
 
   head -c50k /dev/hdg | cmp -l /save/hdg

Three bytes differed:
   4641    0      35
   4642    0      205
   4643    0      10
   bytepos after  before
           boot   boot

wrote the original stuff back:
   dd if=/save/hdg /dev/hdg
   sync 
   hdparm -W0 /dev/hdg
   sync
   reboot

Booted 2.2.25 with "single init=/bin/bash raid=noautodetect" again.

Did 
   head -c50k /dev/hdg | cmp -l /save/hdg
Three same three bytes differed again.

Wrote the stuff back, synced, did hdparm, and powered off. Still, the the
bytes differed on next boot.

Then I booted 2.4.21 with "single init=/bin/bash raid=noautodetect" (I
happened to have 2.4.21 compiled with suitable drivers at hand). Wrote the
same stuff back with dd, synced, turned ide cache off.

Booted 2.4.21 with "single init=/bin/bash raid=noautodetect" again. Did the
diff; the three bytes differed again.

Note that sometimes few bytes on hdc differed, too. Usually it was just the
three hdg bytes.

So this is not a 2.2 kernel issue. I suspect it might not be a kernel issue
at all. Unless it is a bug in kernel partition detection that is still
present in 2.4.x, perhaps in 2.6.

I tried to turn off the ide write cache with hdparm -W0, so it
shouldn't be a write caching issue. 

If it's a bios issue, it's really a strange one, since it affects
both disks on i810 ide and on hpt370. The disks have no partition table,
though, which _could_ confuse the bios. 

Any ideas? Who could write to those three bytes, and why?
