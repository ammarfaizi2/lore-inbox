Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965270AbVKBVmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbVKBVmu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbVKBVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:42:50 -0500
Received: from gold.veritas.com ([143.127.12.110]:2956 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965270AbVKBVmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:42:49 -0500
Date: Wed, 2 Nov 2005 21:41:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <1130965454.20136.50.camel@gaston>
Message-ID: <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au> 
 <4368139A.30701@vc.cvut.cz>  <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
 <1130965454.20136.50.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Nov 2005 21:42:48.0403 (UTC) FILETIME=[5E1FFA30:01C5DFF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Benjamin Herrenschmidt wrote:
> 
> Not completely related to this thread, but ... I have been working on
> the radeon DRI driver to add some non-AGP DMA functionality. That needs
> to pin some userpages for DMA. It's currently doing get_user_pages(),
> and later on, page_cache_release() when the DMA is done. In between
> however, it returns to userland.

That's the right way to do it.

> I haven't been able to find a firm grasp on what is needed to make sure
> those pages won't be mucked with by rmap or others during that proc ess.
> Should I set PG_locked ? if yes why and if not why not ? (you may figure
> out at this point that I have a poor understanding of this part of the
> VM subsystem). Will get_user_pages() increase page_mapcount or only
> page_count (relative to your quote above) ?

get_user_pages() raises page_count, not page_mapcount.  You shouldn't set
PG_locked (and if you did, ought only to do so via lock_page): that was
done at one time in early 2.4, but it's irrelevant (and a problem when
the same page appears more than once in the list).

It remains unlikely but possible that rmap will come along and remove
the page from its place in the user address space before the DMAing
has finished; but that does not matter, so long as any user access
to that address faults the right pinned page back in.

The only extant problem here is if the pages are private, and you
fork while this is going on, and the parent user process writes to the
area before completion: then COW leaves the child with the page being
DMAed into, giving the parent a copied page which may be incomplete.

> Also, I'm not too sure how to handle dirtyness. It _seems_ to be that
> for a DMA transfer from device to memory, I will have to call
> get_user_pages() for write, thus setting dirty at that moment. However,
> this is not very optimal. I want X to be able to "prepare" pixmaps for
> DMA (keeping the user pages locked and the DMA sglists ready) (up to a
> given threshold of memory of course) and later on, kick DMA operations.
> In that context, X doesn't know in advance what direction the DMA will
> take. Pixmaps can be migrated to/from vram at any time depending on the
> type of rendering operation.

It's important that any necessary COW be done at get_user_pages time,
if there's any possibility that you'll be DMAing into them.  So when
in doubt, call it for write access.

> But I'm not sure I have a proper way to set those pages dirty after the
> call to get_user_pages(), do I have a guarantee that they haven't been
> unmapped from the user process for example ?

You don't have that guarantee, but you shouldn't need it: when in doubt,
let it set them dirty beforehand.  As to afterwards, if I remember
rightly, there's a race by which the pages might be written out and
dirty cleared before your DMA completed, so you actually do need to
mark them dirty after - searching fs/ for get_user_pages() use suggests
so.  Take a look at Andrew's educational comment on set_page_dirty_lock
in mm/page-writeback.c.  You do have the list of pages you need to
page_cache_release, don't you?  So it should be easy to dirty them.

Hugh
