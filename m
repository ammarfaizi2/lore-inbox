Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUI0MYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUI0MYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 08:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUI0MYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 08:24:14 -0400
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:52964 "EHLO
	ppsw-4.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S266802AbUI0MYB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 08:24:01 -0400
Subject: Re: Windows Logical Disk Manager error
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Marcin =?iso-8859-2?Q?Gibu=B3a?= <mg@iceni.pl>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409231254.12287@senat>
References: <200409231254.12287@senat>
Content-Type: text/plain; charset=UTF-8
Organization: University of Cambridge Computing Service, UK
Message-Id: <1096287833.8148.53.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 27 Sep 2004 13:23:53 +0100
Content-Transfer-Encoding: 8BIT
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-23 at 11:54, Marcin Gibuła wrote:
> Hi, 
> while using a disc partitioned with ldm the following error occures:
> 
> sda:<6>ldm_validate_vmdb(): VMDB and TOCBLOCK don't agree on the database 
> size.
> [LDM] sda1 sda2 sda3 sda4
> 
> One partition is then unaccessible (though it works in windows). Kernel 
> version is 2.6.8.1, but the problem also seems to appear in earlier versions.

Ok, I have now had the time to look at the ldm database you sent me. 
The problem is very simple.  You are using spanned volumes which are not
supported by the Linux LDM driver.  You need to use the software raid
(MD) driver in Linux to assemble the LDM partition devices (shown above)
into the correct MD devices and then mount the created md device(s). 
See linux-2.6/Documentation/filesystems/ntfs.txt for detailed
description of what you need to do.

The details you may want to know are that you have 4 volumes, three with
NTFS and one with FAT16:

Volume1: NTFS: Letter C in Windows: Size 10GiB
Volume2: NTFS: Letter D in Windows: Size 46GiB
Volume3: FAT16: Letter in Windows unknown: Size 28GiB
Volume6: NTFS: Letter in Windows unknown: Size 109GiB

Volume1 is a simple one partition volume which is the first LDM
partition on your other harddisk (i.e. the one you did not send me the
ldm dump from).  You can just mount that with the NTFS driver.

Volume2 is a two partition concatenated volume made up of partitions
sda1 (26GiB) and sda3 (20GiB) (in this order) on the disk you sent me
the ldm dump from.  This is why you get the errors when you try to mount
sda1.  It tries to access data that is outside sda1, i.e. in sda3, but
sda1 ends at the end of sda1 (obviously) so the data is not readable. 
You need to assemble sda1 and sda3 using the instructions in the ntfs
documentation (see above) and then mount the created MD device with the
ntfs driver.

Volume3 is a simple one partition volume which is the second LDM
partition on your other harddisk.  You can just mount that with the vfat
driver.

Volume6 is a two partition concatenated volume mad up of partitions sda4
(109GiB) and sda2 (32kiB!) (in this order!) on the disk you sent me the
ldm dump from.  You should assemble this as described for Volume2 and
then mount the created MD device with the ntfs driver.

btw. You can obtain all the above information yourself in the future by
running:
	linux-ldm-0.0.8/test/ldminfo --dump /dev/sda
And then putting the displayed info together.

Let me know how it goes.  Both success and failures are interesting to
me as I do not remember anyone actually having had spanned ldm volumes
before so it would be nice to know it all works...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

