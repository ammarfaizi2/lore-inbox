Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263399AbUDTRyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbUDTRyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 13:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbUDTRyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 13:54:31 -0400
Received: from fay-gateway.aitcom.net ([208.234.1.225]:60826 "EHLO
	group-cio.aitcorp.ait") by vger.kernel.org with ESMTP
	id S263656AbUDTRx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 13:53:26 -0400
Message-ID: <40856395.1020703@nova.org>
Date: Tue, 20 Apr 2004 13:53:25 -0400
From: Ken <ken@nova.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6][NETFILTER][e1000 w/NAPI] repeatable deadlock in uP & SMP
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

	[This is a re-submit -- I didn't see it in the archives and there was 
no response.  I apologize in advance to anyone who receives this as a 
duplicate.]

	Summary:  I have an Intel SR2300 based on an Intel SE7501-WV2 MB with 
two Xeon 2.4G (HT) CPUs and E7500 (Plumas) chip set.  There is an
Adaptec 2000S ZCR card and two Intel 82544EI Gigabit Ethernet PCI cards
on the bus.  The system is used as a network monitoring system using
iptables/netfilter to feed Snort and NTOP with libpcap.  The hardware
is rock solid using a 2.4.[18-26] kernel.  However, the same hardware
using kernel 2.6.[1-5] exhibits a repeatable deadlock or freeze after
varying periods of operation.

	I have "googled", lurked, and searched list archives for linux-kernel 
and netfilter.  I have searched netfilter's bug reports.  I have 
attempted UP and SMP kernel configurations in an attempt to eliminate or 
narrow the problem.  I have attempted to follow
Documentation/oops-tracing.txt.

	Problem:  In kernel 2.6.[1-5] (I could not run 2.6.0) using a UP or SMP 
build and running iptable/netfilter modules, the system
deadlocks/freezes after operating for 3 minutes to 5 hours.  The
shortest time to lock was with 2.6.4 UP -- the longest with 2.6.3 SMP.
Prior to each occurrence the system was seeing 12K-20K interrupts per
second and 8K-20K context switches per second according to 'vmstat 1'
output. Practically all of this load is related to a single Intel fiber
NIC sniffing a SPAN port on a Cisco switch.  If I ONLY run NTOP and
sniff the NIC via libpcap, the system performs normally.  In all cases
the NIC is driven by the e1000 driver compiled with NAPI support.  I use
'ethtool' to increase the RX ring parameters to 4096 (max) -- this is to
prevent drops, which occur otherwise.

	The only diagnostic I've been able to get was using the NMI oopser to 
produce a dump on console.  When the deadlock occurs, there is no 
response via network or keyboard.  However, with a UP kernel, on some
occasions I can press <Alt> as in <ALT-SYSRQ> and receive another trace.
After that, it's hardware reset.  The SMP build rarely generates an
oops to console -- it's just locked.

	The dumps to console vary at the top of the screen and usually contain 
garbage down to Stack.  On one occasion using an UP build, the dump did 
indicate that EIP was at scheduler_tick.  Regardless of the garbage at 
the top of the screen or the sub-version of kernel, the call trace for 
UP is consistent and is hand copied here (from 2.6.4 UP configuration):


     Call trace:
     []	__kfree_skb + 0xa3/0x128
     []	update_process_times + 0x46/0x52
     []	do_timer + 0x34/0xe4
     []	timer_interrupt + 0x41/0xf3
     []	handle_IRQ_event + 0x3a/0x64
     []	do_IRQ + 0x72/0xe5
     []	common_interrupt + 0x18/0x20
     []	skb_copy_bits + 0x49/0x261
     []	printk + 0x113/0x146
     []	dump_packet + 0x39f/0x8c4 [ipt_LOG]
     []	recalc_task_prio + 0x92/0x19d

     Code: 0f ab 50 08 83 c4 18 5b 5e 5f 5d c3 8b 4e 18 83 f9 63 89 4d
        <0> Kernel panic:  Fatal exception in interrupt
     In interrupt handler - not syncing

