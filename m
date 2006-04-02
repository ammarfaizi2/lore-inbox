Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWDBW0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWDBW0m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWDBW0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:26:42 -0400
Received: from kevlar.burdell.org ([66.92.73.214]:36071 "EHLO
	kevlar.burdell.org") by vger.kernel.org with ESMTP id S932428AbWDBW0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:26:41 -0400
Date: Sun, 2 Apr 2006 18:19:21 -0400
From: Sonny Rao <sonny@burdell.org>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org
Subject: 2.6.16 crashes when running numastat on p575
Message-ID: <20060402221921.GA27513@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm getting an immediate crash on 2.6.16 when  I run the numastat
command.  The machine is a 16-way IBM p575 POWER5+ box.  It has 8 NUMA
nodes.  Bug is very easy to reproduce on this machine, haven't seen it
on another machine yet.

exception info:
 16:mon> e
cpu 0x16: Vector: 300 (Data Access) at [c0000005aa5db890]
    pc: c000000000293940: .node_read_numastat+0x7c/0x114
    lr: c00000000028aeb4: .sysdev_show+0x48/0x64
    sp: c0000005aa5dbb10
   msr: 8000000000009032
   dar: 68
 dsisr: 40000000
  current = 0xc0000003b7037800
  paca    = 0xc0000000005a8780
    pid   = 14382, comm = numastat

disassembly:

 c000000000293930  e9240000      ld      r9,0(r4)
c000000000293934  38840008      addi    r4,r4,8
c000000000293938  7c0607b4      extsw   r6,r0
c00000000029393c  2f86007f      cmpwi   cr7,r6,127
c000000000293940  e8e90068      ld      r7,104(r9) <----------- Null
Ptr in r9
c000000000293944  e8090040      ld      r0,64(r9)
c000000000293948  e9690048      ld      r11,72(r9)
c00000000029394c  e9490050      ld      r10,80(r9)
c000000000293950  e9090058      ld      r8,88(r9)
c000000000293954  e9290060      ld      r9,96(r9)
c000000000293958  7f7b0214      add     r27,r27,r0
c00000000029395c  7f5a5a14      add     r26,r26,r11
c000000000293960  7f9c3a14      add     r28,r28,r7
c000000000293964  7fff5214      add     r31,r31,r10

registers:

16:mon> r
R00 = 0000000000000002   R16 = 000000001009b360
R01 = c0000005aa5dbb10   R17 = 0000000000000001
R02 = c00000000077ad10   R18 = 0000000000000000
R03 = c000000b67459000   R19 = 0000000000000000
R04 = c000000f7ffd5cd0   R20 = 000000000000001a
R05 = 0000000000000000   R21 = 00000000101220d0
R06 = 0000000000000002   R22 = 000000001013fdd8
R07 = 000000000000161f   R23 = 0000000000001000
R08 = 0000000000001310   R24 = 0000000000000000
R09 = 0000000000000000   R25 = 0000000000001310
R10 = 0000000000000000   R26 = 0000000000000000
R11 = 0000000000000000   R27 = 000000000000161f
R12 = c000000f7ffd5c80   R28 = 000000000000161f
R13 = c0000000005a8780   R29 = 0000000000000000
R14 = 0000000000000000   R30 = c000000000637430
R15 = 0000000000000000   R31 = 0000000000000000
pc  = c000000000293940 .node_read_numastat+0x7c/0x114
lr  = c00000000028aeb4 .sysdev_show+0x48/0x64
msr = 8000000000009032   cr  = 44222488
ctr = c0000000002938c4   xer = 0000000000000010   trap =  300
dar = 0000000000000068   dsisr = 40000000

source code for the function, I believe r9 corresponds to 
the struct per_cpu_pageset *ps

static ssize_t node_read_numastat(struct sys_device * dev, char * buf)
{
        unsigned long numa_hit, numa_miss, interleave_hit,numa_foreign;
        unsigned long local_node, other_node;
        int i, cpu;
        pg_data_t *pg = NODE_DATA(dev->id);
        numa_hit = 0;
        numa_miss = 0;
        interleave_hit = 0;
        numa_foreign = 0;
        local_node = 0;
        other_node = 0;
        for (i = 0; i < MAX_NR_ZONES; i++) {
                struct zone *z = &pg->node_zones[i];
                for (cpu = 0; cpu < NR_CPUS; cpu++) {
                        struct per_cpu_pageset *ps = zone_pcp(z,cpu);
                        numa_hit += ps->numa_hit;
                        numa_miss += ps->numa_miss;
                        numa_foreign += ps->numa_foreign;
                        interleave_hit += ps->interleave_hit;
                        local_node += ps->local_node;
                        other_node += ps->other_node;
                }
        }
...

so the first attempt to dereference 'ps' causes an oops.

Anton B. says that if pg is non-NULL, ps should be non-NULL as well...

Sonny


