Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272710AbRHaOkW>; Fri, 31 Aug 2001 10:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272713AbRHaOkM>; Fri, 31 Aug 2001 10:40:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3087 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272710AbRHaOkF>; Fri, 31 Aug 2001 10:40:05 -0400
Date: Fri, 31 Aug 2001 06:54:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Ion Badulescu <ionut@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010831133750.A25128@thefinal.cern.ch>
Message-ID: <Pine.LNX.4.33.0108310641320.15502-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 Aug 2001, Jamie Lokier wrote:
>
> While I agree with Linus that the above line is ugly, there is a problem
> with the original line:
>
>     if (len <= sizeof(short) || len > sizeof(*sunaddr))
>
> The problem?  Thinking this is natural, suppose you decide you only need
> to check len against sizeof(short), perhaps here, perhaps copying this
> idea to another part of the program:
>
>     if (len <= sizeof(short))
>
> _This_ code has a bug.

I agree.

The difference is subtle, and maybe too subtle.

The fact is, that _ranges_ are "stable" in different types. If a value "x"
is in the range [a,b] in type A, then it will also be in range [a,b] in
type B (assuming, of course, that 'a' and 'b' are valid values in both
types).

This is why range comparisons are different from normal comparisons.

But C doesn't have the notion of a range, which is why you can't write
(while lots of people have _tried_ to write, including in the kernel)

	a < x < b
or
	x in [a,b]

or similar. So you end up having to use a more "complex" setup, where the
individual parts might not be safe even though the totality is safe.

In fact, if gcc never becomes good enough to do that kind of range
checking, I won't be _too_ unhappy. I selected a special example on bad
grounds - it's not actually the most common case of range checking, and
the most common case by far tends to be something like

	if (len < 0)
		return -EINVAL;

	if (len > sizeof(buffer))
		len = sizeof(buffer);

	copy_from_user(buffer, ..., len);

where the operation is safe for _another_ range check reason, namely the
fact that we check that "len" is within the domain of the second check.

Right now gcc will complain about the second comparison, exactly because
gcc does not do range analysis.

Now, the good news is that gcc people have already worked on range
analysis, because it is very useful for other things too (not the least of
which is optimization). So I bet gcc _will_ be able to do a much better
job of this in the future, and if we have to help it by hand in only a few
places, then that will be a good thing.

However, right now gcc complains _way_ too much about perfectly valid and
good code. If it was a few small cases, I'd be happy to fix them in the
kernel. But last time I tried -Wsign-compare, the false positives were
just too damn numerous.

(Now, we may have fixed some of them anyway, and I haven't tried it in a
_loong_ time. If somebody decides to try to see what happens if you try to
clean them up, that would probably not be a bad idea per se. Proving me
wrong is always a good sport ;)

			Linus

