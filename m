Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbRACSkf>; Wed, 3 Jan 2001 13:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbRACSkO>; Wed, 3 Jan 2001 13:40:14 -0500
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:62592 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S129465AbRACSkG>; Wed, 3 Jan 2001 13:40:06 -0500
Date: Wed, 3 Jan 2001 13:09:04 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: "Ts'o, Theodore -- Theodore Ts'o" <tytso@mit.edu>, <tytso@valinux.com>,
        Joel Koerwer <joel@ideacode.com>, Jens Axboe <axboe@suse.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        William Stearns <wstearns@pobox.com>
Subject: Loopback filesystem still hangs on 2.4.0-test13-pre7
Message-ID: <Pine.LNX.4.30.0101031202370.901-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
	This is just meant as an informational message, not a complaint.
Ted, could you note that this still exists on 2.4.0-test13-pre7 in the
todo page?  Many thanks.

[1.] One line summary of the problem:
	Loopback filesystem writes still hang on 2.4.0-test13-pre7.

[2.] Full description of the problem/report:
	Writing to the loopback filesystem continues to hang 2.4 kernel
based systems, up to and including 2.4.0-test13-pre7.  This problem is
listed as "Loop device can still hang" under "To do but non showstopper"
in Ted's 2.4 kernel todo list.
	When writing a large amount of data to a loop mounted block
device, the system gets to a point where all writes halt, ps and top stop
displaying anything, and the system can no longer be shut down (I would
_guess_ that means that reads and writes can no longer be done on the host
drive, but that's not clear).  In older kernels, I would sometimes see ps
listing cp or umount in the D state at the point where all disk activity
stopped.
	Unfortunately, I can't get sysrq working on this system, so I
can't get much debugging info (yes, /proc/sys/kernel/sysrq=1).

[3.] Keywords (i.e., modules, networking, kernel):
	loop, filesystem

[4.] Kernel version (from /proc/version):
	Linux version 2.4.0-test13-pre7 (root@sparrow.websense.net) (gcc
version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #53 Sun Dec 31
02:41:27 EST 2000
	(compiled with kgcc from RH7).

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)

	This may need to be run multiple times.  On systems with a bunch
of memory, filling up ram with lots of bash's tends to show up the hang
more quickly.
	Please don't run with anything important in the background. :-)
While I haven't lost anything important on the host drive yet, I make no
promises for yours.

#!/bin/bash

if [ ! -d mnt ]; then mkdir mnt ; fi

dd if=/dev/zero of=testroot bs=$((1024 * 1024)) count=130 || exit 1
sync
sudo mke2fs -F testroot || exit 1

sudo umount mnt || true
#sudo mount -o loop testroot mnt || exit 1              #loop=./loop1
sudo losetup /dev/loop0 testroot
sudo mount /dev/loop0 mnt || exit 1

cd mnt
df
cp -pRv /usr/src/linux/drivers . >/dev/null
echo -n .
cp -pRv /usr/src/linux/drivers . >/dev/null
echo -n .
cp -pRv /usr/src/linux/drivers . >/dev/null
echo -n .
cp -pRv /usr/src/linux/drivers . >/dev/null
echo -n .
echo done!
df
cd ..
sudo umount mnt || exit 1
sudo losetup -d /dev/loop0
sync


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

[wstearns@sparrow scripts]$ sh ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux sparrow.websense.net 2.4.0-test13-pre7 #53 Sun Dec 31 02:41:27 EST
2000 i686 unknown
Kernel modules         2.3.14
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         wvlan_cs dummy

[7.2.] Processor information (from /proc/cpuinfo):

[wstearns@sparrow scripts]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 751.719
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 1500.77

[7.3.] Module information (from /proc/modules):

[wstearns@sparrow scripts]$ cat /proc/modules
wvlan_cs               23976   1
dummy                   1168   0 (unused)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

[wstearns@sparrow scripts]$ less /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : wvlan_cs
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(set)
0778-077a : parport0
0cf8-0cff : PCI conf1
1000-103f : Intel Corporation 82371AB PIIX4 ACPI
1040-105f : Intel Corporation 82371AB PIIX4 ACPI
1060-107f : Intel Corporation 82371AB PIIX4 USB
  1060-107f : usb-uhci
1080-1087 : Lucent Microelectronics WinModem 56k
1090-109f : Intel Corporation 82371AB PIIX4 IDE
  1090-1097 : ide0
  1098-109f : ide1
1400-14ff : ESS Technology ES1978 Maestro 2E
  1400-14ff : ESS Maestro 2E
1800-18ff : Lucent Microelectronics WinModem 56k
1c00-1cff : PCI CardBus #02
2000-2fff : PCI Bus #01
  2000-20ff : ATI Technologies Inc 3D Rage P/M Mobility AGP 2x
3000-30ff : PCI CardBus #02
3400-34ff : PCI CardBus #06
3800-38ff : PCI CardBus #06

[wstearns@sparrow scripts]$ less /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002bb22f : Kernel code
  002bb230-002d8327 : Kernel data
0fff0000-0ffffbff : ACPI Tables
0ffffc00-0fffffff : ACPI Non-volatile Storage
10000000-10000fff : Texas Instruments PCI1225
10001000-10001fff : Texas Instruments PCI1225 (#2)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
a0000000-a0000fff : card services
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
fc000000-fc0000ff : Lucent Microelectronics WinModem 56k
fc100000-fdffffff : PCI Bus #01
  fc100000-fc100fff : ATI Technologies Inc 3D Rage P/M Mobility AGP 2x
  fd000000-fdffffff : ATI Technologies Inc 3D Rage P/M Mobility AGP 2x
    fd000000-fd7effff : vesafb
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: fc100000-fdffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:04.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 009e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00001c00-00001cff
        I/O window 1: 00003000-000030ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
        Subsystem: Dell Computer Corporation: Unknown device 009e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00003400-000034ff
        I/O window 1: 00003800-000038ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1090 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 1060 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev
10)
        Subsystem: Dell Computer Corporation: Unknown device 009e
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 1400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D2 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Communication controller: Lucent Microelectronics WinModem 56k
(rev 01)
        Subsystem: Action Tec Electronics Inc: Unknown device 2100
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=256]
        Region 1: I/O ports at 1080 [size=8]
        Region 2: I/O ports at 1800 [size=256]
        Capabilities: [f8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M
AGP 2x (rev 64) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 009e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at fc100000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 1.0
                Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
	(none)

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

	Peter Enderborg and Joel Koerwer have confirmed, in previous
2.4.0-test* kernels, that the problem exists for them as well.  Jens Axboe
and Jeff Garzik have been kind enough to work on the problem in the past -
many, many thanks!
	No workaround known.  sync'ing between writes does not seem to
help.  Jens provided some patches, but we did not find a resolution yet.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"She worked with a subdued intensity... She once told me that the
only way to know when you have done something truly great is when your
spine tingles."
	- on Alice Kober, cryptanalist, in The Code Book, Simon Singh.
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
