Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVLPLc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVLPLc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVLPLc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:32:56 -0500
Received: from ulysse.ugr.be ([194.7.102.140]:30214 "EHLO ugr.be")
	by vger.kernel.org with ESMTP id S1751298AbVLPLcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:32:55 -0500
From: Laurent Pinchart <laurent.pinchart@skynet.be>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: VM_RESERVED and PG_reserved : Allocating memory for video buffers
Date: Fri, 16 Dec 2005 12:33:05 +0100
User-Agent: KMail/1.9
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200512152009.33758.laurent.pinchart@skynet.be> <43A21807.70504@yahoo.com.au>
In-Reply-To: <43A21807.70504@yahoo.com.au>
X-Face: 4Mf^tnii7k\_EnR5aobBm6Di[DZ9@AX1wJ"okBdX-UoJ>:SRn]c6DDU"qUIwfs98vF>=?utf-8?q?Tnf=0A=09SacR=7B?=(0Du"N%_.#X]"TXx)A'gKB1i7SK$CTLuy{h})c=g:'w3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512161233.05411.laurent.pinchart@skynet.be>
X-Spam-Processed: ugr.be, Fri, 16 Dec 2005 12:33:36 +0100
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 194.7.220.151
X-Return-Path: laurent.pinchart@skynet.be
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: ugr.be, Fri, 16 Dec 2005 12:33:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 December 2005 02:27, Nick Piggin wrote:
> Laurent Pinchart wrote:
> > Hi everybody,
> >
> > I'm writing a Linux driver for a USB Video Class compliant USB device. I
> > manage to understand pretty much everything on my own until the point
> > where I have to allocate video buffers.
> >
> > I read other drivers to understand how they proceed. Most of them used
> > vmalloc with SetPageReserved and remap_pfn_range to map the memory to
> > user space. I thought I understood that, when I noticed that
> > vm_insert_page has been added in 2.6.15. I wasn't sure how to prevent
> > pages from being swapped out, so I read the excellent "Understanding the
> > Linux Virtual Memory Manager", but I'm still not sure to understand
> > everything. This is where I ask for your help.
> >
> > I need to allocate big buffers, so vmalloc is the way to go, as I don't
> > need contiguous memory. I need to map those buffers to user space, and I
> > understand that vm_insert_page will do the job nicely. My fears come from
> > pages being swapped out. I suppose I need to prevent that, as a page
> > fault in interrupt is a Bad Thing(TM). I'm not sure how PG_reserved and
> > VM_RESERVED interract with eachother. Can kernel pages be swapped out if
> > they are not mapped to user space ? Or does kswapd only walk VMAs when it
> > tries to find pages that will be swapped out ? If the later is true, is
> > it enough to set VM_RESERVED on the VMA in the mmap handler ?
>
> PG_reserved no longer does anything (except catching bugs in old code).
> If you are writing new code, you shouldn't use it. Don't copy rvmalloc,
> you should be able to use vmalloc directly.
>
> vm_insert_page is indeed the right interface for mapping these pages
> into userspace.

Ok, that's what I intended to do.

> You do not have to worry about pages being swapped out, and you shouldn't
> need to set any unusual vma or page flags. kswapd only walks the lru lists,
> and it won't even look at any other pages.

I'd still like to understand how things work (I'm one of those programmers who 
don't like to code without understanding).

I think I understand how disk buffers or non-shared pages mapped by a regular 
file can be reclaimed, but I have trouble with anonymous pages and shared 
pages.

First of all, I haven't been to find a definition of an anonymous page. I 
understand it as a page of memory not backed by a file (pages allocated by 
vmalloc for instance). If this is wrong, what I'm about to say if probably 
very wrong as well.

Are anonymous pages ever added to the LRU active list ? I suppose they are 
not, which is why they are not reclaimed.

How does the kernel handle shared pages, (if for instance two processes map a 
regular file with MAP_SHARED) ? They can't be reclaimed before all processes 
which map them have had their PTEs modified. Is this where reverse mapping 
comes into play ?

Finally, how are devices which map anonymous kernel memory to user space 
handled ? When a page is inserted in a process VMA using vm_insert_page, it 
becomes shared between the kernel and user space. Does the kernel see the 
page as a regular device backed page, and put it in the LRU active list ? You 
said I shouldn't need to set any unusual VMA or page flags. What's the exact 
purpose of VM_RESERVED and VM_IO then ? And when should they be set ?

Hope I'm not bothering you too much with all those questions. I don't feel at 
ease when developping kernel code if I don't have at least a basic 
understanding of what I'm doing.

Laurent Pinchart

