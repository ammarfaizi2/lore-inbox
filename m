Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSIDSN6>; Wed, 4 Sep 2002 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSIDSN6>; Wed, 4 Sep 2002 14:13:58 -0400
Received: from [208.34.239.110] ([208.34.239.110]:20353 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S313558AbSIDSNx>; Wed, 4 Sep 2002 14:13:53 -0400
Date: Wed, 4 Sep 2002 14:19:52 -0400
From: Phil Stracchino <alaric@babcom.com>
To: linux-kernel@vger.kernel.org
Cc: alaric@babcom.com
Subject: PROBLEM:  Kernel 2.4.19 does not export _mmx_memcpy when compiled with gcc-3.2 and Athlon optimizations
Message-ID: <20020904181952.GA1158@babylon5.babcom.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM SUMMARY:
Kernel 2.4.19 apparently fails to export _mmx_memcpy when compiled with
gcc-3.2 and Athlon optimizations


While trying to isolate an apparent progressive hardware failure, I had
cause to swap the disks and SCSI controller from a K6-III/450 machine
running kernel 2.4.19 into an Athlon/1200 machine. Having done so, I
rebuilt the kernel with Athlon optimizations instead of K6-III.

Despite making no other change in the kernel configuration, this yielded
an unusable kernel.  The machine would boot, but almost all modules
failed to load and the system as a whole was not usable running on that
kernel.  All failures appeared to come down to a single error, reporting
_mmx_memcpy as an unresolved symbol.  It appears that for some reason
_mmx_memcpy is not exported from the kernel if Athlon optimization is
used.

The system was sufficiently non-functional that I was unable to capture
a log of the error messages.


Being of a suspicious nature, I generated .config files for K6 and
Athlon optimizations, and discovered the following:


--- .config.k6  Wed Sep  4 01:22:11 2002
+++ .config     Wed Sep  4 13:59:39 2002
@@ -29,8 +29,8 @@
 # CONFIG_M686 is not set
 # CONFIG_MPENTIUMIII is not set
 # CONFIG_MPENTIUM4 is not set
-CONFIG_MK6=y
-# CONFIG_MK7 is not set
+# CONFIG_MK6 is not set
+CONFIG_MK7=y
 # CONFIG_MELAN is not set
 # CONFIG_MCRUSOE is not set
 # CONFIG_MWINCHIPC6 is not set
@@ -45,9 +45,11 @@
 CONFIG_X86_POPAD_OK=y
 # CONFIG_RWSEM_GENERIC_SPINLOCK is not set
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
-CONFIG_X86_L1_CACHE_SHIFT=5
-CONFIG_X86_ALIGNMENT_16=y
+CONFIG_X86_L1_CACHE_SHIFT=6
 CONFIG_X86_TSC=y
+CONFIG_X86_GOOD_APIC=y
+CONFIG_X86_USE_3DNOW=y
+CONFIG_X86_PGE=y
 CONFIG_X86_USE_PPRO_CHECKSUM=y
 CONFIG_X86_MCE=y
 # CONFIG_TOSHIBA is not set


The significant thing here seems to be that CONFIG_X86_USE_3DNOW is not
enabled when compiling for K6, because K6, K6-II and K6-III are treated
as the same processor, even though the K6-III does in fact support
3DNow.  I was baffled as to why 3DNow code would work with K6
optimizations but not with Athlon, but now I see that the explanation
of that particular puzzle is that it wasn't being usedd on K6.  I'm
minded to try building a K6-optimized kernel with CONFIG_X86_USE_3DNOW
turned on, but I don't have the results of that experiment yet and will
report on it when I do.



ver_linux output:


        /*
         *      scripts/ver_linux doesn't report the binutils
         *      version, an omission that should be remedied.
         *      the following simple change would accomplish
         *      this, as well as improving readability of the
	 *	output:

--- scripts/ver_linux.orig      Sun Sep  2 10:27:18 2001
+++ scripts/ver_linux   Wed Sep  4 13:51:32 2002
@@ -12,7 +12,8 @@
 uname -a
 echo ' '
 
-echo "Gnu C                 " `gcc --version`
+echo "Gnu C                 " `gcc --version | head -1`
+echo "Binutils (from ld)    " `ld --version | head -1`
 
 make --version 2>&1 | awk -F, '{print $1}' | awk \
       '/GNU Make/{print "Gnu make              ",$NF}'

	 *	The following output is as patched:
         */


Linux babylon5 2.4.19 #7 Wed Sep 4 00:32:43 EDT 2002 i686 unknown
 
Gnu C                  gcc (GCC) 3.2
Binutils (from ld)     GNU ld version 2.12
Gnu make               3.79.1
util-linux             2.11f
mount                  2.11f
modutils               2.4.6
e2fsprogs              1.25
reiserfsprogs          3.x.0b
PPP                    2.4.0b4
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Linux C++ Library      5.0.0
Procps                 2.0.2
Net-tools              1.60
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         ppp_deflate bsd_comp ppp_async ppp_generic slhc
audiopci pnp soundbase sndshield serial nfs lockd sunrpc iptable_filter
ipt_MASQUERADE ip_nat_irc ip_conntrack_irc iptable_nat ip_tables
mousedev hid input usb-uhci usbcore st sg lp parport_pc parport isofs
inflate_fs sr_mod cdrom

binutils		2.12
	/*
	 *	scripts/ver_linux doesn't report the binutils
	 *	version, an omission that should be remedied.
	 *	the following one-line patch would accomplish
	 *	this, as well as improving readability:

*** scripts/ver_linux.orig      Sun Sep  2 10:27:18 2001
--- scripts/ver_linux   Wed Sep  4 13:51:32 2002
***************
*** 12,18 ****
  uname -a
  echo ' '
  
! echo "Gnu C                 " `gcc --version`
  
  make --version 2>&1 | awk -F, '{print $1}' | awk \
        '/GNU Make/{print "Gnu make              ",$NF}'
--- 12,19 ----
  uname -a
  echo ' '
  
! echo "Gnu C                 " `gcc --version | head -1`
! echo "Binutils (from ld)    " `ld --version | head -1`
  
  make --version 2>&1 | awk -F, '{print $1}' | awk \
        '/GNU Make/{print "Gnu make              ",$NF}'

	 */

/proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1200.097
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
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06


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
02f8-02ff : serial(auto)
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c0ff : 3Dfx Interactive, Inc. Voodoo 3
d000-d00f : VIA Technologies, Inc. Bus Master IDE
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
  d800-d81f : usb-uhci
dc00-dc3f : Ensoniq ES1370 [AudioPCI]
  dc00-dc3f : AudioPCI
e000-e07f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  e000-e07f : 00:09.0
e400-e403 : BusLogic BT-946C (BA80C30) [MultiMaster 10]
  e400-e403 : BusLogic BT-958


/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002098c6 : Kernel code
  002098c7-0027953f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d7ffffff : PCI Bus #01
  d4000000-d5ffffff : 3Dfx Interactive, Inc. Voodoo 3
d8000000-d9ffffff : PCI Bus #01
  d8000000-d9ffffff : 3Dfx Interactive, Inc. Voodoo 3
db000000-db00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
db001000-db001fff : BusLogic BT-946C (BA80C30) [MultiMaster 10]
ffff0000-ffffffff : reserved


/proc/modules:

ppp_deflate            39584   0 (autoclean)
bsd_comp                4288   0 (autoclean)
ppp_async               7504   1 (autoclean)
ppp_generic            15520   3 (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    4960   1 (autoclean) [ppp_generic]
audiopci               16768   0
pnp                    49904   0 [audiopci]
soundbase             846480   0 [audiopci pnp]
sndshield              11488   0 [audiopci pnp soundbase]
serial                 45920   2 (autoclean)
nfs                    66608   7 (autoclean)
lockd                  46640   1 (autoclean) [nfs]
sunrpc                 59552   1 (autoclean) [nfs lockd]
iptable_filter          1680   0 (autoclean) (unused)
ipt_MASQUERADE          1824   2 (autoclean)
ip_nat_irc              2976   0 (unused)
ip_conntrack_irc        2704   0 [ip_nat_irc]
iptable_nat            20096   9 [ipt_MASQUERADE ip_nat_irc]
ip_tables              14048   5 [iptable_filter ipt_MASQUERADE
iptable_nat]
mousedev                4128   1
hid                    18640   0 (unused)
input                   3456   0 [mousedev hid]
usb-uhci               21808   0 (unused)
usbcore                63872   1 [hid usb-uhci]
st                     26544   0 (unused)
sg                     31344   0 (unused)
lp                      6432   0 (unused)
parport_pc             21952   1
parport                25024   1 [lp parport_pc]
isofs                  25280   1 (autoclean)
inflate_fs             17760   0 (autoclean) [isofs]
sr_mod                 13280   0 (autoclean) (unused)
cdrom                  26592   0 (autoclean) [sr_mod]


lspci:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev
02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Region 0: Memory at d0000000 (32-bit, prefetchable)
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d4000000-d7ffffff
        Prefetchable memory behind bridge: d8000000-d9ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc.: Unknown device 0686 (rev 22)
        Subsystem: Unknown device 1106:0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
10) (prog-if 8a)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at d000
        Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d400
        Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d800
        Capabilities: <available only to root>

00:07.4 Host bridge: VIA Technologies, Inc.: Unknown device 3057 (rev
30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: <available only to root>

00:08.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)
        Subsystem: Unknown device 4942:4c4c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 12 min, 128 max, 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at dc00

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: Unknown device 10b7:9055
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 10 min, 10 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e000
        Region 1: Memory at db000000 (32-bit, non-prefetchable)
        Capabilities: <available only to root>

00:0c.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster
10] (rev 08)
        Subsystem: Unknown device 104b:1040
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e400
        Region 1: Memory at db001000 (32-bit, non-prefetchable)

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc.: Unknown
device 0005 (rev 01)
        Subsystem: Unknown device 121a:0030
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 14
        Region 0: Memory at d4000000 (32-bit, non-prefetchable)
        Region 1: Memory at d8000000 (32-bit, prefetchable)
        Region 2: I/O ports at c000
        Capabilities: <available only to root>


/proc/scsi/scsi:

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDYS-T18350N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03


-- 
  *********  Fight Back!  It may not be just YOUR life at risk.  *********
  phil stracchino   ::   alaric@babcom.com   ::   halmayne@sourceforge.net
    unix ronin     ::::   renaissance man   ::::   mystic zen biker geek
     2000 CBR929RR, 1991 VFR750F3 (foully murdered), 1986 VF500F (sold)
       Linux Now! ...because friends don't let friends use Microsoft.
