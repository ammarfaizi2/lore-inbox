Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUIJVZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUIJVZi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUIJVZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:25:38 -0400
Received: from border.scrd.bc.ca ([24.207.24.31]:24068 "EHLO border.scrd.bc.ca")
	by vger.kernel.org with ESMTP id S267891AbUIJVYT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:24:19 -0400
Message-ID: <1174450A1968D111AAAF00805FC162AE012070AC@deep_thought.secure.scrd.bc.ca>
From: Kris Boutilier <Kris.Boutilier@scrd.bc.ca>
To: linux-kernel@vger.kernel.org
Subject: libata/sata_sil doesn't detect drives on second SiL3112A based ad
	apter w/kernel 2.4.27?
Date: Fri, 10 Sep 2004 14:23:44 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running a custom compile of kernel 2.4.27, patched with uml skas3 on a
very basic Debian Woody install. The host is a Compaq DL760 with 8 CPUs/8gb
RAM (Corollary Profusion Chipset). The host includes a a variety of SCSI
storage controllers, one IDE controller and now two SiL-3112a based SATA
adapters (lspci -v attached). Both sata adapters have two ports and each
port has a Seagate ST3200822AS drive attached. One drive (sda) has been
partitioned, tested and works fine - the others have been left blank.

The problem is that sata_sil appears to detect both controllers, but doesn't
initialize drives 3 and 4 on the second card. Consider the output from dmesg
after loading sata_sil:

libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xF8898080 ctl 0xF889808A bmdma 0xF8898000 irq
21
ata2: SATA max UDMA/100 cmd 0xF88980C0 ctl 0xF88980CA bmdma 0xF8898008 irq
21
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata1: dev 0 configured for UDMA/100
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 390721968 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi0 : sata_sil
scsi1 : sata_sil
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
 sda: sda1
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
 sdb: unknown partition table

The only possible contributing factor would be that I had to 'disable'
interrupt assignment for the SATA cards in the bios to prevent them
incorrectly grabbing the boot sequence from the integrated Compaq array
controller. However the fact that scsi1 inits and functions implies that the
kernel is happily handling such a configuration.

Any suggestions/tips/pointers?

Kris Boutilier
Information Systems Coordinator
Sunshine Coast Regional District

----------

# lspci -v

