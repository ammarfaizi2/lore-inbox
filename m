Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSKKBkH>; Sun, 10 Nov 2002 20:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265323AbSKKBkH>; Sun, 10 Nov 2002 20:40:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1551 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265321AbSKKBkG>; Sun, 10 Nov 2002 20:40:06 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] use 64 bit jiffies 1/4
Date: Mon, 11 Nov 2002 01:46:26 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aqn25i$gm7$1@penguin.transmeta.com>
References: <Pine.LNX.4.33.0211101014120.12784-100000@gans.physik3.uni-rostock.de>
X-Trace: palladium.transmeta.com 1036979188 23784 127.0.0.1 (11 Nov 2002 01:46:28 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 11 Nov 2002 01:46:28 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0211101014120.12784-100000@gans.physik3.uni-rostock.de>,
Tim Schmielau  <tim@physik3.uni-rostock.de> wrote:
>
>Provide a sane way to avoid unneccessary locking on 64 bit platforms,
>and a 64 bit analogon to "jiffies_to_clock_t()".
>Naming it "jiffies_64_to_user_HZ()" is the only part of these patches I 
>expect to be controversial.

I disagree with the implementation of this (and yes, I would also prefer
for it to be called "jiffies64_to_clock_t()"):

> # define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))

This is my crapola 32-bit-overflow-horror-thing. Please don't look at it
too closely, since it makes you go blind, _and_ it encourages you to
write more crapola like:

>+static inline u64 jiffies_64_to_user_HZ(u64 x)
>+{
>+	do_div(x, HZ / USER_HZ);
>+	return x;
>+}

This is wrong. You should really start off by fixing the 32-bit case,
since even that needs fixing anyway (some interfaces really _are_
32-bit, and cannot be expanded). 

It also only works for cases where HZ is a direct multiple of USER_HZ,
and yes, my original code has the same problem, but that's not a good
excuse to make it worse.  I think it should be fairly straightforward to
get this right, and have a simple

	static inline u64 jiffies64_to_clock_t(u64 x)
	{
	#if !(HZ % USER_HZ)
		do_div(x, (HZ / USER_HZ))
		return x;
	#else
		/*
		 * There are better ways that don't overflow early,
		 * but even this doesn't overflow in hundreds of years
		 * in 64 bits, so..
		 */
		do_div(x * USER_HZ, HZ);
		return x;
	#endif
	}

(And yes, the above does not return a clock_t, it returns a 64-bit
thing, but people who need to can truncate it to clock_t and live with
the old 497-day overflow of USER_HZ in 32 bits for broken interfaces
like "clock()".  This way the caller can use the same function for both
the "true 64-bit result" and the truncated case). 

And then we should just remove the "jiffies_to_clock_t()" thing, I
suspect.  The 49-day overflow is just too soon for comfort, you're
definitely right about that. 

		Linus
