Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTFXADI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbTFXADI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:03:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264486AbTFXACs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:02:48 -0400
Subject: Re: 2.5.7[23]: wall-clock time advancing too rapidly?
From: Andy Pfiffer <andyp@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Andreas Haumer <andreas@xss.co.at>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1056154072.1027.13.camel@w-jstultz2.beaverton.ibm.com>
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
	 <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
	 <3EF32223.6000207@xss.co.at> <1056151705.1162.114.camel@andyp.pdx.osdl.net>
	 <1056154072.1027.13.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-upc+DGB2yayz6+i90/PH"
Organization: 
Message-Id: <1056413771.1209.14.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Jun 2003 17:16:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-upc+DGB2yayz6+i90/PH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-06-20 at 17:07, john stultz wrote:
> Alright, I've got a first pass at a patch that might solve this. 
> 
> This patch detects if we have 100 consecutive interrupts that find lost
> ticks. If that occurs, we assume that the TSC is changing frequency and
> we fall back to the PIT for a time source (equiv to booting w/
> clock=pit). 
> 
> I'd like to see this well tested as I don't want to prematurely disable
> the TSC if lost ticks is just doing its job, but I also want to catch
> speedstep cpus before folks notice time going out of control. So the #
> of consecutive interrupts may need adjusting. 
> 
> thanks
> -john
> 
> This patch can also be found under bugme bug #827
> http://bugme.osdl.org/show_bug.cgi?id=827

Hmmm... I tried the patch in 2.5.73 and it appeared to have no effect.
The system continues to advance what it thinks is wall-clock time by
about 7.25 seconds for every 15 seconds actual wall-clock time:

# foreach i ( 1 2 3 4 5 6 7 8 9 10 )
foreach? ntpdate ntp
foreach? sleep 15
foreach? end
23 Jun 17:08:42 ntpdate[1336]: <snip> offset -48.975254 sec
23 Jun 17:08:49 ntpdate[1338]: <snip> offset -7.286794 sec
23 Jun 17:08:57 ntpdate[1340]: <snip> offset -7.291861 sec
23 Jun 17:09:05 ntpdate[1342]: <snip> offset -7.288794 sec
23 Jun 17:09:13 ntpdate[1344]: <snip> offset -7.289806 sec
23 Jun 17:09:21 ntpdate[1346]: <snip> offset -7.293829 sec
23 Jun 17:09:29 ntpdate[1348]: <snip> offset -7.286798 sec
23 Jun 17:09:36 ntpdate[1350]: <snip> offset -7.289818 sec
23 Jun 17:09:44 ntpdate[1352]: <snip> offset -7.283786 sec
23 Jun 17:09:52 ntpdate[1354]: <snip> offset -7.285859 sec
# 


None of the printk's in the patch have been printed on the console.

Adding "clock=pit" continues to work as a workaround.

I have attached the output of dmesg from the boot of the kernel with the
patch present.


Andy

ps: cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 800.056
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1576.96





--=-upc+DGB2yayz6+i90/PH
Content-Disposition: attachment; filename=dmesg.patched
Content-Type: text/plain; name=dmesg.patched; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.5.73 (andyp@joe) (gcc version 2.95.3 20010315 (SuSE)) #3 SMP Mon Jun 23 16:56:30 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027fed140 (usable)
 BIOS-e820: 0000000027fed140 - 0000000027ff0000 (ACPI data)
 BIOS-e820: 0000000027ff0000 - 0000000028000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
639MB LOWMEM available.
found SMP MP-table at 0009ddd0
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
On node 0 totalpages: 163821
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 159725 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: xSeries 220  APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=linux-2.5.73 ro root=805 profile=2
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 800.056 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1576.96 BogoMIPS
Memory: 639300k/655284k available (2446k kernel code, 15192k reserved, 1335k data, 160k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.19 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Error: only one processor found.
ENABLING IO-APIC IRQs
Setting 14 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 14 ... ok.
Setting 13 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 13 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 14-0, 14-5, 14-9, 14-11, 14-15, 13-1, 13-2, 13-3, 13-4, 13-5, 13-6, 13-7, 13-8, 13-9, 13-10, 13-11, 13-13, 13-14, 13-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
number of MP IRQ sources: 13.
number of IO-APIC #14 registers: 16.
number of IO-APIC #13 registers: 16.
testing the IO APIC.......................

IO APIC #14......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0E000000
.......     : arbitration: 0E
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
 09 000 00  1    0    0   0   0    0    0    00
 0a 001 01  1    1    0   1   0    1    1    69
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  1    1    0   1   0    1    1    89
 01 000 00  1    0    0   0   0    0    0    00
 02 061 01  1    0    0   0   0    0    2    69
 03 0F2 02  1    0    0   0   0    1    2    E1
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  1    1    0   1   0    1    1    91
 0d 002 02  1    0    0   0   0    1    2    A8
 0e 0FD 0D  1    0    0   0   0    0    2    25
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ16 -> 1:0
IRQ26 -> 0:10
IRQ28 -> 1:12
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 799.0467 MHz.
..... host bus clock speed is 133.0244 MHz.
Starting migration thread for cpu 0
CPUS done 32
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd5dc, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: (B0,I9,P0) -> 16
PCI->APIC IRQ transform: (B0,I15,P0) -> 26
PCI->APIC IRQ transform: (B1,I3,P0) -> 28
pty: 256 Unix98 ptys configured
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: unable to determine aperture size.
agpgart: agp_backend_initialize() failed.
[drm] Initialized radeon 1.8.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Intel(R) PRO/100 Network Driver - version 2.3.13-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: LG CD-ROM CRD-8484B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.35
        <Adaptec aic7892 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 31, 16bit)
(scsi0:A:1): 160.000MB/s transfers (80.000MHz DT, offset 31, 16bit)
  Vendor: IBM-PSG   Model: ST318436LC    !#  Rev: 3281
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
  Vendor: IBM-PSG   Model: ST318436LC    !#  Rev: 3281
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 64
  Vendor: IBM       Model: YGLv3 S2          Rev: 0   
  Type:   Processor                          ANSI SCSI revision: 02
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35548320 512-byte hdwr sectors (18201 MB)
sdb: cache data unavailable
sdb: assuming drive cache: write through
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 8, lun 0,  type 3
mice: PS/2 mouse device common for all mice
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 530104k swap on /dev/sda6.  Priority:42 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
e100: eth0 NIC Link is Up 100 Mbps Full duplex
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining

--=-upc+DGB2yayz6+i90/PH--

