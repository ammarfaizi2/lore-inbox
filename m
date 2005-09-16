Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbVIPQnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbVIPQnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbVIPQnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 12:43:16 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:60609 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1161185AbVIPQnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 12:43:15 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: mike.miller@hp.com
Subject: 2.6.14-rc1 cciss breakage
Date: Fri, 16 Sep 2005 10:43:10 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509161043.10594.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

    [PATCH] cciss: busy_initializing flag
    http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1f8ef3806c40e74733f45f436d44b3d8e9a2fa48

breaks cciss on my HP dl360.  lspci output and dmesg diff below:

0000:00:04.0 RAID bus controller: Compaq Computer Corporation Smart Array 5i/532 (rev 01)
        Subsystem: Compaq Computer Corporation Smart Array 5i
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 71, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at f5f80000 (64-bit, non-prefetchable) [size=256K]
        Region 2: I/O ports at 2800 [size=256]
        Region 3: Memory at f5df0000 (64-bit, prefetchable) [size=16K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [cc] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [dc] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=3
                Status: Bus=221 Dev=30 Func=0 64bit+ 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=3, DMCRS=1, RSCEM-


--- dl360.ok	2005-09-16 10:38:36.000000000 -0600
+++ dl360.broken	2005-09-16 10:35:51.000000000 -0600
@@ -1,236 +1,230 @@
-Linux version 2.6.14-rc1 (helgaas@dl360) (gcc version 3.3.5 (Debian 1:3.3.5-6)) #6 SMP Fri Sep 16 08:56:39 MDT 2005
+Linux version 2.6.14-rc1 (helgaas@dl360) (gcc version 3.3.5 (Debian 1:3.3.5-6)) #7 SMP Fri Sep 16 08:59:57 MDT 2005
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
  BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000007fffa000 (usable)
  BIOS-e820: 000000007fffa000 - 0000000080000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
  BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
 1151MB HIGHMEM available.
 896MB LOWMEM available.
 found SMP MP-table at 000f4fd0
 DMI 2.3 present.
 ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
 Processor #0 15:2 APIC version 20
 ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
 ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] disabled)
 ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
 Processor #6 15:2 APIC version 20
 ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
 Processor #1 15:2 APIC version 20
 ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
 ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] disabled)
 ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
 Processor #7 15:2 APIC version 20
 ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
 ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
 IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-15
 ACPI: IOAPIC (id[0x03] address[0xfec01000] gsi_base[16])
 IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, GSI 16-31
 ACPI: IOAPIC (id[0x04] address[0xfec02000] gsi_base[32])
 IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, GSI 32-47
 ACPI: IOAPIC (id[0x05] address[0xfec03000] gsi_base[48])
 IOAPIC[3]: apic_id 5, version 17, address 0xfec03000, GSI 48-63
 ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
 Enabling APIC mode:  Flat.  Using 4 I/O APICs
 Using ACPI (MADT) for SMP configuration information
 Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
 Built 1 zonelists
 Kernel command line: console=uart,io,0x3f8 root=/dev/cciss/c0d0p1 BOOT_IMAGE=bzImage 
 Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 2799.742 MHz processor.
