Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312450AbSDCWnU>; Wed, 3 Apr 2002 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSDCWnQ>; Wed, 3 Apr 2002 17:43:16 -0500
Received: from cm12534.telecable.es ([213.141.57.91]:42194 "EHLO
	bandit.casa.lan") by vger.kernel.org with ESMTP id <S312450AbSDCWm7>;
	Wed, 3 Apr 2002 17:42:59 -0500
Subject: PROBLEM: __free_pages_ok()  OOPS
From: "Julian J. M." <bandit@telecable.es>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 00:42:41 +0200
Message-Id: <1017873762.14879.33.camel@bandit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This is my first post in this mailing list. 

I'm using Redhat 7.2 distribution, with kernel v2.4.18. The only foreign
module is NVDriver. Here is how the oops looks like: 

invalid operand: 0000 
CPU:    0 
EIP:    0010:[<c0129f1a>]    Tainted: P 
EFLAGS: 00210282 
eax: c1127aac   ebx: c10654e0   ecx: c10654e0   edx: c02a9120 
esi: c10654e0   edi: 00000000   ebp: 000016e5   esp: cffa5f10 
ds: 0018   es: 0018   ss: 0018 
Process kswapd (pid: 4, stackpage=cffa5000) 
Stack: c103c02c c02a9258 00000000 c10654e0 c02a9120 c10654e0 00000014 000016e5 
       c012977f ca212600 cffa4000 00000200 000001d0 c02a9244 00000000 ca212600 
       c13c5eac 00000000 00000020 000001d0 00000006 00000020 c0129a10 00000006 
Call Trace: [<c012977f>] [<c0129a10>] [<c0129a7c>] [<c0129b1c>] [<c0129ba6>] 
   [<c0129cdd>] [<c0129c40>] [<c0105000>] [<c0105536>] [<c0129c40>] 

Code: 0f 0b 89 d8 2b 05 8c eb 2f c0 c1 f8 02 69 c0 ef ee ee ee 3b 

---------------------------- 

Here is the output of ksymoops: 
>>EIP; c0129f1a <__free_pages_ok+2a/230>   <===== 
Trace; c012977f <shrink_cache+1cf/340> 
Trace; c0129a10 <shrink_caches+50/80> 
Trace; c0129a7c <try_to_free_pages+3c/60> 
Trace; c0129b1c <kswapd_balance_pgdat+4c/b0> 
Trace; c0129ba6 <kswapd_balance+26/40> 
Trace; c0129cdd <kswapd+9d/c0> 
Trace; c0129c40 <kswapd+0/c0> 
Trace; c0105000 <_stext+0/0> 
Trace; c0105536 <kernel_thread+26/30> 
Trace; c0129c40 <kswapd+0/c0> 
Code;  c0129f1a <__free_pages_ok+2a/230> 
00000000 <_EIP>: 
Code;  c0129f1a <__free_pages_ok+2a/230>   <===== 
   0:   0f 0b                     ud2a      <===== 
Code;  c0129f1c <__free_pages_ok+2c/230> 
   2:   89 d8                     mov    %ebx,%eax 
Code;  c0129f1e <__free_pages_ok+2e/230> 
   4:   2b 05 8c eb 2f c0         sub    0xc02feb8c,%eax 
Code;  c0129f24 <__free_pages_ok+34/230> 
   a:   c1 f8 02                  sar    $0x2,%eax 
Code;  c0129f27 <__free_pages_ok+37/230> 
   d:   69 c0 ef ee ee ee         imul   $0xeeeeeeef,%eax,%eax 
Code;  c0129f2d <__free_pages_ok+3d/230> 
  13:   3b 00                     cmp    (%eax),%eax 

---------------------------- 

As I see, it's located in the funcion __free_pages_ok, which is located
in /usr/src/linux/mm/alloc_pages.c. The oops is caused by a call to the
macro BUG(). Here is the source of the file: 

[...] 
        if (page->buffers) 
                BUG(); 
        if (page->mapping) 
                BUG();       <---- HERE 
        if (!VALID_PAGE(page)) 
                BUG(); 
[...] 

I think that's the BUG() that triggers the oops, correct me if i'm
wrong. 
What I don't know is why page->mapping is nonzero. Does anyone here have
a clue on this. 

Thanks for your time. 

Julian J. M. 

----------------

For your information, and as recomended in the FAQ: 

/proc/modules: 

sr_mod                 12056   0 (autoclean) 
via82cxxx_audio        18144   0 (autoclean) 
emu10k1                53952   0 (autoclean) 
ac97_codec              9440   0 (autoclean) [via82cxxx_audio emu10k1] 
sound                  54924   0 (autoclean) [emu10k1] 
soundcore               3524   9 (autoclean) [via82cxxx_audio emu10k1
sound] 
NVdriver              945184  20 
3c59x                  25128   1 
ipt_LOG                 3232   1 (autoclean) 
iptable_filter          1664   1 (autoclean) 
ip_tables              13760   2 [ipt_LOG iptable_filter] 
ide-scsi                7712   0 
vfat                    9980   2 (autoclean) 
fat                    30328   0 (autoclean) [vfat] 
rtc                     5688   0 (autoclean) 

Output of lspci -vvv: 

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at c000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 3
	Region 4: I/O ports at c400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 3
	Region 4: I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 20)
	Subsystem: Unknown device 5860:11d4
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at cc00 [size=256]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at d400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at ef001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at dc00 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at e000 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e400 [size=128]
	Region 1: Memory at ef000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: nVidia Corporation GeForce 256 (rev 10) (prog-if 00 [VGA])
	Subsystem: Guillemot Corporation: Unknown device 5020
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


