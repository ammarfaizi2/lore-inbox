Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270327AbRHMRgp>; Mon, 13 Aug 2001 13:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270328AbRHMRgg>; Mon, 13 Aug 2001 13:36:36 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:39855 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270327AbRHMRgc>; Mon, 13 Aug 2001 13:36:32 -0400
Message-Id: <5.1.0.14.2.20010813181017.00ab81b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 13 Aug 2001 18:36:44 +0100
To: tegeran@home.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: via82cxxx_audio driver bug?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01081307194201.00276@c779218-a>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:19 13/08/2001, Nicholas Knight wrote:
>(my apologies if this gets seen as a little offtopic, I felt this was the
>best place to get results from people who knew what was going on with
>drivers)
>My writeup on the bug when I belived it was definitely an XMMS bug is
>avalible here:
>http://bugs.xmms.org/show_bug.cgi?id=115
>you'll need to scroll down to see details on what I isolated it to
>
>I just sent email to the maintainer of the via82cxxx_audio driver
>regarding this bug, hopefully I'll hear back from him soon, but I'd also
>like to hear from anyone else who has used and/or hacked at this driver,
>and if they've seen XMMS or other audio applications with access to
>/dev/mixer have strange, temporarily lockups when not in root/realtime
>priority. I've yet to be able to test this with other audio applications
>besides XMMS.

Sure enough it locks up as you describe, looks like a bug in the driver. 
The only way to recover is to killproc -9 xmms for me. Sometimes it even 
locks up the window manager (mouse moves but can't click anywhere) and I 
have to Ctrl+Altr+Backspace kill X to get the system back. But these 
lockups seem to depend on application used to play sound as well as on 
whether KDE or Gnome is running. Weird.

However I see some interesting effects when run as a root, too!

Audio playing will sometimes block and appear dead until "something" 
triggers the system call it is blocking in to be interrupted (run strace to 
see what I mean). Then it suddenly starts playing fine (I have seen this 
both as root and as normal user). - Weird. Basically there seems to be some 
problem with blocking i/o and the VIA AC97 codec driver (hardware here 
Class 0401: 1106:3058 (rev 50), Subsystem: 1106:4511 this translates to 
text: VIT Tech... AC97 Audio Controller (rev 50), Subsystem: VIA 
Technologies, Inc.: Unknown device 4511).

And there is something else possibly unrelated: Whenever there is high PCI 
activity I get sound drop outs, distortions and even sound slow downs, 
irrespectable of application used to play sound. For example moving any 
windows around or just causing high number of syscalls (e.g. run strace 
<some application, e.g. gmix in gnome>, then move sliders around in the 
application and listen to the sound or just move the application window 
around. same effect but weaker is produced by just taking a random not 
sound related window and moving it around as quickly as possible, effect is 
amplified when moving it so it moves over the xmms window).

I suspect the distortions/slowdowns are a direct effect of the PCI bus 
being saturated or in some way disturbed? I am not convinced this is a 
driver bug per se but it might be possible to fix it by working around this 
in the driver or in the BIOS settings somehow... The first problem with 
xmms blocking until a syscall interrupt is triggered is a bug in the driver 
though I would suspect (haven't looked at it).

Anton

Output of lspci -vvv follows:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 8
         Region 0: Memory at d2000000 (32-bit, prefetchable) [size=4M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Subsystem: VIA Technologies, Inc. Bus Master IDE
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at d000 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 
00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at d400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 
00 [UHCI])
         Subsystem: Unknown device 0925:1234
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 11
         Region 4: I/O ports at d800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin ? routed to IRQ 10
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
         Subsystem: VIA Technologies, Inc.: Unknown device 4511
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 15
         Region 0: I/O ports at dc00 [size=256]
         Region 1: I/O ports at e000 [size=4]
         Region 2: I/O ports at e400 [size=4]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0c.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] 
(rev 04)
         Subsystem: 3Com Corporation 3C900B-TPO Etherlink XL TPO 10Mb
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 12000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 15
         Region 0: I/O ports at e800 [size=128]
         Region 1: Memory at d2400000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0d.0 VGA compatible controller: Tseng Labs Inc ET6000 (rev 70) (prog-if 
00 [VGA])
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at d1000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: I/O ports at ec00 [size=256]
         Expansion ROM at <unassigned> [disabled] [size=16M]



-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

