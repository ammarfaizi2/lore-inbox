Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTKABlx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 20:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTKABlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 20:41:53 -0500
Received: from [134.29.1.12] ([134.29.1.12]:1494 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S262349AbTKABlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 20:41:50 -0500
Message-ID: <3FA30F4A.5030500@hundstad.net>
Date: Fri, 31 Oct 2003 19:41:30 -0600
From: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Something corrupts raid5 disks slightly during reboot
References: <20031031190829.GM4868@niksula.cs.hut.fi>
In-Reply-To: <20031031190829.GM4868@niksula.cs.hut.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try:

hdparm -W0 /dev/hdX

for each of your ide drives.  This turns off write-caching which is 
usually a bad thing with ide drives anyway.

Ville Herva wrote:

>I've been experiencing strange corruption on a raid5 volume for some time.
>Basically, after unmounting the filesystem, I can mount it again without
>problems. I can also raidstop the raid device in between and all is still
>fine:
>
>  
>
>>umount /dev/md4; mount /dev/md4
>>    
>>
>    - no corruption
>  
>
>>umount /dev/md4; raidstop /dev/md4; raidstart /dev/md4; mount /dev/md4
>>    
>>
>    - no corruption
>
>But after a reboot, the filesystem is corrupted:
>
>  
>
>>mount /dev/md4
>>    
>>
> EXT2-fs error (device md(9,4)): ext2_check_descriptors: Block bitmap for
> group 17 not in group (block 0)!
> EXT2-fs: group descriptors corrupted !
>
>(This is recoverable with e2fsck.)
>
>The array consists of three 80GB Samsung disks in raid5 mode, but I
>experienced this problem with two of the disks in raid0 mode, too. The raid
>consists of raw disks hdb,hdc,hdg (rather than partitions hdb1,hdc1,hdg1).
>
>On the same box I have three other raid arrays on different disks, all of
>which consist of partitions. These do not show corruption on boot.
>
>I made a little experiment and saved first megabyte of hd[bcg] between
>umount,mount and umount,raidstop,raidstart,mount operations. They did not
>change.
>
>The I did umount,raidstop and rebooted. After boot, the beginning hdb was
>intact, but hdc and hdg had been tampered. (Unfortunately, raidstart was
>automatically run on boot, but I did raidstop as the first thing.)
>
>I narrowed the difference down to bytes between 1060-1080 on hdc:
>
>root@linux:/scratch>od -x hdc_bytes-1060-1080_before_boot
>0000000 1e1e 00d0 000d 00d0 752e 4264 7714 3fa2
>0000020 0002 0014
>root@linux:/scratch>od -x hdc_bytes-1060-1080_after_boot
>0000000 1e1e 00d0 000d 00d0 75ff 4264 7427 3fa2
>0000020 0003 0014
>
>On hdg, this range differed too:
>
>root@linux:/scratch>od -x hdg_bytes-1060-1080_after_boot
>0000000 8000 0000 8000 0000 7526 3fa2 7539 3fa2
>0000020 0002 0014
>root@linux:/scratch>od -x hdg_bytes-1060-1080_after_boot
>0000000 8000 0000 8000 0000 75f7 3fa2 760a 3fa2
>0000020 0003 0014
>
>But there was additional difference somewhere between 1kB and 5kB that
>wasn't there on hdc.
>
>When I copied the saved 1MB blocks back in place, the fs mounted without
>problems.
>
>AFAIK, the first 512b on each disk should be the raid superblock and the
>next 512 may be ext2 superblock. I assume 1060-1080 falls into group
>descriptor table that gets corrupted.
>
>It may be something in userspace that corrupts the disks, but I cannot think
>what it could be.
>
>Right now, the kernel is 2.2.25-secure + patches, but earlier 2.2.x kernels
>exhibited this as well. These include the newest raid 0.90 patches for 2.2.
>
>Any ideas what might cause this or how to debug this further?
>
>
>-- v --
>
>v@iki.fi
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

