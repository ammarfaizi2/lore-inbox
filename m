Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264703AbRFQJ6H>; Sun, 17 Jun 2001 05:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264704AbRFQJ56>; Sun, 17 Jun 2001 05:57:58 -0400
Received: from [193.132.149.205] ([193.132.149.205]:25355 "EHLO uk5.imdb.com")
	by vger.kernel.org with ESMTP id <S264703AbRFQJ5y>;
	Sun, 17 Jun 2001 05:57:54 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GFvVnq/rk0"
Content-Transfer-Encoding: 7bit
Message-ID: <15148.32506.916604.938393@jim.imdb.com>
Date: Sun, 17 Jun 2001 10:57:14 +0100 (BST)
From: Jim Randell <jim@imdb.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel Bug 2.4.{4,5} page_alloc.c:81
X-Mailer: VM 6.75 (21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid)
X-Missile-Address: 51 28 19 N / 02 35 41 W
X-Location: Bristol, UK
X-Face: 0i`dE&Q3d44YB<DfXUCR]+^L}0EAY(Lt}o%)3jE>g|yj*y0)|\a8KVbOdmkhW3Fgqy#oM1]JIV9VEO3$";)>8dpa}P8,R{(1<czOX27o7bK]q#GuwMpD2pgV4xj1\kUTVUo]ROa%aoNV,;.$P$@s#zuzpzw5B$KFYV)#5Cb1o8a&v$!gBRR;b
X-IMDb-Value: 9
X-IMDb-Filter: internal or partner
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GFvVnq/rk0
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

I've recently been getting strange system lock-ups - often my system
just dies, but occasionally I get messages in dmesg. I've tried to
isolate the problem by increasing the available swap (I now have > 2x
RAM), removing my reiserfs partitions (I'm now running with ext2) and
downgrading from kernel 2.4.5 to 2.4.4, but I'm still seeing the
problem.

Here are the two logs that I've been able to get - after I got these
logs I rebooted my machine and it failed to unmount my /home partition
with the message "device busy".

The first one happened on June 4th with a 2.4.5 kernel:


--GFvVnq/rk0
Content-Type: text/plain
Content-Disposition: inline;
	filename="oops3"
Content-Transfer-Encoding: 7bit

/var/log/messages:

kernel BUG at page_alloc.c:81! 
invalid operand: 0000 
CPU:    1 
EIP:    0010:[__free_pages_ok+168/780] 
EFLAGS: 00210282 
eax: 0000001f   ebx: c1af144c   ecx: 00200046   edx: 00000001 
esi: 000000df   edi: e900fc24   ebp: 00000000   esp: ddccfecc 
ds: 0018   es: 0018   ss: 0018 
Process rm (pid: 2695, stackpage=ddccf000) 
Stack: c022c36a c022c3fe 00000051 c1af144c 000000df e900fc24 00000000 00000000  
       c1af144c c1af144c c0123e33 c1af144c c012d1ef c012409a c1af144c ddccff40  
       e900fc2c e900fc24 e900fc34 df01d840 c1af144c ddccff40 c0124168 e900fb80  
Call Trace: [remove_inode_page+59/72] [__free_pages+27/28] [truncate_list_pages+322/436] [truncate_inode_pages+92/148] [iput+162/360] [d_delete+98/160] [vfs_unlink+377/428]  
       [sys_unlink+166/280] [system_call+51/56]  
 
Code: 0f 0b 83 c4 0c 8d 76 00 8b 43 18 a8 20 74 19 6a 53 68 fe c3


ksymoops:

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   8d 76 00                  lea    0x0(%esi),%esi
Code;  00000008 Before first symbol
   8:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  0000000b Before first symbol
   b:   a8 20                     test   $0x20,%al
Code;  0000000d Before first symbol
   d:   74 19                     je     28 <_EIP+0x28> 00000028 Before first symbol
Code;  0000000f Before first symbol
   f:   6a 53                     push   $0x53
Code;  00000011 Before first symbol
  11:   68 fe c3 00 00            push   $0xc3fe


/usr/src/linux-2.4/scripts/ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux jim.imdb.com 2.4.5 #20 SMP Sat May 26 09:11:38 BST 2001 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10p
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         bsd_comp ppp_async ppp_generic slhc ipchains tdfx w83781d eeprom sensors i2c-isa i2c-piix4 i2c-core via-rhine de4x5 es1371 ac97_codec

--GFvVnq/rk0
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit


The second one happened today with a 2.4.4 kernel:


--GFvVnq/rk0
Content-Type: text/plain
Content-Disposition: inline;
	filename="oops4"
Content-Transfer-Encoding: 7bit

dmesg:

kernel BUG at page_alloc.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012cb58>]
EFLAGS: 00010282
eax: 0000001f   ebx: c181b6e8   ecx: 00000002   edx: 00000002
esi: 00000530   edi: eee832c4   ebp: 00000000   esp: f53adecc
ds: 0018   es: 0018   ss: 0018
Process xemacs (pid: 1539, stackpage=f53ad000)
Stack: c022cde9 c022cebe 00000051 c181b6e8 00000530 eee832c4 00000000 00000000 
       c181b6e8 c181b6e8 c0123d33 c181b6e8 c012d423 c0123f9a c181b6e8 f53adf40 
       eee832cc eee832c4 eee832d4 e77d27c0 c181b6e8 f53adf40 c0124068 eee83220 
Call Trace: [<c0123d33>] [<c012d423>] [<c0123f9a>] [<c0124068>] [<c0147e6e>] [<c0146106>] [<c013ef0d>] 
       [<c013efe6>] [<c0106cdb>] 

Code: 0f 0b 83 c4 0c 8d 76 00 8b 43 18 a8 20 74 19 6a 53 68 be ce 


ksymoops:

>>EIP; c012cb58 <__free_pages_ok+a8/310>   <=====
Trace; c0123d33 <remove_inode_page+3b/48>
Trace; c012d423 <__free_pages+1b/1c>
Trace; c0123f9a <truncate_list_pages+142/1b4>
Trace; c0124068 <truncate_inode_pages+5c/94>
Trace; c0147e6e <iput+a2/168>
Trace; c0146106 <d_delete+62/a0>
Trace; c013ef0d <vfs_unlink+179/1ac>
Trace; c013efe6 <sys_unlink+a6/118>
Trace; c0106cdb <system_call+33/38>
Code;  c012cb58 <__free_pages_ok+a8/310>
00000000 <_EIP>:
Code;  c012cb58 <__free_pages_ok+a8/310>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012cb5a <__free_pages_ok+aa/310>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012cb5d <__free_pages_ok+ad/310>
   5:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c012cb60 <__free_pages_ok+b0/310>
   8:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012cb63 <__free_pages_ok+b3/310>
   b:   a8 20                     test   $0x20,%al
Code;  c012cb65 <__free_pages_ok+b5/310>
   d:   74 19                     je     28 <_EIP+0x28> c012cb80 <__free_pages_ok+d0/310>
Code;  c012cb67 <__free_pages_ok+b7/310>
   f:   6a 53                     push   $0x53
Code;  c012cb69 <__free_pages_ok+b9/310>
  11:   68 be ce 00 00            push   $0xcebe


/usr/src/linux-2.4/scripts/ver_linux:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux jim.imdb.com 2.4.4 #21 SMP Sat Jun 16 23:10:05 BST 2001 i686 unknown
 
Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10p
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
PPP                    2.4.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         bsd_comp ppp_async ppp_generic slhc ipchains tdfx w83781d eeprom sensors i2c-isa i2c-piix4 i2c-core via-rhine de4x5 es1371 ac97_codec

--GFvVnq/rk0
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Here's some more information about my system:

% free
             total       used       free     shared    buffers     cached
Mem:        899808     273212     626596          0       7924     113852
-/+ buffers/cache:     151436     748372
Swap:      1836376          0    1836376

% cat /proc/version 
Linux version 2.4.4 (root@jim.imdb.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #21 SMP Sat Jun 16 23:10:05 BST 2001

% cat /proc/modules 
ppp_async               6576   1 (autoclean)
ppp_generic            17008   3 (autoclean) [ppp_async]
slhc                    4752   1 (autoclean) [ppp_generic]
ipchains               35488   0 (unused)
tdfx                   55856   1
w83781d                17328   0
eeprom                  3120   0
sensors                 6016   0 [w83781d eeprom]
i2c-isa                 1168   0 (unused)
i2c-piix4               3904   0 (unused)
i2c-core               12080   0 [w83781d eeprom sensors i2c-isa i2c-piix4]
via-rhine              10720   0 (autoclean) (unused)
de4x5                  42480   1 (autoclean)

% cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0290-0297 : w83781d
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0400-043f : Intel Corporation 82371AB PIIX4 ACPI
0440-045f : Intel Corporation 82371AB PIIX4 ACPI
  0440-0447 : piix4-smbus
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  d800-d8ff : 3Dfx Interactive, Inc. Voodoo Banshee
e400-e4ff : VIA Technologies, Inc. Ethernet Controller
  e400-e4ff : via-rhine
e800-e8ff : Adaptec AHA-2940U2/W / 7890
ec00-ec7f : Digital Equipment Corporation DECchip 21040 [Tulip]
  ec00-ec7f : DE434/5 (eth0)
ef00-ef3f : Ensoniq ES1371 [AudioPCI-97]
ef80-ef9f : Intel Corporation 82371AB PIIX4 USB
ffa0-ffaf : Intel Corporation 82371AB PIIX4 IDE

% cat /proc/iomem   
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-37fdffff : System RAM
  00100000-002208f1 : Kernel code
  002208f2-002842df : Kernel data
37fe0000-37ff7fff : ACPI Tables
37ff8000-37ffffff : ACPI Non-volatile Storage
ee800000-f28fffff : PCI Bus #01
  f0000000-f1ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
f4000000-f7ffffff : Intel Corporation 440GX - 82443GX Host bridge
faa00000-feafffff : PCI Bus #01
  fc000000-fdffffff : 3Dfx Interactive, Inc. Voodoo Banshee
febfee80-febfeeff : Digital Equipment Corporation DECchip 21040 [Tulip]
febfef00-febfefff : VIA Technologies, Inc. Ethernet Controller
  febfef00-febfefff : via-rhine
febff000-febfffff : Adaptec AHA-2940U2/W / 7890
  febff000-febfffff : aic7xxx
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fffc0000-ffffffff : reserved

# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 set
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: faa00000-feafffff
	Prefetchable memory behind bridge: ee800000-f28fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:0d.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq: Unknown device 1371
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 12 min, 128 max, 64 set
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at ef00 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr+ DSI+ D1- D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
	Subsystem: Adaptec: Unknown device 000f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 39 min, 25 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 10
	BIST result: 00
	Region 0: I/O ports at e800 [disabled] [size=256]
	Region 1: Memory at febff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: VIA Technologies, Inc.: Unknown device 3065 (rev 43)
	Subsystem: D-Link System Inc: Unknown device 1400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 3 min, 8 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at febfef00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at febe0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME+
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: Digital Equipment Corporation DECchip 21040 [Tulip] (rev 23)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 set
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at ec00 [size=128]
	Region 1: Memory at febfee80 (32-bit, non-prefetchable) [size=128]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 03) (prog-if 00 [VGA])
	Subsystem: CardExpert Technology: Unknown device 0001
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at d800 [size=256]
	Expansion ROM at feaf0000 [disabled] [size=32K]
	Capabilities: [54] AGP version 1.0
		Status: RQ=7 SBA+ 64bit+ FW- Rate=x1
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

% cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T09170N     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DDYS-T09170N     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03

-- 
Jim Randell  //  jim@imdb.com  //  +44.117.944.4227
http://www.imdb.com/       Mobile: +44.779.087.6488
                                                 :d

--GFvVnq/rk0--
