Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136452AbRD3Gcl>; Mon, 30 Apr 2001 02:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136455AbRD3Gci>; Mon, 30 Apr 2001 02:32:38 -0400
Received: from smtp09.phx.gblx.net ([206.165.6.139]:4312 "EHLO
	smtp09.phx.gblx.net") by vger.kernel.org with ESMTP
	id <S136452AbRD3GcW>; Mon, 30 Apr 2001 02:32:22 -0400
From: believe@primenet.com
Date: Mon, 30 Apr 2001 02:32:05 -0400
To: linux-kernel@vger.kernel.org
Subject: New aic7xxx driver locking disk access
Message-ID: <20010430023205.A1707@zanzibar.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. New aic7xxx driver locking disk access

2. When I compiled a new 2.4.4 kernel with the new aic7xxx driver, it
would sporatically start spitting out messages to the root
window/syslog as such:

Apr 28 04:17:40 zanzibar kernel: scsi0:0:6:0: Attempting to queue an
ABORT message
Apr 28 04:17:40 zanzibar kernel: scsi0:0:6:0: Cmd aborted from QINFIFO
Apr 28 04:18:30 zanzibar kernel: aic7xxx_abort returns 8194

This would be repeated several times, then this:

pr 28 04:18:30 zanzibar kernel: scsi0:0:6:0: Attempting to queue an
ABORT message
Apr 28 04:18:30 zanzibar kernel: scsi0:0:6:0: Device is active,
asserting ATN
Apr 28 04:18:30 zanzibar kernel: Recovery code sleeping
Apr 28 04:18:30 zanzibar kernel: Recovery code awake
Apr 28 04:18:30 zanzibar kernel: Timer Expired
Apr 28 04:18:30 zanzibar kernel: aic7xxx_abort returns 8195
Apr 28 04:18:30 zanzibar kernel: scsi0:0:6:0: Attempting to queue a
TARGET RESET message
Apr 28 04:18:30 zanzibar kernel: scsi0:0:6:0: Command not found
Apr 28 04:18:30 zanzibar kernel: aic7xxx_dev_reset returns 8194
Apr 28 04:18:30 zanzibar kernel: scsi0:0:6:0: Attempting to queue an
ABORT message
Apr 28 04:18:30 zanzibar kernel: scsi0:0:6:0: Cmd aborted from QINFIFO
Apr 28 04:18:30 zanzibar kernel: aic7xxx_abort returns 8194
Apr 28 04:18:30 zanzibar kernel: Recovery SCB completes

This is with the new TCQ default of 253, and it causes disk access to
stop for quite a few minutes while it spits this out.  Anything in
memory seems to be fine (suck as messages in X Chat keep going), but
anything requiring disk access will just lock.  Lowering the TCQ helps a
little, but it still happens, although when 9it happens, it doesn't take
quite as long.  I even reduced it to 1, but it still happened, and it
had a habit of locking up the machine totally with nothing too helpful
in the syslog.  Configuring it as 0 wouldn't give those messages, but
still the machine seemed to want to lock on me.  I am now using the old
driver for now.

I also patched /usr/src/linux/include/linux/skbuff.h to get vmware
working by adding this after the "/* Internal*/" line:

static inline atomic_t *skb_datarefp(struct sk_buff *skb)
{
        return (atomic_t *)(skb->end);
}

I'm not sure if this would affect this problem, though.  After the
modules for vmware were loaded, I do get weird messages about sr0 in
the syslog, though.

Apr 29 00:50:50 zanzibar kernel: cdrom: open failed.
Apr 29 00:50:50 zanzibar kernel: Device not ready.  Make sure there is a
disc in the drive.
Apr 29 00:50:50 zanzibar kernel: VFS: Disk change detected on device
sr(11,0)
Apr 29 00:51:06 zanzibar kernel: cdrom: open failed.
Apr 29 00:51:06 zanzibar kernel: VFS: Disk change detected on device
sr(11,1)

I did leave a disk in the drive at the time, but it was not mounted, or
being accessed.  This seems to have happened at times when there was
also no disk in the drive.

aic7xxx is compiled into the kernel and not as a module, since this is an
all SCSI machine.

Note:  this problem didn't happen in 2.4.3, and I was using the new
driver.  Even then, it seemed to have a problem detecting my DVD-ROM on
0,0,0, until I moved it to 0,4,0, then it worked.  It may have been
because the SCSI delay was set to 5 ms instead of 5000 (5 s).

3. Keywords:  aic7xxx, scsi, Adaptec

4. Linux version 2.4.4 (root@zanzibar) (gcc version 2.95.4 20010319
(Debian prerelease)) #2 Mon Apr 30 00:32:34 EDT 2001

5. No Oops.. that I can see, the log messages included above.

6. The problem seems to be triggered when a program drives up disk usage
(like vi'ing a large syslog).

7. Environment is Debian unstable, kernel 2.4.4, running gdm and KDE 2.1.1
at the time.

7.1. Output of ver_linux:

Linux zanzibar 2.4.4 #2 Mon Apr 30 00:32:34 EDT 2001 i686 unknown
 
 Gnu C                  2.95.4
 Gnu make               3.79.1
 binutils               2.11.90.0.5
 util-linux             2.11b
 mount                  2.11b
 modutils               2.4.2
 e2fsprogs              1.19
 reiserfsprogs          3.x.0j
 PPP                    2.4.1
 Linux C Library        2.2.2
 Dynamic linker (ldd)   2.2.2
 Procps                 2.0.7
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               2.0.11
 Modules Loaded         vmnet vmmon ppp_deflate ppp_async ppp_generic
 slhc ipt_REJECT ntfs smbfs vfat fat emu10k1 soundcore parport_pc
 parport mga agpgart joydev mousedev usbmouse hid input usb-uhci usbcore
 ipt_REDIRECT ipt_MASQUERADE iptable_nat ip_conntrack iptable_filter
 ip_tables loop 3c59x sg

7.2:  Processor:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1000.070
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1992.29

7.3. Modules:
vmnet                  18720   3
vmmon                  18352   0 (unused)
ppp_deflate            40128   0 (autoclean)
ppp_async               6352   1 (autoclean)
ppp_generic            13536   3 (autoclean) [ppp_deflate ppp_async]
slhc                    5024   0 (autoclean) [ppp_generic]
ipt_REJECT              3296   0 (unused)
ntfs                   36752   0 (unused)
smbfs                  33648   0 (unused)
vfat                    9040   0 (unused)
fat                    31200   0 [vfat]
emu10k1                43312   0
soundcore               4112   4 [emu10k1]
parport_pc             13520   0
parport                27616   0 [parport_pc]
mga                    89728   1
agpgart                13024   3
joydev                  5952   0 (unused)
mousedev                4064   2
usbmouse                1888   0 (unused)
hid                    11872   0 (unused)
input                   3520   0 [joydev mousedev usbmouse hid]
usb-uhci               22352   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)

usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)
usbcore                48432   1 [usbmouse hid usb-uhci]
ipt_REDIRECT            1056   0 (unused)
ipt_MASQUERADE          1456   1
iptable_nat            14832   0 [ipt_REDIRECT ipt_MASQUERADE]
ip_conntrack           14032   1 [ipt_REDIRECT ipt_MASQUERADE
iptable_nat]
iptable_filter          2080   0 (unused)
ip_tables              10432   7 [ipt_REJECT ipt_REDIRECT ipt_MASQUERADE
iptable
_nat iptable_filter]
loop                    8432   0 (unused)
3c59x                  24224   1
sg                     25296   0 (unused)

