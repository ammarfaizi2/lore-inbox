Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUFFMT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUFFMT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 08:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbUFFMT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 08:19:56 -0400
Received: from astro.futurequest.net ([69.5.28.104]:8156 "HELO
	astro.futurequest.net") by vger.kernel.org with SMTP
	id S263389AbUFFMTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 08:19:20 -0400
From: Daniel Schmitt <pnambic@unu.nu>
To: linux-kernel@vger.kernel.org
Subject: nForce2 ACPI interrupt routing oddity (very long) (maybe related to "2.6.7-rc1 breaks forcedeth")
Date: Sun, 6 Jun 2004 14:19:32 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406061419.33085.pnambic@unu.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Beware, this is a rather long and somewhat convoluted story. I do believe
that it does point to an actual bug, though, so please bear with me...]

First a simple question on the result of all the text below: what is supposed
to break, were one to do the following (against 2.6.7-rc2)?:

--- drivers/acpi/pci_link.c.orig	2004-06-06 00:51:53.420738585 +0200
+++ drivers/acpi/pci_link.c	2004-06-06 00:52:33.336339258 +0200
@@ -536,7 +536,7 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
-	if (link->irq.setonboot)
+	if (link->irq.setonboot || !link->device->status.enabled)
 		return_VALUE(0);
 
 	/*


Why do I ask? Well, without this patch, I get to choose between these two
versions of the same problem (see below). This is on an Epox 8RDA3+, newer 
(actively cooled) revision, latest BIOS. The problem has, in minor 
variations, been present on all 2.6-series kernels I tried, but I didn't find 
the time to track it down until now.

Version 1 (ACPI on):

# /cat /proc/interrupts
           CPU0       
  0:      52720    IO-APIC-edge  timer
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       2487    IO-APIC-edge  ide0
 15:         44    IO-APIC-edge  ide1
 17:          5   IO-APIC-level  bttv0, Bt87x audio, ohci1394
 18:          0   IO-APIC-level  ICE1712
 19:        138   IO-APIC-level  eth0
 20:    5003583   IO-APIC-level  ehci_hcd, NVidia nForce2
 21:         99   IO-APIC-level  ohci_hcd
 22:        172   IO-APIC-level  ohci_hcd
NMI:          0 
LOC:      52514 
ERR:          0
MIS:          0

IRQ 20 continues to fire at >100kHz. The interrupt is not disabled due
to this beautiful 'fix' in snd_intel8x0_interrupt():

        if ((status & chip->int_sta_mask) == 0) {
                if (status) {
                        /* ack */
                        iputdword(chip, chip->int_sta_reg, status);
                        /* some Nforce[2] boards have problems when
                           IRQ_NONE is returned here.
                        */
                        if (chip->device_type != DEVICE_NFORCE)
                                status = 0;
                }
                spin_unlock(&chip->reg_lock);
                return IRQ_RETVAL(status);
        }

The system is still usable, but obviously a lot less responsive than it could
be, with a hi load of about 30%.

Here's the relevant snippet from dmesg:

ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs *17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf60, dseg 0xf0000
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
00:00:01[A] -> 2-23 -> IRQ 23 level high
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
00:00:02[A] -> 2-22 -> IRQ 22 level high
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
00:00:02[B] -> 2-21 -> IRQ 21 level high
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
00:00:02[C] -> 2-20 -> IRQ 20 level high
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCI] enabled at IRQ 21
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCK] enabled at IRQ 22
ACPI: PCI Interrupt Link [APCM] enabled at IRQ 21
ACPI: PCI Interrupt Link [AP3C] enabled at IRQ 20
ACPI: PCI Interrupt Link [APCZ] enabled at IRQ 22
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
00:01:06[A] -> 2-18 -> IRQ 18 level high
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
00:01:06[B] -> 2-19 -> IRQ 19 level high
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
00:01:06[C] -> 2-16 -> IRQ 16 level high
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
00:01:06[D] -> 2-17 -> IRQ 17 level high


Version 2: (pci=noacpi nolapic)

# /cat /proc/interrupts
           CPU0       
  0:     184520          XT-PIC  timer
  1:        819          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          5          XT-PIC  ehci_hcd
  5:          0          XT-PIC  ICE1712
  7:         14          XT-PIC  NVidia nForce2
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:     100004          XT-PIC  ohci_hcd
 11:        162          XT-PIC  ohci_hcd, eth0
 12:          5          XT-PIC  bttv0, Bt87x audio, ohci1394
 14:       2557          XT-PIC  ide0
 15:         44          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

Since the sound driver gets a separate interrupt in PIC-mode, it cannot
hide the runaway, and I end up USB-less:

ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf60, dseg 0xf0000
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
[...SNIP...]
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
irq 10: nobody cared!
 [<c010628a>] __report_bad_irq+0x2a/0x90
 [<c010637c>] note_interrupt+0x6c/0xa0
 [<c0106651>] do_IRQ+0x121/0x130
 [<c0104934>] common_interrupt+0x18/0x20
 [<c011abf0>] __do_softirq+0x30/0x80
 [<c011ac66>] do_softirq+0x26/0x30
 [<c010662d>] do_IRQ+0xfd/0x130
 [<c0104934>] common_interrupt+0x18/0x20
 [<c0106b8e>] setup_irq+0x7e/0xf0
 [<f8b9d2e0>] usb_hcd_irq+0x0/0x70 [usbcore]
 [<c0106723>] request_irq+0x83/0xd0
 [<f8ba14d3>] usb_hcd_pci_probe+0x1f3/0x4e0 [usbcore]
 [<f8b9d2e0>] usb_hcd_irq+0x0/0x70 [usbcore]
 [<c01e40c2>] pci_device_probe_static+0x52/0x70
 [<c01e411b>] __pci_device_probe+0x3b/0x50
 [<c01e415c>] pci_device_probe+0x2c/0x50
 [<c022e74f>] bus_match+0x3f/0x70
 [<c022e879>] driver_attach+0x59/0x90
 [<c022eb21>] bus_add_driver+0x91/0xb0
 [<c022efdf>] driver_register+0x2f/0x40
 [<c01177bd>] printk+0x10d/0x170
 [<c01e43dc>] pci_register_driver+0x5c/0x90
 [<f8b7a05b>] ohci_hcd_pci_init+0x5b/0x68 [ohci_hcd]
 [<c012cbd8>] sys_init_module+0xf8/0x210
 [<c0103f75>] sysenter_past_esp+0x52/0x71

