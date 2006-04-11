Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWDKUbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWDKUbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWDKUbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:31:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26809 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750959AbWDKUbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:31:05 -0400
Date: Tue, 11 Apr 2006 13:30:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: carsteno@de.ibm.com
cc: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn handler
In-Reply-To: <443C0B8F.7010501@de.ibm.com>
Message-ID: <Pine.LNX.4.64.0604111318120.10745@g5.osdl.org>
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net>
 <Pine.LNX.4.64.0604110751510.10745@g5.osdl.org> <443BCA98.1020805@de.ibm.com>
 <Pine.LNX.4.64.0604110830260.10745@g5.osdl.org> <443C0B8F.7010501@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Apr 2006, Carsten Otte wrote:
> 
> Today, the _only_ code that uses the struct page behind those DCSS 
> segments is aops->nopage (as return value) and do_wp_page. Those small 
> servers have almost no local memory (kernel, libraries, and binaries are 
> shared), and the mem_map array is a large overhead.

Quite frankly, I'm not in the least interested in designing for a niche 
market and for some strange niche usage. It really needs to make a lot of 
sense from a bigger picture.

I don't much like do_no_pfn either, but at least that one _can_ work 
within the rules of the bigger picture, as long as we limit it and make 
sure people can't mis-use it. 

Now, the kernel page table accessor macros are certainly generic enough 
that you could have your own "COW bits" macro, and make this all an 
architecture-specific feature (and simply not allow it on architectures 
that don't have a sw-usable COW bit)

It so happens that S390 seems to be one of the very few architectures that 
doesn't have room for that bit in its regular page table layout, and 
that's arguably a design problem for S390. But you _could_ just allocate 
extra memory for page tables, and put the COW bit there. The VM wouldn't 
care - at that point it would fit in the "larger picture" of just having 
the COW information directly in the page tables (even if the "page tables" 
would be partly just sw-defined).

But especially since it doesn't seem to have very wide use, I'd push back 
unless you can do it really cleanly. And you'd have to pay that extra page 
table cost all over, even if it's almost never used. I bet you're better 
off just having the "struct page"s.

> > We have no free bits in the page tables to say "this is a COW page" in 
> > general (on x86 we could do it, but some other architectures don't have 
> > any SW-usable bits). 
>
> That's true. One can store that information in the vma flags, and split 
> the vma into 3 vmas once we have a write fault.

Well, i's not exactly "3 vmas". It ends up being "one vma for every page" 
in the limit. Not to mention that you can't really split the vma at all at 
page fault time without screwing up locking (you'd have to take the VM 
lock for writing).

Nasty.

		Linus
