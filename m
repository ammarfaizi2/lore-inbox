Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266893AbUFYXci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266893AbUFYXci (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 19:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUFYXbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 19:31:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:9682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266888AbUFYXbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 19:31:13 -0400
Date: Fri, 25 Jun 2004 16:34:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm lock ordering summary
Message-Id: <20040625163400.43552a08.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0406252335410.19814-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0406252329540.19814-100000@localhost.localdomain>
	<Pine.LNX.4.44.0406252335410.19814-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> + * mm->mmap_sem
> + *   page->flags PG_locked (lock_page)
> + *     mapping->i_mmap_lock
> + *       mm->page_table_lock
> + *         swap_list_lock (in swap_free etc's swap_info_get)
> + *         zone->lru_lock (in mark_page_accessed)
> + *         page->flags PG_maplock (page_map_lock)
> + *           anon_vma->lock
> + *             swap_device_lock (in swap_duplicate, swap_info_get)
> + *             mapping->private_lock (in __set_page_dirty_buffers)
> + *             inode_lock (in set_page_dirty's __mark_inode_dirty)
> + *               sb_lock (within inode_lock in fs/fs-writeback.c)
> + *               mapping->tree_lock (widely used, in set_page_dirty,
> + *                         in arch-dependent flush_dcache_mmap_lock,
> + *                         within inode_lock in __sync_single_inode)

What happened to "i_sem nests inside mmap_sem"?

This representation tends to lose information - it implies that all the
above locks are taken at the same time and it makes it harder to capture
information about where in the kernel the particular ranking occurs.

I mean, if some code does:

	down(a);
	down(b);

and some other code does

	down(a);
	down(c);

the appropriate representation is

	a
	-> b

	a
	-> c


