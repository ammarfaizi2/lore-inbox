Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbUKBVXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUKBVXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUKBVXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:23:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:45257 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261413AbUKBVWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:22:49 -0500
Message-ID: <4187FA6D.3070604@us.ibm.com>
Date: Tue, 02 Nov 2004 13:21:49 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrea@novell.com
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64) 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

> From: Andrea Arcangeli <andrea@novell.com>
> 
> - fix silent memleak in the pageattr code that I found while searching
>   for the bug Andi fixed in the second patch below (basically reference
>   counting in split page was done on the pmd instead of the pte).
> 
> - Part of this patch is also needed to make the above work on x86 (otherwise
>   one of my new above BUGS() will trigger signalling the fact a bug was
>   there).  The below patch creates a subtle dependency that (_PAGE_PCD << 24)
>   must not be zero.  It's not the cleanest thing ever, but since it's an
>   hardware bitflag I doubt it's going to break.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> Signed-off-by: Andrea Arcangeli <andrea@novell.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  25-akpm/arch/i386/mm/ioremap.c    |    4 ++--
>  25-akpm/arch/i386/mm/pageattr.c   |   13 +++++++------
>  25-akpm/arch/x86_64/mm/ioremap.c  |   14 +++++++-------
>  25-akpm/arch/x86_64/mm/pageattr.c |   23 ++++++++++++++---------
>  4 files changed, 30 insertions(+), 24 deletions(-)

is hitting this BUG() during bootup:

        /* memleak and potential failed 2M page regeneration */
        BUG_ON(!page_count(kpte_page));

in 2.6.10-rc1-mm2.

Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511144k/524288k available (1856k kernel code, 12608k reserved, 
1186k data, 164k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
------------[ cut here ]------------
kernel BUG at arch/i386/mm/pageattr.c:136!
invalid operand: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in:
CPU:    0
EIP:    0060:[<c0113f48>]    Not tainted VLI
EFLAGS: 00010046   (2.6.10-rc1-mm2)
EIP is at __change_page_attr+0x28c/0x358
eax: ffffffff   ebx: 017ff163   ecx: 00000000   edx: c10001e0
esi: 00000000   edi: c000fff8   ebp: c10001e0   esp: c03f9d98
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03f9000 task=c0345b40)
Stack: c102ffe0 00000000 00000000 00000046 c0113ceb c17f9000 c102ff20
        c102ff20 017ff163 00000000 017ff163 00000000 c0113ceb c17fe000
        c102ffc0 c102ffc0 c1000000 c17ff000 c000fff8 017ff163 00000000
        017ff163 00000000 00000000
Call Trace:
  [<c0113ceb>] __change_page_attr+0x2f/0x358
  [<c0113ceb>] __change_page_attr+0x2f/0x358
  [<c011404a>] change_page_attr+0x36/0x54
  [<c0114148>] kernel_map_pages+0x30/0x5f
  [<c0137d80>] __alloc_pages+0x340/0x350
  [<c0137dad>] __get_free_pages+0x1d/0x30
  [<c013adfa>] kmem_getpages+0x26/0xd4
  [<c013c221>] cache_grow+0xb1/0x150
  [<c013c84a>] cache_alloc_refill+0x232/0x280
  [<c013ccbe>] kmem_cache_alloc+0x5a/0x78
  [<c01d4970>] idr_pre_get+0x1c/0x44
  [<c0181b60>] sysfs_fill_super+0x0/0xa4
  [<c01572cc>] set_anon_super+0x10/0xb8
  [<c0156cff>] sget+0xb3/0x148
  [<c0181b60>] sysfs_fill_super+0x0/0xa4
  [<c0157636>] get_sb_single+0x26/0x8c
  [<c0157608>] compare_single+0x0/0x8
  [<c01572bc>] set_anon_super+0x0/0xb8
  [<c0181c1d>] sysfs_get_sb+0x19/0x1d
  [<c0181b60>] sysfs_fill_super+0x0/0xa4
  [<c01576ea>] do_kern_mount+0x4e/0xd0
  [<c015777d>] kern_mount+0x11/0x15
  [<c0409962>] sysfs_init+0x1e/0x50
  [<c0409430>] mnt_init+0xb4/0xc0
  [<c040917a>] vfs_caches_init+0x7e/0x94
  [<c03fa831>] start_kernel+0x12d/0x150
Code: c7 0f 75 f5 f0 ff 4d 04 eb 08 0f 0b 85 00 88 c1 2d c0 8b 45 00 89 
ea f6 c4 80 74 07 8b 55 0c 8d 74 26 00 8b 42 04 83 f8 ff 75 08 <0f> 0b 
88 00 88 c1 2d c0 a1 ac 6c 34 c0 a8 08 0f 84 aa 00 00 00

I'm tracking down now to see exactly what's going on.  This just a 
regular, plain 4-way x86 box with 4GB of RAM.  Removing that BUG_ON() 
lets me boot just fine.

kpte: c000fff8
address: c17ff000
kpte_page: c10001e0
pgprot_val(prot): 00000163
pgprot_val(PAGE_KERNEL): 00000163
(pte_val(*kpte) & _PAGE_PSE): 00000000
