Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279782AbRKIJjg>; Fri, 9 Nov 2001 04:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279783AbRKIJjc>; Fri, 9 Nov 2001 04:39:32 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:5643 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S279782AbRKIJiw> convert rfc822-to-8bit; Fri, 9 Nov 2001 04:38:52 -0500
Date: Fri, 9 Nov 2001 03:38:51 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm problems)
Message-ID: <20011109033851.A15099@asooo.flowerfire.com>
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Oct 31, 2001 at 12:07:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're seeing an easily reproducible problem that I believe to be along
the same lines as what Google is seeing.  I'm not sure if Oracle's SGA
(shmem) can be mlock()ed, but I'm guessing there's a state analogous to
Solaris' ISM.  We're seeing this on a 4GB machine with HIGHMEM/HIGHMEM4G
set, using 2.4.1{3,4,5-pre1}.

The machine in question has one 99% active Oracle shadow process, with
kswapd eating about 17-20% CPU at all times.  Per the top listings
below, Oracle is set to use a ~840M SGA.  Interactive performance is
poor, behaving like moderate to severe swapping.  A higher SGA increases
the severity of the problem -- 1.4GB seems to cause the machine to run
away and hide more or less permanently.

However, when a remote machine begins to copy a ~20MB file to this
machine via scp, the following top screen displays and the machine is
essentially frozen for a significant period of time (roughly 15 minutes
to two hours):

 12:22am  up 1 day, 35 min,  1 user,  load average: 7.23, 4.35, 4.27
85 processes: 79 sleeping, 6 running, 0 zombie, 0 stopped
CPU states:  0.0% user, 98.4% system,  0.0% nice,  1.4% idle
Mem:  3343692K av, 3339124K used,    4568K free,       0K shrd,     368K buff
Swap: 1004052K av,  194920K used,  809132K free                 2522428K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
   11 root      17   0     0    0     0 RW      0 99.9  0.0  24:09 kupdated
 2562 oracle    18   0  5964 5632  5488 R    3972 99.9  0.1  34:41 oracle
 2912 oracle    11   0  840M 839M  278M D    255M 93.7 25.7 134:49 oracle
    9 root      14   0     0    0     0 RW      0 88.3  0.0  77:04 kswapd
 3273 root      14   0   888  888   672 R       0 47.5  0.0   1:07 top
 3279 webrot    14   0   580  580   472 R       0 42.7  0.0   0:27 scp
 3282 root      14   0  1092 1072   888 R       0  8.3  0.0   0:01 sshd

It looks like all quasi-active processes begin to "use" 100% system CPU
time.  When the machine recovers 15-120 minutes later, the load has shot
up to >17 and the memory state seems unchanged.  kswapd reappears at
70-80% CPU usage and slowly drops back down to an oscillating 20-90%
range.  Swap usage continues to slowly creep higher:

 12:39am  up 1 day, 52 min,  1 user,  load average: 2.02, 8.16, 9.07
82 processes: 80 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:  3.9% user, 21.9% system,  0.0% nice, 74.1% idle
Mem:  3343692K av, 3340728K used,    2964K free,       0K shrd,     416K buff
Swap: 1004052K av,  207016K used,  797036K free                 2516988K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
 2912 oracle    14   0  855M 854M  280M D    254M 87.6 26.1 143:26 oracle
    9 root      19   0     0    0     0 RW      0 61.5  0.0  82:43 kswapd
 3273 root      18   0   896  868   744 R       0  3.4  0.0   5:49 top

The issue gets better and worse over time without a specific period.
Other kinds of load on this type of machine and kernel seem fine, from
heavy compilation to a development platform for dozens of heavily-active
developers, NFS, etc.

A secondary issue is that kswapd before this hang event is eating 20-90%
more CPU than I think it should :) especially given Oracle's static SGA
that fits well within RAM.  I understand that the quantitative swap
usage could be quite normal based on page age, but it's slightly
worrying that so much swap is being used, given that the page cache is
2.5GB.

This machine is an HP LH6000r (6-way Xeon) with 4GB of RAM (minus the
700MB that HP needs for hot-swappable PCI.  I hate HP.)  I've seen this
since 2.4.13, but didn't try anything between 2.4.9 and 2.4.13
exclusive.  Currently running is 2.4.15-pre1 with Marcelo's vmscan
patch.  I know it won't be "baptized", but it does seem to slightly
reduce the severity and length of the hang state.