7.4. Loaded driver and hardware information
  /proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(set)
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. Bus Master IDE
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
  d800-d81f : usb-uhci
dc00-dcff : Adaptec AHA-2940U2/W
  dc00-dcfe : aic7xxx
e000-e01f : Creative Labs SB Live! EMU10000
  e000-e01f : EMU10K1
e400-e407 : Creative Labs SB Live!
e800-e87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  e800-e87f : eth0

  /proc/iomem:

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0020aed7 : Kernel code
  0020aed8-0026ad1f : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d5ffffff : PCI Bus #01
  d4000000-d5ffffff : Matrox Graphics, Inc. MGA G400 AGP
d6000000-d8ffffff : PCI Bus #01
  d6000000-d6003fff : Matrox Graphics, Inc. MGA G400 AGP
  d7000000-d77fffff : Matrox Graphics, Inc. MGA G400 AGP
da000000-da000fff : Adaptec AHA-2940U2/W
da001000-da00107f : 3Com Corporation 3c905B 100BaseTX [Cyclone]

7.5. PCI information:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d6000000-d8ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 15
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 15
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 12
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: Adaptec AHA-2940U2/W
	Subsystem: Adaptec: Unknown device a180
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	BIST result: 00
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at da000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
	Subsystem: Creative Labs CT4760 SBLive!
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at e400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=128]
	Region 1: Memory at da001000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

7.6. SCSI information:

Attached devices: 
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0c
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: TOSHIBA  Model: DVD-ROM SD-M1401 Rev: 1007
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDRS-39130D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02

  /proc/scsi/aic7xxx/0:

Adaptec AIC7xxx driver version: 5.2.1/5.2.0
Compile Options:
  TCQ Enabled By Default : Disabled
  AIC7XXX_PROC_STATS     : Disabled

Adapter Configuration:
           SCSI Adapter: Adaptec AHA-294X Ultra2 SCSI host adapter
                           Ultra-2 LVD/SE Wide Controller at PCI 0/11/0
    PCI MMAPed I/O Base: 0xda000000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 15
                   SCBs: Active 0, Max Active 1,
                         Allocated 31, HW 32, Page 255
             Interrupts: 28389
      BIOS Control Word: 0x18a6
   Adapter Control Word: 0x1c5d
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0000
 Tag Queue Enable Flags: 0x0000
Ordered Queue Tag Flags: 0x0000
Default Tag Queue Depth: 8
    Tagged Queue By Device array for aic7xxx host instance 0:
      {255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:3:0)
  Device using Narrow/Sync transfers at 10.0 MByte/sec, offset 15
  Transinfo settings: current(25/15/0/0), goal(10/127/0/0), user(10/127/1/0)
  Total transfers 0 (0 reads and 0 writes)


(scsi0:0:4:0)
  Device using Narrow/Sync transfers at 5.0 MByte/sec, offset 16
  Transinfo settings: current(50/16/0/0), goal(50/127/0/0), user(50/127/1/0)
  Total transfers 0 (0 reads and 0 writes)


(scsi0:0:6:0)
  Device using Wide/Sync transfers at 80.0 MByte/sec, offset 15
  Transinfo settings: current(10/15/1/0), goal(10/127/1/0), user(10/127/1/0)
  Total transfers 28287 (11934 reads and 16353 writes)

Once again, this aic7xxx info is with the old driver now, since I've rebuilt
hoping for stability.  If there's info that is needed from a kernel with
the new driver, let me know.

Please reply to me as well, since I'm not on the list.

Thanks.

-- 

                -Jason Pool-     -<believe@primenet.com>-
"Poor planning on your part does | "It is much easier to suggest
 not necessitate an automatic    |  solutions when you know nothing 
 emergency on my part" - Unknown |  about the problem." - Unknown
