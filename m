Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbTIEUzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265704AbTIEUza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:55:30 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:49293 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265723AbTIEUys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:54:48 -0400
Date: Fri, 5 Sep 2003 21:54:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030905205418.GA6019@mail.jlokier.co.uk>
References: <20030904210007.GE31590@mail.jlokier.co.uk> <20030905052006.DCCB62C261@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905052006.DCCB62C261@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> Now, if mremap doesn't move the memory, futexes aren't broken, even
> without your patch, right?  If it does move, you've got a futex
> sitting in invalid memory, no surprise if it doesn't work.

If the mremap doesn't move the memory it's fine.  No surprise :)

If it's moved, then the program isn't broken - it knows it just did an
mremap, and it sends the wakeup to the new address.

This makes sense if async futexes are used on an in-memory private
database.  But such programs can just use MAP_ANON|MAP_SHARED if they
want mremap to work.

> OTOH, I'm interested in returning EFAULT on waiters when pages are
> unmapped, because I realized that stale waiters could "match" live
> futex wakeups (an mm_struct gets recycled), and steal the wakeup.  Bad
> juju.  We could do some uid check or something for anon pages, but
> cleaner to flush them at unmap.

Ah, you're right.  Not fixing that is a serious bug.
It can happen when an async futex fd is passed to another process.

Not only can the mm_struct be recycled, it might be recycled into an
inode so it could match a file futex too.

This can be fixed more simply than the full do_unmap patch I posted
earlier, by invalidating all the futexes in an mm when it is destroyed.

Another fix would be to prevent futex fds of private mappings being
passed to another process, somehow.

It must be fixed somehow.

Linus, which patch do you prefer?  Invalidate all futexes in an mm
when it's destroyed, or invalidate ranges in do_munmap?

-- Jamie

ps. There's another bug: shared waiters match inodes, which they don't
hold a reference to.  Inodes can be recycled too.  Fix is easy: just
need to take an inode reference.
