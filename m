Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752279AbWKFS52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbWKFS52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbWKFS52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:57:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752259AbWKFS51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:57:27 -0500
Date: Mon, 6 Nov 2006 10:56:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Remi <remi.colinet@free.fr>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.19-rc4-mm2: ahci: probe of 0000:00:1f.2 failed with error
 -16
Message-Id: <20061106105619.5241689e.akpm@osdl.org>
In-Reply-To: <1162808396.454f0c4c760d1@imp4-g19.free.fr>
References: <1162764770.454e61e2db5ff@imp3-g19.free.fr>
	<20061105161941.ec64ae70.akpm@osdl.org>
	<1162808396.454f0c4c760d1@imp4-g19.free.fr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2006 11:19:56 +0100
Remi <remi.colinet@free.fr> wrote:

> > > I have caught the full 2.6.19-rc4-mm2 boot messages over a serial cable if
> > it
> > > can help.
> > >
> >
> > Do you have CONFIG_USB_MULTITHREAD_PROBE=y?  If so, try =n.
> >
> 
> # CONFIG_USB_MULTITHREAD_PROBE is not set
> 
> > Yes please send the full dmesg for both -rc4 and for -rc4-mm2, thanks.
> >
> 
> First dmesg is for 2.6.19-rc4. No problem noticed.

Thanks.  I put the dmesg-diff up at http://userweb.kernel.org/~akpm/3.txt. 
That's 2.6.19-rc4 -> 2.6.19-rc4-mm2.

The relevant bits are here:

 libata version 2.00 loaded.
 ahci 0000:00:1f.2: version 2.0
 ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
-ACPI: PCI interrupt for device 0000:00:1f.2 disabled
-ahci: probe of 0000:00:1f.2 failed with error -12
-ata_piix 0000:00:1f.2: version 2.00ac6
+PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
+ahci: probe of 0000:00:1f.2 failed with error -16
+ata_piix 0000:00:1f.2: version 2.00ac7

 So previously ahci failed with -ENOMEM and in -mm2 it failed with EBUSY. 
 because in -mm2 AHCI wasn't able to reserve an IO region.  I don't know
 why this changed.

 And there's no indication what it it conflicting _with_.  Perhaps piix,
 but piix doesn't appear to have started up yet.

 Greg, perhaps when we get a resource reservation conflict we should print
 what it's conflicting _with_?  Optionally, at least - via a kernel boot
 parameter.

 ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
-PCI: Enabling device 0000:00:1f.2 (0000 -> 0001)
-ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 18
-ata: 0x170 IDE port busy
-ata: conflict with ide1
-PCI: Setting latency timer of device 0000:00:1f.2 to 64
-ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xBFA0 irq 14
-ata2: DUMMY
-scsi0 : ata_piix
-PM: Adding info for No Bus:host0
-ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
-ata1.00: ata1: dev 0 multi count 8
-ata1.00: applying bridge limits
-ata1.00: configured for UDMA/100
-scsi1 : ata_piix

 So in -rc4 ata-piix was kinda-happy, although that "conflict with ide1"
 is a bit ugly.

 What is this warning telling us?

-PM: Adding info for No Bus:host1
-PM: Adding info for No Bus:target0:0:0
-scsi 0:0:0:0: Direct-Access     ATA      HTS726060M9AT00  MH4O PQ: 0 ANSI: 5
-PM: Adding info for scsi:0:0:0:0
-SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
-sda: Write Protect is off
-sda: Mode Sense: 00 3a 00 00
-SCSI device sda: drive cache: write back
-SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
-sda: Write Protect is off
-sda: Mode Sense: 00 3a 00 00
-SCSI device sda: drive cache: write back
- sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
-sd 0:0:0:0: Attached scsi disk sda

 <irrelevant stuff snipped>

-kjournald starting.  Commit interval 5 seconds
-EXT3 FS on sda9, internal journal
-EXT3-fs: mounted filesystem with ordered data mode.
+PCI: Unable to reserve I/O region #1:8@1f0 for device 0000:00:1f.2
+ata_piix: probe of 0000:00:1f.2 failed with error -16
+Kernel panic - not syncing: Attempted to kill init!

 And here piix failed because it cannot grab the IO regions.

I dunno.

It _looks_ like one of the various IDE/PATA/SATA drivers is getting in the
way of another one.  But why is this happening in rc4-mm2 and not in -rc4?

I'd suggest that you experiment with the .config: disable ahci for a start.
 Also try disabling the IDE driver.  Maybe try disabling CONFIG_PATA_MPIIX
too.

