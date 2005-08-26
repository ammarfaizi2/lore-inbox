Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVHZTVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVHZTVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVHZTVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:21:48 -0400
Received: from gold.veritas.com ([143.127.12.110]:24246 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030201AbVHZTVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:21:48 -0400
Date: Fri, 26 Aug 2005 20:23:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Blaisorblade <blaisorblade@yahoo.it>
cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: remove-stale-comment-from-swapfilec.patch added to -mm tree
In-Reply-To: <200508262017.38301.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0508262012210.8803@goblin.wat.veritas.com>
References: <200508172149.j7HLn37L012796@shell0.pdx.osdl.net>
 <Pine.LNX.4.61.0508241335390.4198@goblin.wat.veritas.com>
 <200508262017.38301.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Aug 2005 19:21:47.0542 (UTC) FILETIME=[66F80B60:01C5AA73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2005, Blaisorblade wrote:
> On Wednesday 24 August 2005 15:26, Hugh Dickins wrote:
> 
> > If do_swap_page gets 
> > a write fault, it either determines it can go ahead and use the swap
> > page, or if it can't, gets do_wp_page to Copy-On-Write for it (that's
> > a call I added in 2.6.7, as an optimization, and as a necessity for
> > correct behaviour of ptrace's get_user_pages; the latter has just in
> > 2.6.13-rc been made more resilient, so we could remove do_swap_page's
> > call to do_wp_page now - though I'm inclined to let it stay as an
> > optimization, avoiding the second fault which would follow).
> get_user_pages() can still get two faults there, because VM_FAULT_WRITE is not 
> returned by do_swap_page(). And faults can be very expensive (for UML a fault 
> is given by a SIGSEGV delivery).

You're right that it can get two "faults" there, but it's such a rare case
(ptrace modifying an area readonly to the process) that I didn't bother
about it.  It isn't even two real faults, just two iterations within
get_user_pages - or does that somehow get worse in the UML case?

> > If do_swap_page gets a read fault, it doesn't COW at all.
> 
> > I don't know what the "early" COW break referred to is: the write_access
> > call to do_wp_page could be deferred, yes, but it's hardly early.
> The idea in my mind is that after loading the page from swap the first time 
> there's no need to copy the page to give a private copy to the process, if 
> the page is kept on swap.
> 
> We COW it anyway to break the sharing, to keep the original copy in the 
> swapcache, instead of reading it again from the disk. This is *early*. 

We always prefer not to read from the disk.  You're right that we could
choose to remove the page from the swap cache at that point (locking
considerations?) and make it private (in the case where it has actually
been written to the disk, often not yet so), but that's not how the page
cache has ever been treated.  Avoid going to slow disk at all costs.

Hugh
