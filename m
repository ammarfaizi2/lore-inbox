Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422785AbWJFXg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422785AbWJFXg1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423008AbWJFXg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:36:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:7495 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422785AbWJFXgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:36:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=DEQqC50LF0SuFe7BUxQCBsBF0M4Wu/CzVRvnkunuq2/XbnsQHX6tro9tUiAUuZy1ZBUD6Y0pdFqrbyYlv+p99b4cMZjSkNORl7wApJ5ZBQ3erykptdEySTKw/iutY5iA48bBhB5BuTgS167Icp1fef9HDihUFM5TWY60qN5TxoY=
Message-ID: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
Date: Sat, 7 Oct 2006 01:36:24 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Simple script that locks up my box with recent kernels
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14257_10196628.1160177784338"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14257_10196628.1160177784338
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've been using the this very simple script for a while to do test
builds of the kernel :


#!/bin/bash

for i in $(seq 1 100); do
        nice make distclean
        while true; do
                nice make randconfig
                grep -q "CONFIG_EXPERIMENTAL=y" .config
                if [ $? -eq 1 ]; then
                        break
                fi
        done
        cp .config config.${i}
        nice make -j3 > build.log.${i} 2>&1
done


Which has worked great in the past, but with recent kernels it has
been a sure way to cause a complete lockup within 1 hour :-(


The last kernel where I know for sure that it ran without problems is
2.6.17.13 .
The first kernel where I know for sure it caused lockups is
2.6.18-git15 .   I've also tested 2.6.18-git16, 2.6.18-git21 and
2.6.19-rc1-git2 and those 3 also lock up solid.

The lockup usually happens within 30 minutes, but sometimes the box
survives longer, but I've not seen it survive for more than 60 minutes
at most.
It doesn't seem to matter if I leave it alone just building kernels or
if I use it for other purposes while building in the background - if
anything, it seems to survive longer when I do other work while it
builds.

When the lockup happens the box just freezes and doesn't respond to
anything at all. Sometimes I can reboot with alt+sysrq+b but sometimes
not even that works.

Here's exactely what I do, so you can try to reproduce :

1) boot my distro (Slackware 11.0) into runlevel 4 (multi-user with
X), using kernel 2.6.19-rc1-git2 (or one of the other "known-bad"
kernels).

2) Log in via kdm, and once I'm at my KDE desktop I start 'konsole'.

3) cd into a dir holding a fresh copy of the 2.6.19-rc1-git2 source
and run the above script from a file named build-random.sh that I have
placed in the root of the source dir and made executable.

4) wait for 0-60 minutes.


After a reboot I find nothing in the logs, so I can't give you many
hints on what goes wrong, unfortunately.

Attached you can find the config I'm using for my current
2.6.19-rc1-git2 kernel that very consistently exhibits the problem,
and below are some details about my hardware and software environment.

I've run memtest86+ for ~12hrs without problems, just to rule out bad
RAM, and I've seen nothing at all in my logs to indicate that this
should be a hardware problem. Also, the fact that if I boot into
2.6.17.13 I can run the above script for hours and hours without
problems indiates to me that this is not a hardware issue.


# uname -a
Linux dragon 2.6.19-rc1-git2 #1 SMP PREEMPT Sat Oct 7 00:30:45 CEST
2006 i686 athlon-4 i386 GNU/Linux

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.149
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4402.75

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.149
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4399.53

# cat /proc/meminfo
MemTotal:      2071360 kB
MemFree:       1683228 kB
Buffers:         29092 kB
Cached:         193184 kB
SwapCached:          0 kB
Active:         165528 kB
Inactive:       141904 kB
HighTotal:     1179328 kB
HighFree:       895532 kB
LowTotal:       892032 kB
LowFree:        787696 kB
SwapTotal:      763076 kB
SwapFree:       763076 kB
Dirty:             184 kB
Writeback:           0 kB
AnonPages:       85096 kB
Mapped:          48360 kB
Slab:            66968 kB
SReclaimable:    33216 kB
SUnreclaim:      33752 kB
PageTables:       1256 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   1798756 kB
Committed_AS:   285864 kB
VmallocTotal:   114680 kB
VmallocUsed:      6344 kB
VmallocChunk:   107532 kB

# lspci -vvx
00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express
and HyperTransport]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=0 UnitCnt=3 MastHost- DefDir- DUL-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC-
TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut-
LWI=16bit DwFcInEn- LWO=16bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail- Init+ EOC-
TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=16bit DwFcIn- MLWO=16bit DwFcOut-
LWI=8bit DwFcInEn- LWO=16bit DwFcOutEn-
                Revision ID: 1.05
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+
500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 800MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz+ 300MHz- 400MHz+
500MHz- 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz+ 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE-
CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [5c] HyperTransport: MSI Mapping
        Capabilities: [68] HyperTransport: UnitID Clumping
        Capabilities: [74] HyperTransport: Interrupt Discovery and Configuration
        Capabilities: [7c] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
