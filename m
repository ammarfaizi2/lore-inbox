Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272898AbRIMHPF>; Thu, 13 Sep 2001 03:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272899AbRIMHOz>; Thu, 13 Sep 2001 03:14:55 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:14746 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S272898AbRIMHOq>; Thu, 13 Sep 2001 03:14:46 -0400
Date: Thu, 13 Sep 2001 08:15:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109122227040.3414-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0109130806260.2144-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2001, Marcelo Tosatti wrote:
> On Tue, 11 Sep 2001, Hugh Dickins wrote:
> > It may be made more likely by my swapoff changes (not bumping swap
> > count in valid_swaphandles), but it's not been introduced by those
> > changes.  Though usually swapin_readahead/valid_swaphandles covers
> > (includes) the particular swap entry which do_swap_page actually
> > wants to bring in, under pressure that's not always so, and then
> > the race you outline can occur with the "bare" read_swap_cache_async
> > for which there was no bumping.  Furthermore, you can play your
> > scenario with valid_swaphandles through to add_to_swap_cache on CPU0
> > interposed between the get_swap_page and add_to_swap_cache on CPU1
> > (if interrupt on CPU1 diverts it).
> 
> I don't think so. A "bare" read_swap_cache_async() call only happens on
> swap entries which already have additional references. That is, its
> guaranteed that a "bare" read_swap_cache_async() call only happens for
> swap map entries which already have a reference, so we're guaranteed that
> it cannot be reused.

Almost agreed, but there may be a long interval between when that reference
was observed in the page table, and when read_swap_cache_async upon it is
actually performed (waiting for BKL, waiting to allocate pages for prior
swapin_readahead).  In that interval the reference can be removed:
certainly by swapoff, certainly by vm_swap_full removal, anything else?
That's why the pte_same tests were added into do_swap_page in 2.4.8.

Hugh

