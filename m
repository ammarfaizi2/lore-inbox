Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRCZJ6W>; Mon, 26 Mar 2001 04:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132397AbRCZJ6R>; Mon, 26 Mar 2001 04:58:17 -0500
Received: from gip.u-picardie.fr ([193.49.184.17]:5988 "EHLO gip.u-picardie.fr")
	by vger.kernel.org with ESMTP id <S132396AbRCZJ6A>;
	Mon, 26 Mar 2001 04:58:00 -0500
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: BUG in reiserfs with 2.4.2-ac20 + linux-aic7xxx Rev 6.1.7
Mail-Copies-To: never
X-No-Productlinks: yes
From: Jean Charles Delepine <delepine@u-picardie.fr>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
Date: 26 Mar 2001 11:56:17 +0200
Message-ID: <m2n1a826ri.fsf@eloi.machoro.ka>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[dmesg, /proc/cpuinfo, /proc/interrupt, mount, ... at end of mail]
 
Mar 25 06:53:10 gip2 kernel: scsi1: PCI error Interrupt at seqaddr = 0x8
Mar 25 06:53:10 gip2 kernel: scsi1: Data Parity Error Detected during address or write data phase
Mar 25 06:53:55 gip2 kernel: scsi1: PCI error Interrupt at seqaddr = 0x8
Mar 25 06:53:55 gip2 kernel: scsi1: Data Parity Error Detected during
address or write data phase

I have many of them. Before I upgrade to linux-aic7xxx Rev 6.1.7. I 
experienced some freeze with the stock 2.4.2 and with 2.2 with many
scsi : aborting command due to timeout.

This one is new and not on the scsi1 interface :

Mar 25 06:56:50 gip2 kernel: journal_begin called without kernel lock held
Mar 25 06:56:50 gip2 kernel: kernel BUG at journal.c:423!

Thru ksymoops :

