Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVHDRFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVHDRFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 13:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVHDRDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 13:03:07 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:38272 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262560AbVHDRBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 13:01:54 -0400
Subject: Re: How to get the physical page addresses from a kernel
	virtualaddress for DMA SG List?
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Clemens Koller <clemens.koller@anagramm.de>,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508041009350.3645@chaos.analogic.com>
References: <42F20CEC.60206@anagramm.de>
	 <Pine.LNX.4.61.0508040900300.3410@chaos.analogic.com>
	 <42F21A86.8030408@anagramm.de>
	 <1123163846.12009.15.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508041009350.3645@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 04 Aug 2005 13:01:47 -0400
Message-Id: <1123174907.12009.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 10:56 -0400, linux-os (Dick Johnson) wrote:
> On Thu, 4 Aug 2005, Steven Rostedt wrote:
> >
> > The driver doing the allocation would probably be easier.  Do you mean
> > that the application will do some large malloc and then pass that
> > address to the driver?  The driver would then need to map in those pages
> > since most of them would probably not be even allocated yet (no physical
> > memory associated to them).  Then there's always the point to prevent
> > abuse by the user.  If the driver did the allocation, it would just be
> > easier to control.
> >
[...]
> 
> The software architecture is simply wrong. He wants to DMA data
> into user-space, continuously, faster than the CPU can do anything
> with the data. If the data is anything more than an experiment
> in "how fast can DMA write to RAM", then the data needs to be
> used, i.e., processed. In the real world of high-speed data
> processing (like image processing), one writes, using DMA or
> whatever, into a buffer that is to be processed. DMA is often
> used so that more data can be received while the previously-
> received data is being processed. The buffers are usually
> allocated as a linked-list or as a pair of buffers to be
> ping/ponged. Allocating a gigantic buffer for any purpose,
> including sorting databases, is simply wrong.
> 

I just figured that his system was something unique and that he knows
what he's doing in regard to that.

> Data processing involves accessing data in arrays or
> structures that emulate arrays of aggregate types. This
> means that nearby elements are usually accessed, not elements
> that are randomly scattered throughout address-space. This
> locality of action is well known and is in fact why
> paging is possible to provide virtual address-space.
> 
> Allocation of DMA pages by the user will fail. This is
> because many of the user's pages will likely point to
> the exact same page of (probably non-existant) RAM.
> That's how a virtual memory system works. In fact,
> allocation of virtual address space from user-mode
> just tells the kernel not to seg-fault the user if
> an access is made that hasn't been allocated yet.

[snip long explaination of the VM layer]

> 
> This is why the driver must obtain the DMA pages and
> the user must use mmap() to map those pages into its
> address space. It's not a matter of being "easier",
> it's a matter of it being the only way that will work.

Well it definitely looks easier to me :-) I wouldn't say it's the only
way it will work, I would be kinder and say any other way would be
excruciatingly harder! As you explained.

> 
> Also, if Mr. Koller insists upon doing the absurd, i.e.,
> allocating gigabytes of DMA RAM, he is going to have to
> reserve memory that only his driver knows about, using
> the "mem=" parameter on the boot command line. Then the
> "extra" RAM above the kernel can be mapped using
> ioremap_nocache() and made available for DMA and mmap().
> 

Yeah the reserving of 1.5+G would be difficult in a 32 bit address
space. But I'm sure there's ways around it.

He never actually said what his goal was. This could be simply academic,
I don't know.  But if he got it to work, at least that would be cool.
(although I would never do such a thing in the "real" world ;-)


-- Steve


