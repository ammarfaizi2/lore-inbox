Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUDAKqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 05:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUDAKo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 05:44:26 -0500
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:54989 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S262843AbUDAKnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 05:43:22 -0500
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: Strange 'zombie' problem both in 2.4 and 2.6
Date: Thu, 1 Apr 2004 14:42:17 +0400
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JI/aAOXjfZBAikM"
Message-Id: <200404011442.18078@zigzag.lvk.cs.msu.su>
X-Scanner: exiscan *1B8zeM-0003Qx-00*LuCJdPwvIZs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_JI/aAOXjfZBAikM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello.

Some time ago I was faced with a strange problem in 2.4 kernel.
I could reproduce in only on one system - a production 2-CPU server that is 
used as LTSP server here and also runs tons of services and MUST be always 
up.

The problem is the following.
Server runs normally (and uptime may be already several weeks, but may be 
only several hours).
Suddenly something happens.
And process table becomes full of zombies.
Looks like any thread created by any program becomes a zombie when 
finished. Same programs (actually, same running processes) join()ed 
finished threads correctly before Something Happened. So it looks very 
much that Something happens inside the kernel.
Affected programs include mozilla, clamav, mysqld, licq and anything else 
that creates short-living threads, or at least threads that live shorter 
than program itself.

It looks like at some moment kernel looses the abitily to inform process 
that their threads are over. AKAIK, this is done by SIGCHLD? Anyway, 
manual sending SIGCHLD to the parent of zombies does not help.

After the problem happens, server becomes unusable (because of process 
table overflow) in several minutes. One time Something Else happened, and 
all those zombies disappeared. In all other cases a reboot was required.

If the process that created those "zombie thread" is terminated (i.e. 
sevice stopped), all his zombies disappear. However, after service is 
restarted, zombies become to appear again.

Athough I tried, I could not find any correlation between making system to 
this "zombie-keeping" state and anything else happenning with the system. 
Looks like that running java apps (with blackdown jdk) makes this happen 
more often, bot still no direct correlation.

The problem happened with official 2.4.23, 2.4.24 and 2.4.25 kernels, 
compiled from kernel.org sources.

Yestedray I was tired with this zombie problem (it arised twice during this 
week), and decided to upgrade server to kernel 2.6.
I installed 2.6.4 kernel from the Debain kernel-image-2.6.4-1-k7-smp 
package.

Unfortunately, this did not eliminate the problem: it happened today again.
The difference is that when running in 2.6, most binaries use NPTL libs 
from /lib/i686/cmov/, and seem not to be affected by the problem (i.e. no 
zombies from them). However, users need to run some statically-linked 
binaries (without source available) that have non-NPTL libs statically 
linked and so still use linuxthreads; those are affected (i.e. do create 
zombies). So problem is not rendering server unusable (so it no longer 
that critical), but it still exists in the 2.6 kernel.

I can't reproduce the problem on any other host. And the affected system is 
a production server that is somewhat difficult to use for debugging :(
It is a dual-K7 server with Tyan Tiger MPX S2466 motherboard and 2 Gb of 
ram. Output of 'lspci -vv' and 'cat /proc/cpuinfo' is attached. I may 
provide any other technical information.

I'm a seasoned unix developer and sysadmin, and have some kernel hacking 
experience. However, I don't work with the kernel currently, so I am not 
"in context of" kernel internals.
So I'm looking either for a fix :), or for some advice on what to do with 
this (i.e. where to look in the kernel code and what to look for).

Nikita Youshchenko,
sysadmin at lvk.cs.msu.su

--Boundary-00=_JI/aAOXjfZBAikM
Content-Type: text/plain;
  charset="us-ascii";
  name="info"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="info"

> uname -a
Linux zigzag 2.6.4-1-k7-smp #1 SMP Sun Mar 14 00:19:02 EST 2004 i686 GNU/Linux

> cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 10
model name	: AMD Athlon(tm) MP 2800+
stepping	: 0
cpu MHz		: 2133.583
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 4210.68

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 10
model name	: AMD Athlon(tm) Processor
stepping	: 0
cpu MHz		: 2133.583
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 4259.84

> lspci -vv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 20)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f0600000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1020 [disabled] [size=4]
	Capabilities: <available only to root>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f0100000-f01fffff
	Prefetchable memory behind bridge: f8000000-fbffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:08.0 RAID bus controller: Promise Technology, Inc. PDC20271 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at 1038 [size=8]
	Region 1: I/O ports at 1030 [size=4]
	Region 2: I/O ports at 1028 [size=8]
	Region 3: I/O ports at 1024 [size=4]
	Region 4: I/O ports at 1010 [size=16]
	Region 5: Memory at f0000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f0200000-f03fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF/SG AGP (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Magnum/Xpert128/X99/Xpert2000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at f0100000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f0300000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0301000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3480 [size=64]
	Region 2: Memory at f0200000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: <available only to root>

02:06.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. TRM-S1040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 3000 [size=256]
	Region 1: Memory at f0302000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

02:07.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 34c0 [size=64]
	Capabilities: <available only to root>

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: Tyan Computer: Unknown device 2466
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 3400 [size=128]
	Region 1: Memory at f0303000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: <available only to root>


--Boundary-00=_JI/aAOXjfZBAikM--

