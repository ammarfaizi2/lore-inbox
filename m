Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281173AbRKTRR5>; Tue, 20 Nov 2001 12:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281179AbRKTRRr>; Tue, 20 Nov 2001 12:17:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55045 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281173AbRKTRRe>; Tue, 20 Nov 2001 12:17:34 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: i386 flags register clober in inline assembly
Date: Tue, 20 Nov 2001 17:12:16 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9te2tg$20d$1@penguin.transmeta.com>
In-Reply-To: <20011118020957.A10674@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0111171844001.899-100000@penguin.transmeta.com> <20011120003338.A24717@twiddle.net>
X-Trace: palladium.transmeta.com 1006276627 18877 127.0.0.1 (20 Nov 2001 17:17:07 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Nov 2001 17:17:07 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011120003338.A24717@twiddle.net>,
Richard Henderson  <rth@twiddle.net> wrote:
>
>Hmm.  It appears to be easy to do with machine-dependent builtins.  E.g.
>
>	int x;
>	__asm__ __volatile__(LOCK "subl %1,%0"
>			     : "=m"(v->counter) : "ir"(i) : "memory");
>	x = __builtin_ia32_sete();
>	if (x) {

This would obviously be more than useful.

However, at the same time I worry that the syntax of having things
as separate expressions would be a total nightmare to support in the
long run for gcc - making sure that they never split up by mistake
during parsing/tree-forming/CSE/whatever. That makes for a nasty special
case that just sounds like a maintainance headache.

It _sounds_ like you prototyped something like the above to test it
out? If so, how hard would it be to just change the syntax slightly, and
move the "builting_ia32_sete()" syntactically into the __asm__, even if
it as an implementation then gets split out again for now.

That would make it less of a special case - or at least it would be an
_internal_ special case rather than one exported to the user. 

The simplest syntactic extension would obviously be to add a fourth set
of flags, and make the above look somehting like

	char flag;
	__asm__ __volatile__(LOCK "subl %1,%0"
		:"=m" (v->counter)	/* Inputs */
		:"ir" (i)		/* Outputs */
		:"memory"		/* Clobbers */
		:"=Z" (x)		/* Flags (Z/E=equal, A=above, C=carry etc etc*/
		);
	if (x) {
		...

which looks like a reasonable syntax to me. It has the advantage that it
should be _very_ easy and natural to use this syntax on predicate-based
machines like ia64, where the "flags" are trivially predicates. On such
machines I bet that the need to export the predicates is even bigger
than the need to export eflags on x86.

In fact, for predicate architectures it might be reasonable to have both
input and output predicates, which is why I did the "=Z" syntax (so that
if you find it useful to do _input_ predicates, you might have fields 4
and 5 look something like

	:"=p" (is_zero)
	:"p" (a == 7))

and have support for using something like "%p0" and "%!p1" etc for
specifying predicates in the assembly string.  I don't know if you
already do something like this on ia64, or if gcc/ia64 even considers
the predicate bits to be independent registers. 

I don't know how much inline-asm has been written for ia64, but I
suspect that it could come in handy to let gcc select predicates too,
and not have to hardcode and clobber them (or whatever it is ia64 asms
do). 

		Linus
