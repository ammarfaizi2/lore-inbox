Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbRHaPrO>; Fri, 31 Aug 2001 11:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbRHaPrE>; Fri, 31 Aug 2001 11:47:04 -0400
Received: from taka.swcp.com ([198.59.115.12]:38406 "EHLO taka.swcp.com")
	by vger.kernel.org with ESMTP id <S266977AbRHaPq7>;
	Fri, 31 Aug 2001 11:46:59 -0400
Newsgroups: fa.linux.kernel
To: Linus Torvalds <torvalds@transmeta.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        David Lang <david.lang@digitalinsight.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <fa.ehba65v.10i6abc@ifi.uio.no> <fa.odqvefv.g4k4j6@ifi.uio.no>
From: ctm@ardi.com
Date: 31 Aug 2001 09:45:45 -0600
Message-ID: <vy1d75c2pxy.fsf@w2k.ardi.com>
X-Newsreader: Gnus v5.6.45/XEmacs 21.1 - "Arches"
In-Reply-To: Linus Torvalds's message of "Thu, 30 Aug 2001 16:25:56 GMT"
Posted-To: fa.linux.kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following message is a courtesy copy of an article
that has been posted to fa.linux.kernel as well.

Linus Torvalds <torvalds@transmeta.com> writes:

> For example, let's look at this perfectly natural code:
> 
> 	static int unix_mkname(struct sockaddr_un * sunaddr, int len, unsigned *hashp)
> 	{
> 		if (len <= sizeof(short) || len > sizeof(*sunaddr))
> 			return -EINVAL;
> 		...
> 
> Would you agree that the above is _good_ code, and code that makes
> perfect sense, and code that does exactly the right thing in testing its
> arguments?

Personally, I find the above code to be misleading, because

	len <= sizeof(short)

will evaluate to 1 if len is negative.  That is counter-intuitive.

The fact that the test on the right side of the || will get the code
to execute return -EINVAL does make the code correct in that the
right thing will happen when len is negative.  But if someone sees
that sizeof(*sunaddr) is being used in a lot of places and decides to
clean up the code by introducing a variable to hold the sizeof, you
get code that looks very similar to the above but that is now wrong,
because the right side no longer has the special property of "catching
the problem the left side created".

		int max_value;

		max_value = sizeof(*sunaddr);

 		if (len <= sizeof(short) || len > max_value)
 			return -EINVAL;

		... max_value this ...

		... max_value that ...

		... max_value the other thing...

One can argue that making max_value an int (or introducing it at all)
is a bad thing because it breaks the idiom that was originally used.
I won't disagree, but then again I understand signed and unsigned
comparisons and I see why the idiom breaks when you introduce
max_value as an int.

I understand why the sizeof operator is unsigned, but also know that
does introduce some problems.

Although it's ugly,

#define isizeof(x)  ((int) sizeof(x))

would provide a signed sizeof that could be used in all the above code
with no complaints from -Wsign-compare.  But I don't claim that there
wouldn't be other places where -Wsign-compare would produce spurious
complaints.  If there weren't, then I would think use of a min/max
that didn't have a cast forced into it combined with -Wsign-compare
and isizeof would make it more likely that the compiler would point
out real bugs than the min/max with the forced cast.

I don't maintain any linux kernel code, so I'm not lobbying for this
particular solution.  I just don't think Linus's example is _good_
code.  I think it's correct, but misleading, code.

Regards,

Cliff Matthews <ctm@ardi.com>
