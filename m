Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbTDAXEZ>; Tue, 1 Apr 2003 18:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbTDAXEY>; Tue, 1 Apr 2003 18:04:24 -0500
Received: from freestream.com.au ([150.101.215.114]:38921 "EHLO
	www.freestream.com.au") by vger.kernel.org with ESMTP
	id <S262912AbTDAXEA>; Tue, 1 Apr 2003 18:04:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Brown <adam@freestream.com.au>
Reply-To: adam@freestream.com.au
Organization: Freestream
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG while running rsync
Date: Wed, 2 Apr 2003 09:15:12 +1000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030401231513.054A12880@www.freestream.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Summary - kernel BUG while running rsync

[2.] Full Description 
I am using rsync to mirror a hard drive in its entirety as part of a daily  
backup schedule. Both drives are on the same machine. Rsync has failed for 
the last 3 nights and the system logs are reporting a kernel bug.

I have been experiencing crashes on the machine while running the daily and
 weekly cron jobs which I believe may be due to it running out of memory. The
 crashes were aleviated somewhat by deferring the backup till later and
 temporarily disabling the Htdig indexer.

Aside from the rsync failure, the system appears to be running OK.

It would be nice to know if this can be safely attributed to a lack of memory 
or is it likely to be something more sinister and a whole lot more painful?

System
Dual Athlon MP 1800
512 RAM
256 Swap
Asus a7m266-d mb with AMD-768 South bridge and AMD-762 North Bridge
2xIDE drives
3COM 3c905 nic
AGP video card
rsync version: 2.5.6cvs  protocol version 26

[3.] Keywords
kernel bug rsync 2.4.19 memory

[4.] Kernel version from /proc/version
Linux version 2.4.19 (root@wing.wire.org.au) (gcc version 2.95.4 20011002
 (Debian prerelease)) #2 SMP Wed Nov 13 13:44:22 EST 2002

[5.] Output in /var/log/messages

Apr  1 06:51:51 wing kernel: kernel BUG at page_alloc.c:91!
Apr  1 06:51:51 wing kernel: invalid operand: 0000
Apr  1 06:51:51 wing kernel: CPU:    0
Apr  1 06:51:51 wing kernel: EIP:    0010:[__free_pages_ok+45/624]    Not
 tainted
Apr  1 06:51:51 wing kernel: EFLAGS: 00010286
Apr  1 06:51:51 wing kernel: eax: 0100000d   ebx: c10c00b8   ecx: c10c00b8  
 edx: 00000000
Apr  1 06:51:51 wing kernel: esi: 00000000   edi: cea7fb30   ebp: 00000179  
 esp: c8be7ef8
Apr  1 06:51:51 wing kernel: ds: 0018   es: 0018   ss: 0018
Apr  1 06:51:51 wing kernel: Process rsync (pid: 30576, stackpage=c8be7000)
Apr  1 06:51:51 wing kernel: Stack: c10c00b8 00001000 cea7fb30 00000179 
0000017f
 00000020 dfe52640 c012b555 
Apr  1 06:51:51 wing kernel:        c10c00b8 c10c00b8 dfea1e80 cea7fb30 
00000178
 c013310c c012b7fd c8be7f8c 
Apr  1 06:51:51 wing kernel:        c10c00b8 00000000 00001000 00000000 
dfe52640
 ffffffea 00030000 00001000 
Apr  1 06:51:51 wing kernel: Call Trace:    [generic_file_readahead+261/320]
 [__free_pages+28/32] [do_generic_file_read+573/1120]
 [generic_file_read+133/320] [file_read_actor+0/144]
Apr  1 06:51:51 wing kernel:   [sys_read+150/272] [system_call+51/56]
Apr  1 06:51:51 wing kernel: 
Apr  1 06:51:51 wing kernel: Code: 0f 0b 5b 00 13 9a 21 c0 89 d8 2b 05 30 b8 
2c
 c0 69 c0 a3 8b 

[6.] Script
Here are the commands that are run during a successful backup. I have marked
the recent failure point.

/sbin/hdparm -q -R 0x170 0 0 /dev/hda > /dev/null
/sbin/e2fsck -f -y /dev/hdc5 > /dev/null 2>&1
/sbin/e2fsck -f -y /dev/hdc6 > /dev/null 2>&1
/sbin/e2fsck -f -y /dev/hdc7 > /dev/null 2>&1
/sbin/e2fsck -f -y /dev/hdc9 > /dev/null 2>&1
/sbin/e2fsck -f -y /dev/hdc10 > /dev/null 2>&1
/sbin/e2fsck -f -y /dev/hdc11 > /dev/null 2>&1
/sbin/e2fsck -f -y /dev/hdc12 > /dev/null 2>&1
/bin/mount -t ext2 /dev/hdc6 /mnt/backup/
/bin/mount -t ext2 /dev/hdc5 /mnt/backup/boot
/bin/mount -t ext2 /dev/hdc7 /mnt/backup/tmp
/bin/mount -t ext2 /dev/hdc9 /mnt/backup/usr
/bin/mount -t ext2 /dev/hdc10 /mnt/backup/var
/bin/mount -t ext2 /dev/hdc11 /mnt/backup/home
/bin/mount -t ext2 /dev/hdc12 /mnt/backup/clients
/usr/bin/rsync -aH --delete --timeout=180 /bin/ /mnt/backup/bin
/usr/bin/rsync -aH --delete --timeout=180 /boot/ /mnt/backup/boot
/usr/bin/rsync -aH --delete --timeout=180 /clients/ /mnt/backup/clients
/usr/bin/rsync -aH --delete --timeout=180 /dev/ /mnt/backup/dev
/usr/bin/rsync -aH --delete --timeout=180 /etc/ /mnt/backup/etc
/usr/bin/rsync -aH --delete --timeout=180 /home/ /mnt/backup/home
***FAILED HERE***
/usr/bin/rsync -aH --delete --timeout=180 /initrd/ /mnt/backup/initrd
/usr/bin/rsync -aH --delete --timeout=180 /lib/ /mnt/backup/lib
/usr/bin/rsync -aH --delete --timeout=180 /opt/ /mnt/backup/opt
/usr/bin/rsync -aH --delete --timeout=180 /root/ /mnt/backup/root
/usr/bin/rsync -aH --delete --timeout=180 /sbin/ /mnt/backup/sbin
/usr/bin/rsync -aH --delete --timeout=180 /usr/ /mnt/backup/usr
/usr/bin/rsync -aH --delete --timeout=180 /var/ /mnt/backup/var
/usr/sbin/chroot /mnt/backup sbin/lilo -C /etc/lilo.conf.backup > /dev/null
/bin/sync
/bin/umount /mnt/backup/boot
/bin/umount /mnt/backup/tmp
/bin/umount /mnt/backup/usr
/bin/umount /mnt/backup/var
/bin/umount /mnt/backup/home
/bin/umount /mnt/backup/clients
/bin/umount /mnt/backup/
/sbin/hdparm -Y /dev/hdc > /dev/null

[7.] Environment
[7.1.] output of ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux wing.wire.org.au 2.4.19 #2 SMP Wed Nov 13 13:44:22 EST 2002 i686
unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         vfat fat smbfs

[7.2] Processor Information
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) MP 1800+
stepping	: 2
cpu MHz		: 1533.402
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36
 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3060.53

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) MP 1800+
stepping	: 2
cpu MHz		: 1533.402
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36
 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3060.53

