Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBGNBS>; Wed, 7 Feb 2001 08:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129065AbRBGNBH>; Wed, 7 Feb 2001 08:01:07 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:23315 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129047AbRBGNAw>;
	Wed, 7 Feb 2001 08:00:52 -0500
Date: Wed, 7 Feb 2001 13:58:24 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, hpa@transmeta.com, mikpe@csd.uu.se
Subject: UP APIC reenabling vs. cpu type detection ordering
Message-ID: <20010207135824.A24476@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Mikael Pettersson pointed to me that current kernel code should not
reenable local APIC on AMD K7, as it tests boot_cpu_data.x86_vendor.
But boot_cpu_data.x86_vendor is uninitialized (or contains wrong
value) when detect_init_APIC is invoked.

  As side effect I can confirm that APIC reenabling code works also on 
my AMD K7. 
  						Best regards,
  							Petr Vandrovec
  							vandrove@vc.cvut.cz

P.S.: I'm getting 'spurious 8259A interrupt: IRQ7' few seconds after boot. 
It does not cause any harm AFAIS.

int detect_init_APIC (void)
{
	u32 h, l, dummy, features;

	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
		printk("No APIC support for non-Intel processors.\n");
		return -1;
	}

	...

		rdmsr(MSR_IA32_APICBASE, l, h);
		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
			printk("Local APIC disabled by BIOS -- reenabling.\n");
			l &= ~MSR_IA32_APICBASE_BASE;
			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
			wrmsr(MSR_IA32_APICBASE, l, h);
		}
	}



Linux version 2.4.1-ac2-amd (root@ppc) (gcc version 2.95.3 20010125 (prerelease)) #1 Sun Feb 4 04:23:41 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009e800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000001800 @ 000000000009e800 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000feec000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 000000000ffec000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 000000000ffef000 (reserved)
 BIOS-e820: 0000000000001000 @ 000000000ffff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 65516
zone(0): 4096 pages.
zone(1): 61420 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffe000 (fee00000)
Kernel command line: BOOT_IMAGE=Linux ro root=2105 video=matrox:vesa:0x105,left:184,right:32 devfs=nomount
Initializing CPU#0
Detected 1009.017 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2011.95 BogoMIPS
Memory: 255604k/262064k available (910k kernel code, 6068k reserved, 356k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Getting VERSION: 40010
Getting VERSION: 40010
Getting ID: 1000000
Getting ID: e000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
setting K7_PERFCTR0 to ff6609f0
setting K7 LVTPC to DM_NMI
setting K7_EVNTSEL0 to 00530076
testing NMI watchdog ... OK.
calibrating APIC timer ...
..... CPU clock speed is 1008.9901 MHz.
..... host bus clock speed is 201.7980 MHz.
cpu: 0, clocks: 2017980, slice: 1008990
CPU0<T0:2017968,T1:1008976,D:2,S:1008990,C:2017980>
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169802kB/56600kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
hda: ATAPI-CD ROM-DRIVE-52MAX, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307045, ATA DISK drive
hdh: TOSHIBA MK6409MAV, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xa000-0xa007,0x9802 on irq 10
ide3 at 0x9400-0x9407,0x9002 on irq 10
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63
hdh: 12685680 sectors (6495 MB), CHS=13424/15/63
Partition check:
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [5606/255/63] p1 p2 < p5 p6 >
 /dev/ide/host2/bus1/target1/lun0: [PTBL] [839/240/63] p1 p2 < p5 > p4
Real Time Clock Driver v1.10d
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo KT133 @ 0xd0000000 256MB
[drm] Initialized mga 2.0.1 20000928 on minor 63
i2c-core.o: driver maven registered.
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
PCI: Found IRQ 5 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
uhci.c: USB UHCI at I/O 0xd400, IRQ 5
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF cff0ba00, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: d400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cff0ba00
usb.c: call_policy add, num 1 -- no FS yet
PCI: Found IRQ 5 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
uhci.c: USB UHCI at I/O 0xd000, IRQ 5
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF cff0bbc0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 2 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: d000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cff0bbc0
usb.c: call_policy add, num 2 -- no FS yet
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x8bpp (virtual: 1024x16380)
matroxfb: framebuffer at 0xCE000000, mapped to 0xd084b000, size 33554432
Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
i2c-dev.o: Registered 'DDC:fb0 #0 on i2c-matroxfb' as minor 0
i2c-core.o: adapter DDC:fb0 #0 on i2c-matroxfb registered as adapter 0.
i2c-dev.o: Registered 'DDC:fb0 #1 on i2c-matroxfb' as minor 1
i2c-core.o: adapter DDC:fb0 #1 on i2c-matroxfb registered as adapter 1.
i2c-dev.o: Registered 'MAVEN:fb0 on i2c-matroxfb' as minor 2
i2c-core.o: client [maven client] registered to adapter [MAVEN:fb0 on i2c-matroxfb](pos. 0).
i2c-core.o: adapter MAVEN:fb0 on i2c-matroxfb registered as adapter 2.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
uhci.c: root-hub INT complete: port1: 58a port2: 49b data: 6
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 3, 12 Mb/s
hub.c: port 2, portstatus 103, change 0, 12 Mb/s
hub.c: USB new device connect on bus2/2, assigned device number 3
spurious 8259A interrupt: IRQ7.
uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
usb.c: kmalloc IF cff0bec0, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 3 default language ID 0x409
uhci.c: root-hub INT complete: port1: 588 port2: 495 data: 2
Manufacturer: ALCOR
Product: Generic USB Hub
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 44ms
hub.c: hub controller current requirement: 100mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface cff0bec0
usb.c: kusbd: /sbin/hotplug add 3
usb.c: kusbd policy returned 0xfffffffe
uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
hub.c: port 1 enable change, status 300
hub.c: port 2 enable change, status 300
uhci.c: root-hub INT complete: port1: 588 port2: 495 data: 2
hub.c: port 1 enable change, status 300
Adding Swap: 522072k swap-space (priority -1)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
es1371: version v0.27 time 04:22:39 Feb  4 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
PCI: Found IRQ 12 for device 00:0a.0
es1371: found es1371 rev 6 at io 0xa400 irq 12
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A)
NET4: Linux IPX 0.43 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000 Conectiva, Inc.
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378, irq=7, dma=3
lp0: using parport0 (interrupt-driven).
/dev/vmmon: Module vmmon: registered with major=10 minor=165 tag=$Name: build-950 $
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 1014 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: peer interface eth0 not found, will wait for it to come up
bridge-eth0: attached
/dev/vmnet: open called by PID 1024 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 1036 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
