Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTBLVB3>; Wed, 12 Feb 2003 16:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTBLVB3>; Wed, 12 Feb 2003 16:01:29 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38192 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267641AbTBLVB1>; Wed, 12 Feb 2003 16:01:27 -0500
Date: Wed, 12 Feb 2003 13:11:09 -0800
Message-Id: <200302122111.h1CLB9D24412@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: Linus Torvalds's message of  Wednesday, 12 February 2003 12:12:13 -0800 <Pine.LNX.4.44.0302121138570.8062-100000@penguin.transmeta.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: I'm using my X-RAY VISION to obtain a rare glimpse of the INNER
   WORKINGS of this POTATO!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, Roland, instead of your previous patch I would prefer something that 
> just makes "sig_ignored()" test the state of the signal better. Ie 
> something like the appended.

This should be fine (almost).  POSIX leaves it unspecified whether a
blocked, ignored signal is left pending or not.  The only thing it requires
is that setting a blocked signal to SIG_IGN clears any pending signal, and
sigaction already does that.

When I started hacking on this, I only looked at the old new code (i.e.
Ingo's thread group rewrite) not the old old code (i.e. 2.4).  Everything
that was not wrong I left as it was, and bailing early on SIG_IGN signals
without regard to blocking is what that code did when I started with it.
Bailing early can avoid going through the loop and possibly perturbing the
load balancing state, so I had assumed Ingo did it intentionally as an
optimization.

Your patch as is won't fix the ignored-SIG_DFL-interrupts bug in the MT
case.  That is, in __group_send_sig_info if P blocks the signal but some
other thread does not, then the that thread will get woken up and be
subject to all those problems.  So you need another check in or after the
loop, or to move the sig_ignored use after the loop.  After the loop or in
the loop exit condition, you can't get there if the signal is blocked on T,
so for that test you can omit the blocked and ptrace checks that your
sig_ignored does.

I don't see any other problems with doing this instead of just the checks
inserted my previous patch.


Enjoy,
Roland
