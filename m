Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbREZBjS>; Fri, 25 May 2001 21:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbREZBjI>; Fri, 25 May 2001 21:39:08 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:37478 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262505AbREZBiy>; Fri, 25 May 2001 21:38:54 -0400
Date: Fri, 25 May 2001 21:38:36 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <20010526032741.M9634@athlon.random>
Message-ID: <Pine.LNX.4.33.0105252133210.3806-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> side note, it won't compile against pre6, that's against the RH kernel
> that has the tux stuff (PF_ATOMICALLOC in this case) in it, that's also
> included in 2.4.5pre6aa1 if you apply the optional patches in the 30_tux
> directory.

Yeah, I know.  The point is I wanted to know if people were interested in
the approach.  Man, nobody's capable of being a visionary anymore.

> I only had a short look but unless I'm missing something it cannot fix
> anything in the highmem area, you are not reserving anything for highmem
> bounces in particular, you're reserving for swap/irq/atomic allocations
> in general or for some task in particular, that's just broken design I
> think as you will fail anyways eventually because the stacking under
> those layers won't give you any guarantee to make progress. The pool
> must live in the very latest layer of allocations if you want to have
> any guarantee of making progress evenutally, create_bounces() actually
> is called as the very last thing before the atomic stuff, infact loop
> can deadlock as well as it would need its own private pool too after the
> create_bounces() in case of non noop transfer function (but loop is not
> a shotstopper so we didn't addressed that yet, create_bounces itself is
> a showtsopper instead).

You're missing a few subtle points:

	1. reservations are against a specific zone
	2. try_to_free_pages uses the swap reservation
	3. irqs can no longer eat memory allocations that are needed for
	   swap

Note that with this patch the current garbage in the zone structure with
pages_min (which doesn't work reliably) becomes obsolete.

> The only case where a reserved pool make sense is when you know that
> waiting (i.e. running a task queue, scheduling and trying again to
> allocate later) you will succeed the allocation for sure eventually
> (possibly with a FIFO policy to make also starvation impossible, not
> only deadlocks). If you don't have that guarantee those pools
> atuomatically become only a sourcecode and runtime waste, possibly they
> could hide core bugs in the allocator or stuff like that.

You're completely wrong here.

		-ben

