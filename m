Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWI2NMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWI2NMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 09:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWI2NMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 09:12:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:25216 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751284AbWI2NMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 09:12:38 -0400
Message-ID: <451D1BD4.9080307@cn.ibm.com>
Date: Fri, 29 Sep 2006 21:12:52 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
Reply-To: walkinair@cn.ibm.com
Organization: IBM
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.18 fall into xmon during cpu hotplug and oprofile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem description:
cpu hotplug oeration, with oprofile profile session enabled, trigger kernel
2.6.18 into xmon.

Hardware Environment
    Machine type (p650, x235, SF2, etc.): B70+
    Cpu type (Power4, Power5, IA-64, etc.): POWER5+
Software Environment
    Kernel: 2.6.18
    OS: RHEL5 Beta1

Additional information:

1:mon> e
cpu 0x1: Vector: 300 (Data Access) at [c0000001f05bf740]
    pc: c0000000001ab158: .spin_bug+0x8c/0x100
    lr: c0000000001ab138: .spin_bug+0x6c/0x100
    sp: c0000001f05bf9c0
   msr: 8000000000009032
   dar: 6b6b6b6b6b6b6ca7
 dsisr: 40000000
  current = 0xc0000002015846b0
  paca    = 0xc000000000444700
    pid   = 17129, comm = events/1
1:mon> t
[c0000001f05bfa50] c0000000001ab388 ._raw_spin_lock+0x40/0x17c
[c0000001f05bfae0] c000000000333980 ._spin_lock+0x10/0x24
[c0000001f05bfb60] c0000000000631c4 .get_task_mm+0x20/0x80
[c0000001f05bfbf0] d000000000a20eb8 .sync_buffer+0x168/0x4c0 [oprofile]
[c0000001f05bfcd0] d000000000a2091c .wq_sync_buffer+0x44/0x7c [oprofile]
[c0000001f05bfd50] c00000000007a50c .run_workqueue+0xdc/0x168
[c0000001f05bfdf0] c00000000007b278 .worker_thread+0x128/0x198
[c0000001f05bfee0] c00000000007fbd8 .kthread+0x128/0x178
[c0000001f05bff90] c000000000026e9c .kernel_thread+0x4c/0x68
1:mon> r
R00 = c0000000001ab138   R16 = 4000000001c00000
R01 = c0000001f05bf9c0   R17 = c000000000350da8
R02 = c00000000055ce00   R18 = 0000000000000000
R03 = 0000000000000034   R19 = 0000000000169400
R04 = 8000000000001032   R20 = 0000000000000001
R05 = 000000006b6b6b6b   R21 = 0000000000000038
R06 = 6b6b6b6b6b6b6e43   R22 = 0000000000000004
R07 = ffffffffffffffff   R23 = 0000000000000001
R08 = ffffffffffffffff   R24 = 0000000000000000
R09 = c000000000475e68   R25 = 0000000000000001
R10 = c000000000600f80   R26 = 0000000000000000
R11 = c000000000600f78   R27 = d000000000b55db0
R12 = 0000000000004000   R28 = c00000000036f908
R13 = c000000000444700   R29 = c000000002443af8
R14 = 0000000000000000   R30 = c0000000004a3600
R15 = c000000000352378   R31 = 6b6b6b6b6b6b6b6b
pc  = c0000000001ab158 .spin_bug+0x8c/0x100
lr  = c0000000001ab138 .spin_bug+0x6c/0x100
msr = 8000000000009032   cr  = 24000024
ctr = 80000000001af404   xer = 0000000000000002   trap =  300
dar = 6b6b6b6b6b6b6ca7   dsisr = 40000000
1:mon> di c0000000001ab158
c0000000001ab158  e8ff013e      lwa     r7,316(r31)
c0000000001ab15c  811d0008      lwz     r8,8(r29)
c0000000001ab160  e87e8030      ld      r3,-32720(r30)
c0000000001ab164  7fa4eb78      mr      r4,r29
c0000000001ab168  4beb9bcd      bl      c000000000064d34        # .printk+0x0/0x48
c0000000001ab16c  60000000      nop
c0000000001ab170  4be64c59      bl      c00000000000fdc8        #
.dump_stack+0x0/0xc
c0000000001ab174  60000000      nop
c0000000001ab178  48000034      b       c0000000001ab1ac        #
.spin_bug+0xe0/0x100
c0000000001ab17c  e92d01a0      ld      r9,416(r13)
c0000000001ab180  a0ad000a      lhz     r5,10(r13)
c0000000001ab184  7d635b78      mr      r3,r11
c0000000001ab188  7f84e378      mr      r4,r28
c0000000001ab18c  e8e9013e      lwa     r7,316(r9)
c0000000001ab190  38c902d8      addi    r6,r9,728
c0000000001ab194  4beb9ba1      bl      c000000000064d34        # .printk+0x0/0x48
1:mon> mi
Mem-info:
Node 0 DMA per-cpu:
cpu 1 hot: high 6, batch 1 used:0
cpu 1 cold: high 2, batch 1 used:0
cpu 2 hot: high 6, batch 1 used:0
cpu 2 cold: high 2, batch 1 used:0
Node 0 DMA32 per-cpu: empty
Node 0 Normal per-cpu: empty
Node 0 HighMem per-cpu: empty
Free pages:      333248kB (0kB HighMem)
Active:70502 inactive:45626 dirty:43 writeback:0 unstable:0 free:5207 slab:5269
mapped:766 pagetables:199
Node 0 DMA free:333248kB min:11648kB low:14528kB high:17472kB active:4512128kB
inactive:2920064kB present:8519680kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 DMA32 free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 HighMem free:0kB min:2048kB low:2048kB high:2048kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 3*64kB 8*128kB 1*256kB 0*512kB 0*1024kB 8*2048kB 5*4096kB 0*8192kB
18*16384kB = 333248kB
Node 0 DMA32: empty
Node 0 Normal: empty
Node 0 HighMem: empty
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 2096320kB
Total swap = 2096320kB
Free swap:       2096320kB
133120 pages of RAM
775 reserved pages
70064 pages shared
0 pages swap cached
1:mon>


