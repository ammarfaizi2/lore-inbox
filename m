Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRKSSlR>; Mon, 19 Nov 2001 13:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280591AbRKSSk6>; Mon, 19 Nov 2001 13:40:58 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:33290 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S280583AbRKSSkw>;
	Mon, 19 Nov 2001 13:40:52 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111191840.VAA21046@ms2.inr.ac.ru>
Subject: Re: VM-related Oops: 2.4.15pre1
To: torvalds@transmeta.COM (Linus Torvalds)
Date: Mon, 19 Nov 2001 21:40:41 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111181820040.7500-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 19, 1 05:45:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Oh, and I bet TCP would break horribly if gcc wrote internal temporary
> values to the socket sequence numbers.

Actually tcp does not depend on gcc idiosyncrasies. It works under
socket lock.

Well, all these things sort of read-copy updates, relying on memory
ordering etc. may be very good, but:

- I do not know the rules of the game.
- Nobody seems to knows them.
- Anyway, I do not have enough of brain cells to keep this under control.

So, networking relies only on explicit locks and barriers and gcc may do
everything except for splitting "optimizations" of this kind over barriers.


The most dangerous thing, which could harm 2.2 a lot is intuitively
natural:

static int a;
auto int b;

b = a;
do_something_with_b;

Goal of this code is clear, to get snapshot of "a"
and to do anything with "b", assuming it does not change.
In 2.2 we rely on this in many places.

I do not see anything which could prohibit gcc to eliminate register
allocated for "b" while CSE and to use "a" directly f.e. when b does
not fit to hardware register set in any case. Actually, gcc
does not make this to our luck, but I suspect it is only because
it is too stupid.

Alexey
