Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265676AbUFSMj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbUFSMj3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 08:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUFSMj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 08:39:29 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56561 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265676AbUFSMjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 08:39:24 -0400
Date: Sat, 19 Jun 2004 14:39:06 +0200 (MEST)
Message-Id: <200406191239.i5JCd6oX028139@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de, peter@cordes.ca
Subject: Re: x86-64: double timer interrupts in recent 2.4.x
Cc: discuss@x86-64.org, len.brown@intel.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 04:41:32 -0300, Peter Cordes wrote:
>On Thu, Jun 17, 2004 at 12:26:45PM +0200, Andi Kleen wrote:
>> On Thu, 17 Jun 2004 10:54:00 +0200 (MEST)
>> Mikael Pettersson <mikpe@csd.uu.se> wrote:
>>
>> > On Wed, 16 Jun 2004 16:28:26 -0300, Peter Cordes wrote:
>> > > I just noticed that on my Opteron cluster, the nodes that are running
> 64bit
>> > >kernels have their clocks ticking at double speed.  This happens with
>> > >Linux 2.4.26, and 2.4.27-pre2
>> >
>> > I had the same problem: 2.4 x86-64 kernels ticking the clock
>> > twice its normal speed, unless I booted with pci=noacpi.
>> >
>> > This got fixed very recently I believe, in a 2.4.27-pre kernel.
>>
>> In which one exactly? Most likely it was an ACPI problem/fix.
>> Len, do you remember fixing such an issue?
>
> It's fixed in 2.4.27-pre3 and later.

Confirmed: pre2 has the bug, pre3 and later do not.

For reference, here's how pre2 and pre3 dmesg outputs
differ on my K8 (MSI K8T Neo-FIS2R). There are several
changes related to IRQ0.

--- dmesg-2.4.27-pre2	2004-06-19 13:56:57.000000000 +0200
+++ dmesg-2.4.27-pre3	2004-06-19 13:59:14.000000000 +0200
@@ -30,7 +30,6 @@
 ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT 0x00000097) @ 0x000000003fff0030
 ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT 0x00000097) @ 0x000000003fff00c0
 ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT 0x0100000d) @ 0x0000000000000000
-ACPI: Parsing Local APIC info in MADT
 ACPI: Local APIC address 0xfee00000
 ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
 Processor #0 15:4 APIC version 16
@@ -39,6 +38,9 @@
 IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
 ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
+ACPI: IRQ0 used by override.
+ACPI: IRQ2 used by override.
+ACPI: IRQ9 used by override.
 Using ACPI (MADT) for SMP configuration information
 Kernel command line: BOOT_IMAGE=bzimage apic
 Initializing CPU#0
@@ -59,8 +61,8 @@
 testing NMI watchdog ... OK.
 ENABLING IO-APIC IRQs
 init IO_APIC IRQs
- IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
-..TIMER: vector=0x31 pin1=0 pin2=-1
+ IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
+..TIMER: vector=0x31 pin1=2 pin2=-1
 Using local APIC timer interrupts.
 Detected 12.500 MHz APIC timer.
 cpu: 0, clocks: 2000140, slice: 1000070
@@ -80,31 +82,23 @@
 ACPI: Power Resource [LPTP] (off)
 ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
 ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
-ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15)
+ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
 ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
-ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15)
-ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15)
-ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15)
-ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15)
+ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
+ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
+ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
+ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
 PCI: Using configuration type 1
 PCI: Probing PCI hardware
-IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
-00:00:01[A] -> 2-16 -> vector 0xa9 -> IRQ 16
-IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
-00:00:01[B] -> 2-17 -> vector 0xb1 -> IRQ 17
-IOAPIC[0]: Set PCI routing entry (2-20 -> 0xb9 -> IRQ 20 Mode:1 Active:1)
-00:00:11[A] -> 2-20 -> vector 0xb9 -> IRQ 20
-IOAPIC[0]: Set PCI routing entry (2-22 -> 0xc1 -> IRQ 22 Mode:1 Active:1)
-00:00:11[C] -> 2-22 -> vector 0xc1 -> IRQ 22
-IOAPIC[0]: Set PCI routing entry (2-18 -> 0xc9 -> IRQ 18 Mode:1 Active:1)
-00:00:05[C] -> 2-18 -> vector 0xc9 -> IRQ 18
-IOAPIC[0]: Set PCI routing entry (2-19 -> 0xd1 -> IRQ 19 Mode:1 Active:1)
-00:00:05[D] -> 2-19 -> vector 0xd1 -> IRQ 19
-IOAPIC[0]: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1 Active:1)
-00:00:10[A] -> 2-21 -> vector 0xd9 -> IRQ 21
-IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
-00:00:12[A] -> 2-23 -> vector 0xe1 -> IRQ 23
-number of MP IRQ sources: 16.
+00:00:01[A] -> 2-16 -> vector 0xa9 -> IRQ 16 level low
+00:00:01[B] -> 2-17 -> vector 0xb1 -> IRQ 17 level low
+00:00:11[A] -> 2-20 -> vector 0xb9 -> IRQ 20 level low
+00:00:11[C] -> 2-22 -> vector 0xc1 -> IRQ 22 level low
+00:00:05[C] -> 2-18 -> vector 0xc9 -> IRQ 18 level low
+00:00:05[D] -> 2-19 -> vector 0xd1 -> IRQ 19 level low
+00:00:10[A] -> 2-21 -> vector 0xd9 -> IRQ 21 level low
+00:00:12[A] -> 2-23 -> vector 0xe1 -> IRQ 23 level low
+number of MP IRQ sources: 15.
 number of IO-APIC #2 registers: 24.
 testing the IO APIC.......................
 
@@ -117,7 +111,7 @@
 .......     : IO APIC version: 0003
 .... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
- 00 001 01  0    0    0   0   0    1    1    31
+ 00 000 00  1    0    0   0   0    0    0    00
  01 001 01  0    0    0   0   0    1    1    39
  02 001 01  0    0    0   0   0    1    1    31
  03 001 01  0    0    0   0   0    1    1    41
@@ -142,7 +136,7 @@
  16 001 01  1    1    0   1   0    1    1    C1
  17 001 01  1    1    0   1   0    1    1    E1
 IRQ to pin mappings:
-IRQ0 -> 0:0-> 0:2
+IRQ0 -> 0:2
 IRQ1 -> 0:1
 IRQ3 -> 0:3
 IRQ4 -> 0:4
