Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbTAUQI7>; Tue, 21 Jan 2003 11:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbTAUQI7>; Tue, 21 Jan 2003 11:08:59 -0500
Received: from ns0.cobite.com ([208.222.80.10]:57103 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S267121AbTAUQIv>;
	Tue, 21 Jan 2003 11:08:51 -0500
Date: Tue, 21 Jan 2003 11:17:58 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: linux-kernel@vger.kernel.org
Subject: ACPI munges IRQ routing in 2.5.58 on HP3000 U3 (fwd)
Message-ID: <Pine.LNX.4.44.0301211117120.8393-102000@admin>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-556791216-907801398-1043165611=:8393"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---556791216-907801398-1043165611=:8393
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII


Hi Andrew, lists,

(2.5.59 has the same problem, I've just tested)

After extensive help from Justin Gibbs (the aic7xxx driver maintainer) 
I've determined that the reason the SCSI subsystem fails in 2.5.58 is that 
the IRQ routing setup by ACPI is wrong.  Quoting Justin after sending him 
verbose debugging from his driver:

<quote>
The output has confirmed what I had suspected.  The card is not
getting interrupts.  My guess is that some change in the interrupt
routine code in 2.5.X is not working correctly on your system.  To
completely verify that, you could try dropping in 6.2.27 into a
2.4.20aa2 kernel.
[snip]  You might also try to influence interrupt routing in your
system by playing around with the "apic" and "acpi" kernel options.
</quote>

I didn't try 2.4, but *did* try booting with pci=noacpi which solved the 
problem for me.

I've attached the bootup log with and without the pci=noacpi option
(gzipped) so you can see the differences.

Here's the relevant 'diff' of the two files:

--- tarsierx-bootlog.txt	2003-01-16 16:02:10.000000000 -0500
+++ tarsierx-bootlog-noacpi.txt	2003-01-20 16:53:27.000000000 -0500
@@ -47,10 +47,10 @@
 ACPI: INT_SRC_OVR (bus[0] irq[0xb] global_irq[0xb] polarity[0x3] trigger[0x3])
 Using ACPI (MADT) for SMP configuration information
 Building zonelist for node : 0
-Kernel command line: ro root=/dev/md2 console=ttyS0,9600n8
+Kernel command line: ro root=/dev/md2 pci=noacpi
 Initializing CPU#0
 PID hash table entries: 4096 (order 12: 32768 bytes)
-Detected 866.414 MHz processor.
+Detected 866.689 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 1712.12 BogoMIPS
 Memory: 2071476k/2097088k available (2368k kernel code, 24480k reserved, 718k data, 320k init, 1179584k highmem)
@@ -62,6 +62,7 @@
 -> /root
 CPU: L1 I cache: 16K, L1 D cache: 16K
 CPU: L2 cache: 256K
+CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#0.
 Enabling fast FPU save and restore... done.
@@ -79,25 +80,105 @@
 masked ExtINT on CPU#1
 ESR value before enabling vector: 00000000
 ESR value after enabling vector: 00000000
-Calibrating delay loop... 1728.51 BogoMIPS
+Calibrating delay loop... 1732.60 BogoMIPS
 CPU: L1 I cache: 16K, L1 D cache: 16K
 CPU: L2 cache: 256K
+CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
 Intel machine check architecture supported.
 Intel machine check reporting enabled on CPU#1.
 CPU1: Intel Pentium III (Coppermine) stepping 06
-Total of 2 processors activated (3440.64 BogoMIPS).
+Total of 2 processors activated (3444.73 BogoMIPS).
 ENABLING IO-APIC IRQs
+init IO_APIC IRQs
+ IO-APIC (apicid-pin) 2-0, 2-2, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15 not connected.
 ..TIMER: vector=0x31 pin1=-1 pin2=0
 ...trying to set up timer (IRQ0) through the 8259A ... 
 ..... (found pin 0) ...works.
+number of MP IRQ sources: 15.
+number of IO-APIC #2 registers: 16.
+number of IO-APIC #3 registers: 16.
 testing the IO APIC.......................
 
+IO APIC #2......
+.... register #00: 02000000
+.......    : physical APIC id: 02
+.......    : Delivery Type: 0
+.......    : LTS          : 0
+.... register #01: 000F0011
+.......     : max redirection entries: 000F
+.......     : PRQ implemented: 0
+.......     : IO APIC version: 0011
+.... register #02: 00000000
+.......     : arbitration: 00
+.... IRQ redirection table:
+ NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
+ 00 001 01  0    0    0   0   0    1    1    31
+ 01 001 01  0    0    0   0   0    1    1    39
+ 02 000 00  1    0    0   0   0    0    0    00
+ 03 001 01  0    0    0   0   0    1    1    41
+ 04 001 01  0    0    0   0   0    1    1    49
+ 05 001 01  1    1    0   1   0    1    1    51
+ 06 001 01  0    0    0   0   0    1    1    59
+ 07 001 01  0    0    0   0   0    1    1    61
+ 08 001 01  0    0    0   0   0    1    1    69
+ 09 001 01  1    1    0   1   0    1    1    71
+ 0a 001 01  1    1    0   1   0    1    1    79
+ 0b 001 01  1    1    0   1   0    1    1    81
+ 0c 001 01  0    0    0   0   0    1    1    89
+ 0d 001 01  0    0    0   0   0    1    1    91
+ 0e 001 01  0    0    0   0   0    1    1    99
+ 0f 001 01  0    0    0   0   0    1    1    A1
 
+IO APIC #3......
+.... register #00: 03000000
+.......    : physical APIC id: 03
+.......    : Delivery Type: 0
+.......    : LTS          : 0
+.... register #01: 000F0011
+.......     : max redirection entries: 000F
+.......     : PRQ implemented: 0
+.......     : IO APIC version: 0011
+.... register #02: 0F000000
+.......     : arbitration: 0F
+.... IRQ redirection table:
+ NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
+ 00 000 00  1    0    0   0   0    0    0    00
+ 01 000 00  1    0    0   0   0    0    0    00
+ 02 000 00  1    0    0   0   0    0    0    00
+ 03 000 00  1    0    0   0   0    0    0    00
+ 04 000 00  1    0    0   0   0    0    0    00
+ 05 000 00  1    0    0   0   0    0    0    00
+ 06 000 00  1    0    0   0   0    0    0    00
+ 07 000 00  1    0    0   0   0    0    0    00
+ 08 000 00  1    0    0   0   0    0    0    00
+ 09 000 00  1    0    0   0   0    0    0    00
+ 0a 000 00  1    0    0   0   0    0    0    00
+ 0b 000 00  1    0    0   0   0    0    0    00
+ 0c 000 00  1    0    0   0   0    0    0    00
+ 0d 000 00  1    0    0   0   0    0    0    00
+ 0e 000 00  1    0    0   0   0    0    0    00
+ 0f 000 00  1    0    0   0   0    0    0    00
+IRQ to pin mappings:
+IRQ0 -> 0:0
+IRQ1 -> 0:1
+IRQ3 -> 0:3
+IRQ4 -> 0:4
+IRQ5 -> 0:5
+IRQ6 -> 0:6
+IRQ7 -> 0:7
+IRQ8 -> 0:8
+IRQ9 -> 0:9
+IRQ10 -> 0:10
+IRQ11 -> 0:11
+IRQ12 -> 0:12
+IRQ13 -> 0:13
+IRQ14 -> 0:14
+IRQ15 -> 0:15
 .................................... done.
 Using local APIC timer interrupts.
 calibrating APIC timer ...
-..... CPU clock speed is 866.0131 MHz.
-..... host bus clock speed is 133.0250 MHz.
+..... CPU clock speed is 866.0108 MHz.
+..... host bus clock speed is 133.0247 MHz.
 checking TSC synchronization across 2 CPUs: passed.
 Starting migration thread for cpu 0
 Bringing up 1
@@ -126,6 +207,7 @@
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (00:00)
 PCI: Probing PCI hardware (bus 00)
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
 ACPI: PCI Interrupt Link [LNKU] (IRQs 5, disabled)
 ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 10 11 12 14 15, enabled at IRQ 9)
 ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 *10 11 12 14 15)
