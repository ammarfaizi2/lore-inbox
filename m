Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUDAB02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 20:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUDAB02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 20:26:28 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6853
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261790AbUDAB0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 20:26:25 -0500
Date: Thu, 1 Apr 2004 03:26:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040401012625.GV2143@dualathlon.random>
References: <20040331150718.GC2143@dualathlon.random> <Pine.LNX.4.44.0403311735560.27163-100000@localhost.localdomain> <20040331172851.GJ2143@dualathlon.random> <20040401004528.GU2143@dualathlon.random> <20040331172216.4df40fb3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331172216.4df40fb3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 05:22:16PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > @@ -151,8 +151,11 @@ int rw_swap_page_sync(int rw, swp_entry_
> >  	lock_page(page);
> >  
> >  	BUG_ON(page->mapping);
> > -	page->mapping = &swapper_space;
> > -	page->index = entry.val;
> > +	ret = add_to_page_cache(page, &swapper_space, entry.val, GFP_KERNEL);
> 
> Doing a __GFP_FS allocation while holding lock_page() is worrisome.  It's
> OK if that page is private, but how do we know that the caller didn't pass
> us some page which is on the LRU?

it _has_ to be private if it's using rw_swap_page_sync. How can a page
be in a lru if we're going to execute add_to_page_cache on it? That
would be pretty broken in the first place.

> Your patch seems reasonable to run with for now, but to be totally anal
> about it, I'll run with the below monstrosity.

It's not needed IMO. We also already bugcheck on page->mapping, if
you're scared about the page being in a lru, you can add further
bugchecks on PageLru etc.. calling add_to_page_cache on anything that is
already visible to the VM in some lru is broken by design and should be
forbidden. All the users of swap suspend must work with freshly
allocated pages, the page_mapped bugcheck already covers most of the
cases.
