Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSFCJV7>; Mon, 3 Jun 2002 05:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317330AbSFCJV6>; Mon, 3 Jun 2002 05:21:58 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:57675 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317329AbSFCJUf> convert rfc822-to-8bit; Mon, 3 Jun 2002 05:20:35 -0400
Subject: [2.5.20-BUG] 3c59x + highmem + acpi + nfs -> kernel panic
From: Anton Altaparmakov <aia21@cantab.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Jun 2002 10:20:33 +0100
Message-Id: <1023096034.19717.62.camel@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just got this (reproducible) kernel panic (BUG in
asm-i386/highmem.h::kmap_atomic(), the if (!pte_none(*(kmap_pte-idx)))
BUG(); triggers). It happens every time I boot and on an NFS mount do a
./configure.

I am now seeing this error during boot as well. Don't know if it is
related:

---snip---
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c590 Vortex 10Mbps at 0xe800. Vers LK1.1.17
00:09.0: Overriding PCI latency timer (CFLT) setting of 32, new value is
248.
 ***INVALID CHECKSUM 002f*** phy=0, phyx=24, mii_status=0x782d
---snip---

Note that on previous kernels it says:

---snip---
PCI: Assigned IRQ 11 for device 00:09.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c905C Tornado at 0xe800. Vers LK1.1.17
phy=0, phyx=24, mii_status=0x782d
---snip---

Note the Assigned IRQ message is missing in 2.5.20. Also the 2.5.20
kernel (ACPI) decides to use PIC routing for interrupts instead of
IOAPIC as it did before. Possibly also related? - Booting with APM
instead of ACPI causes same panic as before.

Note mii-tool on 2.5.20 doesn't work, and it works on older kernels.

The decoded oops, lspci output, as well as the full dmesg from booting
2.5.20 together with my .config is below. Note this is on a 1G RAM,
Athlon Epox 8kta3 mobo, highmem enabled kernel, UP kernel.

Anyone have any ideas? Is my network card toast or the kernel? (Note
booting back into 2.4.18 still works fine.)

Best regards,

	Anton

---decoded oops---
ksymoops 2.4.5 on i686 2.5.20.  Options used
     -v /usr/src/tng/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.20/ (default)
     -m /boot/System.map-2.5.20 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid
lsmod file?
kernel BUG at /usr/src/tng/include/asm/highmem.h:93!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c02acb69>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: c19cac88   ebx: 00001000   ecx: fffee000   edx: c0002fd4
esi: 00000000   edi: 3eaa5163   ebp: 00002000   esp: f70c9c30
ds: 0018   es: 0018   ss: 0018
Stack: f70cd2fc f7dd1a04 f75ce11c 00002080 00002080 c02a5472 f75ce11c
00000000 
       f70c9c64 c02a53b0 f76c8034 00000008 8f201114 f7dd1a04 00000088
00002000 
       c02a48e7 f75ce0e0 b20311f1 c02a5690 f75ce11c f7dd1a04 f7dd1a04
f75ce000 
Call Trace: [<c02a5472>] [<c02a53b0>] [<c02a48e7>] [<c02a5690>]
[<c02a4d19>] 
   [<c02918f7>] [<c0291c6d>] [<c0291c84>] [<c0276e63>] [<c02a703d>]
[<c02760b6>] 
   [<c0276405>] [<c0266680>] [<c026a31f>] [<c026a3bd>] [<c021172f>]
[<c026a4dc>] 
   [<c01088e9>] [<c011954b>] [<c0108a8c>] [<c0107543>] [<c01b19d9>]
[<c0123a5a>] 
   [<c012d8df>] [<c01246dd>] [<c01b2dd1>] [<c0111c6c>] [<c0114bb5>]
[<c0114d64>] 
   [<c01088e9>] [<c011954b>] [<c0111ad0>] [<c01075fc>] 
Code: 0f 0b 5d 00 e0 6b 2b c0 2b 05 4c 8d 3f c0 69 c0 cd cc cc cc 


>>EIP; c02acb69 <xdr_partial_copy_from_skb+c9/1a0>   <=====

>>eax; c19cac88 <END_OF_CODE+15a5cf4/????>
>>ebx; 00001000 Before first symbol
>>ecx; fffee000 <END_OF_CODE+3fbc906c/????>
>>edx; c0002fd4 Before first symbol
>>edi; 3eaa5163 Before first symbol
>>ebp; 00002000 Before first symbol
>>esp; f70c9c30 <END_OF_CODE+36ca4c9c/????>

