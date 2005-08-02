Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVHBNm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVHBNm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 09:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVHBNm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 09:42:26 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:34447 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261472AbVHBNmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 09:42:25 -0400
Date: Tue, 2 Aug 2005 09:42:23 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Unable to mount the SD card formatted using the DIGITAL CAMREA on Linux box
Message-ID: <20050802134223.GE31019@csclub.uwaterloo.ca>
References: <C349E772C72290419567CFD84C26E01704213C@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C349E772C72290419567CFD84C26E01704213C@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 05:01:00PM +0530, Mukund JB. wrote:
> Dear all,
> 
> Below are my driver messages logged at initialization time & sfdisk call
> time. 
> 
> when module is initialized................
> 
> TIFM INFO | TI init Routine Invoked!
> ReportMediaModel: ( SD card Details)
>   Size            = 14 [MB]
>   mwCylinders       = 450
>   mwHeadCount       = 2
>   mwSectorsPerTrack = 32

Well the 450 cylinders there is right, so why is the driver passing info
down to user space saying the device has 448 cylinders?  Somehow you are
loosing 2 cylinders in your driver somewhere.

> When the ioctl is invoked through the "sfdisk -lV /dev/tfa0"
> 
> TIFM INFO | <tifm_ioctl> invoked! 
> TIFM INFO | dev no. [ 0 ] sock no. [ 0 ]
> TIFM INFO | <GetGeometry_ioctl> geo.cylinders = 450
> TIFM INFO | <GetGeometry_ioctl> geo.heads = 2
> TIFM INFO | <GetGeometry_ioctl> geo.sectors = 32
> TIFM INFO | <GetGeometry_ioctl> geo.start = 0
> 
> This means that I am giving the proper details to the user program but
> the sfdisk is printing it wrong (probably manipulation).
> 
> And when I try to mount ......
> 
> mount /dev/tfa0 /mnt
> FAT: bogus number of reserved sectors
> Mount: you must specify the filesystem type 

Well if the partition table/fs size is larger than the device currently
claims to be, the FS will fail and mount will fail.  Nothing wrong in
mount, just broken device driver.

> mount -tvfat /dev/tfa0 /mnt
> FAT: bogus number of reserved sectors
> Mount: wrong fs type, bad option, bas superblock on /dev/tfa0,
> 	 or too many mounted file systems
> 
> I have gone through the mount.c code in order to understand where I am
> exactly failing. 
> mount is failing in guess_fstype_and_mount() in do_mount_syscall after
> issuing the mount sys call.
> I am attaching the source code of mount functionality which may be on
> some help to u in u8ndertaing why exactly its failing.

Perhaps adding more debuging to your driver wherever user space calls in
to get the size of the device, to make sure you have the right
information passed along.  Heads and sectors looks fine, but the
cylinder count needs fixing since it is currently reporting 2 less than
it really is.  This has to be 100% a problem in the device driver.

Len Sorensen