Using the information above, the code (at EIP when panic occurred, I
believe) is in the 'scheduler_tick' function in kernel/sched.c.  Using
objdump on kernel/sched.o, I did find that code sequence associated with
    scheduler_tick.

	Using SMP builds the troubleshooting is much harder.  The NMI oopser
rarely succeeds in getting anything to console and <ALT-SYSRQ> doesn't
work.  On the occasion when a trace was present, I have hand copied it
here (from 2.6.5 SMP configuration):

     Process swapper (pid: 0, threadinfo=f7f9e000 task=c247d190
     Stack: [ elided ]

     Call trace:
     []	drain_array+0x7b/0xb6
     []	cache_reap+0x8b/0x16e
     []	reap_timer_fnc+0x22/0x46
     []	reap_timer_fnc+0x0/0x46
     []	run_timer_softirq+0xc7/0x180
     []	do_softirq+0xc3/0xc5
     []	smp_apic_timer_interrupt+0xd2/0x13a
     []	default_idle+0x0/0x2d
     []	apic_timer_interrupt+0x1a/0x20
     []	default_idle+0x0/0x2d
     []	default_idle+0x2a/0x2d
     []	cpu_idle+0x37/0x40
     []	printk+0x173/0x1a9

     Code: 89 50 04 89 02 c7 43 04 00 02 20 00 2b 4b 0c c7 03 00 01 10
       <0>Kernel panic:   Fatal exception in interrupt
     In interrupt handler - not syncing


I found the byte code at EIP in mm/slab.o using objdump.  This is what I
see:

slab.o:     file format elf32-i386

Disassembly of section .text:

00000000 <cache_estimate>:
          0:       55                      push   %ebp
          1:       57                      push   %edi
          2:       31 ff                   xor    %edi,%edi
<snip>

000010ce <free_block>:
       10ce:       55                      push   %ebp
       10cf:       31 c0                   xor    %eax,%eax
       10d1:       57                      push   %edi
       10d2:       56                      push   %esi
       10d3:       53                      push   %ebx
<snip>
       1123:       89 50 04                mov    %edx,0x4(%eax)  [<-code
start]
       1126:       89 02                   mov    %eax,(%edx)
       1128:       c7 43 04 00 02 20 00    movl   $0x200200,0x4(%ebx)
       112f:       2b 4b 0c                sub    0xc(%ebx),%ecx
       1132:       c7 03 00 01 10 00       movl   $0x100100,(%ebx)
       1138:       31 d2                   xor    %edx,%edx
       113a:       89 c8                   mov    %ecx,%eax

Unfortunately, that's about the limit of my ability to analyze it.  I
surmise that the netfilter code is the trigger, but not necessarily the
cause -- could be NAPI code, e1000 driver corner case, memory
management, or something else.  The problem is repeatable with both UP
and SMP kernels, but only so long as the iptables/netfilter modules are
loaded and in use -- I can't make the panic/deadlock occur any other
way.  I have let it run for over 72 hours without a problem using only
NTOP to sniff traffic via the e1000/NAPI driver.

The rest of the normally requested information -- ver_linux, lspci,
config, /proc, and boot dmesg are below:

Linux scythe 2.6.5 #3 SMP Thu Apr 15 13:04:50 EDT 2004 i686 unknown

Gnu C                  3.2.2
Gnu make               3.80
binutils               2.13.90.0.18
util-linux             2.11z
mount                  2.11z
module-init-tools      3.0
e2fsprogs              1.32
jfsutils               1.1.1
reiserfsprogs          3.6.4
xfsprogs               2.3.5
pcmcia-cs              3.2.4
quota-tools            3.08.
PPP                    2.4.1
nfs-utils              1.0.4
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.8
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         ipt_length ipt_mac ipt_limit ip_queue ipt_LOG 
adm1021 i2c_sensor i2c_i801 i2c_core ehci_hcd uhci_hcd

00:00.0 Host bridge: Intel Corp. e7500 [Plumas] DRAM Controller (rev 03)
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error 
Reporting (rev 03)
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:03.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge 
(F0) (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fe600000-febfffff
	Prefetchable memory behind bridge: f6500000-fc4fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:03.1 Class ff00: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge 
(F1) (rev 03)
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 3020 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) 
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 3000 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: fc500000-fe5fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02) (prog-if 8a 
[Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 03a0 [size=16]
	Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0580 [size=32]

01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1000 [size=256]
	Region 2: Memory at fe5f0000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe5c0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03) (prog-if 20 
[IO(X)-APIC])
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at febe0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03) 
(prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=48
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fe800000-feafffff
	Prefetchable memory behind bridge: 00000000f6500000-00000000fc400000
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] PCI-X bridge device.
		Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, SCO-, SRD-
		: Upstream: Capacity=0, Commitment Limit=0
		: Downstream: Capacity=0, Commitment Limit=0

