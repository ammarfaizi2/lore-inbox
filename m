Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTFFQIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTFFQIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:08:07 -0400
Received: from port-212-202-203-169.reverse.qdsl-home.de ([212.202.203.169]:1934
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S261874AbTFFQH7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:07:59 -0400
Message-ID: <3EE0BF88.5020708@trash.net>
Date: Fri, 06 Jun 2003 18:21:28 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: two 2.4.21-rc7 BUGs (inode.c:562 / page_alloc.c:231)
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got these two BUGs while running bk commit. I use the box to hack
on nfnetlink_conntrack so it could be related to this, but it ran stable
for several days before. bk process hung in D state, the whole partition
was not accessible anymore.

First one:

kernel BUG at inode.c:562!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c014b8cd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210202
eax: c296d920   ebx: c296d900   ecx: 00000001   edx: c296d920
esi: 000bfab8   edi: e3505d40   ebp: c487fdc0   esp: d351be88
ds: 0018   es: 0018   ss: 0018
Process bk (pid: 22151, stackpage=d351b000)
Stack: c296d900 f7bdfe00 c015b27c c296d900 f5cb2d40 00001000 c225c9f4 
c225c980
       f5cb2d40 c225c9f4 c0165f95 d04ec2a0 00000000 00000000 00000000 
e3505d40
       d351bf14 c296d900 c015fa75 e3505d40 f5cb2d40 d351bf14 00000000 
e3505d40
Call Trace:    [<c015b27c>] [<c0165f95>] [<c015fa75>] [<c015fa02>] 
[<c015fb6f>]
  [<c015c615>] [<c015c500>] [<c014c23b>] [<c01431d8>] [<c014333a>] 
[<c010730f>]
Code: 0f 0b 32 02 1a d8 22 c0 8b 83 f8 00 00 00 a8 10 75 08 0f 0b
 
 
 >>EIP; c014b8cd <clear_inode+1d/c0>   <=====
 
 >>eax; c296d920 <_end+2694d20/3a565480>
 >>ebx; c296d900 <_end+2694d00/3a565480>
 >>edx; c296d920 <_end+2694d20/3a565480>
 >>edi; e3505d40 <_end+2322d140/3a565480>
 >>ebp; c487fdc0 <_end+45a71c0/3a565480>
 >>esp; d351be88 <_end+13243288/3a565480>
Trace; c015b27c <ext3_free_inode+7c/4e0>
Trace; c0165f95 <journal_get_write_access+55/80>
Trace; c015fa75 <ext3_reserve_inode_write+45/f0>
Trace; c015fa02 <ext3_mark_iloc_dirty+42/70>
Trace; c015fb6f <ext3_mark_inode_dirty+4f/60>
Trace; c015c615 <ext3_delete_inode+115/160>
Trace; c015c500 <ext3_delete_inode+0/160>
Trace; c014c23b <iput+eb/210>
Trace; c01431d8 <vfs_unlink+c8/170>
Trace; c014333a <sys_unlink+ba/120>
Trace; c010730f <system_call+33/38>
 
Code;  c014b8cd <clear_inode+1d/c0>
00000000 <_EIP>:
Code;  c014b8cd <clear_inode+1d/c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014b8cf <clear_inode+1f/c0>
   2:   32 02                     xor    (%edx),%al
Code;  c014b8d1 <clear_inode+21/c0>
   4:   1a d8                     sbb    %al,%bl
Code;  c014b8d3 <clear_inode+23/c0>
   6:   22 c0                     and    %al,%al
Code;  c014b8d5 <clear_inode+25/c0>
   8:   8b 83 f8 00 00 00         mov    0xf8(%ebx),%eax
Code;  c014b8db <clear_inode+2b/c0>
   e:   a8 10                     test   $0x10,%al
Code;  c014b8dd <clear_inode+2d/c0>
  10:   75 08                     jne    1a <_EIP+0x1a>
Code;  c014b8df <clear_inode+2f/c0>
  12:   0f 0b                     ud2a


Second one:

 kernel BUG at page_alloc.c:231!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0130b4e>]    Not tainted
EFLAGS: 00010202
eax: 010000c8   ebx: c171a5c0   ecx: 00001000   edx: 00025e1e
esi: c0252f30   edi: c0252f44   ebp: c0252f30   esp: da0b1e70
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 22195, stackpage=da0b1000)
Stack: c21fe1c0 c012ab00 00024e1e 00000282 00000000 c0252f30 c02530b8 
000003fd
       00000000 000001d2 c0130daf e6765140 c0252fe0 c02530b0 ddd176c0 
