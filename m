Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTIEFWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbTIEFW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:22:27 -0400
Received: from dp.samba.org ([66.70.73.150]:8595 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262186AbTIEFUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:20:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix 
In-reply-to: Your message of "Thu, 04 Sep 2003 22:00:07 +0100."
             <20030904210007.GE31590@mail.jlokier.co.uk> 
Date: Fri, 05 Sep 2003 15:19:07 +1000
Message-Id: <20030905052006.DCCB62C261@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030904210007.GE31590@mail.jlokier.co.uk> you write:
> Rusty Russell wrote:
> > I don't have a problem with the omission.  mremap is logically
> > equivalent to munmap + mmap, so it's a subset of the "I unmapped
> > underneath my futex!".  It's not like it's going to happen without the
> > caller knowing: if the address doesn't change, then the futexes won't
> > break.  If they do, the caller needs to reset them anyway.
> 
> I think mremap() on block of memory containing futexes is reasonable.
> Imagine a big data structure with a table futex locks at the start of
> it.  I'm not sure how useful it is, but it's not worthless.

Think about the code that does this:

	struct futex_file
	{
		struct futex lock;
		int content_len;
		char contents[0];
	};

	fd = sys_futex(&futfile->lock);
	...

	futfile = mremap(futfile, oldsize, newsize, MREMAP_MAYMOVE);
	
Now, if mremap doesn't move the memory, futexes aren't broken, even
without your patch, right?  If it does move, you've got a futex
sitting in invalid memory, no surprise if it doesn't work.

OTOH, I'm interested in returning EFAULT on waiters when pages are
unmapped, because I realized that stale waiters could "match" live
futex wakeups (an mm_struct gets recycled), and steal the wakeup.  Bad
juju.  We could do some uid check or something for anon pages, but
cleaner to flush them at unmap.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
