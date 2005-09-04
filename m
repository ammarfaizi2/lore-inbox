Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVIDPzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVIDPzE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 11:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVIDPzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 11:55:04 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:3346 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750847AbVIDPzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 11:55:02 -0400
Message-ID: <431B18D2.2000708@rainbow-software.org>
Date: Sun, 04 Sep 2005 17:54:58 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tic-35054-1125849300-0001-2"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-floppy - software eject not working with LS-120 drive
References: <4318BA6C.8070707@rainbow-software.org> <200509031801.11356.vda@ilport.com.ua>
In-Reply-To: <200509031801.11356.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tic-35054-1125849300-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Denis Vlasenko wrote:
> On Friday 02 September 2005 23:47, Ondrej Zary wrote:
> 
>>Hello,
>>I've bought "new" LS-120 drive and found that software eject does not 
>>work with 2.6.13 kernel:
>>root@pentium:~# eject /dev/hdc
>>eject: unable to eject, last error: Invalid argument
>>
>>The drive spins up and after a while the command fails.
>>This appears in dmesg after each eject attempt:
>>  hdc: unknown partition table
>>ide-floppy: hdc: I/O error, pc = 1b, key =  5, asc = 24, ascq =  0
>>
>>When I boot 2.4.31, eject works fine.
> 
> 
> Can you probive something narrower than 2.4.31 -> 2.6.13 jump?

The problem is caused by idefloppy_ioctl() function which *first* tries
generic_ide_ioctl() and *only* if it fails with -EINVAL, proceeds with
the specific ioctls.
This patch fixes it by first going through the internal ioctls and only
trying generic_ide_ioctl() if none of them matches.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

-- 
Ondrej Zary




--=_tic-35054-1125849300-0001-2
Content-Type: text/plain; name="ide-floppy-eject.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-floppy-eject.patch"

--- linux-2.6.13-orig/drivers/ide/ide-floppy.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-pentium/drivers/ide/ide-floppy.c	2005-09-04 14:07:53.000000000 +0200
@@ -2038,11 +2038,9 @@
 	struct ide_floppy_obj *floppy = ide_floppy_g(bdev->bd_disk);
 	ide_drive_t *drive = floppy->drive;
 	void __user *argp = (void __user *)arg;
-	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
+	int err;
 	int prevent = (arg) ? 1 : 0;
 	idefloppy_pc_t pc;
-	if (err != -EINVAL)
-		return err;
 
 	switch (cmd) {
 	case CDROMEJECT:
@@ -2094,7 +2092,7 @@
 	case IDEFLOPPY_IOCTL_FORMAT_GET_PROGRESS:
 		return idefloppy_get_format_progress(drive, argp);
 	}
- 	return -EINVAL;
+	return generic_ide_ioctl(drive, file, bdev, cmd, arg);
 }
 
 static int idefloppy_media_changed(struct gendisk *disk)




--=_tic-35054-1125849300-0001-2--
