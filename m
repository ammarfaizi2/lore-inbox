Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbRE1Olx>; Mon, 28 May 2001 10:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263067AbRE1Oln>; Mon, 28 May 2001 10:41:43 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:42255 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263070AbRE1OlY>; Mon, 28 May 2001 10:41:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Maximum size of automatic allocation? (was: [PATCH] fs/devfs/base.c)
Date: Mon, 28 May 2001 16:43:06 +0200
X-Mailer: KMail [version 1.2]
Cc: <alan@lxorguk.ukuu.org.uk>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <GLEPIDKFGKPCBDLKDHEAAELGDDAA.aki.jain@stanford.edu> <200105271321.f4RDLoM00342@mobilix.ras.ucalgary.ca>
In-Reply-To: <200105271321.f4RDLoM00342@mobilix.ras.ucalgary.ca>
MIME-Version: 1.0
Message-Id: <01052816430616.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 May 2001 15:21, Richard Gooch wrote:
> Akash Jain writes:
> > in fs/devfs/base.c,
> > the struct devfsd_notify_struct is approx 1056 bytes, allocating it
> > on a stack of 8k seems unreasonable.  here we simply move it to the
> > heap, i don't think it is a _must_ be on stack type thing
>
> I absolutely don't want this patch applied. It's bogus. It is
> entirely safe to alloc 1 kB on the stack in this code, since it has a
> short and well-controlled code path from syscall entry to the
> function. This is not some function that can be called from some
> random place in the kernel and thus has a random call path.
>
> Using the stack is much faster than calling kmalloc() and it also
> doesn't add to system memory pressure. That's why I did it this way
> in the first place. Further, it's much safer to use the stack, since
> the memory is freed automatically. Thus, there's less scope for
> introducing errors.
>
> Please fix your checker to deal with this class of functions which
> have a well-defined call path. I'd suggest looking at the total stack
> allocations from syscall entry point all the way to the end function.
> Ideally, you'd trace the call path to every function, but of course
> that may be computationally infeasible. Hopefully it's feasible to do
> this for any function which has a stack allocation which exceeds some
> threshold.

I did the same thing in my directory indexing patch, but with a much 
larger buffer: 2728 bytes.  I traced the path from the syscall and all 
the paths out as well.  I did cause a stack overflow with this because 
gcc took the union of two such allocations in different control blocks 
instead of the intersection, much to my surprise.  This was cured by 
using fancier code to eliminate one of the allocations.  Al since broke 
this out into a separate function, making it more obviously safe, but 
note: it has to be broken out further so that there are no complex 
trees of calls descending from the stack storage pig.

This call appends a new block to a file then splits the contents of 
some other block into the new block using some workspace on the stack. 
The block has to be appended outside the function, otherwise the big 
stack allocation gets carried arbitrarily far through the kernel (think 
recursive allocation).  Similarly for mark_buffer_dirty and just to be 
safe, brelse as well.  Mark_buffer_dirty didn't use to have a big hairy 
call chain attached to it but it does now.   Even lowly brelse might 
evolve this way without warning.  The only safe thing to do is avoid 
all calls outside the subystem and comment the others.

My question: assuming the entire call chain is documented, exactly how 
much of the 8K kernel stack is safe to use?

--
Daniel
