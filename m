Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRDNJBd>; Sat, 14 Apr 2001 05:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRDNJBY>; Sat, 14 Apr 2001 05:01:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29193 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131323AbRDNJBL>; Sat, 14 Apr 2001 05:01:11 -0400
Date: Sat, 14 Apr 2001 02:00:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <200104140758.AAA06084@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.31.0104140136520.25138-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Apr 2001, Adam J. Richter wrote:
>
> [...]
> >If it turns out to be beneficial to run the child first (you
> >can measure this), why not leave everything the same as it is
> >now but have do_fork() "switch threads" internally ?
>
> 	That is an elegant idea.

I doubt it. It sounds like one of those "cool value" ideas that are
actually really stupid except they sound cool because you have to think
about the twists and turns.

So yes, you could "give" your TLB state to the child, and take the childs
state yourself (eventually, when you re-schedule back to the parent).
They're supposed to be the same, after all. And by doing so, you could do
a "switch_to()" to the child, without actually switching mm state at all.
Fine. Cool TLB optimization.

Except you don't actually _have_ any TLB state to optimize away, as you
just invalidated it anyway when you did the COW thing on the page tables.
So you would only optimize away a "mov xxx,%cr3" - which is the least
expensive part of switching TLB's. You would NOT optimize away any actual
TLB reloads.

And oh, btw, it also means that you'd better make sure that /proc knows
about the fact that the MM state is no longer yours, but your childs, so
that a concurrent "ps" doesn't mess us. Maybe it works as-is, and maybe it
doesn't.

And what if the guy who did the fork() had done a clone(CLONE_MM) before,
or was the child of a vfork'ing parent?  We can't give the mm state to the
child, because we're sharing it with somebody else who expects to share it
with the _parent_. Oh, and the co-thread, btw, might be _using_ those page
tables on another CPU at any time.

And oh, there's the small special case of "init", which uses a fork() to
create the first user-mode mm state, so we'd have to special-case that one
too - we can't let "init_mm" go to a user process. So at the very least it
would have to be conditional on both that and the thread case.

There's a ton of reasons why you _really_ don't want to play games here.
Switching contexts is tricky enough as it is. Let's not try to be "clever"
about it.

So the best you could do is to do a full context switch to the child.
Which setting "current->need_resched = 1" will already end up doing. Plus
it does the right thing on SMP.

		Linus