[7.3.] Modules Info
vfat                    9596   0 (unused)
fat                    30648   0 [vfat]
smbfs                  33504   0 (unused)

[7.4.] Loaded Driver and hardware information
/proc/ioports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #02
  c800-c87f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
    c800-c87f : 02:08.0
d800-d80f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
  d800-d807 : ide0
e800-e803 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller


/proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-002101f2 : Kernel code
  002101f3-0025b9df : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
f5800000-f67fffff : PCI Bus #02
  f5800000-f580007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
f6800000-f68000ff : NEC Corporation USB 2.0
f7000000-f7000fff : NEC Corporation USB (#2)
f7800000-f7800fff : NEC Corporation USB
f8000000-f9afffff : PCI Bus #01
  f8000000-f8ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
f9b00000-f9bfffff : PCI Bus #02
f9c00000-fb7fffff : PCI Bus #01
  fa000000-faffffff : NVidia / SGS Thomson (Joint Venture) Riva128
fb800000-fb800fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System
 Controller
fc000000-fdffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System
 Controller
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5] PCI Info
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 
11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at fb800000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e800 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if
 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: f8000000-f9afffff
	Prefetchable memory behind bridge: f9c00000-fb7fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 05)
	Subsystem: Asustek Computer, Inc.: Unknown device 8044
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev
 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7441
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 8044
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-

00:09.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Unknown device 807d:0035
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f7800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Unknown device 807d:0035
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 12
	Region 0: Memory at f7000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02) (prog-if
 20)
	Subsystem: Unknown device 807d:1043
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at f6800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 05)
 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort+ >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: f5800000-f67fffff
	Prefetchable memory behind bridge: f9b00000-f9bfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) 
Riva128
 (rev 22) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at fa000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at f9c00000 [disabled] [size=4M]
	Capabilities: [44] AGP version 1.0
		Status: RQ=4 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev
 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping-
 SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
 <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at c800 [size=128]
	Region 1: Memory at f5800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI
None

[7.7] Any other information
