Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUDOKzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUDOKzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:55:11 -0400
Received: from web11411.mail.yahoo.com ([216.136.131.8]:41824 "HELO
	web11411.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262328AbUDOKy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:54:28 -0400
Message-ID: <20040415105424.19946.qmail@web11411.mail.yahoo.com>
Date: Thu, 15 Apr 2004 11:54:24 +0100 (BST)
From: =?iso-8859-1?q?alan=20pearson?= <alandpearson@yahoo.com>
Subject: sched_getaffinity & sched_setaffinity returning -1 (errstr = Bad address)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've been trying to use the sched_getaffinity &
sched_setaffinity on
kernel 2.6.4 and it is working on some systems and not
others !
It works fine on my aged dual CPU pentium pro box, but
on the box I
really want it to work on, the calls return -1 !

The problem platform is a HP ML530 with 2 x Intel Xeon
processors.
I've tried it with and without hyperthreading enabled
and the result
is the same.
I'm totally at a loss why this is happening and am
wondering if it is
related to the xeon processors ?
This is a really nice feature I desperatley need to
rid my dependance
on SGI Irix.

I'm using the sample code provided by Robert Lowe
(below)

/*
 * Example of sched_set_affinity and
sched_get_affinity
 * Robert Love, 20020227
 */

#include <stdio.h>
#include <stdlib.h>
#include <sched.h>
#include <linux/unistd.h>

/*
 * provide the proper syscall information if our libc
 * is not yet updated.
 */
#ifndef __NR_sched_setaffinity
#define __NR_sched_setaffinity241
#define __NR_sched_getaffinity242
_syscall3 (int, sched_setaffinity, pid_t, pid,
unsigned int, len,
unsigned long *, user_mask_ptr)
_syscall3 (int, sched_getaffinity, pid_t, pid,
unsigned int, len,
unsigned long *, user_mask_ptr)
#endif

int main(int argc, char * argv[])
{
unsigned long new_mask = 2;
unsigned int len = sizeof(new_mask);
unsigned long cur_mask;
pid_t p = 0;
int ret;

ret = sched_getaffinity(p, len, NULL);
perror ("sched_affinity");
printf(" sched_getaffinity = %d, len = %u\n", ret,
len);

ret = sched_getaffinity(p, len, &cur_mask);
printf(" sched_getaffinity = %d, cur_mask = %08lx\n",
ret, cur_mask);

ret = sched_setaffinity(p, len, &new_mask);
printf(" sched_setaffinity = %d, new_mask = %08lx\n",
ret, new_mask);

ret = sched_getaffinity(p, len, &cur_mask);
printf(" sched_getaffinity = %d, cur_mask = %08lx\n",
ret, cur_mask);

return 0;

}

which when run yields on the Xeon box :

sched_affinity: Bad address
 sched_getaffinity = -1, len = 4
 sched_getaffinity = -1, cur_mask = 0804851c
 sched_setaffinity = -1, new_mask = 00000002
 sched_getaffinity = -1, cur_mask = 0804851c


Output of /proc/cpuinfo with hyperthreading off
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 9
cpu MHz         : 2800.178
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe cid
bogomips        : 5521.40

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 9
cpu MHz         : 2800.178
cache size      : 512 KB
physical id     : 3
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2
ss ht tm pbe cid
bogomips        : 5586.94


lspci -vv
00:00.0 Host bridge: ServerWorks CMIC-HE (rev 22)
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CMIC-HE
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: ServerWorks CMIC-HE
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.3 Host bridge: ServerWorks CMIC-HE
        Control: I/O- Mem- BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:02.0 System peripheral: Compaq Computer Corporation
Advanced System
Management Controller
        Subsystem: Compaq Computer Corporation:
Unknown device b0f3
        Control: I/O+ Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 1800 [size=256]
        Region 1: Memory at f7af0000 (32-bit,
non-prefetchable)
[size=256]

00:03.0 VGA compatible controller: ATI Technologies
Inc Rage XL (rev
27) (prog-if 00 [VGA])
        Subsystem: Compaq Computer Corporation:
Unknown device 001e
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 10
        Region 0: Memory at f6000000 (32-bit,
non-prefetchable)
[size=16M]
        Region 1: I/O ports at 2400 [size=256]
        Region 2: Memory at f5ff0000 (32-bit,
non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:04.0 Ethernet controller: Intel Corp. 82557/8/9
[Ethernet Pro 100]
(rev 08)
        Subsystem: Compaq Computer Corporation Compaq
NC3163 Fast
Ethernet NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache
line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f5fe0000 (32-bit,
non-prefetchable)
[size=4K]
        Region 1: I/O ports at 2800 [size=64]
        Region 2: Memory at f5e00000 (32-bit,
non-prefetchable)
[size=1M]
        Expansion ROM at <unassigned> [disabled]
[size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+
AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2
PME-

00:05.0 SCSI storage controller: Adaptec AHA-3960D /
AIC-7899A U160/m
(rev 01)
        Subsystem: Compaq Computer Corporation Compaq
64-Bit/66MHz
Dual Channel Wide Ultra3 SCSI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache
line size 10
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 2c00 [size=256]
        Region 1: Memory at f5df0000 (64-bit,
non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:05.1 SCSI storage controller: Adaptec AHA-3960D /
AIC-7899A U160/m
(rev 01)
        Subsystem: Compaq Computer Corporation Compaq
64-Bit/66MHz
Dual Channel Wide Ultra3 SCSI Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache
line size 10
        Interrupt: pin B routed to IRQ 15
        BIST result: 00
        Region 0: I/O ports at 3000 [size=256]
        Region 1: Memory at f5de0000 (64-bit,
non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev
93)
        Subsystem: ServerWorks CSB5 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller
(rev 93)
(prog-if 82 [Master PriP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 2000 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB
Controller (rev
05) (prog-if 10 [OHCI])
        Subsystem: ServerWorks OSB4/CSB5 OHCI USB
Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f5dd0000 (32-bit,
non-prefetchable)
[size=4K]

00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Control: I/O- Mem- BusMaster+ SpecCycle-
MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:10.0 Host bridge: ServerWorks CIOB30 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
00:10.2 Host bridge: ServerWorks CIOB30 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
00:11.0 Host bridge: ServerWorks CIOB30 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
00:11.2 Host bridge: ServerWorks CIOB30 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
01:01.0 RAID bus controller: Compaq Computer
Corporation Smart Array
5300 Controller (rev 02)
        Subsystem: Compaq Computer Corporation:
Unknown device 4070
        Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 10
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at f7dc0000 (32-bit,
non-prefetchable)
[size=256K]
        Region 1: Memory at f7c00000 (32-bit,
non-prefetchable)
[size=1M]
        Region 4: I/O ports at 4000 [size=256]
        Expansion ROM at <unassigned> [disabled]
[size=1M]
        Capabilities: [f0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2-
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-
        Capabilities: [f8] Vital Product Data

01:02.0 Ethernet controller: Broadcom Corporation
NetXtreme BCM5701
Gigabit Ethernet (rev 15)
        Subsystem: Compaq Computer Corporation Compaq
NC7770 Gigabit
Server Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f7bf0000 (64-bit,
non-prefetchable)
[size=64K]
        Expansion ROM at <unassigned> [disabled]
[size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit-
133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-     
Capabilities: [48]
Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1
PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled
Interrupts: 64bit+
Queue=0/3 Enable-
                Address: 00a951560c239038  Data: 577a

01:1e.0 PCI Hot-plug controller: Compaq Computer
Corporation PCI
Hotplug Controller (rev 14)
        Subsystem: Compaq Computer Corporation:
Unknown device a2fe
        Control: I/O- Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f7be0000 (32-bit,
non-prefetchable)
[size=4K]
        Capabilities: [58] Message Signalled
Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit-
133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-     
Capabilities: [70]
Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-

05:01.0 Ethernet controller: Broadcom Corporation
NetXtreme BCM5701
Gigabit Ethernet (rev 15)
        Subsystem: Compaq Computer Corporation Compaq
NC7770 Gigabit
Server Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f7ff0000 (64-bit,
non-prefetchable)
[size=64K]
        Expansion ROM at <unassigned> [disabled]
[size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit-
133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-     
Capabilities: [48]
Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1
PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled
Interrupts: 64bit+
Queue=0/3 Enable-
                Address: e9003000301aca08  Data: e405

05:02.0 Ethernet controller: Broadcom Corporation
NetXtreme BCM5701
Gigabit Ethernet (rev 15)
        Subsystem: Compaq Computer Corporation Compaq
NC7770 Gigabit
Server Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f7fe0000 (64-bit,
non-prefetchable)
[size=64K]
        Expansion ROM at <unassigned> [disabled]
[size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit-
133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-     
Capabilities: [48]
Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1
PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled
Interrupts: 64bit+
Queue=0/3 Enable-
                Address: c8858cf00ce383f8  Data: 080a

05:1e.0 PCI Hot-plug controller: Compaq Computer
Corporation PCI
Hotplug Controller (rev 14)
        Subsystem: Compaq Computer Corporation:
Unknown device a2fe
        Control: I/O- Mem+ BusMaster- SpecCycle-
MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f7ef0000 (64-bit,
prefetchable) [size=4K]
        Capabilities: [58] Message Signalled
Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit-
133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-     
Capabilities: [70]
Power Management version 2
                Flags: PMEClk- DSI- D1- D2-
AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0
PME-







Any ideas appreciated !
Please cc on replies !

Thanks in advance,
AlanP




	
	
		
____________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
