Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWBFKyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWBFKyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWBFKyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:54:41 -0500
Received: from oostc.West.NL ([192.43.210.80]:16317 "EHLO oostc.West.NL")
	by vger.kernel.org with ESMTP id S1751077AbWBFKyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:54:40 -0500
Subject: PROBLEM: megaraid2 performance problems with 2.4.32
From: Arthur de Jong <arthur@west.nl>
To: Atul Mukker <Atul.Mukker@lsil.com>,
       Sreenivas Bagalkote <Sreenivas.Bagalkote@lsil.com>,
       linux-kernel@vger.kernel.org, seokmann.ju@lsil.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: West Consulting
Date: Mon, 06 Feb 2006 11:54:31 +0100
Message-Id: <1139223271.9222.114.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-Scanned: by amavis-bq at mailhost.west.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry to send this mail to so many people. Feel free to ignore this if
you don't think it's appropriate for you.

[1.] One line summary of the problem:

The megaraid2 driver from the 2.4.32 kernel has horrible performance
compared to the 2.4.31 one.

[2.] Full description of the problem/report:

When upgrading kernels we noticed a steep drop in transfer rate from our
scsi tape to our scsi disk (all non-raid (raid 0 logical devices) but
using the Dell MegaRAID 518 DELL PERC 4/DC RAID Controller). The
performance drops from 24MByte/second to ** 2MByte/second when
performing a restore (tar) from tape to disk.

