Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266290AbRGSXx7>; Thu, 19 Jul 2001 19:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266293AbRGSXxu>; Thu, 19 Jul 2001 19:53:50 -0400
Received: from stine.vestdata.no ([195.204.68.10]:41489 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S266290AbRGSXxi>; Thu, 19 Jul 2001 19:53:38 -0400
Date: Fri, 20 Jul 2001 01:53:43 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <xfs@ragnark.vestdata.no>
To: "Christian, Chip" <chip.christian@storageapps.com>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Busy inodes after umount
Message-ID: <20010720015343.B11236@vestdata.no>
In-Reply-To: <23D04BDBA646D411BDDD00D0B774B53902963BE8@SA-BWMAIL1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <23D04BDBA646D411BDDD00D0B774B53902963BE8@SA-BWMAIL1>; from Christian, Chip on Thu, Jul 19, 2001 at 04:22:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 19, 2001 at 04:22:07PM -0400, Christian, Chip wrote:
> I found the same thing happening.  Tracked it down in our case to using fdisk to re-read disk size before mounting.  Replaced it with "blockdev --readpt" and the problem seems to have gone away.  YMMV.

I've now been able to reproduce:

* make a filesystem
* mount it
* export it (nfs)
* mount on remote machine
* lock file (fcntl)
* unexport
* unmount

Then you get the VFS message about self-destruct. Tested with both ext2
and xfs.

The lock is still present in /proc/locks after the umount.

With ext2 I can remount the filesystem successfully, but with XFS I get
the message about duplicate UUIDs and the mount failes. I believe this is a totally 
different problem from the one you were experiencing. (and blockdev doesn't help for me)

I suppose this is a generic kernel bug? 



-- 
Ragnar Kjorstad
Big Storage


> [root@ha2 /root]# mkfs -t xfs -f /dev/sdb1
> meta-data=/dev/sdb1              isize=256    agcount=51, agsize=262144
> blks
> data     =                       bsize=4096   blocks=13305828,
> imaxpct=25
>          =                       sunit=0      swidth=0 blks, unwritten=0
> naming   =version 2              bsize=4096  
> log      =internal log           bsize=4096   blocks=1624
> realtime =none                   extsz=65536  blocks=0, rtextents=0
> [root@ha2 /root]# mount -t xfs /dev/sdb1 /mnt/raid/
> [root@ha2 /root]# umount /mnt/raid/
> [root@ha2 /root]# mount -t xfs /dev/sdb1 /mnt/raid/
> mount: wrong fs type, bad option, bad superblock on /dev/sdb1,
>        or too many mounted file systems
> 
> 
> >From /var/log/messages:
> Jul 19 12:27:15 ha2 kernel: Start mounting filesystem: sd(8,17)
> Jul 19 12:27:16 ha2 kernel: Ending clean XFS mount for filesystem: sd(8,17)
> Jul 19 12:27:19 ha2 kernel: XFS unmount got error 16
> Jul 19 12:27:19 ha2 kernel: linvfs_put_super: vfsp/0xc2ff71e0 left dangling!
> Jul 19 12:27:19 ha2 kernel: VFS: Busy inodes after unmount.  Self-destruct in 5 seconds.  Have a nice day...
> Jul 19 12:27:21 ha2 kernel: XFS: Filesystem has duplicate UUID - can't mount
> 
> 
> This happens on a shared storage cluster with two nodes. The same thing
> happens on both nodes. (I'm only using the device from one device at the
> time)
> 
> linux-2.4.5 with XFS patch from 06112001.
> 
> After a reboot it works again, and I have not been able to reproduce
> yet. It first happened when I was testing NFS locks, so it could be
> related to that.
> 
> 
> 
> -- 
> Ragnar Kjorstad
> Big Storage
