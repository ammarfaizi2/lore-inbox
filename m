Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281116AbRLQQT7>; Mon, 17 Dec 2001 11:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRLQQTu>; Mon, 17 Dec 2001 11:19:50 -0500
Received: from ns.ithnet.com ([217.64.64.10]:55565 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281116AbRLQQTe>;
	Mon, 17 Dec 2001 11:19:34 -0500
Date: Mon, 17 Dec 2001 17:19:31 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: <mingo@elte.hu>
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] mempool-2.5.1-D2
Message-Id: <20011217171931.1a87bab2.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0112152251060.27426-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0112152251060.27426-100000@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001 23:17:56 +0100 (CET)
Ingo Molnar <mingo@elte.hu> wrote:

> 
> On Sat, 15 Dec 2001, Stephan von Krawczynski wrote:
> 
> > >  - mempool_alloc(), if called from a process context, never fails. This
> > >    simplifies lowlevel IO code (which often must not fail) visibly.
> >
> > Uh, do you trust your own word? This already sounds like an upcoming
> > deadlock to me _now_. [...]
> 
> please check it out how it works. It's not done by 'loop forever until
> some allocation succeeds'. It's done by FIFO queueing for pool elements
> that are guaranteed to be freed after some reasonable timeout. (and there
> is no other freeing path that might leak the elements.)

This is like solving a problem by not looking onto it. You will obviously _not_
shoot down allocated and still used bios, no matter how long they are going to
take. So your fixed size pool will run out in certain (maybe weird) conditions.
If you cannot resize (alloc additional mem from standard VM) you are just dead.
Look at it from a different point of view: its basically all the same. Standard
VM has a limited resource and tries to give it away in an intelligent way.
Mempool does the same thing - for a smaller sized environment. But that is per
se no gain. And just as Andrea pointed out, the not-used part of the resources
is just plain wasted - though he thinks this is _good_ because it is simpler in
design and implementation. But on the other hand, you could just do it vice
versa: don't make the mempools, make a cache-pool. VM handles memory, and we
are using a fixed size (but resizeable) mem block as pure pool for page cache.
every page that is somehow locked down (iow _used_, and not simply cached) is
pulled away/out from the cache-pool. cache pool ages (hello rik :-), but stays
the same size. You end up with _lots_ of _free_ mem in normal loads and
acceptable performance. This is no good design. But it doesn't need to answer
the question, what pages to expell under pressure, because per definition in
this design there is nothing to expell/drop. when mem gets low it really _is_
low, because your applications ate it all up. The current design cannot answer
this question correctly, because I must not be able to see allocation failures
in a box of 1 GB ram and very few used applications - and a hugh page cache.
But they are there. So there is a problem, probably in the implementation of a
working design. The answer "drivers must be able to cope with failing allocs"
is WRONG WRONG WRONG. They should not oops, ok, but they cannot stand such a
situation, you will always loose something (probably data). Your good points in
mempool usage will all be the simple fact, that there is a memory reserve that
is not touched by the page cache. There are about 29 ways to achieve this same
goal - and most of them are a lot more straight forward and require less
changes in the rest-kernel.

Please _solve_ the problem, do not _spread_ it.

Regards,
Stephan

