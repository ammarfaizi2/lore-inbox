Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUIOLGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUIOLGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 07:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIOLGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 07:06:23 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:25538 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264795AbUIOLFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 07:05:25 -0400
Message-ID: <414821E9.5030007@bull.net>
Date: Wed, 15 Sep 2004 13:05:13 +0200
From: Jacky Malcles <Jacky.Malcles@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: xavier.bru@bull.net
Subject: kernel BUG at fs/jbd/commit.c:760! 
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090806040702020303030108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090806040702020303030108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

has anyone seen similar behavior?

while in a loop running runalltests.sh from LTP (ltp-full-20040804) as
regression test on ia64 I get the following crashes:

kernel 2.6.7 (see attached detailed log)
-------
The kjournald daemon hits a bugcheck:
    Assertion failure in journal_commit_transaction() at fs/jbd/commit.c:760: 
"jh->b_next_transaction == ((void *)0)"
kernel BUG at fs/jbd/commit.c:760!
having a look with kdb, we see a process running at same time in 
journal_dirty_metadata():

kernel 2.6.9-rc2 (see attached detailed log)
----------
kjournald gets an invalid address in __journal_file_buffer() called from 
journal_commit_transaction(). Several processes are
waiting for locks in jbd. struct journal_head  looks corrupted.

regards,
-- 
  Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
  Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
  Tel : 04.76.29.73.14

--------------090806040702020303030108
Content-Type: text/plain;
 name="traces2.6.7"
Content-Disposition: inline;
 filename="traces2.6.7"
Content-Transfer-Encoding: 7bit

Assertion failure in journal_commit_transaction() at fs/jbd/commit.c:760: "jh->b_next_transaction == ((void *)0)"
kernel BUG at fs/jbd/commit.c:760!
kjournald[297]: bugcheck! 0 [1]
Modules linked in: md dm_mod button e100 sg usbhid ehci_hcd uhci_hcd usbcore ext3 jbd aic7xxx sd_mod scsi_mod

Pid: 297, CPU 1, comm:            kjournald
psr : 0000101008026018 ifs : 8000000000001025 ip  : [<a0000002001bab40>]    Tainted: GF
ip is at journal_commit_transaction+0x1b80/0x3600 [jbd]
unat: 0000000000000000 pfs : 0000000000001025 rsc : 0000000000000003
rnat: 0009804c8a70033f bsps: 00000000000bf2fd pr  : 0000000000006941
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000002001bab40 b6  : a000000100532c10 b7  : a000000100090e20
f6  : 1003e0fc0fc0fc0fc0fc1 f7  : 0ffdc8dc0000000000000
f8  : 1003e0000000000000243 f9  : 1003e00000000000024cc
f10 : 1003e000000000ebbb982 f11 : 1003e0000000036e2c316
r1  : a000000100a7ba80 r2  : 0000000000004000 r3  : 0000000000004000
r8  : 0000000000000023 r9  : 0000000000000000 r10 : 0000000000048e90
r11 : 00000000000048e9 r12 : e0000001fd61fb10 r13 : e0000001fd610000
r14 : 0000000000004000 r15 : a000000100707618 r16 : 00000000000000fd
r17 : 0000001008022018 r18 : 00000000000000fd r19 : 0000000000000004
r20 : e0000001fd61fad0 r21 : a00000010088dec0 r22 : a00000010087ce88
r23 : e0000001ff3910c4 r24 : e000002093d80040 r25 : e000002000015228
r26 : e000002000015220 r27 : e000002000015200 r28 : 0000000000000074
r29 : 0000000000000074 r30 : 0000000000000000 r31 : 0000000000000000