Basically, this problem makes it impossible to run Oracle on Linux,
which is really a massive problem from our point of view.  If someone
could show me how to provide more useful information or further debug
this problem, I would greatly appreciate it.  This includes specific
alternate kernels, or perhaps without HIGHMEM4G or HIGHMEM.

I've attached some various stats etc below just to cover bases.  This
example is not a pristine 2.4.15-pre1, due to the long-standing IO-APIC
issues and various other VM-unrelated patches, but the issue also
reproduces on pristine versions of 2.4.1{3,4,5-pre1}.

Thanks much,
-- 
Ken.
brownfld@irridia.com

Nothing notable in syslogs.

[root@skunk ~]$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 10
model name	: Pentium III (Cascades)
stepping	: 0
cpu MHz		: 700.084
cache size	: 2048 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1395.91

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 10
model name	: Pentium III (Cascades)
stepping	: 1
cpu MHz		: 700.084
cache size	: 2048 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 10
model name	: Pentium III (Cascades)
stepping	: 1
cpu MHz		: 700.084
cache size	: 2048 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 10
model name	: Pentium III (Cascades)
stepping	: 1
cpu MHz		: 700.084
cache size	: 2048 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 10
model name	: Pentium III (Cascades)
stepping	: 0
cpu MHz		: 700.084
cache size	: 2048 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 10
model name	: Pentium III (Cascades)
stepping	: 0
cpu MHz		: 700.084
cache size	: 2048 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1399.19

[root@skunk ~]$ cat /proc/slabinfo
slabinfo - version: 1.1 (SMP)
kmem_cache            64     64    244    4    4    1 :  252  126
ip_fib_hash           11    452     32    4    4    1 :  252  126
ip_mrt_cache           0      0     96    0    0    1 :  252  126
tcp_tw_bucket          0      0    128    0    0    1 :  252  126
tcp_bind_bucket       11    452     32    4    4    1 :  252  126
tcp_open_request       0      0     96    0    0    1 :  252  126
inet_peer_cache        0      0     64    0    0    1 :  252  126
ip_dst_cache          33    220    192   11   11    1 :  252  126
arp_cache              5     90    128    3    3    1 :  252  126
blkdev_requests      512    520     96   13   13    1 :  252  126
journal_head           9    234     48    3    3    1 :  252  126
revoke_table           2    506     12    2    2    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache       91    504     92   12   12    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache              6    565     32    5    5    1 :  252  126
skbuff_head_cache   1132   2064    160   86   86    1 :  252  126
sock                  52     60    928   15   15    1 :  124   62
sigqueue             188    319    132   11   11    1 :  252  126
cdev_cache            11    413     64    7    7    1 :  252  126
bdev_cache             8    354     64    6    6    1 :  252  126
mnt_cache             15    295     64    5    5    1 :  252  126
inode_cache        10235  38368    480 4796 4796    1 :  124   62
dentry_cache         432   1650    128   55   55    1 :  252  126
dquot                  0      0    128    0    0    1 :  252  126
filp                1216   1500    128   50   50    1 :  252  126
names_cache            4      4   4096    4    4    1 :   60   30
buffer_head       561764 719760     96 17994 17994    1 :  252  126
mm_struct             66    336    160   14   14    1 :  252  126
vm_area_struct      1845   2560     96   64   64    1 :  252  126
fs_cache              69    472     64    8    8    1 :  252  126
files_cache           69    234    416   26   26    1 :  124   62
signal_act            74    135   1312   45   45    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536            19     19  65536   19   19   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             2      2  32768    2    2    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384             1      1  16384    1    1    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              3      3   8192    3    3    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             43     43   4096   43   43    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            679    756   2048  378  378    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            264    284   1024   71   71    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             295    296    512   37   37    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             165    165    256   11   11    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128             750    750    128   25   25    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              315    708     64   12   12    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32              964   2147     32   19   19    1 :  252  126

[root@skunk ~]$ cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  3423940608 3421167616  2772992        0   417792 2616827904
Swap: 1028149248 215212032 812937216
MemTotal:      3343692 kB
MemFree:          2708 kB
MemShared:           0 kB
Buffers:           408 kB
Cached:        2511388 kB
SwapCached:      44108 kB
Active:        1097100 kB
Inactive:      2126344 kB
HighTotal:     2482112 kB
HighFree:         1136 kB
LowTotal:       861580 kB
LowFree:          1572 kB
SwapTotal:     1004052 kB
SwapFree:       793884 kB

