Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUABQMW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 11:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265605AbUABQMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 11:12:22 -0500
Received: from mail.convergence.de ([212.84.236.4]:7871 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S265603AbUABQMT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 11:12:19 -0500
Message-ID: <3FF5986C.8060806@convergence.de>
Date: Fri, 02 Jan 2004 17:12:28 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com> <20040102103949.GL5523@suse.de> <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com>
Content-Type: multipart/mixed;
 boundary="------------010106090501020105090500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010106090501020105090500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Helloo

On 02.01.2004 15:25, Jeff Chua schrieb:
> On Fri, 2 Jan 2004, Jens Axboe wrote:

> USB drive is a Pioneer DVR-SK11B-J. It's reported as ...
> 
> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: PIONEER   Model: DVD-RW  DVR-K11   Rev: 1.00
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> 
> I've tried at least 2 other USB drives (Plextor PX-208U, and Sony CRX85U),
> and both of these drives also exhibit the same problem.

>>>Linux version is 2.4.24-pre3.

> scsi0 : SCSI emulation for USB Mass Storage devices
>   Vendor: PIONEER   Model: DVD-RW  DVR-K11   Rev: 1.00
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> sr0: scsi-1 drive

IMHO the problem is inside SCSI drive recognition system, which can be 
found in "drivers/scsi/sr.c".

The function "get_capabilities()" tries to find out which type of drive 
you have.

---------------------------schnipp--------------------------------------
     rc = sr_do_ioctl(i, cmd, buffer, 128, 1, SCSI_DATA_READ, NULL);

     if (rc) {
         /* failed, drive doesn't have capabilities mode page */
         scsi_CDs[i].cdi.speed = 1;
         scsi_CDs[i].cdi.mask |= (CDC_CD_R | CDC_CD_RW | CDC_DVD_R |
                      CDC_DVD | CDC_DVD_RAM |
                      CDC_SELECT_DISC | CDC_SELECT_SPEED);
         scsi_free(buffer, 512);
         printk("sr%i: scsi-1 drive\n", i);
         return;
     }
---------------------------schnipp--------------------------------------

For my SCSI-2/USB drive, the above SCSI_DATA_READ command fails. As you 
can see, in this case the driver thinks that your drive is SCSI-1, ie. a 
CD-drive only. So DVD ioctls like the AGID commands will be filtered in 
the lower levels, because a CD-driver does not understand them anyway.

Unfortunately, the driver only knows SCSI-1 and SCSI-3, so SCSI-2 DVD 
driver are out of luck here and get downgraded to SCSI-1 CD-ROM stuff.

The patch below unmasks the DVD drive bit, ie. even if the kernel 
misdetects your driver, it will allow DVD ioctls to be passed to your drive.

This is not a safe fix, but "it works for me"(tm). I don't know how to 
really fix it; probably adding proper SCSI-2 support.

> Thanks,
> Jeff

CU
Michael.

--------------010106090501020105090500
Content-Type: text/plain;
 name="usb-scsi-2-dvd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usb-scsi-2-dvd.patch"

diff -ur linux-2.4.21/drivers/scsi/sr.c linux-2.4.21.patched/drivers/scsi/sr.c
--- linux-2.4.21/drivers/scsi/sr.c	2003-06-13 16:51:36.000000000 +0200
+++ linux-2.4.21.patched/drivers/scsi/sr.c	2003-08-27 23:52:32.000000000 +0200
@@ -725,7 +725,7 @@
 		/* failed, drive doesn't have capabilities mode page */
 		scsi_CDs[i].cdi.speed = 1;
 		scsi_CDs[i].cdi.mask |= (CDC_CD_R | CDC_CD_RW | CDC_DVD_R |
-					 CDC_DVD | CDC_DVD_RAM |
+					 /* USB-DVD-SCSI-2 hack: */ /* CDC_DVD | */  CDC_DVD_RAM |
 					 CDC_SELECT_DISC | CDC_SELECT_SPEED);
 		scsi_free(buffer, 512);
 		printk("sr%i: scsi-1 drive\n", i);

--------------010106090501020105090500--
