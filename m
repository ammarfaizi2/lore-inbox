Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTIGM0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 08:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTIGM0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 08:26:07 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:7001 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S261877AbTIGM0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 08:26:03 -0400
Date: Sun, 7 Sep 2003 13:27:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@redhat.com>
cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch
In-Reply-To: <Pine.LNX.4.44.0309070322310.17404-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0309071248510.3022-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Sep 2003, Ingo Molnar wrote:
> 
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
> the loop exit condition variable? You are trying to avoid the lockup but
> the first one ought to be the most straightforward way to do it.

I think you're reading it as a "list_for_each(i, head1)" loop,
whereas it is and must be a "list_for_each_safe(i, next, head1)" loop.

So it won't (in general) terminate after this one requeueing (as
list_for_each would, finding i->next == head1): termination depends on
next (already set) and head1, so I repoint head1 to the first requeued.

So it should terminate after one pass down the list, when it reaches the
first requeued, and can then return the appropriate "ret" count to user.

You may perhaps know that the ret count is not important, but I don't
know that, so wanted to get it right.  (At the time, I also wanted to
have the list sorted exactly as intended, but now I can't see that the
relative positions of different keys could matter at all.)

It may be bad practice to use a familiar macro like list_for_each_safe,
yet play with its controlling variables within the loop.  I just felt
safer that way than expanding it, or adding extraneous variables.

Hugh

