Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSGLSsP>; Fri, 12 Jul 2002 14:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSGLSsN>; Fri, 12 Jul 2002 14:48:13 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:25844 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316693AbSGLSsM>; Fri, 12 Jul 2002 14:48:12 -0400
Date: Fri, 12 Jul 2002 12:49:12 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 'remount' problem
Message-ID: <20020712184912.GR8738@clusterfs.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20020712163928.GH8738@clusterfs.com> <Pine.LNX.3.95.1020712132914.211A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020712132914.211A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 12, 2002  13:34 -0400, Richard B. Johnson wrote:
> On Fri, 12 Jul 2002, Andreas Dilger wrote:
> > On Jul 12, 2002  08:53 -0400, Richard B. Johnson wrote:
> > > If file-systems are mounted upon boot with 'defaults' as options
> > > 
> > > like /etc/fstab...
> > > /dev/sdc1			/alt		ext2	defaults  0   2
> > > 
> > > mount -o remount,rw,noatime /alt
> > > 
> > > The result is (correctly)
> > > /dev/sdc1 /alt ext2 rw,noatime 0 0
> > > 
> > > Now, if I shut down the system, properly dismounting all the drives,
> > > then I reboot, the drives that were re-mounted end up being fscked
> > > due to 'was not cleanly unmounted' inference. Nothing wrong is found.
> > > 
> > > Now, if I mount the drives "noatime" from the start, i.e., from
> > > /etc/fstab upon startup, there are no such errors upon re-boot.
> 
> # umount /dev/sdb1
> # dumpe2fs -h /dev/sdb1
> dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> Filesystem state:         clean
> Last mount time:          Fri Jul 12 13:04:15 2002
> Last write time:          Fri Jul 12 13:04:15 2002
> 
> Booted with init=/bin/bash
> Then I mounted a floppy off from /tmp, chdir there, and ran script.
> 
> Script started on Fri Jul 12 09:07:57 2002
> bash# /sbin/e2fsck /dev/sdb1
> e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> /dev/sdb1: was not cleanly unmounted, check forced
>  242040/2109408 files, 1619150/4217054 blocks

Well, I don't know what to say about this...  The unmount path calls
ext2_put_super(), which marks the superblock clean and calls
ext2_sync_super() to force it to disk (this can be seen from debugfs
output).

On reboot the filesystem is not clean.  Either the kernel is not
doing what it should to flush the dirty superblock to disk, or the disk
is lying about having written the superblock to disk.  I would suspect
the latter on IDE drives, but SCSI drives are usually sane.

Try adding a sync or two before rebooting, and also checking via
debugfs after reboot to ensure it is marked dirty when it shouldn't
be.  You could even add some printk's to ext2_put_super() inside the
conditional where it marks the filesystem clean and syncs the super
to ensure that is being called.

> # umount -a
> umount: /mnt: device is busy

What about the above message?

The fact that /dev/sda1 is your root fs could cause some strangeness also.

It would appear to be that ext2_remount() is missing "sb->s_flags |=
MS_RDONLY" after the comment "set the rdonly flag and then mark the
partition as valid again".  The other check for valid flags also appears
to be a bit suspect.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

