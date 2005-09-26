Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVIZSHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVIZSHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVIZSHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:07:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:713 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932451AbVIZSHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:07:38 -0400
Subject: 2.6.14-rc2-mm1 ide problems on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Content-Type: multipart/mixed; boundary="=-LsJT6kcwJoG0ivcD5KHt"
Date: Mon, 26 Sep 2005 11:07:00 -0700
Message-Id: <1127758020.16275.19.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LsJT6kcwJoG0ivcD5KHt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

2.6.14-rc2-mm1 doesn't seem to boot on my AMD64 box. It hangs
while probing "ide" disks. I spent time looking at it and
here is what I know so far.

	2.6.13: works fine
	2.6.13-mm series: works fine
	2.6.14-rc2: works fine
	2.6.14-rc2 + linus.patch (from -mm1): works fine
	2.6.14-rc2-mm1: hangs on boot

I looked through all the changes in "drivers/ide/" in -mm
and none of them seemed to cause the problem. I added tracing
to figure out whats happening. It hangs while doing, "do_probe()"
Here is the calling sequence:
	 
	ide_scan_pcidev()
	   amd74xx_probe()
	     ide_setup_pci_device()
	       probe_hwif_init_with_fixup()
	         probe_hwif()
	           probe_for_drive()
	            do_probe()
	         
If anyone has fixes/debug to try, please let me know.

Thanks,
Badari
		

Here are last messages (before hang):
--------------------------------------

RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 169
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio


Here are the messages on a working kernel (2.6.14-rc2):
-------------------------------------------------------
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 169
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1818-0x181f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST380011A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SAMSUNG CDRW/DVD SM-352F, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 156312576 sectors (80032 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdc: ATAPI 5X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

I am also attaching, "diff -u" of the 2.6.14-rc2-mm1 and
2.6.14-rc2 dmesg output.



--=-LsJT6kcwJoG0ivcD5KHt
Content-Disposition: attachment; filename=log-diff.out
Content-Type: text/plain; name=log-diff.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- 2.6.14-rc2-mm1.log	2005-09-26 11:05:21.000000000 -0700
+++ 2.6.14-rc2	2005-09-23 09:30:00.000000000 -0700
@@ -1,5 +1,5 @@
 Bootdata ok (command line is root=/dev/hda2 vga=0x314 selinux=0 splash=silent console=tty0 console=ttyS0,38400 resume=/dev/hda1 profile=2)
-Linux version 2.6.14-rc2-mm1 (root@elm3b29) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Thu Sep 22 14:46:56 PDT 2005
+Linux version 2.6.14-rc2 (root@elm3b29) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Thu Sep 22 15:55:47 PDT 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
@@ -12,18 +12,42 @@
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 00000001e0000000 (usable)
+ACPI: RSDP (v002 PTLTD                                 ) @ 0x00000000000f6970
+ACPI: XSDT (v001 PTLTD  	 XSDT   0x06040000  LTP 0x00000000) @ 0x00000000dfefc625
+ACPI: FADT (v003 AMD    HAMMER   0x06040000 PTEC 0x000f4240) @ 0x00000000dfefed02
+ACPI: SRAT (v001 AMD    HAMMER   0x06040000 AMD  0x00000001) @ 0x00000000dfefedf6
+ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x00000000dfefef56
+ACPI: DSDT (v001 AMD-K8  AMDACPI 0x06040000 MSFT 0x0100000d) @ 0x0000000000000000
 Scanning NUMA topology in Northbridge 24
 Number of nodes 4
 Node 0 MemBase 0000000000000000 Limit 000000017fffffff
 Node 1 MemBase 0000000180000000 Limit 000000019fffffff
 Node 2 MemBase 00000001a0000000 Limit 00000001bfffffff
 Node 3 MemBase 00000001c0000000 Limit 00000001dfffffff
+Using 21 for the hash shift. Max adder is 1dfffffff 
 Using node hash shift of 21
 Bootmem setup node 0 0000000000000000-000000017fffffff
 Bootmem setup node 1 0000000180000000-000000019fffffff
 Bootmem setup node 2 00000001a0000000-00000001bfffffff
 Bootmem setup node 3 00000001c0000000-00000001dfffffff
+On node 0 totalpages: 1441678
+  DMA zone: 3999 pages, LIFO batch:1
+  Normal zone: 1437679 pages, LIFO batch:31
+  HighMem zone: 0 pages, LIFO batch:1
+On node 1 totalpages: 131071
+  DMA zone: 0 pages, LIFO batch:1
+  Normal zone: 131071 pages, LIFO batch:31
+  HighMem zone: 0 pages, LIFO batch:1
+On node 2 totalpages: 131071
+  DMA zone: 0 pages, LIFO batch:1
+  Normal zone: 131071 pages, LIFO batch:31
+  HighMem zone: 0 pages, LIFO batch:1
+On node 3 totalpages: 131071
+  DMA zone: 0 pages, LIFO batch:1
+  Normal zone: 131071 pages, LIFO batch:31
+  HighMem zone: 0 pages, LIFO batch:1
 ACPI: PM-Timer IO Port: 0x8008
+ACPI: Local APIC address 0xfee00000
 ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
 Processor #0 15:5 APIC version 16
 ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
@@ -47,6 +71,9 @@
 ACPI: IOAPIC (id[0x08] address[0xfa3e4000] gsi_base[36])
 IOAPIC[4]: apic_id 8, version 17, address 0xfa3e4000, GSI 36-39
 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
+ACPI: IRQ0 used by override.
+ACPI: IRQ2 used by override.
+ACPI: IRQ9 used by override.
 Setting APIC routing to flat
 Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at e2000000 (gap: e0000000:1ec00000)
@@ -58,17 +85,17 @@
 This costs you 64 MB of RAM
 Mapping aperture over 65536 KB of RAM @ 8000000
 Built 4 zonelists
-Initializing CPU#0
 Kernel command line: root=/dev/hda2 vga=0x314 selinux=0 splash=silent console=tty0 console=ttyS0,38400 resume=/dev/hda1 profile=2
 kernel profiling enabled (shift: 2)
+Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 131072 bytes)
 time.c: Using 3.579545 MHz PM timer.
