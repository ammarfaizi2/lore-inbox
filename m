Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbTEFNug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTEFNug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:50:36 -0400
Received: from mail2.ewetel.de ([212.6.122.18]:10946 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S263713AbTEFNue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:50:34 -0400
Date: Tue, 6 May 2003 16:02:58 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <1052214062.28792.4.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305061552520.1235-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 May 2003, Alan Cox wrote:

> I'm not aware of any plans to make ide-floppy handle that disk, or reasons
> you would want to use ide floppy in 2.5 not the ide-cd layer (which does
> now handle writable devices I believe).

Okay, didn't think of that, so I now tried using ide-cd for the MO drive
(2.5.68+bkcvs). I still had to patch ide-probe.c, just passing "hde=cdrom" 
did not do what I wanted. ;)

Now I get the following at bootup:

hde: FUJITSU MCC3064AP, ATAPI OPTICAL drive
hde: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hde: set_drive_speed_status: error=0x04
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hde, sector 0
hde: packet command error: status=0x51 { DriveReady SeekComplete Error }
hde: packet command error: error=0x50
end_request: I/O error, dev hde, sector 0
ATAPI device hde:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 2a 00 00 00 00 00 18 00 00 00 00 00 00 00 "
  Error in command data byte 8800
hde: packet command error: status=0x51 { DriveReady SeekComplete Error }
hde: packet command error: error=0x50
end_request: I/O error, dev hde, sector 0
ATAPI device hde:
  Error: Illegal request -- (Sense key=0x05)
  Invalid field in command packet -- (asc=0x24, ascq=0x00)
  The failed "Mode Sense 10" packet command was: 
  "5a 00 2a 00 00 00 00 00 18 00 00 00 00 00 00 00 "
  Error in command data byte 8800
end_request: I/O error, dev hde, sector 0

This doesn't look encouraging. However, the MO drive sort of works:

# mount -t ext2 /dev/hde /mnt/mo
mount: block device /dev/hde is write-protected, mounting read-only

The disk gets mounted and reading works just fine. No write support,
though. To reiterate, everything works under 2.4 using ide-scsi.

What can I do to help get this drive supported under 2.5/ide-cd?

I'll check if reading from the MO drive works with ide-cd under 2.4
as well. If it does: what about a patch that makes ATAPI MO drives
and CD writers behave the same on 2.4: read-only with native ide drivers,
read-write with ide-scsi?

--- linux-2.5/drivers/ide/ide-probe.c	Sat Apr 26 18:49:57 2003
+++ build25/drivers/ide/ide-probe.c	Tue May  6 15:42:40 2003
@@ -221,6 +221,7 @@ static inline void do_identify (ide_driv
 				break;
 			case ide_optical:
 				printk ("OPTICAL");
+				type = ide_cdrom;
 				drive->removable = 1;
 				break;
 			default:

-- 
Ciao,
Pascal

