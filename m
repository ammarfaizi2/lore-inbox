Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUAOGYF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 01:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUAOGYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 01:24:05 -0500
Received: from rth.ninka.net ([216.101.162.244]:4480 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261973AbUAOGYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 01:24:02 -0500
Date: Wed, 14 Jan 2004 22:23:16 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jun Sun <jsun@mvista.com>
Cc: akpm@osdl.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, jsun@mvista.com
Subject: Re: [BUG] 2.6.1/MIPS - missing cache flushing when user program
 returns pages to kernel
Message-Id: <20040114222316.25276f12.davem@redhat.com>
In-Reply-To: <20040114174012.H13471@mvista.com>
References: <20040114163920.E13471@mvista.com>
	<20040114171252.4d873c51.akpm@osdl.org>
	<20040114172946.03e54706.akpm@osdl.org>
	<20040114174012.H13471@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 17:40:12 -0800
Jun Sun <jsun@mvista.com> wrote:

> Looking at my tree (which is from linux-mips.org), it appears
> arm, sparc, sparc64, and sh have tlb_start_vma() defined to call
> cache flushing.

Correct, in fact every platform where cache flushing matters
at all (ie. where flush_cache_*() routines actually need to
flush a cpu cache), they should have tlb_start_vma() do such
a flush.

> What exactly does tlb_start_vma()/tlb_end_vma() mean?  There is
> only one invocation instance, which is significant enough to infer
> the meaning.  :)

When the kernel unmaps a mmap region of a process (either for the
sake of munmap() or tearing down all mapping during exit()) tlb_start_vma()
is called, the page table mappings in the region are torn down one by
one, then a tlb_end_vma() call is made.

At the top level, ie. whoever invokes unmap_page_range(), there will
be a tlb_gather_mmu() call.

In order to properly optimize the cache flushes, most platforms do the
following:

1) The tlb->fullmm boolean keeps trap of whether this is just a munmap()
   unmapping operation (if zero) or a full address space teardown
   (if non-zero).

2) In the full address space teardown case, and thus tlb->fullmm is
   non-zero, the top level will do the explict flush_cache_mm()
   (see mm/mmap.c:exit_mmap()), therefore the tlb_start_vma()
   implementation need not do the flush, otherwise it does.

   This is why sparc64 and friends implement it like this:

#define tlb_start_vma(tlb, vma) \
do {    if (!(tlb)->fullmm)     \
                flush_cache_range(vma, vma->vm_start, vma->vm_end); \
} while (0)

Hope this clears things up.

Someone should probably take what I just wrote, expand and organize it,
then add such content to Documentation/cachetlb.txt