handlers:
[<f8b9d2e0>] (usb_hcd_irq+0x0/0x70 [usbcore])
Disabling IRQ #10

In contrast, with the above patch, things look a lot better:

# /cat /proc/interrupts
           CPU0       
  0:      85011    IO-APIC-edge  timer
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       2522    IO-APIC-edge  ide0
 15:         44    IO-APIC-edge  ide1
 17:          5   IO-APIC-level  bttv0, Bt87x audio, ohci1394
 18:          0   IO-APIC-level  ICE1712
 19:        144   IO-APIC-level  eth0
 20:          5   IO-APIC-level  ehci_hcd
 21:         89   IO-APIC-level  ohci_hcd
 22:        244   IO-APIC-level  ohci_hcd, NVidia nForce2
NMI:          0 
LOC:      84706 
ERR:          0
MIS:          0

ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs *17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf60, dseg 0xf0000
PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver
00:00:01[A] -> 2-23 -> IRQ 23 level high
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
00:00:02[A] -> 2-22 -> IRQ 22 level high
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
00:00:02[B] -> 2-21 -> IRQ 21 level high
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
00:00:02[C] -> 2-20 -> IRQ 20 level high
ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 22
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
00:01:06[A] -> 2-18 -> IRQ 18 level high
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
00:01:06[B] -> 2-19 -> IRQ 19 level high
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
00:01:06[C] -> 2-16 -> IRQ 16 level high
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
00:01:06[D] -> 2-17 -> IRQ 17 level high

Some experiments with the DSDT show that the culprit is the PCI Interrupt
link AP3C, which seems to be supposed to live on a hub of its own that does
not show up anywhere in the boot sequence. I'm more than hazy on the actual
hardware issues involved, though. Here are the DSDT excerpts for \_SB context
devices with a _PRT.

        Device (PCI0)
        /* (ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]) */
        {
            Name (_HID, EisaId ("PNP0A03")) 
            Name (_ADR, 0x00)
            Name (_UID, 0x01)
            Name (_BBN, 0x00)

[...SNIP...]

            Device (HUB0)
            /* (ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT] */
            {
                Name (_ADR, 0x00080000)
                Method (_STA, 0, NotSerialized)

[... 'normal' link tables etc., including ...]

                Package (0x04){ 0x000CFFFF, 0x00, \_SB.PCI0.AP3C, 0x00 },
            }

[...SNIP...]

            Device (AGPB)
            {
                Name (_ADR, 0x001E0000)

[... more 'normal' link tables etc. ...]

            }

            Device (HUB1)
            /* (no ACPI message on boot!) */
            {
                Name (_ADR, 0x000C0000)
                Name (APIC, Package (0x04)
                {
                    Package (0x04) { 0x0001FFFF, 0x00, \_SB.PCI0.AP3C, 0x00 },
                    Package (0x04) { 0x0001FFFF, 0x01, \_SB.PCI0.AP3C, 0x00 },
                    Package (0x04) { 0x0001FFFF, 0x02, \_SB.PCI0.AP3C, 0x00 },
                    Package (0x04) { 0x0001FFFF, 0x03, \_SB.PCI0.AP3C, 0x00 }
                })
                Method (_PRT, 0, NotSerialized)
                {
                    If (LNot (PICF))
                    {
                        Return (PICM)
                    }
                    Else
                    {
                        Return (APIC)
                    }
                }
[... much later, the definition ...]

            Device (AP3C)
            {
                Name (_HID, EisaId ("PNP0C0F"))
                Name (_UID, 0x20)
                Method (_STA, 0, NotSerialized)
                {
                    If (INTS)
                    {
                        Return (0x0B)
                    }
                    Else
                    {
                        Return (0x09)
                    }
                }

                Method (_PRS, 0, NotSerialized)
                {
                    Return (BUFF)
                }

                Method (_DIS, 0, NotSerialized)
                {
                    Store (0x00, INTS)
                }

                Method (_CRS, 0, NotSerialized)
                {
                    Return (CRSA (INTS))
                }

                Method (_SRS, 1, NotSerialized)
                {
                    Store (SRSA (Arg0), INTS)
                }
            }


I verified that breaking AP3C's _SRS method 'fixes' the problem as well,
at the expense of some unsightly error messages.

Unfortunately, I have no more than a passing clue on ACPI, APICs, or the
structure of the actual hardware involved in this. However, the results of
the analysis above do work for me. I'd very much appreciate a hint from
somebody who actually understands this stuff. If you need different pieces
of information or want me to test stuff, just let me know.

Thanks for reading this far,

Daniel.
