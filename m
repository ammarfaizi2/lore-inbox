Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278653AbRJaA4b>; Tue, 30 Oct 2001 19:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278684AbRJaA4V>; Tue, 30 Oct 2001 19:56:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11012 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278653AbRJaA4I>; Tue, 30 Oct 2001 19:56:08 -0500
From: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 30 Oct 2001 16:54:14 -0800
Message-Id: <200110310054.f9V0sEf01836@penguin.transmeta.com>
To: airlied@csn.ul.ie, linux-kernel@vger.kernel.org
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.32.0110302132020.14320-100000@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.32.0110302132020.14320-100000@skynet> you write:
>Unable to handle kernel NULL pointer dereference at virtual address 00000054
>c013e227
>*pde = 00000000
>Oops: 0000
>CPU:    0
>EIP:    0010:[<c013e227>]    Not tainted
>Using defaults from ksymoops -t elf32-i386 -a i386
>EFLAGS: 00010202
>eax: 00000040   ebx: c23ded38   ecx: c23da670   edx: c23da670
>esi: c23ded20   edi: c23da660   ebp: 0000013b   esp: c1173f5c
>ds: 0018   es: 0018   ss: 0018
>Process kswapd (pid: 4, stackpage=c1173000)
>Stack: 00000019 000003d0 00000006 00000380 c013e4fb 00000662 c0128857 00000006
>       000003d0 00000006 00000020 00000000 000003d0 00002a06 c012888d c01dc55c
>       00000001 c01dc548 c1172000 c012894d c01dc4a0 00000000 c1173fe0 0008e000
>Call Trace: [<c013e4fb>] [<c0128857>] [<c012888d>] [<c012894d>] [<c01289be>]
>   [<c0128ae7>] [<c0105000>] [<c01054bb>]
>Code: 8b 40 14 85 c0 74 09 57 56 ff d0 83 c4 08 eb 09 57 e8 43 1e
>
>>>EIP; c013e227 <prune_dcache+ab/12c>   <=====
>Trace; c013e4fb <shrink_dcache_memory+1b/34>
>Trace; c0128857 <shrink_caches+6f/88>
>Trace; c012888d <try_to_free_pages+1d/4c>
>Trace; c012894d <kswapd_balance_pgdat+55/b0>
>Trace; c01289be <kswapd_balance+16/3c>
>Trace; c0128ae7 <kswapd+a3/cc>
>Trace; c0105000 <_stext+0/0>
>Trace; c01054bb <kernel_thread+23/30>
>Code;  c013e227 <prune_dcache+ab/12c>
>   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
>   3:   85 c0                     test   %eax,%eax
>   5:   74 09                     je     10 <_EIP+0x10> c013e237 <prune_dcache+bb/12c>

This is

	dentry->d_op->d_iput

with dentry->d_op (%eax) having the bogus value 0x00000040.

It's almost certainly _supposed_ to be a NULL pointer, but has bit 6
set. 

So we do

	if (dentry->d_op && dentry->d_op->d_iput)

and because dentry->d_op isn't NULL, we oops on the d_op->d_iput
dereference.

Something is setting a bit in your dentry. Either RAM errors (do you
have ECC memory or a history of SIGSEGV's to give any indication either
way?) or a wild "set_bit()" pointer or similar.

			Linus
