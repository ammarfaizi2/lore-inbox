Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319492AbSH3I0O>; Fri, 30 Aug 2002 04:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319493AbSH3I0O>; Fri, 30 Aug 2002 04:26:14 -0400
Received: from employees.nextframe.net ([212.169.100.200]:48369 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S319492AbSH3I0F>; Fri, 30 Aug 2002 04:26:05 -0400
Date: Fri, 30 Aug 2002 10:30:46 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: vantuyl@csc.smsu.edu, bryon@csc.smsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [qlogicisp.c PROBLEM 2.5] OOPS: "Unable to handle kernel paging request ..."
Message-ID: <20020830103046.B107@sexything>
Reply-To: morten.helgesen@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Jason and Bryon!

Got this one last night - it is def. reproducible. Vanilla 2.5.32.

Haven't got time to look into this myself until tonight, so I thought
I should let you guys know. 

Anyone on lkml with comments ? I don`t get this OOPS with 2.4.19, and 
the changes from qlogicisp.c in 2.4.19 to qlogicisp.c in 2.5.32 look
minimal. Only cli -> spinlock and io_request_lock -> host->host_lock
as far as I can see from a quick glance.


[OOPS]

Unable to handle kernel paging request at virtual address 01000100
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<01000100>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 01000100   ebx: cfe18180   ecx: 00000007   edx: 00000007
esi: 00000002   edi: 0000000c   ebp: cfe4f400   esp: c0345f00
ds: 0068   es: 0068   ss: 0068
Stack: c01fd22b cfe4f400 c0344000 00000002 0000000c c0345f8c 00000007 00000007
       cfe81950 cfe81800 c01fcfa3 0000000c cfe81800 c0345f8c cfe46940 24000001
       c010909d 0000000c cfe81800 c0345f8c c0344000 c0344000 c0366c00 c0345f84
Call Trace: [<c01fd22b>] [<c01fcfa3>] [<c010909d>] [<c0109255>] [<c0105300>]
   [<c0105300>] [<c0107d04>] [<c0105300>] [<c0105300>] [<c0105323>] [<c01053b3>]
   [<c0105000>] [<c010504d>]
Code:  Bad EIP value.


>>EIP; 01000100 Before first symbol   <=====

>>eax; 01000100 Before first symbol
>>ebx; cfe18180 <END_OF_CODE+fa737f8/????>
>>ebp; cfe4f400 <END_OF_CODE+faaaa78/????>
>>esp; c0345f00 <init_thread_union+1f00/2000>

Trace; c01fd22b <isp1020_intr_handler+26b/2a0>
Trace; c01fcfa3 <do_isp1020_intr_handler+23/40>
Trace; c010909d <handle_IRQ_event+2d/50>
Trace; c0109255 <do_IRQ+95/110>
Trace; c0105300 <default_idle+0/30>
Trace; c0105300 <default_idle+0/30>
Trace; c0107d04 <common_interrupt+18/20>
Trace; c0105300 <default_idle+0/30>
Trace; c0105300 <default_idle+0/30>
Trace; c0105323 <default_idle+23/30>
Trace; c01053b3 <cpu_idle+33/50>
Trace; c0105000 <_stext+0/0>
Trace; c010504d <rest_init+4d/50>

<0>Kernel panic: Aiee, killing interrupt handler!


[SYSTEM INFORMATION]

[22:37][morten@sexything:~]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1000.157
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
syscall mmxext 3dnowext 3dnow
bogomips        : 1961.98

[22:34][morten@sexything:/]$ /sbin/lspci -vv | more
...
00:0d.0 SCSI storage controller: Q Logic ISP1020 (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at da001000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
...


[ WHOLE BOOTPROCESS (WITH DEBUG ENABLED IN qlogicisp.c) LOGGED VIA SERIAL ]

Linux version 2.5.32 (morten@sexything) (gcc version 2.95.3 20010315 (release)) #14 Thu Aug 29 21:41:06 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=home-2.5.32 ro root=303 video=matrox:vesa:0x115 profile=2 console=ttyS0,115200 console=tty0
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1000.169 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1961.98 BogoMIPS
Memory: 254292k/262080k available (1598k kernel code, 7404k reserved, 724k data, 128k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 999.0929 MHz.
..... host bus clock speed is 199.0985 MHz.
cpu: 0, clocks: 199985, slice: 99992
CPU0<T0:199984,T1:99984,D:8,S:99992,C:199985>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
spurious 8259A interrupt: IRQ7.
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
aio_setup: sizeof(struct page) = 40
Capability LSM initialized
PCI: Disabling Via external APIC routing
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 800x600x32bpp (virtual: 800x5241)
matroxfb: framebuffer at 0xD4000000, mapped to 0xd0805000, size 33554432
Console: switching to colour frame buffer device 100x37
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.06
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Maximum main memory to use for agp memory: 203M
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
block: 256 slots per queue, batch=32
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PCI: Found IRQ 5 for device 00:09.0
PCI: Sharing IRQ 5 with 00:13.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:09.0: 3Com PCI 3c905C Tornado at 0xcc00. Vers LK1.1.18
phy=0, phyx=24, mii_status=0x782d
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 5 for device 00:13.0
PCI: Sharing IRQ 5 with 00:09.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:pio
hda: WDC WD273BA, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 53464320 sectors (27374 MB) w/1961KiB Cache, CHS=3328/255/63, UDMA(33)
 hda: hda1 hda2 hda3
SCSI subsystem driver Revision: 1.00
isp1020 : entering isp1020_detect()
PCI: Found IRQ 12 for device 00:0d.0
isp1020 : entering isp1020_init()
qlogicisp : new isp1020 revision ID (2)
isp1020 : leaving isp1020_init()
isp1020 : entering isp1020_reset_hardware()
qlogicisp : mbox 0 0x0004
qlogicisp : mbox 1 0x4953
qlogicisp : mbox 2 0x5020
qlogicisp : mbox 3 0x2020
qlogicisp : mbox 4 0x0001
qlogicisp : mbox 5 0x0004
qlogicisp : loading risc ram
qlogicisp : verifying checksum
qlogicisp : executing firmware
qlogicisp : firmware major revision 7
qlogicisp : firmware minor revision 63
isp1020 : leaving isp1020_reset_hardware()
isp1020 : entering isp1020_set_defaults()
isp1020 : leaving isp1020_set_defaults()
isp1020 : entering isp1020_load_parameters()
isp1020 : leaving isp1020_load_parameters()
isp1020 : leaving isp1020_detect()
isp1020 : entering isp1020_info()
isp1020 : leaving isp1020_info()
scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 68 irq 12 MEM base 0xd2806000
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x00, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x01, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x02, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001d, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x03, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x04, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
scsi: device set offline - command error recover failed: host 0 channel 0 id 4 lun 0
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x05, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
./qlogicisp-oops lines 277-323/561 55%
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x06, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x08, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x09, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x0a, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x0b, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x0c, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001d, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x0d, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x0e, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001e, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
isp1020 : entering isp1020_queuecommand()
qlogicisp : target = 0x0f, lun = 0x00, cmd_len = 0x06
qlogicisp : command = 0x12 0x00 0x00 0x00 0x24 0x00
qlogicisp : request queue depth 0
isp1020 : leaving isp1020_queuecommand()
isp1020 : entering isp1020_intr_handler()
qlogicisp : interrupt on line 12
qlogicisp : response queue update
qlogicisp : response queue depth 1
qlogicisp : entry count = 0x01, type = 0x03, flags = 0x00
qlogicisp : scsi status = 0x0000, completion status = 0x0001
qlogicisp : state flags = 0x0100, status flags = 0x0040
qlogicisp : time = 0x001d, request sense length = 0x0001
qlogicisp : residual transfer length = 0x00000012
qlogicisp : sense data = 0x80
isp1020 : entering isp1020_return_status()
qlogicisp : completion status = 0x0001
qlogicisp : host status (DID_BAD_TARGET) scsi status 0
isp1020 : leaving isp1020_return_status()
isp1020 : leaving isp1020_intr_handler()
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
matroxfb_crtc2: secondary head of fb0 was registered as fb1
mice: PS/2 mouse device common for all mice
logibm.c: Didn't find Logitech busmouse at 0x23c
input.c: hotplug returned -16
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ds: no socket drivers loaded!
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device ide0(3,3), size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age
30, max trans age 30
reiserfs: checking transaction log (ide0(3,3)) for (ide0(3,3))
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 128k freed
Unable to handle kernel paging request at virtual address 01000100
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<01000100>]    Not tainted
EFLAGS: 00010086
eax: 01000100   ebx: cfe18180   ecx: 00000007   edx: 00000007
esi: 00000002   edi: 0000000c   ebp: cfe4f400   esp: c0347f00
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c0346000 task=c02fda00)
Stack: c01fd45b cfe4f400 c0346000 00000002 0000000c c0347f8c 00000007 00000007
       cfe81950 cfe81800 c01fd113 0000000c cfe81800 c0347f8c cfe46940 24000001
       c010909d 0000000c cfe81800 c0347f8c c0346000 c0346000 c0368c00 c0347f84
Call Trace: [<c01fd45b>] [<c01fd113>] [<c010909d>] [<c0109255>] [<c0105300>]
   [<c0105300>] [<c0107d04>] [<c0105300>] [<c0105300>] [<c0105323>] [<c01053b3>]
   [<c0105000>] [<c010504d>]

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


As as said, I`ll look into this tonight as I don`t have the ATTO controller (with ISP1020 chip)
available here at work. I`ll let you know.

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
