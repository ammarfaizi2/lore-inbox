Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTIFRqh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 13:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTIFRqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 13:46:34 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:18574 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261427AbTIFRqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 13:46:32 -0400
Date: Sat, 6 Sep 2003 18:46:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
Message-ID: <20030906174615.GA10987@mail.jlokier.co.uk>
References: <3F58F0F7.4090105@redhat.com> <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> The new bug is that "offset" has been declared as an alternative in
> the union, instead of as an element in the structures comprising it,
> effectively eliminating it from the key: keys match which should not.

Auch!

(Off to the post office for a pack of brown paper bags)
(And a pillow)

> The old bug is that if futex_requeue were called with identical
> key1 and key2 (sensible? tended to happen given the first bug),
> it was liable to loop for a long time holding futex_lock: guard
> against that, still respecting the semantics of futex_requeue.

That explains the hang I just saw in one run of Ulrich's test...
And it explain's why it's not repeatable.

With key1 == key2, you get to move nr_requeue waiters to the end of
the waiting list.  I can't think of a good use for it, but it does do
something visible.

> +				/* Make sure to stop if key1 == key2 */
> +				if (head1 == head2 && head1 != next)
> +					head1 = i;

Subtle, when nr_requeue > 1.  That's a disturbingly nice trick :)

> While here, please let's also fix the get_futex_key VM_NONLINEAR
> case, which was returning the 1 from get_user_pages, taken as an
> error by its callers.

Yes.  I just spotted it too.

> And save a few bytes and improve debuggability
> by uninlining the top-level futex_wake, futex_requeue, futex_wait.

Fair point about about debuggability, but does it really save bytes to
uninline these called-once functions?

-- Jamie
