Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbREQMXX>; Thu, 17 May 2001 08:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbREQMXM>; Thu, 17 May 2001 08:23:12 -0400
Received: from rainbow.studorg.tuwien.ac.at ([128.130.43.98]:5640 "EHLO
	rainbow.studorg.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S261407AbREQMXF>; Thu, 17 May 2001 08:23:05 -0400
Date: Thu, 17 May 2001 14:23:03 +0200 (CEST)
From: Michael Wildpaner <mike@rainbow.studorg.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: alpha/2.4.x: CPU misdetection, possible miscompilation
Message-ID: <Pine.LNX.4.21.0105161739440.31072-100000@rainbow.studorg.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to boot any 2.4.x kernel on a Tsunami DP264 alpha with dual EV67,
we found the following problems:

CPU misdetection:

	On our machine the cpu->type field contains 0x80000000B
	(= 2^35 + 11) instead of 0xB (= hwrpb.h: #define EV67_CPU 11).

	The spurious high bit leads to false/default values for
	on_chip_cache in smp.c:smp_tune_scheduling.

possible miscompilation of smp_tune_scheduling:

	These versions of gcc

		gcc version 2.95.3 20010111
		gcc version 2.95.4 20010506

	miscompile the 'switch (cpu->type)' in smp_tune_scheduling, which
	leads to a reproducible oops on 2.4.4, 2.4.5pre2 and 2.4.5pre2aa1.

Please find a goofy gcc workaround and an attempted cpu->type fix below.

As a side note, the value of smp.c:smp_tune_scheduling:on_chip_cache is
not used in 2.4.5pre2 and 2.4.5pre2aa1.

Greetings, Mike


=== gcc workaround / goofy ===

Inserting an debug statement leads to correct compilation of
smp_tune_scheduling:


--- tmp/linux/arch/alpha/kernel/smp.c	Wed May 16 17:24:28 2001
+++ linux-2.4.5pre2aa1/arch/alpha/kernel/smp.c	Wed May 16 18:06:59 2001
@@ -36,7 +36,7 @@
 #include "irq_impl.h"
 
 
-#define DEBUG_SMP 0
+#define DEBUG_SMP 1
 #if DEBUG_SMP
 #define DBGS(args)	printk args
 #else
@@ -239,6 +239,7 @@
 		break;
 
 	default:
+	        DBGS(("cpu->type = %lx\n", cpu->type));
 		on_chip_cache = 8 + 8;
 		break;
 	}



=== Fix for cpu->type ===

Masking cpu->type seems to work for this machine, but limiting the
cpu->type seems rather arbitrary.


--- tmp/linux/arch/alpha/kernel/smp.c	Wed May 16 17:24:28 2001
+++ linux-2.4.5pre2aa1/arch/alpha/kernel/smp.c	Wed May 16 18:24:49 2001
@@ -35,6 +35,8 @@
 #include "proto.h"
 #include "irq_impl.h"
 
+/* mask for cpu->type (arbitrary assumption based on #define's in hwrpb.h) */
+#define CPU_TYPE_MASK 0xFFFFFF
 
 #define DEBUG_SMP 0
 #if DEBUG_SMP
@@ -218,7 +220,7 @@
 	unsigned long freq;
 
 	cpu = (struct percpu_struct*)((char*)hwrpb + hwrpb->processor_offset);
-	switch (cpu->type)
+	switch (cpu->type & CPU_TYPE_MASK)
 	{
 	case EV45_CPU:
 		on_chip_cache = 16 + 16;


==== dmesg output begin ====

aboot: loading uncompressed vmlinux7...
aboot: segment 0, 2907516 bytes at 0xfffffc0000310000
aboot: zero-filling 1212636 bytes at fffffc00005d5d7c
aboot: starting kernel vmlinuz7 with arguments ro root=/dev/sda3
console=ttyS0
Linux version 2.4.5-pre2aa1 (mike@haring) (gcc version 2.95.4 20010506
(Debian prerelease)) #1 SMP Wed May 16 13:37:27 CEST 2001
Booting GENERIC on Tsunami variation DP264 using machine vector DP264 from
SRM
Command line: ro root=/dev/sda3 console=ttyS0
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end   130979
memcluster 2, usage 1, start   130979, end   131072
memcluster 3, usage 0, start   131072, end   393212
memcluster 4, usage 1, start   393212, end   393216
freeing pages 256:384
freeing pages 897:130979
freeing pages 131072:393212
reserving pages 897:903
SMP: 2 CPUs probed -- cpu_present_mask = 3
On node 0 totalpages: 393212
zone(0): 393212 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/sda3 console=ttyS0
Using epoch = 1900
Console: colour VGA+ 80x25
Calibrating delay loop... 1326.92 BogoMIPS
Memory: 3086216k/3145696k available (1817k kernel code, 56688k reserved,
583k data, 384k init)
Dentry-cache hash table entries: 262144 (order: 9, 4194304 bytes)
Buffer-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Page-cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 4194304 bytes)
POSIX conformance testing by UNIFIX
Unable to handle kernel paging request at virtual address 0000000000000000
CPU 0 swapper(0): Oops 0
pc = [<fffffc00004e44e8>]  ra = [<fffffc00004e4c54>]  ps = 0000
v0 = fffffc0000564000  t0 = 0000000000000001  t1 = 0000000000000000
t2 = 0000000000000180  t3 = 000000000009e000  t4 = fffffc00005d53c8
t5 = 0000000000003ff0  t6 = fffffc000068d100  t7 = fffffc0000540000
s0 = fffffc000060b880  s1 = fffffc0000564000  s2 = fffffc000060b7f0
s3 = fffffc000068c880  s4 = 0000000120001f40  s5 = 0000000000000000
s6 = 0000000000000000
a0 = fffffc0000564000  a1 = 0000000000000000  a2 = 0000000000000000
a3 = fffffc0000000008  a4 = 0000000000000000  a5 = 0000000000000000
t8 = 0000000000003fff  t9 = fffffc00005d6540  t10= fffffc00005d5de0
t11= fffffc00005e0260  pv = fffffc00004d06e0  at = fffffc00005d54c8
gp = fffffc00005ba400  sp = fffffc0000543f70
Code: b53e0008  stq s0,8(sp)
 203f0001  lda t0,1(zero)
 b55e0010  stq s1,16(sp)
 20d13ff0  lda t5,16368(a1)
 b75e0000  stq ra,0(sp)
 47f0040a  or zero,a0,s1
*a6e20000  ldq t9,0(t1)
 48255721  sll t0,42,t0

Trace:31001c 
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

=== ksymoops output begin ===

ksymoops 2.4.1 on alpha 2.2.19pre16-smp.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-pre2aa1 (specified)
     -m /boot/System.map-2.4.5pre2aa1 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 0000000000000000
CPU 0 swapper(0): Oops 0
pc = [<fffffc00004e44e8>]  ra = [<fffffc00004e4c54>]  ps = 0000
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = fffffc0000564000  t0 = 0000000000000001  t1 = 0000000000000000
t2 = 0000000000000180  t3 = 000000000009e000  t4 = fffffc00005d53c8
t5 = 0000000000003ff0  t6 = fffffc000068d100  t7 = fffffc0000540000
s0 = fffffc000060b880  s1 = fffffc0000564000  s2 = fffffc000060b7f0
s3 = fffffc000068c880  s4 = 0000000120001f40  s5 = 0000000000000000
s6 = 0000000000000000
a0 = fffffc0000564000  a1 = 0000000000000000  a2 = 0000000000000000
a3 = fffffc0000000008  a4 = 0000000000000000  a5 = 0000000000000000
t8 = 0000000000003fff  t9 = fffffc00005d6540  t10= fffffc00005d5de0
t11= fffffc00005e0260  pv = fffffc00004d06e0  at = fffffc00005d54c8
gp = fffffc00005ba400  sp = fffffc0000543f70
Code: b53e0008  stq s0,8(sp)
 203f0001  lda t0,1(zero)
 b55e0010  stq s1,16(sp)
 20d13ff0  lda t5,16368(a1)
 b75e0000  stq ra,0(sp)
 47f0040a  or zero,a0,s1
 48255721  sll t0,42,t0
Trace:31001c 
Kernel panic: Attempted to kill the idle task!
Warning (Oops_read): Code line not seen, dumping what data is available

>>PC;  fffffc00004e44e8 <secondary_cpu_start+28/1a0>   <=====
Trace; 0031001c Before first symbol


1 warning issued.  Results may not be reliable.





$ cat /proc/cpuinfo 
cpu                     : Alpha
cpu model               : EV67
cpu variation           : 7
cpu revision            : 0
cpu serial number       : 
system type             : Tsunami
system variation        : DP264
system revision         : 0
system serial number    : 
cycle frequency [Hz]    : 666666666 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 1334.16
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaPC 264DP 666 MHz
cpus detected           : 2
cpus active             : 2
cpu active mask         : 0000000000000003


-- 
Don't feed.                                               DI Michael Wildpaner
Don't provoke.                                                   Ph.D. Student
Don't enter the cage.





