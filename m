Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267328AbUGNJMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267328AbUGNJMC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267329AbUGNJMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:12:01 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:11188 "EHLO
	mwinf0901.wanadoo.fr") by vger.kernel.org with ESMTP
	id S267328AbUGNJLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:11:36 -0400
Message-ID: <40F4F8C1.6070900@reolight.net>
Date: Wed, 14 Jul 2004 11:11:29 +0200
From: Auzanneau Gregory <greg@reolight.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: fr, fr-fr, en, en-gb, en-us
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc1 and before: IO-APIC + DRI + RTL8139 = Disabling Ethernet
 IRQ
References: <40F4635C.3090003@reolight.net> <20040714013903.A21905@electric-eye.fr.zoreil.com>
In-Reply-To: <20040714013903.A21905@electric-eye.fr.zoreil.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070208080109090408010106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070208080109090408010106
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit



Francois Romieu a écrit :
> Auzanneau Gregory <greg@reolight.net> :
> [...]
> 
>>[drm] Loading R200 Microcode
>>irq 19: nobody cared!
>> [<c010732a>] __report_bad_irq+0x2a/0x8b
>> [<c0107414>] note_interrupt+0x6f/0x9f
>> [<c0107732>] do_IRQ+0x161/0x192
>> [<c0105a00>] common_interrupt+0x18/0x20
>>handlers:
>>[<c0245383>] (rtl8139_interrupt+0x0/0x207)
>>Disabling IRQ #19
>>
>>For the moment I can disabling IO-ACPI, but I'm thinking to change my
>>processor with an processor w/HT. So IO-ACPI is enabling by default.
>>
>>How solve that ?
> 
> 
> Shot in the dark (+ quick look into drivers/char/drm):
> 
> drivers/char/drm/radeon_irq.c:
> [...]
> irqreturn_t DRM(irq_handler)( DRM_IRQ_ARGS )
> {
>         drm_device_t *dev = (drm_device_t *) arg;
>         drm_radeon_private_t *dev_priv =
>            (drm_radeon_private_t *)dev->dev_private;
>         u32 stat;
> 
>         /* Only consider the bits we're interested in - others could be used
>          * outside the DRM
>          */
> 
>>      stat = RADEON_READ(RADEON_GEN_INT_STATUS)
>>           & (RADEON_SW_INT_TEST | RADEON_CRTC_VBLANK_STAT);
>>      if (!stat)
>>              return IRQ_NONE;
> 
> 
> Can you turn the ">" lines into:
> 	stat = RADEON_READ(RADEON_GEN_INT_STATUS);
> 	if (!(stat & (RADEON_SW_INT_TEST | RADEON_CRTC_VBLANK_STAT))) {
> 		int ret = IRQ_NONE;
> 
> 		if (stat & ~(RADEON_SW_INT_TEST | RADEON_CRTC_VBLANK_STAT)) {
> 			DRM_INFO("Bingo !\n");
> 			ret = IRQ_HANDLED;
> 		}
> 		return ret;
> 	}
> 
> If it does not work, please send complete dmesg and lspci -vx.
> 

This seems change nothing. So, as you requested, I join my complete
dmesg and lspci.

Thank you all for the good work with linux, keep up with it ! :)

-- 
Auzanneau Grégory
GPG 0x99137BEE

--------------070208080109090408010106
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

001fe00000 (ACPI NVS)
 BIOS-e820: 000000001fe00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
