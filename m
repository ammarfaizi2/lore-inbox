Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263779AbTEFOHe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTEFOHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:07:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6382 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263753AbTEFOAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:00:32 -0400
Date: Tue, 6 May 2003 16:07:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
Message-ID: <20030506140751.GA25817@suse.de>
References: <1052214062.28792.4.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0305061552520.1235-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305061552520.1235-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06 2003, Pascal Schmidt wrote:
> On 6 May 2003, Alan Cox wrote:
> 
> > I'm not aware of any plans to make ide-floppy handle that disk, or reasons
> > you would want to use ide floppy in 2.5 not the ide-cd layer (which does
> > now handle writable devices I believe).
> 
> Okay, didn't think of that, so I now tried using ide-cd for the MO drive
> (2.5.68+bkcvs). I still had to patch ide-probe.c, just passing "hde=cdrom" 
> did not do what I wanted. ;)

Uh nasty :)

> Now I get the following at bootup:
> 
> hde: FUJITSU MCC3064AP, ATAPI OPTICAL drive
> hde: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hde: set_drive_speed_status: error=0x04
> Uniform CD-ROM driver Revision: 3.12
> end_request: I/O error, dev hde, sector 0
> hde: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hde: packet command error: error=0x50
> end_request: I/O error, dev hde, sector 0
> ATAPI device hde:
>   Error: Illegal request -- (Sense key=0x05)
>   Invalid field in command packet -- (asc=0x24, ascq=0x00)
>   The failed "Mode Sense 10" packet command was: 
>   "5a 00 2a 00 00 00 00 00 18 00 00 00 00 00 00 00 "
>   Error in command data byte 8800
> hde: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hde: packet command error: error=0x50
> end_request: I/O error, dev hde, sector 0
> ATAPI device hde:
>   Error: Illegal request -- (Sense key=0x05)
>   Invalid field in command packet -- (asc=0x24, ascq=0x00)
>   The failed "Mode Sense 10" packet command was: 
>   "5a 00 2a 00 00 00 00 00 18 00 00 00 00 00 00 00 "
>   Error in command data byte 8800
> end_request: I/O error, dev hde, sector 0

It barfs at a lot of commands, not surprisingly. ide-cd really has no
concept of devices other than cd/dvd.

> This doesn't look encouraging. However, the MO drive sort of works:
> 
> # mount -t ext2 /dev/hde /mnt/mo
> mount: block device /dev/hde is write-protected, mounting read-only
> 
> The disk gets mounted and reading works just fine. No write support,
> though. To reiterate, everything works under 2.4 using ide-scsi.

You need to patch cdrom.c as well:

	if ((fp->f_mode & FMODE_WRITE) && !CDROM_CAN(CDC_DVD_RAM))
		return -EROFS;

> What can I do to help get this drive supported under 2.5/ide-cd?

I'm tempted to say ide-scsi + sd, but that goes against my principles...
It shouldn't be too much work to make ide-cd work gracefully.

-- 
Jens Axboe

