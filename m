Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTGBV00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTGBV00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:26:26 -0400
Received: from holomorphy.com ([66.224.33.161]:39865 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264544AbTGBV0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:26:24 -0400
Date: Wed, 2 Jul 2003 14:40:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030702214032.GH20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <Pine.LNX.4.53.0307021641560.11264@skynet> <20030702171159.GG23578@dualathlon.random> <461030000.1057165809@flay> <20030702174700.GJ23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702174700.GJ23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 07:47:00PM +0200, Andrea Arcangeli wrote:
> actually other more invasive ways could be to move rmap into highmem.
> Also the page clustering could also hide part of the mem overhead by
> assuming the pagetables to be contiguos, but page clustering isn't part
> of mainline yet either.

BSD-style page clustering preserves virtual contiguity of a software
page, but the new things don't; for ABI preservation, virtually
discontiguous, partial, and misaligned mappings of pages are handled.

The desired behavior can in principle be partially recovered by
scanning within a software page size -sized "blast radius" for each
chain element and only chaining enough elements to find the relevant
ptes that way.

As for remap_file_pages(), either people are misunderstanding or
ignoring me. There is a lovely three-step method to handling it:

(a) fix the truncate() bug; it is just a literal bug. There are at
	least 3 different ways to fix it:
	(i) tag vmas touched by remap_file_pages() for exhaustive search
	(ii) do a cleanup pass after the current vmtruncate() doing
		try_to_unmap() on any still-mapped pages
	(iii) drop the current vmtruncate() entirely and do try_to_unmap()
		on each truncated page
	(ii) and (iii) do the locks in the wrong order, so some still-
	mapped but truncated page could be out there; this could be
	handed by Yet Another Cleanup Pass that does (i) or by tolerating
	the new state elsewhere in the VM. There's plenty of ways to
	code this and a couple choices of semantics (i.e make it
	failable or reliable).

(b) implement the bits omitting pte_chains for mlock()'d mappings
	This is obvious. Yank them off the LRU, set a bitflag, and
	reuse page->lru for a counter.

(c) redo the logic around page_convert_anon() and incrementally build
	pte_chains for remap_file_pages().
	The anobjrmap code did exactly this, but it was chaining
	distinct user virtual addresses instead.
	(i) you always have the pte_chain in hand anyway; the core
		is always prepped to handle allocating them now
	(ii) instead of just bailing for file-backed pages in
		page_add_rmap(), pass it enough information to know
		whether the address matches what it should from the
		vma, and start chaining if it doesn't
	(iii) but you say ->mapcount sharing space with the chain is a
		problem? no, it's not; again, take a cue from anobjrmap:
		if a file-backed page needs a pte_chain, shoehorn
		->mapcount into the first pte_chain block dangling off it

After all 3 are done, remap_file_pages() integrates smoothly into the VM,
requires no magical privileges, nothing magical or brutally invasive
that would scare people just before 2.6.0 is required, and the big
apps can get their magical lowmem savings by just mlock()'ing _anything_
they do massive sharing with, regardless of remap_file_pages().

Does anyone get it _now_?


-- wli