00: b9 10 95 16 07 00 10 00 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00
[Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: ff200000-ff2fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
        Capabilities: [58] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
                Link: Latency L0s <2us, L1 <32us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed unknown, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
                Slot: Number 0, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd Off, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [7c] HyperTransport: MSI Mapping
        Capabilities: [88] HyperTransport: Revision ID: 1.05
00: b9 10 4b 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 20 ff 20 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 03 00

00:02.0 PCI bridge: ALi Corporation PCI Express Root Port (prog-if 00
[Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: ff300000-ff3fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+
Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
        Capabilities: [58] Express Root Port (Slot+) IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                Link: Supported Speed 2.5Gb/s, Width x2, ASPM L0s L1, Port 0
                Link: Latency L0s <2us, L1 <32us
                Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                Link: Speed unknown, Width x1
                Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
                Slot: Number 0, PowerLimit 0.000000
                Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                Slot: AttnInd Off, PwrInd Off, Power-
                Root: Correctable- Non-Fatal- Fatal- PME-
        Capabilities: [7c] HyperTransport: MSI Mapping
        Capabilities: [88] HyperTransport: Revision ID: 1.05
00: b9 10 4c 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 00
20: 30 ff 30 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 03 00

00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single Chip]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at dc000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [40] HyperTransport: Slave or Primary Interface
                Command: BaseUnitID=4 UnitCnt=1 MastHost- DefDir- DUL-
                Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC-
TXO- <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 0: MLWI=16bit DwFcIn- MLWO=8bit DwFcOut-
LWI=16bit DwFcInEn- LWO=8bit DwFcOutEn-
                Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+
TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
                Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut-
LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
                Revision ID: 1.04
                Link Frequency 0: 800MHz
                Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 0: 200MHz+ 300MHz- 400MHz+
500MHz- 600MHz+ 800MHz+ 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Feature Capability: IsocFC- LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
                Link Frequency 1: 200MHz
                Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
                Link Frequency Capability 1: 200MHz- 300MHz- 400MHz-
500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
                Error Handling: PFlE- OFlE- PFE- OFE- EOCFE- RFE-
CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
                Prefetchable memory behind bridge Upper: 00-00
                Bus Number: 00
        Capabilities: [60] HyperTransport: Interrupt Discovery and Configuration
        Capabilities: [80] AGP version 3.0
                Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
00: b9 10 89 16 06 01 10 00 00 00 00 06 00 00 00 00
10: 08 00 00 dc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:05.0 PCI bridge: ALi Corporation AGP8X Controller (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        Memory behind bridge: ff400000-ff4fffff
        Prefetchable memory behind bridge: c7f00000-d7efffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: b9 10 46 52 07 01 20 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 40 f0 00 20 22
20: 40 ff 40 ff f0 c7 e0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0b 00

00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if
01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff500000-ff5fffff
        Prefetchable memory behind bridge: 88000000-880fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: b9 10 49 52 07 01 00 00 00 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 20 d0 d0 00 22
20: 50 ff 50 ff 00 88 00 88 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00

00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
        Subsystem: ASRock Incorporation Unknown device 1563
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 6000ns max)
00: b9 10 63 15 0f 00 00 02 70 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18

00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Subsystem: ASRock Incorporation Unknown device 7101
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 Ethernet controller: ALi Corporation ULi 1689,1573 integrated
ethernet. (rev 40)
        Subsystem: ASRock Incorporation Unknown device 5263
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at ff6ffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 63 52 07 01 10 02 40 00 00 02 08 20 00 00
10: 01 e8 00 00 00 fc 6f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 14 28

00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a
[Master SecP PriP])
        Subsystem: ASRock Incorporation Unknown device 5229
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ff00 [size=16]
00: b9 10 29 52 05 00 a0 02 c7 8a 01 01 00 20 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 49 18 29 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ff6fe000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 e0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50

00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 3
        Region 0: Memory at ff6fd000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 d0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 02 00 50

00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), Cache Line Size: 64 bytes
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at ff6fc000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 c0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 50

00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
(prog-if 20 [EHCI])
        Subsystem: ASRock Incorporation Unknown device 5239
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 64 bytes
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at ff6ff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port
00: b9 10 39 52 16 01 b0 02 01 20 03 0c 10 20 80 00
10: 00 f8 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 39 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 10 20

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] HyperTransport: Host or Secondary Interface
                !!! Possibly incomplete decoding
                Command: WarmRst+ DblEnd-
                Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
                Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
                Revision ID: 1.02
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia
AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ff4fe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at ff4c0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit-
FW- Rate=<none>
00: 2b 10 27 05 07 00 b0 02 03 00 00 03 10 20 00 00
10: 08 00 00 c8 00 e0 4f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 40 08
30: 00 00 4c ff dc 00 00 00 00 00 00 00 05 01 10 20

04:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs SBLive! 5.1 eMicro 28028
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at d880 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 00 05 01 90 02 0a 00 01 04 00 20 80 00
10: 81 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 67 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 14

04:05.1 Input device controller: Creative Labs SB Live! Game Port (rev 0a)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 70 05 01 90 02 0a 00 80 09 00 20 80 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

04:06.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at d400 [disabled] [size=256]
        Region 1: Memory at ff5ff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 80 00 16 01 b0 02 02 00 00 01 10 20 00 80
10: 01 d4 00 00 04 f0 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 a0 62
30: 00 00 5c ff dc 00 00 00 00 00 00 00 03 01 28 19

04:07.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 42)
        Subsystem: D-Link System Inc DFE-530TX rev B
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at ff5fec00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 88020000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 17 01 10 02 42 00 00 02 10 20 00 00
10: 01 d0 00 00 00 ec 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 01 14
30: 00 00 ff ff 40 00 00 00 00 00 00 00 0b 01 03 08

root@dragon:/home/juhl/download/kernel/linux-2.6.19-rc1-git2# scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.19-rc1-git2 #1 SMP PREEMPT Sat Oct 7 00:30:45 CEST
2006 i686 athlon-4 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
quota-tools            3.13.
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   097
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq
snd_pcm_oss snd_mixer_oss agpgart snd_emu10k1 snd_rawmidi
snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer
snd_page_alloc snd_util_mem snd_hwdep evdev snd


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_14257_10196628.1160177784338
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esz7sbrs
Content-Disposition: attachment; filename="config.gz"

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
------=_Part_14257_10196628.1160177784338--
