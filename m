Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263713AbUFXBvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUFXBvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 21:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUFXBvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 21:51:08 -0400
Received: from nacho.alt.net ([207.14.113.18]:61094 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S263713AbUFXBuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 21:50:52 -0400
Date: Wed, 23 Jun 2004 18:50:48 -0700 (PDT)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       <riel@redhat.com>, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
In-Reply-To: <20040620001529.GA4326@logos.cnet>
Message-ID: <Pine.LNX.4.44.0406231802100.13351-100000@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Marcelo Tosatti wrote:
> On Fri, Jun 18, 2004 at 05:47:05PM -0700, Chris Caputo wrote:
> > In 2.4.26 on two different dual-proc x86 machines (one dual-P4 Xeon based,
> > the other dual-PIII) I am seeing crashes which are the result of the
> > inode_unused doubly linked list in fs/inode.c becoming corrupted.
> 
> What steps are required to reproduce the problem?

Unfortunately I don't yet know how to (or if I can) repro this with a
stock kernel.  I am using 2.4.26 + Ingo's tux3-2.4.23-A3 patch in
conjunction with a filesystem I wrote.  (the tux module itself is not
being used, just the patches to the existing kernel)

> > A particular instance of the corruption I have isolated is in a call from
> > iput() to __refile_inode().  To try to diagnose this further I placed list
> > verification code before and after the list_del() and list_add() calls in
> > __refile_inode() and observed a healthy list become corrupted after the
> > del/add was completed.
> 
> Can you show us this data in more detail?

In __refile_inode() before and after the list_add()/del() calls I call a
function which checks up to the first 10 items on the inode_unused list to
see if next and prev pointers are valid.
(inode->next->prev == inode && inode->prev->next == inode)

So what I observed was a case here where iput() inline __refile_inode():

 1) checked inode_unused and saw that it was good
 2) put an item on the inode_unused list
 3) checked inode_unused and saw that it was now bad and that the item 
    added was the culprit.

This all happened within __refile_inode() with the inode_lock spinlock
grabbed by iput() and so I tend to think some other code is accessing the
inode_unused list _without_ grabbing the spinlock.  I've checked the
inode.c code over and over, plus my filesystem code, and haven't yet found
a culprit.  I also checked the tux diffs to see if it was messing with
inode objects in an inappropriate way.

Is it safe to assume that the x86 version of atomic_dec_and_lock(), which
iput() uses, is well trusted?  I figure it's got to be, but doesn't hurt
to ask.

> > It would seem to me that list corruption on otherwise healthy machines
> > would only be the result of the inode_lock spinlock not being properly
> > locked prior to the call to __refile_inode(), but as far as I can tell,
> > the call to atomic_dec_and_lock() in iput() is doing that properly.
> > 
> > So I am at a loss.  Has anyone else seen this or does anyone have any idea
> > what routes I should be exploring to fix this problem?
> 
> The changes between 2.4.25->2.4.26 (which introduce __refile_inode() and 
> the unused_pagecache list) must have something to do with this. 

__refile_inode() was introduced in 2.4.25.  I'll try 2.4.24 to see if I
can reproduce there.

Marcelo, you asked for some oops' relating to the problem.  Here are some.

Thanks,
Chris

---

Oops: 0000
CPU:    0
EIP:    0010:[<c015b465>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a93
eax: 8d12e0e2   ebx: 7b402366   ecx: c40fdf18   edx: d9c92888
esi: 7b40235e   edi: 7b402366   ebp: 000007cf   esp: c40fdf10
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 7, stackpage=c40fd000)
Stack: e3b85380 000004e5 e3b85388 c9812688 00000002 c25caf40 c0317fd8 00023dd2
       c015b664 00000cb4 c0138f35 00000006 000001d0 ffffffff 000001d0 00000002
       00000006 000001d0 c0317fd8 c0317fd8 c013936a c40fdf84 000001d0 0000003c
