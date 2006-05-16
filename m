Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWEPVSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWEPVSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWEPVSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:18:10 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:35492 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750834AbWEPVSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:18:09 -0400
Message-ID: <446A418E.3070307@cmu.edu>
Date: Tue, 16 May 2006 17:18:06 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: need help booting from SATA in 2.4.32
References: <446A36B8.1060707@cmu.edu> <20060516203917.GQ11191@w.ods.org>
In-Reply-To: <20060516203917.GQ11191@w.ods.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Willy Tarreau wrote:
> On Tue, May 16, 2006 at 04:31:52PM -0400, George Nychis wrote:
>> Hi,
>>
>> I've booted from a SATA drive in 2.4.32 before, but for some reason
>> 2.4.32 will not recognize this disk.  It is recognized when I boot 2.6.9
>> though.
>>
>> It uses the ata_piix module in both kernels.  Whenever I boot 2.6.9 I see:
>> ----------------------------------------------------------------------
>>  SCSI subsystem initialized
>>  ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 7 (level, low) -> IRQ 7
>>  ata: 0x170 IDE port busy
>>  ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
>>  ata1: dev 0 ATA, max UDMA/100, 78140160 sectors:
>>  ata1(0): applying bridge limits
>>  ata1: dev 0 configured for UDMA/100
>>  scsi0 : ata_piix
>>    Vendor: ATA       Model: FUJITSU MHV2040A  Rev: 0000
>>    Type:   Direct-Access                      ANSI SCSI revision: 05
>>  SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
>>  SCSI device sda: drive cache: write back
>>   sda: sda1 sda2 sda3 sda4 < sda5 >
>>  Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>>  device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
>> ------------------------------------------------------------------------
>>
>> However in 2.4.32 all i see is:
>> ----------------------------
>>  SCSI subsystem initialized
>> ----------------------------
>>
>> I am positive that my 2.4.32 has been compiled with ata_piix as a
>> module, and it does reside in /lib/modules/2.4.32/kernel/driver/scsi/
>>
>> Any clues?
> 
> Could you retry with it statically linked in the kernel ? I vaguely
> remember that if the original PIIX4 driver registers the device first,
> then ata_piix cannot get it. You could also ensure that you have
> properly removed CONFIG_IDE_PIIX4 (I believe it's called like this).
> 
>> Thanks!
>> George
> 
> Regards,
> Willy
> 
> 

Thanks for the help Willy,

I think you're on to something.  I noticed this during the 2.4.32 kernel
bootup:
-----------------------------------------------------------------
hda: FUJITSU MHV2040AH, ATA DISK drive
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/8192KiB Cache, CHS=4864/255/63
-----------------------------------------------------------------

However i can't find CONFIG_IDE_PIIX4 in .config anyhwere.  I did find
CONFIG_BLK_DEV_PIIX so i tried disabling it, but the device still
registered under hda.

If i build it statically, i get this error trying to boot:
----------------------------------------------------------------------
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Kernel panic: VFS: Unable to mount root fs on 00:00
----------------------------------------------------------------------

AND it still finds the drive as /dev/hda

Therefore I built it as a module and put "alias scsi_hostadapter
ata_piix" in /etc/modules.conf" to atleast eliminate the
scsi_hostadapter thing

This is FC3, and my root is actually an LVM, so i get:
NVS: Cannot open root device "VolGroup00/LogVol00" or 00:00

So i'm thinking once the drive shows up as /dev/sda, the LVM will be
proper, and VolGroup00/LogVol00 will show up.

Any more ideas?

Thanks!
George

