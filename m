Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271371AbRH1PRu>; Tue, 28 Aug 2001 11:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271349AbRH1PRa>; Tue, 28 Aug 2001 11:17:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8975 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271388AbRH1PR2>; Tue, 28 Aug 2001 11:17:28 -0400
Date: Tue, 28 Aug 2001 08:14:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <3B8BA883.3B5AAE2E@linux-m68k.org>
Message-ID: <Pine.LNX.4.33.0108280732560.8585-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Aug 2001, Roman Zippel wrote:
>
> Linus Torvalds wrote:
>
> > The problem with signed compares is not just comparing a signed entity
> > against a unsigned one. It's quite common to have signed quantities on
> > both sides, but _intending_ a unsigned comparison or vice versa.
>
> Then it's a bug that should _not_ be fixed in the min macro. Unsigned
> values should be hold in unsigned variables. If it's that common, please
> show me a sane and realistic example.

I'll show you a real example from drivers/acorn/scsi/acornscsi.c:

	min(host->scsi.SCp.this_residual, DMAC_BUFFER_SIZE / 2);

this_residual is "int", and "DMAC_BUFFER_SIZE" is just a #define for
an integer constant. So the above is actually a signed comparison, and
I'll bet you that was not what the author intended.

Now, this_residual is hopefully never negative, so it doesn't matter.

But how many security bugs have you seen where people just didn't even
_think_ of the user giving invalid values?

Think of code like

	#define BUFFER_SIZE (10)

	char buf[BUFFER_SIZE];

	len = min(user_len, BUFFER_SIZE);
	if (copy_from_user(buf, user, len))
		return -EFAULT;

which is not all that broken. Sure, maybe you _should_ have marked
BUFFER_SIZE explicitly unsigned, but face it, how many people actually do
that?

So "BUFFER_SIZE" is actually a signed value (never mind that it is
obviously positive), and if "user_len" is signed too the above doesn't
actually do what the programmer obviously _meant_ to do.

Does code like the above happen? Sure it does. The input can be signed
because often the user interfaces are defined outside the kernel (think of
the arguments to "bind()" or "setsockopt()", and realize that "socklen_t"
is "int" - the programmer may not even SEE the signedness of the arguments
exactly because they are typedefs).

And did you realize, for example, that of the existing "min()"
implementations, some were inline functions that implicitly cast their
arguments to "int" (and one to "unsigned int")? This way we could also
maintain those kinds of local conventions - where the programmer had
originally (at least in the case of the unsigned int) on purpose made all
"min()" functions unsigned.

That, together with different pieces of code really wanting different
semantics. Let me quote something that got removed:

<include/net/sock.h>:

-static __inline__ int min(unsigned int a, unsigned int b)
-{
-       if (a > b)
-               a = b;
-       return a;
-}
-

<net/khttpd/prototypes.h>:

-/* the TCP/IP stack defines a __BROKEN__ set of min/max functions !! */
-/* So we better define our own.                                      */
-
-/* Broken means: working on unsigned data only, which is not acceptable
-                for kHTTPd and probably a lot of other functions. */
-
-#undef min
-#undef max
-#define min(a,b)  ( (a) < (b) ? (a) : (b) )
-#define max(a,b)  ( (a) > (b) ? (a) : (b) )

Now, just _imagine_ the set of bugs implicit in the fact that part of
networking wants "min()" to be unsigned, while another part (that _uses_
the code that depends on the unsigned "min()") re-defines min() to be
"whatever the arguments are".

Now isn't it better to have a nice macro that _can_ be used for all of
this, and that _does_ explicitly handle the issue of signedness that
different parts of the code has very different opinions on, and that
clearly encodes the assumptions that you have at the exact point of use?

		Linus