509MB LOWMEM available.
found SMP MP-table at 000f67d0
On node 0 totalpages: 130544
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126448 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 HTCLTD                                    ) @ 0x000f67e0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1fdfb86e
ACPI: FADT (v001 Wistro AS1600   0x06040000 PTL  0x000f4240) @ 0x1fdfef14
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1fdfef88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1fdfefd8
ACPI: DSDT (v001   WIST      H2U 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 1
IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 16 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=LinuxNEW ro root=304 idebus=66 resume=/dev/hda6
ide_setup: idebus=66
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2590.392 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513112k/522176k available (2322k kernel code, 8288k reserved, 949k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5128.19 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Hyper-Threading is disabled
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 07
per-CPU timeslice cutoff: 1462.68 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Total of 1 processors activated (5128.19 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-17, 1-18, 1-19, 1-20, 1-21, 1-22, 1-23 not connected.
..TIMER: vector=0x31 pin1=16 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2589.0249 MHz.
..... host bus clock speed is 99.0586 MHz.
Brought up 1 CPUs
CPU0:  online
 domain 0: span 1
  groups: 1
  domain 1: span 1
   groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd649, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS962 that hid as a SIS503 (compatible=1)
Enabling SiS 96x SMBus.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 *10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 *7 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *4 7 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 *11)
ACPI: Embedded Controller [EC] (gpe 30)
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:02.3[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:02.6[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI interrupt 0000:00:09.1[B] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 24.
testing the IO APIC.......................
IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  1    0    0   0   0    1    1    41
 03 001 01  0    0    0   0   0    1    1    49
 04 001 01  0    0    0   0   0    1    1    51
 05 001 01  0    0    0   0   0    1    1    59
 06 001 01  0    0    0   0   0    1    1    61
 07 001 01  0    0    0   0   0    1    1    69
 08 001 01  0    0    0   0   0    1    1    71
 09 001 01  0    1    0   1   0    1    1    79
 0a 001 01  0    0    0   0   0    1    1    81
 0b 001 01  0    0    0   0   0    1    1    89
 0c 001 01  0    0    0   0   0    1    1    91
 0d 001 01  0    0    0   0   0    1    1    99
 0e 001 01  0    0    0   0   0    1    1    A1
 0f 001 01  0    0    0   0   0    1    1    A9
 10 001 01  1    1    0   1   0    1    1    B9
 11 001 01  1    1    0   1   0    1    1    B1
 12 001 01  1    1    0   1   0    1    1    C1
 13 001 01  1    1    0   1   0    1    1    E9
 14 001 01  1    1    0   1   0    1    1    C9
 15 001 01  1    1    0   1   0    1    1    D1
 16 001 01  1    1    0   1   0    1    1    D9
 17 001 01  1    1    0   1   0    1    1    E1
IRQ to pin mappings:
IRQ0 -> 0:16
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
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
vesafb: framebuffer at 0xf0000000, mapped to 0xe0807000, size 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:53bb
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Simple Boot Flag at 0x35 set to 0x1
Machine check exception polling timer started.
NTFS driver 2.1.15 [Flags: R/O].
udf: registering filesystem
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLP2]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRS] (49 C)
ACPI: Thermal Zone [THRC] (17 C)
Console: switching to colour frame buffer device 128x48
Real Time Clock Driver v1.12
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
8139too Fast Ethernet driver 0.9.27
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 19 (level, low) -> IRQ 19
eth0: RealTek RTL8139 at 0xe0b17000, 00:0a:e4:44:74:85, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: PCI interrupt 0000:00:02.5[A] -> GSI 16 (level, low) -> IRQ 16
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-RAM UJ-811, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 > hda3 hda4
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:03.3[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:03.3: Silicon Integrated Systems [SiS] USB 2.0 Controller
ehci_hcd 0000:00:03.3: irq 23, pci mem e0b19000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI interrupt 0000:00:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci_hcd 0000:00:03.0: Silicon Integrated Systems [SiS] USB 1.0 Controller
ohci_hcd 0000:00:03.0: irq 20, pci mem e0b1b000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.1[B] -> GSI 21 (level, low) -> IRQ 21
ohci_hcd 0000:00:03.1: Silicon Integrated Systems [SiS] USB 1.0 Controller (#2)
ohci_hcd 0000:00:03.1: irq 21, pci mem e0b1d000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:03.2[C] -> GSI 22 (level, low) -> IRQ 22
ohci_hcd 0000:00:03.2: Silicon Integrated Systems [SiS] USB 1.0 Controller (#3)
ohci_hcd 0000:00:03.2: irq 22, pci mem e0b1f000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17 14:31:44 2004 UTC).
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 18 (level, low) -> IRQ 18
usb 2-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:03.0-1
intel8x0_measure_ac97_clock: measured 49520 usecs
intel8x0: clocking to 48000
ALSA device list:
  #0: SiS SI7012 at 0x1400, irq 18
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
Adding 514040k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda4, internal journal
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 646 chipset
agpgart: Maximum main memory to use for agp memory: 437M
agpgart: AGP aperture is 64M @ 0xe8000000
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
Yenta: CardBus bridge found at 0000:00:09.0 [17c0:3202]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:09.0, mfunc 0x01001022, devctl 0x64
Yenta: ISA IRQ mask 0x0cb8, PCI irq 16
Socket status: 30000006
ACPI: PCI interrupt 0000:00:09.1[B] -> GSI 17 (level, low) -> IRQ 17
Yenta: CardBus bridge found at 0000:00:09.1 [17c0:3202]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:09.1, mfunc 0x01001022, devctl 0x64
Yenta: ISA IRQ mask 0x0cb8, PCI irq 17
Socket status: 30000006
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
cs: IO port probe 0x0100-0x04ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
device ppp0 entered promiscuous mode
mtrr: 0xf0000000,0x4000000 overlaps existing 0xf0000000,0x200000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9]
mtrr: 0xf0000000,0x4000000 overlaps existing 0xf0000000,0x200000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
irq 19: nobody cared!
 [<c010732a>] __report_bad_irq+0x2a/0x8b
 [<c0107414>] note_interrupt+0x6f/0x9f
 [<c0107732>] do_IRQ+0x161/0x192
 [<c0105a00>] common_interrupt+0x18/0x20
handlers:
[<c0245383>] (rtl8139_interrupt+0x0/0x207)
Disabling IRQ #19

--------------070208080109090408010106
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host & Memory & AGP Controller (rev 01)
	Subsystem: Wistron Corp.: Unknown device 4000
	Flags: bus master, medium devsel, latency 64
	Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
00: 39 10 46 06 07 00 10 22 01 00 00 06 00 40 80 00
10: 00 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 00 40
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: ec100000-ec1fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
00: 39 10 01 00 07 00 00 00 00 00 04 06 00 63 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 44 a0 a0 00 20
20: 10 ec 10 ec 00 f0 f0 f7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 14)
	Flags: bus master, medium devsel, latency 0
00: 39 10 62 09 0f 00 00 02 14 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
	Flags: medium devsel, IRQ 17
	I/O ports at 9000 [size=32]
00: 39 10 16 00 01 00 80 02 00 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00

0000:00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller (prog-if 10 [OHCI])
	Subsystem: Wistron Corp.: Unknown device 1054
	Flags: bus master, medium devsel, latency 64, IRQ 17
	Memory at ec000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [64] Power Management version 2
00: 39 10 07 70 06 00 10 02 00 10 00 0c 00 40 00 00
10: 00 00 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 54 10
30: 00 00 00 00 64 00 00 00 00 00 00 00 0b 02 04 0c

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: Wistron Corp.: Unknown device 1056
	Flags: bus master, medium devsel, latency 128, IRQ 16
	I/O ports at 2000 [size=16]
00: 39 10 13 55 05 00 00 02 00 80 01 01 00 80 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 20 00 00 00 00 00 00 00 00 00 00 c0 17 56 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller (rev a0) (prog-if 00 [Generic])
	Subsystem: Wistron Corp.: Unknown device 1059
	Flags: medium devsel, IRQ 18
	I/O ports at 1000 [size=256]
	I/O ports at 1c00 [size=128]
	Capabilities: [48] Power Management version 2
00: 39 10 13 70 01 00 90 02 a0 00 03 07 00 ad 00 00
10: 01 10 00 00 01 1c 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 59 10
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 03 34 0b

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] Sound Controller (rev a0)
	Subsystem: Wistron Corp.: Unknown device 200a
	Flags: bus master, medium devsel, latency 173, IRQ 18
	I/O ports at 1400 [size=256]
	I/O ports at 1c80 [size=128]
	Capabilities: [48] Power Management version 2
00: 39 10 12 70 05 00 90 02 a0 00 01 04 00 ad 00 00
10: 01 14 00 00 81 1c 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 0a 20
30: 00 00 00 00 48 00 00 00 00 00 00 00 0b 03 34 0b

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Wistron Corp.: Unknown device 1056
	Flags: bus master, medium devsel, latency 64, IRQ 20
	Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: 39 10 01 70 17 00 90 02 0f 10 03 0c 00 40 80 00
10: 00 10 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 56 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 00 50

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Wistron Corp.: Unknown device 1056
	Flags: bus master, medium devsel, latency 64, IRQ 21
	Memory at ec002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: 39 10 01 70 17 00 90 02 0f 10 03 0c 00 40 00 00
10: 00 20 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 56 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 07 02 00 50

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: Wistron Corp.: Unknown device 1056
	Flags: bus master, medium devsel, latency 64, IRQ 22
	Memory at ec003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
00: 39 10 01 70 17 00 90 02 0f 10 03 0c 00 40 00 00
10: 00 30 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 56 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 04 03 00 50

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
	Subsystem: Wistron Corp.: Unknown device 1056
	Flags: bus master, medium devsel, latency 64, IRQ 23
	Memory at ec004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2
00: 39 10 02 70 06 00 90 02 00 20 03 0c 00 40 00 00
10: 00 40 00 ec 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 56 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 04 00 50

0000:00:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Wistron Corp.: Unknown device 1053
	Flags: bus master, medium devsel, latency 64, IRQ 19
	I/O ports at 1800 [size=256]
	Memory at ec005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 40 00 00
10: 01 18 00 00 00 50 00 ec 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 53 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40

0000:00:09.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller (rev 01)
	Subsystem: Wistron Corp.: Unknown device 3202
	Flags: bus master, medium devsel, latency 168, IRQ 16
	Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20400000-207ff000 (prefetchable)
	Memory window 1: 20800000-20bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001
00: 4c 10 55 ac 07 00 10 02 01 00 07 06 20 a8 82 00
10: 00 00 00 20 a0 00 00 02 00 02 05 b0 00 00 40 20
20: 00 f0 7f 20 00 00 80 20 00 f0 bf 20 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0b 01 c0 05
40: c0 17 02 32 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:09.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controller (rev 01)
	Subsystem: Wistron Corp.: Unknown device 3202
	Flags: bus master, medium devsel, latency 168, IRQ 17
	Memory at 20001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 20c00000-20fff000 (prefetchable)
	Memory window 1: 21000000-213ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001
00: 4c 10 55 ac 07 00 10 02 01 00 07 06 20 a8 82 00
10: 00 10 00 20 a0 00 00 02 00 06 09 b0 00 00 c0 20
20: 00 f0 ff 20 00 00 00 21 00 f0 3f 21 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 0b 02 c0 05
40: c0 17 02 32 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01) (prog-if 00 [VGA])
	Subsystem: Wistron Corp.: Unknown device 2058
	Flags: stepping, fast Back2Back, 66MHz, medium devsel, IRQ 16
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at a000 [size=256]
	Memory at ec100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2
00: 02 10 66 4c 83 02 b0 02 01 00 00 03 04 42 00 00
10: 08 00 00 f0 01 a0 00 00 00 00 10 ec 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c0 17 58 20
30: 00 00 00 00 58 00 00 00 00 00 00 00 0b 01 08 00


--------------070208080109090408010106--
