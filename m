Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271807AbRICUgD>; Mon, 3 Sep 2001 16:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271806AbRICUfn>; Mon, 3 Sep 2001 16:35:43 -0400
Received: from gw.xkey.com ([206.86.100.52]:7694 "EHLO happy.xkey.com")
	by vger.kernel.org with ESMTP id <S271805AbRICUfe>;
	Mon, 3 Sep 2001 16:35:34 -0400
Date: Mon, 3 Sep 2001 13:35:52 -0700
Message-Id: <200109032035.NAA01597@happy.xkey.com>
From: David desJardins <david@desjardins.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> I have one thing to say to people who do not like the new min/max 
> functions: most of them probably never even _understood_ the multitude 
> of bugs that are inherent in the classical 
> 
>         #define min(x,y) ((x) < (y) ? (x) : (y)) 

I think you're mistaken about what people understand.

The explicit typing of MIN and MAX will avoid some bugs that have to do
with the comparison of entities of different types.  The explicit typing
will also introduce some bugs, when a user uses the wrong type (e.g.,
when the code is initially written with the correct type, but then
someone later changes the type of the variables, and doesn't remember to
change the type in the macro call).  Overall, I think it will be about a
wash.

If this is really a serious problem, then people shouldn't be using the
comparison operators like "<" either, as they have exactly the same
problem when used to compare objects of different types (particularly
since C has such broken rules for deciding what type to use when
comparing objects of different types).  Instead, we should have
LESSTHAN(type,a,b), etc.

I think the best approach to bug avoidance would be two-argument MIN and
MAX functions which require that both arguments have the same type, but
where that can be any type.  Then users who want to compare objects of
different types would have to explicitly cast one to the type of the
other (or both to a third common type).  In the most common case where
users are simply comparing objects of the same type, there would be no
need or reason to change the code.

It's simple enough for an external checker to confirm that this rule is
followed.  The same checker could enforce the same rule for "<" and
other comparison operators, which would probably help eliminate several
bugs (without the unacceptably clunky LESSTHAN macro).

I think no one who is comparing objects of two different types can
legitimately complain about being asked to cast one (or both) of them to
a common type: the user, rather than the compiler, should indeed choose
the type of the comparison.  But that's different from redundantly
adding the type everywhere to comparisons of objects of the same type,
which introduces, rather than eliminating, a source of error.

  -- David desJardins
