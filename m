Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTGBVtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbTGBVtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:49:13 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29581
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264643AbTGBVtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:49:06 -0400
Date: Thu, 3 Jul 2003 00:02:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702220246.GS23578@dualathlon.random>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random> <20030702214032.GH20413@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702214032.GH20413@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 02:40:32PM -0700, William Lee Irwin III wrote:
> On Wed, Jul 02, 2003 at 07:47:00PM +0200, Andrea Arcangeli wrote:
> > actually other more invasive ways could be to move rmap into highmem.
> > Also the page clustering could also hide part of the mem overhead by
> > assuming the pagetables to be contiguos, but page clustering isn't part
> > of mainline yet either.
> 
> BSD-style page clustering preserves virtual contiguity of a software
> page, but the new things don't; for ABI preservation, virtually
> discontiguous, partial, and misaligned mappings of pages are handled.
> 
> The desired behavior can in principle be partially recovered by
> scanning within a software page size -sized "blast radius" for each
> chain element and only chaining enough elements to find the relevant
> ptes that way.
> 
> As for remap_file_pages(), either people are misunderstanding or
> ignoring me. There is a lovely three-step method to handling it:
> 
> (a) fix the truncate() bug; it is just a literal bug. There are at
> 	least 3 different ways to fix it:
> 	(i) tag vmas touched by remap_file_pages() for exhaustive search
> 	(ii) do a cleanup pass after the current vmtruncate() doing
> 		try_to_unmap() on any still-mapped pages
> 	(iii) drop the current vmtruncate() entirely and do try_to_unmap()
> 		on each truncated page
> 	(ii) and (iii) do the locks in the wrong order, so some still-
> 	mapped but truncated page could be out there; this could be
> 	handed by Yet Another Cleanup Pass that does (i) or by tolerating
> 	the new state elsewhere in the VM. There's plenty of ways to
> 	code this and a couple choices of semantics (i.e make it
> 	failable or reliable).
> 
> (b) implement the bits omitting pte_chains for mlock()'d mappings
> 	This is obvious. Yank them off the LRU, set a bitflag, and
> 	reuse page->lru for a counter.
> 
> (c) redo the logic around page_convert_anon() and incrementally build
> 	pte_chains for remap_file_pages().
> 	The anobjrmap code did exactly this, but it was chaining
> 	distinct user virtual addresses instead.
> 	(i) you always have the pte_chain in hand anyway; the core
> 		is always prepped to handle allocating them now
> 	(ii) instead of just bailing for file-backed pages in
> 		page_add_rmap(), pass it enough information to know
> 		whether the address matches what it should from the
> 		vma, and start chaining if it doesn't
> 	(iii) but you say ->mapcount sharing space with the chain is a
> 		problem? no, it's not; again, take a cue from anobjrmap:
> 		if a file-backed page needs a pte_chain, shoehorn
> 		->mapcount into the first pte_chain block dangling off it
> 
> After all 3 are done, remap_file_pages() integrates smoothly into the VM,
> requires no magical privileges, nothing magical or brutally invasive
> that would scare people just before 2.6.0 is required, and the big
> apps can get their magical lowmem savings by just mlock()'ing _anything_
> they do massive sharing with, regardless of remap_file_pages().
> 
> Does anyone get it _now_?

the problem with the above is that it is an order of magnitude more
complicated than just providing the feature remap_file_pages is been
written for. Removing the pte_chains via mlock is trivial, but then go
ahead and rebuild it synchronously in O(N) scanning the whole 1T of
virtual address space when I munlock.

In turn I still prefer the simplest possible approch. I see no strong
reason why we should complicate the kernel like that to make
remap_file_pages generic.

IMHO remap_file_pages wouldn't exist today in the kernel if 32bit archs
would be limited to 4G of ram. It's primarly a 32bit hack and as such we
should try to get away with it with the minimal damage to the rest of
the kernel (in a way that emulator can use too though, via a sysctl or
similar).

Now releasing the pte_chain during mlock would be a generic feature
orthogonal with the above I know, but I doubt you really care about it
for all other usages (also given the nearly unfixable complexity it
would introduce in munlock).

Andrea
