Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVCDRU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVCDRU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 12:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVCDRR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 12:17:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:56517 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262938AbVCDRRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 12:17:09 -0500
Message-ID: <42289812.9020009@suse.de>
Date: Fri, 04 Mar 2005 18:17:06 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org, hare@suse.de,
       pavel@suse.cz
Subject: Re: swsusp: allow resume from initramfs
References: <20050304101631.GA1824@elf.ucw.cz> <20050304030410.3bc5d4dc.akpm@osdl.org>
In-Reply-To: <20050304030410.3bc5d4dc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> I don't understand how this can be affected by the modularness of the
> kernel.  Can you explain a little more?

normally, resume takes place _before_ the initramfs is entered. If your
swap device depends on a module that is loaded from initramfs, you are lost.

This patch (or the version in the kernel i am running right now at
least) still does this (resume early), but if it does not find a device,
it allows resume to be triggered from initramfs after the module is loaded.

Excerpt from dmesg on my machine (i did boot and not resume this time):
[...]
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
PM: Checking swsusp image.
PM: Resume from disk failed.
ACPI wakeup devices:
 LID PBTN PCI0 USB0 USB1 USB2 USB3 MODM PCIE
ACPI: (supports S0 S1 S3 S4 S4bios S5)
Freeing unused kernel memory: 204k freed
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N060ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD-ROM GCC-4243N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
ide-floppy driver 0.99.newide
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Attempting manual resume
PM: Checking swsusp image.
swsusp: Suspend partition has wrong signature?
PM: Resume from disk failed.
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode

unfortunately the errors did not get caught by dmesg, but the first
error is -6 (no such device), later it is -22 (-EINVAL, no valid suspend
signature). This is in fact ok since i did not suspend before ;-)

Hope this helps (and the patch is working fine in my extended tests, it
could get some documentation on how to set it up since it is not totally
trivial. Hannes?).

   Stefan

