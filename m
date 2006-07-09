Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWGIRa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWGIRa2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWGIRa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:30:28 -0400
Received: from xenotime.net ([66.160.160.81]:34981 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751332AbWGIRa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:30:27 -0400
Date: Sun, 9 Jul 2006 10:33:12 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Reuben Farrelly <reuben-lkml@reub.net>, mingo@redhat.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       linux-acpi@vger.kernel.org, greg@kroah.com
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060709103312.5f78ad38.rdunlap@xenotime.net>
In-Reply-To: <44B0E6E6.6070904@reub.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<44B0E6E6.6070904@reub.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jul 2006 23:22:14 +1200 Reuben Farrelly wrote:

> On 9/07/2006 9:11 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> > 
> > - We're getting a relatively large number of crash reports coming out of the
> >   core sysfs/kobject/driver/bus code, and they're all really hard to diagnose.
> > 
> >   I am suspecting that what's happening is that some registration functions
> >   are failing and the caller is ignoring that failure.  The code proceeds and
> >   crashes much later, in obscure ways.
> > 
> >   All these functions return error codes, and we're not checking them.  We
> >   should.  So there's a patch which marks all these things as __must_check,
> >   which causes around 1,500 new warnings.
> > 
> >   These are all bugs and they all need to be fixed.
> 
> Works.  Well, it boots without crashing here and has been up for 30 or so 
> minutes without incident or so much as a log entry.
> 
> I assume that the bulk of those warnings about the return error codes will be 
> largely dealt with by individual maintainers as there are far too many to post here?

Yeah, right.  (quoting Kathy Mallory with her usual sarcasm)


> Some minor problems noted - possibly PCI/ACPI related (read on past the IDE bit 
> if that's not your cup of tea).
> 
> 2. Onto some more minor warnings:
> 
> ACPI: bus type pci registered
> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> PCI: Not using MMCONFIG.
> PCI: Using configuration type 1
> ACPI: Interpreter enabled
> 
> Is there any way to verify that there really is a BIOS bug there?  If it is, is 
> there anyone within Intel or are there any known contacts who can push and poke 
> to get this looked at/fixed?  (It's a new Intel board, I'd hope they could get 
> it right..).
> 
> Plus we're not using MMCONFIG - even though I have it enabled.
> 
> Based on previous postings to lkml, I believe Randy Dunlap may have one of these 
> boards too - Randy are you seeing this and the next bunch of warnings I am seeing?

I just found 2.6.18-rc1-mm1.  I'll build + check.
I have an Intel ICH7 motherboard with SATA.
Is that close to what you have?


> 3. Power Management warnings, been there ages, but I've had bigger things to 
> worry about (like fatal oopses) so haven't bothered asking:
> 
> Device `[PEX0]' is not power manageable
> ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:00:1c.0 to 64
> Device `[PEX2]' is not power manageable
> ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
> PCI: Setting latency timer of device 0000:00:1c.2 to 64
> Device `[PEX3]' is not power manageable
> ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:1c.3 to 64
> Device `[PEX4]' is not power manageable
> ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
> PCI: Setting latency timer of device 0000:00:1c.4 to 64
> Device `[PEX5]' is not power manageable
> ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
> 
> and
> 
> Device `[IDES]' is not power manageable

I guess that's from here:

/sys/firmware/acpi/namespace/ACPI/_SB/PCI0/IDES

which contains 2 directories:  PRID and SECD.
Apparently ATA/IDE primary and secondary controllers,
but I'm not sure.  Those empty directory structures
don't tell me much.


> [root@tornado ~]# cat /proc/interrupts
>             CPU0       CPU1
>    0:     258266          0   IO-APIC-edge     timer
>    4:        355          0   IO-APIC-edge     serial
>    6:          5          0   IO-APIC-edge     floppy
>    8:          1          0   IO-APIC-edge     rtc
>    9:          0          0   IO-APIC-fasteoi  acpi
>   14:         28          0   IO-APIC-edge     libata
>   15:          0          0   IO-APIC-edge     libata
>   16:          0          0   IO-APIC-fasteoi  uhci_hcd:usb5
>   18:          0          0   IO-APIC-fasteoi  uhci_hcd:usb4
>   19:        980          0   IO-APIC-fasteoi  uhci_hcd:usb3, serial
>   23:        105          0   IO-APIC-fasteoi  ehci_hcd:usb1, uhci_hcd:usb2
> 313:      82513          0   PCI-MSI-<NULL>  eth0
> 314:      57370          0   PCI-MSI-<NULL>  libata

"We" need to fix that <NULL> there.

> NMI:        217        188
> LOC:     258118     257890
> ERR:          0
> MIS:          0
> [root@tornado ~]#
> 
> The full dmesg is up at http://www.reub.net/files/kernel/2.6.18-rc1-mm1.dmesg 
> and config is up at http://www.reub.net/files/kernel/2.6.18-rc1-mm1.config

---
~Randy