Our kernels are patched with the ghosting patch
(http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs4-2.4.29-20050404.patch) and an ipmi patch (http://linux.dell.com/files/ipmi/ipmi_kcs_drv.patch). I believe both patches are irrelevant to these problems.

We tested with 2.4.31 (with mentioned patches) and the performance is
ok. With 2.4.32 the performance is bad. Copying
drivers/scsi/megaraid2.[ch] from 2.4.31 to 2.4.32 results is a usable
kernel with ok performance.

[3.] Keywords (i.e., modules, networking, kernel):

megaraid2, 2.4.32

[4.] Kernel version (from /proc/version):

Linux version 2.4.32-exp (root@turin) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 SMP Mon Jan 9 14:51:07 CET 2006

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
n/a

[6.] A small shell script or example program which triggers the
     problem (if possible)

Two test runs transferring 10GByte of data. These results were done on
2.4.31 and 2.4.32 kernels with identical .config and building tools. The
filesystem type used was reiserfs. Activity on the system was comparable
with all tests (not single user mode though).

** 2.4.31 kernel tests

# uname -r
2.4.31-pe1850
# rm -f test.file
# time dd if=/dev/zero of=test.file bs=32k count=327680
327680+0 records in
327680+0 records out
10737418240 bytes transferred in 199.794846 seconds (53742218 bytes/sec)

real    3m19.796s
user    0m0.290s
sys     0m50.520s
# mt -f /dev/st0 rewind ; mt -f /dev/nst0 fsf 1
# time dd if=/dev/nst0 of=/dev/null bs=32k count=327680
327680+0 records in
327680+0 records out
10737418240 bytes transferred in 250.968109 seconds (42783995 bytes/sec)

real    4m10.977s
user    0m0.220s
sys     0m4.090s
# mt -f /dev/st0 rewind ; mt -f /dev/nst0 fsf 1
rm -f test.file
# rm -f test.file
# time dd if=/dev/nst0 of=test.file bs=32k count=327680
327680+0 records in
327680+0 records out
10737418240 bytes transferred in 422.225318 seconds (25430541 bytes/sec)

real    7m2.235s
user    0m0.270s
sys     0m50.590s

** 2.4.32 kernel tests

# uname -r
2.4.32-pe1850
# rm -f test.file
g# time dd if=/dev/zero of=test.file bs=32k count=327680
327680+0 records in
327680+0 records out
10737418240 bytes transferred in 210.005062 seconds (51129331 bytes/sec)

real    3m30.006s
user    0m0.270s
sys     0m49.850s
# mt -f /dev/st0 rewind ; mt -f /dev/nst0 fsf 1
# time dd if=/dev/nst0 of=/dev/null bs=32k count=327680
327680+0 records in
327680+0 records out
10737418240 bytes transferred in 4967.018522 seconds (2161743 bytes/sec)

real    82m47.072s
user    0m0.200s
sys     0m3.640s

(the tape to disk test was skipped, if it's really relevant I can rerun
the test)

And in friendly table format:

  2.4.31     disk      tape      tape->disk
rate         51.3M/s   40.8M/s   24.3M/s
real time    3m19.796s 4m10.977s 7m2.235s
user time    0m0.290s  0m0.220s  0m0.270s
sys time     0m50.520s 0m4.090s  0m50.590s

  2.4.32     disk      tape       tape->disk
rate         48.8M/s   2.0M/s
real time    3m30.006s 82m47.072s
user time    0m0.270s  0m0.200s
sys time     0m49.850s 0m3.640s


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux turin 2.4.32-exp #1 SMP Mon Jan 9 14:51:07 CET 2006 i686 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
util-linux             2.12p
mount                  2.12p
modutils               2.4.26
e2fsprogs              1.37
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         st nfsd autofs4 nfs lockd sunrpc i810_rng
ehci-hcd usb-uhci usbcore ide-scsi e1000 ipmi_devintf ipmi_kcs_drv
ipmi_msghandler ipv6 i2c-proc i2c-core ide-disk ide-detect ide-cd cdrom
ide-core unix

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 3
cpu MHz         : 2793.274
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
pni monitor ds_cpl cid
bogomips        : 5570.56

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 3
cpu MHz         : 2793.274
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
pni monitor ds_cpl cid
bogomips        : 5583.66

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 3
cpu MHz         : 2793.274
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
pni monitor ds_cpl cid
bogomips        : 5583.66

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 3
cpu MHz         : 2793.274
cache size      : 16 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
pni monitor ds_cpl cid
bogomips        : 5583.66

[7.3.] Module information (from /proc/modules):

st                     29560   0 (autoclean)
nfsd                   74032   8 (autoclean)
autofs4                13112   6
nfs                    77240   3 (autoclean)
lockd                  49744   1 (autoclean) [nfsd nfs]
sunrpc                 74272   1 (autoclean) [nfsd nfs lockd]
i810_rng                2788   0 (unused)
ehci-hcd               18956   0 (unused)
usb-uhci               24176   0 (unused)
usbcore                66188   1 [ehci-hcd usb-uhci]
ide-scsi               10320   0
e1000                  74380   1
ipmi_devintf            3752   0 (unused)
ipmi_kcs_drv           10121   0 (unused)
ipmi_msghandler        14152   0 [ipmi_devintf ipmi_kcs_drv]
ipv6                  218772  -1
i2c-proc                6704   0 (unused)
i2c-core               13860   0 [i2c-proc]
ide-disk               15904   0
ide-detect               288   0 (unused)
ide-cd                 31264   0
cdrom                  29696   0 [ide-cd]
ide-core              111352   0 [ide-scsi ide-disk ide-detect ide-cd]
unix                   16976  21 (autoclean)

[7.4.] Loaded driver and hardware information
(/proc/ioports, /proc/iomem) 

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0828-082f : GPE0_BLK
0ca8-0ca8 : ipmi_kcs
0cac-0cac : ipmi_kcs
0cf8-0cff : PCI conf1
bca0-bcbf : Intel Corp. 82801EB USB
  bca0-bcbf : usb-uhci
bcc0-bcdf : Intel Corp. 82801EB USB
  bcc0-bcdf : usb-uhci
bce0-bcff : Intel Corp. 82801EB USB
  bce0-bcff : usb-uhci
cc00-ccff : ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
d000-efff : PCI Bus #05
  d000-dfff : PCI Bus #07
    dcc0-dcff : PCI device 8086:1076 (Intel Corp.)
      dcc0-dcff : e1000
  e000-efff : PCI Bus #06
    ecc0-ecff : PCI device 8086:1076 (Intel Corp.)
      ecc0-ecff : e1000
fc00-fc0f : Intel Corp. 82801EB Ultra ATA Storage Controller

/proc/iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cb000-000cbfff : Extension ROM
000cc000-000ccfff : Extension ROM
000cd000-000cf1ff : Extension ROM
000cf800-000d1dff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffbffff : System RAM
  00100000-0028dde7 : Kernel code
  0028dde8-00319f23 : Kernel data
3ffc0000-3ffcfbff : ACPI Tables
3ffcfc00-3fffefff : reserved
3ffff000-3ffff3ff : Intel Corp. 82801EB Ultra ATA Storage Controller
e0000000-efffffff : reserved
f0000000-f7ffffff : ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
f8000000-f81fffff : PCI Bus #01
  f8000000-f80fffff : PCI Bus #03
    f80f0000-f80fffff : LSI Logic / Symbios Logic PowerEdge Expandable RAID Controller 4
      f80f0000-f80f007f : MegaRAID: LSI Logic Corporation.
  f8100000-f81fffff : PCI Bus #02
    f81f0000-f81fffff : PCI device 1028:0013 (Dell Computer Corporation)
      f81f0000-f81f007f : MegaRAID: LSI Logic Corporation.
fe0f0000-fe0fffff : ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
fe200000-fe6fffff : PCI Bus #05
  fe300000-fe4fffff : PCI Bus #07
    fe3e0000-fe3fffff : PCI device 8086:1076 (Intel Corp.)
      fe3e0000-fe3fffff : e1000
  fe500000-fe6fffff : PCI Bus #06
    fe5e0000-fe5fffff : PCI device 8086:1076 (Intel Corp.)
      fe5e0000-fe5fffff : e1000
fe700000-feafffff : PCI Bus #01
  fe800000-fe8fffff : PCI Bus #03
  fe900000-feafffff : PCI Bus #02
    fe9e0000-fe9fffff : PCI device 1028:0013 (Dell Computer Corporation)
feb00000-feb003ff : Intel Corp. 82801EB USB2
  feb00000-feb003ff : ehci_hcd
fec00000-fec8ffff : reserved
fed00000-fed003ff : reserved
fee00000-fee0ffff : reserved
ffb00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

0000:00:00.0 Host bridge: Intel Corp. Server Memory Controller Hub (rev 09)
        Subsystem: Dell: Unknown device 016c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #09 [4105]

0000:00:02.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port A0 (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=01, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe700000-feafffff
        Prefetchable memory behind bridge: 00000000f8000000-00000000f8100000
        Secondary status: SERR
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:04.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port B0 (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:05.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port B1 (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=05, subordinate=07, sec-latency=0
        I/O behind bridge: 0000d000-0000efff
        Memory behind bridge: fe200000-fe6fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        Secondary status: SERR
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:06.0 PCI bridge: Intel Corp. Memory Controller Hub PCI Express Port C0 (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=00, secondary=08, subordinate=08, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit- Queue=0/1 Enable-
                Address: fee00000  Data: 0000
        Capabilities: [64] #10 [0041]

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at bce0 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at bcc0 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at bca0 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Dell: Unknown device 016c
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at feb00000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=09, subordinate=09, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe000000-fe1fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fc00 [size=16]
        Region 5: Memory at 3ffff000 (32-bit, non-prefetchable) [disabled] [size=1K]

0000:01:00.0 PCI bridge: Intel Corp. 80332 [Dobson] I/O processor (rev 06) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe900000-feafffff
        Prefetchable memory behind bridge: 00000000f8100000-00000000f8100000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=2
                Status: Bus=1 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=65535, Commitment Limit=65535
                : Downstream: Capacity=65535, Commitment Limit=65535

0000:01:00.2 PCI bridge: Intel Corp. 80332 [Dobson] I/O processor (rev 06) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=01, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe800000-fe8fffff
        Prefetchable memory behind bridge: 00000000f8000000-00000000f8000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=0
                Status: Bus=1 Dev=0 Func=2 64bit- 133MHz- SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=65535, Commitment Limit=65535
                : Downstream: Capacity=65535, Commitment Limit=65535

0000:02:0e.0 RAID bus controller: Dell PowerEdge Expandable RAID controller 4 (rev 06)
        Subsystem: Dell PowerEdge Expandable RAID Controller 4e/Si
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (32000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 46
        Region 0: Memory at f81f0000 (32-bit, prefetchable) [size=64K]
        Region 2: Memory at fe9e0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at fea00000 [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=3
                Status: Bus=2 Dev=14 Func=0 64bit+ 133MHz+ SCD- USC-, DC=bridge, DMMRBC=1, DMOST=3, DMCRS=1, RSCEM-

0000:03:0b.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 01)
        Subsystem: Dell MegaRAID 518 DELL PERC 4/DC RAID Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 37
        Region 0: Memory at f80f0000 (32-bit, prefetchable) [size=64K]
        Expansion ROM at fe800000 [disabled] [size=64K]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:05:00.0 PCI bridge: Intel Corp. PCI Bridge Hub A (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=05, secondary=06, subordinate=06, sec-latency=32
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe500000-fe6fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=0
                Status: Bus=5 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=65535, Commitment Limit=65535
                : Downstream: Capacity=65535, Commitment Limit=65535

0000:05:00.2 PCI bridge: Intel Corp. PCI Bridge Hub B (rev 09) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Bus: primary=05, secondary=07, subordinate=07, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe300000-fe4fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [44] #10 [0071]
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [6c] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d8] PCI-X bridge device.
                Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=0
                Status: Bus=5 Dev=0 Func=2 64bit- 133MHz- SCD- USC-, SCO-, SRD-
                : Upstream: Capacity=65535, Commitment Limit=65535
                : Downstream: Capacity=65535, Commitment Limit=65535

0000:06:07.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller (rev 05)
        Subsystem: Dell: Unknown device 016d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 64
        Region 0: Memory at fe5e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at ecc0 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=0, RSCEM-

0000:07:08.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller (rev 05)
        Subsystem: Dell: Unknown device 016d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 65
        Region 0: Memory at fe3e0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at dcc0 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=0, RSCEM-

0000:09:0d.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: Dell: Unknown device 016c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at cc00 [size=256]
        Region 2: Memory at fe0f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD 0 RAID1   34G Rev: 521S
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 04 Id: 06 Lun: 00
  Vendor: PE/PV    Model: 1x2 SCSI BP      Rev: 1.0
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD 0 RAID0  139G Rev: 351S
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: MegaRAID Model: LD 1 RAID0  139G Rev: 351S
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: MegaRAID Model: LD 2 RAID0   34G Rev: 351S
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 04 Id: 06 Lun: 00
  Vendor: DELL     Model: PV22XS           Rev: E.17
  Type:   Processor                        ANSI SCSI revision: 03
Host: scsi1 Channel: 05 Id: 00 Lun: 00
  Vendor: ADIC     Model: FastStor 2       Rev: G12r
  Type:   Medium Changer                   ANSI SCSI revision: 02
Host: scsi1 Channel: 05 Id: 05 Lun: 00
  Vendor: HP       Model: Ultrium 2-SCSI   Rev: F53A
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi1 Channel: 05 Id: 05 Lun: 01
  Vendor: HP       Model: Ultrium 2-SCSI   Rev: F53A
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi1 Channel: 05 Id: 05 Lun: 02
  Vendor: HP       Model: Ultrium 2-SCSI   Rev: F53A
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi1 Channel: 05 Id: 05 Lun: 03
  Vendor: HP       Model: Ultrium 2-SCSI   Rev: F53A
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi1 Channel: 05 Id: 05 Lun: 04
  Vendor: HP       Model: Ultrium 2-SCSI   Rev: F53A
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi1 Channel: 05 Id: 05 Lun: 05
  Vendor: HP       Model: Ultrium 2-SCSI   Rev: F53A
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi1 Channel: 05 Id: 05 Lun: 06
  Vendor: HP       Model: Ultrium 2-SCSI   Rev: F53A
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: TEAC     Model: DVD-ROM DV-28E-C Rev: D.4E
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Nothing I can think of. If there is any relevant information needed,
please ask. (nothing in the kernel logs during the poor performance)

[X.] Other notes, patches, fixes, workarounds:

We're staying with the 2.4.31 kernel for now.

-- 
-- arthur de jong - arthur@west.nl - west consulting b.v. --