[root@skunk ~]$ dmesg -s32768
Linux version 2.4.15-pre1kb2 (root@aenea.XXX.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Wed Nov 7 23:03:00 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e5c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000c40f0000 (usable)
 BIOS-e820: 00000000c40f0000 - 00000000c40ffc00 (ACPI data)
 BIOS-e820: 00000000c40ffc00 - 00000000c4100000 (ACPI NVS)
 BIOS-e820: 00000000c4100000 - 00000000cf800000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
2424MB HIGHMEM available.
found SMP MP-table at 000f7590
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 849920
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 620544 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: LH 6000      APIC at: 0xFEE00000
Processor #6 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
Processor #2 Pentium(tm) Pro APIC version 17
Processor #4 Pentium(tm) Pro APIC version 17
Processor #5 Pentium(tm) Pro APIC version 17
I/O APIC #3 Version 17 at 0xFEC00000.
I/O APIC #7 Version 17 at 0xFEC01000.
Processors: 6
Kernel command line: auto BOOT_IMAGE=linux ro root=801 no8259A
Initializing CPU#0
Detected 700.084 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1395.91 BogoMIPS
Memory: 3343460k/3399680k available (1387k kernel code, 55764k reserved, 477k data, 232k init, 2482112k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Cascades) stepping 00
per-CPU timeslice cutoff: 5846.34 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Cascades) stepping 01
Booting processor 2/1 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
Intel machine check reporting enabled on CPU#2.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU2: Intel Pentium III (Cascades) stepping 01
Booting processor 3/2 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
Intel machine check reporting enabled on CPU#3.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU3: Intel Pentium III (Cascades) stepping 01
Booting processor 4/4 eip 2000
Initializing CPU#4
masked ExtINT on CPU#4
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
Intel machine check reporting enabled on CPU#4.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU4: Intel Pentium III (Cascades) stepping 00
Booting processor 5/5 eip 2000
Initializing CPU#5
masked ExtINT on CPU#5
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1399.19 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
Intel machine check reporting enabled on CPU#5.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU5: Intel Pentium III (Cascades) stepping 00
Total of 6 processors activated (8391.88 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 7 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 7 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 3-0, 7-3, 7-10, 7-11, 7-12, 7-13, 7-14, 7-15 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer as Virtual Wire IRQ... works.
number of MP IRQ sources: 34.
number of IO-APIC #3 registers: 16.
number of IO-APIC #7 registers: 16.
testing the IO APIC.......................

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 03F 0F  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 03F 0F  0    0    0   0   0    1    1    41
 04 03F 0F  0    0    0   0   0    1    1    49
 05 03F 0F  1    1    0   1   0    1    1    51
 06 03F 0F  0    0    0   0   0    1    1    59
 07 03F 0F  0    0    0   0   0    1    1    61
 08 03F 0F  0    0    0   0   0    1    1    69
 09 03F 0F  1    1    0   1   0    1    1    71
 0a 03F 0F  1    1    0   1   0    1    1    79
 0b 03F 0F  1    1    0   1   0    1    1    81
 0c 03F 0F  0    0    0   0   0    1    1    89
 0d 03F 0F  0    0    0   0   0    1    1    91
 0e 03F 0F  0    0    0   0   0    1    1    99
 0f 03F 0F  0    0    0   0   0    1    1    A1

IO APIC #7......
.... register #00: 07000000
.......    : physical APIC id: 07
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 07000000
.......     : arbitration: 07
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 03F 0F  1    1    0   1   0    1    1    A9
 01 03F 0F  1    1    0   1   0    1    1    B1
 02 03F 0F  1    1    0   1   0    1    1    B9
 03 000 00  1    0    0   0   0    0    0    00
 04 03F 0F  1    1    0   1   0    1    1    C1
 05 03F 0F  1    1    0   1   0    1    1    C9
 06 03F 0F  1    1    0   1   0    1    1    D1
 07 03F 0F  1    1    0   1   0    1    1    D9
 08 03F 0F  1    1    0   1   0    1    1    E1
 09 03F 0F  1    1    0   1   0    1    1    E9
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ20 -> 1:4
IRQ21 -> 1:5
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ25 -> 1:9
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 700.0558 MHz.
..... host bus clock speed is 100.0078 MHz.
cpu: 0, clocks: 1000078, slice: 142868
CPU0<T0:1000064,T1:857184,D:12,S:142868,C:1000078>
cpu: 1, clocks: 1000078, slice: 142868
cpu: 2, clocks: 1000078, slice: 142868
cpu: 3, clocks: 1000078, slice: 142868
cpu: 4, clocks: 1000078, slice: 142868
cpu: 5, clocks: 1000078, slice: 142868
CPU2<T0:1000064,T1:571456,D:4,S:142868,C:1000078>
CPU1<T0:1000064,T1:714320,D:8,S:142868,C:1000078>
CPU3<T0:1000064,T1:428592,D:0,S:142868,C:1000078>
CPU4<T0:1000064,T1:285712,D:12,S:142868,C:1000078>
CPU5<T0:1000064,T1:142848,D:8,S:142868,C:1000078>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x3e)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd989, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01 [IRQ]
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
PCI->APIC IRQ transform: (B0,I6,P0) -> 18
PCI->APIC IRQ transform: (B2,I8,P0) -> 20
PCI->APIC IRQ transform: (B4,I2,P0) -> 16
PCI->APIC IRQ transform: (B4,I2,P1) -> 17
PCI->APIC IRQ transform: (B4,I3,P0) -> 21
PCI->APIC IRQ transform: (B5,I4,P0) -> 22
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Software Watchdog Timer: 0.05, timer margin: 60 sec
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1840-0x1847, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1848-0x184f, BIOS settings: hdc:pio, hdd:pio
hda: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
NET4: Frame Diverter 0.46
loop: loaded (max 8 devices)
DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
DAC960#0: Configuring Mylex eXtremeRAID 2000 PCI RAID Controller
DAC960#0:   Firmware Version: 6.00-01, Channels: 4, Memory Size: 64MB
DAC960#0:   PCI Bus: 2, Device: 8, Function: 0, I/O Address: Unassigned
DAC960#0:   PCI Address: 0xD2000000 mapped at 0xF8800000, IRQ Channel: 20
DAC960#0:   Controller Queue Depth: 512, Maximum Blocks per Command: 2048
DAC960#0:   Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
DAC960#0:   Physical Devices:
DAC960#0:     0:5  Vendor: HP        Model: SAFTE; U160/M BP  Revision: 1020
DAC960#0:          Asynchronous
DAC960#0:          Serial Number: [ 
DAC960#0:     0:7  Vendor: MYLEX     Model: eXtremeRAID 2000  Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:     0:10 Vendor: HP        Model: 36.4GB C 80-8C32  Revision:     
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number: 3CD06PWA            
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     0:11 Vendor: HP        Model: 36.4GB C 80-8C32  Revision:     
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number: 3CD05CT9            
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     0:12 Vendor: HP        Model: 36.4GB C 80-8C32  Revision:     
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number: 3CD07111            
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     0:13 Vendor: HP        Model: 36.4GB C 80-8C32  Revision:     
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number: 3CD071NR            
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     0:14 Vendor: HP        Model: 36.4GB C 80-8C32  Revision:     
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number: 3CD06X36            
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     0:15 Vendor: HP        Model: 36.4GB C 80-8C32  Revision:     
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number: 3CD05BPL            
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     1:0  Vendor: HP        Model: 36.4GB C 80-D94N  Revision: D94N
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number:         4FFWH733
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     1:1  Vendor: HP        Model: 36.4GB C 80-D94N  Revision: D94N
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number:         4FFWQ327
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     1:2  Vendor: HP        Model: 36.4GB C 80-D94N  Revision: D94N
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number:         4FFWM586
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     1:3  Vendor: HP        Model: 36.4GB C 80-D94N  Revision: D94N
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number:         4FFWQ340
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     1:5  Vendor: HP        Model: SAFTE; U160/M BP  Revision: 1020
DAC960#0:          Asynchronous
DAC960#0:          Serial Number: [ 
DAC960#0:     1:7  Vendor: MYLEX     Model: eXtremeRAID 2000  Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:     1:8  Vendor: HP        Model: 36.4GB C 80-D94N  Revision: D94N
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number:         4FFWP201
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     1:9  Vendor: HP        Model: 36.4GB C 80-D94N  Revision: D94N
DAC960#0:          Wide Synchronous at 80 MB/sec
DAC960#0:          Serial Number:         4FFWP351
DAC960#0:          Disk Status: Online, 71098368 blocks
DAC960#0:     2:7  Vendor: MYLEX     Model: eXtremeRAID 2000  Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:     3:7  Vendor: MYLEX     Model: eXtremeRAID 2000  Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:   Logical Drives:
DAC960#0:     /dev/rd/c0d0: RAID-5, Online, 355450880 blocks
DAC960#0:                   Logical Device Initialized, BIOS Geometry: 255/63
DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
DAC960#0:                   Read Cache Disabled, Write Cache Enabled
DAC960#0:     /dev/rd/c0d1: RAID-0, Online, 426541056 blocks
DAC960#0:                   Logical Device Initialized, BIOS Geometry: 255/63
DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
DAC960#0:                   Read Cache Disabled, Write Cache Enabled
Partition check:
 rd/c0d0:<7>LDM:  DEBUG (ldm.c, 898): validate_partition_table: Found basic MS-DOS partition, not a dynamic disk.
 rd/c0d0p1 rd/c0d0p2 rd/c0d0p3
 rd/c0d1:<7>LDM:  DEBUG (ldm.c, 898): validate_partition_table: Found basic MS-DOS partition, not a dynamic disk.
 rd/c0d1p1 rd/c0d1p2 rd/c0d1p3 rd/c0d1p4 < rd/c0d1p5 rd/c0d1p6 rd/c0d1p7 >
