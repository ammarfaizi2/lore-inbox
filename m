Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268428AbTANAVp>; Mon, 13 Jan 2003 19:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268430AbTANAVp>; Mon, 13 Jan 2003 19:21:45 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:22988 "EHLO w-patman.des")
	by vger.kernel.org with ESMTP id <S268428AbTANAVo>;
	Mon, 13 Jan 2003 19:21:44 -0500
Date: Mon, 13 Jan 2003 16:27:41 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Andries.Brouwer@cwi.nl, mdharm-usb@one-eyed-alien.net,
       Greg KH <greg@kroah.com>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: sysfs
Message-ID: <20030113162741.A18396@beaverton.ibm.com>
References: <UTC200301111443.h0BEhRZ06262.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200301111443.h0BEhRZ06262.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Jan 11, 2003 at 03:43:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries -

On Sat, Jan 11, 2003 at 03:43:27PM +0100, Andries.Brouwer@cwi.nl wrote:
> Yesterday evening I wrote a trivial utility fd ("find device")
> that gives the contents of sysfs. Mostly in order to see what
> name the memory stick card reader has today.
> 
> I wondered about several things.
> Is there a description of the intended hierachy, so that one can
> compare present facts with intention?
> 
> In /sysfs/devices I see
> 1:0:6:0  2:0:0:1  2:0:0:3  3:0:0:1  4:0:0:0  4:0:0:2   ide0  legacy  sys
> 2:0:0:0  2:0:0:2  3:0:0:0  3:0:0:2  4:0:0:1  ide-scsi  ide1  pci0
> many SCSI devices and some subdirectories.
> Would it not be better to have subdirectories scsiN just like ideN?
> One can have SCSI hosts, even when presently no devices are connected.

It looks like there is a missing scsi_set_device() call in scsiglue.c,
(similiar to what happens if we handled NULL dev pointer in scis_add_host)
so all the usb scsi devices end up under /sysfs/devices.

I don't have any usb mass storage devices, this patch against 2.5 bk
compiles but otherwise is not tested. It should put the usb-scsi mass
storage devices below the usb sysfs dev (I assume in your case under
/sysfs/devices/pci0/00:07.2/usb1/1-2/1-2.4/1-2.4.4).

Maybe Matthew or Greg can comment.

--- 1.33/drivers/usb/storage/scsiglue.c	Sun Nov 10 09:49:52 2002
+++ edited/drivers/usb/storage/scsiglue.c	Mon Jan 13 15:33:49 2003
@@ -90,6 +90,7 @@
 	if (us->host) {
 		us->host->hostdata[0] = (unsigned long)us;
 		us->host_no = us->host->host_no;
+		scsi_set_device(us->host, &us->pusb_dev->dev);
 		return 1;
 	}
 
-- Patrick Mansfield