Call Trace:    [<c015b664>] [<c0138f35>] [<c013936a>] [<c01393e2>] [<c0139596>]
               [<c0139608>] [<c0139748>] [<c01396b0>] [<c0105000>] [<c010587e>]
[<c01396b0>]
Code: 8b 5b 04 8b 86 1c 01 00 00 a8 38 0f 84 5d 01 00 00 81 fb 08


>>EIP; c015b465 <prune_icache+45/220>   <=====

>>ecx; c40fdf18 <_end+3d3ffec/38676134>
>>edx; d9c92888 <_end+198d495c/38676134>
>>esp; c40fdf10 <_end+3d3ffe4/38676134>

Trace; c015b664 <shrink_icache_memory+24/40>
Trace; c0138f35 <shrink_cache+185/410>
Trace; c013936a <shrink_caches+4a/60>
Trace; c01393e2 <try_to_free_pages_zone+62/f0>
Trace; c0139596 <kswapd_balance_pgdat+66/b0>
Trace; c0139608 <kswapd_balance+28/40>
Trace; c0139748 <kswapd+98/c0>
Trace; c01396b0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010587e <arch_kernel_thread+2e/40>
Trace; c01396b0 <kswapd+0/c0>

Code;  c015b465 <prune_icache+45/220>
00000000 <_EIP>:
Code;  c015b465 <prune_icache+45/220>   <=====
   0:   8b 5b 04                  mov    0x4(%ebx),%ebx   <=====
Code;  c015b468 <prune_icache+48/220>
   3:   8b 86 1c 01 00 00         mov    0x11c(%esi),%eax
Code;  c015b46e <prune_icache+4e/220>
   9:   a8 38                     test   $0x38,%al
Code;  c015b470 <prune_icache+50/220>
   b:   0f 84 5d 01 00 00         je     16e <_EIP+0x16e>
Code;  c015b476 <prune_icache+56/220>
  11:   81 fb 08 00 00 00         cmp    $0x8,%ebx

---

Oops: 0000
CPU:    0
EIP:    0010:[<c015b465>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a97
eax: 830418da   ebx: 5954e741   ecx: c40fdf18   edx: c0318f08
esi: 5954e739   edi: 5954e741   ebp: 000001b4   esp: c40fdf10
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 7, stackpage=c40fd000)
Stack: f718b780 000013a1 f718b788 d04d3988 00000001 c3cfe850 c0317fd8 00023d9e
       c015b664 00001555 c0138f35 00000006 000001d0 ffffffff 000001d0 00000001
       00000004 000001d0 c0317fd8 c0317fd8 c013936a c40fdf84 000001d0 0000003c
Call Trace:    [<c015b664>] [<c0138f35>] [<c013936a>] [<c01393e2>] [<c0139596>]
               [<c0139608>] [<c0139748>] [<c01396b0>] [<c0105000>] [<c010587e>]
 [<c01396b0>]
Code: 8b 5b 04 8b 86 1c 01 00 00 a8 38 0f 84 5d 01 00 00 81 fb 08


>>EIP; c015b465 <prune_icache+45/220>   <=====

>>edx; c0318f08 <inode_unused+0/8>

Trace; c015b664 <shrink_icache_memory+24/40>
Trace; c0138f35 <shrink_cache+185/410>
Trace; c013936a <shrink_caches+4a/60>
Trace; c01393e2 <try_to_free_pages_zone+62/f0>
Trace; c0139596 <kswapd_balance_pgdat+66/b0>
Trace; c0139608 <kswapd_balance+28/40>
Trace; c0139748 <kswapd+98/c0>
Trace; c01396b0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010587e <arch_kernel_thread+2e/40>
Trace; c01396b0 <kswapd+0/c0>

Code;  c015b465 <prune_icache+45/220>
00000000 <_EIP>:
Code;  c015b465 <prune_icache+45/220>   <=====
   0:   8b 5b 04                  mov    0x4(%ebx),%ebx   <=====
Code;  c015b468 <prune_icache+48/220>
   3:   8b 86 1c 01 00 00         mov    0x11c(%esi),%eax
