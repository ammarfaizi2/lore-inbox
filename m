Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266765AbUFZAdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266765AbUFZAdW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 20:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266906AbUFZAdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 20:33:22 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:53967 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266765AbUFZAdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 20:33:10 -0400
Date: Sat, 26 Jun 2004 01:33:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm lock ordering summary
In-Reply-To: <20040625163400.43552a08.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0406260056300.20357-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > + * mm->mmap_sem
> > + *   page->flags PG_locked (lock_page)
> > + *     mapping->i_mmap_lock
> > + *       mm->page_table_lock
> > + *         swap_list_lock (in swap_free etc's swap_info_get)
> > + *         zone->lru_lock (in mark_page_accessed)
> > + *         page->flags PG_maplock (page_map_lock)
> > + *           anon_vma->lock
> > + *             swap_device_lock (in swap_duplicate, swap_info_get)
> > + *             mapping->private_lock (in __set_page_dirty_buffers)
> > + *             inode_lock (in set_page_dirty's __mark_inode_dirty)
> > + *               sb_lock (within inode_lock in fs/fs-writeback.c)
> > + *               mapping->tree_lock (widely used, in set_page_dirty,
> > + *                         in arch-dependent flush_dcache_mmap_lock,
> > + *                         within inode_lock in __sync_single_inode)
> 
> What happened to "i_sem nests inside mmap_sem"?

Well, you tell me, you're the one who's cut it out of what I sent ;)
And it's not as simple as that, either: mmap_sem nests inside i_sem
when faulting, doesn't it?  At first I thought that msync must be
wrong, then realized that down_reads cannot be placed strictly (?).

+ * inode->i_sem
+ *   inode->i_alloc_sem
...
+ * When a page fault occurs in writing from user to file, down_read
+ * of mmap_sem nests within i_sem; in sys_msync, i_sem nests within
+ * down_read of mmap_sem; i_sem and down_write of mmap_sem are never
+ * taken together; in truncation, i_sem is taken outermost.

is what I ended up writing.

> This representation tends to lose information -

I'm inclined to think it loses data, but gives information more easily.

If you want to check your lock ordering (the usual use for this summary),
you have to check through a number of separate blocks in the old format.

The rule I needed to see, that anon_vma->lock nests within page_table_lock,
came from anon_vma->lock within page_map_lock in swapout, and from
page_map_lock within page_table_lock when faulting; and now there's also
anon_vma->lock within page_table_lock in anon_vma_prepare.  But this is
detail which the interested should establish for themselves, I don't
see why the summary need specify it in an arbitrary subset of cases.

And when adding page_map_lock and anon_vma->lock, I just couldn't work
out how to do them in the old layout.  But yes, I made this a separate
patch from the bug fix that begged it, because I realized that you or
others might have other preferences.  Please add page_map_lock and
anon_vma->lock in the fashion that you understand.

> it implies that all the above locks are taken at the same time

I hope not!

> and it makes it harder to capture
> information about where in the kernel the particular ranking occurs.

This is a summary.  In general there are multiple places where the
ranking is enforced, but in odd corners (mainly set_page_dirty) it is
worth clarifying where something comes in, and I've kept such comments.

> I mean, if some code does:
> 
> 	down(a);
> 	down(b);
> 
> and some other code does
> 
> 	down(a);
> 	down(c);
> 
> the appropriate representation is
> 
> 	a
> 	-> b
> 
> 	a
> 	-> c

Well, I've expressed that as
        a
          b
          c

Certainly in principle there are cases where it's just wrong to
represent by a single sequence (and the i_sem/mmap_sem relation
seems to be a fairly simple example of that); but I find a lock
ordering easier to follow than a set of lock orderings.  We differ.

Hugh

