Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263255AbTJ0PQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJ0PQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:16:00 -0500
Received: from kokytos.rz.informatik.uni-muenchen.de ([141.84.214.13]:10465
	"EHLO kokytos.rz.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S263255AbTJ0PPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:15:07 -0500
Date: Mon, 27 Oct 2003 16:15:05 +0100
From: "Oliver M. Bolzer" <oliver@gol.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-t9 libata: Promise FastTrak S150 TX4 not working
Message-ID: <20031027151505.GB10432@magi.fakeroot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Several weeks ago, I tested without success the 2.4.22-bk32-libata1
patch with my Promise FastTrak S150 TX4 controller. Seeing that
2.6.0-test9 merged libata, I tryed again, without success.

4 drives are connected to the controller and are configured as 4
seperate arrays (the thing doesn't have a non-RAID-mode) that are
working with Promise's partially-binary-only ft3xx driver on 2.4.22.

Below are the contents of /proc/pci on the machine and dmesg output
with ATA_DEBUG and ATA_VERBOSE_DEBUG enabled. As it seemed that it
could not soft-reset the ports, I also compiled the driver without
the ATA_FLAG_SRST flag for my controller. It looks like the driver
can recognize the arrays this way but then the kernel enters some
kind of endless-loop after DMA timeouts. The dmesg output without
ATA_FLAG_SRST ist also included below. 

In both cases, the actual error seems to be
ATA: abnormal status 0x80 on port 0xF881321C

As I got 8 identical machines with only 3 currenly in beta-use, I'm
ready to test any kind of patches to help improve the driver.


### /proc/pci output ######
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845G/GL [Brookdale (rev 1).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   2, function  0:
    VGA compatible controller: Intel Corp. 82845G/GL [Brookdale (rev 1).
      IRQ 16.
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
      Non-prefetchable 32 bit memory at 0xfc400000 [0xfc47ffff].
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 1).
      IRQ 16.
      I/O at 0x2440 [0x245f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 1).
      IRQ 19.
      I/O at 0x2460 [0x247f].
  Bus  0, device  29, function  2:
    USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 1).
      IRQ 18.
      I/O at 0x2480 [0x249f].
  Bus  0, device  29, function  7:
    USB Controller: Intel Corp. 82801DB USB EHCI Con (rev 1).
      IRQ 23.
      Non-prefetchable 32 bit memory at 0xfc480000 [0xfc4803ff].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Br (rev 129).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801DB ISA Bridge ( (rev 1).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 1).
      IRQ 18.
      I/O at 0x24c0 [0x24cf].
      Non-prefetchable 32 bit memory at 0x3f800000 [0x3f8003ff].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 1).
      IRQ 17.
      I/O at 0x2000 [0x20ff].
      I/O at 0x2400 [0x243f].
      Non-prefetchable 32 bit memory at 0xfc480400 [0xfc4805ff].
      Non-prefetchable 32 bit memory at 0xfc480600 [0xfc4806ff].
  Bus  5, device   4, function  0:
    RAID bus controller: PCI device 105a:3319 (Promise Technology, ) (rev 2).
      IRQ 16.
      Master Capable.  Latency=96.  Min Gnt=4.Max Lat=18.
      I/O at 0x1080 [0x10bf].
      I/O at 0x1400 [0x140f].
      I/O at 0x1000 [0x107f].
      Non-prefetchable 32 bit memory at 0xfc530000 [0xfc530fff].
      Non-prefetchable 32 bit memory at 0xfc500000 [0xfc51ffff].
  Bus  5, device   8, function  0:
    Ethernet controller: Intel Corp. 82801BD PRO/100 VM ( (rev 129).
      IRQ 20.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfc531000 [0xfc531fff].
      I/O at 0x10c0 [0x10ff].
  Bus  5, device  10, function  0:
    Ethernet controller: Altima (nee Broadcom AC9100 Gigabit Ether (rev 21).
      IRQ 21.
      Master Capable.  Latency=64.  Min Gnt=64.
      Non-prefetchable 64 bit memory at 0xfc520000 [0xfc52ffff].

##### dmesg output, vanilla source (with ATA_FLAG_SRST)
Linux version 2.6.0-test9 (bolzer@ravioli) (gcc version 3.2) #12 Mon Oct 27 14:26:29 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
 BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f7f0000 (usable)
 BIOS-e820: 000000003f7f0000 - 000000003f800000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
119MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f9bf0
hm, page 000f9000 reserved twice.
hm, page 000fa000 reserved twice.
hm, page 000ed000 reserved twice.
hm, page 000ee000 reserved twice.
On node 0 totalpages: 260080
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 30704 pages, LIFO batch:7
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID:              APIC at: 0xFEE00000
Processor #0 15:2 APIC version 16
I/O APIC #8 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: log_buf_len=128k nfsroot=XXX.XXX.XXX.XXX:/var/cipinstall,rsize=8192,wsize=8192 ip=::::::dhcp BOOT_IMAGE=vmlinuz.install-2.6.0t9-silo 
log_buf_len: 131072
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2525.545 MHz processor.
Console: colour VGA+ 80x25
Memory: 1025404k/1040320k available (2196k kernel code, 13964k reserved, 911k data, 152k init, 122816k highmem)
Calibrating delay loop... 4980.73 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 8-0, 8-2, 8-5, 8-10, 8-11 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=-1
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
number of MP IRQ sources: 42.
number of IO-APIC #8 registers: 24.
testing the IO APIC.......................
IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
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
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 001 01  1    1    0   1   0    1    1    99
 12 001 01  1    1    0   1   0    1    1    A1
 13 001 01  1    1    0   1   0    1    1    A9
 14 001 01  1    1    0   1   0    1    1    B1
 15 001 01  1    1    0   1   0    1    1    B9
 16 001 01  1    1    0   1   0    1    1    C1
 17 001 01  1    1    0   1   0    1    1    C9
IRQ to pin mappings:
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
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
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2524.0728 MHz.
..... host bus clock speed is 132.0880 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.20 entry at 0xeca48, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fefe0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6627, dseg 0xf0000
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX [8086/24c0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B5,I4,P0) -> 16
PCI->APIC IRQ transform: (B5,I8,P0) -> 20
PCI->APIC IRQ transform: (B5,I10,P0) -> 21
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
hw_random: RNG not detected
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

tg3.c:v2.2 (August 24, 2003)
eth1: Tigon3 [partno(AC91002A1) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:09:5b:60:df:a3
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x24c0-0x24c7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x24c8-0x24cf, BIOS settings: hdc:pio, hdd:pio
libata version 0.75 loaded.
sata_promise version 0.83
ata_device_add: ENTER
ata_host_add: ENTER
ata_host_add: prd alloc, virt f7ded000, dma 37ded000
ata1: SATA max UDMA/133 cmd 0xF8813200 ctl 0xF8813238 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata1: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7dec000, dma 37dec000
ata2: SATA max UDMA/133 cmd 0xF8813280 ctl 0xF88132B8 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata2: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7dea000, dma 37dea000
ata3: SATA max UDMA/133 cmd 0xF8813300 ctl 0xF8813338 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata3: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7de9000, dma 37de9000
ata4: SATA max UDMA/133 cmd 0xF8813380 ctl 0xF88133B8 bmdma 0x0 irq 16
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_device_add: ata1: probe-wait begin
ata_thread_iter: ata4: thr_state THR_PROBE_START
ata_thread_iter: ata1: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata1: thr_state THR_PORT_RESET
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ATA: abnormal status 0x80 on port 0xF881321C
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 1, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_thread_iter: ata1: new thr_state THR_PROBE_FAILED, returning 0
ata_thread_iter: ata1: thr_state THR_PROBE_FAILED
ata_thread_iter: ata1: new thr_state THR_AWAIT_DEATH, returning 0
ata_thread_iter: ata1: thr_state THR_AWAIT_DEATH
ata_thread_iter: ata1: new thr_state THR_AWAIT_DEATH, returning -1
ata1: thread exiting
ata_device_add: ata1: probe-wait end
scsi0 : sata_promise
ata_device_add: ata2: probe begin
ata_device_add: ata2: probe-wait begin
ata_thread_iter: ata2: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata2: thr_state THR_PORT_RESET
ata_bus_reset: ENTER, host 2, port 1
ata_bus_softreset: ata2: bus reset via SRST
ATA: abnormal status 0x80 on port 0xF881329C
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 2, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 2, dev 1) -- nodev
ata_thread_iter: ata2: new thr_state THR_PROBE_FAILED, returning 0
ata_thread_iter: ata2: thr_state THR_PROBE_FAILED
ata_thread_iter: ata2: new thr_state THR_AWAIT_DEATH, returning 0
ata_thread_iter: ata2: thr_state THR_AWAIT_DEATH
ata_thread_iter: ata2: new thr_state THR_AWAIT_DEATH, returning -1
ata2: thread exiting
ata_device_add: ata2: probe-wait end
scsi1 : sata_promise
ata_device_add: ata3: probe begin
ata_device_add: ata3: probe-wait begin
ata_thread_iter: ata3: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata3: thr_state THR_PORT_RESET
ata_bus_reset: ENTER, host 3, port 2
ata_bus_softreset: ata3: bus reset via SRST
ATA: abnormal status 0x80 on port 0xF881331C
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 3, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 3, dev 1) -- nodev
ata_thread_iter: ata3: new thr_state THR_PROBE_FAILED, returning 0
ata_thread_iter: ata3: thr_state THR_PROBE_FAILED
ata_thread_iter: ata3: new thr_state THR_AWAIT_DEATH, returning 0
ata_thread_iter: ata3: thr_state THR_AWAIT_DEATH
ata_thread_iter: ata3: new thr_state THR_AWAIT_DEATH, returning -1
ata3: thread exiting
ata_device_add: ata3: probe-wait end
scsi2 : sata_promise
ata_device_add: ata4: probe begin
ata_device_add: ata4: probe-wait begin
ata_thread_iter: ata4: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata4: thr_state THR_PORT_RESET
ata_bus_reset: ENTER, host 4, port 3
ata_bus_softreset: ata4: bus reset via SRST
ATA: abnormal status 0x80 on port 0xF881339C
ata_bus_reset: EXIT
ata_dev_identify: ENTER/EXIT (host 4, dev 0) -- nodev
ata_dev_identify: ENTER/EXIT (host 4, dev 1) -- nodev
ata_thread_iter: ata4: new thr_state THR_PROBE_FAILED, returning 0
ata_thread_iter: ata4: thr_state THR_PROBE_FAILED
ata_thread_iter: ata4: new thr_state THR_AWAIT_DEATH, returning 0
ata_thread_iter: ata4: thr_state THR_AWAIT_DEATH
ata_thread_iter: ata4: new thr_state THR_AWAIT_DEATH, returning -1
ata4: thread exiting
ata_device_add: ata4: probe-wait end
scsi3 : sata_promise
ata_device_add: probe begin
ata_scsi_queuecmd: CDB (1:0,0,0) 12 00 00 00 24 00 de f7 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (1:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (1:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (2:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (2:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (3:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (3:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (4:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (4:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,15,0) 12 00 00 00 24 00 00 00 00
ata_device_add: EXIT, returning 4
[...USB...mouting....etc]


##### dmesg output,without ATA_FLAG_SRST
Linux version 2.6.0-test9 (bolzer@ravioli) (gcc version 3.2) #15 Mon Oct 27 15:18:34 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009cc00 (usable)
 BIOS-e820: 000000000009cc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f7f0000 (usable)
 BIOS-e820: 000000003f7f0000 - 000000003f800000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
119MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f9bf0
hm, page 000f9000 reserved twice.
hm, page 000fa000 reserved twice.
hm, page 000ed000 reserved twice.
hm, page 000ee000 reserved twice.
On node 0 totalpages: 260080
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 30704 pages, LIFO batch:7
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID:              APIC at: 0xFEE00000
Processor #0 15:2 APIC version 16
I/O APIC #8 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: console=ttyS0 console=tty0 log_buf_len=128k nfsroot=XXX.XXX.XXX.XXX:/var/cipinstall,rsize=8192,wsize=8192 ip=::::::dhcp BOOT_IMAGE=vmlinuz.install-2.6.0t9-silo 
log_buf_len: 131072
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2525.500 MHz processor.
Console: colour VGA+ 80x25
Memory: 1025360k/1040320k available (2222k kernel code, 14008k reserved, 925k data, 156k init, 122816k highmem)
Calibrating delay loop... 4980.73 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
..TIMER: vector=0x31 pin1=-1 pin2=-1
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2524.0754 MHz.
..... host bus clock speed is 132.0881 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.20 entry at 0xeca48, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fefe0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6627, dseg 0xf0000
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX [8086/24c0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B5,I4,P0) -> 16
PCI->APIC IRQ transform: (B5,I8,P0) -> 20
PCI->APIC IRQ transform: (B5,I10,P0) -> 21
Machine check exception polling timer started.
cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
Initializing Cryptographic API
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
hw_random: RNG not detected
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
tg3.c:v2.2 (August 24, 2003)
eth1: Tigon3 [partno(AC91002A1) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:09:5b:60:df:a3
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x24c0-0x24c7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x24c8-0x24cf, BIOS settings: hdc:pio, hdd:pio
ata_device_add: ENTER
ata_host_add: ENTER
ata_host_add: prd alloc, virt f7de8000, dma 37de8000
ata1: SATA max UDMA/133 cmd 0xF8813200 ctl 0xF8813238 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata1: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7de7000, dma 37de7000
ata2: SATA max UDMA/133 cmd 0xF8813280 ctl 0xF88132B8 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata2: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7de6000, dma 37de6000
ata3: SATA max UDMA/133 cmd 0xF8813300 ctl 0xF8813338 bmdma 0x0 irq 16
ata_host_add: ENTER
ata_thread_iter: ata3: thr_state THR_PROBE_START
ata_host_add: prd alloc, virt f7de5000, dma 37de5000
ata4: SATA max UDMA/133 cmd 0xF8813380 ctl 0xF88133B8 bmdma 0x0 irq 16
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata_device_add: ata1: probe-wait begin
ata_thread_iter: ata1: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata1: thr_state THR_PORT_RESET
ata_thread_iter: ata4: thr_state THR_PROBE_START
ata_bus_reset: ENTER, host 1, port 0
ata_bus_edd: execute-device-diag
ATA: abnormal status 0x80 on port 0xF881321C
ata_exec: ata1: cmd 0x90
ata_exec_command_mmio: ata1: cmd 0x90
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata1: cmd 0xEC
ata_exec_command_mmio: ata1: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003  
ata_dump_id: 88==0x207f  93==0x0000
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata1: cmd 0xEF
ata_exec_command_mmio: ata1: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata1: dev 0 configured for UDMA/133
ata_thread_iter: ata1: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata1: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 0
ata_device_add: ata1: probe-wait end
scsi0 : sata_promise
ata_device_add: ata2: probe begin
ata_device_add: ata2: probe-wait begin
ata_thread_iter: ata2: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata2: thr_state THR_PORT_RESET
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_bus_reset: ENTER, host 2, port 1
ata_bus_edd: execute-device-diag
ATA: abnormal status 0x80 on port 0xF881329C
ata_exec: ata2: cmd 0x90
ata_exec_command_mmio: ata2: cmd 0x90
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 2, dev 0
ata_dev_select: ENTER, ata2: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata2: cmd 0xEC
ata_exec_command_mmio: ata2: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003  
ata_dump_id: 88==0x207f  93==0x0000
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 2, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata2: cmd 0xEF
ata_exec_command_mmio: ata2: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata2: dev 0 configured for UDMA/133
ata_thread_iter: ata2: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata2: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 0
ata_device_add: ata2: probe-wait end
scsi1 : sata_promise
ata_device_add: ata3: probe begin
ata_device_add: ata3: probe-wait begin
ata_thread_iter: ata3: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata3: thr_state THR_PORT_RESET
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_bus_reset: ENTER, host 3, port 2
ata_bus_edd: execute-device-diag
ATA: abnormal status 0x80 on port 0xF881331C
ata_exec: ata3: cmd 0x90
ata_exec_command_mmio: ata3: cmd 0x90
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 3, dev 0
ata_dev_select: ENTER, ata3: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata3: cmd 0xEC
ata_exec_command_mmio: ata3: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003  
ata_dump_id: 88==0x207f  93==0x0000
ata3: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 3, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata3: cmd 0xEF
ata_exec_command_mmio: ata3: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata3: dev 0 configured for UDMA/133
ata_thread_iter: ata3: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata3: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 0
ata_device_add: ata3: probe-wait end
scsi2 : sata_promise
ata_device_add: ata4: probe begin
ata_device_add: ata4: probe-wait begin
ata_thread_iter: ata4: new thr_state THR_PORT_RESET, returning 0
ata_thread_iter: ata4: thr_state THR_PORT_RESET
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
ata_bus_reset: ENTER, host 4, port 3
ata_bus_edd: execute-device-diag
ATA: abnormal status 0x80 on port 0xF881339C
ata_exec: ata4: cmd 0x90
ata_exec_command_mmio: ata4: cmd 0x90
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 4, dev 0
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_dev_identify: do ATA identify
ata_exec: ata4: cmd 0xEC
ata_exec_command_mmio: ata4: cmd 0xEC
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000  
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7f09  84==0x4003  
ata_dump_id: 88==0x207f  93==0x0000
ata4: dev 0 ATA, max UDMA/133, 398297088 sectors (lba48)
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 4, dev 1) -- nodev
ata_host_set_udma: udma masks: host 0x7F, master 0x7F, slave 0xFF
ata_host_set_udma: mask 0x7F i 0x47 j 7
ata_host_set_udma: mask 0x7F i 0x46 j 6
ata_dev_set_xfermode: set features - xfer mode
ata_tf_load_mmio: feat 0x3 nsect 0x46 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xA0
ata_exec: ata4: cmd 0xEF
ata_exec_command_mmio: ata4: cmd 0xEF
ata_dev_set_xfermode: EXIT
ata4: dev 0 configured for UDMA/133
ata_thread_iter: ata4: new thr_state THR_PROBE_SUCCESS, returning 0
ata_thread_iter: ata4: thr_state THR_PROBE_SUCCESS
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 0
ata_device_add: ata4: probe-wait end
scsi3 : sata_promise
ata_device_add: probe begin
ata_scsi_queuecmd: CDB (1:0,0,0) 12 00 00 00 24 00 dd f7 00
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (1:0,0,0) 12 00 00 00 61 00 dd f7 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_queuecmd: CDB (1:0,0,0) a0 00 00 00 00 00 00 00 04
ata_scsiop_report_luns: ENTER
ata_scsi_queuecmd: CDB (1:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (1:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (1:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (2:0,0,0) 12 00 00 00 61 00 00 00 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_queuecmd: CDB (2:0,0,0) a0 00 00 00 00 00 00 00 04
ata_scsiop_report_luns: ENTER
ata_scsi_queuecmd: CDB (2:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (2:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (2:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (3:0,0,0) 12 00 00 00 61 00 00 00 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_queuecmd: CDB (3:0,0,0) a0 00 00 00 00 00 00 00 04
ata_scsiop_report_luns: ENTER
ata_scsi_queuecmd: CDB (3:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (3:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (3:1,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,0,0) 12 00 00 00 24 00 00 00 00
ata_scsiop_inq_std: ENTER
ata_scsi_queuecmd: CDB (4:0,0,0) 12 00 00 00 61 00 00 00 00
ata_scsiop_inq_std: ENTER
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: 0.75
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_queuecmd: CDB (4:0,0,0) a0 00 00 00 00 00 00 00 04
ata_scsiop_report_luns: ENTER
ata_scsi_queuecmd: CDB (4:0,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: no device
ata_scsi_queuecmd: CDB (4:0,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:0,15,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,0,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,1,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,2,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,3,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,4,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,5,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,6,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,7,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,8,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,9,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,10,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,11,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,12,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,13,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,14,0) 12 00 00 00 24 00 00 00 00
ata_scsi_queuecmd: CDB (4:1,15,0) 12 00 00 00 24 00 00 00 00
ata_device_add: EXIT, returning 4
ata_scsi_queuecmd: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
ata_scsi_queuecmd: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sda: drive cache: write through
 sda:<3>ata_scsi_queuecmd: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_sg_setup: ENTER, ata1, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x37DA7000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
pdc_dma_start: ENTER, ap f7dec9a8, mmio f8813000
pdc_dma_start: val == 80008001
pdc_dma_start: val == 80008001
ata_exec_command_mmio: ata1: cmd 0x25
pdc_dma_start: FIVE
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: port 1
pdc_interrupt: port 2
pdc_interrupt: port 3
pdc_interrupt: EXIT
 sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
ata_scsi_queuecmd: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sdb: drive cache: write through
 sdb:<3>ata_scsi_queuecmd: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata2: device 0, wait 1
ata_sg_setup: ENTER, ata2, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x37DA6000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
pdc_dma_start: ENTER, ap f7dec1a8, mmio f8813000
pdc_dma_start: val == 80008002
pdc_dma_start: val == 80008002
ata_exec_command_mmio: ata2: cmd 0x25
pdc_dma_start: FIVE
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
pdc_interrupt: port 1
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: port 2
pdc_interrupt: port 3
pdc_interrupt: EXIT
ata_thread_iter: ata4: thr_state THR_IDLE
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 30000
 sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (3:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (3:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
ata_scsi_queuecmd: CDB (3:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (3:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sdc: drive cache: write through
 sdc:<3>ata_scsi_queuecmd: CDB (3:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata3: device 0, wait 1
ata_sg_setup: ENTER, ata3, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x37DA5000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
pdc_dma_start: ENTER, ap f7fed9a8, mmio f8813000
pdc_dma_start: val == 80008003
pdc_dma_start: val == 80008003
ata_exec_command_mmio: ata3: cmd 0x25
pdc_dma_start: FIVE
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: port 0
pdc_interrupt: port 1
pdc_interrupt: port 2
ata_sg_clean: unmapping 1 sg elements
pdc_interrupt: port 3
pdc_interrupt: EXIT
 sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
ata_scsi_queuecmd: CDB (4:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsiop_noop: ENTER
ata_scsi_queuecmd: CDB (4:0,0,0) 25 00 00 00 00 00 00 00 00
ata_scsiop_read_cap: ENTER
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
ata_scsi_queuecmd: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsiop_mode_sense: ENTER
ata_scsi_queuecmd: CDB (4:0,0,0) 5a 00 08 00 00 00 00 00 17
ata_scsiop_mode_sense: ENTER
SCSI device sdd: drive cache: write through
 sdd:<3>ata_scsi_queuecmd: CDB (4:0,0,0) 28 00 00 00 00 00 00 00 08
ata_scsi_rw_queue: ENTER
ata_scsi_rw_xlat: reading
ata_scsi_rw_xlat: ten-byte command
ata_dev_select: ENTER, ata4: device 0, wait 1
ata_sg_setup: ENTER, ata4, use_sg 1
ata_sg_setup: 1 sg elements mapped
ata_fill_sg: PRD[0] = (0x37DA4000, 0x1000)
ata_tf_load_mmio: hob: feat 0x0 nsect 0x0, lba 0x0 0x0 0x0
ata_tf_load_mmio: feat 0x0 nsect 0x8 lba 0x0 0x0 0x0
ata_tf_load_mmio: device 0xE0
pdc_dma_start: ENTER, ap f7fed1a8, mmio f8813000
pdc_dma_start: val == 80008004
pdc_dma_start: val == 80008004
ata_exec_command_mmio: ata4: cmd 0x25
pdc_dma_start: FIVE
ata_scsi_rw_queue: EXIT
pdc_interrupt: ENTER
pdc_interrupt: QUICK EXIT 3
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata4: thr_state THR_IDLE
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 30000
ata_scsi_error: ENTER
pdc_eng_timeout: ENTER
ata4: DMA timeout
ata_sg_clean: unmapping 1 sg elements
pdc_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata4: thr_state THR_IDLE
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata4: thr_state THR_IDLE
ata_thread_iter: ata4: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata1: thr_state THR_IDLE
ata_thread_iter: ata1: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata2: thr_state THR_IDLE
ata_thread_iter: ata2: new thr_state THR_IDLE, returning 30000
ata_thread_iter: ata3: thr_state THR_IDLE
ata_thread_iter: ata3: new thr_state THR_IDLE, returning 30000
[endless loop]

-- 
	Oliver M. Bolzer
	oliver@gol.com

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF
