Return-Path: <linux-kernel-owner+willy=40w.ods.org-S273587AbVBEUNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273587AbVBEUNw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 15:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271810AbVBEUMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 15:12:35 -0500
Received: from math.ut.ee ([193.40.5.125]:23261 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S271261AbVBEUMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 15:12:13 -0500
Date: Sat, 5 Feb 2005 22:12:06 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: hddtemp hangs usb-storage for 66 seconds
Message-ID: <Pine.SOC.4.61.0502052117570.17047@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Chronos 6-in-1 card reader with USB interface. Currently the 
slots are empty and running hddtemp /dev/sda (fist slot, CF) puts 
hddtemp and usb-storage processes into D state. I thought they were 
stuck but while writing this message it became unstuck.

Hardware is 3 different x86 PC-s with both UHCI and OHCI host 
controllers, 2.6.9..2.6.11-rc3 tested, card reader is identified by 
lsusb as
Bus 001 Device 002: ID 0dda:0102 Integrated Circuit Solution, Inc.

First it logs 5 times the message
program hddtemp is using a deprecated SCSI ioctl, please convert it to SG_IO
and then usb-storage remains in D state in usb_stor_msg_common and 
hddtemp is in D state in blk_execute_rq and then hddtemp exits after 66 
seconds with error message
/dev/sda: log sense failed : Invalid argument

Can something be done with usb-storage to give the result quicker? For 
me the problem happens at boot, the workarounds are removing removing 
the card readed during boot or fiddling with hddtemp conf everytime I 
rearrange storage devices (both are bad but not unbearable).

strace fragment of hddtemp:

20211 open("/dev/sda", O_RDONLY|O_NONBLOCK) = 3 <0.078510>
20211 ioctl(0x3, 0x30d, 0x80538a0)      = -1 (errno 22) <0.000094>
20211 ioctl(0x3, 0x5386, 0xbffffd34)    = 0 <0.000063>
20211 ioctl(0x3, 0x1, 0xbffffc10)       = 0 <0.007336>
20211 ioctl(0x3, 0x1, 0xbffff650)       = 0 <0.007175>
20211 ioctl(0x3, 0x1, 0xbffff650)       = 0 <0.007258>
20211 ioctl(0x3, 0x1, 0xbffff650)       = 0 <0.007242>
20211 ioctl(0x3, 0x1, 0xbffff4a0)       = 0x2 <66.020693>
20211 close(3)                          = 0 <0.000177>
20211 write(2, "/dev/sda: log sense failed : Invalid argument\n", 46) = 46 <0.001035>

So it seems it's 7th SCSI_IOCTL_SEND_COMMAND ioctl that takes so long. 
At the first glance it seems to be SCSI_IOCTL_SEND_COMMAND with 
LOG_SENSE command (and the error message confirms this).

hddtemp is debian's 0.3-beta12-9.

-- 
Meelis Roos (mroos@linux.ee)
