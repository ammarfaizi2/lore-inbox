Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUAEUDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265315AbUAEUDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:03:43 -0500
Received: from marcet.info ([213.60.139.160]:20116 "EHLO mail.marcet.info")
	by vger.kernel.org with ESMTP id S265311AbUAEUDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:03:36 -0500
Date: Mon, 5 Jan 2004 21:03:33 +0100
From: Javier Marcet <lists@marcet.info>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org, usb-storage@one-eyed-alien.net,
       linux-usb-users@lists.sourceforge.net
Subject: Re: usb-storage && iRIVER flash player problem
Message-ID: <20040105200333.GA11318@hiroshi>
Reply-To: Javier Marcet <javier@marcet.info>
References: <20040105125948.GA9257@hiroshi> <20040105190204.GA4547@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20040105190204.GA4547@one-eyed-alien.net>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.6.1-rc1-mm1 i686 AMD Athlon(TM) XP 2000+ AuthenticAMD
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

* Matthew Dharm <mdharm-kernel@one-eyed-alien.net> [040105 20:02]:

>It looks like your device is choking over the ALLOW_MEDIUM_REMOVAL command
>-- I've never seen a device broken in this particular way before.

>If you edit drivers/scsi/sd.c to remove the sending of that command (it's
>normally used to lock the media-eject button on devices that support it),
>we should be able to test this theory.  If this is the case, then we may
>need to modify the SCSI layer to only send that command if the RMB bit is
>set.

That did it, with this fix I have no problems. fdisk still reports
mangled partitions, parted OTOH reports one partition filling the whole
device. I can mount either /dev/sda or /dev/sda4 and get the same
correct results.

Thanks a lot :) You've made me happy for the coming days ;)
Until your message I was messing around with unusual_devs.h to no
avail...


-- 
Javier Marcet <javier@marcet.info>

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-storage_ifpdev_fix.patch"

--- linux/drivers/scsi/scsi_ioctl.c.orig	2004-01-01 09:12:20.000000000 +0100
+++ linux/drivers/scsi/scsi_ioctl.c	2004-01-05 20:42:03.979349544 +0100
@@ -156,7 +156,7 @@
 	if (!sdev->removable || !sdev->lockable)
 	       return 0;
 
-	scsi_cmd[0] = ALLOW_MEDIUM_REMOVAL;
+	scsi_cmd[0] = 0;
 	scsi_cmd[1] = 0;
 	scsi_cmd[2] = 0;
 	scsi_cmd[3] = 0;

--/04w6evG8XlLl3ft--
