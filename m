Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTLJApV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTLJApV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:45:21 -0500
Received: from fmr05.intel.com ([134.134.136.6]:21155 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262288AbTLJApP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:45:15 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Re: memory hotremove prototype, take 3
Date: Tue, 9 Dec 2003 16:45:10 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F4FAF4A@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: memory hotremove prototype, take 3
Thread-Index: AcO+tt10ki/3CahcSt6Lu7uzxRl0tA==
From: "Luck, Tony" <tony.luck@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Dec 2003 00:45:11.0229 (UTC) FILETIME=[DDE036D0:01C3BEB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If your target is NUMA, then you really, really need CONFIG_NONLINEAR.
> We don't support multiple pgdats per node, nor do I wish to, as it'll
> make an unholy mess ;-). With CONFIG_NONLINEAR, the discontiguities
> within a node are buried down further, so we have much less complexity
> to deal with from the main VM. The abstraction also keeps the poor
> VM engineers trying to read / write the code saner via simplicity ;-)
> 
> WRT generic discontigmem support (not NUMA), doing that via pgdats
> should really go away, as there's no real difference between the 
> chunks of physical memory as far as the page allocator is concerned.
> The plan is to use Daniel's nonlinear stuff to replace that, and keep
> the pgdats strictly for NUMA. Same would apply to hotpluggable zones - 
> I'd hate to end up with 512 pgdats of stuff that are really all the
> same memory types underneath.

I guess this all depends on whether you allow bits of memory on
nodes to be hot-plugged ... or insist on the whole node being
added/removed in one fell swoop.  I'd expect the latter to be
a more common model, and in that case the "pgdat-for-the-node" is
the same as the "pgdat-for-the-hot-plug-zone", so you don't have
a proliferation of pgdats to support hotplug.

> The real issue you have is the mapping of the struct pages - if we can
> achieve a non-contig mapping of the mem_map / lmem_map array, we should
> be able to take memory on and offline reasonably easy. If you're willing
> for a first implementation to pre-allocate the struct page array for 
> every possible virtual address, it makes life a lot easier.

On 64-bit systems with CONFIG_VIRTUAL_MEMMAP, this would be trivial,
and avoids the need for the extra level of indirection in the psection[]
and vection[] arrays in CONFIG_NONLINEAR (ok ... it doesn't really get
rid of the indirection, as the page table lookup to access the virtual
mem_map effectively ends up doing the same thing).
 
> Adding the other layer of indirection for access the struct page array
> should fix up most of that, and is very easily abstracted out via the
> pfn_to_page macros and friends. I ripped out all the direct references
> to mem_map indexing already in 2.6, so it should all be nicely 
> abstracted out.

I did go back and look at the CONFIG_NONLINEAR patch again, and I
still can't see how to make it useful on 64-bit machines. Jack
Steiner asked a bunch of questions on how it would work for an
architecture like the SGI:
http://marc.theaimsgroup.com/?l=lse-tech&m=101828803506249&w=2
I don't remember seeing any answers on the list.  Assuming he
were to use a section size of 64MB (a convenient number for ia64)
he'd end up with psection[]/vsection[] tables with 8 million
entries each (@ 4 bytes/entry -> 64MB for the pair).

-Tony Luck  

