Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290813AbSAaBcS>; Wed, 30 Jan 2002 20:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSAaBcN>; Wed, 30 Jan 2002 20:32:13 -0500
Received: from mail.littlefeet-inc.com ([63.215.255.3]:41991 "EHLO
	ltfsd01.little-ft.com") by vger.kernel.org with ESMTP
	id <S290813AbSAaBcA>; Wed, 30 Jan 2002 20:32:00 -0500
Message-ID: <B9F49C7F90DF6C4B82991BFA8E9D547B1256F7@BUFORD.littlefeet-inc.com>
From: Kris Urquhart <kurquhart@littlefeet-inc.com>
To: "'Alexander Viro'" <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolabs.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Date: Wed, 30 Jan 2002 17:27:42 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alexander Viro [mailto:viro@math.psu.edu]
> Sent: Wednesday, January 30, 2002 4:15 PM
> To: Andreas Dilger
> Cc: Kris Urquhart; 'linux-kernel@vger.kernel.org'
> Subject: Re: PROBLEM: ext2/mount - multiple mounts corrupts inodes
> 
> 
> 
> 
> On Wed, 30 Jan 2002, Andreas Dilger wrote:
> 
> > On Jan 30, 2002  15:07 -0800, Kris Urquhart wrote:
> > > [1.] One line summary of the problem: 
> > > A mount of an already mounted ext2 partition corrupts 
> inodes if there have
> > > been recent writes without an intervening sync.
> > 
> > This _should_ be handled OK by the kernel simply by not mounting the
> > filesystem the second time.  If you try and mount it a 
> second time it
> > _should_ just do a "bind" mount instead of a real mount, I think.
> 
> Which is what actually happens.  I suspect that he ends up 
> forgetting to
> umount it...
> 
> Anyway, try to reproduce it on 2.4.16 or later and give the 
> contents of
> /proc/mounts before and after your script.
> 

I upgraded to 2.4.17, and inserted "cat /proc/mounts" 
several places in my script.  

The results are below, and definitely insightful.  

When using a loop device, the second mount creates a 
new loop device that reads a device file that is in an 
unpredictable state since the first loop device is 
still mounted with that device file as a source.  Makes 
sense to me; GIGO.

When using a disk partition, however, the second mount 
appears to fail, but then yields the exact same results
as the loop device example.  It appears that the second 
mount actually replaced the first one, without giving the 
first one a chance to sync to disk?

----------------- loop device --------------------------
+ DEVICE=./loopdev
+ MOUNT=/mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd
+ umount /mnt/hd
umount: /mnt/hd: not mounted
+ dd if=/dev/zero of=./loopdev bs=1k count=5000
5000+0 records in
5000+0 records out
+ mke2fs -F ./loopdev
mke2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
1256 inodes, 5000 blocks
250 blocks (5.00%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
1256 inodes per group

Writing inode tables: done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 36 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
+ rm -rf /mnt/hd
+ mkdir -p /mnt/hd
+ mount -t ext2 -o loop ./loopdev /mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd
/dev/loop0 /mnt/hd ext2 rw 0 0
+ cp -r /bin/tar /mnt/hd
+ cp -r /bin/zcat /mnt/hd
+ mount -t ext2 -o loop ./loopdev /mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd
/dev/loop0 /mnt/hd ext2 rw 0 0
/dev/loop1 /mnt/hd ext2 rw 0 0
+ find /mnt/hd -ls
     2    1 drwxr-xr-x   3 root     root         1024 Dec 31 15:25 /mnt/hd
    11   12 drwxr-xr-x   2 root     root        12288 Dec 31 15:25
/mnt/hd/lost+found
find: /mnt/hd/tar: Input/output error
find: /mnt/hd/zcat: Input/output error
+ umount /mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd
/dev/loop0 /mnt/hd ext2 rw 0 0
+ umount /mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd

---------------- disk partition ------------------------
+ DEVICE=/dev/hda3
+ MOUNT=/mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd
+ umount /mnt/hd
umount: /mnt/hd: not mounted
+ dd if=/dev/zero of=/dev/hda3 bs=1k count=5000
5000+0 records in
5000+0 records out
+ mke2fs -F /dev/hda3
mke2fs 1.23, 15-Aug-2001 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
3392 inodes, 13566 blocks
678 blocks (5.00%) reserved for the super user
First data block=1
2 block groups
8192 blocks per group, 8192 fragments per group
1696 inodes per group
Superblock backups stored on blocks:
        8193

Writing inode tables: done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 35 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
+ rm -rf /mnt/hd
+ mkdir -p /mnt/hd
+ mount -t ext2 /dev/hda3 /mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd
/dev/hda3 /mnt/hd ext2 rw 0 0
+ cp -r /bin/tar /mnt/hd
+ cp -r /bin/zcat /mnt/hd
+ mount -t ext2 /dev/hda3 /mnt/hd
mount: /dev/hda3 already mounted or /mnt/hd busy
mount: according to mtab, /dev/hda3 is already mounted on /mnt/hd
+ grep /mnt/hd
+ cat /proc/mounts
/dev/hda3 /mnt/hd ext2 rw 0 0
+ find /mnt/hd -ls
     2    1 drwxr-xr-x   3 root     root         1024 Dec 31 15:17 /mnt/hd
    11   12 drwxr-xr-x   2 root     root        12288 Dec 31 15:17
/mnt/hd/lost+found
find: /mnt/hd/tar: Input/output error
find: /mnt/hd/zcat: Input/output error
+ umount /mnt/hd
+ cat /proc/mounts
+ grep /mnt/hd
+ umount /mnt/hd
umount: /mnt/hd: not mounted
+ cat /proc/mounts
+ grep /mnt/hd
