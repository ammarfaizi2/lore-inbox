Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265587AbUABQSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 11:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265589AbUABQSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 11:18:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20391 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265587AbUABQS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 11:18:28 -0500
Date: Fri, 2 Jan 2004 17:18:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Michael Hunold <hunold@convergence.de>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
Message-ID: <20040102161813.GA21852@suse.de>
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com> <20040102103949.GL5523@suse.de> <Pine.LNX.4.58.0401022219290.10338@silk.corp.fedex.com> <3FF5986C.8060806@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF5986C.8060806@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Michael Hunold wrote:
> Helloo
> 
> On 02.01.2004 15:25, Jeff Chua schrieb:
> >On Fri, 2 Jan 2004, Jens Axboe wrote:
> 
> >USB drive is a Pioneer DVR-SK11B-J. It's reported as ...
> >
> >scsi0 : SCSI emulation for USB Mass Storage devices
> >  Vendor: PIONEER   Model: DVD-RW  DVR-K11   Rev: 1.00
> >  Type:   CD-ROM                             ANSI SCSI revision: 02
> >
> >I've tried at least 2 other USB drives (Plextor PX-208U, and Sony CRX85U),
> >and both of these drives also exhibit the same problem.
> 
> >>>Linux version is 2.4.24-pre3.
> 
> >scsi0 : SCSI emulation for USB Mass Storage devices
> >  Vendor: PIONEER   Model: DVD-RW  DVR-K11   Rev: 1.00
> >  Type:   CD-ROM                             ANSI SCSI revision: 02
> >Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> >sr0: scsi-1 drive
> 
> IMHO the problem is inside SCSI drive recognition system, which can be 
> found in "drivers/scsi/sr.c".
> 
> The function "get_capabilities()" tries to find out which type of drive 
> you have.
> 
> ---------------------------schnipp--------------------------------------
>     rc = sr_do_ioctl(i, cmd, buffer, 128, 1, SCSI_DATA_READ, NULL);
> 
>     if (rc) {
>         /* failed, drive doesn't have capabilities mode page */
>         scsi_CDs[i].cdi.speed = 1;
>         scsi_CDs[i].cdi.mask |= (CDC_CD_R | CDC_CD_RW | CDC_DVD_R |
>                      CDC_DVD | CDC_DVD_RAM |
>                      CDC_SELECT_DISC | CDC_SELECT_SPEED);
>         scsi_free(buffer, 512);
>         printk("sr%i: scsi-1 drive\n", i);
>         return;
>     }
> ---------------------------schnipp--------------------------------------
> 
> For my SCSI-2/USB drive, the above SCSI_DATA_READ command fails. As you 
> can see, in this case the driver thinks that your drive is SCSI-1, ie. a 
> CD-drive only. So DVD ioctls like the AGID commands will be filtered in 
> the lower levels, because a CD-driver does not understand them anyway.
> 
> Unfortunately, the driver only knows SCSI-1 and SCSI-3, so SCSI-2 DVD 
> driver are out of luck here and get downgraded to SCSI-1 CD-ROM stuff.
> 
> The patch below unmasks the DVD drive bit, ie. even if the kernel 
> misdetects your driver, it will allow DVD ioctls to be passed to your drive.
> 
> This is not a safe fix, but "it works for me"(tm). I don't know how to 
> really fix it; probably adding proper SCSI-2 support.
> 
> >Thanks,
> >Jeff
> 
> CU
> Michael.

> diff -ur linux-2.4.21/drivers/scsi/sr.c linux-2.4.21.patched/drivers/scsi/sr.c
> --- linux-2.4.21/drivers/scsi/sr.c	2003-06-13 16:51:36.000000000 +0200
> +++ linux-2.4.21.patched/drivers/scsi/sr.c	2003-08-27 23:52:32.000000000 +0200
> @@ -725,7 +725,7 @@
>  		/* failed, drive doesn't have capabilities mode page */
>  		scsi_CDs[i].cdi.speed = 1;
>  		scsi_CDs[i].cdi.mask |= (CDC_CD_R | CDC_CD_RW | CDC_DVD_R |
> -					 CDC_DVD | CDC_DVD_RAM |
> +					 /* USB-DVD-SCSI-2 hack: */ /* CDC_DVD | */  CDC_DVD_RAM |
>  					 CDC_SELECT_DISC | CDC_SELECT_SPEED);
>  		scsi_free(buffer, 512);
>  		printk("sr%i: scsi-1 drive\n", i);

Better yet, kill the silly checks instead.

===== drivers/cdrom/cdrom.c 1.41 vs edited =====
--- 1.41/drivers/cdrom/cdrom.c	Sat Sep 27 16:24:59 2003
+++ edited/drivers/cdrom/cdrom.c	Fri Jan  2 17:17:47 2004
@@ -2094,8 +2094,6 @@
 	case DVD_READ_STRUCT: {
 		dvd_struct *s;
 		int size = sizeof(dvd_struct);
-		if (!CDROM_CAN(CDC_DVD))
-			return -ENOSYS;
 		if ((s = (dvd_struct *) kmalloc(size, GFP_KERNEL)) == NULL)
 			return -ENOMEM;
 		cdinfo(CD_DO_IOCTL, "entering DVD_READ_STRUCT\n"); 
@@ -2115,8 +2113,6 @@
 
 	case DVD_AUTH: {
 		dvd_authinfo ai;
-		if (!CDROM_CAN(CDC_DVD))
-			return -ENOSYS;
 		cdinfo(CD_DO_IOCTL, "entering DVD_AUTH\n"); 
 		IOCTL_IN(arg, dvd_authinfo, ai);
 		if ((ret = dvd_do_auth (cdi, &ai)))


-- 
Jens Axboe

