Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVGTFfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVGTFfK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 01:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVGTFfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 01:35:10 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:11155 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261171AbVGTFfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 01:35:08 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3 udev/hotplug use memory after free
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Jul 2005 15:35:04 +1000
Message-ID: <7304.1121837704@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13-rc3 + kdb (which does not touch udev/hotplug) on IA64 (Altix).
gcc version 3.3.3 (SuSE Linux).  Compiled with DEBUG_SLAB,
DEBUG_PREEMPT, DEBUG_SPINLOCK, DEBUG_SPINLOCK_SLEEP, DEBUG_KOBJECT.

There is a use after free somewhere above class_device_attr_show.

<7>fill_kobj_path: path = '/class/vc/vcs13'
<7>kobject_hotplug: /sbin/hotplug vc seq=1377 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs13 SUBSYSTEM=vc
<7>kobject vcs13: cleaning up
<7>kobject_hotplug
<7>fill_kobj_path: path = '/class/vc/vcsa13'
<1>Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b6b6b
<4>udev[13708]: Oops 8813272891392 [1]
<7>kobject_hotplug: /sbin/hotplug vc seq=1378 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa13 SUBSYSTEM=vc
<4>Modules linked in: md5 ipv6 usbcore raid0 md_mod nls_iso8859_1 nls_cp437 dm_mod sg st osst
<4>
<4>Pid: 13708, CPU 0, comm:                 udev
<4>psr : 0000101008126038 ifs : 8000000000000308 ip  : [<a0000001004c8ed0>]    Not tainted
<4>ip is at class_device_attr_show+0x50/0xa0

The offending code is

[0]kdb> id class_device_attr_show
0xa0000001004c8e80 class_device_attr_show[MII]       alloc r36=ar.pfs,8,6,0
0xa0000001004c8e86 class_device_attr_show+0x6            mov r8=r0;;
0xa0000001004c8e8c class_device_attr_show+0xc            adds r2=24,r33

0xa0000001004c8e90 class_device_attr_show+0x10[MMI]       mov r37=r1
0xa0000001004c8e96 class_device_attr_show+0x16            mov r39=r34
0xa0000001004c8e9c class_device_attr_show+0x1c            adds r38=-16,r32

0xa0000001004c8ea0 class_device_attr_show+0x20[MII]       nop.m 0x0
0xa0000001004c8ea6 class_device_attr_show+0x26            mov r35=b0;;
0xa0000001004c8eac class_device_attr_show+0x2c            mov.i ar.pfs=r36

0xa0000001004c8eb0 class_device_attr_show+0x30[MII]       ld8 r33=[r2]
0xa0000001004c8eb6 class_device_attr_show+0x36            mov b0=r35;;
0xa0000001004c8ebc class_device_attr_show+0x3c            cmp.eq p8,p9=0,r33

0xa0000001004c8ec0 class_device_attr_show+0x40[MBB]       nop.m 0x0
0xa0000001004c8ec6 class_device_attr_show+0x46      (p09) br.cond.dpnt.few 0xa0000001004c8ed0 class_device_attr_show+0x50
0xa0000001004c8ecc class_device_attr_show+0x4c            br.ret.sptk.many b0

0xa0000001004c8ed0 class_device_attr_show+0x50[MMI]       ld8 r8=[r33],8;;
0xa0000001004c8ed6 class_device_attr_show+0x56            ld8 r1=[r33],-8
0xa0000001004c8edc class_device_attr_show+0x5c            mov b7=r8

At the oops, r33 has been loaded from [r2], r33 contains
0x6b6b6b6b6b6b6b6b.  IOW, use after free.

[0]kdb> r
 psr: 0x0000101008126038   ifs: 0x8000000000000308    ip: 0xa0000001004c8ed0
unat: 0x0000000000000000   pfs: 0x0000000000000711   rsc: 0x0000000000000003
rnat: 0xe00000b47a429e78  bsps: 0xe00000b00bf5d320    pr: 0x0000000000155659
ldrs: 0x0000000000000000   ccv: 0x0000000000000000  fpsr: 0x0009804c0270033f
  b0: 0xa0000001001fc830    b6: 0xa00000010000f4e0    b7: 0xa0000001004c8e80
  r1: 0xa000000100d31900    r2: 0xe000003473de5080    r3: 0xe000003008f78da4
  r8: 0x0000000000000000    r9: 0xa000000100b4b818   r10: 0xe00000b077270000
 r11: 0x0000000002c1dc9c   r12: 0xe000003008f7fe20   r13: 0xe000003008f78000
 r14: 0xa0000001004c8e80   r15: 0xe00000b077270000   r16: 0x6db6db6db6db6db7
 r17: 0x000000009a684220   r18: 0xa0007fff62138000   r19: 0xe00000b003031318
 r20: 0xe00000b003030080   r21: 0x0000000000000001   r22: 0xa000000100b4b818
 r23: 0xa000000100d23100   r24: 0x00000000134d0844   r25: 0x000000009a684220
 r26: 0xa0000001008732d8   r27: 0xe000003004fe8188   r28: 0xe00000b003030080
 r29: 0xa000000100d23120   r30: 0x0000000000000004   r31: 0x0100000000000000

[0]kdb> r s
 r32: e0000034714fbb30  r33: 6b6b6b6b6b6b6b6b  r34: e00000b077270000
 r35: a0000001001fc830  r36: 0000000000000711  r37: a000000100d31900
 r38: e0000034714fbb20  r39: e00000b077270000

Dumping where r2 points, the area has been reused by the time that the
oops occurred.  Again, use after free.

[0]kdb> mds 0xe000003473de5080-24
0xe000003473de5068 2d646c2f62696c2f   /lib/ld-
0xe000003473de5070 61692d78756e696c   linux-ia
0xe000003473de5078 322e6f732e3436   64.so.2.
0xe000003473de5080 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe000003473de5088 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe000003473de5090 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe000003473de5098 5a5a5a5a5a5a5a5a   ZZZZZZZZ
0xe000003473de50a0 a55a5a5a5a5a5a5a   ZZZZZZZ.

ps. Handy things, kernel debuggers ...

