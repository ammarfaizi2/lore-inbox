Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTADXcr>; Sat, 4 Jan 2003 18:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTADXcr>; Sat, 4 Jan 2003 18:32:47 -0500
Received: from mail46-s.fg.online.no ([148.122.161.46]:29633 "EHLO
	mail46.fg.online.no") by vger.kernel.org with ESMTP
	id <S261733AbTADXcp> convert rfc822-to-8bit; Sat, 4 Jan 2003 18:32:45 -0500
To: johannes@erdfelt.com, linux-kernel@vger.kernel.org
Subject: Problem with uhci and usb-uhci
From: svendsen@pvv.org (=?iso-8859-1?q?=D8ystein?= Svendsen)
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <E18UxuX-0001yJ-00@localhost>
Date: Sun, 05 Jan 2003 00:41:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry to bother you, but I have found a problem with uhci/usb-uhci
stuff in kernel 2.4.20, which I believe someone might want to look
into.

Summary:
Using usb-midi and doing cat /dev/midi stalls both the uhci.o and
usb-uhci.o, drivers.

Description:
I have a Terratec MK-249 USB MIDI keyboard and a Soundblaster Extigy,
who are both recognised by the usb-midi driver.

It does not matter whether I connect the Extigy or the MIDI keyboard,
the usb systems stalls (my usb mouse stops working) when I cat /dev/midi.

The usb system stalls both on modules uhci.o and usb-uhci.o.

When using uhci.o, I get this stuff in the log:

Jan  4 23:25:45 localhost kernel: usb-midi: Found MIDISTREAMING on dev 0a4d:008c, iface 1
Jan  4 23:25:45 localhost kernel: usb-midi: Found MIDIStreaming device corresponding to Release 1.00 of spec.
Jan  4 23:25:45 localhost kernel: usb-midi: Found IN Jack 0x01 EMBEDDED
Jan  4 23:25:45 localhost kernel: usb-midi: Found IN Jack 0x02 EXTERNAL
Jan  4 23:25:45 localhost kernel: usb-midi: Found OUT Jack 0x03 EMBEDDED, 1 pins
Jan  4 23:25:45 localhost kernel: usb-midi: Found OUT Jack 0x04 EXTERNAL, 1 pins
Jan  4 23:25:45 localhost kernel: usb.c: ignoring set_interface for dev 5, iface 1, alt 0
Jan  4 23:25:45 localhost kernel: usb-midi: fetchString(2)
Jan  4 23:25:45 localhost kernel: usb-midi: fetchString = 24
Jan  4 23:25:45 localhost kernel: usbmidi: found [ MK-249 USB MIDI keyboard ] (0x0a4d:0x008c), attached:
Jan  4 23:25:45 localhost kernel: usbmidi: /dev/midi00: in (ep:81 cid: 0 bufsiz: 0) out (ep:02 cid: 0 bufsiz:64)
Jan  4 23:25:45 localhost kernel: usb.c: midi driver claimed interface d801dc18
After cat /dev/midi:
Jan  4 23:26:09 localhost kernel: uhci.c: uhci_result_interrupt/bulk() failed with status 500000
Jan  4 23:26:09 localhost kernel: [d70ad0c0] link (170ad092) element (1660e240)
Jan  4 23:26:09 localhost kernel:   0: [d660e240] link (00000001) e3 IOC Stalled Babble Length=7ff MaxLen=7ff DT0 EndPt=1 Dev=5, PID=69(IN) (buf=00000000)
Jan  4 23:26:09 localhost kernel: 


And, when using usb-uhci.o (and after enabling usb-uhci-debug), I get this:

Jan  5 00:18:20 localhost kernel: usb-uhci.c: interrupt, status 3, frame# 1003
Jan  5 00:18:20 localhost kernel: usb-uhci-debug.h:   usbcmd    =     00c1   Maxp64 CF RS 
Jan  5 00:18:20 localhost kernel: usb-uhci-debug.h:   usbstat   =     0003   USBError USBINT 
Jan  5 00:18:20 localhost kernel: usb-uhci-debug.h:   usbint    =     000f
Jan  5 00:18:20 localhost kernel: usb-uhci-debug.h:   usbfrnum  =   (0)fac
Jan  5 00:18:20 localhost kernel: usb-uhci-debug.h:   flbaseadd = 05abd000
Jan  5 00:18:20 localhost kernel: usb-uhci-debug.h:   sof       =       40
Jan  5 00:18:20 localhost kernel: usb-uhci-debug.h:   stat1     =     0495   PortEnabled PortConnected 
Jan  5 00:18:20 localhost kernel: usb-uhci-debug.h:   stat2     =     0495   PortEnabled PortConnected 

The usb stuff works fine after I reload the uhci/usb-uhci module.

Kernel:
Linux version 2.4.20-xfs (root@knotten) (gcc version 2.95.4 20011002
(Debian prerelease)) #4 Sat Jan 4 23:09:30 CET 2003.

No oopses or panics.

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1401.734
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2798.38

lspci -vvv:

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at c800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at cc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Any ideas?

-- 
    Øystein Svendsen 

