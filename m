Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTIRU2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 16:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTIRU2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 16:28:15 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:49796 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262119AbTIRU2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 16:28:00 -0400
Date: Thu, 18 Sep 2003 22:27:58 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: BUG at mm/memory.c:1501 in 2.6.0-test5
Message-ID: <20030918202758.GA26435@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  yesterday night I shut down VMware virtual machine. About 20 seconds
after that I decided to close VMware UI, and bad thing happened - VMware's
window was partially obscuring xterm, and when I closed UI, only
upper half of VMware window disappeared, until place where xterm window
ended. Bottom half of window was left here, and X server died.

     +========+
     |        |
 +===|        |          +=====+
 |xte| VMware |    =>    |xterm|
 +---|        |          +-----+------+
     |        |              |        |
     +--------+		     +--------+

  Investigation revealed that X server got killed as shown below (unfortunately
stack trace is a bit suspicious - couple of stale entries is printed due
to quality of gcc 3 in eliminating unused local variables & aligning stack
to 16byte boundaries), with page_file() being set for some page whose
vma->vm_ops was NULL (vma->vm_ops == edx, vma == esi in dump below).

  Today I spent over 8 hours trying to find what wrong could VMware do
to the system and/or XFree, but as I was not able to explain it,
I think that I'll ask here. Maybe someone else will know how this could
happen. Only thing I know is that system was under big memory pressure
while VM was running, and that VMware I used uses fadvise(WILL_NEED)
with approx 128kB buffers before issuing actual pread(). But as this
happened in completely different process, it should not matter.

  Kernel is UP with all debugging enabled, DRI disabled, i8042 debugging
enabled. System is old 1G Athlon, A7V, 512MB RAM. MCE check is printed 
since we stopped setting bank 0 in -test3 or -test4, and I already 
reported this on L-K, with no conclusion.
						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz



drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [3664659]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux, 12) [3664666]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [3664667]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux, 12) [3664668]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [3664669]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [3664676]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux, 12) [3664677]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux, 12) [3664678]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [3664679]
------------[ cut here ]------------
kernel BUG at mm/memory.c:1501!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c015be10>]    Tainted: PF 
EFLAGS: 00013246
EIP is at do_file_page+0x170/0x180
eax: da54d3fc   ebx: db8938e4   ecx: daf0a404   edx: 00000000
esi: db35ce14   edi: 00000001   ebp: 404ffdf0   esp: daee1eb4
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 1456, threadinfo=daee0000 task=daf168e0)
Stack: c016e9bb daee1ecc 087de788 00001000 00000000 00000000 db8938e4 daf0a404 
       404ffdf0 00000001 c015bef6 db8938e4 db35ce14 404ffdf0 00000001 da54d3fc 
       daf0a404 daf168e0 db8938e4 db893904 db35ce14 daf168e0 c011da9c db8938e4 
Call Trace:
 [<c016e9bb>] do_sync_read+0x8b/0xc0              <<stale
 [<c015bef6>] handle_mm_fault+0xd6/0x2c0
 [<c011da9c>] do_page_fault+0x13c/0x46e			[152 byte stack]
 [<c013008b>] update_wall_time+0xb/0x40		  <<stale
 [<c013071f>] do_timer+0xdf/0xf0		  <<stale
 [<c01121ab>] timer_interrupt+0x14b/0x360	  <<stale
 [<c010c7c5>] do_IRQ+0x205/0x360		  <<stale
 [<c012713f>] profile_hook+0x1f/0x23		  <<stale
 [<c011d960>] do_page_fault+0x0/0x46e		  <<%edi pushed by do_page_fault prolog
 [<c010a775>] error_code+0x2d/0x38

Code: 0f 0b dd 05 0b 5e 38 c0 e9 c3 fe ff ff 8d 76 00 55 b8 00 e0 
 mm/mmap.c:1369: spin_lock(kernel/fork.c:db893928) already locked by mm/memory.c/1600
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux, 12) [3664865]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [3664866]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux, 12) [3664867]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [3664868]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [3664875]
drivers/input/serio/i8042.c: ff <- i8042 (interrupt, aux, 12) [3664876]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux, 12) [3664877]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux, 12) [3664879]
drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux, 12) [3664885]



Linux version 2.6.0-test5-c1315 (root@ppc) (gcc version 3.3.2 20030908 (Debian prerelease)) #3 Sun Sep 14 04:02:54 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6a90
ACPI: RSDT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V      0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V      0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux ro root=2107 video=matrox:vesa:0x117,fv:85 video=matroxfb:vesa:0x117,fv:85 nmi_watchdog=1 devfs=nomount
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1009.472 MHz processor.
Console: colour VGA+ 80x25
Memory: 514356k/524208k available (2444k kernel code, 9064k reserved, 715k data, 356k init, 0k highmem)
Calibrating delay loop... 1986.56 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1008.0834 MHz.
..... host bus clock speed is 201.0766 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1180, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x16bpp (virtual: 1024x8190)
matroxfb: framebuffer at 0xCE000000, mapped to 0xe080f000, size 33554432
Console: switching to colour frame buffer device 128x48
fb0: MATROX frame buffer device
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
ikconfig 0.6 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1 C2, 16 throttling states)
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PDC20265: IDE controller at PCI slot 0000:00:11.0
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:pio, hdh:pio
hde: ST3160023A, ATA DISK drive
ide2 at 0x9800-0x9807,0x9402 on irq 10
hdh: WDC WD1200BB-00CAA1, ATA DISK drive
ide3 at 0x9000-0x9007,0x8802 on irq 10
hde: max request size: 1024KiB
hde: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
hdh: max request size: 128KiB
hdh: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host2/bus1/target1/lun0: p1 p2 < p5 p6 >
hda: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
matroxfb_crtc2: secondary head of fb0 was registered as fb1
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:04.2: UHCI Host Controller
uhci-hcd 0000:00:04.2: irq 9, io base 0000d400
uhci-hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 0000:00:04.3: UHCI Host Controller
uhci-hcd 0000:00:04.3: irq 9, io base 0000d000
uhci-hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
mice: PS/2 mouse device common for all mice
input: PC Speaker
drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
...
drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [190]
drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [190]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [194]
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c /dev entries driver module version 2.7.0 (20021208)
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 9362)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 356k freed
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 2, assigned address 2
hub 2-2:0: USB hub found
hub 2-2:0: 4 ports detected
Adding 1959888k swap on /dev/hde6.  Priority:-1 extents:1
NTFS driver 2.1.4 [Flags: R/O MODULE].
NTFS volume version 3.1.
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xa000, IRQ 10, 00:C0:26:30:B0:2D.
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 0: f65980000000baff
