Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWCPCKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWCPCKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWCPCKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:10:47 -0500
Received: from mx.pathscale.com ([64.160.42.68]:64385 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751018AbWCPCKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:10:47 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <ada3bhjuph2.fsf@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 18:11:09 -0800
Message-Id: <1142475069.6994.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 17:51 -0800, Roland Dreier wrote:

> However, we turn on the VM_* flag christmas
>  > tree, in a frenzied effort to make the kernel pay no attention:
>  > VM_DONTCOPY | VM_DONTEXPAND | VM_IO | VM_SHM | VM_LOCKED.
> 
> I don't think you need to do anything beyond io_remap_pfn_range().
> Look at the comment inside remap_pfn_range() in mm/memory.c.
> You may want VM_DONTCOPY for fork() handling I guess.

I think we need VM_DONTCOPY for fork, as you say, and probably
VM_DONTEXPAND (for mremap).  I don't know why VM_LOCKED is there, since
it seems to be internal to the mm machinery.  It looks like it might be
the kernel's equivalent of MCL_FUTURE?

> As a side note, why do you use both dma_alloc_coherent() and
> pci_alloc_consistent()?

I use dma_alloc_coherent when I need to specify the GFP flags,
pci_alloc_consistent when I don't.  If you'd rather see only one used,
I'll just drop pci_alloc_consistent.

> You probably want VM_RESERVED.  

I'll try it.

> I don't think you want VM_IO (these
> pages are in RAM),

Probably not.  The reason some of these flags crept in is that other
drivers use them to try and keep the kernel from paging the pages in
question.  I'm pretty sure VM_IO is in that category, and likely
VM_LOCKED as mentioned above, too.

>  and there's not much point to VM_SHM, since it's
> currently defined as:
> 
> #define VM_SHM          0x00000000      /* Means nothing: delete it later */

I think that's another everyone-else-is-doing-it flag.  It only became
zero in 2.6.15-rcX.

>  > The nopage handler looks very normal, except it does a get_page on
>  > pages marked with IPATH_VM_PIOAVAILREGS, but not on others.  Presumably
>  > this is because they've had SetPageReserved set on them.
> 
> I think you should always be doing a get_page().

Yeah.  I think so too, but when I do it, I get an oops.

	<b

