Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUIJOQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUIJOQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUIJOQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:16:12 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36304 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267416AbUIJOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:15:58 -0400
Date: Fri, 10 Sep 2004 15:15:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: having problems with remap_page_range() and virt_to_phys()
In-Reply-To: <4140EEDA.2040909@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0409101501530.16728-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2004, Chris Friesen wrote:

> I'm trying to allocate a page of in-kernel memory and make it accessable to 
> userspace and to late asm code where we don't have virtual memory enabled.
> 
> I'm running code essentially equivalent to the following, where "map_addr" is a 
> virtual address passed in by userspace, and "vma" is the appropriate one for 
> that address:
> 
> struct page *pg = alloc_page(GFP_KERNEL);

You will need to SetPageReserved(pg) for remap_page_range to map it.
And no, remembering your earlier pleas, the MM system doesn't clean
up for you, you'll need to ClearPageReserved and free the page when
it's all done with (if ever).

> void *virt = page_address(pg);
> unsigned long phys = virt_to_phys(virt)
> remap_page_range(vma, map_addr, phys, PAGE_SIZE, vma->vm_page_prot)
> 
> The problem that I'm having is that after the call to remap_page_range, the 
> result of
> 
> virt_to_phys(map_addr)

virt_to_phys applies to the kernel virtual address (what you name "virt"
above), it won't work on a user virtual address, that's something else.

> is not equal to "phys", and I assume it should be since its supposed to be 
> pointing to the same physical page as "virt".
> 
> Anyone have any ideas?  I can't post the exact code right now since the machine 
> is at work and hung (Oops.) but I could post it tomorrow if that is necessary.
> 
> I'm using 2.6.5 for ppc, if it makes any difference.

I'm not a user of remap_page_range (just someone who one day wants
to get rid of PageReserved and incidentally lift that SetPageReserved
restriction), not the best person to advise you.  But there are plenty
of examples of using remap_page_range in the kernel source tree, maybe
not all of them quite correct, but I'd have thought you could work out
what you need from those examples.

Hugh

