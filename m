Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbUC3SUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUC3SUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:20:31 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26296
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263801AbUC3SUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:20:20 -0500
Date: Tue, 30 Mar 2004 20:20:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
Message-ID: <20040330182018.GB3808@dualathlon.random>
References: <20040330161056.GZ3808@dualathlon.random> <Pine.LNX.4.44.0403301845160.23502-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403301845160.23502-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 07:01:44PM +0100, Hugh Dickins wrote:
> On Tue, 30 Mar 2004, Andrea Arcangeli wrote:
> > 
> > the funny thing is that it seems to be the same truncate doing
> > truncate_inode_pages first, and zap_page_range later. It would be better
> > if WARN_ON would show the pid of the task too, if they were two
> > different tasks that would be more realistic. Maybe an xfs screwup of
> > some sort? I could ask the tester to try again with ext2, but then if it
> > doesn't trigger anymore we still have to wonder about timings.
> > 
> > Anyways now the kernel is solid, it just bugs out those warnings so we
> > don't forget. I don't think it's a bug in my tree.
> 
> I do think it's something to worry about, it does seem peculiar.
> 
> Dunno why, but I never received the first mail in this thread,
> neither directly nor via the list, but have now got it from MARC.
> 
> I doubt this is the cause of the problem (would not, I think,
> cause all of the associated symptoms you describe), but I think it
> is a bug in your code which could cause the WARN_ON(!page->mapping):

note that the very same bug triggers with objrmap only applied (before I
applied anon-vma and prio-tree on top of it), so at very least this is a
bug in Dave's code too. See the same BUG_ON triggering in rmap.c before
I replace it with objrmap.c in anon-vma. Almost certainly it will trigger with
your patches applied too and probably it happens with mainline 2.6 too
but nobody tested that yet.

> Imagine if the filesystem (or driver) nopage gave you the empty zero
> page for a private writable mapping (it better not give it you for a
> shared writable mapping!), perhaps to represent a hole in the file.

zero page is reserved, so page_add_rmap does nothing on it, zero page is
gauranteed to have page->mapcount == 0.

> I think it will pass the various tests in your do_no_page, and if

zero page will get intercepted in the page-reserved checks, so
page_add_rmap is a noop and the zero page has always page->mapcount == 0.

Furthermore I WARN_ON if anybody returns a page->mapping == NULL on a
non-reserved VMA, so it can't be the case (zeropage has page->mapping =
NULL).

> it's a write_access, that will correctly copy the page and set_pte
> for this private copy: but it doesn't update pageable (from 0 to 1)
> for it, so skips the page_add_rmap; and eventually page_remove_rmap
> will be passed this page with neither PageAnon nor page->mapping.

A COW on a zero page will call page_add_rmap on the copy just fine and
it will call page_remove_rmap on the old page as well, though the
latter will be a noop for a reserved page or for a page with
page->mapping == 0 like the zero page is.

> As I say, I doubt it's your case, but worth fixing:
> force pageable on where you set anon in do_no_page.

there's no bug to fix in my code as far as I can tell. You probably
overlooked the zeropage is reserved.
