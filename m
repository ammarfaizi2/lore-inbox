Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267911AbRGVHqh>; Sun, 22 Jul 2001 03:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267912AbRGVHq1>; Sun, 22 Jul 2001 03:46:27 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:24594 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267911AbRGVHqV>; Sun, 22 Jul 2001 03:46:21 -0400
Date: Sun, 22 Jul 2001 00:44:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Why Plan 9 C compilers don't have asm("")
In-Reply-To: <20010721234952.A4349@twiddle.net>
Message-ID: <Pine.LNX.4.33.0107220025500.6342-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Sat, 21 Jul 2001, Richard Henderson wrote:
>
> The call-clobbered GP means that your trampoline has to play games
> in order to get the GP restored when coming back from an intra
> module call.  Which means a new stack frame.

Ahh, only if you do my optimization of sharing trampolines among users.
And you're right, that won't work.

But if you don't do that, you don't need a stack frame. You just reload GP
and jump back to the caller.

And assuming most calls don't need the trampoline (and hey, they really
shouldn't), you're still way ahead. The only thing you lost was the icache
win of re-using the trampoline (and a few cycles for scheduling and the
extra short branch).

Think of it as nothing more than a branch prediction thing - you predict
that you can take a short branch, and emit the long-branch code
out-of-line.

So the code would be roughly (this is not how the compiler would see it,
this is the very last stage of outputting the actual assembly. Nothing
else needs to know):

	...
	bsr $26,trampoline	// linker overflow case
retpoint:
	....

trampoline:
	ldq $27,fn($gp)		// load the full address
	jsr $26,($27)		// branch to it
	ldgp $29,($26)		// reload our GP
	jsr $31,retpoint	// and go back to where we came from.

And the linker can just use the special .rel20 thing to turn the bsr into
a direct call when it can.

Overhead when it cannot: one extra "bsr", one extra "jsr" back, and the
lack of scheduling. You lost two cycles and maybe a pipeline stall or
something (branching around is never nice, even if it's unconditional).

But you only lose this on misprects. And you can have a pretty high
prediction accuracy, even with just static knowledge.

And when you _do_ predict right, you're going to win in icache footprint,
code size (and because you can drop the trampoline for non-weak symbolds
the executable size also goes down) and cycles.

That still doesn't look complicated to me. Of course, it clearly does
depend on whether I'm right that you can fairly easily get 99% prediction
accuracy. And I could just be full of sh*t.

		Linus

