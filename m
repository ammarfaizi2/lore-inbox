Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135639AbREITbT>; Wed, 9 May 2001 15:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135655AbREITbJ>; Wed, 9 May 2001 15:31:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55311 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135639AbREITa4>; Wed, 9 May 2001 15:30:56 -0400
Date: Wed, 9 May 2001 14:52:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Race between try_to_swap_out() and swapin_readahead() 
Message-ID: <Pine.LNX.4.21.0105091444450.13878-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, what prevents this from happening: 


CPU0				CPU1

try_to_swap_out()
...

entry = get_swap_page();
if (!entry.val)
	goto out_unlock_restore;

				swapin_readahead()
				finds valid swap entry just allocated by try_to_swap_out()
				lookup_swap_cache() fails...
				new_page = alloc_page();
				lock_page(new_page);
				add_to_swap_cache(new_page, entry);
				rw_swap_page(READ, new_page);
			 	return new_page;

/* Add it to the swap cache and mark it dirty */
add_to_swap_cache(page, entry);
set_page_dirty(page);

----

We'll end up with two pages with the same index in the hash tables, and
one of them has crap read from swap.

I know the window is really really small, but anyway... 

Comments? 

