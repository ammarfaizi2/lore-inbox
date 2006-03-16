Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWCPA4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWCPA4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCPA4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:56:03 -0500
Received: from mx.pathscale.com ([64.160.42.68]:16362 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751333AbWCPA4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:56:02 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060309163740.0b589ea4.akpm@osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 16:56:19 -0800
Message-Id: <1142470579.6994.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 16:37 -0800, Andrew Morton wrote:

> If your driver allocated these pages and never added them to the LRU then
> the VM won't touch them.

We have a rather complex set of user memory mappings.  Let me describe
what's going on.

We use get_user_pages to pin user pages, but I'm 85% sure that our
acquisition and release of user pages is just fine (mostly because the
protocol for get_user_pages/free_page is simple).  It's all the other
stuff I'm worried about.  So here goes ...

There are five (yes, really) different kinds of thing we mmap into
userspace.

The first two are windows onto the chip's MMIO space; we create mappings
for userspace in our mmap code using io_remap_pfn_range.

- General user-oriented chip registers.

- Chip PIO buffers.

We don't do any funnies with get_page/SetPageReserved (or the new
vm_insert_page) on these.  However, we turn on the VM_* flag christmas
tree, in a frenzied effort to make the kernel pay no attention:
VM_DONTCOPY | VM_DONTEXPAND | VM_IO | VM_SHM | VM_LOCKED.

I'm pretty sure this is wrong, but I have no idea what right would look
like.

The next three kinds or memory are allocated with dma_alloc_coherent
(first two) or pci_alloc_consistent (last).  We have a nopage handler
that knows how to deal with them.  We set the low two bits of
vma->vm_private_data to tell the nopage handler what kind of memory it
is dealing with.

- IPATH_VM_RCVEGRBUFS: Memory that the driver allocates for the chip
  to DMA small ("eager") messages into.  Read-only for userspace.  We
  mark these pages with SetPageReserved.

- IPATH_VM_RCVHDRQ: A table of queue headers, again DMAed into by the
  chip.  Read and written by userspace.  We mark these pages with
  SetPageReserved.

- IPATH_VM_PIOAVAILREGS: A table of buffer availability
  registers.  DMAed into by the chip.  Read-only for userspace.  Not
  marked with SetPageReserved.

Once again, we sprinkle heaps of VM_* flags all over the freshly baked
mapping: VM_DONTEXPAND | VM_DONTCOPY | VM_RESERVED | VM_IO | VM_SHM

Some of these mappings are exactly one page in size, some are more.

The nopage handler looks very normal, except it does a get_page on
pages marked with IPATH_VM_PIOAVAILREGS, but not on others.  Presumably
this is because they've had SetPageReserved set on them.

I won't claim that any of this was ever even slightly correct, but we at
least got away with it from mid-2.5 kernels until 2.6.15.  Now we're
apparently being so ill-behaved that the entire box locks up when we run
"hello, world".

These interfaces have changed a lot recently, and surely there are many
people who know better than I what we ought to be doing.  I'm personally
stumped.  The current code makes no real sense to me, but I have no
outline in my head of what we should be doing instead.

Things about which I am confused:

I don't know what to to protect chip memory that I'm mapping into
userspace.

I think I shouldn't be calling SetPageReserved at all, but I don't know
what I should be doing instead.  Naively using get_page instead just
gets me a big crash.

I'll be happy to show off specific hunks of code if you think they'll
help you to understand what's going on, so that you can suggest a better
way.

	<b

