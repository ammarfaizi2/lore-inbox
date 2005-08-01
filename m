Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVHAMOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVHAMOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 08:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVHAMOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 08:14:20 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:22470 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261731AbVHAMOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 08:14:17 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show
In-reply-to: Your message of "Sat, 30 Jul 2005 02:29:55 MST."
             <20050730022955.6c7dd2e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Aug 2005 22:14:05 +1000
Message-ID: <8551.1122898445@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005 02:29:55 -0700,
Andrew Morton <akpm@osdl.org> wrote:
>Keith Owens <kaos@sgi.com> wrote:
>>
>> 2.6.13-rc4 + kdb, with lots of CONFIG_DEBUG options.  There is an
>>  intermittent use after free in class_device_attr_show.  Reboot with no
>>  changes and the problem does not always recur.
>> ...
>>  ip is at class_device_attr_show+0x50/0xa0
>> ...
>
>It might help to know which file is being read from here.
>
>The below patch will record the name of the most-recently-opened sysfs
>file.  You can print last_sysfs_file[] in the debugger or add the
>appropriate printk to the ia64 code?

No need for a patch.  It is /dev/vcsa2.

kdb> bt
Stack traceback for pid 23066
0xe00000301abf8000    23066    23051  1    0   R  0xe00000301abf8300 *udev
0xa00000010057f850 class_device_attr_show+0x50
        args (0xe00000b006abb900, 0x6b6b6b6b6b6b6b6b, 0xe0000030186d4000, 0xa00000010025cf90, 0x711)
0xa00000010025cf90 sysfs_read_file+0x2b0
        args (0xe000003073917110, 0x6000000000058210, 0x4000, 0xe00000301abffe38, 0xe00000307a98d668)
0xa000000100197ae0 vfs_read+0x1c0
        args (0xe00000301b2ba8d0, 0x6000000000058210, 0x4000, 0xe00000301abffe38, 0xe00000301b2ba8f0)
0xa000000100197e20 sys_read+0x80
        args (0x6, 0x6000000000058210, 0x4000, 0x280, 0x0)
0xa00000010000b520 ia64_ret_from_syscall
        args (0x6, 0x6000000000058210, 0x4000)
0xa000000000010640 __kernel_syscall_via_break
        args (0x6, 0x6000000000058210, 0x4000)

kdb> r
 psr: 0x00001010081a6018   ifs: 0x8000000000000308    ip: 0xa00000010057f850
unat: 0x0000000000000000   pfs: 0x0000000000000711   rsc: 0x0000000000000003
rnat: 0xa000000100abbb40  bsps: 0x000000000000036a    pr: 0x0000000000159659
ldrs: 0x0000000000000000   ccv: 0x0000000000000000  fpsr: 0x0009804c0270033f
  b0: 0xa00000010025cf90    b6: 0xa00000010000e8c0    b7: 0xa00000010057f800
  r1: 0xa000000100ddf690    r2: 0xe000003073917128    r3: 0xe000003003018498
  r8: 0x0000000000000000    r9: 0xa000000100bfbbe8   r10: 0xe0000030186d4000
 r11: 0x0000000000c061b5   r12: 0xe00000301abffe20   r13: 0xe00000301abf8000
 r14: 0xa00000010057f800   r15: 0xe0000030186d4000   r16: 0x6db6db6db6db6db7
 r17: 0x000000002a155f98   r18: 0xa0007fff62138000   r19: 0xe0000030030102c8
 r20: 0xe000003003010000   r21: 0xfffffffffffefcf1   r22: 0x0000000000000010
 r23: 0xa000000100d3f1a0   r24: 0xa000000100bfbbe8   r25: 0x000000000542abf3
 r26: 0xa000000100995718   r27: 0xe000003003015208   r28: 0x0000000000000000
 r29: 0xe000003003010000   r30: 0xa000000100d3f1a0   r31: 0x0000000000000000
&regs = e00000301abffc60

kdb> r s
 r32: e00000b006abb900  r33: 6b6b6b6b6b6b6b6b  r34: e0000030186d4000
 r35: a00000010025cf90  r36: 0000000000000711  r37: a000000100ddf690
 r38: e00000b006abb8f0  r39: e0000030186d4000

kdb> filp 0xe00000301b2ba8d0
name.name 0xe00000301aced384  name.len  3
File Pointer at 0xe00000301b2ba8d0
 f_list.nxt = 0xe00000301b2bb9e0 f_list.prv = 0xe000003003e5aeb8
 f_dentry = 0xe00000301aced2a0 f_op = 0xa000000100a615c8
 f_count = 1 f_flags = 0x8000 f_mode = 0xd
 f_pos = 0

kdb> dentry 0xe00000301aced2a0
Dentry at 0xe00000301aced2a0
 d_name.len = 3 d_name.name = 0xe00000301aced384 <dev>
 d_count = 1 d_flags = 0x18 d_inode = 0xe00000b4796a87c8
 d_parent = 0xe00000b0044a6020
 d_hash.nxt = 0x0000000000000000 d_hash.prv = 0x0000000000200200
 d_lru.nxt = 0xe00000301aced2f8 d_lru.prv = 0xe00000301aced2f8
 d_child.nxt = 0xe00000b0044a6098 d_child.prv = 0xe00000b0044a6098
 d_subdirs.nxt = 0xe00000301aced318 d_subdirs.prv = 0xe00000301aced318
 d_alias.nxt = 0xe00000b4796a87f8 d_alias.prv = 0xe00000b4796a87f8
 d_op = 0xa000000100a61870 d_sb = 0xe000003003e5ad58

