Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTIHCIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 22:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTIHCIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 22:08:17 -0400
Received: from dp.samba.org ([66.70.73.150]:63911 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261863AbTIHCIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 22:08:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix 
In-reply-to: Your message of "Sun, 07 Sep 2003 14:20:10 +0100."
             <20030907132010.GB19977@mail.jlokier.co.uk> 
Date: Mon, 08 Sep 2003 11:49:12 +1000
Message-Id: <20030908020812.4EC372C609@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030907132010.GB19977@mail.jlokier.co.uk> you write:
> I don't see a problem, as long as it is documented.  Anybody grokking
> the old futex code would expect futexes to move with mappings.

BTW, I don't know of anyone *doing* this, but IMHO it's not worth a
single line of kernel code, since if you don't adjust your futex
addresses when you mremap, the try_down_futex will segv after the poll
or whatever.  As a programmer, I would *expect* to have to reset the
futexes (along with every other pointer into the map) when mremap
happens: after all, I told the kernel to watch the old address.  If it
still works, great, but I'd not expect it.

> > Yes.  Invalidate is nice because it catches a programmer mistake.  But
> > why not solve the problem by just holding an mm reference, too?
> 
> That would work.  An mm isn't that huge once everything's been
> unmapped by exit.  Alternatively, mm-private futexes can be woken when
> the mm is destroyed.
> 
> I just implemented the latter, but come to think of it a reference to
> a dead mm is light enough not to bother with a list of "futexes
> attached to mm to destroy on exit".
> 
> So I'll throw that away and provide a patch which just takes a reference.
> (Also, takes inode references).

Agreed.  You can get a page per 2 fds trivially anyway with pipes, so
staying within that bound is fairly safe.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
