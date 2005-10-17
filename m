Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVJQT0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVJQT0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVJQT0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:26:46 -0400
Received: from serv01.siteground.net ([70.85.91.68]:56197 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751093AbVJQT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:26:45 -0400
Date: Mon, 17 Oct 2005 12:26:37 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org, linville@tuxdriver.com
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051017192637.GC4959@localhost.localdomain>
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de> <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org> <200510171740.57614.ak@suse.de> <20051017175231.GA4959@localhost.localdomain> <Pine.LNX.4.62.0510171110450.1480@schroedinger.engr.sgi.com> <1129575841.9621.15.camel@lts1.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129575841.9621.15.camel@lts1.fc.hp.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 01:04:01PM -0600, Alex Williamson wrote:
> On Mon, 2005-10-17 at 11:20 -0700, Christoph Lameter wrote:
> > On Mon, 17 Oct 2005, Ravikiran G Thirumalai wrote:
> > 
> > > Maybe someone with access to ia64 NUMA boxen can check if the NODE(0)
> > > solution works (and does not break anything) on ia64?  Chrisoph, can you help?
> > 
> > Umm... SGI does not use the swiotlb and we do not have these issues. HP 
> > does use the swiotlb on IA64. CCing John and Alex.
> ...
> > @@ -123,7 +123,7 @@
> >  	/*
> >  	 * Get IO TLB memory from the low pages
> >  	 */
> > -	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
> > +	io_tlb_start = alloc_bootmem_node(NODE_DATA(0), io_tlb_nslabs *
> 
>    HP ia64 boxes typically use a hardware I/O TLB, so this is not the
> normal case.  However, the sx1000 boxes are exactly an example that will
> break because of this assumption about memory layout.  These boxes can
> be configured to have various ratios of node local memory and
> interleaved memory.  Node local memory starts well above 4GB.
> Interleaved memory is zero-based, and described in it's own proximity
> domain.  It therefore looks like a memory-only node.  I believe the
> above code change would cause us to allocate memory from the node local
> range, way too high in the address space for bounce buffers.

This memory only node has a node id? Then how about a patch which iterates over 
nodes in swiotlb.c, trying to allocate DMA'ble memory from node 0 and above
until it gets proper memory for swiotlb?

Would that be accepatble?  I can quickly make a patch for that if it is
acceptable..

Thanks,
Kiran
