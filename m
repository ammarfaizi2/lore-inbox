Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVANUZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVANUZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVANUWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:22:42 -0500
Received: from lakermmtao01.cox.net ([68.230.240.38]:33169 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262055AbVANUTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:19:01 -0500
Message-ID: <41E8292A.40302@dot21rts.com>
Date: Fri, 14 Jan 2005 14:18:50 -0600
From: Andy Helten <andy.helten@dot21rts.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: SATA hotplug status (sii3114)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can anyone tell me the current status of hotplug support?  The SATA web 
site says only this:

> libata does not support hotplug... yet. 


Is there a plan or design for adding hotplug support?  Can anyone point 
me to any discussions on this matter.  I am new to Linux kernel 
development, but I have searched the archives and found nothing very 
helpful (except for the mention of the echo commands I tried below).  
There could be a simple solution that is evading me, but I've looked for 
two days now without much success.

I am running kernel version 2.4.25-elinos-53 with the 2.4.25-libata16 
patch.  The CPU is a PowerPC 8245 and the SATA controller is an 
Sii3114.  The processor board provides hotplug support which, at least 
at a hardware level, allows safe removal and insertion of the drives.  
However, the software does not appear to handle the re-install very 
well.  Note that before a remove/insert cycle, the drive seems to work 
fine (I haven't tested it very extensively).  This could also be an 
issue with the way hardware brings the drive back up after hotplug 
insertion (I am also not that familiar with SATA just yet).

Thanks for any help,
Andy


*****

If interested, here is what I've done thus far:

I've tried rescanning the bus using 'echo "rescan" > /proc/scsi/scsi' 
and explicitly adding/removing the device using 'add-single-device' and 
'remove-single-device'.  None of these seem to help the device recover 
following a drive hotplug remove/insert.  For example, I issue the 
'remove-single-device' command, remove the drive, re-insert the drive, 
and issue the 'add' command.  I verify that the drive is indeed removed 
from /proc/scsi/scsi and then added back after the 'add' command, but 
accessing the drive does not work following the hotplug insertion.  In 
fact, the 'add' command never returns to the command line, although the 
kernel does continue to run and I can use another terminal to look at 
/proc/scsi/scsi.

I've also tried the 'add' and 'remove' commands without physically 
removing the drive.  After this, I can remount the drive and read/write 
it without problems.  This seems to prove that the act of hotplug 
removal/insertion is the real issue.


Here is a console session of a remove/insert cycle:

[1 /]#cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HTE726040M9AT00  Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HTE726040M9AT00  Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
[2 /]#echo "scsi remove-single-device 0 0 0 0" >/proc/scsi/scsi
[3 /]#cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HTE726040M9AT00  Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
[4 /]#

    /* drive is removed */

cpld.o: shuttle 1: released    /* msg from interrupt routine */

[4 /]#cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HTE726040M9AT00  Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
[5 /]#

    /* drive is inserted */

cpld.o: shuttle 1: inserted    /* msg from interrupt routine */

[5 /]#cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HTE726040M9AT00  Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
[6 /]#echo "scsi add-single-device 0 0 0 0" >/proc/scsi/scsi
scsi singledevice 0 0 0 0
  Vendor: ATA       Model: HTE726040M9AT00   Rev: 1.02
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
 sda:<3>ata1: DMA timeout, stat 0x1
ATA: abnormal status 0xD0 on port 0xD1042C87
scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 00 00 00 00 00 08 00
Current sd08:00: sns = 70  3
ASC=11 ASCQ= 4
Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x06 0x00 0x00 0x00 
0x00 0x11
0x04
 I/O error: dev 08:00, sector 0
 
[7 /]#cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HTE726040M9AT00  Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model:                  Rev:
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HTE726040M9AT00  Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05


