Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVHDOA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVHDOA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVHDN6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 09:58:46 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:31939 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262544AbVHDN5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 09:57:33 -0400
Subject: Re: How to get the physical page addresses from a kernel virtual
	address for DMA SG List?
From: Steven Rostedt <rostedt@goodmis.org>
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: LKML List <linux-kernel@vger.kernel.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>
In-Reply-To: <42F21A86.8030408@anagramm.de>
References: <42F20CEC.60206@anagramm.de>
	 <Pine.LNX.4.61.0508040900300.3410@chaos.analogic.com>
	 <42F21A86.8030408@anagramm.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 04 Aug 2005 09:57:26 -0400
Message-Id: <1123163846.12009.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 15:39 +0200, Clemens Koller wrote:
> > You are trying to do it backwards. You need to have your driver
> > use get_dma_pages() to acquire pages suitable for DMA. Your
> > driver then impliments mmap().
> 
> Okay, I have seen that, too. I've seen that some drivers do it the other
> way around as I do, but I still try to follow my idea that the
> application allocs the memory and the dma / the driver fills it up.
> Or are there fundamental problems I get with my approach which I haven't seen yet?

The driver doing the allocation would probably be easier.  Do you mean
that the application will do some large malloc and then pass that
address to the driver?  The driver would then need to map in those pages
since most of them would probably not be even allocated yet (no physical
memory associated to them).  Then there's always the point to prevent
abuse by the user.  If the driver did the allocation, it would just be
easier to control.

> 
> > The user-mode application then mmaps() the dma-able pages into
> > its address-space. FYI, the pages may be from anywhere, some
> > archs can only DMA to/from memory below 16MB.
> 
> My DMA machine (ppc32, mpc8540 cpu) can do the whole 32bit phys address
> space so, that's not an issue here.

I guess you don't mind that your driver will be locked to a specific
architecture. Or at least one that can handle these requirements. Is
this just for a single use?

> 
> > The pages do not have
> > to be continuous because you will build a scatter-list for
> > the DMA engine and you will mmap() the pages so they are
> > contiguous to the user.
> 
> Yes, only virtual space is contigous. The DMA can do nice
> sg_lists and chained sg_lists, so, this should not be a problem,
> too.
> 
> > Also 400 Megabytes is absurd.
> 
> Why?
> Actually I am planning to alloc more than 1.5GByte at once,
> lock that down, build a big sg_list for all that memory because
> I need to _continously_ feed it with data from the DMA. I get
> about 200MBytes/sec and I cannot stop in between!

Wow! what a system you must have :-)   With a 32 bit address space that
really does take a big chunck out of it.  Well I guess whatever device
this driver is for must be for some specific architecture.

-- Steve


