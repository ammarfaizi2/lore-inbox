Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSIZWiB>; Thu, 26 Sep 2002 18:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261534AbSIZWiB>; Thu, 26 Sep 2002 18:38:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36361 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261511AbSIZWiA>; Thu, 26 Sep 2002 18:38:00 -0400
Date: Thu, 26 Sep 2002 15:45:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
In-Reply-To: <3D938588.4508FDF@digeo.com>
Message-ID: <Pine.LNX.4.33.0209261533230.1345-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually, thinking more on this..

Ingo Molnar wrote: 
>
>  - if the faulting context is a non-owner (ie. the fork()-ed child), then
>    the normal COW path is taken - new page allocated and installed.
> 
>  - if the faulting context is the owner, then the pte chain is walked, and
>    the new page is installed into every 'other' pte. This needs a
>    cross-CPU single-page TLB flush though. The TLB flush could be
>    optimized if we had a way to get to the mapping MM's of the individual
>    pte chain entries - is this possible?

Actually, we don't have to do it this way. My preferred solution would be 
to make the pinning data structure be a special one with a callback (which 
also means that you do _not_ have to re-use the LRU list), and what we do 
is that when we're getting called back the futex code just updates to the 
new physical page instead.

So the data structures would look something like this:

	struct page_change_struct {
		unsigned long address;
		struct mm_struct *vm;
		struct list_head list;
		void (*callback)(struct page_change_struct *data, struct page *new);
	}

	struct list_head page_change_struct_hash[HASHSIZE];

and then when we pin a page, we do

	/* This is part of the 
	struct page_change_struct pinned_data;

	pinned_data.address = virtual_address;
	pinned_data.vm = current_mm;
	pinned_data.callback = futex_cow_callback;

	insert_pin_page(page, &pinned_data);
		.. this does a hash on address, inserts it into the
		   page_change_struct_hash table, and is done..

unpinning does:

	remove_pin_page(page, &pinned_data);
		.. this just does a "list_del(&pinned_data); ...

and COW does:

	.. hash the COW address, look up the page_change_struct_hash,
	   search if the page/vm tuple exists in the index, and if it
	   does, call the callback()..

and then the "callback" function just updates the page information in the 
futex block directly - as if it was looked up anew.

This has the advantage that it works without any cross-CPU tlb stuff, and 
that other users (not just futexes) can also register themselves for 
getting callbacks if somebody COW's a page they had.

We could extend it to work for unmapping etc too if we wanted (ie anybody 
who caches a virtual->physical translation for a specific page can always 
ask for a "invalidate this particular page mapping" event.

I really like this approach. 

[ Of course I do, since I thought it up. All my ideas are absolutely 
  brilliant, until somebody points out why they can't work. The locking
  might be interesting, but the most obvious locking seems to be to have 
  some per-hash thing. ]

			Linus