+Detected 2799.663 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Early serial console at I/O port 0x3f8 (options '115200')
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 Memory: 2073504k/2097128k available (3349k kernel code, 22568k reserved, 1184k data, 324k init, 1179624k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 5607.04 BogoMIPS (lpj=11214087)
+Calibrating delay using timer specific routine.. 5606.96 BogoMIPS (lpj=11213938)
 Mount-cache hash table entries: 512
 CPU: Trace cache: 12K uops, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 0
 mtrr: v2.0 (20020519)
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
  tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
 Parsing all Control Methods:............................................................................................................
 Table [DSDT](id 0005) - 530 Objects with 38 Devices 108 Methods 11 Regions
 ACPI Namespace successfully loaded at root c05e9338
 evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
 CPU0: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
 Booting processor 1/1 eip 2000
 Initializing CPU#1
-Calibrating delay using timer specific routine.. 5598.83 BogoMIPS (lpj=11197669)
+Calibrating delay using timer specific routine.. 5598.90 BogoMIPS (lpj=11197808)
 CPU: Trace cache: 12K uops, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 0
 CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
 Booting processor 2/6 eip 2000
 Initializing CPU#2
-Calibrating delay using timer specific routine.. 5598.72 BogoMIPS (lpj=11197451)
+Calibrating delay using timer specific routine.. 5599.17 BogoMIPS (lpj=11198346)
 CPU: Trace cache: 12K uops, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 3
 CPU2: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
 Booting processor 3/7 eip 2000
 Initializing CPU#3
-Calibrating delay using timer specific routine.. 5599.08 BogoMIPS (lpj=11198166)
+Calibrating delay using timer specific routine.. 5599.18 BogoMIPS (lpj=11198372)
 CPU: Trace cache: 12K uops, L1 D cache: 8K
 CPU: L2 cache: 512K
 CPU: Physical Processor ID: 3
 CPU3: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
-Total of 4 processors activated (22403.68 BogoMIPS).
+Total of 4 processors activated (22404.23 BogoMIPS).
 ENABLING IO-APIC IRQs
 ..TIMER: vector=0x31 pin1=2 pin2=-1
 checking TSC synchronization across 4 CPUs: passed.
 Brought up 4 CPUs
 NET: Registered protocol family 16
 ACPI: bus type pci registered
 PCI: PCI BIOS revision 2.10 entry at 0xf0094, last bus=6
 PCI: Using configuration type 1
 mtrr: your CPUs had inconsistent fixed MTRR settings
 mtrr: probably your BIOS does not setup all CPUs.
 mtrr: corrected configuration.
 ACPI: Subsystem revision 20050902
 evgpeblk-1125 [05] ev_gpe_initialize     : There are no GPE blocks defined in the FADT
 Completing Region/Field/Buffer/Package initialization:..............................................................................................................................................................................................................................
 Initialized 11/11 Regions 149/149 Fields 57/57 Buffers 5/5 Packages (539 nodes)
 Executing all Device _STA and_INI methods:.................................................
 49 Devices found containing: 49 _STA, 0 _INI methods
 ACPI: Interpreter enabled
 ACPI: Using IOAPIC for interrupt routing
 ACPI: PCI Root Bridge [PCI0] (0000:00)
 PCI: Probing PCI hardware (bus 00)
 PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
 ACPI: PCI Root Bridge [PCI1] (0000:01)
 PCI: Probing PCI hardware (bus 01)
 ACPI: PCI Root Bridge [PCI2] (0000:04)
 PCI: Probing PCI hardware (bus 04)
 ACPI: PCI Interrupt Link [IUSB] (IRQs 4 5 7 *10 11 15)
 ACPI: PCI Interrupt Link [IN16] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN17] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN18] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN19] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN20] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN21] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN22] (IRQs 4 5 *7 10 11 15)
 ACPI: PCI Interrupt Link [IN23] (IRQs 4 *5 7 10 11 15)
 ACPI: PCI Interrupt Link [IN24] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN25] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN26] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN27] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN28] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN29] (IRQs 4 5 7 10 11 *15)
 ACPI: PCI Interrupt Link [IN30] (IRQs 4 5 7 10 *11 15)
 ACPI: PCI Interrupt Link [IN31] (IRQs 4 5 7 10 11 15) *3
 ACPI: PCI Interrupt Link [IN32] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN33] (IRQs 4 5 7 10 11 15) *0, disabled.
 ACPI: PCI Interrupt Link [IN34] (IRQs 4 5 7 10 11 15) *0, disabled.
 SCSI subsystem initialized
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 PCI: Using ACPI for IRQ routing
 PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
 PCI: Device 0000:00:00.0 not found by BIOS
 PCI: Device 0000:00:00.1 not found by BIOS
 PCI: Device 0000:00:00.2 not found by BIOS
 PCI: Device 0000:00:0f.0 not found by BIOS
 PCI: Device 0000:00:0f.3 not found by BIOS
 PCI: Device 0000:00:11.0 not found by BIOS
 PCI: Device 0000:00:11.2 not found by BIOS
 highmem bounce pool size: 64 pages
 Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
 NTFS driver 2.1.24 [Flags: R/O].
 ACPI: Power Button (FF) [PWRF]
 ibm_acpi: ec object not found
 Real Time Clock Driver v1.12
 Non-volatile memory driver v1.2
 Linux agpgart interface v0.101 (c) Dave Jones
 [drm] Initialized drm 1.0.0 20040925
 serio: i8042 AUX port at 0x60,0x64 irq 12
 serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
 io scheduler cfq registered
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a National Semiconductor PC87306
 loop: loaded (max 8 devices)
 HP CISS Driver (v 2.6.8)
 ACPI: PCI Interrupt 0000:00:04.0[A] -> GSI 31 (level, low) -> IRQ 169
 cciss: using DAC cycles
       blocks= 35553120 block_size= 512
       heads= 255, sectors= 32, cylinders= 4357
 
