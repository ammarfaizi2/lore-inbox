Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131522AbRAJQEL>; Wed, 10 Jan 2001 11:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131697AbRAJQEB>; Wed, 10 Jan 2001 11:04:01 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:29711 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S131522AbRAJQDw>; Wed, 10 Jan 2001 11:03:52 -0500
Date: Wed, 10 Jan 2001 17:03:48 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <Pine.LNX.4.10.10101092304410.3414-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101101619230.16888-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Linus Torvalds wrote:

> 
> 
> On Wed, 10 Jan 2001, Andrea Arcangeli wrote:
> 
> > On Tue, Jan 09, 2001 at 01:31:35PM -0800, Linus Torvalds wrote:
> > > don't have to worry about undocumented extensions etc.
> > 
> > Infact I don't blame gcc maintainers for that, but the standard. Ok, minor
> > issue.
> 
> Yeah, and nothing we can do about it any more.. Oh, well.
> 
> The fact is that the 
> 
> 	case xxx: ;
> 
> syntax is fairly ugly, so I'd prefer the fixup patches to look more like
> 
> 	case xxx:
> 		/* fallthrough */ ;
> 	}
> 
> or something (or maybe just a "break" statement), just so that we don't
> turn the poor C language into line noise (can anybody say "perl" ;)

Of course, you don't mean that the fallthrough comment and the break
statement have the same functionality! (well you put the closing
bracket and I agree that for the last case it's the same).

I think it's always a good idea to put a comment when you relay on the
(otherwise implicit) fallthrough, especially if there are statements 
in between:

	case xxx:
		stm1;
		/* fallthrough */
	case yyy:
		stm2;

but, note the absence of the semicolon after the comment (which is legal,
if stm1 is present).

The above is just what i feel "natural": it says that case xxx
is almost the same as case yyy but for a single (initial) statement.
It looks like "good C" to my eyes.

But what happens if I delete the stm1 line? We have:

	case xxx:
		/* fallthrough */
	case yyy:
		stm2;

which is wrong. It could be:

	case xxx:
	case yyy:
		stm2;

which says that xxx and yyy are just the same, and looks fine to me. 
Here the "fallthrough" rule is very readable. Too bad it's wrong.

So let me state the rule:
1) always put a comment when relaying on the fallthrough, followed
   by a semicolon, even if not strictly necessary (so that you can
   delete the statements above it later).
2) put the same comment or a break after the last case.

Maybe it's time to update Documentation/CodingStyle? (a very pleasant
reading, BTW. I must say I sometimes re-read it just for fun)

> I have to say, I think it was Pascal had this "no semicolon needed before
> an 'end'" rule, and I always really hated that. The C statement rules make
> a lo tmore sense, and requiring a statement after a case statement is
> probably a very good requirement from a language standpoint. It's just not
> very pretty - but adding a break or a comment will at least separate out
> the colon and the semi-colon a bit.
> 
> 		Linus

Well, I've always hated the Pascal rule, too. It makes you feel that
there's a missing semicolon AND it forces you to add one when you decide
to add new statements after the last one (i used to forget it most of
the time). Now, this C rule makes you see a semicolon where you don't
expect it to be, after a comment. I'm used to see comments after the
semicolon, as in:

	int	foo;	/* this is foo */

or alone.  The only place I'd expect to see a comment before a
semicolon is in:

	for(;;)
		/* nop */;

but I'd write that differently anyway:

	for(;;) {
		continue;
	}

which makes easier to add statements inside the loop. For maximum
readability I'd leave the "continue" even if there are other statements:

	for(;;) {
		stm1;
		if (condition) {
			break;
		}
		stm2;
		continue;
	}

(it's like a comment that says "loop again", opposed to the break which
says "stop looping") but I agree that's overkill. B-)

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
