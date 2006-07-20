Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWGTNaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWGTNaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 09:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWGTNaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 09:30:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25245 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030282AbWGTNaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 09:30:07 -0400
From: Paul Jackson <pj@sgi.com>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Dimitri Sivanich <sivanich@sgi.com>
Date: Thu, 20 Jul 2006 06:29:59 -0700
Message-Id: <20060720132959.31161.284.sendpatchset@v0>
Subject: [BUG] Cpuset: dynamic sched domain crash on > 16 cpu systems.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh,

There is a kernel crash in the following patch, on systems with greater
than 16 CPUs, trying to set 'cpu_exclusive' on a cpuset that doesn't
have all CPUs in it.

The patch was known in Andrew's tree as:
  sched-fix-group-power-for-allnodes_domains.patch

It went into Andrew's tree about Feb 5, 2006, and then into Linus's
tree as the changeset:

  changeset:   25175:b8bf3a0f6377
  user:        Siddha, Suresh B <suresh.b.siddha@intel.com>
  date:        Tue Mar 28 00:44:44 2006 +0800
  summary:     [PATCH] sched: fix group power for allnodes_domains

This bug is still present, as of 2.6.18-rc2.

For the necessary combination of cpuset and system configuration,
this crash happens every time, instantly.


When the 'write(2)' of the value '1' is done into most (not all)
variations of cpusets not having all CPUs, then the kernel crashes
the process doing the write, with the message:

========================== begin ==========================
bash[5940]: NaT consumption 17179869216 [1]
Modules linked in:

Pid: 5940, CPU 0, comm:                 bash
psr : 0000101008526010 ifs : 8000000000000003 ip  : [<a0000001003f3550>]    Not tainted
ip is at find_next_bit+0xb0/0x1a0
unat: 0000000000000000 pfs : 0000000000000207 rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000000000596559
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001003f31f0 b6  : a0000001000d28e0 b7  : a00000010008cc80
f6  : 0fffbccccccccc8c00000 f7  : 0ffdbf300000000000000
f8  : 10001c000000000000000 f9  : 10002a000000000000000
f10 : 0fffe9999999996900000 f11 : 1003e0000000000000000
r1  : a000000100d67f10 r2  : e000003c39ab9060 r3  : 0000000000000001
r8  : 0000000000000400 r9  : 0000000000000400 r10 : a000000100b806d8
r11 : a000000100b806e8 r12 : e000003c39abef30 r13 : e000003c39ab8000
r14 : 0000000000000000 r15 : e000003c39ab9070 r16 : 0000000000000000
r17 : 0000000000004000 r18 : 000000000000003e r19 : a000000100b7f958
r20 : 0000000000004000 r21 : 0000000000004000 r22 : a000000100b806f0
r23 : a000000100b806d0 r24 : a000000100ab1a80 r25 : a000000100ab1a80
r26 : e000003c39ab9070 r27 : e000003c39ab9060 r28 : e000003c39ab9088
r29 : 0000000000000000 r30 : 0000000000000001 r31 : 0000000000000000

Call Trace:
 [<a000000100012880>] show_stack+0x40/0xa0
                                sp=e000003c39abe950 bsp=e000003c39ab96b0
 [<a000000100013180>] show_regs+0x840/0x880
                                sp=e000003c39abeb20 bsp=e000003c39ab9658
 [<a000000100034b70>] die+0x250/0x360
                                sp=e000003c39abeb20 bsp=e000003c39ab9610
 [<a000000100034cd0>] die_if_kernel+0x50/0x80
                                sp=e000003c39abeb40 bsp=e000003c39ab95d8
 [<a000000100035e50>] ia64_fault+0x1150/0x1260
                                sp=e000003c39abeb40 bsp=e000003c39ab9580
 [<a00000010000bb20>] ia64_leave_kernel+0x0/0x290
                                sp=e000003c39abed60 bsp=e000003c39ab9580
 [<a0000001003f3550>] find_next_bit+0xb0/0x1a0
                                sp=e000003c39abef30 bsp=e000003c39ab9568
 [<a0000001003f31f0>] __first_cpu+0x30/0x60
                                sp=e000003c39abef30 bsp=e000003c39ab9548
 [<a00000010008e2f0>] init_numa_sched_groups_power+0x90/0x280
                                sp=e000003c39abef30 bsp=e000003c39ab9508
 [<a000000100096f90>] build_sched_domains+0x1590/0x2460
                                sp=e000003c39abef30 bsp=e000003c39ab9430
 [<a000000100099be0>] partition_sched_domains+0xc0/0x120
                                sp=e000003c39abf960 bsp=e000003c39ab9408
 [<a0000001000ee9f0>] update_cpu_domains+0x2d0/0x300
                                sp=e000003c39abf9e0 bsp=e000003c39ab93c8
 [<a0000001000f0fe0>] cpuset_file_write+0x400/0x1040
                                sp=e000003c39abfb60 bsp=e000003c39ab9360
 [<a000000100158590>] vfs_write+0x1b0/0x340
                                sp=e000003c39abfe20 bsp=e000003c39ab9310
 [<a000000100159210>] sys_write+0x70/0xe0
                                sp=e000003c39abfe20 bsp=e000003c39ab9298
 [<a00000010000b980>] ia64_ret_from_syscall+0x0/0x20
                                sp=e000003c39abfe30 bsp=e000003c39ab9298
 [<a000000000010620>] __kernel_syscall_via_break+0x0/0x20
                                sp=e000003c39ac0000 bsp=e000003c39ab9298
=========================== end ===========================

All testing and analysis so far of this bug has been done on a system
with 60 CPUs, and 30 Memory Nodes, with exactly 2 CPUs per Node.
This system is an ia64 (SN2) system.

The init_numa_sched_groups_power() call that is failing is the
second one:

        init_numa_sched_groups_power(sched_group_allnodes);

It seems that the sched_group_allnodes list is not entirely built.

By adding kernel prints to the loops in the routine:

        init_sched_build_groups()

I see during the successful boot of the system, that in the inner loop
for building sched_group_allnodes(), it builds for all pairs <i, j> such
that i is an even number in the range [0, 58], and j equals i or i + 1.

But when I then do the following after booting:

    test -d /dev/cpuset || mkdir /dev/cpuset
    mount -t cpuset cpuset /dev/cpuset
    cd /dev/cpuset
    mkdir foo
    cp mems foo
    cd foo
    echo 0-15 > cpus
    echo 1 > cpu_exclusive

it immediately crashes my interactive shell process, with the above
kernel message.

The rest of the system -seems- to continue working after this
crash.  I get to login again if I let my login shell get killed.
However something is not right, and subsequent cpuset operations risk
freezing the system completely, forcing a hardware reset.

In the case of this crash, the sched_group_allnodes() inner loop only
builds for <i, j> where i is an even number in the range [16, 58]
and j is i or i + 1.  The values for <i, j> where i is an even number
in the range [0, 14] are skipped.

The failure in the routine init_numa_sched_groups_power() always
occurs on the -2nd- invocation of for_each_cpu_mask(j, sg->cpumask).
The first invocation apparently sees an empty cpumask (nothing within
the for-loop is executed), and then the "goto next_sg" sends it back for
a second invocation of for_each_cpu_mask(j, sg->cpumask), which dies.

I could gather more debug and trace data if you need it.  But I'm
guessing that the above has a good chance of being sufficient.

Let me know if I can help further.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
