Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269471AbUJAIoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269471AbUJAIoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269477AbUJAIoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 04:44:11 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:53632 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269471AbUJAIoC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 04:44:02 -0400
Subject: Re: Windows Logical Disk Manager error
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcin =?iso-8859-2?Q?Gibu=B3a?= <mg@iceni.pl>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410010149.19951@senat>
References: <200409231254.12287@senat>
	 <1096287833.8148.53.camel@imp.csi.cam.ac.uk>  <200410010149.19951@senat>
Content-Type: text/plain; charset=UTF-8
Organization: University of Cambridge Computing Service, UK
Message-Id: <1096619799.17297.22.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 09:36:40 +0100
Content-Transfer-Encoding: 8BIT
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 00:49, Marcin Gibuła wrote:
> > Volume6 is a two partition concatenated volume mad up of partitions sda4
> > (109GiB) and sda2 (32kiB!) (in this order!) on the disk you sent me the
> > ldm dump from.  You should assemble this as described for Volume2 and
> > then mount the created MD device with the ntfs driver.
> 
> Maybe I should explain what is my disc layout...
> Volume2 is one partition, and Volume6 is mounted as one of its directories, 
> something like:
> 
> D:\  <- Volume2
> D:\download <- Volume6
> 
> Volume6 works fine without using software raid though.  Volume2 does not.

I would not advise you to use volume6 without the md driver.  You are
then missing the last 32kb off the end and you never know when they
might be needed and access to the volume might fall over just when you
expect it least.  Also the backup bootsector is in the last sector so
you are at present missing that and even worse something like chkdsk
could think "corrupt volume, lets fix it" and damage your volume because
you are missing the end.

> > Let me know how it goes.  Both success and failures are interesting to
> > me as I do not remember anyone actually having had spanned ldm volumes
> > before so it would be nice to know it all works...
> 
> I've tried the following:
> 
> # mdadm --build /dev/md1 -l linear -n 2 /dev/sda1 /dev/sda3
> mdadm: array /dev/md1 built and started.
> # mount /dev/md1 /mnt/d

Volume2 not working can have a possible explanation in that it might be
assembled incorrectly.  For example, Windows is using 512-byte blocks
but Linux 1024-byte blocks so if your first partition has an odd number
of sectors Windows will use the last sector whereas Linux will cut off
the last sector and hence all data in the second partition will be
shifted by 512-bytes in the array which you cause all data to appear
corrupt in the second part of the volume.  I have seen this happen in my
own experiments on the Windows NT4 fault tolerant linear raid volumes, I
have not done experiments with Windows 2k/xp LDM linear raid volumes. 
If this is the case you cannot use the md driver and are stuck I am
afraid.  At least I am not aware of any Linux utility/driver that will
allow you to work in this case.

Alternatively maybe Windows 2k/XP LDM linear raid volumes are using the
cluster size as the block size instead of 512-byte blocks.  If that were
the case and your cluster size is > 1024 bytes (very likely on such a
large volume, it is probably 4096 bytes) then the second part of the
volume is again misaligned when assembled but in the opposite
direction.  Fortunately you can fix this case by using the "--rounding="
parameter to mdadm.  So if you have a cluster size of 4k try
--rounding=4.  (If you don't know your cluster size enable debugging in
the ntfs driver and then do the mount and "dmesg | grep cluster_size"
will tell you the answer.  To enable debugging in the driver it must be
compiled with debugging enabled and you need to, as root, do: "echo 1 >
/proc/sys/fs/ntfs-debug" after loading the module if modular and before
doing the mount command.)

# ls /mnt/d
> ls: reading directory /mnt/d: Input/output error
> 
> dmesg output:
> NTFS volume version 3.1.
> NTFS-fs error (device md1): ntfs_readdir(): Actual VCN (0x6e68dc76fa7923) of 
> index buffer is different from expected VCN (0x4). Directory inode 0x5 is 
> corrupt or driver bug.

I have seen this particular error before and it was due to the volume
having been upgraded from FAT to NTFS (and the conversion utility
apparently had screwed up the vcns in at least one directory).  Running
"chkdsk /f" on it fixed it in that particular case (even though chkdsk
reported no errors, apparently it fixed them without telling anyone!). 
So this is worth trying before you start messing around with --rounding=
and mdadm.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

