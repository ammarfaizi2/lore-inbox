Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVAOMVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVAOMVG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 07:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVAOMVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 07:21:06 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:31445 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S262265AbVAOMU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 07:20:59 -0500
Date: Sat, 15 Jan 2005 13:21:05 +0100
From: Sander <sander@humilis.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Breakage with raid in 2.6.11-rc1-mm1 [Regression in mm]
Message-ID: <20050115122105.GD25781@favonius>
Reply-To: sander@humilis.net
References: <6.2.0.14.2.20050114233439.01cbb8d8@tornado.reub.net> <20050114035852.3b5ff1a3.akpm@osdl.org> <6.2.0.14.2.20050115014139.01dab5e0@tornado.reub.net> <41E7F9DB.8070707@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E7F9DB.8070707@osdl.org>
X-Uptime: 10:41:06 up 5 days, 12:31, 37 users,  load average: 1.60, 1.16, 1.05
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote (ao):
> Reuben Farrelly wrote:
> >At 12:58 a.m. 15/01/2005, Andrew Morton wrote:
> >
> >>Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >>>
> >>> Something seems to have broken with 2.6.11-rc1-mm1, which worked ok 
> >>with
> >>> 2.6.10-mm3.
> >>>
> >>> NET: Registered protocol family 17
> >>> Starting balanced_irq
> >>> BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
> >>> md: Autodetecting RAID arrays.
> >>> md: autorun ...
> >>> md: ... autorun DONE.
> >>> VFS: Waiting 19sec for root device...

...

> >>> VFS: Waiting 1sec for root device...
> >>> VFS: Cannot open root device "md2" or unknown-block(0,0)
> >>> Please append a correct "root=" boot option
> >>> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> >>unknown-block(0,0)
> >>>
> >>> The system is running 5 RAID-1 partitions, and md2 is the root as
> >>> per grub.conf.  Problem seems to be that raid autodetection finds
> >>> no raid partitions :(
> >>>
> >>> The two ST380013AS SATA drives are detected earlier in the boot, so 
> >>I don't
> >>> think that's the problem..
> >>
> >>hm, the only raidy thing we have in there is the below.  Maybe you could
> >>try reverting that?
> >>
> >>--- 25/drivers/md/raid5.c~raid5-overlapping-read-hack   2005-01-09 
> >>22:20:40.211246912 -0800
> >>+++ 25-akpm/drivers/md/raid5.c  2005-01-09 22:20:40.216246152 -0800

...

> >Ok the breakage occurred somewhere between 2.6.10-mm3 (works) and 
> >2.6.11-rc1 (doesn't work) ie wasn't introduced into the latest -mm 
> >patchset as I first thought.
> >
> >Are there any other patches that might be worth a try backing out?
> 
> Someone else reported that they had to back out this one:
> waiting-10s-before-mounting-root-filesystem.patch
> 
> Can you revert that one and let us know how it goes?

It Works For Me(tm). This is unpatched 2.6.11-rc1-mm1 (no patches
reverted too):

# uname -r
2.6.11-rc1-mm1
# cat /proc/mdstat 
Personalities : [raid0] [raid1] [raid5] [multipath] [raid10] 
Event: 2                   
md1 : active raid10 sdd2[3] sdc2[2] sdb2[1] sda2[0]
      70684416 blocks 128K chunks 2 near-copies [4/4] [UUUU]
      
md0 : active raid1 sdd1[3] sdc1[2] sdb1[1] sda1[0]
      500608 blocks [4/4] [UUUU]
      
unused devices: <none>
# mount
/dev/md1 on / type reiser3 (rw,sync,data=journal,barrier=flush)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/md0 on /boot type ext2 (ro)
tmpfs on /tmp type tmpfs (rw)


So the problem depends on something. This system is SCSI, and I don't
use modules. I'm happy to provide more info if that would be of any
help.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
