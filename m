Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWALEjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWALEjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWALEjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:39:05 -0500
Received: from tornado.reub.net ([202.89.145.182]:25563 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030235AbWALEjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:39:03 -0500
Message-ID: <43C5DD63.1050407@reub.net>
Date: Thu, 12 Jan 2006 17:38:59 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060110)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-acpi@vger.kernel.org
Subject: Re: 2.6.15-mm3
References: <20060111042135.24faf878.akpm@osdl.org>	<43C5D537.7020800@reub.net> <20060111203332.50c45031.akpm@osdl.org>
In-Reply-To: <20060111203332.50c45031.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2006 5:33 p.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>>
>>
>> On 12/01/2006 1:21 a.m., Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/
>>>
>>> - New config options (VMSPLIT_*) to permit non-standard user/kernel
>>>   splitting on x86.  Needs testing please.
>>>
>>> - Lots of updates to the USB, PCI, driver and I2C trees.  This is usually a
>>>   worry.
>>>
>>> - Multiblock allocation speedup for ext3.  This is only used by direct-IO at
>>>   present.
>>>
>>> - Reminder: -mm kernel commit activity can be reviewed by subscribing to the
>>>   mm-commits mailing list.
>>>
>>>   echo "subscribe mm-commits" | mail marordomo@vger.kernel.org
>>>
>>> - If you hit a bug in -mm and it's not obvious which patch caused it, it is
>>>   most valuable if you can perform a bisection search to identify which patch
>>>   introduced the bug.  Instructions for this process are at
>>>
>>> 	http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
>>>
>>>   But beware that this process takes some time (around ten rebuilds and
>>>   reboots), so consider reporting the bug first and if we cannot immediately
>>>   identify the faulty patch, then perform the bisection search.
>> I'm not sure if this is new to -mm3, but it's the first time I have seen it.
>>
>> The sequence of events leading up to this was to reboot the machine, it came up 
>> and crashed:
>>
>> Call Trace:
>>   [<c0103c5d>] show_stack+0x9b/0xc0
>>   [<c0103de4>] show_registers+0x162/0x1e7
>>   [<c0103f8f>] die+0x126/0x231
>>   [<c01140db>] do_page_fault+0x271/0x5b9
>>   [<c01037df>] error_code+0x4f/0x54
>>   [<c023cabd>] class_device_del+0xa3/0x156
>>   [<c023cb7b>] class_device_unregister+0xb/0x15
>>   [<c0255dbf>] scsi_remove_host+0xb4/0xef
>>
> 
> There's some trace missing here.  I assume it's the same ata_device_add()
> thing.

Correct.  I included it to suggest a possible link with the other ATA problems I 
am having and to show it's a separate report.

The important bit in this report was the SATA timing out - which it should not 
be doing.  There are three disks all hooked up and (most of the time) working. 
Box is locked in a cabinet so it's not like any hardware had mysteriously come 
loose or been bumped.

>> uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000d400
>> usb usb4: configuration #1 chosen from 1 choice
>> hub 4-0:1.0: USB hub found
>> hub 4-0:1.0: 2 ports detected
>> ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
>> uhci_hcd 0000:00:1d.3: UHCI Host Controller
>> uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
>> uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000d800
>> usb usb5: configuration #1 chosen from 1 choice
>> hub 5-0:1.0: USB hub found
>> hub 5-0:1.0: 2 ports detected
>> Initializing USB Mass Storage driver...
>> irq 193: nobody cared (try booting with the "irqpoll" option)
>>   [<c01041d9>] dump_stack+0x17/0x19
>>   [<c0139f47>] __report_bad_irq+0x27/0x83
>>   [<c013a021>] note_interrupt+0x7e/0x21d
>>   [<c0139af4>] __do_IRQ+0xd3/0xef
>>   [<c0105038>] do_IRQ+0x3d/0x57
>>   =======================
>>   [<c0103686>] common_interrupt+0x1a/0x20
>>   [<c0101bc4>] cpu_idle+0x63/0x78
>>   [<c0100615>] rest_init+0x23/0x2e
>>   [<c03d070f>] start_kernel+0x2ca/0x34b
>>   [<c0100210>] 0xc0100210
>> handlers:
>> [<c027017e>] (usb_hcd_irq+0x0/0x56)
>> Disabling IRQ #193
> 
> USB lost its interrupt.  Could be USB, more likely ACPI.
> 
>> md: Autodetecting RAID arrays.
>> md: autorun ...
>> md: ... autorun DONE.
>> ReiserFS: md0: warning: sh-2006: read_super_block: bread failed (dev md0, block 
>> 2, size 4096)
>> ReiserFS: md0: warning: sh-2006: read_super_block: bread failed (dev md0, block 
>> 16, size 4096)
>> EXT3-fs: unable to read superblock
>> EXT2-fs: unable to read superblock
>> isofs_fill_super: bread failed, dev=md0, iso_blknum=16, block=32
>> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(9,0)
>>
> 
> Looks like RAID0 keeled over.

md0 is the root partition, I assume because the SATA crapped out the box was 
unable to assemble the raid arrays, find root on md0 and so it panic'd.

reuben

