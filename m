Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315175AbSEIWw0>; Thu, 9 May 2002 18:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315195AbSEIWwZ>; Thu, 9 May 2002 18:52:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S315175AbSEIWwU>;
	Thu, 9 May 2002 18:52:20 -0400
Subject: Re: [PATCH] Fix scsi.c kmod noise
From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020509164109.F11386@redhat.com>
Content-Type: multipart/mixed; boundary="=-so3t5pZqdzwRzxtMGjBf"
X-Mailer: Evolution/1.0.2 (1.0.2-3) 
Date: 09 May 2002 18:41:58 -0400
Message-Id: <1020984118.1847.7.camel@zorak.rdu.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-so3t5pZqdzwRzxtMGjBf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2002-05-09 at 16:41, Doug Ledford wrote: 
> On Thu, May 09, 2002 at 04:33:59PM -0400, Pete Zaitcev wrote:
> > > [...] This error crops up whenever scsi.c
> > > is compiled in (which is fairly common in 2.4, Red Hat Linux does this
> > > as well).
> > 
> > > "kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2"
> > 
> > > --- linux/drivers/scsi/scsi.c.OLD	Wed May  1 16:33:14 2002
> > > +++ linux/drivers/scsi/scsi.c	Wed May  1 16:34:46 2002
> > > @@ -2389,10 +2389,18 @@
> > 
> > > +/* This doesn't make much sense to do unless CONFIG_SCSI is a module itself.
> > > + *
> > > + * ~spot <tcallawa@redhat.com> 05012002
> > > + */
> > > +
> > > +#ifdef MODULE
> > >  #ifdef CONFIG_KMOD
> > >  		if (scsi_hosts == NULL)
> > >  			request_module("scsi_hostadapter");
> > >  #endif
> > > +#endif
> > >  		return scsi_register_device_module((struct Scsi_Device_Template *) ptr);
> > 
> > I do not see how you suppose this should work. What if scsi.c
> > is compiled in, and sunesp.c is not? Besides, why are you running
> > a kernel with CONFIG_KMOD if exec returns -ENOENT? I suspect
> > something is broken in the Aurora land.
> 
> Actually, it happens because of the standard initrd.  In the initrd we 
> load scsi_mod first, and on initialization scsi_mod attempt to 
> request_module the host adapter, but there is no /sbin/modprobe (and no 
> /etc/modules.conf for modprobe to read either) so you get the error above.  
> Then, the initrd continues on to load the specific scsi modules.  So, in 
> actuallity, it makes sense to *disable* this entire code section if scsi 
> is a module because it will *always* be loaded before the host adapter (it 
> has to for dependancy's sake) and will always be a failure.  When compiled 
> into the kernel I'm not sure it makes any sense either since if the scsi 
> driver isn't loaded yet, then where would we be getting modprobe and 
> /etc/modules.conf from?  It would either have to be an initrd (in which 
> case the linuxrc script can load the module manually) or / is on ide (or 
> something like that) which doesn't depend on our host adapter, in which 
> case it makes no sense to go around loading things without them being 
> specifically requested.  Personally, I think this code should just die, 
> period.

I agree, but I didn't want to make any sort of drastic changes to scsi.c
in Aurora (I'm still getting my feet wet here!). 

As to the claim that this is broken solely due to Aurora being broken, I
can dispell that simply by pointing to the fact that Red Hat Linux 7.3
exhibits this behavior as shipped, on machines where the scsi drivers
are modular. dmesg log from 2.4.18-3smp is attached to this email.

In fact, sunesp is modular in Aurora, which is how this issue came to
light. When I made the change from compiled in to modular (and started
using an initrd), several testers reported this as a bug. 

Feel free to correct me (and Doug) if I'm wrong, because I cede that you
know a HELL of a lot more about this than I do. My Aurora kernels use
this, the scsi subsystem works (the modules all load as they should),
and I don't have a kmod error message in dmesg. 

For reference, Aurora builds kernels with the following relevant
options: 

CONFIG_MODULES=y 
CONFIG_MODVERSIONS=y 
CONFIG_KMOD=y 

CONFIG_SCSI=y 
CONFIG_BLK_DEV_SD=y 

CONFIG_SCSI_SUNESP=m 


The Red Hat Linux 7.3 i686 config builds kernels with the following
relevant options: 

CONFIG_MODULES=y 
CONFIG_MODVERSIONS=y 
CONFIG_KMOD=y 

CONFIG_SCSI=m 
CONFIG_BLK_DEV_SD=m 

CONFIG_SCSI_AIC7XXX=m 

As a result of further testing and thought, I definitely agree with
Doug. The patch that I originally submitted will only get rid of the
kmod error noise when BLK_DEV_SD is compiled into the kernel. Perhaps
this block of code should die? I'll leave that to the experts to decide.

~spot
---
Tom "spot" Callaway <tcallawa@redhat.com> Red Hat Sales Engineer
Sair Linux and GNU Certified Administrator (LCA)
Red Hat Certified Engineer (RHCE)
GPG: D786 8B22 D9DB 1F8B 4AB7  448E 3C5E 99AD 9305 4260

The words and opinions reflected in this message do not necessarily
reflect those of my employer, Red Hat, and belong solely to me.

"Immature poets borrow, mature poets steal." --- T. S. Eliot

--=-so3t5pZqdzwRzxtMGjBf
Content-Disposition: attachment; filename=dmesg-2.4.18-3smp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc version 2.=
96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18 07:27:31 EDT 20=
02
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffe06c0 (usable)
 BIOS-e820: 000000001ffe06c0 - 000000001ffe66c0 (ACPI data)
 BIOS-e820: 000000001ffe66c0 - 000000001ffee700 (ACPI NVS)
 BIOS-e820: 000000001ffee700 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
found SMP MP-table at 0009fe00
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
hm, page 000eb000 reserved twice.
hm, page 000ec000 reserved twice.
On node 0 totalpages: 131040
zone(0): 4096 pages.
zone(1): 126944 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: IBM-PCCO Product ID: CDT-BIOS  MP APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 32 at 0xFEC00000.
Processors: 2
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: ro root=3D/dev/hda2
Initializing CPU#0
Detected 731.487 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1458.17 BogoMIPS
Memory: 513132k/524160k available (1232k kernel code, 10640k reserved, 842k=
 data, 304k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 01
per-CPU timeslice cutoff: 731.56 usecs.
task migration cache decay timeout: 10 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1461.45 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 01
Total of 2 processors activated (2919.62 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not=
 connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0020
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81
 10 003 03  1    1    0   1   0    1    1    89
 11 003 03  1    1    0   1   0    1    1    91
 12 003 03  1    1    0   1   0    1    1    99
 13 003 03  1    1    0   1   0    1    1    A1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 731.4736 MHz.
..... host bus clock speed is 132.9950 MHz.
cpu: 0, clocks: 1329950, slice: 443316
CPU0<T0:1329936,T1:886608,D:12,S:443316,C:1329950>
cpu: 1, clocks: 1329950, slice: 443316
CPU1<T0:1329936,T1:443296,D:8,S:443316,C:1329950>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfd5ac, last bus=3D3
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
PCI->APIC IRQ transform: (B0,I31,P3) -> 19
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI->APIC IRQ transform: (B2,I3,P0) -> 19
PCI->APIC IRQ transform: (B2,I8,P0) -> 16
PCI->APIC IRQ transform: (B2,I10,P0) -> 18
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled - APM is not SMP safe.
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IR=
Q SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Real Time Clock Driver v1.10e
block: 992 slots per queue, batch=3D248
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJNA-371350, ATA DISK drive
hdc: CRD-8480C, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c03cbd44, I/O limit 4095Mb (mask 0xffffffff)
hda: 26520480 sectors (13578 MB) w/1966KiB Cache, CHS=3D1650/255/63, UDMA(3=
3)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 421k freed
VFS: Mounted root (ext2 filesystem).
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno =3D 2
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.5
        <Adaptec 2940B Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

  Vendor: IBM-PSG   Model: DNES-309170W  !#  Rev: SAB0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 30, 16bit)
SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
 sda: sda1
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
Adaptec I2O RAID controller 0 at e085a000 size=3D100000 irq=3D18
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001   =20
TID 009  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001   =20
TID 010  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001   =20
TID 011  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001   =20
scsi1 : Vendor: Adaptec  Model: 3410S            FW:350C
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 304k freed
Adding Swap: 1048312k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 07:32:55 Apr 18 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1f.2 to 64
usb-uhci.c: USB UHCI at I/O 0xff00, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepr=
o100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <s=
aw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:D0:B7:59:C1:AA, IRQ 19.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 540675-040, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.

--=-so3t5pZqdzwRzxtMGjBf--

