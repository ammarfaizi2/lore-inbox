Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130102AbRBGVkm>; Wed, 7 Feb 2001 16:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130213AbRBGVkc>; Wed, 7 Feb 2001 16:40:32 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18446 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130102AbRBGVkZ>; Wed, 7 Feb 2001 16:40:25 -0500
Date: Wed, 7 Feb 2001 13:40:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.4.21.0102071948260.5423-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10102071336230.5084-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Feb 2001, Hugh Dickins wrote:
> 
> The "(1<<PG_bitshift)" part of it is done, sure; but I've rechecked
> activate_page_nolock() compiled -O2 -march=i686 with egcs-2.91.66 (RH7.0
> kgcc), gcc-2.96-69 (RH7.0 gcc+fixes), gcc-2.97 (gcc-snapshot-20010207-1).
> 
> None of those optimizes this: I believe the semantics of "||" (don't
> try next test if first succeeds) forbid the optimization "|" gives?

No. The optimization is entirely legal - but the fact that
"constant_test_bit()" uses a "volatile unsigned int *" is the reason why
gcc thinks it can't optimize it.

Oh, well. That "volatile" is really totally bogus. But it's there because
there are probably drivers that do

	while (test_bit(...))
		/* nothing */;

and the compiler woul doptimize it away a bit too much without the
volatile. Dang.

You could try to remove the volatile from test_bit, and see if that fixes
it - but then we'd have to find and add the proper "rmb()" calls to people
who do the endless loop kind of thing like above.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