00:03.0 Unknown mass storage controller: CMD Technology Inc: Unknown device
3112 (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 3112
        Flags: 66Mhz, medium devsel, IRQ 21
        I/O ports at 1000 [size=8]
        I/O ports at 1008 [size=4]
        I/O ports at 1010 [size=8]
        I/O ports at 100c [size=4]
        I/O ports at 1020 [size=16]
        Memory at f0000000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

00:0b.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug
Controller (rev 12)
        Subsystem: Compaq Computer Corporation: Unknown device a2f8
        Flags: 66Mhz, medium devsel, IRQ 26
        Memory at f79f0000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [68] #07 [0000]

00:0c.0 System peripheral: Compaq Computer Corporation Advanced System
Management Controller
        Subsystem: Compaq Computer Corporation: Unknown device b0f3
        Flags: medium devsel, IRQ 34
        I/O ports at 1800 [size=256]
        Memory at f79e0000 (32-bit, non-prefetchable) [size=256]

00:0d.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 215IIC
[Mach64 GT IIC] (rev 7a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc 3D Rage IIC 215IIC [Mach64 GT IIC]
        Flags: bus master, stepping, medium devsel, latency 64
        Memory at f4000000 (32-bit, prefetchable) [size=16M]
        I/O ports at 2000 [size=256]
        Memory at f79d0000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1

00:0e.0 RAID bus controller: LSI Logic / Symbios Logic (formerly NCR):
Unknown device 0010 (rev 02)
        Subsystem: Compaq Computer Corporation: Unknown device 4040
        Flags: bus master, medium devsel, latency 192, IRQ 24
        I/O ports at 2400 [size=256]
        Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [40] Power Management version 2

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4d)
        Subsystem: ServerWorks OSB4 South Bridge
        Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0210 (rev 4a) (prog-if
ea)
        Subsystem: ServerWorks: Unknown device 0210
        Flags: bus master, medium devsel, latency 0, IRQ 25
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 2820 [size=16]

00:14.0 RAM memory: Corollary, Inc Intel 8-way XEON Profusion Chipset [Cache
Coherency Filter] (rev 05)
        Flags: fast devsel

00:14.1 RAM memory: Corollary, Inc Intel 8-way XEON Profusion Chipset [Cache
Coherency Filter] (rev 05)
        Flags: fast devsel

00:19.0 Host bridge: Compaq Computer Corporation: Unknown device 6011
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Capabilities: [70] #07 [0030]

00:1a.0 Host bridge: Compaq Computer Corporation: Unknown device 6011
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Capabilities: [70] #07 [0030]

00:1b.0 Host bridge: Compaq Computer Corporation: Unknown device 6011
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Capabilities: [70] #07 [0030]

05:01.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=05, secondary=06, subordinate=06, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: f7b00000-f7efffff
        Capabilities: [dc] Power Management version 1

05:02.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c896 (rev 05)
        Subsystem: Compaq Computer Corporation: Unknown device 6004
        Flags: bus master, medium devsel, latency 255, IRQ 19
        I/O ports at 3000 [size=256]
        Memory at f7af0000 (64-bit, non-prefetchable) [size=1K]
        Memory at f7ae0000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

05:02.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c896 (rev 05)
        Subsystem: Compaq Computer Corporation: Unknown device 6004
        Flags: bus master, medium devsel, latency 255, IRQ 19
        I/O ports at 3400 [size=256]
        Memory at f7ad0000 (64-bit, non-prefetchable) [size=1K]
        Memory at f7ac0000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

05:03.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c896 (rev 05)
        Subsystem: Compaq Computer Corporation: Unknown device 6004
        Flags: bus master, medium devsel, latency 255, IRQ 18
        I/O ports at 3800 [size=256]
        Memory at f7ab0000 (64-bit, non-prefetchable) [size=1K]
        Memory at f7aa0000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

05:03.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR)
53c896 (rev 05)
        Subsystem: Compaq Computer Corporation: Unknown device 6004
        Flags: bus master, medium devsel, latency 255, IRQ 18
        I/O ports at 3c00 [size=256]
        Memory at f7a90000 (64-bit, non-prefetchable) [size=1K]
        Memory at f7a80000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [40] Power Management version 2

05:0b.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug
Controller (rev 12)
        Subsystem: Compaq Computer Corporation: Unknown device a2fc
        Flags: 66Mhz, medium devsel, IRQ 26
        Memory at f7a70000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [68] #07 [0000]

06:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Compaq Computer Corporation: Unknown device b163
        Flags: bus master, medium devsel, latency 64, IRQ 20
        Memory at f7ef0000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 4000 [size=64]
        Memory at f7d00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

06:05.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Compaq Computer Corporation: Unknown device b163
        Flags: bus master, medium devsel, latency 64, IRQ 20
        Memory at f7cf0000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 4040 [size=64]
        Memory at f7b00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2

0d:0b.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug
Controller (rev 12)
        Subsystem: Compaq Computer Corporation: Unknown device a2fd
        Flags: 66Mhz, medium devsel, IRQ 26
        Memory at f7ff0000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [68] #07 [0000]

# cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 36 netlink
128 ptm
136 pts
162 raw
202 cpu/msr
203 cpu/cpuid

Block devices:
  1 ramdisk
  2 fd
  3 ide0
  8 sd
 65 sd
 66 sd
 72 ida0

asterix:~# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
CPU6       CPU7
  0:   13012540          0          0          0          0          0
0          0  local-APIC-edge  timer
  1:        152        331        321        206        319        288
323        295    IO-APIC-edge  keyboard
  9:          0          0          0          0          0          0
0          0   IO-APIC-level  acpi
 14:          1          0          0          0          0          0
3          1    IO-APIC-edge  ide0
 20:       2700      10337       9977      10331      10306      10443
10383      10365   IO-APIC-level  eth0
 21:       5282       5575       5521       5494       5486       5388
5384       5444   IO-APIC-level  libata
 24:        890       8830       1345       8930       8815       9008
8818       8660   IO-APIC-level  ida0
NMI:          0          0          0          0          0          0
0          0
LOC:   13011692   13011691   13011690   13011690   13011690   13011690
13011690   13011684
ERR:          0
MIS:          0

