Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267554AbSKQSyx>; Sun, 17 Nov 2002 13:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267555AbSKQSyx>; Sun, 17 Nov 2002 13:54:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:59605 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267554AbSKQSyw>;
	Sun, 17 Nov 2002 13:54:52 -0500
Date: Sun, 17 Nov 2002 21:18:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <Pine.LNX.4.44.0211171047160.22525-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0211172114240.12788-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Linus Torvalds wrote:

> In fact, SETTID is clearly useful even without threads, and exactly for
> the case that Ingo apparently broke with his patch: the parent wants to
> atomically save the TID of the child in the _parents_ address space (so
> that a immediate SIGCHLD won't be racy with saving off the pid by the
> parent).

while it makes sense, the problem in this case is that the 'TID address'
is the parent's TID address. (ie. might be futex-waited upon by some other
context, for an exit() event.)

i think what makes most sense is what Luca suggested, to split up the
things and use two different TID address: one for race-less setting of the
TID in the parent's address space, and another for the race-less
initialization of the TID value in the child's context.

> There's no reason to make SETTID/CLEARTID be one flag, since they are
> clearly different things, and NPTL can just always set both bits if that
> is the behaviour glibc wants (and I agree with that behaviour, of
> course. I just disagree with not allowing others to do different
> things).

ok, agreed. Other libraries might choose to still do SIGCHLD based exit()  
notification - exit notification and initial-TID setting are separate
things.

(i'll send a new patch in a few minutes so that we can see the full impact
on things.)

	Ingo

