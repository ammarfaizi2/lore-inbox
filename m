Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274920AbRJJGbZ>; Wed, 10 Oct 2001 02:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274951AbRJJGbP>; Wed, 10 Oct 2001 02:31:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60690 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274920AbRJJGbD>; Wed, 10 Oct 2001 02:31:03 -0400
Date: Tue, 9 Oct 2001 23:30:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <15299.59317.38687.588368@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0110092323450.1360-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Oct 2001, Paul Mackerras wrote:
>
> There is an assumption that anyone modifying the list (inserting or
> deleting) would take a lock first, so the deletion is just a pointer
> assignment.  Any reader traversing the list (without a lock) sees
> either the old pointer or the new, which is fine.

Right, that's not the problem.

> The difficulty is in making sure that no reader is still inspecting
> the list element you just removed before you free it, or modify any
> field that the reader would be looking at (particularly the `next'
> field :).

..which implies _some_ sort of locking, even if it may be deferred.

The locking can be per-CPU, whatever - have a per-CPU count for "this many
traversals in progress", and have every lookup increment it before
starting, and decrement it after stopping.

Then the deleter can actually free the thing once he has seen every CPU go
down to zero, with the proper memory barriers.

Yes, I see that it can work. But it sounds like a _lot_ of complexity for
not very much gain.

Right now, you already have to have eight CPU's to see locking as a large
problem in normal life. People have normal patches to bring that easily up
to 16. Then how much hard-to-debug-with-subtle-memory-ordering-issues code
do you want to handle the few machines that aren't in that range?

I'm just trying to inject a bit of realism here.

		Linus

