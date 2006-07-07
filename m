Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWGGWfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWGGWfR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWGGWfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:35:17 -0400
Received: from lucidpixels.com ([66.45.37.187]:18897 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932355AbWGGWfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:35:15 -0400
Date: Fri, 7 Jul 2006 18:35:14 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: <17582.57549.204471.855655@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0607071832200.8499@p34.internal.lan>
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
 <Pine.LNX.4.64.0607071037190.5153@p34.internal.lan> <17582.55703.209583.446356@cse.unsw.edu.au>
 <Pine.LNX.4.64.0607071814510.8499@p34.internal.lan> <17582.57549.204471.855655@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jul 2006, Neil Brown wrote:

> On Friday July 7, jpiszcz@lucidpixels.com wrote:
>>
>> Hey!  You're awake :)
>
> Yes, and thinking about breakfast (it's 8:30am here).
>
>>
>> I am going to try it with just 64kb to prove to myself it works with that,
>> but then I will re-create the raid5 again like I had it before and attempt
>> it again, I did not see that documented anywhere!! Also, how do you use
>> the --backup-file option? Nobody seems to know!
>
> man mdadm
>       --backup-file=
>              This  is  needed  when  --grow is used to increase the number of
>              raid-devices in a RAID5 if there  are no  spare  devices  avail-
>              able.   See  the section below on RAID_DEVICE CHANGES.  The file
>              should be stored on a separate device, not  on  the  raid  array
>              being reshaped.
>
>
> So e.g.
>   mdadm --grow /dev/md3 --raid-disk=7 --backup-file=/root/md3-backup
>
> mdadm will copy the first few stripes to /root/md3-backup and start
> the reshape.  Once it gets past the critical section, mdadm will
> remove the file.
> If your system crashed during the critical section, then you wont be
> able to assemble the array without providing the backup file:
>
> e.g.
>  mdadm --assemble /dev/md3 --backup-file=/root/md3-backup /dev/sd[a-g]
>
> NeilBrown
>

Gotcha, thanks.

Quick question regarding reshaping, must one wait until the re-shape is 
completed before he or she grows the file system?

With the re-shape still in progress, I tried to grow the xfs FS but it 
stayed the same.

p34:~# df -h | grep /raid5
/dev/md3              746G   80M  746G   1% /raid5

p34:~# mdadm /dev/md3 --grow --raid-disks=4
mdadm: Need to backup 384K of critical section..
mdadm: ... critical section passed.
p34:~#

p34:~# cat /proc/mdstat
md3 : active raid5 hdc1[3] sdc1[2] hde1[1] hda1[0]
       781417472 blocks super 0.91 level 5, 64k chunk, algorithm 2 [4/4] 
[UUUU]
       [>....................]  reshape =  0.0% (85120/390708736) 
finish=840.5min speed=7738K/sec
p34:~#

p34:~# mount /raid5
p34:~# xfs_growfs /raid5
meta-data=/dev/md3               isize=256    agcount=32, agsize=6104816 
blks
          =                       sectsz=4096  attr=0
data     =                       bsize=4096   blocks=195354112, imaxpct=25
          =                       sunit=16     swidth=48 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=32768, version=2
          =                       sectsz=4096  sunit=1 blks
realtime =none                   extsz=196608 blocks=0, rtextents=0
data blocks changed from 195354112 to 195354368
p34:~#

p34:~# umount /raid5
p34:~# mount /raid5
p34:~# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/md3              746G   80M  746G   1% /raid5
p34:~#

I guess one has to wait until the reshape is complete before growing the 
filesystem..?
