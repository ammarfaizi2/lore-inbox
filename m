Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272581AbRHaB23>; Thu, 30 Aug 2001 21:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272580AbRHaB2T>; Thu, 30 Aug 2001 21:28:19 -0400
Received: from cs.columbia.edu ([128.59.16.20]:24261 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S272579AbRHaB2L>;
	Thu, 30 Aug 2001 21:28:11 -0400
Date: Thu, 30 Aug 2001 21:28:28 -0400
Message-Id: <200108310128.f7V1SSn08071@moisil.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108300909560.7973-100000@penguin.transmeta.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac7 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001 09:21:12 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> wrote:

> For example, let's look at this perfectly natural code:
> 
>        static int unix_mkname(struct sockaddr_un * sunaddr, int len, unsigned *hashp)
>        {
>                if (len <= sizeof(short) || len > sizeof(*sunaddr))
>                        return -EINVAL;
>                ...
> 
> Would you agree that the above is _good_ code, and code that makes
> perfect sense, and code that does exactly the right thing in testing its
> arguments?

Ugh. I must confess I am disappointed, Linus. I thought you had better taste.

Yes, the above code is correct. And yes, gcc should be more aggressive to
recognize that the above code is unambiguous. But that doesn't change the fact
that the code is UGLY AS HELL. Nor does it change the fact that each comparison
is broken if taken separately.

You make two UNSIGNED comparisons when you clearly mean to make two SIGNED
comparisons, and you call that _good_ code? Hmm.

> Try to compile it with -Wsign-compare.
> 
> You'll get not one, but TWO warnings for code that is totally correct, and
> that it would make _no_ sense in writing any other way.

Really? How so? We _know_ that the result of sizeof() fits confortably within
"int"'s range. So the natural way to write that comparison would be

	if (len <= (int) sizeof(short) || len > (int) sizeof(*sunaddr))

which is 100% correct, 100% obvious, and does not break horribly if you
remove one of the comparisons.

The compiler also _knows_ that. But the compiler can't change the implicit 
cast, because it would make it incompatible with every other compiler on
the planet. Yes, standards suck sometimes. So compiler warns us instead.
I consider that a feature.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
