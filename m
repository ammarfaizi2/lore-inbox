Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUC3Ssr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUC3Ssr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:48:47 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:46567 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263540AbUC3Ssn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:48:43 -0500
Date: Tue, 30 Mar 2004 19:48:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
In-Reply-To: <20040330182018.GB3808@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403301930040.23534-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, Andrea Arcangeli wrote:
> 
> note that the very same bug triggers with objrmap only applied (before I
> applied anon-vma and prio-tree on top of it), so at very least this is a
> bug in Dave's code too. See the same BUG_ON triggering in rmap.c before
> I replace it with objrmap.c in anon-vma. Almost certainly it will trigger with
> your patches applied too and probably it happens with mainline 2.6 too
> but nobody tested that yet.

Do you have enough evidence that it's the very same bug?
I believe there were other loopholes in the original objrmap code,
we've both moved on from there (e.g. we both decided it's safer to
set and clear PageAnon inside the maplock), so I'm not concerned
about the original objrmap.

> > Imagine if the filesystem (or driver) nopage gave you the empty zero
> > page for a private writable mapping (it better not give it you for a
> > shared writable mapping!), perhaps to represent a hole in the file.
> 
> zero page is reserved, so page_add_rmap does nothing on it, zero page is
> gauranteed to have page->mapcount == 0.

Yes, I'm not talking about page_add_rmap on the zero page, but
about how with pageable 0 you skip page_add_rmap of copy of zero page.

> > I think it will pass the various tests in your do_no_page, and if
> 
> zero page will get intercepted in the page-reserved checks, so
> page_add_rmap is a noop and the zero page has always page->mapcount == 0.

Yes, repeat sentence above.

> Furthermore I WARN_ON if anybody returns a page->mapping == NULL on a
> non-reserved VMA, so it can't be the case (zeropage has page->mapping =
> NULL).

Perhaps that's in a different version than I'm looking at, 2.6.5-rc2-aa5.

> > it's a write_access, that will correctly copy the page and set_pte
> > for this private copy: but it doesn't update pageable (from 0 to 1)
> > for it, so skips the page_add_rmap; and eventually page_remove_rmap
> > will be passed this page with neither PageAnon nor page->mapping.
> 
> A COW on a zero page will call page_add_rmap on the copy just fine and

Where does "pageable" get set to 1 in do_no_page's COW case?

> it will call page_remove_rmap on the old page as well, though the
> latter will be a noop for a reserved page or for a page with
> page->mapping == 0 like the zero page is.

It'll get a page which is !PageReserved !PageAnon !page->mapping.

> > As I say, I doubt it's your case, but worth fixing:
> > force pageable on where you set anon in do_no_page.
> 
> there's no bug to fix in my code as far as I can tell. You probably
> overlooked the zeropage is reserved.

Er, probably not.  I may be wrong, but you're not convincing me.
Go slower, read my mail and read your code, then explain where
"pageable" gets set to 1 if do_no_page is COWing the zero page.

Hugh

