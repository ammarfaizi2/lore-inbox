Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271640AbRIBQnb>; Sun, 2 Sep 2001 12:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271641AbRIBQnM>; Sun, 2 Sep 2001 12:43:12 -0400
Received: from quattro.sventech.com ([205.252.248.110]:6150 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S271640AbRIBQnD>; Sun, 2 Sep 2001 12:43:03 -0400
Date: Sun, 2 Sep 2001 12:43:22 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_alloc_consistent for small allocations?
Message-ID: <20010902124321.G9175@sventech.com>
In-Reply-To: <200109021508.IAA29875@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200109021508.IAA29875@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Sep 02, 2001 at 08:08:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001, Adam J. Richter <adam@yggdrasil.com> wrote:
> 	In looking at the ieee1394 OHCI driver, I noticed that it
> appears to make 104 calls to pci_alloc_consistent for data structures
> that are 16 or 64 bytes.  Currently, on x86, pci_alloc_consistent
> allocates at least one full page per call, so it looks like the
> ohci1394 driver allocates 416kB per controller as a result of these
> data structures.
> 
> 	It is easy enough to change the ohci driver to just
> do a few pci_alloc_consistent calls, but, in grepping through the
> kernel, I see that there are lots of calls to pci_alloc_consistent
> calls requesting small amounts of memory.  So, I think it might reduce
> kernel memory consumption to have pci_alloc_consistent do something
> slightly smarter for allocations of less than a page.  Two pretty
> simple approaches come to mind:
> 
> 	1. If it is the case that a side effect of the slab memory allocator
> is that allocations of less than a page (or a certain size) never cross
> page boundaries, then the x86 version of pci_alloc_consistent can just
> use kmalloc/kfree when the size is below a certain amount.  Could someone
> tell me if this is the case?
> 
> 	2. Assuming that is not the case, I have written, but not yet tested,
> a change to pci_alloc_consistent for x86 where sub-page allocations can share
> a single page.  The first four bytes of a shared page are used as a
> reference counter.  This would be two bytes were it not for alignment
> considerations.  This change can only aggregate small allocations when
> they occur in succession.  I have attached the patch for illustration, but,
> it could use some better variable naming and, I repeat, I have not tested
> it at all yet.  In the middle of working on it, I thought of option #1 and
> figured I should ask on linux-kernel before investing more time in this idea.

Just use pci_pool. We developed the API for USB where we ran into the
same problem.

JE

