Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSFKIsX>; Tue, 11 Jun 2002 04:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316958AbSFKIsW>; Tue, 11 Jun 2002 04:48:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5136 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316957AbSFKIsV> convert rfc822-to-8bit;
	Tue, 11 Jun 2002 04:48:21 -0400
Message-ID: <3D05B94B.6090502@evision-ventures.com>
Date: Tue, 11 Jun 2002 10:48:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On Tue, 11 Jun 2002, Rusty Russell wrote:
> 
>>Worst sin is that you can't predeclare typedefs.  For many uses (not the
>>list macros of course):
>>	struct xx;
>>is sufficient and avoids the #include hell,
> 
> 
> True.
> 
> However, that only works for function declarations.
> 
> typedefs are easy to avoid.
> 
> The real #include hell comes, to a large degree, from the fact that we
> like inline functions. Which have many wonderful properties, but they have
> the same nasty property typedefs have: they require full type information
> and cannot be predeclared.
> 
> And while I'd like to avoid #include hell, I'm not willing to replace
> inline functions with #define's to avoid it ;^p

That's true, but please note that there is quite a lot
of inadequate include abuse in Linux. People are just too
lazy to check whatever inlining something really speeds things
up. For example the functions used to copy data between
userspace and kernel are very likely to be executed not much slower
if *not* included. In fact they should not turn up
on *any* benchmark - becouse if they do we have other problems...
Namely we have a system call which is basically doing nothing.
But they show up significantly on the .text size.

And then we have quite a lot if silly include code like the following:

static inline function()
{
           seme_function();
		some_other_function();
}

Which doesn't really make much sense, quite frequently, becouse
We will trash caches anyway...

Or

static inline int iterator()
{
}

This doesn't make sense too, becouse
the CPUs tends to be good at branch prediction and if
a function is mainly used inside loops again and again
it doesn't make sense to make them inline frequently too.

And so on and so on...

