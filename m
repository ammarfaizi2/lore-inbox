Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSESN7t>; Sun, 19 May 2002 09:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314484AbSESN7s>; Sun, 19 May 2002 09:59:48 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:31685 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S314433AbSESN7p>; Sun, 19 May 2002 09:59:45 -0400
Message-ID: <3CE7B118.5010601@anu.edu.au>
Date: Mon, 20 May 2002 00:05:12 +1000
From: David Houlder <david.houlder@anu.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MTRR problem in 2.4.7+ on Athlon+VIA? XFree86 can't write-combine
 framebuffer.
Content-Type: multipart/mixed;
 boundary="------------030406040804030201030507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030406040804030201030507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi...

If any kind soul out there has the time to investigate this I'd be very 
grateful.

I have a problem with the XFree86 4.1.0 nv driver failing to set up a 
write-combining mtrr range for my video card. This happens with both 
2.4.9-31 and 2.4.7-10 (redhat kernels). The system is an AMD Athlon with 
VIA chipset (see attachments for details).
KT133 chipset
TNT2 video card 8mb RAM
Epox EP-8KTA2 motherboard (onboard VIA audio).

Basically, the "nv" driver reports
(WW) NV(0): Failed to set up write-combining range (0xd4000000,0x800000)
to XFree86.0.log. XFree86 works, but things like MPEG playback seem a 
bit slow.

I assume this is because cat /proc/mtrr looks like this before X starts:

reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
reg01: base=0xd0000000 (3328MB), size= 128MB: uncachable, count=1

 From reading the mtrr doco I gather that because 0xd0000000 + 128mb is 
already set up as an uncachable range, "nv" can't set up 0xd4000000 + 
8mb as write-combining.

This uncachable range seems to be set up fairly early in the system 
startup. I created a little /etc/rc5.d/S00MTRRDUMP script to cat 
/proc/mtrr before any of the other S* scripts run, and it reported the 
same mtrr ranges above.

I've searched all through the 2.4.7-10 source code and can't see 
anything that I'm using that explicitly asks for MTRR_TYPE_UNCACHABLE, 
so I'm a bit perplexed. I've had a good look around the web and 
newsgroups with all the keyword combinations I can think of, but no 
luck. mtrr.c is v1.40.

The only thing that looks suspicious to me is some lines in dmesg 
refering to 'unknown bridge', but that might be completely OK, I'm not 
sure (See below).


ver_linux reports...
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.13
e2fsprogs              tune2fs
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sr_mod ppp_deflate bsd_comp ppp_async ppp_generic 
slhc via82cxxx_audio uart401 ac97_codec sound soundcore scanner sg 
ide-scsi scsi_mod ide-cd cdrom nls_iso8859-1 nls_cp437 vfat fat usb-uhci 
usbcore ext3 jbd

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
   00100000-002b4b99 : Kernel code
   002b4b9a-002cbccf : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d5ffffff : PCI Bus #01
   d4000000-d5ffffff : nVidia Corporation Vanta [NV6]
d6000000-d7ffffff : PCI Bus #01
   d6000000-d6ffffff : nVidia Corporation Vanta [NV6]
ffff0000-ffffffff : reserved

The interesting bits of dmesg are:
...
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA southbridge workaround.
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
...
parport_pc: Via 686A parallel port: io=0x378
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
mtrr: type mismatch for d4000000,800000 old: uncachable new: 
write-combining  <<<<----- I'm pretty sure this is XFree86 trying to 
write-combine
Via 686a audio driver 1.9.1
PCI: Found IRQ 10 for device 00:07.5
ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (ICE1232)
via82cxxx: board #1 at 0xDC00, IRQ 10
...


A few other dumps are attached (apologies if this is overkill).

I'm not on the mailing list, so please reply directly if you have any 
suggestions.

Thanks in advance,
David Houlder.



--------------030406040804030201030507
Content-Type: text/plain;
 name="lspci-vv"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-vv"

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d6000000-d7ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: <available only to root>

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: <available only to root>

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
	Subsystem: VIA Technologies, Inc.: Unknown device 4511
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=4]
	Capabilities: <available only to root>

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
	Subsystem: AOPEN Inc.: Unknown device 0032
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>


--------------030406040804030201030507
Content-Type: text/plain;
 name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo"

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 801.827
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1599.07


--------------030406040804030201030507
Content-Type: text/plain;
 name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod"

Module                  Size  Used by    Tainted: P  
ppp_deflate            41760   0 (autoclean)
bsd_comp                4352   0 (autoclean)
ppp_async               6752   0 (autoclean)
ppp_generic            19432   0 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    5504   0 (autoclean) [ppp_generic]
via82cxxx_audio        18400   1 (autoclean)
uart401                 6592   0 (autoclean) [via82cxxx_audio]
ac97_codec              9536   0 (autoclean) [via82cxxx_audio]
sound                  59628   0 (autoclean) [via82cxxx_audio uart401]
soundcore               4452   4 (autoclean) [via82cxxx_audio sound]
scanner                 7776   0 (unused)
sg                     28932   0 (autoclean)
ide-scsi                8352   0
scsi_mod               98840   2 [sg ide-scsi]
ide-cd                 27072   0
cdrom                  28672   0 [ide-cd]
nls_iso8859-1           2816   1 (autoclean)
nls_cp437               4320   1 (autoclean)
vfat                   10396   1 (autoclean)
fat                    33112   0 (autoclean) [vfat]
usb-uhci               21732   0 (unused)
usbcore                51936   1 [scanner usb-uhci]
ext3                   62624   3
jbd                    41156   3 [ext3]

--------------030406040804030201030507--

