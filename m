Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSKHTgQ>; Fri, 8 Nov 2002 14:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSKHTgQ>; Fri, 8 Nov 2002 14:36:16 -0500
Received: from mail016.mail.bellsouth.net ([205.152.58.36]:11320 "EHLO
	imf16bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S262296AbSKHTgP>; Fri, 8 Nov 2002 14:36:15 -0500
Date: Fri, 8 Nov 2002 14:42:36 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: 2.5.46-bk3: BUG in skbuff.c:178
Message-ID: <Pine.LNX.4.43.0211081440130.317-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Single-CPU system, running 2.5.46-bk3. Whiling compiling bk4, and running
a script that was pinging every host on my subnet (I was running arp -a
to see what was in the arp table at the time), I hit this BUG.

Debug: sleeping function called from illegal context at mm/slab.c:1305
Call Trace:
 [<c011247c>] __might_sleep+0x54/0x58
 [<c012a3e2>] kmem_flagcheck+0x1e/0x50
 [<c012ab6a>] kmem_cache_alloc+0x12/0xc8
 [<c0226e0c>] sock_alloc_inode+0x10/0x68
 [<c014cb65>] alloc_inode+0x15/0x180
 [<c014d397>] new_inode+0xb/0x78
 [<c0227093>] sock_alloc+0xf/0x68
 [<c0227d65>] sock_create+0x8d/0xe4
 [<c0227dd9>] sys_socket+0x1d/0x58
 [<c0228a13>] sys_socketcall+0x5f/0x1f4
 [<c0108903>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c01110b1>] schedule+0x3d/0x2c8
 [<c010892a>] work_resched+0x5/0x16

alloc_skb called nonatomically from interrupt c022966e
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:178!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c022a073>]    Not tainted
EFLAGS: 00010202
EIP is at alloc_skb+0x43/0x1a4
eax: 0000003a   ebx: c27d1044   ecx: c3fff360   edx: c0343e50
esi: 00000000   edi: 000001d0   ebp: c27d1ca4   esp: c1ad3e90
ds: 0068   es: 0068   ss: 0068
Process arp (pid: 5029, threadinfo=c1ad2000 task=c3fff360)
Stack: c02bf140 c022966e c27d1044 00000000 0000006e c022966e 00000001 000001d0
       c6bb65e4 c02679a1 c27d1044 00000001 00000000 000001d0 c6bb65e4 c1ad3f14
       0000006e bffff78c 00000018 7fffffff 00000000 c27d1044 fffffff4 bffff71c
Call Trace:
 [<c022966e>] sock_wmalloc+0x26/0x50
 [<c022966e>] sock_wmalloc+0x26/0x50
 [<c02679a1>] unix_stream_connect+0xb1/0x3e8
 [<c0228177>] sys_connect+0x5b/0x78
 [<c0228a40>] sys_socketcall+0x8c/0x1f4
 [<c0108903>] syscall_call+0x7/0xb

Code: 0f 0b b2 00 e3 f0 2b c0 83 c4 08 83 e7 ef 31 c0 9c 59 fa be
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


