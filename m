Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283244AbRLOSNU>; Sat, 15 Dec 2001 13:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283234AbRLOSNJ>; Sat, 15 Dec 2001 13:13:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9088 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S283244AbRLOSMx>;
	Sat, 15 Dec 2001 13:12:53 -0500
Date: Sat, 15 Dec 2001 20:40:19 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ben LaHaise <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
Message-ID: <Pine.LNX.4.33.0112152020030.25153-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Dec 2001, Rik van Riel wrote:

> > such scenarios can only be solved by using/creating independent pools,
> > and/or by using 'composite' pools like raid1.c does. One common
>
> OK, you've convinced me ...
> ... of the fact that you're reinventing Ben's reservation
> mechanism, poorly.

i have to admit that i did not know Ben's patch until today. I must have
missed it when he released it, and apparently there were no followup
releases(?). I now understand why Ben had to flame me. Anyway, here is his
patch:

	http://lwn.net/2001/0531/a/bcrl-reservation.php3

With all respect, even if i had read it before, i'd have done mempool.c
the same way as it is now. (but i'd obviously have Cc:-ed Ben on it during
its development.) I'd like to sum up Ben's patch (Ben please correct me if
i misrepresent your patch in any way):

the patch adds a reservation feature to the page allocator. It defines a
'reservation structure', which causes the true free pages count of
particular page zones to be decreased artificially, thus creating a
virtual reserve of pages. These reservation structures can be assigned to
processes on a codepath basis. Eg. on IRQ entry the current process gets
assigned the IRQ-atomic reservation - and any original reservation is
restored on IRQ-exit. On swapping-code entry, arbitrary processes get the
swapping reservation. kswapd, kupdated and bdflush have their own,
permanent reservations. Freeing into the reserved pools is done by linking
the reservation structure to it's "home-zone", which the __free_pages()
code polls and refills. One process has a single active reservation
structure to allocate from.

this approach IMO does not answer some fundamental issues:

- Allocations might still fail with NULL. With mempool, allocations in
  process contexts are guaranteed to always succeed.

- it does not allow the reservation of higher order allocations, which can
  be especially important given the poor higher-order behavior of the page
  allocator.

- the reservation patch does not offer deadlock avoidance in critical code
  paths with complex allocation patterns (see the examples from my
  previous email). Just having separate pools of pages is not enough.

- minor nit #1: reservations are tied to zones, while mempool can take
  from different zones, as long as the zones are compatible.

- minor nit #2: reservations are adding overhead to critical code areas
  (and yes, besides oom-only code, the fast-path is touched as well) such
  as rmqueue() and __free_pages(). Mempool does not add overhead to the
  underlying allocator(s).

- perhaps there is a more advanced patch available (Ben?), but right now i
  cannot see how the SLAB allocator can have the same reservation concept
  added, without excessive code duplication.

Rik, it would be nice if you could provide a few technical arguments that
underscore your point. If i'm wrong then i'd like to be proven wrong.

	Ingo