@@ -145,6 +227,8 @@
 ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15, disabled)
 ACPI: PCI Root Bridge [PCI1] (00:03)
 PCI: Probing PCI hardware (bus 03)
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.PCI2._PRT]
 block request queues:
  128 requests per read queue
  128 requests per write queue
@@ -152,19 +236,15 @@
  enter congestion at 15
  exit congestion at 17
 SCSI subsystem driver Revision: 1.00
-ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 5
-ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 11
-ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 10
-ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 11
-ACPI: PCI Interrupt Link [LNK9] enabled at IRQ 10
-ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
-ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
-ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
-ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
-ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
-ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
-PCI: Using ACPI for IRQ routing
-PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
+PCI: Probing PCI hardware
+PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 0!
+PCI BIOS passed nonexistent PCI bus 3!
+PCI BIOS passed nonexistent PCI bus 3!
+PCI BIOS passed nonexistent PCI bus 3!
+PCI BIOS passed nonexistent PCI bus 4!
+PCI BIOS passed nonexistent PCI bus 3!
 SBF: ACPI BOOT descriptor is wrong length (39)
 SBF: Simple Boot Flag extension found and enabled.
 SBF: Setting boot flags 0x80
@@ -191,6 +271,7 @@
 Intel(R) PRO/100 Network Driver - version 2.1.29-k1
 Copyright (c) 2002 Intel Corporation
 
+e100: selftest OK.
 Freeing alive device f7f15000, eth%d
 e100: eth0: Intel(R) 8255x-based Ethernet Adapter
   Hardware receive checksums enabled
@@ -216,63 +297,157 @@
         <Adaptec aic7880 Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
 
At this point SCSI either fails or works depending...
David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/




---556791216-907801398-1043165611=:8393
Content-Type: APPLICATION/X-GZIP; NAME="tarsierx-bootlog.txt.gz"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="tarsierx-bootlog.txt.gz"

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
---556791216-907801398-1043165611=:8393
Content-Type: APPLICATION/X-GZIP; NAME="tarsierx-bootlog-noacpi.txt.gz"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="tarsierx-bootlog-noacpi.txt.gz"

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
---556791216-907801398-1043165611=:8393--
