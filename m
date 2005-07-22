Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVGVQjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVGVQjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 12:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVGVQjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 12:39:05 -0400
Received: from gear.torque.net ([204.138.244.1]:39563 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id S261321AbVGVQjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 12:39:02 -0400
Message-ID: <42E120BF.6090504@torque.net>
Date: Fri, 22 Jul 2005 12:37:19 -0400
From: Michael Harris <mharris@torque.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Failure to deliver SIGCHLD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Failure to deliver SIGCHLD

[2.] The problem occurs in a forking server similar in function to
inetd.  The server employs a very simple SIGCHLD handler that loops on
wait(2), until all zombie processes have been collected.  For no
immediately apparent reason, the parent process behaves as if it no
longer receives SIGCHLD.  Manually sending the signal has no effect.
Within minutes the server is incapacitated.  If the forking server is
terminated, init properly disposes of the zombie processes.

When i attach strace to the parent server, it immediately enters the
signal handler, and calls wait() for each zombie, and normal function
continues, even after strace is terminated.

We have only seen this problem manifest itsself on x86_64 and em64t 
multi-processor machines, which is not to say that i feel it may be 
limited to those architectures.

[3.] Keywords:   Signal handler, zombie, SIGCHLD, 64 BIT SMP

[4.] Kernel version (from /proc/version): Linux version 2.6.5-7.97-smp

(geeko@buildhost) (gcc version 3.3.3 (SuSE Linux)) #1 SMP Fri Jul 2 
14:21:59 UTC 2004
[6.] This is the code for the signal handler in the server application. 
I dare say it contains no bugs (famous last words)

    void reaper_man (int signum)
    {
            int stat;
            while ( waitpid(-1, &stat, WNOHANG) > 0 );
    }

    signal (SIGCHLD, reaper_man);  /* from main() */


[7.1.] Software:
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.34
jfsutils               1.1.6
xfsprogs               2.6.3
PPP                    2.4.2
isdn4k-utils           3.4
nfs-utils              1.0.6
Linux C Library        x  1 root root 1398085 Jun 30  2004
/lib64/tls/libc.so.6
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 248
stepping        : 8
cpu MHz         : 2193.511
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 4325.37
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 248
stepping        : 8
cpu MHz         : 2193.511
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips        : 4374.52
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts ttp


[7.3.] Module information (from /proc/modules):
hid                    45952  0
joydev                 12416  0
sg                     43576  0
st                     43428  0
sr_mod                 19492  0
usbserial              35704  0
parport_pc             41152  0
lp                     13352  0
parport                47372  2 parport_pc,lp
hw_random               7336  0
ohci_hcd               22532  0
evdev                  11776  0
thermal                15500  0
processor              20128  1 thermal
fan                     5640  0
button                  8480  0
battery                10760  0
ac                      6664  0
ipv6                  288760  19
tg3                    75780  0
usbcore               124656  5 hid,usbserial,ohci_hcd
subfs                  10496  1
dm_mod                 57920  0
reiserfs              256752  4
mptscsih               47064  0
mptbase                49568  1 mptscsih
sd_mod                 22400  0
scsi_mod              131584  5 sg,st,sr_mod,mptscsih,sd_

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
ioports:
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
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-101f : 0000:00:07.2
1020-102f : 0000:00:07.1
  1020-1027 : ide0
  1028-102f : ide1
2000-2fff : PCI Bus #01
  2000-20ff : 0000:01:05.0
3000-3fff : PCI Bus #02
  3000-30ff : 0000:02:02.0
8008-800b : ACPI timer
8010-8015 : ACPI CPU throttle

iomem:
00000000-0009b7ff : System RAM
0009b800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000c9800-000cafff : Extension ROM
000cb000-000cb7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-fbf6ffff : System RAM
  00100000-003423ab : Kernel code
  003423ac-0041c4ec : Kernel data
fbf70000-fbf7afff : ACPI Tables
fbf7b000-fbf7ffff : ACPI Non-volatile Storage
fbf80000-fbffffff : reserved
fc000000-fc000fff : 0000:00:0a.1
fc001000-fc001fff : 0000:00:0b.1
fc100000-fdffffff : PCI Bus #01
  fc100000-fc100fff : 0000:01:00.0
    fc100000-fc100fff : ohci_hcd
  fc101000-fc101fff : 0000:01:00.1
    fc101000-fc101fff : ohci_hcd
  fc102000-fc102fff : 0000:01:05.0
  fd000000-fdffffff : 0000:01:05.0
    fd000000-fd7effff : vesafb
fe000000-fe0fffff : PCI Bus #02
  fe000000-fe00ffff : 0000:02:01.0
    fe000000-fe00ffff : tg3
  fe010000-fe01ffff : 0000:02:01.0
    fe010000-fe01ffff : tg3
  fe020000-fe02ffff : 0000:02:01.1
    fe020000-fe02ffff : tg3
  fe030000-fe03ffff : 0000:02:01.1
    fe030000-fe03ffff : tg3
  fe040000-fe04ffff : 0000:02:02.0
  fe050000-fe05ffff : 0000:02:02.0
fec00000-fec003ff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved



[7.5.] PCI information ('lspci -vvv' as root)
0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev
07) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 115
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: fc100000-fdffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Expansion ROM at 00002000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [c0] #08 [0086]
        Capabilities: [f0] #08 [8000]

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
        Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE
(rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: IBM: Unknown device 7469
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1020 [size=16]

0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
        Subsystem: IBM: Unknown device 746a
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 255
        Region 0: I/O ports at 1000

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
        Subsystem: IBM: Unknown device 746b
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: fe000000-fe0fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        Expansion ROM at 00003000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
        Capabilities: [c0] #08 [004a]

0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev
01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc000000 (64-bit, non-prefetchable)

0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]

0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev
01) (prog-if 10 [IO-APIC])
        Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at fc001000 (64-bit, non-prefetchable)

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB
(rev 0b) (prog-if 10 [OHCI])
        Subsystem: IBM: Unknown device 7464
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at fc100000 (32-bit, non-prefetchable)

0000:01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB
(rev 0b) (prog-if 10 [OHCI])
        Subsystem: IBM: Unknown device 7464
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at fc101000 (32-bit, non-prefetchable)

0000:01:05.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 0240
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fd000000 (32-bit, non-prefetchable)
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at fc102000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
        Subsystem: IBM: Unknown device 02a6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at fe010000 (64-bit, non-prefetchable)
        Region 2: Memory at fe000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management
version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
                Address: 0a31380c040042c8  Data: 0135

0000:02:01.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704
Gigabit Ethernet (rev 03)
        Subsystem: IBM: Unknown device 02a6
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 10
        Interrupt: pin B routed to IRQ 25
        Region 0: Memory at fe030000 (64-bit, non-prefetchable)
        Region 2: Memory at fe020000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40]      Capabilities: [48] Power Management
version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/3 Enable-
                Address: 9460002008830000  Data: 2007

0000:02:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030
PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
        Subsystem: IBM: Unknown device 026d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 4500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 26
        Region 0: I/O ports at 3000
        Region 1: Memory at fe050000 (64-bit, non-prefetchable) [size=64K]
        Region 3: Memory at fe040000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=2 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
DC=simple, DMMRBC=0, DMOST=0, DMC

[8]   I have advised the developers maintaining the forking server, to
explicitly set the SIGCHLD handler to SIG_IGN, to prevent the creation
of zombie processes until we can find the cause of this problem.

Cheers,
Michael Harris
Systems Administrator, Torque.net