Call Trace:
 [<a000000100019080>] show_stack+0x80/0xa0
                                sp=e0000001fd61f6e0 bsp=e0000001fd611330
 [<a000000100046b00>] die+0x1a0/0x2c0
                                sp=e0000001fd61f8b0 bsp=e0000001fd6112f8
 [<a000000100046f50>] ia64_bad_break+0x2d0/0x400
                                sp=e0000001fd61f8b0 bsp=e0000001fd6112d0
 [<a000000100011f80>] ia64_leave_kernel+0x0/0x260
                                sp=e0000001fd61f940 bsp=e0000001fd6112d0
 [<a0000002001bab40>] journal_commit_transaction+0x1b80/0x3600 [jbd]
                                sp=e0000001fd61fb10 bsp=e0000001fd6111a0
 [<a0000002001c2d20>] kjournald+0x2a0/0x880 [jbd]
                                sp=e0000001fd61fd80 bsp=e0000001fd611128
 [<a00000010001aed0>] kernel_thread_helper+0xd0/0x100
                                sp=e0000001fd61fe30 bsp=e0000001fd611100
 [<a0000001000090a0>] start_kernel_thread+0x20/0x40
                                sp=e0000001fd61fe30 bsp=e0000001fd611100
LKCD not yet configured, can't take dump now

Entering kdb (current=0xe0000001fd610000, pid 297) on processor 1 Oops: <NULL>
due to oops @ 0xa0000002001bab40
 psr: 0x0000101008026018   ifs: 0x8000000000001025    ip: 0xa0000002001bab40
unat: 0x0000000000000000   pfs: 0x0000000000001025   rsc: 0x0000000000000003
rnat: 0x0009804c8a70033f  bsps: 0x00000000000bf2fd    pr: 0x0000000000006941
ldrs: 0x0000000000000000   ccv: 0x0000000000000000  fpsr: 0x0009804c8a70033f
  b0: 0xa0000002001bab40    b6: 0xa000000100532c10    b7: 0xa000000100090e20
  r1: 0xa000000100a7ba80    r2: 0x0000000000004000    r3: 0x0000000000004000
  r8: 0x0000000000000023    r9: 0x0000000000000000   r10: 0x0000000000048e90
 r11: 0x00000000000048e9   r12: 0xe0000001fd61fb10   r13: 0xe0000001fd610000
 r14: 0x0000000000004000   r15: 0xa000000100707618   r16: 0x00000000000000fd
 r17: 0x0000001008022018   r18: 0x00000000000000fd   r19: 0x0000000000000004
 r20: 0xe0000001fd61fad0   r21: 0xa00000010088dec0   r22: 0xa00000010087ce88
 r23: 0xe0000001ff3910c4   r24: 0xe000002093d80040   r25: 0xe000002000015228
 r26: 0xe000002000015220   r27: 0xe000002000015200   r28: 0x0000000000000074
 r29: 0x0000000000000074   r30: 0x0000000000000000   r31: 0x0000000000000000
&regs = e0000001fd61f950
[1]kdb> bt
Stack traceback for pid 297
0xe0000001fd610000      297        1  1    1   R  0xe0000001fd610680 *kjournald
0xa0000002001bab40 [jbd]journal_commit_transaction+0x1b80
        args (0xe0000001804d0b28, 0xe0000001fa5a9f80, 0xe0000001fbbea040, 0xe0000001fbbea030, 0xa0000002001d5c60)
0xa0000002001c2d20 [jbd]kjournald+0x2a0
        args (0xe0000001804d0b28, 0xe0000001804d0b4c, 0xe0000001804d0c9c, 0x0, 0xa0000002001d6040)
0xa00000010001aed0 kernel_thread_helper+0xd0
        args (0xa0000002001caff8, 0xe0000001804d0b28, 0xa0000001000090a0, 0x2, 0xa000000100a7ba80)
0xa0000001000090a0 start_kernel_thread+0x20
        args (0xa0000002001caff8, 0xe0000001804d0b28)
[1]kdb>
[1]kdb> ps R
Task Addr               Pid   Parent [*] cpu State Thread             Command
0xe0000001fd610000      297        1  1    1   R  0xe0000001fd610680 *kjournald
0xe000000185380000     7346     7343  1    3   R  0xe000000185380680  mkdir09
0xe000002093d80000     7384        1  1    4   R  0xe000002093d80680  klogd