02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03) (prog-if 20 
[IO(X)-APIC])
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at febf0000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03) 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fe600000-fe7fffff
	Prefetchable memory behind bridge: fffffffffff00000-0000000000000000
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] PCI-X bridge device.
		Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=1
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, SCO-, SRD-
		: Upstream: Capacity=0, Commitment Limit=0
		: Downstream: Capacity=0, Commitment Limit=0

03:07.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet 
Controller (Copper) (rev 01)
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 30
	Region 0: Memory at fe700000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 2080 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk+ DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] 	Capabilities: [f0] Message Signalled Interrupts: 
64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:07.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet 
Controller (Copper) (rev 01)
	Subsystem: Intel Corp.: Unknown device 3415
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin B routed to IRQ 31
	Region 0: Memory at fe720000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 2040 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk+ DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] 	Capabilities: [f0] Message Signalled Interrupts: 
64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:08.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet 
Controller (Fiber) (rev 02)
	Subsystem: Intel Corp. PRO/1000 XF Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at fe780000 (64-bit, non-prefetchable) [size=128K]
	Region 2: Memory at fe760000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 2020 [size=32]
	Expansion ROM at fe740000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled 
Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

03:09.0 Ethernet controller: Intel Corp. 82544EI Gigabit Ethernet 
Controller (Fiber) (rev 02)
	Subsystem: Intel Corp. PRO/1000 XF Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), cache line size 10
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at fe7e0000 (64-bit, non-prefetchable) [size=128K]
	Region 2: Memory at fe7c0000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at 2000 [size=32]
	Expansion ROM at fe7a0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, 
DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [f0] Message Signalled 
Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

