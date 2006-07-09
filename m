Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWGILWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWGILWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWGILWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:22:16 -0400
Received: from tornado.reub.net ([202.89.145.182]:63725 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030252AbWGILWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:22:15 -0400
Message-ID: <44B0E6E6.6070904@reub.net>
Date: Sun, 09 Jul 2006 23:22:14 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060708)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-acpi@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.18-rc1-mm1
References: <20060709021106.9310d4d1.akpm@osdl.org>
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/07/2006 9:11 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> 
> - We're getting a relatively large number of crash reports coming out of the
>   core sysfs/kobject/driver/bus code, and they're all really hard to diagnose.
> 
>   I am suspecting that what's happening is that some registration functions
>   are failing and the caller is ignoring that failure.  The code proceeds and
>   crashes much later, in obscure ways.
> 
>   All these functions return error codes, and we're not checking them.  We
>   should.  So there's a patch which marks all these things as __must_check,
>   which causes around 1,500 new warnings.
> 
>   These are all bugs and they all need to be fixed.

Works.  Well, it boots without crashing here and has been up for 30 or so 
minutes without incident or so much as a log entry.

I assume that the bulk of those warnings about the return error codes will be 
largely dealt with by individual maintainers as there are far too many to post here?

Some minor problems noted - possibly PCI/ACPI related (read on past the IDE bit 
if that's not your cup of tea).

1. I've disabled the old IDE stuff and enabled Alan's IDE support 
(CONFIG_SCSI_ATA_GENERIC=y).  But it seems to be a bit unhappy with my IDE CD 
burner:

ata_piix 0000:00:1f.1: version 2.00ac5
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30B0 irq 14
scsi4 : ata_piix
ata5.00: ATAPI, max UDMA/66
ata5.00: configured for UDMA/66
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
Losing some ticks... checking if CPU frequency changed.
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: limiting speed to UDMA/44
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x30B8 irq 15
scsi5 : ata_piix
ata6: port disabled. ignoring.
ATA: abnormal status 0xFF on port 0x177
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

Note also the message midway through about losing some ticks, which if I recall 
correctly is not new to this -mm release.  I'm not sure who to cc about this.

The IDE device obviously ended up not being detected by the system.  Usually 
this device comes up as:

Jul  2 12:03:28 tornado kernel: hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 
2000kB Cache, UDMA(66)


2. Onto some more minor warnings:

ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled

Is there any way to verify that there really is a BIOS bug there?  If it is, is 
there anyone within Intel or are there any known contacts who can push and poke 
to get this looked at/fixed?  (It's a new Intel board, I'd hope they could get 
it right..).

Plus we're not using MMCONFIG - even though I have it enabled.

Based on previous postings to lkml, I believe Randy Dunlap may have one of these 
boards too - Randy are you seeing this and the next bunch of warnings I am seeing?

3. Power Management warnings, been there ages, but I've had bigger things to 
worry about (like fatal oopses) so haven't bothered asking:

Device `[PEX0]' is not power manageable
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
Device `[PEX2]' is not power manageable
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
Device `[PEX3]' is not power manageable
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
Device `[PEX4]' is not power manageable
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.4 to 64
Device `[PEX5]' is not power manageable
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16

and

Device `[IDES]' is not power manageable

[root@tornado ~]# cat /proc/interrupts
            CPU0       CPU1
   0:     258266          0   IO-APIC-edge     timer
   4:        355          0   IO-APIC-edge     serial
   6:          5          0   IO-APIC-edge     floppy
   8:          1          0   IO-APIC-edge     rtc
   9:          0          0   IO-APIC-fasteoi  acpi
  14:         28          0   IO-APIC-edge     libata
  15:          0          0   IO-APIC-edge     libata
  16:          0          0   IO-APIC-fasteoi  uhci_hcd:usb5
  18:          0          0   IO-APIC-fasteoi  uhci_hcd:usb4
  19:        980          0   IO-APIC-fasteoi  uhci_hcd:usb3, serial
  23:        105          0   IO-APIC-fasteoi  ehci_hcd:usb1, uhci_hcd:usb2
313:      82513          0   PCI-MSI-<NULL>  eth0
314:      57370          0   PCI-MSI-<NULL>  libata
NMI:        217        188
LOC:     258118     257890
ERR:          0
MIS:          0
[root@tornado ~]#

The full dmesg is up at http://www.reub.net/files/kernel/2.6.18-rc1-mm1.dmesg 
and config is up at http://www.reub.net/files/kernel/2.6.18-rc1-mm1.config

Minor issues and possibly most if not all are not of concern, but occasionally 
supposedly minor things show up much bigger problems when questions are asked 
and people start poking around :)

Reuben




