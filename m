Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272511AbRIMWBC>; Thu, 13 Sep 2001 18:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272531AbRIMWAw>; Thu, 13 Sep 2001 18:00:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16909 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272511AbRIMWAo>; Thu, 13 Sep 2001 18:00:44 -0400
Date: Thu, 13 Sep 2001 17:36:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109131718320.4107-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109131736050.4107-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Sep 2001, Marcelo Tosatti wrote:

> 
> 
> On Thu, 13 Sep 2001, Marcelo Tosatti wrote:
> 
> > 
> > 
> > On Thu, 13 Sep 2001, Hugh Dickins wrote:
> > 
> > > On Wed, 12 Sep 2001, Marcelo Tosatti wrote:
> > > > On Tue, 11 Sep 2001, Hugh Dickins wrote:
> > > > > It may be made more likely by my swapoff changes (not bumping swap
> > > > > count in valid_swaphandles), but it's not been introduced by those
> > > > > changes.  Though usually swapin_readahead/valid_swaphandles covers
> > > > > (includes) the particular swap entry which do_swap_page actually
> > > > > wants to bring in, under pressure that's not always so, and then
> > > > > the race you outline can occur with the "bare" read_swap_cache_async
> > > > > for which there was no bumping.  Furthermore, you can play your
> > > > > scenario with valid_swaphandles through to add_to_swap_cache on CPU0
> > > > > interposed between the get_swap_page and add_to_swap_cache on CPU1
> > > > > (if interrupt on CPU1 diverts it).
> > > > 
> > > > I don't think so. A "bare" read_swap_cache_async() call only happens on
> > > > swap entries which already have additional references. That is, its
> > > > guaranteed that a "bare" read_swap_cache_async() call only happens for
> > > > swap map entries which already have a reference, so we're guaranteed that
> > > > it cannot be reused.
> > > 
> > > Almost agreed, but there may be a long interval between when that reference
> > > was observed in the page table, and when read_swap_cache_async upon it is
> > > actually performed (waiting for BKL, waiting to allocate pages for prior
> > > swapin_readahead).  In that interval the reference can be removed:
> > > certainly by swapoff, certainly by vm_swap_full removal, anything else?
> > 
> > Not sure about swapoff(). 
> > 
> > vm_swap_full() is only going to remove the reference _after_ we did the
> > swapin, so I don't see how the race can happen with it.
> 
> Ooh I see:
> 
> CPU0			CPU1			CPU2
> do_swap_page()		try_to_swap_out()	swapin_readahead()
> 						swapin_readahead() finds valid swap
> 						map entry and considers it "readable"
> 		
> swap_free(entry);				
> 			get_swap_page()
> 
> if (exclusive_swap_p..) {
> if (vm_swap_full()) {
> delete_from_swap_cache_nolock(page);
> pte = pte_mkdirty(pte);
> }
> }
> UnlockPage(page);
> 
> 						__find_get_page() fails on swapin_readahead()
> 						swap_duplicate() succeeds.
> 						add_to_swap_cache()
> 			add_to_swap_cache()
> 
> BOOM.
> 
> Now, if we get additional references at valid_swaphandles() the above race
> is NOT possible: we're guaranteed that any get_swap_page() will not find

Err I mean _will_ find the swap map entry used and not use it, then.

> the swap map entry used. See?

