Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRBHQiY>; Thu, 8 Feb 2001 11:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRBHQiO>; Thu, 8 Feb 2001 11:38:14 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:41394 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S129116AbRBHQiF>; Thu, 8 Feb 2001 11:38:05 -0500
Date: Thu, 8 Feb 2001 17:37:45 +0100
From: David Weinehall <tao@acc.umu.se>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Howells <dhowells@cambridge.redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] micro-opt DEBUG_ADD_PAGE
Message-ID: <20010208173745.A27383@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.10.10102071336230.5084-100000@penguin.transmeta.com> <Pine.LNX.4.21.0102081549210.12077-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0102081549210.12077-100000@localhost.localdomain>; from hugh@veritas.com on Thu, Feb 08, 2001 at 04:24:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2001 at 04:24:23PM +0000, Hugh Dickins wrote:
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

Well, after all, it's debugging code, and the code now is easy to read.
Your code, while more efficient, isn't. I think that clarity takes
priority over efficiency in non-critical code such as debugging
code. Of course, this is my personal opinion...


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
