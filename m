Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132689AbRBED7d>; Sun, 4 Feb 2001 22:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132682AbRBED7Y>; Sun, 4 Feb 2001 22:59:24 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:28420 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S132667AbRBED7O>; Sun, 4 Feb 2001 22:59:14 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Daniel Schroeter <d.schroeter@gmx.de>
Date: Mon, 5 Feb 2001 14:58:56 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14974.9472.971444.972844@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: raid-1 with raid-0 and normal disk -> performance and autostart?
In-Reply-To: message from Daniel Schroeter on Thursday February 1
In-Reply-To: <3A7937EE.1030104@gmx.de>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 1, d.schroeter@gmx.de wrote:
> hi,
> i using kernel 2.4.1. mkraid version 0.90.0
> i build /dev/md0 raid-0 with hda5 and sda1. then i build /dev/md1 raid-1 
> with /dev/md0 and sdb1.
> it works fine.
> BUT the resync takes a long time. i have a performance from 253K/sec. 
> whats there wrong?

The resync code tries to detect other (non-resync) IO on the devices
and throttle back the resync process if there is any other IO.
Because you can build a RAID array from partitions, and because it is
IO to the device rather than the partition that md wants to meausure,
md needs to figure out what actual device the IO is on, and keep track
of that.

When one of the underlying devices is a raid0 array, md fails to guess
properly and I suspect that this is causing the problem.  It is
concluding that there is always IO to that device, and constantly
throttling.

You can control the throttling with
   /proc/sys/dev/raid/speed_limit_min
and
   /proc/sys/dev/raid/speed_limit_max

If you put a nice big number in speed_limit_min, it should rebuild
more quickly for you, at the cost of interfering with any other IO to
the device.

NeilBrown

> [root@mendocino <mailto:root@mendocino> /root]# cat /proc/mdstat
> Personalities : [linear] [raid0] [raid1] [raid5]
> read_ahead 1024 sectors
> md0 : active raid1 md1[1] sdb1[0]
>       8891712 blocks [2/2] [UU]
>       [>....................]  resync =  0.0% (5572/8891712) 
> finish=581.8min speed=253K/sec
> md1 : active raid0 sda1[1] hda5[0]
>       8891776 blocks 4k chunks
> 
> unused devices: <none>
> 
> if i build a raid-1 with sdb1 and hda5 i get:
> 
> Personalities : [linear] [raid0] [raid1] [raid5]
> read_ahead 1024 sectors
> md0 : active raid1 sdb1[1] hda5[0]
>       4449920 blocks [2/2] [UU]
>       [>....................]  resync =  0.4% (21952/4449920) 
> finish=10.0min speed=7317K/sec
> unused devices: <none>
> 
> i get the same speer also with sda1 and sdb1.
> any ideas?
> 
> i will mount the raid-10 (or 01???) as "/". but the autodetection 
> doesn't work corect. the partitions are all "Linux raid autodetect". the 
> raid-0 starts fine. if he tries to start the raid-1 the dev md0 will not 
> integrated in the array. must i start a ramdisk, and starting there 
> manuell the raid-1? if i change md1 and md0 it's the same.
> 
> THNX
> CU
>     daniel
> 
> 
> raidtab:
> 
> raiddev /dev/md0
>     raid-level                0
>     nr-raid-disks             2
>     persistent-superblock     1
>     chunk-size                4
> 
>     device                    /dev/hda5
>     raid-disk                 0
>     device                    /dev/sda1
>     raid-disk                 1
> 
> raiddev /dev/md1
>     raid-level                1
>     nr-raid-disks             2
>    persistent-superblock     1 # i tried also 0 here
>     chunk-size                4
> 
>     device                    /dev/sdb1
>     raid-disk                 0
>     device                    /dev/md0
>     raid-disk                 1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
