Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTIGNA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTIGNA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:00:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42894 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263183AbTIGNAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:00:54 -0400
Date: Sun, 7 Sep 2003 14:00:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
Message-ID: <20030907130017.GA19977@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309042224240.5364-100000@localhost.localdomain> <Pine.LNX.4.44.0309070322310.17404-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309070322310.17404-100000@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> btw., regarding this fix:
> 
>   ChangeSet@1.1179.2.5, 2003-09-06 12:28:20-07:00, hugh@veritas.com
>     [PATCH] Fix futex hashing bugs
> 
> why dont we do this:
> 
>                         } else {
>                                 /* Make sure to stop if key1 == key2 */
> 				if (head1 == head2)
> 					break;
>                                 list_add_tail(i, head2);
>                                 this->key = key2;
>                                 if (ret - nr_wake >= nr_requeue)
>                                         break;
>                         }
> 
> instead of the current:
> 
>                         } else {
>                                 list_add_tail(i, head2);
>                                 this->key = key2;
>                                 if (ret - nr_wake >= nr_requeue)
>                                         break;
>                                 /* Make sure to stop if key1 == key2 */
>                                 if (head1 == head2 && head1 != next)
>                                         head1 = i;
>                         }
> 
> what's the point in requeueing once, and then exiting the loop by changing
> the loop exit condition variable?

Hugh's patch is clever and subtle.  It doesn't exit the loop; the
loop continues from "next".

What it does is change the end condition so that the loop stops just
before the first requeued futex.  Let's call that one REQUEUED1.

If are other futexes to requeue, they after inserted after REQUEUED1
(because head2 wasn't changed), yet the end condition _isn't_ changed
when this happens, because now head1 != head2.

This causes the correct number of futexes to be requeued at the end of
the wait list.

> You are trying to avoid the lockup but the first one ought to be the
> most straightforward way to do it.

Hugh's patch returns the correct retval _and_ requeues the correct
number of waiters to the end of the queue.  And it does it without
fancy code.

Remember that the waiter order is visible to userspace - it's used by
"fair" operations, so it's appropriate that requeuing a futex to
itself moves nr_requeues waiters to the end of the queue, just like it
does when it requeues to a different futex.

If the code to handle that were complicated, I'd vote for dropping it.
But Hugh's patch does exactly the right thing in a simple way.  Lovely!

-- Jamie