Trace; c02a5472 <csum_partial_copy_to_xdr+52/f0>
Trace; c02a53b0 <skb_read_and_csum_bits+0/70>
Trace; c02a48e7 <call_decode+127/150>
Trace; c02a5690 <udp_data_ready+180/230>
Trace; c02a4d19 <xprt_release_write+29/60>
Trace; c02918f7 <udp_queue_rcv_skb+67/b0>
Trace; c0291c6d <udp_rcv+11d/290>
Trace; c0291c84 <udp_rcv+134/290>
Trace; c0276e63 <ip_defrag+f3/120>
Trace; c02a703d <__rpc_sleep_on+1ad/1c0>
Trace; c02760b6 <ip_local_deliver+b6/130>
Trace; c0276405 <ip_rcv+2d5/330>
Trace; c0266680 <alloc_skb+d0/190>
Trace; c026a31f <netif_receive_skb+ff/130>
Trace; c026a3bd <process_backlog+6d/120>
Trace; c021172f <boomerang_interrupt+12f/3f0>
Trace; c026a4dc <net_rx_action+6c/100>
Trace; c01088e9 <handle_IRQ_event+39/60>
Trace; c011954b <do_softirq+4b/90>
Trace; c0108a8c <do_IRQ+9c/b0>
Trace; c0107543 <common_interrupt+1f/24>
Trace; c01b19d9 <fast_copy_page+49/f0>
Trace; c0123a5a <do_wp_page+22a/410>
Trace; c012d8df <__alloc_pages+4f/1c0>
Trace; c01246dd <handle_mm_fault+9d/110>
Trace; c01b2dd1 <rb_insert_color+c1/f0>
Trace; c0111c6c <do_page_fault+19c/48f>
Trace; c0114bb5 <do_fork+485/770>
Trace; c0114d64 <do_fork+634/770>
Trace; c01088e9 <handle_IRQ_event+39/60>
Trace; c011954b <do_softirq+4b/90>
Trace; c0111ad0 <do_page_fault+0/48f>
Trace; c01075fc <error_code+34/3c>

Code;  c02acb69 <xdr_partial_copy_from_skb+c9/1a0>
00000000 <_EIP>:
Code;  c02acb69 <xdr_partial_copy_from_skb+c9/1a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c02acb6b <xdr_partial_copy_from_skb+cb/1a0>
   2:   5d                        pop    %ebp
Code;  c02acb6c <xdr_partial_copy_from_skb+cc/1a0>
   3:   00 e0                     add    %ah,%al
Code;  c02acb6e <xdr_partial_copy_from_skb+ce/1a0>
   5:   6b 2b c0                  imul   $0xffffffc0,(%ebx),%ebp
Code;  c02acb71 <xdr_partial_copy_from_skb+d1/1a0>
   8:   2b 05 4c 8d 3f c0         sub    0xc03f8d4c,%eax
Code;  c02acb77 <xdr_partial_copy_from_skb+d7/1a0>
   e:   69 c0 cd cc cc cc         imul   $0xcccccccd,%eax,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.
---decoded ooops---

---lspci---
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Flags: bus master, medium devsel, latency 8
	Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d2000000-d4ffffff
	Prefetchable memory behind bridge: d0000000-d1ffffff
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000 [size=16]
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d400 [size=32]
	Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d800 [size=32]
	Capabilities: <available only to root>

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Flags: medium devsel, IRQ 9
	Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
	Subsystem: VIA Technologies, Inc.: Unknown device 4511
	Flags: medium devsel, IRQ 12
	I/O ports at dc00 [size=256]
	I/O ports at e000 [size=4]
	I/O ports at e400 [size=4]
	Capabilities: <available only to root>

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Flags: bus master, medium devsel, latency 248, IRQ 11
	I/O ports at e800 [size=128]
	Memory at d6100000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

00:0b.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04) (prog-if 00 [VGA])
---lspci---

