Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313938AbSDUXSM>; Sun, 21 Apr 2002 19:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313942AbSDUXSL>; Sun, 21 Apr 2002 19:18:11 -0400
Received: from zork.zork.net ([66.92.188.166]:778 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S313938AbSDUXSK>;
	Sun, 21 Apr 2002 19:18:10 -0400
To: linux-kernel@vger.kernel.org
Subject: IRQ routing and USB audio on Dell Inspiron 4100
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Message-Flag: Message text advisory: DRUGS/ALCOHOL, ARGUMENTUM AD BACULUM
X-Mailer: Norman
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 22 Apr 2002 00:18:09 +0100
Message-ID: <6ur8l8ljym.fsf@zork.zork.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been having difficulty getting smooth USB audio output on my Dell
Inspiron 4100 with a Griffin iMic.  It works great when the machine is
unloaded (on 2.4.18 I got constant breakups; I think the improvement
is related to the recent USB fixes), but any video or disk activity
causes breakups.

I have a feeling that I need to get the USB controller onto its own
IRQ, and a further, horrible, feeling that the chipset in this machine
is "integrated" to such an extent that this is not possible.  My
fiddlings with setpci had no discernible effect, although I could
simply have been doing it wrong.

I'm running Linux 2.4.19-pre7 (with international Crypto and rmap13).
The BIOS version is A03, which does not appear to have any kind of
options for fiddling with IRQs at all.  I plan to try with A07
tomorrow.

Further information follows.

$ uname -a
Linux darkstar 2.4.19-pre7-rmap13-1 #1 Sun Apr 21 18:12:13 IST 2002 i686 unknown
$ /sbin/lsmod
Module                  Size  Used by    Tainted: P  
audio                  37824   0
uhci                   23784   0 (unused)
soundcore               3268   3 (autoclean) [audio]
orinoco_cs              4712   2
orinoco                29696   0 [orinoco_cs]
hermes                  3296   0 [orinoco_cs orinoco]
ds                      6624   3 [orinoco_cs]
i82365                 22448   3
pcmcia_core            38176   0 [orinoco_cs ds i82365]
ipt_state                608   1 (autoclean)
ip_conntrack           12940   1 (autoclean) [ipt_state]
ipt_REJECT              2784   3 (autoclean)
ipt_LOG                 3104   3 (autoclean)
iptable_filter          1728   1 (autoclean)
ip_tables              10368   4 [ipt_state ipt_REJECT ipt_LOG iptable_filter]
ext3                   56064   7 (autoclean)
jbd                    34536   7 (autoclean) [ext3]
usbcore                54080   1 [audio uhci]
cipher-blowfish         8736   1
cryptoloop              1916   1
cryptoapi               3044   2 [cipher-blowfish cryptoloop]
loop                    7824   3 [cryptoloop]
radeon                 92408   0 (unused)
agpgart                15456   1
apm                     9024   2
rtc                     5528   0 (autoclean)
$ cat /proc/interrupts 
           CPU0       
  0:     251481          XT-PIC  timer
  1:       7443          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          3          XT-PIC  rtc
 11:      18796          XT-PIC  i82365, orinoco_cs, usb-uhci
 12:      36747          XT-PIC  PS/2 Mouse
 14:      25275          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0 
ERR:          0
$ sudo lspci -vvvv
00:00.0 Host bridge: Intel Corp.: Unknown device 3575 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [40] #09 [0105]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp.: Unknown device 3576 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp.: Unknown device 2482 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at bf80 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) (rev 41) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=10, sec-latency=32
	I/O behind bridge: 0000e000-0000ffff
	Memory behind bridge: f4000000-fbffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp.: Unknown device 248c (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 248a (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 4541
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at bfa0 [size=16]
	Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.5 Multimedia audio controller: Intel Corp. AC'97 Audio Controller (rev 01)
	Subsystem: Cirrus Logic: Unknown device 5959
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc80 [size=64]

00:1f.6 Modem: Intel Corp.: Unknown device 2486 (rev 01) (prog-if 00 [Generic])
	Subsystem: PCTel Inc: Unknown device 4c21
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at d400 [size=256]
	Region 1: I/O ports at dc00 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00e4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at fcff0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 00e3
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec80 [size=128]
	Region 1: Memory at f8fffc00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at f9000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

02:01.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Dell Computer Corporation: Unknown device 00e4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=32
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:01.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Dell Computer Corporation: Unknown device 00e4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=32
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:03.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	Subsystem: Lucent Technologies: Unknown device ab01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=0b, subordinate=0e, sec-latency=176
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

Regards,

	Sean

-- 
 /////////////////  |                  | The spark of a pin
<sneakums@zork.net> |  (require 'gnu)  | dropping, falling feather-like.
 \\\\\\\\\\\\\\\\\  |                  | There is too much noise.
