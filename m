Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWHOP0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWHOP0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbWHOP0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:26:21 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57540 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752103AbWHOP0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:26:20 -0400
Subject: 2.6.18-rc3->rc4 hugetlbfs regression
From: Dave Hansen <haveblue@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Cc: Yao Fei Zhu <zhuyaof@cn.ibm.com>, Suzuki Kp <suzukikp@in.ibm.com>,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, lge@us.ibm.com,
       PPC External List <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 08:22:24 -0700
Message-Id: <1155655344.12700.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel BUG in cache_free_debugcheck at mm/slab.c:2748!

This is from a ppc64 machine running 2.6.18-rc4.  It didn't apparently
happen with 2.6.18-rc3, but I don't see anything particularly suspect in
the changelogs, so it might be a wee bit more intermittent than it first
appeared.

You can get libhugetlbfs from here: http://libhugetlbfs.sourceforge.net/

Steps to reproduce:
1. boot kernel 2.6.18-rc4 with "hugepages=20"
2. mount none -t hugetlbfs /mnt/hugetlbfs
3. run libhugetlbfs, "make check" trigger xmon.

apple-lp1:/kernel/libhugetlbfs.git # make check
zero_filesize_segment (32):     obj32/zero_filesize_segment:
obj32/zero_filesize_segment: cannot execute binary file
zero_filesize_segment (64):     obj64/zero_filesize_segment:
obj64/zero_filesize_segment: cannot execute binary file
test_root (32): PASS
test_root (64): PASS
meminfo_nohuge (32):    PASS
meminfo_nohuge (64):    PASS
gethugepagesize (32):   PASS
gethugepagesize (64):   PASS
empty_mounts (32):      PASS
empty_mounts (64):      PASS
find_path (32): PASS
find_path (64): PASS
unlinked_fd (32):       PASS
unlinked_fd (64):       PASS
readback (32):  PASS


Additional info:
0:mon> e
cpu 0x0: Vector: 700 (Program Check) at [c0000001cf6e3530]
    pc: c0000000000c7458: .cache_free_debugcheck+0x1d0/0x2b0
    lr: c0000000000c7410: .cache_free_debugcheck+0x188/0x2b0
    sp: c0000001cf6e37b0
   msr: 8000000000021032
  current = 0xc0000001ccaf94e0
  paca    = 0xc000000000622300
    pid   = 6714, comm = readback
kernel BUG in cache_free_debugcheck at mm/slab.c:2748!

0:mon> t
[c0000001cf6e37b0] c0000000000c73cc .cache_free_debugcheck+0x144/0x2b0 (unreliable)
[c0000001cf6e3860] c0000000000c7a04 .kmem_cache_free+0xd8/0x164
[c0000001cf6e3900] c00000000002f630 .pgtable_free_tlb+0xd4/0x144
[c0000001cf6e39a0] c000000000032648 .hugetlb_free_pgd_range+0x1b8/0x26c
[c0000001cf6e3a70] c0000000000b4f68 .free_pgtables+0x90/0x134
[c0000001cf6e3b20] c0000000000b61ac .exit_mmap+0xcc/0x180
[c0000001cf6e3bd0] c00000000006209c .mmput+0x70/0x148
[c0000001cf6e3c60] c000000000067288 .exit_mm+0x118/0x138
[c0000001cf6e3cf0] c0000000000692c4 .do_exit+0x21c/0x958
[c0000001cf6e3da0] c000000000069aa8 .sys_exit_group+0x0/0x8
[c0000001cf6e3e30] c00000000000871c syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000feb0b78
SP (ffcc4090) is in userspace

0:mon> r
R00 = 000000000000018f   R16 = 00000000100a0000
R01 = c0000001cf6e37b0   R17 = 00000000100b2eb0
R02 = c000000000849ce0   R18 = 00000000100a0000
R03 = c0000001cfe90a08   R19 = 0000000000000000
R04 = c0000001cfe90a10   R20 = 0000000000000000
R05 = ffffffffffffffff   R21 = 00000000e0ffffff
R06 = 0000000000000000   R22 = c0000001cf6e3b90
R07 = c000000000648c38   R23 = 00000000e0ffffff
R08 = 000000000001ffff   R24 = 00000000e1000000
R09 = 0000000000000001   R25 = c00000000002f630
R10 = 0000000000000019   R26 = c0000001cfe90000
R11 = 0000000000000850   R27 = 0000000000000000
R12 = 0000000000000001   R28 = c0000001cfe90978
R13 = c000000000622300   R29 = 000000000000000e
R14 = 0000000010080000   R30 = c00000000065f098
R15 = 0000000000000000   R31 = c000000002b14380
pc  = c0000000000c7458 .cache_free_debugcheck+0x1d0/0x2b0
lr  = c0000000000c7410 .cache_free_debugcheck+0x188/0x2b0
msr = 8000000000021032   cr  = 44000424
ctr = 0000000000000001   xer = 000000002000001a   trap =  700

0:mon> di c0000000000c7458
c0000000000c7458  0b090000      tdnei   r9,0
c0000000000c745c  801f0118      lwz     r0,280(r31)
c0000000000c7460  7809bfe3      rldicl. r9,r0,55,63
c0000000000c7464  41820034      beq     c0000000000c7498        #
.cache_free_debugcheck+0x210/0x2b0
c0000000000c7468  e93f0148      ld      r9,328(r31)
c0000000000c746c  e87f01d2      lwa     r3,464(r31)
c0000000000c7470  7fe4fb78      mr      r4,r31
c0000000000c7474  38a00005      li      r5,5
c0000000000c7478  e9690000      ld      r11,0(r9)
c0000000000c747c  f8410028      std     r2,40(r1)
c0000000000c7480  7c7c1a14      add     r3,r28,r3
c0000000000c7484  7d6903a6      mtctr   r11
c0000000000c7488  e8490008      ld      r2,8(r9)
c0000000000c748c  e9690010      ld      r11,16(r9)
c0000000000c7490  4e800421      bctrl
c0000000000c7494  e8410028      ld      r2,40(r1)


The BUG() hit here :

               *dbg_redzone1(cachep, objp) = RED_INACTIVE;
                *dbg_redzone2(cachep, objp) = RED_INACTIVE;
        }
        if (cachep->flags & SLAB_STORE_USER)
                *dbg_userword(cachep, objp) = caller;

        objnr = obj_to_index(cachep, slabp, objp);

        BUG_ON(objnr >= cachep->num);
        BUG_ON(objp != index_to_obj(cachep, slabp, objnr)); <---- Hit here.

        if (cachep->flags & SLAB_DEBUG_INITIAL) {
                /*


-- Dave

