Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbRGKIbG>; Wed, 11 Jul 2001 04:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbRGKIa6>; Wed, 11 Jul 2001 04:30:58 -0400
Received: from rillanon.amristar.com.au ([202.181.77.23]:31754 "HELO
	amristar.com.au") by vger.kernel.org with SMTP id <S267227AbRGKIao>;
	Wed, 11 Jul 2001 04:30:44 -0400
From: "Daniel Harvey" <daniel@amristar.com.au>
To: <linux-laptop@mobilix.org>, <linux-kernel@vger.kernel.org>
Subject: UPDATE: Linux SLOW on Compaq Armada 110 PIII Speedstep
Date: Wed, 11 Jul 2001 16:34:17 +0800
Message-ID: <NEBBJDBLILDEDGICHAGAAEPLCFAA.daniel@amristar.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I submitted this request about a week ago, and have tested some of the
suggestions raised. See below for results. For completeness I include my
original post.

------
UPDATE
------

Every kernel runs DOG slow except for a vanilla 2.2.14 with the patch
included below (patch taken from the RedHat kernel-2.2.14-5.0.src.rpm
package.

This patch makes this following change to the kernel as reported on bootup:

< dcache_init(259068880l)Dentry hash table entries: 262144 (order 9, 2048k)
---
> dcache_init(257984l)Dentry hash table entries: 32768 (order 6, 256k)

However, even if I manually increase this cache size in the 2.4.5 kernel, it
still runs DOG slow. i.e. make dep takes 30-45 mins

Note that I have confirmed memory + disk bandwidth seems ok on the face of
it:

Stream reports
Function      Rate (MB/s)   RMS time     Min time     Max time
Copy:         220.6927       0.1457       0.1450       0.1466
Scale:        215.8473       0.1485       0.1483       0.1488
Add:          266.8000       0.1805       0.1799       0.1813
Triad:        243.0946       0.1978       0.1975       0.1983

# hdparm -tT /dev/hda
/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.21 seconds =105.79 MB/sec
 Timing buffered disk reads:  64 MB in  3.79 seconds = 16.89 MB/sec

So I don't know what to think, any suggestions?

cat >linux-2.2.13-bigmem-dcache.patch <<EOF
--- linux/fs/dcache.c.bigmem-dcache	Tue Nov 16 18:41:05 1999
+++ linux/fs/dcache.c	Tue Nov 16 18:42:19 1999
@@ -860,12 +860,11 @@
 	return ino;
 }

-void __init dcache_init(void)
+void __init dcache_init(unsigned long memory_size)
 {
 	int i, order;
 	struct list_head *d;
 	unsigned int nr_hash;
-	unsigned long memory_size;

 	/*
 	 * A constructor could be added for stable state like the lists,
@@ -883,9 +882,6 @@
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");

-	memory_size = num_physpages << PAGE_SHIFT;
-	memory_size >>= 13;
-	memory_size *= 2 * sizeof(void *);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < memory_size; order++);

 	do {
--- linux/init/main.c.bigmem-dcache	Tue Nov 16 18:41:06 1999
+++ linux/init/main.c	Tue Nov 16 18:41:08 1999
@@ -1217,7 +1217,7 @@
 #endif
 	uidcache_init();
 	filescache_init();
-	dcache_init();
+	dcache_init(memory_end-memory_start);
 	vma_init();
 	buffer_init(memory_end-memory_start);
  	page_cache_init(memory_end-memory_start);
--- linux/include/linux/fs.h.bigmem-dcache	Tue Nov 16 18:41:06 1999
+++ linux/include/linux/fs.h	Tue Nov 16 18:41:08 1999
@@ -171,7 +171,7 @@
 extern void buffer_init(unsigned long);
 extern void inode_init(void);
 extern void file_table_init(void);
-extern void dcache_init(void);
+extern void dcache_init(unsigned long);

 typedef char buffer_block[BLOCK_SIZE];
EOF

-------------
ORIGINAL POST
-------------

[1.] Linux SLOW on Compaq Armada 110 PIII Speedstep

[2.]

I have a just brought a Compaq Armade 110 PIII, and am having a lot of
trouble getting the kernel to operate effectively. The problem is that any
kernel I run (except one pre-compiled RedHat kernel) runs very slowly. The
thing is that disk IO tests seem fine, BogoMIPS reports high, but the system
is dog-slow (kernel make dep takes ~45mins).

The kernel which works FAST (read ok) is:
Linux version 2.2.14-5.0 (root@porky.devel.redhat.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Mar 7 21:07:39 EST
2000

One of the kernels which works SLOW (have tried right through to 2.4.5):
Linux version 2.2.14 (root@elvandar) (gcc version 2.95.4 20010604 (Debian
prerelease))

[3.] Keywords - kernel, cpu, notebook, laptop
[4.] Linux version 2.2.14 (root@elvandar) (gcc version 2.95.4 20010604
(Debian prerelease))
	- although is as SLOW on any kernel up to  2.4.5 except the one above.
[5.] Output of Oops.. - N/A
[6.] Shell script - N/A

[7.] Environment
[7.1.] Software
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.7
util-linux
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer
available.
util-linux             Please use /usr/bin/superformat instead (make sure
you have the
util-linux             fdutils package installed first).  Also, there had
been some
util-linux             major changes from version 4.x.  Please refer to the
documentation.
util-linux
mount                  2.10f
modutils               2.4.6
e2fsprogs              1.18
pcmcia-cs              3.1.22
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ds i82365 pcmcia_core eepro100 vfat fat smbfs

[7.2.] Processor info.
One kernel which runs SLOW:
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 6
cpu MHz		: 797.084
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 3
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
mmx fxsr sse
bogomips	: 1589.24

Kernel which runs acceptably (speed wise):
processor   : 0
vendor_id   : GenuineIntel
cpu family  : 6
model    : 8
model name  : Pentium III (Coppermine)
stepping : 6
cpu MHz     : 797.050962
cache size  : 256 KB
fdiv_bug : no
hlt_bug     : no
sep_bug     : no
f00f_bug : no
coma_bug : no
fpu      : yes
fpu_exception  : yes
cpuid level : 3
wp    : yes
flags    : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 pn mmx fxsr xmm
bogomips : 794.62

[7.3.] Module information
ds                      6736   1
i82365                 29808   1
pcmcia_core            44480   0 [ds i82365]
eepro100               15696   1
vfat                    9312   0 (unused)
fat                    30368   0 [vfat]
smbfs                  25600   0 (unused)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
1460-1467 : ide0
1468-146f : ide1
d0046000-d004601f : Intel Speedo3 Ethernet

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev
05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f4100000-f57fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1460
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00
[UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 1440
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 20)
	Subsystem: Compaq Computer Corporation: Unknown device b194
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at 1000
	Region 1: I/O ports at 1474
	Region 2: I/O ports at 1470
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
09)	Subsystem: Intel Corporation: Unknown device 2201
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4020000 (32-bit, non-prefetchable)
	Region 1: I/O p

[7.6.] SCSI information (from /proc/scsi/scsi) - N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

There is a few messages that I am not clear on in the boot-up sequence.

For the kernel which runs FAST:
Linux version 2.2.14-5.0 (root@porky.devel.redhat.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 Tue Mar 7 21:07:39 EST
2000
Detected 797050962 Hz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 794.62 BogoMIPS
Memory: 253564k/257984k available (1060k kernel code, 416k reserved, 2880k
data, 64k init, 0k bigmem)
Dentry hash table entries: 262144 (order 9, 2048k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling extended fast FPU save and restore...done.
Not enabling KNI unmasked exception support
Exception 19 error handler not integrated yet
Disabling CPUID Serial number...done.
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfd83e
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.9)
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-210, ATA DISK drive
hdc: LG DVD-ROM DRN-8060B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IBM-DJSA-210, 9590MB w/384kB Cache, CHS=1222/255/63
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
Uniform CDROM driver Revision: 2.56
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
raid5: KNI detected, trying cache-avoiding KNI checksum routine
   pIII_kni  :    20.574 MB/sec
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :    18.288 MB/sec
   p5_mmx    :    17.145 MB/sec
   8regs     :     9.525 MB/sec
   32regs    :     5.715 MB/sec
using fastest function: pIII_kni (20.574 MB/sec)
scsi : 0 hosts.
scsi : detected total.
md.c: sizeof(mdp_super_t) = 4096
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 64k freed
Adding Swap: 248996k swap-space (priority -1)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.18 $ 1999/12/29 Modified by Andrey V. Savochkin
<saw@msu.ru>
  The PCI BIOS has not enabled this device!  Updating PCI command
0013->0017.
eth0: OEM i82557/i82558 10/100 Ethernet at 0xd0046000, 00:D0:59:2A:84:EB,
IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 980100-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
eth0: 0 multicast blocks dropped.
Linux PCMCIA Card Services 3.1.8
  kernel build: 2.2.14-5.0 #1 Tue Mar 7 21:07:39 EST 2000
  options:  [pci] [cardbus] [apm]
Intel PCIC probe:
  Unknown [0x104c 0xac50] PCI-to-CardBus at bus 0 slot 10, mem 0x68000000, 1
socket
    host opts [0]: [no pci irq] [lat 32/176] [bus 32/34]
    ISA irqs (scanned) = 3,4,5,7,10 polling interval = 1000 ms
cs: IO port probe 0x0c00-0x0cff: excluding 0xcf8-0xcff
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x158-0x15f 0x378-0x37f
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

For one of the kernel's which runs SLOW:
Linux version 2.2.14 (root@elvandar) (gcc version 2.95.4 20010604 (Debian
prerelease)) #3 Tue Jun 26 11:10:12 WST 2001
Detected 797050962 Hz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 794.62 BogoMIPS
Memory: 253904k/257984k available (880k kernel code, 416k reserved, 2744k
data, 40k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
Pentium-III serial number disabled.
CPU: Intel Pentium III (Coppermine) stepping 06
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd83e
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.9)
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-210, ATA DISK drive
hdc: LG DVD-ROM DRN-8060B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IBM-DJSA-210, 9590MB w/384kB Cache, CHS=1222/255/63
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache
Uniform CDROM driver Revision: 2.56
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
  The PCI BIOS has not enabled this device!  Updating PCI command
0013->0017.
eth0: Invalid EEPROM checksum 0x7b73, check settings before activating this
device!
eth0: Intel EtherExpress Pro 10/100 at 0x1400, 00:B4:00:80:00:A6, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 800080-000, Physical connectors present:
  Primary interface chip None PHY #0.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xdbd8681d).
  Receiver lock-up workaround activated.
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 >
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 40k freed
Adding Swap: 248996k swap-space (priority -1)

[X.] Other notes, patches, fixes, workarounds:
I reiterate - I have got the machine running acceptably (read speed is what
I expect) by change on one pre-compiled RedHat kernel. EVERY other kernel I
have compiled & tried runs DOG SLOW.

Would appreciate any help.
--
Daniel Harvey <daniel@amristar.com.au> Phone/Fax +61 8 9389 7844/33
Director, Amristar Pty Ltd; www.amristar.com.au Mobile +61 41 444 8136


