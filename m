Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266308AbUFZAmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUFZAmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 20:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266906AbUFZAmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 20:42:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:20115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266308AbUFZAmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 20:42:47 -0400
Date: Fri, 25 Jun 2004 17:41:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm lock ordering summary
Message-Id: <20040625174150.7ad7ee97.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0406260056300.20357-100000@localhost.localdomain>
References: <20040625163400.43552a08.akpm@osdl.org>
	<Pine.LNX.4.44.0406260056300.20357-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Fri, 25 Jun 2004, Andrew Morton wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > >
> > > + * mm->mmap_sem
> > > + *   page->flags PG_locked (lock_page)
> > > + *     mapping->i_mmap_lock
> > > + *       mm->page_table_lock
> > > + *         swap_list_lock (in swap_free etc's swap_info_get)
> > > + *         zone->lru_lock (in mark_page_accessed)
> > > + *         page->flags PG_maplock (page_map_lock)
> > > + *           anon_vma->lock
> > > + *             swap_device_lock (in swap_duplicate, swap_info_get)
> > > + *             mapping->private_lock (in __set_page_dirty_buffers)
> > > + *             inode_lock (in set_page_dirty's __mark_inode_dirty)
> > > + *               sb_lock (within inode_lock in fs/fs-writeback.c)
> > > + *               mapping->tree_lock (widely used, in set_page_dirty,
> > > + *                         in arch-dependent flush_dcache_mmap_lock,
> > > + *                         within inode_lock in __sync_single_inode)
> > 
> ...
> > the appropriate representation is
> > 
> > 	a
> > 	-> b
> > 
> > 	a
> > 	-> c
> 
> Well, I've expressed that as
>         a
>           b
>           c
> 

Yes, but what does

	a
	b
	  c
	  d

mean?

The above graph tells us that one or more of (swap_device_lock,
mapping->private_lock and inode_lock) nests inside one or more of
(swap_list_lock, zone->lru_lock and page->flags PG_maplock).

And has no way of telling us _where_, say, swap_device_lock nests inside
zone->lru_lock.

And it alleges that tree_lock nests inside lru_lock, which isn't so.  Is
it?  These guys used to have no locking relationship.  Hopefully that's
still the case.  But how to represent that?
