Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUCYOYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 09:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUCYOYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 09:24:25 -0500
Received: from linux-bt.org ([217.160.111.169]:46766 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263154AbUCYOYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 09:24:17 -0500
Subject: Re: ACPI problem with latest 2.6 snapshot
From: Marcel Holtmann <marcel@holtmann.org>
To: Len Brown <len.brown@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1080187915.21259.354.camel@dhcppc4>
References: <1080136312.2309.9.camel@pegasus>
	 <1080187915.21259.354.camel@dhcppc4>
Content-Type: text/plain
Message-Id: <1080224640.2274.7.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 25 Mar 2004 15:24:01 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

> I expect we'll have this problem in 2.4.26 too.

this will be bad, because before the update this works fine on my
system.

> I've dropped this info into a new bug report:
> http://bugzilla.kernel.org/show_bug.cgi?id=2366
> 
> can you add yourself to the cc:, and attach the complete dmesg -s40000
> from the failure (or a "debug" console capture).  Would like to confirm
> that IRQ22 got set up correctly in the IOAPIC.
> 
> There are two bugs here,
> 1. AE_NOT_ACQUIRED on non-identity mapped SCI over-ride -- new
> 2. boot failure on AE_NOT_ACQUIRED -- old

I applied your two patches from the bug report (btw one of them has a
wrong directory in the diff) and the systems boots up in a better state,
which means that a least my USB subsystem is now working. But the
network is still broken and I disabled the SCSI and the IEEE1394 drivers
for now. However I see these two oops along

ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:02:0c.0: OHCI Host Controller
ohci_hcd 0000:02:0c.0: irq 20, pci mem e12a5000
ohci_hcd 0000:02:0c.0: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
ohci_hcd 0000:02:0c.1: OHCI Host Controller
ohci_hcd 0000:02:0c.1: irq 21, pci mem e12b4000
ohci_hcd 0000:02:0c.1: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
irq 21: nobody cared!
Call Trace:
 [<c0108e32>] __report_bad_irq+0x2a/0x8b
 [<c0108f1c>] note_interrupt+0x6f/0x9f
 [<c01091de>] do_IRQ+0x127/0x136
 [<c01076ac>] common_interrupt+0x18/0x20

handlers:
[<e12858a3>] (usb_hcd_irq+0x0/0x67 [usbcore])
Disabling IRQ #21
usb 3-2: new full speed USB device using address 2

and

Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:0e.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:02:0e.0 [133f:3000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0000, PCI irq 18
Socket status: 10000047
irq 22: nobody cared!
Call Trace:
 [<c0108e32>] __report_bad_irq+0x2a/0x8b
 [<c0108f1c>] note_interrupt+0x6f/0x9f
 [<c01091de>] do_IRQ+0x127/0x136
 [<c01076ac>] common_interrupt+0x18/0x20
 [<c011007b>] mtrr_ioctl+0x253/0x6a7
 [<c0104b91>] default_idle+0x23/0x26
 [<c0104bef>] cpu_idle+0x2c/0x35
 [<c02f46f2>] start_kernel+0x16b/0x188
 [<c02f444b>] unknown_bootoption+0x0/0x110

handlers:
[<c01b8c63>] (acpi_irq+0x0/0x16)
Disabling IRQ #22

Actually I am not able to get the full dmesg so here are the initial
parts that are ACPI related

ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2017.0707 MHz.
..... host bus clock speed is 100.0885 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf11f0, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040311
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 *6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Enabled i801 SMBus device
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:1f[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xb1 -> IRQ 23 Mode:1 Active:1)
00:00:1f[C] -> 2-23 -> IRQ 23
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:1f[D] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:01:00[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:02:09[A] -> 2-21 -> IRQ 21
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:02:09[D] -> 2-20 -> IRQ 20
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xd9 -> IRQ 18 Mode:1 Active:1)
00:02:0e[A] -> 2-18 -> IRQ 18
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... register #03: 00000001
.......     : Boot DT    : 1
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  0    0    0   0   0    1    1    71
 0b 001 01  0    0    0   0   0    1    1    79
 0c 001 01  0    0    0   0   0    1    1    81
 0d 001 01  0    0    0   0   0    1    1    89
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 001 01  1    1    0   1   0    1    1    C1
 11 001 01  1    1    0   1   0    1    1    A9
 12 001 01  1    1    0   1   0    1    1    D9
 13 001 01  1    1    0   1   0    1    1    B9
 14 001 01  1    1    0   1   0    1    1    D1
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  0    1    0   1   0    1    1    A1
 17 001 01  1    1    0   1   0    1    1    B1
IRQ to pin mappings:
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'

Regards

Marcel


