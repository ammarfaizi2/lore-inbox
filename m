Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbVIGR3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbVIGR3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVIGR3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:29:09 -0400
Received: from main.gmane.org ([80.91.229.2]:34537 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751159AbVIGR3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:29:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: 2.6.13 (was 2.6.11.11) and rsync oops (SATA or NFS related?)
Date: Thu, 08 Sep 2005 02:22:35 +0900
Message-ID: <431F21DB.2010504@thinrope.net>
References: <dfg2sa$peu$2@sea.gmane.org> <dfguoq$eng$1@sea.gmane.org> <dfhjp3$fd4$1@sea.gmane.org> <dfjjp9$f7k$1@sea.gmane.org> <loom.20050907T055454-169@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
In-Reply-To: <loom.20050907T055454-169@post.gmane.org>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aric Cyr wrote:
> Kalin KOZHUHAROV <kalin <at> thinrope.net> writes:
> 
> 
>>A closer examination of the drive:
>>	(Model=ST3300831AS, FwRev=3.03, SerialNo=3NF07KA1 )
>>and why is it so slow revealed that it was running not in UDMA.
>>
>>Got one total oops, even no logs were written to disk.
>>Seems that rsync-ing huge amounts of data (200 GB in *many* small files)
>>streses the system too much.
> 
> It seems that you are using the IDE-SATA driver... perhaps you should try the
> SCSI-SATA (i.e. libata)?  The IDE one is deprecated and should no longer be
> used.  Disable SATA from in the IDE menu and enable the SCSI libata driver for
> your chipset (in the scsi kernel menu).

Well, well, well... Cal me blind, but I didn't realize that this
machine is still running on IDE-SATA (as if the hdg was not enough).
My other machines are with libata for a long time, but this was just
running, so I `make oldconfig` only the other night. Now that I
rebooted it into the new kernel, it says at boot:
===
libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:0b.0[A] -> Link [APC3] -> GSI 18 (level, high) -> IRQ 16
ata1: SATA max UDMA/100 cmd 0xF8802080 ctl 0xF880208A bmdma 0xF8802000 irq 16
ata2: SATA max UDMA/100 cmd 0xF88020C0 ctl 0xF88020CA bmdma 0xF8802008 irq 16
ata1: dev 0 cfg 49:2f00 82:74eb 83:7f63 84:4003 85:74e9 86:3c43 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 72303840 sectors: lba48
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:207f
ata2: dev 0 ATA, max UDMA/133, 586072368 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
   Vendor: ATA       Model: WDC WD360GD-00FL  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
SCSI device sdb: drive cache: write back
  sdb: sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
===

However hdparm does not work now :-(
# hdparm -i /dev/sda

/dev/sda:
  HDIO_GET_IDENTITY failed: Inappropriate ioctl for device

After upgrading to hdparm-6.1 (not sure it was necessary) "-i" still fails, but:

# hdparm  /dev/sdb

/dev/sdb:
  IO_support   =  0 (default 16-bit)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 36481/255/63, sectors = 586072368, start = 0

  # hdparm -t /dev/sdb

/dev/sdb:
  Timing buffered disk reads:  176 MB in  3.01 seconds =  58.43 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device

I don't like the error MSG above, but 58MB/s is not bad, compared to 36.5MB/s with ide-sata driver!
My other 10k rpm SATA drive (WD360GD-00FL) has not changed from 62MB/s.
Now, the long run will show how stable is that.

Might be a stupid question... but is UDMA relevant to SATA drives run by libata??
If yes, how do I get the current value of it?

> Also the reason you don't get higher UDMA modes is because your drive is a
> blacklisted seagate.  There are known problems with some of those drives, and so
> they are downgraded to slower modes (this was mentioned in your kernel log if
> you look closely). 

Well, I thought that was a problem with some early Seagate drives some 6-9 months ago.
That is my first Seagate SATA drive, I have always used (many) WDs till now, but the
shop didn't have any 300GB WD at that time.

> If you upgrade the BIOS on your harddrive, you _might_ be
> able to remove the drive from the blacklist in the kernel to improve
> performance... this may be dangerous however, so don't complain if you lose your
> data.
And upgrading firmware to a harddrive is done how?
Done on my BIOSes, my Plextor CD-Rs and DVD+RWs, but on a hard drive?
Any pointers, or that was just a random thought :-)

According to linux-2.6.13/drivers/scsi/sata_sil.c:94 my drives are not blacklisted.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|


