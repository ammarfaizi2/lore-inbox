Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265322AbUFYKSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265322AbUFYKSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 06:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266696AbUFYKSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 06:18:10 -0400
Received: from nacho.alt.net ([207.14.113.18]:32745 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S265322AbUFYKSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 06:18:04 -0400
Date: Fri, 25 Jun 2004 03:18:00 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <Pine.LNX.4.44.0406250048190.6668-100000@nacho.alt.net>
Message-ID: <Pine.LNX.4.44.0406250259400.12660-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Chris Caputo wrote:
> On Wed, 23 Jun 2004, Chris Caputo wrote:
> > __refile_inode() was introduced in 2.4.25.  I'll try 2.4.24 to see if I
> > can reproduce there.
> 
> No word yet on my 2.4.24 testing.  (test still running without failure)

I have now reproduced (below) with 2.4.24 (with tux patches + my driver).  
In the code I believe the line doing the null deref is:

  entry = entry->prev;  [771 or 2.4.24 fs/inode.c]
  
Next I'll try to repro with simply a stock 2.4.26.

Chris

---

Unable to handle kernel NULL pointer dereference at virtual address
00000004
c01665f5
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01665f5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: 00000020   ebx: 00000000   ecx: 00000006   edx: 00000001
esi: 00000000   edi: fffffff8   ebp: c7f95f58   esp: c7f95f30
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c7f95000)
Stack: c7f95f58 c0163794 00000000 c7f95f3c c7f95f3c c7f95f64 c013d152 000001d0
       0000003a 0000000a c7f95f64 c01666f7 00018057 c7f95f8c c013fdcf 00000006
       000001d0 00000000 c0329a60 00000001 c0329a60 00000001 c7f94000 
c7f95fa8
Call Trace:    [<c0163794>] [<c013d152>] [<c01666f7>] [<c013fdcf>] [<c013ff78>]
  [<c013ffe8>] [<c014013a>] [<c01400a0>] [<c01059ce>] [<c01400a0>]
Code: 8b 76 04 8b 87 30 01 00 00 a8 38 74 6e 81 fe 28 a9 32 c0 75


>>EIP; c01665f5 <prune_icache+65/140>   <=====

>>ebp; c7f95f58 <_end+7bcdd8c/3862ae94>
>>esp; c7f95f30 <_end+7bcdd64/3862ae94>

Trace; c0163794 <prune_dcache+194/280>
Trace; c013d152 <kmem_cache_shrink+72/c0>
Trace; c01666f7 <shrink_icache_memory+27/40>
Trace; c013fdcf <try_to_free_pages_zone+8f/f0>
Trace; c013ff78 <kswapd_balance_pgdat+78/c0>
Trace; c013ffe8 <kswapd_balance+28/40>
Trace; c014013a <kswapd+9a/c0>
Trace; c01400a0 <kswapd+0/c0>
Trace; c01059ce <arch_kernel_thread+2e/40>
Trace; c01400a0 <kswapd+0/c0>

Code;  c01665f5 <prune_icache+65/140>
00000000 <_EIP>:
Code;  c01665f5 <prune_icache+65/140>   <=====
   0:   8b 76 04                  mov    0x4(%esi),%esi   <=====
Code;  c01665f8 <prune_icache+68/140>
   3:   8b 87 30 01 00 00         mov    0x130(%edi),%eax
Code;  c01665fe <prune_icache+6e/140>
   9:   a8 38                     test   $0x38,%al
Code;  c0166600 <prune_icache+70/140>
   b:   74 6e                     je     7b <_EIP+0x7b>
Code;  c0166602 <prune_icache+72/140>
   d:   81 fe 28 a9 32 c0         cmp    $0xc032a928,%esi
Code;  c0166608 <prune_icache+78/140>
  13:   75 00                     jne    15 <_EIP+0x15>

