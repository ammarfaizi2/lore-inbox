Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbSKZD0j>; Mon, 25 Nov 2002 22:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbSKZD0j>; Mon, 25 Nov 2002 22:26:39 -0500
Received: from mail.wincom.net ([209.216.129.3]:61966 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S266078AbSKZD0e>;
	Mon, 25 Nov 2002 22:26:34 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Nov 102 22:31:12 -0500
Subject: Identifying/activating faster ATAxx modes (WAS kernel config tale of woe)
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3de2eee3.16fd.0@wincom.net>
X-User-Info: 24.57.83.120
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I mentioned earlier, once I got access back to the machine where I had the
problems described in the "Tale of Woe" micro-rant, I'd break those out into
their own threads; to separate philosophy from actual troubleshooting.

Well, mostly. I've got one philosophical point I want to touch briefly later
on.

Here's the ATA config issue.

Output from hdparm -I (which I understand queries the drive)

---------------------
/dev/hda:

ATA device, with non-removable media
        Model Number:       Maxtor 6E030L0
        Serial Number:      E106SZLE
        Firmware Revision:  NAR61590
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:   60058656
        device size with M = 1024*1024:       29325 MBytes
        device size with M = 1000*1000:       30750 MBytes (30 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum

        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
device size with M = 1024*1024:       29325 MBytes
        device size with M = 1000*1000:       30750 MBytes (30 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum

        R/W multiple sector transfer: Max = 16  Current = 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
           *    Automatic Acoustic Management feature set
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test
           *    SMART error logging
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

----------------------

Output from hdparm -i (which I understand comes from some sort of config at
boot time?)

/dev/hda:

 Model=Maxtor 6E030L0, FwRev=NAR61590, SerialNo=E106SZLE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60058656
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):  1 2 3 4 5 6 7

-------------------------

Output from hdparm -tT

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.44 seconds =290.91 MB/sec
 Timing buffered disk reads:  64 MB in  8.11 seconds =  7.89 MB/sec

These values fluctuate a bit, but are typically of this order. I've certainly
not seen it go much faster.

And finally, the relevant sections from dmesg

--------------------
Linux version 2.4.19 (root@x1-6-00-e0-18-ab-f7-6b) (gcc version 3.2 20020903
(Red Hat Linux 8.0 3.2-7)) #8 Fri Nov 22 23:43:47 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
Advanced speculative caching feature present
On node 0 totalpages: 131068
zone(0): 4096 pages.
zone(1): 126972 pages.
zone(2): 0 pages.
Kernel command line: ro root=LABEL=/ pci=biosirq agp_try_unsupported=1 parport=auto
ide0=ata66
ide_setup: ide0=ata66
Found and enabled local APIC!
Initializing CPU#0
Detected 1733.438 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3460.30 BogoMIPS
Memory: 515264k/524272k available (1503k kernel code, 8620k reserved, 531k data,
116k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.

Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff c1c3fbff 00000000, vendor = 2
Advanced speculative caching feature present
Disabling advanced speculative caching
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0383fbf7 c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbf7 c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbf7 c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2100+ stepping 02
Enabling fast FPU save and restore... done.
Enabling uChecking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1733.3222 MHz.
..... host bus clock speed is 266.6649 MHz.
cpu: 0, clocks: 2666649, slice: 1333324
CPU0<T0:2666640,T1:1333312,D:4,S:1333324,C:2666649>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport0: Printer, EPSON Stylus COLOR 740
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (interrupt-driven).
lp0: console ready

DoubleTalk PC - not found
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

VP_IDE: IDE controller on PCI bus 00 dev 89
PCI: No IRQ known for interrupt pin A of device 00:11.1.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik <vojtech@ucw.cz>
VP_IDE: ATA-66/100 forced bit set (WARNING)!!
hda: Maxtor 6E030L0, ATA DISK drive
hdc: 56X CD-ROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide0: probed IRQ 14 failed, using default.
ide1 at 0x170-0x177,0x376 on irq 15
ide1: probed IRQ 15 failed, using default.
hda: 60058656 sectors (30750 MB) w/2048KiB Cache, CHS=3738/255/63
hdc: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >

-----------------------

See? Not a whole lot of conclusive information about what is actually happening
with the drive setup at boot.

Somebody point me in the right place to start, and I'll happily cut an added
verbosity patch.

Quick philosphical point - it was expressed to me that "users shouldn't be compiling
kernels, that's the distro manager's job"

I could not POSSIBLY disagree more. What is Linux if not putting more power
in the hands of the people who actually use the system? Users should ABSOLUTELY
be compiling kernels, if they want to or need to. The trick is to pass on enough
information so as to give the guy on the pointy end of the compiler as best
a chance of success as can be done.

Is asking for a dmesg that states "this is an ATAxxx drive, and your interfacer
is using ATAyyy" really such a horrible thing to ask?

-----------

In any case, I will provide any other info anybody might wish on my system,
and thanks to those people who are offering help. It is appreciated.

DG





