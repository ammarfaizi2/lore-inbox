Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbTIGNUn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTIGNUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:20:43 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44686 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263243AbTIGNU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:20:27 -0400
Date: Sun, 7 Sep 2003 14:20:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030907132010.GB19977@mail.jlokier.co.uk>
References: <20030905205418.GA6019@mail.jlokier.co.uk> <20030907072034.435C62C308@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907072034.435C62C308@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <20030905205418.GA6019@mail.jlokier.co.uk> you write:
> > Rusty Russell wrote:
> > > Now, if mremap doesn't move the memory, futexes aren't broken, even
> > > without your patch, right?  If it does move, you've got a futex
> > > sitting in invalid memory, no surprise if it doesn't work.
> > 
> > If the mremap doesn't move the memory it's fine.  No surprise :)
> > 
> > If it's moved, then the program isn't broken - it knows it just did an
> > mremap, and it sends the wakeup to the new address.
> > 
> > This makes sense if async futexes are used on an in-memory private
> > database.  But such programs can just use MAP_ANON|MAP_SHARED if they
> > want mremap to work.
> 
> The only real case (ignoring the "one thread FUTEX_WAIT while the
> other mremaps underneath" which is gonna break anyway), is FUTEX_FD,

By "async futex" I mean FUTEX_FD; sorry if that wasn't clear.
By "sync futex" I mean FUTEX_WAIT.

> I don't see a problem with having to manually move your futex fds in
> this case when the memory underneath them has been remapped.  In
> fact, it'd be surprising if you didn't have to.

I don't see a problem, as long as it is documented.  Anybody grokking
the old futex code would expect futexes to move with mappings.

It's a mild surprise whatever behaviour, because:

   - if it's a MAP_SHARED, then the program doesn't have to move futexes,
     and this is a good thing (think locks in a remap_file_pages
     database mapping).

   - the old (page pinning) version moves FUTEX_FD futexes "automatically",
     in the sense that they're attached to the page which moves.

> Yes.  Invalidate is nice because it catches a programmer mistake.  But
> why not solve the problem by just holding an mm reference, too?

That would work.  An mm isn't that huge once everything's been
unmapped by exit.  Alternatively, mm-private futexes can be woken when
the mm is destroyed.

I just implemented the latter, but come to think of it a reference to
a dead mm is light enough not to bother with a list of "futexes
attached to mm to destroy on exit".

So I'll throw that away and provide a patch which just takes a reference.
(Also, takes inode references).

-- Jamie
