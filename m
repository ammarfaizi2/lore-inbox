Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267924AbTAHUf4>; Wed, 8 Jan 2003 15:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267925AbTAHUf4>; Wed, 8 Jan 2003 15:35:56 -0500
Received: from fmr02.intel.com ([192.55.52.25]:1516 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267924AbTAHUfg>; Wed, 8 Jan 2003 15:35:36 -0500
Message-ID: <005f01c2b756$b42a59a0$79d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Scott Murray" <scottm@somanetworks.com>,
       "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: <greg@kroah.com>, <harold.yang@intel.com>, <linux-kernel@vger.kernel.org>,
       <pcihpd-discuss@lists.sourceforge.net>
References: <Pine.LNX.4.44.0301081453520.15466-100000@rancor.yyz.somanetworks.com>
Subject: Re: [Pcihpd-discuss] Re:[BUG] cpci patch for kernel 2.4.19 bug
Date: Wed, 8 Jan 2003 12:44:13 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005C_01C2B713.A5C9E990"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_005C_01C2B713.A5C9E990
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

From: "Scott Murray" <scottm@somanetworks.com>
> On Wed, 8 Jan 2003, Rusty Lynch wrote:
> 
> > From: "Yang, Harold" <harold.yang@intel.com>
> > > 
> > > Hi, Scott & Greg:
> > > 
> > > I have applied the cpci patch for kernel 2.4.19, and test it
> > > thoroughly on ZT5084 platform. Two bugs are found:
> > > 
> > > 1. In my ZT5084, the driver can't correctly detect the cPCI
> > >    Hot Swap bridge device. Two DEC21154 exist on ZT5084,
> > >    however, only one is the right bridge. The driver can't 
> > >    distinguish them correctly.
> > 
> > I just got a couple of ZT5541 peripheral master boards
> > and can finally see what happens when an enumerable board
> > is plugged into a ZT5084 chassis using a ZT5550 system master 
> > board.
> > 
> > As of yet I have only tried a 2.5.54 kernel, but I see the 
> > same problems along with some other wacky behavior that I 
> > am trying to isolate.
> > 
> > Now about the multiple DEC21154 devices ==>  on my ZT5550 that
> > is in system master mode, the first DEC21154 device is a bridge
> > for the slots to the left of the system slots, and the second
> > DEC21154 is a bridge for the right of the system slots.
> 
> Okay, that's what I originally wanted to determine from the lspci
> output I requested when Harold mentioned this problem at the end
> of November.
> 

I am attaching output for:
1. lspci -vvv
2. cat /proc/ioports
3. cat /proc/iomem

For a ZT5550 running as system master in the second system slot
of a ZT5084 chassis that has two ZT5541 (peripherial master) boards
plugged in (one to the left of the sytem slots and the other to 
the right of the system slots.)

> > So if I boot the system master (I'll talk about problems with 
> > hotswaping in another email) with a peripheral board plugged
> > into one of the slots on the right of the master using the
> > current 2.5.54 kernel then I run into problems the first time 
> > cpci_hotplug_core.c::check_slots() runs because it only looks
> > at the first bus when trying to find the card that caused the
> > #ENUM.
> 
> I assume by problems you mean that the cPCI event thread gets
> shut down (which is what I'd expect), or do you mean something more 
> severe?
> 

The event thread shutsdown with the 
"cannot find ENUM# source, shutting down" error message.  That's all.

> > The following patch will register each of the cpci busses instead
> > of just the first one detected.
> 
> Your patch is better than Harold's hack, but I'm probably going to
> try and think of some other alternative, as the while loop idea
> doesn't handle the possibility of someone having a 21154 bridge
> on a PMC card or actually as a bridge on a cPCI card.  The original
> code doesn't really handle that possiblity either, so I'll need to
> cook up something better anyway.
> 
> > NOTE: I'm a little worried that the right way to do this is to
> >       properly initialize the RSS bits, or at least see how the
> >       chassis is configured via the RSS bits to determine which 
> >       cpci bus to register.  The ZT5084 doesn't have near as many
> >       configurations as newer designs like the ZT5088.
> [snip]
> 
> I will investigate reading the active bus(es) out of the HC, as I've
> gotten the documentation for the HC from Performance Tech, I was just
> too busy before Christmas to dig into it then.  I'll try and have
> something that attempts to handle your ZT5084 chassis done in a few
> days.
> 
> Scott

------=_NextPart_000_005C_01C2B713.A5C9E990
Content-Type: text/plain;
	name="lspci_system_master.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci_system_master.txt"

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge =
(rev 03)=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
	Latency: 64=0A=
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=3D64M]=0A=
	Capabilities: <available only to root>=0A=
=0A=
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge =
(rev 03) (prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 128=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64=0A=
	I/O behind bridge: 0000f000-00000fff=0A=
	Memory behind bridge: f5000000-f5ffffff=0A=
	Prefetchable memory behind bridge: fff00000-000fffff=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+=0A=
=0A=
00:05.0 Ethernet controller: Digital Equipment Corporation DECchip =
21142/43 (rev 41)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 165 (5000ns min, 10000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: I/O ports at 1080 [size=3D128]=0A=
	Region 1: Memory at f4001000 (32-bit, non-prefetchable) [size=3D1K]=0A=
	Expansion ROM at <unassigned> [disabled] [size=3D256K]=0A=
=0A=
00:06.0 Ethernet controller: Digital Equipment Corporation DECchip =
21142/43 (rev 41)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 165 (5000ns min, 10000ns max), cache line size 08=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 0: I/O ports at 1400 [size=3D128]=0A=
	Region 1: Memory at f4001400 (32-bit, non-prefetchable) [size=3D1K]=0A=
	Expansion ROM at <unassigned> [disabled] [size=3D256K]=0A=
=0A=
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) =
(prog-if 80 [Master])=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Region 4: I/O ports at 14a0 [size=3D16]=0A=
=0A=
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) =
(prog-if 00 [UHCI])=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64=0A=
	Interrupt: pin D routed to IRQ 9=0A=
	Region 4: I/O ports at 1060 [size=3D32]=0A=
=0A=
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)=0A=
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin ? routed to IRQ 9=0A=
=0A=
00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64, cache line size 08=0A=
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D68=0A=
	I/O behind bridge: 00002000-00002fff=0A=
	Memory behind bridge: f6000000-f61fffff=0A=
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
	Capabilities: <available only to root>=0A=
