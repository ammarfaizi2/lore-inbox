Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTJMKbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTJMKbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:31:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:6805 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261656AbTJMKbn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:31:43 -0400
Date: Mon, 13 Oct 2003 03:34:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?UmFt824=?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test7-bk][OOPS] Unable to handle kernel paging request
 at virtual address f9a7e857
Message-Id: <20031013033459.3519f83b.akpm@osdl.org>
In-Reply-To: <1065959373.1111.13.camel@debian>
References: <1065959373.1111.13.camel@debian>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramón Rey Vicente <ramon.rey@hispalinux.es> wrote:
>
> Unable to handle kernel paging request at virtual address f9a7e857
>   printing eip:
>  c0169361
>  *pde = 00000000
>  Oops: 0000 [#2]
>  CPU:    0
>  EIP:    0060:[<c0169361>]    Not tainted
>  EFLAGS: 00010217
>  EIP is at mpage_readpages+0x41/0x140
>  eax: c01602af   ebx: f9a7e853   ecx: caab053c   edx: caab053c
>  esi: f9a7e84b   edi: 00000000   ebp: caab072c   esp: cfe03e04
>  ds: 007b   es: 007b   ss: 0068  
>  Process kswapd0 (pid: 8, threadinfo=cfe02000 task=cfe08ca0)
>  Stack: 00000000 00000000 00000000 00000000 cfe03e10 00000000 c02ef348
>  c011e55a
>         00000000 00000001 c011e36c 00000046 cfe02000 00000000 00000000
>  c02cca00
>         c010aaef c0273900 c80b5f40 c80b6c8c cfe02000 00000028 caab072c
>  caab072c
>  Call Trace:
>   [<c011e55a>] tasklet_action+0x3a/0x60
>   [<c011e36c>] do_softirq+0x8c/0xa0
>   [<c010aaef>] do_IRQ+0xef/0x120
>   [<c0180536>] ext3_readpages+0x16/0x20
>   [<c01602af>] prune_dcache+0x14f/0x1c0
>   [<c017f840>] ext3_get_block+0x0/0x80
>   [<c0162b23>] iput+0x63/0x80
>   [<c01602af>] prune_dcache+0x14f/0x1c0
>   [<c0160753>] shrink_dcache_memory+0x33/0x40
>   [<c013a508>] shrink_slab+0x108/0x160
>   [<c013b783>] balance_pgdat+0x1c3/0x1e0
>   [<c013b89e>] kswapd+0xfe/0x120
>   [<c0118c60>] autoremove_wake_function+0x0/0x40
>   [<c0108ed6>] ret_from_fork+0x6/0x20
>   [<c0118c60>] autoremove_wake_function+0x0/0x40
>   [<c013b7a0>] kswapd+0x0/0x120
>   [<c0107061>] kernel_thread_helper+0x5/0x24

You get the award for the weirdest bug report of the 21st century.  There
is just no way in which kswapd can call ->readpages().

The only thing I can think of is that an inode's superblock's ->put_inode
pointer somehow got set to point at ext3_readpages().  Or we got a
completely wild pointer in prune_dcache().  Some sort of memory scribble,
anyway.

What sort of machine is it?  Nice, new and stable or old, nasty and likely
to tromp its memory?

