Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283655AbRLOUUp>; Sat, 15 Dec 2001 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283675AbRLOUUf>; Sat, 15 Dec 2001 15:20:35 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36481 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S283655AbRLOUUT>;
	Sat, 15 Dec 2001 15:20:19 -0500
Date: Sat, 15 Dec 2001 23:17:56 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: bcrl <bcrl@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mempool-2.5.1-D2
Message-ID: <Pine.LNX.4.33.0112152251060.27426-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Dec 2001, Stephan von Krawczynski wrote:

> >  - mempool_alloc(), if called from a process context, never fails. This
> >    simplifies lowlevel IO code (which often must not fail) visibly.
>
> Uh, do you trust your own word? This already sounds like an upcoming
> deadlock to me _now_. [...]

please check it out how it works. It's not done by 'loop forever until
some allocation succeeds'. It's done by FIFO queueing for pool elements
that are guaranteed to be freed after some reasonable timeout. (and there
is no other freeing path that might leak the elements.)

> [...] I saw a lot of try-and-error during the last month regarding
> exactly this point. There have been VM-days where allocs didn't really
> fail (set with right flags), but didn't come back either. [...]

hm, iirc, the code was just re-trying the allocation infinitely (while
sleeping on kswapd_wait).

> [...] And exactly this was the reason why the stuff was _broken_.
> Obviously no process can wait a indefinitely long time to get its
> alloc fulfilled. And there are conditions under heavy load where this
> cannot be met, and you will see complete stall.

this is the problem with doing this in the (current) page allocator:
allocation and freeing of pages is done by every process, so the real ones
that need those pages for deadlock avoidance are starved. Identifying
reserved pools and creating closed circuits of allocation/freeing
relations solves this problem - 'outsiders' cannot 'steal' from the
reserve. In addition, creating pools of composite structures helps as well
in cases where multiple allocations are needed to start a guaranteed
freeing operation.

mempool moves deadlock avoidance to a different, and explicit level. If
everything uses mempools then the normal allocators (the page allocator)
can remove all their reserved pools and deadlock-avoidance code.

> [...] Looking at your mempool-ideas one cannot fight the impression
> that you try to "patch" around a deficiency of the current code. This
> cannot be the right thing to do.

to the contrary - i'm not 'patching around' any deficiency, i'm removing
the need to put deadlock avoidance into the page allocator. But in this
transitional period of time the 'old code' still stays around for a while.
If you look at Ben's patch you'll see the same kind of dualness - until a
mechanizm is fully used things like that are unavoidable.

	Ingo