=0A=
00:0b.0 Class ff00: Ziatech Corporation: Unknown device 5550 (rev 03)=0A=
	Subsystem: Ziatech Corporation: Unknown device 5550=0A=
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin A routed to IRQ 9=0A=
	Region 0: I/O ports at 1480 [size=3D32]=0A=
	Region 1: Memory at f4000000 (32-bit, non-prefetchable) [size=3D4K]=0A=
=0A=
00:0c.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) =
(prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64, cache line size 08=0A=
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D68=0A=
	I/O behind bridge: 00003000-00003fff=0A=
	Memory behind bridge: f6200000-f63fffff=0A=
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
	Capabilities: <available only to root>=0A=
=0A=
01:00.0 VGA compatible controller: Chips and Technologies F69000 =
HiQVideo (rev 64) (prog-if 00 [VGA])=0A=
	Subsystem: Chips and Technologies F69000 HiQVideo=0A=
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=3D16M]=0A=
	Expansion ROM at <unassigned> [disabled] [size=3D256K]=0A=
=0A=
02:0d.0 Bridge: Digital Equipment Corporation DECchip 21554 (rev 01)=0A=
	Subsystem: Ziatech Corporation: Unknown device 5541=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B+=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64, cache line size 08=0A=
	Interrupt: pin A routed to IRQ 11=0A=
	Region 0: Memory at f6101000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Region 1: I/O ports at 2400 [size=3D256]=0A=
	Region 2: I/O ports at 2000 [size=3D256]=0A=
	Region 3: Memory at f6000000 (32-bit, non-prefetchable) [size=3D1M]=0A=
	Region 4: Memory at f6100000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Capabilities: <available only to root>=0A=
=0A=
03:0a.0 Bridge: Digital Equipment Corporation DECchip 21554 (rev 01)=0A=
	Subsystem: Ziatech Corporation: Unknown device 5541=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B+=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 64, cache line size 08=0A=
	Interrupt: pin A routed to IRQ 10=0A=
	Region 0: Memory at f6301000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Region 1: I/O ports at 3400 [size=3D256]=0A=
	Region 2: I/O ports at 3000 [size=3D256]=0A=
	Region 3: Memory at f6200000 (32-bit, non-prefetchable) [size=3D1M]=0A=
	Region 4: Memory at f6300000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Capabilities: <available only to root>=0A=
