Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTLNWpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 17:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTLNWpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 17:45:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:17284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262746AbTLNWpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 17:45:11 -0500
Date: Sun, 14 Dec 2003 14:45:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312142324250.15172@earth>
Message-ID: <Pine.LNX.4.58.0312141433520.1481@home.osdl.org>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org> <Pine.LNX.4.58.0312142205050.13533@earth>
 <Pine.LNX.4.58.0312141353220.1586@home.osdl.org> <Pine.LNX.4.58.0312142324250.15172@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Dec 2003, Ingo Molnar wrote:
>
> - it sets zap_leader to 0 outside the critical section.
>
> - it sets 'p = leader' within the unlikely branch - slightly faster common
>   case.

Note that both of these micro-optimizations are equally likely to _hurt_.

In particular, the bigger the liveness region of a variable is, the more
it adds to register pressure, and the worse code gcc generates.
Initializing variables further away from its use tends to just increase
the likelihood that gcc will have to spill that (or another) variable to
the stack.

So setting variables earlier tends to actually pessimize code (yes, a
perfect compiler wouldn't care, and just move the assignment later. But
for such a perfect compiler it doesn't matter where you put it anyway).

Rule of thumb: don't use variables "early" just to get one instruction out
of a critical region. The cost of a critical region is not the variables
inside of it, but the locking, and using variables early not only has the
potential to screw the compiler, it makes the code less readable.

Use the variable where they logically make sense.

Similarly, straight-line unconditional code without any memory footprint
(ie with only cached reads/writes) tends to be basically "free" on any
modern CPU. In contrast, jumping around sure isn't (and gcc tends to
optimize for the wrong things here).

For this reason, don't do

	if (x) {
		a = ...
	} else {
		a = ...;
	}

if one of the cases is trivial and 'a' is a local variable. It's usually
better to use

	a = ...;
	if (x) {
		a = ...
	}

and avoid the jumps.

In fact, from a performance standpoint, it can often be better to use

	a = ...;
	tmp = ....;
	a = x ? tmp : a;

because that allows the compiler to generate straight-line code with
conditional moves - which it would _not_ be able to do if it decided that
one of the subexpressions might cause faults or other unintended
consequences.

Basically: linearize the code. That's what modern CPU's are good at
handling. It's ok to do a small number of extra "normal" instructions if
you can avoid the nasty kind (jumps etc).

			Linus
