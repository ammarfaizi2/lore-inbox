Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbTDDVas (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbTDDVas (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:30:48 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62298 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S261339AbTDDVaS (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 16:30:18 -0500
Date: Fri, 4 Apr 2003 22:43:46 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: dmccr@us.ibm.com, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030404105417.3a8c22cc.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0304042223120.2876-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003, Andrew Morton wrote:
> 
> How about we just don't do the SIGBUS thing at all for nonlinear mappings? 
> Any pages outside i_size which are mapped into a nonlinear mapping become
> anonymous.
> 
> We'd need vm_flags:VM_NONLINEAR.

That's an idea, it sounds plausible, but I'll need to think more.

I'm not convinced there won't be difficulties around the corner
going that way.  For example, it's difficult to do sensible page
accounting if the vma is shared writable, but parts of it can go
private without warning.  It actually introduces a new category
of page (or perhaps legitimizes what already exists as a rare,
forgotten category of outlaw page).

Also (sob, sob) that's a little inconvenient for anonymous objrmap
(such pages may be shared outside of the anonmm).  Neither of which
rules out the idea, but they do hint that it might prove awkward in
other ways too.

> > Various places in rmap.c where !page->mapping is considered a
> > BUG(), but you've now drawn attention to the fact it may get
> > vmtruncated at any moment.  Easy to remove those BUG()s.
> 
> Well not really.  page_referenced_obj() is racy wrt truncate and will deref
> null.  We're back to locking the pages in refill_inactive_zone().  There is
> no other way of stabilising ->mapping.
> 
> Probably a trylock in page_referenced_obj() would suit.

I didn't get you at first, but now I see it.  Shame it's taken us
so long to notice that.  I think there is another way, but it's not
necessarily preferable: I suggested before that truncate_inode_pages
should forcibly try_to_unmap if it sees a page_mapped page (either
from sys_remap_file_pages or racing nopage) - for that it would
have to take the pte_chain_lock, wouldn't that give the required
serialization against page_referenced_obj?

> btw,
>         if (PageSwapCache(page))
>                 BUG();
> 
> is that safe against your weird tmpfs address_space swizzling?

Yes, it's safe against my weird swizzling, because it's against the
rules for a tmpfs page to have swap identity while it's mapped into
an mm - BUG_ON(page_mapped(page)) in shmem_writepage.

But I don't think it's safe against truncation nulling page->mapping,
then shrink_list doing add_to_swap later.  Probably a SetPageAnon in
add_to_swap would fix all rmap.c's PageSwapCache BUG()s.

Hugh