0xe000000180520000        4        1  0    1   R  0xe000000180520680  migration/1
0xe0000001fd610000      297        1  1    1   R  0xe0000001fd610680 *kjournald
0xe000000185380000     7346     7343  1    3   R  0xe000000185380680  mkdir09
0xe000002093d80000     7384        1  1    4   R  0xe000002093d80680  klogd
[1]kdb> btp 7346
Stack traceback for pid 7346
0xe000000185380000     7346     7343  1    3   R  0xe000000185380680  mkdir09
0xa0000002001b4f30 [jbd]journal_dirty_metadata+0x130
        args (0xe0000001f0c849c8, 0xe0000001fa5a9f80, 0xe0000001ff756628, 0xe0000001fbbea030, 0xe0000001804d0b28)
0xa00000020031d0d0 [ext3]ext3_getblk+0x2f0
        args (0xe0000001f0c849c8, 0xe0000001de05bfc0, 0x0, 0xa0000002003481d8, 0xe00000018538fdc0)
0xa00000020031d3c0 [ext3]ext3_bread+0x40
        args (0xe0000001f0c849c8, 0xe0000001de05bec8, 0x0, 0x1, 0xe00000018538fdc0)
0xa00000020032b590 [ext3]ext3_mkdir+0x1f0
        args (0xe00000019763c4c8, 0xe0000020a6683ff8, 0xe0000001de05bec8, 0xe0000001f0c849c8, 0xa0000002003534d0)
0xa000000100154b30 vfs_mkdir+0x1d0
        args (0xe00000019763c4c8, 0xe0000020a6683ff8, 0xe00000019763c6b8, 0xa000000200353a40, 0xa000000100154ea0)
0xa000000100154ea0 sys_mkdir+0x2e0
        args (0x600ffffffffec2b0, 0xff8, 0x2, 0x0, 0x2000000000260200)
0xa000000100011e00 ia64_ret_from_syscall
        args (0x600ffffffffec2b0, 0xff8, 0x2, 0x0, 0x2000000000260200)
[1]kdb>
--------------090806040702020303030108
Content-Type: text/plain;
 name="traces2.6.9-rc2"
Content-Disposition: inline;
 filename="traces2.6.9-rc2"
Content-Transfer-Encoding: 8bit

<1>Unable to handle kernel paging request at virtual address 5b5b5b5b5b5b5b8b
<4>kjournald[761]: Oops 11003706212352 [1]
<4>Modules linked in: md dm_mod button sg usbhid uhci_hcd usbcore
<4>
<4>Pid: 761, CPU 2, comm:            kjournald
<4>psr : 0000121008026018 ifs : 8000000000000590 ip  : [<a0000001002404c1>]    Not tainted
<4>ip is at __journal_file_buffer+0x481/0x6a0
[2]more>
<4>unat: 0000000000000000 pfs : 0000000000001229 rsc : 0000000000000003
<4>rnat: 0000000000000000 bsps: 0000000000000000 pr  : 000000000000a541
<4>ldrs: 0000000000000000 ccv : 000000000008a01d fpsr: 0009804c8a70433f
<4>csd : 0000000000000000 ssd : 0000000000000000
<4>b0  : a000000100240440 b6  : a0000001006fd4c0 b7  : a000000100462940
<4>f6  : 1003e0000000000000000 f7  : 0ffdd8000000000000000
<4>f8  : 1003e0000000000000000 f9  : 1003e0000000000000005
<4>f10 : 1003e000000000001c1b0 f11 : 1003e00000000000c4bd0
<4>r1  : a000000100c9e3a0 r2  : 000000000008a01d r3  : 000000000008a01d
<4>r8  : 0000000000000001 r9  : 0000000000000000 r10 : ffffffffffaba650
<4>r11 : a000000100785df0 r12 : e00000018198fb10 r13 : e000000181980000
<4>r14 : 0000000000000000 r15 : a000000100785db0 r16 : 0000000000000040
<4>r17 : 0000000000040000 r18 : e00000006258bfd0 r19 : e00000004af096e8
<4>r20 : e00000004af09718 r21 : e0000001cb3313f0 r22 : 000000000008a01d
<4>r23 : 0000000000000000 r24 : e0000001fe4a9c00 r25 : e0000001fe4a82a0
<4>r26 : 0000000000000009 r27 : 0000000000000000 r28 : a00000010023ff90
<4>r29 : ffffffffffaba238 r30 : a000000100785d58 r31 : 0000000000000008
<4>
<4>Call Trace:
<4> [<a000000100018f00>] show_stack+0x80/0xa0
<4>                                sp=e00000018198f6a0 bsp=e000000181981138
<4> [<a00000010003a790>] die+0x150/0x1e0
<4>                                sp=e00000018198f870 bsp=e0000001819810f8
[2]more><4> [<a000000100058760>] ia64_do_page_fault+0x720/0xa60
<4>                                sp=e00000018198f870 bsp=e000000181981090
<4> [<a000000100010480>] ia64_leave_kernel+0x0/0x260
<4>                                sp=e00000018198f940 bsp=e000000181981090
<4> [<a0000001002404c0>] __journal_file_buffer+0x480/0x6a0
<4>                                sp=e00000018198fb10 bsp=e000000181981010
<4> [<a000000100247bc0>] journal_commit_transaction+0xba0/0x3520
<4>                                sp=e00000018198fb10 bsp=e000000181980ee8
<4> [<a000000100256550>] kjournald+0x1d0/0x7a0
<4>                                sp=e00000018198fd80 bsp=e000000181980e78
<4> [<a0000001000177e0>] kernel_thread_helper+0xe0/0x100
<4>                                sp=e00000018198fe30 bsp=e000000181980e50
<4> [<a000000100009060>] start_kernel_thread+0x20/0x40
<4>                                sp=e00000018198fe30 bsp=e000000181980e50
[2]kdb> bt
Stack traceback for pid 761
0xe000000181980000      761        1  1    2   R  0xe0000001819803f0 *kjournald
0xa0000001002404c0 __journal_file_buffer+0x480
        args (0xe00000006258c448, 0xe000000181632680, 0x8, 0xe0000001ccec55f0, 0xa000000100240440)
