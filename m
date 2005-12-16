Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVLPOKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVLPOKK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLPOKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:10:10 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:36248 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932273AbVLPOKI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:10:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bwHjue4djGo28n1efzm3Q1u/Oss3amLh72ThT+hqXi1AdYBtL1dGEMG9aC6nO4tQ/z/nR7hNajzkbdHXj8lhpyn0+LzqNKM1od61jGfQbBqqJa4Lm1y/DQ0b4dpZAFl2W7cS4R3aSbS27kngwkXgyEZtxHOdc1xZsbUIBjp+5OM=
Message-ID: <d9def9db0512160610w4f544f5embc316be8c00a902a@mail.gmail.com>
Date: Fri, 16 Dec 2005 15:10:06 +0100
From: Markus Rechberger <mrechberger@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: VM_RESERVED and PG_reserved : Allocating memory for video buffers
Cc: Laurent Pinchart <laurent.pinchart@skynet.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43A2C26F.3060101@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512152009.33758.laurent.pinchart@skynet.be>
	 <43A21807.70504@yahoo.com.au>
	 <200512161233.05411.laurent.pinchart@skynet.be>
	 <43A2C26F.3060101@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Laurent Pinchart wrote:
> > On Friday 16 December 2005 02:27, Nick Piggin wrote:
>
> >>vm_insert_page is indeed the right interface for mapping these pages
> >>into userspace.
> >
> >
> > Ok, that's what I intended to do.
> >
> >
> >>You do not have to worry about pages being swapped out, and you shouldn't
> >>need to set any unusual vma or page flags. kswapd only walks the lru lists,
> >>and it won't even look at any other pages.
> >
> >
> > I'd still like to understand how things work (I'm one of those programmers who
> > don't like to code without understanding).
> >
> > I think I understand how disk buffers or non-shared pages mapped by a regular
> > file can be reclaimed, but I have trouble with anonymous pages and shared
> > pages.
> >
> > First of all, I haven't been to find a definition of an anonymous page. I
> > understand it as a page of memory not backed by a file (pages allocated by
> > vmalloc for instance). If this is wrong, what I'm about to say if probably
> > very wrong as well.
> >
>
> Anonymous memory is memory not backed by a file. However the userspace
> program will gain access to your vmalloc memory by mmaping a /dev file,
> right?
>
> So the mm kind of treats these pages as file pages (not anonymous),
> although it doesn't make much difference because it really has very little
> to do with them aside from what you see in vm_insert_page.
>
> > Are anonymous pages ever added to the LRU active list ? I suppose they are
> > not, which is why they are not reclaimed.
> >
>
> They are, see the line
>
>         lru_cache_add_active(page);
>
> in mm/memory.c:do_anonymous_page()
>
> Anonymous memory is basically memory allocated by malloc(), to put simply.
>
> Reclaiming anonymous memory involves writing it out to swap.
>
> > How does the kernel handle shared pages, (if for instance two processes map a
> > regular file with MAP_SHARED) ? They can't be reclaimed before all processes
> > which map them have had their PTEs modified. Is this where reverse mapping
> > comes into play ?
> >
>
> That's right. mm/rmap.c:try_to_unmap()
>
> > Finally, how are devices which map anonymous kernel memory to user space
> > handled ? When a page is inserted in a process VMA using vm_insert_page, it
> > becomes shared between the kernel and user space. Does the kernel see the
> > page as a regular device backed page, and put it in the LRU active list ? You
>
> No, the kernel won't do anything with it after vm_insert_page (which does
> not put it on the LRU) until the process unmaps that page, at which time
> all the accounting done by vm_insert_page is undone.
>
> > said I shouldn't need to set any unusual VMA or page flags. What's the exact
> > purpose of VM_RESERVED and VM_IO then ? And when should they be set ?
> >
>
> VM_RESERVED I think was in 2.4 to stop the swapout code looking at that
> vma. I don't think you should ever need to set it in 2.6.
>
> VM_IO should be set on memory areas that have can have side effects when
> accessing them, like memory mapped IO regions.
>

This is documented on page 421 in the ldd3

http://lwn.net/Kernel/LDD3/ chapter memory mapping and dma

VM_IO prevents memory from beeing included in coredumps

(though the ldd3 was written for 2.6.10 or so, some pieces are already
outdated but it's the most recent available one I think)

> > Hope I'm not bothering you too much with all those questions. I don't feel at
> > ease when developping kernel code if I don't have at least a basic
> > understanding of what I'm doing.
> >
>
> That's OK, hope this is of some help.
>
> --
> SUSE Labs, Novell Inc.
>
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Markus Rechberger
