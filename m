Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVAJSQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVAJSQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVAJSPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:15:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:41138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262409AbVAJSNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:13:14 -0500
Date: Mon, 10 Jan 2005 10:13:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V3 [1/4]: Allow request for zeroed memory
In-Reply-To: <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org>
References: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jan 2005, Christoph Lameter wrote:
>
> Yes. Right my ia64 centric vision got me again. Thanks for all the other
> patches that were posted. I hope this is now all cleared up?

Hmm.. I fixed things up, but I didn't exactly do it like the posted 
patches. 

Currently the BK tree
 - doesn't use __GFP_ZERO with anonymous user-mapped pages (which is what 
   you wrote this whole thing for ;)

   Potential fix: declare a per-architecture "alloc_user_highpage(vaddr)"
   that does the proper magic on virtually indexed machines, and on others 
   it just does a "alloc_page(GFP_HIGHUSER | __GFP_ZERO)".

 - verifies that nobody ever asks for a HIGHMEM allocation together with 
   __GFP_ZERO (nobody does - a quick grep shows that 99% of all uses are
   statically clearly fine (there's a few HIGHMEM zero-page users, but 
   they are all GFP_KERNEL or similar), with just two special cases:

	- get_zeroed_page() - which can't use HIGHMEM anyway
	- shm.c does "mapping_gfp_mask(inode->i_mapping) | __GFP_ZERO"
	  and that's fine because while the mapping gfp masks may lack
	  GFP_FS and GFP_IO, they are always supposed to be ok with 
	  waiting.

 - moves "kernel_map_pages()" into "prep_new_page()" to fix the 
   DEBUG_PAGEALLOC issue (Chris Wright).

So that should take care of the known problems.

		Linus
