Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267763AbRGQEXk>; Tue, 17 Jul 2001 00:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbRGQEX0>; Tue, 17 Jul 2001 00:23:26 -0400
Received: from adsl-63-193-243-214.dsl.snfc21.pacbell.net ([63.193.243.214]:60369
	"EHLO dmz.ruault.com") by vger.kernel.org with ESMTP
	id <S267763AbRGQEWk>; Tue, 17 Jul 2001 00:22:40 -0400
Message-ID: <3B53BD76.B2E9212D@ruault.com>
Date: Mon, 16 Jul 2001 21:22:14 -0700
From: Charles-Edouard Ruault <ce@ruault.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel oops in skbuff.c when tcp mss>mtu in kernel 2.4.6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I was upgrading my firewall from kernel 2.2.19 to 2.4.6 today and i
found the following problem :
i'm using pptp to connect my internal network to my company network. The
tunnel is established from my firewall to my company and i'm using
masquerading to allow the machines on my home network ( including my
firewall ) to connect to the company network.
As you certainly know, pptp uses gre to encapsulate the encrypted data.

To allow my internal machines to communicate properly with machines on
the other side of the tunnel, i have to use the following rules in the
forwarding chain of my firewall :
ipchains -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS
--clamp-mss-to-pmtu -o ppp+
ipchains -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS
--clamp-mss-to-pmtu -i ppp+

without that, the mss that is used in the tcp connection is larger than
the Path MTU and large tcp packets are dropped.

When rewriting my firewall config file ( migrating from ipchains to
iptables ) i made the mistake of specifying my rule allowing forwarding
from my internal net to the VPN before the clamp-mss-to-pmtu rule, wich
caused the later to be ignored.

In this config, the tcp connections establised from my internal net to
my company net have a mss larger than the MTU.
When a tcp packet larger than the mtu is sent, the kernel crashes and i
need to reboot my machine.
After fixing the rules and moving the clamp-mss-to-pmtu before the
forwading rules, it works fine.
This was not occuring with kernel 2.2.19 ( i was using ipchains and the
mssclampfw module ).
here's the oops ( i had to copy it manually since the whole machine is
locked up after the oops and it's not logged anywhere )

this is on kernel 2.4.6

skput:over: c385100e:1405 put: 1504 dev:<NULL> kernel bug at skbuff.c
line 93
invalid operand 0000
cpu: 0
EIP: 0010:[<c018c48d>]
EFLAGS: 00010296
EAX: 1b EBX: c184d400 ecx: c142c000 edx: 01 esi: c184d400 edi: 5e0 ebp:
c11d9d60 esp: c0559e28 ds:18 es:18 ss:18
process: pptp stackpage: c0559000
stack: c01f7a0c c01f7c00 5d c3851016 c184d400 5e0 c3851002 c11d9d60
c163440 c17b05a0 c1437813
            c3850a0d c11d9d60 c17b05a0 c11d9d60 c16a3440
call trace: c015c416 c015acef c0156d59 c015ab54 c012ee6a c0106b53
code: 0f 0b 83 c4 0c c3 90 8b 54 24 04 8b 42 18 85 c0 75 05 b8 c7
kernel panic: killing interrupt handler
in interrupt handler, not syncing

i've tried several times, it crashes everytime with the same error.

here's the output of scripts/ver_linux

Linux ns.ruault.com 2.4.6 #1 Fri Jul 13 16:26:58 PDT 2001 i586 unknown

Gnu C                  egcs-2.91.66
Gnu make               3.77
binutils               2.11.90.0.8
util-linux             2.10s
mount                  2.9o
modutils               2.4.6
e2fsprogs              1.22
pcmcia-cs              3.0.9
PPP                    2.4.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.2
Net-tools              1.52
Console-tools          1999.03.02
Sh-utils               1.16
Modules Loaded         mppe ppp_async ppp_generic slhc eepro100 3c59x

my cpuinfo is the following :
 cat /proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 5
model  : 2
model name : Pentium 75 - 200
stepping : 12
cpu MHz  : 180.001
fdiv_bug : no
hlt_bug  : no
f00f_bug : yes
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 1
wp  : yes
flags  : fpu vme de pse tsc msr mce cx8
bogomips : 358.80

moduleinfo is the following :
mppe                   21984   2 (autoclean)
ppp_async               6640   1 (autoclean)
ppp_generic            14624   3 (autoclean) [mppe ppp_async]
slhc                    5056   1 (autoclean) [ppp_generic]
eepro100               16400   2 (autoclean)
3c59x                  26016   1 (autoclean)

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
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
6100-613f : Intel Corporation 82557 [Ethernet Pro 100]
  6100-613f : eepro100
6200-623f : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  6200-623f : eepro100
6300-633f : 3Com Corporation 3c905 100BaseTX [Boomerang]
  6300-633f : 00:0a.0
f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
  f000-f007 : ide0
  f008-f00f : ide1

iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000c9000-000c9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-02ffffff : System RAM
  00100000-001d667f : Kernel code
  001d6680-0022227f : Kernel data
e0000000-e3ffffff : S3 Inc. 86c325 [ViRGE]
e4000000-e40fffff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
e4100000-e41fffff : Intel Corporation 82557 [Ethernet Pro 100]
e4200000-e4200fff : Intel Corporation 82557 [Ethernet Pro 100]
  e4200000-e4200fff : eepro100
e4201000-e4201fff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
  e4201000-e4201fff : eepro100
ffff0000-ffffffff : reserved

lspci -vvv
00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX]
(rev 02)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
 Latency: 32 set

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton
II] (rev 01)
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 0 set

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE
[Natoma/Triton II] (prog-if 80)
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 32 set
 Region 4: I/O ports at f000

00:08.0 Ethernet controller: Intel Corporation 82557 (rev 08)
 Subsystem: Unknown device 8086:000c
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 8 min, 56 max, 32 set, cache line size 08
 Interrupt: pin A routed to IRQ 11
 Region 0: Memory at e4200000 (32-bit, non-prefetchable)
 Region 1: I/O ports at 6100
 Region 2: Memory at e4100000 (32-bit, non-prefetchable)
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:09.0 Ethernet controller: Intel Corporation 82557 (rev 08)
 Subsystem: Unknown device 8086:000c
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 8 min, 56 max, 32 set, cache line size 08
 Interrupt: pin A routed to IRQ 10
 Region 0: Memory at e4201000 (32-bit, non-prefetchable)
 Region 1: I/O ports at 6200
 Region 2: Memory at e4000000 (32-bit, non-prefetchable)
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX
[Boomerang]
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 3 min, 8 max, 32 set
 Interrupt: pin A routed to IRQ 9
 Region 0: I/O ports at 6300

00:0b.0 VGA compatible controller: S3 Inc. 86C325 [ViRGE] (rev 06)
 Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Interrupt: pin A routed to IRQ 0
 Region 0: Memory at e0000000 (32-bit, non-prefetchable)

no scsi

that's about it ! let me know if you need more information from me.
I hope it will help you pinpoint the problem.
Good luck and keep on the great work !

regards

PS : can you cc me when you reply to the list, i'm not a subscriber.
thanks !
--
Charles-Edouard