04:08.0 RAID bus controller: Distributed Processing Technology SmartRAID 
V Controller (rev 01)
	Subsystem: Distributed Processing Technology: Unknown device c033
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 (250ns min, 250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 48
	BIST result: 00
	Region 0: Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
	Region 1: Memory at fb000000 (32-bit, prefetchable) [size=16M]
	Region 2: Memory at f8000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at 00095000 [disabled] [size=32K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk+ DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
02f8-02ff : serial
0376-0376 : ide1
03a0-03af : 0000:00:1f.1
   03a0-03a7 : ide0
   03a8-03af : ide1
03c0-03df : vga+
03f8-03ff : serial
0580-059f : 0000:00:1f.3
   0580-0587 : i801-smbus
0cf8-0cff : PCI conf1
1000-10ff : 0000:01:0c.0
2000-2fff : PCI Bus #02
   2000-2fff : PCI Bus #03
     2000-201f : 0000:03:09.0
       2000-201f : e1000
     2020-203f : 0000:03:08.0
       2020-203f : e1000
     2040-207f : 0000:03:07.1
       2040-207f : e1000
     2080-20bf : 0000:03:07.0
       2080-20bf : e1000
3000-301f : 0000:00:1d.1
   3000-301f : uhci_hcd
3020-303f : 0000:00:1d.0
   3020-303f : uhci_hcd

cat /proc/iomem
00000000-0009a7ff : System RAM
0009a800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000ce000-000cf7ff : Extension ROM
000cf800-000d0fff : Extension ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
   00100000-002e8cd0 : Kernel code
   002e8cd1-003b637f : Kernel data
7fff0000-7fffefff : ACPI Tables
7ffff000-7fffffff : ACPI Non-volatile Storage
80000000-800003ff : 0000:00:1f.1
f6500000-fc4fffff : PCI Bus #02
   f6500000-fc4fffff : PCI Bus #04
     f8000000-f9ffffff : 0000:04:08.0
     fb000000-fbffffff : 0000:04:08.0
fd000000-fdffffff : 0000:01:0c.0
fe5f0000-fe5f0fff : 0000:01:0c.0
fe600000-febfffff : PCI Bus #02
   fe600000-fe7fffff : PCI Bus #03
     fe700000-fe71ffff : 0000:03:07.0
       fe700000-fe71ffff : e1000
     fe720000-fe73ffff : 0000:03:07.1
       fe720000-fe73ffff : e1000
     fe760000-fe77ffff : 0000:03:08.0
       fe760000-fe77ffff : e1000
     fe780000-fe79ffff : 0000:03:08.0
       fe780000-fe79ffff : e1000
     fe7c0000-fe7dffff : 0000:03:09.0
       fe7c0000-fe7dffff : e1000
     fe7e0000-fe7fffff : 0000:03:09.0
       fe7e0000-fe7fffff : e1000
   fe800000-feafffff : PCI Bus #04
     fea00000-feafffff : 0000:04:08.0
   febe0000-febe0fff : 0000:02:1c.0
   febf0000-febf0fff : 0000:02:1e.0
fec00000-fecfffff : reserved
fee00000-fee00fff : reserved
fff00000-ffffffff : reserved

Config for 2.6.4-up:
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_STANDALONE=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_ACPI_BOOT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=7777
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_DPT_I2O=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_BRIDGE=y
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_BRIDGE_NF_EBTABLES=y
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_IPV6_SCTP__=y
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_E1000=y
CONFIG_E1000_NAPI=y
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DRM=y
CONFIG_DRM_R128=m
CONFIG_HANGCHECK_TIMER=m
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_I801=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_REISERFS_FS=m
CONFIG_JFS_FS=m
CONFIG_XFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_CRAMFS=m
CONFIG_VXFS_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=y
CONFIG_SMB_FS=m
CONFIG_CIFS=m
CONFIG_NCP_FS=m
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_UTF8=m
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

Config for 2.6.5-smp:
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_STANDALONE=y
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=8
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ACPI_BOOT=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=7777
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_DPT_I2O=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_BRIDGE=y
CONFIG_NETFILTER=y
CONFIG_BRIDGE_NETFILTER=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_VLAN_8021Q=m
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m
CONFIG_E1000=y
CONFIG_E1000_NAPI=y
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_NETCONSOLE=m
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DRM=y
CONFIG_DRM_R128=m
CONFIG_HANGCHECK_TIMER=m
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_I801=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_REISERFS_FS=m
CONFIG_JFS_FS=m
CONFIG_XFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_QUOTA=y
CONFIG_QFMT_V1=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_CRAMFS=m
CONFIG_VXFS_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=y
CONFIG_SMB_FS=m
CONFIG_CIFS=m
CONFIG_NCP_FS=m
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_UTF8=m
CONFIG_DEBUG_KERNEL=y
CONFIG_EARLY_PRINTK=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y



Assistance requested -- relevant guidance and patches accepted.  Please
CC me if you require my response -- I'm not subscribed, but follow the
list archive.


Thanks,
Ken Beaty