SCSI subsystem driver Revision: 1.00
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001
)<5>megaraid: found 0x8086:0x1960:idx 0:bus 4:slot 3:func 1
scsi0 : Found a MegaRAID controller at 0xf8802000, IRQ: 21
megaraid: [:B ] detected 1 logical drives
megaraid: channel[1] is raid.
megaraid: channel[2] is raid.
scsi0 : LSI Logic MegaRAID  254 commands 16 targs 5 chans 7 luns
scsi0: scanning channel 0 for devices.
scsi0: scanning channel 1 for devices.
scsi0: scanning virtual channel 1 for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID1  8677R  Rev:   E 
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: scanning virtual channel 2 for logical drives.
scsi0: scanning virtual channel 3 for logical drives.
scsi0: scanning virtual channel 4 for logical drives.
Attached scsi disk sda at scsi0, channel 2, id 0, lun 0
SCSI device sda: 17770496 512-byte hdwr sectors (9098 MB)
 sda:<7>LDM:  DEBUG (ldm.c, 898): validate_partition_table: Found basic MS-DOS partition, not a dynamic disk.
 sda1 sda2
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   962.000 MB/sec
   32regs    :   636.800 MB/sec
   pIII_sse  :  1398.800 MB/sec
   pII_mmx   :  1554.800 MB/sec
   p5_mmx    :  1650.800 MB/sec
