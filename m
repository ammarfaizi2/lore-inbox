Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVJQTEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVJQTEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVJQTEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:04:32 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:65164 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932262AbVJQTEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:04:31 -0400
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
From: Alex Williamson <alex.williamson@hp.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org, linville@tuxdriver.com
In-Reply-To: <Pine.LNX.4.62.0510171110450.1480@schroedinger.engr.sgi.com>
References: <20051017093654.GA7652@localhost.localdomain>
	 <200510171153.56063.ak@suse.de>
	 <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org>
	 <200510171740.57614.ak@suse.de>
	 <20051017175231.GA4959@localhost.localdomain>
	 <Pine.LNX.4.62.0510171110450.1480@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 17 Oct 2005 13:04:01 -0600
Message-Id: <1129575841.9621.15.camel@lts1.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 11:20 -0700, Christoph Lameter wrote:
> On Mon, 17 Oct 2005, Ravikiran G Thirumalai wrote:
> 
> > Maybe someone with access to ia64 NUMA boxen can check if the NODE(0)
> > solution works (and does not break anything) on ia64?  Chrisoph, can you help?
> 
> Umm... SGI does not use the swiotlb and we do not have these issues. HP 
> does use the swiotlb on IA64. CCing John and Alex.
...
> @@ -123,7 +123,7 @@
>  	/*
>  	 * Get IO TLB memory from the low pages
>  	 */
> -	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
> +	io_tlb_start = alloc_bootmem_node(NODE_DATA(0), io_tlb_nslabs *

   HP ia64 boxes typically use a hardware I/O TLB, so this is not the
normal case.  However, the sx1000 boxes are exactly an example that will
break because of this assumption about memory layout.  These boxes can
be configured to have various ratios of node local memory and
interleaved memory.  Node local memory starts well above 4GB.
Interleaved memory is zero-based, and described in it's own proximity
domain.  It therefore looks like a memory-only node.  I believe the
above code change would cause us to allocate memory from the node local
range, way too high in the address space for bounce buffers.

   BTW, I've got a patch in Tony's testing branch that allows a late
initialization of the swiotlb.  This is currently only useful on ia64
since we have 4GB of ZONE_DMA, but may be useful on x86-ish archs when
the 4GB zone is introduced.

	Alex

-- 