-      blocks= 35553120 block_size= 512
-      heads= 255, sectors= 32, cylinders= 4357
-
- cciss/c0d0: p1 p2
 Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
 Copyright (c) 1999-2005 Intel Corporation.
 e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
 e100: Copyright(c) 1999-2005 Intel Corporation
 tg3.c:v3.39 (September 5, 2005)
 ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 30 (level, low) -> IRQ 177
 eth0: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0e:7f:b4:69:94
 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
 eth0: dma_rwctrl[769f4000]
 ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 29 (level, low) -> IRQ 185
 eth1: Tigon3 [partno(N/A) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:0e:7f:b4:89:9f
 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
 eth1: dma_rwctrl[769f4000]
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 SvrWks CSB5: IDE controller at PCI slot 0000:00:0f.1
 SvrWks CSB5: chipset revision 147
 SvrWks CSB5: not 100% native mode: will probe irqs later
 SvrWks CSB5: simplex device: DMA forced
     ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
 SvrWks CSB5: simplex device: DMA forced
     ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
 hda: CRN-8245B, ATAPI CD/DVD-ROM drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: ATAPI 24X CD-ROM drive, 128kB Cache
 Uniform CD-ROM driver Revision: 3.20
 usbmon: debugfs is not available
 ACPI: PCI Interrupt Link [IUSB] enabled at IRQ 10
 ACPI: PCI Interrupt 0000:00:0f.2[A] -> Link [IUSB] -> GSI 10 (level, low) -> IRQ 10
 ohci_hcd 0000:00:0f.2: OHCI Host Controller
 ohci_hcd 0000:00:0f.2: new USB bus registered, assigned bus number 1
 ohci_hcd 0000:00:0f.2: irq 10, io mem 0xf5e70000
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 4 ports detected
 USB Universal Host Controller Interface driver v2.3
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.6:USB HID core driver
 mice: PS/2 mouse device common for all mice
 input: PC Speaker
 Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
 ALSA device list:
   No soundcards found.
 NET: Registered protocol family 2
 IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
 TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
 TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
 TCP: Hash tables configured (established 524288 bind 65536)
 TCP reno registered
 IPv4 over IPv4 tunneling driver
 TCP bic registered
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 Starting balanced_irq
 Using IPI Shortcut mode
 Adding console on ttyS0 at I/O port 0x3f8 (options '115200')
-kjournald starting.  Commit interval 5 seconds
-EXT3-fs: mounted filesystem with ordered data mode.
-VFS: Mounted root (ext3 filesystem) readonly.
-Freeing unused kernel memory: 324k freed
-INIT: version 2.86 booting
+VFS: Cannot open root device "cciss/c0d0p1" or unknown-block(104,1)
+Please append a correct "root=" boot option
+Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(104,1)
