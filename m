Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285325AbRLNKbw>; Fri, 14 Dec 2001 05:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285326AbRLNKbn>; Fri, 14 Dec 2001 05:31:43 -0500
Received: from urtica.linuxnews.pl ([217.67.192.54]:47878 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S285325AbRLNKbd>; Fri, 14 Dec 2001 05:31:33 -0500
Date: Fri, 14 Dec 2001 11:31:28 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: Dag Brattli <dagb@cs.uit.no>, <linux-kernel@vger.kernel.org>
Subject: [BUG()] IrDA in 2.4.16 + preempt
Message-ID: <Pine.LNX.4.33.0112141128300.662-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found an annoying problem with irda on 2.4.16.
When I remove irlan module I get sementation fault:
root@blurp:~# rmmod irlan
Dec 14 02:27:29 blurp kernel: irlan_init()
Dec 14 02:27:29 blurp kernel: irlmp_register_client()
Dec 14 02:27:29 blurp kernel: irlan_register_netdev()
Dec 14 02:27:35 blurp kernel: kernel BUG at slab.c:1200!
Dec 14 02:27:35 blurp kernel: invalid operand: 0000
Dec 14 02:27:35 blurp kernel: CPU:    0
Dec 14 02:27:35 blurp kernel: EIP:    0010:[kmem_extra_free_checks+81/140] Not tainted
Dec 14 02:27:35 blurp kernel: EFLAGS: 00010082
Dec 14 02:27:35 blurp kernel: eax: 0000001b   ebx: c14055f0   ecx: ffffffe2 edx: 000017eb
Dec 14 02:27:35 blurp kernel: esi: 00000000   edi: cf2eb974   ebp: cc4d9030 esp: cc045ebc
Dec 14 02:27:35 blurp kernel: ds: 0018   es: 0018   ss: 0018
Dec 14 02:27:35 blurp kernel: Process rmmod (pid: 110, stackpage=cc045000)
Dec 14 02:27:35 blurp kernel: Stack: c024a8ac 000004b0 cf2eb974 cc4d9030 cc4d9030 c14055f0 c012d3c2 c14055f0
Dec 14 02:27:35 blurp kernel:        cf2eb974 cc4d9030 cc4d9030 cc4d9030 ffffe000 00000286 ffffe000 00000400
Dec 14 02:27:35 blurp kernel:        cc4d9030 00000286 c01eab85 cc4d9030 cc4d9030 c01ead4f cc4d9030 cc4d9030
Dec 14 02:27:35 blurp kernel: Call Trace: [kfree+450/576] [netdev_finish_unregister+145/152] [unregister_netdevice+451/632] [unregister_netdev+16/40] [<d285b490>]
Dec 14 02:27:35 blurp kernel:    [<d285b34c>] [hashbin_delete+107/152] [<d285b160>] [<d285b34c>] [<d28602e3>] [<d285ccdd>]
Dec 14 02:27:36 blurp kernel:    [free_module+23/192] [sys_delete_module+300/732] [system_call+51/56]
Dec 14 02:27:36 blurp kernel:
Dec 14 02:27:36 blurp kernel: Code: 0f 0b 83 c4 08 8b 5f 14 83 fb ff 74 27 8d b6 00 00 00 00 39
[and segmentation fault]

And then the module is not removed in fact:
root@blurp:~# lsmod
Module                  Size  Used by
irlan                      0   0  (deleted)
root@blurp:~# insmod irlan
Using /lib/modules/2.4.16preempt/kernel/net/irda/irlan/irlan.o
insmod: a module named irlan already exists

Moreover, some processes go into a 'D' state. Eg. ifconfig, irattach.

Additionally, when I try to login an the other console, I get bug:
Dec 14 02:28:52 blurp kernel:  kernel BUG at slab.c:1243!
Dec 14 02:28:52 blurp kernel: invalid operand: 0000
Dec 14 02:28:52 blurp kernel: CPU:    0
Dec 14 02:28:52 blurp kernel: EIP:    0010:[kmalloc+346/504]    Not tainted
Dec 14 02:28:52 blurp kernel: EFLAGS: 00010086
Dec 14 02:28:52 blurp kernel: eax: 0000001b   ebx: c14055f0   ecx: ffffffe5 edx: 00001b5b
Dec 14 02:28:52 blurp kernel: esi: cc4d9400   edi: cc4d942f   ebp: cc4d942f esp: ccc41f30
Dec 14 02:28:52 blurp kernel: ds: 0018   es: 0018   ss: 0018
Dec 14 02:28:52 blurp kernel: Process bash (pid: 94, stackpage=ccc41000)
Dec 14 02:28:52 blurp kernel: Stack: c024a8ac 000004db 00000100 fffffff4 000000ff c15181ec 00000400 00000246
Dec 14 02:28:52 blurp kernel:        c0149d19 00000400 000001f0 c0149e0a 00000100 000000ff c15181ec 00000001
Dec 14 02:28:52 blurp kernel:        c15181ec 00000003 ccc40000 c15181ec bffffd12 c0141b46 c15181ec 000000ff
Dec 14 02:28:52 blurp kernel: Call Trace: [alloc_fd_array+25/52] [expand_fd_array+142/384] [expand_files+54/68] [sys_dup2+125/324] [system_call+51/56]
Dec 14 02:28:52 blurp kernel:
Dec 14 02:28:52 blurp kernel: Code: 0f 0b 83 c4 08 90 f6 43 1d 04 74 4e b8 a5 c2 0f 17 87 06 3d

There's only a problem with a first login. But I suppose it is a consequence
of the first bug.

I can reproduce it.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku
http://tfuj.pl/cv.html :: http://tfuj.pl/pgp.asc

