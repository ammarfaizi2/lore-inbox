Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbTIJQFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTIJQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:05:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6786 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265173AbTIJQF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:05:27 -0400
Date: Wed, 10 Sep 2003 12:07:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@ucw.cz>
cc: Dave Jones <davej@redhat.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
In-Reply-To: <20030910152902.GA2764@elf.ucw.cz>
Message-ID: <Pine.LNX.4.53.0309101147040.14762@chaos>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com>
 <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com>
 <20030910152902.GA2764@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Pavel Machek wrote:

> Hi!
>
> >  > > none of this patch seems to touch particularly performance critical code.
> >  > > Is it really worth adding these macros to every if statement in the kernel?
> >  > > There comes a point where readability is lost, for no measurable gain.
> >  >
> >  > Perhaps we should have macros ifu() and ifl(), that would be used as a
> >  > plain if, just with likelyness-indication? That way we could have it
> >  > in *every* statement and readability would not suffer that much...
> >
> > You've got to be kidding.
>
> I'm pretty serious.
>
> 	ifu (a==b) {
> 		something();
> 	}
>
> looks better than
>
> 	if (unlikely(a==b)) {
> 		something();
> 	}
>
> sched.c alone probably would get more readable as a result of such
> conversion...
>
> [Okay, having it at every statement is prbably bad idea.]
> 								Pavel
> --
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]

Dumb question? Has anybody actually tested "__builtin_expect", and
friends to see if any of this "coloration" actually enhances performance?
"unlikely()" is the negative of the new built-in. I would guess that
any conversion operations are going to negate any advantage possibly
gained by reordering instructions.

For instance:
		Given:
		if(a == b)
                   foo();
                else
                   bar();
... and ...
		if(unlikely(a == b))
                    foo();
                else
                    bar();

I would guess that the compiler output might be:

		movl a(%esp), %eax	# Get 'a' off the stack
		cmpl b(%esp), %eax	# Compare against 'b' on the stack
		jnz	1f		# Not the same
		call	foo		# Are the same, call foo()
		jmp	2f		# Need to jump around stuff
	1:	call	bar		# Execute bar()
	2:	# Do more stuff.

Note that no matter what you do, comparing equal or not equal,
when you get down to the actual code, it's apples and apples.
You are always going to take an extra jump in one execution
path after the function, and you will take a conditional jump
before the function call in the other execution path. So, you
always have the "extra" jumps, no matter.

I would guess that most all of the conditional code will turn
out this way and, won't even be as efficient as what I have
written above.

Before a lot of readable code is modified (trashed???), maybe
somebody should benchmark the differences? The tests I have
made here, seem to show that any measurment differences are
in the noise and... favor leaving __builtin_expect() out of
the code.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


