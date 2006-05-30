Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWE3Bey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWE3Bey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWE3BbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:31:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932101AbWE3BbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:31:04 -0400
Date: Mon, 29 May 2006 18:32:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de, torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
Message-Id: <20060529183201.0e8173bc.akpm@osdl.org>
In-Reply-To: <447B8CE6.5000208@yahoo.com.au>
References: <447AC011.8050708@yahoo.com.au>
	<20060529121556.349863b8.akpm@osdl.org>
	<447B8CE6.5000208@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 10:08:06 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > 
> > Try disabling kblockd completely, see what effect that has on performance.
> 
> Which is what I want to know. I don't exactly have an interesting
> disk setup.

You don't need one - just a single disk should show up such problems.  I
forget which workloads though.  Perhaps just a linear read (readahead
queues the I/O but doesn't unplug, subsequent lock_page() sulks).

> >>Can we get rid of the whole thing, confusing memory barriers and all? Nobody
> >>uses anything but the default sync_page, and if block rq plugging is terribly
> >>bad for performance, perhaps it should be reworked anyway? It shouldn't be a
> >>correctness thing, right?
> > 
> > 
> > What this means is that it is not legal to run lock_page() against a
> > pagecache page if you don't have a ref on the inode.
> 
> Yes. So set_page_dirty_lock is broken, right?

yup.

> And the wait_on_page_stuff needs an inode ref.
> Also splice seems to have broken sync_page.

Please describe the splice() problem which you've observed.

> > 
> > iirc the main (only?) offender here is direct-io reads into MAP_SHARED
> > pagecache.  (And similar things, like infiniband and nfs-direct).
> 
> Well yes, writing to a page would be the main reason to set it dirty.
> Is splice broken as well? I'm not sure that it always has a ref on the
> inode when stealing a page.

Whereabouts?

> It sounds like you think fixing the set_page_dirty_lock callers wouldn't
> be too difficult? I wouldn't know (although the ptrace one should be
> able to be turned into a set_page_dirty, because we're holding mmap_sem).

No, I think it's damn impossible ;)

get_user_pages() has gotten us a random pagecache page.  How do we
non-racily get at the address_space prior to locking that page?

I don't think we can.

> You're sure about all other lock_page()rs? I'm not, given that
> set_page_dirty_lock got it so wrong. But you'd have a better idea than
> me.

No, I'm not sure.

However it is rare for the kernel to play with pagecache pages against
which the caller doesn't have an inode ref.  Think: how did the caller look
up that page in the first place if not from the address_space in the first
place?

- get_user_pages(): the current problem

- page LRU: OK, uses trylock first.

- pagetable walk??
