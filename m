Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbTIGHUi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 03:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbTIGHUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 03:20:37 -0400
Received: from dp.samba.org ([66.70.73.150]:42423 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262868AbTIGHUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 03:20:34 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix 
In-reply-to: Your message of "Fri, 05 Sep 2003 21:54:18 +0100."
             <20030905205418.GA6019@mail.jlokier.co.uk> 
Date: Sun, 07 Sep 2003 16:45:58 +1000
Message-Id: <20030907072034.435C62C308@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030905205418.GA6019@mail.jlokier.co.uk> you write:
> Rusty Russell wrote:
> > Now, if mremap doesn't move the memory, futexes aren't broken, even
> > without your patch, right?  If it does move, you've got a futex
> > sitting in invalid memory, no surprise if it doesn't work.
> 
> If the mremap doesn't move the memory it's fine.  No surprise :)
> 
> If it's moved, then the program isn't broken - it knows it just did an
> mremap, and it sends the wakeup to the new address.
> 
> This makes sense if async futexes are used on an in-memory private
> database.  But such programs can just use MAP_ANON|MAP_SHARED if they
> want mremap to work.

wakeup is not a problem: from the kernel's POV, between wakeups the
futex doesn't exist.

The only real case (ignoring the "one thread FUTEX_WAIT while the
other mremaps underneath" which is gonna break anyway), is FUTEX_FD, I
don't see a problem with having to manually move your futex fds in
this case when the memory underneath them has been remapped.  In fact,
it'd be surprising if you didn't have to.

> > OTOH, I'm interested in returning EFAULT on waiters when pages are
> > unmapped, because I realized that stale waiters could "match" live

> Ah, you're right.  Not fixing that is a serious bug.
> It can happen when an async futex fd is passed to another process.

> ps. There's another bug: shared waiters match inodes, which they don't
> hold a reference to.  Inodes can be recycled too.  Fix is easy: just
> need to take an inode reference.

Yes.  Invalidate is nice because it catches a programmer mistake.  But
why not solve the problem by just holding an mm reference, too?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