kernel BUG at journal.c:423!
invalid operand: 0000
CPU:    0
EIP:    0010:[<e0862f7b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001d   ebx: 00000000   ecx: c0227880   edx: 00000282
esi: c19ad000   edi: c56f1f00   ebp: 00000018   esp: c56f1e80
ds: 0018   es: 0018   ss: 0018
Process sort (pid: 30642, stackpage=c56f1000)
Stack: e086d384 000001a7 e0865432 e086e3a1 c56f1f00 de13f9a0 00000000 00000000 
       3abd7a92 00000003 c013675f dcbec5c0 00001000 dcbec5c0 e086566a c56f1f00 
       c19ad000 00000018 00000000 e0852ff8 c56f1f00 c19ad000 00000018 00000000 
Call Trace: [<e086d384>] [<e0865432>] [<e086e3a1>] [<c013675f>] [<e086566a>] [<e0852ff8>] [<c0125469>] 
       [<e0853fc0>] [<c0123724>] [<c01284b9>] [<c0132a0b>] [<c0108f3b>] [<c010002b>] 
Code: 0f 0b 83 c4 08 c3 8d 76 00 31 c0 c3 90 31 c0 c3 90 56 53 31 

>>EIP; e0862f7b <[reiserfs]reiserfs_check_lock_depth+33/3c>   <=====
Trace; e086d384 <[reiserfs].rodata.start+4ce4/6b7a>
Trace; e0865432 <[reiserfs]do_journal_begin_r+2a/230>
Trace; e086e3a1 <[reiserfs].rodata.start+5d01/6b7a>
Trace; c013675f <try_to_free_buffers+17b/1f8>
Trace; e086566a <[reiserfs]journal_begin+16/1c>
Trace; e0852ff8 <[reiserfs]reiserfs_truncate_file+98/194>
Trace; c0125469 <truncate_inode_pages+6d/80>
Trace; e0853fc0 <[reiserfs]reiserfs_vfs_truncate_file+c/10>
Trace; c0123724 <vmtruncate+ec/208>
Trace; c01284b9 <generic_file_write+565/578>
Trace; c0132a0b <sys_write+8f/c4>
Trace; c0108f3b <system_call+33/38>
Trace; c010002b <startup_32+2b/cb>
Code;  e0862f7b <[reiserfs]reiserfs_check_lock_depth+33/3c>
00000000 <_EIP>:
Code;  e0862f7b <[reiserfs]reiserfs_check_lock_depth+33/3c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  e0862f7d <[reiserfs]reiserfs_check_lock_depth+35/3c>
   2:   83 c4 08                  add    $0x8,%esp
Code;  e0862f80 <[reiserfs]reiserfs_check_lock_depth+38/3c>
   5:   c3                        ret    
Code;  e0862f81 <[reiserfs]reiserfs_check_lock_depth+39/3c>
   6:   8d 76 00                  lea    0x0(%esi),%esi
Code;  e0862f84 <[reiserfs]push_journal_writer+0/4>
   9:   31 c0                     xor    %eax,%eax
Code;  e0862f86 <[reiserfs]push_journal_writer+2/4>
   b:   c3                        ret    
Code;  e0862f87 <[reiserfs]push_journal_writer+3/4>
   c:   90                        nop    
Code;  e0862f88 <[reiserfs]pop_journal_writer+0/4>
   d:   31 c0                     xor    %eax,%eax
Code;  e0862f8a <[reiserfs]pop_journal_writer+2/4>
   f:   c3                        ret    
Code;  e0862f8b <[reiserfs]pop_journal_writer+3/4>
  10:   90                        nop    
Code;  e0862f8c <[reiserfs]dump_journal_writers+0/30>
  11:   56                        push   %esi
Code;  e0862f8d <[reiserfs]dump_journal_writers+1/30>
  12:   53                        push   %ebx
Code;  e0862f8e <[reiserfs]dump_journal_writers+2/30>
  13:   31 00                     xor    %eax,(%eax)

Linux gip2 2.4.2-ac20-p1 #4 SMP Thu Mar 22 13:28:35 CET 2001 i686 unknown
Kernel modules         2.4.2
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         reiserfs 3c59x
reiserfsprogs          3.x.0d

$ mount
/dev/sdh3 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sdh2 on /boot type ext2 (rw)
/dev/sdh5 on /usr type ext2 (rw)
/dev/sdc1 on /var type reiserfs (rw)
/dev/sdc2 on /var/log type reiserfs (rw)
/dev/sda1 on /var/spool/cyrus type reiserfs (rw)
/dev/sdb1 on /www type ext2 (rw,noatime)
/dev/sdd1 on /var/spool/squid/1 type reiserfs (rw,noatime)
/dev/sde1 on /var/spool/squid/2 type reiserfs (rw,noatime)
/dev/sdf1 on /var/spool/squid/3 type reiserfs (rw,noatime)
/dev/sdg1 on /var/spool/squid/4 type reiserfs (rw,noatime)

sda to sdg are on a gdth interface.
sdh (was sda before 2.4.2-ac or the new linux-aic) is on an adaptec.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.138
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 999.42

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.138
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 999.42

           CPU0       CPU1       
  0:     526638     526254    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 17:     286264     286414   IO-APIC-level  gdth
 18:    3160084    3158875   IO-APIC-level  eth0
 19:       8305       8299   IO-APIC-level  aic7xxx
NMI:          0          0 
LOC:    1052801    1052552 
ERR:          0
MIS:          0

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host
bridge (rev 03
)
        Flags: bus master, medium devsel, latency 64
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e1000000-e1efffff
        Prefetchable memory behind bridge: e2f00000-e3ffffff

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 
[Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at b800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00
 [UHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at b400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
        Subsystem: Adaptec: Unknown device 000f
        Flags: bus master, medium devsel, latency 32, IRQ 19
        BIST result: 00
        I/O ports at b000 [disabled] [size=256]
        Memory at e0800000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
[Cyclone] (rev 30
)
        Subsystem: 3Com Corporation: Unknown device 9055
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at a800 [size=128]
        Memory at e0000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:0b.0 SCSI storage controller: ICP Vortex Computersysteme GmbH GDT
6x28RD
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at 000d0000 (low-1M, prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
AGP (rev 7a)
 (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 16
        Memory at e3000000 (32-bit, prefetchable) [size=16M]
        I/O ports at d800 [size=256]
        Memory at e1000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at e2fe0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1

Linux version 2.4.2-ac20-p1 (delepine@gip2) (gcc version 2.95.2
20000220 (Debian
 GNU/Linux)) #4 SMP Thu Mar 22 13:28:35 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000001fefd000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000002000 @ 000000001fffd000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 000000001ffff000 (ACPI NVS)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f6e90
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 131069
zone(0): 4096 pages.
zone(1): 126973 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    PSN  present.
    MMX  present.
    FXSR  present.
    XMM  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is ISA   
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 0, IRQ 13, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 18, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 2c, APIC ID 2, APIC INT 11
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: 
Initializing CPU#0
Detected 501.146 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 513368k/524276k available (893k kernel code, 10520k reserved, 352k data,
 184k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt'instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.39 (20010312) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 1462.08 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 1000000
Getting ID: e000000
Getting LVT0: 8700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 0) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 999.42 BogoMIPS
Stack at about c188dfbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Katmai) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (1998.84 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
..TIMER: vector=49 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 501.1632 MHz.
..... host bus clock speed is 100.2323 MHz.
cpu: 0, clocks: 1002323, slice: 334107
CPU0<T0:1002320,T1:668208,D:5,S:334107Ç:1002323>
cpu: 1, clocks: 1002323, slice: 334107
CPU1<T0:1002320,T1:334096,D:10,S:334107Ç:1002323>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
PCI->APIC IRQ transform: (B0,I4,P3) -> 19
PCI->APIC IRQ transform: (B0,I6,P0) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 341146kB/210074kB, 1024 slots per queue
Real Time Clock Driver v1.10d
Software Watchdog Timer: 0.05, timer margin: 60 sec
SCSI subsystem driver Revision: 1.00
Configuring GDT-PCI HA at 0/11 IRQ 17
scsi0 : GDT6528RD
  Vendor: ICP       Model: Host Drive  #00   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ICP       Model: Host Drive  #01   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ICP       Model: Host Drive  #02   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ICP       Model: Host Drive  #03   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ICP       Model: Host Drive  #04   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ICP       Model: Host Drive  #05   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ICP       Model: Host Drive  #06   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 5, lun 0
Attached scsi disk sdg at scsi0, channel 0, id 6, lun 0
SCSI device sda: 17767890 512-byte hdwr sectors (9097 MB)
Partition check:
 sda: sda1
SCSI device sdb: 17767890 512-byte hdwr sectors (9097 MB)
 sdb: sdb1
SCSI device sdc: 17767890 512-byte hdwr sectors (9097 MB)
 sdc: sdc1 sdc2
SCSI device sdd: 17767890 512-byte hdwr sectors (9097 MB)
 sdd: sdd1
SCSI device sde: 17767890 512-byte hdwr sectors (9097 MB)
 sde: sde1
SCSI device sdf: 17767890 512-byte hdwr sectors (9097 MB)
 sdf: sdf1
SCSI device sdg: 17767890 512-byte hdwr sectors (9097 MB)
 sdg: sdg1
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.7
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Wide Channel A, SCSI Id=7, 32/255 SCBs

  Vendor: SEAGATE   Model: ST39175LW         Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: HP        Model: C1537A            Rev: L708
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1:0:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sdh at scsi1, channel 0, id 0, lun 0
(scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
SCSI device sdh: 17783240 512-byte hdwr sectors (9105 MB)
 sdh: sdh1 sdh2 sdh3 sdh4 < sdh5 sdh6 sdh7 sdh8 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 522072k swap-space (priority -1)

If you need more infos just ask.

                Jean Charles
-- 
> Mais bon, c'est pas moi qui lancerais l'AAD là-dessus (mais s'il passe
> je voterai certainement pour si ça peut éviter aux dinosaures de bloquer
> systèmatiquement toutes les initiatives des linuxiens).
-+- EF in Guide du linuxien pervers : "Les dinos ont changé de camps !" -+-
