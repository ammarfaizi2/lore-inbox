Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265187AbUETTk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265187AbUETTk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 15:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbUETTk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 15:40:28 -0400
Received: from htklx2.htk.fi ([195.156.245.118]:57500 "EHLO htklx2.htk.fi")
	by vger.kernel.org with ESMTP id S265187AbUETTkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 15:40:18 -0400
Message-ID: <40AD099C.7040705@fixel.org>
Date: Thu, 20 May 2004 22:40:12 +0300
From: Pauli Borodulin <boro@fixel.org>
Organization: Fixel networking Org.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, fi
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Writing to disks takes system to it's knees when using libata with
 sil3112
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently upgraded my kernel from 2.4.25 to 2.6.6 and started using 
libata. I used siimage.c with 2.4 and it worked fine enough with this 
patch applied: 
http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/ide-siimage-seagate.patch

Now with 2.6.6 and libata, all things don't seem to work that well. I 
use couple of Maxtor's 120GB SATA-disks (6Y120M0) in software raid 
configuration (mirroring) with Silicon Image's SIL3112. Hdparm seems to 
indicate correct performance for the disks, but writing to the disks is 
slow and makes my system sluggerish. Good example is running bonnie++ 
(bonnie++ -u nobody -d /archive/tmp -s 1024 -n 0) to test the speed of 
my raid. Bonnie++ writing its test file (putc part) is really slow, 
something like 1MB/s. If I press ctrl-c, it takes a short while to end, 
and while that ps reports bonnie++'s status as "D" (uninterruptible 
sleep). Also kjournald seems to be as "D". Intelligently writing part 
works faster (higher MB/s), but system remains quite slow thru' the 
whole test. I also tried copying files to my raid with cp and it's the 
same 1MB/s.

I noticed the bad performance first after booting my system to 2.6.6: my 
raid mirror was in unsync and md started recovering it in the background 
-- highest speed I saw while watching /proc/mdstat was about 1MB/s and I 
had hard time trying to do anything. With 120GB disks, I had no other 
choice than cancel it. Reading from the disks seems to work better, cat 
really-big-file > /dev/null doesn't disturb other activity and works as 
quickly as it should.

I did try changing the disks behind a HPT374 with serial ata bridges and 
I reached about 17MB/s speed without any interference. I assume there's 
something wrong with libata's 3112/3114-support. Any ideas how to fix 
this would be good.

Here's libata's output from dmesg:

libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xE0826080 ctl 0xE082608A bmdma 0xE0826000 
irq 18
ata2: SATA max UDMA/100 cmd 0xE08260C0 ctl 0xE08260CA bmdma 0xE0826008 
irq 18
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 
88:207f
ata2: dev 0 ATA, max UDMA/133, 240121728 sectors
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
   Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 1.02
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write through
  /dev/scsi/host0/bus0/target0/lun0: p1 p2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write through
  /dev/scsi/host1/bus0/target0/lun0: p1 p2


Regards,
-- 
Pauli Borodulin
