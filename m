Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQL2Byb>; Thu, 28 Dec 2000 20:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbQL2ByV>; Thu, 28 Dec 2000 20:54:21 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8201 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129464AbQL2ByH>; Thu, 28 Dec 2000 20:54:07 -0500
Date: Thu, 28 Dec 2000 17:23:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stefan Traby <stefan@hello-penguin.com>
cc: Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
In-Reply-To: <20001229014918.A10171@stefan.sime.com>
Message-ID: <Pine.LNX.4.10.10012281712180.1231-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Stefan Traby wrote:
> On Thu, Dec 28, 2000 at 03:37:51PM -0800, Linus Torvalds wrote:
> 
> > Too bad. Maybe somebody should tell gcc maintainers about programmers that
> > know more than the compiler again.
> 
> I know that {p,}gcc-2.95.2{,.1} are not officially supported.

Hmm, I use gcc-2.95.2 myself on some machines, and while I'm not 100%
comfortable with it, it does count as "supported" even if it has known
problems with "long long". pgcc isn't.

> Did you know that it's impossible to compile nfsv4 because of
> register allocation problems with long long since (long long) month ?

lockd v4 (for NFS v3), I assume. 

No, I wasn't aware of this particular bug. 

> The following does not hurt, it's just a fix for a broken
> compiler:

Ugh, that's ugly.

Can you test if it is sufficient to just simplify the math a bit, instead
of uglyfing that function more? The nlm4_encode_lock() function already
tests for NLM4_OFFSET_MAX explicitly for both start and end, so it should
be ok to just re-code the function to not do the extra "loff_t_to_s64()"
stuff, and simplify it enough that the compile rwill be happy to compile
the simpler function. Something along the lines of

	if (.. NLM4_OFFSET_MAX tests ..)
		..

	*p++ = htonl(fl->fl_pid);

	start = fl->fl_start;
	len = fl->fl_end - start;
	if (fl->fl_end == OFFSET_MAX)
		len = 0;

	p = xdr_encode_hyper(p, start);
	p = xdr_encode_hyper(p, len);

	return p;

Where it tries to minimize the liveness of the 64-bit values, and tries to
avoid extra complications.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
