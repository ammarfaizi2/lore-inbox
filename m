Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTLCXGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTLCXGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:06:37 -0500
Received: from relay-6m.club-internet.fr ([194.158.104.45]:20728 "EHLO
	relay-6m.club-internet.fr") by vger.kernel.org with ESMTP
	id S262196AbTLCXG3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:06:29 -0500
From: pinotj@club-internet.fr
To: torvalds@osdl.org, nathans@sgi.com
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Thu,  4 Dec 2003 00:06:28 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1070492788.24399.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the "small kernel" test11 with Ext3 support instead of XFS by booting on my slack partition.

I confirm to have the same problem without XFS, oops as usual when I try to compile a kernel:

---
slab: double free detected in cache 'buffer_head' objp c605733c, objnr 9, slabp c6057000, s_mem c6057120, bufctl 12
---

[slab.c patch from Linus]

I tried the patch on the same small config (XFS and CONFIG_DEBUG_PAGEALLOC enabled) and I got oops at the beginning of boot sequence. I spent some times to write this down but I'm not so sure it's a good news. Just say me it's not a hw problem...

---
kernel BUG at mm/slab.c:1655!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c013bf35>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c0243c00   ebx: 0027f448   ecx: 00000000   edx: cffb5000
esi: cffb6000   edi: cffb5000   ebp: c027bf70   esp: c027bf60
ds: 007b   es: 007b   ss: 0068
Stack: 00000286 00000000 cffb6000 cffb5000 c027bf94 c013c1a5 cffb5000 cffb6044
       cffb6000 cffb5000 cffb6000 cffb6000 c029be80 c027bfb0 c013c413 cffb6000
       00000008 00000004 00000000 000000d0 c027bfec c0283d8a cffb6000 00000090
Call Trace:
 [<c013c1a5>] do_tune_cpucache+0x1cd/0x3fc
 [<c013c413>] enable_cpucache+0x3f/0x64
 [<c0283d8a>] kmem_cache_init+0x1ae/0x280
 [<c0105000>] _stext+0x0/0x20
 [<c027c5af>] start_kernel+0xb3/0x138
Code: 0f 0b 77 06 75 2f 24 c0 8b 15 c4 bf 29 c0 eb af 8d 76 00 57


>>EIP; c013bf35 <kfree+81/b0>   <=====

>>eax; c0243c00 <bpp4tab+5f40/13436>
>>edx; cffb5000 <_end+fd0c990/3fd55990>
>>esi; cffb6000 <_end+fd0d990/3fd55990>
>>edi; cffb5000 <_end+fd0c990/3fd55990>
>>ebp; c027bf70 <init_thread_union+1f70/2000>
>>esp; c027bf60 <init_thread_union+1f60/2000>

Trace; c013c1a5 <do_tune_cpucache+1cd/3fc>
Trace; c013c413 <enable_cpucache+3f/64>
Trace; c0283d8a <kmem_cache_init+1ae/280>
Trace; c0105000 <_stext+0/0>
Trace; c027c5af <start_kernel+b3/138>

Code;  c013bf35 <kfree+81/b0>
00000000 <_EIP>:
Code;  c013bf35 <kfree+81/b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013bf37 <kfree+83/b0>
   2:   77 06                     ja     a <_EIP+0xa>
Code;  c013bf39 <kfree+85/b0>
   4:   75 2f                     jne    35 <_EIP+0x35>
Code;  c013bf3b <kfree+87/b0>
   6:   24 c0                     and    $0xc0,%al
Code;  c013bf3d <kfree+89/b0>
   8:   8b 15 c4 bf 29 c0         mov    0xc029bfc4,%edx
Code;  c013bf43 <kfree+8f/b0>
   e:   eb af                     jmp    ffffffbf <_EIP+0xffffffbf>
Code;  c013bf45 <kfree+91/b0>
  10:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c013bf48 <kfree+94/b0>
  13:   57                        push   %edi

 <0>Kernel panic: Attempted to kill the idle task!
---

Jerome

