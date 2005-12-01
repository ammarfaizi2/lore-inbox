Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVLAXLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVLAXLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbVLAXLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:11:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932555AbVLAXLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:11:37 -0500
Date: Thu, 1 Dec 2005 15:11:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Terence Ripperda <tripperda@nvidia.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
In-Reply-To: <20051201211119.GA11437@hygelac>
Message-ID: <Pine.LNX.4.64.0512011455090.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
 <20051201121826.GF19694@charite.de> <20051201211119.GA11437@hygelac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Dec 2005, Terence Ripperda wrote:
> 
> from looking at the new code, it looks like this is due to how we mmap
> our dma pages. due to opengl using large (multiple megabyte) push
> buffers, we allocate individual physically discontiguous pages, then
> mmap them in one call. we end up iterating over all of the pages with
> individual calls to remap_pfn_range.
> 
> it appears this new warning doesn't like that and will complain,
> unless VM_INCOMPLETE is set. when, if ever, is it valid to set
> VM_INCOMPLETE?

VM_INCOMPLETE is just an internal flag, you should never set it.

What happened is that the internal implementation of reserved pages 
changed radically in -rc1, and all the changes since have been to try to 
make sure nobody even notices. In the end, we pretty much gave up.

The new "remap_pfn_range()" is a lot more powerful, in that it much more 
simply can remap whole ranges without worrying about "struct page" at all, 
and in particular without worrying about PageReserved(), which used to be 
a magic flag saying "this page doesn't exist as far as the VM is 
concerned".

It's that "doesn't exist as far as the VM is concerned" thing that went 
away - it caused some problems and nasty complexity.

The _new_ remap_pfn_range() is really good for doing /dev/mem kind of 
remappings: large _contiguous_ ranges of pages that may not have any real 
RAM backing at all (eg a frame buffer or something). However, it got much 
worse at handling the _regular_ page case.

(Something it was never really designed for in the first place, but that 
people had done by hand by taking individual pages, marking them 
PageReserved to fool the VM, and then mapping it as a "small range": 
exactly your behaviour, in fact).

But to make things easier, we now have _another_ function that is 
expressly designed for the one-page-at-a-time behaviour:

	vm_insert_page(vma, addr, page);

which inserts the "struct page *page" at the virtual address "addr" in the 
virtual memory area "vma". It uses the page protections of the vma as the 
page protections for the page, and it verifies that the address is within 
that virtual memory area.

The nice thing about this is that you no longer need to play with 
PageReserved() at all. You can just allocate a normal kernel page, and 
insert it into user space. Which is what I think you always wanted to do 
in the first place.

>From a compatibility standpoint, you can do something like

   #ifndef WE_HAVE_VM_INSERT_PAGE

	static int vm_insert_page(struct vm_area *vma, 
		unsigned long addr,
		struct page *page)
	{
		SetPageReserved(page);
		remap_pfn_range(vma, vma->vm_start,
			page_to_pfn(page),
			PAGE_SIZE,
			vma->vm_page_prot);
	}

	static void free_one_page(struct page *page)
	{
		ClearPageReserved(page);
		__free_page(page);
	}

   #else

	#define free_one_page(x) __free_page(x)

   #endif

which should result in pretty clean code.

There's some explanation on what is going on in mm/memory.c: see the 
comments above the "vm_normal_page()" function (which you should never 
use: it's for internal VM usage, but it explains how the page range 
remapping works), and above "vm_insert_page()" (which you _should_ use).

		Linus