raid5: using function: pIII_sse (1398.800 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
lvm -- Driver successfully initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k freed
DAC960#0: Physical Device 0:5 Found
DAC960#0: Physical Device 1:5 Found
DAC960#0: Physical Device 1:0 Found
DAC960#0: Physical Device 1:1 Found
DAC960#0: Physical Device 1:2 Found
DAC960#0: Physical Device 1:3 Found
DAC960#0: Physical Device 1:8 Found
DAC960#0: Physical Device 1:9 Found
DAC960#0: Physical Device 0:10 Found
DAC960#0: Physical Device 0:11 Found
DAC960#0: Physical Device 0:12 Found
DAC960#0: Physical Device 0:13 Found
DAC960#0: Physical Device 0:14 Found
DAC960#0: Physical Device 0:15 Found
DAC960#0: Physical Device 0:10 Online
DAC960#0: Physical Device 0:11 Online
DAC960#0: Physical Device 0:12 Online
DAC960#0: Physical Device 0:13 Online
DAC960#0: Physical Device 0:14 Online
DAC960#0: Physical Device 0:15 Online
DAC960#0: Physical Device 1:0 Online
DAC960#0: Physical Device 1:1 Online
DAC960#0: Physical Device 1:2 Online
DAC960#0: Physical Device 1:3 Online
DAC960#0: Physical Device 1:8 Online
DAC960#0: Physical Device 1:9 Online
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Found
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Online
DAC960#0: Logical Drive 1 (/dev/rd/c0d1) Found
DAC960#0: Logical Drive 1 (/dev/rd/c0d1) Online
DAC960#0: Controller Battery Backup Unit Found
DAC960#0: Enclosure 1 Temperature Sensor 0 Temperature Normal
DAC960#0: Enclosure 2 Temperature Sensor 0 Temperature Normal
Adding Swap: 1004052k swap-space (priority 1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on dac960(48,11), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.15, 06 Nov 2001 on dac960(48,13), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
sk98lin: Network Device Driver v4.06kb0
Copyright (C) 2000-2001 SysKonnect GmbH.
divert: allocating divert_blk for eth0
eth0: SysKonnect SK-NET Gigabit Ethernet Adapter SK-9843 SX
      PrefPort:A  RlmtMode:Check Link State
eth0: network connection up using port A
    speed:           1000
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric

[root@aenea ~]$ cat /usr/src/linux/.config
#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
CONFIG_BLK_DEV_DAC960=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=y
CONFIG_BLK_DEV_LVM=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_POOL=m
CONFIG_IP_POOL_STATISTICS=y
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_MPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TIME=m
CONFIG_IP_NF_MATCH_PSD=m
CONFIG_IP_NF_MATCH_RANDOM=m
CONFIG_IP_NF_MATCH_NTH=m
CONFIG_IP_NF_MATCH_IPV4OPTIONS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_IPLIMIT=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_NETLINK=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_FTOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_AGR=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_KHTTPD=m
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_IPX is not set
CONFIG_ATALK=m
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
CONFIG_NET_DIVERT=y
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
# CONFIG_SCSI_DEBUG_QUEUES is not set
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_SCSI_DPT_I2O=y
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
CONFIG_SCSI_MEGARAID=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
# CONFIG_APPLETALK is not set
CONFIG_DUMMY=m
CONFIG_BONDING=m
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_SK98LIN=m
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
CONFIG_SERIAL_MULTIPORT=y
# CONFIG_HUB6 is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_I810_TCO is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_INTEL_RNG=y
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_MINIX_FS is not set
CONFIG_VXFS_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_ZLIB_FS_INFLATE is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
CONFIG_MIDI_EMU10K1=y
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
CONFIG_SOUND_ICH=m
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=m
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
CONFIG_SOUND_YMFPCI=m
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDDEV=y
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_BUGVERBOSE=y

[root@skunk ~]$ lspci -v -v -v
00:00.0 Host bridge: Relience Computer CNB20HE (rev 21)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: Relience Computer CNB20HE (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64 set, cache line size 08

00:00.2 Host bridge: Relience Computer: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: Relience Computer: Unknown device 0006
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Hewlett-Packard Company: Unknown device 10ca
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 56 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at cf801000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1800 [size=64]
	Region 2: Memory at cf900000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:07.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC (rev 7a) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 10c4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 66 set, cache line size 08
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1400 [size=256]
	Region 2: Memory at cf802000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 4f)
	Subsystem: Relience Computer: Unknown device 0200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set
	Region 4: I/O ports at 1840 [size=16]

01:03.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=68
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: d2000000-d3ffffff
	Prefetchable memory behind bridge: 00000000d8000000-00000000dbf00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 RAID bus controller: Mylex Corporation: Unknown device ba56
	Subsystem: Mylex Corporation: Unknown device 0040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at d2000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: I/O ports at 2000 [size=128]
	Region 2: Memory at d8000000 (64-bit, prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [70] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:02.0 System peripheral: Hewlett-Packard Company: Unknown device 1219 (rev 0b)
	Subsystem: Hewlett-Packard Company: Unknown device 0001
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 4000 [size=256]

04:02.1 Class 0c06: Hewlett-Packard Company: Unknown device 121a (rev 0b)
	Subsystem: Hewlett-Packard Company: Unknown device 0001
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at 4400 [size=256]

04:03.0 PCI bridge: Intel Corporation: Unknown device 0964 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set, cache line size 08
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=64
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: dc800000-dc8fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:03.1 SCSI storage controller: Intel Corporation 80960RP [i960RP Microprocessor] (rev 01)
	Subsystem: Hewlett-Packard Company: Unknown device 10cc
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B+
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Expansion ROM at <unassigned> [disabled] [size=32K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:04.0 Ethernet controller: Syskonnect (Schneider & Koch) Gigabit Ethernet (rev 12)
	Subsystem: Syskonnect (Schneider & Koch) SK-9843 (1000Base-SX single link)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 23 min, 31 max, 64 set, cache line size 08
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at dc808000 (32-bit, non-prefetchable) [size=16K]
	Region 1: I/O ports at 5000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [48] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data

05:08.0 System peripheral: Hewlett-Packard Company: Unknown device 10c1 (rev a0)
	Subsystem: Hewlett-Packard Company: Unknown device 0001
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at dc800000 (32-bit, non-prefetchable) [size=32K]

