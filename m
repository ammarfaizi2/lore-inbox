Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWEJWgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWEJWgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWEJWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:36:18 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:4318 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965043AbWEJWgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:36:18 -0400
Date: Wed, 10 May 2006 18:31:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG 2.6.17-rc3-git8
To: Matthew L Foster <mfoster167@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200605101833_MC3-1-BF57-9736@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060510145426.88957.qmail@web51014.mail.yahoo.com>

On Wed, 10 May 2006 07:54:26 -0700, Matthew L Foster wrote:

> Found this in the log this morning. Dunno if it's relevant but I don't have swap enabled in my
> config.
> 
> BUG: unable to handle kernel paging request at virtual address 04000004
>  printing eip:
> c015568b
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT 
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c015568b>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.17-rc3-git8 #10) 
> EIP is at prune_dcache+0xbf/0x138
> eax: 04000000   ebx: d895122c   ecx: d8951250   edx: c14553cc
> esi: d8951238   edi: 00000050   ebp: dff3aed8   esp: dff3aecc
> ds: 007b   es: 007b   ss: 0068
> Process kswapd0 (pid: 127, threadinfo=dff3a000 task=dff360d0)
> Stack: <0>00006720 dffeeb00 00000081 dff3aee0 c015571e dff3af18 c0132e82 00000080 
>        000000d0 00000000 000000d0 0019c800 00000000 0019c800 00000080 00000000 
>        00000000 c02f9720 c02f9720 dff3af98 c0133cd7 00000000 000000d0 0001d60d 
> Call Trace:
>  <c01032f8> show_stack_log_lvl+0x8c/0x96   <c0103457> show_registers+0x120/0x18c
>  <c0103620> die+0x15d/0x229   <c010f571> do_page_fault+0x444/0x527
>  <c0102dab> error_code+0x4f/0x54   <c015571e> shrink_dcache_memory+0x1a/0x32
>  <c0132e82> shrink_slab+0xd8/0x13f   <c0133cd7> balance_pgdat+0x1f9/0x2fc
>  <c0133f10> kswapd+0xdd/0xdf   <c0101005> kernel_thread_helper+0x5/0xb
> Code: c0 ff 4a 14 8b 42 08 a8 08 74 72 e8 82 10 15 00 eb 6b a8 10 75 1f 83 c8 10 8d 71 e8 89 43 04 8b 41 e8 8b 56 04 85 c0 89 02 74 03 <89> 50 04 c7 46 04 00 02 20 00 8d 4b 2c 8b 53 2c 8b 41 04 89 42 
> EIP: [<c015568b>] prune_dcache+0xbf/0x138 SS:ESP 0068:dff3aecc

Code;  c0155676 No symbols available
  16:   83 c8 10                  or     $0x10,%eax
Code;  c0155679 No symbols available
  19:   8d 71 e8                  lea    0xffffffe8(%ecx),%esi
Code;  c015567c No symbols available
  1c:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c015567f No symbols available
  1f:   8b 41 e8                  mov    0xffffffe8(%ecx),%eax
Code;  c0155682 No symbols available
  22:   8b 56 04                  mov    0x4(%esi),%edx
Code;  c0155685 No symbols available
  25:   85 c0                     test   %eax,%eax
Code;  c0155687 No symbols available
  27:   89 02                     mov    %eax,(%edx)
Code;  c0155689 No symbols available
  29:   74 03                     je     2e <_EIP+0x2e>
Code;  c015568b No symbols available   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c015568e No symbols available
   3:   c7 46 04 00 02 20 00      movl   $0x200200,0x4(%esi)
Code;  c0155695 No symbols available
   a:   8d 4b 2c                  lea    0x2c(%ebx),%ecx
Code;  c0155698 No symbols available
   d:   8b 53 2c                  mov    0x2c(%ebx),%edx
Code;  c015569b No symbols available
  10:   8b 41 04                  mov    0x4(%ecx),%eax

Tracing through the nested inline functions:

prune_dcache
  prune_one_dentry
    __d_drop
      hlist_del_rcu
        __hlist_del

static inline void __hlist_del(struct hlist_node *n)
{
        struct hlist_node *next = n->next;
        struct hlist_node **pprev = n->pprev;
        *pprev = next;
        if (next)
                next->pprev = pprev;    <========== OOPS
}

next (in register eax) was not zero, but has only one bit set.
Looks like a bit flipped in memory.  Please run memtest86
overnight on the machine.




-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

