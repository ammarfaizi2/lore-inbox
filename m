Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbREZB2Z>; Fri, 25 May 2001 21:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262432AbREZB2P>; Fri, 25 May 2001 21:28:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:39984 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262423AbREZB2H>; Fri, 25 May 2001 21:28:07 -0400
Date: Sat, 26 May 2001 03:27:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
Message-ID: <20010526032741.M9634@athlon.random>
In-Reply-To: <20010526024230.K9634@athlon.random> <Pine.LNX.4.33.0105252044170.3806-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105252044170.3806-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Fri, May 25, 2001 at 08:52:50PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 08:52:50PM -0400, Ben LaHaise wrote:
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> > Please merge this one in 2.4 for now (originally from Ingo, I only
> > improved it), this is a real definitive fix and there's no nicer way to
> > handle that unless you want to generalize an API for people to generate
> > private anti-deadlock ("make sure to always make a progress") memory
> > pools:
> 
> Alternatively, the following might be more interesting...

side note, it won't compile against pre6, that's against the RH kernel
that has the tux stuff (PF_ATOMICALLOC in this case) in it, that's also
included in 2.4.5pre6aa1 if you apply the optional patches in the 30_tux
directory.

I only had a short look but unless I'm missing something it cannot fix
anything in the highmem area, you are not reserving anything for highmem
bounces in particular, you're reserving for swap/irq/atomic allocations
in general or for some task in particular, that's just broken design I
think as you will fail anyways eventually because the stacking under
those layers won't give you any guarantee to make progress. The pool
must live in the very latest layer of allocations if you want to have
any guarantee of making progress evenutally, create_bounces() actually
is called as the very last thing before the atomic stuff, infact loop
can deadlock as well as it would need its own private pool too after the
create_bounces() in case of non noop transfer function (but loop is not
a shotstopper so we didn't addressed that yet, create_bounces itself is
a showtsopper instead).

The only case where a reserved pool make sense is when you know that
waiting (i.e. running a task queue, scheduling and trying again to
allocate later) you will succeed the allocation for sure eventually
(possibly with a FIFO policy to make also starvation impossible, not
only deadlocks). If you don't have that guarantee those pools
atuomatically become only a sourcecode and runtime waste, possibly they
could hide core bugs in the allocator or stuff like that.

Andrea