kdb> inode 0xe00000b4796a87c8
struct inode at  0xe00000b4796a87c8
 i_ino = 33036 i_count = 1 i_size 16384
 i_mode = 0100444  i_nlink = 0  i_rdev = 0x0
 i_hash.nxt = 0x0000000000000000 i_hash.pprev = 0x0000000000000000
 i_list.nxt = 0xe00000301b10d2f0 i_list.prv = 0xe00000b474f1bb50
 i_dentry.nxt = 0xe00000301aced2a0 i_dentry.prv = 0xe00000301aced2a0
 i_sb = 0xe000003003e5ad58 i_op = 0xa000000100a61488 i_data = 0xe00000b4796a8970 nrpages = 0
 i_fop= 0xa000000100a615c8 i_flock = 0x0000000000000000 i_mapping = 0xe00000b4796a8970
 i_flags 0x0 i_state 0x0 []  fs specific info @ 0xe00000b4796a8b20

kdb> kobject 0xe00000b006abb900
kobject at 0xe00000b006abb900
 k_name 0xe00000b006abb908 'vcsa2'
 kref.refcount 1'
 entry.next = 0xe00000b006abb920 entry.prev = 0xe00000b006abb920
 parent = 0xe00000347b877528 kset = 0xa000000100abba30 ktype = 0x0000000000000000 dentry = 0xe00000b0044a6020

The attr is passed to class_device_attr_show in r33 but gcc has reused
that register by the time of the oops.

kdb> id class_device_attr_show
0xa00000010057f800 class_device_attr_show[MII]       alloc r36=ar.pfs,8,6,0
0xa00000010057f806 class_device_attr_show+0x6            mov r8=r0;;
0xa00000010057f80c class_device_attr_show+0xc            adds r2=24,r33

0xa00000010057f810 class_device_attr_show+0x10[MMI]       mov r37=r1
0xa00000010057f816 class_device_attr_show+0x16            mov r39=r34
0xa00000010057f81c class_device_attr_show+0x1c            adds r38=-16,r32

0xa00000010057f820 class_device_attr_show+0x20[MII]       nop.m 0x0
0xa00000010057f826 class_device_attr_show+0x26            mov r35=b0;;
0xa00000010057f82c class_device_attr_show+0x2c            mov.i ar.pfs=r36

0xa00000010057f830 class_device_attr_show+0x30[MII]       ld8 r33=[r2]
0xa00000010057f836 class_device_attr_show+0x36            mov b0=r35;;
0xa00000010057f83c class_device_attr_show+0x3c            cmp.eq p8,p9=0,r33

0xa00000010057f840 class_device_attr_show+0x40[MBB]       nop.m 0x0
0xa00000010057f846 class_device_attr_show+0x46      (p09) br.cond.dpnt.few 0xa00000010057f850 class_device_attr_show+0x50
0xa00000010057f84c class_device_attr_show+0x4c            br.ret.sptk.many b0

0xa00000010057f850 class_device_attr_show+0x50[MMI]       ld8 r8=[r33],8;;
0xa00000010057f856 class_device_attr_show+0x56            ld8 r1=[r33],-8
0xa00000010057f85c class_device_attr_show+0x5c            mov b7=r8

r2 contains the original r33+24, so attr is

kdb> mds %r2-24
0xe000003073917110 1000000001   ........
0xe000003073917118 7270000100000100   ......pr
0xe000003073917120 72742f6574617669   ivate/tr
0xe000003073917128 5a5a5a5a00656361   ace.ZZZZ
0xe000003073917130 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe000003073917138 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe000003073917140 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe000003073917148 a55a5a5a5a5a5a5a   ZZZZZZZ.

This does not match the contents of r33.  class_device_attr_show() is
being passed the address of freed memory which has been reused by the
time of the oops.

dentry->d_fsdata is at e000003472e22640.

kdb> mds e000003472e22640
0xe000003472e22640 00000001   ........					count
0xe000003472e22648 e000003472e22648   H&.r4...				s_sibling
0xe000003472e22650 e000003472e22648   H&.r4...
0xe000003472e22658 e000003472e22658   X&.r4...				s_children
0xe000003472e22660 e000003472e22658   X&.r4...
0xe000003472e22668 e000003073917110   .q.s0...				s_element
0xe000003472e22670 812400000004   ....$...				s_type, s_mode
0xe000003472e22678 e00000301aced2a0   ....0...				s_dentry
0xe000003472e22680 00000000   ........					s_iattr

s_element contains e000003073917110.  This matches the attr passed to
class_device_attr_show, which contains bad data.

BTW, ps shows lots of udev and hotplug related processes.  Race between
bits of udev?

      5 automount
      2 blogd
      1 cupsd
     51 generic_udev.ag
    175 hotplug
      1 init
      1 klogd
    124 logger
      1 master
      1 ntpd
      1 pickup
      1 pidof
      1 pmcd
      1 pmdasample
      1 pmdasimple
      1 pmdaweblog
      1 portmap
      1 postconf
      1 powersaved
      1 qmgr
      1 rc
      1 rpc.mountd
      2 S13kbd
      3 S13postfix
      4 salinfo_decode
      4 salinfo_decode_
      1 sed
     75 sleep
      1 sshd
      2 startpar
      1 syslogd
     24 udev

