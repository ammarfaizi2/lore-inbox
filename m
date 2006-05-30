Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWE3DNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWE3DNn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 23:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWE3DNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 23:13:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751149AbWE3DNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 23:13:43 -0400
Date: Mon, 29 May 2006 20:14:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de, torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
Message-Id: <20060529201444.cd89e0d8.akpm@osdl.org>
In-Reply-To: <447BB3FD.1070707@yahoo.com.au>
References: <447AC011.8050708@yahoo.com.au>
	<20060529121556.349863b8.akpm@osdl.org>
	<447B8CE6.5000208@yahoo.com.au>
	<20060529183201.0e8173bc.akpm@osdl.org>
	<447BB3FD.1070707@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 12:54:53 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Andrew Morton wrote:
> 
> >On Tue, 30 May 2006 10:08:06 +1000
> >Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >
> >>Which is what I want to know. I don't exactly have an interesting
> >>disk setup.
> >>
> >
> >You don't need one - just a single disk should show up such problems.  I
> >forget which workloads though.  Perhaps just a linear read (readahead
> >queues the I/O but doesn't unplug, subsequent lock_page() sulks).
> >
> 
> I guess so. Is plugging still needed now that the IO layer should
> get larger requests? Disabling it might result in a small initial
> request (although even that may be good for pipelining)...

Mysterious question, that.  A few years ago I think Jens tried pulling unplugging
out, but some devices still want it (magneto-optical storage iirc).  And I
think we did try removing it, and it caused hurt.

> Otherwise, we could make set_page_dirty_lock use a weird non-unplugging
> variant

Yes, that would work.  In fact the number of times when direct-io actually
calls set_page_dirty_lock() is infinitesimal - I had to jump through hoops
to even test that code.  The speculative
set-the-page-dirty-before-we-do-the-IO thing is very effective.  So the
performace impact of making such a change would be nil.

That's for the direct-io case.  Other cases might be hurt more.

Also, perhaps we could poke kblockd to do it for us.

> sync_page wants to get either the current mapping, or a NULL one.
> The sync_page methods must then be able to handle running into a
> NULL mapping.
> 
> With splice, the mapping can change, so you can have the wrong
> sync_page callback run against the page.

Oh.

> >
> >>Well yes, writing to a page would be the main reason to set it dirty.
> >>Is splice broken as well? I'm not sure that it always has a ref on the
> >>inode when stealing a page.
> >>
> >
> >Whereabouts?
> >
> 
> The ->pin() calls in pipe_to_file and pipe_to_sendpage?

One for Jens...

> >
> >>It sounds like you think fixing the set_page_dirty_lock callers wouldn't
> >>be too difficult? I wouldn't know (although the ptrace one should be
> >>able to be turned into a set_page_dirty, because we're holding mmap_sem).
> >>
> >
> >No, I think it's damn impossible ;)
> >
> >get_user_pages() has gotten us a random pagecache page.  How do we
> >non-racily get at the address_space prior to locking that page?
> >
> >I don't think we can.
> >
> 
> But the vma isn't going to disappear because mmap_sem is held; and the
> vma should hold a ref on the inode I think?

That's true during the get_user_pages() call.  Be we run
set_page_dirty_lock() much later, after IO completion.

> >
> >>You're sure about all other lock_page()rs? I'm not, given that
> >>set_page_dirty_lock got it so wrong. But you'd have a better idea than
> >>me.
> >>
> >
> >No, I'm not sure.
> >
> >However it is rare for the kernel to play with pagecache pages against
> >which the caller doesn't have an inode ref.  Think: how did the caller look
> >up that page in the first place if not from the address_space in the first
> >place?
> >
> >- get_user_pages(): the current problem
> >
> >- page LRU: OK, uses trylock first.
> >
> >- pagetable walk??
> >
> 
> Am I wrong about mmap_sem?
> 
> Anyway, it is possible that most of the problems could be solved by locking
> the page at the time of lookup, and unlocking it on completion/dirtying...
> it's just that that would be a bit of a task.

But lock_page() requires access to the address_space.  To kick the IO so we
don't wait for ever.

> Can we somehow add BUG_ONs to
> lock_page to ensure we've got an inode ref?

WARN_ONs.
