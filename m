Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbRBHRD2>; Thu, 8 Feb 2001 12:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbRBHRDS>; Thu, 8 Feb 2001 12:03:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129846AbRBHRDC>; Thu, 8 Feb 2001 12:03:02 -0500
Date: Thu, 8 Feb 2001 12:02:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
In-Reply-To: <Pine.LNX.4.21.0102081549210.12077-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1010208115135.873A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Hugh Dickins wrote:

> On Wed, 7 Feb 2001, Linus Torvalds wrote:
> > On Wed, 7 Feb 2001, Hugh Dickins wrote:
> > > 
> > > None of those optimizes this: I believe the semantics of "||" (don't
> > > try next test if first succeeds) forbid the optimization "|" gives?
> > 
> > No. The optimization is entirely legal - but the fact that
> > "constant_test_bit()" uses a "volatile unsigned int *" is the reason why
> > gcc thinks it can't optimize it.
> 
> Ah, yes, I hadn't noticed that, the "volatile" is indeed why it ends up
> with three "mov"s.  But take the "volatile"s out of constant_test_bit(),
> and DEBUG_ADD_PAGE still expands to three tests and three (four if 2.97)
> jumps - which is what originally offended me.
> 
> But Mark (in test program in private mail) shows gcc combining bits
> into one test and one jump, just as we'd hope (and I wrongly thought
> forbidden).  Perhaps the inline function nature of constant_test_bit()
> (which Mark didn't use) gets in the way of combining those tests.
> 
> > You could try to remove the volatile from test_bit, and see if that fixes
> > it - but then we'd have to find and add the proper "rmb()" calls to people
> > who do the endless loop kind of thing like above.
> 
> That is not an inviting path to me, at least not any time soon!
> 
> I think this all argues for the little patch I suggested - just avoid
> test_bit() here.  But it was only intended as a quick little suggestion:
> looks like our tastes differ, and you prefer taking the _tiny_ hit of
> using the regular macros, to seeing "1<<PG_bitshift"s in DEBUG_ADD_PAGE.
> 

The use of the key word 'volatile' has gone just a bit too far in
some cases.

given:
funct()
{
   volatile unsigned int;
}

Is plain dumb. There is nobody else that can touch that local
variable except the code in funct(). Even if it's recursive,
the Nth invocation still can't (using legal 'C' code) touch
that variable. Therefore, it should not be declared volatile.


Another problem with 'volatile' has to do with pointers. When
it's possible for some object to be modified by some external
influence, we see:

	volatile struct whatever *ptr;

Now, it's unclear if gcc knows that we don't give a damn about
the address contained in 'ptr'. We know that it's not going to
change. What we are concerned with are the items within the
'struct whatever'. From what I've seen, gcc just reloads the
pointer.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