-time.c: Detected 1398.189 MHz processor.
+time.c: Detected 1398.202 MHz processor.
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
 Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
-Memory: 6110856k/7864320k available (3049k kernel code, 194612k reserved, 1612k data, 244k init)
-Calibrating delay using timer specific routine.. 2801.62 BogoMIPS (lpj=5603254)
+Memory: 6110904k/7864320k available (3032k kernel code, 194548k reserved, 1600k data, 244k init)
+Calibrating delay using timer specific routine.. 2801.67 BogoMIPS (lpj=5603345)
 Security Framework v1.0.0 initialized
 SELinux:  Disabled at boot.
 Mount-cache hash table entries: 256
@@ -78,42 +105,38 @@
 mtrr: v2.0 (20020519)
 Using local APIC timer interrupts.
 Detected 12.483 MHz APIC timer.
-setup_APIC_timer
-done
+softlockup thread 0 started up.
 Booting processor 1/4 APIC 0x1
 Initializing CPU#1
-Calibrating delay using timer specific routine.. 2796.59 BogoMIPS (lpj=5593188)
+Calibrating delay using timer specific routine.. 2796.58 BogoMIPS (lpj=5593161)
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
 CPU 1(1) -> Node 1 -> Core 0
 Opteron MP w/ 1MB stepping 00
-setup_APIC_timer
-done
 CPU 1: Syncing TSC to CPU 0.
-CPU 1: synchronized TSC with CPU 0 (last diff -1 cycles, maxerr 981 cycles)
+CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 987 cycles)
+softlockup thread 1 started up.
 Booting processor 2/4 APIC 0x2
 Initializing CPU#2
-Calibrating delay using timer specific routine.. 2796.59 BogoMIPS (lpj=5593185)
+Calibrating delay using timer specific routine.. 2796.40 BogoMIPS (lpj=5592818)
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
 CPU 2(1) -> Node 2 -> Core 0
 Opteron MP w/ 1MB stepping 00
-setup_APIC_timer
-done
 CPU 2: Syncing TSC to CPU 0.
-CPU 2: synchronized TSC with CPU 0 (last diff -4 cycles, maxerr 976 cycles)
+CPU 2: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 986 cycles)
+softlockup thread 2 started up.
 Booting processor 3/4 APIC 0x3
 Initializing CPU#3
-Calibrating delay using timer specific routine.. 2796.59 BogoMIPS (lpj=5593186)
+Calibrating delay using timer specific routine.. 2796.64 BogoMIPS (lpj=5593292)
 CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
 CPU: L2 Cache: 1024K (64 bytes/line)
 CPU 3(1) -> Node 3 -> Core 0
 Opteron MP w/ 1MB stepping 00
