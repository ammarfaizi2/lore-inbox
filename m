Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946135AbWBDAZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946135AbWBDAZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946132AbWBDAZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:25:56 -0500
Received: from silver.veritas.com ([143.127.12.111]:4966 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1946007AbWBDAZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:25:55 -0500
Date: Sat, 4 Feb 2006 00:26:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Brian King <brking@us.ibm.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
In-Reply-To: <43E3D3EC.3040006@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031953400.14829@goblin.wat.veritas.com> <43E3D3EC.3040006@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Feb 2006 00:25:55.0076 (UTC) FILETIME=[8FDA8440:01C62921]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Brian King wrote:
> Hugh Dickins wrote:
> > On some architectures, mapping the scatterlist may coalesce entries:
> > if that coalesced list is then used for freeing the pages afterwards,
> > there's a danger that pages may be doubly freed (and others leaked).
> 
> I don't understand why this is necessary... Comparing the bug you fixed
> in st with ipr's usage of scatterlists, there is a bit of a difference.
> st is dealing with user pages and calling page_cache_release to release
> the pages, and I can begin to understand why there might be a problem
> in that code.

Yes, certainly the st and ipr cases seem different, and originally
I was thinking it was only an issue in connection with get_user_pages.

> page_cache_release looks at the pages themselves to figure
> out how many compound pages there are. This could certainly result in
> double free's occurring.

I don't follow you there, but better if I try to explain how I see it.

> Looking at ipr, however, it is simply doing alloc_pages
> and __free_pages. __free_pages passes in the page allocation order, so
> I don't think I would have the double free problem.
> 
> As I understand it, pci_map_sg only modifies the dma_address and dma_length
> fields when things get coalesced. If it were to coalese pages by
> turning them into compound pages then I would agree that ipr might have
> a problem, but I don't think this to be the case...

It's not fully defined what it does (intentionally: internal detail).
But as I understand it, what it's likely to do is coalesce entries as
far as it can (causes no problem in itself) then shift down and attempt
to coalesce the entries above.  It's the shifting down that gives the
problem.

Imagine we start with sglist

struct page *a, length A
struct page *b, length B
struct page *c, length C

and pci_map_sg finds a+A brings it to b (I'm writing loosely, mixing
the page pointers and their corresponding virtual addresses), but b+B
does not match c.  Then it'll coalesce the first two entries, and
shift down the third to second place, turning sglist into

struct page *a, length A+B
struct page *c, length C
struct page *c, length C

So (again writing loosely, mixing up lengths and orders) on return the
caller will __free_pages(a, A+B) (itself probably wrong since a and b
were likely not buddies to start out with), __free_pages(c, C),
__free_pages(c, C) - doubly freeing c, ensuing mayhem.

Maybe it doesn't change length A to A+B, just doing that in dma_length;
but caller is still going to free c twice.

Agree?

Hugh
