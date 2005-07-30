Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVG3FsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVG3FsW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 01:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVG3FsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 01:48:22 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:48325 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262940AbVG3FsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 01:48:18 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc4 use after free in class_device_attr_show
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jul 2005 15:47:39 +1000
Message-ID: <18189.1122702459@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13-rc4 + kdb, with lots of CONFIG_DEBUG options.  There is an
intermittent use after free in class_device_attr_show.  Reboot with no
changes and the problem does not always recur.

Starting SSH daemon                                                   done
Starting sound driver                                                 done
Starting cupsd                                                        done
loading ACPI modules () Starting powersaved                           done
Try to get initial date and time via NTP from  ntp0                   done
Starting network time protocol daemon (NTPD)                          done
Starting kernel based NFS server                                      done
Starting service automounter                                          done
udev[21369]: Oops 8813272891392 [1]

udev[21369]: Oops 8813272891392 [1]
Modules linked in: md5 ipv6 usbcore raid0 md_mod nls_iso8859_1 nls_cp437 dm_mod sg st osst

Pid: 21369, CPU 0, comm:                 udev
psr : 00001010081a6018 ifs : 8000000000000308 ip  : [<a0000001005807b0>]    Not tainted
ip is at class_device_attr_show+0x50/0xa0
unat: 0000000000000000 pfs : 0000000000000711 rsc : 0000000000000003
rnat: a000000100abbae0 bsps: 00000000000001fb pr  : 0000000000159659
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c0270033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010025def0 b6  : a00000010000e8c0 b7  : a000000100580760
f6  : 1003e6db6db6db6db6db7 f7  : 1003e0000000000c1d6ca
f8  : 1003e0000000000c1d6ca f9  : 1003e00000000054cdf86
f10 : 000000000000000000000 f11 : 000000000000000000000
r1  : a000000100ddf0a0 r2  : e000003072ab7288 r3  : e00000300301c498
r8  : 0000000000000000 r9  : a000000100bfb5d0 r10 : e000003075b28000
r11 : 0000000000c1d6ca r12 : e000003076ce7e20 r13 : e000003076ce0000
r14 : a000000100580760 r15 : e000003075b28000 r16 : 6db6db6db6db6db7
r17 : 000000002a66fc30 r18 : a0007fff62138000 r19 : e0000030030102c8
r20 : e000003003010000 r21 : fffffffffffefcf1 r22 : 0000000000000010
r23 : a000000100d46c50 r24 : a000000100bfb5d0 r25 : 00000000054cdf86
r26 : a0000001009968c8 r27 : e000003003015208 r28 : 0000000000000000
r29 : e000003003010000 r30 : a000000100d46c50 r31 : 0000000000000000

Call Trace:
 [<a000000100011f80>] show_stack+0x80/0xa0
                                sp=e000003076ce79c0 bsp=e000003076ce10d8
 [<a0000001000127f0>] show_regs+0x850/0x880
                                sp=e000003076ce7b90 bsp=e000003076ce1078
 [<a00000010003c000>] die+0x280/0x4a0
                                sp=e000003076ce7ba0 bsp=e000003076ce1028
 [<a000000100060ad0>] ia64_do_page_fault+0x650/0xba0
                                sp=e000003076ce7ba0 bsp=e000003076ce0fb8
 [<a00000010000b6c0>] ia64_leave_kernel+0x0/0x290
                                sp=e000003076ce7c50 bsp=e000003076ce0fb8
 [<a0000001005807b0>] class_device_attr_show+0x50/0xa0
                                sp=e000003076ce7e20 bsp=e000003076ce0f78
 [<a00000010025def0>] sysfs_read_file+0x2b0/0x360
                                sp=e000003076ce7e20 bsp=e000003076ce0f08
 [<a000000100198a40>] vfs_read+0x1c0/0x360
                                sp=e000003076ce7e20 bsp=e000003076ce0eb0
 [<a000000100198d80>] sys_read+0x80/0xe0
                                sp=e000003076ce7e20 bsp=e000003076ce0e38
 [<a00000010000b520>] ia64_ret_from_syscall+0x0/0x20
                                sp=e000003076ce7e30 bsp=e000003076ce0e38
kdb> id class_device_attr_show
0xa000000100580760 class_device_attr_show[MII]       alloc r36=ar.pfs,8,6,0
0xa000000100580766 class_device_attr_show+0x6            mov r8=r0;;
0xa00000010058076c class_device_attr_show+0xc            adds r2=24,r33

0xa000000100580770 class_device_attr_show+0x10[MMI]       mov r37=r1
0xa000000100580776 class_device_attr_show+0x16            mov r39=r34
0xa00000010058077c class_device_attr_show+0x1c            adds r38=-16,r32

0xa000000100580780 class_device_attr_show+0x20[MII]       nop.m 0x0
0xa000000100580786 class_device_attr_show+0x26            mov r35=b0;;
0xa00000010058078c class_device_attr_show+0x2c            mov.i ar.pfs=r36

0xa000000100580790 class_device_attr_show+0x30[MII]       ld8 r33=[r2]
0xa000000100580796 class_device_attr_show+0x36            mov b0=r35;;
0xa00000010058079c class_device_attr_show+0x3c            cmp.eq p8,p9=0,r33

0xa0000001005807a0 class_device_attr_show+0x40[MBB]       nop.m 0x0
0xa0000001005807a6 class_device_attr_show+0x46      (p09) br.cond.dpnt.few 0xa0000001005807b0 class_device_attr_show+0x50
0xa0000001005807ac class_device_attr_show+0x4c            br.ret.sptk.many b0

0xa0000001005807b0 class_device_attr_show+0x50[MMI]       ld8 r8=[r33],8;;
0xa0000001005807b6 class_device_attr_show+0x56            ld8 r1=[r33],-8
0xa0000001005807bc class_device_attr_show+0x5c            mov b7=r8

0xa0000001005807c0 class_device_attr_show+0x60[MIB]       nop.m 0x0
0xa0000001005807c6 class_device_attr_show+0x66            nop.i 0x0
0xa0000001005807cc class_device_attr_show+0x6c            br.call.sptk.many b0=b7;;

0xa0000001005807d0 class_device_attr_show+0x70[MII]       mov r1=r37
0xa0000001005807d6 class_device_attr_show+0x76            mov.i ar.pfs=r36
0xa0000001005807dc class_device_attr_show+0x7c            mov b0=r35

kdb> r s
 r32: e00000b4793c37e8  r33: 6b6b6b6b6b6b6b6b  r34: e000003075b28000
 r35: a00000010025def0  r36: 0000000000000711  r37: a000000100ddf0a0
 r38: e00000b4793c37d8  r39: e000003075b28000
kdb> mds 0xe000003072ab7288
0xe000003072ab7288 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003072ab7290 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003072ab7298 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003072ab72a0 6b6b6b6b6b6b6b6b   kkkkkkkk
0xe000003072ab72a8 a56b6b6b6b6b6b6b   kkkkkkk.
0xe000003072ab72b0 5a2cf071   q.,Z....
0xe000003072ab72b8 a000000100459640 linvfs_follow_link+0x1e0
0xe000003072ab72c0 5a2cf071   q.,Z....
[<a000000000010640>] __kernel_syscall_via_break+0x0/
                                sp=e000003076ce8000 bsp=e000003076ce0e38