---dmesg from booting 2.5.20 with ACPI debug statements enabled---
Linux version 2.5.20 (aia21@drop) (gcc version 2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Mon Jun 3 09:58:45 BST 2002
Video mode to be used for restore is f06
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 262128
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32752 pages.
ACPI: RSDP (v000 VIA694                     ) @ 0x000f79f0
ACPI: RSDT (v001 VIA694 AWRDACPI 16944.11825) @ 0x3fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 16944.11825) @ 0x3fff3040
ACPI: MADT not present
Kernel command line: BOOT_IMAGE=l2520 ro root=301 console=ttyS1,115200n8 console=tty0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1336.378 MHz processor.
Console: colour VGA+ 80x34
Calibrating delay loop... 2667.31 BogoMIPS
Memory: 1034440k/1048512k available (1817k kernel code, 13688k reserved, 1066k data, 224k init, 131008k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1336.3654 MHz.
..... host bus clock speed is 267.2731 MHz.
cpu: 0, clocks: 2672731, slice: 1336365
CPU0<T0:2672720,T1:1336352,D:3,S:1336365,C:2672731>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20020517
 tbxface-0100 [03] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:................................................................................
Table [DSDT] - 361 Objects with 36 Devices 80 Methods 23 Regions
ACPI Namespace successfully loaded at root c0423f7c
spurious 8259A interrupt: IRQ7.
evxfevnt-0076 [04] Acpi_enable           : Transition to ACPI mode successful
Executing all Device _STA and_INI methods:....................................
36 Devices found containing: 36 _STA, 1 _INI methods
Completing Region/Field/Buffer/Package initialization:...............................................
Initialized 19/23 Regions 5/6 Fields 15/16 Buffers 8/8 Packages (361 nodes)
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
usb.c: registered new driver usbfs
usb.c: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi'
Starting kswapd
highmem bounce pool size: 64 pages
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Journalled Block Device driver loaded
udf: registering filesystem
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.11
Non-volatile memory driver v1.1
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xc0000000 256MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
block: 512 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c590 Vortex 10Mbps at 0xe800. Vers LK1.1.17
00:09.0: Overriding PCI latency timer (CFLT) setting of 32, new value is 248.
 ***INVALID CHECKSUM 002f*** phy=0, phyx=24, mii_status=0x782d
Linux video capture interface: v1.00
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: VIA Technologies, Inc. Bus Master IDE, PCI slot 00:07.1
ATA: chipset rev.: 6
ATA: non-legacy mode: IRQ probe delayed
VP_IDE: VIA vt82c686b (rev 40) ATA UDMA100 controller on PCI 00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVER07-0, DISK drive
hdc: LITE-ON LTR-12102B, ATAPI CD/DVD-ROM drive
hdd: Maxtor 90288D2, DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: tagged command queueing enabled, command queue depth 32
 hda: 80418240 sectors w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
 hda: [PTBL] [5005/255/63] hda1 hda2 < hda5 hda6 hda7 >
 hdd: 5627664 sectors w/256KiB Cache, CHS=5583/16/63, UDMA(33)
 hdd: [PTBL] [697/128/63] hdd1 hdd2 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 >
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
usb-uhci-hcd.c: High bandwidth mode enabled.
hcd.c: usb-uhci-hcd @ 00:07.2, VIA Technologies, Inc. UHCI USB
hcd.c: irq 5, io base 0000d400
hcd.c: new USB bus registered, assigned bus number 1
usb-uhci-hcd.c: Detected 2 ports
hcd.c: 00:07.2 root hub device address 1
usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
Manufacturer: Linux 2.5.20 usb-uhci-hcd
Product: VIA Technologies, Inc. UHCI USB
SerialNumber: 00:07.2
hub.c: USB hub found at /
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7fe739c
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
hcd.c: usb-uhci-hcd @ 00:07.3, VIA Technologies, Inc. UHCI USB (#2)
hcd.c: irq 5, io base 0000d800
hcd.c: new USB bus registered, assigned bus number 2
usb-uhci-hcd.c: Detected 2 ports
hcd.c: 00:07.3 root hub device address 1
usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
Manufacturer: Linux 2.5.20 usb-uhci-hcd
Product: VIA Technologies, Inc. UHCI USB (#2)
SerialNumber: 00:07.3
hub.c: USB hub found at /
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7fe74a4
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registering 16 minors, starting at 96
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.31:USB HID core driver
mice: PS/2 mouse device common for all mice
Advanced Linux Sound Architecture Driver Version 0.9.0rc1 (Mon Apr 29 06:46:09 2002 UTC).
hub.c: port 1, portstatus 101, change 3, 12 Mb/s
hub.c: hub / port 1 connection change
hub.c: hub / port 1, portstatus 101, change 3, 12 Mb/s
hub.c: port 1, portstatus 101, change 2, 12 Mb/s
hub.c: port 1, portstatus 101, change 2, 12 Mb/s
hub.c: port 1, portstatus 101, change 2, 12 Mb/s
ALSA device list:
  #0: VIA 82C686A/B at 0xdc00, irq 12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
IPv4 over IPv4 tunneling driver
hub.c: port 1, portstatus 101, change 2, 12 Mb/s
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux IPX 0.48 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: new USB device 00:07.2-1, assigned address 2
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
Manufacturer: Chicony 
Product: Generic USB Hub
hub.c: USB hub found at 1
hub.c: 3 ports detected
hub.c: part of a compound device
hub.c: individual port power switching
hub.c: individual port over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 100ms
hub.c: hub controller current requirement: 90mA
hub.c: port removable status: FRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7fe7ad4
usb.c: kusbd: /sbin/hotplug add 2
hub.c: port 2, portstatus 301, change 3, 1.5 Mb/s
hub.c: hub / port 2 connection change
hub.c: hub / port 2, portstatus 301, change 3, 1.5 Mb/s
hub.c: port 2, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 2, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 2, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 2, portstatus 301, change 2, 1.5 Mb/s
hub.c: port 2, portstatus 303, change 0, 1.5 Mb/s
hub.c: new USB device 00:07.2-2, assigned address 3
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
Manufacturer: Microsoft
Product: Microsoft IntelliMouse® Optical
usb-uhci-hcd.c: ENXIO (Control)  80000300, flags 0, urb f7c0812c, burb f7c080c4, probably device driver bug...
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=3/45e/39/121 NAME=Microsoft Microsoft IntelliMouse® Optical]
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-00:07.2-2
usb.c: hid driver claimed interface f7fe7bdc
usb.c: kusbd: /sbin/hotplug add 3
hub.c: port 1, portstatus 101, change 1, 12 Mb/s
hub.c: hub 1 port 1 connection change
hub.c: hub 1 port 1, portstatus 101, change 1, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 101, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 10, 12 Mb/s
hub.c: new USB device 00:07.2-1.1, assigned address 4
usb.c: new device strings: Mfr=3, Product=4, SerialNumber=0
Manufacturer: Chicony 
Product: PFU-65 USB Keyboard
usb-uhci-hcd.c: ENXIO (Control)  80000400, flags 0, urb f7c08404, burb f7c0839c, probably device driver bug...
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=3/472/65/100 NAME=Chicony  PFU-65 USB Keyboard]
input: USB HID v1.00 Keyboard [Chicony  PFU-65 USB Keyboard] on usb-00:07.2-1.1
usb.c: hid driver claimed interface f7fe7ce4
usb.c: kusbd: /sbin/hotplug add 4
hub.c: port 2, portstatus 100, change 0, 12 Mb/s
hub.c: port 3, portstatus 100, change 0, 12 Mb/s
hub.c: port 1, portstatus 103, change 0, 12 Mb/s
hub.c: port 2, portstatus 303, change 0, 1.5 Mb/s
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: hub / port 1 connection change
hub.c: hub / port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: hub / port 2 connection change
hub.c: hub / port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1, portstatus 300, change 2, 1.5 Mb/s
hub.c: hub / port 1 enable change, status 300
hub.c: port 2, portstatus 300, change 2, 1.5 Mb/s
hub.c: hub / port 2 enable change, status 300
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
Adding Swap: 2016116k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: Using codepage cp850
FAT: Using IO charset iso8859-1
---dmesg from booting 2.5.20 with ACPI debug statements enabled---

---.config---
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHPTE is not set
CONFIG_HIGHMEM=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y

#
# General options
#

#
# ACPI Support
#
CONFIG_ACPI=y
# CONFIG_ACPI_HT_ONLY is not set
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_IPX=y
# CONFIG_IPX_INTERN is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDE_TCQ=y
CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC6280_BURST is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_BLK_DEV_SL82C105 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_IVB is not set
CONFIG_ATAPI=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1152
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=864
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_GAMEPORT_PCIGAME is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_PROC=y

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_MGA=y
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
# CONFIG_VIDEO_ZORAN_LML33 is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_EXT2_FS is not set
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=y
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="iso8859-15"
CONFIG_NCP_FS=y
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_UTF8=y

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT0197H is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA686=y
# CONFIG_SND_VIA8233 is not set

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_LONG_TIMEOUT is not set
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# CONFIG_USB_WACOM is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QW is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_HIGHMEM=y

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
# CONFIG_ZLIB_DEFLATE is not set
---.config---

-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