Code;  c015b46e <prune_icache+4e/220>
   9:   a8 38                     test   $0x38,%al
Code;  c015b470 <prune_icache+50/220>
   b:   0f 84 5d 01 00 00         je     16e <_EIP+0x16e>
Code;  c015b476 <prune_icache+56/220>
  11:   81 fb 08 00 00 00         cmp    $0x8,%ebx

---

I think this one was an infinite loop which I used alt-sysrq-p to get 
deduce:

Pid: 7, comm:               kswapd
EIP: 0010:[<c014dd1c>] CPU: 2 EFLAGS: 00000246    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: c4e4f824 EBX: c4e4f804 ECX: 00000006 EDX: 00000000
ESI: c4e4f80c EDI: c4e4f804 EBP: 000009ee DS: 0018 ES: 0018
Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register 
line ignored
CR0: 8005003b CR2: bfffdfb4 CR3: 00101000 CR4: 000006d0
Call Trace:    [<c0167f8e>] [<c01681d4>] [<c013d9d0>] [<c0168254>] [<c013fe69>]
  [<c01404ae>] [<c0140533>] [<c01405b2>] [<c011a6cb>] [<c0140766>] [<c01407d8>]
  [<c0140918>] [<c0140880>] [<c010595e>] [<c0140880>]
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c014dd1c <inode_has_buffers+6c/90>   <=====

>>EAX; c4e4f824 <_end+4a6b2f8/3864fb34>
>>EBX; c4e4f804 <_end+4a6b2d8/3864fb34>
>>ESI; c4e4f80c <_end+4a6b2e0/3864fb34>
>>EDI; c4e4f804 <_end+4a6b2d8/3864fb34>

Trace; c0167f8e <prune_icache+7e/320>
Trace; c01681d4 <prune_icache+2c4/320>
Trace; c013d9d0 <kmem_cache_shrink+70/c0>
Trace; c0168254 <shrink_icache_memory+24/40>
Trace; c013fe69 <shrink_cache+1d9/6d0>
Trace; c01404ae <refill_inactive+14e/160>
Trace; c0140533 <shrink_caches+73/90>
Trace; c01405b2 <try_to_free_pages_zone+62/f0>
Trace; c011a6cb <schedule+34b/5f0>
Trace; c0140766 <kswapd_balance_pgdat+66/b0>
Trace; c01407d8 <kswapd_balance+28/40>
Trace; c0140918 <kswapd+98/c0>
Trace; c0140880 <kswapd+0/c0>
Trace; c010595e <arch_kernel_thread+2e/40>
Trace; c0140880 <kswapd+0/c0>

---

Another infinite loop (alt-sysrq-p):

Pid: 7, comm:               kswapd
EIP: 0010:[<c0167bc8>] CPU: 3 EFLAGS: 00000206    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 00000001 EBX: ebe7f40c ECX: 00000002 EDX: 00000000
ESI: ebe7f60c EDI: ebe7f604 EBP: c2851ee4 DS: 0018 ES: 0018
Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register 
line ignored
CR0: 8005003b CR2: 40014000 CR3: 00101000 CR4: 000006d0
Call Trace:    [<c013d7e2>] [<c0167eb7>] [<c013fd05>] [<c0140360>] [<c01403e2>]
  [<c0140462>] [<c0140638>] [<c01406a8>] [<c01407fa>] [<c0140760>] [<c010596e>]
  [<c0140760>]

>>EIP; c0167bc8 <prune_icache+78/340>   <=====

Trace; c013d7e2 <kmem_cache_shrink+72/c0>
Trace; c0167eb7 <shrink_icache_memory+27/40>
Trace; c013fd05 <shrink_cache+1d5/6d0>
Trace; c0140360 <refill_inactive+160/170>
Trace; c01403e2 <shrink_caches+72/90>
Trace; c0140462 <try_to_free_pages_zone+62/f0>
Trace; c0140638 <kswapd_balance_pgdat+78/c0>
Trace; c01406a8 <kswapd_balance+28/40>
Trace; c01407fa <kswapd+9a/c0>
Trace; c0140760 <kswapd+0/c0>
Trace; c010596e <arch_kernel_thread+2e/40>
Trace; c0140760 <kswapd+0/c0>

