Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSKIPAp>; Sat, 9 Nov 2002 10:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbSKIPAp>; Sat, 9 Nov 2002 10:00:45 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:54279 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S265863AbSKIPAo>;
	Sat, 9 Nov 2002 10:00:44 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: 2.5.46: kernel BUG at kernel/timer.c:333!
Date: Sat, 9 Nov 2002 15:07:27 +0000 (UTC)
Organization: Cistron
Message-ID: <aqj8bf$ff2$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1036854447 15842 62.216.29.67 (9 Nov 2002 15:07:27 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can reliably crash 2.5.X on one of our newsservers (dual PIII/450, GigE,
lots of disk- and network I/O).

The last crash I posted here was a bit garbled. So I tried again,
this one is clean. Crash appears to be timer related ?

kernel BUG at kernel/timer.c:333!
invalid operand: 0000
CPU:    1
EIP:    0060:[<c01227a9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010083
eax: c1a16140   ebx: c1a1638c     ecx: f70b65e4       edx: c1a16140
esi: c1a15aa0   edi: f70b65e4     ebp: c1a162b0       esp: c1b25db4
ds: 0068   es: 0068   ss: 0068
Stack: c1a16ac0 c1a15aa0 c1b24000 00000001 c0122ca9 c1a15aa0 c1a162b0 c1a16ac0
       00000000 c1b24000 00000001 00000001 c011f7d5 00000000 00000001 c03d9660
       fffffffe 00000020 c042f424 c042f424 c011f4da c03d9660 00000004 00000001
 [<c0122ca9>] run_timer_tasklet+0x5d/0x15c
 [<c011f7d5>] tasklet_hi_action+0x85/0xe0
 [<c011f4da>] do_softirq+0x5a/0xac
 [<c0112adf>] smp_apic_timer_interrupt+0x113/0x124
 [<c0109476>] apic_timer_interrupt+0x1a/0x20
 [<c0135fd5>] shrink_cache+0x185/0x350
 [<c0136850>] shrink_zone+0x80/0x88
 [<c0136a5e>] balance_pgdat+0x9e/0xfc
 [<c0136bc4>] kswapd+0x108/0x112
 [<c0136abc>] kswapd+0x0/0x112
 [<c0118058>] autoremove_wake_function+0x0/0x40
 [<c0106e8d>] kernel_thread_helper+0x5/0xc
Code: 0f 0b 4d 01 ed d2 29 c0 8b 39 8b 41 08 89 c2 2b 56 04 81 fa


>>EIP; c01227a9 <cascade+25/f8>   <=====

>>eax; c1a16140 <END_OF_CODE+158eb98/????>
>>ebx; c1a1638c <END_OF_CODE+158ede4/????>
>>ecx; f70b65e4 <END_OF_CODE+36c2f03c/????>
>>edx; c1a16140 <END_OF_CODE+158eb98/????>
>>esi; c1a15aa0 <END_OF_CODE+158e4f8/????>
>>edi; f70b65e4 <END_OF_CODE+36c2f03c/????>
>>ebp; c1a162b0 <END_OF_CODE+158ed08/????>
>>esp; c1b25db4 <END_OF_CODE+169e80c/????>

Code;  c01227a9 <cascade+25/f8>
00000000 <_EIP>:
Code;  c01227a9 <cascade+25/f8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01227ab <cascade+27/f8>
   2:   4d                        dec    %ebp
Code;  c01227ac <cascade+28/f8>
   3:   01 ed                     add    %ebp,%ebp
Code;  c01227ae <cascade+2a/f8>
   5:   d2 29                     shrb   %cl,(%ecx)
Code;  c01227b0 <cascade+2c/f8>
   7:   c0 8b 39 8b 41 08 89      rorb   $0x89,0x8418b39(%ebx)
Code;  c01227b7 <cascade+33/f8>
   e:   c2 2b 56                  ret    $0x562b
Code;  c01227ba <cascade+36/f8>
  11:   04 81                     add    $0x81,%al
Code;  c01227bc <cascade+38/f8>
  13:   fa                        cli    


Perhaps it has something to do with the following debug message
I see during boot:

... bootmessages ...
slab: reap timer started for cpu 0
slab: reap timer started for cpu 1
Starting kswapd
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
[f7f8e040] eventpoll: driver installed.
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0117be8>] __might_sleep+0x54/0x58
 [<c013578c>] set_shrinker+0x3c/0x7c
 [<c01686b4>] mb_cache_create+0x1c4/0x244
 [<c0168380>] mb_cache_shrink_fn+0x0/0x170
 [<c01050ab>] init+0x47/0x1ac
 [<c0105064>] init+0x0/0x1ac
 [<c0106e8d>] kernel_thread_helper+0x5/0xc

Journalled Block Device driver loaded
Capability LSM initialized
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
... continuess booting ...

Mike.