0xa000000100247bc0 journal_commit_transaction+0xba0
        args (0xe0000001ffeb4f80, 0xe0000001ccec55f0, 0xe00000006258c448, 0x0, 0xa000000100aad918)
0xa000000100256550 kjournald+0x1d0
        args (0xe0000001ffeb4f80, 0xe0000001ffeb4fa4, 0xa000000100ab8368, 0xa000000100ab0118, 0xe0000001ffeb50f4)
0xa0000001000177e0 kernel_thread_helper+0xe0
        args (0xa000000100819310, 0xe0000001ffeb4f80, 0xa000000100009060, 0x2, 0xa000000100c9e3a0)
0xa000000100009060 start_kernel_thread+0x20
        args (0xa000000100819310, 0xe0000001ffeb4f80)
[2]kdb>
[2]kdb> md 0xe00000006258c448
0xe00000006258c448 ccec55f0 e0000001 00000000 00000008   ðUìÌ...à........
0xe00000006258c458 00000000 00000000 00000000 00000000   ................
0xe00000006258c468 81632680 e0000001 00000000 00000000   .&c....à........
0xe00000006258c478 6258bfd0 e0000000 5b5b5b5b 5b5b5b5b   Ð¿Xb...à[[[[[[[[ <<<---
0xe00000006258c488 00000000 00000000 00000000 00000000   ................
0xe00000006258c498 00000000 00000000 5b5b5b5b 5b5b5b5b   ........[[[[[[[[
0xe00000006258c4a8 5b5b5b5b 5b5b5b5b 5b5b5b5b 5b5b5b5b   [[[[[[[[[[[[[[[[
0xe00000006258c4b8 5b5b5b5b 5b5b5b5b 5b5b5b5b 5b5b5b5b   [[[[[[[[[[[[[[[[
[2]kdb>
[2]kdb> ps R
Task Addr               Pid   Parent [*] cpu State Thread             Command
0xe0000001b0b50000     5144    29815  1    0   R  0xe0000001b0b503f0  growfiles
0xe000000195b60000     5254     5251  1    1   R  0xe000000195b603f0  mkdir09
0xe000000181980000      761        1  1    2   R  0xe0000001819803f0 *kjournald

0xe000000180c10000       69        8  0    2   R  0xe000000180c103f0  kblockd/2
0xe000000181980000      761        1  1    2   R  0xe0000001819803f0 *kjournald
0xe0000001f7ec0000     2565        1  0    2   R  0xe0000001f7ec03f0  klogd
0xe0000001b0b50000     5144    29815  1    0   R  0xe0000001b0b503f0  growfiles
0xe0000001915e0000     5234     6820  0    2   R  0xe0000001915e03f0  mkdir09
0xe0000001ca150000     5239     5234  0    1   R  0xe0000001ca1503f0  mkdir09
0xe0000001cf3b0000     5240     5234  0    2   R  0xe0000001cf3b03f0  mkdir09
0xe00000019e620000     5252     5251  0    1   R  0xe00000019e6203f0  mkdir09
0xe0000001b1bc0000     5253     5251  0    0   R  0xe0000001b1bc03f0  mkdir09
0xe000000195b60000     5254     5251  1    1   R  0xe000000195b603f0  mkdir09
0xe0000001d1040000     5255     5251  0    0   R  0xe0000001d10403f0  mkdir09
0xe0000001ec900000     5256     5251  0    1   R  0xe0000001ec9003f0  mkdir09
[2]kdb> btp 5239
Stack traceback for pid 5239
0xe0000001ca150000     5239     5234  0    1   R  0xe0000001ca1503f0  mkdir09
0xa0000001006fbab0 schedule+0xb30
        args (0xe0000001fbd752f8, 0x1008026018, 0xe0000001ca15fdf8, 0x0, 0xe0000001ca15fdf0)
0xa0000001006fa8c0 __down+0x180
        args (0xe0000001fbd752f0, 0x1008026018, 0xe0000001fbd752f4, 0xe0000001fbd752f8, 0xe0000001ca150000)
0xa0000001001455b0 sys_rmdir+0x150
        args (0x600ffffffffed2b0, 0x400000000000da18, 0x4, 0x2, 0x2c8)
0xa000000100010300 ia64_ret_from_syscall
        args (0x600ffffffffed2b0, 0x400000000000da18, 0x4, 0x2, 0x2c8)
[2]kdb> btp 5240
Stack traceback for pid 5240
0xe0000001cf3b0000     5240     5234  0    2   R  0xe0000001cf3b03f0  mkdir09
0xa0000001006fbab0 schedule+0xb30
        args (0xe0000001ffeb4fa4, 0x16b65, 0xe0000001ffeb50f4, 0xa000000100246670, 0x815)
0xa000000100246690 start_this_handle+0x970
        args (0xe0000001ffeb4f80, 0xe00000019f911c98, 0xe0000001ffeb4fe8, 0xe000000181632680, 0xe000000181632688)
0xa000000100246e60 journal_start+0x200
        args (0xe0000001ffeb4f80, 0x5d, 0xe00000019f911c98, 0xa000000100ab8370, 0xa0000001002383d0)
0xa0000001002383d0 ext3_journal_start+0xf0
        args (0xe0000001fbd75240, 0x5d, 0xa00000010022e3d0, 0x692, 0x308)
0xa00000010022e3d0 ext3_mkdir+0x70
        args (0xe0000001fbd75240, 0xe0000001f13b6d48, 0x3e8, 0xa00000010013d9b0, 0x38a)
0xa00000010013db10 vfs_mkdir+0x1d0
        args (0xe0000001fbd75240, 0xe0000001f13b6d48, 0xe0000001fbd75420, 0xe0000001fbd75328, 0xa0000001001458b0)
0xa00000010
[2]kdb> btp 5253
Stack traceback for pid 5253
0xe0000001b1bc0000     5253     5251  0    0   R  0xe0000001b1bc03f0  mkdir09
0xa0000001006fbab0 schedule+0xb30
        args (0xe0000001f84aa470, 0x1008026018, 0xe0000001b1bcfdf8, 0x0, 0xe0000001b1bcfdf0)
0xa0000001006fa8c0 __down+0x180
        args (0xe0000001f84aa468, 0x1008026018, 0xe0000001f84aa46c, 0xe0000001f84aa470, 0xe0000001b1bc0000)
0xa0000001001455b0 sys_rmdir+0x150
        args (0x600ffffffffed2b0, 0x400000000000da18, 0x4, 0x2, 0x0)
0xa000000100010300 ia64_ret_from_syscall
        args (0x600ffffffffed2b0, 0x400000000000da18, 0x4, 0x2, 0x0)
[2]kdb> btp 5254
Stack traceback for pid 5254
0xe000000195b60000     5254     5251  1    1   R  0xe000000195b603f0  mkdir09
0xa0000001000090b0 ia64_spinlock_contention+0x30
        r31 (spinlock address) 0xe0000001ffeb50dc
0xa0000001006fd4c0 _spin_lock+0x40
        args (0xe0000001ffeb50dc)
0xa000000100245130 journal_get_create_access+0x230
        args (0xe00000019f912628, 0xe0000001d579e5a0, 0xe000000023422ec0, 0xe00000018163f380, 0xe0000001ffeb4f80)
0xa000000100225d90 ext3_getblk+0x250
        args (0xe00000019f912628, 0xe0000001f80b0ba0, 0x30011, 0xa000000100785470, 0xe000000195b6fdc0)
0xa000000100226020 ext3_bread+0x40
        args (0xe00000019f912628, 0xe0000001f80b0aa8, 0x0, 0x1, 0xe000000195b6fdc0)
0xa00000010022e490 ext3_mkdir+0x130
        args (0xe0000001f84aa3b8, 0xe0000001e8e64820, 0x3e8, 0xe0000001f80b0aa8, 0xe00000019f912628)
0xa00000010013db10 vfs_mkdir+0x1d0
        args (0xe0000001f84aa3b8, 0xe0000001e8e64820, 0xe0000001f84aa598, 0xe0000001f84aa4a0, 0xa0000001001458b0)
0xa0000001001458b0 sys_mkdir+0x170
        args (0x600ffffffffec2b0, 0xff8, 0x2, 0x0, 0x2000000000260200)
0xa000000100010300 ia64_ret_from_syscall
        args (0x600ffffffffec2b0, 0xff8, 0x2, 0x0, 0x2000000000260200)
[2]kdb> btp 5255
Stack traceback for pid 5255
0xe0000001d1040000     5255     5251  0    0   R  0xe0000001d10403f0  mkdir09
0xa0000001006fbab0 schedule+0xb30
        args (0xe0000001f84aa470, 0x1008026018, 0xa000000100143590, 0x38a, 0xa000000100c9e3a0)
0xa0000001006fa8c0 __down+0x180
        args (0xe0000001f84aa468, 0x1008026018, 0xe0000001f84aa46c, 0xe0000001f84aa470, 0xe0000001d1040000)
0xa00000010013fc80 lookup_create+0x60
        args (0xe0000001d104fdd0, 0x1, 0xa000000100145800, 0x813, 0xa0000001001457e0)
0xa000000100145800 sys_mkdir+0xc0
        args (0x600ffffffffed2b0, 0xff8, 0x3, 0x11, 0x20000000002c2f18)
0xa000000100010300 ia64_ret_from_syscall
        args (0x600ffffffffed2b0, 0xff8, 0x3, 0x11, 0x20000000002c2f18)
[2]kdb> btp 5256
Stack traceback for pid 5256
0xe0000001ec900000     5256     5251  0    1   R  0xe0000001ec9003f0  mkdir09
0xa0000001006fbab0 schedule+0xb30
        args (0xe0000001f84aa470, 0x1008026018, 0xe0000001ec90fdf8, 0x0, 0xe0000001ec90fdf0)
0xa0000001006fa8c0 __down+0x180
        args (0xe0000001f84aa468, 0x1008026018, 0xe0000001f84aa46c, 0xe0000001f84aa470, 0xe0000001ec900000)
0xa0000001001455b0 sys_rmdir+0x150
        args (0x600ffffffffed2b0, 0x400000000000da18, 0x4, 0x2, 0x0)
0xa000000100010300 ia64_ret_from_syscall
        args (0x600ffffffffed2b0, 0x400000000000da18, 0x4, 0x2, 0x0)
[2]kdb>

--------------090806040702020303030108--
