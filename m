Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275045AbRJJHw7>; Wed, 10 Oct 2001 03:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275082AbRJJHwt>; Wed, 10 Oct 2001 03:52:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1273 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S275045AbRJJHwj>;
	Wed, 10 Oct 2001 03:52:39 -0400
Date: Wed, 10 Oct 2001 13:28:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010132830.A17135@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110092323450.1360-100000@penguin.transmeta.com> Linus Torvalds wrote:
> On Wed, 10 Oct 2001, Paul Mackerras wrote:
>> The difficulty is in making sure that no reader is still inspecting
>> the list element you just removed before you free it, or modify any
>> field that the reader would be looking at (particularly the `next'
>> field :).

> ..which implies _some_ sort of locking, even if it may be deferred.

> The locking can be per-CPU, whatever - have a per-CPU count for "this many
> traversals in progress", and have every lookup increment it before
> starting, and decrement it after stopping.

> Then the deleter can actually free the thing once he has seen every CPU go
> down to zero, with the proper memory barriers.

> Yes, I see that it can work. But it sounds like a _lot_ of complexity for
> not very much gain.

It can get really ugly since the deleter has to keep
checking periodically for zero-traversal-count. During that peiod more
deletions can happen and the resulting in the need to maintain
deleters as well.

An alternative approach is to divide the timeline
of the kernel into cycles - periods where every CPU does atleast
one context switch thereby losing reference to any pointer to
kernel data. You can now batch all the deletions prior to the
start of a period and finish them after the end of that period. Any
new deletions that happens during  such a period get batched to the
next such period. Any new traversal will see not see the older
copy of the data since the global pointer(s) was updated.


> Right now, you already have to have eight CPU's to see locking as a large
> problem in normal life. People have normal patches to bring that easily up
> to 16. Then how much hard-to-debug-with-subtle-memory-ordering-issues code
> do you want to handle the few machines that aren't in that range?

Yes, various degrees of weakness of memory ordering will make writing code
harder, but it can be dealt with be defining primitives that
behaves uniformly across different architectures. As for large machines
are concerned, I hope the answer is "yes as long as it doesn't adversely
affect the lower end" :-)

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