---

Infinite loop (alt-sysrq-p):

Pid: 9, comm:             kupdated
EIP: 0010:[<c0168df3>] CPU: 2 EFLAGS: 00000282    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: f7bea000 EBX: f7bea000 ECX: f7bebfd0 EDX: 00000000
ESI: f7bebfc8 EDI: f7bebfd8 EBP: f7bebf10 DS: 0018 ES: 0018
Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register 
line ignored
CR0: 8005003b CR2: 40013090 CR3: 00101000 CR4: 000006d0
Call Trace:    [<c011a1b2>] [<c0151333>] [<c015185e>] [<c0107a42>]
[<c010596e>] [<c0151690>]

>>EIP; c0168df3 <.text.lock.inode+69/256>   <=====

>>EAX; f7bea000 <_end+377ffb74/38649bd4>
>>EBX; f7bea000 <_end+377ffb74/38649bd4>
>>ECX; f7bebfd0 <_end+37801b44/38649bd4>
>>ESI; f7bebfc8 <_end+37801b3c/38649bd4>
>>EDI; f7bebfd8 <_end+37801b4c/38649bd4>
>>EBP; f7bebf10 <_end+37801a84/38649bd4>

Trace; c011a1b2 <schedule_timeout+62/b0>
Trace; c0151333 <sync_old_buffers+53/160>
Trace; c015185e <kupdate+1ce/230>
Trace; c0107a42 <ret_from_fork+6/20>
Trace; c010596e <arch_kernel_thread+2e/40>
Trace; c0151690 <kupdate+0/230>

---

Infinite loop (alt-sysrq-p):

Pid: 7, comm:               kswapd
EIP: 0010:[<c0167be0>] CPU: 3 EFLAGS: 00000202    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 00000020 EBX: dcbc120c ECX: 00000086 EDX: daae3044
ESI: dcbc120c EDI: dcbc1204 EBP: c2851ee4 DS: 0018 ES: 0018
Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register 
line ign
ored
CR0: 8005003b CR2: 0807f260 CR3: 00101000 CR4: 000006d0
Call Trace:    [<c013d7e2>] [<c0167ed7>] [<c013fd05>] [<c0140360>] [<c01403e2>]
  [<c011a55b>] [<c0140462>] [<c0140638>] [<c01406a8>] [<c01407fa>] [<c0140760>]
  [<c010596e>] [<c0140760>]

>>EIP; c0167be0 <prune_icache+90/360>   <=====

>>EBX; dcbc120c <_end+1c7d6d80/38649bd4>
>>EDX; daae3044 <_end+1a6f8bb8/38649bd4>
>>ESI; dcbc120c <_end+1c7d6d80/38649bd4>
>>EDI; dcbc1204 <_end+1c7d6d78/38649bd4>
>>EBP; c2851ee4 <_end+2467a58/38649bd4>

Trace; c013d7e2 <kmem_cache_shrink+72/c0>
Trace; c0167ed7 <shrink_icache_memory+27/40>
Trace; c013fd05 <shrink_cache+1d5/6d0>
Trace; c0140360 <refill_inactive+160/170>
Trace; c01403e2 <shrink_caches+72/90>
Trace; c011a55b <schedule+34b/5f0>
Trace; c0140462 <try_to_free_pages_zone+62/f0>
Trace; c0140638 <kswapd_balance_pgdat+78/c0>
Trace; c01406a8 <kswapd_balance+28/40>
Trace; c01407fa <kswapd+9a/c0>
Trace; c0140760 <kswapd+0/c0>
Trace; c010596e <arch_kernel_thread+2e/40>
Trace; c0140760 <kswapd+0/c0>

