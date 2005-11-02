Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbVKBVHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbVKBVHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVKBVHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:07:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:28851 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965244AbVKBVH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:07:29 -0500
Subject: Re: Nick's core remove PageReserved broke vmware...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au>
	 <4368139A.30701@vc.cvut.cz>
	 <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 08:04:14 +1100
Message-Id: <1130965454.20136.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 12:26 +0000, Hugh Dickins wrote:

> Well, beware.  That "page_count() != page_mapcount() + 2" check in rmap.c
> went away in 2.6.13: the problem it was there to solve being solved
> instead by a can_share_swap_page based on page_mapcount instead of
> page_count (partly to fix a page migration progress problem).

Not completely related to this thread, but ... I have been working on
the radeon DRI driver to add some non-AGP DMA functionality. That needs
to pin some userpages for DMA. It's currently doing get_user_pages(),
and later on, page_cache_release() when the DMA is done. In between
however, it returns to userland.

I haven't been able to find a firm grasp on what is needed to make sure
those pages won't be mucked with by rmap or others during that proc ess.
Should I set PG_locked ? if yes why and if not why not ? (you may figure
out at this point that I have a poor understanding of this part of the
VM subsystem). Will get_user_pages() increase page_mapcount or only
page_count (relative to your quote above) ?

Also, I'm not too sure how to handle dirtyness. It _seems_ to be that
for a DMA transfer from device to memory, I will have to call
get_user_pages() for write, thus setting dirty at that moment. However,
this is not very optimal. I want X to be able to "prepare" pixmaps for
DMA (keeping the user pages locked and the DMA sglists ready) (up to a
given threshold of memory of course) and later on, kick DMA operations.
In that context, X doesn't know in advance what direction the DMA will
take. Pixmaps can be migrated to/from vram at any time depending on the
type of rendering operation.

But I'm not sure I have a proper way to set those pages dirty after the
call to get_user_pages(), do I have a guarantee that they haven't been
unmapped from the user process for example ?

Ben.