00104025
       00000001 ddd179c0 e2675378 c0126b5c c21fe1c0 080de000 e6765140 
00000001
Call Trace:    [<c012ab00>] [<c0130daf>] [<c0126b5c>] [<c0126e57>] 
[<c0114488>]
  [<c0127466>] [<c0128403>] [<c012736c>] [<c0114310>] [<c0107400>]
Code: 0f 0b e7 00 20 ca 22 c0 8b 43 18 a9 80 00 00 00 74 08 0f 0b
                                                                                                                 
                                                                                                                 
 >>EIP; c0130b4e <rmqueue+1fe/220>   <=====
                                                                                                                 
 >>ebx; c171a5c0 <_end+14419c0/3a565480>
 >>esi; c0252f30 <contig_page_data+b0/340>
 >>edi; c0252f44 <contig_page_data+c4/340>
 >>ebp; c0252f30 <contig_page_data+b0/340>
 >>esp; da0b1e70 <_end+19dd9270/3a565480>
                                                                                                                 
Trace; c012ab00 <filemap_nopage+1d0/210>
Trace; c0130daf <__alloc_pages+3f/170>
Trace; c0126b5c <do_anonymous_page+5c/100>
Trace; c0126e57 <handle_mm_fault+77/100>
Trace; c0114488 <do_page_fault+178/4d6>
Trace; c0127466 <__vma_link+56/c0>
Trace; c0128403 <do_brk+113/200>
Trace; c012736c <sys_brk+ec/120>
Trace; c0114310 <do_page_fault+0/4d6>
Trace; c0107400 <error_code+34/3c>
                                                                                                                 
Code;  c0130b4e <rmqueue+1fe/220>
00000000 <_EIP>:
Code;  c0130b4e <rmqueue+1fe/220>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0130b50 <rmqueue+200/220>
   2:   e7 00                     out    %eax,$0x0
Code;  c0130b52 <rmqueue+202/220>
   4:   20 ca                     and    %cl,%dl
Code;  c0130b54 <rmqueue+204/220>
   6:   22 c0                     and    %al,%al
Code;  c0130b56 <rmqueue+206/220>
   8:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c0130b59 <rmqueue+209/220>
   b:   a9 80 00 00 00            test   $0x80,%eax
Code;  c0130b5e <rmqueue+20e/220>
  10:   74 08                     je     1a <_EIP+0x1a>
Code;  c0130b60 <rmqueue+210/220>
  12:   0f 0b                     ud2a
 
module loaded:

Module                  Size  Used by    Not tainted
nfnetlink_conntrack    10220   0  (unused)
ip_conntrack           20540   0  [nfnetlink_conntrack]
nfnetlink               3936   1  [nfnetlink_conntrack]
nfsd                   73008   8  (autoclean)
nfs                    71548  12  (autoclean)
lockd                  50736   1  (autoclean) [nfsd nfs]
sunrpc                 66240   1  (autoclean) [nfsd nfs lockd]
8139too                14824   1
mii                     2464   0  [8139too]
rtc                     6792   0  (autoclean)

versions:

Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.34-WIP
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0

cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 2000+
stepping        : 2
cpu MHz         : 1666.774
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3322.67

ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(set)
03c0-03df : vga+
  03c0-03df : matrox
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
d000-d03f : Ensoniq ES1371 [AudioPCI-97]
  d000-d03f : es1371
d400-d4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  d400-d4ff : 8139too
d800-d80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1

iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-5ffeffff : System RAM
  00100000-0021fbed : Kernel code
  0021fbee-00262b9f : Kernel data
5fff0000-5fff2fff : ACPI Non-volatile Storage
5fff3000-5fffffff : ACPI Tables
d0000000-d7ffffff : VIA Technologies, Inc. VT8367 [KT266]
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : Matrox Graphics, Inc. MGA G550 AGP
    d8000000-d9ffffff : matroxfb FB
da000000-dcffffff : PCI Bus #01
  da000000-da003fff : Matrox Graphics, Inc. MGA G550 AGP
    da000000-da003fff : matroxfb MMIO
  db000000-db7fffff : Matrox Graphics, Inc. MGA G550 AGP
dd000000-dd0000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  dd000000-dd0000ff : 8139too
ffff0000-ffffffff : reserved

lspci -vvv:

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo 
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: da000000-dcffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at dd000000 (32-bit, non-prefetchable) [size=256]
                                                                                                                 
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8233A ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                                                                                                                 
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master 
ATA133/100/66/33 IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                                                                                                                 
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP 
(rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G550
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at da000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at db000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x1
                                                                                                                 






