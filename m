Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbUAFUca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 15:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUAFUca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 15:32:30 -0500
Received: from marcet.info ([213.60.139.160]:22446 "EHLO mail.marcet.info")
	by vger.kernel.org with ESMTP id S265080AbUAFUc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 15:32:27 -0500
Date: Tue, 6 Jan 2004 21:32:23 +0100
From: Javier Marcet <lists@marcet.info>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       <linux-kernel@vger.kernel.org>, <usb-storage@one-eyed-alien.net>,
       <linux-usb-users@lists.sourceforge.net>
Subject: Re: usb-storage && iRIVER flash player problem
Message-ID: <20040106203223.GA8840@hiroshi>
Reply-To: Javier Marcet <javier@marcet.info>
References: <20040106065655.GA10031@one-eyed-alien.net> <Pine.LNX.4.44L0.0401061035420.770-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0401061035420.770-100000@ida.rowland.org>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.6.1-rc1-mm2 i686 AMD Athlon(TM) XP 2000+ AuthenticAMD
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

* Alan Stern <stern@rowland.harvard.edu> [040106 16:41]:

>> > >It looks like your device is choking over the ALLOW_MEDIUM_REMOVAL command
>> > >-- I've never seen a device broken in this particular way before.

>> Hrm... what's the easiest way for Javier to figure out if his device sets
>> the RMB or not?

>> I feel another SCSI enhancement coming on....

>It's not so simple, unfortunately.  In 2.6, sd.c already does check that 
>sdev->removable is set before issuing PREVENT ALLOW MEDIUM REMOVAL.

Yeah, I noticed that upon looking over sd.c et all.
It seems this iRiver player reports incorrectly that it is removable,
since the protocol used by usb-stoareg for this device is
transparent_scsi, thus all the info is fed directly from the device to
the scsi layer.

I have added a new flag for SCSI devices that need special treatment,
and the "iRiver" "iFP Mass Driver"  to the list of those devices with
that new flag. this way nothing is broken to support the iRiver.
However, since this is not a real SCSI device, shouldn't this be
transparently fixed by usb-storage instead? Or is it ok this way?


-- 
Javier Marcet <javier@marcet.info>

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="broken_RMB_scsi.patch"

--- linux/include/scsi/scsi_devinfo.h.orig	2004-01-06 01:00:29.000000000 +0100
+++ linux/include/scsi/scsi_devinfo.h	2004-01-06 20:15:50.036892568 +0100
@@ -19,4 +19,5 @@
 #define BLIST_MS_SKIP_PAGE_08	0x2000	/* do not send ms page 0x08 */
 #define BLIST_MS_SKIP_PAGE_3F	0x4000	/* do not send ms page 0x3f */
 #define BLIST_USE_10_BYTE_MS	0x8000	/* use 10 byte ms before 6 byte ms */
+#define BLIST_NORMB     	0x10000	/* Known to be not removable */
 #endif
--- linux/drivers/scsi/scsi_scan.c.orig	2004-01-06 01:00:29.000000000 +0100
+++ linux/drivers/scsi/scsi_scan.c	2004-01-06 20:10:19.731106680 +0100
@@ -536,7 +536,8 @@
 		sdev->online = FALSE;
 	}
 
-	sdev->removable = (0x80 & inq_result[1]) >> 7;
+	sdev->removable = (((0x80 & inq_result[1]) >> 7) &&
+		!(*bflags & BLIST_NORMB));
 	sdev->lockable = sdev->removable;
 	sdev->soft_reset = (inq_result[7] & 1) && ((inq_result[3] & 7) == 2);
 
--- linux/drivers/scsi/scsi_devinfo.c.orig	2004-01-06 01:00:29.000000000 +0100
+++ linux/drivers/scsi/scsi_devinfo.c	2004-01-06 20:13:46.890613648 +0100
@@ -183,6 +183,7 @@
 	{"SGI", "TP9500", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"MYLEX", "DACARMRB", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"XYRATEX", "RS", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
+	{"iRiver", "iFP Mass Driver", NULL, BLIST_NORMB},
 	{ NULL, NULL, NULL, 0 },
 };
 

--MGYHOYXEY6WxJCY8--