=0A=

------=_NextPart_000_005C_01C2B713.A5C9E990
Content-Type: text/plain;
	name="proc_iomem.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_iomem.txt"

00000000-0009f7ff : System RAM=0A=
0009f800-0009ffff : reserved=0A=
000a0000-000bffff : Video RAM area=0A=
000c0000-000c7fff : Video ROM=0A=
000c9800-000c9fff : Extension ROM=0A=
000ca000-000ca7ff : Extension ROM=0A=
000f0000-000fffff : System ROM=0A=
00100000-0fffffff : System RAM=0A=
  00100000-002fda29 : Kernel code=0A=
  002fda2a-003c7d67 : Kernel data=0A=
f4000000-f4000fff : PCI device 1138:5550 (Ziatech Corporation)=0A=
  f4000000-f4000fff : cpcihp_zt5550=0A=
f4001000-f40013ff : Digital Equipment Co DECchip 21142/43=0A=
  f4001000-f40013ff : tulip=0A=
f4001400-f40017ff : Digital Equipment Co DECchip 21142/43 (#2)=0A=
  f4001400-f40017ff : tulip=0A=
f5000000-f5ffffff : PCI Bus #01=0A=
  f5000000-f5ffffff : Chips and Technologi F69000 HiQVideo=0A=
f6000000-f61fffff : PCI Bus #02=0A=
  f6000000-f60fffff : Digital Equipment Co DECchip 21554=0A=
  f6100000-f6100fff : Digital Equipment Co DECchip 21554=0A=
  f6101000-f6101fff : Digital Equipment Co DECchip 21554=0A=
f6200000-f63fffff : PCI Bus #03=0A=
  f6200000-f62fffff : Digital Equipment Co DECchip 21554 (#2)=0A=
  f6300000-f6300fff : Digital Equipment Co DECchip 21554 (#2)=0A=
  f6301000-f6301fff : Digital Equipment Co DECchip 21554 (#2)=0A=
f8000000-fbffffff : Intel Corp. 440BX/ZX/DX - 82443B=0A=
fffc0000-ffffffff : reserved=0A=

------=_NextPart_000_005C_01C2B713.A5C9E990
Content-Type: text/plain;
	name="proc_ioports.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_ioports.txt"

0000-001f : dma1=0A=
0020-003f : pic1=0A=
0040-005f : timer=0A=
0060-006f : keyboard=0A=
0070-007f : rtc=0A=
0080-008f : dma page reg=0A=
00a0-00bf : pic2=0A=
00c0-00df : dma2=0A=
00e1-00e1 : #ENUM hotswap signal register=0A=
00f0-00ff : fpu=0A=
0170-0177 : ide1=0A=
01f0-01f7 : ide0=0A=
02f8-02ff : serial=0A=
0376-0376 : ide1=0A=
03c0-03df : vga+=0A=
03f6-03f6 : ide0=0A=
03f8-03ff : serial=0A=
0cf8-0cff : PCI conf1=0A=
1000-103f : Intel Corp. 82371AB/EB/MB PIIX4 =0A=
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4 =0A=
1060-107f : Intel Corp. 82371AB/EB/MB PIIX4 =0A=
1080-10ff : Digital Equipment Co DECchip 21142/43=0A=
  1080-10ff : tulip=0A=
1400-147f : Digital Equipment Co DECchip 21142/43 (#2)=0A=
  1400-147f : tulip=0A=
1480-149f : PCI device 1138:5550 (Ziatech Corporation)=0A=
14a0-14af : Intel Corp. 82371AB/EB/MB PIIX4 =0A=
2000-2fff : PCI Bus #02=0A=
  2000-20ff : Digital Equipment Co DECchip 21554=0A=
  2400-24ff : Digital Equipment Co DECchip 21554=0A=
3000-3fff : PCI Bus #03=0A=
  3000-30ff : Digital Equipment Co DECchip 21554 (#2)=0A=
  3400-34ff : Digital Equipment Co DECchip 21554 (#2)=0A=

------=_NextPart_000_005C_01C2B713.A5C9E990--

