Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTGCPCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTGCPCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 11:02:40 -0400
Received: from mail-8.tiscali.it ([195.130.225.154]:64145 "EHLO
	mail-8.tiscali.it") by vger.kernel.org with ESMTP id S264030AbTGCPCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 11:02:38 -0400
Date: Thu, 3 Jul 2003 17:17:03 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.74: BUG at mm/slab.c:1537
Message-ID: <20030703151703.GA4595@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Pfiffer <andyp@osdl.org> ha scritto:
> kernel BUG at mm/slab.c:1537!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c01457ad>]    Not tainted
> EFLAGS: 00010002
> EIP is at kfree+0x35/0x268
> eax: 0000002c   ebx: ded59b68   ecx: c150bc20   edx: c0412ce8
> esi: 00000100   edi: 00040000   ebp: df12df30   esp: df12df00
> ds: 007b   es: 007b   ss: 0068
> Process netstat (pid: 1405, threadinfo=df12c000 task=df3c6080)
> Stack: c0389060 00000100 ded59b68 df5e0e64 df0b4cb4 df12df6c df5e0e84
> df12df30
>       c0344ca1 ded59b68 00000001 00000206 df12df48 c017ae8c 00000100
> defe1c54
>       df5e0e64 df0b4cb4 df12df6c c015b9c7 df0b4cb4 df5e0e64 defe1c54
> df5e0e64
> Call Trace:
> [<c0344ca1>] raw_seq_start+0x4d/0x58
> [<c017ae8c>] seq_release_private+0x18/0x30
> [<c015b9c7>] __fput+0x3b/0xfc
> [<c015b987>] fput+0x17/0x1c
> [<c015a402>] filp_close+0x10a/0x118
> [<c015a4ba>] sys_close+0xaa/0x100
> [<c010af6f>] syscall_call+0x7/0xb
>
> Code: 0f 0b 01 06 27 8d 38 c0 83 c4 08 8d 04 bf c1 e0 03 89 45 f8

I can reproduce it with cat /proc/net/raw:

kernel BUG at mm/slab.c:1537!
invalid operand: 0000 [#7]
CPU:    0
EIP:    0060:[<c015ae85>]    Not tainted
EFLAGS: 00010082
EIP is at kfree+0x315/0x330
eax: 0000002c   ebx: 00040000   ecx: 00000000   edx: 00000001
esi: de5e390c   edi: c8b355d0   ebp: e9edff1c   esp: e9edfef0
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 4564, threadinfo=e9ede000 task=dbcae3c0)
Stack: c0373c00 00000100 eeb94044 00000000 dff166c8 de5e392c e9edff1c 00000206
       dff166c8 de5e390c c8b355d0 e9edff38 c01a9263 00000100 00000000 de5e390c
       de5e390c effe67c4 e9edff5c c017a642 c8b355d0 de5e390c c8b355d0 eacf22e8
Call Trace:
 [<c01a9263>] seq_release_private+0x23/0x3f
 [<c017a642>] __fput+0x112/0x120
 [<c017862a>] filp_close+0x15a/0x220
 [<c01787f2>] sys_close+0x102/0x220
 [<c01795df>] sys_read+0x3f/0x60
 [<c010b10f>] syscall_call+0x7/0xb

Code: 0f 0b 01 06 b6 30 37 c0 e9 0f fd ff ff 8d b4 26 00 00 00 00

ksymoops says:

>>EIP; c015ae85 <kfree+315/330>   <=====

>>esi; de5e390c <_end+1e161064/3fb7b758>
>>edi; c8b355d0 <_end+86b2d28/3fb7b758>
>>ebp; e9edff1c <_end+29a5d674/3fb7b758>
>>esp; e9edfef0 <_end+29a5d648/3fb7b758>

Trace; c01a9263 <seq_release_private+23/3f>
Trace; c017a642 <__fput+112/120>
Trace; c017862a <filp_close+15a/220>
Trace; c01787f2 <sys_close+102/220>
Trace; c01795df <sys_read+3f/60>
Trace; c010b10f <syscall_call+7/b>

Code;  c015ae85 <kfree+315/330>
00000000 <_EIP>:
Code;  c015ae85 <kfree+315/330>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015ae87 <kfree+317/330>
   2:   01 06                     add    %eax,(%esi)
Code;  c015ae89 <kfree+319/330>
   4:   b6 30                     mov    $0x30,%dh
Code;  c015ae8b <kfree+31b/330>
   6:   37                        aaa
Code;  c015ae8c <kfree+31c/330>
   7:   c0 e9 0f                  shr    $0xf,%cl
Code;  c015ae8f <kfree+31f/330>
   a:   fd                        std
Code;  c015ae90 <kfree+320/330>
   b:   ff                        (bad)
Code;  c015ae91 <kfree+321/330>
   c:   ff 8d b4 26 00 00         decl   0x26b4(%ebp)


HTH,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
You and me baby ain't nothin' but mammals
So let's do it like they do on the Discovery Channel
