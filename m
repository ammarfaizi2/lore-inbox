Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVDZWOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVDZWOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVDZWOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:14:12 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:28121 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261813AbVDZWOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:14:04 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: returning non-ram via ->nopage, was Re: [patch] mspec driver for 2.6.12-rc2-mm3
References: <16987.39773.267117.925489@jaguar.mkp.net>
	<20050412032747.51c0c514.akpm@osdl.org>
	<yq07jj8123j.fsf@jaguar.mkp.net>
	<20050413204335.GA17012@infradead.org>
	<yq08y3bys4e.fsf@jaguar.mkp.net>
	<20050424101615.GA22393@infradead.org>
	<yq03btftb9u.fsf@jaguar.mkp.net>
	<20050425144749.GA10093@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 26 Apr 2005 18:14:02 -0400
In-Reply-To: <20050425144749.GA10093@infradead.org>
Message-ID: <yq0ll75rxsl.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> http://marc.theaimsgroup.com/?l=linux-kernel&m=111416930927092&w=2),
Christoph> which has a nopage routine that calls remap_pfn_range from
Christoph> ->nopage for uncached memory that's not part of the mem
Christoph> map.  Because ->nopage wants to return a struct page * he's
Christoph> allocating a normal kernel page and actually returns that
Christoph> one - to get the page he wants into the pagetables his does
Christoph> all the pagetable manipulation himself before (See the
Christoph> glory details of pagetable walks and modification inside a
Christoph> driver in the patch above).

Christoph> I don't think these hacks are acceptable for a driver,
Christoph> especially as the problem can easily be solved by calling
Christoph> remap_pfn_range in ->mmap - except SGI also wants node
Christoph> locality..

Christoph,

Let me try and provide some more background then.

Simply doing remap_pfn_range in the mmap call doesn't work for large
systems.

Take the example of a 2048 CPU system (512 CPUs per partition/machine
- each machine running it's own OS) running an MPI application
across all 2048 CPUs using cross coherency domain traffic.

A standard application will allocate 56 DDQs per thread (the DDQs are
used for synchronization and allocated through the mspec driver) which
translates to having 126976 uncached cache lines reserved or 992 pages
per worker thread. The controlling thread on each partition will mmap
the entire DDQ space up front and then fork off the workers who will
then go and touch their pages. With the current approach by the driver
this means that if you have two threads per node you will end up with
~32MB of uncached memory allocated per node.

Alternatively doing this at mmap time having 512 worker threads per
partition, the result is ~8GB (992 * 16K * 512) of uncached memory all
allocated by the master thread on each machine.

A typical system configuration is 4GB or 8GB of RAM per node. This
means that by using the remap_pfn_range at mmap time approach and the
kernel's standard overhead you end up completely starving the first
couple of nodes of memory on each partition.

Combine this with the effect of all synchronization traffic hitting
the same node, you effectively end up with 512 CPUs all constantly
hammering the same memory controller to death.

FWIW, an initial implementation of the driver was done by someone
within SGI, prior to me having anything to do with it. It was using
the remap_pfn_range at mmap time approach and it was noticed then that
16 worker threads was pretty much enough to overwhelm a node.

Having the page allocations and drop ins on a first touch basis is
consistent with what is done for cached memory and seems a pretty
reasonable approach to me. Sure it isn't particularly pretty to use
the ->nopage approach, nobody disagrees with you there, but what is
the alternative?

Is the problem more an issue of the ugliness of allocating a page
just to return it to the nopage handler or the fact that we're trying
to make the allocations node local?

If you have any suggestions for how to do this differently, then I'm
all ears.

Cheers,
Jes

PS: Thanks to Robin Holt for providing more info on MPI application
behavior than I ever wanted to know ;-)
