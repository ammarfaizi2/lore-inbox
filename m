Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272090AbRIOG33>; Sat, 15 Sep 2001 02:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272102AbRIOG3U>; Sat, 15 Sep 2001 02:29:20 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:50604 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S272090AbRIOG3J>; Sat, 15 Sep 2001 02:29:09 -0400
Date: Sat, 15 Sep 2001 07:29:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre VM changes: Potential race condition on swap code
In-Reply-To: <Pine.LNX.4.21.0109150050060.1151-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0109150709120.1476-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2001, Hugh Dickins wrote:
> On Fri, 14 Sep 2001, Marcelo Tosatti wrote:
> > 
> > I would prefer to make get_swap_page() not lock the swap lock anymore,
> > making it necessary to its callers to do the locking themselves. So:
> > ...
> This does gloss over the distinction between the swap_list_lock()
> and the swap_device_lock(si).  The latter is the more crucial here,
> but difficult to use in this way.  Though if you were to throw it
> away and convert to swap_list_lock() throughout, I wonder if we'd
> lose much (only gain on systems with just one swap area).  But I
> wasn't daring to combine them myself.

I think I get your idea now.  swap_device_lock stays where it was.
You want to move swap_list_lock out of get_swap_page, use it to
bracket swap_duplicate with add_to_swap_cache and get_swap_page
with add_to_swap_cache, easily done without changing interfaces,
since swap_duplicate doesn't currently use it at all.

That does add further locking in read_swap_cache_async, but if BKL
goes, I think that's okay; and it's a neat way to keep the familiar
primitives with little change.  I'll give it a try.

Hugh

