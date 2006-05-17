Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWEQPNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWEQPNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWEQPNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:13:04 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:28556 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751296AbWEQPNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:13:02 -0400
Message-ID: <446B3D86.1020205@cmu.edu>
Date: Wed, 17 May 2006 11:13:10 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org, linux-lvm@redhat.com
Subject: help booting from SATA in 2.4.32.. initrd not loading
References: <446A36B8.1060707@cmu.edu> <20060516203917.GQ11191@w.ods.org> <446A418E.3070307@cmu.edu> <20060517034814.GA25818@w.ods.org> <446B2523.1040800@cmu.edu> <20060517142447.GA27602@w.ods.org>
In-Reply-To: <20060517142447.GA27602@w.ods.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Willy Tarreau wrote:
> On Wed, May 17, 2006 at 09:29:07AM -0400, George Nychis wrote:
>>
>> Willy Tarreau wrote:
>>> On Tue, May 16, 2006 at 05:18:06PM -0400, George Nychis wrote:
>>>> Willy Tarreau wrote:
>>>>> On Tue, May 16, 2006 at 04:31:52PM -0400, George Nychis wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've booted from a SATA drive in 2.4.32 before, but for some reason
>>>>>> 2.4.32 will not recognize this disk.  It is recognized when I boot 2.6.9
>>>>>> though.
>>>>>>
>>>>>> It uses the ata_piix module in both kernels.  Whenever I boot 2.6.9 I see:
>>>>>> ----------------------------------------------------------------------
>>>>>>  SCSI subsystem initialized
>>>>>>  ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 7 (level, low) -> IRQ 7
>>>>>>  ata: 0x170 IDE port busy
>>>>>>  ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
>>>>>>  ata1: dev 0 ATA, max UDMA/100, 78140160 sectors:
>>>>>>  ata1(0): applying bridge limits
>>>>>>  ata1: dev 0 configured for UDMA/100
>>>>>>  scsi0 : ata_piix
>>>>>>    Vendor: ATA       Model: FUJITSU MHV2040A  Rev: 0000
>>>>>>    Type:   Direct-Access                      ANSI SCSI revision: 05
>>>>>>  SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
>>>>>>  SCSI device sda: drive cache: write back
>>>>>>   sda: sda1 sda2 sda3 sda4 < sda5 >
>>>>>>  Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>>>>>>  device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
>>>>>> ------------------------------------------------------------------------
>>>>>>
>>>>>> However in 2.4.32 all i see is:
>>>>>> ----------------------------
>>>>>>  SCSI subsystem initialized
>>>>>> ----------------------------
>>>>>>
>>>>>> I am positive that my 2.4.32 has been compiled with ata_piix as a
>>>>>> module, and it does reside in /lib/modules/2.4.32/kernel/driver/scsi/
>>>>>>
>>>>>> Any clues?
>>>>> Could you retry with it statically linked in the kernel ? I vaguely
>>>>> remember that if the original PIIX4 driver registers the device first,
>>>>> then ata_piix cannot get it. You could also ensure that you have
>>>>> properly removed CONFIG_IDE_PIIX4 (I believe it's called like this).
>>>>>
>>>>>> Thanks!
>>>>>> George
>>>>> Regards,
>>>>> Willy
>>>>>
>>>>>
>>>> Thanks for the help Willy,
>>>>
>>>> I think you're on to something.  I noticed this during the 2.4.32 kernel
>>>> bootup:
>>>> -----------------------------------------------------------------
>>>> hda: FUJITSU MHV2040AH, ATA DISK drive
>>>> hda: attached ide-disk driver.
>>>> hda: host protected area => 1
>>>> hda: 78140160 sectors (40008 MB) w/8192KiB Cache, CHS=4864/255/63
>>>> -----------------------------------------------------------------
>>>>
>>>> However i can't find CONFIG_IDE_PIIX4 in .config anyhwere.  I did find
>>>> CONFIG_BLK_DEV_PIIX so i tried disabling it, but the device still
>>>> registered under hda.
>>> OK, you correctly removed the one I was thinking about. You should also
>>> remove other CONFIG_BLK_DEB_IDE* and CONFIG_IDEDMA*, because there is
>>> also a generic PCI support for IDE controllers. Most probably your
>>> drive has been detected on a generic PCI controller. At least, just for
>>> a test, completely disable IDE to be sure, and enable ata_piix. As long
>>> as you'll not see your disk as sda, it will not work.
>>>
>>>> If i build it statically, i get this error trying to boot:
>>>> ----------------------------------------------------------------------
>>>> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
>>>> Kernel panic: VFS: Unable to mount root fs on 00:00
>>>> ----------------------------------------------------------------------
>>>>
>>>> AND it still finds the drive as /dev/hda
>>>>
>>>> Therefore I built it as a module and put "alias scsi_hostadapter
>>>> ata_piix" in /etc/modules.conf" to atleast eliminate the
>>>> scsi_hostadapter thing
>>>>
>>>> This is FC3, and my root is actually an LVM, so i get:
>>>> NVS: Cannot open root device "VolGroup00/LogVol00" or 00:00
>>>>
>>>> So i'm thinking once the drive shows up as /dev/sda, the LVM will be
>>>> proper, and VolGroup00/LogVol00 will show up.
>>> I don't know, I'm a terrible loser when it comes to LVM unfortunately.
>>> I just hope you're right :-)
>>>
>>>> Any more ideas?
>>>>
>>>> Thanks!
>>>> George
>>> Regards,
>>> willy
>>>
>>>
>> Good suggestion on disabling IDE, it does not show up as SATA, it simply
>> doesn't show up... after some googling, it seems as though no one has
>> gotten it as SATA in 2.4:
>> http://wip.powerblogs.com/posts/1124302626.shtml
>> http://www.linuxquestions.org/questions/showthread.php?t=400521
> 
> I don't agree, I have one machine running 2.4.32 + a few patches to get it
> up to date with 2.4.33-pre as of 2006/01. And it is running quite well with
> ata_piix :
> 
> # dmesg |grep ata
> libata version 1.20 loaded.
> ata1: SATA max UDMA/133 cmd 0x24F8 ctl 0x2812 bmdma 0x24D0 irq 18
> ata2: SATA max UDMA/133 cmd 0x2800 ctl 0x2816 bmdma 0x24D8 irq 18
> ata1: dev 0 cfg 49:2f00 82:3069 83:5801 84:4003 85:3069 86:1001 87:4003 88:203f
> ata1: dev 0 ATA-6, max UDMA/100, 156301488 sectors: LBA
> ata1: dev 0 configured for UDMA/100
> ata2: SATA port has no device.
> scsi0 : ata_piix
> scsi1 : ata_piix
> 
> # grep -i piix /proc/ikconfig/config      
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_SCSI_ATA_PIIX=y
> CONFIG_I2C_PIIX4=m
> 
> So it seems like even BLK_DEV_PIIX was enabled without problem. However, as
> you can see, the ata_piix driver was slightly more recent than in 2.4.32 :
> 
> @@ -32,12 +50,13 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME       "ata_piix"
> -#define DRV_VERSION    "1.03"
> +#define DRV_VERSION    "1.05"
> 
> So I would suggest that you retry with the most recent 2.4.33-pre, it *must*
> work.
> 
>> Ok so, lets just assume we can't get SATA, and lets just try to get it
>> to boot as /dev/hda ... so now i know nothing about LVM, can anyone
>> provide me any insight on how to get this to boot with LVM?
> 
> I don't know, but let's first get SATA working. Fixing low level first
> is the only solution to progress in a diagnostic.
> 
>> So in 2.6.9, it loads VolGroup00/LogVol00 from /dev/sda5 which shows up
>> in fdisk as LVM.  How can i get this to load from /dev/hda5 instead?
>>
>> Thanks!
>> George
> 
> Regards,
> Willy
> 
> 

Okay new news... it turns out that initrd is not running before my
system is trying to mount the root partition, i have no clue why because
in my grub.conf i have initrd set to my initrd

Since my root partition is logical, which needs to be loaded with
vgscan/vgchange in initrd, and initrd is not run before it tries to
mount root... it simply can't

I've never seen this before so i'm not quite sure, maybe someone else
has seen this before?

Thanks!
George
