Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSEEQic>; Sun, 5 May 2002 12:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSEEQib>; Sun, 5 May 2002 12:38:31 -0400
Received: from pD950B1E6.dip0.t-ipconnect.de ([217.80.177.230]:14428 "EHLO
	mordor.svara") by vger.kernel.org with ESMTP id <S313182AbSEEQi3>;
	Sun, 5 May 2002 12:38:29 -0400
Date: Sun, 5 May 2002 20:40:46 +0200
From: Fabian Svara <svara@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:82
Message-Id: <20020505204046.7a374220.svara@gmx.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Recently, the battery of my wireless mouse went empty - not realizing
the problem was realted to the battery, i switched to a text console and
saw the following BUG report from the kernel:

kernel BUG at page_alloc.c:82
invalid operand: 0000
CPU:	0
EIP:	0010:[<c0125183>]    Tainted: P
EFLAGS:	00013286
eax: 0000001f	ebx: c14ce240	ecx: c01f4a00	edx: 007d1d3a
esi: c14ce240	edi: 0011a900	ebp: 00000000	esp: d350fe48
ds: 0018   es: 0018   ss: 0018
Process XFree86 (pid: 6240, stackpage=d350f000)
Stack: c01c90c1 00000052 c14ce240 c14ce240 0011a900 08800000 0011a900 c01261e5
       c023cee0 c023cee0 c0124351 c01259c8 0011a900 c0125da3 0011a900 c023cee0
       c14ce240 c01263e9 c14ce240 00400000 00043000 cb5db10c c011c01c 0011a900
Call Trace: [<c01261e5>] [<c0124351>] [<c01259c8>] [<c0125da3>] [<c01263e9>]
   [<c011c01c>] [<c011e2f1>] [<c010f445>] [<c011330d>] [<c01069d8>] [<c0147624>]

   [<c012ab67>] [<c0106032>] [<c0106c1c>] [<c0106b64>]

Code: 0f 0b 83 c4 08 8b 46 18 a8 40 74 11 6a 54 68 c1 90 1c c0 e8

Which, using ksymoops, resolves to

>>EIP; c0125183 <__free_pages_ok+93/29c>   <=====

>>ebx; c14ce240 <_end+12755cc/145e538c>
>>ecx; c01f4a00 <console_sem+0/14>
>>edx; 007d1d3a Before first symbol
>>esi; c14ce240 <_end+12755cc/145e538c>
>>edi; 0011a900 Before first symbol
>>esp; d350fe48 <_end+132b71d4/145e538c>

Trace; c01261e5 <swap_free+25/2c>
Trace; c0124351 <lru_cache_del+5/14>
Trace; c01259c8 <page_cache_release+2c/30>
Trace; c0125da3 <delete_from_swap_cache+47/50>
Trace; c01263e9 <free_swap_and_cache+69/88>
Trace; c011c01c <zap_page_range+1a4/244>
Trace; c011e2f1 <exit_mmap+b5/12c>
Trace; c010f445 <mmput+39/58>
Trace; c011330d <do_exit+95/1ec>
Trace; c01069d8 <do_signal+220/288>
Trace; c0147624 <ext3_release_file+14/1c>
Trace; c012ab67 <fput+af/d0>
Trace; c0106032 <sys_sigreturn+b6/e4>
Trace; c0106c1c <error_code+34/3c>
Trace; c0106b64 <signal_return+14/18>

Code;  c0125183 <__free_pages_ok+93/29c>
00000000 <_EIP>:
Code;  c0125183 <__free_pages_ok+93/29c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0125185 <__free_pages_ok+95/29c>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0125188 <__free_pages_ok+98/29c>
   5:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c012518b <__free_pages_ok+9b/29c>
   8:   a8 40                     test   $0x40,%al
Code;  c012518d <__free_pages_ok+9d/29c>
   a:   74 11                     je     1d <_EIP+0x1d> c01251a0 <__free_pages_ok+b0/29c>
Code;  c012518f <__free_pages_ok+9f/29c>
   c:   6a 54                     push   $0x54
Code;  c0125191 <__free_pages_ok+a1/29c>
   e:   68 c1 90 1c c0            push   $0xc01c90c1
Code;  c0125196 <__free_pages_ok+a6/29c>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c012519b <__free_pages_ok+ab/29c>

I don't know what triggered it, as it could've been displayed on that terminal for a long time already, and I noticed it only now...

I am running Linux 2.4.17 on a Pentium 3.

-Fabian Svara