-setup_APIC_timer
-done
 CPU 3: Syncing TSC to CPU 0.
-CPU 3: synchronized TSC with CPU 0 (last diff -2 cycles, maxerr 1606 cycles)
+CPU 3: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 1611 cycles)
 Brought up 4 CPUs
+softlockup thread 3 started up.
 Disabling vsyscall due to use of PM timer
 time.c: Using PM based timekeeping.
 testing NMI watchdog ... OK.
@@ -129,8 +152,14 @@
 ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 *10 11)
 ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 10 *11)
 ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 10 *11)
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.TP2P._PRT]
 ACPI: PCI Root Bridge [PCI1] (0000:08)
 PCI: Probing PCI hardware (bus 08)
+Boot video device is 0000:0a:00.0
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G0PA._PRT]
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G0PB._PRT]
+ACPI: PCI Interrupt Routing Table [\_SB_.PCI1.G1PB._PRT]
 SCSI subsystem initialized
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
@@ -164,7 +193,7 @@
 ACPI: PCI Interrupt 0000:08:04.0[A] -> GSI 36 (level, low) -> IRQ 16
 IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
 audit: initializing netlink socket (disabled)
-audit(1127427646.392:1): initialized
+audit(1127493945.408:1): initialized
 Total HugeTLB memory allocated, 0
 VFS: Disk quotas dquot_6.5.1
 Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
@@ -202,10 +231,7 @@
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
-mice: PS/2 mouse device common for all mice
-input: PC Speaker
 io scheduler noop registered
-input: AT Translated Set 2 keyboard on isa0060/serio0
 io scheduler anticipatory registered
 io scheduler deadline registered
 io scheduler cfq registered
@@ -213,9 +239,8 @@
 loop: loaded (max 8 devices)
 tg3.c:v3.40 (September 15, 2005)
 ACPI: PCI Interrupt 0000:19:02.0[A] -> GSI 38 (level, low) -> IRQ 17
-input: PS/2 Generic Mouse on isa0060/serio1
 eth0: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:04:76:f0:f9:aa
-eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0]
+eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
 eth0: dma_rwctrl[76ff000f]
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
@@ -225,3 +250,49 @@
 AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
     ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:DMA, hdd:pio
+Probing IDE interface ide0...
+hda: IC35L080AVVA07-0, ATA DISK drive
+ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
+Probing IDE interface ide1...
+hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
+ide1 at 0x170-0x177,0x376 on irq 15
+hda: max request size: 128KiB
+hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
+hda: cache flushes supported
+ hda: hda1 hda2
+hdc: ATAPI 48X DVD-ROM drive, 512kB Cache
+Uniform CD-ROM driver Revision: 3.20
+ide-floppy driver 0.99.newide
+mice: PS/2 mouse device common for all mice
+input: PC Speaker
+md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
+md: bitmap version 3.39
+input: AT Translated Set 2 keyboard on isa0060/serio0
+input: PS/2 Generic Mouse on isa0060/serio1
+NET: Registered protocol family 2
+IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
+TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
+TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
+TCP: Hash tables configured (established 262144 bind 65536)
+TCP reno registered
+TCP bic registered
+NET: Registered protocol family 1
+md: Autodetecting RAID arrays.
+md: autorun ...
+md: ... autorun DONE.
+ReiserFS: hda2: found reiserfs format "3.6" with standard journal
+ReiserFS: hda2: using ordered data mode
+ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
+ReiserFS: hda2: checking transaction log (hda2)
+ReiserFS: hda2: Using r5 hash to sort names
+VFS: Mounted root (reiserfs filesystem) readonly.
+Freeing unused kernel memory: 244k freed
+md: raidstart(pid 1340) used deprecated START_ARRAY ioctl. This will not be supported beyond 2.6
+md: could not open unknown-block(8,224).
+md: autostart failed!
+md: Autodetecting RAID arrays.
+md: autorun ...
+md: ... autorun DONE.
+Adding 1048784k swap on /dev/hda1.  Priority:42 extents:1 across:1048784k
+tg3: eth0: Link is up at 100 Mbps, full duplex.
+tg3: eth0: Flow control is off for TX and off for RX.

--=-LsJT6kcwJoG0ivcD5KHt--

