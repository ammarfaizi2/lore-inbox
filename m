Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269698AbRHCX1E>; Fri, 3 Aug 2001 19:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269697AbRHCX0t>; Fri, 3 Aug 2001 19:26:49 -0400
Received: from 124-205.dialup.ucalgary.ca ([136.159.124.205]:4357 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S269691AbRHCX0X>;
	Fri, 3 Aug 2001 19:26:23 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108032301.f73N18E01809@lynx.adilger.int>
Subject: Re: Any known ext2 FS problems in 2.4.7?
To: david@blue-labs.org (David Ford)
Date: Fri, 3 Aug 2001 17:01:08 -0600 (MDT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3B6AE225.9070702@blue-labs.org> from "David Ford" at Aug 03, 2001 01:40:53 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford writes:
> I'm starting to go through a cycle every 2-3 days where I have to bring 
> one particular machine down to init l1, kill any processes and remount 
> RO, then run e2fsck on the e2fs partition.  Over that period of time, 
> disk space is eaten without accouting. 'du' shows about 13 gigs used 
> when I sum up all the directories.  Roughly 4.5 gigs is missing.  During 
> e2fsck, there are many many pages of deleted inodes with zero dtime, ref 
> count fixups, and free inode count fixups.  When I say many, I mean that 
> this pIII 667 scrolls for about four minutes...
> 
> There is nothing special about this partition, it doesn't do it while 
> running 2.4.5-ac15, but I can't use that kernel either because it OOPSes 
> as I reported.  That OOPS was fixed for 2.4.7, but this disk space issue 
> is rather frustrating.  Fortunately all my other systems are reiserfs 
> and work fine.
> 
> /dev/ide/host0/bus0/target0/lun0/part2 on / type ext2 
> (rw,usrquota=/usr/local/admin/system-info/quota-home)
> 
> I haven't mucked with any /proc settings other than "16384" 
>  >/proc/sys/fs/file-max.  It's also worthy to note that this machine 
> also likes to break and spontaneously reboot about once every day.  No 
> klog, no console, no nothing, just bewm.  Again 2.4.5 didn't do this.

Are you sure you are running e2fsck on this partition at boot time?
I mean, if it is rebooting spontaneously every day, but you need to run
e2fsck manually to clean up the filesystem every 2-3 days, the fsck after
reboot should already clean up the filesystem for you.  If you _don't_
run e2fsck on this filesystem (you need a non-zero number in the 6th
column of /etc/fstab) that would explain the problem.

The "missing space" you are seeing is because files are being held open
(thus not reported by "du", which only can check linked files, but reported
by "df" which shows the whole filesystem stats).  If the files are held
open at the time of a crash, then you need to run e2fsck to clean up all
of these "orphans".  You should be able to see what process is causing this
by running "lsof | grep deleted" to find open-but-deleted files.

Note that reiserfs still has the same problem (AFAIK, I don't think it
is fixed in the stock kernels, although there is a patch available),
so even though it doesn't _need_ reiserfsck at boot time, you still
don't get the space back until it is run.  If the other machines don't
crash all the time, the space won't be "lost", so you may not notice it.
Ext3 cleans up orphans at boot time (no fsck needed).

Cheers, Andreas
-- 
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

